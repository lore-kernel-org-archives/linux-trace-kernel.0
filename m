Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6F2D0614
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121600; cv=none; b=eg4X4mSEKRuF828d5PuJcNfeZhkvgHvZh5FWJgrsppI1fQuMLvk4aiksq37fAitaVgf2iUl7vqPA0jyB5m+tjFKweVejSktSTjGrW5i5Yjn6QDcTPLLSrYDSm9zxLn4T9tI7dBEpjCxnSoz57cpZeL4vYnj8XTMr+RB3sAgm3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121600; c=relaxed/simple;
	bh=DHdWukh4h7IvkZHXqIQiUR/IkL+1dqHZgnn7QdLDFkI=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Date:Subject; b=C1prJCR3e/K/NXsFn0764pNg/adPJoji/ZlgjUhLzQER+CTMc8jNAjgfF9yWSQNuA6YebQI0NjWjQiQjttz6rjUznhey0tC4g73bZ8c44t6t8/qqhvwvNMcGrlBhC+TXTVoJhaUhqfLf/RZFTNqO2nN/yVdWUN+jpR3c4gQX7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GADB8XMY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GADB8XMY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so3790260a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121598; x=1792726398; darn=vger.kernel.org;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHdWukh4h7IvkZHXqIQiUR/IkL+1dqHZgnn7QdLDFkI=;
        b=GADB8XMYA5/1SyF+O0r6Lk7t5UNsnS9UNnfvtbODPgLIWQ6Caf0HBV9v7RhCYsg+Wu
         UxB5jOSj3F8nSouUe7fZZ4gIFSsGhG+qfEUE07TveKwJwkIZk6RN1/W3E7cWRY9LarLi
         /37fXvBSr220wX/8sxA7ISTH8fPiqqHUG9tNO/fCMF5JeLKNzYBixOIS7tZiA1e+XG1e
         9UTyFZdAlWlfVvSpBCUCH1Hwr/DaGhn4zPkjNrQzX7CD5bHBnpPKbbpr/saGmEHSQBPQ
         MRDB2Tt+LMgGDAJ408bZchDTHWRapp4A9zB4ApGiXTYYer/wCJB8slA4N/3lkT/iUO/F
         pQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121598; x=1792726398;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DHdWukh4h7IvkZHXqIQiUR/IkL+1dqHZgnn7QdLDFkI=;
        b=Xz6TGZMVt142mVdTuKaq10+/MK/7sEBccWXxoaaeBul5txDlIxXUMtECO8QXDKI3pJ
         7sfRBd21VjSKIhr0awZ4y4INIFICt5VwLGgsMecyr/IW0J0lUcXvQe6xQaGuELH0SnM2
         11/9o8dKN8lCOCHJMSKiNfOpoRORglNPfPObiuIqOwQztDb8DdLh3xBc6etXbyWl2ddd
         0gbv91OkrMHuRTJgcTS1OvLMHRd8lXXQBprZlS+nNkshXMzezBIMXHlwPKYeQiczEja7
         BZ7EISAvdITU3TokKydZVmTHxSgyDFW2wdSW55VUKet7a9mif84271qnlf6CEwoRWPEE
         X7Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwnkDjL8TahAR21k4ZKXP36FONE83YqcWOK8xLNz1JY3gtjsDzkpd0pj0qx8LtvKNqe7Tw/pe5P5Xj7zcfJXkSrOCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW8cIR1SmAHOKSFvtZxcUxqfhIqSHzTg1zewPq13pg8ZHHgUHO
	PKR7Dcakhngjj7f2CIi0jBK1FFH9AWWjNC0AUEf+BcEmMgowcT31EuQMmzgj3+awl9M=
X-Gm-Gg: AYBFou2QZ6j5ETinbEKYt9a5d+tkKDOCTV+VymY62FBZK7BnJnBrCUbi3NuxXuPmn7b
	B2jNn18AaoCGHweB383MWyjwdJSfYKElgQthbcpGPZbai5zd27Z/cA46ilmbgXsoOsk+K1jH/eE
	pyolFSyrzVAuOGrTc8a2kak5IZ1YzH58WpkG2o9ELILSfSV1ZEB3PKtsKwii9y4/pYAmReVSm/b
	bjavSj4tp0B/mk9BEbxS1xFyjrCSIzD1/flLtM1DakC3Ep79TXPW5DXxLhfifn0z8vZp+836BaT
	jGJkWRnAtsx34ZMdL3MHOlhJcpOpWE4WNUfUBWFMydEzqEm3UUhOT17aB6yo9quwELjNjvLoXsn
	6GsbeB37dZCcFPSBqG52Pq4Ls3AFODruNLsjg8Vm/Ds4LL0LxZVPtdcnLKxF5VmM4KfHtelzBUk
	nKJh2lilW90FgvS052lBjBNn1kqvQEi4ISJzwVs8JUMEu/cSSyFsvqhBS5npkBsl/pAcBl1eUDf
	ORBbQ==
