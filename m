Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39327264A9D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994381; cv=none; b=rBgAo1r1DMabGgYoSpY/L72u84CY5kltaWDEGpbs29uVmpKTf3eO2MuvYBoeNg1uda+eFQ41IA9BLUKMMzV6pA0WHg4RGe4g1zj4tZpSl6HZ1AgEnrFOzXx6xz3fO4ellf7xT5Ppjt4bLU12mvJGULYTRm0R/i2ghAiFvAtcY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994381; c=relaxed/simple;
	bh=+KCuC2LmBxPeu8G5Zj0C8tLcgxLLDPtn3+G+7Oxs9wc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+/C/W0tpsu/65gxs4YK5OARCuXJKXyinuhsi5DusaXAZgnUuQdk5tYEnSs0GSiIQFA5E/xLNXDYKymaFA9sWtYjOB0fx245feheeBwFuGZ3W2V+Bes2eOInJprq0gz5RkwOettsSVHedLi/BTym/U/B9NMCLKFfbZ3vV78XF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5dghKHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5dghKHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782994379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+KCuC2LmBxPeu8G5Zj0C8tLcgxLLDPtn3+G+7Oxs9wc=;
	b=Z5dghKHb/Krsoa2gLRXXVSg8tAjSod41dy8EYnPjTj4Neul8/26zlBwkDX3LgkyqPbfUtM
	kd9bn37uiy0BfQVZ7Nij+xQ47y2uY+r4667IIT1A/gl9fIOj4OPNJbDSdokRjCWX41ncqa
	WQyd8HFB/lQzYdVvS5NHAqhfeldK2ic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-G39b0zz4NNOfHwJeMQKjPQ-1; Thu, 02 Jul 2026 08:12:58 -0400
X-MC-Unique: G39b0zz4NNOfHwJeMQKjPQ-1
X-Mimecast-MFC-AGG-ID: G39b0zz4NNOfHwJeMQKjPQ_1782994377
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493c1bc7a70so16990405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 05:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994377; x=1783599177;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mKuT8VIo7OjICZksfOoe1Bph2Sts3FOnr0Xxcwzwhw=;
        b=jvWqMmFeMye5VfneT7PW7hH34mncAt0OY4k2tMqM/I3ldmGEu5jML7CSDwN7v0ftZR
         VJE4jFWVct2rXvKtYrsxRBCPEYIY39maUOjFA1LfBE5LG0db5P7Mk/MDD580oLO4jqMZ
         NLmFQPiA3zOh28mmESyMTiA6pW+04EX6aTZ1/Oe4a8NjoH7aP2UF+V2CBAoAxiw50w1U
         MX2yx8G5+3FaVKShDl03IaUOsP4xZfOjTGlE7tbZSM+qaRBlBV10aAQBINTCDyxyganA
         /LKnP6F1b2bOoOh18xlvg29KGfEj99kk0H3VhMma6kkEIqBXYbby1uAGB57YB15G0HGb
         SGwQ==
X-Forwarded-Encrypted: i=1; AFNElJ86b13UgL9hd6ZrO/Cylo9IDIIyvVHzbtxinVmiw9U6FAKDMt2Qmdt1MoMfVoVE+lS1zdMgfyvg93ylnAbhW7A3lWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVA1oDb2TReEMYGFm1vSwBS7wtRNAg1p5T3SsuXvtPP4TbvFPa
	mIBqIVQI5aU5aTFO756SG0l0i2BVZT4RkpbaQ7oabj/p6JqRU4ZHrqjtlHb+qDXNdCmcBt4ih24
	YkfZwieb9eaDk2Y7u7zeg4Nv2YtHLt/BZXRNKDiEP14PEpStOjWc1oEJjEGtzuEszqdhQnHNg+w
	==
X-Gm-Gg: AfdE7cl4flI81Psg03QijPUAVw/dzZycaqGpWkHq5ldJfSV2gGQDLkV7QvG970pSMac
	io9ETYgeWkQ8lAeSeS3f0z3iYXCyeqDLAMwohErVJtbh+/ewGQE+9Ct+7xkSbpR8NNll3uHzbsb
	u8kUlUN5TWJaBDFdUi30sPnAuPTIrU3cGoaA3jx8gbgGyg+76B+YlRVVWud/onFoqhJdLPbaeib
	jSnNR3McZYouiYFx5jgxDFHBtMqUNYIUAEP+MmbKTQsIm1csleuIBZDB639MwRepRFBEJOia3kA
	25duQHvqaW95++upQPfs3jOhQvoxAIW2qI42jLl6XHhT9qw2WX84Fq/bBYgWQtvFOcfn9PMtq8/
	bhqu6fO5lHV1ULU2trDE7ToLvlmvyFD0GxWAZscRyiWASDEZCLnGSRJg+feFQE9OLOmSBGQsj0G
	R+DoOE
