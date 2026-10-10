Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E137B02D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599667; cv=none; b=hk3TUC508kI+wsqnjh3FJN5O5/LEwZ8qjQjDp95V0AGIDMyH8YCXa+P7MdQQuHHKDELP5+xviM6N+IBvBpVtlsV1y7gfK2dNBNFOMnBpzwduaKbfMD5CbxEnn3BdHxVcA/r4oxJq+ZpN0gEX6RlfRM4HCo+Q6YYfw0YpWZiPTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599667; c=relaxed/simple;
	bh=dByDGbu+UZLzrIxrkRfJi1o+JCq0vLbAQHOcQ6ldDYY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rkKRW3+GKugGgW4Uz09l44WCcUkBYoyxwxMAcA2PLxoAm2mE/iFYNNta7DXlccgQ69KJhXnf7uZDEaniUF6WhOY6mOdibSvrtcWIf1j7uBEmBxOORPl2XxzBY4ULTmFvrpvAl0cVgmTKgfO7mOcFFhqx8h/Ci7zSfYymDxWZ9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRy9wMEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRy9wMEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D23A1F000FF;
	Sat, 10 Oct 2026 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791599665;
	bh=oiZqajjs/ad30r62PXiJpMlI5gbFdapkCvryY6ffRxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IRy9wMEo8sqsq3dqsuQeYkS8eRrAgt8mG1soVC5IbgDN3T/qaxuvOx3XJUjji6nP/
	 eNhkP8kuC8YxMPgcXSOGYVBmSv/snSwGOnKhWKGe81+Y63shJi+VaSU5Z65bsZxYFV
	 wVC38fZI8AGL+t4wUxRXliTGv/2bUh8v7n53gqb/xH0IXZV7/FiuSi8E5/Ir4uxRVL
	 sb0D/NkT6bL+/Ybhfxea4VXrnZQ5C9X+Nq6+xUagSNNcbWVGdzY/h9oRPaQS/Ai3sk
	 tXuHyDgCksQOGkbt0FvaMVss/Jxn5czBrmEForMB8T0Bzi0yijqrDDscedxhivZlAL
	 dNh9S32rM1FcA==
Message-ID: <sashiko-outbox-166221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] tracing/osnoise: start_kthread: Always check
 OSN_WORKLOAD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261010022338.2507589-6-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
 <20261010022338.2507589-6-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 02:34:24 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing/osnoise: WARN_ON triggered on restart with NO_OSNOISE_WO=
RKLOAD
--

commit 0c861cff53ad6b5caf50d13aaff67f66512d0646
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: start_kthread: Always check OSN_WORKLOAD

This commit modifies start_kthread() to check OSN_WORKLOAD up front and
return early if it is not set, instead of only checking it inside the
non-timerlat branch.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2077,16 +2077,17 @@ static int start_kthread(unsigned int cpu)
>  	if (osn->kthread)
>  		goto out;
> =20
> +	/* Can still happen with timerlat via cpu hotplug */
> +	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
> +		if (!timerlat_enabled())
> +			osn->sampling =3D true;
> +		goto out;

[Severity: Medium]
If OSN_WORKLOAD is not set, this code sets osn->sampling to true and
returns without creating a kthread. Later, when the tracer is stopped,
stop_kthread() does nothing because osn_var->kthread is NULL:

stop_kthread() {
    ...
    } else if (osn_var->kthread) {
        ...
        osn_reset_cpu(cpu);
    }
}

Because osn_reset_cpu() is skipped, the sampling state is leaked. When the
tracer is subsequently restarted, osn_var_reset() checks the state and
triggers a kernel warning:

osn_var_reset() {
    ...
    WARN_ON(osn->sampling);
    ...
}

Could this leave a stale sampling state that persists across tracer
stop/start, triggering a WARN_ON in osn_var_reset() and breaking the
restartability of the tracer without a workload?

> +	}
> +
>  	if (timerlat_enabled()) {
>  		snprintf(comm, 24, "timerlat/%d", cpu);
>  		main =3D timerlat_main;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010022338.2507=
589-1-crwood@redhat.com?part=3D5
