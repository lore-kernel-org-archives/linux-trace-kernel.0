Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DF14A4F7;
	Thu, 11 Jul 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710065; cv=none; b=IetKCK2BKjeP5iUlgNDBYsIpDdDcAee+kU2ZZWrtjkrq6WUV3cJzH+/XZOM/SIggoTHLetzgjd+96Yw/dU6oPCQQQ/ez5hi1qNbzyEeNn5TNCunVAqGUXeyxhCHWFf0DTmKrAfLiTthUPvEpYx4F5h82QaNbQra30gGw3BN2Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710065; c=relaxed/simple;
	bh=628C/Aq52Kfgb3AouXQudVs1Fdv8eNeF2/Sn/7ZzdNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnkHqHV+6sI2WKucVVJAxqce4aWXYibob+BvFWI+nQ8hYCuARNWQJnhluiGFNTWscis81N2ghuFCWIll8tAnuUFZfH3nqn/7gSCmQBo0hQ/DkaxcdPH2jGiLsBD+vRqVGIyLNPV6iKI2b3VyIxO6ARJIHxlnN5KWzvAdyij3itI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GBjfc0A8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBjfc0A8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JDR+Y5lA68hGC+YOCg0tjUpoc5lcqLw0eQjAAGj2XjM=; b=GBjfc0A8w9oDOAc8BdHFkF4n9A
	WArrfK4afX/Fb3Y81Z6x+OlxDZiahYLpK//GBKhrFDQG50cWu9GcVpmT3PWwnBDku7HF4laS4pgO1
	SK3jDuZhzDxF0DxEYPB933yZ5o5hbzv278t391eLI6tJan3fleMtD+bZWGtgaAaNZqRk8eA8cg3C4
	mzsUFTOi6OZZZp2e1yFbZRnaOqV3K36TIyk+rVuXLOjNevAOhOgRRAWhPE+4/cpKdDVkLqObzIfJg
	KRgDAoDdSDqAVQieV2ZZWShHVhNAeWZ7PW39vHLe9F9L9FbqczJwHLgUoUIBvEH0P2wVkDHF/2t6J
	AZ9L9nBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRvHz-000000017LI-0hsE;
	Thu, 11 Jul 2024 15:00:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8707C30050D; Thu, 11 Jul 2024 17:00:54 +0200 (CEST)
Date: Thu, 11 Jul 2024 17:00:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240711150054.GA3285@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
 <20240711131918.GC16902@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711131918.GC16902@redhat.com>

On Thu, Jul 11, 2024 at 03:19:19PM +0200, Oleg Nesterov wrote:
> Not sure I read this patch correctly, but at first glance it looks
> suspicious..
> 
> On 07/11, Peter Zijlstra wrote:
> >
> > +static void return_instance_timer(struct timer_list *timer)
> > +{
> > +	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
> > +	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
> > +}
> 
> What if utask->task sleeps in TASK_STOPPED/TASK_TRACED state before
> return from the ret-probed function?
> 
> In this case it won't react to TWA_SIGNAL until debugger or SIGCONT
> wakes it up.

Or FROZEN etc.. Yeah.

> ---------------------------------------------------------------------------
> And it seems that even task_work_add() itself is not safe...
> 
> Suppose we have 2 ret-probed functions
> 
> 	void f2() { ... }
> 	void f1() { ...; f2(); }
> 
> A task T calls f1(), hits the bp, and calls prepare_uretprobe() which does
> 
> 	mod_timer(&utask->ri_timer, jiffies + HZ);
> 
> Then later it calls f2() and the pending timer expires after it enters the
> kernel, but before the next prepare_uretprobe() -> mod_timer().
> 
> In this case ri_task_work is already queued and the timer is pending again.

You're saying we can hit a double enqueue, right? Yeah, that's a
problem. But that can be fairly easily rectified.

> Now. Even if T goes to the exit_to_user_mode_loop() path immediately, in
> theory nothing can guarantee that it will call get_signal/task_work_run
> in less than 1 second, it can be preempted.
> 
> But T can sleep in xol_take_insn_slot() before return from handle_swbp(),
> and this is not so theoretical.

So the assumption is that kernel code makes forward progress. If we get
preempted, we'll get scheduled again. If the machine is so overloaded
this takes more than a second, stretching the SRCU period is the least
of your problems.

Same with sleeps, it'll get a wakeup.

The only thing that is out of our control is userspace. And yes, I had
not considered STOPPED/TRACED/FROZEN.

So the reason I did that task_work is because the return_instance list
is strictly current, so a random timer cannot safely poke at it. And
barring those pesky states, it does as desired.

Let me ponder that a little, I *can* make it work, but all 'solutions'
I've come up with so far are really rather vile.
