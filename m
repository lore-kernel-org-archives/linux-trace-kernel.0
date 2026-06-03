Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1383859D3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498620; cv=none; b=pEeez665Qbpiz1IJ2l3MySR2xrcYEZZN1nosaC1hG23fwlP78C/6fmrsJAkwnQAzIG4nEAdbJ80mfvCOMF/KGi3BAArbnopfURsI69sW8mJEvbngKpLhLWDOw6uUaGU59vAwYXiZthWV9VDlo6xExOo9p/qQpXRnLuU6KxoiYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498620; c=relaxed/simple;
	bh=mJeC6fcOKaWxfEpajQYM5mHzwGiQNF34QfvBIUo1UxM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMMy69J9uDU2uOY8/2bk+UYZmM0/kSs5McqYwbxWSxcukcuOxyb9chr9LaY4JG+pDKYAOjrScTZlCTRoMxs1NbknzlziSHO/eGgLwW2C9O6ihBtafu2niDp8jTsCfbGJfs7DVhBBS4Rk7O4TvRR1yXK+NTRF2PgVjWIlv5n5Lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ea4e/+Mm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ea4e/+Mm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780498617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJeC6fcOKaWxfEpajQYM5mHzwGiQNF34QfvBIUo1UxM=;
	b=Ea4e/+Mm49QsD3EPOFuRYT+0aD+F3zl7wmQebiSegV8cRZNgc3wFslvuWNYx6spUJerkrX
	BL4J5StbOlzadWPawZ3gUi5gEppVjiIC+/ixMBrZJvAAMIzLE0nrBrKArafErN4VJdtF05
	jR75IPLWV2RXYvoi0DZKL4pwTTnoEYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-Ua-TKu_6Ouu7dQ5XPns5Xw-1; Wed, 03 Jun 2026 10:56:56 -0400
X-MC-Unique: Ua-TKu_6Ouu7dQ5XPns5Xw-1
X-Mimecast-MFC-AGG-ID: Ua-TKu_6Ouu7dQ5XPns5Xw_1780498615
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3773890f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 07:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498615; x=1781103415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we+1HVrYXK+1c6Wm42/kJfeyiwF1Rm9fVBzeIree4vk=;
        b=GV4WcR5CQYGDdT0XhIqu9zpdd5P9gkdWJ1WvI1NTowyDqxImufoxchotEDXpeHXHvq
         QaOgKK3tDLBsGD0WZeLx+evQQlrLszm8lNcZAOe3MfIKTJ9oVour6qlMnxU5J7barFda
         InodBGdfjX0OzXuabIWn2D3MJhAm9U4EeR/2ruwoPactT2Zh1v2g6phV1IDEY8Sq8Fc7
         VH22uhzVpSkXfpt8Ql4TRTu07aej/86Tv/F4+tFlYua8j1T0aozhFmsluZR+D18iTutq
         SAm1RLqrKfW93vLsp4pqeokRvuzE/QZvMlPFsZo9cG2sj3aVRTgeSL0+jvVNKPHcUdPx
         TnPA==
X-Forwarded-Encrypted: i=1; AFNElJ8ImfQj2+/1OLNiNLezcrqXZpFuUpdptB+PMGrppN5AyxXGUsnWXvWhuKrXVAj0+y69eFlKgg1Kl5rKVSSOlz/PJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZooTyx3n5BcJDWwpFLAuKFq2t8JMcIWzaACiFk7tAvznx0xM1
	22bYTo7bEIrdTaQ9yhIHLCpq4SkJPxSJeIbI06Bgnw3hLI9Ar50A34u18IE/msikD+ybl68zinN
	utsm3m/DMamT0rgy+BVJRLj7BXzAGah2aJiFBRc2eXoIhPM77AqXxxLeOZne2F0pmtLtgcg0/2A
	==
