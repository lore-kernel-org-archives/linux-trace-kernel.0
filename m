Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226243;
	b=QG/xvB9xcw0rNmuiDwQwtMQBFNoX1UhV+uOVMJ0E9WR5+R2yalvQ72n6WU58DeMe/Tbj
	 WfJ/6o36i8NWac40x3AfNOWax7CDz52vnealhy66KuRQs2LMRbt66D+jjKpnwEeE3oLov
	 Q7RAh4AUtv9ZcO2xebvKzorQc3ntaiQJkPgKq3KSK10n9lt9rZWm3NLUelfNOCh7/R3tW
	 tqr0DT4OisQJ7IyyPVSMOgxVnDBwlQucOsIkSGdrgPK7Qwo/bhb8LyHPAEUHbxtqoX71H
	 Ne2nx3mRlfD5uLn/XTW+y8VertRcM5xOpej+4Bdau3bqV3roP5IKpQo1i/z3wxeNVAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TwvgzAdEr20eUmNpzrmKJfdu9EJe6GS1KE3+2fR27iU=;
	b=fPi++QwRdu6AMASt6F3POm6K9SOJDEiD6+0dquCLikd077zlghhBk+6okGRVxa8sOKS1
	 iEL9uHbreySu+W6Z8PmPSlwWKklfPn62XTTGb96YqVQdzs1Cegw6V2mAoNn/E8wrvEx9s
	 XVnz4LcYgFBTg39dK+z6mn6EtUreWSHbjKkRuvWBo9HuaR0mbXG9jos81PxDTGyg/jwZ1
	 bSoKyYkIQ7d/Yr6lVYZ7aaSbPFQGY0QPqRq4/7nPTh5jDGADkGwT2jjRdVqcnGmhl6uMz
	 qxoCdVF/wd7o0bpEMICzW1Z2bE2VqVeV1FAQ0w1zCB1dnz5IYpVvzHhAz4xnfV9nmzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy877mHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E1606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy877mHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0551F01825;
	Wed, 28 Oct 2026 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226242;
	bh=TwvgzAdEr20eUmNpzrmKJfdu9EJe6GS1KE3+2fR27iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jy877mHf7sbZoBDKLysEJKGyjqPcAPf7EQTOFIyZAXni2QX7fCvXgviUEBHc7Pvo8
	 X9IMevbClxGWVQiYuw1rvsOR50ZM8Xm63sia4I/Fby4ghbht2T6WtUbsYhf6SN2Db5
	 g8yJ4V4D118eb+QHRymbVNgoKewBhm7vgGuxWOmN3T4Lq7reb0CtSEMgiiT3ZlOYwl
	 5Y+kSxoj4YmZzlsKGYwLQ0W/lKocJuvfiLhViSkztVKMOflQi0OdIE6RgxrPoyoJmD
	 lJwyEaErq/zxtwqMKAyig2jnQkQ75Sy85+5doV2ehLnCxqMmbNhK62coT4ZGiNvHNu
	 rA8Wg8i8Ing4A==
Message-ID: <sashiko-outbox-188499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] tracing/osnoise: Split out per-cpu variable
 resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261028220120.4005187-7-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
 <20261028220120.4005187-7-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:24:01 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tracing/osnoise: unreset delta_start and arrival_time in osn_res=
et_cpu()
- [Medium] tracing/osnoise: race on osn->pid in timerlat_fd_detach() vs mig=
ration check
--

commit fffc251bf1aed17ce8e75b3b4c7d5990c0ecad11
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Split out per-cpu variable resets

This commit splits per-CPU variable resets out of osn_var_reset() and
tlat_var_reset() into osn_reset_cpu() and tlat_reset_cpu(), resetting
per-CPU state whenever stopping a kthread or detaching an fd. It also moves
the interrupt and thread tracking structures out of the zeroed group in
struct osnoise_variables.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index cd386c75926e4..1abe2c3507f76 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -237,15 +237,15 @@ struct osnoise_variables {
>  	struct mutex		lock; /* covers kthread and fdd changes */
>  	struct task_struct	*kthread;
>  	struct fd_data		*fdd;
> +	struct osn_nmi		nmi;
> +	struct osn_irq		irq;
> +	struct osn_softirq	softirq;
> +	struct osn_thread	thread;
> +	local_t			int_counter;
> =20
>  	struct_group(zero,
>  		bool			sampling;
>  		pid_t			pid;
> -		struct osn_nmi		nmi;
> -		struct osn_irq		irq;
> -		struct osn_softirq	softirq;
> -		struct osn_thread	thread;
> -		local_t			int_counter;
>  	);
>  };

