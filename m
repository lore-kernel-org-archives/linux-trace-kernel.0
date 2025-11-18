Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6935580A;
	Tue, 18 Nov 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473334; cv=none; b=Nds9FU9HYKA4EimYrDRKi+uLWkP9AbSdFCYy2K8sGCjFyA/+nsNGH/Wywmb6jvd4CfLborQRiCgkBSMPFIqXiXV9Nc+ajKXJcKEXsB+xHN4f/eKIkwTvK50zQPEXU9ZbNeNiDGeIwk6qfiQGQdp6jzwxEmsfpNwheSmI1t0bXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473334; c=relaxed/simple;
	bh=Um04pVU7wsUE982wDvPeRRijkwcDQcIfgXubQOjBSMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj/pMWGvomUfT3X9Ew31eKDLZhiwcyhVsToRDuYdfpL66p18dL1jpUHFiWTMpU7l+3ewh38sJCpcwNw26g7W/s9D1i7OhPw7PHeu/99YAIV4kq/pX1x0qU3yqJ2Dah/udVZX1yAyVq2OkH9Paashg1HrqIkb4ehepzmMmJ4MA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C7E2DC0552;
	Tue, 18 Nov 2025 13:42:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 133351A;
	Tue, 18 Nov 2025 13:42:00 +0000 (UTC)
Date: Tue, 18 Nov 2025 08:42:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Douglas
 Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 1/3] tracing: Add perf events
Message-ID: <20251118084226.1e531c4b@gandalf.local.home>
In-Reply-To: <20251118083510.GI3245006@noisy.programming.kicks-ass.net>
References: <20251118002950.680329246@kernel.org>
	<20251118003531.644484343@kernel.org>
	<20251118083510.GI3245006@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 133351A
X-Stat-Signature: aeb1soab6d7rawe8asosexj7k1c1thm6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/B+CQkLgTlVRE55r//DwkLri7yWbR0H9E=
X-HE-Tag: 1763473320-650899
X-HE-Meta: U2FsdGVkX1+eDlRh1IDLMVEp5KpbMIrSr7EXuynOECOUejEx2Hy77n5rMpmWfTEaZZozla0ppcO1uUJdaq0oJ+g4Pe8/9vJWZHwj2sA4YOW8bkQhhtqu6+WIogIo11rvcpJcHvwPVxovrA2h4zFH4oomqXUlHoElCrhwbnkxYTv6cJOqdsvl2KmHuoD05gvP5CqzXUSNtJZH4joPSat6lZhUvcIf9JrcMWNXQEVSCmjhK+QGLOsfdJGckkGr9CzU00k9wxMTM2QLeQ2gryhzti1W1DwZTCu4C9RgG/lItwLWwwr9WhDPl7HPBVL36JzOUF1sXlerHTlMSaBKi6rmwtPtpAKngcW6rH34Gu8TTvsLQlWc1Hh11r4swrUMQv1E

On Tue, 18 Nov 2025 09:35:10 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > +	cpu = smp_processor_id();
> > +
> > +	e = per_cpu_ptr(events, cpu)->event;
> > +	if (!e)
> > +		return 0;
> > +
> > +	e->pmu->read(e);
> > +	return local64_read(&e->count);
> > +}  
> 
> NAK, wtf do you think its okay to use internal stuff like that? And
> wrongly while at it.

Peter, this is a PROOF-OF-CONCEPT. It means I'm showing the concept and not
the implementation. I'm hoping the NAK is on the implementation and not the
concept.

> 
> What you wanted to use was perf_event_read_local().

Great! I didn't know about that. Which is why I posted this as a
PROOF-OF-CONCEPT and not even a normal RFC, so that I could learn about the
proper way of doing this.

-- Steve
