Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D9380FD4;
	Mon,  1 Jun 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296907; cv=none; b=iUMqWd8MwGTm4x0NhhR6tjrzkHU7pVfLuN794a5mKYJD8aNTfXjljGcGgpCak9/uKLZa0bZziO8qq/2megAPhUvT8EXIUm5EDmlEv9xzRxXmMc1Ap7wlyTOMBhCU4Hbuk/JbS5qgOkoJnL3PD5W13ELo9zQlG2Aw429SuBcAcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296907; c=relaxed/simple;
	bh=clxMj4h/adU4SqPnP0J3bUGl70jU3KyrQhkVP8gNGjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipKet4E18IdbwVZInv1iKrYbbK4kZH5+U58/nMlk11YF1qXs2C088fnXoj9055jxfS68+elQ/FEI0cVl8Z90X6KXh64u8PAzR+PGnxJPY2Izl0SysCtdJ8l7d5Svd5xuN3mcCneTWSuptzjHW+pWs3T4k7vEao1EtjbAR/ri6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqcGvKwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQK6akcg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqcGvKwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQK6akcg"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780296904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDWJFbAxnYGoMvgIhIVCHmSIfL/HIrGtvNmSl+ZA7JU=;
	b=CqcGvKwJdhT+NCNII10YGS7sug6ZJuZfqe7G4Emczzw7i6iGefIjxFCw43swapBFPFjqd9
	yewhtbSvbEsHP2YkGWy303na30+iDXosmK1jvUUOxE1i+qbZkIx1dLN3cewc/LVOwVPuNh
	yH2AwjR9woMzmZ9aYd3K897feL0FAptmBJWvfUGcCejh1RMFvQjh7tDCKASb++aobHnZ/m
	BHBKJzxMGfduLKMzWUJng4z0QR3Pl/iEdbKauAAHbKg0ejtc96bxh9mMukj6MD3bEGqGjd
	BADL3+ACNRJgU9UJkUHvX0niO8vvgdFUr1G4jlgaKwdeijoMTDg6IcI1WNh0+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780296904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDWJFbAxnYGoMvgIhIVCHmSIfL/HIrGtvNmSl+ZA7JU=;
	b=SQK6akcgMW1amRhI7HAo98YI4YGzGd0MBvkpPd1zoNJ0r8EqGb+h4f8rxZq6ZWIuUTa1t2
	8p9P9TBh58M5zVBA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 05/13] rv: Fix monitor start ordering and memory
 ordering for monitoring flag
In-Reply-To: <20260530141652.58084-6-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-6-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 08:55:04 +0200
Message-ID: <87ik82ycl3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> From: Wen Yang <wen.yang@linux.dev>
>
> da_monitor_start() set monitoring=1 before calling da_monitor_init_hook(),
> may racing with the sched_switch handler:
>
>   da_monitor_start()               sched_switch handler
>   -------------------------        ---------------------------------
>   da_mon->monitoring = 1;
>                                    if (da_monitoring(da_mon))  /* true  */
>                                        ha_start_timer_ns(...);
>                                        /* hrtimer->base == NULL, crash */
>   da_monitor_init_hook(da_mon);
>   /* hrtimer_setup() sets base */
>
> Fix the ordering and pair with release/acquire semantics:
>
>   da_monitor_init_hook(da_mon);
>   smp_store_release(&da_mon->monitoring, 1);    /* da_monitor_start()  */
>   return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()     */
>
> On ARM64 a plain STR + LDR does not form a release-acquire pair, so
> the load can observe monitoring=1 while hrtimer->base is still NULL.
> The plain accesses are also data races under KCSAN.
>
> Use WRITE_ONCE for the monitoring=0 store in da_monitor_reset() to
> cover the reset path.
>
> Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/rv/da_monitor.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index a7e103654..60dc39f26 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -82,7 +82,7 @@ static void react(enum states curr_state, enum events event)
>  static inline void da_monitor_reset(struct da_monitor *da_mon)
>  {
>  	da_monitor_reset_hook(da_mon);
> -	da_mon->monitoring = 0;
> +	WRITE_ONCE(da_mon->monitoring, 0);
>  	da_mon->curr_state = model_get_initial_state();
>  }

Looking at this again, do you need to change it to

static inline void da_monitor_reset(struct da_monitor *da_mon)
{
	WRITE_ONCE(da_mon->monitoring, 0);
        smp_mb();
	da_monitor_reset_hook(da_mon);
	da_mon->curr_state = model_get_initial_state();
}

To prevent another task from seeing monitoring=1 while the timer is
already cancelled?

Nam
