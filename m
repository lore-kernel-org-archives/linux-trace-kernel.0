Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB71F3D4D;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364354; cv=none; b=iF99fSMWITpBFMOXYse6Mf+hKMx/9iln8sYWd1Eaxj0ETQBP6OzvYmc1/4yGQWDu/6LM2Gk494ykvHSs7AUZ2+bbvPiweBtxKbJie2Ng8yr/VA7003lW5IJ3b2uLGXh2tNgUttrRnpYxziXQJkJRyfnwRefpnfBDWZqxwbqRFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364354; c=relaxed/simple;
	bh=q9W3Lullw5b5N1EmJUz6xwLa09U+84wt5yQ35aM0t4Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O/R2jQxT8OgNvrf98toWCGndgFg14rAbay54CNBk5inQ2UILhRdFzD/YXoKMp3FPucQCdQiKKE59l5JvcI99bvrKxqwVgWSzvbPxHdzjhfvWMCvyG+FS1NquSQg5RaeS1gx1YnJ9PEfqhndwtwII2FaoHWzH3vcMUmREafU/nYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F52C4CEE6;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tdzzC-00000003vTU-2rcw;
	Fri, 31 Jan 2025 17:59:42 -0500
Message-ID: <20250131225942.535211818@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 31 Jan 2025 17:58:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-mm@kvack.org,
 x86@kernel.org,
 akpm@linux-foundation.org,
 luto@kernel.org,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 willy@infradead.org,
 mgorman@suse.de,
 jon.grimm@amd.com,
 bharata@amd.com,
 raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com,
 jgross@suse.com,
 andrew.cooper3@citrix.com,
 Joel Fernandes <joel@joelfernandes.org>,
 Vineeth Pillai <vineethrp@google.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>,
 bigeasy@linutronix.de,
 daniel.wagner@suse.com,
 joseph.salisbury@oracle.com,
 broonie@gmail.com
Subject: [RFC][PATCH 2/2] sched: Shorten time that tasks can extend their time slice for
References: <20250131225837.972218232@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a task sets its rseq bit to notify the kernel that it is in a critical
section, the kernel currently gives it a full time slice to get out of
that section. But that could be anywhere from 1ms to 10ms depending on the
CONFIG_HZ value, and this can cause unwanted latency in other
applications.

Limit the extra time to 50us, which should be long enough for tasks to
get out of their critical sections. If a task has a critical section
longer than 50us, then it should be using futexes anyway. That is, system
calls should not be a bottle neck for critical sections longer than 50us.

This makes the code rely not only on CONFIG_RSEQ but also CONFIG_SCHED_HRTICK
as it relies on a timer that can be set 50us into the future.

The flag rseq_sched_delay is added to the task struct.

The exit_to_user_mode_loop() will return the _TIF_NEED_RESCHED_LAZY flag
if it granted the task an extended time slice.

After interrupts are disabled and the code path is on its way to user
space, a new function rseq_delay_resched_fini() is called with the return
value of exit_to_user_mode_loop() (ti_work).

If the _TIF_NEED_RESCHED_LAZY is set in the ti_work, then it will check to
see if the task's rseq_sched_delay is already set (in case the task came
into user space for some other reason), and if it is not set, then it will
enable the schedule timer to trigger again in 50us and set the
rseq_sched_delay flag.

If that timer goes off, and the current task has the rseq_sched_delay flag
set, it will then force a schedule, and also clear the rseq cr_counter
flag stating that it had extended time, as user space no longer needs to
schedule.

sys_yield() has been modified to check to see if it was called and does a
trace_printk() if it has. This is for testing purposes and will likely be
removed in later versions of this patch.

This is based on Peter Ziljstra's code:

  https://lore.kernel.org/all/20231030132949.GA38123@noisy.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/entry-common.h |  2 +
 include/linux/sched.h        | 11 +++++-
 kernel/entry/common.c        |  2 +-
 kernel/rseq.c                | 76 +++++++++++++++++++++++++++++++++---
 kernel/sched/core.c          | 16 ++++++++
 kernel/sched/syscalls.c      |  6 +++
 6 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97..1e0970276726 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -330,6 +330,8 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
