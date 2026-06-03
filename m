Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1C3D6CC6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502429; cv=none; b=WxJ+gkmyO7LYI+5uz7McYYEN+RmtnBtE1H6YJozwp+kpwVqLp0w4uduze7xRckou+fVOB/QTBJA/xuiGw7UEnTGcV6D4wy5nnUa5boBx4Ra1nkcYfny1Qboe3DtDclBdjAZ93tx1sUM0sbaQ9uV3OPO+axJB6t6f5D7l6W+K6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502429; c=relaxed/simple;
	bh=QFR+/tpZ8uzN474YvRqja0mc2TdziWuaV4fJFtkA3g0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f37oF0dc75ukSSNtF6cJNywU8IGBKTVjdQrYa/wokB7Y1P1emqu2ThkZCCIbfWXfARL6Vm3NuVSbKFxcJY1OGHTlaj/Ak9OrAi09qTo76J9l1teMOtUOm1cJWuoEuvd2coSVOBn/KwrH1xhP4WlWx+pbEkkRr7PmdMCWGfZeYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPmcD1qe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPmcD1qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780502427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFR+/tpZ8uzN474YvRqja0mc2TdziWuaV4fJFtkA3g0=;
	b=iPmcD1qeDRga/mr+hHf+meprOnD3yrPbkuOsmGmhQ5n842DfuHxrZ2A/ncUviNroVf6V02
	ROj6viUCEWlvU6ui5GSQw4wEMoK9j39Tr2kYc6Y1U0/Kd6g/L1LvYPC11OpJIm65I3781M
	AY/jGR4rzdtZ024+1lmiLXoaONtDvfc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-P1Fa6IGZP8--cYHeUXt7UQ-1; Wed, 03 Jun 2026 12:00:26 -0400
X-MC-Unique: P1Fa6IGZP8--cYHeUXt7UQ-1
X-Mimecast-MFC-AGG-ID: P1Fa6IGZP8--cYHeUXt7UQ_1780502425
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd543f9fe2cso733602966b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 09:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502425; x=1781107225;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lNCQQNN6W8nxbhN7SgBZCKWVpkzvgiV38Aw9eTdSbE=;
        b=qqOS8IP8/kwMmxlY0Mmdd3Pu8CWeX26i4hHP4QQGWIuxGHxEdJvHEMOeuU38DHao/E
         DqNuRWlhLjl1GeaUjI2eZBDTy2uTd/HwounFcbj1lckC4+kauvX5MzOQntLh1bEFaBBH
         029aCQqvkX+5QzIT95ovjNKFrXAYBmwWq/qaW03W18bUX1w+zsPVmkE5qCn81i9rrTc1
         iCVmmpRi0vx5eGQB3yaXHWykwk46qvzeNC/PemQlNmGt+w/5NM5Y+EEtl3j/sEqjYEVi
         MqCDKHLtUrIldgP0WxkJsvWTtCgB5JCWSbxEMiaBxZufFiNAhr7wHqiJFtZAdr+h7ilc
         ciLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+P9BNlqEZaSFcro5IWX7lbTz/nzIojrw/sSvksuShHTIzQNTtKB8tTAqGYD5ALoUHCGtiEJyObaoJ99ZEjyyZLaSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXR+KlEfoJh8rigjWeQtgZYWpij5gCKJmCqO4ALgF8tAP786dA
	kDVaCBTuGnmnm9uJUNc0+cfCjYUmjcufnqHLUJRwNokiJa5wb0XA++TcnXFHX89UlWBSBISJ3gr
	Ie/0fnFEsEBH18m9yKzTpXOt8VQ5VCl6CjnAICiyt2A3M0oE27vqhhJGhpxO2q6JxU+rrDyxXNg
	==
X-Gm-Gg: Acq92OGxtJ1vj81S76e7guouXGQpDeHjOf8r1IDaBNk6CmIAY/ygarRaJy9H9AbbWsh
	G1WvZ5z9Ig0LQ6AaqpXpnp30e7d7yEdyP5cqZ/6eKbpIcvbRTHCGhMcpwGUT3F21WtW5WrNCD6z
	d59x9/S4TrqSw8K0IfY1t3p/dxqa+IhlKQCmL7yzy4hi6LGbv2W6gA5+q9oZcxezTATE7rwIXfU
	zfv2YUIgzWS+wG1I+fF8YxF3d5NqOXDbbf7BH5ClTtkXgU3fJYBTb2ZGWmmHlPBOlAsZe7qwT9G
	BAEuDyYhARKsbMQ/Ixy3d8q/kHF8h17knUq8U7pSDiQUb2f654IpoJgFFdCraQ3UT3KpbXuqvgg
	N7EBTKv1wAdNQGKaXtd9CxwN28nUlbCS0IZKY
X-Received: by 2002:a17:906:6a03:b0:bee:e2a2:bddc with SMTP id a640c23a62f3a-bf0af9fcd04mr223604666b.46.1780502424801;
        Wed, 03 Jun 2026 09:00:24 -0700 (PDT)
