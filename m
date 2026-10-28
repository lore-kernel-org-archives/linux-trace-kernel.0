Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224896;
	b=N4QweKC8nTqWgbwBpZAymiHr3DOVjonwiT63ysm41s6TSOxYwMM5vHy/ho//QQQs4Vg5
	 vTXrCQBaCorMMeAO+ulf8TUGJGv7Velgg35PH8dgK8h6q7YtmfHaU8ghIDtWplIJ78eox
	 ilIg9PGL50C9cv0lMUnfuSZ6o4g6K0rVwTEuz0B7BQ7eUSfuE+3HUfRva57t5nvqS8hmo
	 SQYRLRZjWuJtflg0DyWrAXyYcYZuN+DeX4vavvVMiNKpUB8FcytOOIDT8OtFhRCCQub/8
	 mDdmBWMvsjC+4k2Ar9ApVy3WXC4g8lckuC37imRwdmIYgRKeVFyEjOpqdyP0odBh9aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224896;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=q1u+4N7OmlKTxwqTWSfowvESBZ9aUrQIIvPHMyv6gYM=;
	b=ig/UhOGtAQOkb5HQUY5ubl+es3pXZY2mwTIuwvWiae0RZ7Scx9mbcEX2CYAp2RQr5dU8
	 5+NBRn9UUSg6dT97saZeOg/wpM9gwURjRF+If1+UvhyZLoZy8cp4zZasUGC/SDKubhbrK
	 w6PM4XZbhZC3oFGHWeqzV61XFGLYlN2MrNLJO2KTbmKKZrgdGE3Tv4UYAYcJYsZN076Bg
	 lIsKDscQsqIFnJLALLznKuM3HE4hi3+Vox+YRDA2rNQgwsyv4AHQ4H2pqUTAIOIWTaOBc
	 DsiKEtrYg37dpggZev1AeIRYywq1E0kzThgb+Qkwq9dlju3PpnTQ71ycnSrJr/m3Qpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHhH45Mx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07B606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF07B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHhH45Mx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1u+4N7OmlKTxwqTWSfowvESBZ9aUrQIIvPHMyv6gYM=;
	b=NHhH45Mx2rWCS5iRKLuWmdoC/sgZz37tutP5srJE/d3/3BidQiTvKPSlbj5QxnSXtKbZGh
	2zRNOATYONgBHiIu3pzV0k1qBZxL7qGzV9Uep2fyWl3SZtpUXnh+Mxmhw+ki+IrykOlPgd
	7L2y7jH75dDgxEFTglbu+BV2KKa4wE8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Mq4YP1LwPbynighnHKPo6Q-1; Wed, 28 Oct 2026 18:01:33 -0400
X-MC-Unique: Mq4YP1LwPbynighnHKPo6Q-1
X-Mimecast-MFC-AGG-ID: Mq4YP1LwPbynighnHKPo6Q_1793224893
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338974c0ceso9873441cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224893; x=1793829693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1u+4N7OmlKTxwqTWSfowvESBZ9aUrQIIvPHMyv6gYM=;
        b=RuCb2IwREjrCh+lEg7VZiC4Baa1J+2sjNYyJTKNuYw/uG07dMIwf5XZ9ORPnr5TqcW
         mTX5VR7SxQ+6N001BTeFtuq3YizlgeBbuCF7Y7EXl608zSIP+NG7GURIDhCqL8ssAo+g
         Nrf++ty6HyVYJ1vV4QGNkeP0ieVYd4NCaMqqcUn8ItKQXbdu/cO1WRzKmjtmzFkS/NBj
         aExnR/EacQVogmektBfdYFBjNUhqydS/2joVX/Odp41rbAa9VNH1J5QvHjROJ8TYH1dS
         x+51+eoRga76Ip0xTChODUd4RxxwiGd+2J0IqsqvitkM2Q5ED65JGUGoSxTRP8CaT531
         LOVw==
X-Forwarded-Encrypted: i=1; AKwUvBz5VEZDFavkM0okaBnKi02AByl5q9/WjGHfkfxVb0U+wYDZAQJm0NvoFDD50CELyaIJtgqPaeW2aUzTc3mlqvycDOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+/P85W/Sdu9et7Sk9L4YALQa5tRWbmGMet+dn3Blb8X+OnZ1A
	A+SV/naXKmSbiIPAInid1gtv/UhHsBD5ztjO+jLrj+xt0o5AJobQLL/rZe7pJVrflFFNAGJYlpU
	LzQ7vzy7/9jyGEt7mkgVQFPyHyMQjjK95e5xHtNNgv+oyMxW1ygncLym8NGAEsuTJ8caZM53hMQ
	==
X-Gm-Gg: AYBFou0/itoVArBV65HejFNMHqAZJZNntP5tLOUbc/ADipuhI2wz7NK+s1NnPJcK6qf
	fW2KbgeqdF8VRAwf1A3UOY5dvQC3kE5AEm7N0gTPUVy+wfqd54svR1hrOWGJ5MfdTHt152DO0Zk
	AAyNt2BpM8HSO2QVcvf/mp2IofIghpCBm42W36C6hP7LZ8jQl7MKTLH4M9xCvjm/ply20Ziobve
	tbRThJm2rJiGN1CH6crNnBrEsx9VJYAUEBHUDhk17XWKgSZyQ3d2+qxLbj5UhsdqYd4p16sGg/K
	Ycyv/GFZ5QaVNp2Ekshn+zTJPNOAM7vDH5e2XrE1YVkMXhUJlu5BJZbWbctFiq4bSkaL5XE50k0
	m3tqGjw+tlAaN7N5GjbGy62t/D5hh+HZJ/j7ovx4Lj/780ItSW0dfcZn+LUj2/AzNmAqZeysihX
	1pMVEgSNcFTO5OuVR13drJLSqrpAXI
