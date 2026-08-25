Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B334750F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669025; cv=none; b=We5ScRq84/GYypixJo/gnSP6DMagMCePCgd7wL2o/AIudhWr2LIJ008KWq1kz5AnjZrbum7mQgjvI1YQF6pdqfkH3zabE1X7kmxkKavo6ktU9Su2g6JHYqph2OhiJlff3ZFemoqQKfxWD609q5JtJ2NV4/nZ1Z7kQw7ddLhbSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669025; c=relaxed/simple;
	bh=QiMiWYwpSHpACblW5rPwiAKwTm3kYi4UV6UJP2mJZB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+2II+vZVYWGMs1Vdp4hfXpdwIKl0lkPG7VTElXTh9YgNL23Pw+la+HOo3bvHo73WmjcFsot8LpKPoNTOPrK5F6lWAlp1vy7z88E2VnmMBPXIynfxE57NWRvQ8QXIe7/YcP3EAlnvnh2XhypVGC4+qBnjUyGOVNwCiZRyxQb51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEdwoMrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEdwoMrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787669022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QiMiWYwpSHpACblW5rPwiAKwTm3kYi4UV6UJP2mJZB4=;
	b=UEdwoMrsZuXIoSpU7BIx60923NmxPzruPiH9kDZcmyvT8XkC7xR66hH+yKIWuyEo8XJiBc
	DNjyzQTH5ve9Wm1qsxUeP1lyJluAwsWspXgPpP/euVBK9tr2oy3xvIbwb0ZoFKswwklKOk
	FkEaZ+L3DuM7jIq19LOKmm1ElxHZ3ck=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-cf4V7X5MOEWq7uIXjFf5Yg-1; Tue, 25 Aug 2026 10:43:39 -0400
X-MC-Unique: cf4V7X5MOEWq7uIXjFf5Yg-1
X-Mimecast-MFC-AGG-ID: cf4V7X5MOEWq7uIXjFf5Yg_1787669018
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15d4224f9dso162075466b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 07:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787669018; x=1788273818;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+mzjBvtJiXWlRYg5vALkaQ/lMTmfc5pn1N/aoubfE2Y=;
        b=QIq/zqrZFGzHzsMLWGrHh+8LyKdtsCywjIbWXvbUo1eYd+cZmvGSZeB0qPsricdrC/
         HYhTGYZ9oI4Q9edMgUFBpNdhsop09UoSuUNRJib6xH2Z717bbHnHcKsnyLq4OxlTu5QA
         wRAr8aTac1MPKXlfOzO0IAZrlBTpCZOWCuddUWYWH6kLU2GgZca2m3+45ywW3klIhBh6
         AuptqYqRKgGnOOg2hIhj/2gn1dUG+HiLlcJpZ1MYj44hX7uBNUz+heyErDJJJxIRwzmp
         kTDf6i11obOrVhMeX6LHJotdfJSJYaU3Vo2TxE6PDDWuXpXlwQSAZQQeC04rnCsC4+hl
         oxbA==
X-Forwarded-Encrypted: i=1; AHgh+RpA/SePGkgPP6QvmGI9pmPHdPD6VliKVHv1SKebtprvUqA1Uw9dQ629QxPqIbZTUcnQ/gBKkIY2WhQJljy+mQD4Dv8=@vger.kernel.org
X-Gm-Message-State: AFuF++mvuNnYP1aYHlTwju23c/3cNpZ2svPAq8PoIzesiNEeO39nXf1I
	g0xYfNmKr+te+DyB0E4MrGkop8beL2j1P2r92zD+7y9DpcK3I7cO4XKnt74rIHUOYkcxsv8O5U5
	ErHlDOmmCmk0or41PzFXfCQ0mGGe/j+ApiGA9at3jN7hWHA+06ofqtEhDI0Ch0dTodKQRi9IZiw
	==
X-Gm-Gg: AR+sD10rdIisLFWq5b0dcJg7Iseg1nISuJferLuPcbrTj8GhY8fXUoP101MKnCN9YG5
	oLM+mD6vTD2Lad9746h+wAxa5vwZ0tBrst7WnbkJbp41HUHhXB+DVEGYZfOt1dWC3O1R3GJfS4/
	OX6Ru486o6uMIetCcBoVIKyKA1Q0YuJeIMbGC5E0nK58y5vi/vVhE2hJ5a4SfHIHfeUIYrRyEY5
	XTkZW+tPbp7g67cwCbqPst9OOc+1WO6De2To2wNSlYCyriEFntKondzyt8QbLnF1Guy3VShht9i
	XZtOS7UwcHBipxqsYmGaGdGg8q6wYIB4y3hEs5bUY3gLY6Ec2O2MSMH6xvLN1nqD8bSoMVfK4ed
	BmSt4KF/RR2Oqis6o8InkPwGNXRthRRu1mhxYaKxfy3/BIXT++XLm34usCv/TnS2eovxxTQ==
X-Received: by 2002:a17:907:72cc:b0:c1f:8145:820c with SMTP id a640c23a62f3a-c2492579d7cmr2900604066b.2.1787669018023;
        Tue, 25 Aug 2026 07:43:38 -0700 (PDT)