X-Received: by 2002:a17:90b:2ecc:b0:3ac:b3e5:426a with SMTP id 98e67ed59e1d1-3acb3e54485mr2244561a91.4.1792121597779;
        Thu, 15 Oct 2026 20:33:17 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm1950630a91.8.2026.10.15.20.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:33:17 -0700 (PDT)
Message-ID: <6ad19afd.a938ce27.16851e.3440@mx.google.com>
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
Date: Fri, 16 Oct 2026 11:33:13 +0800
Subject: [PATCH] tracing/syscalls: use copy_from_user for the faultable syscall buffer

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9yYW4gV2FuZyA8aGFvcmFud2FuZ3NlY0BnbWFpbC5jb20+
CkRhdGU6IFRodSwgMTYgT2N0IDIwMjYgMTA6MDA6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0
cmFjaW5nL3N5c2NhbGxzOiB1c2UgY29weV9mcm9tX3VzZXIgZm9yIHRoZSBmYXVsdGFibGUgc3lz
Y2FsbCBidWZmZXIKCnN5c2NhbGxfY29weV91c2VyX2FycmF5KCkgY29waWVzIHRoZSBidWZmZXIg
YXJndW1lbnQgb2YgZmF1bHRhYmxlCnN5c2NhbGxzICh3cml0ZSwgcHdyaXRlNjQsIC4uLikgd2l0
aCBfX2NvcHlfZnJvbV91c2VyKCksIHdoaWNoIHNraXBzCmFjY2Vzc19vaygpLiBVc2UgY29weV9m
cm9tX3VzZXIoKSBpbnN0ZWFkIHNvIGEgbm9uLXVzZXIgYWRkcmVzcyBpcwpyZWplY3RlZCBhbmQg
dGhlIGVudHJ5IGlzIHJlY29yZGVkIGFzIGZhdWx0ZWQuCgpJdCBjb3VsZCBiZSBhIHNlY3VyaXR5
IGNvbmNlcm4gZm9yIG1hY2hpbmVzIHRoYXQgdHJ1c3QgcGVyZiBhIGJpdCB0b28KbXVjaC4KClNp
Z25lZC1vZmYtYnk6IEhhb3JhbiBXYW5nIDxoYW9yYW53YW5nc2VjQGdtYWlsLmNvbT4KLS0tCiBr
ZXJuZWwvdHJhY2UvdHJhY2Vfc3lzY2FsbHMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFj
ZV9zeXNjYWxscy5jIGIva2VybmVsL3RyYWNlL3RyYWNlX3N5c2NhbGxzLmMKLS0tIGEva2VybmVs
L3RyYWNlL3RyYWNlX3N5c2NhbGxzLmMKKysrIGIva2VybmVsL3RyYWNlL3RyYWNlX3N5c2NhbGxz
LmMKQEAgLTY4Miw3ICs2ODIsNyBAQAogCiAJZm9yIChpbnQgaSA9IDA7IGkgPCBhcmdzLT51YXJn
czsgaSsrLCBidWYgKz0gU1lTQ0FMTF9GQVVMVF9BUkdfU1opIHsKIAkJcHRyID0gKGNoYXIgX191
c2VyICopYXJncy0+cHRyX2FycmF5W2ldOwotCQlyZXQgPSBfX2NvcHlfZnJvbV91c2VyKGJ1Ziwg
cHRyLCBzaXplKTsKKwkJcmV0ID0gY29weV9mcm9tX3VzZXIoYnVmLCBwdHIsIHNpemUpOwogCQlh
cmdzLT5yZWFkW2ldID0gcmV0ID8gLTEgOiBzaXplOwogCX0KIAlyZXR1cm4gMDsKLS0gCjIuNDMu
MAo=
