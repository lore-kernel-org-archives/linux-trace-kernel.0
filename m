Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF41991B6;
	Mon, 14 Jul 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496933; cv=none; b=r3qBWa1DNCq346oZa7RXKf7nSCe+ojISHAbaR+zNtFI39jZDw+xuIozpPviUEbQg5eW7aAOBB/2o1cxZpxFhIO+uqsSUOV1ZC2tVV9B+BJL0a0e/RRfV2qnven+ZbykwCe5Ekko/G0Rdb3nTSAr6K08Ns/yOFOk9jW9HbioaW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496933; c=relaxed/simple;
	bh=jX0VIRBmN2WhSP8dsIH0lk9rbvaVrmbXdg/Px7R6Qos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAJPHYkAyj05ceMVVE3PQJuAtYNm4d2Eyoh9XNzWcJPdCVXpgFYS/kar10eUsUXLpD49ENCxGUQAjWVuxR3yI8mbcuySWEL8AWwcNFt0rnNp0kD5Tzyo8b6Mgh2NrOAZC2UBZlv4X+6EkKV4E6f5oRnlhYl2EDBHtL7XED96fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Okjctpm/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o2/7pjTY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Okjctpm/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o2/7pjTY"
Date: Mon, 14 Jul 2025 14:42:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752496930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wz+8JvfRo3pw8Jjk2TBySr4r15xwjfmC1RYsd3p+Aw=;
	b=Okjctpm/eQcEel3Y1CWG2YwpI7+HsEd41cFpDi5HcxykX1sje39OMGFVTaudW2lLponlIK
	Z3dxq1WR2McitSP8LtCDYDFO1qate18/xzv/apdhI9Fv3D2MtNRBLLBasyq8ux9X94gGde
	pkHoQveAIkpMeYaEf0QQpUWw21rAehIuPxSQhJpkd3dO6+Ag2A7gdL91Gd/fY3C+LbvCH2
	5x2pDOQzhWE2xpvFE85MNEk71y5ELANHHXyUAAT2jHsIdi9XYrz2YskjHT96AJZOVRzIQn
	UqKJnkQd6JJOiJzVQVjMEUoZkcDKKNGAi/ODG+3LvrwlmsNlDkWoZTtjH8IiPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752496930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wz+8JvfRo3pw8Jjk2TBySr4r15xwjfmC1RYsd3p+Aw=;
	b=o2/7pjTYbJWL4Slol19iXy28xAtjiLfJdRyrYEZ/6HvSDivacjp/mHMaEqymhC6O2I9jA/
	/HIbxa27jHck9ODw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
Message-ID: <20250714124208.qVXvUVqp@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
 <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>

On Mon, Jul 14, 2025 at 02:18:05PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-07-11 at 15:17 +0200, Nam Cao wrote:
> > The 'next' operator is a unary operator. It is defined as: "next
> > time, the
> > operand must be true".
> > 
> > Support this operator. For RV monitors, "next time" means the next
> > invocation of ltl_validate().
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> Hi Nam,
> 
> thanks for the series, I did a very stupid test like this:
> 
>   RULE = always (SCHEDULING imply next SWITCH)
> 
> Despite the monitor working or not, the generator created code that
> doesn't build, specifically:
> 
> 1. It creates a variable named switch
>   - sure I could change the name, but perhaps we could prepend
> something to make sure local variables are not C keywords

Right. Maybe we can prefix them with "ltl_".

> 2. It created unused variables in ltl_start
>   - _fill_atom_values creates all variables but _fill_start uses only
> those where the .init field is true (maybe the model is wrong though)

Not sure what you mean by .init field, but yes the scripts always generate
all variables, even if they are unused. Let me change the scripts.

> Now, this specific model reports errors without the sched_switch_vain
> tracepoint which I'm introducing in another patch.
> 
> For it to work, I have to define it in such a way that scheduling
> becomes true at schedule_entry and becomes false right after the
> switch:
> 
> schedule_entry
> 	SCHEDULING=true
> 
> sched_switch
> 	SWITCH=true
> 
> schedule_exit
> 	SCHEDULING=false
> 	SWITCH=false
> 
> If I understood correctly that's intended behaviour since swapping the
> assignments in schedule_exit (or doing a pulse in sched_switch) would
> add another event when scheduling is true, which is against the next
> requirement.

Yes.

> Now I can't think of a way to rewrite the model to allow a pulse in
> sched_switch, that is /whenever scheduling turns to true, the next
> event is a switch/ instead of /any time scheduling is true, the next
> event is a switch/.
> 
> I tried something like:
>   RULE = always ((not SCHEDULING and next SCHEDULING) imply next
> SWITCH)

Be careful of operator precedence. This rule is also what I would suggest,
but you need parentheses:

    RULE = always (((not SCHEDULING) and (next SCHEDULING)) imply (next SWITCH))

because I think the parser understood your rule as:

    RULE = always ((not (SCHEDULING and next SCHEDULING)) imply (next SWITCH))

Defining an operator precedence rules is on my TODO list. Unfortunately no
theory defines this AFAIK, so it is not obvious how should they be defined.

> but the parser got the two SCHEDULING as two different atoms, so I
> guess I did something I was not supposed to do..

This is just the parser's shortcoming. Currently it thinks that they are
different variables.

> Is the next operator only meaningful for atoms that are mutually
> exclusive (e.g. RED next GREEN, if GREEN is true RED turns to false)
> and/or when playing with ltl_atom_set without triggering validations?
> 
> What am I missing here?

I hope the above already answered your questions. Let me know if anything
is unclear.

Thanks for the report, I will post some patches to address these problems
with the scripts.

Best regards,
Nam
