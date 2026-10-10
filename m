Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF89385535
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599053; cv=none; b=PeV+vAQ/YOu2Sz2DXANTNmBmEO3UDhDzwwlShJEkxQfdFDANNaeCZRmWDFQXdOFnxWxBehywlhceFeFOJdHWbF0UjcNrDQkXpHEY9LNQe+j4Jrqk1mkSQAtGyZlsri2DgBEy7uxfsrQhmLr6rx4Z7cvaChZzkV0pv/jNe03Kmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599053; c=relaxed/simple;
	bh=RaIOCnojV3xtur4bofo97yIURm2b4t3Xb2IF9jMYN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ow2Gpw331U3DLDJT3LMWSOBfN4ZEBzwg2ys8sRHjw1i3M53SDkyfFhAsthM0hLSwcOZa9vOOx8P9tM0a+lV3HM8uvU4R5XblQHzvWSgsc5r2j4InFnkblTxVKru1OCKaZl0R+fVy+8OXfE4Atj+dO45oOdvqn/VZnqdRr6I3ZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMnMpxEc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMnMpxEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGRUiq8M/Djm/IFRXivk2shNsJXHe8S7DbrRJ63Nm2g=;
	b=EMnMpxEcjkkzPyKIO08JI1ovIqseH/2rtMMxCYJWiwFSIp/rZ6WSoiNalAnP+4oQvnFBBW
	rUmnFtfsRF4U7kf3IrDC7S1uuidV700DaC1mhvEXou5k09jLuH0l4Y9AkYWgQFsmKwjALe
	VK5xqeR0OlAjBQzAQCf0m4WV+BY24a8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-jzTIrNdjM2i75G4KtuxaPg-1; Sat, 10 Oct 2026 02:24:10 +0000
X-MC-Unique: jzTIrNdjM2i75G4KtuxaPg-1
X-Mimecast-MFC-AGG-ID: jzTIrNdjM2i75G4KtuxaPg_1791599050
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53522c265f1so7183241cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599050; x=1792203850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGRUiq8M/Djm/IFRXivk2shNsJXHe8S7DbrRJ63Nm2g=;
        b=ZZyO2R57RFc2M/JbjWf26IqOXN2azI43U6EQzv+HCj1bEXPpglTtIwE5aEOHDsMvnf
         FRdRvZU2WI92qqVpaD5eZcLErkY6QuRD6rX/coViDwi2ouCi5jMEIYdZlxRi5X1Eq6fE
         qhmgdVXjOAtONVZLYgcj6mqOVaPKKxw7bkoJyVL6BA7RgFe80A2zQD/KrFqTdacrU5PE
         Oa4pm68T+xYtz4SYYGb2yWLfMQN3qx+c1so51W7hDKSuemQ/nCS6xnuID4ZSB7IbPrxO
         20p/ghS8IZ9U/FUlUNHammtRKosTKOrawLzgnd0WP/H5LRqOtRxDBcvowb04rxExl/cV
         EoyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSm6TAZk2x3XYRRjPqxF8Cuxx95N0kkSQsWa2l1ZCAF/me4o8IUOPCqIHZxWFgqBPRpPI/ndGPzeYlpwIa5Qqrmkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWTC+unPcEiWLxMXKPvbRWvEy0C5H0+pD0LIJ5ee1HNXZYM5Pq
	XVxneNBCIDIdtGGowPOvNHrWdUMQvmwzEzBXuglEOnuqWvWfKcH1e22jiBRYT0Vr0N4sLaioJWA
	So9Lty733IzahhQiQIFpLpV3Tz9Xyodx+l3Q+YcaQNkbU5kCEe07htOitUYc2qdeB3uWUMz0ZMQ
	==
