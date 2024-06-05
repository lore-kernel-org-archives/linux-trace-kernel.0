Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD56FB0;
	Wed,  5 Jun 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597117; cv=none; b=FueftfX4pRD7SKdTqiUFEX41LKjVJp7voyqm1FNuuiMn7zwQLFAA+3U4B7Lv3wX011kMmf1q4MD6r8IHias0SwG4WXqZIHvQaa8xpGyYRLL2NGB+oaL/tsXgbAPEf1Ak+3vmBiqUIHabFSCBdkSjnL4odXYi/L4lSjAaWEn5hbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597117; c=relaxed/simple;
	bh=LbuZvRIY7fwpTBuUx3Np8cUoMVcmPLOhHPCIl8cD/q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j05q/hCXfaPiDiAsPtfYks1lg54nf6FRv62MZZ/JD/5U4xVOQ+yjmK/bviiLMFeuBZ/gp11UEGEjJRgGmW5oAHyNUjFCLKmQafFzccjZsPRTsA+m+qI2B3Vge7/7jxYcUjMeDLP0hrvrciEv3sfUA0d5qt3qdskwDKruCr1NwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42C2C32781;
	Wed,  5 Jun 2024 14:18:33 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:18:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] ftrace: Comment __ftrace_hash_rec_update() and make
 filter_hash bool
Message-ID: <20240605101832.09fb4211@gandalf.local.home>
In-Reply-To: <ZmA6ygUWNPkq0PKV@J2N7QTR9R3>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.725383717@goodmis.org>
	<ZmA6ygUWNPkq0PKV@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 11:15:38 +0100
Mark Rutland <mark.rutland@arm.com> wrote:
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 9dcdefe9d1aa..93c7c5fd4249 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1701,8 +1701,20 @@ static bool skip_record(struct dyn_ftrace *rec)
> >  		!(rec->flags & FTRACE_FL_ENABLED);
> >  }
> >  
> > +/*
> > + * This is the main engine to the ftrace updates.
> > + *
> > + * It will iterate through all the available ftrace functions
> > + * (the ones that ftrace can have callbacks to) and set the flags
> > + * to the associated dyn_ftrace records.  
> 
> I beleive s/to/in/ here, to make this one of:
> 
> 	set the flags in the associated dyn_ftrace records.
> 
> ... rather than:
> 
> 	set the flags to the associated dyn_ftrace records.

Thanks. It's good to get a "native English speaker" response ;-)

> 
> > + *
> > + * @filter_hash: True if for the filter hash is udpated, false for the
> > + *               notrace hash  
> 
> Typo: s/udpated/updated/
> 
> ... though I couldn't parse this regardless; maybe:
> 
> 	@filter_hash: true to update the filter hash, false to update
> 		      the notrace hash

Sure.

-- Steve

> 
> Mark.
> 
> > + * @inc: True to add this hash, false to remove it (increment the
> > + *       recorder counters or decrement them).
> > + */
> >  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> > -				     int filter_hash,
> > +				     bool filter_hash,
> >  				     bool inc)
> >  {
> >  	struct ftrace_hash *hash;
> > -- 
> > 2.43.0
> > 
> >   

