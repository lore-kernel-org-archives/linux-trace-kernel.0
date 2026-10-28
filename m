Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225170;
	b=BjjqdRYtqSoXuCEn6HMvbfsR2WQOFCpIdbRGZ2guaPuKZAaaXYqxf+ZJm+jC/MzNyvLD
	 qLwOmaBcktA7QhLcLo+xhcYxS+yEioR1IDu354nvqDmnr5Mtak/bstQrlK+mKfNtVWtez
	 g8IQY37tjzJMAFLynlq7EfZXfUYotAoKKP4H42ZeXB3yqv78Hi2aMdKAbVPmotLRSSLud
	 AIFJrSk1B2PgEg244UQJssc1FxySdz6xAk/neDzEwAd2NNxW6CRmXj/UTtrau9UBI951y
	 LrSZp1oSMUazYjtshw45XHue9IZpJwKsEZsMHj0UM18EjOukJV8iZB9+RnTiiHFJV9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8hytzjREO7ZyZE/pqjLXom1GpkJkTt7BIRaCUfub0OI=;
	b=OmABn+IhuZ8kK4Wx66ec8DP1fVLowu9qpmUndMPbVonaTUDdCqrkc33rBXTfJVBXDVoc
	 tdzGo29712hZkYv03yW3EbsQ4OI4c8seaYtJBzOwT4Ykxp5Hpgar75/gNNQJiWYf+g9/o
	 fSOHIQ/H+469YpMHc4sMFNSRLowPY63+R4tjoGYHDSG34gGMjEoJ8DIEIDS2rN/kL2ZQE
	 hXpGCi2bK0lQoV+iXylG5i+6cxpKB3APPbIDcYinOMNYkQqfg3DLxlxKxL/Lew3/KfXo4
	 ZpaU4m8B/z/KGmR05mbssZHB4OyLd6s9hcOjW6/4b0buqVXajBMtIr3dLrRuqGF4lag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaVtunwg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1E606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaVtunwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF11F01829;
	Wed, 28 Oct 2026 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793225169;
	bh=8hytzjREO7ZyZE/pqjLXom1GpkJkTt7BIRaCUfub0OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HaVtunwg/eGgnMdm8ANh0iOHEv8IM3z9nWlLaUIiK144FjGpR3PRNE3/KX2vYDrgm
	 gTa83T9Uc/WXZMdR8sAzk7/dOrRlB70469ZfkZvn8CTBaNKugNHzJDM9hf88qEt/1B
	 2HZIQahLrX6SPoDxyttMpXwcm0S4EVrmNh0rqo0mLv7F//YTaB5CgU7rt64rIYH8ga
	 uNIcttG7s/4tSn2PmIHMr8kAuHIOuWn0riBhfeVVMwMNlvbe+zousXKGbDX9NKETvg
	 0bFwIPeg+TTbCuLECzwstjG+hf/wCC5ucGodOSo02+mQ78vogqGxsfL6sVRK9Y8s79
	 1mFbUGnT0EHoA==
Message-ID: <sashiko-outbox-188484@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] tracing/osnoise: start_kthread: Always check
 OSN_WORKLOAD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261028220120.4005187-3-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
 <20261028220120.4005187-3-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:06:09 +0000
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
- [Low] tracing/osnoise: undeclared identifier osn in start_kthread() break=
s build
--

commit 4a3b715cf1d6cbcedaf9c94747a13d69da987d02
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: start_kthread: Always check OSN_WORKLOAD

This commit moves the OSN_WORKLOAD check in start_kthread() ahead of the
timerlat_enabled() check so that timerlat CPU hotplug does not start a kthr=
ead
when OSN_WORKLOAD is cleared, and removes a compiler barrier before returni=
ng.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index aa764ae13047e..33477239351cf 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2047,16 +2047,17 @@ static int start_kthread(unsigned int cpu)
>  	if (cpu_osn_var(cpu)->kthread)
>  		return 0;
> =20
> +	/* Can still happen with timerlat via cpu hotplug */
> +	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
> +		if (!timerlat_enabled())
> +			osn->sampling =3D true;

[Severity: Low]
Does this break the build when CONFIG_OSNOISE_TRACER is enabled because osn
is undeclared in start_kthread() at this point in the series?

In parent commit 1860e8883e92 ("tracing/osnoise: Variable cleanup"),
start_kthread() accessed this field via cpu_osn_var(cpu)->sampling =3D true
without a local osn variable:

    if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
        cpu_osn_var(cpu)->sampling =3D true;
        barrier();
        return 0;
    }

The local declaration struct osnoise_variables *osn =3D cpu_osn_var(cpu); is
only introduced later in the series in commit fc0df59115a1 ("tracing/osnois=
e:
Per-cpu mutexes and fd detachment"), leaving this commit and the following =
two
commits unable to compile. Should this still use cpu_osn_var(cpu)->sampling=
 =3D
true here to preserve bisection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028220120.4005=
187-1-crwood@redhat.com?part=3D2
