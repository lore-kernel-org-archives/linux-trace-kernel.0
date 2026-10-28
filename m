Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224897;
	b=Ej2kSt6m7SaRntu9fy1V5Cgi2CcXyodVKLOw9+t7iVrbNYZOwpDHpAQ26lntcaPofxD/
	 ytHVR7U/A9d8qzlTsePdijrgtkWsqJN1L1QKY8J3Qb8wdCytEvqFWICJeTQ9niYEP0jvu
	 GNMh77vry+WictIrWTfrz9uEk7AnGRJl56mzbjsU83hJ5CdqNNZZi0QlyKkBG2ChHm0Iq
	 1vzMQA0en7xef9iyxfTu4QzRtUdohPTpq3blx0arniADM+pTCT19uMrqeneVAH2WPPmwp
	 4ahBgPtpCO/CWW64+gG/fZm1vUHiQkNjrUgtY4dTzGTeTd+X+gu4QvQfVjhRCHEjsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224897;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=lVYg5durMJ/TQWpiEV1b+buo676ve7zd/Djo9rg6POY=;
	b=KLU/v0EzqiPOuY07bEvx3PTwgMccQtQ4REwzqVjl0GkAg7jB/EW18EEczKKLJs8Z8L/Y
	 Qo1s+r8J07Z2QXXlfT0g6wQdsaLIG//DjVfhVP9kuFzYfatvc9msafsrRjoXCaB+slbQ+
	 f25ABTdYiMzIhMaxJ66K7wLFh0NUl6N2K0yLYzRORuv5jVOcXUXd/fNKyY4xE4zwL6ijJ
	 4Ko/JeFLguSpugkzuXzYl3N8O6kWpUtCUUDmQgsHeivZKLdv0Bwj+D2wj7gcKoe8qt/V9
	 YcXpEyiOXsWYdNQrhepdNtCjZW33zJrjx+X2ADMOk7LxsJpS5U1CZkt1C/mMHHqaSpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XFtwIqdk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC79606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC79606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XFtwIqdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVYg5durMJ/TQWpiEV1b+buo676ve7zd/Djo9rg6POY=;
	b=XFtwIqdkqWPSatc3tDjIzcr2GQpTt/x2y8RUfF8mM+ndMp42QGS98CyLqhWduJ61MhBhH2
	kHAnvtDdl3QYV7Y8i+BX1Ugtp8MNJoNGrT8oRCLZRnronkvEqxwcOW3VdJmbK4C4r64YlK
	B/wAeAL0jNajsnC04eULJtGxQnsWhU4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ORaeUj9RMryEq2zbpshCug-1; Wed, 28 Oct 2026 18:01:34 -0400
X-MC-Unique: ORaeUj9RMryEq2zbpshCug-1
X-Mimecast-MFC-AGG-ID: ORaeUj9RMryEq2zbpshCug_1793224894
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5363763b556so32725561cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224894; x=1793829694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lVYg5durMJ/TQWpiEV1b+buo676ve7zd/Djo9rg6POY=;
        b=sqh64OF4e87aKWD9XrLNn7QJY4Td3cwuXcSFc+UiLPjNFDeZClWaO2GPyGnaBwEzXO
         g99ab0NFTO64bjUFtGTq+nunndYS/PBt96dqPhAKMZtGlSsb7WQYnFcLrVd28n+y/3lt
         XJcyy28sKJgOoXqkJWZAHNFW+BKnygXw9e6HHEufgiz4sEG7PkRHRstPs71SlS3gJ5QU
         OTeNsB17Fv0Jrq7qYBQbmSgvMEixdwzvmPSuBD/hLnyTi7aPyoUuS0+B7PFubFG//HaX
         GvyIrcELy3JlHoUunfh6GdAZBukS3hEzV48JzGm1WCouh7nOOkPk1Zh3jKNv7Q8g8VKG
         8KkA==
X-Forwarded-Encrypted: i=1; AKwUvBzGZ6YcfXN2aAKyQBUTAXW2vGNvU/6hzAs1fWoItEVovjXRclg+DobOYQUylveAhZ+GLLlj20GUJDcnXefHlk7zkg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi3ffRKM6uKU5cliyN3VTZrIIGhPG+obs5nWA1TePOd7obHTiG
	Q0tsP0manM2g7SH0i9MaM83gDUGeLVSNXXMSVlOYpi4TO1ZDSxr7fZzskN1DRA8ETV0VrIBCxMo
	H8VK7xKPr8+Cas+hgR1RQQM8gPguk0QNeLUkbf5M0X61XTvtONzliFWew1A21+N1MFAv5c7Z0Iw
	==
X-Gm-Gg: AYBFou32FuSeP2U4LrTDj5XMT9XvTwdCJrBQX2HObfQJtcH+6tyJdTWqoLxSIm04uNs
	bWS2uKaSFiH4Y3STUUPWuJpocik+WQk/Di1L+LrG+wU8Yveg7XrjzNX9towjU0AAX7GpzbZKfKy
	cT617XU/VM8+9bJTlyc9Vq0zaSo1gpKmb+IwStNdC7DCcZmxthUM4wdywXEyIERlC5KsrH9TMKD
	kNo3Pw6W8MekWppmtRM2sOnxKea2XCpGTpB1s5LMpws0+u6kMi0uE1gUja+L4GggjetNr2FKBbY
	ho5fn+0yyXKO2AqOoIwZWVQz1IrurGLBk6FHRUHuiYzE+oPnGeRASVWO/iU7FVJf6mCUIYUrfgd
	WYFvKGjNqwrqpvKSRnAtDNMjhuE3xexP2Xzwwl+T9JpQvie4UBXudCFFpAcil8isUfFJ6mHDscZ
	ww9JTTqi6aTnmKztP05Q3Zi/l7/ule
