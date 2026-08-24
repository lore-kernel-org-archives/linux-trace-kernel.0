Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56932749C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606172; cv=none; b=GtV4dhvHkzB746LTuVpGQacrYkJUc15+axCRNGbb2qQllV6+sMyo5KHXPXZZ8EnlArnzOpXzwog/CCzfKElY+MJQIQOOUBdEZ9hwv16KN2FfksAMIPqt5UtmxpxoN/o4STrKR9TScIhG6Hneu6Y7wSiKBFE1YrZTgJZ8/AF6nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606172; c=relaxed/simple;
	bh=e4CqM7T4l2Pz5a/qs4z8g9JGoesVWyJk8zAnnKGW8v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XsYv9hlLwXPb71oPa51giZpcf3d8wgb0sLX6pComelbwLzzRnv7fRUlgJiM2OCOIiCyOBcc5ErGrD5xJIgvtl0/kSpxZcD8gaB/qM0mr0Sl4OSSgkN7FePdlKEuUQwuP9qJ6iFBnK1GloWh7vl15/+zmsXEY0jhYadkOPtulp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbnMVSQy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbnMVSQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787606169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFi4ukfARMjyMxn1JNtTbiSEv25cuEOq9MFgozaexbw=;
	b=fbnMVSQy0f9RV90GYv4U8ePaFvJkQ1LFl4O0cQbC1hleq8pO8aP++fH5NVzhxoBat7iE2s
	9944isw4RQEUXa4jsijUePArSDaEdv8ble/7PVqdRlKV8v1eg2917waSbTkWy6mArARsD2
	UuUt9j0bw315lFLnTY3ah9axMtENP/w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-lRijB26JNsK_73n0H0MG4Q-1; Mon, 24 Aug 2026 17:16:08 -0400
X-MC-Unique: lRijB26JNsK_73n0H0MG4Q-1
X-Mimecast-MFC-AGG-ID: lRijB26JNsK_73n0H0MG4Q_1787606167
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90c4e6517e9so79772406d6.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606167; x=1788210967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aFi4ukfARMjyMxn1JNtTbiSEv25cuEOq9MFgozaexbw=;
        b=HaG+hK1AA+Jg+ID0H3gYz1RHZDqKBpJ1HPsDsc25Ut0H641UtdSn5eawtLfCIJnyWT
         0EZ3MNLMeGqu5hhdLv/SqIiyEKPr+Ki18PkLLoMU87B7/HOynL5bAXVdMk+Cw5NpiEeX
         XIE/T4jzUxbrAuUbWwpTjH1fEEWORlgHDGlWkc3BNZ1a8/3/5BjvpaPkeMMPQ9+d+7Zs
         V9WHowtKNGFgiuPbAzva6g5txnKSUX1EctnB3kbsDUJ0oO+ddglTfB68r9EcaATSbUEM
         NeLzZFJHatdgsB/laL/FTZGzxQ2B9m/fW+5wKPAWn5sjN/03nnfSz7VOgmZjJUKXdk+9
         +MkA==
X-Forwarded-Encrypted: i=1; AHgh+RoSHAc0qHwPd+xYU3HJ2pKNylaaQaJeH1kZ+XlPc4/3wGR8qxvpysSTolIZX7WhcKYkAdr2Kur1u+1S3cCYlZv09sM=@vger.kernel.org
X-Gm-Message-State: AFuF++looMM5KIeUq9PuJYtAPY3iY3HFP2QcOGvDD2bsjRNumUH+xuRp
	DoWhjQvhxLWDsRJsPf/7uuLXeXeW/RTB1gJbNkLyz2JAZntXunHTnSwSJs07s8pb6H4IVKjii0R
	keNmuhvec5RXcRiRJ2L0GtfROSkLR+w0NTdfu1qHrg/86qVrLtGVzLDboTOl5u7UZg5I9Rix+Ug
	==
X-Gm-Gg: AR+sD137dlk+lbKn/baiDmeAWmNe8lGAyMOYPCro1LkqnFM2UJZ7aP5HR/FB/bKwDDi
	jB7n8v/TsJzdLfozJX19vF4kyMThnyfEmRcl77PSP7XepOg4yKK4atqJaYXh9XqmbO8//YpPpm8
	kblzYopXYzHRHB116gY433qdL/q0qKsXoO6jIEeZM/w+VMJ2XFUm3Mq8tmpmu0GOHjjjcf1Mqb/
	TfRKo7XE7jsKlTJMJB9XopeDuq+s984po6oipmwGzf5uScFjU6Lvvt7QYotbfZetczGo+iWZ1gj
	dp40aJXEx2w8qeba7MOxJD5TmGagr3W6mcnIKT5es4QL9GeIxN0F25SZObn5cZOLfj2iYbAoACy
	+kcnSm6yf660qoctYNm8qPvEtSUUHX7D1
