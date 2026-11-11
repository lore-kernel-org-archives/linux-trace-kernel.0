Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365651;
	b=vmMouJDtBE/hTdXIXhXefpBxAso7hpRbNgjum9K9QuNVCn1G9c1bbfNfO2lMWT8bSiAv
	 EdHesbw3z7Gli0XM6MpIGj1vWOwAcLIyam1tSowVqLuYZVQoNdFfixF4uFWtRtIc0v62t
	 MHAxRtmzHRhqkscwxjBJMCREHvYlBammHVEt47y64gh+Rs/fuYbqQpd9Ts5MK29m/WXPt
	 pyreGg66gqY4wHcte+gGwHPhFIY5vznL1dLqkgZo77rPK+zXhUjoD6OSmoTRzVAbTG5A+
	 I5ksvWipBcI0Fs3OkiMPjNM6LJQoI32vyJARk11JfGNnp8EQKQdZVfHPl6geR1kKd4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IPjgHuPkz5DBOst4HXagyBDGKdf5efJ3EMJdWgfnTew=;
	b=KOC4eX3nMPqKBfIpZp8Ug7lPaIkRaKe43XQ3G/uql6nYlXEK10OCr/F3HTi6quD9giWC
	 Gcd3iUwVj+J0fIm5zck/7iOQRMg3GDihOCACUPUEZDjFB2yrV1KSIWBSDq4JbvEHBNeiG
	 a/ueQZQo9hYHozGNO+BrqipXWvAt89SxnJ/96XccYZluYt75kpzfgFofpOHaUcrZRenuh
	 N6e2C/dm5XL+1kItmP8ffNAMcFRvfSn4jl469hF/YCU/BRCZD06hqj7Chq/Awgiy4pimp
	 813598jSqtrac6IJmtWO7l8O/xWayM0ejivcdSpVUsQKdHJCbc1VUIvkYz88QQBjD7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HLtykcx/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLtykcx/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35F1F0089F;
	Wed, 11 Nov 2026 02:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365650;
	bh=IPjgHuPkz5DBOst4HXagyBDGKdf5efJ3EMJdWgfnTew=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HLtykcx/aiAk3vsoeCKYuu9tcvG3WmGLpnyDi6JqNE1aVWgLfuvtmNPz7tG1XEqtN
	 gzMCl9URxb0bfLpVQ2kWyGqy7sk5JkVTCJ9WsSaL6C/+G89JDBrHJim9yvm9JNFRbP
	 Z8+Ox/4N2jDQuqPncOStOcq1p4IUJub09G1SWO6nogrSIElzBYNpgAnzQoHLIWKo4D
	 MvcZ4vIYfHMpH5lY3GhUHe4cEiHPyWKKbr1TOC4AxFQnuVWPd/V6oAWeKW5dodJz/k
	 vTF4o6FMJpaOSJMqWwE1YWX0nUzTL+hDx2hhFpeBBj1fHY8pHPQXk0oSeqxVQ0MK07
	 tOFnlE64V3zRQ==
Message-ID: <sashiko-outbox-208125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenwu Hou" <hwenwur@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111020755.1422284-1-hwenwur@gmail.com>
References: <20261111020755.1422284-1-hwenwur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:54:09 +0000
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
- [Medium] tracing/hwlat: start_single_kthread() leaves
  PF_NO_SETAFFINITY set on hwlatd
--

commit 649d99e25afc0a134fd743f085f8409aa8adb366
Author: Wenwu Hou <hwenwur@gmail.com>

tracing/hwlat: Bind the sampler kthread instead of setting its affinity

This commit replaces set_cpus_allowed_ptr() with kthread_bind_mask() in
start_single_kthread() and validates that tracing_cpumask overlaps with
cpu_online_mask before creating the hwlatd kthread.

> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 3fe274b84f1c2..65e184d800ff1 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -440,7 +437,14 @@ static int start_single_kthread(struct trace_array *=
tr)
> =20
>  	}
> =20
> -	set_cpus_allowed_ptr(kthread, current_mask);
> +	kthread =3D kthread_create(kthread_fn, NULL, "hwlatd");
> +	if (IS_ERR(kthread)) {
> +		pr_err(BANNER "could not start sampling thread\n");
> +		cpus_read_unlock();
> +		return -ENOMEM;
> +	}
> +
> +	kthread_bind_mask(kthread, current_mask);

[Severity: Medium]
Does leaving PF_NO_SETAFFINITY set on hwlatd prevent userspace from
changing its CPU affinity or moving it into a cgroup?

kthread_bind_mask() sets PF_NO_SETAFFINITY, which kthread() only checks on
initial wake-up before calling kthread_fn().  Because kthread_fn() never
clears the flag, sched_setaffinity() and cgroup_attach_permissions()
reject hwlatd with -EINVAL in both round-robin and none modes.  That also
makes the user-affinity override check in move_to_next_cpu() unreachable
from sched_setaffinity():

kernel/trace/trace_hwlat.c:move_to_next_cpu() {
	/*
	 * If for some reason the user modifies the CPU affinity
	 * of this thread, then stop migrating for the duration
	 * of the current test.
	 */
	if (!cpumask_equal(current_mask, current->cpus_ptr))
		goto change_mode;
    ...
}

Clearing PF_NO_SETAFFINITY in kthread_fn() once the thread has started, as
done in 4998e7fda149 ("tracing/osnoise: Switch from PF_NO_SETAFFINITY to
migrate_disable"), would avoid this regression while still skipping
kthread_affine_node() on the initial wake-up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111020755.1422=
284-1-hwenwur@gmail.com?part=3D1
