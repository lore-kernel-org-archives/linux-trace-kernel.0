Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EF441030
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078911; cv=none; b=ZEghfgGZt+eHG29O5g0UlnlSg2mSsgI4S+iLLQJvex/eY9+0992oDM8hXdNDiVRttasFLqwOJJ1q5tqvd78uHe0s50PR0O+74pwB2AgIk6ulAqkCV9aTr+3LBoAdaQj/Hf4dn+USQzWqVJILgH11pStEO3ZX0+j5neMSpaNKRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078911; c=relaxed/simple;
	bh=htDOogwAgMqjtWKBKf6Jli8B2oMTvTgxy0Et239u51Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgX2seMeXxsih6sjb41Vd2MbInsGyT5np8weIUMQijSLL5sbnr4GIygVlcnuip1lyHqI6Fnd7LdS8d28KTboe7cyyaetAMfozJxFMNm9t7O4eoPIVfnZGeljbKZROuwMC0Pm9kYLT7NONqLdOFZsfUFHHy4tU+2LgonlgOKIihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhyPm0GE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhyPm0GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778078904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=htDOogwAgMqjtWKBKf6Jli8B2oMTvTgxy0Et239u51Q=;
	b=UhyPm0GE05MoCc7OCzYshadAQNLGRln7M1eTHIvg1Im73mQ1FUGjVnpHkjw/SrfV6jchFc
	SB45oPQf5+VlfyhNfKnv0df3SoSXfKpnZmhSpzJy7h7d8dEaaF5XkhTXVmXxcip3JwN2al
	AzKjugqEXQKSmUP3NmZ7Om9HCNt+v7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-oNFG2Io-O4q9cMOoOEWzkg-1; Wed, 06 May 2026 10:48:22 -0400
X-MC-Unique: oNFG2Io-O4q9cMOoOEWzkg-1
X-Mimecast-MFC-AGG-ID: oNFG2Io-O4q9cMOoOEWzkg_1778078901
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e526e11ccso7199645e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 07:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078901; x=1778683701;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+FvJexWelGEVSZnDFp1mP6SNdeqSldeDdMU0C/uM1A=;
        b=IfygILroQPY2NOAVIbU0OsXgou6DzUQI/Kecc7ECObSXN7gxUGl93ObIcXKeW1c/T3
         s3CZq1v3/rbjwyBXPzojL9UrF2ma2XrL4l96pxXnjFl9Nt8F0AK4xlsuvpRws1zfDCH7
         ouf1jt1ZMtLc7S1+VGmhMGhggkVJnWKPbLrIZamZ9aIs7ldWNyzjRYsoCdprY6+mwLbN
         3Tv1Y1Q573cvofyp4vdksC4MUfMZ/xm9+jlAAG/qdJh1J/ftmQWjgu+xK2E583fiLzQ7
         caxQR9cOUOdLRHCUetZnYmYCQ+AzmTXtMlA9jw6NGB6yy8L6IOTOrhMX3hvSbaRAW9xA
         1ixA==
X-Forwarded-Encrypted: i=1; AFNElJ/Uc23eFrCnSWLgE6D72UNH5CVgYJ4xanfNMY9J/uE41emAR9aaPnH3kXqhV6BYuTVN7Oetsq7stntE8Hhf8EtCwvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0UZc8ur7EJS+r4RoWcT872S7K1SfnKsObCjPhtQ22c+82W5S
	tbPhtU7NgW1tmri5JZXxACMe8hXcIS/+17gqhQHHJ3wiQp9UBVMLm0E/ttqI70i5g1snEwP3tpR
	Qzkpc3G+EcEO89nO/TsjAWqD4ZyAvS7Ewwj3KYyI05p/kzjepRC3RGhefJDR682aefjvKj8OplQ
	==
