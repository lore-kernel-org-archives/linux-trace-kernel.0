Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1B242D98
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431657; cv=none; b=tiHFF7JQ2qPvdxj2sBfq+0ozHRIgF91C2zSbZOIkkTxz1pVcmCt0Sj+lJCSNi5ARWjyLXfNzF3d3F1GSfqQSkMfKUb0R39/bzTl346goLtrmNqfJxZnRlABIxzm3iigKArwg12wlzvlww1L7KKbrV9iq5G+K0lkNT6M5hioWsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431657; c=relaxed/simple;
	bh=nTIue3Mvzn20Dd3HzdKn9bucnWMFMJhc/jukety0TF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5MtIiZrMJ1C2RSFq70JU7uGcLxzokXGzm7QPntTgmRrPiggEUt04y/tigcMe2ZEHxmC/vfkwN5L5BTMEK+v4+Gj4ASjihkYi+GfX0/3bZsI+0krqan6j0jtbdnWj+fksfRjbj/wMNbWyV1Bq8rPx0pg/vwxKHzw8AGEKbkCUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3gkkl1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3gkkl1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748431655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nTIue3Mvzn20Dd3HzdKn9bucnWMFMJhc/jukety0TF8=;
	b=L3gkkl1QpWzV7M7R1rIiIBBNrhoyrlbA2PIbIAI7hlujg/a41DDxPxPBn4Ge25tuXoMHwm
	NFOfzEEC3/OLtrmV4pEJ/RsyYwu/sTyCVQ8yZALXCtLXFVIKTUmN9lZKevcJAhQoB7Ol9q
	0lZAorrvAvebbVdBaLpoTqkh/m4Q5PA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Xo6z5pMwOTC_dvWM9wb2Uw-1; Wed, 28 May 2025 07:27:33 -0400
X-MC-Unique: Xo6z5pMwOTC_dvWM9wb2Uw-1
X-Mimecast-MFC-AGG-ID: Xo6z5pMwOTC_dvWM9wb2Uw_1748431652
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5ffe81b2ec9so4430575a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 04:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748431652; x=1749036452;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTIue3Mvzn20Dd3HzdKn9bucnWMFMJhc/jukety0TF8=;
        b=pQhrgB9yXrUkx5TG8YvgksP3spkEN7JNroXBl1F0KvhO3JX1xbVO/7/rFzGbPi7jXe
         vhbo+MyQpKRjdGzqbXbYmT0inLrtRRW+DvvePKx9O9GpLtGfCwClJvDUPYQLrVYWpRwv
         ST+JEBkEvDz9melcoUZJNvweSvawaNS4AZzQE+M5+fDCo7f63lwAAsyr0qFwJwrDygmR
         IdgpR380suFZorCBM17+iyrQw8/p1YNV3tyraKFx91Gxx7uGraBSwoA4+2MJW2NeT74R
         wc5b+7PPy2a/qlT/66iWbVNH6j4hiSrnsvAE3Jsmr957ZN1uWf+nahDcLjn/snVHe7La
         Sknw==
X-Forwarded-Encrypted: i=1; AJvYcCVJv0L4huruU5GJV4f/MA6Lil2goSbuVU3ZwVfUe0Csl7KNoLVGMIN1OOjb6+uvPegIucpiki7ocv5z5Kh5y7h6cNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0lv3MKc40OCN14OCguYc6UpiuAQozJzJN1dKI8JpUgsCiEO8
	piGfYb/YIHC6tDXYHjKAK5ZpeIqmyMNB86hwQEH8F6KZ+HBL5BYooAQqn8AVib1FjgVgYk7BSgX
	B0cId2Lm5vgzbX3TJgRdh1AS/lgY++BAwF3EGeDKR1lN0TdQmispuIEyzJUYVcAy7js5lYOiDgg
	==
