Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072534D4CE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944830; cv=none; b=G/FvoNOGoJ+f3lRfzvubR9PTZ0qGWFluX31O/ne7KmXLQauTsAHb02Xk6/sHzRu1utBOQQQlXhf9yEdpxcOcZiJbeoOEtCSSrqXfwfs0tfiQizSklVroSttn1nGKUaZ3A8zM72fkZDndU1TloL/lHnQ1ATdCe8OWI0sfqot92eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944830; c=relaxed/simple;
	bh=BCnnmYPH/arFLybpWhhqkcOju1zCyct+gotU6uXimBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=o9QX5ZDkmypXNwFdnOsP6Ixr5r8Wyy4on1WdUpNkAYgkYYlq4mUUiWp3usDlT7ZUmcdtqvLKQsHiNPYCF6p1JkS9NAK0fmtLSqfOEekoBjt2qrtVDpSBATdDikRWg2xdKVIBgGIXkTHVDveDnHrzS1HD1metgniwocSJTH/oK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvEwbS7d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvEwbS7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VM8DFEDeSP3dJ5afV3y346Xur1F6vgbvguYXDH1MsM=;
	b=ZvEwbS7dByVjf3bFN/j1dyj3GYzXbq6YEj0ZHo4ah90B4gRy9MEcgVXVKPVydZv7AKtfjI
	JsabzPCS3S4p9gVrS4fhK/EKAKGZqZUMf0hh6I4GZvXU2d4dMo4yhUWVr2SH3osqXgMStO
	jbT94CIwxQ7kwg4omscs4c3Qb6KnCws=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-s5UDulgjMWCtlSqmTTv0Gw-1; Wed, 14 Oct 2026 02:27:02 +0000
X-MC-Unique: s5UDulgjMWCtlSqmTTv0Gw-1
X-Mimecast-MFC-AGG-ID: s5UDulgjMWCtlSqmTTv0Gw_1791944822
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5351f1b26e6so55269881cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944822; x=1792549622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VM8DFEDeSP3dJ5afV3y346Xur1F6vgbvguYXDH1MsM=;
        b=xmkY/54t2trFMz4ARlHCMz/g9gUFfkGxdNzo4XoBv8gVN/BndS3UKfoCLRDR8k8Spe
         oMEWAaSXhfmxwb0QcoUIBypQSRAh4QbZjLMabKXpPI/3axr/akoSeOkd7Y4wv5z7oPSq
         rh0exEjePy/x2IBb2Z4lKNsstZ9FccHwiuaq2Q6HlRgKFTGbV7aJccy3GLAUtwFrrTkG
         eSRwqe9D459aXcvk7HToRGROpOgFGM09w0Uo9SL8zECMC5YB/qSq7iv7q4Xr+LjXHa2d
         VQLuSXUBzHg+kweTp1VxlL62ar97r4RMCTi2ijKSivto5AuhV5D0HwTcX5KEaMh5MUJr
         avVQ==
X-Forwarded-Encrypted: i=1; AKwUvByIMGIC1gF1IaLfDCsIqdopGtA67LR6xsnRcXeBTYq/Fv+yo1yme14yGeWz5+2wspNAyhO0jx522AXB9ehafjAsBrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKEwhr5HmdfhknYX1/m+3U/yqE8CiowzXePVgNyQmwQfLBUhel
	4PbaAzPGEh86b5oa5vZBjC9GxTUSePAmh9vHPwfNLS0O6a8lhamTwGZlXf2O1SbW04cKjN7b8/E
	TqD2muRr1RpysqV0kllSK63pINDsj9KeuemNzx91wZwGODVC6oUVefESkxh+NY6PkN9vO8HrPlA
	==
X-Gm-Gg: AYBFou3/gSXvk58Nz0ztMxcRFkXcwq0UcjZPQ+gRA3L0eteT2r2ixD+MM/T8CvkcOfF
	MaKVTWGDuqpOLBnPS8FwMH/wwiJZVMCUuqwkFcc4DN2f1AaFLZig4yesVkvHP2XdwYwzWUbCkUt
	ItZG2zK4Kr9ihJ0K7TyISdl9jqpoC/L9The7eEk47YMYMslDrl0p8ZfPvFnnAE3NJIMNtYKM1mv
	gwJDUP53kK+2T+8fDbLXMl1UNzVQuKjOwpIMj1oBuxdlPCJl4z2RK6tut2pFIOTWSMIG6MN/o6X
	TCmyIHsKr9rPqJ7pwJUIoI7tBZ/UsOWD92uduUbOzZ8Bme4EynoUe3mWLauJMow1z90K63LoriZ
	sDcU5JtfshL8ry6fmJkN9nArw31iXa8W1CIMAGGRmU64HWHYzbToTSdY=
X-Received: by 2002:a05:622a:4c11:b0:535:70b4:3f7c with SMTP id d75a77b69052e-5359fe3d475mr204959021cf.66.1791944821817;
        Tue, 13 Oct 2026 19:27:01 -0700 (PDT)
X-Received: by 2002:a05:622a:4c11:b0:535:70b4:3f7c with SMTP id d75a77b69052e-5359fe3d475mr204958901cf.66.1791944821349;
        Tue, 13 Oct 2026 19:27:01 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 6/9] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Tue, 13 Oct 2026 21:26:37 -0500
Message-ID: <20261014022640.695786-7-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ooiq8LbQFSnGfoFpH7QzjgTPkrLHi1EgQGmYJs_rJoo_1791944822
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