X-Gm-Gg: AYBFou0fDsOO7+sXtZh+9h41MxnN1FRCHyfdSM9eKPethKYbpsdIS2rtlip49bw6m2E
	3PWvwrEznETHBZ7Ia2qE3SLOm6UsCSf1CIJbozDslDPEgw0kKHpQysM/6WwhFGt+DQ7tIbw/0U6
	U6PYaCV/vZbhT7GhvU3AXup7jvnRplMhb/bS3GBxUGuto3L/9mB5DeqEUC4MOl2d6+JZ5nbTH/Z
	ddQtcvc4IIxI68cXMYQlY7Yw3f9VZNTcdGrx/2arLVFeujrLRcwh2zuF9/fzAZX+SKL8k8Rr1t2
	65u+7jOWN4gK7xBB3gq4i4q8x6ZNIWbpMvJ7vsyjvfm/IjGyqiYkSOcN4wmQgwYexyAIKWutbvl
	fTRbdjasVNCaMzgzMYOPRz+wAkBsUEWvHCnBQMsU6cLAeQBMfreDuL6g=
X-Received: by 2002:ac8:5f4b:0:b0:533:37fe:3680 with SMTP id d75a77b69052e-5359fba7972mr65990931cf.60.1791599049534;
        Fri, 09 Oct 2026 19:24:09 -0700 (PDT)
X-Received: by 2002:ac8:5f4b:0:b0:533:37fe:3680 with SMTP id d75a77b69052e-5359fba7972mr65990701cf.60.1791599048975;
        Fri, 09 Oct 2026 19:24:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:08 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 7/9] tracing/osnoise: Split out per-cpu variable resets
Date: Fri,  9 Oct 2026 21:23:36 -0500
Message-ID: <20261010022338.2507589-8-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0WMC6fFyhYA_fBF_oxa9flRoYQVJFftHBYg8mbMxQII_1791599050
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Reset per-cpu state every time we stop a kthread or detach an fd, rather
than assume everything gets cleaned up properly, and avoiding the need
to explicitly zero individual fields.

Also, stop initializing tlat->thread lazily, add some debug checks to
detect an unclean state, and clear osnoise_data.tainted in
osn_var_reset().

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: New patch.  Without this, I was seeing sampling = 1 leaking from a
kthread context to an fd context, which confused the latter into
operating with tlat->thread set to the old kernel thread, causing the fd
thread to hang.
---
 kernel/trace/trace_osnoise.c | 104 +++++++++++++++++------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index eaecd56492e3..ccd717db9a51 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -319,23 +319,19 @@ static inline struct timerlat_variables *cpu_tmr_var(int cpu)
 	return per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 }
 
