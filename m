Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08E280A5A;
	Mon, 29 Sep 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137157; cv=none; b=sObXX6Jfo7scNR0ZXjn2Fu/FHi5I1dgylHWuii5+HXct/J3CumiwDHovyZjxtx7Xewkz0OMgndlYmwIDODkztucDv+auoMpD+W32oBMA5zK/b+XEuOQMF/ml8ivIbezZcZnEc5EkR/snpf8/D/rGR3tpbtV6xEhiQcS1lgDc1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137157; c=relaxed/simple;
	bh=tnPhuiU47ad0N3FuqcpRKlf4qr4plNBoBLQ4diumTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9VqrTVfk7RUHwil+BRgwX4/oOUS6QDrm6TndvDx0gIlRYKiNv8Oi6AqrT73NZt8VsgmsMdI0y53kUV9bX4mxrurVsGz0gCTav7r3DyfUZK2bPjlecjBLAs4LdoEgVvO8/wrzXCYNb9jU9tgShABl3bYT9n8V7hR2wtbccTooGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gBBfXo3N; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBBfXo3N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IF5PbXEfPUzlgpbsFwniFlNImYXVd/US+vBWEr4VDHQ=; b=gBBfXo3N9w8tIh+DC9BOdRDij6
	0nIzhpzvGF0gyioslm9bdeMyvY928XNTbvHTfsrvk3MOVPux+OaR/kQMynDA9eVTpopGoc9Mnh7pK
	gplzEu9acjLwLxu/824VIUHOJWqXVazyZGWGluOg3NLy5ThUVjcPxg3fWd2r1ZONJ1gPvO3nnQfuV
	GdCwH1/7r2YVE1PX01He2tG/hsdblnVhjS4mv+CR/JhnB61I2sierbdyG+iJeueFnwO7TOWFeB8Qz
	41y6oP6nDZUsk8quOs2AcZinw6pLeH2sfp1jIxdqT/SAtURiKkr9tP3bq1AbP346v9KBtL0Z9745W
	/lJu+0/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39vk-0000000BxNO-1FK9;
	Mon, 29 Sep 2025 09:12:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B650300359; Mon, 29 Sep 2025 11:12:23 +0200 (CEST)
Date: Mon, 29 Sep 2025 11:12:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: chenyuan_fl@163.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20250929091223.GG4067720@noisy.programming.kicks-ass.net>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
 <20250929065731.1351028-1-chenyuan_fl@163.com>
 <20250929044836.7169d5be@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929044836.7169d5be@batman.local.home>

On Mon, Sep 29, 2025 at 04:48:36AM -0400, Steven Rostedt wrote:
> On Mon, 29 Sep 2025 07:57:31 +0100
> chenyuan_fl@163.com wrote:
> 
> > From: Yuan Chen <chenyuan@kylinos.cn>
> > 
> > There is a critical race condition in kprobe initialization that can lead to
> > NULL pointer dereference and kernel crash.
> > 
> > [1135630.084782] Unable to handle kernel paging request at virtual address 0000710a04630000

> > [1135630.434828]  kprobe_perf_func+0x30/0x260
> > [1135630.441661]  kprobe_dispatcher+0x44/0x60
> > [1135630.448396]  aggr_pre_handler+0x70/0xc8
> > [1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
> > [1135630.462435]  brk_handler+0xbc/0xd8
> > [1135630.468437]  do_debug_exception+0x84/0x138

> > 
> > kernel/trace/trace_kprobe.c
> > 1308: head = this_cpu_ptr(call->perf_events);
> > 1309:   if (hlist_empty(head))
> > 1310:           return 0;
> > 
> > crash> struct trace_event_call -o  
> > struct trace_event_call {
> >   ...
> >   [120] struct hlist_head *perf_events;  //(call->perf_event)
> >   ...
> > }
> > 
> > crash> struct trace_event_call ffffaf015340e528  
> > struct trace_event_call {
> >   ...
> >   perf_events = 0xffff0ad5fa89f088, //this value is correct, but x21 = 0
> >   ...
> > }
> > 
> > Race Condition Analysis:
> > 
> > The race occurs between kprobe activation and perf_events initialization:
> > 
> >   CPU0                                    CPU1
> >   ====                                    ====
> >   perf_kprobe_init
> >     perf_trace_event_init
> >       tp_event->perf_events = list;(1)
> >       tp_event->class->reg (2)← KPROBE ACTIVE
> >                                           Debug exception triggers
> >                                           ...
> >                                           kprobe_dispatcher
> >                                             kprobe_perf_func (tk->tp.flags & TP_FLAG_PROFILE)
> >                                               head = this_cpu_ptr(call->perf_events)(3)
> >                                               (perf_events is still NULL)
> > 
> > Problem:
> > 1. CPU0 executes (1) assigning tp_event->perf_events = list
> > 2. CPU0 executes (2) enabling kprobe functionality via class->reg()

This is kprobe_register() doing enable_trace_kprobe() ?

> > 3. CPU1 triggers and reaches kprobe_dispatcher
> > 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> > 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
> >    call->perf_events is still NULL
> > 
> > The issue: Assignment in step 1 may not be visible to CPU1 due to
> > missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
> > 
> > Add smp_mb() barrier between perf_events assignment and enabling
> > profile functionality to ensure visibility ordering across CPUs.

Yeah, that cannot be right.

> > Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> > ---
> >  kernel/trace/trace_event_perf.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > index a6bb7577e8c5..6eff8c9d6bae 100644
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -113,6 +113,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
> >  
> >  	tp_event->perf_events = list;
> >  
> > +	/* Ensure perf_events assignment is visible to all CPUs before enabling
> > +	 * profile functionality
> > +	 */
> > +	smp_mb();
> 
> So from other discussions I had with John and Sebastian (both Cc'd),
> memory barriers are not for "making memory visible", but instead are
> for interactions between memory and two different CPUs, where both CPUs
> have memory barriers.

Correct, barriers have to be paired. The above doesn't have enough clues
for me to know what code is affected, but if we're talking about
kprobe_register(PERF_REG) := enable_trace_kprobe(,NULL), when it might
be that trace_probe_set_flag() should be an smp_store_release(), while
trace_probe_test_flag(PROFILE) in kprobe_dispatch() needs to be a
smp_load_acquire().

Without the acquire it might still be possible for the CPU to lift the
call->perf_event load up before the event->flags load, rendering your
wmb pointless.

The guarantee you're looking for is that if the flag is set, it sees a
fully formed event. This is done with RELEASE on publish and ACQUIRE on
access.
