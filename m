Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54F225403
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039661; cv=none; b=YJDpTID1gM4BZpFT2tFOV38WWKVt423opP/vf73iuQEByLhArhbYMg/68veab9fiobz41tcOdsmb9LxE7vR16BhqYfFNkRg7m5dRSXujSPH6HSqw3xE6go9dtEKues9/k6PCtYPSJf7I/rUTpD3PV5mjkRvpR9GBpUKeW/2XUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039661; c=relaxed/simple;
	bh=90EqnloKDeWXSvmpJ42DAZtzXfv6nBjjHGzGKZhuom4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th+SRuUyg2pa7BaWXibyVVIMX9Fq9UMfpdfnvGxYfqMZshdoyH2t/BU+A+Nhm2m+uvGceSuArVT0Lfa+IcCb7Yd0SxjZqiz0Qom9ynUusJFlxyBLYTNOVPZBnS5K4ZZ56MXB87tkCXwe0QBBEbTGsXjlBcN6VS17Y1qvAVJ/+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCqmd1nC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCqmd1nC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754039659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=90EqnloKDeWXSvmpJ42DAZtzXfv6nBjjHGzGKZhuom4=;
	b=MCqmd1nCzBPxLbXAuRwiFp6APt8++jKIFC8ClC735vy0I8PFWTsMMfQ1dPqvCWJErBdUy+
	lieaH16ghZ9x4Z+vsU1VnhwgOvoP5XrzONHi9CsrAFylIFvo0DfCm+Lgk9If4gDZA1iUPA
	Q0UPqdu8HVctHyx4ceM9QIz6mKTekpY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-AW7Owf0zO2eoA4N1IGE7pg-1; Fri, 01 Aug 2025 05:14:17 -0400
X-MC-Unique: AW7Owf0zO2eoA4N1IGE7pg-1
X-Mimecast-MFC-AGG-ID: AW7Owf0zO2eoA4N1IGE7pg_1754039657
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458a7e2ced6so4811915e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039656; x=1754644456;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j0+WkfZMw1AoCAOC5CaMkbSzrbduahLpS9n566Aa3Q=;
        b=Uos9pMvjoX4EDgm3fWYf2e/D6fVqC9vw2eLE8tIFywrncANBRVaK2JzU1LjrLQG5ks
         kqNgwIxytyq0c7pvGZP0znuzKRbIZ64n+orqtok8MedbmV4sDBIiz0tQt5466aZ9gOUd
         hmUGomH10E2Ww8aOFa+M9PJuW0jVXB3E1cEQSp/5zOKvVg73iV0NUSgU1Br8E2xP4ja5
         OilHZRFZys1E2dpgwIDo/iHwM3pqq1T55reApe6Uf+RfcGakSqhOBBOEbuB9pyJ2UM7v
         kax74kvweBs4qDtVjJBHKURXw+X/DS0h5Q3hv4dkDuA98wTtGt+8dPNJxjXeb5ycr/JJ
         dm/g==
X-Forwarded-Encrypted: i=1; AJvYcCWy5cNuG1zC3PbrFStnVgWH9vfjxQCfF4wcv/0XN0hhQU0Ccjt9TbV7wFnBnRiRRyvxOs+QJVJEcPjR8gh/XQlhSHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ssYXJq/ciTnmjfVuKVf9ddQTY8ZsPz9J6nw27FYD6KMWcE13
	0jm+ya9lu7vuYwxHhlHzMtsnwc4XMtZAw4lKZU33NT8UCxXpQFrJr7pQXZK5ME32UNILOZKbXg2
	id0vLsekRzPCC+XSDm7hIw116Wo/Z5QMQS8+X0jIL0WekbhlErEPWNk1Q3qfuqDNWcmVCwAQVdw
	==
X-Gm-Gg: ASbGncu63McUAktIizZLytuhEojPd+wnMCIfzhEqsGIM7hbiu6URI5zWVk7kadJFTlu
	H+uQDwWA+xgjFiqB8UOUEQg+hSA6kedwKXHDoO29Wd4Pj/SypWVSnOKIEMMlob9UztAvWWXr0bB
	KRuLSbi90StM31ZRna6LDvCTtSAg52t0CJ7992gbbh+XMavSZtybQOmCij1dc3YVGu/7rKxBWa/
	DnEs2j+YxJoximcRwYS2vQPIMM2wmOXIcfaJFwbZ3ye32s25Nr3IMB/x8j+y59ouky9/81MoqLb
	bEIXCrwYdQpC7WMxuTx9ls1nnuPMbz0kd41IRhT35OV9E/OJnU5YtNBoeCZUbAtN3g==
