Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24526AE7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831428; cv=none; b=kqt5F+O9K6yCOWZnILNKwfCUsFeoDubYgu+WnHC8V1HQUdu7OIdrilI0ZNYwejldz7AjlwqA5Z+e9N+VL4OyNg+pUmnBsW4rSGhAy1/Y1k5Wl2fiU1GlwJet06T38gaO6rfNU1i4qbivcU3npmMUCui6W11LZpR0Fs5txQo7mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831428; c=relaxed/simple;
	bh=XI6erCDnrp+edCzPtCdt2hp9LgvvOZnP83lVYPYHph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaffY4vLWMKaGlxkaXbw7WJ7F4KcnXLtfbpA0UjkeAhtuiRbpRjB1tp6bBk0/Pwz/EuOWPddljXcLLxI3SnXtqApYyAzbHkzs4+iFIWnSoKlQ8lFLZiCT+aTPenXDDzgBDr7cgoH33bOJ6ShONp3fuIvLcxFeosi/Kd5TUt7sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=0DJ+9IAz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="0DJ+9IAz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so112131995e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716831425; x=1717436225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=0DJ+9IAzti2vugVYkKwZ+eJC/QJQBMTuE7BzanFIcrz86+S5rgwcYc8wUbHu0tc+0O
         wu0RYLQ4IUbKGdQy4+7VB+HtKxXkyj4RySCqJeCgRtr5lxhTp4bCuKsOCmCSXE0tIk10
         mYcf15pN735Pa1t4/yj0Y0eOEPI6ukHH89/wyS2VTveRXolA8FB3PGrQIhebf9Go57Bm
         6kgE9d2JEEUIEUA40Z8lNoXKByAbkbfnWYgqWYyM6g07H/desKIaXhyFOtjanSVomrx6
         pVG4OC4XizNAzfhFHSLmJs/KCIDU+nl6Kno0jQTwWvecS6yiqGk2vscEPjxkgURFCwO7
         +xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831425; x=1717436225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=j9DKHqfDgkfAEvOsDiMxHZRpPLebC56c3IL7b+GFweeefeEF44v4hrg0YsK9TykReV
         udERW4Cnlkyb/xTG5mz9JrVAZ0D2z8hlEFylBMx5PBMwUV1khjszQaS7BUTblMlYUPvr
         J4b61fc6PMD6yk+b8KPEDADPKa/RfTegcQAyxeQu5n1d7Nb9RvWnKXihkgsVouA0haRK
         WDit7gkUjnwvm7YMM2PQp/9xG0X/zxSwxm3TL/h7XfOCN6mA2ipy4RMn1a1K+Uz01T07
         rdUWb0l+OUT2eqi6D3mV3nKY6RQ4KHgy9lF3OLP3Cs7V2dPfGEZce/FD0aj8OVfuX7EL
         Pwhg==
X-Forwarded-Encrypted: i=1; AJvYcCUphIOpaku7gGeTIpRdW/6qJWYyFleI4/1jfWKl9RSloKnqZXKemte0pP/yeAv+T6OKcTJPOEftwybHQyFbH7ou4FfJmAE9VRR9/aEen50+jdFj
X-Gm-Message-State: AOJu0YzRx38IvzUIkyf/uFHb3Hl0gT4eAXGu1cl2tpag8ikvsoB6jhqh
	L0zoObEGdDE+yhGMxC5LTAsWD1rJjngTb6b+MNmS/xtV1IEX89GyG70zwgpfXYs=
X-Google-Smtp-Source: AGHT+IFHCdjZfBLADJgWvonL4PKkMzOE4//76Gn2zYKCwqPkEaCY0W71oc+vzFaisXznPhCsroiviQ==
X-Received: by 2002:a05:6000:1001:b0:354:db70:3815 with SMTP id ffacd0b85a97d-355270567abmr9685956f8f.7.1716831425563;
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9530sm9512807f8f.81.2024.05.27.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Date: Mon, 27 May 2024 18:37:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240527173703.52wsstp5dnczaxrv@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240523114540.2856c109@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523114540.2856c109@gandalf.local.home>

On 05/23/24 11:45, Steven Rostedt wrote:
> On Wed, 15 May 2024 23:05:36 +0100
> Qais Yousef <qyousef@layalina.io> wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index df3aca89d4f5..5cb88b748ad6 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,8 +10,6 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -#define MAX_DL_PRIO		0
> > -
> >  static inline int dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> > @@ -19,6 +17,10 @@ static inline int dl_prio(int prio)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to DL class. PI-boosted
> > + * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int dl_task(struct task_struct *p)
> >  {
> >  	return dl_prio(p->prio);
> > diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> > index ab83d85e1183..6ab43b4f72f9 100644
> > --- a/include/linux/sched/prio.h
> > +++ b/include/linux/sched/prio.h
> > @@ -14,6 +14,7 @@
> >   */
> >  
> >  #define MAX_RT_PRIO		100
> > +#define MAX_DL_PRIO		0
> >  
> >  #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
> >  #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
> > diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> > index b2b9e6eb9683..a055dd68a77c 100644
> > --- a/include/linux/sched/rt.h
> > +++ b/include/linux/sched/rt.h
> > @@ -7,18 +7,43 @@
> >  struct task_struct;
> >  
> >  static inline int rt_prio(int prio)
> > +{
> > +	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static inline int realtime_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_RT_PRIO))
> >  		return 1;
> >  	return 0;
> >  }
> 
> I'm thinking we should change the above to bool (separate patch), as
> returning an int may give one the impression that it returns the actual
> priority number. Having it return bool will clear that up.
> 
> In fact, if we are touching theses functions, might as well change all of
> them to bool when returning true/false. Just to make it easier to
> understand what they are doing.

I can add a patch on top, sure.

> 
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to RT class. PI-boosted
> > + * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int rt_task(struct task_struct *p)
> >  {
> >  	return rt_prio(p->prio);
> >  }
> >  
> > -static inline bool task_is_realtime(struct task_struct *tsk)
> > +/*
> > + * Returns true if a task has a priority that belongs to RT or DL classes.
> > + * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
> > + * PI-boosted tasks.
> > + */
> > +static inline int realtime_task(struct task_struct *p)
> > +{
> > +	return realtime_prio(p->prio);
> > +}
> > +
> > +/*
> > + * Returns true if a task has a policy that belongs to RT or DL classes.
> > + * PI-boosted tasks will return false.
> > + */
> > +static inline bool realtime_task_policy(struct task_struct *tsk)
> >  {
> >  	int policy = tsk->policy;
> >  
> 
> 
> 
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
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

--
Qais Yousef

> 
> 
