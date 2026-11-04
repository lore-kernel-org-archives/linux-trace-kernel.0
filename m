Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760564;
	b=ZnQE5uut66fjVK2MieCxk/QzggCmRpif/D+jK3W5PBh1GbzCWr5QVfPr7LaaldlBkXpc
	 YObK5MblZEZgwOGbqIsJrWLv003wIIN01f91qnXhV5Klg2IxX8Dez/XHAAnfF78RO0kba
	 snVxRIWQcsvl181FvIoql2onmPZ6BaX7tlR/uQ1totCMeYeyMTO4IHnQY02PglV+2c2jF
	 R2ZUo64s7MAJYH2Uh1NEiJtKXlDuSxw4dX9J0aX/27MOkoGgjf7/fwWXnM2+9nVesPoD7
	 hG210RTCJiasMiwAagXwKur9RUXXKi0XfcqDs7VuXYrWLyI5Lh4kppv5BYTHOnURBVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=olZhh7KhDNcSAx3uv+MHZHd+XJ6Y2NBJSt9S/teet50=;
	b=TmGgznDZB/MuQOEfugGyrQuUJXguYhxmeMByXJCPBwvJdqlH777zf1qNYrio/z1g/cka
	 Ok/JZ7TdP9sKeTvCnKv2YTYUPByKZ6TRAD09qoeTCNMBq/YoeSaPsYJE6epxKIYVmqyrF
	 9FK7YM0P7WZKL0O1Ut2mj0Pl5DbxGHyI2gSJb0/OOK76p1yK6sbRy0BBKSQ054G3jwsb/
	 p1W9ikYiHZORnHKy07BoLcyp70Gf2rGEXhVIjDWGdWfMEJjJMyJ8LHtmK3x6LVEgYdx7B
	 iY/SK1xsYMtVWUJ3k2ItTIK2yAli5Z1Yi1T3Lom+SJxpdtq7LTCnjmqgofBxANug42g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ8G9hjc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D0606A32C;
	Wed,  4 Nov 2026 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ8G9hjc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808A1F0093A;
	Wed,  4 Nov 2026 02:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760563;
	bh=olZhh7KhDNcSAx3uv+MHZHd+XJ6Y2NBJSt9S/teet50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZ8G9hjcgEzXEhEtYdEVwDvslVTaFOYV5Oq5m8pOGhHflRTfEc2aXUQxJFrBuJAEi
	 Vg0TRUfMJSUm/VENKMD+ntt2lq4xE8rBMYRqNIl7fqIUBKTGZAu4lYGHFt5VTY1WRW
	 6ZLok5vXty+/5BJNnQuWVjIE1XoP1DQIqmkP2j6afJoNsUNLiyyVCe8DLYS+h4MVso
	 S9Mm2OAiQi8ZQuvIGgV44tfmZx8a4+zmdfb9xeldE5qYV/fjx6U708SN6q56zLSatu
	 aRbMJEnIeGkwHcajAbIrbrN6vKQ9JQH4yLF5bzwRMvfgGSUKIBiEkbGV7EOE5uGXzX
	 B+VduoxsiIQ0w==
Message-ID: <sashiko-outbox-196526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/5] timers: Avoid blocking on hrtimer_cpu_base
 lock during Oops or panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103024453.922373-4-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:21 +0000
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
- [High] timers: incomplete !CONFIG_SMP guard in print_active_timers()
--

commit 8e788faa0cf2d16ee117d7196f09432346eeda90
Author: Aaron Tomlin <atomlin@atomlin.com>

timers: Avoid blocking on hrtimer_cpu_base lock during Oops or panic

This commit switches sysrq_timer_list_show() to use ktime_get_mono_fast_ns()
and updates print_active_timers() to use raw_spin_trylock_irqsave() on
base->cpu_base->lock when in NMI, Oops, or panic contexts so that dumping
timer state does not deadlock if a CPU is holding a timekeeping or hrtimer
base lock.

> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index 0406bf4488e9f..4973650c4ae5a 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -68,7 +68,15 @@ static void print_active_timers(struct seq_file *m, st=
ruct hrtimer_clock_base *b
> =20
>  	touch_nmi_watchdog();
> =20
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

[Severity: High]
In print_active_timers(), the outer check enters this branch when in_nmi(),
oops_in_progress, or panic_in_progress() is true, but the inner !CONFIG_SMP
check only tests in_nmi(). What happens on a !CONFIG_SMP build if an Oops or
panic occurs in non-NMI context while the CPU already holds
base->cpu_base->lock (for example, inside enqueue_hrtimer() or
__remove_hrtimer())?

When CONFIG_SMP=3Dn and CONFIG_DEBUG_SPINLOCK=3Dn, _raw_spin_trylock_irqsav=
e()
unconditionally returns 1:

include/linux/spinlock_api_up.h:_raw_spin_trylock_irqsave() {
	__LOCK_IRQSAVE(lock, *(flags));
	return 1;
}

Wouldn't that allow print_active_timers() to re-enter the critical section
and walk base->active while the timerqueue is in a partially modified state?

And when CONFIG_SMP=3Dn and CONFIG_DEBUG_SPINLOCK=3Dy, since vpanic() invok=
es
sys_info() before debug_locks_off():

kernel/panic.c:vpanic() {
	...
	sys_info(panic_print);

	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);

	if (_crash_kexec_post_notifiers)
		__crash_kexec(NULL);

	console_unblank();

	debug_locks_off();
	...
}

wouldn't do_raw_spin_trylock() hit SPIN_BUG_ON(!ret, lock, "trylock failure
on UP") when base->cpu_base->lock is already held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D3
