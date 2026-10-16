Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AE3BED11
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133849; cv=none; b=BfOv5jRE8jlaaySbCEmvzwFLvT4rPnIY6TrJ4rV29MDuMBWl9UrydepCdtpwQZXfiH9zjiYn55jZb40+8dl6SJp+IliS3JkZw28E8lDzrND3ijgXJXr92hGyyc/CVyw564u7w2kVDhGQxU7s4Jz/TISdl1sXgDpA42vk/kfQe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133849; c=relaxed/simple;
	bh=kQd5P4S1KIO7wdKGlrQgW7S7g/qEN4cgrzSOX0pj/yU=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Date:Subject; b=BPtjVpDfyE5ooMDOm3f/daealwFgSBZyBLynFqRwwPV/CqapWk4yYsuiECpZXKxQTqeq3fdwmRDZPRT9+z9JCm7Bmpe3XfF0zHN++xDV75xBCPVuDhztM3SL1qH1mkSWJuw1jFg6IxRmiJNEFHgYHlxyCjpuWdU4MAKAbythF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM64pemc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM64pemc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1948571a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792133847; x=1792738647; darn=vger.kernel.org;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kQd5P4S1KIO7wdKGlrQgW7S7g/qEN4cgrzSOX0pj/yU=;
        b=bM64pemcKr167oviw9n8GYfUUYAKXD/CNdrWfxRQl26gVv7NviKo22S2N1P4wOVeAw
         W1uhb4qVU56Rpo1CRHn8flmV79PT6T8Hta+zMCCbg6V3zt/+8ScC0Ym1m7fJzxBRu+D4
         hhvgvVDDS39lD0XX2iP4rfW+BwtVcA91rNB5EUzcS0f1gR+s5ELxzUHgpXTt6ugkNAK0
         L1gJIIZDW4otvwgpaESk1odx4bNpbadiFc8I6zDdvkDchxdjhwpmPILxz6wvMzzbnPEu
         p/DqJR5WA4shBQjv5i2QKAJKQnm/MtoQhQxz584Kot4YO+rXZTplLXoBRjUXPZsMbo8N
         FvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133847; x=1792738647;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kQd5P4S1KIO7wdKGlrQgW7S7g/qEN4cgrzSOX0pj/yU=;
        b=afKZ+yNK617uxOrn/vKGZlnzU0cc7R7Agamefwwc4LIYJIAj4y2XVcU32is0x7jlqj
         wMwibuRCnf/pWvzHPgkU3XoBNR6EBAz8zy/I2mm6Rv6H22xmVzysuiyfXghhn+eznrIc
         x4Q1DvOwNXAHlIqcIGHt+xwxCr1jbM3DQFgHZGiHpfa3dIYP88jZ1WxP5avRGni98vhr
         jLdIYOOz7q6vICAxtik6n5gRKZtoH610rtMh5nhC3IYlM0KdqMUphmeO6kpTdoqMi4kn
         jJ0y2aBqOI1U37ZXW9mN7hjOm9hFqcBdEVRpW4RP7T+2UPkPW8gJgswKWjc+drb1F0BW
         0U9g==
X-Forwarded-Encrypted: i=1; AKwUvBwIizVnnH9WboOJ/cPLSY8aohJp9qgPkOWJqyA9zKeTXljanMSe32Rlke/bQhuFSkNdfYipXsLeKHJhvsLRpmJ/FXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDMYK+nC2Xo/57LtuXtQYndLVB4KXM/RCJ8AeG37VVfeyZfETf
	yCpmaS8BnXJZ0ZhZWrzSKBxd1kmprwBxsuBsLIKKxUt/DJue2wpyJvHJ
X-Gm-Gg: AYBFou2nCbg84sWIsc0k7w4iECmTfJMYhdCDnc33ZVgsw3xM571b/WSL8Q1Johj02Fv
	f8Y3xh2lbaMCdJC3q/TXQPc1HW4rtEMuKG052lqzA3yNcCF9Y5rOtgUGlm6UDaIxMa/b0Bg5D6q
	+kBG7ZFwyapWpf6D8MwnySXcY3t5903LSvxqivwsioo8n0SqtTibB+DwOElRly3dLKYywTzVrOp
	FrJtRfRGC97ZRP9zZdgtXDx/B3ZPrwV3Wsp4/MqtTEbHbTm1rLLWZhW7eIYkY3Kkr61xBWt6SOB
	0uP33pjPdqi3gRDOxjvjpLNgypbKooAKR2/x+nD43gKnP43NdmvKRCGb6OZ5P+yFzO611UZ4Vv9
	4y4zGq52nwugqD4ZM1Y+k29t+D+XrKQK4Vdagd1OtOzBts2amyiKuDukOEJjwIMwBZhP4/fCQTX
	O0zpDDjLFlpHWIF74nr8O6CtAL4oHsMskzgf+aKgtCMgxunhsxTf1tuwUtHYjJvI8A8eCYpw+AG
	xNjatc=
X-Received: by 2002:a17:90b:5444:b0:3aa:f2c4:12df with SMTP id 98e67ed59e1d1-3ab3a236ca5mr18057089a91.9.1792133846192;
        Thu, 15 Oct 2026 23:57:26 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm1242020a91.0.2026.10.15.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:57:25 -0700 (PDT)