+	rseq_delay_resched_fini(ti_work);
+
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8e983d8cf72d..3c9d3ca9c5ad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -967,6 +967,9 @@ struct task_struct {
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
+#if defined(CONFIG_RSEQ) && defined(CONFIG_SCHED_HRTICK)
+	unsigned			rseq_sched_delay:1;
+#endif
 
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
@@ -2206,16 +2209,22 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_RSEQ
+#if defined(CONFIG_RSEQ) && defined(CONFIG_SCHED_HRTICK)
 
 extern bool rseq_delay_resched(void);
+extern void rseq_delay_resched_fini(unsigned long ti_work);
+extern void rseq_delay_resched_tick(void);
 
 #else
 
 static inline bool rseq_delay_resched(void) { return false; }
+extern inline void rseq_delay_resched_fini(unsigned long ti_work) {  }
+static inline void rseq_delay_resched_tick(void) { }
 
 #endif
 
+extern void hrtick_local_start(u64 delay);
+
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 50e35f153bf8..349f274d7185 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,7 +142,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
-	return ti_work;
+	return ti_work | ignore_mask;
 }
 
 /*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b792e36a3550..701c4801a111 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -339,35 +339,101 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+#ifdef CONFIG_SCHED_HRTICK
+void rseq_delay_resched_fini(unsigned long ti_work)
+{
+	extern void hrtick_local_start(u64 delay);
+	struct task_struct *t = current;
+
+	if (!t->rseq)
+		return;
+
+	if (!(ti_work & _TIF_NEED_RESCHED_LAZY)) {
+		/* Clear any previous setting of rseq_sched_delay */
+		t->rseq_sched_delay = 0;
+		return;
+	}
+
+	/* No need to start the timer if it is already started */
+	if (t->rseq_sched_delay)
+		return;
+
+	/*
+	 * IRQs off, guaranteed to return to userspace, start timer on this CPU
+	 * to limit the resched-overdraft.
+	 *
+	 * If your critical section is longer than 50 us you get to keep the
+	 * pieces.
+	 */
+
+	t->rseq_sched_delay = 1;
+	hrtick_local_start(50 * NSEC_PER_USEC);
+}
+
 bool rseq_delay_resched(void)
 {
 	struct task_struct *t = current;
 	u32 flags;
 
 	if (!t->rseq)
-		return false;
+		goto nodelay;
 
 	/* Make sure the cr_counter exists */
 	if (current->rseq_len <= offsetof(struct rseq, cr_counter))
-		return false;
+		goto nodelay;
 
 	/* If this were to fault, it would likely cause a schedule anyway */
 	if (copy_from_user_nofault(&flags, &t->rseq->cr_counter, sizeof(flags)))
-		return false;
+		goto nodelay;
 
 	if (!(flags & RSEQ_CR_FLAG_IN_CRITICAL_SECTION_MASK))
-		return false;
+		goto nodelay;
 
 	trace_printk("Extend time slice\n");
 	flags |= RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED;
 
 	if (copy_to_user_nofault(&t->rseq->cr_counter, &flags, sizeof(flags))) {
 		trace_printk("Faulted writing rseq\n");
-		return false;
+		goto nodelay;
 	}
 
 	return true;
+
+nodelay:
+	t->rseq_sched_delay = 0;
+	return false;
+}
+
+void rseq_delay_resched_tick(void)
+{
+	struct task_struct *t = current;
+
+	if (t->rseq_sched_delay) {
+		u32 flags;
+
+		set_tsk_need_resched(t);
+		t->rseq_sched_delay = 0;
+		trace_printk("timeout -- force resched\n");
+
+		/*
+		 * Now remove the that it was extended, as this will
+		 * force a schedule and user space no longer needs to.
+		 */
+
+		/* Just in case user space unregistered its rseq */
+		if (!t->rseq)
+			return;
+
+		if (copy_from_user_nofault(&flags, &t->rseq->cr_counter, sizeof(flags)))
+			return;
+
+		flags &= ~RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED;
+
+		if (copy_to_user_nofault(&t->rseq->cr_counter, &flags, sizeof(flags)))
+			return;
+	}
 }
+#endif /* CONFIG_SCHED_HRTICK */
 
 #ifdef CONFIG_DEBUG_RSEQ
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e5a6bf587f9..77d671dcd161 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -815,6 +815,7 @@ void update_rq_clock(struct rq *rq)
 
 static void hrtick_clear(struct rq *rq)
 {
+	rseq_delay_resched_tick();
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);
 }
@@ -830,6 +831,8 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
+	rseq_delay_resched_tick();
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
@@ -903,6 +906,16 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 #endif /* CONFIG_SMP */
 
+void hrtick_local_start(u64 delay)
+{
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+
+	rq_lock(rq, &rf);
+	hrtick_start(rq, delay);
+	rq_unlock(rq, &rf);
+}
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
@@ -6711,6 +6724,9 @@ static void __sched notrace __schedule(int sched_mode)
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_RSEQ
+	prev->rseq_sched_delay = 0;
+#endif
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
 #endif
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ff0e5ab4e37c..1d981599e890 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1379,6 +1379,12 @@ static void do_sched_yield(void)
  */
 SYSCALL_DEFINE0(sched_yield)
 {
+	if (current->rseq_sched_delay) {
+		trace_printk("yield -- made it\n");
+		schedule();
+		return 0;
+	}
+
 	do_sched_yield();
 	return 0;
 }
-- 
2.45.2


