Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1438B7CD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606682; cv=none; b=jEWfZxy0sSyiuQ/gOFprE1lce42UQwlS6+1XP2ikwxnAspC3IcfaQMpZDeSCAjXsqT08QIk5lI7eT8i2Pf3TOLf2ygbAPdVmsJ/WUNjfsve+3FRkyEWoQB4n0ZH2BrVuwlQxc3f0XI9GLgbzD7c2VGkQQdfYtYeDO/xz6hn08x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606682; c=relaxed/simple;
	bh=3nv3pYrOvTZuVi0Z2AmjHmLeT+nrlENjEiajD8Omp0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BdQAE/oEB+YUGex7m9xL0EQFgmUTaecqxU3b6f1GNWd5Lbsy7Pl6RAOQxKg2KX3wbAF9doiJC3CwD9KEpFWCR7w3iU572n4PW5vOGQQZdfBFcKycwld/rvX1e34Tao7zeCdoIzO6e4arBRFFHgqx2NAFQQAP/7Ra9aeKTlF+A5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUrfCkWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUrfCkWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99C01F000E9;
	Mon, 24 Aug 2026 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787606680;
	bh=kjzjkjZRq3SXxYIFSTLmGD2M4III0beiKcydUq+DBzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUrfCkWpqkqlQmwwVQ9EoAXss+w7rUzHTWg6BLM2IHs6Agt9kII2UHQ2HFd11f5mR
	 tZZuCbHlzO6g8c8XAYLVxepAMJrn62B9OXpmLnJWZmBthgjoYC8CeFLUHXKteC9sqd
	 w2k2WVRYfcDT5BFYevlL8vDDpk4aKKGzkg2g1oKFtGB4gLZYlaSfNxcXot7xTodOcj
	 9buVaRmVymoCoEzxxyEVW+eLOnJ2gTRkVlYqJOZck620kEAdZGVFVeFVb0seKorjAI
	 HDucsqFj5wXnqDUGXKoCsB1yUwICxPAXemV/wZruC8VK+aSxpzQxp1f25QLcCEuOZT
	 e0YhEt2Na1cqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] tracing/osnoise: Take trace_types_lock in
 timerlat_fd_open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824211544.3984835-5-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
 <20260824211544.3984835-5-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:24:40 +0000
Message-Id: <20260824212440.A99C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Mixing `goto`-based error handling with scope-based `guard()` clean=
up in `timerlat_fd_open()`.

Pre-existing issues:
- [High] Uninitialized per-CPU mutex and CPU ID for hotplugged CPUs in `ini=
t_osnoise_tracer()`.
--

--- Patch [4]: [PATCH 4/4] tracing/osnoise: Take trace_types_lock in timerl=
at_fd_open ---
commit d0fbb203fad6d30d667803da9a34c6adb7c10f72
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Take trace_types_lock in timerlat_fd_open

This commit replaces the use of interface_lock with trace_types_lock using
a guard(mutex) in timerlat_fd_open. It prevents a user fd from being opened
when osnoise_options_write has already stopped threads but not yet set
OSN_WORKLOAD.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 0f27af6ade3e1..3d12ce8a591e7 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2466,16 +2466,14 @@ static int timerlat_fd_open(struct inode *inode, =
struct file *file)
>  	long cpu =3D (long) inode->i_cdev;
>  	int ret =3D 0;
> =20
> -	mutex_lock(&interface_lock);
> +	guard(mutex)(&trace_types_lock);

[Severity: Low]
Does this mix goto-based error handling with scope-based guard cleanup?

The function still relies on a goto err; block for error handling (which
unlocks osn_var->lock and calls migrate_enable()), but it now uses guard
for trace_types_lock.

The cleanup guidelines suggest converting all resources to scope-based
cleanup, or none of them, to avoid mixing semantics and ownership rules
in the same routine.

[ ... ]

[Severity: High]
This is a pre-existing issue, but does init_osnoise_tracer fail to
initialize per-CPU data for hotplugged CPUs?

Looking at init_osnoise_tracer in kernel/trace/trace_osnoise.c:

kernel/trace/trace_osnoise.c:init_osnoise_tracer() {
    ...
    for_each_online_cpu(cpu) {
        struct osnoise_variables *osn =3D cpu_osn_var(cpu);

        mutex_init(&osn->lock);
        osn->cpu =3D cpu;
    }
    ...
}

Because this iterates over online CPUs rather than possible CPUs, if a CPU
is offline during boot or hot-added later, its mutex and cpu ID will remain
uninitialized.

When that CPU comes online, osnoise_hotplug_workfn calls start_kthread(cpu),
which attempts to lock the uninitialized osn->lock. Could this cause a
lockdep warning or kernel crash due to uninitialized list_head pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824211544.3984=
835-1-crwood@redhat.com?part=3D4
