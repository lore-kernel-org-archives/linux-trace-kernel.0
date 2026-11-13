Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552080;
	b=esJhaCOsOs31qxRS+76V6NgY373TnG8AD9b+nKKp45XqNMCoezmOgb50RpMC8ZtajQNj
	 Lgk0HpcQALPhUaOhHK3/M7QolTy6zwPjTCToRYfkyWdMTOtkOffJ2cUvfsbTQWhS7G8fe
	 8e8VVR1desf3XQ9IeguA4HO4lXFE9m6ssEf9Z/5oQpDJKVaA1UNqJkkHS16GrfJKgRXZe
	 EMcBVy8d2uPuLlJBFy1D9l3QaEA8IB0akyNQjVzed7Qw/CybQdLmSL0cnz6NjEUnozU5L
	 ZGMsBn5PrG5JCsb4+39qVs4n55KURYE/uONa9ZQYPqyvS6Gcfsw8K+f2I+mb5LBqWWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552080;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=zkZb7IuPg1tVs8hEcDW3HebBdAtBVWkpBNBed58KdRc=;
	b=JoAop2XwTafl6nO6Pz6D+IeD0uDWCsRod9AW0+rgWG1uEA+mxNLalrFZnVlm3mm8D80w
	 LxrNXJ3zSlKbvppANFZ9NrKKAmH5zzg3p5fLAfLRP7uCdw93QTogMjlrRBhJTyNQlU8Rv
	 E3i85uNgyzqWNbLFHxG6RXQLSIMTogbtVvKV/Ane2MGu9Fj+8xfImbFKzAbKlpL7kwTW2
	 uELDrkpIuvQCsBpGBfaIUe6rQcZO4/j3NvtzhAaCozTg4BhIHhNM7f/ZZSgcMFt171zKB
	 1eITWNiX1mUOwi5+9kbeh3RdtJbRp4frEyuZqtCgGD1QKByFL2g3V7zs3KJtnHFRsLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDNghujc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95823606A333
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95823606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDNghujc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkZb7IuPg1tVs8hEcDW3HebBdAtBVWkpBNBed58KdRc=;
	b=IDNghujcPrzUJgW/VEsIWPEje7ixVrq4LM9r1v6Gh8GlB91TOkTWy89Zo0XfMafpKCtOWO
	ajM7gJC+bjKj2UQ0S3RskdwXoLzt8fYZG75d96K6rxXAuuP6bVuCC6TGyOqT26tiCQvJHU
	OUE8m8f0sphkg+uS3fm6ha4EwljCF0s=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-JwdDoVg6NjyMRYzrXzlejA-1; Fri, 13 Nov 2026 01:41:17 -0500
X-MC-Unique: JwdDoVg6NjyMRYzrXzlejA-1
X-Mimecast-MFC-AGG-ID: JwdDoVg6NjyMRYzrXzlejA_1794552076
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-860e65f42a5so733198a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552076; x=1795156876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkZb7IuPg1tVs8hEcDW3HebBdAtBVWkpBNBed58KdRc=;
        b=ENVlM+rQPXdnGk5UK32LedV7uSdzz8Y22XGXBw2qDiTJ5e3XVApBLICypcS+piQbfn
         nl/GTSzTY3PKRNdH1f6FGy+yIcRA8L/wqfGueeG1uGJomNL9YWs3ZY1pFJkWQDOY1cGE
         QAweEqDhsELGrlH45bheNuwZ5TeWyeapGDDhKUISeTHVnNN/JeLb80BRR9WAfmay1DlP
         KU6b2v9tfAWHZGHI91iXue7WA6HUYlvNlF4zz6cj6/mvcSDjbexKjEFewUVnMV/OZsQ1
         6XL8kQ36PJYPKkqSK5kbV1vcBo5U4bTpJwIPL16ndxkAppEt5m+YbB/0edpC4+pn4JEx
         GoeA==
X-Forwarded-Encrypted: i=1; AL+hErFduXcWTxR9XvUQpU05097HGW/yNJk9mZ4o+/O3/rRWDZH6oaxMCbElkbtHCa1Yf2pI15mECgRXXLtxZ4xDjml+HzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zdjWD5gKrtVlJYV2N9ElMrnUU406Ub0QHQFfXYPU+CXAda51q
	7fWoDxKXTlfS2wEYQ+WBSLCouJWWyH4NXdbUhdrcVF+jtZQ82uH7o+x+GN5saNn5x9rIjJyXCuQ
	kxwqP0dgvkTJ2hHbQWJqg3Hxp+6v5YqI2NmxhP+y/aVUjd2r9llyWJXGbrWb7u7I2I+aZmFMpOA
	==
X-Gm-Gg: AYBFou1FMHHV4+4QBErJvIqsNcIUk2SjjCODH92gi/0NYl9UUGtYIBj7t4aclNEMvsi
	g0Y+x9XnElCrYJTstG2/YuJ+dCfVoqTgBKRNf7lOOBF1g8ha5VgIG8yGiio1lUgv9opkEZrEQvN
	ITE7JnDiA8HBSoewj8Ju46Ft82pSiczdVG1paLuGYnnrdITC+lGKiT5HI+M3RtK1AP1OfeoNb2s
	NywoEyACtpzGdiy4fES/saVIEV39EJ4c/mH+v0jKW205ZvM1vWip5kz9+Zd8qNDHRfTqKQksCN9
	vsRNGzc7Yfaqi/72z/nxCuK0HcZ7FV8vBhVbyPBkzbY++O5l257L8+ZxTTbK32KwJbZzs8aabi9
	Ijr0kzohPwTEbNKOwPv1AmVBVcRGSgx5TIBnC9g0xcDkR7khbYnV11CHASxaDtrooWd7ck5tooU
	xzJmvNXumTYYI/jjHdWA9wny3+Fb7j
