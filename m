Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B5368D5A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583164; cv=none; b=snrlM/4RYjfzrstiLmpSVBWHMZerfoa4fs6xyF2tesK8LZNxNHPS0SoL/2d8p7Epd33kQoi4RNWKzkmCOMB1FbbEQ+g/7Kx0t/kH8Ox9Y24WMWZj00VaZ1fbV4uYpoAb7m05nJduuF3GE3Y5vzts+QH/JqFWuYEDjez4iE6Bics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583164; c=relaxed/simple;
	bh=ZadEfTE72Hm8xcU5BCykhs0FuqiuE2IgPjt0h/XQBQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i60WS+5zvOIqPX4+2sl3k4VK2zdqIFgS1LHAt7iok5KnxGZMum0NnknDSlMn1x8yEqIbZL0sWouniDJ2FImBj6pIRZj0N9wlS7NtnTq5SgPYiRj+Nm3IpkdiOqOk4Y9ulOHSuFOqHbdsrNBZ9GUG2/ITlqXrDd/kNn4OumpWJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=yWo/8Xxw; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="yWo/8Xxw"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6E5071C07D8;
	Mon, 24 Aug 2026 14:52:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id B9D1A2002D;
	Mon, 24 Aug 2026 14:52:34 +0000 (UTC)
Date: Mon, 24 Aug 2026 10:53:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260824105315.27377f30@gandalf.local.home>
In-Reply-To: <aotTYT0zE5LNik06@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
	<20260817134750.3909384-2-vdonnefort@google.com>
	<20260817140812.2C7D41F00A3A@smtp.kernel.org>
	<20260822110424.346fa3c8@fedora>
	<aotTYT0zE5LNik06@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: e5tc3bkaiowkpqzdz5gnhxbtfseshmcd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B9D1A2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/eylMScIhR765Li2a10rJVedUHRIwdZaQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vOd8c7BmRwEiEKUIYJzJgREfWmSHPR9AonH9AZylYiw=; b=yWo/8XxwugqlgwM0BDCtT09ewr9MNBNFWiPFOCi/Ors9qoxbC2alAgwnsAuZU0MoZnz3xIbKmNT3w10BAdEX6UmuFNjkR0Nli2WJKqypA60AloKOupM9E2IFEm+1vGX/k86u4m2HGl/EqelltWsvyN3rEVgjB+ciKIx5ilkrGas=
X-HE-Tag: 1787583154-103029
X-HE-Meta: U2FsdGVkX18XtVLFYz5MuXxlt72tk4/PryeJdtL3vXlS+B3+Wj7Zu5ujq7YBPHf/sDTsx3Lb+jXld1Vg/3P3Kchq/l5JWDS7O0D4ZdRHBQWigEDo/iqm7wz4GTW3dlWWgy3NbI3B7BbGrZ8P9+xIb9g+oZItA51Vm9KO01bV3wD+VjCsrfZjqf9gEbxckmrmOtvr3Njm1orxb2PXRKfN2C5YpEjW64y9uPGEp6u5ERPfMFskDbS8ZrD1unm4P5BCz/nETRN8AcByRQsVswU/oEl1mXU7HZd1d3zqXXui6AEjqQdMjPzncGQPX+Ig1MCJvZDfRZ4h1ik0rXTkzF7m4ssj8MrjZcYd

On Sun, 23 Aug 2026 21:09:05 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > [Severity: High]
> > > If ring_buffer_read_page() returns -EAGAIN because the subbuffer order was
> > > updated but cpu_buffer->reader_page->order hasn't been updated yet, this
> > > branches back to the again label.
> > > 
> > > Since the loop does not yield the CPU or call cond_resched(), could this cause
> > > a hard lockup if the reader and the resize thread are on the same CPU?  
> > 
> > Hmm, this looks legit. We should at least have a way to break out if it
> > loops too many times.  
> 
> Can this happen only on !CONFIG_PREEMPT systems?

It can happen with RT tasks as they don't yield. If this task is of higher
priority than the one resizing, then it will loop forever even with a
cond_resched().

> 
> I can add a cond_resched() here though, I believe that would make sense: if an
> order modification is pending, writing is disabled anyway and we are about to
> loose the stored events.

For RT tasks, cond_resched() wouldn't be enough.

> 
> Additionally I can reduce the window where buffer::subbuf_order differs from the
> reader page order by adding an "order" argument to __rb_allocate_pages() and
> only set buffer::subbuf_order later in ring_buffer_subbuf_order_set().

I'm wondering if we even care if data_page->order != cpu_buffer->reader_page->order
and should change it to being a force copy instead.

If the reader_page is bigger than the dpage, and only copy what the dpage
can hold. It would also update the read value of the reader_page which
would allow another copy to get the rest. If the data page is bigger, then
just copy everything.

It's not like this will happen often.

-- Steve
