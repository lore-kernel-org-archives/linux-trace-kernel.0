Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EF3BC4EC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899809; cv=none; b=MlRpZqEOAJVbsDTB8Q4VcoYg3HGgXOwEUvSJXiCY2aYuA4NYFtR22dJijlU2puVWZMgPVnpoeA8WtFjKaz3vY6hDCXwhUrCyRKtTwnxC3V7SLaDhTgull5eMeXhVFHuJxNWgEM5z0EtzIaQ4QxZnmHizCasabUlUiJbr18fgx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899809; c=relaxed/simple;
	bh=GLa7jXj54X9WgBa54METRecXc3wNl/aOHp59fQnxOtY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh2GILAbeJz3dhylQwTXLU/GloPsHy1H9PqTstpxTKMq/nWcRzDEFoD+Xeds6aZCO5aKsNRN66beIOGocFxRWUkCB5HxsxqANklzhK+yOwIWwhdfbE8q46UI50Mw/PBLcEKGsX/guL6JJvXLXOmHAvrAep1Cc1PY77YV9RTV6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv+Fisg0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv+Fisg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768899805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GLa7jXj54X9WgBa54METRecXc3wNl/aOHp59fQnxOtY=;
	b=Mv+Fisg03ROPQplfdaYQqEAUyC1IXBcQ5VMy9EovBi4ZdFH4bDaZxr/PRTubvmaDMs0zUM
	BYT+urhXy0GljujtMcIBVTTNT86H6pEN11VDIkpBEM5suS4U57iwu3FQ2p123wxtaI0Hfr
	RkovDnh7qOfogfe198Y+v+c0vlnFOGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-Y_usU4lPP5mLyEEGe3vXJA-1; Tue, 20 Jan 2026 04:03:24 -0500
X-MC-Unique: Y_usU4lPP5mLyEEGe3vXJA-1
X-Mimecast-MFC-AGG-ID: Y_usU4lPP5mLyEEGe3vXJA_1768899803
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso26502645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 01:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899803; x=1769504603;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLa7jXj54X9WgBa54METRecXc3wNl/aOHp59fQnxOtY=;
        b=m/r4dIt9pP7zcAyHXgEWpMuWWacx+mgiKERoxMRjhMUFEm2DQLoO6/1xEBxKWLquMT
         5V6H+w8rqHQqmp0nOpVxvw3KfMvIKweOjdVqBPXcChIyJ8uqKJ6ZQo6uJvk02SVTHq7Z
         /ay7JTHr9pG9tj7Co37bAek70V+oMn6PiwYKxxK+4cpIJhuEUu7Iu1Ui91zFq/XxHYeX
         ZBFr5AQN0O57xFhJbRnnNazIVKl6xns0+QgIoSWjMN49U9Px2GPCWl7vwSSDcr3MrH+1
         SzKQ/Ow4Ar2lJRTcT18t4VY2PkDIgAx6RF7yij/UexUIgmJIF9Mw1I7qjuhi4S9xSSFY
         +3YA==
X-Forwarded-Encrypted: i=1; AJvYcCX54aI2I6WAkxLSKL7Rm9x34tEF7ikOHYjRYGobCbX9dH5h1vF0m1GNYiYr8KgdDgj8wAJey8jIg4vXDb+DxJiSi4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwspmxCbIEom1YDbnsqDAjwzom7ULqcKSCCU7SMjMjyTqruiP0l
	f+epDKW6HJ0hSX4df6/fVeaVinjNyTIpxH63iaiz/XHxk7rBKoCUR3QWCvDOPW+X3EYqmgyUN8C
	b+Swy/ComesIOy7FSBfP81cTtHwYCpULw5K/mEPGwCGUlVS3fxjp/Ys//kXSPJMW85BT+9jJdIA
	==
X-Gm-Gg: AY/fxX6eVq1LmAO/N8rwqVYRSoUOkcTGSXP21mLYKwJHfZMIA8ZDl4YkgofwFoAtVAd
	faEU/0fDCj6oGDgnSsKLSPVgWki5Q8mgmkGUv7KSzzENfwwWjiO7wJmEO2+ewV4uD8k9Bkk2/fC
	fmvoj2HxuRv6A308C5/ursV3ugTKjMshqvZ+KanthO91CXGsrofQqycjrMPo3MOxD87hCDlIzeH
	M/wmKi6chGC9gOyuFw3qflnA+U4iI9uK6mJ6V1jWvD7jqC1tJ/Z3q1CqaV6ZdObwCW6AzkCuWNP
	gX7xwUa/0ZnmXbrY6wY+tyicThB3bmD7dzlzKy6ufA6mL2DOPp+N8FmJsfbtTBavKUtcRMFF2Th
	HpISxirl9B7L91bSBrQUDysICUhl63dMeu9ppQgkqYiLAOBqPq4Zls1B0ipBdw3yaUAmI4RkaqG
	MCf3Rwcv41
X-Received: by 2002:a05:600c:4451:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4801eb0eeb8mr166643125e9.27.1768899802623;
        Tue, 20 Jan 2026 01:03:22 -0800 (PST)
X-Received: by 2002:a05:600c:4451:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4801eb0eeb8mr166642695e9.27.1768899802147;
        Tue, 20 Jan 2026 01:03:22 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm290674505e9.11.2026.01.20.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:03:21 -0800 (PST)