+static inline void tlat_reset_cpu(int cpu)
+{
+	struct timerlat_variables *tlat = cpu_tmr_var(cpu);
+
+	WARN_ON_ONCE(tlat->thread);
+	memset(&tlat->zero, 0, sizeof(tlat->zero));
+}
+
 /*
- * tlat_var_reset - Reset the values of the given timerlat_variables
+ * tlat_var_reset - Reset non-per-cpu state
  */
 static inline void tlat_var_reset(void)
 {
-	struct timerlat_variables *tlat_var;
-	int cpu;
-
-	/*
-	 * So far, all the values are initialized as 0, so
-	 * zeroing the structure is perfect.
-	 */
-	for_each_online_cpu(cpu) {
-		tlat_var = cpu_tmr_var(cpu);
-		WARN_ON_ONCE(tlat_var->thread);
-		memset(&tlat_var->zero, 0, sizeof(tlat_var->zero));
-	}
 	/*
 	 * Reset also align_next, to be filled by a new offset by the first timerlat
 	 * thread that wakes up, if TIMERLAT_ALIGN is set.
@@ -343,38 +339,12 @@ static inline void tlat_var_reset(void)
 	atomic64_set(&align_next, 0);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
-#define tlat_var_reset()	do {} while (0)
-#endif /* CONFIG_TIMERLAT_TRACER */
-
-/*
- * osn_var_reset - Reset the values of the given osnoise_variables
- */
-static inline void osn_var_reset(void)
+static inline void tlat_reset_cpu(int cpu)
 {
-	struct osnoise_variables *osn_var;
-	int cpu;
-
-	/*
-	 * So far, all the values are initialized as 0, so
-	 * zeroing the structure is perfect.
-	 */
-	for_each_online_cpu(cpu) {
-		osn_var = cpu_osn_var(cpu);
-
-		WARN_ON(osn_var->kthread);
-		WARN_ON(osn_var->fdd);
-		memset(&osn_var->zero, 0, sizeof(osn_var->zero));
-	}
 }
 
-/*
- * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
- */
-static inline void osn_var_reset_all(void)
-{
-	osn_var_reset();
-	tlat_var_reset();
-}
+#define tlat_var_reset()	do {} while (0)
+#endif /* CONFIG_TIMERLAT_TRACER */
 
 /*
  * Tells NMIs to call back to the osnoise tracer to record timestamps.
@@ -409,6 +379,36 @@ static struct osnoise_data {
 #endif
 };
 
+static inline void osn_reset_cpu(int cpu)
+{
+	struct osnoise_variables *osn = cpu_osn_var(cpu);
+
+	WARN_ON(osn->kthread);
+	WARN_ON(osn->fdd);
+	memset(&osn->zero, 0, sizeof(osn->zero));
+	tlat_reset_cpu(cpu);
+}
+
+/*
+ * osn_var_reset - Reset non-per-cpu state, and check for stale data
+ */
+static inline void osn_var_reset(void)
+{
+	struct osnoise_variables *osn;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		osn = cpu_osn_var(cpu);
+
+		WARN_ON(osn->kthread);
+		WARN_ON(osn->fdd);
+		WARN_ON(osn->sampling);
+	}
+
+	tlat_var_reset();
+	osnoise_data.tainted = false;
+}
+
 #ifdef CONFIG_TIMERLAT_TRACER
 static inline bool timerlat_enabled(void)
 {
@@ -2036,6 +2036,7 @@ static void stop_kthread(unsigned int cpu)
 		kthread_stop(osn_var->kthread);
 		put_task_struct(osn_var->kthread);
 		osn_var->kthread = NULL;
+		osn_reset_cpu(cpu);
 	}
 
 	mutex_unlock(&osn_var->lock);
@@ -2468,18 +2469,12 @@ static void timerlat_fd_detach(struct fd_data *fdd)
 	if (WARN_ON(fdd != osn->fdd))
 		return;
 
-	WARN_ON(osn->kthread);
 	WARN_ON(fdd->thread != tlat->thread);
 	tlat->detach = true;
 	wake_up_process(tlat->thread);
 
 	mutex_lock(&tlat->detach_lock);
 
-	memset(tlat, 0, sizeof(*tlat));
-
-	osn->sampling = 0;
-	osn->pid = 0;
-
 	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
 	hrtimer_cancel(&tlat->timer);
 	put_task_struct(fdd->thread);
@@ -2489,6 +2484,8 @@ static void timerlat_fd_detach(struct fd_data *fdd)
 	osn->fdd = NULL;
 
 	mutex_unlock(&tlat->detach_lock);
+
+	osn_reset_cpu(fdd->cpu);
 }
 
 static int timerlat_fd_open(struct inode *inode, struct file *file)
@@ -2545,7 +2542,11 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	osn_var->fdd = fdd;
 
 	tlat = this_cpu_tmr_var();
-	tlat->count = 0;
+	WARN_ON(tlat->thread);
+	WARN_ON(tlat->count != 0);
+	WARN_ON(tlat->tracing_thread);
+	WARN_ON(osn_var->sampling);
+	tlat->thread = current;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	return 0;
@@ -2637,9 +2638,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			}
 		}
 	} else {
-		tlat->tracing_thread = false;
-		tlat->thread = current;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 
@@ -3014,7 +3012,7 @@ static int osnoise_workload_start(void)
 	if (osnoise_has_registered_instances())
 		return 0;
 
-	osn_var_reset_all();
+	osn_var_reset();
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.54.0

