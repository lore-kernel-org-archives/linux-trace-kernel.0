Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32A149DF0;
	Fri,  1 Aug 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035095; cv=none; b=LcBw2jyXszim4sv3Og8yVH2QG/9HMTUfjhnILJF9F6dZnCUN/BZufZ00M/HK9LixvYm68HUjIKrZfzTaDkTTq4vnxQJAxcscaJ3PCNALKZSjz8UpxtQt2F5HMrvBaHaB1OdsXqeUzpDySKmjHGP6Ya9Tt8urE8RLpg9Xg34pQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035095; c=relaxed/simple;
	bh=4G8ZhZtodfCeiMf5Gp7tSbupjCoO3FbHLO5sWumn/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnZyWVM7dQRc2ajvd40OnIP2OrzLqnY9C0fZ2ndkAEb5GuxNKdb2E/oskJ6FSwW5Z+P0JmkySYrNbBHCmiJ6xI2/01UbxCD7cpJL/16qvFW6pM6h4cKbVP/JnyNSxdesF8hThubLUXh9cP134VrEXdU2LK/n9GEnq6K7GFHdBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxVUQSQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg8ggV2A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxVUQSQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg8ggV2A"
Date: Fri, 1 Aug 2025 09:58:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754035092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjDlUcWpNJA19n2hFY8uNhKAuaKdKU6iYQHAetVcuVs=;
	b=uxVUQSQ8+oOqJGHX17OobaEduDxX+Lv8wtSBKntZr8LmURRWJQusKP/0xVrzCW34wr7buu
	u0uHhGgnjl59yQrU/r2xpmuPmvlJe8YvjKMfk80be1JFZGtqQUaFVC0Ms+jKceow/bszG3
	fjAhM1YMGPeXuCPMo8Ze7ojF2aSbKDbQA01BNQ1HSkIqe92xD2n/cZzP5mfyPjsDViNQ1o
	rndpG2rBQgqyevmASbKv9LQw7vK0Lk/kdlD+LsF/RpKVogCI0tsrTc48cYaBEHw1/KgvJ8
	SVacCr7FcO79NfshzCBcHMfFbT9dokyquAAN3GObg4A0sZ65uvID8GhV2AMa5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754035092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjDlUcWpNJA19n2hFY8uNhKAuaKdKU6iYQHAetVcuVs=;
	b=bg8ggV2AxmZDh2BiayN9HtaX+MQIpw4H7iDWBmssLO2PX8EsXolcJ5XH+6f2XefOAW/mip
	VBebV1eR0RvpcUBw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
Message-ID: <20250801075810._Ng7G1QT@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
 <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>

On Thu, Jul 31, 2025 at 09:47:10AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> > Add "real-time scheduling" monitor, which validates that SCHED_RR and
> > SCHED_FIFO tasks are scheduled before tasks with normal and
> > extensible
> > scheduling policies
> > 
> 
> Looks a very interesting monitor!
> A few questions:
> 
> I assume this works with rt-throttle because it implies a dequeue,
> right?
> And you probably won't see that without explicit tracepoints..

It does work properly with rt-throttling:
	root@yellow:~# ./rt-loop
	[   74.357730] sched: RT throttling activated
	[   74.357745] rv: rts: 0: violation detected

Looking at rt-throlling code, it does not dequeue tasks, only does
	rt_rq->rt_throttled = 1;
	rt_rq->rt_queued = 0;

so we are fine.

> > +	/*
> > +	 * This may not be accurate, there may be enqueued RT tasks.
> > But
> > that's
> > +	 * okay, the worst we get is a false negative. It will be
> > accurate
> > as
> > +	 * soon as the CPU no longer has any queued RT task.
> > +	 */
> > +	ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
> > 
> 
> As far as I understand here the monitor would just miss RT tasks
> already running but would perfectly enforce the ones starting after
> initialisation, right?

Not exactly. What could happen is that:

 - RT task A already running

 - monitor enabled. The monitor isn't aware of task A, therefore it allows
   sched_switch to switch to non-RT task.

 - RT task B is queued. The monitor now knows at least one RT task is
   enqueued, so it disallows sched_switch to switch to non-RT.

 - RT task A is dequeued. However, the monitor does not differentiate task
   A and task B, therefore I thinks the only enqueued RT task is now gone.

 - So now we have task B started after the monitor, but the monitor does
   not check it.

The monitor will become accurate once the CPU has no enqueued RT task,
which should happen quite quickly on a sane setup where RT tasks do not
monopoly the CPU.

The monitor could be changed to be accurate from the get-go, by looking at
how many enqueued RT tasks are present. I *think* rt_rq->rt_nr_running
works. But I think the current implementation is fine, so not worth
thinking too much about it.

> > +RULE = always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
> > +
> > +SCHEDULE_RT_NEXT = (not SCHED_SWITCH) until (SCHED_SWITCH_RT or
> > EXCEPTIONS)
> > +
> > +EXCEPTIONS = SCHED_SWITCH_DL or not RT_TASK_ENQUEUED
> 
> This monitor allows non-RT tasks to run indefinitely before the switch,
> only when it happens, RT must run, right?

Yes.

> Not sure you can do much about it though. (without falling into the
> need resched rabbithole I was trying to untangle)

I would need to look into scheduler code, maybe we could check that the
next scheduler tick implies a sched_switch. Another day.

Nam