Message-ID: <6ad1cad5.856c1b21.18f9b7.a2c3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Haoran Wang <haoranwangsec@gmail.com>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, haoranwangsec@gmail.com
Date: Fri, 16 Oct 2026 14:57:22 +0800
Subject: [PATCH] tracing: reject trace events with an empty TP_STRUCT__entry

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9yYW4gV2FuZyA8aGFvcmFud2FuZ3NlY0BnbWFpbC5jb20+
CkRhdGU6IEZyaSwgMTYgT2N0IDIwMjYgMTU6MTA6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0
cmFjaW5nOiByZWplY3QgdHJhY2UgZXZlbnRzIHdpdGggYW4gZW1wdHkgVFBfU1RSVUNUX19lbnRy
eQoKdHJhY2VfZXZlbnRfZ2V0X29mZnNldHMoKSB1bmNvbmRpdGlvbmFsbHkgZGVyZWZlcmVuY2Vz
IHRoZSBmaXJzdCBlbnRyeSBvZgphbiBldmVudCBjbGFzcydzIGZpZWxkcyBsaXN0IHRocm91Z2gg
bGlzdF9maXJzdF9lbnRyeSgpLiAgQSB0cmFjZXBvaW50CnRoYXQgZGVjbGFyZXMgYW4gZW1wdHkg
VFBfU1RSVUNUX19lbnRyeSBuZXZlciBwb3B1bGF0ZXMgdGhhdCBsaXN0LiBJdHMKZmllbGRzX2Fy
cmF5IGhvbGRzIG9ubHkgdGhlIHRlcm1pbmF0aW5nIHNlbnRpbmVsLCBzbyBsaXN0X2ZpcnN0X2Vu
dHJ5KCkKcmV0dXJucyB0aGUgbGlzdCBoZWFkIGl0c2VsZiBhbmQgdGhlIGZvbGxvd2luZyB0YWls
LT5vZmZzZXQgKyB0YWlsLT5zaXplCnJlYWRzIG1lbW9yeSBwYXN0IHN0cnVjdCB0cmFjZV9ldmVu
dF9jbGFzcy4gIFRoZSBjb3JydXB0ZWQgcmVzdWx0IGlzCnRoZW4gdXNlZCBhcyB0aGUgQlBGIGNv
bnRleHQtc2l6ZSBib3VuZCBpbiBfX3BlcmZfZXZlbnRfc2V0X2JwZl9wcm9nKCksCndoaWNoIGxl
dHMgY29udGV4dC1yZWFkaW5nIEJQRiBwcm9ncmFtcyBhdHRhY2ggdG8gYSB6ZXJvLWZpZWxkIHRy
YWNlcG9pbnQKd2hlbiB0aGV5IHNob3VsZCBiZSByZWplY3RlZCB3aXRoIC1FQUNDRVMuCgpSZWpl
Y3Qgc3VjaCBldmVudHMgYXQgcmVnaXN0cmF0aW9uIHRvIGZpeCB0aGlzIGJ1Zy4gZXZlbnRfaW5p
dCgpIGlzIHRoZQp1bml2ZXJzYWwgY2hva2Vwb2ludCBpbnZva2VkIGZvciBib3RoIGVhcmx5LWJv
b3QgYW5kIG1vZHVsZSBldmVudHMsIGFuZAppdHMgcmV0dXJuIGlzIGVuZm9yY2VkIGJ5IF9fcmVn
aXN0ZXJfZXZlbnQoKSwgd2hpY2ggcmVmdXNlcyB0byBhZGQgdGhlIGNhbGwKdG8gZnRyYWNlX2V2
ZW50cy4gIEFuIGV2ZW50IHdob3NlIGZpZWxkc19hcnJheVswXS50eXBlIGlzIE5VTEwgKHRoZQpl
bXB0eS1UUF9TVFJVQ1RfX2VudHJ5IHNlbnRpbmVsKSBpcyByZWplY3RlZCB3aXRoIC1FSU5WQUwg
YmVmb3JlCnRyYWNlX2V2ZW50X2dldF9vZmZzZXRzKCkgY2FuIGJlIHJlYWNoZWQuCgpTaWduZWQt
b2ZmLWJ5OiBIYW9yYW4gV2FuZyA8aGFvcmFud2FuZ3NlY0BnbWFpbC5jb20+Ci0tLQoga2VybmVs
L3RyYWNlL3RyYWNlX2V2ZW50cy5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jIGIva2VybmVs
L3RyYWNlL3RyYWNlX2V2ZW50cy5jCi0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHMuYwor
KysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMKQEAgLTMyNzksNiArMzI3OSwxMCBAQCBz
dGF0aWMgaW50IGV2ZW50X2luaXQoc3RydWN0IHRyYWNlX2V2ZW50X2NhbGwgKmNhbGwpCiAJaWYg
KFdBUk5fT04oIW5hbWUpKQogCQlyZXR1cm4gLUVJTlZBTDsKIAorCWlmIChjYWxsLT5jbGFzcy0+
ZmllbGRzX2FycmF5ICYmCisJICAgICFjYWxsLT5jbGFzcy0+ZmllbGRzX2FycmF5WzBdLnR5cGUp
CisJCXJldHVybiAtRUlOVkFMOworCiAJaWYgKGNhbGwtPmNsYXNzLT5yYXdfaW5pdCkgewogCQly
ZXQgPSBjYWxsLT5jbGFzcy0+cmF3X2luaXQoY2FsbCk7CiAJCWlmIChyZXQgPCAwICYmIHJldCAh
PSAtRU5PU1lTKQotLSAKMi40My4wCg==
