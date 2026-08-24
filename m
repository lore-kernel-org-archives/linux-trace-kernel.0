Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29B21ABD7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607039; cv=none; b=ZZ7eUt8F/Pw7SHnSL7tFDnzlTsGcWDtDeX8qxk7GclhHBcEQVCmV6rPIpHv+AfHjSpJNsJyiXo11zOxbUsMfJmmn6Sux2bIhCcKTbGPoKoFqzqO5tXm615SlvZaQUq6/pz4vK7//QshE/A0ogCKnOXIAf6Lvxu+IIwWy0K+gSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607039; c=relaxed/simple;
	bh=WewxW5otkWXYfoFlZTj4oHvGVT/sdXbvuqV12jt2apc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sCbuLYc069hgO5H7aEs54YRaSf2YHdNzbNYFdRPIhN86Z5N1D8ABfp2eYaGjlurj7mYJK1RxTVYV1Lhp2woQGoN57ERFjo9/nz0YoRaP6++qhrE6+9rfy8CP6488CQD45uammbDz1UA/HQd8ubun/OzhkWcVHboJbn+prfiLWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4qhovBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4qhovBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41B11F000E9;
	Mon, 24 Aug 2026 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607038;
	bh=4SfCwn0LE212nGOXKbjeDoOogNRtW7iqkS739xm6Dr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d4qhovBdzuZQKeDa/aPFB7A2IwAb4hBMCJ9UeRL9VDsf61hyDawfCTvOaiRXUYIky
	 MvpnG6J8sb26r0R+FbKAUIqlTf7qkXJPiPVi1xw+AU6AJTwQ5u1bu2kW54xUOjdBBt
	 jSv3bhtr7MgV3NqjTDNpsp6Y94uwHlGEpquLDTZmfiqdX6Cam6yazgVmlcC5dFH40b
	 UwLi8CoZPmRrQEzUDbXnx4iGIOq9qbIlOBv7TMDgSCUfz2AX0miYh4ChUU6EmVhDlK
	 rfYim3+Mh4TiYqod3PxvzD51Mizatksqv4S4q7Ka5IpX/0M2FwoarEcCS2TZS/yS0M
	 MPvAQV1wndp/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824211544.3984835-2-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
 <20260824211544.3984835-2-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:30:37 +0000
Message-Id: <20260824213037.F41B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Deadlock / Priority Inversion in `timerlat_fd_read()` due to holdi=
ng a mutex across an indefinite sleep.
- [High] Uninitialized Mutex for offline CPUs leads to crash during CPU hot=
plug.
- [High] AB-BA deadlock between `stop_kthread()` and `osnoise_migration_pen=
ding()`.
- [Medium] Spurious `WARN_ON` due to a contradictory double clear of `kthre=
ad_cpumask`.
--

--- Patch [1]: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment=
 ---
commit 3d6fdd195012eb0c62c4c6d7f8152a80a0f97897
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Per-cpu mutex and fd detachment

Clean up a variety of synchronization issues and related bandaids
by having a per-cpu mutex that guards changes to kthread, and
fd open/close/revoke. Replace the SIGKILL hack with a mutex-protected
detachment mechanism.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 0e1265acd1ccc..e2e1ef3f5a617 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -1688,10 +1704,10 @@ static inline int osnoise_migration_pending(void)
>  	 * The tracers are responsible for cleaning their env before
>  	 * exiting.
>  	 */
> -	mutex_lock(&interface_lock);
> +	mutex_lock(&osn->lock);
>  	this_cpu_osn_var()->kthread =3D NULL;
>  	cpumask_clear_cpu(smp_processor_id(), &kthread_cpumask);
> -	mutex_unlock(&interface_lock);
> +	mutex_unlock(&osn->lock);
> =20
>  	return 1;
>  }

[ ... ]

