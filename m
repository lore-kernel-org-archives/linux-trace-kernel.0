Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A112C3266
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136336; cv=none; b=SZL7bn3kl7kMAALavjd9pqyoKDumQDCz1Jh+iFkZSzOKqOTMFwjSpnko3/Ye8jFXBQFxDA6EmcUiWEmobrJYOh+A1H9ko6CXNYM/CpBhgUZDv9WuWSjWCi5l3iHUQLj//gB10X/+1N4FCo7kjS+FXms27PmtDinjwEum+ZCW0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136336; c=relaxed/simple;
	bh=y//couFlBXNz2/Zxu6hfeHUs70BmA157+for+pnBQo8=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Date:Subject; b=T+pp48TrMCmiU2dUQiwqayaCe85RV4Oat/cApO8xN4tjJo1Q3iAkfw4+s8Y7pCOGOUBpRZMFLj1+nFkJ04IdCnAh5GIeCxjrSul45mCEgXrF1FH1Gi4h98eT/cM8kMffDYlx0IJTXSIUHlypph4eyiGp9Bij0ANVHfnI6uX9od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3wCbKsG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3wCbKsG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab41538192so4376859a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792136334; x=1792741134; darn=vger.kernel.org;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y//couFlBXNz2/Zxu6hfeHUs70BmA157+for+pnBQo8=;
        b=D3wCbKsGMDvfx/3te1VZX+4l/qY9USM1pezuHxb9YGNQXYlBF/VMVonIBZ5CR6g2TD
         AmQT7iGLjVfHil406Kk0cpFs4Lo9ONqvVtkU+CzhfRlm0G0pH/z7/EtaYPb2+D0XSsB/
         2NlL/5gLFzcYTAA/mKc6llrPmjJ51rDzvt8kpgCmYBS/WkWvrj10zWHnGTMWK5Evgbmv
         6YRwTMNmjcLae19e0+26kRHXqw7G8iOH2tshqqm5zLMCK46g3/aEw9Ci+d14zksXMODZ
         YdsyOalpofZcSqh0ElMFNP3sVTtwIJLxYwjcOheBCNgkhGC2m+OVmHIoHsjijUeLgoFy
         5arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136334; x=1792741134;
        h=subject:date:cc:to:from:content-transfer-encoding:mime-version
         :content-type:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y//couFlBXNz2/Zxu6hfeHUs70BmA157+for+pnBQo8=;
        b=noMpD1qZwZ9ARyT57dngFYwQ43IxXwkcd41Ojqks+fXzoNTR5ZXwie+o7gQZYMIwmv
         +rBZuTwasClN7zfE+GwaCYmlqKm68fWxkOfCYQomIn4gseC9coJvKMl8GohOUak8wAkv
         3MpxZe6yh9H+0/nvpPzZeYeoDHDV0LVzAV/FNQ6CsLuvFPAWJhhCOO8/A8j9BNlTTTMa
         tsyFASOJLfymp5sDQhXj7ytgWOi1Kbrw8tyzbc97Y6Ub6B1qZtgxqsk0blF9TwfByC8n
         g6woFkvaPd1pG7qCTfT9fczit/Ern2PIg/QeDqLzVQ6zUQt+FAAJfQHmsboZ3cmdu/S5
         OeDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlRVAnMRK20bA6sA1OOaPUnx6YsrOWMg1aIBWI9p4p8rLxdkCDJDNpfO6Xl3fYfe76HK6hwbVCAZW1enhGUoXvf1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT7jjDtd/fhOnD1jXe2eGGGQJYVzjO5gjDqAw4a3MU77uWBxUe
	06J5cgby1+NF7ICPlYs2h0Or7cnPvx7sbAHFwhX9q5rse+U3LK2Phwqa
X-Gm-Gg: AYBFou0yoSYx5MPcxtD/apO4cW1MLja/shmLLPb+fvwVFv8Nr5DuwPRrSeSKX02KuKa
	vRxONdI2nrQYDtayDZxiGrRlOSoO4mNpOD3jrytRJTjpFqI900LOOG+qWLrglT4yX7n+3DrtXAv
	XqZ92vwmIc1fO8MGIX3lZP3DhwunPBCRDxHd1oFd4KzeOdnagx+EhVF3W9TiZZIDHlUezZciwX9
	vDh06GJCHm9VcnL+0E1Tbpx4VnQIWY5+VZaCPiYFV7cQRTIjNiXTQ/CfHRxMAgpAnaOsUtaLR+H
	qUjrXK3v0vJuikC+Qr5YuMOdxwj8zrwJzZbLwP6Mt4fCstTKlITCg0uA7xoH5CB2H0FNjSuTLVx
	2Dn4ez1FzEbhuXW/AalOlBOI9LNWTcDmzyhSqM8oHVFuo30w+kRJQVsR/HV+FKfRQwVPVdhyEV9
	ROG3dvd9SNwqObj++EkJiAxxQCjGSrozd3kJz1uH3heVwKYDD7Z2+qFAJQZbYTUuzBuL17mqdH2
	xiJQQ==
