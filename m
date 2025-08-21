Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB627230D14;
	Thu, 21 Aug 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789328; cv=none; b=n8jsgvWKvgXKjKllK4KsU3QRprt+bN0e3ffN4GPyoc1IaOiPsmZ3TcS8/eXIeXCARiaIpiDXvGeUMxSmyV6/yAOHteYa82ZO/leaGant7NfWTsDMeinRhdkRx1u/6ktP5ZhmEEr53fnzOadge7SjVtCKQTYm5avAbX3BFBPnKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789328; c=relaxed/simple;
	bh=vuNCIW14U2DEqNlJHN+NgKUyC5263dGLiepJKDGhlP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9USsEhPAfXlA8rHqvHBVwCKlHKwbgiqlhaJG2q5wb9raB5U4VsQtGjh2lkzYqjARzGWMazBB63608TGBgqQ0L8RqlFP16mqYHcOAk6r6m3Sg0tn6ZaDrTN/koaaX+UolGl3RS/mrgqbB7UCdJ+w4bYF2WRg4BrFJCfkiZd7E5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/rTY/Vq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dQumtV7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/rTY/Vq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dQumtV7"
Date: Thu, 21 Aug 2025 17:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755789323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cw8N6hmObeXfDdp1fjFs/HmRNVaPrSP2f/odEGJMvjs=;
	b=h/rTY/Vq5t9GVKV+Y+KuojedSSnGVoLdhv6gI00pmw+rM9BqpPWJUbtUW3Pvv+WZ4BpEDO
	69QpoGl1zDYLFIukQRQl+Ngn9SWnyDbNHU5PP1M8HZYzOb+bKGJ13rvSKnKIJme73xRwXP
	hQWPl3ssayl92i0pnLHzmJ+LlSiD1m7x1IlwZ5h4J/x/FI2qCfmIQl4e62Dg32vH0H1VO5
	4Me6lcyXPIi6lTdYRP8PDbkAfhtsVsbx2vALPBkJmuxqc11ibeCTFCghvDhlPUUWVVLAd2
	o6t15nZxqDkz46OGH5MelvQEhja2sbbWFo0wq+Eg2U4up8GpmAXkC3raYLQCcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755789323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cw8N6hmObeXfDdp1fjFs/HmRNVaPrSP2f/odEGJMvjs=;
	b=1dQumtV71iy5rmH6rkaDIFYL6PfN4nqHAN0rCNAOQ+qJ3JTMKuJ8QL9UgrIjiCEFc62Ky8
	on51mp6sw2L+EnAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and events
 strings
Message-ID: <20250821151520.nc0hALIW@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-10-gmonaco@redhat.com>
 <20250821122210.B9iAsUFG@linutronix.de>
 <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com>

On Thu, Aug 21, 2025 at 03:22:23PM +0200, Gabriele Monaco wrote:
> On Thu, 2025-08-21 at 14:22 +0200, Nam Cao wrote:
> > On Thu, Aug 14, 2025 at 05:08:01PM +0200, Gabriele Monaco wrote:
> > > Currently the automata parser assumes event strings don't have any
> > > space, this stands true for event names, but can be a wrong
> > > assumption
> > > if we want to store other information in the event strings (e.g.
> > > constraints for hybrid automata).
> > > 
> > > Adapt the parser logic to allow spaces in the event strings.
> > 
> > The current parser does have a few problems. Not all valid .dot files
> > are accepted.
> > 
> > I have a patch buried somewhere which removes the custom parser and
> > instead uses a library. But then it adds a new dependency, so I'm not
> > sure if it is worth..
> 
> Yeah it isn't really robust, I tried to improve it a bit but sure
> something is still failing it.
> We don't need full dot capabilities, but just extract some keywords,
> I'd avoid pulling in a dependency for that.
> 
> I'm imagining users would either generate graphs from the
> Waters/Supremica tool [1] or copy/edit existing ones, so I'm not sure
> they can go that far.

When I tried out the DA monitor, I edited the .dot files directly.

> Still that's hacky because some things are just lightly implied by the
> code (e.g. initial/final states, edges labels, etc.), so one day we
> should at the very least say what DOT is valid and what not.

We could also rewrite the parser using ply with a well-defined grammar and
tokenizer, like how the LTL parser is implemented. Doing it this way would
be easier to validate as well, because the grammar would be mostly
copy-pasted from the specification.

> Do you have specific examples of what doesn't work?

Two things that I can remember:

  - breaking long lines

  - C-style and C++-style comments

Not really relevant if you do not edit the .dot files directly like I did.
But these things are valid according to https://graphviz.org/doc/info/lang.html

Nam
