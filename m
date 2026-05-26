Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F340DFA0;
	Tue, 26 May 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817246; cv=none; b=Hj++ECenN23eHXPipBvkVaPt3I+mQUVRs7SwVdYrjH25SkDxlIYk+TKMRRG6FnKuzkPaky1i6waAwJIXgJSDpGoC2McTtXteiQoOzkCmzmlh7DoFJdurBP/Kpvmqbh7bOsRyZvT4NZE014EXSQQstCeKFV1k1eoWtitO2Rs5AwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817246; c=relaxed/simple;
	bh=estDhWcGSNvWw0CfereXPiU+gAQ0jdi0QcmD3BCVEVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5DKH5eKRIs2NmV8E9ugoJmhFl+YiteZDSsjmLwH1XViwYoKD5hKRfwE3wQR4aKlmaRiEoY9FkPvp8sH0E5jxLFK1KszhvKCHx1MIuZMyGLWHbrBr4KAtfn+zJL6Gc9Fa9sgXhwm4HQAaJZYgdDZTBWnWgyMXZqekRB22L9MTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDQE5MVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDQE5MVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8FA1F00A3A;
	Tue, 26 May 2026 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817245;
	bh=bZaIbbOaxejlxa0oIX5seZRzSdaJUz/jVQrzCN9FnTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZDQE5MVsgzWoBTV38BTgMOt/k1g7UYKZIoKE1z5cRFDZ3LyPtpwDvjUOm5icYmJSe
	 bs9O6ZWt81R5BwzvBbacG2JLlt1JTgj7/dmL7ngSRvsDUZAFI+zNxxzYrI+sLAwiK3
	 EJZmwE3H+vb8jZBRqyGolKN5NgOapVekTFYe0xBGoU0KbjjSC6BQ3NrT+HmsM9zm14
	 I/JyDYOGRFE2M/ReaDQ4BZjBPqg6GFaOkaA3IP+x0UNh8Qw/woxV8yrn8DIkcmlpYx
	 FB5i7G/UkTo8iWUuthefoAP5UQ/Dgj6wwgZVZ3VK8sNat+OswIxywoL92b1lnj6rZH
	 DmHYh0vxlfsiQ==
Date: Tue, 26 May 2026 13:41:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-ID: <20260526134116.11e1db99@gandalf.local.home>
In-Reply-To: <20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
	<20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:06:09 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > @@ -7204,10 +7209,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  	 * Set a flag in the commit field if we lost events
> >  	 */
> >  	if (missed_events) {
> > -		/* If there is room at the end of the page to save the
> > +		/*
> > +		 * If there is room at the end of the page to save the
> >  		 * missed events, then record it there.
> >  		 */
> > -		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > +		if (missed_events > 0 &&
> > +		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
> >  			memcpy(&dpage->data[commit], &missed_events,
> >  			       sizeof(missed_events));
> >  			local_add(RB_MISSED_STORED, &dpage->commit);  
> 
> After this line, we "add" RB_MISSED_EVENTS instead of set.
> In this case, does it clear the RB_MISSED_EVENTS bit because
> it already sets RB_MISSED_EVENTS.
> 
> 			commit += sizeof(missed_events);
> 		}
> 		local_add(RB_MISSED_EVENTS, &bpage->commit);
>                       ^^^ here.

Perhaps this needs to be commented better.

The answer to your question is "No". The reason is that this is a *copy* of
the page we are reading. As persistent pages are always assigned to
specific memory, it can never leave the buffer even for the splice system
call. It is always copied to a new page.

The new page doesn't have these bits set and needs to set them depending on
what was found when reading the page from the buffer.

Now if this was a normal ring buffer where it did a zero copy from the
buffer itself by swapping pages with the passed in page, if the bit was set
before, then adding would cause a problem. But normal ring buffer pages
never set these bits while in the buffer. They are only set by this function.

-- Steve