X-Gm-Gg: Acq92OFzlaFS7KQ/ckZVgqzbVTINQNLuxO9x36Hm5HwQEfp++ua0yTUrE9OA/NRSINn
	v5i6sixBJi3c27k6oEXJ62dlhHVHxtGUm8hIv2yd913TiHJiXFDv1exp2u/W3l+N4XppcTUR5gT
	IHLg3fSMiN6HT44bnAr6OrxOuSbZxvUf1u4ShXCg8Pz/n6qUeuXLRgKaIl3XWgSOzGh1prOVAQL
	y8jcRgM4mrTVQ434FWufK53AoDcS+mfwoeh03T2Gi21u2DBrh5c5Y3eYTZqXcb+/e6BfOhMyHKp
	7IG56azgJHdtQiljZDpUtRbfRK/HQ9paZjKMfpvpimLa4qEVzTrDUhVq8+3qPSbYb6HEXsRh2co
	/OxJgq9axpw2sa28eOYuR3N/wioAaY0GWOEx5
X-Received: by 2002:a05:6000:1290:b0:45e:e44b:312b with SMTP id ffacd0b85a97d-460219369c2mr3921882f8f.18.1780498614970;
        Wed, 03 Jun 2026 07:56:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1290:b0:45e:e44b:312b with SMTP id ffacd0b85a97d-460219369c2mr3921834f8f.18.1780498614368;
        Wed, 03 Jun 2026 07:56:54 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm7558129f8f.3.2026.06.03.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:56:54 -0700 (PDT)
Message-ID: <0a33f1104792311e738bc3fdf08037d7d3e59508.camel@redhat.com>
Subject: Re: [PATCH v2 04/13] verification/rvgen: Convert
 __fill_verify_invariants_func() to Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Wander Lairson Costa
 <wander@redhat.com>,  Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 16:56:53 +0200
In-Reply-To: <d1fbbafd8af64a9663b3982845ecb2c3c5a4eded.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
	 <d1fbbafd8af64a9663b3982845ecb2c3c5a4eded.1779956342.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xb0iDWz4ZpD0tCPrRpcXF9mBeyFd9NJzmmAzEBxzWes_1780498615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDEwOjI3ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IENvbnZl
