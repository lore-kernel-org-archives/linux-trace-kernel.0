Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E347480DC0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909287; cv=none; b=iPDU1Zhc4TZajz34DLN5O37LX7QcntvUcnTwBVqXxxeKeNgSJBhyPpuTC2FLOxchqVPOFHTkCa52MO9ERSElW755X2IIptKniGCmBisXsvfXn278+Tz/kNSxN0hMcwooPKLLCUKtrJHWezRsfIGqv4E03iXIZpX1u5gpfFMWC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909287; c=relaxed/simple;
	bh=piXPXajSellerj2NyLVWyJ/OjwbQtQGrI/5XA2l2urM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcR5uXgnDKGHkrSamnoaYF+KGYUcFJ+thQZmzyJdY/kJ7L+Wx3GRgJ88gNriWzgAFmr9TOF9tr2fxu3Kuer4Hu6NtNcNr8zTnxpXqd42XTjwTfGOcTFgJVdnjovIkPt/0RdHUzuAYLg9YFmg6VcGLLdNXJeI8gMlLCwvZgqqQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL3qT1f+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL3qT1f+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782909285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=piXPXajSellerj2NyLVWyJ/OjwbQtQGrI/5XA2l2urM=;
	b=DL3qT1f+Mnw8EbCbhFValJIihg49LNGd/+bUdTVv/0Qrc0GBsiUUQ5KEistCEhH+/AD2r4
	j93JegRUYTCgyoBxWu8Zkhq07CEh6LRi9kYVAJYCk28coCN/u3sMu/QnHh8Y7GOIP0iTAG
	byR/2VXm9yHdI9DUh1SYqz1L3pAr56A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-2UR_aeBJMSyg1wAbVLGc6g-1; Wed, 01 Jul 2026 08:34:44 -0400
X-MC-Unique: 2UR_aeBJMSyg1wAbVLGc6g-1
X-Mimecast-MFC-AGG-ID: 2UR_aeBJMSyg1wAbVLGc6g_1782909283
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso432312f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 05:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909283; x=1783514083;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SImA3bc67S49Aleri4ZSDqcnWVDlr+FWuRlVb8TQRg=;
        b=mSs94GmR1DVr37gxghbWWBeJKwL5Thit2ONZeX00ZTQj7aZ+WEl8cTfhZm0sreDwaH
         S0x2PLu90f6VsFRspAYAPvnjSxV+uh9Sc3Od5I+4mUACpmhL36SyrjTILHr25y419QbN
         LWMA8TliL9wJAiS4tn20hNvWdUkzcUxHvtGOG8wIsZN6V/qDjbfRsLW9q/LdIiyrz3EZ
         SGkwqUpD231DWRMsNAcXwaU4VcU/kJpjfcauhzzvCBqoTEN970S7Ze6ohzG4O4WVdkGC
         vGUOkmDizLA7r/AiGjgt2ZEBcRh0QPCtqZWK0OO/w0M+GbTMfDR0VWwCkaPaQHFEg8iB
         xzUg==
X-Forwarded-Encrypted: i=1; AFNElJ/O78IYmadc4SEmC6IxhMnYmfoZxTK15K0CdBf+HbJYd1BDLfAle96OJowCViGq7T0YaPS66Epdbm0P7Vy7T3DFraE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtbH9gTaWP4/9ouW0NwygjNufc+Nb6wlVHRr2C+wEMJwE1zWc
	tc2yVUUQANn7lXy3WDMxypkx7ikzlhHLeCBkity8tr5OKZPnKCPWsXdrDP+RSkHs+9NoT+Ft/UZ
	SPmbKbRhPlqfH7UZd0R2ZZViOLJd4RZKdm/WTY0qg7y7kbEVX/wJnUQlYCTYZyD0xMtHxfEA11w
	==
X-Gm-Gg: AfdE7cmz+5yZUvQe52y6Uu4y/xawe/oxLQbc9mnxG7pSEl+vwiIoNpQFFGJLw7eBjJQ
	Z5UpnQdxltON+JQ514wB/VScy6lV2nioeUzOf1rfhjELpu4DPo5cobW8srJ5L8CbxHs55o7G+AV
	rpDwnafdm5wWCzZiOfNfJyyLuqJtnLG9iHzOO0ARG0J/KLmvonKJ4GJe7QI2bGiTrQHdIR1NXhc
	E79BNNXS14j3ALNvrLf6dAmwEkwvx8jKzYsgrPJtcwZgvqoUehawCbOx5K88H/oeVG2zWsGCQYl
	NR5yGOQK7ERS/TDQzzezDJswqNscPy0WUzdWTdvP6jfPbpXmN5rVqysgswL7LHVPHccnWfgrk3a
	N64d48elMEYUuVKq+SKUNUkIr8LhwIfx9f2WvGdMpYQYg/q8C5hiKlOYeDzeBKf11d+peRimYzr
	Jg+6MK
X-Received: by 2002:a05:600c:68d0:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-493c2b4d01dmr14992085e9.13.1782909282943;
        Wed, 01 Jul 2026 05:34:42 -0700 (PDT)
X-Received: by 2002:a05:600c:68d0:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-493c2b4d01dmr14991685e9.13.1782909282587;
        Wed, 01 Jul 2026 05:34:42 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d19573sm15953957f8f.4.2026.07.01.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:34:42 -0700 (PDT)
Message-ID: <84105e8f975673f9c49ed4a5c47f0437fa4f7dc4.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] rv/rtapp/sleep: Make the error more informative
 for user
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 14:34:40 +0200
In-Reply-To: <9bc739eec41b6616e9f81cbe50759cefb1c3ad9c.camel@redhat.com>
References: <cover.1781852967.git.namcao@linutronix.de>
		 <d97b4b5c476e5792b6875ec9bbf8dc214f999516.1781852967.git.namcao@linutronix.de>
	 <9bc739eec41b6616e9f81cbe50759cefb1c3ad9c.camel@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ipsGwM0CVt2Ln68BHyr5XWVCT0Ag7AuIDCKNwSEIYcQ_1782909283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 14:26 +0200, Gabriele Monaco wrote:
> On Fri, 2026-06-19 at 09:21 +0200, Nam Cao wrote:
> > -static void handle_sched_wakeup(void *data, struct task_struct *task)
> > +static void handle_sched_exit(void *data, bool is_switch)
> > =C2=A0{
> > -=09ltl_atom_pulse(task, LTL_WAKE, true);
> > +=09ltl_atom_pulse(current, LTL_SCHEDULE_IN, true);
> > =C2=A0}
>=20
> Well, this triggers also in a spurious schedule: current -> current, can
> that be a problem? Otherwise you may either use sched_switch over next

sched_switch would obviously be in the wrong context.. Ignore that.

> or pulse only if is_switch.
>=20
> It probably isn't a big deal though, since there's no SLEEP prior.. But
> we may want to avoid the noise.
>=20
> Looks good overall.
>=20
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Thanks,
> Gabriele

