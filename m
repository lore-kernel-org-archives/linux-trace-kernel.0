Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806989;
	b=SEXAzxm9QsjfEVR1kCd3rzZCmC06Fw43+QaZ5DJNUfRVa3OOLQJTnR64/evMhtuoJdVi
	 YZqsP+FEhVs2FiClXSiFrMBMzFVkL91z9ncuzZVI8v9vVqZLkg6Wy3cPgyZey0DAQAlkW
	 Hh5x2j9MucXxQ0QMAIy+hE8nlt18MVYyBXhK7ucz5gHC9UG9UHH1yZgxFDtBDwzrJL0LZ
	 i4XXBBLDA/d4r67RT2EVcxeZvf71DAU3Yj7HhITqPsXTjNIEwvVKqeQD8ydwfTRxN0M+Q
	 ndl1zsJsrEjVIyhJxDTgIbRBxz/ht9SnsnWDzzCW+dOz6gyd5MHZ5R74pX/F2L0GXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806989;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=ptIrGizZshsvGJKgeUiPH1eVv8xIBcCNL3pCOMblS64=;
	b=XzMYWKKsheuQuKEhyPVQqk0Ezy8EQnni6y0pUtcBNHfIMw2dugm1uiCzD9LQCq0f9bKi
	 CbyZzTpujdWEUWt2R00dtJqpbCBJhLXKyF8qXVaKmbQiD1xvAMYTXhcUDCRGc8pVH0uoJ
	 iXgKbWnSGofpAjqb5wTYQYi6+kJQmsy9zyzBIwi9COguA4ZsLdodWsAIEcnNHJfLy00QC
	 najvrDr0yiHdYHze9DvMZo+yhVmX7VOjzVlKZEBKRrgVsZyrypQ4lC355Tl0W/q4secMb
	 kbCDdfB3Zca/h6kPFEgS8uJCzU7ruKcyWn+REU9NdDqeHXCM/Z0puhvwzW5Y9G0WKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EyWB7PbO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50258606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50258606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EyWB7PbO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptIrGizZshsvGJKgeUiPH1eVv8xIBcCNL3pCOMblS64=;
	b=EyWB7PbO3DQfwzwKKXjVC/85DjBqdGQTZ71IlHKTGCQjwybpG53X6QfB/4WYrsjJnbTF8v
	2jmn8oFsDLMFM4BSTsgRiDrlieZrBcD3dOzYOLxSNj7SgZgEu/GpF33B6yFw2NdnJYt2oW
	7gHrv9KroY8hWf08lj3a3OjFQPUJwsE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665--HR5yLLQMZeUigPK49kgTA-1; Fri, 23 Oct 2026 21:56:26 -0400
X-MC-Unique: -HR5yLLQMZeUigPK49kgTA-1
X-Mimecast-MFC-AGG-ID: -HR5yLLQMZeUigPK49kgTA_1792806986
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b937ecbb4so31382466d6.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806986; x=1793411786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ptIrGizZshsvGJKgeUiPH1eVv8xIBcCNL3pCOMblS64=;
        b=RLOXP6UpuPuHgPr4WbgncN1TM6pF6CnHIlhBpW1v0iMVoBE6r3eKXytkzmAHsXEK3L
         tf/fx8nHRqI0/A7clZ0EIDfN3Emr0QOHDOgxTxawpqKXrE7hgzISJq44r1Uk5kpnbike
         DFKH1vvyo/lT3FE+/Up9nFfl+sO5GSSeNlsDbLsI/WFwcZW0c1kOYgcfZQ4f3YFdifYO
         XNXF7JH9pFdZUkgNOYVyAeDkXm1B0kD7OMzGDZWlIBuzOfC3T8k8wkHq1KIKxDp2Ajtc
         ZVpu9i0lj8nhJOgXVOkYdjwLUzs/D9vAXfqexQmIZ94jW99Bd2fr8/2PaL8FjBkO36Fc
         IUwA==
X-Forwarded-Encrypted: i=1; AKwUvBwa599J269Ckcy9f6BwNyz83WNM0ijxKF5vCCME70zhxeNXpk578HA89dqjfENtWgkhuqmYEXdrBAyv6V72eLusTrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsxZVMMnoVMhKxD//7vuNXi9FuqzTVJz7RRLmGXC+GYmnbUeis
	HfFii+r/Bn2fVm5h6m2bNzVlZG4FM7XR1BuKq8Sv6nVIBC/7pJZ7tdK8dbE9pL/wC30+dHXOWRy
	WZ1k9kr5rbJkG3P1mqo6ZPrp1gukUKSoCMe7H3KgOavOyyMv7KwIBchVOjKaSr1icLLueDEAvJw
	==
X-Gm-Gg: AYBFou0q8XV+8lGVGJXpFG4U9IYrJssmPsxEX7m7aRYmLLl4SrOicSKUJipe8tzu/mg
	7aMJ4+IJ5cnHp7atxl8bKNDIlg8wjUlVBcUQE9+iRqQw1Y3Ztz8H1AAXDBK9iSeC1B9jiYoXx8S
	jrm+G6R04Qbdun7gx334/D+N4OJ9EFqmL2FpokeXRegvJNVYIlUPLo/kqewRb3PcvvrgKIJVlP2
	NoFejznxJ9cOysFKJMc4lW5vuHrHl6YxoTDHMpt2nLu2GUQZluZjH9MAivpElEyXeMdx9p8LBte
	txk3+d+AgSKtSd2AVhPN7z1FJrdXASOAhkGwvvLFbw8Ue+0MdvazzrxnTO8ppJGWFEo7NceKjhx
	o9LUpX0vzmBCofYx6ReHv0b5t2cHF8Dh3bukUvr3479sQqfh+RtMpWOY=
X-Received: by 2002:a05:6214:2681:b0:914:501c:6d08 with SMTP id 6a1803df08f44-91c48e38bcamr13100116d6.14.1792806986157;
        Fri, 23 Oct 2026 18:56:26 -0700 (PDT)
X-Received: by 2002:a05:6214:2681:b0:914:501c:6d08 with SMTP id 6a1803df08f44-91c48e38bcamr13099906d6.14.1792806985473;
        Fri, 23 Oct 2026 18:56:25 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:24 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 6/8] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Fri, 23 Oct 2026 20:56:12 -0500
Message-ID: <20261024015614.3095251-7-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024015614.3095251-1-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: L3NqOLUzZGBVUU9vlih948wCrx67WJpJ77edjRyV8l4_1792806986
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
index 9206123ad445..9c7470ef4b03 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2494,29 +2494,24 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
 	tlat = this_cpu_tmr_var();
-	mutex_lock(&osn_var->lock);
+	guard(mutex)(&osn_var->lock);
 
-	if (osn_var->fdd) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (osn_var->fdd)
+		return -EBUSY;
 
 	WARN_ON_ONCE(osn_var->kthread);
 
@@ -2527,16 +2522,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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

