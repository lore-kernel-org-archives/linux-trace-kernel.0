Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB23112C3;
	Mon, 22 Sep 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558545; cv=none; b=aCsC5Uanwnk2dbov86KFUdCWiiH9OZwJrOKpk1LPWeteS+1RNn3y30IHGwuseZugyjI5F7skW6kwWjMrdWGQqEVvgIVPDebMhFsUKGIGXk0nyIEydi31pCXjztAyL7PfZKDTRGAjcV0/L9/0Rar4IiyeRvSsXIHbg5V199MjG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558545; c=relaxed/simple;
	bh=mgvFeTK4TM6IjKYriZlHqMRbdNwTUYyVt1ns/bRTkKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njc1h45AHwgwsV+3tkVNHWbjf9aTrNNi7yY1b3rlHL4Pk80cXbNId3H1dLM07WNN5uF1lJ7JGYBwjx2u1xYr8+M9lqZESu5rc211lvTwxyVvEcjVULtDy81q+NgW7gUC0L6CEUm/XQ4WuQQLHIHE6c/DGiHtgfHYzsUpckFdBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFEyKmdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4AjFpTsP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFEyKmdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4AjFpTsP"
Date: Mon, 22 Sep 2025 18:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758558541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHg8+HkamnZm01xX5vs4eWwYS7Rr0huD8EUHR5N18h4=;
	b=PFEyKmdWC2NlEKsvPKX7SE7QqKwBDa8zpu0rOZ1YnK6l07ZT+4L006gl2TQIsckGMoMlLP
	yO6S4hTReLkOSEOAaCssTUuffpiFIHz6eS9+fLvOYdcqo7kMW1PkLSKtZl6h1B0grHOMlg
	IhN6GLySvlK+NYbGFI2kjmJSdY83D4ileLV5+5l23DHqQFSUyZV1s9AXBkYd1b/SdLEjcU
	3p+Jww1nH70MgMcxarjm3cLMowQLlebf032UfXMEb5CTmQ4VNuNBl57kWJ1bh3AB3APJd7
	h9GduoOI7dLW6cLQiy2o0UCosFns+TaBNrS+7oH4yQ3lK6ASjL9CaxBQtyM2Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758558541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHg8+HkamnZm01xX5vs4eWwYS7Rr0huD8EUHR5N18h4=;
	b=4AjFpTsPKHirZXXkhZ2ilwCaFUppb2w3q/cVmRWIh2ZWnU4ASROoxnspSBbH76hyx/0Iyg
	ROaDnu0WcxaUrDDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
Message-ID: <20250922162900.eNwI7CS0@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>

On Fri, Sep 19, 2025 at 02:26:12PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-09-19 at 12:49 +0200, Thomas Weißschuh wrote:
> > Reactions of the existing reactors are not easily detectable from programs
> > and also not easily attributable to the triggering task.
> > This makes it hard to test the monitors themselves programmatically.
> > 
> > The signal reactors allows applications to validate the correct operations
> > of monitors either by installing custom signal handlers or by forking a
> > child and waiting for the expected exit code.
> 
> Thanks, this looks like a really nice addition!

Yeah, this will help us write KUnit or kselftest for the rtapp monitor.

> > For now only SIGBUS is supported, but additional signals can be added.
> 
> Curious choice of a default signal, is this specific to your use-case?

Any signal should do. Looking through the signal list, I think SIGTRAP is
more appropriate.

> > +config RV_REACT_SIGNAL
> > +	bool "Signal reactor"
> > +	depends on RV_REACTORS
> > +	default y
> > +	help
> > +	  Enables the signal reactor. The signal reactors sends a signal to
> > the
> > +	  task triggering an exception.
> 
> This assumption is not always correct, imagine a failure in the sleep monitor
> caused by the wakeup event. The offending task is not current but the wakee.
> 
> This is a bit tricky because reactors don't have access to that task, just to
> keep the same implementation between per-cpu and per-task monitors.

Yeah, this one is tricky. We probably need to pass the correct task_struct
to reactor, but then I'm not sure how to handle the other monitor types,
e.g. per-cpu monitors.

I have no alternative to offer, let me give it some thought.

> > +static void rv_signal_force_sig(int signal, const char *message)
> > +{
> > +	/* The message already contains a subsystem prefix, so use raw
> > printk() */
> > +	printk(KERN_WARNING "%s", message);
> > +	pr_warn("Killing PID %d with signal %d", task_pid_nr(current),
> > signal);

RV reactors have to use printk_deferred() instead. See:
https://lore.kernel.org/lkml/874k50hqmj.fsf@jogness.linutronix.de/

But I suggest dropping the printk from this reactor. We already have a
printk reactor for that.

> > +	force_sig(signal);
> > +}
> > +
> > +static void rv_signal_task_work(struct callback_head *cbh)
> > +{
> > +	struct rv_signal_work *work = container_of_const(cbh, struct
> > rv_signal_work, twork);
> > +
> > +	rv_signal_force_sig(work->signal, work->message);
> > +
> > +	mempool_free(work, rv_signal_task_work_pool);
> > +}
> > +
> > +static void rv_reaction_signal(int signal, const char *fmt, va_list args)
> > +{
> > +	struct rv_signal_work *work;
> > +	char message[256];
> > +
> > +	work = mempool_alloc_preallocated(rv_signal_task_work_pool);
> > +	if (!work) {
> > +		pr_warn_ratelimited("Unable to signal through task_work,
> > sending directly\n");
> > +		vsnprintf(message, sizeof(message), fmt, args);
> > +		rv_signal_force_sig(signal, message);
> > +		return;
> > +	}
> 
> Why do you use the task_work at all instead of signalling directly?
> If that's something not safe from a (any) tracepoint because it can sleep

If I remember correctly, sending signals requires a spinlock and therefore
may sleep on PREEMPT_RT.

> you should definitely not call it if allocation fails.

Yep.

We probably can get away with not reacting at all if allocation fails, by
crafting our tests such that only one reaction happens at a time, and
allocation won't fail.

Nam
