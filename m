Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C41385535
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599052; cv=none; b=YKEmzgdAjkLAt0W+bm+vFBdLeCsWuMJVOSRmW3+drSOB0jh7rGA489d8DC6b3BL72MxAc9OEQM9FwDrcp00hnd2HWueyNtTFPWI/zTM0y1MoB9rziL3Sx84IrP2R5vJ4Ci3+akiu2E4rv7NyBEbN9Lj97tb45k/r9J9sSz9KOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599052; c=relaxed/simple;
	bh=3KBzRBu0Wa4ExB7pzULRL8NWBKQlfFIKR2s1Eo5aUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=S3uIBVueLaMH10p920oxt0FO+0MeUf8Wp0xmBVm978YwY/pg0TgWRODqjnSBM6SsX1Hkv2DQiBjxJOxlRdffujwLGoRa45jqRqa230dDR/AwclgW/8bJ0wbsCREp6hatKvD3pAxZQ7uswJxT2hrrkdx77IbbpOKEIOU9ZmImuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7ZvB7RG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7ZvB7RG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcWi+z5bacRI+6K+CfzVtCsEL3Febj3y52gxM38dpmo=;
	b=H7ZvB7RGuaLMUygo5NpP0s1sG8YRpSgKSUZK2eoYVejz/abjEWpU/IwXFGRihVcOsO05Pp
	rvFcrt9oreMIGvqlHYSw6B3gzahX+3b1dxkrmITNZ93OXB6GFjJpfcctDYazQmaU+peTw5
	urv1WtsH6HP/IujFlXNXivJQfX7d/os=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-RpA0n2hFNgirkmNVfWTxfQ-1; Sat, 10 Oct 2026 02:24:08 +0000
X-MC-Unique: RpA0n2hFNgirkmNVfWTxfQ-1
X-Mimecast-MFC-AGG-ID: RpA0n2hFNgirkmNVfWTxfQ_1791599048
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5350bf63ba3so9392531cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599048; x=1792203848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcWi+z5bacRI+6K+CfzVtCsEL3Febj3y52gxM38dpmo=;
        b=Ogk2XgUzJZ47W7tZGG9QW5GPtnHvQJTO+DNQu9AANy0mt3Zq8J7ACWkR2EYBPEPf4J
         2SD2l1VxkkPjY7sBDySje65F+V3+hWU2JYBUT2AoepgSUYHWjAI8rB58xZWXhH25SGwP
         99G5jVGJZwivICQQsgfbZ6pGplNizXVRs+2lT6X0LuDhsxBghPSn7HZahQKOWg8Y9ZV+
         kylEdHaiRYtAdOUPOpQuW7GV2l0EMri8/b0Tuhw/NFRpE9eYeFMLXzeNcdXLkHkE+dCV
         w7NE51l4TholDrC0sbV7b7w68Wk9aZ6vPGWV8RgO4B2hha1jzv99X0m2QuaaVHpAQWAs
         ufBw==
X-Forwarded-Encrypted: i=1; AKwUvBz082YzyRli+Jg7jk30yUgTq2fh67JI6WIauw1zvbHvHDIygupe5BUT8rDwVcsbWpM2fqXWAGBerk+f19Rx8e40WkM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXzUnlV3FQYG/8aTHs+xG27aw4Q3zf007TDR+sv74UH9A+6xzS
	6MuSB0zTsX0tQCCMYxwxQaMNTt9RB0vcWf+Lvvy3UtJRMHU+G3sKFxPZcXdasqRtqiJxOGR82vY
	jGsM3DR7tsXDvUKw5ej8uaPFa3BSUWsId/mS6jomoeBeZyFOduMC92DhqtTnvWnwA5I906DihWQ
	==
