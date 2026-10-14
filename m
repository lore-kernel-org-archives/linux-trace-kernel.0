Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB80374A06
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944828; cv=none; b=NGs+GRXzQqpd90ykCWjqd5QefpuNfDDcFYgDIqBSDAtB8XJXlXm9aAgjMbvfpQHqMx6cCjoUyRqbCIrLAGrqZYG7MUnyYHP84iXRRTy5ooL79DMmWpi0rEnB1iAogXZBN5G8SINM3xu4dE6VgHhrL9hmeKwqdcixn38SBlJHJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944828; c=relaxed/simple;
	bh=+7aefSKY1gXXvraSENki0vm1h02D3V4Xln36LPE+dSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kkTJwTbHAlQXbTGXWgUjLGHrx1/nqRxBPq5wZhhJXsHYEJgMgIzHNsfqMLhniydYwfoMPjKoP9hb8/gFXt1Z9NKL2PXNS8BlMph5fxbAkEPnMqkvNfcmJg09dnqMuY/x+K9ZF/gCwUOiYVglKG9685gVJHyhkN+EmuLcrNXkEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBPoxMoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBPoxMoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pD1K8UnxaUNFMbmMEtCJuuXLsTmmxYGqniVDy6YrpM=;
	b=EBPoxMoHMT+zUF4v+lA/53XUDxB1Hm8KrDxeGLpghnjSiQ454+Fmhys/K4XB0Y/kORR1Kz
	iee3RqUCpyrI1osHna0ODoCXWiZ+xZ8UNNuvdlO+xxtejCLR8Q2ofb3+wss8184rPKhhwg
	nSg2tJDDh3eCqNuflOJ+axX4jLyZWZ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-sT46VCo6ONe5MCItV--L-Q-1; Wed, 14 Oct 2026 02:27:00 +0000
X-MC-Unique: sT46VCo6ONe5MCItV--L-Q-1
X-Mimecast-MFC-AGG-ID: sT46VCo6ONe5MCItV--L-Q_1791944819
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b937ecbb4so38670126d6.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944819; x=1792549619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1pD1K8UnxaUNFMbmMEtCJuuXLsTmmxYGqniVDy6YrpM=;
        b=UQVtGbzvv3vUcDZx69YRR5PGDFvT85P4tIe7h9z1c0ehnavXuxVbQ05CgI0uQaRAPS
         QYz90SQ0gn41s8ajg+R8VvGhmbczU2RfvF3irNBIbCgdFLLUDNLtQTfy0Aa7sUELMNUm
         2pDa7T2l5PRxd2W5hB+sePr55NUdXoSAH8Au/wY2o9QR8u7jy6YDDeI/kzb4mvQdNTYw
         SBgC+ZQZb6kyf+NqN1G+KQaCNRTuDPxEXGlLS/WWzISDic1YSS59wyfI2mvZ+mmwfBY2
         oYl7qKSHq6NbBCQ2pAe4+i7BkU19vLwPhRqQRm68Wrl/wKyxNts8llU+nGl+5zNVn5+U
         bpJg==
X-Forwarded-Encrypted: i=1; AKwUvBwVOdVD+wVnpyOco/okg8rz+8vlFJ1KJHT504bT6dCiivOIvc0xJuYwjWMJFtLaGUnjJCob0wwZwl0/RUNnr6LSZ4U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQslrNZx288f/41eUcoGTDyTXIKjPjm2W4Sa/QTbuceahvVfws
	w7y/PweCUfnWi4eh8QbFch8XeQe1jbBuctc8yvIR2WxLy8fW861OvevV4S2dFkPRdohT/nBNBEA
	Q19NnNEJwkSE+KWlmGC4J2emKbOU9yELtFx7ip/fvdegVojQ7oqXlMnIMOkzSpPkqAmc3TKQqKQ
	==
X-Gm-Gg: AYBFou3yLl5lRMnbTtbJnzrPKLsVw6fleR1CZldvJpfmfuIGuiOa7TwpL1j6qFI+mwj
	4DA09SpHuHAHs2yxR1/xcb7hPHe8PMo8QWsVa1YkMFZtmAJcK9btkK8AVrPxz/xFVt23oC6YP29
	MOTpLXJPyGE23kuMWo6k6hXxWHAJtHo5eF/Jr0DoSXEsqJTJnzrs9dc/UyRwNOPwZc6ez0yzfhM
	D9cH9JVc5rDEW1ILkwEbsCGE6MnjZAEm+oCDwq0d5zNBk4liaquYS4Ebb88cqLw5uD4bqyBI+/P
	dmobkTJ5VntYMqpzs1x7ujweoG5bLvUD7aTr2Fnh5etGQENuHgPD2rfWWgGm2X4tHso7brkdmbV
	77plTlL7Z3ou1CtrD5wKE8tWX3wEPZJgq6Pdf7XMxXvRbeFV+E1Dthwk=
