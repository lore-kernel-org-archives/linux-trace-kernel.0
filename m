Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5E3B52E2;
	Fri, 10 Apr 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813738; cv=none; b=b1xcfGOkDI8ujvrCrLnWee5kMhHoL/SWw5e3no1UTZc8AS2xNXB1uvh1EnZh/1I1/pB7c7h2RsApMX0UJdkbkDZGcD5ESvFRQToMKyJrh1cMkueKFk3+BTeTOcy0P28I264bCBYUcQdKDM34SX3nA+onI/Lvug8pf+s/tctDLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813738; c=relaxed/simple;
	bh=PesYormxSzyPqoir4DFNN8L3FSOH52CALEnHY2eUv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1/NDRzKFkxJWpZqC2a16/4ZVcAq4CLLjZxp+c0UyrLJr3S1ZgdtQAocU6e5/m3iC0OnlvrYxeaSjh17HiIjQpRF1SOiUoBuR5NR601N7RmqWl2hTdvk/khaliUJl6DhqjMlfB1tLoGQuNR8Rdb+KBSrOc08TQ1aynTbDg5rxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlNVzkeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlNVzkeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749A7C19421;
	Fri, 10 Apr 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775813738;
	bh=PesYormxSzyPqoir4DFNN8L3FSOH52CALEnHY2eUv04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlNVzkeDR7AviyyfxAWN17hnJ31bQpEKX6mVWCzCl0/a3fli5lBuIrmMegENDwMLf
	 5yFnrazJ3l8jxUuurlHWGg6arq7/v2HEel7mUSCskcDBDNotuuE2bdE3YUNa7fX0iX
	 a9ZqwSXAAsfXaDrF0Jtf2wx0MqVRmH4YEhMkxntFJt0tBId1aEu0Yo9ioGH216I3vT
	 T2JXVJKkhBmLPouTOqnqpgC2k3IGlZyMTdGpFQqUkk5sdW/vkayFUb1E7EIkvu3Kjt
	 jaEoV6cJpM5KtXGA6ddbll0LtJh+xuS+4lKCFE/+XzSKqRqRcFDRCQWb6TFRb4hxkZ
	 UGr5JRKNLSSJQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tracing/fprobe: Check the same type fprobe on table as the unregistered one
Date: Fri, 10 Apr 2026 18:35:36 +0900
Message-ID:  <177581373580.617881.355647055040227134.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To:  <177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com>
References:  <177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Commit 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
introduced a different ftrace_ops for entry-only fprobes.

However, when unregistering an fprobe, the kernel only checks if another
fprobe exists at the same address, without checking which type of fprobe
it is.
If different fprobes are registered at the same address, the same address
will be registered in both fgraph_ops and ftrace_ops, but only one of
them will be deleted when unregistering. (the one removed first will not
be deleted from the ops).

This results in junk entries remaining in either fgraph_ops or ftrace_ops.
For example:
 =======
 cd /sys/kernel/tracing

 # 'Add entry and exit events on the same place'
 echo 'f:event1 vfs_read' >> dynamic_events
 echo 'f:event2 vfs_read%return' >> dynamic_events

 # 'Enable both of them'
 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_read (2)            ->arch_ftrace_ops_list_func+0x0/0x210

 # 'Disable and remove exit event'
 echo 0 > events/fprobes/event2/enable
 echo -:event2 >> dynamic_events

 # 'Disable and remove all events'
 echo 0 > events/fprobes/enable
 echo > dynamic_events

 # 'Add another event'
 echo 'f:event3 vfs_open%return' > dynamic_events
 cat dynamic_events
f:fprobes/event3 vfs_open%return

 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_open (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
vfs_read (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
 =======

As you can see, an entry for the vfs_read remains.

To fix this issue, when unregistering, the kernel should also check if
there is the same type of fprobes still exist at the same address, and
if not, delete its entry from either fgraph_ops or ftrace_ops.

Fixes: 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   81 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 46357808cbde..7f7daf2c49dd 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -86,11 +86,9 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node)
 	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
 }
 
-/* Return true if there are synonims */
-static bool delete_fprobe_node(struct fprobe_hlist_node *node)
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
 {
 	lockdep_assert_held(&fprobe_mutex);
-	bool ret;
 
 	/* Avoid double deleting */
 	if (READ_ONCE(node->fp) != NULL) {
@@ -98,13 +96,6 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 		rhltable_remove(&fprobe_ip_table, &node->hlist,
 				fprobe_rht_params);
 	}
-
-	rcu_read_lock();
-	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
-				fprobe_rht_params);
-	rcu_read_unlock();
-
-	return ret;
 }
 
 /* Check existence of the fprobe */
@@ -338,6 +329,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return !fp->exit_handler;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We have to check the same type on the list. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp)) {
+			if ((!ftrace && fp->exit_handler) ||
+			    (ftrace && !fp->exit_handler))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -360,6 +377,29 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return false;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We only need to check fp is there. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_set_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -546,15 +586,22 @@ struct fprobe_addr_list {
 static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
 					 struct fprobe_addr_list *alist)
 {
+	lockdep_assert_in_rcu_read_lock();
+
 	if (!within_module(node->addr, mod))
 		return 0;
 
-	if (delete_fprobe_node(node))
-		return 0;
+	delete_fprobe_node(node);
+	/*
+	 * Don't care the type here, because all fprobes on the same
+	 * address must be removed eventually.
+	 */
+	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params)) {
+		alist->addrs[alist->index++] = node->addr;
+		if (alist->index == alist->size)
+			return -ENOSPC;
+	}
 
-	alist->addrs[alist->index++] = node->addr;
-	if (alist->index == alist->size)
-		return -ENOSPC;
 	return 0;
 }
 
@@ -917,7 +964,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		delete_fprobe_node(&hlist_array->array[i]);
+		if (!fprobe_exists_on_hash(hlist_array->array[i].addr,
+					   fprobe_is_ftrace(fp)))
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);