X-Gm-Gg: AeBDietPgTe3tNqE0L6IDBVA7AQGr/2sKTrYzuo6up9sjhEaekMgujEV5pXoKvuYVv8
	fOaUalzLygKrLwGAw4rAn35dMcaYc9zQydRJCvV5NI2h8lTzPoBTpVUXgzSTVLtKYREesMgjugd
	44EZufJtZZ54E1rrRA8wpABgJ98wMiWXCeAUtdK5puGYnOFqMXQVeXjqulAQSwoFRcYRaz+N7rQ
	LHTqKLRc5rSVvl0C3i/U1QMh7wXZpbhndyvWvypHq2T/ZvX/BBkc5+pfjSCkGr+XQ8EsGmno1p9
	k2WbGrOTME17cm5cZRzRsnR6JJrk8fD3Fgjy7ekfB93XpeXodAozwUjgeddjFEYbvMTsH33wFdA
	F8kS4G7GhMy+5Lb3KrKC9LQnBg9cuAXbA3LLhX862guhuKGrW69H3ptMH/9PLKc8SD2i0AGX8RA
	Q/RTH+gELFBydl/SGTOGDJ2Zkv8w==
X-Received: by 2002:a05:600c:c48f:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48e51f2a790mr67590745e9.7.1778078900877;
        Wed, 06 May 2026 07:48:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c48f:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48e51f2a790mr67590345e9.7.1778078900521;
        Wed, 06 May 2026 07:48:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fad5fsm57881245e9.10.2026.05.06.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:48:19 -0700 (PDT)
Message-ID: <dba16e4fe794c5aa237f3360fef5fc22ae32c60b.camel@redhat.com>
Subject: Re: [PATCH 03/13] verification/rvgen: Implement state and
 transition parser based on Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 16:48:17 +0200
In-Reply-To: <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
	 <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _OnnaQCdcteEsLWAbmhUfLpD5Dqr5dXkdumqzHrVuYY_1778078901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Ckxvb2tzIGdvb2QsIGFsdGhvdWdoIEkgbmVlZCB0byBwdXQgbW9yZSBlZmZvcnQgdG8gdW5kZXJz
