Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC7364E80
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599046; cv=none; b=MFuqEgj0B10tObspnYju3mUiUxDCtm6fyH5Vtq/le6A4kMbwGLXa9AMWVqmtY3/wMg+XPo210M2dPyPnk2QACUb6tibWU5B5kkuEs+u3QiqNbewpUBp8ZM6epOcjVpEKIqamqWDROAscNeL5QlmohqIPLcpwhBzMbaeyPiPtNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599046; c=relaxed/simple;
	bh=R1BMqtqeX+DKZ3YLNbQBNy8jwf/bhIzP7JA2VunWjTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WsUHFfjehVE9Jpnji5FjfWhobHIsy1RXqyXg1lUi7eLi4M6SEmmPipD9OijwYM1AOTttFBOvWBEtneN/UnEwZgbPkl/X+qjAr/sSC6OtWvyJbiGGHUTMZnvPpPAQzPAOzYL7sM7CYH4TkNtIcsS7S7nDudPivnwv7amPmoRKN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiMY4iCH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiMY4iCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=OiMY4iCHB8/378hnUyrL48oZWmhZNVrXl+YWpJTAIbQx+lWKeDGzjGWxj1JAH1uVNsoR1b
	htSDChkopnyjpPJbZwg3NscRlKWFHz9yqmygDiy4arehRTfHIRHfXoNEAOJ2eUXjv+fgrg
	IEWPCdMZQZSy94ilo/2bRygi6eb0qY8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-O48hgY_COl6vUFTyTnD9BA-1; Sat, 10 Oct 2026 02:24:02 +0000
X-MC-Unique: O48hgY_COl6vUFTyTnD9BA-1
X-Mimecast-MFC-AGG-ID: O48hgY_COl6vUFTyTnD9BA_1791599042
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53513d2a70eso6230201cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599042; x=1792203842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
        b=mw/r09CdsiHxiOXwTMtD+/g3sNw0OoYU/KWv4IueF4mH57mMYEjCBLVKq7uiukmdId
         dk64mroddFkssDvFhfJixNkvJVyoBbT6mgTvdsktgLC+1k6qmKjiwkza8kQ5VA/MHVs0
         NHcwAI2/ju5kvIHiPOWb6fOk8jw5tLh/bz/daG2tyMMShX/RrM30PKhL/OUUGI//5XEs
         27nvv4cggcEyswl4migts6a6p+4PVWftdIghUg2fMnwFWvqJoC3ULrM2VK1+wJHvKt2T
         xvMI2mkcuzIgRSzr91yuQfca6Wdi0taBTvbSgNpn8Adpn6qF8K02yQlPdSxbcHOo/uLT
         3Xjw==
X-Forwarded-Encrypted: i=1; AKwUvByu2MiggoiEAFt1XoaakF5Eguno/2eNzvWBk/C2vsLj9mSPnq6r20vIxbNlajnTS+gELwfzDTlaHVKszPBq8jwCsTc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj1lGltOVimVM1/enNL+6iutTBQUkBeMOXx1GdC++qUtXM38+2
	3KMmkuH+n89rpb5U5/e8kHdnjWZNjzvPD20y+swlgxkwpicMMmj+Q9mzFuv+sG7qbs2T1ZZqO8L
	mE+3DY1mgVDlOEGLmtzKSyWJEbGqmIlgNIrnesU3M2Z+GpZMgu9Ug0J8KfZdFfy+mIrH2vZ1LoQ
	==
X-Gm-Gg: AYBFou1jBu3FvAbT8q+LcJftJBD0nn2JalksbGIsvZzj9mAujKZUk2ORhG7pW7VF3iZ
	marU2+u6Q47fVbMDTXvct5Eh31Uhnnk+qvOF2toJX7BlnamgeEeYIb9JmmfLhojwW7Y9jvXrqED
	MyZI4CpJMYVGDhv8kpXlGDEJOJXFTz3ajLpUeEWOZvoGETFUHThosLEjRjAcRmf77KeAMR8/8P1
	Ul8qEOwR8ZaHsXRXqru7B4F2PJSsBXfNvC9C9aTje4P2oWxdRO2B+Y3CGf895Dboh/Zq2Xsd5ys
	N5JIRaTW1EKPZ3DQDasxiEHpt7qDiGZcjcrzIP/mCaQm8cTvKbRBddclcmGJdGy+w0VFoihphyB
	3090kKn2EiyGKnMF8NNOun622ae2odCEwUWBVVPvb8Q603t5pS8pzcAY=
X-Received: by 2002:ac8:6907:0:b0:532:d36c:7096 with SMTP id d75a77b69052e-5359fdf0601mr62955511cf.56.1791599041611;
        Fri, 09 Oct 2026 19:24:01 -0700 (PDT)
X-Received: by 2002:ac8:6907:0:b0:532:d36c:7096 with SMTP id d75a77b69052e-5359fdf0601mr62955271cf.56.1791599041060;
        Fri, 09 Oct 2026 19:24:01 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:00 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 1/9] tracing/osnoise: Variable cleanup
Date: Fri,  9 Oct 2026 21:23:30 -0500
Message-ID: <20261010022338.2507589-2-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: uf4KVf9bTS1kCpCehSS-HSzUvJuHsHI5HXQPAQA2Ct8_1791599042
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