X-Received: by 2002:a05:600c:4ed3:b0:456:26c6:77f3 with SMTP id 5b1f17b1804b1-458aa31fcd7mr18902125e9.12.1754039656602;
        Fri, 01 Aug 2025 02:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9dHrdikJE8iU+AXDoaMgWrxyi9BhIyaYCF/grmEP0FdzFY/s5Yr9YWGryGg8P9I6xdtla/w==
X-Received: by 2002:a05:600c:4ed3:b0:456:26c6:77f3 with SMTP id 5b1f17b1804b1-458aa31fcd7mr18901775e9.12.1754039656143;
        Fri, 01 Aug 2025 02:14:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcc1sm101356375e9.17.2025.08.01.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:14:15 -0700 (PDT)
Message-ID: <c1635857f735aa91679c153f785e09beed9b5b2f.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,  Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>
Date: Fri, 01 Aug 2025 11:14:12 +0200
In-Reply-To: <20250801075810._Ng7G1QT@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
	 <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
	 <20250801075810._Ng7G1QT@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: J6N6IDvd3m0Kb7SMjvjW9081j-blO0Ox6M7kV_bPvRE_1754039657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-01 at 09:58 +0200, Nam Cao wrote:
> On Thu, Jul 31, 2025 at 09:47:10AM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> > > Add "real-time scheduling" monitor, which validates that SCHED_RR
> > > and SCHED_FIFO tasks are scheduled before tasks with normal and
> > > extensible scheduling policies
> >=20
> > Looks a very interesting monitor!
> > A few questions:
> >=20
> > I assume this works with rt-throttle because it implies a dequeue,
> > right?
> > And you probably won't see that without explicit tracepoints..
>=20
> It does work properly with rt-throttling:
> =09root@yellow:~# ./rt-loop
> =09[=C2=A0=C2=A0 74.357730] sched: RT throttling activated
> =09[=C2=A0=C2=A0 74.357745] rv: rts: 0: violation detected
>=20
> Looking at rt-throlling code, it does not dequeue tasks, only does
> =09rt_rq->rt_throttled =3D 1;
> =09rt_rq->rt_queued =3D 0;
>=20
> so we are fine.

Wait, by /works properly/ you mean it reports a violation. I just
noticed you mention it in the description.

It's reasonable to request RT throttling disabled on sanely configured
RT systems. But throttling is a /valid/ kernel feature, I get you mark
it as /unwanted/ though.

I guess if that's the case, this monitor doesn't belong in the sched
collection because it's meant to validate the kernel behaviour, not its
configuration for a specific purpose (RT).
Isn't it better off with the rtapp ones (which validate the system
configuration to run in an RT scenario).

Does it make sense to you?

> >=20
> > As far as I understand here the monitor would just miss RT tasks
> > already running but would perfectly enforce the ones starting after
> > initialisation, right?
>=20
> Not exactly. What could happen is that:
>=20
> =C2=A0- RT task A already running
>=20
> =C2=A0- monitor enabled. The monitor isn't aware of task A, therefore it
> allows
> =C2=A0=C2=A0 sched_switch to switch to non-RT task.
>=20
> =C2=A0- RT task B is queued. The monitor now knows at least one RT task i=
s
> =C2=A0=C2=A0 enqueued, so it disallows sched_switch to switch to non-RT.
>=20
> =C2=A0- RT task A is dequeued. However, the monitor does not differentiat=
e
> task
> =C2=A0=C2=A0 A and task B, therefore I thinks the only enqueued RT task i=
s now
> gone.
>=20
> =C2=A0- So now we have task B started after the monitor, but the monitor
> does not check it.
>=20
> The monitor will become accurate once the CPU has no enqueued RT
> task, which should happen quite quickly on a sane setup where RT
> tasks do not monopoly the CPU.
>=20
> The monitor could be changed to be accurate from the get-go, by
> looking at how many enqueued RT tasks are present. I *think* rt_rq-
> >rt_nr_running works. But I think the current implementation is
> fine, so not worth thinking too much about it.

Yeah if it's something quickly reached it shouldn't be a problem, also
rt throttle would run in case there's an RT monopoly and you'd see a
violation already.

> >=20
> > Not sure you can do much about it though. (without falling into the
> > need resched rabbithole I was trying to untangle)
>=20
> I would need to look into scheduler code, maybe we could check that
> the next scheduler tick implies a sched_switch. Another day.

Agree, the monitor looks good for now.
I still want to give it a run when I have a bit more time, besides with
RT throttle, can the monitor really fail on a working system?

Thanks,
Gabriele

