Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263286;
	b=A54/DaPtwZeHSUudmkfQeoJfalmNQGnL8ddLEigLPRbenibLyXyk8wprhu9aPC1PUCSM
	 +/A5rO/eC8JssdE+ADSzETg2rhuu/8MMV1BkTBBvDFt7Pf5bhddx1E7l5ro9InxPWcGv5
	 T+OhYCMAPsZa7JrTnbgg5pny/fsfynAzrEWHiJTM93IJ5dw33Cv8HvZD946yzh3AsNs2T
	 4Irt1Vw7FSq/IEYHBt+xFDA5qPvleQ7BA7migKZnbCJnHzNvbInX1B8Zi/C2krZL3te72
	 r+EhCtulQiY+PbxRomJR136EYe1T80N9jBoOO22XPdw5vS2gxOReF1x0YSAy2R2B8yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=wc4/ml/eH1O4k3Y1BTYhWYiLh1fjGgzYV80i4p3jK2o=;
	b=Sr0so4fxI7c4A5FVCGPGly3rlZ1WlCz0BXvnLWY5ixXumctqiMDdfhdT4STrhdGslW7/
	 RmwplxWgY9RtiWsgsPEIoQzUSdwsuEE+Zg/fb6akLEhA9Um61m9Z+EYUNhqZjf3ZJr1st
	 RHcMGR3uDJe+vpl5rm7hsaZ4ksXRJGw/nQMqxLKhE34AZQA+rNegFZdV79aglrfG76i36
	 nbJmE8LTiwLJs4weMbl/qpDXOYmCsa47WDQi6F+D/r4qPEXEa9xRdNh8y20573DcS9m9h
	 y5Xg6WrHtKCgbqyCEf7gouqSr67rU/Acv63OdDz9eM+2KXXOpuR6+LR/K7q8FQSm/dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOW+0cZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4E606A321;
	Mon,  9 Nov 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOW+0cZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A821F0089F;
	Mon,  9 Nov 2026 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263285;
	bh=wc4/ml/eH1O4k3Y1BTYhWYiLh1fjGgzYV80i4p3jK2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iOW+0cZp8ZdjOcgvFLbFD+uA/y2u0ZimDukX5XfB+ExEssnw8F1bq1kKoI/2ZVJpY
	 rbMTfE8olAdPf/hq54a+GiYhF7qaSsw3xa+8SNgZmpY17+Q1mnxXKsLUWJQaEbP9zs
	 0dzJ7ubdV4evJffpMob/nnc3cboCInYpRD1J/5uTE1+LiUmyKSRFLci9D+HKq/JJEu
	 5wm9OuTG8htEB7WROWFNmXrXxuXlbIKT4u5t8gH9S0kh6t8x7jcedJ1JUlF/8JdNZb
	 bpU6EVSOVm2hYAmPTiq5ue2/UrtMqKRZrNNkYnsXHFmeUdHRJ5iF2Vzm1Dxb8bPj22
	 wxWFi6w7Rgl1g==
From: Thomas Gleixner <tglx@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>, pmladek@suse.com,
 john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, kees@kernel.org,
 anna-maria@linutronix.de, frederic@kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
 hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/5] timers: Avoid blocking on hrtimer_cpu_base
 lock during Oops or panic
In-Reply-To: <20261103024453.922373-4-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-4-atomlin@atomlin.com>
Date: Mon, 09 Nov 2026 23:28:01 +0100
Message-ID: <87y0b1tzbi.ffs@fw13>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 02 2026 at 21:44, Aaron Tomlin wrote:

