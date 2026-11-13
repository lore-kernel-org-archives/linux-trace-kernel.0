Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552078;
	b=e55MO+G0lRWYjZKVo3C3lOkpe2CUHSqyjcq+eFjGv8XnFqyuikpgJajjI2E4nBQVxBlU
	 Su3e0VnM1VOq6hPAF7xmAwvBShle11P1P5OGr+PRg8hKdDcgDDPavVm9wD8QXusM5FLsd
	 MAW0SjI4Zpip+hiyB3mdg0RoMXMYGq5X2HZwzhcMgrxoUrLCd7Ezb/TlHZgzpJHk0RXGP
	 JA3IuQrqZuwss2kv2njw1dQZPHptlKFE5jt4mNA+b2B2dTaW3Y7oM/ltLu7GetUMKOy+/
	 j6v39z0LoffAyAsa/0VXH+DD9QUEBL14K5kdt3/ZiHmJAPQmnStE3c9KFZh986PkGiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552078;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=uSheQb/yfEdE/VEH3AXc6Plc+wNLc0GVdRwmcywMGtg=;
	b=HQq6f31qqxv4Qibz7ZB7KrQH8l4dtGfiTbMCFCJ2PtJU821VEV84YjPdjANWoqlhlQBk
	 QyeWuJIXikYeoQ7udQrOKZHFUaV07qbSyoAS1zDby1GmsJzKeBudyHJFFx9uAGeTUgQVn
	 Npm/4reyP1hqsncID389qvWRwXaVzPjXzLAA03jVpsgKqufMVAUdhR9kucGep0Aby4e7s
	 us4FT0yuhgtbzkp9wAAuG18281lpSeo39KmCxU4UxCtK5ZnTtiZeSGUl6Y7Cj7YgaZQLV
	 BXqjDHQ2VxIqnm/6DqSxOB6Shsn8ClKSld6LRT5X2kKaM3rIA2UltADvAD61m/dos8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jvj952DO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFC606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFFC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jvj952DO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSheQb/yfEdE/VEH3AXc6Plc+wNLc0GVdRwmcywMGtg=;
	b=Jvj952DOy7NYR/AdZ6JuR55arEpiY35MVD1V1BWlwRIzpM6OO/PWHN8IZydMMBHSwmmMPQ
	Le/7TUactGKZ6PdAmz1XSMLM5vrNpn3D2Urn3vIKI7tso8/W6odxow0IweSnJPtwEjdZ4q
	ZPFyCEa+BLSsSPmDdjYROSIjtKQ9MuM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-uSYf8y8DNqiwkmslGangcw-1; Fri, 13 Nov 2026 01:41:15 -0500
X-MC-Unique: uSYf8y8DNqiwkmslGangcw-1
X-Mimecast-MFC-AGG-ID: uSYf8y8DNqiwkmslGangcw_1794552075
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-821de0b7baaso43868a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552075; x=1795156875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSheQb/yfEdE/VEH3AXc6Plc+wNLc0GVdRwmcywMGtg=;
        b=rf/M7xHQCtYhVvDVnk08vEo6tdEq26NbEDXProJLaApXdv0FCa7rzl8mURQVb156uD
         qMATm1YZEQtE8hAfCiMirOpdLA2fkwTOvXj4AATpcTa7jYuXaIKinS4rTDQlhuAFiNaz
         3WcSSYcE7ZrftyPDpE4IW70PmsgeR8R5hKxeEJH0TDAoJMgn7kcbfar3B+YxJmq2st7G
         Jdi0YulXMj5Dh+MJEm5hhQdeh6o42SB6OYTm+qW/d5EYvJ4sNL0xKOrAQPpZxDK/uvgw
         dI5E8RnYBfrnIYqBkwbPJtM9C+rMT/dZ/gdK5R4DgZQvVu3Xq7lZUvliSnDb9IpLk6CX
         s0Lg==
