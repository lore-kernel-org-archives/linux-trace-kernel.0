Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439B4A68AA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016506; cv=none; b=otYhtXKcUfQUpPtE1t3FhodBmFIywEWQKMr0XIHemRzqsAqfCwVfAh1Z1UeucAD5TNcaSW9AEkCCo65J3RcxxcrPHTjIie3q88TzUD24F2+mrUBwAPFSJfnSDuuyYlm2rKSf0zyoc8vNnKVKCau1Si4d++TqkwIYH0tkJAclZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016506; c=relaxed/simple;
	bh=6U0cu0FSc0xriinys3rABf9107lfHjwJix8/KPWm8iU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lZMEHzxSC46pqw0adUNRBTbDzsIZ4LBs0/kvt8O0Q5O+fHJnruX3RCS8ItXbAytkOVcF0dzuiSbt6WNlX+oy7IWflNUYU9hrXcz5UlkF9ixNdMXGHb5Lk29sheI5WhiWaRVRtEJ1CRRLgqMi4eKlhorOklDMdZfhl9pW2i4TgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBIFHSUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBIFHSUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F381F000C4;
	Wed, 14 Oct 2026 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016505;
	bh=788ehwhNX0Ni+Z7mGovtEe2xyXqWfTgEOHMxOIkQ2t4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBIFHSUYXKaPKaSz1nWRP2FgwJ/QV6ZRxJpeQYDyB0MDn1NYTY2sT19wAjd9nXdyh
	 foMp71+n/ILFvn1xasxwoSyoVghzV7G68iyr+Y1TVLPfMBI2muySpHcA4RN73qSKbR
	 3cltFwpbEPU9W5FN37dyrm09MXRMCu3QEDP4KMA6F2codU7TVWs/Tv1ny7w0XIda0U
	 XGLDai46GACUq+t+JQU4xWNBD3uWtg9MnbGxDU+Bc5xJWU1GkycF3YB1G/QfdRQ4x7
	 XxreLq022n/XxnaOUSwo4/M+dvUb5XGI6GqYhnW9tpfnxs/6s4PcYXf4LmcrjT8g4i
	 GNs7hHblqYVZA==
Message-ID: <sashiko-outbox-171968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] tracing/osnoise: Split out per-cpu variable
 resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261014220759.908839-8-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
 <20261014220759.908839-8-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:21:44 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: Data race between osn_reset_cpu memset and NMI handler
--

commit 01cd6ef0e171fa1526bc0f401fc2072fe284c438
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Split out per-cpu variable resets

This commit splits out per-cpu variable resets by resetting the per-cpu
state every time a kthread is stopped or an fd is detached. It uses a bulk
memset to clear the zero struct_group in osn_reset_cpu() to avoid zeroing
individual fields explicitly.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
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

[Severity: High]
Does this non-atomic memset race with the NMI handler
trace_osnoise_callback()?

If osn_reset_cpu() is invoked from a remote CPU while the osnoise tracer is
still globally active (for example, via timerlat_fd_release() or
stop_kthread()), it will concurrently overwrite osn->zero on the target CPU.

The target CPU's NMI handler could be running concurrently and might bypass
the sampling check if it reads it before or during the zeroing. This would
lead to it executing operations like:

kernel/trace/trace_osnoise.c:trace_osnoise_callback() {
    ...
            local_inc(&osn_var->int_counter);
    ...
}

A concurrent memset from another CPU destroys the target CPU's local_t
guarantees and atomic operations, corrupting per-CPU state via torn reads
and writes. This replaces what was previously a safe single-byte
osn_var->sampling =3D false assignment with a bulk memset over the entire
state.

> +	tlat_reset_cpu(cpu);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014220759.9088=
39-1-crwood@redhat.com?part=3D7
