Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549A2749C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606180; cv=none; b=HKYowSRiyCK63hG5PGDCXOUmmRN06hwP+7Q8RPCzc05cbnFuIsYUP1aF/+mtVsepF7keO9Swq7VETz2aHgB36pAAD3jDxliO0kck54BPSuRQHryRpjNgHdGfUfqHJov4kU+EFkZnELncP5IO4ZwG7+HaMzihuy1iO0aBsYxtt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606180; c=relaxed/simple;
	bh=uydx0NfvR9oHoUSL2+1kP4u1iqJstPdTDcwaWmoIU4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uEyRzBlzIryW1g/MwHmLnac04zm/jYgZnlNkUTdl8srJ4CSmPN1GGJOxyZJrn9LdcwXDMBNP2TfTwC063YWlwunEnPOL5b30MAvfkTJ48Oca0eLqKwuVwVVmXhUAHhlA58AdCmX0U/AicWN8jIgXzabRBA0jTjwLPOvempIM9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cT2UPRHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cT2UPRHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787606177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saDw8qJnLAeBrS0avcXXP2y/beBvgy23uIQc1I8SaRg=;
	b=cT2UPRHQARsWXZRMnEiwPmDYMTTJIlRr7xb8vFyecNQLIjNvfCrT506H72FwNGsODYi/R2
	YXMijIuFY1fgd+lX3Thy2mVS8jG76HacNLtJ5Zs5M4h/l5ShfuvRXzjs/Xe3JHzc6VHNJa
	Q36jWDzO6uTLjDNN1zaGN2aoUMN9pDw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-tOSF1sdKMieztCJX0MiDbQ-1; Mon, 24 Aug 2026 17:16:15 -0400
X-MC-Unique: tOSF1sdKMieztCJX0MiDbQ-1
X-Mimecast-MFC-AGG-ID: tOSF1sdKMieztCJX0MiDbQ_1787606175
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8eac2620cb0so41655536d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606175; x=1788210975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=saDw8qJnLAeBrS0avcXXP2y/beBvgy23uIQc1I8SaRg=;
        b=spbSIXd30otwQTHGXZxNi1vG+eLYMV9gRC2GSA9mZTetv2XTuoZCJZDkiic1mQ8o81
         6YP8ABoDsSC7Nx60M+diA6EvKX6GZpXWui9H/mPn3ZBg5iLvjjqjlqCIVCNWCSt9FzNf
         ETCTkIyKq/yba4fxuWsU8UbmOMXKCL6C5eXCTjAyPLxar2duxlcOGBu3h6JJGr3vPVmN
         gndQ+ElO0rKeOlB83Fb3eSrUJx1ZqG8w2UWL4PM9u11Bhvzp396D2vyZqneKHatR2Pwn
         vyZFG5iMorYKxpxPbKmoG97SBpo2tUA2Gakr8FY/bXtNEn8BCf9JrhA+IhvEJbDxqwYY
         P9AA==
X-Forwarded-Encrypted: i=1; AHgh+RrBbLC2S2SeJ9IgawaS+nDm8xaBvIFo1Y6z6uiJG2GgJIZukT5gmaCqpg3OPPs5Dnyb9nRljvGqbSnPQs5VeD7fUN0=@vger.kernel.org
X-Gm-Message-State: AFuF++kZver+di0SUIgyRaYn+upjzLcxJAtouCKIIWDGABpiD5PoIwGO
	t7m8SsdLD7DoY4mOOkC7NkK4LEw25pw3qPUYWsSUqNuUXNJMJSj/GI9iZ8I9suD/4ZkRnqahEoY
	tQ3mv+unUMPHpADlQSkQUV6mxc19sFdVTiKtTW4ZqzMbOFQQalNA1QWCe71JDKMLvYbU/gcHVag
	==
X-Gm-Gg: AR+sD11PLma0YqOGh/ON1bzxTPtr6gg86A6v8Go3NmmIFygEaE5vzbX3CYD8Sk2NqBL
	KBdmvxvOvwMnRVGAxpuM6BemO2jgmGu5k/f4iXdbtlAoJyh+OWSQXLaHj62DjW9DmxFTDKHyzis
	CsPtGrKXhON8HPXgPj7FXO2SUrUZAlHttrFsdN0p2ASnKdyYyN3w0Assl6DeKU79nix1ebCvKOs
	jTMq6ZoPNSfASmJCygwnni89dv5HEB+5t1Z8R5+HAuDGaVjxbfqcTS1ansBllv295vxqb9UJP+u
	WHB7fSZQYWphhGduT8eObpI7XTErPi9u1R1xSYc0ZGdozceb+SBitCCD9HuaefHtUjVRZ8raXtC
	9LO5C0sdr9OZSHF4leAPqhckYStnMcZEE
X-Received: by 2002:a05:6214:4993:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90cb78f7853mr19800366d6.15.1787606174787;
        Mon, 24 Aug 2026 14:16:14 -0700 (PDT)
X-Received: by 2002:a05:6214:4993:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90cb78f7853mr19799636d6.15.1787606174204;
        Mon, 24 Aug 2026 14:16:14 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93931452sm71832556d6.26.2026.08.24.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:16:11 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/4] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Mon, 24 Aug 2026 16:15:44 -0500
Message-ID: <20260824211544.3984835-5-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824211544.3984835-1-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gcXJBoMFW5ufggUDokfBz7FT4dCjhj70bcx4xcnlK9s_1787606175
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
Do we really need that interface_lock in osnoise_sleep()?  Technically
we should probably be grabbing it every time we access osnoise_data, but
we don't seem to do so anywhere else.  Perhaps this was due to concerns
about the atomicity of "period - runtime", but that's just synchronization
theater given that userspace has no way of writing to both atomically.

In any case, we shouldn't use the same lock for protecting osnoise_data
members that we use for major reconfiguration procedures.
---
 kernel/trace/trace_osnoise.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0f27af6ade3e..3d12ce8a591e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2466,16 +2466,14 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	long cpu = (long) inode->i_cdev;
 	int ret = 0;
 
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
 
 	migrate_disable();
 
@@ -2524,7 +2522,6 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * Setup is done.
 	 */
 	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
 
 	tlat = this_cpu_tmr_var();
 	tlat->count = 0;
@@ -2536,7 +2533,6 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 
 err:
 	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
 	migrate_enable();
 	return ret;
 };
-- 
2.54.0

