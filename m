Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A20B22
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837153; cv=none; b=AdyCnGYJABDj+C//rNM7nJIikiaarhxVwmU19sntaW1cAnxtM9KxavwCAESrvwbj462vl/4sxdc3kuYVSh6EVpgHHMxi7Q6I0MvO5WXSLrVJ3RDp0U/VybEzlMFreqXWDLLS0sT4TkMyIgE9J+uMgYbR+6kHBTGn7Yn9ROENNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837153; c=relaxed/simple;
	bh=elTaJnHhFwlq5NnTCob011c+uORrUTCjNLRxvXCQjYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvqM17WKhTeQkJsGma/b1mpYNyjqqENVsoBER0cS1numNEwELOdWhWS+BCBK3p6/1zjf5I+FTd0lSVmFLX9c2dZO/lsGUdG4hM0lrzMIvJ1+tf8rdjDgBQleClpHkZF1DFD0vwNWX+9nGJpfp4M7l5DiJFRS+VjAEYm2cTQrUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1c6XlMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1c6XlMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772837151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yA9z7e0R7ulDqjAP7NWK693d7zoHfetFpBo8ykTsJt8=;
	b=F1c6XlMTAK4wPzJqFR1m9eCbvFwLUpuewDH5DipfZgej/umOdqzEkjCZzXptJRvNkXKQ/d
	9TG5SlGlckNjuj81m77xTPDnF2NAXhBcm4tXNDq92qdEV/juNEIpCzjJYNO3+KY0dj6ze5
	OjrMoTIdamuyr2h+LG9Lhb5Vwb9ej7A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-wqifJWd1OGCVzWOzlWZbgA-1; Fri, 06 Mar 2026 17:45:50 -0500
X-MC-Unique: wqifJWd1OGCVzWOzlWZbgA-1
X-Mimecast-MFC-AGG-ID: wqifJWd1OGCVzWOzlWZbgA_1772837149
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506bf83258bso251619921cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 14:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772837149; x=1773441949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA9z7e0R7ulDqjAP7NWK693d7zoHfetFpBo8ykTsJt8=;
        b=VyInpneXhamsVQKQQzEPWD2O+IMq1TiVZdKMVfOhHBRUshzXrD69ESKg6Y7WBw4u5x
         XjNgPUccZK/nwqWuHJt5H0ZZGXOLACtkFanbsQTwrE26RSKq/1fnpZVRTrbjYHbpVyL0
         jWAY9tY8QBCgeLzX25Su1GWNMX3tqRe/bXZ9TJpJcPHiniDCLLie5PPoQC2bMZbxZd+i
         AY07irL140LQLBQg8nIsteyfdH32sy587l6kVfoVglfT2DA81+LPKJ2d9DSasMdv0EZ5
         3UQ83ePVbS2/+ZUV/mH8ltphML/YdrepKiAxvi+dz7eGWOoD5lME/KYvoZs6xWLXMId+
         BK5w==
X-Forwarded-Encrypted: i=1; AJvYcCUdhEF339W+t561+08umQwn+aMVx34v00KgnnHPmOIh+URdf1lZQusw+awTtQY/nzqWHs8J2EcAdUKrYaiwhC4l68s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwsG9JA5MVf4eqjHSydQ4CCc19isMx7Pkr4Qs9dm/T0KAsUrJ
	UToUueB7f02GwZHB2QVGKqKNONwbGKo2J/XqzGZ9AJnplE417MghqEpbpDWXw+kEQZhUE+V5mwc
	cXLcOjD7GxB8CsZ5Dzq2AzFQkQFnl7zQ7AbCpwPZBh1ftlDoSF17OYh3unHRMkCWaJ2WewIft0e
	2zzUBa/A==