X-Gm-Gg: AYBFou1gAxdvtXocdpLK/EdCqPNc9E+2qHvaCMe4bjMXyOOufjwvVfrn+0nhvhMz2U9
	6jaJ2vvXUYS0oMDHI2hFbgDD5oxI2pek91xD98gzK4tZ91L5p1m/tew/naIKO8Jf+Q9yzBZm3uU
	G2mBCNRaZFEZM1kQlcT2hQ4a0QCHB3VgZceCSaJU85hdHuAqaOfkuJ4xMi9i55fkUYIL6cdJ7CL
	E8v3dN02U/8ePBcrX+psg34prWCb6VVJUVC2E6FAHXEW/XGfqsMqxrDTMANF0FIBM9mCc1oe/Mb
	XErlqAJC+vZBarXGt1z5hY4uHaYkHk7CsSSlk2+BHRvCpB+JNwDPCUVaxHlUauwgaJORG9q08aH
	ofQoA5TUH3voFdAcPLs/U6hY690l7qzet3Y7rmUrEIjVzj5CJtoRR+k8=
X-Received: by 2002:a05:622a:4813:b0:533:2717:6221 with SMTP id d75a77b69052e-5359fb406e4mr58101811cf.31.1791599048208;
        Fri, 09 Oct 2026 19:24:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4813:b0:533:2717:6221 with SMTP id d75a77b69052e-5359fb406e4mr58101651cf.31.1791599047788;
        Fri, 09 Oct 2026 19:24:07 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:07 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 6/9] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Fri,  9 Oct 2026 21:23:35 -0500
Message-ID: <20261010022338.2507589-7-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: k1tE4YtcbYhtpJg8EZZMKWnwqREf2hR8IaPAeMsf9Uo_1791599048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This prevents a user fd from being opened when osnoise_options_write()
has already stopped threads but not yet set OSN_WORKLOAD, and matches what
all callers of start_kthread() do.

The original intent was probably for interface_lock to cover things like
this, but it never covered the full race window, and currently can't
due to lock order issues stemming from using interface_lock in
osnoise_sleep().  There does not appear to be any remaining reason
to take interface_lock in timerlat_fd_open(), so remove it.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: convert rest of function to guards

Do we really need that interface_lock in osnoise_sleep()?  Technically
we should probably be grabbing it every time we access osnoise_data, but
we don't seem to do so anywhere else.  Perhaps this was due to concerns
about the atomicity of "period - runtime", but that's just synchronization
theater given that userspace has no way of writing to both atomically.

In any case, we shouldn't use the same lock for protecting osnoise_data
members that we use for major reconfiguration procedures.
---
 kernel/trace/trace_osnoise.c | 43 +++++++++---------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 92b1216d5740..eaecd56492e3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2497,28 +2497,23 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	struct osnoise_variables *osn_var;
 	struct timerlat_variables *tlat;
 	long cpu = (long) inode->i_cdev;
-	int ret = 0;
 
-	mutex_lock(&interface_lock);
+	guard(mutex)(&trace_types_lock);
 
 	/*
 	 * This file is accessible only if timerlat is enabled, and
 	 * NO_OSNOISE_WORKLOAD is set.
 	 */
-	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options)) {
-		mutex_unlock(&interface_lock);
+	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options))
 		return -EINVAL;
-	}
 
-	migrate_disable();
+	guard(migrate)();
 
 	osn_var = this_cpu_osn_var();
-	mutex_lock(&osn_var->lock);
+	guard(mutex)(&osn_var->lock);
 
-	if (osn_var->fdd) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (osn_var->fdd)
+		return -EBUSY;
 
 	WARN_ON_ONCE(osn_var->kthread);
 
@@ -2529,16 +2524,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * worth doing this basic acceptance test to avoid obviusly wrong
 	 * setup.
 	 */
-	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id()) {
-		ret = -EPERM;
-		goto err;
-	}
+	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id())
+		return -EPERM;
 
 	fdd = kmalloc(sizeof(*fdd), GFP_KERNEL);
-	if (!fdd) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!fdd)
+		return -ENOMEM;
 
 	/*
 	 * From now on, it is good to go.
@@ -2553,25 +2544,11 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	osn_var->pid = current->pid;
 	osn_var->fdd = fdd;
 
-	/*
-	 * Setup is done.
-	 */
-	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
-
 	tlat = this_cpu_tmr_var();
 	tlat->count = 0;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-
-	migrate_enable();
 	return 0;
-
-err:
-	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
-	migrate_enable();
-	return ret;
 };
 
 /*
-- 
2.54.0

