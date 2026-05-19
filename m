Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843F3DF002
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177500; cv=none; b=ikrAvMzOr6eLv/DIsq5jqdIo88zd5Xqfn1+iJOZPaH1OvFbo5wRWOGyDr+x4keeSHyIqT7iU4NMgw1MX7QwNud7B/2XeOxVB1sSecdK46Nn00s2cAJ6lhpH78uyd6LH9wLBC9pLu0P/ebWUKY0LozZ/Oe6LUk50AiklIgr9MbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177500; c=relaxed/simple;
	bh=Qf6Dhx3InYyd8ZgX5aZ+T88EYWxiKjGOzkM883wuwyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKJgwSmRx/70eKg9wev+KQzFf5vfI2AjKaoWrdSLUqvz2vRU97xo/la2g6bgjHO7hZq3JxH368FDs0zvJYwJ0rW3UnIoKinOAJUIPdfucCiI1gequjko16eJHKLBhyis4dxWPbpaTBlGKgf4DqrNc+KO6z0mxfu1lvm596tBLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB9bQDRM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB9bQDRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779177498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qf6Dhx3InYyd8ZgX5aZ+T88EYWxiKjGOzkM883wuwyw=;
	b=OB9bQDRM7skcqMkbFCwtBvzb4Rs3JOiu9pxWiVIYqC6fCKSK6NKZBcanDrsXq6InvGLG9w
	Pl8vovOoeW9A1KE6ETNooF6rZGGa9tUY4BGkEin+isIY8gGlKuljLFWSrMO3dRgJP+mtc9
	cDflZUZ2pW+pUzdoQ9Cj/OUbj9o3x2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-VKoHE3s0PCWnSmqlWmzoXQ-1; Tue, 19 May 2026 03:58:16 -0400
X-MC-Unique: VKoHE3s0PCWnSmqlWmzoXQ-1
X-Mimecast-MFC-AGG-ID: VKoHE3s0PCWnSmqlWmzoXQ_1779177496
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so27363075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 00:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177495; x=1779782295;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf6Dhx3InYyd8ZgX5aZ+T88EYWxiKjGOzkM883wuwyw=;
        b=D0TI0fDvP7rJXwbU/Pa4JVqpTZS6wszZgUHkg+OvdNwUyH23PTFP+QcAxC+1q7iie9
         TCqgiVSszHMctRfYn1MXZbzh/MD9G4RJQsBLOkYEwilIMBvRRFvjvuNm6mghVb0XagmL
         YjhJ/UQdYL8C9YmSpT8oST7FgB/kenJsLOSHHn3xHjjBJ7wAOkN1ZniT4HGlYxRmXiKj
         aX0w6BPyt3KKBIrYoAgtiexVnYGwba9GqLRMLwfyEHvZ+WIbRtLSzSJGE3LCztiATCa/
         OA18Z9L/N0/66Vx653NanERS2QbYtUP0oi3lPbocSGEO+fdTgtmiz8LH3ZH/HK7jivwq
         9Kdg==
X-Forwarded-Encrypted: i=1; AFNElJ/0LZ0C/43eM57qV1QjP+WsinaGJvVklbhKcfCyv9MSj2cxSEh0VArMMfbyJ3LeyaG07yqkpz6eyyx7KlIpRJFRlRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTnLCAJItNrmm7Wt/P6A8+qADzGdr71Ha7IkEbrqYxWIKidJS
	3/pTwJk7Z1KOzlCxy4o7SLpoQJbDAUSaoIEHVrLDtq0n14YUpMKleXkfuevQn/TlHmCE4KgF+vC
	6+goeh7xD4B4LRY3C7y/fMFMc/KC3Pyr4IIc0dV7fXn9zTyvmvVCZWxZHWuGVL52gZ5b2+3fSNg
	==
