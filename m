Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740AB374E70
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772508103; cv=none; b=bpOM3A4xTNnN/DnV3jqJAB9P5Rb6ieNP63KepsAsn60CPvxKoalOtzxALGoSfQJsP95bzaKI2fR5J4d1pcWtUi38+jVyFUTssiTILhq2/GLYIh+HaR0NbWMXF9fUToKUPQEYq3fO8ruOwc9Okv+bda8E4VQGQrsgXa8e/J5JmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772508103; c=relaxed/simple;
	bh=JNyT2/KX4nFprp4vFfh6Jq7ebmxk7laRiV44Ul7KGI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1SmsEMrvrOGMLnG9Xr0D56ALPdc+Xt2vxlkm97a16X8h3Lrl1YxZLG4NqY+EGbaX2J8Em6LYRDIs1qWJeWKdqKuePdq1ogF8N5DHSZeVHcj4EvPi+i7RX/AVrauqb0VjY01rPdBXhDW6PDzKjL5wpsqrPozpAhLE/Im1U5h8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8LSKlD8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8LSKlD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772508101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPxBLa7o+pF+WTgFM2j3h6TaOxXnGsPMAOuRgvEYjNI=;
	b=H8LSKlD8z9Y4t118+lAKYFCsdt88G7C4ff6TdvhMhlPBmFhM1Ct0a3fRRNZg8OHKJIJXdJ
	4LuWbEF8a0NXQ9/rGHxBnYx8SKBNcV4qDGr0BlfaTMNj6Rzbj2p3zWfIc4CiSoOL87qy/e
	16r5QeTQiA/Xpuz3ztseCYarrMeIsRI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Ak8hZF0ZM1i3IsxLQirhbw-1; Mon, 02 Mar 2026 22:21:40 -0500
X-MC-Unique: Ak8hZF0ZM1i3IsxLQirhbw-1
X-Mimecast-MFC-AGG-ID: Ak8hZF0ZM1i3IsxLQirhbw_1772508100
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d1950b48f3so55887891a34.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 19:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772508100; x=1773112900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPxBLa7o+pF+WTgFM2j3h6TaOxXnGsPMAOuRgvEYjNI=;
        b=ZOlyieC+z6eVQsxd+/JZuUCteibJmVMTU0NwgDgM8wIN4BVnwUMR+T4mGlCl9tpoBI
         /iEHYE75m9/TD25gzWFFf+qG/zEutnVcYtW3+bNJFzvKxJ7KwYpmWyw40Bd2Uv5EGM5S
         9y88+CMY0w/zArZMvSH40Qsyz8Xyy0V9E6IeUam5sEGvBWuRTOzWl2dVgP9Yk2voh9oT
         Rip9IiLIbh2K1vXYuZ+ukBz5dVoV4IJIDKehdiBjaLY+dD41IMM+jVVXGszLrMrttar9
         uVIKzk5gGhZGorIG63AS+6PN02122Cytaiwa37kPgeFLakYiSP96ldTY3jpUzExTGcCv
         3++g==
X-Forwarded-Encrypted: i=1; AJvYcCWz3D2H8AGVPXURJXpKJUjPdmBMlC1aaZKY8ighrnhZDHZk1n5kcH7P+FsQ227R4NEyL56td/99rHvj8MGYDna1Pls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+AHH52UJxrEwKc263UpCSclp3vgMAjiuDgArMZiTcxBdSXy5
	cybGqwtMlDJ9U5ztczWtTDJGWTMII9UQ09BsTTF5t2kDY5YYnlq08fRMpnIC+EbmPviJWsOCsxt
	Tl93csbgiGfw7AKKI2RPqG8vmZzwfHoxJxuWuxTDywt6uq6YwUNeDIiSiABPnTwNLgE8pN8oIww
	==
X-Gm-Gg: ATEYQzzLJt+HjNLpDtTwf2fSUNjYjnNE/TjojJTPscsefYsvSD3/V7oa3VVddPye2hN
	nnT+XK3xaDKxO06JU70It7lkmA+clCjUoWTBQaLPjMx0lDIBV/E2Hyfwg29lB3FbUVIPjOgARFj
	+1fcqYb3pP+Tv6mASDfJ0sBBFYLcO+og+dguaUyVD4BKhPLscjyjSsvP/goohv5FBhgJCHip7i1
	D/zSFdXcAvbrqOq/NzoODv8z3cQED1JPPsR3SGIdZ8e5HplGsfxSAv/5wc8u9i5S8i30eZy3gVi
	RPRt5+vBe2nWbQWrTitmXKEq7Tk2EKJw/S6gLrtl4+BxwH2QVw9V1xMCGheEeiXE2FxIpDaLV2+
	7mqev2JX924HWEk3V2KxInd6i8WBy42+1yo4qnn8XPd0zkl0V4iqXlg==