> When sysrq_timer_list_show() dumps active high-resolution timers across
> all online CPUs, it calls ktime_get() (which spins on tk_core.seq) and
> print_active_timers() unconditionally acquires each CPU's
> base->cpu_base->lock via raw_spin_lock_irqsave(). If invoked from an
> Oops, NMI, or panic context while the crashing CPU or a wedged remote
> CPU is inside a timekeeping write section or already holds
> base->cpu_base->lock, sysrq_timer_list_show() will spin indefinitely
> and prevent panic recovery or kexec from completing.
>
> Use the NMI-safe ktime_get_mono_fast_ns() helper in
> sysrq_timer_list_show() and raw_spin_trylock_irqsave() in
> print_active_timers() when in_nmi(), oops_in_progress, or
> panic_in_progress() is active, noting any contended lock and returning cleanly instead of
> deadlocking.
>
> Fixes: d999bd9392de ("panic: add options to print system info when panic happens")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  kernel/time/timer_list.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index 0406bf4488e9..4973650c4ae5 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -68,7 +68,15 @@ static void print_active_timers(struct seq_file *m, struct hrtimer_clock_base *b
>  
>  	touch_nmi_watchdog();
>  
> -	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> +	if (in_nmi() || oops_in_progress || panic_in_progress()) {
> +		if ((!IS_ENABLED(CONFIG_SMP) && in_nmi()) ||
> +		    !raw_spin_trylock_irqsave(&base->cpu_base->lock, flags)) {
> +			SEQ_printf(m, "  [cpu_base lock contended]\n");
> +			return;
> +		}
> +	} else {
> +		raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> +	}

TBH, that's horrible and unreadable gunk.

Clearly the approach of all of this is:

   1) Pick some existing code
   2) Invoke it
   3) Hope that it works
   4) If not add bandaids to make it "work"

Seriously?

Each of the callers of sys_info() knows the exact context in which it is
invoked, right?

So the obvious and clean solution is to hand exactly that context
information into sys_info() and further down into the invoked
functions so they can make informed decisions and eventually omit
pointless information which is otherwise emitted in proc/sysrq-t.

Something like the uncompiled mockup below should give you an idea.

>  	curr = timerqueue_linked_first(&base->active);
>  	/*
> @@ -262,7 +270,8 @@ static inline void timer_list_header(struct seq_file *m, ktime_t now)
>  
>  void sysrq_timer_list_show(void)
>  {
> -	ktime_t now = ktime_get();
> +	ktime_t now = (in_nmi() || oops_in_progress || panic_in_progress()) ?
> +		      ns_to_ktime(ktime_get_mono_fast_ns()) : ktime_get();

That's a pointless exercise. Just use ktime_get_mono_fast_ns()
unconditionally. It's perfectly fine for the purpose of this in all
contexts.

Thanks,

        tglx
---
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -17,10 +17,16 @@
 
 #include "tick-internal.h"
 
+struct tlctx {
+	struct	seq_file	*seq_file;
+	ktime_t			ts_now;
+	enum sysinfo_context	si_ctx;
+};
+
 struct timer_list_iter {
-	int cpu;
-	bool second_pass;
-	ktime_t now;
+	int	cpu;
+	bool	second_pass;
+	ktime_t	now;
 };
 
 /*
@@ -28,35 +34,51 @@ struct timer_list_iter {
  * to the console (on SysRq-Q):
  */
 __printf(2, 3)
-static void SEQ_printf(struct seq_file *m, const char *fmt, ...)
+static void SEQ_printf(struct tlctx *ctx, const char *fmt, ...)
 {
 	va_list args;
 
 	va_start(args, fmt);
 
-	if (m)
-		seq_vprintf(m, fmt, args);
+	if (ctx->seq_file)
+		seq_vprintf(ctx->seq_file, fmt, args);
 	else
 		vprintk(fmt, args);
 
 	va_end(args);
 }
 
