Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829B3A8F7;
	Tue, 14 Oct 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435182; cv=none; b=pV8MMvmCcMJG+mwPKWJ1OK9ASl4//ISZJ8NnerrSTPLMScnMVTJVMzl5DbOO5Z6cMAtniW0rotBpzvPfQ8VQzOz+lHW7XYDdQqq9c3kdiNBfFZC52jrsAn0FbsOlk5alILj/iD0YENFI54lKoHZ7mfcDMJlGBunTxzAmk3Pxq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435182; c=relaxed/simple;
	bh=IufsyS4GLLScR2QymDt9bCQiIAl3I9+1PtswPVeRMGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5ojnbhlWys/3WYx1sXxNFzq5b1krY60iLf14etYhRGnCfvdn7v7y/XTFkzsn7nqaMUQGo7l5ZdePNimy3BBvQz0fT8qcMBwfFwTc03Of5PzSsIqKYRwvaWYHxcAzx96VX9+bNTufx8w98ePWLWXPAzWxqhMQcz1kKywaSbrp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJvfJbrj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BweEd6IU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJvfJbrj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BweEd6IU"
Date: Tue, 14 Oct 2025 11:46:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760435177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H5zZwMog26iT6I5oJeIziIQ1r8hDgfpoI95hkN0uHM=;
	b=OJvfJbrjjL23VixMQjifyKBCpc7M3iM/qkNexCUiuZTianYZHVzv3w7mirCu11daXLNfUT
	DLAR3l3hH0WqPgsVjEL3q4xR+UU7XgZdNdykbEvjlsB6gVTFWY3IQ79NNmdD9iJIiOs/AG
	qvwg4ibJ4/rnoQmeVLwMA5lhWOOQltcv1TjN8lrFMGwpl8m+oceL95uUg4OX+TrzT5nljo
	uN+lWZyhxA0iCIi6k8s3qnHiVnAQAo1LAEEjW67m/x+1lqcJuM5Fwq/IyvT1QdMflJrkv5
	LYeMhsQ9IGSF/lpPUUMnA5KMYVLcIQYhYEcmHiqTHrJldTE4zkix5/V8DUKErA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760435177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H5zZwMog26iT6I5oJeIziIQ1r8hDgfpoI95hkN0uHM=;
	b=BweEd6IUkTER/584EIl5vH5Fp1q+qheZ0njRGRB5LULWlNuhZAwqJiuXxVTYxJ5Pzfdm3H
	l93eYbyzPoomqlDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Message-ID: <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <87qzv6szku.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzv6szku.fsf@yellow.woof>

On Tue, Oct 14, 2025 at 09:38:09AM +0200, Nam Cao wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> > Reactors can be called from any context through tracepoints.
> > When developing reactors care needs to be taken to only call APIs which
> > are safe. As the tracepoints used during testing may not actually be
> > called from restrictive contexts lockdep may not be helpful.
> >
> > Add explicit overrides to help lockdep find invalid code patterns.
> >
> > The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
> > reactor. These are indeed valid warnings but they are out of scope for
> > RV and will instead be fixed by the printk subsystem.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> ...
> >  void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> >  {
> > +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> >  	va_list args;
> >  
> >  	if (!rv_reacting_on() || !monitor->react)
> > @@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> >  
> >  	va_start(args, msg);
> >  
> > +	lock_map_acquire_try(&rv_react_map);
> >  	monitor->react(msg, args);
> > +	lock_map_release(&rv_react_map);
> >  
> >  	va_end(args);
> >  }
> 
> The reactors are invoked in tracepoints' handlers, thus they must not
> trigger another tracepoint, otherwise we may be stuck in an infinite loop.
> (this is why preempt_enable_notrace() exists alongside preempt_enable()).

Sounds reasonable. However today not even the printk reactor satisfies this
rule as it transitively calls trace_console().

> I'm not familiar with the internal lockdep. But I think these would
> trigger trace_lock_acquire() and trace_lock_release().

Indeed. Right now no monitor attaches to those tracepoints. We could
prevent monitors from attaching to certain "well-known" tracepoints.
But then we still need to manually track which those are, which is ugly.
Or we move the invocation of the reactor to a workqueue/task_work.


Thomas