X-Received: by 2002:a17:90b:1c87:b0:3ab:d26b:c2d1 with SMTP id 98e67ed59e1d1-3abd26bc3demr18665534a91.11.1792136334072;
        Fri, 16 Oct 2026 00:38:54 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a249f3sm705405a12.27.2026.10.16.00.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:38:53 -0700 (PDT)
Message-ID: <6ad1d48d.a461c41f.282b8.7a97@mx.google.com>
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
Date: Fri, 16 Oct 2026 15:38:49 +0800
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
Y3Qgc3VjaCBldmVudHMgYXQgcmVnaXN0cmF0aW9uIGNhbiBmaXggdGhpcyBidWcuIGV2ZW50X2lu
aXQoKSBpcyB0aGUKdW5pdmVyc2FsIGNob2tlcG9pbnQgaW52b2tlZCBmb3IgYm90aCBlYXJseS1i
b290IGFuZCBtb2R1bGUgZXZlbnRzLCBhbmQKaXRzIHJldHVybiBpcyBlbmZvcmNlZCBieSBfX3Jl
Z2lzdGVyX2V2ZW50KCksIHdoaWNoIHJlZnVzZXMgdG8gYWRkIHRoZSBjYWxsCnRvIGZ0cmFjZV9l
dmVudHMuICBBbiBldmVudCB3aG9zZSBmaWVsZHNfYXJyYXlbMF0udHlwZSBpcyBOVUxMICh0aGUK
ZW1wdHktVFBfU1RSVUNUX19lbnRyeSBzZW50aW5lbCkgaXMgcmVqZWN0ZWQgd2l0aCAtRUlOVkFM
IGJlZm9yZQp0cmFjZV9ldmVudF9nZXRfb2Zmc2V0cygpIGNhbiBiZSByZWFjaGVkLiAgRHluYW1p
YyBldmVudHMsIHdoaWNoIGNhcnJ5CnRoZSBUUkFDRV9GVU5DVElPTl9UWVBFIG1hcmtlciBpbiBm
aWVsZHNfYXJyYXlbMF0udHlwZSBhbmQgcG9wdWxhdGUgdGhlCmZpZWxkcyBsaXN0IGxhemlseSB0
aHJvdWdoIGEgZGVmaW5lX2ZpZWxkcyBjYWxsYmFjaywgYXJlIHVuYWZmZWN0ZWQuCgpTaWduZWQt
b2ZmLWJ5OiBIYW9yYW4gV2FuZyA8aGFvcmFud2FuZ3NlY0BnbWFpbC5jb20+Ci0tLQoga2VybmVs
L3RyYWNlL3RyYWNlX2V2ZW50cy5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHMuYyBiL2tlcm5l
bC90cmFjZS90cmFjZV9ldmVudHMuYwotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMK
KysrIGIva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jCkBAIC0zMjc5LDYgKzMyNzksMTEgQEAg
c3RhdGljIGludCBldmVudF9pbml0KHN0cnVjdCB0cmFjZV9ldmVudF9jYWxsICpjYWxsKQogCWlm
IChXQVJOX09OKCFuYW1lKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlpZiAoY2FsbC0+Y2xhc3Mt
PmZpZWxkc19hcnJheSAmJgorCSAgICAhY2FsbC0+Y2xhc3MtPmZpZWxkc19hcnJheVswXS50eXBl
ICYmCisJICAgICFjYWxsLT5jbGFzcy0+Z2V0X2ZpZWxkcykKKwkJcmV0dXJuIC1FSU5WQUw7CisK
IAlpZiAoY2FsbC0+Y2xhc3MtPnJhd19pbml0KSB7CiAJCXJldCA9IGNhbGwtPmNsYXNzLT5yYXdf
aW5pdChjYWxsKTsKIAkJaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1FTk9TWVMpCi0tIAoyLjQzLjAK