X-Gm-Gg: Acq92OHUw5Ax6E48VjDGPtOLhut7I+TXaQLR6Fr2Ec4DsuLPWhKSu96cpMdKHdQwRB1
	mT3lnB+67xOJfrNvQbRTK4nJQtWVSmGCMAOkXbX51aMt4s+yA/u6o8gTFjjSi+4+fCl8TeTXUft
	Q++8RnsQBnZhUDodb8U6c1GCAWXCkgOZqqqdw5jvH+a2vwDbdqqvG1wfL/udPIOebP3GAZA71re
	o3A69BEcLz9UaAVNlwvN/rvzdGqanwBEFfSSgqwj89sanyug33+bqTmMK9HHZlTQ4eaVvcPj7vr
	6J0mds8XCMkbA59/ds2z03iy0SbXFVzVcUToQFavKF3OIESzahIRw+0bnoQ3M9RKT0qaRAAG8KX
	Gdc9RBVMKfo3AaLXZpQtK5hl/3dU8JzUTg0xkgzqNkMMWtJNHDw3T9tmcB3TmNl1Q1R3IXmePmq
	LlPZjnV+awphLiH8s=
X-Received: by 2002:a05:600c:82c3:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-49007785080mr141286605e9.26.1779177495584;
        Tue, 19 May 2026 00:58:15 -0700 (PDT)
X-Received: by 2002:a05:600c:82c3:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-49007785080mr141286195e9.26.1779177495186;
        Tue, 19 May 2026 00:58:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b9efsm150574195e9.5.2026.05.19.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:58:14 -0700 (PDT)
Message-ID: <2a966b1499e4607d6ab8c33b20a2eff7fa40a855.camel@redhat.com>
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 09:58:13 +0200
In-Reply-To: <87h5o588m4.fsf@yellow.woof>
References: <cover.1777962130.git.namcao@linutronix.de>
	 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
	 <967f1cd8cd6e27aaa65d68194487306bc312caa0.camel@redhat.com>
	 <87wlxaupmz.fsf@yellow.woof>
	 <ad9ca4916604d3f5ffe7a6683f9b82008784fa0e.camel@redhat.com>
	 <87h5o588m4.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _USA2f8l1GRZ6lJowKOwTYSL5VQZ9z50nx6Vso1crYQ_1779177496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 09:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Mon, 2026-05-11 at 13:55 +0200, Nam Cao wrote:
> > > That can work, but not ideal, because hrtimer will not be usable.
> >=20
> > Why not? If we have HA_TIMER_WHEEL , we'd use timer and expire, if we h=
ave
> > HA_TIMER_HRTIMER we'd only need hrtimer with it's hrtimer_get_expires()=
:
> >=20
> > =C2=A0union {
> > =C2=A0struct hrtimer hrtimer;
> > =C2=A0struct {
> > =C2=A0struct timer_list timer;
> > =C2=A0u64 expire; /* Explicitly store the armed budget */
> > =C2=A0};
> >=20
> > we already can't use timer and hrtimer interchangeably.
> > What am I missing here?
>=20
> Ah, now I understand the trick, thanks.
>=20
> We already have an "expires" field in struct timer_list. But I am not
> sure if we are supposed to touch that field. Your proposal looks safer.

Yeah and even if we did, that'd be jiffy-granularity, so not good if the cl=
ock
is ns-based.

Let me sketch it out.

Anyway back to the patch, you need to fix the build for HA_TIMER_HRTIMER as=
 well
(too many arguments to function =E2=80=98ha_invariant_passed_ns=E2=80=99; e=
xpected 3, have 4),
and the title should s/Simply/Simplify/

Thanks,
Gabriele

>=20
> > > Looking at the throttle monitor again, is it possible to rewrite
> > > runtime_left_ns() to read .dl_runtime instead of .runtime? I don't kn=
ow
> > > the deadline schedule very well, but I think .dl_runtime is not chang=
ing
> > > like .runtime?
> >=20
> > In theory yes, but since the runtime is consumed only when running, we
> > cannot
> > just set the timeout once. We either save how much was consumed somewhe=
re or
> > do
> > some start/pause mechanism.
> > Neither looks simpler to me.
>=20
> Understood.
>=20
> Nam

