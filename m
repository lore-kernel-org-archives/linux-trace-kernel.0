Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5363112BB;
	Thu, 13 Nov 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048112; cv=none; b=JUPhV4CktS+ogkfO8OYSQfKVMLn060bkY+cT0VE0FcpiNnb5DtA1JnTnzSWx9okwYv6l2Km4ob1UWbDxVoH0e3KtIlo5DFtEQQMMxR+WI6kTuSLQue08OR5SLc6ysLpdEZhbE7BCumas9IWkFuiiwsDEn4ZjWuBRtVyNyUuyDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048112; c=relaxed/simple;
	bh=x0fuzI6YRP3PTZsgW3tQ/n7GZ7E7kPR1ddm5RqYDeyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toajjGEsYHK5N4xLzHuO9gFGfQL3p5Vcqtn9hfO47dzw3OBRX8mwi5bEJyDAkJiltqJ/dO+I1zitwMIi1F6Pu6IxNVvjQFx/LP7Evt7HJAdjiDKsHrhO1p/CsT1T6f4fAQSymH0y84d6taZWO4a6gQxlyIuN6v9jBpkOTUhBSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WR1hTpvD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jqemhNOF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WR1hTpvD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jqemhNOF"
Date: Thu, 13 Nov 2025 16:35:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763048109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgWbF0s9rqqAq6d5nm/n6NPP01/SAB2lh3emYsdDdyI=;
	b=WR1hTpvDz3V68Vatk3WsX7G46aKoG+UyCVkh4KfFtRBctoDfY+BQ42FdtNi+XpF5h4UDLy
	chKfh+wmOc/xgtSR/bd0RlH24UhNzZdrals49rUajKqGDhADMcF/kIYAaTniwhN5GzrRf/
	jjm87GcwWJQSrPjrGip+qqKvQG3XpBjN3D4VfLJRXQiEQk4s+qf7JE4eaq6kVwycT+IWQ9
	Si06o7lkFe9ctUCk+b0+vYMPf56SdVf3IxpyPG0DEvqikk3WuhvJ3KsTibBCSPJSIirp38
	F0b/vGnAkS7sTtzTSXAbTnIoPyDPh/T4vQELbJ0rvMOp0WlHw7Yjw0tRjrrhyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763048109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgWbF0s9rqqAq6d5nm/n6NPP01/SAB2lh3emYsdDdyI=;
	b=jqemhNOFpx9+448NsBzy/OfzpN3nsk+Y5+id2E7h7F38r3weYCUR0hZ8UmAs86ZVj8gs1/
	ybt+JP5PmBnu9mAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113153508.9mYBNQlL@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
 <20251113073420.yko6jYcI@linutronix.de>
 <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
 <20251113141515.iZSIDK0T@linutronix.de>
 <20251113100524.5c5f6bdc@gandalf.local.home>
 <20251113151729.4Zky6d-t@linutronix.de>
 <20251113102445.3e70c1ec@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113102445.3e70c1ec@gandalf.local.home>

On 2025-11-13 10:24:45 [-0500], Steven Rostedt wrote:
> On Thu, 13 Nov 2025 16:17:29 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-11-13 10:05:24 [-0500], Steven Rostedt wrote:
> > > This means that the chunks are not being freed and we can't be doing
> > > synchronize_rcu() in every exit.  
> > 
> > You don't have to, you can do call_rcu().
> 
> But the chunk isn't being freed. They may be used right away.

Not if you avoid using it until after the rcu callback.

> > > > So I *think* the RCU approach should be doable and cover this.  
> > > 
> > > Where would you put the synchronize_rcu()? In do_exit()?  
> > 
> > simply call_rcu() and let it move to the freelist.
> 
> A couple of issues. One, the chunks are fully used. There's no place to put
> a "rcu_head" in them. Well, we may be able to make use of them.

This could be the first (16?) bytes of the memory chunk.

> Second, if there's a lot of tasks exiting and forking, we can easily run
> out of chunks that are waiting to be "freed" via call_rcu().

but this is a general RCU problem and not new here. The task_struct and
everything around it (including stack) is RCU freed.

> > 
> > > Also understanding what this is used for helps in understanding the scope
> > > of protection needed.
> > > 
> > > The pid_list is created when you add anything into one of the pid files in
> > > tracefs. Let's use /sys/kernel/tracing/set_ftrace_pid:
> > > 
> > >   # cd /sys/kernel/tracing
> > >   # echo $$ > set_ftrace_pid
> > >   # echo 1 > options/function-fork
> > >   # cat set_ftrace_pid
> > >   2716
> > >   2936
> > >   # cat set_ftrace_pid
> > >   2716
> > >   2945
> > > 
> > > What the above did was to create a pid_list for the function tracer. I
> > > added the bash process pid using $$ (2716). Then when I cat the file, it
> > > showed the pid for the bash process as well as the pid for the cat process,
> > > as the cat process is a child of the bash process. The function-fork option
> > > means to add any child process to the set_ftrace_pid if the parent is
> > > already in the list. It also means to remove the pid if a process in the
> > > list exits.  
> > 
> > This adding/ add-on-fork, removing and remove-on-exit is the only write
> > side?
> 
> That and manual writes to the set_ftrace_pid file.

This looks like minimal. I miss understood then that context switch can
also contribute to it.

> > > What we are protecting against is when one chunk is freed, but then
> > > allocated again for a different set of PIDs. Where the reader has the chunk,
> > > it was freed and re-allocated and the bit that is about to be checked
> > > doesn't represent the bit it is checking for.  
> > 
> > This I assumed.
> > And the kfree() at the end can not happen while there is still a reader?
> 
> Correct. That's done by the pid_list user:
> 
> In clear_ftrace_pids():
> 
> 	/* Wait till all users are no longer using pid filtering */
> 	synchronize_rcu();
> 
> 	if ((type & TRACE_PIDS) && pid_list)
> 		trace_pid_list_free(pid_list);
> 
> 	if ((type & TRACE_NO_PIDS) && no_pid_list)
> 		trace_pid_list_free(no_pid_list);

And the callers of trace_pid_list_is_set() are always in the RCU read
section then? I assume so, since it wouldn't make sense otherwise.

> -- Steve

Sebastian
