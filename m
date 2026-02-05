Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B263A782F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292085; cv=none; b=ZxezqQm9nuh30NDhpBm65DigCpKhOQEGi0upset9mk4WwHiy2wkzc/rlm6PvSad52hUHYIC/osjz1WYOSm4vmsyiYO8vXlNV99jjHQTMSpxYXpkvIgBhhdCAPDKyDw+e18avCzLmmksYxqJ2OFgYsjyIAbAnEeQuzXtZDBbUiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292085; c=relaxed/simple;
	bh=fsaNE9kp0eF4BTDNgqpmiKPSthCq3blYLfgVFOxipNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSxklwS7usBkngZj+lT4tKc2+A/AK/BYJ75A1ug2cRvDc3vWhbzmGb17zjqEGO9dc+dqksYO8kIR/Y1b3DKRrRQZo9qSqjFfSQiHVOyA1Awe+FLWKVDBjgOk4n8TyyCjlRWB23yEZeqJyBQrscfduQqgoQD+abPbnxG/S34PQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDHAxAYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDHAxAYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770292084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fsaNE9kp0eF4BTDNgqpmiKPSthCq3blYLfgVFOxipNQ=;
	b=JDHAxAYqXbNPWIka8fgg/7JA6zGckokf3oRepHcprIjgQxuNlZMSceec3SboCvp0rDU9P1
	avz5zTGQbbx+Yw7asAiV84LV6ArzTxLnIQo+5irq+Rw/pCtF3fwITXAZdj94I5JtbVKSa+
	KwKsWCdcbu+iP9Xn80VUD7Vi1w6stzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-EFQrnbqxOaG3bdEBv7TmZA-1; Thu, 05 Feb 2026 06:48:03 -0500
X-MC-Unique: EFQrnbqxOaG3bdEBv7TmZA-1
X-Mimecast-MFC-AGG-ID: EFQrnbqxOaG3bdEBv7TmZA_1770292082
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b182e3cso604322f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 03:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770292082; x=1770896882;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsaNE9kp0eF4BTDNgqpmiKPSthCq3blYLfgVFOxipNQ=;
        b=TsnE5xJURSEcjqwSQavRBuRmsZNvvu8jTwBcKi2fGkyRNbyZedwfEKXJ6kguY37ncQ
         z7SkpcGgtCHuuZmcgm1GDXg569b9HE2abZ+t6ZCUl3gE0fnkZoBESO/tfUA1XPV+IIIA
         VbcB1PEl1DusYk4fKOVr+u8cdLMWGpjsSUQnMFVGmE0GRiTCMGzTioBm4qfiQ7DS13qj
         xQJ0IQv0OYEQg+NGw1OjLVhj3XhnYTr0C0x4AdEqiF+6MMjJnmH84SzyKUx2yw8u7Dq2
         rOSyckSZkdb+qK7wNw+jRtiN/tejXN03zzwmDcKBrGmnmxKH9ueEfx3vAgW1ogTpMkqv
         TZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWLxM419InAK8UH/SbWpEd1viSHagjuSA7eUcaQtgUZT/YPYEEdE43MO+t5UzQiJSwM4uPT+rFAQ88tuDsUQPCY4O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTquyl9Bt66f42kCAGeBtGi3mG4gG7+ga6WIZEqg4/fjEkHt3
	358eTFGoxC5gqgdnkRjSpIXqOd/R+9yrIgAJXrRyYZ62xeJSjQrSG6omWUs3rR/CY3GWDzpqmYK
	fLhA4x83kCviK/ZEBYtVowmDnriKUsCr1dTJT0+5h9Fq7YhA/2xA9c23RtaY2f8GKrkLJddUN+g
	==
