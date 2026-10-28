Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226009;
	b=06yzdDvdi4aw9cSd7EsEDb0RR4kaL5FnWX3W0kl94J2YAa7vXN35NVv/meKGIux6qk9o
	 vrFGkN996rfkO0xfmbBrIg7fFAWPncrJqvEpWqNrLVqXvXjZMSp7EngqKFFsJptPg+I+c
	 rjW865Jt0c+T0JIsfbkYrwDYxVN9mNdgf0X06fta8i7JPnzt5/PpY8c/DaPsoSlhTNNR5
	 Hbw8nhOVyDV5t1YBy9mzAzv9c/YKOg7nrDbfQ8PvOQNVcwLmQHugaLsxH07yHQzf1guay
	 OPM7YR+sbpH/k+BQrHez3N9tcwV5LBOi+mmN5ciDn1s57moAlB/Fq3B3M87hm3Dhn7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fHcB4v60yE+Oat6YGu27Gl0YyJrA819CGBN27TxmeeY=;
	b=JgpJ/7Eet6uHBu1pfV08JRhYu5Z0Y/cnoUlQE1HaGIsV112iqZvE6DHLBnJJBE9T8ls7
	 ZAbJfLbMBgXkFZ6qO27aI5vtlZWp5zxZvOxNNOX9jYH2fLhIQ+5ArxauJKBijtbUKoDZF
	 0mwn+CqPKDXhhkZ1hprPPJ02nJHwzn9BZH4nhYSc7nDfuF2s4iBt/FbNQXVosMl1M2kKB
	 wwnzIIALJiFLHx/CtER+kWoILUVMx6LKGhk9/WXXR+nqCN0QYwu9GS+ACvkjfg4wYIHQt
	 p125a5JY8dAg0ZoFq6f95uL+Q80FHpvaGl9oBr1FomsWS8zoolBBP4tSFbW0r5hcGVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddowIkj2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE67606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddowIkj2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE2E1F01825;
	Wed, 28 Oct 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226009;
	bh=fHcB4v60yE+Oat6YGu27Gl0YyJrA819CGBN27TxmeeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddowIkj2V1z85xmb8ovNqHi0QcxAYizdfxUbFGB64gTFxL5Sf9+JX6T5r+Cosn90K
	 6Y3r1h86T3fO4pAuHY5kp8tMKgVBA09B4jvgZCdPsW/fqZOtqmMCjkkqhL+ip4vGxG
	 m7XQqc8miCGvpktD3Gcb50JKCjG/gSetqQZ6kIQFerb2UM50JF2tnglZPuAVzaWa6X
	 m/Xyiyd3GEAy+3JgClWR90JB9EWyMzhsLn0Hvn6XKBiaIxlAXqmNjuess53Om6h1Fy
	 jF39sPEJWtr0M8a4qmh5i6c6gNA9rWdZkG2iLgjQ4PU5VN+TvmQYbn6UOvucsfpv11
	 2rF+7kA+3dRqQ==
Message-ID: <sashiko-outbox-188496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261028220120.4005187-6-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
 <20261028220120.4005187-6-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:20:08 +0000
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
- [Medium] tracing/osnoise: unreachable migration handling in timerlat_fd_r=
ead()
- [Medium] tracing/osnoise: stale tracing_thread after signal in timerlat_f=
d_read()
--

commit fc0df59115a148fd84654dadbdbb8ffa3b889971
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Per-cpu mutexes and fd detachment

This patch introduces per-CPU mutexes in osnoise_variables and
timerlat_variables to synchronize kthread lifecycle and file descriptor
open, close, and detachment, replacing the previous SIGKILL mechanism
for user-space timerlat threads.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 791a9103c2ec0..cd386c75926e4 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -2496,37 +2572,44 @@ static ssize_t
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
>  	tlat =3D this_cpu_tmr_var();
> +	osn_var =3D this_cpu_osn_var();
> +
> +	/* In normal usage, this should always be uncontended. */
> +	mutex_lock(&tlat->detach_lock);
> +	if (fdd !=3D osn_var->fdd || current !=3D fdd->thread) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	/*
>  	 * While in user-space, the thread is migratable. There is nothing
>  	 * we can do about it.
>  	 * So, if the thread is running on another CPU, stop the machinery.
>  	 */
> -	if (cpu =3D=3D smp_processor_id()) {
> +	if (fdd->cpu =3D=3D smp_processor_id()) {
>  		if (tlat->uthread_migrate) {
> -			migrate_enable();
> -			return -EINVAL;
> +			ret =3D -EINVAL;
> +			goto out;
>  		}
>  	} else {
> -		cpu_tmr_var(cpu)->uthread_migrate =3D 1;
> +		cpu_tmr_var(fdd->cpu)->uthread_migrate =3D 1;
>  		osnoise_taint("timerlat user thread migrate\n");
>  		osnoise_stop_tracing();
> -		migrate_enable();
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto out;
>  	}

[Severity: Medium]
In timerlat_fd_open(), fdd is stored only in the osnoise_variables for
fdd->cpu.

In timerlat_fd_read(), osn_var and tlat are fetched via this_cpu_osn_var()
and this_cpu_tmr_var() for smp_processor_id(). If the user-space thread
migrated to another CPU before calling read(), osn_var belongs to the new
CPU, where osn_var->fdd cannot match fdd.

Because fdd !=3D osn_var->fdd is checked before fdd->cpu =3D=3D smp_process=
or_id(),
won't a migrated thread always lock the new CPU's detach_lock and bail out
at the fdd !=3D osn_var->fdd check, making the else branch that sets
cpu_tmr_var(fdd->cpu)->uthread_migrate, calls osnoise_taint(), and stops
tracing via osnoise_stop_tracing() unreachable?

> @@ -2561,9 +2644,6 @@ timerlat_fd_read(struct file *file, char __user *ub=
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
> @@ -2571,7 +2651,20 @@ timerlat_fd_read(struct file *file, char __user *u=
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
> +		osn_var->sampling =3D false;
> +		goto out;
> +	}

[Severity: Medium]
If timerlat_irq() fires in hardirq context while the thread is in
wait_next_period(), it sets tlat->tracing_thread =3D true:

kernel/trace/trace_osnoise.c:timerlat_irq() {
	...
	/*
	 * Enable the osnoise: events for thread an softirq.
	 */
	tlat->tracing_thread =3D true;
	...
}

If a signal is also pending before wait_next_period() checks
signal_pending(current), wait_next_period() returns -1 and timerlat_fd_read=
()
clears osn_var->sampling =3D false, but leaves tlat->tracing_thread set to
true.

Since tlat->tracing_thread =3D false was removed from the !osn_var->sampling
branch above, if the read() is restarted or called again, it sets
osn_var->sampling =3D 1 with tlat->tracing_thread still true before entering
wait_next_period(). While sleeping for the next timer activation, won't
timerlat_thread_exit() and timerlat_softirq_exit() see both osn_var->sampli=
ng
and tlat->tracing_thread as true and emit spurious noise events before the
timer expires?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028220120.4005=
187-1-crwood@redhat.com?part=3D5
