Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD561FCC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830818; cv=none; b=kb0dxV8LYlZa6HaXcaWzpT0VatWdP41fFVUnDNOr2AkHPlHeZ+16PM+E+dLVSgLKPlEtyCYCEJ6PTIIGlmXrsJTC+g++OYih0e+dTL3UVC8PMbB07wjuy9TxlOG0HWNXIaBgyNauRBPbRoUhCjV8tAIyGlDulP5gHQz9vAiaaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830818; c=relaxed/simple;
	bh=jLYkH40oB5JVqk7IENrH/z41M8REqpnkoaKlNh9TW5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoujNFR2c4JVg9gvxcXwZM7yhTL9d9oM6npw7COOa/bgeThB7bNCDgyzFvU9bM0VNfAYMyyUrg7DEHvESBde2rIMEXBxVdrDJhs0+vbZmpOLsXxVdA3azYokTHeDkzI4UF9FXuTrBxvc74zijiPwJLrrsoYPFfQUK18njya7yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=LAZa+3Yk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="LAZa+3Yk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42108822e3cso18169265e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716830813; x=1717435613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5xaz9ANbbqqtDnoE1v5r0IIUcdg877x8+F/QngDnD6I=;
        b=LAZa+3Yk1er0RHbC5Je/Rfv7EGr2Oo1RzE7EzaNZ/UTpk5M1ZLXVO9wk1q6UlwpIE9
         95ipYSAjBrQJqf2dlr2GPP6+fkJN2EHYI4umtvtcRvGI4ImKie2lakTMGDXcz8GkfD5F
         7KH+AWULKz/FoLAqop39Li36UbxJ+pzgz4CicYGEB93KJs60Kz0/fZUOrTibDbg+QwY0
         rtfRzUKKGFTJj8yrX0ELIYXh++9+y0xv85/r0mjuLOvzOkluOt0Ywhg1L0KiBn3UAlkW
         4Xmd0WVL6GX7vv0hA3uTM7DRADQ64Ze2JoPxQNBUmkPB8bT8cdlIV9KogF92OO12i3l/
         i4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716830813; x=1717435613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xaz9ANbbqqtDnoE1v5r0IIUcdg877x8+F/QngDnD6I=;
        b=ZS/jqgYXUNhIf5SwS8MEkwvC2pHtifJL//CF9vIlKRya58ogmdcZi6p1k1N9/+uz2Q
         W2KQD8xPnbePh1gniBOXpC0ksmOHuup1tRE29VprraS1BZNkHvJdcczPn/wzSVe5S/vB
         9TcB9bzxgMcoeLtWG5f5fNw68d4SiC4Qru3VTqTiU5oyt3lQMQ7YVZTKcqOu6c75rrhh
         xYMl8Nm8FnW32KJ6rqvzAuTp7A7Wg9/KspD1IS0pNySQ+SGMPNyaAU9E2mTo7tDcKZnX
         uMdfj7bayfp+ZLV15ksMq1CVmk42mycAQzQxzZsjGpobHFJaqsPPKKzRmp08c8lj9G9A
         f+7g==
X-Forwarded-Encrypted: i=1; AJvYcCXx1lrGcxzGks5RTzCYBOurJDzFOVg40SkPV12yBnSYLrltRfAVOp/qGMh9k0r8qfjJ7DfEbwWFuaWYxSFRf8pLZoNStEbqwpmLc+N7E3auLiBa
X-Gm-Message-State: AOJu0YxulhYOTBKI6ixO2rN/D4VjqPjXdBvzNqnHB9hDTxpSncjekJXN
	NIXrEAFTLYSU/fScutXv7iLiwjJ//J3f6KB39eUm8IVmIl29vGeheXUG4yUiYeU=
X-Google-Smtp-Source: AGHT+IFArA1tSNa8aXEYto+F+xmnxEWR8BmJTuNot07bbSgyyxQsRiM4eehBTdcgh4HRplq3rNQiuw==
X-Received: by 2002:a05:600c:54c5:b0:41f:dc27:a7c1 with SMTP id 5b1f17b1804b1-421081ae3f7mr94812535e9.5.1716830813135;
        Mon, 27 May 2024 10:26:53 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089708f8sm113693955e9.20.2024.05.27.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:26:52 -0700 (PDT)
Date: Mon, 27 May 2024 18:26:50 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240527172650.kieptfl3zhyljkzx@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521110035.KRIwllGe@linutronix.de>

