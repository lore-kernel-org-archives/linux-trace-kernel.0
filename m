Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67D13B58A;
	Mon, 11 May 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500537; cv=none; b=gRg5umFggEVhhrl8kZ4x5BzzwDjRvhL6DQU+72I3ecgf2HD4YZ7l8Pv8eDWMhgL++2EfaN1yHJJk+4bzwpR7dhLMpHP3r3r+wPNNwg918sQIEerSJvj6szHZ0KO1N6DVl8UnpVRuQ+YMpkdYRdEVsJohcLjn4iAUF+vyb1RLVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500537; c=relaxed/simple;
	bh=asit4Z10BXOXs5PlEqF3AGgFzcX9dM95sfl88Z7u0Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGb1Jc+/N0hJ6IjHk+T0OjY1zVqEG/58ZpnRxeb9n+uDEfwgBKmbRxtnrR5BYS/jnCdyQtwUUpL8BZEXsAVQWfAt0qitxK2UzLJQ+tvvWlA9ZqAT/WtsrnpOpEiNbkvldnLJdIk3N+PSGWDotsGpq/aGXEEp/F1Dz0m4lYB0yN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7gnm4gt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R46fRCVE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7gnm4gt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R46fRCVE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778500533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FWKDZGohyhh9Yrb8WvpGh52tC89+hxM1SOtOwDOO+U=;
	b=n7gnm4gt9yl3NPKmPZ2aWs5fSFw0rXiUyFRFlDY6rWqiXx88485DZ8Kpeh0HoYlByrRVeI
	YIL80xUbS+j6JUBeQCPDZxptiaXZ4FbaoEelf1RcBwi/t6oTq9FRj64AUWOzzFOd64uUic
	0X3SX/D2CBxaVBxL/c8J+SGFe1gNMlWAZdT9YQyyGMPZrCETfO98PyvhLFb5bcxb3YLDpw
	3UBWjh6wfRKqNBImTqkT5k7qSKbKcvRFUineTFkq/7l3VmGK/Gt704Yd2L24jUYBLiDy4k
	IeIctAjdOCiyA3UmRbysPEjEg+e4I/S8HUe+/fTVXMXSkxHFx65inyE4bk2nlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778500533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FWKDZGohyhh9Yrb8WvpGh52tC89+hxM1SOtOwDOO+U=;
	b=R46fRCVE/Z9Jbj6iVouZ3osnIRLywX05TXHGb8G2kF6/xDdK4X63ZmSPfbplNcFvZ9aYWd
	9PQsr1x2gYb7NtDA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
In-Reply-To: <967f1cd8cd6e27aaa65d68194487306bc312caa0.camel@redhat.com>
References: <cover.1777962130.git.namcao@linutronix.de>
 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
 <967f1cd8cd6e27aaa65d68194487306bc312caa0.camel@redhat.com>
Date: Mon, 11 May 2026 13:55:32 +0200
Message-ID: <87wlxaupmz.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Well, this is roughly what we discussed in [1].
> Now, I didn't submit the throttle monitor yet because it depends on unacked
> tracepoints.

Thanks for bringing that up. I had no memory of that discussion.

> In short, this works with the assumption that the expires value you pass to
> ha_check_invariant() is the same you used to arm the timer.
>
> That's true for constant values only (the deadline) but not for something like
> the runtime. I couldn't think of a way to rearrange that model not to require
> the runtime left field.

I believe you are referring to this:

                                     |
                                     |
      dl_replenish;reset(clk)        v
              sched_switch_in   #=========================# sched_switch_in;
               +--------------- H                         H   reset(clk)
               |                H                         H <----------------+
               +--------------> H         running         H                  |
    dl_throttle;reset(clk)      H clk < runtime_left_ns() H                  |
   +--------------------------- H                         H sched_switch_out |
   |       +------------------> H                         H -------------+   |
   | dl_replenish;reset(clk)    #=========================#              |   |
   |       |                         |             ^                     |   |
   v       |                  dl_defer_arm         |                     |   |

Now that I stared at this again, I think we already deviate from theory
here. Our documentation mentions that the invariant must be in the form

        g = v < c | true

with "c [being] a numerical value".

The invariant "clk < runtime_left_ns()" means clk must not exceed the
remaining runtime, which is sampled by calling runtime_left_ns() when
the state is entered. This is not in the theory. Additionally, I think
this interpretation is ambiguous; one could also interpret that as "the
clk value must never exceed the *current* value returned by
runtime_left_ns()".

I digged into the cited academic papers, but couldn't find anything that
can describe this. The closest I see is the "init" label for states, but
that is the condition for entering the states.

> Otherwise.. We could read the remaining time in the timer, but we wouldn't be
> able to simulate ns precision when using the timer wheel.
>
> Now if we really wanted to go down that path, we are using a union to allocate
> either timer or hrtimer, the latter is larger, so we /could/ add a u64 expire_ns
> field to the ha_monitor struct without needing additional memory.
>
> If that doesn't sound too wild to you, I may try and sketch something up to see
> if that's viable. Then this patch could go through as is and I would add the
> extension together with the submission of throttle.

That can work, but not ideal, because hrtimer will not be usable.

Looking at the throttle monitor again, is it possible to rewrite
runtime_left_ns() to read .dl_runtime instead of .runtime? I don't know
the deadline schedule very well, but I think .dl_runtime is not changing
like .runtime?

Nam
