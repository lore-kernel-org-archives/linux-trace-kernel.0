Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87E27FB1C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015699; cv=none; b=ATzIW9yyYdLZbXttxyQ5OMT9GFUSTC5YcdZRB3uA6J+MX/FxqC2cQ6WCH7AJLuMwCokWdB5N4Kou9DJPatO0L0UHKVwaVsG0Rt9KxqLTKyCMZpMtL434Htl+F2kn+cDzW6MCu/DPnljpzrlqYekILZUFlZlDQvMeLZz1pf30Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015699; c=relaxed/simple;
	bh=R1BMqtqeX+DKZ3YLNbQBNy8jwf/bhIzP7JA2VunWjTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Dd7uqIBdvFF8ONXtIn2Np5s9lRLRoaeEREeoWqU2x+/aKbYQSr/S9m38xLPPQoI9NQazNQ+wKzZl3EnghUCj3pMB3LNBADlVPRejjdSHH6W+C29ZsltJoLD1wBF26Bu2LvtSwKRs/HCdRpwo2t5n/tRbAZrVlKiVCMdLAhKd6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3ufz+sg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3ufz+sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
	b=J3ufz+sgm0mIVhp60jBMkCxvK/4DARjNgwRG9K9d6DZtVZnXGqSaCrk2Ccu1DTIJ81YQpf
	yctZVC/5Uz0n7ojRLFk6chkIugE7r6vxbcffBBO54g+TPOkx5ZGFLoM9ifKQoa2vBo0gOS
	ZoC2aaMnmehzfoWvycHIAnM83Y2ZsvU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qv5LWOqLPXGnQwwibej-3g-1; Wed, 14 Oct 2026 22:08:15 +0000
X-MC-Unique: qv5LWOqLPXGnQwwibej-3g-1
X-Mimecast-MFC-AGG-ID: qv5LWOqLPXGnQwwibej-3g_1792015695
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53514fbd4a3so18198251cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015695; x=1792620495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ip22AMxpllVibEO/+0oREu1QNLV/fi5O+5FLIo4xvk=;
        b=fS8H7wA3IXqE++QIK51GtHloAFMfxwLFxyf7XIOJTMbgKTsZLQNdf9wERs9h3mBxVB
         PZYqTPQtYTWylFaJBwZFBtKf3CqskWRZbiiPONnhxy4mnKjITwU+ncPtdySGSeRiMEVZ
         k2FOqDT54sG1UuxY9AyPqJ5LdtOoHjM3Rz76dn0AvjHOO5j4gfCH2mEXhwoHR6cvQJA/
         XR4tR6QfmGr9hLI9TubH8/DOCZu3ZWeoG6WbF2faYMaEQTpOfvaX9p9FVoy3vFXViVx0
         vFesmTNMHEFpiA1kw9aVrjX52z0jwuqxxJbhYVqpW2qniHUYPltWLBP78QplVl8SKNU2
         A/WA==
X-Forwarded-Encrypted: i=1; AKwUvBwbUlRRcxTGZkY+nE3dc0Yxj4Hfts7QX8zQuPlNxLkK4cmkL5P/BXu7VKcWl+Jlvjq/TN5XExkzb+bIU/A7eZ6KvKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyF8DD7HnZTV9yn7m2cUGYkNj5RCYjTQ5lzTQ7PFV+9p94o2/o
	sX9i56JbhUSg3euV4hO4GxuU+zc4ZrfOcVdlXehd8Ug5sRtrEk382IIWMaJBYMvO8As0bJ/9F24
	aUcnLP9da2lYi0P1d+LISy4urtY8ss693OW2UuKn1cIC/H0BENDxUtBcZD8KXXVdDpjpLYMWh7g
	==
X-Gm-Gg: AYBFou3ixuuRyAcjuPhy/LTIX8H3vbN4QlXSmPIYoTrH9QKd/6sg3Amt+qDA52sseYU
	SGWQUwJJUTaBWYz4TAmWd6Q8njMg0Q8uDozpR08rNBdmNAmrkycocWLKbTIwYTct5ql4x3pH1ia
	w8Gh4MgntFgyDIcqohp6v+akLr2rIyiDW3WXsG4DPH3suN+4chtnPeOYYh1LrQsgcuzNKqk+BMm
	/6+q6jLkK13jLkcF2VSEsHsKQ6/8MazvaBphVlOpT+bbEYQiDLriftTMafluWSz3lkWgAr0Y6DQ
	kKBJvy835sFWpIH9ot2bSvU613l44ECv5wj8SpnTBEajBAI6tshJJy5MCUtopmgh4nhQe0G+Im2
	v4C+w6ndT7vVuT1QA5Dmn/K0474/VG8WVUCy18t8uJPKK4JhHWTBkfYk=
X-Received: by 2002:a05:622a:4c7:b0:530:de54:ff67 with SMTP id d75a77b69052e-5359fb8ae8emr281885221cf.50.1792015695235;
        Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:530:de54:ff67 with SMTP id d75a77b69052e-5359fb8ae8emr281884951cf.50.1792015694734;
        Wed, 14 Oct 2026 15:08:14 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:14 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 1/9] tracing/osnoise: Variable cleanup
Date: Wed, 14 Oct 2026 17:07:51 -0500
Message-ID: <20261014220759.908839-2-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220759.908839-1-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3zhj3pZC9NVo_f6dEKbnY9enf-ry0vAZNdG30MoJlU_1792015695
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