Message-ID: <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 10:03:20 +0100
In-Reply-To: <20260119205601.105821-27-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-27-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: JpeU18VmLflLWxKSxtFt_tX8fIVrTSr-ZZTYGMCTlgU_1768899803
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTAxLTE5IGF0IDE3OjQ2IC0wMzAwLCBXYW5kZXIgTGFpcnNvbiBDb3N0YSB3
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
TGFpcnNvbiBDb3N0YSA8d2FuZGVyQHJlZGhhdC5jb20+CgpMb29rcyBmaW5lIGZvciBtZSwgdGhh
bmtzIQoKSSB3b25kZXIgaWYgd2UgY291bGQgbWVyZ2UgdGhpcyBwYXRjaCB3aXRoIDE1LzI2IHRo
YXQgaXMgaW50cm9kdWNpbmcgYSB2ZXJ5CnNpbWlsYXIgY2hhbmdlIG9uIGluaXRfbWFya2VyLgoK
QW55d2F5OgoKUmV2aWV3ZWQtYnk6IEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29t
PgoKPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9hdXRvbWF0YS5weSB8
IDkgKysrKystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4v
YXV0b21hdGEucHkKPiBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9hdXRvbWF0YS5w
eQo+IGluZGV4IGE2ODg5ZDBjMjZjM2YuLjVmMjNkYjE4NTVjZDMgMTAwNjQ0Cj4gLS0tIGEvdG9v
bHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2F1dG9tYXRhLnB5Cj4gKysrIGIvdG9vbHMvdmVy
aWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2F1dG9tYXRhLnB5Cj4gQEAgLTI5LDYgKzI5LDcgQEAgY2xh
c3MgQXV0b21hdGE6Cj4gwqAKPiDCoMKgwqDCoCBpbnZhbGlkX3N0YXRlX3N0ciA9ICJJTlZBTElE
X1NUQVRFIgo+IMKgwqDCoMKgIGluaXRfbWFya2VyID0gIl9faW5pdF8iCj4gK8KgwqDCoCBub2Rl
X21hcmtlciA9ICJ7bm9kZSIKPiDCoAo+IMKgwqDCoMKgIGRlZiBfX2luaXRfXyhzZWxmLCBmaWxl
X3BhdGgsIG1vZGVsX25hbWU9Tm9uZSk6Cj4gwqDCoMKgwqDCoMKgwqDCoCBzZWxmLl9fZG90X3Bh
dGggPSBmaWxlX3BhdGgKPiBAQCAtNzYsNyArNzcsNyBAQCBjbGFzcyBBdXRvbWF0YToKPiDCoMKg
wqDCoMKgwqDCoMKgIGZvciBjdXJzb3IsIGxpbmUgaW4gZW51bWVyYXRlKHNlbGYuX19kb3RfbGlu
ZXMpOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGxpdF9saW5lID0gbGluZS5zcGxpdCgp
Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBsZW4oc3BsaXRfbGluZSkgYW5kIHNw
bGl0X2xpbmVbMF0gPT0gIntub2RlIjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBsZW4o
c3BsaXRfbGluZSkgYW5kIHNwbGl0X2xpbmVbMF0gPT0gc2VsZi5ub2RlX21hcmtlcjoKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY3Vyc29yCj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgIHJhaXNlIEF1dG9tYXRhRXJyb3IoIkNvdWxkIG5vdCBmaW5kIGEgYmVnaW5uaW5n
IHN0YXRlIikKPiBAQCAtOTEsOSArOTIsOSBAQCBjbGFzcyBBdXRvbWF0YToKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIHN0YXRlID09IDA6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiBsaW5lWzBdID09ICJ7bm9kZSI6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiBsaW5lWzBdID09IHNlbGYubm9kZV9tYXJrZXI6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdGF0ZSA9IDEKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGlm
IGxpbmVbMF0gIT0gIntub2RlIjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGxpbmVb
MF0gIT0gc2VsZi5ub2RlX21hcmtlcjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhawo+IMKgwqDCoMKgwqDCoMKgwqAgZWxzZToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmFpc2UgQXV0b21hdGFFcnJvcigiQ291bGQgbm90IGZpbmQgYmVnaW5uaW5nIGV2ZW50IikK
PiBAQCAtMTE2LDcgKzExNyw3IEBAIGNsYXNzIEF1dG9tYXRhOgo+IMKgwqDCoMKgwqDCoMKgwqAg
IyBwcm9jZXNzIG5vZGVzCj4gwqDCoMKgwqDCoMKgwqDCoCBmb3IgbGluZSBpbiBpc2xpY2Uoc2Vs
Zi5fX2RvdF9saW5lcywgY3Vyc29yLCBOb25lKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3BsaXRfbGluZSA9IGxpbmUuc3BsaXQoKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIG5v
dCBzcGxpdF9saW5lIG9yIHNwbGl0X2xpbmVbMF0gIT0gIntub2RlIjoKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiBub3Qgc3BsaXRfbGluZSBvciBzcGxpdF9saW5lWzBdICE9IHNlbGYubm9k
ZV9tYXJrZXI6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWsKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYXdfc3RhdGUgPSBzcGxpdF9saW5lWy0xXQo=

