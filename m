Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173213FFAD7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144077; cv=none; b=g56d+1WLg8e/w1glEQL+aZzpL4FY00U9RyKK+61KtRREdEkIYvgIH8QrcLHUhHjyt3uNZvj/BMCc6cDYQ7VV2r2uC5WckC5nCII0/auQBtAYJSUyLdpsGEWaivtuAAWQyNzGTFFzlAtOsuAUoxFxQwtZzrZO1WHIwP+mRggH/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144077; c=relaxed/simple;
	bh=K851o75YbtR6vIMbLWAnHs9eoIWtRPb2jgeinaNj5V8=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Date:Subject; b=Bsss8CZ4gtfVChozQIabnFcVR2QtOG38sRpqwp00NMZ8KGBhZvg90LO7xRinsp7qI/tYJ4G7Z+DZvSE2YL6M1YCVvRuuY+GGASOjx569MSZFHpY3oH1/LcVdU8Obc0DbpOsgtAbgNxdhTZ9T+ZEoImo+hFoS5nIvVYBlZsrFR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi0Cg/ID; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi0Cg/ID"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so5141973a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792144075; x=1792748875; darn=vger.kernel.org;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K851o75YbtR6vIMbLWAnHs9eoIWtRPb2jgeinaNj5V8=;
        b=gi0Cg/IDa3bwUGDnBX91MAVFv1HsYbkDMWNyipX3JZqiF6JisLpDyHM46Sfv/hVrte
         w+oXr6wJNuHmhtcbbnehUMXxByHQB99WhJQIIZFTK1JJr/1fjLIa3RaFGGQG9Q3xAYb6
         v60DEDPzqQJ4f7h7mDtbvgv3SKBT5eLjc5yhwycHQ92vNBjfd6nJGuAnMxQahsjjbiOd
         RS4p7Gw4H4ko/pZ1wpIzWuNO1TjRvBEI/L2bhXbt0HBBg2fi0EXL2vgUs+P6kVfev/ne
         oUoMzJeUrC1tRNH3G9nZbJfScfbmJBEnIF3eyrjsT38c49e8OEnin0XYKmRlyI+mIQ7G
         BmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144075; x=1792748875;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K851o75YbtR6vIMbLWAnHs9eoIWtRPb2jgeinaNj5V8=;
        b=iszJotI2jwTAUta0dNiZUnLFYs509UX0uUcFaBYe2pSVHjhJA0whChTDQihVaK0IS/
         h/pCkcc8ovmpaia1EubAqK1BskmjBMefPFJuGiKo6eRauwOVR33nylbhl193L14a4OAr
         ADrJyoEw4ySdoKD0TtQhbWN/eSmYoSLS28nX53V2tKa6YTtYtnnFwIYkJYRvlLx1x1bt
         tkYQ4ryK3TIDNeBZvE0BqeR8l20bV7fyTB6fZ872OWji12F40snPrtLkzoFs7yb5/Z51
         UsmoUm4r4s+6igLyPqM9Fybg4VtQFvZeTrq1VSVz8kklWYIVZcEvxTL9ZUgXHEC90lnx
         EI1w==
X-Forwarded-Encrypted: i=1; AKwUvBw/H5hfLUBzqR4AfF2wp+2kxyPJYGb8XAlCdrSHUgDXKRrirqdcUFPtc7v5A+qUm4NZM60x5BpE7yrIh1x72tMjCuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2385j9rN8qOL7nwGFNmdqJtlt3XcllihUGeoEvwdfeNxRf2cF
	ImsZ0XheAMqm+6+544e/mah0ocvGya1ZGeatyDo0bJxEtUVnqv4EzibP
