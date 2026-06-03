Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3F47DD6A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500292; cv=none; b=PIAWV0a9BuurOeZJo67Kj2Loq61sUUO3Mq69a76LTTHLIlv6Jd0TcEa1yeXZ+xcnCYKR19JvsOjUHvxlZ5qgTDNfzuAEZe0SAVE1qvJzxhMYSZH3SxOhVwLLBFsAoy/yPbSjMZF7B2f466T3hV2BAsdAVEWuItO3o+zxismvuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500292; c=relaxed/simple;
	bh=nvHieHp8wZREJ54/8T75Kz0Y/Nmscox4fseGQda1z+Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tci9LXcDeUgX2KS9qvLl+gQm2J/a6eEyvdEbQ61xzOrHX3O5E9+Ya4SMyPu9O5UI103FujcNWaNAvdRUbpMCVJ2L8U93hmnBslQVpBmxmAz+YY8/qXPyWeYq1MRUaSgZHgrJPzGvOTg3l/pa9ZxbSDCD4YmjXPzWcrC9w52xCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbmsMUoE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbmsMUoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780500290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvHieHp8wZREJ54/8T75Kz0Y/Nmscox4fseGQda1z+Y=;
	b=ZbmsMUoEVoi60l6HqwRUWFeH5U960TVrvFdYRYT8C8vi3wlIi2EU63BF3A9xo3FPQ3Pajj
	QYfXLDpNpT348iDM1RwTOq4BMeFCScioMlg8XiXYBSWh8FRJTH8v6rlf7UACjZNQfH54/O
	+K2aLnFsUzh6KyFZ0Gecuht5QRkaJ+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-cCFCb6b1OTSvDKlq2AUqPw-1; Wed, 03 Jun 2026 11:24:49 -0400
X-MC-Unique: cCFCb6b1OTSvDKlq2AUqPw-1
X-Mimecast-MFC-AGG-ID: cCFCb6b1OTSvDKlq2AUqPw_1780500287
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3799681f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500287; x=1781105087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkQ13q4TeFpODaLrrkHa03RpcxboXaYGW8+IKDDNU/s=;
        b=R1B9FtC6aepBNqE127Nj/j90DK2uCMTUkiM3ng1YT1AAENKEZKRbGXBsYjydXE9NwC
         2Um+S/+s9x+SbZA3PvQi8e3uSpfKb5UwLrOXdBFaz7gNGviGA+tJpJBc8+YZClJcxZv+
         wEkF8k3U2tkvcByMV86Jtd9nFdBUs4DXQHvYeZ7hA4MA8oo2SsUyv0RP/hYJU7pv0yvN
         WG3n+lv/2pjYvGAXacRt0X8JOCJkUZRmLP2Zo1cOYH+Of7VIl4+m5L0DfyqWaMF9ce7T
         a9dnQ3OgXo+5dK9hJZWzYUPW3Squp7z25MEQZpFbSTjd43aGXbvEKZKnbgGgB34CJCmB
         Of8g==
X-Forwarded-Encrypted: i=1; AFNElJ+jVChYT+5+DCpnjb93N6BjXKf3rOMc+JePZM9wkEKkQVM6cWXZAPT0dAhZ4scv2KNsYv/OG7yMxfWGp5veP+zmr4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBQ2epUf9SZ8/ljqOxGOtQYDBblIveVAIM4tULV3XOkOX/i+K
	j+RXijyqTm8EbXpL03xfABaEh5IMRIN12wePQGSvuodl3S3vfO0HmNp22Z3ISG/Kyo5phWDqtNK
	u0oXqTje0u2PbJzLrb1biqBIwNg5hsr6wpzE829VJGU073NHfkA/oOpEnorXmCN1BN9ASYQE6kE
	ESX4ZYpA==
X-Gm-Gg: Acq92OFVNR9jnRhdCqhafghECEd1NvZcACl2BaghkS06bOBlFwZCpO9zkn+WasyfN6B
	ZNu08URCy0cUVYOvBB1ZLqFPYTci6KHcRSCgfJCQIy6v7MV/8vS8grSGciJEvJHwOpU67z1AQg9
	5r5LKkrQfIohfkBSzA4lBDPc5mnq1xqI+lBhYunH9oNVEU7lT36AM6gc4oTIiFAgXDC8HVV29ap
	n/VyjmZdNF33IDSTMi2OWBof7HRhlR9AdSWMUvYNKCAUgjSD0QBs1Wor3GuEdM2eHg2NRtsv1nV
	DWnUfJy4yD2ggI8T2UnygAF82T9zNCFhErnTfzE8JffhcQofO7pLheIfhRwMa96qB/gYHFCvNpB
	iyJunv7EhX1+5JANz3V35+4NeZ+DSXWxy4qOG