X-Received: by 2002:a05:600c:820d:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-493c83a5b92mr11797065e9.28.1782994376738;
        Thu, 02 Jul 2026 05:12:56 -0700 (PDT)
X-Received: by 2002:a05:600c:820d:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-493c83a5b92mr11796785e9.28.1782994376418;
        Thu, 02 Jul 2026 05:12:56 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde19e8dsm8862145f8f.27.2026.07.02.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:12:56 -0700 (PDT)
Message-ID: <3b0cb6e06b52607ba4de8202e197391abd585cfd.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 02 Jul 2026 14:12:54 +0200
In-Reply-To: <87ldbtvoo8.fsf@yellow.woof>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
	 <b33e175467a8cb8011ded2195353bc6743b4cd46.camel@redhat.com>
	 <87ldbtvoo8.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lf_EJ_EMVzg7Rg_POvrE6ofFdQARQWe6GGvcKdbiAH0_1782994377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDA5OjI1ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IEdhYnJp
ZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPiB3cml0ZXM6Cj4gPiBUaGlzIGxvb2tzIGdv
b2QsIGJ1dCBpZiBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdGx5LCB0aGUgc2FtZSB2aW9sYXRpb24g
c2hvdWxkCj4gPiBiZQo+ID4gc3BvdHRlZCBieSBib3RoIG1vbml0b3JzIGZyb20gdHdvIGRpZmZl
cmVudCBwZXJzcGVjdGl2ZXMsIGJ1dCBzbGVlcCBjYXRjaGVzCj4gPiBtb3JlCj4gPiB0aGluZ3Mg
KGUuZy4gdGFza3MgdXNpbmcgd3Jvbmcgc2xlZXBpbmcgd2F5cyBkZXNwaXRlIHRoZWlyIHdha2V1
cCk6Cj4gPiAKPiA+IMKgICMgcGVyZiBzdGF0IC1hIC1lIHJ2OmVycm9yX3NsZWVwIC1lIHJ2OmVy
cm9yX3dha2V1cCAtLSBzdHJlc3MtbmcgLS1jcHUgNSAtCj4gPiAtY3B1LWxvYWQgOTAgLS1zY2hl
ZCByciAtdCA1Cj4gPiAKPiA+IMKgwqAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5
c3RlbSB3aWRlJzoKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyODXCoMKg
wqDCoMKgCj4gPiBydjplcnJvcl9zbGVlcMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIwwqDCoMKgwqDCoAo+ID4gcnY6ZXJyb3Jfd2Fr
ZXVwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gCj4gPiBQcm92aWRlZCBJIGRvbid0IHJlYWxs
eSBrbm93IHdoYXQncyBoYXBwZW5pbmcgZG93biB0aGVyZSAoSSBqdXN0IGxldCB0aGUKPiA+IHN0
cmVzc29yIHJ1biBmcmVlKSwgdGhpcyBkaXNjcmVwYW5jeSBpcyBleHBlY3RlZCwgcmlnaHQ/Cj4g
Cj4gVGhhbmtzIGZvciB0ZXN0aW5nIGl0Lgo+IAo+IEJlc2lkZSBtb25pdG9yaW5nIGxvdy1wcmlv
IHRhc2sgd2FraW5nIGhpZ2gtcHJpbyB0YXNrLCB0aGUgcnRhcHAvc2xlZXAKPiBtb25pdG9yIGFs
c28gY2hlY2tzIHRoYXQgdXNlciB1c2VzIHRoZSBjb3JyZWN0IEFQSXMgZm9yIHNsZWVwaW5nLiBT
bwo+IHllcywgdGhpcyBkaXNjcmVwYW5jeSBpcyBleHBlY3RlZC4KCkFscmlnaHQgbWFrZXMgc2Vu
c2UsIHRoYW5rcy4KClJldmlld2VkLWJ5OiBHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0
LmNvbT4KDQo=

