Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877539150A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606949; cv=none; b=uxn5qDduwRVl2C1WNQV5Wfk7OMZ6jXDtEAQT19LUHLBTKLVqByGClCdWgV5km2QPwhy3VU4i90hhR5cyBYjciz3swPTxqdCXvvU/Hg+30sxGbqqQXunsTVVB3KGfBIbUU6KW/UZGQa8PJjAC/gG1TZt3hLUWM2j3yeyJF1CKL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606949; c=relaxed/simple;
	bh=Iio5vcYENkq9OUpj227EHb4Rqa/8uKFyPKguKps/3Tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h6/eU+w5PvFbAR6D4ZieeehCag28PNU20otyUOpzT7zaiB95OPLQa2cpJE0n1yJ+G5cZQV5W1mxiXyEzHnNFxVrmguN+TnvX44lw0gcb2jj7QRpy2XZnFpK/LPN8lNrkbKu6uMeh6HmrwZy5eHvvkl4aPAzJZOJN9A7+yrp/GrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIU/RA0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIU/RA0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2411F000E9;
	Mon, 24 Aug 2026 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787606947;
	bh=P5KfJefNtyXZZ2VXGY46serzwCuv43vllla93iihkFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HIU/RA0Ng+8fUC/GkWlY1/IPLJhDYHsKKDgm10Tx8b+/wFNUk1UvEJLjCxTGvR2DR
	 HupFNeYj090VrCAggxJ2iEQfO4tfAGNHNhzOi0FFF+tW8yIZIOw+xYeotsPSqqDhja
	 HdXqLQpy6D2hlKGflbnbUH0/vqYsh2WGxJa3DZlQF0VxNVYZomH02gg9Q+9e+UjJzC
	 bJd4V4kal8RWIUwnBN3DEf8INRUYDQhJYINvINUpFv1TpNeNMfcg1XUl4SsVyoxfhj
	 B80Oa2TCkbU/n9+LFOR/ekG26mJ2HD+rlNOJbXu9xP/Caxb8M/XrXDsiUDwh6koZZ3
	 AeRz/Yulw3S9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] tracing/osnoise: timerlat_main: Disable migration
 before per-cpu access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824211544.3984835-3-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
 <20260824211544.3984835-3-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:29:06 +0000
Message-Id: <20260824212907.3E2411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Early exit in `timerlat_main` leaves a dangling task_struct po=
inter, causing a Use-After-Free when the tracer is stopped.
- [High] `osn->cpu` is only initialized for online CPUs, permanently breaki=
ng hotplug functionality and triggering the aforementioned Use-After-Free.

Pre-existing issues:
- [High] Uninitialized mutex `osn->lock` used on CPUs hotplugged after boot.
- [High] `osnoise_main` ignores its `data` argument and lacks the CPU migra=
tion validation, leading to per-CPU data corruption if migrated.
- [High] ABBA deadlock between `stop_kthread()` and `osnoise_migration_pend=
ing()`.
--

--- Patch [2]: [PATCH 2/4] tracing/osnoise: timerlat_main: Disable migratio=
n before per-cpu access ---
commit 1b15cf4d4c5a1c36335ab647f7c93d428b13f4fc
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: timerlat_main: Disable migration before per-cpu access

This commit attempts to fix a preemptible-context splat in timerlat_main
by disabling migration before accessing per-CPU variables. It verifies the
CPU assignment after calling migrate_disable and exits early if a migration
occurred. It also initializes the CPU ID for each online CPU in the tracer
setup.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index e2e1ef3f5a617..a53a07e59197c 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -1933,6 +1934,13 @@ static int timerlat_main(void *data)
>  	 * flag.
>  	 */
>  	migrate_disable();
> +	if (osn_var->cpu !=3D smp_processor_id()) {
> +		migrate_enable();
> +		return 1;
> +	}

[Severity: Critical]
Does this early return leave a dangling task_struct pointer?

If timerlat_main exits here, the thread terminates without clearing
osn_var->kthread. Because the creator in start_kthread does not hold an
extra reference, the task_struct is freed upon exit.

When the tracer is later disabled or the CPU goes offline, stop_kthread
will unconditionally call kthread_stop(osn_var->kthread) on this freed
pointer. Can this cause a use-after-free crash?

[Severity: High]
This is a pre-existing issue, but does a deadlock exist between
stopping the kthread and handling pending migrations?

If a user disables the tracer, stop_kthread successfully takes
osn_var->lock and calls kthread_stop.

Concurrently, if userspace alters the kthread's CPU affinity, the scheduler
sets current->migration_pending =3D 1 because the kthread is pinned by
migrate_disable.

The kthread loop calls osnoise_migration_pending, detects this flag, and
attempts to acquire mutex_lock(&osn->lock).

Will kthread_stop block indefinitely waiting for the kthread to exit,
while the kthread blocks indefinitely on the mutex held by stop_kthread?

> +
> +	tlat =3D this_cpu_tmr_var();
> +

[ ... ]

> @@ -2061,7 +2069,7 @@ static int start_kthread(unsigned int cpu)
>  		snprintf(comm, 24, "osnoise/%d", cpu);
>  	}
> =20
> -	kthread =3D kthread_run_on_cpu(main, NULL, cpu, comm);
> +	kthread =3D kthread_run_on_cpu(main, cpu_osn_var(cpu), cpu, comm);

[Severity: High]
This is a pre-existing issue, but does osnoise_main have the same
migration vulnerability that was just addressed in timerlat_main?

start_kthread now passes cpu_osn_var(cpu) to both timerlat_main and
osnoise_main via the data parameter. However, osnoise_main ignores its
data argument and blindly pins itself without validating the CPU:

kernel/trace/trace_osnoise.c:osnoise_main() {
    unsigned long flags;
    ...
    migrate_disable();
    ...
}

If osnoise_main is migrated by hotplug activity before migrate_disable,
does it pin itself to the wrong CPU, causing two tracing threads to
concurrently overwrite the same tracking data without synchronization?

[ ... ]

> @@ -3207,8 +3215,12 @@ __init static int init_osnoise_tracer(void)
> =20
>  	mutex_init(&interface_lock);
> =20
> -	for_each_online_cpu(cpu)
> -		mutex_init(&cpu_osn_var(cpu)->lock);
> +	for_each_online_cpu(cpu) {
> +		struct osnoise_variables *osn =3D cpu_osn_var(cpu);
> +
> +		mutex_init(&osn->lock);
> +		osn->cpu =3D cpu;
> +	}

[Severity: High]
Is osn->cpu correctly initialized for CPUs that are hotplugged after boot?

Because this loop uses for_each_online_cpu, CPUs that are offline during
tracer initialization will have osn->cpu left as 0.

When timerlat_main later starts on a newly hotplugged CPU, the migration
check (osn_var->cpu !=3D smp_processor_id()) will incorrectly evaluate to
true.

Will this cause the kthread to immediately abort upon creation, breaking
hotplug functionality and triggering the dangling kthread regression?

[Severity: High]
This is a pre-existing issue, but is the mutex initialization skipping
offline CPUs?

Because mutex_init(&osn->lock) is strictly within the for_each_online_cpu
loop, CPUs brought online after boot will have a zero-initialized lock.

When start_kthread runs on a hotplugged CPU, it attempts to lock this
uninitialized mutex. Could this trigger a lockdep splat or a null pointer
dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824211544.3984=
835-1-crwood@redhat.com?part=3D2
