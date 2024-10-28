Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D95189BAC;
	Mon, 28 Oct 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096334; cv=none; b=sJ+T4rvJWeUAPc3AybLAr0v/hCamtRTucQ76t5EGtWt6qzryVraGK7wuGbQ6AbSOm0kNMHPsG4x4d7cNT2gmiz73Bvj1++ZLR2teunyD8XLMv/9MjAeMoPFzHGv6qvPa+TQnwaTYhpzgkNh4ZuDYr+kL0zh+SdDja2ehEPkgpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096334; c=relaxed/simple;
	bh=3czVAhAP6abjALkMMr8DDUwznxBwrkdSG3RvBG30mD4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dXYSEOPUpBk+n10Tq6lCCcruh2O9lV+0p9r5dJFm+TKV3712d4E7PO3jNKGQXrrM30cCrJ9c/Eb+t9olYIC1f4XDFv0l4G/U+hF7Z42G+XTqkvj72uY4bbWJckjCY2/3CJUhuf/PazEbvYjgw/+BVxjp8Q1Nk3Etnn9+bT0nd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72312C4CEE9;
	Mon, 28 Oct 2024 06:18:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5J6N-000000052xT-0hU5;
	Mon, 28 Oct 2024 02:19:43 -0400
Message-ID: <20241028061943.027149869@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 02:18:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 2/2] fgraph: Free ret_stack when task is done with it
References: <20241028061821.009891807@goodmis.org>
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
Changes since v2: https://lore.kernel.org/20241028060118.956474816@goodmis.org

- Fixed the previous patch ;-)

 kernel/trace/fgraph.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index f7df6c14d5f9..afc20a9616c7 100644
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
 
@@ -1374,6 +1386,21 @@ static void free_ret_stacks(void)
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
@@ -1384,6 +1411,12 @@ static __init int fgraph_init(void)
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
@@ -1429,6 +1462,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_disable_direct(true);
 
 	if (ftrace_graph_active == 1) {
+		static_branch_disable(&fgraph_ret_stack_cleanup);
 		ftrace_graph_enable_direct(false, gops);
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
@@ -1495,6 +1529,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_entry = ftrace_graph_entry_stub;
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+		static_branch_enable(&fgraph_ret_stack_cleanup);
 		free_ret_stacks();
 	}
  out:
-- 
2.45.2


