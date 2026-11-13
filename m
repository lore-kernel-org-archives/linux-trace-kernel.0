Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552080;
	b=ZnyUR2Th+ljbYQeOI1cc/Aa0uTfFKyfVvyMYGPReEk63yZTmgR+p7z1sIiuzRd96kQiM
	 140SRAPhMOxQrJx2joBjhBcvqZfuiVQAVhI3+BnpwUgyPaAw7UdRrwfE61/euLcqIEUPF
	 2uKNxXkDRq9Edl7W75cTAYQcQI8mckxAIqiMFaKssRGl1g16fkHk2l7cOB16fT6O/JQA4
	 PrCWT2PxMKKwz7yUOf3eky7qd3ot/mZD8HiukGCWE7Beg/w1tsg7ptXr4Uz3BwyBY2Yir
	 UdKCqJoJs22XZmmP5lZiHaNQszBVdxYnQXUkAmJb8/VMdwz6qpeFLBpQLljLXTqSX+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552080;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=ulyNEHI0NfvAmJM2VicEHDkL7u4WeoOuQtnZDofp7x4=;
	b=1LKgpaNWilnl4oLoJrF6yKLubkXFSrnO4ZlGfLIDOLyghlmrhL93fRY1+4t7ogf382xQ
	 g0t2whNgzTEUJP0IJTScdczF9V38bgcHsGHNwFItmwdkE2X58zpGJa1UTtMVsaABffzwD
	 MS0oQIF+JH5gnkpipmFd3LJ9nKR33YQh3KuxXTKllgdmvAeNY+tVGVgbo01tXr6LrpNeP
	 GyZMy1u1NoeytzIsCkoSa3cC2WV8ha3gCpSZbmSa/7JESQPd+iDXgqZzB8IkwSDWGqvR2
	 zBfOyYFYBVSJLjhspe3Ez1hxzjyCRN9cYZOUidz9M2fZTKssbJsZY5kg9qRCrAOv6dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Td+OY17b;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3B606A338
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE3B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Td+OY17b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulyNEHI0NfvAmJM2VicEHDkL7u4WeoOuQtnZDofp7x4=;
	b=Td+OY17bIcxW7u6l2xPZ7/2L4PgXDrWAhKc+vRu2Tv1WS+pW+xtRUS18S796jEcrsYd4Sr
	UJrTGkHP2SrUudH1DOm7s4VuSyCQMRRIUOkH9yrTNz1hoPT7qfBatq7J9JBFA+RmkL+K/L
	7Lh4YdAaN2XdRhKN62edwR/WfsrACOw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1xpNIfUcMn-luyNlA4KJiw-1; Fri, 13 Nov 2026 01:41:10 -0500
X-MC-Unique: 1xpNIfUcMn-luyNlA4KJiw-1
X-Mimecast-MFC-AGG-ID: 1xpNIfUcMn-luyNlA4KJiw_1794552070
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8615cc92488so592992a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552070; x=1795156870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ulyNEHI0NfvAmJM2VicEHDkL7u4WeoOuQtnZDofp7x4=;
        b=eI3iWUC6Rw3Qxf2P/qX8MkgpTlCXv1XYX/E+TIYCQX/Vqox/wwy/LU9SFg0ddiug3F
         2B5IRokbijw4JYKB6WX8MYC7G8ZAnybpCl+r0hMCU9HcaanFi5E3IguAWM4ppe3GkCQU
         uk7P8t/7+K9CvmUQD5kf3cf2wFG330CJl2nuAFjmwGwjyNTCb/8AY9uND7MK0CM+Cy1w
         fI922ehmjQkspYxjs208112i9X89RkoQTYd+0YcqiYJ/NcYff78KTPDbKpW8dvmMgwuZ
         kf3MbmPm/9MvMb0xtF2Ov65sZmKJiEitQFG77i1terejoia3rjA3lc44zCcWoyHKwK2k
         4+Ug==
X-Forwarded-Encrypted: i=1; AL+hErGEl67nUTZbLLjpnGQwRs2/yyaV8fH83MMRwspWb+9Xto/c64Iv1qotuREvYQTRIavpVdfSlqwzfHwOh17WE3uaYho=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9ZZbfxXqjqheaQgaDoxlRo4VQmoYsgBf7FoB5lZW3JNCVzO4c
	cJF7kda5mi4c3u9zZ2/JFRz2ddJJecjTHjoaz+QAeWF//gK+dVw59QCRt7tQ9OysuPe10MtYEGX
	V69kyNfe8fyYfviUc0bWYo8ygmN9RDrJHqOfJlMDrkXA2uMptgLXpK5pcCp5yRBl7Vx1yi4AQGw
	==