X-Gm-Gg: AYBFou1NnoI/WeZITQPRLWBBRT4uxY+rBpruj4Bj7QJHqzJqEd2REEosmysVOYQgQym
	Z5M2Ki+bMlrxhasSOSAF2B056F/XUctUPfBIzOyxrxP64zB6qPIIDCDvp0W/CfxE7AXk7Wcysel
	hSvst3RWvI1mjNUmBuhV9s/yPvKEQjlCl0HIfPyXQxQW5qqPFcx7HxdzwgYjpnGUsJvhuKNvbqZ
	IRT2pmHb2jxQbxIhRoW2bR3Y80bvPncfB29qP5pWwGcWrx6kIJKwiXPDoxvDL9QbJK5FOXqTAFy
	ISn8K/ZtIB1CdhpzFeSclF/MILTTmhRGTLlerARsYzfFJaV7pSiH5pCUzUhTneYihr2oBvzeDF1
	zVrkgITHrqk0zkIKOPC7t6jRnfTXjTUdhXkl1Z0wzbJu2nHets/BcquWcAsUoFT5NRPfY7tl8t8
	VeYqFfoKtw9l9Yx9BIugWJdVLAgBwBVAvCSSdep2Tv10nkgTX14bJYKRGQEDu0Yu+DV8N2yupw+
	fzW2w==
X-Received: by 2002:a17:90b:3c4b:b0:3ac:ba49:2fed with SMTP id 98e67ed59e1d1-3acba4932b4mr2675488a91.58.1792144075313;
        Fri, 16 Oct 2026 02:47:55 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm3773059a91.7.2026.10.16.02.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:47:54 -0700 (PDT)
