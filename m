Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC282F12A5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441333; cv=none; b=f5HPVIoJ7DzHP/PsJYRXYTlw13kzAoyKa3bCJQ3b7VWqDHoloJnmwo+fQRqFxWL/uYZA7JQCKXWOJJCIxfJOPp6eGypAQJVmBMouZyu38/8HuJR9c+0L72ygSx4cDTCbgpwMOzfpQO7UBNLlFqkLYnobnaZbJXsxT2G4OB9ZP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441333; c=relaxed/simple;
	bh=mb97S8vbUfyGe64spQ4hrmYbJyDZwqJdm9CJa8a2J4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNekaOnsyv8fbHjcwwZARkZ+LNBzzfnt+pb031XYTsRCWoCLvfrXctYGBQfaMn+JVAnVPQG1LABkotb9pUPxUCxG9A71a+C7qonhkj1qJXquLdOejBSYa+Un7LoghUmX/vqA3neg7iCNC1GbJixqGlUemqzQmu1UrtYmgZH/aGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwsvukI9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwsvukI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772441331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPvtEutPRQlBoqGu2X1PSXf2Ft85vDt0RVFQtVCqGs0=;
	b=UwsvukI9ku7t/v7lU4kBAIGJhxorA+xGaIB/XKL6DnU3q+sQC1MZHMPpxXcec3GLPuzld/
	Twnsy2DiNIuLNSbEgyEpvOqqSsGjNNwOdHJCxSD8+dRpnpUJGqzygWbYP2CnyhOT3qjBeq
	PfcWosegU3yOIDTplTjFaZHggrxEo5o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-Gho6Ss9FPdWAdaKvTa5TVg-1; Mon, 02 Mar 2026 03:48:49 -0500
X-MC-Unique: Gho6Ss9FPdWAdaKvTa5TVg-1
X-Mimecast-MFC-AGG-ID: Gho6Ss9FPdWAdaKvTa5TVg_1772441329
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b90484c398cso382403966b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 00:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441329; x=1773046129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPvtEutPRQlBoqGu2X1PSXf2Ft85vDt0RVFQtVCqGs0=;
        b=pDelaepkYoVnKfil1la1K8QWVHYFUnDsnLh50R3pQWFFOhjGJOupS3UqZcrHZ6mr9H
         7z1Pb6WxxnYPIkPkIfiWBCwOOeLCuFtRld3OvlKa2Vteo2AMesywHZBm6pqhxKzCPmq2
         Jh1h4vQnDygZ1yoLbUEoZl0YnyikHCe3etCXI582HgDfgB8u2tudDUgoVIzjqv+NV098
         8rwNZ1iZg7/qDNEc5mcljnQ6CNCNKPrZZjOroeA4ZMdOc3unRQ1tNYcNmlV6uUHf+B3V
         +cTaXkPfM3YxRv6M2hJOwIgAufI0UrQrHZ3IC8qiItUlTr+v9nb3XabRjw1FmdSzLJ8r
         Q93A==
X-Forwarded-Encrypted: i=1; AJvYcCWllBpPCtCjrBu1hD5ZA9FZkWatfPpMd7lGs9yjpxu47nRX0rJlC0d8gE4F7xDdcmDiuyUHgVjuhUwRcmrgA231auk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8VjDjfuYevmQPjx6nuJ6pW5WYcbTpS5S5gMRPJzF7aCGa5+7
	FtAAGIO+FeGkXWUniqOvCgdisrHamKwXyHm+H+E4NYGyj+49wWwINUyQK634O1zlLkbe4bEw0nD
	DX2gkzmNCg+4KiQCeCSdMj4HZcec4F5RgoeFOsQFredDuvF3jeuTH54QJQWynuH4gSm49vdGW5R
	X+pydGtH30BETV3z5WBIIM/46dxc44RDzv3ZGFLgIH5smhWwRI
X-Gm-Gg: ATEYQzytilfwBMiIfAFR190z9eFIK0T7KC4vnbmCcxP6oV/pFezJ+u6rTqLY7bwOUxv
	Gwg/G1qHHPcgkgOk7wK7UQZwFpBwgNgmxTqwXKsAkewdgjd734g3YYw1m/A/Y8xmR1l/hQ1BAMc
	SaqQaiad/Byl/DWxk3/lgmlQ7bp96pie1JH/3idru58NPOveAce/v4kKizesZKLNqK4GNI66xeF
	295guYTr+AOfkWCxpXjrOWsS9Dh18W0gPu/