X-Gm-Gg: AYBFou1uidVpzzV8Xbna/grK99kJY1mcm25Nnxk/649CIMBx5PidphifqpO1fXihR1k
	OuopP5lZ5Y91k5AhQOeWBVy/XDD4y9NuncSFErdjy1LpNygLCx9vD6OVbPrH2+blfxJDd+jENKO
	MEhKGde8hRiYhqAgfRqBls8/wEl9khWmpQ7KGSLIYYaTLxiShXdJdzRKuaM2PfxEuAE+qg0FB9x
	V3+s+XxQ7TF1ul+lEtcM/3hnrkqwOdDkvTSTTxIsm5dcv5SNDlpWsPuLkbHLua/zViW7+63AEqC
	fgP6QHSv02jVSGilxUe/ltusjWeTD3z8JRpGRi3KCKpYbW7A8yLzVSLSKnAAvHkub4G1IgO9Ym3
	MhYAm0Cbq5gvWKPusCmSz/B7iGca/lxqTGGmM/gTfT2x5Tpwy57QyEeFGULZKiTW3NpZCl9Q8vv
	PL1HzHTI+7dc4Ow3PMyiggk9sNdZEj
X-Received: by 2002:a05:6808:1527:b0:4a3:3108:866a with SMTP id 5614622812f47-56e637950e9mr1418828b6e.17.1794552069727;
        Thu, 12 Nov 2026 22:41:09 -0800 (PST)
X-Received: by 2002:a05:6808:1527:b0:4a3:3108:866a with SMTP id 5614622812f47-56e637950e9mr1418814b6e.17.1794552069298;
        Thu, 12 Nov 2026 22:41:09 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:08 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 01/10] tracing/osnoise: Variable cleanup
Date: Fri, 13 Nov 2026 00:40:54 -0600
Message-ID: <20261113064103.3041704-2-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: szRIH-OzOSd-zmPMDwZxTDqgLZ-SlEsFc4CghZdyMo8_1794552070
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add cpu_osn_var/cpu_tmr_var() accessors and use them.

Timerlat threads aren't always kthreads, so rename the variable to just
"thread".

rel_period isn't used at all, so remove it.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v7: Add osn variable to start_kthread(), replacing individual calls to
    cpu_osn_var(), which previously happened later in the patch set.
    This avoids a temporary build break in the next patch.
---
 kernel/trace/trace_osnoise.c | 54 +++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 995da9e0b548..2f3cbe71d313 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -251,6 +251,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
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
@@ -261,9 +266,8 @@ static struct mutex interface_lock;
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
@@ -285,6 +289,11 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
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
@@ -301,8 +310,8 @@ static inline void tlat_var_reset(void)
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
@@ -331,7 +340,7 @@ static inline void osn_var_reset(void)
 	 * zeroing the structure is perfect.
 	 */
 	for_each_online_cpu(cpu) {
-		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+		osn_var = cpu_osn_var(cpu);
 		memset(osn_var, 0, sizeof(*osn_var));
 	}
 }
@@ -1227,9 +1236,9 @@ static void trace_sched_migrate_callback(void *data, struct task_struct *p, int
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
@@ -1827,13 +1836,13 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
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
@@ -1926,7 +1935,7 @@ static int timerlat_main(void *data)
 	tlat->tracing_thread = false;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->kthread = current;
+	tlat->thread = current;
 	osn_var->pid = current->pid;
 	/*
 	 * Annotate the arrival time.
@@ -1981,7 +1990,7 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
+	kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
 	if (kthread) {
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
@@ -2001,7 +2010,7 @@ static void stop_kthread(unsigned int cpu)
 			/*
 			 * This is set in the osnoise tracer case.
 			 */
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
+			cpu_osn_var(cpu)->sampling = false;
 			barrier();
 		}
 	}
@@ -2030,12 +2039,13 @@ static void stop_per_cpu_kthreads(void)
  */
 static int start_kthread(unsigned int cpu)
 {
+	struct osnoise_variables *osn = cpu_osn_var(cpu);
 	struct task_struct *kthread;
 	void *main = osnoise_main;
 	char comm[24];
 
 	/* Do not start a new thread if it is already running */
-	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+	if (osn->kthread)
 		return 0;
 
 	if (timerlat_enabled()) {
@@ -2044,7 +2054,7 @@ static int start_kthread(unsigned int cpu)
 	} else {
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = true;
+			osn->sampling = true;
 			barrier();
 			return 0;
 		}
@@ -2058,7 +2068,7 @@ static int start_kthread(unsigned int cpu)
 		return -ENOMEM;
 	}
 
-	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	osn->kthread = kthread;
 	cpumask_set_cpu(cpu, &kthread_cpumask);
 
 	return 0;
@@ -2091,7 +2101,7 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
+			kthread = xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
@@ -2520,7 +2530,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			return -EINVAL;
 		}
 	} else {
-		per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
+		cpu_tmr_var(cpu)->uthread_migrate = 1;
 		osnoise_taint("timerlat user thread migrate\n");
 		osnoise_stop_tracing();
 		migrate_enable();
@@ -2564,7 +2574,7 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		}
 	} else {
 		tlat->tracing_thread = false;
-		tlat->kthread = current;
+		tlat->thread = current;
 
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
@@ -2613,10 +2623,10 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
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
 
@@ -3096,7 +3106,7 @@ static void timerlat_tracer_stop(struct trace_array *tr)
 	 */
 	if (!osnoise_has_registered_instances()) {
 		for_each_online_cpu(cpu)
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = 0;
+			cpu_osn_var(cpu)->sampling = 0;
 	}
 
 	osnoise_workload_stop();
-- 
2.56.0

