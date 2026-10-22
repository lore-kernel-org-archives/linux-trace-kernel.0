Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647848;
	b=zGv9IHu0ZUFR1PQRowFxfZM2mi09V+/HWBRN/tR6xL1ScAuD7UIsCXG4lLwP2opXUGUY
	 WKdhZPuWz1mmTfqW3PFJZ7736v37qHgz8nGAQobwiZveTBD4gPPXYiY2eX2YgOCLgiLrh
	 pi0MStx2vus8BoVIjx0elftke7DZB5bxklmk0nKD131dj5M3HAeDnGdQFoXC/fF0E8jkH
	 JAXaxSsGWqhLaUUa8CG3eRPo16QmZVihk16QjzX3cW5XmXUm6TQ+ABwmc3XGKoKjuixB0
	 bTti1JMEcJBybuqxIhnLBFuvrseR8cENmiiurTQ9aU2HWlVhpXTzNoGzbjVl7hMTR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NsdmW8PWZUZE173bOjBuVwed0SqHsylhNMAUviaHF6E=;
	b=TlBxpkXebdXRJCzxnFdrixAZ9jHzs3NXv6akp4ARHklWtdSSHVDRisAtI4wkeD3Z0yBu
	 PSJ9tdEN2rFMpi4ZSVaTAaJae1e+cLp4+s1KniMK/Crfc8ykYq/qOH7pVlBDdEYk6OXiu
	 CnIk29XYRujL/WpDi0Tt7TOPhSlAByO4v0bPLiMhB5ovC0ixVzqgXXjWZyMKsZhKjEyWQ
	 nWtocmEjfMadEx+HQPHYrxo0F09hFTXarIU6mZ00B4yGnW4IrzW2c7cA7td2ZJJfB+35F
	 ygg1dVjIf51BgqYcb1tj2Ukaz6g4+SVs+0XYAyK6IBgz5gJgaB2hPK26rzw57vpMd4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwK9Pho+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F9606A319;
	Thu, 22 Oct 2026 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwK9Pho+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0509D1F000C1;
	Thu, 22 Oct 2026 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792647847;
	bh=NsdmW8PWZUZE173bOjBuVwed0SqHsylhNMAUviaHF6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwK9Pho+FjN8JsBd3jH7ukVm33CieIpHsAJhRAfuRRs6zmhgnzxSRAO745HHopRun
	 K2K05bHS5yO3ks7xqu1KGtU5HlBiz25z7wWyeEau6gRK4Rj1/rNAIIGyxemw/WiyTI
	 KmjKqVMwQRKybOoGYnMpctmrhrVoCAJL/ecl+kPjljbG+j5ofIJxAqkdB8YRxKJg6F
	 wnwXXCBYtRLWDML7DU6Q28+OpGIX6BUqtvhGUWXA18i9TA3187mhNqH0KrSavyIpdk
	 2iphvFc/WPBKIFtQqgr3GrylPAOTqK6qqF2ZgSuQcsggLPc+6GPhxSeJuYgaiaKD/V
	 //3AonXfxYCyA==
Message-ID: <sashiko-outbox-181037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] tracing/irq: Add generic IRQ context boundary
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022050712.75035-2-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
 <20261022050712.75035-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 05:44:06 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] softirq: tick_irq_exit() called before trace_hardirq_context_exi=
t() handoff
--

commit 2beb0d9dac0a7b76bfe5b73b550fff3be238bbab
Author: Karl Mehltretter <kmehltretter@gmail.com>

tracing/irq: Add generic IRQ context boundary events

This commit adds tracepoints at the generic hardirq and serving-softirq
context boundaries. It also updates softirq pending snapshots and wakes
worker threads when callbacks attached to boundary events raise new work.

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index be49e6469f3ad..2e3b6fd3f6d5d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c

[ ... ]

