Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070B225788;
	Thu,  6 Feb 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832267; cv=none; b=O9vNockomQ4TiRfk8WZzfwCi9unAgmgpfFo+NeSLmRAKtcVqdhLBVKOl/vMLRvdSJMW6szWRTG7AYLRnOldwzluMYtpPsedSLDTz58qsNIHEwe0Le2imbKmox34WgXEbVQeb05OqeqqRFAt+YnLwj8yMnRcvOPS9a2HsK9X0IOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832267; c=relaxed/simple;
	bh=AHzmab3IVzOv4ljegaF3aCNXLSFt4v9KOiMp2XTVb7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TST5UiXkqj/2xGAuw3490LF95O9Pj/Bv0p5iX5g6g9K0e8oncE2wqQ+bFF6SsmZvvvCONq+uvupiyvXc9uM+ugdJZ45utnWYodjdqsLIbdjU5DhxMMeU2JdnIMxgkG06uocXHb8updvyOFCNTPzZqRn7H176adHcencn8z5jUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q7qwVHLz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7qwVHLz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QJF5K1Ld/qUFVxjLNweayOZydJ7o5XHCEFsT1AV7AK4=; b=Q7qwVHLzhq0fJJzbb+ZoRsBJ8j
	8G6CfBsfI3lpwnXNYPy0L+RGJ9xNUGYoyaXe3CAzB0SRwe3ZL2TN3GGbdTJ+vNkCulBrEropyB78A
	IshRUFM/6WwkLE957X7Wg3dVXsnehuhIOeKfeWnouGoo06LxHWGzWEHUoTzsHy1+cRjHZ6HQnSzxP
	E7PHczQNDnhr6NiSZmAMdf8/B6371ngDWK9CN7irj27xOyiiZ5rek5mK+Bj65YzPw1lsmUEWNSVIo
	Es78jP5IWZcjw+/C8nyrG4whhYOp8JMy9Jxha7WWE/FV+iUK2XLsnZ7ROrfX4CTjZGcfV3WwLua58
	Y54aW3TQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfxhb-0000000GtCE-2Euw;
	Thu, 06 Feb 2025 08:57:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94C6330031C; Thu,  6 Feb 2025 09:57:38 +0100 (CET)
Date: Thu, 6 Feb 2025 09:57:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250206085738.GL7145@noisy.programming.kicks-ass.net>
References: <20250206080952.98478-1-gmonaco@redhat.com>
 <20250206080952.98478-4-gmonaco@redhat.com>
 <20250206081942.GJ7145@noisy.programming.kicks-ass.net>
 <d8187fcd53c62272d7e1a8dad327c4f2a5f07188.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8187fcd53c62272d7e1a8dad327c4f2a5f07188.camel@redhat.com>

On Thu, Feb 06, 2025 at 09:36:41AM +0100, Gabriele Monaco wrote:

> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 165c90ba64ea9..fb5f8aa61ef5d 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -491,6 +491,12 @@ sched_core_dequeue(struct rq *rq, struct
> > > task_struct *p, int flags) { }
> > >  
> > >  #endif /* CONFIG_SCHED_CORE */
> > >  
> > > +void trace_set_current_state(int state_value)
> > > +{
> > > +	trace_sched_set_state_tp(current, current->__state,
> > > state_value);
> > > +}
> > > +EXPORT_SYMBOL(trace_set_current_state);
> > 
> > Urgh, why !?!
> > 
> 
> Do you mean why exporting it?
> At first I was puzzled too (this line is borrowed from Daniel), but the
> thing is: set_current_state and friends are macros called by any sort
> of code (e.g. modules), this seems the easiest way without messing up
> with the current code.
> 
> I'm not sure if it would be cleaner to just drop this function and
> define it directly in the header (including also trace/events/sched.h
> there). It felt like files including sched shouldn't know about
> tracepoints.
> 
> What do you think would be better?

So I would think having the tracepoint in-line would be better. Because
as is, everything gets to have this pointless CALL to an empty function.

If this were x86_64 only, I would suggest using static_call(), but
barring that, the static_branch() already in the tracepoint is the best
we can do.