X-Received: by 2002:a05:6830:91d:b0:80c:d34f:5f65 with SMTP id 46e09a7af769-8628991f062mr1743226a34.30.1794552075830;
        Thu, 12 Nov 2026 22:41:15 -0800 (PST)
X-Received: by 2002:a05:6830:91d:b0:80c:d34f:5f65 with SMTP id 46e09a7af769-8628991f062mr1743212a34.30.1794552075399;
        Thu, 12 Nov 2026 22:41:15 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:14 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 06/10] tracing/osnoise: Reset cleanup
Date: Fri, 13 Nov 2026 00:40:59 -0600
Message-ID: <20261113064103.3041704-7-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6kXb6_KuRJodipaDHJsH8KSk9vh3kAbKLf8VKyRAw5U_1794552076
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Reset per-cpu timerlat state every time we stop a kthread or detach an
fd, rather than assume everything gets cleaned up properly, and avoiding
the need to explicitly zero individual fields.

Also, stop initializing tlat->thread lazily, add some debug checks to
detect an unclean state, and clear osnoise_data.tainted in
osn_var_reset().

Combine the per-cpu tlat cleanup and clearing osn->sampling and osn->pid into
osn_reset_cpu(), which is called consistently regardless of the tracer mode.

Don't clear the rest of the osnoise per-cpu state except when the full
tracer has been reset, to avoid racing with interrupt trace hooks.

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

v7:
 - Go back to clearing interrupt counters on full tracer reset, explicily clearing
   osn->sampling and osn->pid only during cpu detachment.  The issue
   pointed out by Sashiko in v6, where we could have stale data after a
   detach, is still there but it is not a new issue and is out of scope
   for this patchset, and unlike v6 it doesn't persist across full tracer
   resets.
 - Use WARN_ON_ONCE consistently
---
 kernel/trace/trace_osnoise.c | 117 ++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 56 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e61f57230eef..8db0697b69e4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -237,9 +237,10 @@ struct osnoise_variables {
 	struct mutex		lock; /* covers kthread and fdd changes */
 	struct task_struct	*kthread;
 	struct fd_data		*fdd;
+	bool			sampling;
 
+	/* reset only when the entire tracer is restarted */
 	struct_group(zero,
-		bool			sampling;
 		pid_t			pid;
 		struct osn_nmi		nmi;
 		struct osn_irq		irq;
@@ -287,6 +288,7 @@ struct timerlat_variables {
 	 */
 	struct mutex		detach_lock;
 
+	/* reset on per-cpu detachment */
 	struct_group(zero,
 		struct task_struct	*thread;
 		struct hrtimer		timer;
@@ -318,23 +320,19 @@ static inline struct timerlat_variables *cpu_tmr_var(int cpu)
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
@@ -342,38 +340,12 @@ static inline void tlat_var_reset(void)
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
-		WARN_ON_ONCE(osn_var->kthread);
-		WARN_ON_ONCE(osn_var->fdd);
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
@@ -408,6 +380,39 @@ static struct osnoise_data {
 #endif
 };
 
+static inline void osn_reset_cpu(int cpu)
+{
+	struct osnoise_variables *osn = cpu_osn_var(cpu);
+
+	WARN_ON_ONCE(osn->kthread);
+	WARN_ON_ONCE(osn->fdd);
+
+	osn->sampling = false;
+	osn->pid = 0;
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
+		WARN_ON_ONCE(osn->kthread);
+		WARN_ON_ONCE(osn->fdd);
+		WARN_ON_ONCE(osn->sampling);
+		memset(&osn->zero, 0, sizeof(osn->zero));
+	}
+
+	tlat_var_reset();
+	osnoise_data.tainted = false;
+}
+
 #ifdef CONFIG_TIMERLAT_TRACER
 static inline bool timerlat_enabled(void)
 {
@@ -2024,7 +2029,7 @@ static void stop_kthread(unsigned int cpu)
 		osn_var->kthread = NULL;
 	}
 
-	osn_var->sampling = false;
+	osn_reset_cpu(cpu);
 	mutex_unlock(&osn_var->lock);
 }
 
@@ -2452,23 +2457,19 @@ static void timerlat_fd_detach(struct fd_data *fdd)
 	if (WARN_ON_ONCE(fdd != osn->fdd))
 		return;
 
-	WARN_ON_ONCE(osn->kthread);
 	WARN_ON_ONCE(fdd->thread != tlat->thread);
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
 }
@@ -2531,13 +2532,17 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	fdd->cpu = cpu;
 	file->private_data = fdd;
 
-	tlat->tracing_thread = false;
-	tlat->thread = current;
 	get_task_struct(current);
 
 	osn_var->pid = current->pid;
 	osn_var->fdd = fdd;
 
+	WARN_ON_ONCE(tlat->thread);
+	WARN_ON_ONCE(tlat->count != 0);
+	WARN_ON_ONCE(tlat->tracing_thread);
+	WARN_ON_ONCE(osn_var->sampling);
+	tlat->thread = current;
+
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 
 	/*
@@ -2682,13 +2687,13 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
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
@@ -3002,7 +3007,7 @@ static int osnoise_workload_start(void)
 	if (osnoise_has_registered_instances())
 		return 0;
 
-	osn_var_reset_all();
+	osn_var_reset();
 
 	retval = osnoise_hook_events();
 	if (retval)
-- 
2.56.0