> @@ -722,6 +770,7 @@ void irq_enter_rcu(void)
>  		tick_irq_enter();
> =20
>  	account_hardirq_enter(current);
> +	trace_hardirq_context_entry(hardirq_count() >> HARDIRQ_SHIFT);
>  }
> =20
>  /**
> @@ -796,6 +845,36 @@ static inline void __irq_exit_rcu(void)
>  		wake_timersd();
> =20
>  	tick_irq_exit();
> +	if (trace_hardirq_context_exit_enabled()) {
> +		bool ksoftirqd_wake_requested =3D false;
> +		bool timersd_wake_requested =3D false;
> +
> +		trace_hardirq_context_exit(hardirq_count() >> HARDIRQ_SHIFT);
> +
> +		/* Hand work raised by the final boundary event to its worker. */
> +		if (hardirq_count() =3D=3D HARDIRQ_OFFSET) {
> +			if (irq_count() =3D=3D HARDIRQ_OFFSET &&
> +			    unlikely(local_softirq_pending()) &&
> +			    should_wake_ksoftirqd()) {
> +				wakeup_softirqd();
> +				ksoftirqd_wake_requested =3D true;
> +			}
> +
> +			if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) &&
> +			    force_irqthreads() && local_timers_pending_force_th()) {
> +				wake_timersd();
> +				timersd_wake_requested =3D true;
> +			}
> +
> +			/* The timersd wakeup can itself raise a softirq. */
> +			if (timersd_wake_requested &&
> +			    !ksoftirqd_wake_requested &&
> +			    irq_count() =3D=3D HARDIRQ_OFFSET &&
> +			    unlikely(local_softirq_pending()) &&
> +			    should_wake_ksoftirqd())
> +				wakeup_softirqd();
> +		}
> +	}
>  	preempt_count_sub(HARDIRQ_OFFSET);
>  }

[Severity: Medium]
Should tick_irq_exit() be called after the trace_hardirq_context_exit()
block rather than before it?

In irq_enter_rcu(), tick_irq_enter() runs before
trace_hardirq_context_entry() so that the nohz clock wakeup and idle
cputime accounting state are established before the entry event fires.

In __irq_exit_rcu(), however, tick_irq_exit() runs before
trace_hardirq_context_exit() and the subsequent wakeup_softirqd() and
wake_timersd() calls:

kernel/softirq.c:tick_irq_exit() {
	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cp=
u)) {
		if (hardirq_count() =3D=3D HARDIRQ_OFFSET)
			tick_nohz_irq_exit();
	}
}

kernel/time/tick-sched.c:tick_nohz_irq_exit() {
	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);

	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
		tick_nohz_clock_sleep(ts);
		ts->idle_entrytime =3D ktime_get();
		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
			kcpustat_irq_exit(ts->idle_entrytime);
	} else {
		tick_nohz_full_update_tick(ts);
	}
}

On an idle cpu where need_resched() is false before the tracepoint,
tick_irq_exit() calls tick_nohz_irq_exit(), which places sched_clock and
kcpustat back into idle sleep via tick_nohz_clock_sleep() and
kcpustat_irq_exit(). If the hardirq_context_exit callback then raises work
and wakes ksoftirqd or ktimerd, try_to_wake_up() reads sched_clock_cpu()
and sets need_resched after the idle clock and cputime state have already
gone to sleep.

Similarly, on a nohz_full cpu, tick_nohz_irq_exit() calls
tick_nohz_full_update_tick() to evaluate and potentially stop the tick
before trace_hardirq_context_exit() runs. Any timer, softirq, rcu, or
irq_work state raised by the exit callback is missed by that evaluation,
or forces an extra self-ipi when waking ksoftirqd after the tick was just
stopped.

Would moving tick_irq_exit() to just after the
trace_hardirq_context_exit_enabled() block (while hardirq_count() is still
equal to the outermost offset) avoid this regression and keep entry and
exit symmetric?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022050712.7503=
5-1-kmehltretter@gmail.com?part=3D1
