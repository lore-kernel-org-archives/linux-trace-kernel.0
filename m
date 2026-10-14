Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65398397930
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945572; cv=none; b=TSyJLmxMGey10U1OjI6kbwUlgKkeSxsvWdGHALF2er8Ei//HyVzmCitvMo42aQ5RTaRMps2pKIDxdAtPGANDh8wSz2IlOJFLqkkMlHp3jCevwAsDWsGdN8oxFyPplIuEHB+NqZwhzLjw5IFRHJdfRcD4ptHQQtozHSI5xrN/jRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945572; c=relaxed/simple;
	bh=afkONAaIts7daluIZ9pAF75UdR2NR24/kyN5nuPonMI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s6qVs9XfY6x4ph0VC5wHMuwtka6Fd1aDTH3iWTq1Tuc1lNhH5cHNELbqr3aD9pJt1HhPRe1Jbcr9qIfGY/w7H533yPFcVO/jiIMvD0I3TeN16QtIfVLOzBwUL8sAH5a5jEhtcZGNFGnkw7I11qEkhpwSCzYsNsHKO1vbQSl/0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvHV+gtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvHV+gtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8111F000FF;
	Wed, 14 Oct 2026 02:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945571;
	bh=k6yv1pYItlSc1UCLZzjQdFsAvxFCIB9bzpBUeWGptws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvHV+gtDUP/1MkMy7Zi5xVsfl2+vZBBmHEmJk7dmEovrU/mA61V/a3dB4H/EuLSQZ
	 x3AKe9noe/o5RwzfBWbhR0pKSJsYBQ5eQsuQSxB5kdssttvzu07o/gh9Z2yGBRPCrr
	 b9yzoLnZXmUaDwZQg0xa9Td+4d6iym7/4P3ZFS1NZU/OOVB0UVo0OrA26WkMfdE2Pn
	 4Bluoku3pLaEpLkCD4XntwLt4/BuSnR5d7jdyUqe5t4GQ0KM8qvvf9F1gRwipdcJrm
	 JDnmHA1eaq/MWyB+R+XfQgq+Qf+yvukefaxXkiWH+3999sxrdmaU6aaUr3tJ49MH5e
	 W8DvQa5uCHCLw==
Message-ID: <sashiko-outbox-170742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] tracing/osnoise: Refuse timerlat fd open if
 tracer inactive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261014022640.695786-10-crwood@redhat.com>
References: <20261014022640.695786-1-crwood@redhat.com>
 <20261014022640.695786-10-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:39:30 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] trace: timerlat_fd_release unconditionally resets cpu state
--

commit 3a852123b0f7d3294fb2be0fe904429d8ee1fccc
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Refuse timerlat fd open if tracer inactive

This commit refuses to open a timerlat file descriptor when there are no
active instances. This prevents the file descriptor from remaining active
during reconfiguration, which could cause WARN splats.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 9ca45b0b8cb39..2511a9b763b98 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2506,7 +2506,8 @@ static int timerlat_fd_open(struct inode *inode, st=
ruct file *file)
>  	 * This file is accessible only if timerlat is enabled, and
>  	 * NO_OSNOISE_WORKLOAD is set.
>  	 */
> -	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options))
> +	if (!osnoise_has_registered_instances() || !timerlat_enabled() ||
> +	    test_bit(OSN_WORKLOAD, &osnoise_options))
>  		return -EINVAL;
> =20
>  	guard(migrate)();

[Severity: High]
Does this code still allow state corruption during the fd release path?

Looking at timerlat_fd_release() in kernel/trace/trace_osnoise.c,
osn_reset_cpu() is called unconditionally, bypassing the active session che=
ck:

kernel/trace/trace_osnoise.c:timerlat_fd_release() {
    ...
	if (fdd =3D=3D osn_var->fdd)
		timerlat_fd_detach(fdd);
	osn_reset_cpu(fdd->cpu);
    ...
}

Can the following sequence occur?

1. Userspace opens a timerlat fd, creating an active tracing session (fdd1).

2. Tracing is stopped or reconfigured (e.g. via
   /sys/kernel/tracing/osnoise/cpus), calling stop_kthread(). This detaches
   fdd1 (osn_var->fdd =3D NULL) but leaves the fd open in userspace.

3. Tracing is restarted, and userspace opens a new timerlat fd on the same
   CPU (fdd2). This becomes the active session (osn_var->fdd =3D fdd2) and
   tlat_var->timer is initialized and armed.

4. Userspace closes the first fd (fdd1).

5. timerlat_fd_release() is called. Because fdd1 !=3D osn_var->fdd, it skips
   detachment, but unconditionally calls osn_reset_cpu(fdd1->cpu).

Would this unconditional reset wipe the active tracing session's state,
including zero-filling the armed hrtimer of the active fdd2 session,
potentially leading to timer tree corruption and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014022640.6957=
86-1-crwood@redhat.com?part=3D9
