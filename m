Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C33806A6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599819; cv=none; b=ikQSCPe6qOGJGdPbZjx/UKvZKDZX8SxraU1JHRmlnEA5kPPDpoEdmbwL2ojsUBzgZGlG5g8j/rXWRQ00Z6qd1HZzqUZA/GjrX4/FNFRnzPoENCA96Ag7n+VgpjzcP33QF1hbKxEcpktOE48WkkGfXMxVAOYLaBbPuDPf90nT/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599819; c=relaxed/simple;
	bh=iG4ZWdkhT/Q1GBL38XDN5XlFTU3bTWivpP7TQaYWZPU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hWZRjsd3KVxGdcNl1VMbDYzh3yUcR8KJUggAtr0bt8gi4eEMT9rQE+XaAHAGKuxXLl+UGfzSS0RGUhZjpbD45Wm90jweT3YgWFKpDorxQC9GJUoXwh0h1EZAejb7LVPe/n1yEGsz1991fOR1aeKhs7qj2sWDv7+0pU5Uk3s7NVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbheGafB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbheGafB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363661F000FF;
	Sat, 10 Oct 2026 02:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791599817;
	bh=Fc9shreG1ozq+T/m3J2bsvnwTl54D06HoGKSErSG9Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbheGafBW/pR5oSM9Pc8nBzgjB7ttjOpTbvqbx+AG5wqQMgS1klagN6QqxTFHogSF
	 c2QYDcFyR4oqfLgkVxClAAPhGSZQ3BzhBqSoJTKK7Yw9xXgvRzSA0P/MEVkVMNv+VR
	 GXDt1TeCYLgchoXIlH7jB25u8m6dW8YJ6gVsMTRjEg0uNGIbmG/LYTOr9RbkO0Chqe
	 K59v4LWIIZOpf77xtCQ7CjNPfXMTRlIr/YyIny4SGzewYa0JYYo2opuRsZmdv1/uoN
	 qVemXc4c+HW/blFccwoR5XnqvmhZ1aLhktdixdkbhzxbQS/RMpHtO8nVhpwBWJddZM
	 cJ9qOp0rjetqg==
Message-ID: <sashiko-outbox-166223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] tracing/osnoise: Split out per-cpu variable
 resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261010022338.2507589-8-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
 <20261010022338.2507589-8-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 02:36:56 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing/osnoise: missing state reset when OSN_WORKLOAD is disabled
--

commit 9927bbade704e7302f3a77ce1eeb45ccd749854e
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Split out per-cpu variable resets

This commit resets per-cpu state when stopping a kthread or detaching a file
descriptor, instead of assuming cleanup happens implicitly. It also adds de=
bug
checks to detect unclean states and no longer initializes the thread lazily.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index eaecd56492e39..ccd717db9a518 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -409,6 +379,36 @@ static struct osnoise_data {
>  #endif
>  };
> =20
> +static inline void osn_reset_cpu(int cpu)
> +{
> +	struct osnoise_variables *osn =3D cpu_osn_var(cpu);
> +
> +	WARN_ON(osn->kthread);
> +	WARN_ON(osn->fdd);
> +	memset(&osn->zero, 0, sizeof(osn->zero));
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
> +		WARN_ON(osn->kthread);
> +		WARN_ON(osn->fdd);
> +		WARN_ON(osn->sampling);
> +	}

[Severity: High]
Since the explicit memset was removed from this function, could stale
timestamps and counts remain if cleanup is somehow skipped during teardown?

If osn->sampling is left true from a previous session, this code warns but
does not clear the stale state. Does this mean delta_start timestamps for
NMIs, IRQs, softirqs, and threads are retained, causing the next interrupt
to compute a massive bogus duration and corrupt trace metrics?

> +
> +	tlat_var_reset();
> +	osnoise_data.tainted =3D false;
> +}

[ ... ]

> @@ -2036,6 +2036,7 @@ static void stop_kthread(unsigned int cpu)
>  		kthread_stop(osn_var->kthread);
>  		put_task_struct(osn_var->kthread);
>  		osn_var->kthread =3D NULL;
> +		osn_reset_cpu(cpu);
>  	}
> =20
>  	mutex_unlock(&osn_var->lock);

[Severity: High]
When the osnoise tracer is used with the OSN_WORKLOAD option disabled,
start_kthread() sets osn->sampling =3D true but does not spawn a kthread.

When tracing stops, does this block bypass osn_reset_cpu() entirely because
both osn_var->kthread and osn_var->fdd are NULL?

If so, this leaves osn->sampling set to true and prevents the per-CPU state
from being cleaned up, causing the stale timestamp issue in osn_var_reset()
when the tracer is restarted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010022338.2507=
589-1-crwood@redhat.com?part=3D7
