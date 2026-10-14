Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F4370D69
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944861; cv=none; b=nI3lub6s78H1fZfBfCjGwo/RCBWvEFvrRT7vFNhBKGyffUTEUJFLVuDTQR8iaO0YHwbN1dRJcaDmA0lx4FVJVliynVCzSRWA0r99iMLfSvGyIOxdOAeRkgUIakevsKb1BUSOWUKTOwRNoFuMAHZMSZZ6aBEik+VZ82mOHM9h+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944861; c=relaxed/simple;
	bh=MICiZC/idifNDivLzNDqtKN2tWeQBGe2YRTE/HEe5fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ECZ0l1/9g8c8skjcktYXxGaiq0P6vJJ+g5LD4iAbEOrnaiyAgiZLqCFUdXgK7MIhBkvdG/SiIU9T1uS14k4eaNnyNawwVEgY8PVRGwRAErqHp0D8edGsN6ljhfgihye0kJnBjakr0EpHooBGCVm3f8tcb9OF+b9hjwjOnt/5XDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4B3/214; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4B3/214"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftzW5sE0QXGXZWT1DIaid8I8n5icnI2FzH3TvhDQwz8=;
	b=i4B3/214ywFnpGfl+ptyGlBWK+BK38JX3MgIPBh0u9JFa2tC7ohXm1dx6yysJm+Bps+FXo
	KU1w34YFBqEKs5qAMFSJunmBJ9lykVoPdFiBTwXQ5w0L0mSGA2EquklofcMP/Yhx/YopoN
	240yjXxltnaKGs3IH0luJ02BCPVRYSk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-PcwsO2j1MMeVfp5nM9u87w-1; Wed, 14 Oct 2026 02:27:03 +0000
X-MC-Unique: PcwsO2j1MMeVfp5nM9u87w-1
X-Mimecast-MFC-AGG-ID: PcwsO2j1MMeVfp5nM9u87w_1791944823
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ecdc701a2so455294385a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944823; x=1792549623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftzW5sE0QXGXZWT1DIaid8I8n5icnI2FzH3TvhDQwz8=;
        b=reYpGIGOnKKVks13VG2PLU9Pcsr6TlT7CrqldNuvv20XwM6yqPqGS8mSwfI3Xixojm
         IXfMHt5izYkVLEF70NX08uG5micVYd8nrcMIbcqbS94e//yR+NQ5ELCbmPYanke9GN5/
         0myJ8U17bqrXLTNpvgP/iMzVwygjNxAVpd0DTIIJX71cXSUssO3x8+HNx9GuXogYiznT
         ZTpwC5zndzIFma/ESqwkVICNfELVV9uGHu+ycGpn1oWD4s53LSYd5cE0pUaFcSgzEKXr
         ALK/oPGhtPIm8HWx7Ny//Ggdbi0oeyTGefEeNkiIvuZKvW+23jRBtL6dTpsL5GpQv2lM
         7tog==
X-Forwarded-Encrypted: i=1; AKwUvBz4lNClYLvAI8WmJzywK46R/mwCXaih0vm8MrdqrDFygjdoNFovMMYdmCj9KlHXFdDA9Tw9NLgDKVrR5n5FxMheXK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9MKxnMdau2rNpHdPy0fhGlNNTMPaw5NUv6aRVcpULhG15l7cf
	3+WBx8iWDuti0KYsDyY3Pfwm7ju13ENlMII+fcQ8y4qv7eUFQkv/kaNZHRq6Ug8S91120t5vhzH
	p5PQw2rpEeO36uAkiM86qHUq0Zk0kKd2iBJxFUO66etI/EPXS80b5P1cI4CC2zxSMScyEz2mZVA
	==
X-Gm-Gg: AYBFou3xnP3Fg1cJ2pUpK6dFM1rpqgxjIalDkpeopJgf6XxKgZSxI+ScAF67TMN/qHh
	213ODgkT1loCycCj2zTPetzxt8VPVN3yxpif4UTdOPONjeKaGfTW0/WEuXpHtVUgBadjJH8/4b+
	huslWA2TZMI9gLsA/EUXE2LnnykzEpTMUE4BAx4E+5dGdLg4pztKX9s/ZqdCT+t7RdqJmK0i3GW
	erNTyn5mUhs1RYsn1UBw9yVi9kArNti7/j4QWfKzw0ELZcQM7o04Gbkbht9v4zKvVoqWF5/0QCs
	/jDnEGV2wM33RwfPZ/piIGoEn2RKz6FlI21yN3oMVc2r8stutmWVyiBuqotQ/d2TJmxOKeRiN2d
	FbhDMznLZVbFxJF1dnmYf/jRfGXmpm/mjIBc16Jl4cMIxk3h1RIB43Mk=
X-Received: by 2002:a05:620a:17a9:b0:93e:7dfa:262c with SMTP id af79cd13be357-93ebd2499d5mr2309008885a.35.1791944822696;
        Tue, 13 Oct 2026 19:27:02 -0700 (PDT)
X-Received: by 2002:a05:620a:17a9:b0:93e:7dfa:262c with SMTP id af79cd13be357-93ebd2499d5mr2309006685a.35.1791944822175;
        Tue, 13 Oct 2026 19:27:02 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:27:01 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 7/9] tracing/osnoise: Split out per-cpu variable resets
Date: Tue, 13 Oct 2026 21:26:38 -0500
Message-ID: <20261014022640.695786-8-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UdKf4Qgjj83FSEvsSBRp5PYdtsm2iOPs4ufPAhpJ7q4_1791944823
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
---
 kernel/trace/trace_osnoise.c | 109 +++++++++++++++++------------------
 1 file changed, 52 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 22263e08b968..d799c400ed9b 100644
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
 
@@ -2695,13 +2691,12 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 static int timerlat_fd_release(struct inode *inode, struct file *file)
 {
 	struct fd_data *fdd = file->private_data;
-	struct osnoise_variables *osn_var;
-
-	osn_var = cpu_osn_var(fdd->cpu);
+	struct osnoise_variables *osn_var = cpu_osn_var(fdd->cpu);
 
 	mutex_lock(&osn_var->lock);
 	if (fdd == osn_var->fdd)
 		timerlat_fd_detach(fdd);
+	osn_reset_cpu(fdd->cpu);
 	mutex_unlock(&osn_var->lock);
 
 	kfree(fdd);
@@ -3015,7 +3010,7 @@ static int osnoise_workload_start(void)
 	if (osnoise_has_registered_instances())
 		return 0;
 
-	osn_var_reset_all();
+	osn_var_reset();
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.54.0

