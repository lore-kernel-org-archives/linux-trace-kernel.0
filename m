Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DD38AC9C;
	Mon,  8 Jun 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914247; cv=none; b=ufRUl+nuq8KqUM28002l+D/aqvBtMGH/fE7UGlrlaC4uEvbGMlniZv3GFe3thxkJSvCCTp+ndvSqxPEvqL1Q26HXT8/nOwHagab2wrcZHbdNKcUHuoI8zyhLW2ZP9IoHMxkeKJrAj09a9Mz3PPUQKxdRIPizZuUEqvBm7gEbEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914247; c=relaxed/simple;
	bh=TQNzuhW8qNHmgLjsMR9rjLnm4WiCUUUYKIPnx1k0FdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwodGcg3JEgtMPDw2zNZ8hAjjoyd2tqrhjo1dpTAaXnXBsxH65QcKFk2A2NHpWtPhOlseEzMzWEv97pT4kmnca6ri7EZ8TXphdlblpAdJxyWKcNYTAkNuCGNe5MBqnSef1cCRiwBWpItAUvUyGnUrFCkrFn5lnCCcMgQQVtl2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZmV9e02I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmV9e02I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0kQ/nT4Nufj/3/mo9LElvCX+euvyJO3ut+oFpKx7fFE=; b=ZmV9e02I6+KQ7sAfPGoRwM6CIf
	Vl9to5voPKIu9tOay9PYKuFrxqoTq32j6Qp8dXroH7MB8Mpp2JPMArIIOcORRCuc6u3vO6pRgLkw9
	5YhNi7g6sp8WUyw8vQh45qpENkR/YV3KUu7cqZ8h+Xo9Vx+HBlVqY9g8VOuV6U1x7rM09yLCelhzU
	l+xoBB3u258IlhfYUQMMomNtnrpNsnQTiBuiYWDO47AB/2FGY0d/LHwxRFbbJkjr0TH3oY4SFMWql
	ziOoJS69FnxnkcxieVa7WQwiL8fC+juXuWi1UO47ZefR9YB3Kgfudh3DTe8P8/BO7fgPQOnl3j7Q+
	S9y5BemQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWX9A-0000000DVH1-3Bed;
	Mon, 08 Jun 2026 10:23:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2995C30036F; Mon, 08 Jun 2026 12:23:26 +0200 (CEST)
Date: Mon, 8 Jun 2026 12:23:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-ID: <20260608102326.GB3161497@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
 <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
 <20260608093449.GH4149641@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608093449.GH4149641@noisy.programming.kicks-ass.net>

On Mon, Jun 08, 2026 at 11:34:49AM +0200, Peter Zijlstra wrote:
> 
> +Live patching folks
> 
> On Mon, Jun 08, 2026 at 09:52:37AM +0800, Tengda Wu wrote:
> 
> > Background: We are verifying the support of live patches for functions that
> > have a kretprobe. The specific verification method is as follows:
> > 
> > We construct a function foo() that calls bar():
> > 
> > void bar(void)
> > {
> >     for (;;) {
> >         schedule();
> >     }
> > }
> > 
> > void foo(void)
> > {
> >     bar();
> > }
> > 
> > A kretprobe is attached to bar():
> > 
> > echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
> > echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
> > 
> > Then foo() is triggered. The expected behavior is that bar() will call
> > schedule() and yield the CPU.
> > 
> > After that, the live patch is activated to attempt replacing the implementation
> > of foo(). The expectation is that this should succeed.
> 
> This wholly depends on how foo() calls bar(), if it is a normal call,
> then no, it should not succeed, because foo() is still on the stack.
> 
> If it is a tail-call, then yes, because foo() is no longer relevant.
> 
> > However, in reality, because the task that called schedule() is still in the
> > RUNNING state,
> 
> So calling schedule() without setting state is dodgy in the first place.
> Who is doing this? All wait primitives will set this to
> TASK_UNINTERRUPTIBLE or something along those lines.
> 
> > the condition task_is_running(tsk) inside rethook_find_ret_addr()
> > is not satisfied, causing the function to return early. This, in turn,
> > prevents stack_trace_save_tsk_reliable() from determining the stack as
> > reliable, leading to a failure in activating the live patch.
> > 
> > **Not sure if this is correct:**
> > 
> > We believe that after a task voluntarily calls schedule(), when the stack
> > is expected to be reliable, it is a safe time to activate a live patch.
> 
> Calling schedule() without setting state is a no-op and really shouldn't
> count much at all.
> 
> > Additionally, a similar tsk->on_cpu check can be found elsewhere in the
> > kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
> > Therefore, we propose changing the task_is_running(tsk) condition to
> > tsk->on_cpu.
> 
> Anyway, I'm wondering what the purpose of this check here is, there is
> no real comment, and commit 5120d167e21c ("rethook: Remove warning
> messages printed for finding return address of a frame.") is just pure
> voodoo as well.

FWIW, you should have had this discussion then.

> Also, note the comment that goes with the usage of
> task_on_another_cpu(); that thing is racy as all heck.
> 
> So it really comes down to what the purpose of this check is.
> 
> I suspect the issue at hand is that tsk->rethook elements, such as
> iterated by __rethook_find_ret_addr() are not safe to be accessed for a
> running task.
> 
> Notably while rethook_recycle() has some RCU thing on, that objpool
> thing (and the recycle name itself) seems to strongly suggest iterating
> these things is not sound (you could start with things from this task,
> hit a recycled entry and continue iterating rethooks from another task).
> 
> Also note that the current check is also racy, nothing really prevents a
> wakeup from happening right after you observe task_is_running() being
> false. The task can then get scheduled in on another CPU and tear down
> its rethooks concurrent with __rethook_find_ret_addr().
> 
> 
> Now, livepatch itself calls unwind from a proper context, but unwinds in
> general are not. This rethook stuff doesn't seem to be sound in general.

I suspect just entirely removing the check is the sanest option at this
point. Callers that do it right (livepatch) are guaranteed consistent
data, and the rest gets whatever pieces.

Notably, unwind_next() holds rcu, so the iteration is protected from any
of those rethook_node things getting freed. Its just that the iteration
can go sideways and you might not get a sane answer.

The very worst possible option is getting stuck in an infinite loop when
concurrent with agressive rethook re-use or something daft like that,
but that seems extremely unlikely.
