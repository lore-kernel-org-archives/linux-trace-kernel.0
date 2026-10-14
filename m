Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366A481230
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015710; cv=none; b=tCXjU5b1Haj1UTEcmUAvvWEEwX8j2wurDWJx3DAGzPWrUIs1/3cU1NIZmijDVWS+pFBP+Xl4q4HTg5Svcs4aW59DKmAYsCoIz/AdOWu7bJG9Upd+ZaLysw8xLajmThIlHggX05XrrX3QgYlfKhduHvFtIud6+48BHc3vZiY8XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015710; c=relaxed/simple;
	bh=r0e/enn2javi+7BdjGCPY3NSCXJlOPI/vT8VoHtNc/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Bb/wGSP9oR8gcG5w+JNBkOOkB1R9QsDtc6NclQ71jwrXXwyc41s8DJY/n52/lQWPK9Ah8rHnk4IJ41Q7cPOFzDp5v/D6Q3fkKrk4dDpRBigXHn7UFCBOSUM2xZWgVQDZrPF91X54Xqni557WH+Q7tATXO0Zl5ia3h1QRKiJ8zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOv1qx6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOv1qx6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6227Ra8RHOU7yj9QWOUr4aB2t06u1pUQFQnFgdegrmg=;
	b=cOv1qx6fKPYgROnCeaA76v25JTVVgzdlT4g6P/T8dPo87hsL935hlP25r7L7ONVSOfrkfP
	q1HOuIYAG36jE2hjsobTMeAKniK0bOpKG0Bn27MKb3DVZBx+pk/Os2vcRE2tmlJB5/qn06
	EUxE90bIwUU1SVLXJGzBjz/lkyiqb1E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-5RVfqVynMK-qPMGZfj1HXQ-1; Wed, 14 Oct 2026 22:08:23 +0000
X-MC-Unique: 5RVfqVynMK-qPMGZfj1HXQ-1
X-Mimecast-MFC-AGG-ID: 5RVfqVynMK-qPMGZfj1HXQ_1792015703
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535131e4c25so90830971cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015703; x=1792620503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6227Ra8RHOU7yj9QWOUr4aB2t06u1pUQFQnFgdegrmg=;
        b=mzzITI8e3oOe8kEreNBgWV03kJnMHMtY3wYeo+FYJwy4VDRfqA7wPDLOTUDyK0RiaC
         +4io3n7bhzXK0omWdXLLhpmCOVNRStmXCxgiP6AR3ZW1P1Uyth24gxmqWN4tlmh3DmTU
         PUg/RJ8zhMbFCRQo/26qRnwtMjzOVFQ4pNaiAtHPQzLLneNwbglOlDN9aI4JYmdKJz3+
         Jl4pPJa/jD5qig/xaDq0QRtlpM7DRdBmnY3DyHZQJ+1AQu5IqzYnndRPZQ4Egii8yXU9
         FGPldPapypVxfz0zBleBme0X8HgjdDIE3wcJZgsuupA0b44m1o9BAkfGWK6BU2K4nbsH
         PVjw==
X-Forwarded-Encrypted: i=1; AKwUvBw8Wl87ZARSQkcqyw/WIM7x76EY0Lg2Q9LaTJSVL+NdAuZxY2X9BxAcIGvo6KktnF4U3IWS1hwDDo8BlcFRquweLGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiSgzR3QymDh3C2be8IDZFoHDB+rxP+Zk4TGY4I0pjxXI9Gpcy
	EhsTOUKTy2uyEib6QZtBA75SOZr3QQIx1pQA1+j3dutZ18AahMboMbzkMHHQrkxuwgUIPdxREV2
	bvIotQ7ylO1+w3RMqlCK+btAl88blRStuaUOLTVK/mdPIIY19D4DtQ9OrBwNl23gjmAbtPNXlxA
	==