X-Received: by 2002:a05:622a:1810:b0:535:a5f7:d593 with SMTP id d75a77b69052e-53fcda67a5dmr65809851cf.77.1793224892064;
        Wed, 28 Oct 2026 15:01:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1810:b0:535:a5f7:d593 with SMTP id d75a77b69052e-53fcda67a5dmr65809101cf.77.1793224891390;
        Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 05/10] tracing/osnoise: Per-cpu mutexes and fd detachment
Date: Wed, 28 Oct 2026 17:01:15 -0500
Message-ID: <20261028220120.4005187-6-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028220120.4005187-1-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: KyYK3nL_zMZuzFDlB8h1TzAwSD7Dhi7TI83_cynCBZ0_1793224893
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
---
 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 320 +++++++++++++++---------
 2 files changed, 209 insertions(+), 116 deletions(-)

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
index 5a2294e9c70a..ce6d02346ea4 100644
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
@@ -265,12 +276,25 @@ static struct mutex interface_lock;
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
@@ -301,26 +325,20 @@ static inline void tlat_var_reset(void)
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
@@ -340,7 +358,10 @@ static inline void osn_var_reset(void)
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
 
@@ -1883,10 +1904,18 @@ static int wait_next_period(struct timerlat_variables *tlat)
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
@@ -1960,7 +1989,9 @@ static int timerlat_main(void *data)
 		wait_next_period(tlat);
 	}
 
+	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
 	hrtimer_cancel(&tlat->timer);
+	tlat->thread = NULL;
 	migrate_enable();
 	return 0;
 }
@@ -1976,32 +2007,24 @@ static int timerlat_main(void *data)
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
@@ -2027,19 +2050,24 @@ static void stop_per_cpu_kthreads(void)
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
 
 	/* Can still happen with timerlat via cpu hotplug */
 	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 		if (!timerlat_enabled())
 			osn->sampling = true;
-		return 0;
+		goto out;
 	}
 
 	if (timerlat_enabled()) {
@@ -2053,15 +2081,18 @@ static int start_kthread(unsigned int cpu)
 
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
@@ -2087,15 +2118,8 @@ static int start_per_cpu_kthreads(void)
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
@@ -2415,11 +2439,46 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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
 
@@ -2435,16 +2494,16 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2453,24 +2512,35 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
 
 	/*
 	 * Setup is done.
 	 */
+	mutex_unlock(&osn_var->lock);
 	mutex_unlock(&interface_lock);
 
 	tlat = this_cpu_tmr_var();
@@ -2480,6 +2550,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 
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
@@ -2495,37 +2571,44 @@ static ssize_t
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
+
+	/* In normal usage, this should always be uncontended. */
+	mutex_lock(&tlat->detach_lock);
+	if (fdd != osn_var->fdd || current != fdd->thread) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/*
 	 * While in user-space, the thread is migratable. There is nothing
 	 * we can do about it.
 	 * So, if the thread is running on another CPU, stop the machinery.
 	 */
-	if (cpu == smp_processor_id()) {
+	if (fdd->cpu == smp_processor_id()) {
 		if (tlat->uthread_migrate) {
-			migrate_enable();
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	} else {
-		cpu_tmr_var(cpu)->uthread_migrate = 1;
+		cpu_tmr_var(fdd->cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user thread migrate\n");
 		osnoise_stop_tracing();
-		migrate_enable();
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	osn_var = this_cpu_osn_var();
-
 	/*
 	 * The timerlat in user-space runs in a different order:
 	 * the read() starts from the execution of the previous occurrence,
@@ -2560,9 +2643,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			}
 		}
 	} else {
-		tlat->tracing_thread = false;
-		tlat->thread = current;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 
@@ -2570,7 +2650,20 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 	}
 
 	/* wait for the next period */
-	wait_next_period(tlat);
+	if (wait_next_period(tlat) < 0) {
+		if (signal_pending(current))
+			ret = -ERESTARTSYS;
+		else
+			ret = -EINVAL;
+
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
@@ -2597,39 +2690,24 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
-
-	migrate_disable();
-	mutex_lock(&interface_lock);
-
-	osn_var = cpu_osn_var(cpu);
-	tlat_var = cpu_tmr_var(cpu);
 
-	if (tlat_var->thread)
-		hrtimer_cancel(&tlat_var->timer);
-	memset(tlat_var, 0, sizeof(*tlat_var));
+	osn_var = cpu_osn_var(fdd->cpu);
 
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
@@ -3144,6 +3222,14 @@ static struct tracer timerlat_tracer __read_mostly = {
 
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
@@ -3155,10 +3241,16 @@ __init static int init_timerlat_tracer(void)
 
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