X-Received: by 2002:a05:6214:5d08:b0:917:a256:c151 with SMTP id 6a1803df08f44-91b557c63f4mr280629926d6.45.1791944819210;
        Tue, 13 Oct 2026 19:26:59 -0700 (PDT)
X-Received: by 2002:a05:6214:5d08:b0:917:a256:c151 with SMTP id 6a1803df08f44-91b557c63f4mr280629666d6.45.1791944818635;
        Tue, 13 Oct 2026 19:26:58 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:26:58 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 3/9] tracing/osnoise: Per-cpu mutexes and fd detachment
Date: Tue, 13 Oct 2026 21:26:34 -0500
Message-ID: <20261014022640.695786-4-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014022640.695786-1-crwood@redhat.com>
References: <20261014022640.695786-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LpNQliE37MGKP3gb_dgC4iNieFoCtc4yqOzypTDVUKs_1791944819
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Clean up a variety of synchronization issues and related bandaids
by having a per-cpu mutex that guards changes to kthread, and
another than guards fd open/close/revoke.

Replace the SIGKILL hack for userspace timerlat threads (that doesn't
even work, because we don't wait for the process to actually die) with
a mutex-protected detachment mechanism.  The mutex should be uncontended
during normal timerlat_fd_read() usage.

This also eliminates the need for the "quick fix" of e6a53481da292
("tracing/timerlat: Only clear timer if a kthread exists").

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2:
 - Use a separate lock for detachment, so that we can wake the thread that
   holds the detach lock, while holding osn->lock to make sure the thread
   is valid.
 - Return -EINVAL if detached while waiting, and -ERESTARTSYS on a signal
 - Init mutex on every possible cpu (as pointed out by Sashiko)
 - Update documentation for SIGKILL removal

v3:
 - Clear osn_var->sampling in stop_kthread(), as reporteed by Sashiko
   for the osnoise non-workload case
---
 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 303 ++++++++++++++++--------
 2 files changed, 202 insertions(+), 106 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index 68d429d454a5..ea94627e821b 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -220,8 +220,9 @@ After reporting the total latency, timerlat will restart the cycle, arm
 a timer, and go to sleep for the following activation.
 
 If at any time one of the conditions is broken, e.g., the thread migrates
-while in user space, or the timerlat tracer is disabled, the SIG_KILL
-signal will be sent to the user-space thread.
+while in user space, or the timerlat tracer is disabled, the fd will be
+detached from the tracer, and subsequent usage will fail with EINVAL.
+Note that older kernels may deliver a SIGKILL instead.
 
 Here is an basic example of user-space code for timerlat::
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 47ede1696c91..20b0264e5adc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -222,19 +222,30 @@ struct osn_thread {
 	u64	delta_start;
 };
 
+struct fd_data {
+	struct task_struct *thread;
+	void (*detach)(struct fd_data *fdd);
+	int cpu;
+};
+
 /*
  * Runtime information: this structure saves the runtime information used by
  * one sampling thread.
  */
 struct osnoise_variables {
+	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
-	bool			sampling;
-	pid_t			pid;
-	struct osn_nmi		nmi;
-	struct osn_irq		irq;
-	struct osn_softirq	softirq;
-	struct osn_thread	thread;
-	local_t			int_counter;
+	struct fd_data		*fdd;
+
+	struct_group(zero,
+		bool			sampling;
+		pid_t			pid;
+		struct osn_nmi		nmi;
+		struct osn_irq		irq;
+		struct osn_softirq	softirq;
+		struct osn_thread	thread;
+		local_t			int_counter;
+	);
 };
 
 /*
@@ -266,11 +277,25 @@ static struct mutex interface_lock;
  */
 struct timerlat_variables {
 	struct task_struct	*thread;
-	struct hrtimer		timer;
-	u64			abs_period;
-	bool			tracing_thread;
-	u64			count;
-	bool			uthread_migrate;
+
+	/*
+	 * This is separate from osn->lock in order to allow waking
+	 * the waiting thread during forced detach, without having to
+	 * wait for the next period (and possibly longer, due to
+	 * priority-based lock stealing).
+	 *
+	 * Both locks must be held during the actual detachment.
+	 */
+	struct mutex		detach_lock;
+
+	struct_group(zero,
+		struct hrtimer		timer;
+		u64			abs_period;
+		bool			tracing_thread;
+		u64			count;
+		bool			uthread_migrate;
+		bool			detach;
+	);
 };
 
 static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
@@ -301,26 +326,20 @@ static inline void tlat_var_reset(void)
 	struct timerlat_variables *tlat_var;
 	int cpu;
 
-	/* Synchronize with the timerlat interfaces */
-	mutex_lock(&interface_lock);
-
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
 	for_each_online_cpu(cpu) {
 		tlat_var = cpu_tmr_var(cpu);
-		if (tlat_var->thread)
-			hrtimer_cancel(&tlat_var->timer);
-		memset(tlat_var, 0, sizeof(*tlat_var));
+		WARN_ON_ONCE(tlat_var->thread);
+		memset(&tlat_var->zero, 0, sizeof(tlat_var->zero));
 	}
 	/*
 	 * Reset also align_next, to be filled by a new offset by the first timerlat
 	 * thread that wakes up, if TIMERLAT_ALIGN is set.
 	 */
 	atomic64_set(&align_next, 0);
-
-	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 #define tlat_var_reset()	do {} while (0)
@@ -340,7 +359,10 @@ static inline void osn_var_reset(void)
 	 */
 	for_each_online_cpu(cpu) {
 		osn_var = cpu_osn_var(cpu);
-		memset(osn_var, 0, sizeof(*osn_var));
+
+		WARN_ON(osn_var->kthread);
+		WARN_ON(osn_var->fdd);
+		memset(&osn_var->zero, 0, sizeof(osn_var->zero));
 	}
 }
 
