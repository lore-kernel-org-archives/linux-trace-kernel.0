Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33328E61E;
	Wed, 16 Jul 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654437; cv=none; b=U0YG5SvGQPZrGSzCKHNBC1FnSqQg9Cc5GAqmR17f6CqHX5EcrqgwpMDVAsbkNZ4KY9yuw9f9qz0hEAFmpAGI1aqy67FrlS9TRimweQc16gn5+WBXkhrr8pW7cXA+KfRpB2f8jBmI6XkLVLdr8ACNHYavMy3qaDZyly9zNTPaXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654437; c=relaxed/simple;
	bh=4u2lay4hovL5zKYuyCR5r46djizrppNKT21L58JI2mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmt7028kdGWhew56WjUatNQ8T+q4+nxcZgg6bb97upL2g7yvQG39DgfJABY1nJpCCt+xL+R/zhFih7uKV4eVmtUg2MwDvqR8kV0xTF5dyTrAPaizCIrrNnnsuPbXy3bo/AUHN7BQ3J2SIK+1k1lcS3r3EtUrAegBwV1fCAljk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GLJO5q1/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUjFoMAi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GLJO5q1/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUjFoMAi"
Date: Wed, 16 Jul 2025 10:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752654434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNzvlBDk9taOAY9Sh/nOLKJL9wqAlXmEj8E2u0/5lI4=;
	b=GLJO5q1/uHkLhc/S8mrakS/X5wxx/6DRe0yVrQV/7Ksg5l7tBgWRRGSWZpXR99375ssSbu
	brGmlrtwan7qczA6OTD7UdmgSyq4QXoP7a4UusK79vc7rHR9t9SRMzmMUhQ0XcpPUGE5u4
	sRCdqi0aRfMGROu/2VTEzA6NfTuxQVMPWawFPpV8MB/DfQH8V3wFe4uLL5Fd45rSU8c1jJ
	oi3falJrB8HGYok9lN6RDe5uwm1jLbnMjaPaTjmmHju4GdAfxrFrsv7gyfpUAMvV2gxvTC
	+NLZC0kcWa0ziWA4NAgQr6lWr5uruytGgqtkd32guNzosm4Oyi0FaUStxPWJtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752654434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNzvlBDk9taOAY9Sh/nOLKJL9wqAlXmEj8E2u0/5lI4=;
	b=mUjFoMAi3T5Q6CQaJ2YcYkH/WtpV1LLbFgP5o8EmsqxIiQVDuGkg1VIvehBwORbzo0Wqws
	VVUYHoFoONQ0pjDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250716082712.L9z_ptHK@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-12-gmonaco@redhat.com>
 <20250715152322.Os4lDq_B@linutronix.de>
 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>

On Wed, Jul 16, 2025 at 10:20:39AM +0200, Gabriele Monaco wrote:
> On Tue, 2025-07-15 at 17:23 +0200, Nam Cao wrote:
> > If I understand correctly, if after 3 tries and we still fail to
> > change the
> > state, we will invoke the reactor and trace_error? Doesn't that cause
> > a
> > false positive? Because it is not a violation of the model, it is
> > just a
> > race making us fail to change the state.
> > 
> 
> Yes, that's correct.
> My rationale was that, at that point, the monitor is likely no longer
> in sync, so silently ignoring the situation is not really an option.
> In this case, the reaction includes an invalid current state (because
> in fact we don't know what the current state is) and tools may be able
> to understand that.

Can't you bring the monitor back to the init state, and start over again?

I think "da_mon->monitoring = 0;" does the trick?

> I know you wouldn't be able to do that in LTL..  By the way, LTL uses
> multiple statuses, so this lockless approach may not really work.

Let's worry about one thing at a time ;)

> I don't see this situation happening often: I only ever observed 2
> events able to race, 4 happening at the same time is wild, but of
> course cannot be excluded in principle for any possible monitor.
> Yet, I have the feeling a monitor where this can happen is not well
> designed and RV should point that out.
> Do you have ideas of potential monitors where more than 3 events can
> race?
> 
> Perhaps a full blown reaction is a bit aggressive in this situation, as
> the /fault/ may not be necessarily in the monitor.
> We could think of a special tracepoint or just printing.
> 
> > Same below.
> > 
> > Also, I wouldn't use goto unless necessary. Perhaps it is better to
> > put the
> > code at "out_react:" and "out_success:" into the loop. But that's
> > just my
> > personal preference, up to you.
> 
> That could be done if we do a whole different thing when retries run
> out, instead of defaulting to out_react.
> I liked to avoid excessive indentation with those goto as well but
> yeah, it may not be quite necessary.

Sure, as I said before, "just my personal preference, up to you."

Nam
