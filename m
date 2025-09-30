Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E252628D;
	Tue, 30 Sep 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241918; cv=none; b=CBhCW3TeVMio1YtRaOqXIKw+XueitCNszGxgTSz4AHvZGd9VLv8ZGQl9SswKJpEgzx1FYFcYaCfo539s17mM3egAbS0I95yEI98qVRdmCbwPzNeuqTFcFxJcsWJ9C9KjMdghOCOkLiKu3SbO0p8/s/DXA8q1rttsDU6mIRto9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241918; c=relaxed/simple;
	bh=/Z9vHgFitGnywr0evX36Ur856Ith0O06Y1XN/TLpmFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG3RErY8zqPgURg78E2LCSRqqw/cB7WW4BmbC3JzHTb43iu0skV/DA76Ak+VSq+jjBzqxoEr1qv5mvOz1+5U/UXN/wcg4rb9z2DCgk0TyrJneYKE5zL75jbOWOAZfP5byXN7Y4q9PSx3y2W7hLJGGd3oRPTZ/HnoeYRjkbqicIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCTMaLnt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9YuYWYc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCTMaLnt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9YuYWYc"
Date: Tue, 30 Sep 2025 16:18:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759241914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUa3P5BA7Ar6Emm+p460eFkGleUa0VHRFnVxjlOnyUU=;
	b=hCTMaLntdwlggOSyv9hkSECLvqBMw10QA9tj1urT5JtfSD5e1Zp0WHkWDXkDEM8wfjStlZ
	0O7ekQeT/PwmtEvrfbngfoX3CHcqwfSxtwEVxVT9EvCFSmp8JIFA0kSUABT/wMYZJRhVu8
	B3Cag+ffToUw6j6MxyKU1FYdXQAvr/2c1PEeQpfvuwK1MsDPQxqssZpqxvI5nPUJFVBjNp
	DD4eCdATiyHRcWka+QiGQob+OkI/yT1xrQcjrPFQxZ30V+X9PBo69iZtRGk5j7dXHbfmZX
	9NclbWHngx3avhu1KNe3nQijnZAb2o5UCS6FcIKNunkPlE6SbhPTas863ehtPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759241914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUa3P5BA7Ar6Emm+p460eFkGleUa0VHRFnVxjlOnyUU=;
	b=O9YuYWYcW/AwG7x6bM5tYChRYRjSPkkgFuA29+zfYUfMTG82dbT5DG501xc0ia70CXzl2e
	Yj5rebxnQPkiZ7Bw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
Message-ID: <20250930161252-ea116bda-293e-4f81-ab0f-075dd03dee52@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
 <20250922162900.eNwI7CS0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922162900.eNwI7CS0@linutronix.de>

On Mon, Sep 22, 2025 at 06:29:00PM +0200, Nam Cao wrote:
> On Fri, Sep 19, 2025 at 02:26:12PM +0200, Gabriele Monaco wrote:
> > On Fri, 2025-09-19 at 12:49 +0200, Thomas Weißschuh wrote:

(...)

> > > For now only SIGBUS is supported, but additional signals can be added.
> > 
> > Curious choice of a default signal, is this specific to your use-case?
> 
> Any signal should do. Looking through the signal list, I think SIGTRAP is
> more appropriate.

Indeed. Thanks for the hint.

> > > +config RV_REACT_SIGNAL
> > > +	bool "Signal reactor"
> > > +	depends on RV_REACTORS
> > > +	default y
> > > +	help
> > > +	  Enables the signal reactor. The signal reactors sends a signal to
> > > the
> > > +	  task triggering an exception.
> > 
> > This assumption is not always correct, imagine a failure in the sleep monitor
> > caused by the wakeup event. The offending task is not current but the wakee.
> > 
> > This is a bit tricky because reactors don't have access to that task, just to
> > keep the same implementation between per-cpu and per-task monitors.
> 
> Yeah, this one is tricky. We probably need to pass the correct task_struct
> to reactor, but then I'm not sure how to handle the other monitor types,
> e.g. per-cpu monitors.
> 
> I have no alternative to offer, let me give it some thought.

Thanks.

> > > +static void rv_signal_force_sig(int signal, const char *message)
> > > +{
> > > +	/* The message already contains a subsystem prefix, so use raw
> > > printk() */
> > > +	printk(KERN_WARNING "%s", message);
> > > +	pr_warn("Killing PID %d with signal %d", task_pid_nr(current),
> > > signal);
> 
> RV reactors have to use printk_deferred() instead. See:
> https://lore.kernel.org/lkml/874k50hqmj.fsf@jogness.linutronix.de/

When the direct-call path is removed, this will only be used through task_work.
For that direct printk() should be fine, right?

> But I suggest dropping the printk from this reactor. We already have a
> printk reactor for that.

Works for me.

(...)

> > Why do you use the task_work at all instead of signalling directly?
> > If that's something not safe from a (any) tracepoint because it can sleep
> 
> If I remember correctly, sending signals requires a spinlock and therefore
> may sleep on PREEMPT_RT.
> 
> > you should definitely not call it if allocation fails.
> 
> Yep.
> 
> We probably can get away with not reacting at all if allocation fails, by
> crafting our tests such that only one reaction happens at a time, and
> allocation won't fail.

It would be nice if the reactor works without having to worry about its
implementation in the testcases or even general users. In 6.18 we will get
kmalloc_nolock() which is meant to be usable from tracepoint context. My
plan is to use that for the next revision.


Thomas
