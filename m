Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AF19AD89;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364354; cv=none; b=nrMOn/lzny37Q+leJCXre6zSR5/RUtbEVS46DospijG1PfN7QBA6o8ffrJX3hjYi9xu+PmV42/9Sc3qAQMYPxL2xrZfRDoschT341kxhEDcETGqJoN7OCdeqpECNTdV5ZNBTw/D8tawaXjUuywIAIpg8Yir9UF7/jVlVizu/RmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364354; c=relaxed/simple;
	bh=HeKKrSjPO37kaYaoIpprwh9Zc7PGQ4l50BHykndVcJM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gpiwc0TFfD1caH8laYqKzy4XRWFzvevrrqLI4IcO19KR89HTYhonpurAOxHFdo6i7vjm5dkoHVercKQvZPER1A2fEMmlE64U1kSK0+VZ461aw0E0/6FfWDmevb9ab/mWmdpPNmGDN9fmHVvYb9lLfPKK5IP+Z1tdjZNId90mpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30440C4CEE1;
	Fri, 31 Jan 2025 22:59:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tdzzC-00000003vSy-29MX;
	Fri, 31 Jan 2025 17:59:42 -0500
Message-ID: <20250131225942.365475324@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 31 Jan 2025 17:58:38 -0500
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
Subject: [RFC][PATCH 1/2] sched: Extended scheduler time slice
References: <20250131225837.972218232@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This is to improve user space implemented spin locks or any critical
section. It may also be extended for VMs and their guest spin locks as
well, but that will come later.

This adds a new field in the struct rseq called cr_counter. This is a 32 bit
field where bit zero is a flag reserved for the kernel, and the other 31
bits can be used as a counter (although the kernel doesn't care how they
are used, as any bit set means the same).

This works in tandem with PREEMPT_LAZY, where a task can tell the kernel
via the rseq structure that it is in a critical section (like holding a
spin lock) that it will be leaving very shortly, and to ask the kernel to
not preempt it at the moment.

The way this works is before going into a critical section, the user space
thread will increment the cr_counter by 2 (skipping bit zero that is
reserved for the kernel). If the tasks time runs out and NEED_RESCHED_LAZY
is set, on the way back out to user space, instead of calling schedule,
the kernel will allow user space to continue to run. For the moment, it
lets it run for one more tick (which will be changed later). When the
kernel lets the thread have some extended time, it will set bit zero of
the rseq cr_counter, to inform the user thread that it was granted extended
time and that it should call a system call immediately after it leaves its
critical section.

When the user thread leaves the critical section, it decrements the
counter by 2 and if the counter equals 1, then it knows that the kernel
extended its time slice and it then will call a system call to allow the
kernel to schedule it.

If NEED_RESCHED is set, then the rseq is ignored and the kernel will
schedule.

Note, the incrementing and decrementing the counter by 2 is just one
implementation that user space can use. As stated, any bit set in the
cr_counter from bit 1 to 31 will cause the kernel to try and grant extra
time.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h     | 10 ++++++++++
 include/uapi/linux/rseq.h | 24 ++++++++++++++++++++++++
 kernel/entry/common.c     | 14 +++++++++++++-
 kernel/rseq.c             | 30 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 64934e0830af..8e983d8cf72d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2206,6 +2206,16 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 unsigned long sched_cpu_util(int cpu);
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_RSEQ
+
+extern bool rseq_delay_resched(void);
+
+#else
+
+static inline bool rseq_delay_resched(void) { return false; }
+
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..185fe9826ff9 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,18 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_cr_flags_bit {
+	RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED_BIT	= 0,
+};
+
+enum rseq_cr_flags {
+	RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED	=
+	(1U << RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED_BIT),
+};
+
+#define RSEQ_CR_FLAG_IN_CRITICAL_SECTION_MASK	\
+	(~RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED)
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -148,6 +160,18 @@ struct rseq {
 	 */
 	__u32 mm_cid;
 
+	/*
+	 * The cr_counter is a way for user space to inform the kernel that
+	 * it is in a critical section. If bits 1-31 are set, then the
+	 * kernel may grant the thread a bit more time (but there is no
+	 * guarantee of how much time or if it is granted at all). If the
+	 * kernel does grant the thread extra time, it will set bit 0 to
+	 * inform user space that it has granted the thread more time and that
+	 * user space should call yield() as soon as it leaves its critical
+	 * section.
+	 */
+	__u32 cr_counter;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e33691d5adf7..50e35f153bf8 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -90,6 +90,8 @@ void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 						     unsigned long ti_work)
 {
+	unsigned long ignore_mask = 0;
+
 	/*
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
@@ -98,9 +100,18 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (ti_work & _TIF_NEED_RESCHED) {
 			schedule();
 
+		} else if (ti_work & _TIF_NEED_RESCHED_LAZY) {
+			/* Allow to leave with NEED_RESCHED_LAZY still set */
+			if (rseq_delay_resched()) {
+				trace_printk("Avoid scheduling\n");
+				ignore_mask |= _TIF_NEED_RESCHED_LAZY;
+			} else
+				schedule();
+		}
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
@@ -127,6 +138,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
+		ti_work &= ~ignore_mask;
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..b792e36a3550 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -339,6 +339,36 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+bool rseq_delay_resched(void)
+{
+	struct task_struct *t = current;
+	u32 flags;
+
+	if (!t->rseq)
+		return false;
+
+	/* Make sure the cr_counter exists */
+	if (current->rseq_len <= offsetof(struct rseq, cr_counter))
+		return false;
+
+	/* If this were to fault, it would likely cause a schedule anyway */
+	if (copy_from_user_nofault(&flags, &t->rseq->cr_counter, sizeof(flags)))
+		return false;
+
+	if (!(flags & RSEQ_CR_FLAG_IN_CRITICAL_SECTION_MASK))
+		return false;
+
+	trace_printk("Extend time slice\n");
+	flags |= RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED;
+
+	if (copy_to_user_nofault(&t->rseq->cr_counter, &flags, sizeof(flags))) {
+		trace_printk("Faulted writing rseq\n");
+		return false;
+	}
+
+	return true;
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
-- 
2.45.2