X-Received: by 2002:a0c:e009:0:b0:90c:92d3:5bef with SMTP id 6a1803df08f44-90c92d35d67mr213010916d6.27.1787606167446;
        Mon, 24 Aug 2026 14:16:07 -0700 (PDT)
X-Received: by 2002:a0c:e009:0:b0:90c:92d3:5bef with SMTP id 6a1803df08f44-90c92d35d67mr213010306d6.27.1787606166794;
        Mon, 24 Aug 2026 14:16:06 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93931452sm71832556d6.26.2026.08.24.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:16:06 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
Date: Mon, 24 Aug 2026 16:15:41 -0500
Message-ID: <20260824211544.3984835-2-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824211544.3984835-1-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bi6OCWP80AyWEKBsEiCRbkJkHgnHpYALDp-pxc8BGI4_1787606167
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Clean up a variety of synchronization issues and related bandaids
by having a per-cpu mutex that guards changes to kthread, and
fd open/close/revoke.

Replace the SIGKILL hack for userspace timerlat threads (that doesn't
even work, because we don't wait for the process to actually die) with
a mutex-protected detachment mechanism.  The mutex should be uncontended
during normal timerlat_fd_read() usage.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/trace/trace_osnoise.c | 239 +++++++++++++++++++++--------------
 1 file changed, 144 insertions(+), 95 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0e1265acd1cc..e2e1ef3f5a61 100644
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
@@ -250,6 +261,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+static inline struct osnoise_variables *cpu_osn_var(int cpu)
+{
+	return per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+}
+
 /*
  * Protect the interface.
  */
@@ -292,9 +308,6 @@ static inline void tlat_var_reset(void)
 	struct timerlat_variables *tlat_var;
 	int cpu;
 
-	/* Synchronize with the timerlat interfaces */
-	mutex_lock(&interface_lock);
-
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
@@ -310,8 +323,6 @@ static inline void tlat_var_reset(void)
 	 * thread that wakes up, if TIMERLAT_ALIGN is set.
 	 */
 	atomic64_set(&align_next, 0);
-
-	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 #define tlat_var_reset()	do {} while (0)
@@ -330,8 +341,11 @@ static inline void osn_var_reset(void)
 	 * zeroing the structure is perfect.
 	 */
 	for_each_online_cpu(cpu) {
-		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
-		memset(osn_var, 0, sizeof(*osn_var));
+		osn_var = cpu_osn_var(cpu);
+
+		WARN_ON(osn_var->kthread);
+		WARN_ON(osn_var->fdd);
+		memset(&osn_var->zero, 0, sizeof(osn_var->zero));
 	}
 }
 
@@ -1673,6 +1687,8 @@ static void osnoise_sleep(bool skip_period)
  */
 static inline int osnoise_migration_pending(void)
 {
+	struct osnoise_variables *osn = this_cpu_osn_var();
+
 	if (!current->migration_pending)
 		return 0;
 
@@ -1688,10 +1704,10 @@ static inline int osnoise_migration_pending(void)
 	 * The tracers are responsible for cleaning their env before
 	 * exiting.
 	 */
-	mutex_lock(&interface_lock);
+	mutex_lock(&osn->lock);
 	this_cpu_osn_var()->kthread = NULL;
 	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
-	mutex_unlock(&interface_lock);
+	mutex_unlock(&osn->lock);
 
 	return 1;
 }
@@ -1978,32 +1994,22 @@ static int timerlat_main(void *data)
  */
 static void stop_kthread(unsigned int cpu)
 {
-	struct task_struct *kthread;
+	struct osnoise_variables *osn_var = cpu_osn_var(cpu);
 
-	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
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
-			put_task_struct(kthread);
-		}
-	} else {
-		/* if no workload, just return */
-		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			/*
-			 * This is set in the osnoise tracer case.
-			 */
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
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
+		osn_var->kthread = NULL;
 	}
