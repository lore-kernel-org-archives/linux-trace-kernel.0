Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FF311958
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810163; cv=none; b=ufdxFsnmSC7nQE4K8wlCNviPM/YyvZwv+VmePLj+Z0idF1kh4ptMIFNWd8GLzdyIcieqgOgU06qb96sbbailf6orsYQOW9MKG2AdXBrJ8cUbrGi7y2Q2il7ZRET5xdiqptl9+d/b2KcgxJJmxCFrCIJotHI0tDJ4bsPkB5rnWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810163; c=relaxed/simple;
	bh=+BvXWfAKQ9O663kwoZyZMyWhA/zunFdKvzi17BKmRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdcrFBKcqykQx18lffRWuu98u5MQmSOlNo+z+EcmDeyQw9k76NeDVC7gWaKgIKdJt2/DDYFcMgR9dKQmPG+UEezzs+vrzx34/a3tJth8rc5bPFW+0N2yykZsK4OHIQKdURxoHYfCtZ4OiPdKs1py+tvwQsA9NU/UkNeDfIf7kGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEQDjRe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEQDjRe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772810160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DLJi0mGeilQ3CHI3Vep7lQkDSy0MxH2gEuKYbprlfw=;
	b=GEQDjRe8YLDJRDfZr+c45xsGbApN56Uv3rBKyuXLPUI6ObJuWOJ8ATkNGJNizmL1dqFJnb
	r+vkaFXVGkpAKYEzirk32BVTXlVRt7KsjYfvDypUnlH1T0Ijbo9BbN20onrr0jERmFnB+b
	ddqhg1S4zN0+OzFoi9JyWgp/IOSxqN8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-k5DE8abLNP6cs5dI73aVJw-1; Fri, 06 Mar 2026 10:15:59 -0500
X-MC-Unique: k5DE8abLNP6cs5dI73aVJw-1
X-Mimecast-MFC-AGG-ID: k5DE8abLNP6cs5dI73aVJw_1772810158
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a137c599ccso533774e87.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 07:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810158; x=1773414958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DLJi0mGeilQ3CHI3Vep7lQkDSy0MxH2gEuKYbprlfw=;
        b=qYpdiT6VEawx9QKsfa4jlYa5L6Jm6rzBos5sBJ/WqVmurL8s1te2zgvCRecmpYrowk
         hwq3yXkAvTC8TLZ9OXbErD/gj0owuuif8ckCCjn2n/NL9NZ9gFR2j8SZryuoaIqGwcZB
         sP6gL3FDaAMxZxT6hiMTwAVeGgf49La1qRWc9USoHLXmuEWWaZwOzQYXI/xTP/trlfZj
         d9ytwBhjBuYHh5dlJf5N25BJwMq9fnIPbK993n/2ICjQOesacPhK/jFSySHX3FRYMgir
         CLZcFerge3ePOki9dQ6e2IVJoyx37dZxkLdYi9k7cllYuhVEPJMn6X1pLAXjRlEqCTPB
         4Duw==
X-Forwarded-Encrypted: i=1; AJvYcCVBrhb7xYNjB2MVf1FqNBIGd/AmAgV8TElc82UE5WgrvsYK5L+aMIcvNW4XY3PRCIXe6aBjJA2tQxXqb8chRQSOcIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNYz4MivkwZZ2rOHZK2DiKiy25k7KzV8xLYM/9nOHOurW61Va
	3GNqhbUs3vPwRxrsxqvJ/YOd/JB6fXr1zq+Y72C5sXcevGJ2mPKsB5oflIZ1NbAZS13c5Rh73MM
	C26oLhXs8Vf9xUW8jHD4QAqjPsRTr4qbPnfpO+wepTmwXabqv9I0Fz0C/yAf4/+ZffssTqvRfX2
	m9x37VC3JQ8sMmB7e5LFfj4ySsZhJVGqr064IAn++VimOlyJ1l
X-Gm-Gg: ATEYQzxImO2vAxsixmlhvbBD1VEY4QdsnRIMM/XTlWQ/knlQqGgYTguDNesis5k1KUp
	qR97BeVC9zs2f17I2lRSeXnHrtdWheflrtaxkHUkKh2KJOQPCmyxDccAltYw9wRgHjajoF1NkAU
	WAaFguwQ4wMFgqkMkxvM+G2qZGJVa2W7HFi50xBID0p48Eor8mJHo/uVuFhEX2yrXt2gDv0P8G0
	dlFzKcwRLnKhxiaOhEoDyEbmITHe25QYkCt
