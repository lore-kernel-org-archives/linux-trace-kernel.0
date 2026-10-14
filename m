Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD737416F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944834; cv=none; b=affGujdr6xIcq4ZRX7H4isooGgF3TUvuSUMAaIKhMJzJOhheVT0PaXZGaAIiL9ZRJYsZkqck9Ps0XZcaD67oL+9OV2EizCSR4KuX98L01CtuiKOGCwGWa9ymIDkUkqhD/ExRHonb+CL19n38XYIb7vhvn4wQvSVt+EA4FgyFP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944834; c=relaxed/simple;
	bh=fuSY2BrKKzivVHD0zzTyf8FxDHUAaWnGwul49FsWV2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AcrNxSCgIxIhpflsvAlhsCAAzeaezSIi7API2isVk7RXb4SV4DvNX1faF0xVAInIIiZ1QqhdoHMlJQz2ef59YAtlcFbCqwjFSR2ReBjsnPMyvVCpUXISKLKNC9Ekr3azyrgr1KxZooBQRIoRbTsTlXXVMOfbQ6PljLbabjCoxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjfQVChs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjfQVChs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHrtH1n4lqRV3ZpkuhjrUXP9vwpNb4y3cJeXmKKLl+w=;
	b=MjfQVChsv4WlLAwWnSdMZ+ZkRGBF7CnYffCuKeZIdJ6+YyAq9rMVg7AbU64Mkwb9le76IZ
	E4s2KqeZ45dJ+t6LZ/vwViwS0mRMRl3ZglizWlEywBe8yJ6aqOBcmaUKo+vVvaSWkX8wZg
	0DfGavQvVO42kKFcNs5B8DUsTN4n7t8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-f9Q61QLqNJqiTy4P0A7kcg-1; Wed, 14 Oct 2026 02:27:04 +0000
X-MC-Unique: f9Q61QLqNJqiTy4P0A7kcg-1
X-Mimecast-MFC-AGG-ID: f9Q61QLqNJqiTy4P0A7kcg_1791944824
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338974c0ceso101008971cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944824; x=1792549624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHrtH1n4lqRV3ZpkuhjrUXP9vwpNb4y3cJeXmKKLl+w=;
        b=LL4T55FZhWh/RX1YnzX66Or4EKnwFuLlb/4p6xLOHkzWiBi53EE0yq9Ciot9i6MqN5
         os6aKvo+uZjfBoaJKxMnzioWuQ9d7csZ/b43RxSGrd0aDsl151HfRjBojwS53FvsZNzR
         p9sSYpxygnFKCCsjA1tu0FIKXTfNwmyCAGt9XtnIYL7fraO8153LSJ1d1v0FKVw2iR7R
         NfKOJT9cVXeXdl4qaFEiU9RwcmdnPrZhnGZy2nq/PXrWtxoiieDoefXr6nXf2qIjazjD
         hSgt5ZLsvLWpxz21S0jLH19uCP1egExMhsfx5EzjI56p3w18GcW914Bdl4om1rVqQxJm
         Uh1A==
X-Forwarded-Encrypted: i=1; AKwUvBxeGJ69lopJ7rRQKUxI6xcWXQTOMNDHz9//NZO9WxX5fRrnifYH7Qs6XTeHGySlchW3b7L2ZYzxoMgYENlqbCPEnco=@vger.kernel.org
X-Gm-Message-State: AFq9FYILC6P3BXQcR0g9gDSS2hLmBJ8+XDaiBd7wv2BAqL+DkHoB4P+6
	/kKPfS0vFtkdBFHc70DHvBcI6X9DC8R6+kWcNm+NF+NIZDr4C2LkgUoxTxGq8fH2ek1t1xFiMcn
	KPDwTlRjgnmsmyYSasxXrRMx6OGXagg3dI0aKY7N4pj3Qd4nrH8Ds18VbP0RTBgjwR5cI8kG/KA
	==
X-Gm-Gg: AYBFou1pfjZB+TSBkKi6sFDIHXv3Lk38mjkX13KMMa7y/y+mnzJL5WZMMYkiOk3zX6w
	RSpL5qtpc4AtRiU/wN4Z3bbkIFFe7PtbE622z0gvHf1hBE9OL/H63/dyyOkAZNd1vhCQq0rnPI0
	fKs23aDqoSaJ1XpNeaPHBUzZRWmQ36ZRApcctHlLI/GHn2YTCUBSa9qgV/w+zuQ7trD1TJHwmUE
	NNWLYI3xZWdNsgy/eXVbWVB6CAfddNT7cW6ENCMxwnO9m2zMOIAroUX0R4RGxV6Y0RAiiieZun+
	5haNHJtPU4xqiTt9NI1vSTv4fGTjxYXiagchD7khhOOsr4tQlYqGZWMYOnsTzZGICTJolxd1ekN
	NvtK/Y58V8gTv6ssUn1vxWTw/Fky3FFS22T/rG+FhdwbAgT8S7nerubU=
X-Received: by 2002:a05:622a:350:b0:535:a5f7:d588 with SMTP id d75a77b69052e-535a5f7de1bmr219480121cf.66.1791944824218;
        Tue, 13 Oct 2026 19:27:04 -0700 (PDT)
X-Received: by 2002:a05:622a:350:b0:535:a5f7:d588 with SMTP id d75a77b69052e-535a5f7de1bmr219480041cf.66.1791944823869;
        Tue, 13 Oct 2026 19:27:03 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:27:03 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 9/9] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Tue, 13 Oct 2026 21:26:40 -0500
Message-ID: <20261014022640.695786-10-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: bDIf5gxDNF5u3mibOSQa0L3VKhX8LRW1GiTKwqEjrq0_1791944824
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Besides being generally bad, allowing an fd open when there are no active
instances means that osnoise_options_write() and osnoise_cpus_write() will
leave it active during reconfiguration, causing at least WARN splats.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: new patch
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9ca45b0b8cb3..2511a9b763b9 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2506,7 +2506,8 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * This file is accessible only if timerlat is enabled, and
 	 * NO_OSNOISE_WORKLOAD is set.
 	 */
-	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options))
+	if (!osnoise_has_registered_instances() || !timerlat_enabled() ||
+	    test_bit(OSN_WORKLOAD, &osnoise_options))
 		return -EINVAL;
 
 	guard(migrate)();
-- 
2.54.0