dGFuZCB0aGUgZ3JhbW1hci4KVGhlcmUncyBhbiBpc3N1ZSBwYXJzaW5nIGV2ZW50cyB0aG91Z2g6
Cgo+ICtjbGFzcyBFdmVudExhYmVsUGFyc2VyOgo+ICvCoMKgwqAgZ3JhbW1hciA9IHInJycKPiAr
wqDCoMKgIGV2ZW50czogZXZlbnQgKCJcXG4iIGV2ZW50KSoKPiArCj4gK8KgwqDCoCBldmVudDog
bmFtZSAoIjsiIGd1YXJkKSoKPiArCj4gK8KgwqDCoCBndWFyZDogcmVzZXQKPiArwqDCoMKgwqDC
oMKgwqDCoCB8IHJ1bGUKPiArwqDCoMKgwqDCoMKgwqDCoCB8IHJ1bGUgcmVzZXQKPiArwqDCoMKg
wqDCoMKgwqDCoCB8IHJlc2V0IHJ1bGUKPiArCj4gK8KgwqDCoCBuYW1lOiBDTkFNRQo+ICsKPiAr
wqDCoMKgIHJlc2V0OiAicmVzZXQiICIoIiBFTlYgIikiCj4gKwo+ICvCoMKgwqAgJWltcG9ydCBj
b21tb24uQ05BTUUKPiArwqDCoMKgICVpbXBvcnQgY29tbW9uLldTCj4gK8KgwqDCoCAlaWdub3Jl
IFdTCj4gK8KgwqDCoCAnJycgKyBDb25zdHJhaW50UnVsZS5ncmFtbWFyCj4gKwo+ICvCoMKgwqAg
Y2xhc3MgR2V0RXZlbnRzKGxhcmsudmlzaXRvcnMuVHJhbnNmb3JtZXIpOgo+ICvCoMKgwqDCoMKg
wqDCoCBkZWYgZ3VhcmQoc2VsZiwgYXJncyk6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVz
ZXQgPSBOb25lCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnVsZSA9IE5vbmUKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb3IgYXJnIGluIGFyZ3M6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiBhcmcuZGF0YSA9PSAicmVzZXQiOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXNldCA9IENvbnN0cmFpbnRSZXNldChhcmcuY2hpbGRyZW5b
MF0pCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGFyZy5kYXRhID09ICJy
dWxlIjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uZGl0aW9u
cyA9IGFyZy5jaGlsZHJlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBydWxlID0gQ29uc3RyYWludFJ1bGUoY29uZGl0aW9uc1swXSkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGkgaW4gcmFuZ2UoMSwgbGVuKGNvbmRpdGlvbnMp
LCAyKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
dWxlLmNoYWluKGNvbmRpdGlvbnNbaV0sIGNvbmRpdGlvbnNbaSArIDFdKQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiByZXNldCwgcnVsZQo+ICsKPiArwqDCoMKgwqDCoMKgwqAgZGVm
IE9QKHNlbGYsIGFyZ3MpOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBhcmdzCj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoCBkZWYgY29uZGl0aW9uKHNlbGYsIGFyZ3MpOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBDb25zdHJhaW50Q29uZGl0aW9uKCphcmdzKQo+ICsKPiAr
wqDCoMKgwqDCoMKgwqAgZGVmIGV2ZW50KHNlbGYsIGFyZ3MpOgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG5hbWUgPSBhcmdzWzBdCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnVsZSwgcmVz
ZXQgPSBOb25lLCBOb25lCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbGVuKGFyZ3MpID09
IDI6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNldCwgcnVsZSA9IGFyZ3Nb
MV0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmFtZSwgcmVzZXQsIHJ1bGUKCkkn
bSBub3Qgc3VyZSBpZiBpdCBjb3VsZCBiZSBzb2x2ZWQgYmV0dGVyIGNoYW5naW5nIHRoZSBncmFt
bWFyLCBidXQgdGhpcyBkb2Vzbid0CndvcmsgaW4gY2FzZSB3ZSBoYXZlIGJvdGggYSByZXNldCBh
bmQgYSBydWxlLCBlLmcuOgoKICAiZXZlbnQyO2VudjEgPT0gMDtyZXNldChjbGspIgoKSXQgYXBw
YXJlbnRseSBzYXZlcyBvbmx5IG9uZSBvZiB0aGVtLCB0aGUgb3RoZXIgd291bGQgZW5kIHVwIGlu
IGFyZ3NbMl0uCgpEb2luZyB0aGlzIHNlZW1zIHRvIGZpeDoKCmRpZmYgLS1naXQgYS90b29scy92
ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vYXV0b21hdGEucHkKYi90b29scy92ZXJpZmljYXRpb24v
cnZnZW4vcnZnZW4vYXV0b21hdGEucHkKaW5kZXggY2M0MmI4MTI3ZmMwLi4xMDUzNGY5NTZjYzMg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9hdXRvbWF0YS5weQor
KysgYi90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vYXV0b21hdGEucHkKQEAgLTMxNCw4
ICszMTQsMTEgQEAgY2xhc3MgRXZlbnRMYWJlbFBhcnNlcjoKICAgICAgICAgZGVmIGV2ZW50KHNl
bGYsIGFyZ3MpOgogICAgICAgICAgICAgbmFtZSA9IGFyZ3NbMF0KICAgICAgICAgICAgIHJ1bGUs
IHJlc2V0ID0gTm9uZSwgTm9uZQotICAgICAgICAgICAgaWYgbGVuKGFyZ3MpID09IDI6Ci0gICAg
ICAgICAgICAgICAgcmVzZXQsIHJ1bGUgPSBhcmdzWzFdCisgICAgICAgICAgICBmb3IgX3Jlc2V0
LCBfcnVsZSBpbiBhcmdzWzE6XToKKyAgICAgICAgICAgICAgICBpZiBfcmVzZXQ6CisgICAgICAg
ICAgICAgICAgICAgIHJlc2V0ID0gX3Jlc2V0CisgICAgICAgICAgICAgICAgaWYgX3J1bGU6Cisg
ICAgICAgICAgICAgICAgICAgIHJ1bGUgPSBfcnVsZQogICAgICAgICAgICAgcmV0dXJuIG5hbWUs
IHJlc2V0LCBydWxlCiAKICAgICAgICAgZGVmIGV2ZW50cyhzZWxmLCBhcmdzKToKClRoYW5rcywK
R2FicmllbGUKDQo=

