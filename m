Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74D3128D4;
	Thu, 11 Sep 2025 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592273; cv=none; b=RxtbYSnchecJlEM9z4nKwOOgNBPfafONpDk4ARwPP7prjigmTWpMAs4nDVXa5FyVXaInuAqalAhYYrK2/pxlk7B2CbRb5jWEKBVJwcguOQu9y5FHWRtH638CtY/zxlRndW1L47XWA/MWMkA8/hdVUekXHrq/S235OD/m2DzD6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592273; c=relaxed/simple;
	bh=Xg8WPyY4Z2e/E6IlZJLdf5Ee7eBmYQHurcIBELdCrEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTacmU7Mb0NtiuJhbawiFNUl5CInMrvzwodFYeDhw5zUlgS0/LwCxVIRU4bdvSsdXeh5RxrvkmpQClv7jHwd7R14ta6gi0L4XKrFLIrCtBgVq7A1rEXNgF4A7+Ulr6FTXm9lHpb9RcvIYlZJ9zGAj0R2uaAUgEAj65lQMc0t4p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o254A2S4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o254A2S4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC95C4CEF0;
	Thu, 11 Sep 2025 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757592273;
	bh=Xg8WPyY4Z2e/E6IlZJLdf5Ee7eBmYQHurcIBELdCrEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=o254A2S4acpiYC5vQbnVB9cqvLl2eUTw6ADcSIvghj3LoBH8AO0qFyS2GXuC389aH
	 RK+cFV+F/cwGtT6aagNHEaLSghVwL7VtA87EI5661g2cxlfo9aQxPrbWEuDzKY7tY2
	 /60HrOSA6QAOR+WdCaQxSjKFBazmNjPJzu9rJWZ7VC0MkTpyDenggWuOV+9A3ROx1w
	 +wLFgneCu7aPkV528ZfyGYKb+NieXQya9a9852GpoJ5tz1fI2cBjVGQDVbCJTbiF3j
	 +vENVLVJ4zR1pSzuzxgWek2XSesckW4jrJZJnMMHhYierVw6XyrxZpTKiON9lcybas
	 TY9saRptMCskQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6428CE0C39; Thu, 11 Sep 2025 05:04:31 -0700 (PDT)
Date: Thu, 11 Sep 2025 05:04:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <f1223eab-3a31-4765-82a7-1d5d8af25a17@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508211038.c93e8603-lkp@intel.com>
 <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
 <aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>
 <d1ee722b-eb90-4b7e-9c2f-2db7d3b33ce9@paulmck-laptop>
 <20250903113112.247eb552@batman.local.home>
 <ea678a68-6a32-42d7-a9c7-f80261d02093@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea678a68-6a32-42d7-a9c7-f80261d02093@paulmck-laptop>

On Fri, Sep 05, 2025 at 06:43:34AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 03, 2025 at 11:31:12AM -0400, Steven Rostedt wrote:
> > On Wed, 3 Sep 2025 03:31:31 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > by applying the patch, the issue gone. but since you said this is a 'diagnostic
> > > > patch', not sure if it's a real fix. anyway:
> > > > 
> > > > Tested-by: kernel test robot <oliver.sang@intel.com>  
> > > 
> > > Thank you very much!  This tells me that something on the code path from
> > > the tracepoint to the BPF program needs to have preemption disabled.
> > > I will leave the diagnostic patch in my tree, and will be looking into
> > > what the real fix should be.
> > 
> > Was it a BPF program that triggered this? I couldn't get that from the
> > backtrace. Also, is this only a x86 32bit issue?
> 
> Excellent question, now that you mention it!  Your thought is that
> one of the other preemption-disablings might need to be moved?

And a quick chat with Yonghong Song (added on CC) pointed out one bug
in my conversion, namely that when BPF is invoked from a tracepoint,
it expects that BPF-program entry and exit will happen on the same CPU.
So I disabled migration, as shown in the upcated commit below.

