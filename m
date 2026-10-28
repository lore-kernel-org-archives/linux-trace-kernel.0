Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224901;
	b=QU+zNbm2b44gPN40AbWmNe3c2eAAtZQBCczoXKRFq2mrdWiYSDKi8El6YqbadJ4AIian
	 NziPNervwaIPmuBaVTfd6aC/Tnmn4PyRQpuemOJ5mSyMBLYAC4F2FsN2BBfqO/oIlEpfr
	 PBXPU7GhxWCHvuTkyuDMKK4oQGJXkIapiAoTwJMWDYm0fOze6iDX5T07udiuc+DMgH/Au
	 +COfzSD/x2ZdbcO37v3vjLJYsJdsvAg/DkBWU2oaNm9hcQG3qxMXYPe4YJ/9HCM9FHpW3
	 OdzV4B4plIF2nCNbHtGetAdKGcraSKqM5p2rDoO8eSXGZ2DGNvZO205oRunj8GnI+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224901;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=2hOwY94Tc8up6DQsiUeKQ/0fLL1I9lHupQl8kRabjJ8=;
	b=k2bfQ9ZJSiD/Ta442fzkpfBE9vVx+Rc1dexMc0TnkngSUofULS2Gj7YfDtBAb4IIPXV5
	 OpTV7yK63Mn5QS2W6MQOizlqC702x5zkx1g+CaCW/hLHREtvTaULmFYf5YO0ypw6noT0D
	 ZspOznlokM9m+A+rLxVQ05OSaTz2CEVxbwOj5fNVL3UESctlgFxN6lKJZ+6jdCnQIbyPk
	 H03MkQfd/YnNRU7witwSn4dEznC80DihORbz2VkYmefLI9qvhlVQaWV+FSrOjfwIx0aS7
	 dZayFhM/7RgVn1vGVezkIPUTK7MhHFbhe1tfeMb7K7BMruKFLFKKOarcVR+cGnDgg1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPcgk9wM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EB606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPcgk9wM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hOwY94Tc8up6DQsiUeKQ/0fLL1I9lHupQl8kRabjJ8=;
	b=hPcgk9wMSGwnW3T0jsjrogKlic/AGf9r02NjYEiryFjFMPUcCnFe2Ec09lfT0YE5E3Rrhi
	0EJaM5EziLS+gVYUMxVCinsuA5iyV2sZdyXV1j/OrqAvG3N5viebTdtScqmtgQ/0U2Q3Ue
	KlveuhdSoLXlFOdq6tQ+Ct7F3voCSCs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-DbXGF6hzMNymn3Yc3heu2w-1; Wed, 28 Oct 2026 18:01:39 -0400
X-MC-Unique: DbXGF6hzMNymn3Yc3heu2w-1
X-Mimecast-MFC-AGG-ID: DbXGF6hzMNymn3Yc3heu2w_1793224898
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53661e036a2so31237421cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224898; x=1793829698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hOwY94Tc8up6DQsiUeKQ/0fLL1I9lHupQl8kRabjJ8=;
        b=UN49VhquHuoiuYTQax8D4zf05f7hO+68TznyF0XzRsY5wyQH3WXQViisOUUVLju23z
         +USMnFbZQg2hbeBgdy/z1LCypESI91qlYKY8abj0ICq9yCu/izp7oxlnKhUG1UOH6iwS
         iM9KVqlRUb/kb4dyVeTQ1Lgmagrd0jixB6MlAl0yJi8NNyjpRW6WpKbKy1c/CZpluEKS
         ZYxTI5nmDpReyP1bLpRpxalbgYA4DLgnwmqhrLRT9I0L6fDKq0VmwuytBNKYcJ+FOost
         i6c7ZU+fQVCdW7LAEggqvrquCQGbquE3T2AI5thjO4BX6MkY4nIui6b5k/2PMH9MuqVY
         oy/g==
X-Forwarded-Encrypted: i=1; AKwUvByo/BczDjydhgQq1/NkyCVZ4HtBq9ce7gdtCqFi7OF5aUfzqW/SRHGCwaBbZ9qoo17817CYqJCb2V0UBRrZjq2PFCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg7SpR8mAc0GlB3U1seza7nTrI3zvq9pDsxbQxVi/C1b7dxsAD
	jWiu+DZUbGruQWTJnrGX/meAoqEHA9+mZUK+gQVh4PU7hR8TexPT2XiJ1DUrhkAasij7aqM/qNp
	33JSf2+0JxnPUizOSsFRWUOY+hObMyyokBT2nXVh/OaHz0fCkmE02gPSx1+VSOG9oZe6JagkgwQ
	==
X-Gm-Gg: AYBFou0B6X1AW8rUfBKwG+Idk5OQyVScMBVGkKfkw6mxngNBBmUZwPpcna9v7SL8AFO
	5onw1MEEilgpBJBlAyifNTSQMnxuTlIewiTbEjcmfJitwcoKu7+vXS9bSJ7ELUgprRpqr/+Pnh0
	B7jfkRJhbaPDwvHfT4/vfZuigiLV+uzwcgPoAyEMnHps5LZnLiN+HGt/Xq3925wq0WvA+pugjmf
	uq/MqQ2vW1WT2WX8KvAQRcisL8BY01HJLdU8WS2lvdwPD8jybPEEawZfxjHsPLMA/PST2qUyja5
	ileZ9egBO4GwiH9u3jxCXN5Kyq9MXu6bFMKQcFdsiyhfLlo59x92mdUFcPtoGdxaTBuQF1VQf3x
	NsAgdZR3U/xuzSv1poYWA1VBrHFxrRPxebfYu0asBMJ1s0LbonFq+UF5FeJ9advwsWSh/BLauBh
	sZWEyc//lYDDeG9B7fJb2reeY3gkRi
X-Received: by 2002:ac8:5ac5:0:b0:52f:ab8f:43d9 with SMTP id d75a77b69052e-53fcb50a1f5mr66183211cf.22.1793224898212;
        Wed, 28 Oct 2026 15:01:38 -0700 (PDT)
X-Received: by 2002:ac8:5ac5:0:b0:52f:ab8f:43d9 with SMTP id d75a77b69052e-53fcb50a1f5mr66182401cf.22.1793224897542;
        Wed, 28 Oct 2026 15:01:37 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:37 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 10/10] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Wed, 28 Oct 2026 17:01:20 -0500
Message-ID: <20261028220120.4005187-11-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fo4l65JP1dFCvl_UwqFlwGgFnRjJ7gxaqRLkgb0Wfts_1793224898
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
index ff4744c0701e..4617c12072c7 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2502,7 +2502,8 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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

