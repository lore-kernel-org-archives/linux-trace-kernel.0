Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751905;
	b=ePx2L6E8/v2ntpCX2xd8bETrHVFYb5Mmk1QhdFOQbKgiFdZ/lWT+4kf0rxqFx9Yymfgi
	 ON5Z/ixhiKB5PQAJd0CFkyynmitIiYOJGP9oOUmtnG8wKy6RLmx9u3p++lY3Mt8L6Duqg
	 Tqwes096o9/EfDJ/+ZyZ/A/9jPzd7Df7Yv6uBdecUkj+1YftDVdFRcl/CU7jNMsjlQsaz
	 D4D2AMu8JAqU8jDAPN9AEKUfYrrb2ydwuRutcz1b0fuAXwdAgLPUGGIBXkeCu8sRRNV7U
	 UvxTe5+dwUKTXKk1Zf2gkGTSU2ezYMdsEBkJWuHoKzDFdCVTk20q42HLUecQUO/r9QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RdG+GiG/1CIfLzYeExA9U5o7xv0u79r3wtEA+fGwC2Y=;
	b=tqX4tKRRtNkpZFQBRJMu7sVf0Fp4bmxzHVlWWSfPYEj6y1o73I6zY7DOn8WeTko6iNsF
	 +LLeYODPh+CbCLTVNjkQpfkWhswz3pCX5NM05Rq0fPoYT0j7vIlhoJqXcIrMlrRluRHYX
	 MtdCNv7+LhgMgbmj/7MTPTT0B0ehgKpClZmHU/L9I/I3KMZwT5VEiM/GcKqiC5CulpYs+
	 OdTSZ2vpbguIfUtvF5tb0Z4ArHOXLlxeb45Xgu5c71y1wYk/05f6kELAih6m9dgpiINSs
	 v5Ek7xi2uZRJUk7fC/YNtkKKqUkYYea4UUE0vhZQ4kXlNdlb0UP4o8AmHKGTMu3Y6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iq4PBeOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CA606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iq4PBeOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37121F000C1;
	Wed,  4 Nov 2026 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751904;
	bh=RdG+GiG/1CIfLzYeExA9U5o7xv0u79r3wtEA+fGwC2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq4PBeOkg8v7fPnMv39SNgWdQWOedHN8CYnE8OomTQEudiFTsKy61n2HuqFhpEbfE
	 gOW/ZrPIRijN9M+Qz3Rf+8KyW84MhdOIWl//Ha8iKqctGILNkt71ts3gzS3PIEQNv0
	 QYQXc+HxCjps4ewK02M8bYmXvJ2HWW578+EkBJQgvxINubuTJ4VfoWK3PEuiL4FvKZ
	 wP99iJshIgyFUdoT3YbEk3aC37v+TV4AnmG4rqzsLK/NpLMuI2tayIKNdf0RZs0wvE
	 BxeFtSfLn6L5WkDMsJ/GGUGPLgfrGbJUNIHUbZYUkGMR0pBbFj9DZXNz//rFkzqoRx
	 JoQl4GTKdNksg==
Message-ID: <sashiko-outbox-196308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] kprobes: Fix UAF and queue cooling probes on forced
 unoptimization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179375034391.247640.7677208599009420639.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
 <179375034391.247640.7677208599009420639.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:25:03 +0000
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
- [Low] kprobes: unreachable kprobe_unused() branch in unoptimize_kprobe()
--

commit c6680d6b1b284ca1b2cdf402fac410e5adfc1db4
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Fix UAF and queue cooling probes on forced unoptimization

This patch fixes a use-after-free on forced unoptimization of an active
optimized kprobe by queueing the probe onto the current generation's list
and waiting for a Tasks RCU grace period before freeing it. It also separat=
es
newly unoptimized probes into a local list in do_unoptimize_kprobes() so
probes already on freeing_list are not disarmed twice.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 135fec5d49cf5..ceacd56245c24 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -1039,6 +1039,15 @@ static void unoptimize_kprobe(struct kprobe *p, bo=
ol force)
>  	if (force) {
>  		/* Forcibly update the code: this is a special case */
>  		force_unoptimize_kprobe(op);
> +		if (kprobe_unused(&op->kp)) {
> +			if (!kprobe_gone(&op->kp))
> +				arch_disarm_kprobe(&op->kp);
> +			hlist_del_init_rcu(&op->kp.hlist);
> +			list_add(&op->list, &cur->freeing_list);
> +		} else {
> +			list_add(&op->list, &cur->cooling_list);
> +		}
> +		kick_kprobe_optimizer();

[Severity: Low]
Can kprobe_unused(&op->kp) ever evaluate to true here?

At the start of unoptimize_kprobe(), the function checks:

	if (!kprobe_aggrprobe(p) || kprobe_disarmed(p))
		return; /* This is not an optprobe nor optimized */

where kprobe_disarmed(p) for an aggregator probe is:

	return kprobe_disabled(p) && list_empty(&op->list);

And earlier in unoptimize_kprobe(), the !list_empty(&op->list) block handles
all probes already on a list and returns.

When execution reaches this final if (force) block, list_empty(&op->list) is
guaranteed to be true, which means kprobe_disabled(&op->kp) must be false
(otherwise kprobe_disarmed(p) at the top of unoptimize_kprobe() would have
returned early). Since force_unoptimize_kprobe(op) only clears
KPROBE_FLAG_OPTIMIZED and kprobe_unused(&op->kp) requires
kprobe_disabled(&op->kp) to be true, isn't the kprobe_unused(&op->kp) branch
unreachable here, leaving the probe to always be added to cur->cooling_list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179375029807.247640=
.13024754173032838618.stgit@devnote2?part=3D5
