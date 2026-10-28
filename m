Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224905;
	b=btr42yl02MaXbA3GT1zJmvTzQQUUlbiqkqBpaY8uiAGipUPt2zaezjnXkKyzsGv/yr1+
	 E7B4aCaGdAf1xhP+icIk3d2GcDufs3BZOOox8uHWoGdNFOtGENKvozU5UExvp6oAtVN3s
	 XEPgayg2g0u/PObMI+rw50zwwH0Q5p5aRn2UKzU7+HD5+BbmnX+NiDwJhaVswYz5YzeMV
	 pb1Z8jPgUUbJc5ObwGN/5iOOkkxkwY+tsmkW7w/ox+dGWjHHv572N6fk70go7GAzv5eGS
	 hWAPZSrc5h+U2rKP3F9azgr2N6vPRXoa32pHXm8AbH93NkoyUB3qBmMUDDzyL/wqupA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=SOLevrhpF57aAWk8SI0yilfyzLUUVve7X6+kbGlvd5k=;
	b=JEd6lO1czIOJrcliQPGJVfxdRzZ/zfV+QqD9uwufXNA/UyiPYureyNSzjJdRRmSRlTUY
	 I7IqAsgHW2lABC5Pl9kzUVxama8B4T5sp8hU80KMJ1nbRijr6/fn71BOISVInaGF9cnfW
	 0ewExMnrVwOu+4fuNMDXvijeskinXiW8PmREzJRwawkEhY5dV5jXKzPhqttaME6lph81U
	 Wya2GraMp6iCoFvvUusV2RgeqpSSOxG6FxnWGq+U0PX3aAXTtCTp6Zib61nCMJSfmyECZ
	 vDDtVH6wPTIOsQgYBs6QBv8oLLjXPzVN9Nyq4O9VBc+/uFys4Kc/BrR8glK6pNPbm1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoHCVVW6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AC606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1AC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DoHCVVW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOLevrhpF57aAWk8SI0yilfyzLUUVve7X6+kbGlvd5k=;
	b=DoHCVVW6A44BCJVB7G5l8Wm9WD5Qxg7vTNsI8z94KYZXP1+C9J/V1MQYxAZ/rGuMH1JFvU
	5OECxVrx7GX3KL2ooB3puR4+6IGwkxSpdTcBUsLJBJBILdA+EBjcvT6qn7+eYbKoPhXugU
	nuko4juneHIzxWiyRfA6l5II9BY+xdE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-KzI6i-XMPKKJvPwL927tOw-1; Wed, 28 Oct 2026 18:01:43 -0400
X-MC-Unique: KzI6i-XMPKKJvPwL927tOw-1
X-Mimecast-MFC-AGG-ID: KzI6i-XMPKKJvPwL927tOw_1793224902
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-535066512b0so29430751cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224902; x=1793829702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOLevrhpF57aAWk8SI0yilfyzLUUVve7X6+kbGlvd5k=;
        b=1KaS3woUOTXB56E45KpYi+xXkkvzrumb9iv0/MvCFQE7MgiVanqKRQEiSZ4XHgaEPx
         ZH7FAS2fhhjSEZzvMYkqgMQOrhws7E3RBG3Wx95BgCiqkI4111qLDejZzN/nE8TiYdak
         gXrDMHWk4dxMUYaewQsLPVKnOshtYEVIEPeSnLm11KTfCxQKphGXLQazaJtxvLZaL7or
         NtKgoTEkQpaXw3y7WmKYWXb8380rcCzd/kl83QkC94aQrBOAhzio2uwmbodggEEphDly
         YYW35EiQS0DGekZ+4oDDhfo78+Wyf19LMeq+it1+rZqKuFUQJypjYp/iYhqr4Jrqd3cd
         P+gQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHLsmwYd/corWdrW/SduAHKXDalADO4zdLso9j2fEdZeGEkbC1nHXKVCO6LHZM+keFVE6HX70fL26niOto8CrcejA=@vger.kernel.org
X-Gm-Message-State: AFq9FYILdpfeZvSo4I/DQ6A+a2AeOq/og6X5yQ1O68x9xRID7bo6Khao
	DAnvLx38xYe4p5yV7qsXUa4Z6k8/OjtYLnE/nyfp7HL/jtSKzqzFVtBuXQcSoo+TmVqR5UumqG+
	agX9vqojbqNlPpn4gu8vlL/bMSqFOvXk6F8OfBLyudDQ9UUJx18RaJY/ufHPnzLfUEF1Ms93cjA
	==
X-Gm-Gg: AYBFou1H+5BCIZPLG9Rc5IfHaOaGxvNzEjYcmtO2CVMnlLma5VlXijHBeCGmr6ceyMQ
	2LBBFLCdxyT1DCoDr9nnM9R/e8RgREGf8xTvxhsR4tksrbRZ6SM+2looixSFvM4eWovXjest/pt
	Hd/TDPnGVggmumbweeCzYmp4lTH0jMG4CS59qpj20YARzhz4WJuATy4T41wswkZEyn62KSOVPTf
	sZ8W9ZHOGF+I3LGlk/bjpUvy5yZELNGpl9X+B7uk2mNkY0YgVYX+3ScHES+rsJAYN3dj47Xwxhf
	528EPfjv/2NphzqQSUjixxDOLqMM3Kom6cZw0lPUnaOOTKqZpCy8YOUDSdE8sS+bfInqvNnKeco
	XUI1V/E6XGsgO1gUH5giw3ZbM4hJx4iBTAeu5DAC4RZCF9b5+No5H+9zVpcqLp1O/v6qdC6KsfI
	u7mIs0bmGHRliwle4Av3rwaXRfJAH1
X-Received: by 2002:ac8:5c8d:0:b0:535:a5f8:a5c4 with SMTP id d75a77b69052e-53fcc7ca7d8mr58001691cf.68.1793224898231;
        Wed, 28 Oct 2026 15:01:38 -0700 (PDT)
X-Received: by 2002:ac8:5c8d:0:b0:535:a5f8:a5c4 with SMTP id d75a77b69052e-53fcc7ca7d8mr57998041cf.68.1793224894781;
        Wed, 28 Oct 2026 15:01:34 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:34 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 08/10] tracing/osnoise: Take trace_types_lock in timerlat_fd_open
Date: Wed, 28 Oct 2026 17:01:18 -0500
Message-ID: <20261028220120.4005187-9-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 27cnmwNA_ddXafk0F0KYdIFftVvBbUOWBZbK2CsKNmw_1793224902
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
index 614adac25a89..9e37733f7395 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2489,29 +2489,24 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
 
@@ -2522,16 +2517,12 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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
@@ -2546,12 +2537,6 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	osn_var->pid = current->pid;
 	osn_var->fdd = fdd;
 
-	/*
-	 * Setup is done.
-	 */
-	mutex_unlock(&osn_var->lock);
-	mutex_unlock(&interface_lock);
-
 	tlat = this_cpu_tmr_var();
 	WARN_ON(tlat->thread);
 	WARN_ON(tlat->count != 0);
@@ -2560,15 +2545,7 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	tlat->thread = current;
 
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

