Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE347140F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015705; cv=none; b=iT2hVFXa9jk7MbU+0mXgSfQ7KklBDiKkErdEm8mKL5zun1M5SnNYgRFq1twsftGHVp0pj05c7yodMtgQ1qqYoxwUO/jPUMWx5KH42XTG+ciAwSfVO0Lenoc7k6NmIC0W5B6Jvp2G2dblj1kuYpUU2hJKTAWni3aBn4NNdUObmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015705; c=relaxed/simple;
	bh=BCnnmYPH/arFLybpWhhqkcOju1zCyct+gotU6uXimBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GQA6mTEl+bjblVfs95Ya24gQqZN+/iJMVdZpaF6P0FeDto0aYfN1c34Z9V0N/uILO7tm1aanuOJs5pvRTaPGZY63kD3l0caZCyyRBpBywFt4eEnfCuxbLFnUN9XrjO9P1PIUGVN/vHA0m8xu4RHmknnmu0uw+nvkz/6b8u3shhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJlbHJaF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJlbHJaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VM8DFEDeSP3dJ5afV3y346Xur1F6vgbvguYXDH1MsM=;
	b=NJlbHJaFZmJuy4NJOR9uya5FcJZlAASqE0hzumt3Uy/EU5TELLm9cvLshWw6Gk9yIoLGsw
	dk0usQHO6tDYIPR0B6lW5LffkipQNeIumdg44QtTCsUFXoA3s6gg06Fm2fSt1yFQvjIWMC
	2hril4Ig6LH5q1N5kbeFa+XK3gRKAh8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-TlhhjEp8NtC7BCk2nLgVIQ-1; Wed, 14 Oct 2026 22:08:22 +0000
X-MC-Unique: TlhhjEp8NtC7BCk2nLgVIQ-1
X-Mimecast-MFC-AGG-ID: TlhhjEp8NtC7BCk2nLgVIQ_1792015702
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53397338004so152383081cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015702; x=1792620502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VM8DFEDeSP3dJ5afV3y346Xur1F6vgbvguYXDH1MsM=;
        b=a2DVs8MQZFCq4rw8gJJ6Q0n3NZcp6VpqF0yG8/Y6K7X5arU/EvJm4fI8DGOjpRovct
         srBYPqRdW042O7muNUnh+a/3Le/XrIzjBy8QY4fh77iZHB7tUNx4CBVSG9w8uXaTwYfp
         LEcjsB5j6S5szJm/o60JwHukwWwfQIKhDT240KNR4jMIitZX8eFcBNw1LipJakall54d
         kSHx9w7Teby3IIEyCLmUAztl5DBAHlWPi0hKjLFTfwaIkm22lAFC2/JiuvJd8sVOhMxs
         id1gTU7gMmkYXDnkZdVTjNOjp1aO/CtXNRg6PfnWIEwZ94GnXda3SalYOZUI0Z4giaaq
         LGsg==
X-Forwarded-Encrypted: i=1; AKwUvBwt8VkAX72qekILoto9xCrxktorlbOe08sXf05yQE9rjhrMg1v4jJD9d7DNzppG/dBKYKSqgkv75JZe448i4iVhC6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGPlCyE2hSQVZYb/BS2168fnRtYUDMpP3QeHY+RwlIfpSNoPDe
	PqG1UuDGLxR3ri74sZ3kQHdfJsOsxfNMQnM30kqkJk8o6+bFQfxCW4iv6YJ8q4nlxyCTRI9gXmW
	N09aLPagxxtZqLLQZpmQD3EeelsYv4rj9UBpQx65ttX7z/CaS4IBQTg+MTigL2PWUp95/zbJIJQ
	==
X-Gm-Gg: AYBFou12xPzdIkIW427Txb82b7xEyuRlCXIL5le3zzOHcAnBYcXYswuO99B41nM7flh
	QlrlqpSGQtiBP8z0tlgCJ0xpoj3wiPJHhTk05vWTYFZC0KXVUYYuLJuWmIbIW3KmJzmd8NpOmCX
	p7nTzAKh27SY/O3rJJKNIdcrTdob4LVOWVN65ff+ufFvUzucJpoPlp0GahQ1KxJIaixCcF/Co/Y
	pyeq9sNNTvqp1a5zltQVYWlivhqsW4FiXzf1wh1zv42VG+zAERGMkwEe8o2e/7lBDOhdtepIT1s
	NPxMRrq4bB5Z6Tp0apI4KYhJ/shImSCl0HYuUvhKny+XVXcp9QQGBte7o9dk9lEofDGVg2JnZtZ
	He9e5bgKIa+SSccKy6gOp9skvMjdALLxpKRZ0sYi3DJPVdAS0AnBdnw4=
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id d75a77b69052e-5359fae42c4mr314828731cf.27.1792015701639;
        Wed, 14 Oct 2026 15:08:21 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id d75a77b69052e-5359fae42c4mr314828361cf.27.1792015701182;
        Wed, 14 Oct 2026 15:08:21 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:20 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 6/9] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Wed, 14 Oct 2026 17:07:56 -0500
Message-ID: <20261014220759.908839-7-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: FyVge2p8jpulYVwYlwtNKziGtBNRCP4oPa0TEc0xU84_1792015702
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
index 3da4f1f095df..22263e08b968 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2498,28 +2498,23 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
 
@@ -2530,16 +2525,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2554,25 +2545,11 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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