X-Received: by 2002:a05:6830:8502:10b0:7d1:4f4c:532a with SMTP id 46e09a7af769-7d591bc1a25mr5408949a34.20.1772508099654;
        Mon, 02 Mar 2026 19:21:39 -0800 (PST)
X-Received: by 2002:a05:6830:8502:10b0:7d1:4f4c:532a with SMTP id 46e09a7af769-7d591bc1a25mr5408934a34.20.1772508099229;
        Mon, 02 Mar 2026 19:21:39 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866541fcsm12066409a34.21.2026.03.02.19.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 19:21:38 -0800 (PST)
Message-ID: <238e4851e45a505d7974443c4fe703e61a0fbf55.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
 Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML	 <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>
Date: Mon, 02 Mar 2026 21:21:37 -0600
In-Reply-To: <CAP4=nvQcQQCeyi00WchwhrecOQCxoN3gHiuZD63KZb-30JzTYw@mail.gmail.com>
References: <20260227150420.319528-1-tglozar@redhat.com>
	 <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
	 <CAP4=nvQcQQCeyi00WchwhrecOQCxoN3gHiuZD63KZb-30JzTYw@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LR2ta-QwWWYCtMrjHtcQCbw1sqgWRcVKlVgBp4eApE0_1772508100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-03-02 at 09:48 +0100, Tomas Glozar wrote:
> so 28. 2. 2026 v 0:50 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> na=
psal:
> > > Add an option called TIMERLAT_ALIGN to osnoise/options, together with=
 a
> > > corresponding setting osnoise/timerlat_align_us.
> > >=20
> > > This option sets the alignment of wakeup times between different
> > > timerlat threads, similarly to cyclictest's -A/--aligned option. If
> > > TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> > > records its first wake-up time. Each following thread sets its first
> > > wake-up time to a fixed offset from the recorded time, and incremenet=
s
> > > it by the same offset.
> >=20
> > Why not just set the initial timer expiration to be
> > "period + cpu * align_us"?  Then you wouldn't need any interaction
> > between CPUs.
>=20
> "period + cpu * align_us" wouldn't quite do it, for two reasons:
>=20
> 1. The wake-up timers are set to absolute time, and are incremented by
> "period" (once or multiple times, if the timer is significantly
> delayed) each cycle. What can be done as an alternative to what v1
> does is this: record the current time when starting the timerlat
> tracer (I need to reset align_next to zero anyway even with the v1
> design, that is a bug in the patch), and increment from that.

I was only talking about doing this for the initial expiration, not on
increment.

> 2. "cpu" makes a poor thread ID here. If my period is 1000us, and I
> run on CPUs 0 and 100 with alignment 10, suddenly, the space between
> the threads becomes 1000us, which is equivalent to 0us. I would need
> to go through the cpuset and assign numbers from 0 to n to each CPU.
> That would guarantee a fixed spacing of the threads independent of
> when the threads wake up in the first cycle (unlike the v1 design),
> but it would make the implementation more complex, since I would have
> to store the numbers.

Right, I was thinking of just a few CPUs missing not being a big deal,
but on big systems with only a few CPUs running the test it does
matter.

Instead of assigning numbers, could you just loop over each CPU's
tlat->abs_period and set the initial expiration with appropriate
offset (prior to starting any of the threads)?  Then the thread would
not need to care about anything other than the usual increment.

> If I implemented both of those ideas, the interaction between the CPUs
> can indeed be gotten rid of. I'm not sure if it is a better solution,
> though. Another motivation of recording the first thread wake-up was
> that when using user threads, the first thread might be created some
> time after the tracer is enabled, and I did not want to have a large
> gap that would have to be corrected by the while loop at the end of
> wait_next_period().

What is the actual concerning impact here?

If we want to be really paranoid we could check for pending signals
during the loop, in case userspace delayed so long (with a very short
period) that the user has a hard time with ctrl+c and such... but that
could happen already if userspace does something silly (e.g. stopped
by a debugger?) between loops.

