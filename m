Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295213A89DF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894982; cv=none; b=sD0GcPoGbO24nqLYFxLwF/bwK4OL3Srslkr1UIjXi4txoIJIkws/BnTTV5+s+KUmxGQ+ZPsfmSDQVs1L3KpgnLx/pw3KgceHFA/ZMVvaaUzAKZQXLh9vLb0CrkJEJ+ZvaY5/vFoVVv42w5cP8dFDMQwDrBjpfMlEz5AfRwVOdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894982; c=relaxed/simple;
	bh=oEyFmivE3K8J7Oi7ke49NJtAa6NZlEY8G+v8FDYSikk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUazg6eEB32Svx4QH0t7k1ob+csZUT5z3au2ffwfj/OwwxG8I6FxpKnsnzIxAzMHOuXCFr6WoMAQDXqzViC2hucz0SbWxEbNDPOSoqDy9ORoFSabiqoo9VBPsl3km5kbHxyVSZ9E12SzfqqlhabRV5CtzKSKfXvgY4FrBWLJPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2rHFc7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2rHFc7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768894977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oEyFmivE3K8J7Oi7ke49NJtAa6NZlEY8G+v8FDYSikk=;
	b=g2rHFc7dqTM/7wlR9t8wvVzO1ziNnFvvWQ4XeYkwK0wtwbEYWGB4ZeCYqmdLeCsS304RUe
	GTM5Ezck0BIz7vKDlqCw1ikg+n3LAtBIRKfrbA6wpasjnjBoPYpR5mL33XRQWAHPCsWLlJ
	UNyuHBaVZ6L6PI2MWi/GrJ3QiQ0ZGHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-ul865UGjP5SKVsjsC6ovUw-1; Tue, 20 Jan 2026 02:42:56 -0500
X-MC-Unique: ul865UGjP5SKVsjsC6ovUw-1
X-Mimecast-MFC-AGG-ID: ul865UGjP5SKVsjsC6ovUw_1768894975
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso52533545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894975; x=1769499775;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEyFmivE3K8J7Oi7ke49NJtAa6NZlEY8G+v8FDYSikk=;
        b=Y2ykw9Q+XGNbiZCNd1Khr/cm+yGfKUb1u30b86OpNNBs/KtSit1EGho+15T65pc+98
         EmgV4C+aox7Mt9pyNgWMg4FMf5qSdhXfgFFqpfLEWa2Bb4/mKSeuCXy3V5aInDHxq9KH
         PI3Qm1yx0apyvrgpqlOP2xMN+oOi971Y++ivDw66ON2jJd+NDHHSyxMpM9L1rS/YpxC+
         DZA6ncqfm8W22OsgZLYdW8vCU5PJ8Zwn73AZwXGwGTg4HBGoUzhKT3Me+psTPI46WjD5
         ojwZSmBJlwAPuXKE5cypBnbymXwrxzhoZnqamnjUoLbXPO5BKOzTHMaOzaVlKl6V4F4t
         gtOw==
X-Forwarded-Encrypted: i=1; AJvYcCWeBai5B+bRWpeiMpLcBl8gZeR8u9ck4HuCuPQu7SMFWP9VodVkbp3Aedkh4TwRrdLgJkMuBIooFpSwJ1WgkuyUkhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEgkjaVdba58UO9gepa7lrjoXOMkhOtT4fDPIqNONC+aN80xj
	es1FeVYKDAcSGgEpeylyKqcKfSDdBE8PkDd/pcHSeR4MqIdH+T+Ka+RHb/3nQFAQo1os5HIzlT2
	2tJlNnCxOLunp985j+ivqoqcdaL4zC2Z9rWnqBN+q0b3ykHgQau7ktXUCe29yw7UnIDs/s4mFdg
	==
X-Gm-Gg: AY/fxX4E4xN4IYsAI4ogQV5FKyDzT6ZkOp0Vxd3RBhP7Gy1yDzUZGHIZatiqAgna+rm
	VLzVeo+a51cxaSsuVDx7ZNCpTGyK3AC//4kp1Bfw489hjEh0YYhu8OtIsuhbeYRBJOZ4yJjXWpK
	/9EMXl+apbFXoHf/JiqXrhX8EzX8qfQxhV3giui4vKN2e16FR18jxxKUOgM04xISEcNUjkL+Opp
	TGH+qPjHbF8jNIzxo8OFyHqx1cveN0bxQMxty8tdP5mmsULh4Po1q+IW5wKzub6GvVB4YyRH17X
	+UOL4JMqFgQwklkuaAEsxDa1AKo10uY+gp0vjKnVhqE8aE6v1AchOrt0WFRlW7/mJbD52YJe4rU
	9vgu2v5D1T99YdgTk+U/TJ3q36tHge/EjfwrV4RQmpo2i4WNw4k45SPZLlizOwu1wjaxDqIfnH7
	kQDeyW6n24