X-Received: by 2002:ac8:5d0b:0:b0:535:a5f9:752e with SMTP id d75a77b69052e-53fcd389760mr58625421cf.77.1793224893714;
        Wed, 28 Oct 2026 15:01:33 -0700 (PDT)
X-Received: by 2002:ac8:5d0b:0:b0:535:a5f9:752e with SMTP id d75a77b69052e-53fcd389760mr58624751cf.77.1793224893034;
        Wed, 28 Oct 2026 15:01:33 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 06/10] tracing/osnoise: Split out per-cpu variable resets
Date: Wed, 28 Oct 2026 17:01:16 -0500
Message-ID: <20261028220120.4005187-7-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: G-AIBYtu54dlT-6oBJ4wpi4QrXViV4LY2WjJwpArpYw_1793224894
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Reset per-cpu state every time we stop a kthread or detach an fd, rather
than assume everything gets cleaned up properly, and avoiding the need
to explicitly zero individual fields.

Also, stop initializing tlat->thread lazily, add some debug checks to
detect an unclean state, and clear osnoise_data.tainted in
osn_var_reset().

The interrupt counters do not really need to be reset, and resetting them
on CPU detachment is racy because the hooks are still in place, so move
them out of the zero group.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: New patch.  Without this, I was seeing sampling = 1 leaking from a
kthread context to an fd context, which confused the latter into
operating with tlat->thread set to the old kernel thread, causing the fd
thread to hang.

v3: Reset the per-cpu context unconditionally in stop_kthread(), so sampling
gets cleared as noted in patch 3/9

v4: Only reset the cpu data if the fdd is a match

v6: Revive patch, but remove the interrupt counters from the zeroed area
---
 kernel/trace/trace_osnoise.c | 121 +++++++++++++++++------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ce6d02346ea4..f07b62a5ccb8 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -236,15 +236,15 @@ struct osnoise_variables {
 	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
+	struct osn_nmi		nmi;
+	struct osn_irq		irq;
+	struct osn_softirq	softirq;
+	struct osn_thread	thread;
+	local_t			int_counter;
 
 	struct_group(zero,
 		bool			sampling;
 		pid_t			pid;
-		struct osn_nmi		nmi;
-		struct osn_irq		irq;
-		struct osn_softirq	softirq;
-		struct osn_thread	thread;
-		local_t			int_counter;
 	);
 };
 
@@ -317,23 +317,19 @@ static inline struct timerlat_variables *cpu_tmr_var(int cpu)
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
@@ -341,38 +337,12 @@ static inline void tlat_var_reset(void)
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
@@ -407,6 +377,36 @@ static struct osnoise_data {
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
@@ -2023,7 +2023,7 @@ static void stop_kthread(unsigned int cpu)
 		osn_var->kthread = NULL;
 	}
 
-	osn_var->sampling = false;
+	osn_reset_cpu(cpu);
 	mutex_unlock(&osn_var->lock);
 }
 
@@ -2451,25 +2451,22 @@ static void timerlat_fd_detach(struct fd_data *fdd)
 	if (WARN_ON(fdd != osn->fdd))
 		return;
 
-	WARN_ON(osn->kthread);
 	WARN_ON(fdd->thread != tlat->thread);
 	tlat->detach = true;
 	wake_up_process(tlat->thread);
 
 	mutex_lock(&tlat->detach_lock);
 
-	osn->sampling = 0;
-	osn->pid = 0;
-
 	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
 	hrtimer_cancel(&tlat->timer);
 	put_task_struct(fdd->thread);
 
 	fdd->thread = NULL;
+	tlat->thread = NULL;
 	osn->fdd = NULL;
-	memset(&tlat->zero, 0, sizeof(tlat->zero));
 
 	mutex_unlock(&tlat->detach_lock);
+
 }
 
 static int timerlat_fd_open(struct inode *inode, struct file *file)
@@ -2530,8 +2527,6 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	fdd->cpu = cpu;
 	file->private_data = fdd;
 
-	tlat->tracing_thread = false;
-	tlat->thread = current;
 	get_task_struct(current);
 
 	osn_var->pid = current->pid;
@@ -2544,7 +2539,11 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	mutex_unlock(&interface_lock);
 
 	tlat = this_cpu_tmr_var();
-	tlat->count = 0;
+	WARN_ON(tlat->thread);
+	WARN_ON(tlat->count != 0);
+	WARN_ON(tlat->tracing_thread);
+	WARN_ON(osn_var->sampling);
+	tlat->thread = current;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 
@@ -2698,13 +2697,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
@@ -3018,7 +3017,7 @@ static int osnoise_workload_start(void)
 	if (osnoise_has_registered_instances())
 		return 0;
 
-	osn_var_reset_all();
+	osn_var_reset();
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.54.0