On 05/21/24 13:00, Sebastian Andrzej Siewior wrote:
> On 2024-05-15 23:05:36 [+0100], Qais Yousef wrote:
> > rt_task() checks if a task has RT priority. But depends on your
> > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > task, which includes RT and DL classes.
> > 
> > Since this has caused some confusion already on discussion [1], it
> > seemed a clean up is due.
> > 
> > I define the usage of rt_task() to be tasks that belong to RT class.
> > Make sure that it returns true only for RT class and audit the users and
> > replace the ones required the old behavior with the new realtime_task()
> > which returns true for RT and DL classes. Introduce similar
> > realtime_prio() to create similar distinction to rt_prio() and update
> > the users that required the old behavior to use the new function.
> > 
> > Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.
> > 
> > Document the functions to make it more obvious what is the difference
> > between them. PI-boosted tasks is a factor that must be taken into
> > account when choosing which function to use.
> > 
> > Rename task_is_realtime() to realtime_task_policy() as the old name is
> > confusing against the new realtime_task().
> 
> I *think* everyone using rt_task() means to include DL tasks. And
> everyone means !SCHED-people since they know when the difference matters.

yes, this makes sense

> 
> > No functional changes were intended.
> > 
> > [1] https://lore.kernel.org/lkml/20240506100509.GL40213@noisy.programming.kicks-ass.net/
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> > 
> > Changes since v1:
> > 
> > 	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
> > 	* Improve commit message readability about replace some rt_task()
> > 	  users.
> > 
> > v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyousef@layalina.io/
> > 
> >  fs/select.c                       |  2 +-
> 
> fs/bcachefs/six.c
> six_owner_running() has rt_task(). But imho should have realtime_task()
> to consider DL. But I think it is way worse that it has its own locking
> rather than using what everyone else but then again it wouldn't be the
> new hot thing…

I think I missed this one. Converted now. Thanks!

> 
> >  include/linux/ioprio.h            |  2 +-
> >  include/linux/sched/deadline.h    |  6 ++++--
> >  include/linux/sched/prio.h        |  1 +
> >  include/linux/sched/rt.h          | 27 ++++++++++++++++++++++++++-
> >  kernel/locking/rtmutex.c          |  4 ++--
> >  kernel/locking/rwsem.c            |  4 ++--
> >  kernel/locking/ww_mutex.h         |  2 +-
> >  kernel/sched/core.c               |  6 +++---
> >  kernel/time/hrtimer.c             |  6 +++---
> >  kernel/trace/trace_sched_wakeup.c |  2 +-
> >  mm/page-writeback.c               |  4 ++--
> >  mm/page_alloc.c                   |  2 +-
> >  13 files changed, 48 insertions(+), 20 deletions(-)
> …
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index 70625dff62ce..08b95e0a41ab 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -1996,7 +1996,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
> >  	 * expiry.
> >  	 */
> >  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > -		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> > +		if (realtime_task_policy(current) && !(mode & HRTIMER_MODE_SOFT))
> >  			mode |= HRTIMER_MODE_HARD;
> >  	}
> >  
> > @@ -2096,7 +2096,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
> >  	u64 slack;
> >  
> >  	slack = current->timer_slack_ns;
> > -	if (rt_task(current))
> > +	if (realtime_task(current))
> >  		slack = 0;
> >  
> >  	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
> > @@ -2301,7 +2301,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
> >  	 * Override any slack passed by the user if under
> >  	 * rt contraints.
> >  	 */
> > -	if (rt_task(current))
> > +	if (realtime_task(current))
> >  		delta = 0;
> 
> I know this is just converting what is already here but…
> __hrtimer_init_sleeper() looks at the policy to figure out if the task
> is realtime do decide if should expire in HARD-IRQ context. This is
> correct, a boosted task should not sleep.
> 
> hrtimer_nanosleep() + schedule_hrtimeout_range_clock() is looking at
> priority to decide if slack should be removed. This should also look at
> policy since a boosted task shouldn't sleep.

I have to admit I never dug deep enough into this code. Happy to convert these
users. I'll add that as a separate patch as this is somewhat changing behavior
which this patch intends to do a clean up only.

> 
> In order to be PI-boosted you need to acquire a lock and the only lock
> you can sleep while acquired without generating a warning is a mutex_t
> (or equivalent sleeping lock) on PREEMPT_RT. 

Note we care about the behavior for !PREEMPT_RT. PI issues are important there
too. I assume the fact the PREEMPT_RT changes the locks behavior is what you're
referring to here and not applicable to normal case.


Thanks!

--
Qais Yousef

> 
> >  	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
> > diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> > index 0469a04a355f..19d737742e29 100644
> > --- a/kernel/trace/trace_sched_wakeup.c
> > +++ b/kernel/trace/trace_sched_wakeup.c
> > @@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
> >  	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
> >  	 */
> >  	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
> > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > +	    (wakeup_rt && !realtime_task(p)) ||
> >  	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
> >  		return;
> >  
> 
> Sebastian