X-Received: by 2002:a05:6512:286:b0:5a0:ff97:4374 with SMTP id 2adb3069b0e04-5a13cac11c3mr665195e87.7.1772810157812;
        Fri, 06 Mar 2026 07:15:57 -0800 (PST)
X-Received: by 2002:a05:6512:286:b0:5a0:ff97:4374 with SMTP id
 2adb3069b0e04-5a13cac11c3mr665180e87.7.1772810157135; Fri, 06 Mar 2026
 07:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227150420.319528-1-tglozar@redhat.com> <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
 <CAP4=nvQcQQCeyi00WchwhrecOQCxoN3gHiuZD63KZb-30JzTYw@mail.gmail.com> <238e4851e45a505d7974443c4fe703e61a0fbf55.camel@redhat.com>
In-Reply-To: <238e4851e45a505d7974443c4fe703e61a0fbf55.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 6 Mar 2026 16:15:43 +0100
X-Gm-Features: AaiRm53309KqLhMKCT4skU4LFhURQl4DfFL6gvaNohos0jnWj-OjwJaF5gZxdYs
Message-ID: <CAP4=nvSmbvz68H77T4Wohm7rT3Ojn_D_igBk8pvsvGurL05Kww@mail.gmail.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HPJYNBks2x43JVjsHCKDDOFfzuKQiWfebEoh2puoJgo_1772810158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 3. 3. 2026 v 4:21 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> =
napsal:
> > 1. The wake-up timers are set to absolute time, and are incremented by
> > "period" (once or multiple times, if the timer is significantly
> > delayed) each cycle. What can be done as an alternative to what v1
> > does is this: record the current time when starting the timerlat
> > tracer (I need to reset align_next to zero anyway even with the v1
> > design, that is a bug in the patch), and increment from that.
>
> I was only talking about doing this for the initial expiration, not on
> increment.
>

Ah, I misread "period" as "relative period", since the initial
absolute period is determined from the current time in the first cycle
of each thread.

> > 2. "cpu" makes a poor thread ID here. If my period is 1000us, and I
> > run on CPUs 0 and 100 with alignment 10, suddenly, the space between
> > the threads becomes 1000us, which is equivalent to 0us. I would need
> > to go through the cpuset and assign numbers from 0 to n to each CPU.
> > That would guarantee a fixed spacing of the threads independent of
> > when the threads wake up in the first cycle (unlike the v1 design),
> > but it would make the implementation more complex, since I would have
> > to store the numbers.
>
> Right, I was thinking of just a few CPUs missing not being a big deal,
> but on big systems with only a few CPUs running the test it does
> matter.
>

My point is mostly that the spacing of the threads shouldn't depend on
the CPU numbers. One has to make sure the alignment doesn't overflow
the period anyway if they want to have completely time-isolated
wake-ups.

> Instead of assigning numbers, could you just loop over each CPU's
> tlat->abs_period and set the initial expiration with appropriate
> offset (prior to starting any of the threads)?  Then the thread would
> not need to care about anything other than the usual increment.
>
> > If I implemented both of those ideas, the interaction between the CPUs
> > can indeed be gotten rid of. I'm not sure if it is a better solution,
> > though. Another motivation of recording the first thread wake-up was
> > that when using user threads, the first thread might be created some
> > time after the tracer is enabled, and I did not want to have a large
> > gap that would have to be corrected by the while loop at the end of
> > wait_next_period().
>
> What is the actual concerning impact here?
>
> If we want to be really paranoid we could check for pending signals
> during the loop, in case userspace delayed so long (with a very short
> period) that the user has a hard time with ctrl+c and such... but that
> could happen already if userspace does something silly (e.g. stopped
> by a debugger?) between loops.
>

The while loop is designed only to handle "small" time differences,
with respect to the relative period. When using timerlat manually with
a user workload, it might take the user a few seconds/seconds/hours
before they start the user process (typing the command line, or if the
user e.g. has a snack or coffee in between), which has to be corrected
by the while loop. This does not interact well with a low period.
Consider the following scenario, assuming the initial absolute period
is set on timerlat tracer enablement:

