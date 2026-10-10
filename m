Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05521382387
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599723; cv=none; b=Cyd3PlBCvz9UEnVFV9JpJ7pH79FwcC3Cw5V/uc9dH6/yYsJl09u0AzwT+zxzA4Ua8h3nba3HJ9qFk0FyAbq7lKyBYA77uH0f13d7F8yjRuj+DCWDZkJq3zgg3y3QhFmbw+FWZvE2Kzs9ViVwT1KKlklZR7zlVTvu0e1N4V0tgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599723; c=relaxed/simple;
	bh=lwemSTfbg3LfAFhV5tM4ABEFH5aNyu0JJ6XTWTaWNWs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hh8npRKGxBE89AjwLgCcwJuyp7u5vlH03RFI3dK36VV7yOhCt+7w2osr9sdZJ9PZsXwAMIin6WH86pEbwjmidru7mHaVk8+qyH4dmkU6QS5hJxioLUY9/u68PCgmij4LScK4nc2OY8weYd2nWI/cXYO37RX9/oVIDdcxhEAx4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKGDuL1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKGDuL1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536551F000FF;
	Sat, 10 Oct 2026 02:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791599721;
	bh=pfh2m1updFyMqVZWXJXczDHed+q2d8S+d33X82Vkckg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKGDuL1g6CRVH9KE7epZKIP8E9L0C3VTHpdHO0unjesUxjUbrBsR+qzWIW7+UTzfs
	 DAVNVxzDbEoN1tasuihciKkyQ219Nv3l0y3zkZLs5IGs+m3KrHf6WCJih+gKXCRPAh
	 DYDLW8R7KEnkdDFir4GQNwDSSoHBeNtZwLATXs971ThShrE/4G19cXq3/3MbcdySu0
	 Z2xRHY7Rnfno2VZryuzjmStAkqXDRI+jTo4Fy2L50znFys/v3S1KdiNaxwiGT02aUc
	 fZvGFsHJQavDebS9Obxeupx7kxvP4oSVjq5SVtJNiEMb1PjpBVKJTSzsskMSUMpnRJ
	 s1NG9psC2ua6A==
Message-ID: <sashiko-outbox-166222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261010022338.2507589-4-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
 <20261010022338.2507589-4-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 02:35:20 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing/osnoise: sampling state is never cleared when no-workloa=
d tracer stops
--

commit f0d962e5159ec760bce6edd22ecbeb40abce0874
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Per-cpu mutexes and fd detachment

This commit cleans up synchronization issues by introducing per-cpu mutexes
for guarding kthread changes and fd open/close/revoke operations. It also
replaces a SIGKILL hack for userspace timerlat threads with a
mutex-protected detachment mechanism.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -1976,32 +2008,23 @@ static int timerlat_main(void *data)
>   */
>  static void stop_kthread(unsigned int cpu)
>  {
> -	struct task_struct *kthread;
> +	struct osnoise_variables *osn_var =3D cpu_osn_var(cpu);
> =20
> -	kthread =3D xchg_relaxed(&cpu_osn_var(cpu)->kthread, NULL);
> -	if (kthread) {
> -		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
> -		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
> -			kthread_stop(kthread);
> -		} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
> -			/*
> -			 * This is a user thread waiting on the timerlat_fd. We need
> -			 * to close all users, and the best way to guarantee this is
> -			 * by killing the thread. NOTE: this is a purpose specific file.
> -			 */
> -			kill_pid(kthread->thread_pid, SIGKILL, 1);
> -		}
> -		put_task_struct(kthread);
> -	} else {
> -		/* if no workload, just return */
> -		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
> -			/*
> -			 * This is set in the osnoise tracer case.
> -			 */
> -			cpu_osn_var(cpu)->sampling =3D false;
> -			barrier();
> -		}
> +	mutex_lock(&osn_var->lock);
> +
> +	if (osn_var->fdd) {
> +		WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options));
> +		WARN_ON(osn_var->kthread);
> +		osn_var->fdd->detach(osn_var->fdd);
> +	} else if (osn_var->kthread) {
> +		WARN_ON(!cpumask_test_and_clear_cpu(cpu, &kthread_cpumask));
> +		WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options));
> +		kthread_stop(osn_var->kthread);
> +		put_task_struct(osn_var->kthread);
> +		osn_var->kthread =3D NULL;
>  	}
> +
> +	mutex_unlock(&osn_var->lock);
>  }

[Severity: Medium]
Does this removal leave the sampling state permanently enabled when the
tracer is stopped in the no-workload configuration?

When the osnoise tracer starts without a workload (!OSN_WORKLOAD),
start_kthread() sets osn_var->sampling =3D true but exits without spawning
a kthread. Because both osn_var->kthread and osn_var->fdd remain NULL in
this mode, this new logic in stop_kthread() appears to do nothing.

The previous code had an else block that explicitly reset the sampling
flag:

    } else {
        /* if no workload, just return */
        if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
            /*
             * This is set in the osnoise tracer case.
             */
            cpu_osn_var(cpu)->sampling =3D false;
            barrier();
        }
    }

Without this fallback, the sampling flag remains permanently true. This
could cause tracepoint callbacks (like NMI, IRQ, and softirq) to continue
incurring execution overhead and recording events into the ring buffer
even after the tracer is stopped, eventually triggering warnings in
osn_var_reset() upon subsequent starts.

Could we restore the cleanup of the sampling flag for the no-workload
case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010022338.2507=
589-1-crwood@redhat.com?part=3D3
