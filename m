Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019342056
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598138; cv=none; b=P0AOdYK/FsNjfkckYBMIka9fSQaqFqyuTOatUqL0VaJCpAifjkipICgmkWRvKxxyUnpKI0FgOEj7Nb7T/ZV6wU0VGxRPj1tKqmYIY9mRam4nDxW5pxnq7PXGa+HqzDPUTGpoNl30Y3pTo1CX0t57f4k83Lh9hc8Ea6g/RM5Mto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598138; c=relaxed/simple;
	bh=NHPHtH9ALf8fXP+m7/BR0oKEAA9a42xol7Ri8hb20nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=po/D5oylj54VDQ5Pq11xwse1ZhzJLqLB4icNIG2h4LB7s4DSwwnTaRuf3RFQKFp9LIva1yKryGfuVFgHlLXh5SkCOwxOUdSM8S6PSncxP7YvZIaMqyxrmz/kX1bel14CpD9yEnJRjIZgfkMOxt0+M1kdDyOON4Y9SEijC6kF8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grf2Tql4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grf2Tql4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755598135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1yexDew6C3Lad0/qhTHuJrwx4Fxi6ziyJpmXWOKMBI=;
	b=grf2Tql4rtBPaEOeCJG3aU+3K4ZqDRajZLmJ9xLJR3wfcF/Uce2uL613dyWzIwm8V3OJ+Q
	LCELe603h+R7+5f6yAInAgE/3iQb7e3VGe9EbThWZX6eeEBF/1DABlyVwiOd9TLx3BbDxI
	ZgwsVDWxlLOChQIawgdxiD6wySEJj6M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-K_BMYtmmMKq0uoS1oJT_lQ-1; Tue, 19 Aug 2025 06:08:53 -0400
X-MC-Unique: K_BMYtmmMKq0uoS1oJT_lQ-1
X-Mimecast-MFC-AGG-ID: K_BMYtmmMKq0uoS1oJT_lQ_1755598133
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109ab1e1dso263686481cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598133; x=1756202933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1yexDew6C3Lad0/qhTHuJrwx4Fxi6ziyJpmXWOKMBI=;
        b=kBAn72w+ZIVNP64pjQv2TnADPDBYUPQ0vP/VoP2JgoYBggteT53Yl/kE04JGyGL/JE
         C8/I1Z6/TanbFuIRM+nhX5zdLmMa7uQXXUifcF+vbRPeRmMG/gTbiF/MOC5zDP7BJm/a
         KKwour347fmDgESEuCyaS3kMMG1bQYenycHvmfboYdRrOvPlU3fbcF/yW61bQrFGaMuC
         IrDjBb+OuqFjck5EQWP5XGwGEagTgzQCUxa+yrlthrk+SJSJ2W1jnBV4zTbILhxPfGFF
         b2+zxx2/FO/znHzdz9l23766J7qriJP19aepdEBE5Jm8dWzQgWPjWxA9IqG3R3nqMNtH
         LiSg==
X-Forwarded-Encrypted: i=1; AJvYcCXCyBBQQ4I/Y3fLo6nmg6Vr6C6+qXXq6TrKzBznTZlNRM0t/IlvNQVx7mFpkjPzPXLIux3bv+VII0E6Csj7cKlJapA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYOjysIuuC6nJGFrrBQgbwtgDsSolnQG5lmtW0jNA4t0RnzZB
	ikVlAW5T4axSmnBVnERBB2asV1WQCJIa+PpRUKmhb/gsGpJ1z/XqGUnkWJ+NVAp9fGquVq8DMUS
	i8d4RSjOT3flFuej4/TAlacBxosMHCqKuZTk4DsRiKDE96XH1lBDjZf3rJf8vw9iKQOFn33zttg
	==
X-Gm-Gg: ASbGncsE6CW18GqSeLUkOP+N5xldfuIZkyrQAub9ugyfzqhPMcBCjGwiLGthJPx6ODM
	ZfchX5HNvHtzKcKKmwBJifgA7FA266Mb9Qw4CM2wVKv/DXwCpy+z1clB2pEFJcx2Jcc6F5Nc+0L
	vqyllshaG9N+1lo96gCgUX9ruvwRNKMeUHbrKbwW/0JyTUl9G/9Cjwuepl0QRtVbgUHFC/hvuT7
	8uIMDXwgSIPqRBKidxoHSTqEyMitY12/RUpkxdXvDy1Pbxt2j4ZkuordCtNwje04Wb2KA36YlKs
	7v+DVRiNV3ERZLq5m6xeQRf1+o8dudxhyOtCErZ+Q2UzcRvOt/KnbRF+GA5Zl249Cutx
X-Received: by 2002:a05:622a:13:b0:4b0:82d9:7cc0 with SMTP id d75a77b69052e-4b286c9801cmr24440511cf.13.1755598133315;
        Tue, 19 Aug 2025 03:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeSozDuJgPdcyPhgCPexi8n/y3Ep+51aw5qhD6j4WyoggQ1R/8vBy7fG3x+/dTjFoBKHArIw==
