Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552082;
	b=vPbM4vasD9mtczTcDTpDlc4bsn4B0b6HU2LpoMtKyMDK476i2lQyPIzmb7wOBpIgR/Tr
	 OFkVaO85tyNS72K2bszm0tleK4gqlp7kcIwX5zvwQ0hwkHAU+VVsDTI+LA3i8PMf3LHjK
	 E9XIcmgAgTeawG+pt/bm69cdcE3N2jn5De35a0mwkqdEqClS8QXWAiBVRux42Tb16x8I8
	 hZXoe5/2J71Jc7ntfY4T3MhMy78wGAe+gkuLWK3vCL3pGo2Z6U1ETK+VCQLq+8XJuvhdL
	 zoC+oQh5kSIn8cdPeInYwlJ0iaFddACsRx+mXEgh7EdOPZzLniq7gaAMd+UcMfPB7Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552082;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=pNqu1q1BPP3r/nLQrdHSO/Pf61FJosz3Noh/oBK0wrY=;
	b=QRIJK61Pkoh1fMKszESZM4yNRyL8esb0KLsqfW9Vw5mVwqTaW235bFFfExPigt/k8LB4
	 acGCVqejMdDgE0XDibciArwR5RENjlqozq2+LBU4iiGrmcAPf8wJPlLel0SfvOPOulS4+
	 oVjdry+1VB7jz44Aem3PSTXMw5PmbvHD1hMUhGFWs5vaN7bcSuFgLRe1S0iTbIE405Tyb
	 b77udMt+oIy2EWObZJ9JTwu4P7/L2bhwqeJXrw92kDNAUI26vf9+r2AUj5eyOVOu2GWi0
	 ACIac382BRCYmrIMw+Wc6clOIsA/lNnxUGjx82VI7RQYmxmZFZWpkzScFOCGGtp0gIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J98v5kmj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143D606A883
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9143D606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J98v5kmj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNqu1q1BPP3r/nLQrdHSO/Pf61FJosz3Noh/oBK0wrY=;
	b=J98v5kmjUyKC/f2dIVAfw/bCtdCMJfmVX9d8TB5WCj9quiGmNKqvh9eHLCyySKx+qMCxOI
	p2zlc+3jPqhheI3JlPNDowpXLQCY1RmGHUeVaqQjJ7Bxi6TUC3iHMHnugyIqGLFOmM241s
	JJ16P1glb3ltJHteTz86mk/ph74iRs0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-JD3IfNOVMKe4XqCwAB3qIQ-1; Fri, 13 Nov 2026 01:41:19 -0500
X-MC-Unique: JD3IfNOVMKe4XqCwAB3qIQ-1
X-Mimecast-MFC-AGG-ID: JD3IfNOVMKe4XqCwAB3qIQ_1794552078
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-717000c7761so408386eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552078; x=1795156878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pNqu1q1BPP3r/nLQrdHSO/Pf61FJosz3Noh/oBK0wrY=;
        b=KoW/Sqam2Uz2JXySRLu5Av4A7PHVTDszPkdAtKmdB9RsX+TY8kW1yAKTUC5xtB/UJ6
         mngF/Z1PvJlsKrZpqdK4kAPbTM3X3i6OvhzutwOylmVGouqqbc9DUppGPhG7hMNFSTGZ
         ijlpfIYA1IOMWltxjxzqG3hUeruFaN5387O3689qcQV/6/B1qcCqcCUt7f8PJ2ZNs1vz
         TfGoh19tJzwEjN/syCpZZ02KJ8ZvO/Im4m6ui0EcI2n23aV/a3xcyLsPPXP8AQ4YJbAm
         KIk9cIilz96k1I/1TiEGLtOqUCN72NqH5CU3ZhlUFdPD5AK8mAdzykAIqVwmluOkfhZo
         KJIg==
X-Forwarded-Encrypted: i=1; AL+hErEIowy6O5Mxxei0t+h+IS6y0eB7WmR3e/CkiE9UvguoGVnkH4s1buPdVAnVX6un83j+cmKcuCZ1cRj8kS+7R4EpHsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PopgRUBp+DCPyjjFASIPwuCb0G29JMoQZ5hkyBHF5pZv5t9XC
	80URz/hCa19Hmqv1jhWRzPwXfxTC44GlGEag/yQCragLuuU3B07JhHQ5SPt69UDQYvR4nBwUCGU
	BowzMZlun9IedJC/PQgGzHTyiv6lhypTzQ+lFpmm7DiR2OZtInkR6boeZLlUfv/S5VqRTWpgGqg
	==
X-Gm-Gg: AYBFou20Ke4JYJ5+FqZCCbOaSaHe+BbEORSEDizhdQJzi/4Meeh+9zrjUUfT5xMEMEw
	sDbT7r1/nQTUA4WDvtPKJnmD51ZReAF8Cf1h2YNYf9rin7j2ifQrMe5aU/vkfr4qSlVz1wINv35
	1e5MWvzlNH0yOGKxRmQUvRDeuqgZYijMT43ua4AW/oLLA18fb8CiXvFZJOitp28BaTkwVfTEQs1
	p2+BxnwLIUWJ6mOgsw3S4byP2cFWGhOYfR2bKW64CTFQ88x8w84Hw+5q61Sig5NNv65YPnlMC6q
	hWDC8T0Nd45ELstRztx+ynLAOA/SbsEiRnrX/cpdHdn8K/qjCTTmi848qnRswtaX8tm2Xip4D9y
	I2axPG7EM0GCoLh3lWAZCTM5nB1mpyLfyb5U8v8OuchnrCE2ykcR6IVjrXvOvQlsU/NsEEGYQyd
	XjUgT5G1ypIAl9RusF+wgTdZz8U+r+
X-Received: by 2002:a05:6820:1c98:b0:716:d143:4692 with SMTP id 006d021491bc7-71ab50b23e5mr861175eaf.33.1794552078292;
        Thu, 12 Nov 2026 22:41:18 -0800 (PST)
X-Received: by 2002:a05:6820:1c98:b0:716:d143:4692 with SMTP id 006d021491bc7-71ab50b23e5mr861162eaf.33.1794552077791;
        Thu, 12 Nov 2026 22:41:17 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:17 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 08/10] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Fri, 13 Nov 2026 00:41:01 -0600
Message-ID: <20261113064103.3041704-9-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fxWNMNcvnDWH9ScLSnJhZfOz-pe_BMDQy4ZxwlVyX4U_1794552078
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
index a81992c937fb..b2b9db69692d 100644
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
@@ -2558,21 +2549,7 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	tlat->thread = current;
 
 	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-
-	/*
-	 * Setup is done.
-	 */
-	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
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
2.56.0