+
+	mutex_unlock(&osn_var->lock);
 }
 
 /*
@@ -2029,13 +2035,18 @@ static void stop_per_cpu_kthreads(void)
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
-	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
-		return 0;
+	if (osn->kthread)
+		goto out;
 
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
@@ -2045,7 +2056,7 @@ static int start_kthread(unsigned int cpu)
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			per_cpu(per_cpu_osnoise_var, cpu).sampling = true;
 			barrier();
-			return 0;
+			goto out;
 		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
@@ -2054,13 +2065,16 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
-	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	osn->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
 
-	return 0;
+out:
+	mutex_unlock(&osn->lock);
+	return ret;
 }
 
 /*
@@ -2086,15 +2100,9 @@ static int start_per_cpu_kthreads(void)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
 
-	for_each_possible_cpu(cpu) {
-		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
-			struct task_struct *kthread;
-
-			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
-			if (!WARN_ON(!kthread))
-				kthread_stop(kthread);
-		}
-	}
+	for_each_possible_cpu(cpu)
+		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask))
+			stop_kthread(cpu);
 
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
@@ -2417,11 +2425,37 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 }
 
 #ifdef CONFIG_TIMERLAT_TRACER
+static void timerlat_fd_detach(struct fd_data *fdd)
+{
+	struct osnoise_variables *osn_var;
+	struct timerlat_variables *tlat_var;
+
+	osn_var = cpu_osn_var(fdd->cpu);
+	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, fdd->cpu);
+
+	lockdep_assert_held(&osn_var->lock);
+	if (WARN_ON(fdd != osn_var->fdd))
+		return;
+
+	WARN_ON(osn_var->kthread);
+
+	hrtimer_cancel(&tlat_var->timer);
+	memset(tlat_var, 0, sizeof(*tlat_var));
+
+	osn_var->sampling = 0;
+	osn_var->pid = 0;
+
+	put_task_struct(fdd->thread);
+	osn_var->fdd = NULL;
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
 
@@ -2437,16 +2471,15 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2455,24 +2488,33 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2482,6 +2524,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 
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
@@ -2497,12 +2545,13 @@ static ssize_t
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
 
@@ -2513,13 +2562,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
-		per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+		per_cpu_ptr(&per_cpu_timerlat_var, fdd->cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user thread migrate\n");
 		osnoise_stop_tracing();
 		migrate_enable();
@@ -2528,6 +2577,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 
 	osn_var = this_cpu_osn_var();
 
+	/* In normal usage, this should always be uncontended. */
+	mutex_lock(&osn_var->lock);
+	if (fdd != osn_var->fdd || current != fdd->thread) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * The timerlat in user-space runs in a different order:
 	 * the read() starts from the execution of the previous occurrence,
@@ -2574,6 +2630,11 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	/* wait for the next period */
 	wait_next_period(tlat);
 
+	if (fdd != osn_var->fdd) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* This is the wakeup from this cycle */
 	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
 	diff = now - tlat->abs_period;
@@ -2599,39 +2660,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	}
 
 out:
+	mutex_unlock(&osn_var->lock);
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
-
-	migrate_disable();
-	mutex_lock(&interface_lock);
-
-	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
-	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
-	if (tlat_var->kthread)
-		hrtimer_cancel(&tlat_var->timer);
-	memset(tlat_var, 0, sizeof(*tlat_var));
+	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, fdd->cpu);
 
-	osn_var->sampling = 0;
-	osn_var->pid = 0;
+	mutex_lock(&osn_var->lock);
+	if (fdd == osn_var->fdd)
+		timerlat_fd_detach(fdd);
+	mutex_unlock(&osn_var->lock);
 
-	/*
-	 * We are leaving, not being stopped... see stop_kthread();
-	 */
-	if (osn_var->kthread) {
-		put_task_struct(osn_var->kthread);
-		osn_var->kthread = NULL;
-	}
-
-	mutex_unlock(&interface_lock);
-	migrate_enable();
+	kfree(fdd);
 	return 0;
 }
 #endif
@@ -3157,10 +3203,13 @@ __init static int init_timerlat_tracer(void)
 
 __init static int init_osnoise_tracer(void)
 {
-	int ret;
+	int ret, cpu;
 
 	mutex_init(&interface_lock);
 
+	for_each_online_cpu(cpu)
+		mutex_init(&cpu_osn_var(cpu)->lock);
+
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
 
 	ret = register_tracer(&osnoise_tracer);
-- 
2.54.0