-static void
-print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
-	    int idx, ktime_t now)
-{
-	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, ACCESS_PRIVATE(timer, function));
-	SEQ_printf(m, ", S:%02x", timer->is_queued);
-	SEQ_printf(m, "\n");
-	SEQ_printf(m, " # expires at %lld-%lld nsecs [in %lld to %lld nsecs]\n",
-		(long long)hrtimer_get_softexpires(timer),
-		(long long)hrtimer_get_expires(timer),
-		(long long)ktime_sub(hrtimer_get_softexpires(timer), now),
-		(long long)ktime_sub(hrtimer_get_expires(timer), now));
+static void print_timer(struct tlctx *ctx, struct hrtimer *taddr, struct hrtimer *timer,
+			int idx, ktime_t now)
+{
+	SEQ_printf(ctx, " #%d: <%p>, %ps", idx, taddr, ACCESS_PRIVATE(timer, function));
+	SEQ_printf(ctx, ", S:%02x", timer->is_queued);
+	SEQ_printf(ctx, "\n");
+	SEQ_printf(ctx, " # expires at %lld-%lld nsecs [in %lld to %lld nsecs]\n",
+		   (long long)hrtimer_get_softexpires(timer),
+		   (long long)hrtimer_get_expires(timer),
+		   (long long)ktime_sub(hrtimer_get_softexpires(timer), now),
+		   (long long)ktime_sub(hrtimer_get_expires(timer), now));
+}
+
+static bool lock_hrtimer_base(struct tlctx *ctx, struct hrtimer_clock_base *base,
+			      unsigned long *flags)
+{
+	switch (ctx->si_ctx) {
+	case SYSINFO_CTX_LOCK_SAFE:
+		raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
+		return true;
+	case SYSINFO_CTX_TRYLOCK_SAFE:
+		if (raw_spin_trylock_irqsave(&base->cpu_base->lock, *flags))
+			return true;
+		fallthrough;
+	default:
+		SEQ_printf(ctx, "  Unsafe context: Skip timers.\n");
+		return false;
+	}
 }
 