X-Forwarded-Encrypted: i=1; AL+hErGAumGC+EWBethKpDYMx+Q2j/LhCNU/5L0MEGnSebxAAny2BV1LHANSHVefkeMK9x0sIoJY2/n9IsUEH5qzrh6pa5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qp2zJJOQYJuyhDKu767astYbd9qWwIu7lFYQuU6P5W0fQvGUa
	VSQqQQ5L9KPG1uEBLfF52m38oP8Imrw/oQ5S7tAEBETBABLN0o0KaBqqb3ZC5MVShDYG1emXzl5
	fPo5K30KrqinKLSXskK6smRmLbfp8zNhL5CJpcOHRsf07+0lAaAzZKzw33IqGlFKEN+9TL48WDQ
	==
X-Gm-Gg: AYBFou1arQ1deBvDvYS25MipgjTJl8V515Q/64N+0ojttfdboPnfAU8IgSAvnnxTdXD
	RnZezFgoXR8s2npO1D/GupMuuqoQ6+eW48mhv/oto/9a7wDOoyEoRv8a3yrioyQZCrULit0j0PR
	vxZ0SbvnEW611Ijc1R527nrLmZcF3GhcfVzlL7jmO2bFoA5PwUejVPTxtLBL7OAmII7+gi4ki+J
	otAU+TsZYfk1j4K6AqZKm0N8QdYl/0jrzqoX57A5hqI4n8xakYALDA0X1gSJ1J7zhk5470vGho+
	QFzwYn9FD59UIY6CcGup9gstQzAMVpPMjFTII64Agzal1up3rR8wzvCzAwu4y3vIkHssYXarfwE
	fFnLbEO3i8XPjWd6f9d1DGETjEwhGPZtQRy/4L9d9lq9zRK6e/81DMkRE878u2ZAhW8SxL3VHLZ
	St1irVynb1Lnvb0Q7swmYQbAIM2i4H
X-Received: by 2002:a05:6830:4424:b0:85e:f82d:436a with SMTP id 46e09a7af769-862898a0046mr1343804a34.5.1794552074668;
        Thu, 12 Nov 2026 22:41:14 -0800 (PST)
X-Received: by 2002:a05:6830:4424:b0:85e:f82d:436a with SMTP id 46e09a7af769-862898a0046mr1343794a34.5.1794552074096;
        Thu, 12 Nov 2026 22:41:14 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:13 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 05/10] tracing/osnoise: Per-cpu mutexes and fd detachment
Date: Fri, 13 Nov 2026 00:40:58 -0600
Message-ID: <20261113064103.3041704-6-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113064103.3041704-1-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KD2aLoPEIc_4W1POxAj_4zMr1lx4hDedOyIsCFktIww_1794552075
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

v5:
 - Fix some patch-shuffling bugs in timerlat_fd_detach() that were previously
   undone by the reset patch.

v6:
 - Move migration checks after the detach lock
 - Clear osn->sampling on signal exit.  It's not expected that the signal will
   be non-fatal given the limited use case, but this gives somewhat more reasonable
   behavior if it does get restarted.  Or do we want to fail more noisily
   in that case?
 - Remove detachment language from user doc that doesn't apply in all scenarios

v7:
 - Remove the uthread_migrate setting from timer_fd_read() which seems
   redundant with trace_sched_migrate_callback(), and complicates the
   locking.
 - Clear tlat->tracing_thread on abnormal timerlat_fd_read() exit
 - Use WARN_ON_ONCE consistently
---
 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 326 +++++++++++++++---------
 2 files changed, 203 insertions(+), 128 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index 68d429d454a5..e23467376ff5 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -220,8 +220,9 @@ After reporting the total latency, timerlat will restart the cycle, arm
 a timer, and go to sleep for the following activation.
 
 If at any time one of the conditions is broken, e.g., the thread migrates