X-Received: by 2002:a17:907:7f8a:b0:b8e:9d66:f5fb with SMTP id a640c23a62f3a-b937616f277mr641837966b.0.1772441328569;
        Mon, 02 Mar 2026 00:48:48 -0800 (PST)
X-Received: by 2002:a17:907:7f8a:b0:b8e:9d66:f5fb with SMTP id
 a640c23a62f3a-b937616f277mr641835566b.0.1772441327945; Mon, 02 Mar 2026
 00:48:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227150420.319528-1-tglozar@redhat.com> <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
In-Reply-To: <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Mar 2026 09:48:37 +0100
X-Gm-Features: AaiRm51wi0nA0DaRT-PYQ1usAXorLLM4nsZxctC8aQRpwByyWlnPofjkjELdgLs
Message-ID: <CAP4=nvQcQQCeyi00WchwhrecOQCxoN3gHiuZD63KZb-30JzTYw@mail.gmail.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bWICQ8ZExM4zREs09Grjex54YxYPN44p5kIoDoxLFmQ_1772441329
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 28. 2. 2026 v 0:50 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> naps=
al:
> > Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
> > corresponding setting osnoise/timerlat_align_us.
> >
> > This option sets the alignment of wakeup times between different
> > timerlat threads, similarly to cyclictest's -A/--aligned option. If
> > TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> > records its first wake-up time. Each following thread sets its first
> > wake-up time to a fixed offset from the recorded time, and incremenets
> > it by the same offset.
>
> Why not just set the initial timer expiration to be
> "period + cpu * align_us"?  Then you wouldn't need any interaction
> between CPUs.

"period + cpu * align_us" wouldn't quite do it, for two reasons:

1. The wake-up timers are set to absolute time, and are incremented by
"period" (once or multiple times, if the timer is significantly
delayed) each cycle. What can be done as an alternative to what v1
does is this: record the current time when starting the timerlat
tracer (I need to reset align_next to zero anyway even with the v1
design, that is a bug in the patch), and increment from that.

2. "cpu" makes a poor thread ID here. If my period is 1000us, and I
run on CPUs 0 and 100 with alignment 10, suddenly, the space between
the threads becomes 1000us, which is equivalent to 0us. I would need
to go through the cpuset and assign numbers from 0 to n to each CPU.
That would guarantee a fixed spacing of the threads independent of
when the threads wake up in the first cycle (unlike the v1 design),
but it would make the implementation more complex, since I would have
to store the numbers.

If I implemented both of those ideas, the interaction between the CPUs
can indeed be gotten rid of. I'm not sure if it is a better solution,
though. Another motivation of recording the first thread wake-up was
that when using user threads, the first thread might be created some
time after the tracer is enabled, and I did not want to have a large
gap that would have to be corrected by the while loop at the end of
wait_next_period().

>
> >  kernel/trace/trace_osnoise.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
>
> Documentation needs to be updated as well.
>
> Should mention that updating align_us while the timer is running won't
> take effect immediately (unlike period, which does).
>

Good idea, thanks! In general, I'm not expecting the user to change
timerlat parameters during a measurement - but it is supported, and
should be documented.

> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > index dee610e465b9..df1d4529d226 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -58,6 +58,7 @@ enum osnoise_options_index {
> >       OSN_PANIC_ON_STOP,
> >       OSN_PREEMPT_DISABLE,
> >       OSN_IRQ_DISABLE,
> > +     OSN_TIMERLAT_ALIGN,
> >       OSN_MAX
> >  };
> >
> > @@ -66,7 +67,8 @@ static const char * const osnoise_options_str[OSN_MAX=
] =3D {
> >                                                       "OSNOISE_WORKLOAD=
",
> >                                                       "PANIC_ON_STOP",
> >                                                       "OSNOISE_PREEMPT_=
DISABLE",
> > -                                                     "OSNOISE_IRQ_DISA=
BLE" };
> > +                                                     "OSNOISE_IRQ_DISA=
BLE",
> > +                                                     "TIMERLAT_ALIGN" =
};
>
> Do we really need a flag for this, or can we just interpret a non-zero
> align_us value as enabling the feature?
>