> > >  kernel/trace/trace_osnoise.c | 34 +++++++++++++++++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> >=20
> > Documentation needs to be updated as well.
> >=20
> > Should mention that updating align_us while the timer is running won't
> > take effect immediately (unlike period, which does).
> >=20
>=20
> Good idea, thanks! In general, I'm not expecting the user to change
> timerlat parameters during a measurement - but it is supported, and
> should be documented.

Maybe better to phrase it as "not guaranteed to take effect
immediately" :-)

> > > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnois=
e.c
> > > index dee610e465b9..df1d4529d226 100644
> > > --- a/kernel/trace/trace_osnoise.c
> > > +++ b/kernel/trace/trace_osnoise.c
> > > @@ -58,6 +58,7 @@ enum osnoise_options_index {
> > >       OSN_PANIC_ON_STOP,
> > >       OSN_PREEMPT_DISABLE,
> > >       OSN_IRQ_DISABLE,
> > > +     OSN_TIMERLAT_ALIGN,
> > >       OSN_MAX
> > >  };
> > >=20
> > > @@ -66,7 +67,8 @@ static const char * const osnoise_options_str[OSN_M=
AX] =3D {
> > >                                                       "OSNOISE_WORKLO=
AD",
> > >                                                       "PANIC_ON_STOP"=
,
> > >                                                       "OSNOISE_PREEMP=
T_DISABLE",
> > > -                                                     "OSNOISE_IRQ_DI=
SABLE" };
> > > +                                                     "OSNOISE_IRQ_DI=
SABLE",
> > > +                                                     "TIMERLAT_ALIGN=
" };
> >=20
> > Do we really need a flag for this, or can we just interpret a non-zero
> > align_us value as enabling the feature?
> >=20
>=20
> Yes, we need a flag for this, because a zero alignment is a common use ca=
se.
>=20
> I used it in cyclictest to measure the overhead of a large number of
> threads waking up at the same time. Similarly, a non-zero alignment
> will get rid of most of that overhead. Without alignment set, the
> thread wake-ups offsets are semi-random, depending on how the threads
> wake up, which might lead to inconsistent results where one run has
> good numbers and another run bad numbers, since the alignment is
> determined in the first cycle.

OK, I was viewing the staggering as the main point, but I see how the
alignment itself helps too.

Is there a use case for not always doing the alignment?
Other than people asking why their numbers suddenly got worse...

> > I'm already unclear about the existing purpose of next_abs_period, but
> > if it has any use at all shouldn't it be to avoid writing intermediate
> > values like this back to tlat?
> >=20
>=20
> next_abs_period is basically just the ktime_t variant of
> tlat->abs_period for local calculations of the next period inside
> wait_next_period(). Its only purpose is the ktime_compare() call that
> increments tlat->abs_period by the period until it lands into the
> future, if it happens to be in the past. This is necessary to do for
> both a regular cycle (which might take long due to noise) and the
> first cycle with alignment (because the other thread's first wake up
> might be late), so it has to be set in the new code as well,
> otherwise, the while loop won't see the time is in the past.

Oh, I missed the unit difference (though it's basically just a typedef
at this point).

> I agree that this part of the code is confusing. There is also a
> field, timerlat_variables.rel_period (tlat->rel_period), that is not
> used anywhere, since the relative period is pulled out of
> osnoise_variables. Something like this would be easier to read and
> comprehend, IMHO:

Yeah, I noticed that as well... we should remove it if we're not going
to use it.

> /*
>  * wait_next_period - Wait for the next period for timerlat
>  */
> static int wait_next_period(struct timerlat_variables *tlat)
> {
>     ktime_t now;
>     u64 rel_period =3D osnoise_data.timerlat_period * 1000;
>=20
>     now =3D hrtimer_cb_get_time(&tlat->timer);
>=20
>     /*
>      * Set the next abs_period.
>      */
>     tlat->abs_period +=3D rel_period;
>=20
>     /*
>      * If the new abs_period is in the past, skip the activation.
>      */
>     while (ktime_compare(now, ns_to_ktime(tlat->abs_period) > 0) {
>         next_abs_period =3D ns_to_ktime(tlat->abs_period + rel_period);
>         tlat->abs_period =3D (u64) ktime_to_ns(next_abs_period);
>     }
>=20
>     set_current_state(TASK_INTERRUPTIBLE);
>=20
>     hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_=
HARD);
>     schedule();
>     return 1;
> }
>=20
> (Excluding the changes from this patch.) What do you think?

Why can't we just make tlat->abs_period and every other time variable
in this file be ktime_t?  Other than atomic stuff if we do go that
route.

Not saying that that should hold up this patch,  just an idea to simplify t=
hings.

-Crystal