X-Gm-Gg: AZuq6aIQYUSlQxvpg9lna/icw/55NOZ/VocjO30rfzBoSaNpsfZNkzo5NkIT2PWeRR4
	C6UGgn3e6FYCDd/AMxGsj4Ihu1NNJ3Ekgfzxf51Al57CxYQYyziUpPOsH1IFxH5HTuyAG1CkIJE
	xRn2cPAHvsSvvQ+1CHWz13GVELr0A0u2lgEhhDQ+0gMkZEG3FiXmLLYID4u069l5jE6D5UZtO+C
	E3xnD3CzbEIfGkqzBR2eUuXjm/zF7KDUfYCU04Qejxe+paUnhAIy+zE9PBkFdvNtWWGxrF1eKRZ
	kYdqvegBXNlX1B1M86F3kW/Z5F1pdvJn35sAyUs4B2QW2uFJg28zHCvcCHLUWIMxovSUwULQRdi
	RgLVq43UpmMaaOLa7H6VtbMlx29N2gJ23NqzPRLCk8G98iXEg+Op0Y9+MczLujnVKyMb2PLi3bU
	JBen/2EEdK
X-Received: by 2002:a05:6000:24c5:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-4361805d638mr9475378f8f.44.1770292081690;
        Thu, 05 Feb 2026 03:48:01 -0800 (PST)
X-Received: by 2002:a05:6000:24c5:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-4361805d638mr9475337f8f.44.1770292081180;
        Thu, 05 Feb 2026 03:48:01 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e250bdsm14131731f8f.2.2026.02.05.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:48:00 -0800 (PST)
