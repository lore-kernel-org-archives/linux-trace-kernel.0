Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6329B8DD;
	Mon, 25 Aug 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109605; cv=none; b=gUeNJ/hYPN8KQiWT4fS5Aq8DV0jJObYsFnn/3cEUiOmVQ1C3LCEIN89TauZiKG5B60oRmHp/sVN9xC63ZA740vuQLMEjWzyLfNdWQ2Cmz+txyJLEBPEe93G7DyYkZPtiSPgXmHvMnkZF9rymcTniS6NwibMYP0F0P2CH7ozwYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109605; c=relaxed/simple;
	bh=GKGj+zHAf9pKKfmCORpg4LcpDNqFSw8bG579p8awKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEtDAU76tNY2fVmlDtV3y9SjYH00DXLQcHPnVJDOyMSfPNB+Prmo/lPC6jip6i/SY9QmCNJyk+oHSL4NR8mONZhVzvV277ZK3pfadZ78yF/u5JamkZ6oimKbgtTfwQf6uR/dty7mhB2VV7NBo42sl61Fp8oODysyiEr9mgXGIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sV8pxECP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XgI0U9v8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sV8pxECP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XgI0U9v8"
Date: Mon, 25 Aug 2025 10:13:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756109602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94+RozVYHYhOvbwTo3+5fGuCmQswZmX4YY/OVqWHeuk=;
	b=sV8pxECPS/7vBVMpRaRop8OQas4ch8+z0VHSgSFpZTPmNlnY/Y1HYsMj6/KaSYXwPvuxbg
	PLYqoLtrb15u25MYMVAyQZI2IbJLSq0OghZyXS8etMfeWqRfKvyMAHk5Xw7189IJsg9+1Q
	Uh4wdCnnH939+iloZBbw3XuzkGB+84OcApT4uZONMOKT15Y72AtZzk5P4NUvhj1+gK9h/1
	M+Ro6HWSq+FjShYGuZIM+Ttg0o3VvPrQdXLei10hBEfq3Qyujy5HyNcrJmCRFxGgoweu1N
	hUJABaubUHV7H/Ayj1/s9yNV7TeeuLDXv77Ay7OcgDPjQzoA7eUwqpHU+MA/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756109602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94+RozVYHYhOvbwTo3+5fGuCmQswZmX4YY/OVqWHeuk=;
	b=XgI0U9v8BxLnhmTTL2FxW2t8scmA5p6/JOx7LlhjErO1HL1NtCZUT6SoBeCjqaj7d1HXLZ
	aecRwfnBDSV96UDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
Message-ID: <20250825081320.syZmsSiH@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-9-gmonaco@redhat.com>
 <20250821121846.N0S9tb6x@linutronix.de>
 <fd9dc21acd4fac68a3948ded59cf9235f0e4bb7f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9dc21acd4fac68a3948ded59cf9235f0e4bb7f.camel@redhat.com>

On Mon, Aug 25, 2025 at 09:48:23AM +0200, Gabriele Monaco wrote:
> On Thu, 2025-08-21 at 14:18 +0200, Nam Cao wrote:
> > On Thu, Aug 14, 2025 at 05:08:00PM +0200, Gabriele Monaco wrote:
> > > Deterministic automata define which events are allowed in every
> > > state,
> > > but cannot define more sophisticated constraint taking into account
> > > the
> > > system's environment (e.g. time or other states not producing
> > > events).
> > > 
> > > Add the Hybrid Automata monitor type as an extension of
> > > Deterministic
> > > automata where each state transition is validating a constraint on
> > > a finite number of environment variables.
> > > Hybrid automata can be used to implement timed automata, where the
> > > environment variables are clocks.
> > > 
> > > Also implement the necessary functionality to handle clock
> > > constraints (ns or jiffy granularity) on state and events.
> > > 
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > 
> > So you have figured out how to deal with the time problem. Cool!
> > 
> > I'm curious, instead of a new monitor type, would the entire thing be
> > simpler if these new features are added as extension to DA monitor
> > instead?
> > 
> > The existing "pure DA" monitors would just not use the constraint and
> > timer stuffs and would behave same as before.
> > 
> > Just an idea, I'm not sure how it would look like. But I think we
> > might reduce some line count.
> 
> Mmh, that might save some lines, especially the *_hooks() macros.
> The few functions that are now duplicated would end up together with a
> condition, though.
> 
> I'm however not too fond of forcing any DA user to allocate space for a
> timer. Imagine a custom kernel for an embedded device trying to squeeze
> some RV monitors in tasks and ending up requiring 64 bytes per monitor
> instead of 8.

I'm not sure if I follow. We put "union rv_task_monitor" in task_struct, so
we always require 64 bytes, regardless of the monitor type?

> If this doesn't look confusing to you, I'd prefer them separate at
> least there.

The current implementation is fine. It is just an thought that I think may
be worth considering. But I trust you know best what to do here.

Nam