-while in user space, or the timerlat tracer is disabled, the SIG_KILL
-signal will be sent to the user-space thread.
+while in user space, or the timerlat tracer is disabled, subsequent usage
+will fail with EINVAL.  Note that older kernels may deliver a SIGKILL
+instead.
 
 Here is an basic example of user-space code for timerlat::
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7b343f47cf2f..e61f57230eef 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -223,19 +223,30 @@ struct osn_thread {
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
@@ -266,12 +277,25 @@ static struct mutex interface_lock;
  * Runtime information for the timer mode.
  */
 struct timerlat_variables {
-	struct task_struct	*thread;
-	struct hrtimer		timer;
-	u64			abs_period;
-	bool			tracing_thread;
-	u64			count;
-	bool			uthread_migrate;
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
+		struct task_struct	*thread;
+		struct hrtimer		timer;
+		u64			abs_period;
+		bool			tracing_thread;
+		u64			count;
+		bool			uthread_migrate;
+		bool			detach;
+	);
 };
 
 static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
@@ -302,26 +326,20 @@ static inline void tlat_var_reset(void)
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
@@ -341,7 +359,10 @@ static inline void osn_var_reset(void)
 	 */
 	for_each_online_cpu(cpu) {
 		osn_var = cpu_osn_var(cpu);
-		memset(osn_var, 0, sizeof(*osn_var));
+
+		WARN_ON_ONCE(osn_var->kthread);
+		WARN_ON_ONCE(osn_var->fdd);
+		memset(&osn_var->zero, 0, sizeof(osn_var->zero));
 	}
 }
 
@@ -1884,10 +1905,18 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -1961,7 +1990,9 @@ static int timerlat_main(void *data)
 		wait_next_period(tlat);
 	}
 
+	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
 	hrtimer_cancel(&tlat->timer);
+	tlat->thread = NULL;
 	migrate_enable();
 	return 0;
 }
@@ -1977,32 +2008,24 @@ static int timerlat_main(void *data)
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
+		WARN_ON_ONCE(test_bit(OSN_WORKLOAD, &osnoise_options));
+		WARN_ON_ONCE(osn_var->kthread);
+		osn_var->fdd->detach(osn_var->fdd);
+	} else if (osn_var->kthread) {
+		WARN_ON_ONCE(!cpumask_test_and_clear_cpu(cpu, &kthread_cpumask));
+		WARN_ON_ONCE(!test_bit(OSN_WORKLOAD, &osnoise_options));
+		kthread_stop(osn_var->kthread);
+		put_task_struct(osn_var->kthread);
+		osn_var->kthread = NULL;
 	}
+
+	osn_var->sampling = false;
+	mutex_unlock(&osn_var->lock);
 }
 
 /*
@@ -2032,16 +2055,20 @@ static int start_kthread(unsigned int cpu)
 	struct task_struct *kthread;
 	void *main = osnoise_main;
 	char comm[24];
+	int ret = 0;
+
+	lockdep_assert_held(&trace_types_lock);
+	mutex_lock(&osn->lock);
 
 	/* Do not start a new thread if it is already running */
 	if (osn->kthread)
-		return 0;
+		goto out;
 
 	/* Can still happen with timerlat via cpu hotplug */
 	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 		if (!timerlat_enabled())
 			osn->sampling = true;
