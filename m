Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7E372B3C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944826; cv=none; b=uaI5H19sGKS/g/vMOmUP9b/gUIIMKutwxvxX0MI6uM39WsJHQ1S4l+5TMPy8BjwtjkCS0nWxHfzL++aLCTr/dcKovd5LIShcY8vjRS50jju4BmgADhHC0pOrElrs/QBApncsj9sRWhuuFkBq8r4PkgOsCgmJawZWZqWIUlGFEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944826; c=relaxed/simple;
	bh=R1BMqtqeX+DKZ3YLNbQBNy8jwf/bhIzP7JA2VunWjTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pYS8vXt0DpJwnn9dr4rb46C0WH9FOPdfUdSNVYr7NNHCzGQgE+FKz3sc+/6l9qZ4rLRKCf8W+6OI2eImLvbBLYOyLuXke8qhZOs9D0eIrpUq9uKoPoNfaLG8j8rgOf2baHeRvplJMfAQ5rq4Gh8xn5FmUIpsh9Q0X2lBriqjNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbLnwMfI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbLnwMfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=ZbLnwMfIJqLjj4bPCJ2BsHko+b9O8R7ODJIY3YnnkSoox910Y8raO6/avDtguEvtEM/mlk
	tJj6KuUdKTOjOFMCzp1sq3ZZJUHF/2WNyElTOE5pnXm/dcZXJxwp8mT4G0/y24rfLGq/hN
	yEdVNHIeBU6HRpj24ynBxNELxOUSBH4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-o5todptvPZ-fmh_Pn00XKQ-1; Wed, 14 Oct 2026 02:26:58 +0000
X-MC-Unique: o5todptvPZ-fmh_Pn00XKQ-1
X-Mimecast-MFC-AGG-ID: o5todptvPZ-fmh_Pn00XKQ_1791944818
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91785bd637bso121059856d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944818; x=1792549618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
        b=vLEAEWpowyzi/W3Y1jg5dum4EoYqhObyhgJCe6PHlYVvTZ/XOSZcVgsYa7s3AQmyCc
         tIEMP27Jyol5E/rU8i8VR2HqjvUoTf93Y2vgEvMLdoTHjZB3ngSXCKs/MPodFdYGydkX
         O2LmhfJU+HOOQqBjDpbDsBW3kfRQFm4eZMV1MHzfgFGd2KIke4rh8AxtSU4J6cfiTUw7
         +aDzG6uu9L1ruF5YQeGps3Z2pzLHTjVdgn66Fb7pMdjJwz57mUsfPnTfjkgBkAUTBfef
         oJ3gWyMQSXeWnUg3OsVl6g6r+N+SxKrCw2SQucaTEvQt+Y+mKfv3bJUZlKJV32mXCV4N
         koRQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4dZqSxrgA08p8anEmojRGltMkbu+tImS4NS6Lhs3AqvCw1WVFBm9y6cyMHOYVKdm6uVWVmMJuibzOorOj/nPPAVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLr0IrVruOzWHpV9e4tZPCwrOKx8pBBo/qxS8E4/7nv1s6OW60u
	tVJ3W7Vnl3vhKrlQY2lzckW+Ln8UkvlfBUu+SvQ35xI823IMUXnhLbHQ1lhWamaAKCPAA6jc6rz
	WuDVKEKgzbU5Z6rCoeU6UnZ+3h4uaFeDlOSFiNTrql0bo+T8TnnwJSA00wW05WArW+DkXnd2Jdw
	==
X-Gm-Gg: AYBFou2GDftmTNI1oyEriIs04QljcRBKL/086gxaYP557bkyUXcHJQjHBg/0gTzOeEo
	wEqmifTOFHbLc/41n7ZZpiiLwX4TIOpD5D8ohFt9jsJCph7h5vIsVCrl11xa1rERcMGmRh4P6rM
	+jDFZXsbuPTPthN2Igpw+d+PkzwB7v46KyubJ1LodfnIaT7f5hpRfXSjaxvN6TMF8Fh5Jo1KEQH
	00XYU9y5+iC8Sp7dhMoHI17JfQkz2vrUjhSs9QaRhjdCH3cgqlMkrMHjzM/sTRN9f6lsfaa0BDP
	Xatl6DXAUTEpnSj80W9B6Fz4PwsyCrOe+pFdP0G6MGy/FN7ApBplHm+6NrwhzwyIdkTtUTYlkdi
	Z+FfYAD5r6vUFT9hhZCZaA8KAmqymwGRHw1sHHrKNv3MkcJFYHR7Ofe8=
X-Received: by 2002:a05:6214:4586:b0:917:b333:e555 with SMTP id 6a1803df08f44-91b557994ccmr231191716d6.46.1791944817546;
        Tue, 13 Oct 2026 19:26:57 -0700 (PDT)
X-Received: by 2002:a05:6214:4586:b0:917:b333:e555 with SMTP id 6a1803df08f44-91b557994ccmr231191526d6.46.1791944817075;
        Tue, 13 Oct 2026 19:26:57 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:26:56 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 1/9] tracing/osnoise: Variable cleanup
