Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E863A9;
	Sun,  5 Jan 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067461; cv=none; b=UjW3SFpqm1hdgmco2RihPpSy71+p8aSAjw5vOKUnoLPCwpxz/alFF/zPELdSGqsvuXJyDxoEVNBw64MFhKubGpsBLDBfiHwVIgIEtaKkI9BuADU2ZYSQCrPjtMCW2OB6pn1WWx2AYUtQW8Q0dEyCS6iqp7P56DBEYMA1Not7Hsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067461; c=relaxed/simple;
	bh=LpD6HGGTufDOkQdJIVQStAXH3mQoOFBySV27TRmSk9A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H5q1ycjugwLf4rdtN2itIccLDtB1mfqYEb/W9afzJlYzxpbVoxK9g0pkMLA6jB1Xb4V7aKmJEFsxG1ma8eK2q9qWhKdtMUOuqjebilxqi7BOWrBRagPi697a02FKoE7qMgTV5MeJ0dTx/cmR3pwpFctfM63/U5quhgs5TBX31nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxfDY0q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxfDY0q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A457EC4CED0;
	Sun,  5 Jan 2025 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736067460;
	bh=LpD6HGGTufDOkQdJIVQStAXH3mQoOFBySV27TRmSk9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxfDY0q8uVjJ51LIpscrI9k+fRJWQV8Bl0Mw0/RuNHzMxWbHYVH2hYxa/mfsHDtYP
	 Kv5AyCK6/1ARncor6m0UDBOHu4Gp2QmIIWjFh0H4as8AIB/syxqsfIafUnQfD1PXk/
	 z3ZNBXI6UF6+N0TOgcAhfMhULqCe4gk7FDhKB5Ky5lBgPOPKStXkHNAoxmWzaeb/m0
	 Wk4tBc8CxxKeqqqb69lAEDkKx9IW4JlbNN59xmVmOiBIohePHAatWQDrGJan4wvDC2
	 Zf69Tqg7Buf6X1edUaz21rwiamgdHTrr7R2HcPrGtjExDgTnN972/fXJkSaAusFIgj
	 Q191T/hEwGAbQ==
Date: Sun, 5 Jan 2025 17:57:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Naveen N Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] tracing/dynevent: Adopt guard() and
 scoped_guard()
Message-Id: <20250105175736.bc0f4568f5e64ea5608ab50d@kernel.org>
In-Reply-To: <20241227101218.5948129c@gandalf.local.home>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
	<173289891992.73724.9491350426847416169.stgit@devnote2>
	<20241227101218.5948129c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 10:12:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 30 Nov 2024 01:48:40 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use guard() or scoped_guard() in dynamic events for critical sections
> > rather than discrete lock/unlock pairs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Use scoped_guard() instead of guard() to avoid goto warnings.
> 
> I forgot you touched this file, and added a free guard to it which
> conflicts. That said, I have some issues with this patch.
> 
> > ---
> >  kernel/trace/trace_dynevent.c |   35 ++++++++++++++++-------------------
> >  1 file changed, 16 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> > index 4376887e0d8a..eb8f669c15e1 100644
> > --- a/kernel/trace/trace_dynevent.c
> > +++ b/kernel/trace/trace_dynevent.c
> > @@ -63,9 +63,8 @@ int dyn_event_register(struct dyn_event_operations *ops)
> >  		return -EINVAL;
> >  
> >  	INIT_LIST_HEAD(&ops->list);
> > -	mutex_lock(&dyn_event_ops_mutex);
> > +	guard(mutex)(&dyn_event_ops_mutex);
> >  	list_add_tail(&ops->list, &dyn_event_ops_list);
> > -	mutex_unlock(&dyn_event_ops_mutex);
> 
> I don't care for a scoped guards around simple paths. The great thing about
> guard()s is that they help prevent bugs when you have complex code between
> the lock and unlock that may need to exit.
> 
> But replacing:
> 
> 
> 	mutex_lock(&dyn_event_ops_mutex);
>  	list_add_tail(&ops->list, &dyn_event_ops_list);
> 	mutex_unlock(&dyn_event_ops_mutex);
>  }
> 
> 
> With:
> 
> 	guard(mutex)(&dyn_event_ops_mutex);
>  	list_add_tail(&ops->list, &dyn_event_ops_list);
>  }
> 
> is overkill to me. The first one is much easier to read. The second one
> begs the question, "why did they use a guard here?"

