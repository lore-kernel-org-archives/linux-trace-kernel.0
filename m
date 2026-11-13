Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554431;
	b=hX6pxNkOFssZY9+0rZXkkflPEz70P8NmTzU2DYw6pkckKgdQhG3p3DKdJqPqUP7itLhD
	 T40zsGrAgNBJOHipMixvQrK0oL9Srj8PI6StTtMZIPP9PCTBfd+eNRLwxfz+2kjwNNYY2
	 +9kPtDz4QdBbN8UGNTnSaXCSOT6a2igqjoZijUZEra+bF4AVr9+vvNhfPGSS8z9pfRlY2
	 gjHz+FC1xLV0CAVI4xnMNEZHjIU/3fcTg6EUK6cpJJPoApYo16LNKL3I2i7cadZC7LBto
	 PXtQoof2/627XaYXprX+hWl5VVHfz+Y2WCMntPmM83vdEDffRLPkf+bp558WJEKbcZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1A5ctWx2jqRRheH67fYqQltUBkey/x3w8cm7hG/LOYg=;
	b=M6+NQ+1DaPn6FGj84m+7UI+4FBGCNeqpIoH8tmK4RUz2c/J6eemFLvrWH/0KlMjPTys4
	 ncceGdnbp7TBgV3AfDM7/tokbCayAX8W1GAtXUrDuier+pNxc+bLcE14V36vW0SL8yaF2
	 qI7oVjyIvDpnAALOIaRnQL7ZxpLhyKhMQFNkhws7rD9CrvfrVqycOFh8VmQrItN5+PKNh
	 JV9W5n6PHnk4XrJaEIZlAdqMwqmsEorR6TnTCVEsPnW9+KoooJ+spyMZtlCI+AfNIBkwg
	 lXYa3iCykVxkaboKpGVtDTncXfqg2tolhW8JsirKHdqHc3RdBXMLy7W+UdHbubO+aJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFsayrsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15541606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFsayrsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8331F000C4;
	Fri, 13 Nov 2026 07:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794554430;
	bh=1A5ctWx2jqRRheH67fYqQltUBkey/x3w8cm7hG/LOYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AFsayrsXwqX/gDX1B7yUmGa4+dpqYL94jeYlR5QQlmWCpGVtPYtrvOy0umzy69N+s
	 EWwBXZV4X0uGyNKvi2NBwr441xKTvaKu6EvhupRtITC51Lky3b//GyC9xbAzBCjcZn
	 zitcXH9ay6Y02Zsao2WCbuplkmKfzeLufxgPYwd/XCCSIdLKMrvM+zC8E5yrGlAzwd
	 088GoZRL6drZlqJGDV1RKSc62WMJk2if962W/LhV4A75yoFjtIkmaaNB7m2Icnjx0H
	 k48AkQfnhWa8UbPKsYscFxr85oPKCslHdgr2u1t87SMx9/4vz4BYFgkLyyxOzqDkvO
	 b/V3JfPQQByDw==
Message-ID: <sashiko-outbox-212339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] tracing/osnoise: Reset cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113064103.3041704-7-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
 <20261113064103.3041704-7-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:20:30 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing/osnoise: CPU hotplug race in timerlat_fd_open() leaves
  stale fdd
--

commit 25ee38a6983ff50cb9227e203eed4ba8758cefa4
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Reset cleanup

This commit reorganizes per-CPU and global state resets in the osnoise and
timerlat tracers when stopping kthreads, detaching file descriptors, or
restarting the tracer.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index e61f57230eefb..8db0697b69e4a 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
[ ... ]
> @@ -408,6 +380,39 @@ static struct osnoise_data {
>  #endif
>  };
> =20
> +static inline void osn_reset_cpu(int cpu)
> +{
> +	struct osnoise_variables *osn =3D cpu_osn_var(cpu);
> +
> +	WARN_ON_ONCE(osn->kthread);
> +	WARN_ON_ONCE(osn->fdd);
> +
> +	osn->sampling =3D false;
> +	osn->pid =3D 0;
> +	tlat_reset_cpu(cpu);
> +}
> +
> +/*
> + * osn_var_reset - Reset non-per-cpu state, and check for stale data
> + */
> +static inline void osn_var_reset(void)
> +{
> +	struct osnoise_variables *osn;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		osn =3D cpu_osn_var(cpu);
> +
> +		WARN_ON_ONCE(osn->kthread);
> +		WARN_ON_ONCE(osn->fdd);
> +		WARN_ON_ONCE(osn->sampling);
> +		memset(&osn->zero, 0, sizeof(osn->zero));
> +	}
> +
> +	tlat_var_reset();
> +	osnoise_data.tainted =3D false;
> +}

[Severity: Low]
Can osn_var_reset() hit WARN_ON_ONCE(osn->fdd) if timerlat_fd_open() races
with CPU hotplug takedown?

timerlat_fd_open() disables migration without holding cpus_read_lock() or
checking whether the CPU is still active under osn_var->lock.  If a task
pinned to CPU0 enters timerlat_fd_open() just as CPU0 is being offlined,
balance_push() skips the task while migration is disabled, allowing
osnoise_cpu_die() to run before timerlat_fd_open() attaches osn_var->fdd:

CPU0 (user task)                  CPU0 (cpuhp/0)
timerlat_fd_open()
  migrate_disable()
                                  sched_cpu_deactivate()
                                  ...
                                  osnoise_cpu_die()
                                    stop_kthread(0)
                                  sched_cpu_wait_empty()
                                    balance_hotplug_wait()
  mutex_lock(&osn_var->lock)
  osn_var->fdd =3D fdd
  tlat->thread =3D current
  mutex_unlock(&osn_var->lock)
  migrate_enable()
                                  <takedown completes>

When the tracer is later stopped and restarted, stop_per_cpu_kthreads()
only iterates over online CPUs and misses offline CPU0, so osn_var_reset()
iterating over for_each_possible_cpu() will trigger WARN_ON_ONCE(osn->fdd)
with stale fdd and tlat->thread state left attached on the offline CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113064103.3041=
704-1-crwood@redhat.com?part=3D6