@@ -1883,10 +1905,18 @@ static int wait_next_period(struct timerlat_variables *tlat)
 	}
 
 	set_current_state(TASK_INTERRUPTIBLE);
+	if (!tlat->detach && !signal_pending(current)) {
+		hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
 
-	hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);
-	schedule();
-	return 1;
+	if (tlat->detach || signal_pending(current)) {
+		hrtimer_cancel(&tlat->timer);
+		return -1;
+	}
+
+	return 0;
 }
 
 /*
@@ -1960,7 +1990,9 @@ static int timerlat_main(void *data)
 		wait_next_period(tlat);
 	}
 
+	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
 	hrtimer_cancel(&tlat->timer);
+	tlat->thread = NULL;
 	migrate_enable();
 	return 0;
 }
@@ -1976,32 +2008,24 @@ static int timerlat_main(void *data)
  */
 static void stop_kthread(unsigned int cpu)
 {
-	struct task_struct *kthread;
+	struct osnoise_variables *osn_var = cpu_osn_var(cpu);
 
-	kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
-	if (kthread) {
-		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
-		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
-			kthread_stop(kthread);
-		} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
-			/*
-			 * This is a user thread waiting on the timerlat_fd. We need
-			 * to close all users, and the best way to guarantee this is
-			 * by killing the thread. NOTE: this is a purpose specific file.
-			 */
-			kill_pid(kthread->thread_pid, SIGKILL, 1);
-		}
-		put_task_struct(kthread);
-	} else {
-		/* if no workload, just return */
-		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			/*
-			 * This is set in the osnoise tracer case.
-			 */
-			cpu_osn_var(cpu)->sampling = false;
-			barrier();
-		}
+	mutex_lock(&osn_var->lock);
+
+	if (osn_var->fdd) {
+		WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options));
+		WARN_ON(osn_var->kthread);
+		osn_var->fdd->detach(osn_var->fdd);
+	} else if (osn_var->kthread) {
+		WARN_ON(!cpumask_test_and_clear_cpu(cpu, &kthread_cpumask));
+		WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options));
+		kthread_stop(osn_var->kthread);
+		put_task_struct(osn_var->kthread);
+		osn_var->kthread = NULL;
 	}
