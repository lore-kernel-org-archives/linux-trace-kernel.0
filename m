Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605018C006;
	Mon, 28 Oct 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095230; cv=none; b=fLSlU8rqSalE/GCfKZhl5s6bW1DW/KDvaJPUGO+aM3d6Ha69e21YVIEZrOY0JRinc/HiF0hbBMkSJhkTqu3P1rVCkFx9MD3kxrZnPAuChd0+Qj+Nj29BnA3ujPGjjVuKtwjZvrifnoYrj5Gw+FSwnEQReXln0ytIHoQK1WYhQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095230; c=relaxed/simple;
	bh=Hr7ZAIUYSQXjIYBtYPVdNO1vCnaB6pN5XVORNNm7yAs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KaPnFAqArojECkPvuxu8X4OZYmNLfzVPk/FIKmLTjkiN6cXzae1PdQG9BqjvjDZ8bgfo1jS8INvTWpw1xJjMAvLSByAkvm/EjpTxlp6PWhZ4gxitntPF9OST+6aJGRPjYbIF0UX6VQHee9M7GQeX+5Z/3KluUJt/Ndcn91iYfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70231C4CEE8;
	Mon, 28 Oct 2024 06:00:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5IoZ-000000052oV-0QVT;
	Mon, 28 Oct 2024 02:01:19 -0400
Message-ID: <20241028060118.956474816@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 02:00:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 2/2] fgraph: Free ret_stack when task is done with it
References: <20241028060029.742310369@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The shadow stack used for function graph is only freed when function graph
is done for those tasks that are no longer using them. That's because a
function that does a long sleep (like poll) could be traced, and its
original return address on the stack has been replaced with a pointer to a
trampoline, but that return address is saved on the shadow stack. It can
not be freed until the function returns and there's no more return
addresses being stored on the shadow stack.

Add a static_branch test in the return part of the function graph code
that is called after the return address on the shadow stack is popped. If
the shadow stack is empty, call an irq_work that will call a work queue
that will run the shadow stack freeing code again. This will clean up all
the shadow stacks that were not removed when function graph ended but are
no longer being used.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20241024092952.709200360@goodmis.org

- Rebased on top of the merge of urgent

 kernel/trace/fgraph.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b1ef36a8d931..6addbcfbef64 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -174,6 +174,11 @@ int ftrace_graph_active;
 
 static struct kmem_cache *fgraph_stack_cachep;
 
+DEFINE_STATIC_KEY_FALSE(fgraph_ret_stack_cleanup);
+static struct workqueue_struct *fgraph_ret_stack_wq;
+static struct work_struct fgraph_ret_stack_work;
+static struct irq_work fgraph_ret_stack_irq_work;
+
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 static unsigned long fgraph_array_bitmask;
 
@@ -849,8 +854,15 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 */
 	barrier();
 	current->curr_ret_stack = offset - FGRAPH_FRAME_OFFSET;
-
 	current->curr_ret_depth--;
+
+	/*
+	 * If function graph is done and this task is no longer using ret_stack
+	 * then start the work to free it.
+	 */
+	if (static_branch_unlikely(&fgraph_ret_stack_cleanup) && current->curr_ret_depth < 0)
+		irq_work_queue(&fgraph_ret_stack_irq_work);
+
 	return ret;
 }
 
@@ -1375,6 +1387,21 @@ static void free_ret_stacks(void)
 	}
 }
 
+static void fgraph_ret_stack_work_func(struct work_struct *work)
+{
+	mutex_lock(&ftrace_lock);
+	if (!ftrace_graph_active)
+		free_ret_stacks();
+	mutex_unlock(&ftrace_lock);
+}
+
+static void fgraph_ret_stack_irq_func(struct irq_work *iwork)
+{
+	if (unlikely(!fgraph_ret_stack_wq))
+		return;
+	queue_work(fgraph_ret_stack_wq, &fgraph_ret_stack_work);
+}
+
 static __init int fgraph_init(void)
 {
 	int ret;
@@ -1385,6 +1412,12 @@ static __init int fgraph_init(void)
 		pr_warn("fgraph: Error to init cpu hotplug support\n");
 		return ret;
 	}
+	fgraph_ret_stack_wq = alloc_workqueue("fgraph_ret_stack_wq",
+				      WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!fgraph_ret_stack_wq);
+
+	INIT_WORK(&fgraph_ret_stack_work, fgraph_ret_stack_work_func);
+	init_irq_work(&fgraph_ret_stack_irq_work, fgraph_ret_stack_irq_func);
 	return 0;
 }
 core_initcall(fgraph_init)
@@ -1430,6 +1463,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_disable_direct(true);
 
 	if (ftrace_graph_active == 1) {
+		static_branch_disable(&fgraph_ret_stack_cleanup);
 		ftrace_graph_enable_direct(false, gops);
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
@@ -1496,6 +1530,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_entry = ftrace_graph_entry_stub;
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+		static_branch_enable(&fgraph_ret_stack_cleanup);
 		free_ret_stacks();
 	}
  out:
-- 
2.45.2