X-Received: by 2002:a05:622a:13:b0:4b0:82d9:7cc0 with SMTP id d75a77b69052e-4b286c9801cmr24440221cf.13.1755598132861;
        Tue, 19 Aug 2025 03:08:52 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.81.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b27e7810f0sm19150841cf.47.2025.08.19.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:08:52 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:08:48 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
 <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rG4S9DSJoGvpCzsSu8mXrWyL3DIFIQgKJx1kcXk3BUk_1755598133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 19/08/25 11:48, Gabriele Monaco wrote:
> 
> 
> On Tue, 2025-08-19 at 11:18 +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 14/08/25 17:08, Gabriele Monaco wrote:
> > 
> > ...
> > 
> > > +/*
> > > + * ha_monitor_init_env - setup timer and reset all environment
> > > + *
> > > + * Called from a hook in the DA start functions, it supplies the
> > > da_mon
> > > + * corresponding to the current ha_mon.
> > > + * Not all hybrid automata require the timer, still set it for
> > > simplicity.
> > > + */
> > > +static inline void ha_monitor_init_env(struct da_monitor *da_mon)
> > > +{
> > > +	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
> > > +
> > > +	ha_monitor_reset_all_stored(ha_mon);
> > > +	if (unlikely(!ha_mon->timer.base))
> > > +		hrtimer_setup(&ha_mon->timer,
> > > ha_monitor_timer_callback,
> > > +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +}
> > 
> > ...
> > 
> > > +/*
> > > + * Helper functions to handle the monitor timer.
> > > + * Not all monitors require a timer, in such case the timer will
> > > be set up but
> > > + * never armed.
> > > + * Timers start since the last reset of the supplied env or from
> > > now if env is
> > > + * not an environment variable. If env was not initialised no
> > > timer starts.
> > > + * Timers can expire on any CPU unless the monitor is per-cpu,
> > > + * where we assume every event occurs on the local CPU.
> > > + */
> > > +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon,
> > > enum envs env,
> > > +				     u64 expire)
> > > +{
> > > +	int mode = HRTIMER_MODE_REL;
> > > +	u64 passed = 0;
> > > +
> > > +	if (env >= 0 && env < ENV_MAX_STORED) {
> > > +		if (ha_monitor_env_invalid(ha_mon, env))
> > > +			return;
> > > +		passed = ha_get_env(ha_mon, env);
> > > +	}
> > > +	if (RV_MON_TYPE == RV_MON_PER_CPU)
> > > +		mode |= HRTIMER_MODE_PINNED;
> > > +	hrtimer_start(&ha_mon->timer, ns_to_ktime(expire -
> > > passed), mode);
> > > +}
> > 
> > Also, my only concern with the usage of per-task timers is that
> > reprogramming add overhead, so I wonder if this gets noticeable when
> > running some kind of performance sensitive workload in production (as
> > it was reported for dl-server). Did you test such a case?
> 
> That's a good point, I need to check the actual overhead..
> 
> One thing to note is that this timer is used only on state constraints,
> one could write roughly the same monitor like this:
> 
>   +------------------------------------------+
>   |                 enqueued                 |
>   +------------------------------------------+
>     |
>     | sched_switch_in;clk < threshold_jiffies
>     v
> 
> or like this:
> 
>   +------------------------------------------+
>   |                 enqueued                 |
>   |         clk < threshold_jiffies          |
>   +------------------------------------------+
>     |
>     | sched_switch_in
>     v
> 
> the first won't fail as soon as the threshold passes, but will
> eventually fail when the sched_switch_in event occurs. This won't use a
> timer at all (well, mostly, some calls are still made to keep the code
> general, I could improve that if it matters).
> 
> Depending on the monitor, the first option could be a lower overhead
> yet valid alternative to the second, if it's guaranteed sched_switch_in
> will eventually come and reaction latency isn't an issue.

Right, as in the first example you have in the docs. I was thinking it
would be cool to possibly replace the hung task monitor with this one,
but again we would need to check for overhead, as the definition that
does expect a switch_in to eventually happen wouldn't work in this case.

> > Does this also need to be _HARD on RT for the monitor to work?
> 
> That might be something we want configurable actually.. I assume the
> more aggressive the timer is, the more overhead it will have on the
> system.
> Some monitors might be fine with a bit of latency.

It might not only be about latency, as if the callback timer is not
serviced in case of starvation (if it's not hard) then the monitor won't
probably react and we won't be able to rely on it.

> For example in the deadline case, I believe, the monitor is not
> supposed to fix anything, but merely report violations. So we don't
> really care to react on time, but to react at all.
> 
> I'm going to assess the overhead and see how to offer some more
> configurability.

Thanks!

