Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806985;
	b=4JPHW2kR2v2vSZUSWHzZT1k5QeSzN8H7ijg1XGtCDOkoOu13PA9nF4JMI4ur5WA3C4uI
	 2c3uuJETFTznwrrCfVQKtytRh9BaYHKckFAgaTlNKS8hzRl9QNshMmU7lAdf5uutHa3MJ
	 AVamBMbBp7tr/7Wo+C0fzq1bvSBmVpdxfGvIrpPWAs4QesLKSPDUcbAA4XjdeeKBRM/Kn
	 QFs1In642Rw/jgTw4x715f2HKrl7T0niixWV2TByUTVYQ8l+SjLsOf6DCnDEPPJG0W4VN
	 tV+RRzUhXMccuJ8EBM+zFlK3PZLAA5OYjd/9NmoP+qU9JFjO5a5m3PyNesdfeJGZsSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806985;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=KamQ5PMP6S22TZiiLVflx3wKF5v74jN2SSmYOkTILxGqCy0R27g3wBZrtdkjO9Yud0jn
	 0sE0GKPsWsEidk25tiDna5vNgRX1WZ5a/6kWFLNUyxxLO1hgNlismKhxAbD96ixWvrkgA
	 mSreJWORYlj1e018KaVr5UpCfiHF7rDKmZQZmE4byhWuzOTs0btH7OOCPuVwoFn5OcQnu
	 FGq+lZeAz7JyLXPrxRDLi9ArNk/TCuoyFYsyounOL5mem4669Aul5ikNnQXHqrAYH5RIB
	 GXvNayF753vW0SZxx1D5ZLt1qKOcQQLmkPaxWeeh1WLhvmFbE0G8a0YtIvFJ+Zbr7vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PrL94RL6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79140606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79140606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PrL94RL6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=PrL94RL6Vz9rPgxPSqj8F37j/v8BrQGBTqZMMtQKIPHGN8wyG8H86c3VMGW8x8EuvACTnd
	VXNawCrGEz2UE6BCojUyHDAoJAXzNbtfc3O+wBGwLF3RIW4C1NYK0pHqGASGSF798S2I2I
	Gt2LuIn5wL+IgWWdZPOU/amP9RMw+a0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-K7NICyWtN-arlEDPbnvRPg-1; Fri, 23 Oct 2026 21:56:22 -0400
X-MC-Unique: K7NICyWtN-arlEDPbnvRPg-1
X-Mimecast-MFC-AGG-ID: K7NICyWtN-arlEDPbnvRPg_1792806982
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c0f73807eso23024186d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806982; x=1793411782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
        b=jj7x2TlF/+Fl8On+0SV49KFigBKBXsKLVS8tbWDlQxZURr7xK6MOOLzV/TqqfoiP0U
         Xv0w+bCV/LDmYgbqlHEG28D5n3+P/3pff1XyKCxv/Eeb3eyKSnGSnzloVKmAPin/uHES
         xUGCvdQ40UFhjr41eUBHYjBVZQecpWIs7OorDrOUHPY2jXGOeOL1DbbdNZjtXAeg/IcG
         FfUh85Pkisc4KgaD8pGwb5XwFjUfxOskRhvTA+CQ2pAk/MlETFrKIDebD3q/wUbXj1QC
         pvk2kD/NzVMA1gMlU3VtmE1VurPZOyKTe3T9EjR8Z48FVwLrsleUfgYYos44TfF5J+4C
         2nuQ==
X-Forwarded-Encrypted: i=1; AKwUvByRNrzEp5o1CCn9RTdvbLww4R4msvCtRCevPvABztc5dETPvx9H3Nu4iyNE4u7JMt+/S3mDCJFsWBidRhmLTqCbBEg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn4+U7EdQNAzoRxWYrwqid5Nh30p6c1LxJ2lBNR+ATdHS4Gh6O
	xu87HVBLJNkou4f5NOm1OSlVDfZqAPWSdtkfBjIFw3ojDpRfdSJhkMU8xnNK4uw25YHXMQct1dL
	sQxXbV+lCoHzowxgEdg2M2iw/me36qbjekOPD96XP8tg4HmfM6SefuzT/iqzx39Zf5yFYLkhEXQ
	==
X-Gm-Gg: AYBFou2lLiXws60zOp240Ya+KIOiEUFvbHiGzE9AkPG/EscHBsGsLQR+Ede6wJ8W+lr
	vQqbpD2yyUwq5QOC6K/6aJJrTxR8JfQRJvIrtstlmHq+r5oBEAho5frEQR5At2qva6Tz8pBiFSi
	Oa81Q2JP7AjFR0t36wtoVHt4zetOVJRxPXSq8q5XGjc6vibXGzbkfn7muaqzi2IUusb48HkwAHw
	9wFK6IglnCBttpEm8iZLneUtzfPc+Io12Fu7rTS08SS1GaEVYExvwOJde+p6iTeGTrpLvHRXlHJ
	vu1+5m04yw1DkutuyqxlGsusalHmbkTWrUWmkBvhkm5eX+BL+cejBHUicHfY7IiG03Q7zUCH1O6
	6PC1RwSklCN53BEyBG2900PP3NkbtLew69448AtkAIADwBY5n9NPDUOo=
X-Received: by 2002:a05:6214:2424:b0:90e:9665:71b9 with SMTP id 6a1803df08f44-91c48e38af1mr12441756d6.27.1792806981314;
        Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
X-Received: by 2002:a05:6214:2424:b0:90e:9665:71b9 with SMTP id 6a1803df08f44-91c48e38af1mr12441506d6.27.1792806980735;
        Fri, 23 Oct 2026 18:56:20 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:20 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 1/8] tracing/osnoise: Variable cleanup
Date: Fri, 23 Oct 2026 20:56:07 -0500
Message-ID: <20261024015614.3095251-2-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024015614.3095251-1-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Dy86qQ2OSfRDV8FjcNDmCk9zxaEDf0J38TxDegA_r5c_1792806982
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