Message-ID: <6394f4446e29416f2b1e4ea1412d6ec6d1ef5e85.camel@redhat.com>
Subject: Re: [PATCH v2 16/20] rv/rvgen: extract node marker string to class
 constant
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 12:47:59 +0100
In-Reply-To: <20260204144914.104028-17-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-17-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 74rAiQKG2WiOCA_EY4QkiWUiKq_RTAvZYxz3sxj5Jl8_1770292082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDExOjQyIC0wMzAwLCBXYW5kZXIgTGFpcnNvbiBDb3N0YSB3
cm90ZToKPiBBZGQgYSBub2RlX21hcmtlciBjbGFzcyBjb25zdGFudCB0byB0aGUgQXV0b21hdGEg
Y2xhc3MgdG8gcmVwbGFjZSB0aGUKPiBoYXJkY29kZWQgIntub2RlIiBzdHJpbmcgbGl0ZXJhbCB1
c2VkIHRocm91Z2hvdXQgdGhlIERPVCBmaWxlIHBhcnNpbmcKPiBsb2dpYy4gVGhpcyBmb2xsb3dz
IHRoZSBleGlzdGluZyBwYXR0ZXJuIGVzdGFibGlzaGVkIGJ5IHRoZSBpbml0X21hcmtlcgo+IGFu
ZCBpbnZhbGlkX3N0YXRlX3N0ciBjbGFzcyBjb25zdGFudHMgaW4gdGhlIHNhbWUgY2xhc3MuCj4g
Cj4gVGhlICJ7bm9kZSIgc3RyaW5nIGlzIHVzZWQgYXMgYSBtYXJrZXIgdG8gaWRlbnRpZnkgbm9k
ZSBkZWNsYXJhdGlvbgo+IGxpbmVzIGluIERPVCBmaWxlcyBkdXJpbmcgc3RhdGUgdmFyaWFibGUg
ZXh0cmFjdGlvbiBhbmQgY3Vyc29yCj4gcG9zaXRpb25pbmcuIEV4dHJhY3RpbmcgaXQgdG8gYSBu
YW1lZCBjb25zdGFudCBpbXByb3ZlcyBjb2RlCj4gbWFpbnRhaW5hYmlsaXR5IGFuZCBtYWtlcyB0
aGUgbWFya2VyJ3MgcHVycG9zZSBleHBsaWNpdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBXYW5kZXIg
TGFpcnNvbiBDb3N0YSA8d2FuZGVyQHJlZGhhdC5jb20+CgpSZXZpZXdlZC1ieTogR2FicmllbGUg
TW9uYWNvIDxnbW9uYWNvQHJlZGhhdC5jb20+Cgo+IC0tLQo+IMKgdG9vbHMvdmVyaWZpY2F0aW9u
L3J2Z2VuL3J2Z2VuL2F1dG9tYXRhLnB5IHwgOSArKysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xz
L3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9hdXRvbWF0YS5weQo+IGIvdG9vbHMvdmVyaWZpY2F0
aW9uL3J2Z2VuL3J2Z2VuL2F1dG9tYXRhLnB5Cj4gaW5kZXggMTdiMDEyYjg2ODUzMS4uMjcwYTNk
MGJmNGNlNyAxMDA2NDQKPiAtLS0gYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vYXV0
b21hdGEucHkKPiArKysgYi90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vYXV0b21hdGEu
cHkKPiBAQCAtMjcsNiArMjcsNyBAQCBjbGFzcyBBdXRvbWF0YToKPiDCoAo+IMKgwqDCoMKgIGlu
dmFsaWRfc3RhdGVfc3RyID0gIklOVkFMSURfU1RBVEUiCj4gwqDCoMKgwqAgaW5pdF9tYXJrZXIg
PSAiX19pbml0XyIKPiArwqDCoMKgIG5vZGVfbWFya2VyID0gIntub2RlIgo+IMKgCj4gwqDCoMKg
wqAgZGVmIF9faW5pdF9fKHNlbGYsIGZpbGVfcGF0aCwgbW9kZWxfbmFtZT1Ob25lKToKPiDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYuX19kb3RfcGF0aCA9IGZpbGVfcGF0aAo+IEBAIC03Miw3ICs3Myw3
IEBAIGNsYXNzIEF1dG9tYXRhOgo+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIGN1cnNvciwgbGluZSBp
biBlbnVtZXJhdGUoc2VsZi5fX2RvdF9saW5lcyk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNwbGl0X2xpbmUgPSBsaW5lLnNwbGl0KCkKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIGxlbihzcGxpdF9saW5lKSBhbmQgc3BsaXRfbGluZVswXSA9PSAie25vZGUiOgo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIGxlbihzcGxpdF9saW5lKSBhbmQgc3BsaXRfbGluZVswXSA9
PSBzZWxmLm5vZGVfbWFya2VyOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBjdXJzb3IKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgQXV0b21hdGFFcnJvcigi
Q291bGQgbm90IGZpbmQgYSBiZWdpbm5pbmcgc3RhdGUiKQo+IEBAIC04Nyw5ICs4OCw5IEBAIGNs
YXNzIEF1dG9tYXRhOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVl
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgc3RhdGUgPT0gMDoKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGxpbmVbMF0gPT0gIntub2RlIjoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGxpbmVbMF0gPT0gc2VsZi5ub2RlX21hcmtlcjoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXRlID0gMQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsaWYgbGluZVswXSAhPSAie25vZGUiOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVsaWYgbGluZVswXSAhPSBzZWxmLm5vZGVfbWFya2VyOgo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrCj4gwqDCoMKgwqDCoMKgwqDCoCBlbHNl
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBBdXRvbWF0YUVycm9yKCJDb3VsZCBu
b3QgZmluZCBiZWdpbm5pbmcgZXZlbnQiKQo+IEBAIC0xMTEsNyArMTEyLDcgQEAgY2xhc3MgQXV0
b21hdGE6Cj4gwqDCoMKgwqDCoMKgwqDCoCAjIHByb2Nlc3Mgbm9kZXMKPiDCoMKgwqDCoMKgwqDC
oMKgIGZvciBsaW5lIGluIGlzbGljZShzZWxmLl9fZG90X2xpbmVzLCBjdXJzb3IsIE5vbmUpOgo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGxpdF9saW5lID0gbGluZS5zcGxpdCgpCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNwbGl0X2xpbmUgb3Igc3BsaXRfbGluZVswXSAh
PSAie25vZGUiOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIG5vdCBzcGxpdF9saW5lIG9y
IHNwbGl0X2xpbmVbMF0gIT0gc2VsZi5ub2RlX21hcmtlcjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBicmVhawo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhd19z
dGF0ZSA9IHNwbGl0X2xpbmVbLTFdCg==