+
+	osn_var->sampling = false;
+	mutex_unlock(&osn_var->lock);
 }
 
 /*
@@ -2027,13 +2051,18 @@ static void stop_per_cpu_kthreads(void)
  */
 static int start_kthread(unsigned int cpu)
 {
+	struct osnoise_variables *osn = cpu_osn_var(cpu);
 	struct task_struct *kthread;
 	void *main = osnoise_main;
 	char comm[24];
+	int ret = 0;
+
+	lockdep_assert_held(&trace_types_lock);
+	mutex_lock(&osn->lock);
 
 	/* Do not start a new thread if it is already running */
-	if (cpu_osn_var(cpu)->kthread)
-		return 0;
+	if (osn->kthread)
+		goto out;
 
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
@@ -2043,7 +2072,7 @@ static int start_kthread(unsigned int cpu)
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			cpu_osn_var(cpu)->sampling = true;
 			barrier();
-			return 0;
+			goto out;
 		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
@@ -2052,15 +2081,18 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	get_task_struct(kthread);
-	cpu_osn_var(cpu)->kthread = kthread;
+	osn->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
 	wake_up_process(kthread);
 
-	return 0;
+out:
+	mutex_unlock(&osn->lock);
+	return ret;
 }
 
 /*
@@ -2086,15 +2118,8 @@ static int start_per_cpu_kthreads(void)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
 
-	for_each_possible_cpu(cpu) {
-		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
-			struct task_struct *kthread;
-
-			kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
-			if (!WARN_ON(!kthread))
-				kthread_stop(kthread);
-		}
-	}
+	for_each_possible_cpu(cpu)
+		WARN_ON(cpumask_test_cpu(cpu, &kthread_cpumask));
 
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
@@ -2417,11 +2442,48 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 }
 
 #ifdef CONFIG_TIMERLAT_TRACER
+static void timerlat_fd_detach(struct fd_data *fdd)
+{
+	struct osnoise_variables *osn;
+	struct timerlat_variables *tlat;
+
+	osn = cpu_osn_var(fdd->cpu);
+	tlat = cpu_tmr_var(fdd->cpu);
+
+	lockdep_assert_held(&osn->lock);
+	if (WARN_ON(fdd != osn->fdd))
+		return;
+
+	WARN_ON(osn->kthread);
+	WARN_ON(fdd->thread != tlat->thread);
+	tlat->detach = true;
+	wake_up_process(tlat->thread);
+
+	mutex_lock(&tlat->detach_lock);
+
+	memset(tlat, 0, sizeof(*tlat));
+
+	osn->sampling = 0;
+	osn->pid = 0;
+
+	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
+	hrtimer_cancel(&tlat->timer);
+	put_task_struct(fdd->thread);
+
+	fdd->thread = NULL;
+	tlat->thread = NULL;
+	osn->fdd = NULL;
+
+	mutex_unlock(&tlat->detach_lock);
+}
+
 static int timerlat_fd_open(struct inode *inode, struct file *file)
 {
+	struct fd_data *fdd;
 	struct osnoise_variables *osn_var;
 	struct timerlat_variables *tlat;
 	long cpu = (long) inode->i_cdev;
+	int ret = 0;
 
 	mutex_lock(&interface_lock);
 
@@ -2437,16 +2499,15 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	migrate_disable();
 
 	osn_var = this_cpu_osn_var();
+	mutex_lock(&osn_var->lock);
 
-	/*
-	 * The osn_var->pid holds the single access to this file.
-	 */
-	if (osn_var->pid) {
-		mutex_unlock(&interface_lock);
-		migrate_enable();
-		return -EBUSY;
+	if (osn_var->fdd) {
+		ret = -EBUSY;
+		goto err;
 	}
 
+	WARN_ON_ONCE(osn_var->kthread);
+
 	/*
 	 * timerlat tracer is a per-cpu tracer. Check if the user-space too
 	 * is pinned to a single CPU. The tracer laters monitor if the task
@@ -2455,24 +2516,33 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * setup.
 	 */
 	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id()) {
-		mutex_unlock(&interface_lock);
-		migrate_enable();
-		return -EPERM;
+		ret = -EPERM;
+		goto err;
+	}
+
+	fdd = kmalloc(sizeof(*fdd), GFP_KERNEL);
+	if (!fdd) {
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	/*
 	 * From now on, it is good to go.
 	 */
-	file->private_data = inode->i_cdev;
+	fdd->thread = current;
+	fdd->detach = timerlat_fd_detach;
+	fdd->cpu = cpu;
+	file->private_data = fdd;
 
 	get_task_struct(current);
 
-	osn_var->kthread = current;
 	osn_var->pid = current->pid;
+	osn_var->fdd = fdd;
 
 	/*
 	 * Setup is done.
 	 */
+	mutex_unlock(&osn_var->lock);
 	mutex_unlock(&interface_lock);
 
 	tlat = this_cpu_tmr_var();
@@ -2482,6 +2552,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 
 	migrate_enable();
 	return 0;
+
+err:
+	mutex_unlock(&osn_var->lock);
+	mutex_unlock(&interface_lock);
+	migrate_enable();
+	return ret;
 };
 
 /*
@@ -2497,12 +2573,13 @@ static ssize_t
 timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		  loff_t *ppos)
 {
-	long cpu = (long) file->private_data;
+	struct fd_data *fdd = file->private_data;
 	struct osnoise_variables *osn_var;
 	struct timerlat_variables *tlat;
 	struct timerlat_sample s;
 	s64 diff;
 	u64 now;
+	int ret = 0;
 
 	migrate_disable();
 
@@ -2513,13 +2590,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	 * we can do about it.
 	 * So, if the thread is running on another CPU, stop the machinery.
 	 */