> @@ -1978,32 +1994,22 @@ static int timerlat_main(void *data)
>   */
>  static void stop_kthread(unsigned int cpu)
>  {
> -	struct task_struct *kthread;
> +	struct osnoise_variables *osn_var =3D cpu_osn_var(cpu);
> =20
> -	kthread =3D xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), =
NULL);
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
> -			put_task_struct(kthread);
> -		}
> -	} else {
> -		/* if no workload, just return */
> -		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
> -			/*
> -			 * This is set in the osnoise tracer case.
> -			 */
> -			per_cpu(per_cpu_osnoise_var, cpu).sampling =3D false;
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

[Severity: High]
Can holding osn_var->lock while calling kthread_stop() cause a deadlock?

kthread_stop() blocks waiting for the target kthread to exit. However, if
the kthread is currently handling a migration request in
osnoise_migration_pending() (shown slightly earlier in the diff), it will
attempt to acquire this same osn_var->lock before it can clear its state and
exit:

osnoise_migration_pending() {
    ...
    mutex_lock(&osn->lock);
    this_cpu_osn_var()->kthread =3D NULL;
    ...
}

If stop_kthread() holds the lock while waiting for the thread to exit, and
the kthread waits for the lock to exit, they will deadlock and hang the
system. Is there a way to call kthread_stop() outside of the mutex critical
section?

> +		osn_var->kthread =3D NULL;
>  	}
> +
> +	mutex_unlock(&osn_var->lock);
>  }

[ ... ]

> @@ -2086,15 +2100,9 @@ static int start_per_cpu_kthreads(void)
>  	 */
>  	cpumask_and(current_mask, cpu_online_mask, &osnoise_cpumask);
> =20
> -	for_each_possible_cpu(cpu) {
> -		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
> -			struct task_struct *kthread;
> -
> -			kthread =3D xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread)=
, NULL);
> -			if (!WARN_ON(!kthread))
> -				kthread_stop(kthread);
> -		}
> -	}
> +	for_each_possible_cpu(cpu)
> +		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask))
> +			stop_kthread(cpu);

[Severity: Medium]
Will this always trigger the WARN_ON() inside stop_kthread()?

Here in start_per_cpu_kthreads(), the kthread_cpumask bit is cleared prior
to calling stop_kthread(cpu).=20

But in stop_kthread(cpu) introduced above, it expects the bit to still be
set and asserts:
WARN_ON(!cpumask_test_and_clear_cpu(cpu, &kthread_cpumask));

Since the caller already cleared the bit, won't this result in a guaranteed
warning stack trace whenever this recovery path is executed?

> =20
>  	for_each_cpu(cpu, current_mask) {
>  		retval =3D start_kthread(cpu);

[ ... ]

> @@ -2528,6 +2577,13 @@ timerlat_fd_read(struct file *file, char __user *u=
buf, size_t count,
> =20
>  	osn_var =3D this_cpu_osn_var();
> =20
> +	/* In normal usage, this should always be uncontended. */
> +	mutex_lock(&osn_var->lock);
> +	if (fdd !=3D osn_var->fdd || current !=3D fdd->thread) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	/*
>  	 * The timerlat in user-space runs in a different order:
>  	 * the read() starts from the execution of the previous occurrence,
> @@ -2574,6 +2630,11 @@ timerlat_fd_read(struct file *file, char __user *u=
buf, size_t count,
>  	/* wait for the next period */
>  	wait_next_period(tlat);
> =20
> +	if (fdd !=3D osn_var->fdd) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}

[Severity: High]
Is it safe to hold osn_var->lock across a sleep in TASK_INTERRUPTIBLE?

The function acquires osn_var->lock and then calls wait_next_period(),
which sets the task state to TASK_INTERRUPTIBLE and calls schedule().

If a user task calling read() is suspended (e.g., via SIGSTOP), it could
remain in TASK_STOPPED and sleep indefinitely while holding the mutex.
This would permanently block any administrator actions like CPU hotplug
or stopping the tracer, since stop_kthread() attempts to acquire this same
lock.

[ ... ]

> @@ -3157,10 +3203,13 @@ __init static int init_timerlat_tracer(void)
> =20
>  __init static int init_osnoise_tracer(void)
>  {
> -	int ret;
> +	int ret, cpu;
> =20
>  	mutex_init(&interface_lock);
> =20
> +	for_each_online_cpu(cpu)
> +		mutex_init(&cpu_osn_var(cpu)->lock);

[Severity: High]
Does this skip possible CPUs that are offline during initialization?

If a CPU is offline at boot time, its mutex won't be initialized here.
Later, if an administrator hotplugs this CPU, osnoise_cpu_init() will
schedule a workqueue to invoke start_kthread() on the newly online CPU.
start_kthread() will immediately attempt to acquire the uninitialized lock,
leading to a system crash or lockdep splat.

Should this use for_each_possible_cpu(cpu) instead to ensure all CPUs
have their mutex properly initialized for hotplug?

> +
>  	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
> =20
>  	ret =3D register_tracer(&osnoise_tracer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824211544.3984=
835-1-crwood@redhat.com?part=3D1