This can result in duplicate preemption disabling on the non-BPF code
paths.  Please let me know if this is a problem, easy fix if so.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 69f96ca7b79912d58e8efddb09c45c0ee9dee6a1
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 16 12:34:26 2025 -0700

    tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
    
    The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
    to protect invocation of __DO_TRACE_CALL() means that BPF programs
    attached to tracepoints are non-preemptible.  This is unhelpful in
    real-time systems, whose users apparently wish to use BPF while also
    achieving low latencies.  (Who knew?)
    
    One option would be to use preemptible RCU, but this introduces
    many opportunities for infinite recursion, which many consider to
    be counterproductive, especially given the relatively small stacks
    provided by the Linux kernel.  These opportunities could be shut down
    by sufficiently energetic duplication of code, but this sort of thing
    is considered impolite in some circles.
    
    Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
    readers than those of preemptible RCU, at least on my laptop, where
    task_struct access is more expensive than access to per-CPU variables.
    And SRCU fast provides way faster readers than does SRCU, courtesy of
    being able to avoid the read-side use of smp_mb().  Also, it is quite
    straightforward to create srcu_read_{,un}lock_fast_notrace() functions.
    
    While in the area, SRCU now supports early boot call_srcu().  Therefore,
    remove the checks that used to avoid such use from rcu_free_old_probes()
    before this commit was applied:
    
    e53244e2c893 ("tracepoint: Remove SRCU protection")
    
    The current commit can be thought of as an approximate revert of that
    commit, with some compensating additions of preemption disabling pointed
    out by Steven Rostedt (thank you, Steven!).  This preemption disabling
    uses guard(preempt_notrace)(), and while in the area a couple of other
    use cases were also converted to guards.
    
    However, Yonghong Song points out that BPF expects non-sleepable BPF
    programs to remain on the same CPU, which means that migration must
    be disabled whenever preemption remains enabled.  In addition, non-RT
    kernels have performance expectations on BPF that would be violated
    by allowing the BPF programs to be preempted.
    
    Therefore, continue to disable preemption in non-RT kernels, and protect
    the BPF program with both SRCU and migration disabling for RT kernels,
    and even then only if preemption is not already disabled.
    
    [ paulmck: Apply kernel test robot and Yonghong Song feedback. ]
    
    Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Cc: <bpf@vger.kernel.org>

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f851..9f8b19cd303acc 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -115,7 +117,10 @@ void for_each_tracepoint_in_module(struct module *mod,
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		synchronize_srcu(&tracepoint_srcu);
+	else
+		synchronize_rcu();
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -266,23 +271,29 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __do_trace_##name(proto)			\
-	{								\
-		if (cond) {						\
-			guard(preempt_notrace)();			\
-			__DO_TRACE_CALL(name, TP_ARGS(args));		\
-		}							\
-	}								\
-	static inline void trace_##name(proto)				\
-	{								\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__do_trace_##name(args);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			WARN_ONCE(!rcu_is_watching(),			\
-				  "RCU not watching for tracepoint");	\
-		}							\
+	static inline void __do_trace_##name(proto)				\
+	{									\
+		if (cond) {							\
+			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\
+				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
+				guard(migrate)();				\
+				__DO_TRACE_CALL(name, TP_ARGS(args));		\
+			} else {						\
+				guard(preempt_notrace)();			\
+				__DO_TRACE_CALL(name, TP_ARGS(args));		\
+			}							\
+		}								\
+	}									\
+	static inline void trace_##name(proto)					\
+	{									\
+		if (static_branch_unlikely(&__tracepoint_##name.key))		\
+			__do_trace_##name(args);				\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {			\
+			WARN_ONCE(!rcu_is_watching(),				\
+				  "RCU not watching for tracepoint");		\
+		}								\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
diff --git a/include/trace/perf.h b/include/trace/perf.h
index a1754b73a8f55b..348ad1d9b5566e 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
 }
 
@@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)					\
 	struct task_struct *__task __attribute__((unused));		\
 									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd4656c..fbc07d353be6b6 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -436,6 +436,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
 
@@ -447,9 +448,8 @@ static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c900..21bb6779821476 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,6 +25,9 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU_FAST(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -34,6 +37,7 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
@@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -101,17 +108,29 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
+		/*
+		 * Tracepoint probes are protected by either RCU or
+		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU
+		 * callback in the [Tasks Trace] RCU callback we cover
+		 * both cases. So let us chain the SRCU and [Tasks Trace]
+		 * RCU callbacks to wait for both grace periods.
+		 */
 		if (tracepoint_is_faultable(tp))
 			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
 		else