X-Received: by 2002:a17:906:6a03:b0:bee:e2a2:bddc with SMTP id a640c23a62f3a-bf0af9fcd04mr223601166b.46.1780502424178;
        Wed, 03 Jun 2026 09:00:24 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0558f3885sm175116366b.54.2026.06.03.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:00:22 -0700 (PDT)
Message-ID: <b2dda9ecd9741a3ef8743c43727ac3728eed758c.camel@redhat.com>
Subject: Re: [PATCH v2 06/13] verification/rvgen: Convert
 __fill_verify_guards_func() to Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Wander Lairson Costa
 <wander@redhat.com>,  Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 18:00:21 +0200
In-Reply-To: <2157c2e5fe34251c403604f0d58a3a686a6f6a8b.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
	 <2157c2e5fe34251c403604f0d58a3a686a6f6a8b.1779956342.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C_NwBF5H_5IMvmgTCp4xAvn5PhWuPbWquYRgH9BA148_1780502425
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDEwOjI3ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IFByZXBh
cmUgdG8gcmVtb3ZlIHNlbGYuZ3VhcmRzIGFuZCBzZWxmLl9fcGFyc2VfY29uc3RyYWludHMoKSwg
Y29udmVydAo+IF9fZmlsbF92ZXJpZnlfZ3VhcmRzX2Z1bmMoKSB0byB1c2UgdGhlIHBhcnNlZCB0
cmFuc2l0aW9ucyBmcm9tIExhcmsuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmFtIENhbyA8bmFtY2Fv
QGxpbnV0cm9uaXguZGU+Cj4gLS0tCgpSZXZpZXdlZC1ieTogR2FicmllbGUgTW9uYWNvIDxnbW9u
YWNvQHJlZGhhdC5jb20+Cgo+IHYyOgo+IMKgIC0gZml4IHVwIHRoZSAnOycgc2VwYXJhdG9yIFtH
YWJyaWVsZV0KPiDCoCAtIG1ha2UgcmV0dXJuIHR5cGUgY29uc2lzdGVudCB3aXRoIHRoZSBmdW5j
dGlvbidzIHNpZ25hdHVyZQo+IFtXYW5kZXJdCj4gwqAgLSBmaXggdXAgX19wYXJzZV9ndWFyZF9y
dWxlKCkncyBzaWduYXR1cmUKPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdl
bi9kb3Qyay5weSB8IDM4ICsrKysrKysrKysrKysrKysrKystLS0tCj4gLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmsucHkKPiBiL3Rvb2xzL3Zlcmlm
aWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5weQo+IGluZGV4IGQ5ZjhlMWM3NzM3YS4uZWJhYTZj
OTEzNWMyIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qy
ay5weQo+ICsrKyBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5weQo+IEBA
IC0yMjEsNiArMjIxLDE5IEBAIGNsYXNzIGhhMmsoZG90MmspOgo+IMKgwqDCoMKgIGRlZiBfX3Bh
cnNlX3NpbmdsZV9jb25zdHJhaW50KHNlbGYsIHJ1bGU6IGRpY3QsIHZhbHVlOiBzdHIpIC0+Cj4g
c3RyOgo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGYiaGFfZ2V0X2VudihoYV9tb24sIHtydWxl
WyJlbnYiXX17c2VsZi5lbnVtX3N1ZmZpeH0sCj4gdGltZV9ucykge3J1bGVbIm9wIl19IHt2YWx1
ZX0iCj4gwqAKPiArwqDCoMKgIGRlZiBfX3BhcnNlX2d1YXJkX3J1bGUoc2VsZiwgcnVsZSkgLT4g
bGlzdFtzdHJdOgo+ICvCoMKgwqDCoMKgwqDCoCBidWZmID0gW10KPiArwqDCoMKgwqDCoMKgwqAg
Zm9yIGMsIHNlcCBpbiBydWxlLnJ1bGVzOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudiA9
IGMuZW52ICsgc2VsZi5lbnVtX3N1ZmZpeAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wID0g
Yy5vcAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHNlbGYuX19hZGp1c3RfdmFsdWUo
Yy52YWwsIGMudW5pdCkKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uZCA9IGYiaGFf
Z2V0X2VudihoYV9tb24sIHtlbnZ9LCB0aW1lX25zKSB7b3B9IHt2YWx9Igo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIHNlcDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bmQgKz0gZiIge3NlcH0iCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoY29u
ZCkKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGJ1ZmYKPiArCj4gwqDCoMKgwqAgZGVmIF9fZ2V0
X2NvbnN0cmFpbnRfZW52KHNlbGYsIGNvbnN0cjogc3RyKSAtPiBzdHI6Cj4gwqDCoMKgwqDCoMKg
wqDCoCAiIiJFeHRyYWN0IHRoZSBzZWNvbmQgYXJndW1lbnQgZnJvbSBhbiBoYV8gZnVuY3Rpb24i
IiIKPiDCoMKgwqDCoMKgwqDCoMKgIGVudiA9Cj4gY29uc3RyLnNwbGl0KCIoIilbMV0uc3BsaXQo
KVsxXS5yc3RyaXAoIikiKS5yc3RyaXAoIiwiKQo+IEBAIC0yODcsNyArMzAwLDcgQEAgY2xhc3Mg
aGEyayhkb3Qyayk6Cj4gwqDCoMKgwqDCoMKgwqDCoCBydWxlcyA9IGludmFsaWRfY2hlY2tzICsg
cnVsZXMKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgc2VwYXJhdG9yID0gIlxuXHRcdMKgwqDCoMKg
wqAgIiBpZiBzdW0obGVuKHIpIGZvciByIGluIHJ1bGVzKSA+Cj4gODAgZWxzZSAiICIKPiAtwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIFsicmVzID0gIiArIHNlcGFyYXRvci5qb2luKHJ1bGVzKV0KPiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIFsicmVzID0gIiArIHNlcGFyYXRvci5qb2luKHJ1bGVzKSAr
ICI7Il0KPiDCoAo+IMKgwqDCoMKgIGRlZiBfX3ZhbGlkYXRlX2NvbnN0cmFpbnQoc2VsZiwga2V5
OiB0dXBsZVtpbnQsIGludF0gfCBpbnQsCj4gY29uc3RyOiBzdHIsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ1bGUsIHJlc2V0
KSAtPiBOb25lOgo+IEBAIC00MDYsNyArNDE5LDggQEAgZiIiInN0YXRpYyBpbmxpbmUgdm9pZAo+
IGhhX2NvbnZlcnRfaW52X2d1YXJkKHN0cnVjdCBoYV9tb25pdG9yICpoYV9tb24sCj4gwqAKPiDC
oMKgwqDCoCBkZWYgX19maWxsX3ZlcmlmeV9ndWFyZHNfZnVuYyhzZWxmKSAtPiBsaXN0W3N0cl06
Cj4gwqDCoMKgwqDCoMKgwqDCoCBidWZmID0gW10KPiAtwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNl
bGYuZ3VhcmRzOgo+ICsKPiArwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNlbGYuaGFzX2d1YXJkOgo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gW10KPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqAgYnVmZi5hcHBlbmQoCj4gQEAgLTQxOCwxNCArNDMyLDIyIEBAIGYiIiJzdGF0aWMgaW5saW5l
IGJvb2wgaGFfdmVyaWZ5X2d1YXJkcyhzdHJ1Y3QKPiBoYV9tb25pdG9yICpoYV9tb24sCj4gwqAi
IiIpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIF9lbHNlID0gIiIKPiAtwqDCoMKgwqDCoMKgwqAg
Zm9yIGVkZ2UsIGNvbnN0ciBpbiBzb3J0ZWQoc2VsZi5ndWFyZHMuaXRlbXMoKSk6Cj4gK8KgwqDC
oMKgwqDCoMKgIGZvciB0cmFuc2l0aW9uIGluIHNlbGYudHJhbnNpdGlvbnM6Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgbm90IHRyYW5zaXRpb24ucnVsZSBhbmQgbm90IHRyYW5zaXRpb24u
cmVzZXQ6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQo+ICsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoZiJcdHtfZWxzZX1pZiAoY3Vycl9z
dGF0ZSA9PSAiCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZiJ7c2VsZi5zdGF0ZXNbZWRnZVswXV19e3NlbGYuZW51bV9zdWZmaXh9Cj4gJiYgIgo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGYiZXZlbnQgPT0K
PiB7c2VsZi5ldmVudHNbZWRnZVsxXV19e3NlbGYuZW51bV9zdWZmaXh9KSIpCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgY29uc3RyLmNvdW50KCI7IikgPiAwOgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGYie3RyYW5zaXRpb24uc3JjfXtzZWxm
LmVudW1fc3VmZml4fSAmJiAiCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZiJldmVudCA9PQo+IHt0cmFuc2l0aW9uLmV2ZW50fXtzZWxmLmVudW1fc3Vm
Zml4fSkiKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ1bGUgPSB0cmFuc2l0aW9uLnJ1bGUK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXNldCA9IHRyYW5zaXRpb24ucmVzZXQKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBydWxlIGFuZCByZXNldDoKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBidWZmWy0xXSArPSAiIHsiCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnVmZiArPSBbZiJcdFx0e2N9OyIgZm9yIGMgaW4gY29uc3RyLnNwbGl0KCI7IildCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgY29uc3RyLmNvdW50KCI7IikgPiAwOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIHJ1bGU6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBidWZmLmFwcGVuZCgiXHRcdCIgKwo+IHNlbGYuX19mb3JtYXRfZ3VhcmRfcnVsZXMoc2VsZi5f
X3BhcnNlX2d1YXJkX3J1bGUocnVsZSkpWzBdKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IHJlc2V0Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoZiJc
dFx0aGFfcmVzZXRfZW52KGhhX21vbiwKPiB7cmVzZXQuZW52fXtzZWxmLmVudW1fc3VmZml4fSwg
dGltZV9ucyk7IikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBydWxlIGFuZCByZXNldDoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfZWxzZSA9ICJ9IGVsc2UgIgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9lbHNlID0gImVsc2UgIgoNCg==

