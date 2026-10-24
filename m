Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808239;
	b=vuWXS/23Y1koPgFSPv332CGaH2m5b/euKpuNirtRqXmSCuUxsg98xiYiTI7vEIogsiq8
	 3mDRzq+9K0qOH4IMNe4IzzDO/U0SzAO7+CeiUVVcDEtV9UdCu3pwhL2bOcJcaebopWXg7
	 g6MOsSYB+DodLtH7G3D3g4Lo9cnAHxDtl5bYdjXxkIF8GDJCLNBtav/jQV/u+caFpS62q
	 S6uT+QJz93TSaHPX6ZgRZRl2vIiuECR5qRE2dFv0iwpUuCIiC72bR3BFgzbt2RBXvOM6k
	 iEUtLV1+b9OpxMP8twxwW1dO6qRjRwZLbHFCdE3Ba51dYOE4Yw6zILINF/VO4YNzfPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sKQqsqdhP/+ZzWj7/b6BcIyYnh9cafeLlGF2GvkuE0E=;
	b=FsLkcrTIMD59ZDVHbqjIJur9s+6BuKyfgR8ZaR4QrbfR7ArUokWyI9TDu5iNVgD47SUp
	 emFQB13h4oRaYqaVRj41mkdTPQRquxZvSin3msK1E12iW48WTEBEfijT01RYAXtCBiAlw
	 y12CcN0Fre9b36uwgQifAfqcVXEiKo03zmKwzGQCxjwuUareoPH9SC36/0SHbyhKEz52y
	 CzSw0MVk8cIZvwRyi5lsP1Hkg5GpP2Qr0AETINvATKaV/V+xCu+aus1Rs+/vI+Lqvfo+Q
	 y7JZ018nElnGr4yx19Xm+7z61096cXv4/HC6QBwiIZ2h4Upae5oYBDiSuvfOC8p7ToQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3o9ccYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D9606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3o9ccYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737FF1F01825;
	Sat, 24 Oct 2026 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792808238;
	bh=sKQqsqdhP/+ZzWj7/b6BcIyYnh9cafeLlGF2GvkuE0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3o9ccYF3S7IyyjvgUBVr1rIrydfZh+zjiJ/KIfgqhD+yWSz9Ii4gqp95jo3WKrww
	 fyxu5iPT3J5qyM6GFNWvmy8wDw9OqVFxxkfMu/LZJbxMMuHhTb7Gey8jP6tRPoZTub
	 kSTt0TV3TpzhvkqygTl8lN10v4eDu9FvSz7EVWheXYwpB8vormXh2L0uTgRpppVLfE
	 J+pG4gD1vN+B8tg5Mru1cwH+Glz3DlwN0d2iVQlnNFky3PbJsVz9nwpJqWldGzdhkj
	 78QffUwD06jo5liwjV1eAuRqRVIjONX8EMFHhBFn49d1+GAAL7+XI2cp1AJy9PHJ7U
	 DqSi00Ydzm+oA==
Message-ID: <sashiko-outbox-183513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261024015614.3095251-5-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
 <20261024015614.3095251-5-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 02:17:18 +0000
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
- [Medium] tracing/osnoise: broken state on signal restart in timerlat_fd_r=
ead()
- [Medium] tracing/osnoise: migration check precedes fd validation in timer=
lat_fd_read()
--

commit 8df487d33bcb20519b9ce641f525b512ec06fe1d
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Per-cpu mutexes and fd detachment

This commit introduces per-CPU mutexes to synchronize kthread and timerlat =
fd
lifecycle operations and replaces the SIGKILL mechanism for detaching
user-space timerlat threads with a mutex-protected fd detachment mechanism.

> diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trac=
e/timerlat-tracer.rst
> index 68d429d454a54..ea94627e821b5 100644
> --- a/Documentation/trace/timerlat-tracer.rst
> +++ b/Documentation/trace/timerlat-tracer.rst
> @@ -220,8 +220,9 @@ After reporting the total latency, timerlat will rest=
art the cycle, arm
>  a timer, and go to sleep for the following activation.
> =20
>  If at any time one of the conditions is broken, e.g., the thread migrates
> -while in user space, or the timerlat tracer is disabled, the SIG_KILL
> -signal will be sent to the user-space thread.
> +while in user space, or the timerlat tracer is disabled, the fd will be
> +detached from the tracer, and subsequent usage will fail with EINVAL.
> +Note that older kernels may deliver a SIGKILL instead.
> =20
>  Here is an basic example of user-space code for timerlat::
> =20
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 40cbabb98a1ba..f383bc4df6b7b 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -2498,12 +2574,13 @@ static ssize_t
>  timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>  		  loff_t *ppos)
>  {
> -	long cpu =3D (long) file->private_data;
> +	struct fd_data *fdd =3D file->private_data;
>  	struct osnoise_variables *osn_var;
>  	struct timerlat_variables *tlat;
>  	struct timerlat_sample s;
>  	s64 diff;
>  	u64 now;
> +	int ret =3D 0;
> =20
>  	migrate_disable();
> =20
> @@ -2514,13 +2591,13 @@ timerlat_fd_read(struct file *file, char __user *=
ubuf, size_t count,
>  	 * we can do about it.
>  	 * So, if the thread is running on another CPU, stop the machinery.
>  	 */
> -	if (cpu =3D=3D smp_processor_id()) {
> +	if (fdd->cpu =3D=3D smp_processor_id()) {
>  		if (tlat->uthread_migrate) {
>  			migrate_enable();
>  			return -EINVAL;
>  		}
>  	} else {
> -		cpu_tmr_var(cpu)->uthread_migrate =3D 1;
> +		cpu_tmr_var(fdd->cpu)->uthread_migrate =3D 1;
>  		osnoise_taint("timerlat user thread migrate\n");
>  		osnoise_stop_tracing();
>  		migrate_enable();
> @@ -2529,6 +2606,13 @@ timerlat_fd_read(struct file *file, char __user *u=
buf, size_t count,
> =20
>  	osn_var =3D this_cpu_osn_var();
> =20
> +	/* In normal usage, this should always be uncontended. */
> +	mutex_lock(&tlat->detach_lock);
> +	if (fdd !=3D osn_var->fdd || current !=3D fdd->thread) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}

[Severity: Medium]
In timerlat_fd_read(), the CPU migration check runs before acquiring
tlat->detach_lock and before verifying that fdd =3D=3D osn_var->fdd and
current =3D=3D fdd->thread.

Because stop_kthread() now detaches the fd via timerlat_fd_detach() instead
of sending SIGKILL, the user-space thread stays alive with an open file
descriptor after detachment. If that thread later migrates to another CPU
and calls read() on the detached fd (or if another thread sharing the file
table calls read() on a CPU other than fdd->cpu), timerlat_fd_read() takes
the fdd->cpu !=3D smp_processor_id() branch:

	cpu_tmr_var(fdd->cpu)->uthread_migrate =3D 1;
	osnoise_taint("timerlat user thread migrate\n");
	osnoise_stop_tracing();

This taints the tracer, stops tracing (or panics if OSN_PANIC_ON_STOP is
set), and leaves cpu_tmr_var(fdd->cpu)->uthread_migrate set to 1. Because
fdd is already detached (fdd !=3D osn_var->fdd), a subsequent close() in
timerlat_fd_release():

	mutex_lock(&osn_var->lock);
	if (fdd =3D=3D osn_var->fdd)
		timerlat_fd_detach(fdd);
	mutex_unlock(&osn_var->lock);

will not call timerlat_fd_detach() to zero tlat->zero, and
timerlat_fd_open() does not clear tlat->uthread_migrate either, leaving new
timerlat fd sessions on fdd->cpu broken until the tracer is restarted.

Also, Documentation/trace/timerlat-tracer.rst states that if the thread
migrates while in user space, the fd will be detached from the tracer, but
neither trace_sched_migrate_callback() nor timerlat_fd_read() calls
timerlat_fd_detach().

Should timerlat_fd_read() validate that fdd is still attached and owned by
current before acting on migration, and should migration detach the fd?

>  	/*
>  	 * The timerlat in user-space runs in a different order:
>  	 * the read() starts from the execution of the previous occurrence,
> @@ -2563,9 +2647,6 @@ timerlat_fd_read(struct file *file, char __user *ub=
uf, size_t count,
>  			}
>  		}
>  	} else {
> -		tlat->tracing_thread =3D false;
> -		tlat->thread =3D current;
> -
>  		/* Annotate now to drift new period */
>  		tlat->abs_period =3D hrtimer_cb_get_time(&tlat->timer);
> =20
> @@ -2573,7 +2654,19 @@ timerlat_fd_read(struct file *file, char __user *u=
buf, size_t count,
>  	}
> =20
>  	/* wait for the next period */
> -	wait_next_period(tlat);
> +	if (wait_next_period(tlat) < 0) {
> +		if (signal_pending(current))
> +			ret =3D -ERESTARTSYS;
> +		else
> +			ret =3D -EINVAL;
> +
> +		goto out;
> +	}

[Severity: Medium]
What happens when wait_next_period() in timerlat_fd_read() is interrupted by
a signal and returns -ERESTARTSYS?

Before calling wait_next_period(), timerlat_fd_read() has either set
osn_var->sampling =3D 1 (on the first read) or already recorded the
THREAD_URET latency sample for the previous wakeup (on subsequent reads).
Inside wait_next_period(), tlat->abs_period is advanced to next_abs_period,
and when signal_pending(current) is true, the timer is cancelled via
hrtimer_cancel(&tlat->timer) and -1 is returned:

	if (tlat->detach || signal_pending(current)) {
		hrtimer_cancel(&tlat->timer);
		return -1;
	}

When the read() syscall is restarted (or retried by user space after EINTR),
osn_var->sampling is still 1, so timerlat_fd_read() enters the
if (likely(osn_var->sampling)) branch at the top of the function:

	if (likely(osn_var->sampling)) {
		now =3D ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
		diff =3D now - tlat->abs_period;

		/*
		 * it was not a timer firing, but some other signal?
		 */
		if (diff < 0)
			goto out;

		s.seqnum =3D tlat->count;
		s.timer_latency =3D diff;
		s.context =3D THREAD_URET;

		record_timerlat_sample(&s);

While now is still earlier than the future tlat->abs_period, diff < 0 is
true and timerlat_fd_read() jumps to out and returns 0 (EOF) without arming
the timer or sleeping. Once now reaches tlat->abs_period, diff >=3D 0 and
timerlat_fd_read() records a bogus or duplicate THREAD_URET sample and
checks stop_tracing_total for a timer activation that was cancelled and
never fired.

Does timerlat_fd_read() need to avoid treating the next read() after a
signal interruption as a wakeup from a completed timer cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024015614.3095=
251-2-crwood@redhat.com?part=3D4