Message-ID: <6ad1f2ca.6048f038.32d739.a530@mx.google.com>
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
Date: Fri, 16 Oct 2026 17:47:51 +0800
Subject: [PATCH] tracing: guard trace_event_get_offsets() against an empty fields list

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9yYW4gV2FuZyA8aGFvcmFud2FuZ3NlY0BnbWFpbC5jb20+
CkRhdGU6IEZyaSwgMTYgT2N0IDIwMjYgMTY6MzA6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0
cmFjaW5nOiBndWFyZCB0cmFjZV9ldmVudF9nZXRfb2Zmc2V0cygpIGFnYWluc3QgYW4gZW1wdHkg
ZmllbGRzIGxpc3QKCnRyYWNlX2V2ZW50X2dldF9vZmZzZXRzKCkgZGVyZWZlcmVuY2VzIHRoZSBm
aXJzdCBlbnRyeSBvZiB0aGUgZmllbGRzIGxpc3QKcmV0dXJuZWQgYnkgdHJhY2VfZ2V0X2ZpZWxk
cygpIHZpYSBsaXN0X2ZpcnN0X2VudHJ5KCkuICBsaXN0X2ZpcnN0X2VudHJ5KCkKdGhlbiByZXR1
cm5zIHRoZSBsaXN0IGhlYWQgaXRzZWxmLCBhbmQgdGFpbC0+b2Zmc2V0ICsgdGFpbC0+c2l6ZSBy
ZWFkcyBwYXN0Cml0LiAgVGhlIGNvcnJ1cHRlZCByZXN1bHQgaXMgdXNlZCBhcyB0aGUgQlBGIGNv
bnRleHQtc2l6ZSBib3VuZCBpbgpfX3BlcmZfZXZlbnRfc2V0X2JwZl9wcm9nKCk6CgogICAgaW50
IG9mZiA9IHRyYWNlX2V2ZW50X2dldF9vZmZzZXRzKGV2ZW50LT50cF9ldmVudCk7CiAgICBpZiAo
cHJvZy0+YXV4LT5tYXhfY3R4X29mZnNldCA+IG9mZikKICAgICAgICAgICAgcmV0dXJuIC1FQUND
RVM7CgpzbyBhIGNvbnRleHQtcmVhZGluZyBCUEYgcHJvZ3JhbSB0aGF0IG91Z2h0IHRvIGJlIHJl
amVjdGVkIGNhbiBpbnN0ZWFkIGJlCmF0dGFjaGVkIHRvIGEgemVyby1maWVsZCB0cmFjZXBvaW50
ICh3aGljaCBzdGlsbCBjYXJyaWVzClRSQUNFX0VWRU5UX0ZMX1RSQUNFUE9JTlQpIGFuZCByZWFk
IGFkamFjZW50IGtlcm5lbCBtZW1vcnkgd2hlbiB0aGUKdHJhY2Vwb2ludCBmaXJlcywgYnlwYXNz
aW5nIHRoZSB2ZXJpZmllcidzIGNvbnRleHQtc2l6ZSBjb25maW5lbWVudC4KClRoaXMgaXMgcmVh
Y2hhYmxlIHRocm91Z2ggdXNlcl9ldmVudHM6IGEgdXNlciBjYW4gcmVnaXN0ZXIgYW4gZXZlbnQg
d2l0aCBubwpmaWVsZHMgKGUuZy4gYGVjaG8gdTpteV9ldmVudCA+IGR5bmFtaWNfZXZlbnRzYCks
IHdoaWNoIGxlYXZlcyB1c2VyLT5maWVsZHMKZW1wdHkgd2hpbGUgdGhlIGV2ZW50IHJlbWFpbnMg
YSBCUEYtYXR0YWNoYWJsZSB0cmFjZXBvaW50LAp0cmFjZV9nZXRfZmllbGRzKCkgdGhlbiByb3V0
ZXMgdGhyb3VnaCB1c2VyX2V2ZW50X2dldF9maWVsZHMoKSB0byB0aGF0CmVtcHR5IGxpc3QuIFRo
ZSBjb3JydXB0ZWQKcmVzdWx0IGFmdGVyIGxpc3RfZmlyc3RfZW50cnkgaXMgdGhlbiB1c2VkIGFz
IHRoZSBCUEYgY29udGV4dC1zaXplIGJvdW5kIGluCl9fcGVyZl9ldmVudF9zZXRfYnBmX3Byb2co
KSwgd2hpY2ggbGV0cyBjb250ZXh0LXJlYWRpbmcgQlBGIHByb2dyYW1zIGF0dGFjaAp0byBhIHpl
cm8tZmllbGQgdHJhY2Vwb2ludCB3aGVuIHRoZXkgc2hvdWxkIGJlIHJlamVjdGVkIHdpdGggLUVB
Q0NFUy4KCkFkZCBsaXN0IGVtcHR5IGNoZWNrIHRvIGZpeCB0aGlzIGJ1Zy4KClNpZ25lZC1vZmYt
Ynk6IEhhb3JhbiBXYW5nIDxoYW9yYW53YW5nc2VjQGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvdHJh
Y2UvdHJhY2VfZXZlbnRzLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMgYi9rZXJuZWwvdHJh
Y2UvdHJhY2VfZXZlbnRzLmMKLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jCisrKyBi
L2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHMuYwpAQCAtMjM5LDYgKzIzOSwxMCBAQCBpbnQgdHJh
Y2VfZXZlbnRfZ2V0X29mZnNldHMoc3RydWN0IHRyYWNlX2V2ZW50X2NhbGwgKmNhbGwpCiAJc3Ry
dWN0IGxpc3RfaGVhZCAqaGVhZDsKIAogCWhlYWQgPSB0cmFjZV9nZXRfZmllbGRzKGNhbGwpOwor
CisJaWYgKGxpc3RfZW1wdHkoaGVhZCkpCisJCXJldHVybiBzaXplb2Yoc3RydWN0IHRyYWNlX2Vu
dHJ5KTsKKwogCS8qCiAJICogaGVhZC0+bmV4dCBwb2ludHMgdG8gdGhlIGxhc3QgZmllbGQgd2l0
aCB0aGUgbGFyZ2VzdCBvZmZzZXQsCiAJICogc2luY2UgaXQgd2FzIGFkZGVkIGxhc3QgYnkgdHJh
Y2VfZGVmaW5lX2ZpZWxkKCkKLS0gCjIuNDMuMAo=
