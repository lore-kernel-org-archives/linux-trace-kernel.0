Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03975478E5E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632052; cv=none; b=BVBtP1fWGTNmXS3F0yrxyt0Atj4PfXCz/xkUfeAZeXG7kY7UqbWXgImRMgm4x8SJEV1d1d0RkcBtyqaugXOAFRNqXgyyCzM1CmxwaYrTp3xe2lrRXOATW5LLVL9CUei6JCfoC0tHBl4MWV4s2/k3IewoCByP2a3/W0T/j/NzuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632052; c=relaxed/simple;
	bh=rUcO2gzRvKvE6eMggLtIX7U6PuOVcdx00WgIf0BsLgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXxDAsQqQIA/aGRDdHhidGRO8hU9FS3ZiD75DtCk7NqpYPNwHOn0IbVtBAzDsFP+WfJ5NRnFPcczxWTHFwL6tYOGrc0Ws1BEomFH5/gwOQ3rXLX6NkUhYsuA1VzURN97iOwZhOD4JKK82snDsgGLw7uyG6x1tx1KLBr7vB7jJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p2MQ/rOo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jteyQ4uj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2MQ/rOo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jteyQ4uj"
Date: Thu, 13 Aug 2026 16:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786632048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfPGh9RfMdDRiyeR2IpHJiREzHBOJQ2IiBHfFF080Hk=;
	b=p2MQ/rOoOeA5aPGQUDTyZ1TDchSOD9VK9HMsd2JEQICh/b/qDkqhsB5MWiA6Rbvp4PmQQZ
	tCUw33HjD0IYJohdAmVTk7Zpi4eDs33uh19eig0jzi9JG+zwgidEFCoKNhhiuPWvAhqxku
	/Y8KJnQTPgYBWKmtmDW6H/cCu4fymsYNmwGWXzo1ubZqXSMflnDjpcaErdzgX7YfbmQX32
	fL4y45YDZDL+PfjQcGRc0ShJdmQFjliGGZnA41FYQylvsTx4NijdegnskwM9/O8fYAV6na
	/jZfg+C0GUf6avUBjf0oL1U3HKlpNnWcl/VA4rbPO+Urvgb116d7z2DR6kxeGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786632048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfPGh9RfMdDRiyeR2IpHJiREzHBOJQ2IiBHfFF080Hk=;
	b=jteyQ4ujyXRdT118fq8U//LLP5vPrzDkBUTrQNkJ10+mLH1uuWzxwgBw5AkpjUUCxSfxgf
	n/XTu7Ov/RBZDMCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Message-ID: <20260813164014-bb2d92fc-631f-4e0d-b940-2f2c63859563@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
 <20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
 <20260813141501.347E21F000E9@smtp.kernel.org>
 <20260813103821.36d6b6f7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813103821.36d6b6f7@gandalf.local.home>

On Thu, Aug 13, 2026 at 10:38:21AM -0400, Steven Rostedt wrote:
> On Thu, 13 Aug 2026 14:15:00 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Invalid free (causing kernel panic) and memory leak due to `strsep()` modifying a pointer managed by `__free(kfree)`.
> > --
> > 
> > --- Patch [3]: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in ftrace_set_clr_event() ---
> > commit c968a27c39638474537de841b7e2191407463142
> > Author: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > tracing: Stop modifying the input buffer in ftrace_set_clr_event()
> > 
> > This commit changes ftrace_set_clr_event() to copy its input buffer using
> > kstrdup() and manage it with __free(kfree). This removes the need to
> > restore the original buffer modifications before returning.
> > 
> > > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > > index 6aa32c4922807..c75a7f5b55def 100644
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c
> > > @@ -1411,14 +1411,17 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
> > >  	return ret;
> > >  }
> > >  
> > > -int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> > > +int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
> > >  {
> > >  	char *event = NULL, *sub = NULL, *match, *mod;
> > >  
> > >  	if (!tr)
> > >  		return -ENOENT;
> > >  
> > > +	char *buf __free(kfree) = kstrdup(_buf, GFP_KERNEL);
> > > +	if (!buf)
> > > +		return -ENOMEM;
> > > +  
> > 
> > [Severity: High]
> > Will this lead to an invalid free or memory leak when buf is later modified? 
> > 
> > Further down in ftrace_set_clr_event(), buf is passed to strsep(), which
> > modifies the pointer in place:
> > 
> >     match = strsep(&buf, ":");
> > 
> > If strsep() advances the pointer to the next token, the cleanup function
> > will call kfree() on an interior pointer, causing a slab corruption bug or
> > kernel panic upon scope exit. If buf is advanced to NULL (when no colon is
> > found), it will result in a memory leak of the duplicated string since
> > kfree(NULL) is a no-op.
> > 
> > Could a separate pointer be used to track the allocation for cleanup,
> > leaving buf free to be safely advanced by strsep()?
> 
> Yes, this is a legitimate bug.
> 
> I guess you need to have:
> 
> int ftrace_set_clr_event(struct trace_array *tr, const char *buffer, int set)
> {
> 	char *event = NULL, *sub = NULL, *match, *mod;
> 	char *buf;
> 	int ret;
> 
> 	if (!tr)
> 		return -ENOENT;
> 
> 	char *_buf __free(kfree) = kstrdup(_buf, GFP_KERNEL);
> 	if (!_buf)
> 		return -ENOMEM;
> 
> 	/* Need to keep _buf pointing to the start of the buffer */
> 	buf = _buf;

Agreed.

I'll deal with the Sashiko fallout if you are fine with the general idea.


Thomas
