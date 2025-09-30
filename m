Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658D2C08BA;
	Tue, 30 Sep 2025 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222710; cv=none; b=fSN5svQVH6woEyG4A+fyLdOEkjH7c+Ht3YZBz7PWh0OgMzgrU7KV78r4relwzKU7MT+MOh8gPtXoY1nocp3UPvtxtas043UenWEEFZgSebY5yHyGSoGtzB9Z7JEk3BDvPaXVIdYn+D+k8SBvZaFR25l+jInB5Hx9UNvVrl7W1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222710; c=relaxed/simple;
	bh=4efOYhltetw6slyQVH9lme/4VEV7xmJUuIjJq1TJpkA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uhJhvK2qF6+4tMNJptd+R2o5zU9mv9oU/JgOvmWirsMIr2BjMhVV9J+z8KZoR9sbeCg89v0HCX16Ml+PgkcaEliP07Z9MCIr4joZdGiSRk8Y18Jxmlcm704mb1548grM3XeKxg7LpnGuPRfZQWqBG/aqF4sTFBzmgXpnWSZm8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V30Fvt34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V30Fvt34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DCCC4CEF0;
	Tue, 30 Sep 2025 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759222709;
	bh=4efOYhltetw6slyQVH9lme/4VEV7xmJUuIjJq1TJpkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V30Fvt34jdn+QCj2hYE5jsUtKKi/63nkVzbb3bMOoUPRyKNM47H4KXovzE+Sc2DKq
	 UQjvXPbC9JmFEY8P5XEk6ZSoyLgUodtNDnMAO78aVMYRl7OY/TqgAvWYJjfwkQq7kR
	 83MnR1VmyfUllsWEvFtypgx5PMgqs6UAyl8+UMouStqiuP/zeRNGaGUvaOQP9j9Dsx
	 0vUAAl1vNQ+Gm78GCgn/wekElngofzzpVWQA8IQhl42X3+zMA2WeI/4aYkfEw4bCLt
	 ec6l4L/MnBNy3D5YMO1QGOpfD+r3GTiAUdSQKxeAbcAQwSKGSkb6brk1sP78BlT7tx
	 JULmit+lTjEvQ==
Date: Tue, 30 Sep 2025 17:58:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, chenyuan_fl@163.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20250930175826.52b58b7a502b215e3d226f9b@kernel.org>
In-Reply-To: <20250929101259.GE3245006@noisy.programming.kicks-ass.net>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
	<20250929065731.1351028-1-chenyuan_fl@163.com>
	<20250929044836.7169d5be@batman.local.home>
	<84seg5d2p3.fsf@jogness.linutronix.de>
	<20250929101259.GE3245006@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 12:12:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 29, 2025 at 11:38:08AM +0206, John Ogness wrote:
> 
> > >> Problem:
> > >> 1. CPU0 executes (1) assigning tp_event->perf_events = list
> > 
> > smp_wmb()
> > 
> > >> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
> > >> 3. CPU1 triggers and reaches kprobe_dispatcher
> > >> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> > 
> > smp_rmb()
> > 
> > >> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
> > >>    call->perf_events is still NULL
> > >> 
> > >> The issue: Assignment in step 1 may not be visible to CPU1 due to
> > >> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
> > 
> > A better explanation of the issue would be: CPU1 sees that kprobe
> > functionality is enabled but does not see that perf_events has been
> > assigned.
> > 
> > Add pairing read and write memory barriers to guarantee that if CPU1
> > sees that kprobe functionality is enabled, it must also see that
> > perf_events has been assigned.
> > 
> > Note that this could also be done more efficiently using a store_release
> > when setting the flag (in step 2) and a load_acquire when loading the
> > flag (in step 4).
> 
> The RELEASE+ACQUIRE is a better pattern for these cases. 
> 
> And I'll argue the barrier should be in 2 not 1, since it is 2 that sets
> the flag checked in 4.  Any store before that flag might be affected,
> not just the ->perf_events list.

RELEASE+ACQUIRE ensures the memory ordering on the `same` CPU, so do we still need smp_rmb() and smp_wmb()? e.g.

perf_trace_event_init()
-----
tp_event->perf_events = list
/*(1)*/
smp_store_release(&tp->event->flags, newflag);
-----

kprobe_dispatcher()
-----
smp_load_acquire(&tk->tp.flags);
/*(2)*/
this_cpu_ptr(call->perf_events);
-----

This ensures
 - the flags update is shown on other CPUs
 - perf_events update is done before the flags update on the same CPU
 - perf_events load is done after the flags load on the same CPU

But we are still not sure the perf_events update is shown on other CPUs?

To ensure that we still need smp_wmb() and smp_rmb() at (1) and (2).

Or we don't need smp_*mb()?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
