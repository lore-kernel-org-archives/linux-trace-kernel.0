Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C101632D8;
	Sat, 26 Oct 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938735; cv=none; b=jMLUJhboyVWTF29I3KvZFl0NZgjKwKmnUA8UVWm74zDOw69GwzriBajalI6YNsmzwSwQ+UDxWFyCWfWoP2acK1325svFvaJbNhJFIMctZfgKEmIIN2znPY0Y6cWcYwXMX/jdUmg7XhQxt6fxaurUOc/Yti+Cel2yy/tYzpT2i8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938735; c=relaxed/simple;
	bh=mwWIEVhnQYpMAE1Bmx4YYs7/nSup60f/f4lI38YYiDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZaMu4zK6Dv1rXsximTRi1SKpNjdOZkIrCvQjVRquQ1wvIoski7XDrzbRH1WbA3IeMT7uJ5vj6QgILrFPMBSlWeN0t8kThYJN3jUl1n/gbg6Fac29RNFxiew/TwWebwfUHTIDPDHit3rOTnyS3jB5muu9ZfWzPWXmJe2lW4PqkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37E2C4CEC6;
	Sat, 26 Oct 2024 10:32:13 +0000 (UTC)
Date: Sat, 26 Oct 2024 06:32:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v2] fgraph: Give ret_stack its own kmem cache
Message-ID: <20241026063210.7d4910a7@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The ret_stack (shadow stack used by function graph infrastructure) is
created for every task on the system when function graph is enabled. Give
it its own kmem_cache. This will make it easier to see how much memory is
being used specifically for function graph shadow stacks.

In the future, this size may change and may not be a power of two. Having
its own cache can also keep it from fragmenting memory.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20241019152719.321772eb@rorschach.local.home

- Rebased on top of urgent merged into for-next (uses guard(mutex) now)

 kernel/trace/fgraph.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4ce87982966a..001abf376c0c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -172,6 +172,8 @@ enum {
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
+static struct kmem_cache *fgraph_stack_cachep;
+
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 static unsigned long fgraph_array_bitmask;
 
@@ -1022,8 +1024,11 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
 	struct task_struct *g, *t;
 
+	if (WARN_ON_ONCE(!fgraph_stack_cachep))
+		return -ENOMEM;
+
 	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
-		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+		ret_stack_list[i] = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 		if (!ret_stack_list[i]) {
 			start = 0;
 			end = i;
@@ -1054,7 +1059,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
-		kfree(ret_stack_list[i]);
+		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
 	return ret;
 }
 
@@ -1117,9 +1122,12 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 	if (ftrace_graph_active) {
 		unsigned long *ret_stack;
 
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+
 		ret_stack = per_cpu(idle_ret_stack, cpu);
 		if (!ret_stack) {
-			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+			ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 			if (!ret_stack)
 				return;
 			per_cpu(idle_ret_stack, cpu) = ret_stack;
@@ -1139,7 +1147,10 @@ void ftrace_graph_init_task(struct task_struct *t)
 	if (ftrace_graph_active) {
 		unsigned long *ret_stack;
 
-		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+
+		ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
 		if (!ret_stack)
 			return;
 		graph_init_task(t, ret_stack);
@@ -1154,7 +1165,11 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	/* NULL must become visible to IRQs before we free it: */
 	barrier();
 
-	kfree(ret_stack);
+	if (ret_stack) {
+		if (WARN_ON_ONCE(!fgraph_stack_cachep))
+			return;
+		kmem_cache_free(fgraph_stack_cachep, ret_stack);
+	}
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1294,6 +1309,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	guard(mutex)(&ftrace_lock);
 
+	if (!fgraph_stack_cachep) {
+		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
+							SHADOW_STACK_SIZE,
+							SHADOW_STACK_SIZE, 0, NULL);
+		if (!fgraph_stack_cachep)
+			return -ENOMEM;
+	}
+
 	if (!fgraph_initialized) {
 		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
 					fgraph_cpu_init, NULL);
-- 
2.45.2

