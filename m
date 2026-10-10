Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C33385535
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599049; cv=none; b=AZQ87Kd9PRs1DfsDNxtTeAvxjuxJwtrCloDQgNwxpJOt322GfNcUfa+rt0CKeDRLrQXi8yFUiTc+T4iwsVJCmQw8gJ+NEj6nmQBcnu78MUhrvId47fS906RrGy9rnu1UmFeevCljSqe2UXW5VjAuavhuc297+IAANxzwhhpreH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599049; c=relaxed/simple;
	bh=yJX0o5FoWejWW2kD0JqIqqoMBdOZ2LHZq5cHXZbI5WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PhPKVW8xbROl7svj7uZJE56drINEV9DEm0fZ2ySC8Lz1zcaz29RGej9ZSIYo8a/IVxJ0AFnJleZ95Sk44ujuTOgHlAIc2Py3T8yOZ6ZWTzp9GtF2WcQO0jHP31BiGGRwmMXocgdgyUFtTaVCk5wHM160f7EpN6hp3Lb1YgtokO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dS7pOd7k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS7pOd7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb4BtAj3IXUBC9QKdhUlQosLU/wwMAODlAB3xnPUZ74=;
	b=dS7pOd7kFrC1gIc6Gmj7UAkJ82WOUxatu+98hHGaBuLa0Q0kERedPxAP3V3ayopIn71KGo
	F/UqeV3zry72WDEOmt0F2NqHXKWQ+iB6j5HNB14jaMWCpGQDneZB44bIIKsOmR9e80JqFN
	fx/+hGsad+QNAP2lBVtzF1RcTD9lthE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-zybwrK3CO66vn-OiSq-43g-1; Sat, 10 Oct 2026 02:24:05 +0000
X-MC-Unique: zybwrK3CO66vn-OiSq-43g-1
X-Mimecast-MFC-AGG-ID: zybwrK3CO66vn-OiSq-43g_1791599045
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535131e4c25so5652011cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599045; x=1792203845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cb4BtAj3IXUBC9QKdhUlQosLU/wwMAODlAB3xnPUZ74=;
        b=1cRAQlCmZ5LJYlUelgG3x2w/imqdZ/d1PEPgk6bIWJOC1AMXiAEtr8Uwh/SKqUe5ja
         Ogmbph0owzDCNWmryKO+eMZrI0oh0naUF3hFFs9xsiUw69D1nWfka9tTehJrvixBXRD+
         b32bIyMOFpZ3SffdJnmWKNwzFWKkCezp/o17W07GXYbZ0rf4FKrR/tPZIuhr4PjP6gTw
         TEdXysXU8RsWzLb9n6dpfdSB06xr9uaShoPJI6OSrwPNAOAQjXx9+KS8XeSVv9HEgVNS
         SMX9mJSoX8Jzm65/wJjVfrimLLcxPOcNrHPh0qsfpy77Ec6bZN0q6Dtln4lGIEkhNcWw
         ZpbA==
X-Forwarded-Encrypted: i=1; AKwUvBzmOkyaQvdiLEOyeNwAzrLV2WdmP7UDoTtoyuybQz6G8B8weAD0dgzoi9Z7usGTSZ72z5I7KGKdvsOxiZyVjHPXSAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPiC4SUwvCAVMBpaVkduY5lwBiHpQJ9KV/eD87e6RqhQkKEHYa
	nJ7ILJzSPMipQNqrxtSpuOSjmJLrfNLcrS9E679mIrrrArKiSutEKqwGQFHT3CGiAFFcwi+Wvox
	BIuR/0NXXHEXaVsxILAIegg6UiRlsRM3VTvUr7QFa0Y7l6OgQc6zf9Vr7/ezr/QLeI3r4TGimrw
	==
X-Gm-Gg: AYBFou2LyMaRQ6SBCm7clx/f+H5SPU7phEZzzRONGqvEbYMagsRaYEbnMJGwulILkmz
	N3DfdVyPLian10U9MSBlvjQGYd0xMBzJjPhKI66TtFvvC/oetxbvJyxn/8G35g1y4jdK1kytw0u
	SqQm6xz+dJEzMKbJnZpNms9C8x7DDUm3YnLR8JNuTkKwniFoxE/LVIKeY1qS5P0wQLkHpUIC9nf
	4MUTpLVnr1Mefjqgz+XSkTrn4wjj7KFqu4RH89++iqcetgEfloaPfDZ1oymBzSKnRU+73wH4SWc
	Dl0qaLszQ6SN1mn7iI7MB0GoK4zjYDWooW8RC0LuIX1NkdmRKEaKTFTizfnknl7O+wNwJuBrnf5
	N0OleQi7JDmIdkScU1+5oX3M7TLMkPCMvs4+v5O7g9PcPlVn13OaPwLY=
X-Received: by 2002:a05:622a:4d07:b0:531:11ac:23d8 with SMTP id d75a77b69052e-5359fba60edmr55675571cf.49.1791599044695;
        Fri, 09 Oct 2026 19:24:04 -0700 (PDT)
X-Received: by 2002:a05:622a:4d07:b0:531:11ac:23d8 with SMTP id d75a77b69052e-5359fba60edmr55675391cf.49.1791599044131;
        Fri, 09 Oct 2026 19:24:04 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:03 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 3/9] tracing/osnoise: Per-cpu mutexes and fd detachment
Date: Fri,  9 Oct 2026 21:23:32 -0500
Message-ID: <20261010022338.2507589-4-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010022338.2507589-1-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wa6dZDL79-td0frMQ9FqjbA82S6YblhtGx0EeWi246I_1791599045
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
---
 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 302 ++++++++++++++++--------
 2 files changed, 201 insertions(+), 106 deletions(-)

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
index 47ede1696c91..17cd5ea61e41 100644
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
@@ -1976,32 +2008,23 @@ static int timerlat_main(void *data)
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
+	mutex_unlock(&osn_var->lock);
 }
 
 /*
@@ -2027,13 +2050,18 @@ static void stop_per_cpu_kthreads(void)
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
@@ -2043,7 +2071,7 @@ static int start_kthread(unsigned int cpu)
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			cpu_osn_var(cpu)->sampling = true;
 			barrier();
-			return 0;
+			goto out;
 		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
@@ -2052,15 +2080,18 @@ static int start_kthread(unsigned int cpu)
 
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
@@ -2086,15 +2117,8 @@ static int start_per_cpu_kthreads(void)
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
@@ -2417,11 +2441,48 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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
 
@@ -2437,16 +2498,15 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2455,24 +2515,33 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2482,6 +2551,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 
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
@@ -2497,12 +2572,13 @@ static ssize_t
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
 
@@ -2513,13 +2589,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
@@ -2528,6 +2604,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 
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
@@ -2572,7 +2655,19 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
@@ -2599,39 +2694,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
@@ -3146,6 +3226,14 @@ static struct tracer timerlat_tracer __read_mostly = {
 
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
@@ -3157,10 +3245,16 @@ __init static int init_timerlat_tracer(void)
 
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

