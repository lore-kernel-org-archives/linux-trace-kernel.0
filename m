Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386223B62C;
	Tue, 30 Sep 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227063; cv=none; b=n0IwDzkuAdgFsYj3wCK0QCPd36EKvB5YRi4alxhsojCDajtUENz/jw9XqbBqg9vWD0GjvbOzjFHSR5sOJnE0YbM+qkxyxO7YAJOfVcocVwt25Qka5SSvcusEgEuS7zUButGd+NkZYEAKs+LF7C8mA/Qz677aOXtlSK2g1BSdtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227063; c=relaxed/simple;
	bh=h9HgIoGBQjSi1XCoAKCIhO9bF1dgTIEXPdad4STGnNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYjSg+tneyz9jpgik6lZTtRCgX07Fi7WDrpu1XziL2vSfyA9NrS+piudwIFDIATa3T6QAiusixtgZZku2lONKxEclHFbaoep/rLaZs6nyVk+UnKtJNe8Lih6eTPef32FIFoZKp3sqo/3eu6oeZRvq1E8ZO23FjU9SowuJAzl9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SlJR6dls; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlJR6dls"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D+CZAypiGvBv9t3fET4ytZsgqVELs1pifW7X4YTcTJQ=; b=SlJR6dlsigYezhyVby0mOit/K/
	+CikGgD4DrX+HJwfKMjhny/YGlgT70/lWDYgxuJbkBgqBFmt7R0LigpJ4VmL3R3gvLYkjkSjGLOWC
	2R5sjL+XBeCx7td0YcwdBb2Vhtwee7RmwuawlTAVK33hniSJhoTSWM1w+r1BzN93NnXhhMT4l2Isk
	+56cHMrv6SescNMwPTMP3dKyMz+ppP+BwTEDANA7IL6NGZiaImiiUKrJ3jLAXuQYZ9QgynRMmPJ4g
	UlASvc3H2B+gGl8pbUab8NmLSlRVzrk8efrbs3juJCGAZelT14pvz6smLZ9G5vZhAYcrQpn7MX5v2
	OzJUMV8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3XJr-00000009toO-1vf2;
	Tue, 30 Sep 2025 10:10:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4173F300220; Tue, 30 Sep 2025 12:10:52 +0200 (CEST)
Date: Tue, 30 Sep 2025 12:10:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, chenyuan_fl@163.com,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20250930101052.GL3245006@noisy.programming.kicks-ass.net>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
 <20250929065731.1351028-1-chenyuan_fl@163.com>
 <20250929044836.7169d5be@batman.local.home>
 <84seg5d2p3.fsf@jogness.linutronix.de>
 <20250929101259.GE3245006@noisy.programming.kicks-ass.net>
 <20250930175826.52b58b7a502b215e3d226f9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930175826.52b58b7a502b215e3d226f9b@kernel.org>

On Tue, Sep 30, 2025 at 05:58:26PM +0900, Masami Hiramatsu wrote:
> On Mon, 29 Sep 2025 12:12:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Sep 29, 2025 at 11:38:08AM +0206, John Ogness wrote:
> > 
> > > >> Problem:
> > > >> 1. CPU0 executes (1) assigning tp_event->perf_events = list
> > > 
> > > smp_wmb()
> > > 
> > > >> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
> > > >> 3. CPU1 triggers and reaches kprobe_dispatcher
> > > >> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> > > 
> > > smp_rmb()
> > > 
> > > >> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
> > > >>    call->perf_events is still NULL
> > > >> 
> > > >> The issue: Assignment in step 1 may not be visible to CPU1 due to
> > > >> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
> > > 
> > > A better explanation of the issue would be: CPU1 sees that kprobe
> > > functionality is enabled but does not see that perf_events has been
> > > assigned.
> > > 
> > > Add pairing read and write memory barriers to guarantee that if CPU1
> > > sees that kprobe functionality is enabled, it must also see that
> > > perf_events has been assigned.
> > > 
> > > Note that this could also be done more efficiently using a store_release
> > > when setting the flag (in step 2) and a load_acquire when loading the
> > > flag (in step 4).
> > 
> > The RELEASE+ACQUIRE is a better pattern for these cases. 
> > 
> > And I'll argue the barrier should be in 2 not 1, since it is 2 that sets
> > the flag checked in 4.  Any store before that flag might be affected,
> > not just the ->perf_events list.
> 
> RELEASE+ACQUIRE ensures the memory ordering on the `same` CPU, so do we still need smp_rmb() and smp_wmb()? e.g.

Eh, no, that's wrong. RELEASE and ACQUIRE are SMP barriers.