X-Gm-Gg: ATEYQzxNsXmtMyEnzRTT61DCEJNZqg0ZSVBfJaOG9+UPeCk8eBDRJ5eInxWV46BEWJ3
	kKSf5aV4lkMunuDQxPlKsrgvxOJMW4HgzM61nDAtl8A+OxeuZbnge1RyEUu9tOL4VnEZbCKvIpT
	sh6LWgsclo0aooWAoIhVp3mBIFj9987TIIMMlWhbwmKDPcKWwB5Z4GiLoQJY3kFYF8OPlw1pL69
	1Ai+xnsZei4scxIoqA/gQMp3/DkYLTR+abVwyVaX07QnjKZ2N5q1poELNxmznq3y2YZaqA0PaNz
	InWDuJ6Tjl7sz5UjZrsgtaXDXbdu1RDXVkCfW3gcArlG2dpj0F/74xMkI23xeSbjcndU8C/SD28
	i8rT6RKP90uexTdVBiUsLARMuwKenaTyO6Mvuh7A/GvYjB9y04kUO3Q==
X-Received: by 2002:ac8:5795:0:b0:4f1:b712:364a with SMTP id d75a77b69052e-508f497496fmr48097801cf.56.1772837149225;
        Fri, 06 Mar 2026 14:45:49 -0800 (PST)
X-Received: by 2002:ac8:5795:0:b0:4f1:b712:364a with SMTP id d75a77b69052e-508f497496fmr48097531cf.56.1772837148755;
        Fri, 06 Mar 2026 14:45:48 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66b620dsm18906921cf.23.2026.03.06.14.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:45:48 -0800 (PST)
Message-ID: <b0b1dac3d5088def9dc74006063e7a8d91bef3c7.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
 Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML	 <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>
Date: Fri, 06 Mar 2026 16:45:46 -0600
In-Reply-To: <CAP4=nvSmbvz68H77T4Wohm7rT3Ojn_D_igBk8pvsvGurL05Kww@mail.gmail.com>
References: <20260227150420.319528-1-tglozar@redhat.com>
	 <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
	 <CAP4=nvQcQQCeyi00WchwhrecOQCxoN3gHiuZD63KZb-30JzTYw@mail.gmail.com>
	 <238e4851e45a505d7974443c4fe703e61a0fbf55.camel@redhat.com>
	 <CAP4=nvSmbvz68H77T4Wohm7rT3Ojn_D_igBk8pvsvGurL05Kww@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uqDeSgG8wqMjFgFjZ2W-qkYfRgSCnd41v84WSKuOm2s_1772837149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-06 at 16:15 +0100, Tomas Glozar wrote:
> =C3=BAt 3. 3. 2026 v 4:21 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
> > > 1. The wake-up timers are set to absolute time, and are incremented b=
y
> > > "period" (once or multiple times, if the timer is significantly
> > > delayed) each cycle. What can be done as an alternative to what v1
> > > does is this: record the current time when starting the timerlat
> > > tracer (I need to reset align_next to zero anyway even with the v1
> > > design, that is a bug in the patch), and increment from that.
> >=20
> > I was only talking about doing this for the initial expiration, not on
> > increment.
> >=20
>=20
> Ah, I misread "period" as "relative period", since the initial
> absolute period is determined from the current time in the first cycle
> of each thread.