1. The user enables the timerlat tracer with NO_OSNOISE_WORKLOAD and
100us period.
2. The user steps away for 1 hour.
3. After 10 seconds, tlat->abs_period is 3 600 000 000us in the past.
The while loop starts incrementing tlat->abs_period by 100us, taking
36 000 000 loops. If one iteration takes 10 CPU cycles on a 1GHz CPU,
the while loop itself will take 360us (which is >100us).
4. The timerlat thread never wakes up, since the wake-up time even
after the correction is in the past.

This is much more reasonable than the user stopping the thread inside
the while loop. Actually, this scenario can already happen without
alignment, since the scheduler might preempt the thread inside the
while loop for more than the period - but that is a separate issue.

Also, the current implementation is relatively simple (and hopefully
also easy to understand with the comments in v2), so my idea is that
we can use it for now, and if we want deterministing alignment in the
future, we can always improve it.

> > Good idea, thanks! In general, I'm not expecting the user to change
> > timerlat parameters during a measurement - but it is supported, and
> > should be documented.
>
> Maybe better to phrase it as "not guaranteed to take effect
> immediately" :-)
>

I think we can afford to be less vague than that here :) something
like, "setting the timerlat_align_us option will take affect upon next
timerlat tracer start".

> > I used it in cyclictest to measure the overhead of a large number of
> > threads waking up at the same time. Similarly, a non-zero alignment
> > will get rid of most of that overhead. Without alignment set, the
> > thread wake-ups offsets are semi-random, depending on how the threads
> > wake up, which might lead to inconsistent results where one run has
> > good numbers and another run bad numbers, since the alignment is
> > determined in the first cycle.
>
> OK, I was viewing the staggering as the main point, but I see how the
> alignment itself helps too.
>
> Is there a use case for not always doing the alignment?
> Other than people asking why their numbers suddenly got worse...
>

Yes - to simulate the default behavior of cyclictest without
-A/--aligned, and of multi-thread cyclic workloads that do not align
their threads respectively. Even if we wanted to always use the
alignment, it should not default to 0 IMHO, so that users don't see a
degradation like you mention.

> > next_abs_period is basically just the ktime_t variant of
> > tlat->abs_period for local calculations of the next period inside
> > wait_next_period(). Its only purpose is the ktime_compare() call that
> > increments tlat->abs_period by the period until it lands into the
> > future, if it happens to be in the past. This is necessary to do for
> > both a regular cycle (which might take long due to noise) and the
> > first cycle with alignment (because the other thread's first wake up
> > might be late), so it has to be set in the new code as well,
> > otherwise, the while loop won't see the time is in the past.
>
> Oh, I missed the unit difference (though it's basically just a typedef
> at this point).
>
> > I agree that this part of the code is confusing. There is also a
> > field, timerlat_variables.rel_period (tlat->rel_period), that is not
> > used anywhere, since the relative period is pulled out of
> > osnoise_variables. Something like this would be easier to read and
> > comprehend, IMHO:
>
> Yeah, I noticed that as well... we should remove it if we're not going
> to use it.
>

Yeah.

> > /*
> >  * wait_next_period - Wait for the next period for timerlat
> >  */
> > static int wait_next_period(struct timerlat_variables *tlat)
> > {
> >     ktime_t now;
> >     u64 rel_period =3D osnoise_data.timerlat_period * 1000;
> >
> >     now =3D hrtimer_cb_get_time(&tlat->timer);
> >
> >     /*
> >      * Set the next abs_period.
> >      */
> >     tlat->abs_period +=3D rel_period;
> >
> >     /*
> >      * If the new abs_period is in the past, skip the activation.
> >      */
> >     while (ktime_compare(now, ns_to_ktime(tlat->abs_period) > 0) {
> >         next_abs_period =3D ns_to_ktime(tlat->abs_period + rel_period);
> >         tlat->abs_period =3D (u64) ktime_to_ns(next_abs_period);
> >     }
> >
> >     set_current_state(TASK_INTERRUPTIBLE);
> >
> >     hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNE=
D_HARD);
> >     schedule();
> >     return 1;
> > }
> >
> > (Excluding the changes from this patch.) What do you think?
>
> Why can't we just make tlat->abs_period and every other time variable
> in this file be ktime_t?  Other than atomic stuff if we do go that
> route.
>
> Not saying that that should hold up this patch,  just an idea to simplify=
 things.
>

The reason for that is that the code does arithmetic directly on the
ns unit form of the time, without the need to use ktime_add(). I don't
see anything on top of that.  I see ktime_add(x, y) is just x + y
nowadays, so that would work.

Tomas