Yes, we need a flag for this, because a zero alignment is a common use case=
.

I used it in cyclictest to measure the overhead of a large number of
threads waking up at the same time. Similarly, a non-zero alignment
will get rid of most of that overhead. Without alignment set, the
thread wake-ups offsets are semi-random, depending on how the threads
wake up, which might lead to inconsistent results where one run has
good numbers and another run bad numbers, since the alignment is
determined in the first cycle.

For example, here are some bpftrace numbers (from the same command as
in the original message) with wake-ups with timerlat_align_us =3D 0:

@time[12]: 1
@time[11]: 1
@time[13]: 1
@time[10]: 3
@time[16]: 6
@time[19]: 6
@time[15]: 6
@time[18]: 7
@time[14]: 7
@time[17]: 71
@time[20]: 997

> > @@ -1820,6 +1824,7 @@ static int wait_next_period(struct timerlat_varia=
bles *tlat)
> >  {
> >       ktime_t next_abs_period, now;
> >       u64 rel_period =3D osnoise_data.timerlat_period * 1000;
> > +     static atomic64_t align_next;
>
> How will this get reset if the tracer is stopped and restarted?
>

It won't, I forgot to reset it. See my comment above in my reply to Steve,

> >       now =3D hrtimer_cb_get_time(&tlat->timer);
> >       next_abs_period =3D ns_to_ktime(tlat->abs_period + rel_period);
> > @@ -1829,6 +1834,17 @@ static int wait_next_period(struct timerlat_vari=
ables *tlat)
> >        */
> >       tlat->abs_period =3D (u64) ktime_to_ns(next_abs_period);
> >
> > +     if (test_bit(OSN_TIMERLAT_ALIGN, &osnoise_options) && !tlat->coun=
t
> > +         && atomic64_cmpxchg_relaxed(&align_next, 0, tlat->abs_period)=
) {
> > +             /*
> > +              * Align thread in first cycle on each CPU to the set ali=
gnment.
> > +              */
> > +             tlat->abs_period =3D atomic64_fetch_add_relaxed(osnoise_d=
ata.timerlat_align_us * 1000,
> > +                     &align_next);
> > +             tlat->abs_period +=3D osnoise_data.timerlat_align_us * 10=
00;
> > +             next_abs_period =3D ns_to_ktime(tlat->abs_period);
> > +     }
>
> I'm already unclear about the existing purpose of next_abs_period, but
> if it has any use at all shouldn't it be to avoid writing intermediate
> values like this back to tlat?
>

next_abs_period is basically just the ktime_t variant of
tlat->abs_period for local calculations of the next period inside
wait_next_period(). Its only purpose is the ktime_compare() call that
increments tlat->abs_period by the period until it lands into the
future, if it happens to be in the past. This is necessary to do for
both a regular cycle (which might take long due to noise) and the
first cycle with alignment (because the other thread's first wake up
might be late), so it has to be set in the new code as well,
otherwise, the while loop won't see the time is in the past.

I agree that this part of the code is confusing. There is also a
field, timerlat_variables.rel_period (tlat->rel_period), that is not
used anywhere, since the relative period is pulled out of
osnoise_variables. Something like this would be easier to read and
comprehend, IMHO:

/*
 * wait_next_period - Wait for the next period for timerlat
 */
static int wait_next_period(struct timerlat_variables *tlat)
{
    ktime_t now;
    u64 rel_period =3D osnoise_data.timerlat_period * 1000;

    now =3D hrtimer_cb_get_time(&tlat->timer);

    /*
     * Set the next abs_period.
     */
    tlat->abs_period +=3D rel_period;

    /*
     * If the new abs_period is in the past, skip the activation.
     */
    while (ktime_compare(now, ns_to_ktime(tlat->abs_period) > 0) {
        next_abs_period =3D ns_to_ktime(tlat->abs_period + rel_period);
        tlat->abs_period =3D (u64) ktime_to_ns(next_abs_period);
    }

    set_current_state(TASK_INTERRUPTIBLE);

    hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HA=
RD);
    schedule();
    return 1;
}

(Excluding the changes from this patch.) What do you think?

Tomas