-		return 0;
+		goto out;
 	}
 
 	if (timerlat_enabled()) {
@@ -2055,7 +2082,8 @@ static int start_kthread(unsigned int cpu)
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	get_task_struct(kthread);
@@ -2063,7 +2091,9 @@ static int start_kthread(unsigned int cpu)
 	cpumask_set_cpu(cpu, &kthread_cpumask);
 	wake_up_process(kthread);
 
-	return 0;
+out:
+	mutex_unlock(&osn->lock);
+	return ret;
 }
 
 /*
@@ -2089,15 +2119,8 @@ static int start_per_cpu_kthreads(void)
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
+		WARN_ON_ONCE(cpumask_test_cpu(cpu, &kthread_cpumask));
 
 	for_each_cpu(cpu, current_mask) {
 		retval = start_kthread(cpu);
@@ -2417,11 +2440,46 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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
+	if (WARN_ON_ONCE(fdd != osn->fdd))
+		return;
+
+	WARN_ON_ONCE(osn->kthread);
+	WARN_ON_ONCE(fdd->thread != tlat->thread);
+	tlat->detach = true;
+	wake_up_process(tlat->thread);
+
+	mutex_lock(&tlat->detach_lock);
+
+	osn->sampling = 0;
+	osn->pid = 0;
+
+	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
+	hrtimer_cancel(&tlat->timer);
+	put_task_struct(fdd->thread);
+
+	fdd->thread = NULL;
+	osn->fdd = NULL;
+	memset(&tlat->zero, 0, sizeof(tlat->zero));
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
 
@@ -2437,16 +2495,16 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	migrate_disable();
 
 	osn_var = this_cpu_osn_var();
+	tlat = this_cpu_tmr_var();
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
@@ -2455,33 +2513,47 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
 
+	tlat->tracing_thread = false;
+	tlat->thread = current;
 	get_task_struct(current);
 
-	osn_var->kthread = current;
 	osn_var->pid = current->pid;
+	osn_var->fdd = fdd;
+
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 
 	/*
 	 * Setup is done.
 	 */
+	mutex_unlock(&osn_var->lock);
 	mutex_unlock(&interface_lock);
 
-	tlat = this_cpu_tmr_var();
-	tlat->count = 0;
-
-	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-
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
@@ -2497,36 +2569,28 @@ static ssize_t
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
 
 	tlat = this_cpu_tmr_var();
+	osn_var = this_cpu_osn_var();
 
-	/*
-	 * While in user-space, the thread is migratable. There is nothing
-	 * we can do about it.
-	 * So, if the thread is running on another CPU, stop the machinery.
-	 */
-	if (cpu == smp_processor_id()) {
-		if (tlat->uthread_migrate) {
-			migrate_enable();
-			return -EINVAL;
-		}
-	} else {
-		cpu_tmr_var(cpu)->uthread_migrate = 1;
-		osnoise_taint("timerlat user thread migrate\n");
-		osnoise_stop_tracing();
-		migrate_enable();
-		return -EINVAL;
+	/* In normal usage, this should always be uncontended. */
+	mutex_lock(&tlat->detach_lock);
+	if (fdd != osn_var->fdd || current != fdd->thread ||
+	    tlat->uthread_migrate) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	osn_var = this_cpu_osn_var();
+	WARN_ON_ONCE(fdd->cpu != smp_processor_id());
 
 	/*
 	 * The timerlat in user-space runs in a different order:
@@ -2562,9 +2626,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			}
 		}
 	} else {
-		tlat->tracing_thread = false;
-		tlat->thread = current;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 
@@ -2572,7 +2633,21 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	}
 
 	/* wait for the next period */
-	wait_next_period(tlat);
+	if (wait_next_period(tlat) < 0) {
+		if (signal_pending(current))
+			ret = -ERESTARTSYS;
+		else
+			ret = -EINVAL;
+
+		tlat->tracing_thread = false;
+		osn_var->sampling = false;
+		goto out;
+	}
+
+	if (WARN_ON_ONCE(fdd != osn_var->fdd)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* This is the wakeup from this cycle */
 	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
@@ -2599,39 +2674,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
-
-	osn_var = cpu_osn_var(cpu);
-	tlat_var = cpu_tmr_var(cpu);
+	osn_var = cpu_osn_var(fdd->cpu);
 
-	if (tlat_var->thread)
-		hrtimer_cancel(&tlat_var->timer);
-	memset(tlat_var, 0, sizeof(*tlat_var));
+	mutex_lock(&osn_var->lock);
+	if (fdd == osn_var->fdd)
+		timerlat_fd_detach(fdd);
+	mutex_unlock(&osn_var->lock);
 
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
-
-	mutex_unlock(&interface_lock);
-	migrate_enable();
+	kfree(fdd);
 	return 0;
 }
 #endif
@@ -3146,6 +3206,14 @@ static struct tracer timerlat_tracer __read_mostly = {
 
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
@@ -3157,10 +3225,16 @@ __init static int init_timerlat_tracer(void)
 
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
2.56.0

