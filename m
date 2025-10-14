Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32319F135;
	Tue, 14 Oct 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446320; cv=none; b=ZsjnIHUfDWQcW9TV8Gq3SQvvOZ1Ow8cCLhlpOPpvbOSwy9h24fx0iMUJzCvNXees3W5+HSeV5rnCQo+A4H4d3tC9uyvci+0WcVbjieVDD4F16ms+DmY/rGm3Pe9yD16MeMoJWkiPtWNtnaW1QUG+q7Voweiu6BWjKKeN4cnSj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446320; c=relaxed/simple;
	bh=1BgVSKTIPh3PbrgvXaumugE5ruYDfbmNXsoXkbmvnMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5e12BECKuYriiPzUMQ5En47RTRhPpG98lFCQJkbYcc+Trnn5xZ+VhZ7pJkDKaqZ6MOFa16OAdKDP1Kc+TWCIXaRhNHwYRshm6SUCv9QZUFTzIuheeOfgbqiB4DOqlJNoR3B4JUSnCzdASq8/34Hi+vV0bPVt7P/IFadig71IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwkkb4Yi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m6us4LAw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwkkb4Yi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m6us4LAw"
Date: Tue, 14 Oct 2025 14:51:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760446317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsJoAKiqi88a0RwGzaTiXEJCJvOKGck4/f88vgZqoRI=;
	b=nwkkb4Yika0U5j9MNfts6f/gTvPriOETYqmsaw0LUYaMOy8x+FbzQoLNCe/HeUhyM6T/1E
	TYy12t1oRTVN4KizNQZ2yInhhCg35cR/iluUg4ezsc3ZuLBLjWKEU3Bf3yknNfI2cMhRtC
	0Fl0aZdu3t5Qgade0Z4dlKnl5Cc8ZJczI5mi8zfpBTLtfffF77Kvei+5Hpm2sJWX0Bpc8H
	pxioEI1glP3pB09EFwa3XlGvr6scBTlTz8GR64noPTekCzIIAHnBkPiAGUJ0UqHUDz8bcL
	Xp2VDHnuhGqORfKmRFfL5TAijYlljvkxND0EVpEtApbsRDy1OGzMODe+J3y91g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760446317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsJoAKiqi88a0RwGzaTiXEJCJvOKGck4/f88vgZqoRI=;
	b=m6us4LAwqVFQIs7per9EFs9EkbZ31M2t0BtQmuom5PE/WefER45zi6H3rVaG7sxglJ2ZZf
	Y2TB0iYxNkPH4TBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Message-ID: <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <87qzv6szku.fsf@yellow.woof>
 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>

On Tue, Oct 14, 2025 at 12:22:06PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 11:46 +0200, Thomas Weißschuh wrote:
> > On Tue, Oct 14, 2025 at 09:38:09AM +0200, Nam Cao wrote:
> > > The reactors are invoked in tracepoints' handlers, thus they must not
> > > trigger another tracepoint, otherwise we may be stuck in an infinite loop.
> > > (this is why preempt_enable_notrace() exists alongside preempt_enable()).

(...)

> > > I'm not familiar with the internal lockdep. But I think these would
> > > trigger trace_lock_acquire() and trace_lock_release().
> > 
> > Indeed. Right now no monitor attaches to those tracepoints. We could
> > prevent monitors from attaching to certain "well-known" tracepoints.
> > But then we still need to manually track which those are, which is ugly.
> > Or we move the invocation of the reactor to a workqueue/task_work.
> 
> I'm afraid also workqueues might open a rabbit-hole (waking up a task fights
> with locks in many scheduling tracepoints).
> At a quick glance task_works also do some IPI/wakeups that are traced.
> If I get it correctly we are looking for something absolutely lock-free/trace-
> free, I can't really think of much at the moment, maybe abusing RCU callbacks
> but those would have their set of problems too.

Agreed.

> As much as it might be interesting to write monitors on lockdep tracepoints,
> this seems challenging.

> We could opt for a foolproof Kconfig solution and prevent reactors if lockdep is
> active (leaving only the error tracepoints that are hopefully still safe).

I can't follow here. lockdep can indicate problems, but it should not introduce
problems on its own. So preventing the usage together with lockdep would be the
proverbial head in the sand. If the tracepoints called by lockdep are an issue
then we would just not call into lockdep in the first place. lockdep triggering
these tracepoints should not be an issue in practice. I don't see a bulletproof
way to prevent a tracepoint handler from calling another tracepoint, except
maybe extending lockdep to also track that.


Thomas
