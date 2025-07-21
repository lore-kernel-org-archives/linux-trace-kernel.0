Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1A23AB8F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099644; cv=none; b=tBcz82e7Uw+Y7u+dX/cQmKuqrY5mHXvfDDlT6WXbTmW6pG3puPO/3571DCXf++s1PnI91LdiEbXxBrzgD2XlXsZPpmPzF5O6D9xvXBu0JcUE9XxJLfhMu341h3PpBrlusB9uLcowdXnhhR2UYqta+WJFma8prD+aveERI7V5UHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099644; c=relaxed/simple;
	bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP5YIP4zs+ItKah9RmjhX0DbbdliSskoS4SmRf/YSxfPfLpa0Myb1EUSrV8/Xxo1US28xcxR/YJaK9dXVHDcNjUVzbhITb9frG//jm5GlC1OF7i+grOenZj1RY+1h6uRU7mob4sxUY07Zf7ARO9Ld9evg+iJCrIlW9h3F//f7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMOLLRJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMOLLRJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753099641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
	b=NMOLLRJeu4Kj5yZcKWmElm8+0G5h1ScgWFnaWvQfS/15b2PD8DpPa9z/YNWY1qZKCA9uqq
	tM74L50vosZ1Snwk+CqwTEqL7qEEPeXXFpjuWCvjPu0sN6WWhVfR8EX+uIv0ZxJTO91e2g
	2L2FpiMflwQU6Py+xezyrOXiu+jscOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-p1Hnp3mVNNeSLvGiY8qkLw-1; Mon, 21 Jul 2025 08:07:20 -0400
X-MC-Unique: p1Hnp3mVNNeSLvGiY8qkLw-1
X-Mimecast-MFC-AGG-ID: p1Hnp3mVNNeSLvGiY8qkLw_1753099639
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456013b59c1so25958495e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753099639; x=1753704439;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
        b=GxhEV6tq1hptaMeJwKEfzNfADTZyLKED5xS5geGj1a4TuWJgH6X/0xtka7VZWmrXg0
         5tbS67ZZi+CkWwmRsOW8Ougx9U2f70tIXiE4Z/tKiOz7X80YF1ViNYCB/Rl3WsBONSyL
         H93+tJE22NKMthfMilW9/cb56I3+ZGn90aJmhD/XXY2CbVd7rCRmWDYI0/R58Rmuk7xb
         Rc1XR5pt9g4sbdbosErcnv9UX1EqwwWUthor2I7gOQGgNeGAMMTnLzga4Dh8pFmq2CB/
         LbtauFshaTBq0DIDercY4x0aMsgJtpuacl0cpx6c039rQRhXGSzj1YLfy1rozvF6TH6n
         i0TA==
X-Forwarded-Encrypted: i=1; AJvYcCXZUW+xPYkSo0u77L1lEsL2DzpWg9yMhfbJJyecPMjwEhT5CTwImivgbrk7GcHtHmM9i+9EisKQ7mPnghqfI1rdigs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpl4TNIM9v9Ud/T0Z2BonUe3CC6X5k1JkDUaCn3R0YWfCX9hw
	arJ8lliV8JCpS80JU0MmAYtQRgDQM6/P1SmsUbtBHyaSryHm4frnWyUhLZP1gCnzvscd9nT2qx+
	eFYVPIGYvcCeplXOsuItgHa3b+UmIIZBIocU6XDWKXZFaNzf8WCLNEtinVQjU67pkxHdDqL4QOQ
	==
X-Gm-Gg: ASbGncvw14tECC1CR7oVShR9LvobXy+WQ7IT8EjDCT0szm7nJxJK18x5q7rqPh66Nhz
	klJ3q2FJKTE73a8SgcOPPBeWCvk7yWSwivqi4ry8GRHUh+B/vL/UQxtQLE4tAPQWD3PJSHVrta4
	FRpGXuHKs+MhRYvsu43z/JXniFJReM8sAzLVUI9IHEuvE406lIcKESdPMLNm2u9s6rU1ACdsdzF
	v/Chh15x08GVrgQScYKFMVGaC7PKUSxte31RJ+YBN/Fx9vP51QwBVUw4yE0NuDIxjk+zNrrXMR8
	uks9bcyk1+mpsbRDT6msM0HuG6nOpFwjp3s6HD1ex99j1aGvB0s1YUL/vrnq9wIEew==
X-Received: by 2002:a05:6000:1a8b:b0:3b3:c4b1:a212 with SMTP id ffacd0b85a97d-3b60e4b8576mr15495231f8f.7.1753099639232;
        Mon, 21 Jul 2025 05:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUvbI/CfwwnEkTK8hKXubcNeMcY56S29TCgkmo+UmRsG0JqHV1Q/+3pToH1ysboduZm01Fxw==
X-Received: by 2002:a05:6000:1a8b:b0:3b3:c4b1:a212 with SMTP id ffacd0b85a97d-3b60e4b8576mr15495191f8f.7.1753099638732;
        Mon, 21 Jul 2025 05:07:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm10279837f8f.36.2025.07.21.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:07:18 -0700 (PDT)
Message-ID: <87c5e103780e8d8d0cef27cb3cba69ab0bcb9b1f.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Do not generate unused variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 14:07:15 +0200
In-Reply-To: <636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de>
References: <cover.1752850449.git.namcao@linutronix.de>
	 <636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oC7gRla1z6_hmi7dF7Vx4GVgsfU0fm2Q-8LGXGncHVw_1753099639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDI1LTA3LTE4IGF0IDE2OjU4ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IGx0bDJr
IGdlbmVyYXRlcyBhbGwgdmFyaWFibGUgZGVmaW5pdGlvbiBpbiBib3RoIGx0bF9zdGFydCgpIGFu
ZAo+IGx0bF9wb3NzaWJsZV9uZXh0X3N0YXRlcygpLiBIb3dldmVyLCB0aGVzZSB0d28gZnVuY3Rp
b25zIG1heSBub3QgdXNlCj4gYWxsCj4gdGhlIHZhcmlhYmxlcywgY2F1c2luZyAidW51c2VkIHZh
cmlhYmxlIiBjb21waWxlciB3YXJuaW5nLgo+IAo+IENoYW5nZSB0aGUgc2NyaXB0IHRvIG9ubHkg
Z2VuZXJhdGUgdXNlZCB2YXJpYWJsZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmFtIENhbyA8bmFt
Y2FvQGxpbnV0cm9uaXguZGU+CgpUcmllZCBib3RoIHBhdGNoZXMgYW5kIHRoZXkgc2VlbSB0byB3
b3JrIGFzIGludGVuZGVkLgoKUmV2aWV3ZWQtYnk6IEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0By
ZWRoYXQuY29tPgoKVGhhbmtzLApHYWJyaWVsZQoKPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlv
bi9ydmdlbi9ydmdlbi9sdGwyay5weSB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tCj4gLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vbHRsMmsucHkKPiBi
L3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9sdGwyay5weQo+IGluZGV4IDU5ZGEzNTE3
OTJlYy4uYjA3NWY5OGQ1MGM0IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdl
bi9ydmdlbi9sdGwyay5weQo+ICsrKyBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9s
dGwyay5weQo+IEBAIC0xMDYsMjAgKzEwNiwyNSBAQCBjbGFzcyBsdGwyayhnZW5lcmF0b3IuTW9u
aXRvcik6Cj4gwqDCoMKgwqDCoMKgwqDCoCBdKQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGJ1
Zgo+IMKgCj4gLcKgwqDCoCBkZWYgX2ZpbGxfYXRvbV92YWx1ZXMoc2VsZik6Cj4gK8KgwqDCoCBk
ZWYgX2ZpbGxfYXRvbV92YWx1ZXMoc2VsZiwgcmVxdWlyZWRfdmFsdWVzKToKPiDCoMKgwqDCoMKg
wqDCoMKgIGJ1ZiA9IFtdCj4gwqDCoMKgwqDCoMKgwqDCoCBmb3Igbm9kZSBpbiBzZWxmLmx0bDoK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBub2RlLm9wLmlzX3RlbXBvcmFsKCk6Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgc3RyKG5vZGUpIG5vdCBpbiByZXF1aXJlZF92YWx1ZXM6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBpc2luc3RhbmNlKG5vZGUub3AsIGx0bDJiYS5BbmRPcCk6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmLmFwcGVuZCgiXHRib29sICVz
ID0gJXMgJiYgJXM7IiAlIChub2RlLAo+IG5vZGUub3AubGVmdCwgbm9kZS5vcC5yaWdodCkpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMgfD0ge3N0cihu
b2RlLm9wLmxlZnQpLAo+IHN0cihub2RlLm9wLnJpZ2h0KX0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWxpZiBpc2luc3RhbmNlKG5vZGUub3AsIGx0bDJiYS5Pck9wKToKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJvb2wgJXMgPSAlcyB8fCAlczsi
ICUgKG5vZGUsCj4gbm9kZS5vcC5sZWZ0LCBub2RlLm9wLnJpZ2h0KSkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVpcmVkX3ZhbHVlcyB8PSB7c3RyKG5vZGUub3AubGVmdCks
Cj4gc3RyKG5vZGUub3AucmlnaHQpfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGlz
aW5zdGFuY2Uobm9kZS5vcCwgbHRsMmJhLk5vdE9wKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJvb2wgJXMgPSAhJXM7IiAlIChub2RlLAo+IG5vZGUu
b3AuY2hpbGQpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxdWlyZWRfdmFs
dWVzLmFkZChzdHIobm9kZS5vcC5jaGlsZCkpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIGZvciBh
dG9tIGluIHNlbGYuYXRvbXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgYXRvbS5sb3dl
cigpIG5vdCBpbiByZXF1aXJlZF92YWx1ZXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb250aW51ZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJv
b2wgJXMgPSB0ZXN0X2JpdChMVExfJXMsIG1vbi0+YXRvbXMpOyIgJQo+IChhdG9tLmxvd2VyKCks
IGF0b20pKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBidWYucmV2ZXJzZSgpCj4gQEAgLTEzNSw3
ICsxNDAsMTMgQEAgY2xhc3MgbHRsMmsoZ2VuZXJhdG9yLk1vbml0b3IpOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAibHRsX3Bvc3NpYmxlX25leHRfc3RhdGVzKHN0cnVjdCBsdGxfbW9uaXRv
ciAqbW9uLAo+IHVuc2lnbmVkIGludCBzdGF0ZSwgdW5zaWduZWQgbG9uZyAqbmV4dCkiLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieyIKPiDCoMKgwqDCoMKgwqDCoMKgIF0KPiAtwqDCoMKg
wqDCoMKgwqAgYnVmLmV4dGVuZChzZWxmLl9maWxsX2F0b21fdmFsdWVzKCkpCj4gKwo+ICvCoMKg
wqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMgPSBzZXQoKQo+ICvCoMKgwqDCoMKgwqDCoCBmb3Ig
bm9kZSBpbiBzZWxmLmJhOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBvIGluIHNvcnRl
ZChub2RlLm91dGdvaW5nKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVp
cmVkX3ZhbHVlcyB8PSBvLmxhYmVscwo+ICsKPiArwqDCoMKgwqDCoMKgwqAgYnVmLmV4dGVuZChz
ZWxmLl9maWxsX2F0b21fdmFsdWVzKHJlcXVpcmVkX3ZhbHVlcykpCj4gwqDCoMKgwqDCoMKgwqDC
oCBidWYuZXh0ZW5kKFsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiIsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJcdHN3aXRjaCAoc3RhdGUpIHsiCj4gQEAgLTE2Niw3ICsxNzcsMTMg
QEAgY2xhc3MgbHRsMmsoZ2VuZXJhdG9yLk1vbml0b3IpOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAic3RhdGljIHZvaWQgbHRsX3N0YXJ0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgc3Ry
dWN0Cj4gbHRsX21vbml0b3IgKm1vbikiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieyIK
PiDCoMKgwqDCoMKgwqDCoMKgIF0KPiAtwqDCoMKgwqDCoMKgwqAgYnVmLmV4dGVuZChzZWxmLl9m
aWxsX2F0b21fdmFsdWVzKCkpCj4gKwo+ICvCoMKgwqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMg
PSBzZXQoKQo+ICvCoMKgwqDCoMKgwqDCoCBmb3Igbm9kZSBpbiBzZWxmLmJhOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIG5vZGUuaW5pdDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlcXVpcmVkX3ZhbHVlcyB8PSBub2RlLmxhYmVscwo+ICsKPiArwqDCoMKgwqDCoMKg
wqAgYnVmLmV4dGVuZChzZWxmLl9maWxsX2F0b21fdmFsdWVzKHJlcXVpcmVkX3ZhbHVlcykpCj4g
wqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCIiKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBm
b3Igbm9kZSBpbiBzZWxmLmJhOgo=