Date: Tue, 13 Oct 2026 21:26:32 -0500
Message-ID: <20261014022640.695786-2-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: I-oyDRajNae6oTIc4dFBJR_Z5hyD8GveRN7RT9lKi4M_1791944818
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add cpu_osn_var/cpu_tmr_var() accessors and use them.

Timerlat threads aren't always kthreads, so rename the variable to just
"thread".

rel_period isn't used at all, so remove it.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: new patch
---
 kernel/trace/trace_osnoise.c | 53 +++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0e1265acd1cc..953936bd5eec 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -250,6 +250,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
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
@@ -260,9 +265,8 @@ static struct mutex interface_lock;
  * Runtime information for the timer mode.
  */
 struct timerlat_variables {
-	struct task_struct	*kthread;
+	struct task_struct	*thread;
 	struct hrtimer		timer;
-	u64			rel_period;
 	u64			abs_period;
 	bool			tracing_thread;
 	u64			count;
@@ -284,6 +288,11 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
+static inline struct timerlat_variables *cpu_tmr_var(int cpu)
+{
+	return per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+}
+
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
@@ -300,8 +309,8 @@ static inline void tlat_var_reset(void)
 	 * zeroing the structure is perfect.
 	 */
 	for_each_online_cpu(cpu) {
-		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
-		if (tlat_var->kthread)
+		tlat_var = cpu_tmr_var(cpu);
+		if (tlat_var->thread)
 			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
@@ -330,7 +339,7 @@ static inline void osn_var_reset(void)
 	 * zeroing the structure is perfect.
 	 */
 	for_each_online_cpu(cpu) {
-		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+		osn_var = cpu_osn_var(cpu);
 		memset(osn_var, 0, sizeof(*osn_var));
 	}
 }
@@ -1226,9 +1235,9 @@ static void trace_sched_migrate_callback(void *data, struct task_struct *p, int
 	struct osnoise_variables *osn_var;
 	long cpu = task_cpu(p);
 
-	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+	osn_var = cpu_osn_var(cpu);
 	if (osn_var->pid == p->pid && dest_cpu != cpu) {
-		per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+		cpu_tmr_var(cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user-thread migrated\n");
 		osnoise_stop_exception("timerlat user-thread migrated", cpu);
 	}
@@ -1826,13 +1835,13 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
-			wake_up_process(tlat->kthread);
+			wake_up_process(tlat->thread);
 
 			return HRTIMER_NORESTART;
 		}
 	}
 
-	wake_up_process(tlat->kthread);
+	wake_up_process(tlat->thread);
 
 	if (osnoise_data.print_stack)
 		timerlat_save_stack(0);
@@ -1925,7 +1934,7 @@ static int timerlat_main(void *data)
 	tlat->tracing_thread = false;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->kthread = current;
+	tlat->thread = current;
 	osn_var->pid = current->pid;
 	/*
 	 * Annotate the arrival time.
@@ -1980,7 +1989,7 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
+	kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
 	if (kthread) {
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
@@ -2000,7 +2009,7 @@ static void stop_kthread(unsigned int cpu)
 			/*
 			 * This is set in the osnoise tracer case.
 			 */
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
+			cpu_osn_var(cpu)->sampling = false;
 			barrier();
 		}
 	}
@@ -2034,7 +2043,7 @@ static int start_kthread(unsigned int cpu)
 	char comm[24];
 
 	/* Do not start a new thread if it is already running */
-	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+	if (cpu_osn_var(cpu)->kthread)
 		return 0;
 
 	if (timerlat_enabled()) {
@@ -2043,7 +2052,7 @@ static int start_kthread(unsigned int cpu)
 	} else {
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = true;
+			cpu_osn_var(cpu)->sampling = true;
 			barrier();
 			return 0;
 		}
@@ -2057,7 +2066,7 @@ static int start_kthread(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	cpu_osn_var(cpu)->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
 
 	return 0;
@@ -2090,7 +2099,7 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
+			kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
@@ -2519,7 +2528,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			return -EINVAL;
 		}
 	} else {
-		per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+		cpu_tmr_var(cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user thread migrate\n");
 		osnoise_stop_tracing();
 		migrate_enable();
@@ -2563,7 +2572,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		}
 	} else {
 		tlat->tracing_thread = false;
-		tlat->kthread = current;
+		tlat->thread = current;
 
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
@@ -2612,10 +2621,10 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	migrate_disable();
 	mutex_lock(&interface_lock);
 
-	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
-	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+	osn_var = cpu_osn_var(cpu);
+	tlat_var = cpu_tmr_var(cpu);
 
-	if (tlat_var->kthread)
+	if (tlat_var->thread)
 		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
@@ -3095,7 +3104,7 @@ static void timerlat_tracer_stop(struct trace_array *tr)
 	 */
 	if (!osnoise_has_registered_instances()) {
 		for_each_online_cpu(cpu)
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = 0;
+			cpu_osn_var(cpu)->sampling = 0;
 	}
 
 	osnoise_workload_stop();
-- 
2.54.0