X-Received: by 2002:a05:600c:310c:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-4801eaadcc0mr165593665e9.7.1768894975139;
        Mon, 19 Jan 2026 23:42:55 -0800 (PST)
X-Received: by 2002:a05:600c:310c:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-4801eaadcc0mr165593195e9.7.1768894974692;
        Mon, 19 Jan 2026 23:42:54 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe2c04bsm97427595e9.8.2026.01.19.23.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:42:54 -0800 (PST)
Message-ID: <3278263b3df8ced3816b5206f9c350d8c18f7ce5.camel@redhat.com>
Subject: Re: [PATCH 05/26] rv/rvgen: remove unnecessary semicolons
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:42:53 +0100
In-Reply-To: <20260119205601.105821-6-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-6-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: SRqcKuQc07KwwcV5HG4o4vbjrkEcO7K2T7meWlXfEoo_1768894975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTAxLTE5IGF0IDE3OjQ1IC0wMzAwLCBXYW5kZXIgTGFpcnNvbiBDb3N0YSB3
cm90ZToKPiBSZW1vdmUgdW5uZWNlc3Nhcnkgc2VtaWNvbG9ucyBmcm9tIFB5dGhvbiBjb2RlIGlu
IHRoZSBydmdlbiB0b29sLgo+IFB5dGhvbiBkb2VzIG5vdCByZXF1aXJlIHNlbWljb2xvbnMgdG8g
dGVybWluYXRlIHN0YXRlbWVudHMsIGFuZAo+IHRoZWlyIHByZXNlbmNlIGdvZXMgYWdhaW5zdCBQ
RVAgOCBzdHlsZSBndWlkZWxpbmVzLiBUaGVzZSBzZW1pY29sb25zCj4gd2VyZSBsaWtlbHkgYWRk
ZWQgb3V0IG9mIGhhYml0IGZyb20gQy1zdHlsZSBsYW5ndWFnZXMuCj4gCj4gVGhlIGNoYW5nZXMg
YWZmZWN0IGZvdXIgaW5zdGFuY2VzIGFjcm9zcyB0d28gZmlsZXMuIEluIGRvdDJjLnB5LCBvbmUK
PiBzZW1pY29sb24gaXMgcmVtb3ZlZCBmcm9tIGEgYm9vbGVhbiBhc3NpZ25tZW50LiBJbiBkb3Qy
ay5weSwgdGhyZWUKPiBzZW1pY29sb25zIGFyZSByZW1vdmVkIGZyb20gc3RyaW5nIGFwcGVuZCBv
cGVyYXRpb25zIHRoYXQgYnVpbGQKPiBnZW5lcmF0ZWQgQyBjb2RlLiBOb3RlIHRoYXQgdGhlIHNl
bWljb2xvbnMgaW5zaWRlIHRoZSBzdHJpbmcgbGl0ZXJhbHMKPiB0aGVtc2VsdmVzIGFyZSBjb3Jy
ZWN0bHkgcHJlc2VydmVkIGFzIHRoZXkgYXJlIHBhcnQgb2YgdGhlIEMgY29kZQo+IGJlaW5nIGdl
bmVyYXRlZCwgbm90IFB5dGhvbiBzeW50YXguCj4gCj4gVGhpcyBjbGVhbnVwIGltcHJvdmVzIGNv
bnNpc3RlbmN5IHdpdGggUHl0aG9uIGNvZGluZyBzdGFuZGFyZHMgYW5kCj4gYWxpZ25zIHdpdGgg
dGhlIHJlY2VudCBpbXByb3ZlbWVudHMgdG8gcmVtb3ZlIG90aGVyIFB5dGhvbgo+IGFudGktcGF0
dGVybnMgZnJvbSB0aGUgY29kZWJhc2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogV2FuZGVyIExhaXJz
b24gQ29zdGEgPHdhbmRlckByZWRoYXQuY29tPgoKTXVzY2xlIG1lbW9yeSBpcyBoYXJkIHRvIGNv
bnRyb2wuIFRoYW5rcyEKClJldmlld2VkLWJ5OiBHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVk
aGF0LmNvbT4KCj4gLS0tCj4gwqB0b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmMu
cHkgfCAyICstCj4gwqB0b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmsucHkgfCA2
ICsrKy0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qy
Yy5weQo+IGIvdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2RvdDJjLnB5Cj4gaW5kZXgg
MGZiMzYxN2FkOGNlOS4uYjlhMmMwMDlhOTI0NiAxMDA2NDQKPiAtLS0gYS90b29scy92ZXJpZmlj
YXRpb24vcnZnZW4vcnZnZW4vZG90MmMucHkKPiArKysgYi90b29scy92ZXJpZmljYXRpb24vcnZn
ZW4vcnZnZW4vZG90MmMucHkKPiBAQCAtMTIwLDcgKzEyMCw3IEBAIGNsYXNzIERvdDJjKEF1dG9t
YXRhKToKPiDCoMKgwqDCoMKgwqDCoMKgIGZvciBlbnRyeSBpbiBidWZmOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiBmaXJzdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJpbmcgPSBzdHJpbmcgKyAiXHRcdFwiIiArIGVudHJ5Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmaXJzdCA9IEZhbHNlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZmlyc3QgPSBGYWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmluZyA9IHN0cmluZyArICJcIixcblx0
XHRcIiIgKyBlbnRyeQo+IMKgwqDCoMKgwqDCoMKgwqAgc3RyaW5nID0gc3RyaW5nICsgIlwiIgo+
IGRpZmYgLS1naXQgYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmsucHkKPiBi
L3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5weQo+IGluZGV4IDFjMGQwMjM1
YmRmNjIuLjI5MTM4NWFkYjJjMjAgMTAwNjQ0Cj4gLS0tIGEvdG9vbHMvdmVyaWZpY2F0aW9uL3J2
Z2VuL3J2Z2VuL2RvdDJrLnB5Cj4gKysrIGIvdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2Vu
L2RvdDJrLnB5Cj4gQEAgLTM3LDEwICszNywxMCBAQCBjbGFzcyBkb3QyayhNb25pdG9yLCBEb3Qy
Yyk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoIlx0Lyog
WFhYOiB2YWxpZGF0ZSB0aGF0IHRoaXMgZXZlbnQgaXMgb25seSB2YWxpZAo+IGluIHRoZSBpbml0
aWFsIHN0YXRlICovIikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoYW5kbGUg
PSAiaGFuZGxlX3N0YXJ0X3J1bl9ldmVudCIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
c2VsZi5tb25pdG9yX3R5cGUgPT0gInBlcl90YXNrIjoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJ1ZmYuYXBwZW5kKCJcdHN0cnVjdCB0YXNrX3N0cnVjdCAqcCA9IC8qIFhYWDog
aG93IGRvIEkgZ2V0Cj4gcD8gKi87Iik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBidWZmLmFwcGVuZChmIlx0ZGFfe2hhbmRsZX1fe3NlbGYubmFtZX0ocCwKPiB7ZXZlbnR9e3Nl
bGYuZW51bV9zdWZmaXh9KTsiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1
ZmYuYXBwZW5kKCJcdHN0cnVjdCB0YXNrX3N0cnVjdCAqcCA9IC8qIFhYWDogaG93IGRvIEkgZ2V0
Cj4gcD8gKi87IikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBwZW5k
KGYiXHRkYV97aGFuZGxlfV97c2VsZi5uYW1lfShwLAo+IHtldmVudH17c2VsZi5lbnVtX3N1ZmZp
eH0pOyIpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoAo+IGJ1ZmYuYXBwZW5kKGYiXHRkYV97aGFuZGxlfV97c2VsZi5uYW1l
fSh7ZXZlbnR9e3NlbGYuZW51bV9zdWZmaXh9KTsiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gYnVmZi5hcHBlbmQoZiJcdGRhX3toYW5kbGV9X3tzZWxmLm5hbWV9KHtldmVu
dH17c2VsZi5lbnVtX3N1ZmZpeH0pOyIpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYu
YXBwZW5kKCJ9IikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoIiIpCj4g
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gJ1xuJy5qb2luKGJ1ZmYpCg==

