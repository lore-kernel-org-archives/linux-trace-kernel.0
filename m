Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552084;
	b=C1s06SBpxJSsYqc1rZ4WMiFg5hAFpYx3/Rb/kZaepWeDQFDLk2zmSC4ZN3oMpLCtfF/q
	 xCOs3rYmZ0XIPKEwm00gj/SDbDONdbOplbhRO29dB8lG9rDBLejJOrkOnS4sso/IaMCIa
	 pFuzznVDMea7pKEAS24S9uDXeXpJBxKmLgY7NpJAWrJ+S9UZPYSKquz09zhtsTjfAtrH0
	 USXS5VnU7kKpSj0XaQQylqfmgSGvy26H+1FHddA/GiYmEjWOule6NmOmTGfObVKyGgfw5
	 xZ7mgwQfcSowGQPY8NXS/2BOLNdtyUYdEcHQ862hWuEEFsBtwRk/zXSC+lFHMA3wKmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552084;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=HsTg2RAwYgCXTCZ0mBZpLn2I6dfTUd1MDf7T5bGpkWo=;
	b=xy07/hIv2NTfqDPDYlL24kj9CGhl9gg/ml6cGpbewxW/3aJiuVS19K2lWOCthm5LgIYx
	 f6Nl7flkAev1ZbhvPqeVkkVcCcUEKG47jOdrjGG0Z0orb35rdfVs8MCK2vijAO0NcXXeq
	 Yr90sAl9Nuy+KuMgxk2x7Sr242Sca3EpJNAvyWtkBiCuf/ItNXaQUGqHvEfJ9pMMiLHVI
	 CLxWg4YIOZIiq/t8djSd6JdtCiSWzeDVfilt+qZ/RlKUyx6Aa6kRxNEdz8hHoOrUVhG9Q
	 DDcYLxpPmQiAzC98hKS9r9WZrGntRYIZckWkhxsinE9+gxB+MlQxweoyFR5E9CDWbKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfPnTSH7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234C606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F234C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfPnTSH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsTg2RAwYgCXTCZ0mBZpLn2I6dfTUd1MDf7T5bGpkWo=;
	b=bfPnTSH7VAUfXWbTsdCc31c6MO1po2KuoEHT7lRa7zOXZGCWjJ/hCuRYmn71jjpYjfP2FZ
	dPaFtbPHvKCfUkXyPHeAcSQ1i8sVAFhRnPDOpSxYmf8bRhENAKbHV+KylgEOxua5nCRgCl
	NGQUZe4Huh/qoGENXu3rWm/hMAVdfxk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-M8d5KR60N1CpRwMeoY4bsA-1; Fri, 13 Nov 2026 01:41:21 -0500
X-MC-Unique: M8d5KR60N1CpRwMeoY4bsA-1
X-Mimecast-MFC-AGG-ID: M8d5KR60N1CpRwMeoY4bsA_1794552080
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-86289dc426aso667492a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552080; x=1795156880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsTg2RAwYgCXTCZ0mBZpLn2I6dfTUd1MDf7T5bGpkWo=;
        b=URzZm+6/qEpbkEhnvrrJWgEC7Hzg6/JXTxDkjtObY35yG3DRB/xZi6O1uesFsy/He8
         wqevpOsyotgLLWqu/fQvScX7c2nlCLi8cEudwV28L7gdsdKCsiQ3Pt0ehWsvan9XgMhD
         8v75uSk+PhRU0w8cpuh1MMJrflvAOke5Ql2rg0a7bKEGnaeeOSUh3GtqAJn+7uxv0JZC
         V0Wh2j81Wfgidy4fRgRp/5TN6xPcEIK3SQ8HZv+kC83AqkHvRgANzKexWsLh3a3Mwuqz
         yAeLpAejzNdTKeiOWYzCq/nTuttxRwFB1avRWZCoIp39LS8EDjvesfFYk9L+8Jch+erX
         MsCA==
X-Forwarded-Encrypted: i=1; AL+hErEcOypKL5XSJk11nNUZAJ+4Yj9wyu4BoZXDbnB1AfsgJzKiHh1S6n5AAz/kg4mEFchjfXGah8ptZewxuO27ZP+4JD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z88LneZW6/o/4mRf/s/Uu9ttnh4L8q+uTLjL0ZKtR0t5esnCKtF
	LZjn4SPwi2HLc2VasNQupVhS+hMre0cpqzhqv2hM9liNxLMHQ+tv6vQEdnTqdzLyRL9DOBRtXaD
	TuU4Nxyk8+KIFuWQ0aLteune99NvBiyG1Ddjc9At5zcYJcyiZolxUHIMmqj+H8ODQrweBVZ4ZIQ
	==
X-Gm-Gg: AYBFou1QxwBZet/HXCV0Dn/icbvzaSf22A1Wot6boHvu1YKYkEJt9NOQjHcpJ0HJXmy
	s2Hj9A5DkqKyBzmFGFFyepGyFMdIpZQmm4SGTnjimk3nAnvs8YnUb00aCthYdo9rjAW39+RWffl
	bWZs7/+tRj9NgxUUiQI1CJOzW84lsWJhJJfKaF0tFEnF+O654GMv8Zfkc0V+G08LYjeUBP6UcMG
	FGAtdCxu7AYnMS2QwZE/HY/e2dl285WzcgDXGfj9iziJSQtG4aR9EAaykooScrLthYotNy4HCBE
	S2fpEq7r3ZxitTfMbrfaqD2pFJIEDvnJeh+O9lEspz9VtV9G3AMORbfEkT4+4Zd2cgxzBna7myX
	evjYechAEZO3/aoOgRP6W7qhQxHfx3ZZ+veztwPftJDP/CESLTTpl6C9edwTOouzRX2u6/G/Pne
	2vmtENDdDATJ74/ZqjkuNZOs4qG2X8
X-Received: by 2002:a05:6830:2b27:b0:817:c566:93a9 with SMTP id 46e09a7af769-86152750233mr3582881a34.22.1794552080487;
        Thu, 12 Nov 2026 22:41:20 -0800 (PST)
X-Received: by 2002:a05:6830:2b27:b0:817:c566:93a9 with SMTP id 46e09a7af769-86152750233mr3582876a34.22.1794552080065;
        Thu, 12 Nov 2026 22:41:20 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:19 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 10/10] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Fri, 13 Nov 2026 00:41:03 -0600
Message-ID: <20261113064103.3041704-11-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yXn1eCXbsK88iStCv0KS0Acz1eyNnEyuemDsg8blpcw_1794552080
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
index 4fbad6ab2adf..3876e8cb51d8 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2507,7 +2507,8 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * This file is accessible only if timerlat is enabled, and
 	 * NO_OSNOISE_WORKLOAD is set.
 	 */
-	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options))
+	if (!osnoise_has_registered_instances() || !timerlat_enabled() ||
+	    test_bit(OSN_WORKLOAD, &osnoise_options))
 		return -EINVAL;
 
 	guard(migrate)();
-- 
2.56.0