-static void print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base, ktime_t now)
+static void print_active_timers(struct tlctx *ctx, struct hrtimer_clock_base *base, ktime_t now)
 {
 	struct timerqueue_linked_node *curr;
 	struct hrtimer *timer, tmp;
@@ -64,13 +86,14 @@ static void print_active_timers(struct s
 	unsigned long flags;
 
 next_one:
-	if (m && seq_has_overflowed(m))
+	if (ctx->seq_file && seq_has_overflowed(ctx->seqfile))
 		return;
 	i = 0;
 
 	touch_nmi_watchdog();
 
-	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
+	if (!lock_hrtimer_base(ctx, base, &flags))
+		return;
 
 	curr = timerqueue_linked_first(&base->active);
 	/*
@@ -83,51 +106,48 @@ static void print_active_timers(struct s
 	}
 
 	if (curr) {
-
 		timer = container_of(curr, struct hrtimer, node);
 		tmp = *timer;
 		raw_spin_unlock_irqrestore(&base->cpu_base->lock, flags);
 
-		print_timer(m, timer, &tmp, i, now);
+		print_timer(ctx, timer, &tmp, i, now);
 		next++;
 		goto next_one;
 	}
 	raw_spin_unlock_irqrestore(&base->cpu_base->lock, flags);
 }
 
-static void
-print_base(struct seq_file *m, struct hrtimer_clock_base *base, ktime_t now)
+static void print_base(struct tlctx *ctx, struct hrtimer_clock_base *base)
 {
-	SEQ_printf(m, "  .base:       %p\n", base);
-	SEQ_printf(m, "  .index:      %d\n", base->index);
+	SEQ_printf(ctx, "  .base:       %p\n", base);
+	SEQ_printf(ctx, "  .index:      %d\n", base->index);
 
-	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
+	SEQ_printf(ctx, "  .resolution: %u nsecs\n", hrtimer_resolution);
 #ifdef CONFIG_HIGH_RES_TIMERS
-	SEQ_printf(m, "  .offset:     %lld nsecs\n",
-		   (long long) base->offset);
+	SEQ_printf(ctx, "  .offset:     %lld nsecs\n", (long long) base->offset);
 #endif
-	SEQ_printf(m,   "active timers:\n");
-	print_active_timers(m, base, ktime_add(now, base->offset));
+	SEQ_printf(ctx,   "active timers:\n");
+	print_active_timers(ctx, base, ktime_add(ctx->ts_mono, base->offset));
 }
 
-static void print_cpu(struct seq_file *m, int cpu, ktime_t now)
+static void print_cpu(struct tlctx *ctx, int cpu)
 {
 	struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
 	int i;
 
-	SEQ_printf(m, "cpu: %d\n", cpu);
+	SEQ_printf(ctx, "cpu: %d\n", cpu);
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		SEQ_printf(m, " clock %d:\n", i);
-		print_base(m, cpu_base->clock_base + i, now);
+		SEQ_printf(ctx, " clock %d:\n", i);
+		print_base(ctx, cpu_base->clock_base + i);
 	}
 
 #define DIAG_READ(x) data_race(READ_ONCE(x))
 
 #define P(x)				     \
-	SEQ_printf(m, "  .%-15s: %llu\n", #x, \
+	SEQ_printf(ctx, "  .%-15s: %llu\n", #x, \
 		   (unsigned long long)DIAG_READ(cpu_base->x))
 #define P_ktime(x) \
-	SEQ_printf(m, "  .%-15s: %lld nsecs\n", #x, (long long)DIAG_READ(cpu_base->x))
+	SEQ_printf(ctx, "  .%-15s: %lld nsecs\n", #x, (long long)DIAG_READ(cpu_base->x))
 
 #ifdef CONFIG_HIGH_RES_TIMERS
 	P_ktime(expires_next);
@@ -141,13 +161,12 @@ static void print_cpu(struct seq_file *m
 #undef P_ktime
 
 #ifdef CONFIG_TICK_ONESHOT
-# define P(x) \
-	SEQ_printf(m, "  .%-15s: %llu\n", #x, \
-		   (unsigned long long)DIAG_READ(ts->x))
-# define P_ktime(x) \
-	SEQ_printf(m, "  .%-15s: %lld nsecs\n", #x, (long long)DIAG_READ(ts->x))
-# define P_flag(x, f)			    \
-	SEQ_printf(m, "  .%-15s: %d\n", #x, !!(DIAG_READ(ts->flags) & (f)))
+# define P(x)										\
+	SEQ_printf(ctx, "  .%-15s: %llu\n", #x, (unsigned long long)DIAG_READ(ts->x))
+# define P_ktime(x)									\
+	SEQ_printf(ctx, "  .%-15s: %lld nsecs\n", #x, (long long)DIAG_READ(ts->x))
+# define P_flag(x, f)									\
+	SEQ_printf(ctx, "  .%-15s: %d\n", #x, !!(DIAG_READ(ts->flags) & (f)))
 
 	{
 		struct tick_sched *ts = tick_get_tick_sched(cpu);
@@ -162,8 +181,7 @@ static void print_cpu(struct seq_file *m
 		P(last_jiffies);
 		P(next_timer);
 		P_ktime(idle_expires);
-		SEQ_printf(m, "jiffies: %llu\n",
-			   (unsigned long long)jiffies);
+		SEQ_printf(ctx, "jiffies: %llu\n", (unsigned long long)jiffies);
 	}
 #endif
 
@@ -171,129 +189,138 @@ static void print_cpu(struct seq_file *m
 #undef P_ktime
 #undef P_flag
 #undef DIAG_READ
-	SEQ_printf(m, "\n");
+	SEQ_printf(ctx, "\n");
 }
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-static void
-print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
+static void print_tickdevice(struct tlctx *ctx, struct tick_device *td, int cpu)
 {
 	struct clock_event_device *dev = td->evtdev;
 
 	touch_nmi_watchdog();
 
-	SEQ_printf(m, "Tick Device: mode:     %d\n", td->mode);
+	SEQ_printf(ctx, "Tick Device: mode:     %d\n", td->mode);
 	if (cpu < 0)
-		SEQ_printf(m, "Broadcast device\n");
+		SEQ_printf(ctx, "Broadcast device\n");
 	else
-		SEQ_printf(m, "Per CPU device: %d\n", cpu);
+		SEQ_printf(ctx, "Per CPU device: %d\n", cpu);
 
-	SEQ_printf(m, "Clock Event Device: ");
+	SEQ_printf(ctx, "Clock Event Device: ");
 	if (!dev) {
-		SEQ_printf(m, "<NULL>\n");
+		SEQ_printf(ctx, "<NULL>\n");
 		return;
 	}
-	SEQ_printf(m, "%s\n", dev->name);
-	SEQ_printf(m, " max_delta_ns:   %llu\n",
-		   (unsigned long long) dev->max_delta_ns);
-	SEQ_printf(m, " min_delta_ns:   %llu\n",
-		   (unsigned long long) dev->min_delta_ns);
-	SEQ_printf(m, " mult:           %u\n", dev->mult);
-	SEQ_printf(m, " shift:          %u\n", dev->shift);
-	SEQ_printf(m, " mode:           %d\n", clockevent_get_state(dev));
-	SEQ_printf(m, " next_event:     %lld nsecs\n", (long long)dev->next_event);
+	SEQ_printf(ctx, "%s\n", dev->name);
+	SEQ_printf(ctx, " max_delta_ns:   %llu\n", (unsigned long long) dev->max_delta_ns);
+	SEQ_printf(ctx, " min_delta_ns:   %llu\n", (unsigned long long) dev->min_delta_ns);
+	SEQ_printf(ctx, " mult:           %u\n", dev->mult);
+	SEQ_printf(ctx, " shift:          %u\n", dev->shift);
+	SEQ_printf(ctx, " mode:           %d\n", clockevent_get_state(dev));
+	SEQ_printf(ctx, " next_event:     %lld nsecs\n", (long long)dev->next_event);
 
-	SEQ_printf(m, " set_next_event: %ps\n", dev->set_next_event);
+	SEQ_printf(ctx, " set_next_event: %ps\n", dev->set_next_event);
 
 	if (dev->set_state_shutdown)
-		SEQ_printf(m, " shutdown:       %ps\n",
-			dev->set_state_shutdown);
+		SEQ_printf(ctx, " shutdown:       %ps\n", dev->set_state_shutdown);
 
 	if (dev->set_state_periodic)
-		SEQ_printf(m, " periodic:       %ps\n",
-			dev->set_state_periodic);
+		SEQ_printf(ctx, " periodic:       %ps\n", dev->set_state_periodic);
 
 	if (dev->set_state_oneshot)
-		SEQ_printf(m, " oneshot:        %ps\n",
-			dev->set_state_oneshot);
+		SEQ_printf(ctx, " oneshot:        %ps\n", dev->set_state_oneshot);
 
 	if (dev->set_state_oneshot_stopped)
-		SEQ_printf(m, " oneshot stopped: %ps\n",
-			dev->set_state_oneshot_stopped);
+		SEQ_printf(ctx, " oneshot stopped: %ps\n", dev->set_state_oneshot_stopped);
 
 	if (dev->tick_resume)
-		SEQ_printf(m, " resume:         %ps\n",
-			dev->tick_resume);
+		SEQ_printf(ctx, " resume:         %ps\n", dev->tick_resume);
 
-	SEQ_printf(m, " event_handler:  %ps\n", dev->event_handler);
-	SEQ_printf(m, "\n");
-	SEQ_printf(m, " retries:        %lu\n", dev->retries);
+	SEQ_printf(ctx, " event_handler:  %ps\n", dev->event_handler);
+	SEQ_printf(ctx, "\n");
+	SEQ_printf(ctx, " retries:        %lu\n", dev->retries);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	if (cpu >= 0) {
 		const struct clock_event_device *wd = tick_get_wakeup_device(cpu);
 
-		SEQ_printf(m, "Wakeup Device: %s\n", wd ? wd->name : "<NULL>");
+		SEQ_printf(ctx, "Wakeup Device: %s\n", wd ? wd->name : "<NULL>");
 	}
 #endif
-	SEQ_printf(m, "\n");
+	SEQ_printf(ctx, "\n");
 }
 
 static void timer_list_show_tickdevices_header(struct seq_file *m)
 {
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-	print_tickdevice(m, tick_get_broadcast_device(), -1);
-	SEQ_printf(m, "tick_broadcast_mask: %*pb\n",
+	print_tickdevice(ctx, tick_get_broadcast_device(), -1);
+	SEQ_printf(ctx, "tick_broadcast_mask: %*pb\n",
 		   cpumask_pr_args(tick_get_broadcast_mask()));
 #ifdef CONFIG_TICK_ONESHOT
-	SEQ_printf(m, "tick_broadcast_oneshot_mask: %*pb\n",
+	SEQ_printf(ctx, "tick_broadcast_oneshot_mask: %*pb\n",
 		   cpumask_pr_args(tick_get_broadcast_oneshot_mask()));
 #endif
-	SEQ_printf(m, "\n");
+	SEQ_printf(ctx, "\n");
 #endif
 }
 #endif
 
-static inline void timer_list_header(struct seq_file *m, ktime_t now)
+static inline void timer_list_header(struct seq_file *ctx)
 {
-	SEQ_printf(m, "Timer List Version: v0.11\n");
-	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
-	SEQ_printf(m, "now at %lld nsecs\n", (long long)now);
-	SEQ_printf(m, "\n");
+	SEQ_printf(ctx, "Timer List Version: v0.11\n");
+	SEQ_printf(ctx, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
+	SEQ_printf(ctx, "now at %lld nsecs\n", (long long)ctx->ts_mono);
+	SEQ_printf(ctx, "\n");
 }
 
-void sysrq_timer_list_show(void)
+static void sys_timer_list_show(struct tlctx *ctx)
 {
-	ktime_t now = ktime_get();
+	ctx->ts_mono = ktime_get_ns_fast();
 	int cpu;
 
-	timer_list_header(NULL, now);
+	timer_list_header(ctx);
 
 	for_each_online_cpu(cpu)
-		print_cpu(NULL, cpu, now);
+		print_cpu(ctx, cpu);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
-	timer_list_show_tickdevices_header(NULL);
+	timer_list_show_tickdevices_header(ctx);
 	for_each_online_cpu(cpu)
-		print_tickdevice(NULL, tick_get_device(cpu), cpu);
+		print_tickdevice(ctx, tick_get_device(cpu), cpu);
 #endif
-	return;
+}
+
+void sysinfo_timer_list_show(enum sysinfo_context si_ctx)
+{
+	struct tlctx ctx = { .si_ctx = si_ctx, };
+
+	sys_timer_list_show(&ctx);
+}
+
+void sysrq_timer_list_show(void)
+{
+	struct tlctx ctx = {};
+
+	sys_timer_list_show(&ctx);
 }
 
 #ifdef CONFIG_PROC_FS
 static int timer_list_show(struct seq_file *m, void *v)
 {
 	struct timer_list_iter *iter = v;
+	struct tlctx ctx = {
+		.seq_file	= m,
+		.ts_mono	= iter->now,
+	};
 
 	if (iter->cpu == -1 && !iter->second_pass)
-		timer_list_header(m, iter->now);
+		timer_list_header(&ctx, iter->now);
 	else if (!iter->second_pass)
-		print_cpu(m, iter->cpu, iter->now);
+		print_cpu(&ctx, iter->cpu);
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	else if (iter->cpu == -1 && iter->second_pass)
-		timer_list_show_tickdevices_header(m);
+		timer_list_show_tickdevices_header(&ctx);
 	else
-		print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
+		print_tickdevice(&ctx, tick_get_device(iter->cpu), iter->cpu);
 #endif
 	return 0;
 }



