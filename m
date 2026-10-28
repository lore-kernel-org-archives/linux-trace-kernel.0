Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224891;
	b=PhfFgi+j9EFtP4JPrg3BNM2iMjwRwo5ZAkXfm4oHGhWV2RlKK2UgoYi1oG2YI+z8xGRL
	 YA5Eqxs54FEAjXWEtzK2BEnkcl4CVDFxHk91JLLlAKnBhto9qwS807Kg6JTksxf74bsNG
	 BONr9rGeYOtcfCfU0s6mzQ+Bo98cJ5B5z/h0EdGROLa7mEg4V8dbz+u/9qt6J74DcS5fx
	 qQVBfVJ8jEHDgYrh3TIb8m/5oZzRkZiZLPoECWvW76aL7PQxyK7jpKqmQ9eYZMxMlHh0d
	 S6Y1BQLg5wP0urv8nUCAnh3CzB4pqyA7DnZmdtqYHAl61BVNbcHbzJf3do+2nNb2Zdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224891;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=khu+fNCSUfOG+Le6ZMJy/ydSFWyYDNulrEkRYC5nqSXDeBhtwNhfTguCDD9fN7Qe+X5k
	 87YZorCCPBdevEElDDCDsIwYMP6MHLhyQKvhxLyNKc2iVcpHkjO9nPkbuKI5ihw80qgOu
	 ptkSR562ZJu88MxFxOIxBy7mEAFkZlSmWh9eAYUg5LL0lfLL61rR7w2sXF6PV4lJ9350Y
	 Ac+M2RkaasHvwSGpLs6IyB9vhxDG0Hya1bZn1JkyeQ+lpD2iIignJ6vYOk694W/SjdiNd
	 8rEacttYW3yshtxyjFF0KqBQtB4rIpgWLxl8u9OyxS2ylNqK3KSfDQlUel6E8OUtFxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbqyflI0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02D606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D02D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbqyflI0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=XbqyflI0sWyJ8KSqIhHNE2pQju17hsS8YeqceGRxy62XowdMe8aWAXpf1GDImhL08Qp/JO
	cDE/Xc0eWg1geaB5TBPd274EPg+rovC7I4dDmH7KVaTiV0Yin5cNMb3fzqv1mn5xPhK2+B
	pU6rRybq+X6N2PBFgjHjcJyjZdBSA+Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ZCfHkjkaMb-ZPgK9uzp8bQ-1; Wed, 28 Oct 2026 18:01:29 -0400
X-MC-Unique: ZCfHkjkaMb-ZPgK9uzp8bQ-1
X-Mimecast-MFC-AGG-ID: ZCfHkjkaMb-ZPgK9uzp8bQ_1793224888
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-535066512b0so29424631cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224888; x=1793829688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
        b=tRKKGt+bjLbffms/Gs+XBUkUEHvTsp1Vtdply6nl5N6cDRsiScUnSbEHYRNej6EtTg
         6tPyZaiNlGBZ6Odu6dR9nMnOBCAVMUj1bochl1xeAsPYsNYVm6anQ72smFAt1GcSZ1e/
         VMVUs3jGe5EGKCNC8XkSow6Q0O1N7PqToWw5HU+SM4XvmtSQmylMqAJKMlW24qrfR5Gh
         hTLQ4Bge746yTiYZ3+tCalfkA4OufOyITp0DncSNAc/DElHHspwYxcZdUwW69r7/+4xj
         dlVyjEeAn7wmXPmSLA5NZcYV6/ZtSLXq1J2YVeKfKZSkl40eaz07NyljBDchk5nLBktZ
         3LOA==
X-Forwarded-Encrypted: i=1; AKwUvBxNB30iS6wYRpX8I916PeH+ppl17NBz5gTKPlBEnSXWEmkyUBCHkuHIqxz0fEcpxqkEh0X6apQvKjTrAHzs9tPjByw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmss8HSQ1lJ3tA9/1mtfNG4DsG096gilOkPJrNsxdz2fwJeF2A
	miK5R66qiF22MaRrbCZ3hHrLtnANH2sEMp668QR1iQAd0i2aqE/YNif2A39C4Enyh9c3jFVklAh
	kbWGR4kBZuLZAgVr9LzQDxoPnfq3+9LVw0hQ85ElvB9TDYsAhYLsQb2VWO1oetTuV0lTGrrWoBw
	==
X-Gm-Gg: AYBFou2vprkbRfjHOousWoX0aMl79R+z/xhizULPXDE9NH11qy2Nut9YUMJqtqMgPbM
	T5Df03Kr8+7+VQ9sjQivo295517fwuEMMvTRA+qQ5kinQWgNqMZxcU8DpKSFpxVdR+Kg+EHRXfD
	FKLL5pNjt16sfFM8wg5voMYLeQ+E4YH/OLacw+kKzGVl5q1Ev6pOt/9B+EyuQwWm7jfkb/RzgxO
	CpP5IA5HShMvLissZDdOEjGom3a3S0P9vrOlgBOQgV0qpf0AXpCwzN8VpgWuFz7rUGQyprBT0oE
	IrAftz5dVhSkLyohfM5d56PrDBwK0UFw82g98qg8htFNLtr/32+bda9qQ+gVsC2HOt8gWsjVwLz
	NfTFgfVZ4aM8tvrkyuKMOE1m658/rhCGR+t5fKafLtpU68yZ0R30SAxB2xOvcZSatSt/eIoBW82
	OirXnWPBT48Kghh0Wr96sD/PgpWzDp
X-Received: by 2002:a05:622a:5c1b:b0:537:af99:b562 with SMTP id d75a77b69052e-53fcbce2f35mr57874351cf.47.1793224888161;
        Wed, 28 Oct 2026 15:01:28 -0700 (PDT)
X-Received: by 2002:a05:622a:5c1b:b0:537:af99:b562 with SMTP id d75a77b69052e-53fcbce2f35mr57873721cf.47.1793224887515;
        Wed, 28 Oct 2026 15:01:27 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:27 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 01/10] tracing/osnoise: Variable cleanup
Date: Wed, 28 Oct 2026 17:01:11 -0500
Message-ID: <20261028220120.4005187-2-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: d7EM4n73ZV0Ll949Amc5_ot3KLpCmPB3Jl8AEJkKYzE_1793224888
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