I did mean relative period ("absolute period" isn't a phrase that makes
sense to me; that's just an expiration); I just forgot to make the
"now +" part explicit.

> > > 2. "cpu" makes a poor thread ID here. If my period is 1000us, and I
> > > run on CPUs 0 and 100 with alignment 10, suddenly, the space between
> > > the threads becomes 1000us, which is equivalent to 0us. I would need
> > > to go through the cpuset and assign numbers from 0 to n to each CPU.
> > > That would guarantee a fixed spacing of the threads independent of
> > > when the threads wake up in the first cycle (unlike the v1 design),
> > > but it would make the implementation more complex, since I would have
> > > to store the numbers.
> >=20
> > Right, I was thinking of just a few CPUs missing not being a big deal,
> > but on big systems with only a few CPUs running the test it does
> > matter.
> >=20
>=20
> My point is mostly that the spacing of the threads shouldn't depend on
> the CPU numbers. One has to make sure the alignment doesn't overflow
> the period anyway if they want to have completely time-isolated
> wake-ups.

Yeah, I underestimated how easy it would be for that to be a problem.  I
think this is a good enough reason to use the atomic approach.

> The while loop is designed only to handle "small" time differences,
> with respect to the relative period. When using timerlat manually with
> a user workload, it might take the user a few seconds/seconds/hours
> before they start the user process (typing the command line, or if the
> user e.g. has a snack or coffee in between), which has to be corrected
> by the while loop. This does not interact well with a low period.
> Consider the following scenario, assuming the initial absolute period
> is set on timerlat tracer enablement:
>=20
> 1. The user enables the timerlat tracer with NO_OSNOISE_WORKLOAD and
> 100us period.
> 2. The user steps away for 1 hour.
> 3. After 10 seconds, tlat->abs_period is 3 600 000 000us in the past.
> The while loop starts incrementing tlat->abs_period by 100us, taking
> 36 000 000 loops. If one iteration takes 10 CPU cycles on a 1GHz CPU,
> the while loop itself will take 360us (which is >100us).
> 4. The timerlat thread never wakes up, since the wake-up time even
> after the correction is in the past.

(assuming you meant "after one hour" instead of 10 seconds)

Oh, I see it doesn't update "now" inside the loop.  Arming a timer for
the past should cause it to fire immediately though; otherwise there
would be all sorts of nasty races.

In any case, regardless of what we do with alignment, we could simplify
by replacing the while loop with hrtimer_forward_now() which does
division (if necessary) instead of a loop, and get rid of
tlat->abs_period (the handler can call hrtimer_get_expires()).

> This is much more reasonable than the user stopping the thread inside
> the while loop. Actually, this scenario can already happen without
> alignment, since the scheduler might preempt the thread inside the
> while loop for more than the period - but that is a separate issue.
>=20
> Also, the current implementation is relatively simple (and hopefully
> also easy to understand with the comments in v2), so my idea is that
> we can use it for now, and if we want deterministing alignment in the
> future, we can always improve it.

The comments do help, thanks.  v1 took me a few tries to figure out,
given how different it is from usual cmpxchg usage.  v2 looks good to
me.

> > > I used it in cyclictest to measure the overhead of a large number of
> > > threads waking up at the same time. Similarly, a non-zero alignment
> > > will get rid of most of that overhead. Without alignment set, the
> > > thread wake-ups offsets are semi-random, depending on how the threads
> > > wake up, which might lead to inconsistent results where one run has
> > > good numbers and another run bad numbers, since the alignment is
> > > determined in the first cycle.
> >=20
> > OK, I was viewing the staggering as the main point, but I see how the
> > alignment itself helps too.
> >=20
> > Is there a use case for not always doing the alignment?
> > Other than people asking why their numbers suddenly got worse...
> >=20
>=20
> Yes - to simulate the default behavior of cyclictest without
> -A/--aligned, and of multi-thread cyclic workloads that do not align
> their threads respectively. Even if we wanted to always use the
> alignment, it should not default to 0 IMHO, so that users don't see a
> degradation like you mention.

It just feels a bit weird to preserve "maybe they're bunched up, maybe
not, who knows?" as a feature (much less the default), especially for a
tool meant to help with determinism.

> > Why can't we just make tlat->abs_period and every other time variable
> > in this file be ktime_t?  Other than atomic stuff if we do go that
> > route.
> >=20
> > Not saying that that should hold up this patch,  just an idea to simpli=
fy things.
> >=20
>=20
> The reason for that is that the code does arithmetic directly on the
> ns unit form of the time, without the need to use ktime_add(). I don't
> see anything on top of that.  I see ktime_add(x, y) is just x + y
> nowadays, so that would work.

We should still use ktime_add() etc. in order to be nice users of the
interface.  I just think the conversions are worse clutter than a
couple ktime add/sub calls.

-Crystal