-	if (cpu == smp_processor_id()) {
+	if (fdd->cpu == smp_processor_id()) {
 		if (tlat->uthread_migrate) {
 			migrate_enable();
 			return -EINVAL;
 		}
 	} else {
-		cpu_tmr_var(cpu)->uthread_migrate = 1;
+		cpu_tmr_var(fdd->cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user thread migrate\n");
 		osnoise_stop_tracing();
 		migrate_enable();
@@ -2528,6 +2605,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 
 	osn_var = this_cpu_osn_var();
 
+	/* In normal usage, this should always be uncontended. */
+	mutex_lock(&tlat->detach_lock);
+	if (fdd != osn_var->fdd || current != fdd->thread) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * The timerlat in user-space runs in a different order:
 	 * the read() starts from the execution of the previous occurrence,
@@ -2572,7 +2656,19 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	}
 
 	/* wait for the next period */
-	wait_next_period(tlat);
+	if (wait_next_period(tlat) < 0) {
+		if (signal_pending(current))
+			ret = -ERESTARTSYS;
+		else
+			ret = -EINVAL;
+
+		goto out;
+	}
+
+	if (WARN_ON_ONCE(fdd != osn_var->fdd)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* This is the wakeup from this cycle */
 	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
@@ -2599,39 +2695,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	}
 
 out:
+	mutex_unlock(&tlat->detach_lock);
 	migrate_enable();
-	return 0;
+	return ret;
 }
 
 static int timerlat_fd_release(struct inode *inode, struct file *file)
 {
+	struct fd_data *fdd = file->private_data;
 	struct osnoise_variables *osn_var;
-	struct timerlat_variables *tlat_var;
-	long cpu = (long) file->private_data;
 
-	migrate_disable();
-	mutex_lock(&interface_lock);
+	osn_var = cpu_osn_var(fdd->cpu);
 
-	osn_var = cpu_osn_var(cpu);
-	tlat_var = cpu_tmr_var(cpu);
-
-	if (tlat_var->thread)
-		hrtimer_cancel(&tlat_var->timer);
-	memset(tlat_var, 0, sizeof(*tlat_var));
-
-	osn_var->sampling = 0;
-	osn_var->pid = 0;
-
-	/*
-	 * We are leaving, not being stopped... see stop_kthread();
-	 */
-	if (osn_var->kthread) {
-		put_task_struct(osn_var->kthread);
-		osn_var->kthread = NULL;
-	}
+	mutex_lock(&osn_var->lock);
+	if (fdd == osn_var->fdd)
+		timerlat_fd_detach(fdd);
+	mutex_unlock(&osn_var->lock);
 
-	mutex_unlock(&interface_lock);
-	migrate_enable();
+	kfree(fdd);
 	return 0;
 }
 #endif
@@ -3146,6 +3227,14 @@ static struct tracer timerlat_tracer __read_mostly = {
 
 __init static int init_timerlat_tracer(void)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct timerlat_variables *tlat = cpu_tmr_var(cpu);
+
+		mutex_init(&tlat->detach_lock);
+	}
+
 	return register_tracer(&timerlat_tracer);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
@@ -3157,10 +3246,16 @@ __init static int init_timerlat_tracer(void)
 
 __init static int init_osnoise_tracer(void)
 {
-	int ret;
+	int ret, cpu;
 
 	mutex_init(&interface_lock);
 
+	for_each_possible_cpu(cpu) {
+		struct osnoise_variables *osn = cpu_osn_var(cpu);
+
+		mutex_init(&osn->lock);
+	}
+
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
 
 	ret = register_tracer(&osnoise_tracer);
-- 
2.54.0