[Severity: Medium]
Can moving nmi, irq, softirq, and thread out of struct_group(zero, ...)
without resetting their delta_start and arrival_time fields in
osn_reset_cpu() leave stale non-zero timestamps across runs?

In addition to count, struct osn_nmi, struct osn_irq, struct osn_softirq,
and struct osn_thread contain arrival_time and delta_start. A non-zero
delta_start is used to detect an active window in
cond_move_irq_delta_start(), cond_move_softirq_delta_start(),
cond_move_thread_delta_start(), and timerlat_irq():

    if (!IS_ENABLED(CONFIG_PREEMPT_RT) && osn_var->softirq.delta_start) {
        copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
                           &osn_var->softirq.delta_start);

        copy_int_safe_time(osn_var, &osn_var->softirq.delta_start,
                            &osn_var->irq.delta_start);
    }

Normally, delta_start and arrival_time are cleared to zero in
osnoise_trace_irq_exit(), trace_softirq_exit_callback(), and thread_exit().
However, all three exit callbacks return early when osn_var->sampling is
false:

    if (!osn_var->sampling)
        return;

If osn_var->sampling is cleared while a measurement window is open (for
example, when timerlat_main() exits while sampling is still true and
schedules in the next task via thread_entry() before stop_kthread() runs,
when NO_OSNOISE_WORKLOAD or timerlat_fd stops while a task is running on the
CPU, or when timerlat_tracer_stop() clears sampling from another CPU while
a softirq or IRQ is in flight), the exit callback skips clearing
delta_start and arrival_time.

On a subsequent timerlat or NO_OSNOISE_WORKLOAD run, won't a stale non-zero
osn_var->softirq.delta_start cause timerlat_irq() to misdetect softirq
preemption and overwrite thread.delta_start on every period, or a stale
osn_var->thread.delta_start corrupt the first thread_exit() duration?

[ ... ]

> @@ -2452,25 +2452,22 @@ static void timerlat_fd_detach(struct fd_data *fd=
d)
>  	if (WARN_ON(fdd !=3D osn->fdd))
>  		return;
> =20
> -	WARN_ON(osn->kthread);
>  	WARN_ON(fdd->thread !=3D tlat->thread);
>  	tlat->detach =3D true;
>  	wake_up_process(tlat->thread);
> =20
>  	mutex_lock(&tlat->detach_lock);
> =20
> -	osn->sampling =3D 0;
> -	osn->pid =3D 0;
> -
>  	WARN_ON_ONCE(hrtimer_active(&tlat->timer));
>  	hrtimer_cancel(&tlat->timer);
>  	put_task_struct(fdd->thread);
> =20
>  	fdd->thread =3D NULL;
> +	tlat->thread =3D NULL;
>  	osn->fdd =3D NULL;
> -	memset(&tlat->zero, 0, sizeof(tlat->zero));
> =20
>  	mutex_unlock(&tlat->detach_lock);
> +
>  }

[Severity: Medium]
Does removing osn->pid =3D 0 from timerlat_fd_detach() open a race window
with trace_sched_migrate_callback() before osn_reset_cpu() runs?

In timerlat_fd_detach(), waking tlat->thread and unlocking
tlat->detach_lock allows the user thread in timerlat_fd_read() to finish
its read path, call migrate_enable(), and return to userspace (or get
pushed off a dying CPU during hotplug via osnoise_cpu_die() ->
stop_kthread() -> timerlat_fd_detach()) before the caller invokes
osn_reset_cpu(cpu) to zero osn->pid.

While osn->pid still holds the detaching thread's PID,
trace_sched_migrate_callback() checks osn_var->pid locklessly:

    osn_var =3D cpu_osn_var(cpu);
    if (osn_var->pid =3D=3D p->pid && dest_cpu !=3D cpu) {
        cpu_tmr_var(cpu)->uthread_migrate =3D 1;
        osnoise_taint("timerlat user-thread migrated\n");
        osnoise_stop_exception("timerlat user-thread migrated", cpu);
    }

If the detached thread migrates in that window before osn_reset_cpu()
clears osn->pid, won't trace_sched_migrate_callback() falsely taint and
stop tracing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028220120.4005=
187-1-crwood@redhat.com?part=3D6
