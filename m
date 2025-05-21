Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A41DC1AB;
	Wed, 21 May 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810688; cv=none; b=OweYaojzfVySZaKLeCqTsmeC3/6pVYqPmRnKVx+noxcndF9L9T5l2xB96ehCm7c6EuKL3YKhPnizMVX3y/OwACzKQWh9GZ0QxLKG/ID78d9xcewTHbr9KC23ZtQNzKFqQsu10XpV0uwt+XG/Lv8aG0aN5NW1rwwXzcGcXbSVxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810688; c=relaxed/simple;
	bh=IWz6Yy/BcLz6PFo1jEHDIlrywfsNwNmZ069v+JGYxUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJlvCpLZK9Kaw/EsckaRNr5kCCxC4tic2mLZ1dXGe/qMJmwTOqFyXxHZVtvwJkX6BAk8m+qTlnksX2E0A6lnW4Ad1oHmGmgbVTrxtDRayl+ErUSKSSjEo6VHRfzDsRtpqelHpBNeJRYhgpH71ZAKaxPY7jg6qUS8E5QonVD1w10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Edpjpf68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7IOWTLCV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Edpjpf68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7IOWTLCV"
Date: Wed, 21 May 2025 08:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747810685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdBcXY08SFR0xzfgVF5rY3+1lWSMx/XtZ80Wkh6Zt5Q=;
	b=Edpjpf68A1uKzaP0QrwzhV1XWzGzmtCqSbPMr84wq8Z4mxdOcdWoAfU3ugeZbqHPag4wAo
	CsBDDfsDq7rMLSxIZLcjvPVZoSHcgfaplwBo1ObxGGb+WFkVUt4I71qKCDsTmXyRimPxaj
	QpPKj3cCzDNi7y7hKtoBIki51hbNsgxI36KFUYzKpiOeNBIdWZ2j3lsF8C/v6GdkfILxGh
	n3OIx4qf3N27eAkXMi42uO40CljN32kg5rOhhlVwxu48v72FGqqv6ICIU7bIh5Zv6w3z1d
	6AziKRVZitnc+snBXA9QbD/QXZKG6kfDT5AeIxvfCG7l5v0aAAuGLctDAz+AIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747810685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdBcXY08SFR0xzfgVF5rY3+1lWSMx/XtZ80Wkh6Zt5Q=;
	b=7IOWTLCV94pErTphukCDvEfRUUt+2wfK7tjAEX3KdEcL7Ln508RjKfuP+sHHSecZHIk7bX
	eRHBHnqpczRasHDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 10/12] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250521065800.jgtPyWd7@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-11-gmonaco@redhat.com>
 <20250519090626.zjiYgUGW@linutronix.de>
 <5f1365f2cd84597fd3547544fcceab5c79682624.camel@redhat.com>
 <20250519103809.nuEUQbVl@linutronix.de>
 <cdcab46480cbfe2c3320e060ea9603adbd04956c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcab46480cbfe2c3320e060ea9603adbd04956c.camel@redhat.com>

On Mon, May 19, 2025 at 01:13:01PM +0200, Gabriele Monaco wrote:
> 
> 
> On Mon, 2025-05-19 at 12:38 +0200, Nam Cao wrote:
> > On Mon, May 19, 2025 at 12:28:12PM +0200, Gabriele Monaco wrote:
> > > Mmh, although definitely unlikely, I'm thinking of a case in which
> > > the
> > > event starts on one CPU and at the same time we see events in IRQ
> > > and 
> > > on another CPU, let's say continuously. Nothing forbids that
> > > between
> > > any two consecutive try_cmpxchg another CPU/context changes the
> > > next
> > > state (making the local try_cmpxchg fail).
> > > In practice I've never seen it going on the second iteration, as
> > > the
> > > critical section is really tiny, but I'm not sure we can guarantee
> > > this
> > > never happens.
> > > Or am I missing something?
> > 
> > I have a feeling that you missed my point. I agree that the retrying
> > is
> > needed, because we may race with another.
> > 
> > What I am proposing is that we drop the MAX_DA_RETRY_RACING_EVENTS,
> > and
> > just keep retrying until we succeed.
> > 
> > And that's safe to do, because the maximum number of retries is the
> > number
> > of tasks contending with us to set the monitor's state. So we know we
> > won't
> > be retrying for long.
> 
> I get this point, what I mean is: can we really guarantee the number of
> contending tasks (or contexts) is finite?
> In other words, the try_cmpxchg guarantees 1 and only 1 actor wins
> every time, but cannot guarantee all actors will eventually win, an
> actor /could/ be hanging there forever.
> 
> This handler is running for each event in the monitor and tracepoint
> handlers can be interrupted as well as run in interrupt context (where
> of course they cannot be interrupted). I don't think the number of
> actors is bounded by the number of CPUs.
> I see this situation is extremely unlikely, but in an exotic scenario
> where a CPU is sufficiently slower than others (e.g. in a VM) I believe
> we can see this critical section large enough for this to potentially
> happen.
> 
> I'm not quite afraid of infinite loops, but rather RV introducing
> unbounded latency very hard to track and without any reporting.
> Chances are, since tracepoints and actual traced events are not atomic,
> that by the time this delayed context /wins/ the RV event is no longer
> current, so we may see an error already.
> 
> Does it make sense to you or am I making it more complex than it should
> be?

Right, I can see that being a problem. But I don't know enough about it to
comment further, so do as you think best, maybe someone else can help.

Best regards,
Nam