X-Gm-Gg: AYBFou3g229wu2LElxH2U3nztgw2IQozo5FkxoMvXW9AXfFOBdKMu5d8tHOYlIbxZuW
	LI4qd5KaC39bzp9Ir+4IS3oyXwbEKyF4PYiMpuzwAOz85I7CD3oJ0JLBIREaUhQ6YotqCH5Gu6E
	r+JdM0s9+BlHAm1IA9489YadokZruoVZq3c7S62fe3hYg9rikeL4X+ji9yPlNbot+ULr5+xOUvY
	YeG4X/i0eANkY1DODo79Ut6iSAXMOf7E7k5gjT7wU3mLHlDo1bMjXS0kvUPdD3LbU3ZJjgB7u17
	LjAGqudsO54HziAgiPRpujOGgYKf5RbzxF9rlsmS55ZTEXjVRpulNZgvv32HuzwKz/VssPFtCQ2
	7QPK0jhXjJ8BrbsQIqpTLyv2AaY9NBU8APswriY95HUiJCwK/bwhw6n4=
X-Received: by 2002:a05:622a:4c89:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-5359f48d6b6mr268414471cf.6.1792015702924;
        Wed, 14 Oct 2026 15:08:22 -0700 (PDT)
X-Received: by 2002:a05:622a:4c89:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-5359f48d6b6mr268414081cf.6.1792015702428;
        Wed, 14 Oct 2026 15:08:22 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:21 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 7/9] tracing/osnoise: Split out per-cpu variable resets
Date: Wed, 14 Oct 2026 17:07:57 -0500
Message-ID: <20261014220759.908839-8-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ABJXb_4Ak5rexNNHxFmBSOFshup0nWWIvb9Wl_PMQws_1792015703
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

v3: Reset the per-cpu context unconditionally in stop_kthread(), so sampling
gets cleared as noted in patch 3/9

v4: Only reset the cpu data if the fdd is a match
---
 kernel/trace/trace_osnoise.c | 112 +++++++++++++++++------------------
 1 file changed, 54 insertions(+), 58 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 22263e08b968..36088b30f4ed 100644
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
@@ -2038,7 +2038,7 @@ static void stop_kthread(unsigned int cpu)
 		osn_var->kthread = NULL;
 	}
 
-	osn_var->sampling = false;
+	osn_reset_cpu(cpu);
 	mutex_unlock(&osn_var->lock);
 }
 
@@ -2469,18 +2469,12 @@ static void timerlat_fd_detach(struct fd_data *fdd)
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
@@ -2490,6 +2484,7 @@ static void timerlat_fd_detach(struct fd_data *fdd)
 	osn->fdd = NULL;
 
 	mutex_unlock(&tlat->detach_lock);
+
 }
 
 static int timerlat_fd_open(struct inode *inode, struct file *file)
@@ -2546,7 +2541,11 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2638,9 +2637,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 			}
 		}
 	} else {
-		tlat->tracing_thread = false;
-		tlat->thread = current;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 
@@ -2695,13 +2691,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 static int timerlat_fd_release(struct inode *inode, struct file *file)
 {
 	struct fd_data *fdd = file->private_data;
-	struct osnoise_variables *osn_var;
-
-	osn_var = cpu_osn_var(fdd->cpu);
+	struct osnoise_variables *osn_var = cpu_osn_var(fdd->cpu);
 
 	mutex_lock(&osn_var->lock);
-	if (fdd == osn_var->fdd)
+	if (fdd == osn_var->fdd) {
 		timerlat_fd_detach(fdd);
+		osn_reset_cpu(fdd->cpu);
+	}
 	mutex_unlock(&osn_var->lock);
 
 	kfree(fdd);
@@ -3015,7 +3011,7 @@ static int osnoise_workload_start(void)
 	if (osnoise_has_registered_instances())
 		return 0;
 
-	osn_var_reset_all();
+	osn_var_reset();
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.54.0