X-Gm-Gg: ASbGncvu9IVoGTxEJJ/Rr6bJYiAm9U5RPtvjL7Jx+ian9XE8vt7txji369YzDhN9811
	NJqPj/czZ8+wDV7P7eXrzcAcZEwDM8jtIn6Xai7AxtMqGrGI1U0+eNFXwj1RgDuTSYlxIRJ82ou
	8Xq6gRhEkTZrnZOV1xngCeDKe0enPoXcH/mZzYkUwD1skqyjI/FzuXQxC9PHrkG6fFay13o2KfG
	T4f6VPd5OJpvemKIXPb9Ebg7Y+MYVt1qYHE2w8RO+E2akm3Pb7VHNgveB47Oy9WAsLViTYnRqxc
	CqcfABLznneNq7AJAc7pGM/bWadR43rDR91LlGf5
X-Received: by 2002:aa7:d644:0:b0:5fb:f4a5:7871 with SMTP id 4fb4d7f45d1cf-602da2f841emr10797124a12.16.1748431652415;
        Wed, 28 May 2025 04:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQUWEH2pCZ5bxs+CgNRhJt6TOY/L9pdb25KbPomHATF7eVp8pLEQnjG8aLofLp7Gk157YcA==
X-Received: by 2002:aa7:d644:0:b0:5fb:f4a5:7871 with SMTP id 4fb4d7f45d1cf-602da2f841emr10797098a12.16.1748431652041;
        Wed, 28 May 2025 04:27:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d5d9936sm649141a12.7.2025.05.28.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 04:27:31 -0700 (PDT)
Message-ID: <5fa6744332000be5e914e32d205b634e22bc4f4f.camel@redhat.com>
Subject: Re: [RFC PATCH v2 12/12] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Date: Wed, 28 May 2025 13:27:29 +0200
In-Reply-To: <20250527145032.fIN-37M_@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-13-gmonaco@redhat.com>
	 <20250527133712.CFW5AcNE@linutronix.de>
	 <6f33e6b7ad296f4fd0e9c089ac92e53c08cfd850.camel@redhat.com>
	 <20250527145032.fIN-37M_@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: TS2RGEh9aoK578e1mT_o22hIBKM_aasvpJwQbayh1fM_1748431652
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-05-27 at 16:50 +0200, Nam Cao wrote:
> On Tue, May 27, 2025 at 04:35:04PM +0200, Gabriele Monaco wrote:
> > Thanks for trying it out, and good to know about this stressor.
> > Unfortunately it's a bit hard to understand from this stack trace,
> > but
> > that's very likely a problem in the model.=C2=A0 I have a few ideas
> > where that
> > could be but I believe it's something visible only on a physical
> > machine
> > (haven't tested much on x86 bare metal, only VM).
> >=20
> > You're running on bare metal right?
>=20
> No, it's QEMU:
>=20
> qemu-system-x86_64 -enable-kvm -m 2048 -smp 4 \
> =C2=A0=C2=A0=C2=A0 -nographic \
> =C2=A0=C2=A0=C2=A0 -drive if=3Dvirtio,format=3Draw,file=3Dbookworm.img \
> =C2=A0=C2=A0=C2=A0 -kernel /srv/work/namcao/linux/arch/x86/boot/bzImage \
> =C2=A0=C2=A0=C2=A0 -append "console=3DttyS0 root=3D/dev/vda rw" \
>=20
> The kernel is just x86 defconfig + the monitors.
>=20

Apparently the error is visible on non-PREEMPT_RT only, the models are
designed for preempt-rt and I didn't really test them elsewhere.
Not sure if it's worth tailoring them for non RT kernels, but for now I
can just mark those monitors as RT-only via Kconfig.
Especially this type of monitors is describing very accurately the
preemptiveness of some events, I wouldn't be too surprised if some
rules don't hold in all preempt configurations.
The idea is that, as long as the models stand true, some assumptions
about latency can be made, on the long run this type of assumptions is
likely different across preemption models.

That said, it might be a stupid mistake as well, so I'd look into that
more closely ;)

Thanks again,
Gabriele

