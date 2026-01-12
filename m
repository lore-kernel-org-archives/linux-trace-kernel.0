Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA132142F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202616; cv=none; b=Q95FDmnQHXRQPLKAvzcXU/cHAml1mm1epFPAVL+khqxbTDHPFNhYJa8YsgnAI+HaWaEhNLtyQBr6HunM1bPrasJ9GZ7zsgmqUZx3W7D1j04h+m0nbuZ4tnjvTXzXD7BkHCRtBp+C2x/oZgkZiWui7+Tdoc4TzKDkM5siP5dBRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202616; c=relaxed/simple;
	bh=F1V8XP6HfIfDJMn8b3y89S9z8mQ50N6xQrztS65BQo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUZVsoNX5zXwGXuAn2dsYeq33J8g5epJGN6FcR0/8KBl0mtpHN1vq+pGfd1+a1oHCknAeco95TtKka13mgvUE+wsRjH8vnvPeN5lJ5l7WnEWIgvIllGvOgXdEULMynj1Z6r5HsQsJ9YjDi0zBFtgF57PrXTSJFlGu9w2fP60QI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B39GCIub; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B39GCIub"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768202602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcAsPi/didUAjJXFDQZOG7bxdnR13N/UiSq6MPkktV8=;
	b=B39GCIubC5D2ehRQZqMm5Vw7TUDlLnTT5SqLIQ42mQkHCdv9m9WYsJ302mX/2FS7urRwYL
	Kana3WIerh0vVjwRHB0UBX68zx/N6t7lk0Zy92RATokQxmkqOBpRA9Dr/AIkXiR94mYkLO
	3DzGJPWhDiNzFFN4sw6Yu+VqAFeRUds=
From: Menglong Dong <menglong.dong@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject:
 Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with
 SRCU-fast
Date: Mon, 12 Jan 2026 15:23:13 +0800
Message-ID: <13926791.uLZWGnKmhe@7940hx>
In-Reply-To: <20260109160202.22975aa4@gandalf.local.home>
References:
 <20260108220550.2f6638f3@fedora>
 <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <20260109160202.22975aa4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 05:02 Steven Rostedt <rostedt@goodmis.org> write:
> On Fri, 9 Jan 2026 15:21:19 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > * preempt disable/enable pair:                                     1.1 ns
> > * srcu-fast lock/unlock:                                           1.5 ns
> > 
> > CONFIG_RCU_REF_SCALE_TEST=y
> > * migrate disable/enable pair:                                     3.0 ns
> > * calls to migrate disable/enable pair within noinline functions: 17.0 ns
> > 
> > CONFIG_RCU_REF_SCALE_TEST=m
> > * migrate disable/enable pair:                                    22.0 ns
> 
> OUCH! So migrate disable/enable has a much larger overhead when executed in
> a module than in the kernel? This means all spin_locks() in modules
> converted to mutexes in PREEMPT_RT are taking this hit!
> 
> It looks like it has to allow access to the rq->nr_pinned. There's a hack to
> expose this part of the rq struct for in-kernel by the following:
> 
> kernel/sched/rq-offsets.c:      DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
> 
> Then for the in-kernel code we have:
> 
> #define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
> #else
> #define this_rq_raw() PERCPU_PTR(&runqueues)
> #endif
> #define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))
> 
> Looking at the scheduler code, the rq->nr_pinned is referenced by a static
> function with:
> 
> static inline bool rq_has_pinned_tasks(struct rq *rq)
> {
> 	return rq->nr_pinned;
> }
> 
> Which is only referenced in hotplug code and a balance_push() path in load
> balancing. Does this variable really need to be in the runqueue struct?
> 
> Why not just make it a per-cpu variable. Maybe call it cpu_nr_pinned_tasks,
> and export that for all to use?
> 
> It will not only fix the discrepancy between the overhead of
> migrate_disable/enable in modules vs in-kernel. But it also removes the
> hack to expose a portion of the runqueue.

I think it's a good idea to factor out the "nr_pinned" from struct rq.
The current approach that we inline the migrate_disable is a little
obscure. The initial propose of inline migrate_disable is to optimize the
performance of bpf trampoline, so the modules are not considered.

As you said, rq_has_pinned_tasks() is the only place that use the
nr_pinned, except the migrate_disable/migrate_enable. After more
analysis, I think maybe we can do it this way:

DEFINE_PER_CPU_SHARED_ALIGNED(int, cpu_nr_pinned_tasks);

And change rq_has_pinned_tasks() to:
static inline bool rq_has_pinned_tasks(struct rq *rq)
{
	return *per_cpu_ptr(&cpu_nr_pinned_tasks, rq->cpu);
}

The "rq" in rq_has_pinned_tasks() may come from other CPU, so we
can't use "return this_cpu_read(cpu_nr_pinned_tasks)" directly.

Thanks!
Menglong Dong

> 
> -- Steve
> 
> 




