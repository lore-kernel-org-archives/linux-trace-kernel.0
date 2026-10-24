Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807440;
	b=WPdnwUHVUmStxdTA1q1SnTM250xkn6Mh8EgRbgS76efiTdsfoRcWqaBEmCq7ybZKr2eK
	 AyLv8T6Ziz2fCkSlj1juHeBA/VmD60nFupP4uxIUzXSCnf00EKYu5O0Oy7GA/mZbI7oAb
	 sU2u1W7/Dgmu23XN1wETJrYRRRkADa+EEzHrdf3AJkcj0VTL8cCYe0cSKBbIx+lBbKiJ+
	 xxDnnXCoxojfFfmfhE3UoBu966F1LG0Tni+P0UioF/WHOmIZUZQ2WtEiZ7SvQs/S2hbjT
	 P+lj5n7s8+hlll60ZkUf9O4b3HFwUKVwDK5Tkpho09ZyEbPAkPAQDlq+ADDO0x+AjBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ZwWrKeST46XYHQgvO0SQjWzxIKKSTgLren5emz3tmo=;
	b=cBt6EPrJXRGdqxhl6JnHBnZnAXd1sg9//rbFM01NY5jx57fTlYBOBHhhmAkNVvN/gCFQ
	 JYNSI9z0cQHDDb7kiUI7WGVc9HFeoKxGP3OukUgJpgWVdZI8yhyCcwtRUwvHvYpoRhBVC
	 51wNFCvZEdQWm4nVX/DxmE+JgFEprYrpCHroxtmDVuTcZx2k5u8ICo9tCf3kc03cOM230
	 Qx5nDX4YedV8VKGC5ppff7kWI3WhTWUo2nb9Ki+5gwsvgOe1QBNcN572M7DS8BFjRBPUQ
	 F6pkVCvMOZ/dT4rvY/xMDOcLP/tmW/96hmUXQOLOw6HGFT+DBoW09hb+MfqfjG1u3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwW2aG+M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80C606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwW2aG+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E7A1F01825;
	Sat, 24 Oct 2026 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807439;
	bh=1ZwWrKeST46XYHQgvO0SQjWzxIKKSTgLren5emz3tmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FwW2aG+MLRluXEr7qHs//aAEtjUv3u/2tjaa//oGTvRgOFHB/nq5nkpYeUMsAShZv
	 vZ93W6TBeRvw6yNvbxFKFI/q8k064sfLHGwmyYq0hVdQXvI3zJpLZq7AfIJAhSQL0b
	 OVsuOvUjUn3KWz7FOPLBRcj9A77+tJH/4Nov03AQFjBJ9orCUC85KJo6wmRa1FRcxS
	 Rvn4ogw19NDIJf44S4eWb5gkGLKcvlG3GaEJqHqIHy8NH4C+V0byFRmHU1mI5CJGmx
	 DesjZQpI9eDfvL1xP2qq4XEqO46+5TpJ4mtmJodPP2DITJr7toxY+h319AMBaHXcoj
	 4nEf0HqHb66/A==
Message-ID: <sashiko-outbox-183507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] tracing/osnoise: Start all eligible cpus from
 hotplug workfn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261024015614.3095251-3-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
 <20261024015614.3095251-3-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 02:03:59 +0000
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
- [Medium] tracing/osnoise: osnoise_hotplug_workfn() skips sampling when !O=
SN_WORKLOAD
--

commit 4bedb2088cbb62deefeaad638901751b0c1e9f6d
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Start all eligible cpus from hotplug workfn

This commit updates osnoise_hotplug_workfn() to iterate over all online CPUs
in osnoise_cpumask and start their kthreads when scheduled from
osnoise_cpu_init(), avoiding lost starts if multiple CPUs come online before
the work item runs.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index aa764ae13047e..29fa4150b26c0 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2123,7 +2123,7 @@ static int start_per_cpu_kthreads(void)
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void osnoise_hotplug_workfn(struct work_struct *dummy)
>  {
> -	unsigned int cpu =3D smp_processor_id();
> +	unsigned int cpu;
> =20
>  	guard(mutex)(&trace_types_lock);
> =20
> @@ -2133,13 +2133,13 @@ static void osnoise_hotplug_workfn(struct work_st=
ruct *dummy)
>  	guard(cpus_read_lock)();
>  	guard(mutex)(&interface_lock);
> =20
> -	if (!cpu_online(cpu))
> +	if (!test_bit(OSN_WORKLOAD, &osnoise_options))
>  		return;
> =20
> -	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
> -		return;
> -
> -	start_kthread(cpu);
> +	for_each_online_cpu(cpu) {
> +		if (cpumask_test_cpu(cpu, &osnoise_cpumask))
> +			start_kthread(cpu);
> +	}
>  }

[Severity: Medium]
Does returning early in osnoise_hotplug_workfn() whenever OSN_WORKLOAD is
clear leave per-CPU sampling disabled on newly onlined CPUs when running the
osnoise tracer with NO_OSNOISE_WORKLOAD?

When timerlat is disabled (i.e. the osnoise tracer is active) and
OSN_WORKLOAD is clear, start_kthread() is responsible for enabling sampling
on the CPU without spawning a kthread:

kernel/trace/trace_osnoise.c:start_kthread() {
	...
	if (timerlat_enabled()) {
		snprintf(comm, 24, "timerlat/%d", cpu);
		main =3D timerlat_main;
	} else {
		/* if no workload, just return */
		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
			cpu_osn_var(cpu)->sampling =3D true;
			barrier();
			return 0;
		}
		snprintf(comm, 24, "osnoise/%d", cpu);
	}
	...
}

And when a CPU goes offline via osnoise_cpu_die() -> stop_kthread(),
sampling is cleared on that CPU:

kernel/trace/trace_osnoise.c:stop_kthread() {
	...
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
}

In start_per_cpu_kthreads(), the early return for !OSN_WORKLOAD is gated on
timerlat_enabled():

kernel/trace/trace_osnoise.c:start_per_cpu_kthreads() {
	...
	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
		if (timerlat_enabled())
			return 0;
	}
	...
}

Should osnoise_hotplug_workfn() likewise check timerlat_enabled() before
returning early on !test_bit(OSN_WORKLOAD, &osnoise_options) (or let
start_kthread() handle the !OSN_WORKLOAD case) so that
cpu_osn_var(cpu)->sampling is set to true when a CPU in osnoise_cpumask com=
es
online?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024015614.3095=
251-2-crwood@redhat.com?part=3D2
