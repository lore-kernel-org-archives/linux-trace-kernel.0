Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BE377003
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346537; cv=none; b=i1TFZop7HNyPU+ytjXThXGoviRASRFycLzMmS0MKrUTvh06xKdGlWuK8KNcl1Mox06qxgBa0NAksCCDJwxVJCR0kc93igiLICjnJglUgLdj47PFm0vTDU/ssFRC0O7AEr1KtxxjhK8tS0mQVkycTqcgFTPNgE18G6eQsRP+I0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346537; c=relaxed/simple;
	bh=+JqLFX616JDwKbMQz43fj2DNhDNXcrBgecFC751sJ8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ux+o26xm+xqYLon5sjWlHqc1TgxSeID9nuJB0zlTGF6rDA1IyYj9iE4OzPsH7U7V+0CMAWNi77/7ifu1c0Tne/nICIFGuT+2XoXyRbYPydxmFzfLo6Bkaud9h4Cc4vhEmwWAqcdDPWHXQH1I6gDFil/iNnEOwpOgV78KAQrSSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGXPKMat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGXPKMat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783346535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+JqLFX616JDwKbMQz43fj2DNhDNXcrBgecFC751sJ8Q=;
	b=bGXPKMatzyDXtnMiUvk1MwnFYZNsk/s4kBe/m9hEb5gxaxR/U6NDG36XZ3zY4XJzoYKM6h
	XE4Uuh2gaNMPSnqEbyi+gBZ/KXcntBsrq7691i13WH+iET1RORAHj5vu1UOo4uVmpmkHyn
	JwCmXIFh50DDNQKjF+BIUsyPCcskDLE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Z-MjDYY9OWa90R7z4t05aw-1; Mon, 06 Jul 2026 10:02:14 -0400
X-MC-Unique: Z-MjDYY9OWa90R7z4t05aw-1
X-Mimecast-MFC-AGG-ID: Z-MjDYY9OWa90R7z4t05aw_1783346532
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c619bb52so21997595e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346532; x=1783951332;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JqLFX616JDwKbMQz43fj2DNhDNXcrBgecFC751sJ8Q=;
        b=C0C2b4KIkBJ0JH+0KC8Sv3zai4c8OrBODndLfK3Ff1ykiG5eR/1XOEwPuGmNB1bmnx
         3C5XcMdtYU9kg0DkrsAlmngae6Rn0U8LYs2XOuXYmm942sVCRhYXbTqhEWEgQynTuA9B
         TM+NWMPRr43QnPuar53CVRT16VPp5ce6p+RWT4IIBdSNVOdfIZsDVLzVqVEmRvf6wIVP
         bOoP4aOUkuHmEC5xY8G9ruh9I9jDNWKvIz9orRr6I7EcRuQC5ufONTqrTucxLG5wIxQP
         jFFVvEZdzxgrDkGTJAfNDDujqgZTeuOyfRcbsZDNzjpaIgGbvcf2icThIHM7pzSNJQL3
         sQUA==
X-Forwarded-Encrypted: i=1; AHgh+RpAVuqepCXRf+kqxQaH+YbrY4ea8Pn6s1Cx31hyctgood1zdWQLx7jxyzeFyCaOHqMdjKH8SCPX2nMpyAuueOFkiUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUMHZSLPbGUs76pNbPDROAT2kHoXUsfkrj6Miy6yfRHw4esAQ
	sYvGxRIc/jIfpEPA9l1YNPdo5wv8o3+pevn4w83xVgRcWGbzCJjSm40NEcXfbCcZEQwglRJh7px
	1+xMZDdN/+k08mfaUrS9jvgvgFhHxBFsYIgnAspcY+iC6cf++gTW4ecb7rbrSuPmFt7QQS+ATCA
	==
X-Gm-Gg: AfdE7ckLZ7vs1iR2Vw0kaq17gMMZCb0r3/83L/DU2XKiSZsaP7iOSjwvkd3nq6A8+cl
	fiRk4VeECEaPQul/EyvOcVk1jddvWhPtk54jVprt4gF/CitPkR/8lQmF/QCv1U62xzBw1V+rAqm
	autqmcFnwwm+r2opgBtmVGgPa1O5EdIoMxamgHfABYaSAeaRq9subh/7jXFNstVqlsFdcFMS//D
	f9lcdOVADDhUyPllzchUppAfnqn6LoP5y786YNhItDqfWBckGkJMAGArNp1fA19HAcbneC1rk5o
	AxihP3fu9plLsUxcNY2tFrjVHmLjiwLoucjTj/a3IuwEml7TG7OijxcB+hYpbRR9FQeQs1aipDZ
	set7rzs2hiHBiIu+W/T+Oyf3dNdEeAsEa9l6AK6YRWBdZCqWHabxWbuEsoAR9VvyDOCrbucN1O7
	nhC2Ts
X-Received: by 2002:a05:600c:8108:b0:492:6f9b:572e with SMTP id 5b1f17b1804b1-493df083a4amr7477305e9.37.1783346532078;
        Mon, 06 Jul 2026 07:02:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8108:b0:492:6f9b:572e with SMTP id 5b1f17b1804b1-493df083a4amr7476565e9.37.1783346531415;
        Mon, 06 Jul 2026 07:02:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm25576171f8f.13.2026.07.06.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:02:10 -0700 (PDT)
Message-ID: <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
	wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 16:02:08 +0200
In-Reply-To: <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
	 <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: Fhptvka6tREqzavNwpvwUFjTo8pJPRioQbH4oPiIfhg_1783346532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-23 at 11:38 +0200, Thomas Wei=C3=9Fschuh wrote:
> This now allows reactors to take (raw) spinlocks. The original idea was
> to not allow that as a reactor can be called from LD_WAIT_FREE context.
> So I am not sure this is the right fix. Not that I have a better one
> available right now.

As far as I understand it, LD_WAIT_FREE is fairly impossible to apply on
preemptible code (here we see it hit by an interrupt).

Since we kind of have to allow raw spinlock to avoid this (even if we don't=
 take
them explicitly), why wouldn't a reactor ever be allowed to take raw spinlo=
cks?

Technically it wouldn't be wrong to take locks from RV monitors, although m=
ost
monitors don't do it explicitly.
If we ever happen to take the wrong lock explicitly from a reactor triggere=
d by
a nasty event (e.g. sched_switch), I believe lockdep would still be complai=
ning
down that path, so we probably don't need to be too strict in rv_react().

Obviously we don't want to disable interrutps for LD_WAIT_FREE to hold eith=
er.

Am I missing something?

Thanks,
Gabriele