X-Received: by 2002:a17:907:72cc:b0:c1f:8145:820c with SMTP id a640c23a62f3a-c2492579d7cmr2900596466b.2.1787669017406;
        Tue, 25 Aug 2026 07:43:37 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f8f08sm1819198666b.35.2026.08.25.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 07:43:36 -0700 (PDT)
Message-ID: <1b3bb36a8acfa64dd250482e92a23dadcc8a6329.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 25 Aug 2026 16:43:34 +0200
In-Reply-To: <d72daef4-5d68-49e4-a264-3f813d897813@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
	 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
	 <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
	 <87zeylnos3.fsf@yellow.woof>
	 <b6de8228ee3045104a03ab4754e5ecc50e67f627.camel@redhat.com>
	 <20260819112038-e7b033f8-3711-4acd-ba05-dbef015c6fc8@linutronix.de>
	 <d72daef4-5d68-49e4-a264-3f813d897813@linux.dev>
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
X-Mimecast-MFC-PROC-ID: 5Bcd2EPDRkwCsYfMR8p8xES0fMZ47n2gBJzGfDMFK64_1787669018
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-20 at 01:28 +0800, Wen Yang wrote:
> So I don't think LD_WAIT_SPIN for everything is safe, it's not just=20
> "less strict on paper".

Yes it won't be safe, we could have wrong reactors not reported by lockdep,=
 but
so would your conditional check. We'd be catching everything in interrupts,=
 but
if a model never runs in interrupt context, we'd be demoted to LD_WAIT_SPIN
nonetheless.

Your condition is kind of a best-effort to do a bit better than just
LD_WAIT_SPIN. Again, I'm not completely against it, but it isn't a final
solution (not that I can think of a better one) and if most people find it
confusing, we're probably better off without it.

Or am I missing something?

> If a reactor ever does raw_spin_lock() by mistake while running from=20
> nrp's path, check_wait_context() takes the wait type straight from the=20
> override map:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(class->lock_type =3D=3D LD_LOCK_WAI=
T_OVERRIDE))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
curr_inner =3D prev_inner;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SPI=
N */
> =C2=A0=C2=A0=C2=A0=C2=A0 if (next_outer > curr_inner)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return print_lock_invalid_wait_context(...);
>=20
> SPIN nested in SPIN is 2 > 2, which is false, so it just passes.
> We'd be silently giving up the one case (hardirq/NMI) where the "no=20
> locks" rule for reactors actually matters, which is the same thing that=
=20
> bit you with the signal reactor.

True, that is one, but it isn't the only case where using locks can be an i=
ssue,
namely sched_switch is particularly hard to please (interrupts are disabled=
 for
a reason).

> And for what it's worth, checking context to decide the wait type isn't=
=20
> something we'd be introducing -- lockdep does the same thing to get the=
=20
> baseline before any override is applied, in the exact function that=20
> produced this splat:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 static inline short task_wait_context(struct tas=
k_struct *curr)
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (lockdep_hardirq_context()) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (curr->hardirq_threaded=
 || curr->irq_config)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return LD_WAIT_CONFIG;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return LD_WAIT_SPIN;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
} else if (curr->softirq_context) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return LD_WAIT_CONFIG;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return LD_WAIT_MAX;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> That's four cases. Our in_nmi() || in_hardirq() is a simplification of
> what's already there, not a new habit.

I'm not familiar with the lockdep code, so I may be missing something here,=
 but
isn't this function getting the current context? It isn't used to tune the
lockdep logic for some specific function, it /is/ the lockdep logic itself.

Is this really comparable?

> Thomas, on disabling preemption instead: it does fix the pagefault
> case, and it's a no-op for nrp since preempt_count is already elevated=20
> there. But it changes what a reactor is allowed to do, for every=20
> reactor, not just the two above.cspin_lock() on RT checks=20
> might_resched() before it even looks at thevlock:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 static __always_inline void __rt_spin_lock(spinl=
ock_t *lock)
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
rtlock_might_resched();=C2=A0=C2=A0 /* unconditional */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
rtlock_lock(&lock->lock);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> so any future reactor using a plain spinlock would hit that every single=
=20
> time, lock contended or not, on top of whatever it's already called for.=
=20
> That seems worse than the thing we're trying to fix.

I'm also against disabling preemption, we may even be able to avoid schedul=
ing
by also disabling interrupts in a convenient order, but in principle I'd av=
oid
that like plague. RV was born as a tool for real-time and disabling preempt=
ion
only to get better lockdep reporting doesn't look right to me.

Sure we could do it only with lockdep and assume lockdep's overhead is alre=
ady
enough, but we're again complicating things.

> Since neither struct rv_reactor nor rv_react() actually documents what
> context a callback may run in, maybe that's worth spelling out
> separately regardless of what we do here -- something close to what
> printk already does for the same reason (reactor_printk's
> vprintk_deferred() leans on this internally: is_printk_legacy_deferred()
> checks in_nmi() to decide whether it's safe to take console_lock or
> whether it has to go through the lock-free irq_work path instead).

You raise a fair point though, we should document all this somewhere. I bel=
ieve
this is the best thing we can do at this point.
The peculiarity of reactors and RV in general is that we run from tracepoin=
ts,
so we could run virtually from anywhere, that's why there's no one size fit=
s
all..

Overall I'm now leaning towards using only LD_WAIT_SPIN and carefully docum=
ent
why we had to do this.

What do you all think?

Thanks,
Gabriele

