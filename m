Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF251CEE90;
	Thu,  3 Oct 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995287; cv=none; b=N4vqNG9CIuRBb6PgZmfvdTX0gOTpSXKM7UxjOYQrGOKjNEsBC/QX6s+2HV4vLuWbd4eJ++7yExhnpe3vjM51QlK5+p9qFGkHNFhqhkTsMYU/epnZf87VEIwwYwp4BHCNV6rO9ffe+3jDFDh7lpUgw1AOKHJ47oZSwi2ExFXz2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995287; c=relaxed/simple;
	bh=2kFx0zW6ylmIO9ZqfBwscYHqc1CTTaEYZL1RdiJ73pw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mNWq1ogXOTqYjxAf5yvj75yz7/1LR8sKQpU2HzCd0ENfRQuOSDl8DMP+xbV/sebfUVA8IIZPHcP16awUSCvnedg3W007J6LHuZZH3Kfl8GKnGBUEttE1ROHzVbzIYQMwdmrNV2h+yafB67FTUaVqhLu6Byv2veBD8C3+9plula0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B550C4CEC5;
	Thu,  3 Oct 2024 22:41:26 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:42:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracepoint: Remove SRCU protection
Message-ID: <20241003184220.0dc21d35@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

With the removal of the trace_*_rcuidle() tracepoints, there is no reason
to protect tracepoints with SRCU. The reason the SRCU protection was
added, was because it can protect tracepoints when RCU is not "watching".
Now that tracepoints are only used when RCU is watching, remove the SRCU
protection. It just made things more complex and confusing anyway.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
This is based on top of:

    https://lore.kernel.org/linux-trace-kernel/20241003181629.36209057@gandalf.local.home/

 include/linux/tracepoint.h |  4 ---
 kernel/tracepoint.c        | 51 +-------------------------------------
 2 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 9b85a02b8575..fa130c360179 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -32,8 +32,6 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
-extern struct srcu_struct tracepoint_srcu;
-
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -109,7 +107,6 @@ void for_each_tracepoint_in_module(struct module *mod,
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
-	synchronize_srcu(&tracepoint_srcu);
 	synchronize_rcu();
 }
 #else
@@ -207,7 +204,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8879da16ef4d..cfd3e0ed413d 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,9 +25,6 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
-DEFINE_SRCU(tracepoint_srcu);
-EXPORT_SYMBOL_GPL(tracepoint_srcu);
-
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -37,7 +34,6 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
-	unsigned long srcu;
 	bool ongoing;
 };
 
@@ -50,7 +46,6 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
-	snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -61,8 +56,6 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
-	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
-		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -85,9 +78,6 @@ static LIST_HEAD(tracepoint_module_list);
  */
 static DEFINE_MUTEX(tracepoints_mutex);
 
-static struct rcu_head *early_probes;
-static bool ok_to_free_tracepoints;
-
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -111,56 +101,17 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void srcu_free_old_probes(struct rcu_head *head)
-{
-	kfree(container_of(head, struct tp_probes, rcu));
-}
-
 static void rcu_free_old_probes(struct rcu_head *head)
 {
-	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
-}
-
-static __init int release_early_probes(void)
-{
-	struct rcu_head *tmp;
-
-	ok_to_free_tracepoints = true;
-
-	while (early_probes) {
-		tmp = early_probes;
-		early_probes = tmp->next;
-		call_rcu(tmp, rcu_free_old_probes);
-	}
-
-	return 0;
+	kfree(container_of(head, struct tp_probes, rcu));
 }
 
-/* SRCU is initialized at core_initcall */
-postcore_initcall(release_early_probes);
-
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
-		/*
-		 * We can't free probes if SRCU is not initialized yet.
-		 * Postpone the freeing till after SRCU is initialized.
-		 */
-		if (unlikely(!ok_to_free_tracepoints)) {
-			tp_probes->rcu.next = early_probes;
-			early_probes = &tp_probes->rcu;
-			return;
-		}
-
-		/*
-		 * Tracepoint probes are protected by both sched RCU and SRCU,
-		 * by calling the SRCU callback in the sched RCU callback we
-		 * cover both cases. So let us chain the SRCU and sched RCU
-		 * callbacks to wait for both grace periods.
-		 */
 		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
 	}
 }
-- 
2.45.2