OK. fair enough. I think I was getting a little too excited. :(

> 
> >  	return 0;
> >  }
> >  
> > @@ -106,20 +105,20 @@ int dyn_event_release(const char *raw_command,
> > struct dyn_event_operations *type goto out;
> >  	}
> >  
> > -	mutex_lock(&event_mutex);
> > -	for_each_dyn_event_safe(pos, n) {
> > -		if (type && type != pos->ops)
> > -			continue;
> > -		if (!pos->ops->match(system, event,
> > -				argc - 1, (const char **)argv + 1, pos))
> > -			continue;
> > -
> > -		ret = pos->ops->free(pos);
> > -		if (ret)
> > -			break;
> > +	scoped_guard(mutex, &event_mutex) {
> > +		for_each_dyn_event_safe(pos, n) {
> > +			if (type && type != pos->ops)
> > +				continue;
> > +			if (!pos->ops->match(system, event,
> > +					argc - 1, (const char **)argv +
> > 1, pos))
> > +				continue;
> > +
> > +			ret = pos->ops->free(pos);
> > +			if (ret)
> > +				break;
> > +		}
> > +		tracing_reset_all_online_cpus();
> >  	}
> 
> This scoped_guard() doesn't give us anything. We still have the out label
> below (which my patch removes).

OK.

> > -	tracing_reset_all_online_cpus();
> > -	mutex_unlock(&event_mutex);
> >  out:
> >  	argv_free(argv);
> >  	return ret;
> > @@ -133,13 +132,12 @@ static int create_dyn_event(const char *raw_command)
> >  	if (raw_command[0] == '-' || raw_command[0] == '!')
> >  		return dyn_event_release(raw_command, NULL);
> >  
> > -	mutex_lock(&dyn_event_ops_mutex);
> > +	guard(mutex)(&dyn_event_ops_mutex);
> >  	list_for_each_entry(ops, &dyn_event_ops_list, list) {
> >  		ret = ops->create(raw_command);
> >  		if (!ret || ret != -ECANCELED)
> >  			break;
> >  	}
> 
> I also don't think this helps much here.

OK.

> > -	mutex_unlock(&dyn_event_ops_mutex);
> >  	if (ret == -ECANCELED)
> >  		ret = -EINVAL;
> >  
> > @@ -198,7 +196,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
> >  	struct dyn_event *ev, *tmp;
> >  	int ret = 0;
> >  
> > -	mutex_lock(&event_mutex);
> > +	guard(mutex)(&event_mutex);
> >  	for_each_dyn_event(ev) {
> >  		if (type && ev->ops != type)
> >  			continue;
> > @@ -216,7 +214,6 @@ int dyn_events_release_all(struct dyn_event_operations *type)
> >  	}
> >  out:
> 
> And the same issue here too. Why the guard when you still need to do the
> goto?

Yeah, we still need to call tracing_reset_all_online_cpus() here.

> 
> 
> >  	tracing_reset_all_online_cpus();
> > -	mutex_unlock(&event_mutex);
> >  
> >  	return ret;
> >  }
> 
> 
> There's a reason I looked at this file an didn't add any guards to it (when
> I forgot that you touched it). They are all special cases, and I rather
> avoid adding special case guards to handle it. I don't believe it makes it
> any less error prone.
> 
> Are you OK with dropping this patch?

Yeah, let's drop it.

Thanks for your review!


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