cnQgX19maWxsX3ZlcmlmeV9pbnZhcmlhbnRzX2Z1bmMoKSB0byB1c2UgdGhlIHBhcnNlZCBzdGF0
ZXMKPiBpbmZvcm1hdGlvbiBmcm9tIExhcmssIHByZXBhcmUgdG8gcmVtb3ZlIHRoZSBvbGQgcmF3
IHRleHQgcGFyc2luZwo+IGNvZGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmFtIENhbyA8bmFtY2Fv
QGxpbnV0cm9uaXguZGU+CgpSZXZpZXdlZC1ieTogR2FicmllbGUgTW9uYWNvIDxnbW9uYWNvQHJl
ZGhhdC5jb20+Cgo+IC0tLQo+IHYyOiBmaXggdXAgX19zdGFydF90b19pbnZhcmlhbnRfY2hlY2so
KSdzIHNpZ25hdHVyZSBbU2FzaGlrb10KPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlvbi9ydmdl
bi9ydmdlbi9kb3Qyay5weSB8IDMyICsrKysrKysrKysrKysrKystLS0tLS0tCj4gLS0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2RvdDJrLnB5Cj4gYi90b29s
cy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90MmsucHkKPiBpbmRleCBlNmY0NzZiOTAzYjAu
LmEzNDRjYmJjYjM0NiAxMDA2NDQKPiAtLS0gYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZn
ZW4vZG90MmsucHkKPiArKysgYi90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vZG90Mmsu
cHkKPiBAQCAtMTIsNiArMTIsNyBAQCBmcm9tIGNvbGxlY3Rpb25zIGltcG9ydCBkZXF1ZQo+IMKg
ZnJvbSAuZG90MmMgaW1wb3J0IERvdDJjCj4gwqBmcm9tIC5nZW5lcmF0b3IgaW1wb3J0IE1vbml0
b3IKPiDCoGZyb20gLmF1dG9tYXRhIGltcG9ydCBfRXZlbnRDb25zdHJhaW50S2V5LCBfU3RhdGVD
b25zdHJhaW50S2V5LAo+IEF1dG9tYXRhRXJyb3IKPiArZnJvbSAuYXV0b21hdGEgaW1wb3J0IENv
bnN0cmFpbnRSdWxlLCBDb25zdHJhaW50Q29uZGl0aW9uCj4gwqAKPiDCoAo+IMKgY2xhc3MgZG90
MmsoTW9uaXRvciwgRG90MmMpOgo+IEBAIC0xNzcsNiArMTc4LDE0IEBAIGNsYXNzIGhhMmsoZG90
MmspOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYWlzZSBBdXRvbWF0YUVycm9yKCJEZXRl
Y3RlZCBkZXRlcm1pbmlzdGljIGF1dG9tYXRvbiwKPiB1c2UgdGhlICdkYScgY2xhc3MiKQo+IMKg
wqDCoMKgwqDCoMKgwqAgc2VsZi50cmFjZV9oID0gc2VsZi5fcmVhZF90ZW1wbGF0ZV9maWxlKCJ0
cmFjZV9oeWJyaWQuaCIpCj4gwqDCoMKgwqDCoMKgwqDCoCBzZWxmLl9fcGFyc2VfY29uc3RyYWlu
dHMoKQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmhhc19pbnZhcmlhbnQgPSBGYWxzZQo+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLmhhc19ndWFyZCA9IEZhbHNlCj4gK8KgwqDCoMKgwqDCoMKgIGZvciBz
dGF0ZSBpbiBzZWxmLl9zdGF0ZXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgc3RhdGUu
aW52Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5oYXNfaW52YXJpYW50
ID0gVHJ1ZQo+ICvCoMKgwqDCoMKgwqDCoCBmb3IgdHJhbnNpdGlvbiBpbiBzZWxmLnRyYW5zaXRp
b25zOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIHRyYW5zaXRpb24ucnVsZSBvciB0cmFu
c2l0aW9uLnJlc2V0Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5oYXNf
Z3VhcmQgPSBUcnVlCj4gwqAKPiDCoMKgwqDCoCBkZWYgZmlsbF9tb25pdG9yX2NsYXNzX3R5cGUo
c2VsZikgLT4gc3RyOgo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5faXNfaWRfbW9uaXRvcigp
Ogo+IEBAIC0yMTgsMTQgKzIyNywxMyBAQCBjbGFzcyBoYTJrKGRvdDJrKToKPiDCoMKgwqDCoMKg
wqDCoMKgIGFzc2VydCBlbnYucnN0cmlwKGYiX3tzZWxmLm5hbWV9IikgaW4gc2VsZi5lbnZzCj4g
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZW52Cj4gwqAKPiAtwqDCoMKgIGRlZiBfX3N0YXJ0X3Rv
X2ludmFyaWFudF9jaGVjayhzZWxmLCBjb25zdHI6IHN0cikgLT4gc3RyOgo+ICvCoMKgwqAgZGVm
IF9fc3RhcnRfdG9faW52YXJpYW50X2NoZWNrKHNlbGYsIGludjogQ29uc3RyYWludENvbmRpdGlv
bikgLQo+ID4gc3RyOgo+IMKgwqDCoMKgwqDCoMKgwqAgIyBieSBkZWZhdWx0IGFzc3VtZSB0aGUg
dGltZXIgaGFzIG5zIGV4cGlyYXRpb24KPiAtwqDCoMKgwqDCoMKgwqAgZW52ID0gc2VsZi5fX2dl
dF9jb25zdHJhaW50X2Vudihjb25zdHIpCj4gwqDCoMKgwqDCoMKgwqDCoCBjbG9ja190eXBlID0g
Im5zIgo+IC3CoMKgwqDCoMKgwqDCoCBpZiBzZWxmLmVudl90eXBlcy5nZXQoZW52LnJzdHJpcChm
Il97c2VsZi5uYW1lfSIpKSA9PSAiaiI6Cj4gK8KgwqDCoMKgwqDCoMKgIGlmIGludi51bml0ID09
ICJqIjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2tfdHlwZSA9ICJqaWZmeSIKPiDC
oAo+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZiJyZXR1cm4gaGFfY2hlY2tfaW52YXJpYW50X3tj
bG9ja190eXBlfShoYV9tb24sCj4ge2Vudn0sIHRpbWVfbnMpIgo+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gZiJyZXR1cm4gaGFfY2hlY2tfaW52YXJpYW50X3tjbG9ja190eXBlfShoYV9tb24sCj4g
e2ludi5lbnZ9X3tzZWxmLm5hbWV9LCB0aW1lX25zKSIKPiDCoAo+IMKgwqDCoMKgIGRlZiBfX3N0
YXJ0X3RvX2NvbnYoc2VsZiwgY29uc3RyOiBzdHIpIC0+IHN0cjoKPiDCoMKgwqDCoMKgwqDCoMKg
ICIiIgo+IEBAIC0zMjAsMjAgKzMyOCwyMiBAQCBjbGFzcyBoYTJrKGRvdDJrKToKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmludmFyaWFudHNba2V5XSA9IHJ1bGVzWzBd
Cj4gwqAKPiDCoMKgwqDCoCBkZWYgX19maWxsX3ZlcmlmeV9pbnZhcmlhbnRzX2Z1bmMoc2VsZikg
LT4gbGlzdFtzdHJdOgo+IC3CoMKgwqDCoMKgwqDCoCBidWZmID0gW10KPiAtwqDCoMKgwqDCoMKg
wqAgaWYgbm90IHNlbGYuaW52YXJpYW50czoKPiArwqDCoMKgwqDCoMKgwqAgaWYgbm90IHNlbGYu
aGFzX2ludmFyaWFudDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFtdCj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQoCj4gK8KgwqDCoMKgwqDCoMKgIGJ1ZmYgPSBb
Cj4gwqBmIiIic3RhdGljIGlubGluZSBib29sIGhhX3ZlcmlmeV9pbnZhcmlhbnRzKHN0cnVjdCBo
YV9tb25pdG9yCj4gKmhhX21vbiwKPiDCoFx0XHRcdFx0XHRlbnVtIHtzZWxmLmVudW1fc3RhdGVz
X2RlZn0gY3Vycl9zdGF0ZSwgZW51bQo+IHtzZWxmLmVudW1fZXZlbnRzX2RlZn0gZXZlbnQsCj4g
wqBcdFx0XHRcdFx0ZW51bSB7c2VsZi5lbnVtX3N0YXRlc19kZWZ9IG5leHRfc3RhdGUsIHU2NCB0
aW1lX25zKQo+IC17eyIiIikKPiAre3siIiJdCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIF9lbHNl
ID0gIiIKPiAtwqDCoMKgwqDCoMKgwqAgZm9yIHN0YXRlLCBjb25zdHIgaW4gc29ydGVkKHNlbGYu
aW52YXJpYW50cy5pdGVtcygpKToKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGVja19zdHIg
PSBzZWxmLl9fc3RhcnRfdG9faW52YXJpYW50X2NoZWNrKGNvbnN0cikKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBidWZmLmFwcGVuZChmIlx0e19lbHNlfWlmIChjdXJyX3N0YXRlID09Cj4ge3Nl
bGYuc3RhdGVzW3N0YXRlXX17c2VsZi5lbnVtX3N1ZmZpeH0pIikKPiArwqDCoMKgwqDCoMKgwqAg
Zm9yIHN0YXRlIGluIHNlbGYuX3N0YXRlczoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBu
b3Qgc3RhdGUuaW52Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUK
PiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hlY2tfc3RyID0gc2VsZi5fX3N0YXJ0X3Rv
X2ludmFyaWFudF9jaGVjayhzdGF0ZS5pbnYpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVm
Zi5hcHBlbmQoZiJcdHtfZWxzZX1pZiAoY3Vycl9zdGF0ZSA9PQo+IHtzdGF0ZS5uYW1lfXtzZWxm
LmVudW1fc3VmZml4fSkiKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZChm
Ilx0XHR7Y2hlY2tfc3RyfTsiKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfZWxzZSA9ICJl
bHNlICIKPiDCoAoNCg==