X-Received: by 2002:a05:600c:5288:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490b5ec3ed8mr63197905e9.20.1780500286736;
        Wed, 03 Jun 2026 08:24:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490b5ec3ed8mr63197445e9.20.1780500286383;
        Wed, 03 Jun 2026 08:24:46 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6d16f0csm70928445e9.15.2026.06.03.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:45 -0700 (PDT)
Message-ID: <2cebee30d54bf5ac7bc963396d0ce80cfa8428f9.camel@redhat.com>
Subject: Re: [PATCH v2 05/13] verification/rvgen: Convert
 __fill_setup_invariants_func() to Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Wander Lairson Costa
 <wander@redhat.com>,  Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 17:24:44 +0200
In-Reply-To: <0b2cf5e1bb03d0e3a667b0fc2c7093123ef0a78c.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
	 <0b2cf5e1bb03d0e3a667b0fc2c7093123ef0a78c.1779956342.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TI9YlmMNRaecOXWlTNmRlJ82XC3TGfjxs9NGgkQZO2A_1780500287
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDEwOjI3ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IFByZXBh
cmUgZm9yIHNlbGYuaW52YXJpYW50cyBhbmQgX19wYXJzZV9jb25zdHJhaW50cygpIHRvIGJlIHJl
bW92ZWQuCj4gY29udmVydCBfX2ZpbGxfc2V0dXBfaW52YXJpYW50c19mdW5jKCkgdG8gdXNlIHRo
ZSBuZXcgcGFyc2VkIHN0YXRlcwo+IGZyb20gTGFyay4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYW0g
Q2FvIDxuYW1jYW9AbGludXRyb25peC5kZT4KPiAtLS0KClJldmlld2VkLWJ5OiBHYWJyaWVsZSBN
b25hY28gPGdtb25hY29AcmVkaGF0LmNvbT4KCj4gdjI6IGFkZCBtaXNzaW5nIHRpbWUgY29udmVy
c2lvbiBbU2FzaGlrb10KPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9k
b3Qyay5weSB8IDQ0ICsrKysrKysrKysrKysrKysrKysrLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90
b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmsucHkKPiBiL3Rvb2xzL3ZlcmlmaWNh
dGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5weQo+IGluZGV4IGEzNDRjYmJjYjM0Ni4uZDlmOGUxYzc3
MzdhIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5w
eQo+ICsrKyBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3Qyay5weQo+IEBAIC0y
NTAsNiArMjUwLDI2IEBAIGNsYXNzIGhhMmsoZG90MmspOgo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIChmImhhX3N0YXJ0X3RpbWVyX3tjbG9ja190eXBlfShoYV9tb24sCj4ge3J1bGVbImVudiJd
fXtzZWxmLmVudW1fc3VmZml4fSwiCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZiIge3ZhbHVlfSwgdGltZV9ucykiKQo+IMKgCj4gK8KgwqDCoCBkZWYgX19wYXJzZV9pbnZhcmlh
bnQoc2VsZiwgaW52KToKPiArwqDCoMKgwqDCoMKgwqAgIyBieSBkZWZhdWx0IGFzc3VtZSB0aGUg
dGltZXIgaGFzIG5zIGV4cGlyYXRpb24KPiArwqDCoMKgwqDCoMKgwqAgY2xvY2tfdHlwZSA9ICJu
cyIKPiArwqDCoMKgwqDCoMKgwqAgaWYgaW52LnVuaXQgPT0gImoiOgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNsb2NrX3R5cGUgPSAiamlmZnkiCj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBlbnYg
PSBpbnYuZW52ICsgc2VsZi5lbnVtX3N1ZmZpeAo+ICvCoMKgwqDCoMKgwqDCoCB2YWwgPSBpbnYu
dmFsLnJlcGxhY2UoIigpIiwgIihoYV9tb24pIikKPiArCj4gK8KgwqDCoMKgwqDCoMKgIG1hdGNo
IGludi51bml0Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgInVzIjoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCAqPSAxMCoqMwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNhc2UgIm1zIjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCAq
PSAxMCoqNgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgInMiOgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsICo9IDEwKio5Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gKGYiaGFfc3RhcnRfdGltZXJfe2Nsb2NrX3R5cGV9KGhhX21vbiwge2Vudn0sIgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZiIge3ZhbH0sIHRpbWVfbnMpIikKPiArCj4g
wqDCoMKgwqAgZGVmIF9fZm9ybWF0X2d1YXJkX3J1bGVzKHNlbGYsIHJ1bGVzOiBsaXN0W3N0cl0p
IC0+IGxpc3Rbc3RyXToKPiDCoMKgwqDCoMKgwqDCoMKgICIiIgo+IMKgwqDCoMKgwqDCoMKgwqAg
TWVyZ2UgZ3VhcmQgY29uc3RyYWludHMgYXMgYSBzaW5nbGUgQyByZXR1cm4gc3RhdGVtZW50Lgo+
IEBAIC00NjMsMTUgKzQ4MywxNCBAQCBmIiIic3RhdGljIGlubGluZSBib29sIGhhX3ZlcmlmeV9n
dWFyZHMoc3RydWN0Cj4gaGFfbW9uaXRvciAqaGFfbW9uLAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGNvbmZsaWN0X2d1YXJkcywgY29uZmxpY3RfaW52cwo+IMKgCj4gwqDCoMKgwqAgZGVmIF9f
ZmlsbF9zZXR1cF9pbnZhcmlhbnRzX2Z1bmMoc2VsZikgLT4gbGlzdFtzdHJdOgo+IC3CoMKgwqDC
oMKgwqDCoCBidWZmID0gW10KPiAtwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNlbGYuaW52YXJpYW50
czoKPiArwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNlbGYuaGFzX2ludmFyaWFudDoKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFtdCj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgYnVmZi5h
cHBlbmQoCj4gK8KgwqDCoMKgwqDCoMKgIGJ1ZmYgPSBbCj4gwqBmIiIic3RhdGljIGlubGluZSB2
b2lkIGhhX3NldHVwX2ludmFyaWFudHMoc3RydWN0IGhhX21vbml0b3IKPiAqaGFfbW9uLAo+IMKg
XHRcdFx0XHTCoMKgwqDCoMKgwqAgZW51bSB7c2VsZi5lbnVtX3N0YXRlc19kZWZ9IGN1cnJfc3Rh
dGUsIGVudW0KPiB7c2VsZi5lbnVtX2V2ZW50c19kZWZ9IGV2ZW50LAo+IMKgXHRcdFx0XHTCoMKg
wqDCoMKgwqAgZW51bSB7c2VsZi5lbnVtX3N0YXRlc19kZWZ9IG5leHRfc3RhdGUsIHU2NCB0aW1l
X25zKQo+IC17eyIiIikKPiAre3siIiJdCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIGNvbmRpdGlv
bnMgPSBbIm5leHRfc3RhdGUgPT0gY3Vycl9zdGF0ZSJdCj4gwqDCoMKgwqDCoMKgwqDCoCBjb25k
aXRpb25zICs9IFtmImV2ZW50ICE9IHtlfXtzZWxmLmVudW1fc3VmZml4fSIKPiBAQCAtNDgwLDEz
ICs0OTksMjAgQEAgZiIiInN0YXRpYyBpbmxpbmUgdm9pZAo+IGhhX3NldHVwX2ludmFyaWFudHMo
c3RydWN0IGhhX21vbml0b3IgKmhhX21vbiwKPiDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBwZW5k
KGYiXHRpZiAoe2NvbmRpdGlvbl9zdHJ9KVxuXHRcdHJldHVybjsiKQo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoCBfZWxzZSA9ICIiCj4gLcKgwqDCoMKgwqDCoMKgIGZvciBzdGF0ZSwgY29uc3RyIGlu
IHNvcnRlZChzZWxmLmludmFyaWFudHMuaXRlbXMoKSk6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnVmZi5hcHBlbmQoZiJcdHtfZWxzZX1pZiAobmV4dF9zdGF0ZSA9PQo+IHtzZWxmLnN0YXRl
c1tzdGF0ZV19e3NlbGYuZW51bV9zdWZmaXh9KSIpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnVmZi5hcHBlbmQoZiJcdFx0e2NvbnN0cn07IikKPiArwqDCoMKgwqDCoMKgwqAgZm9yIHN0YXRl
IGluIHNlbGYuX3N0YXRlczoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnYgPSBzdGF0ZS5p
bnYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBub3QgaW52Ogo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnYg
PSBzZWxmLl9fcGFyc2VfaW52YXJpYW50KGludikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
dWZmLmFwcGVuZChmIlx0e19lbHNlfWlmIChuZXh0X3N0YXRlID09Cj4ge3N0YXRlLm5hbWV9e3Nl
bGYuZW51bV9zdWZmaXh9KSIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQo
ZiJcdFx0e2ludn07IikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX2Vsc2UgPSAiZWxzZSAi
Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgZm9yIHN0YXRlIGluIHNlbGYuaW52YXJpYW50czoKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZChmIlx0ZWxzZSBpZiAoY3Vycl9zdGF0
ZSA9PQo+IHtzZWxmLnN0YXRlc1tzdGF0ZV19e3NlbGYuZW51bV9zdWZmaXh9KSIpCj4gK8KgwqDC
oMKgwqDCoMKgIGZvciBzdGF0ZSBpbiBzZWxmLl9zdGF0ZXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW52ID0gc3RhdGUuaW52Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgbm90IGlu
djoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoZiJcdGVsc2UgaWYgKGN1cnJfc3RhdGUgPT0KPiB7
c3RhdGUubmFtZX17c2VsZi5lbnVtX3N1ZmZpeH0pIikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnVmZi5hcHBlbmQoIlx0XHRoYV9jYW5jZWxfdGltZXIoaGFfbW9uKTsiKQo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZCgifVxuIikKDQo=

