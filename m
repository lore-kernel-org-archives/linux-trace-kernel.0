Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3351F3BA2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Aug 2026 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788045244; cv=none; b=qLB06h3DDH2KaAjzZ9908LpRoz0bL5b3seDhN83cTwh1hOe9dtDxazuPLCl2mL3uWKWtbSU0E6fi1JHP2KKuDMHwfkFdz40Fz95drV5bSKcePKoEPSGKymBSUCJBVg/oSQ5YIn24cHGxNEY+fKzUhensGI/2d1HCnbhYHZWzXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788045244; c=relaxed/simple;
	bh=30x4njbv1M9wW9aUjg3DhwfYrIsMA66iQiaClh0XFtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0uphFbNDk/hkAQKCYsqP0W2zBA3MZ59C/xCZFwHj1qgoRKJgaDW7XiOuKae1oV3gssY4bmbJYJNRcOua8bG5OlgB/p6OVXKK0cG5YqMx5ioA/JFfpHzAT3jVL3Fhg5Qs0u+Kmr1rP9rJWM3Ox/lWE37oz0m9p77prthTTevDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFIlQpGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFIlQpGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4071F000E9;
	Sat, 29 Aug 2026 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788045243;
	bh=2e7jcmQo2ZlGqZ3hHPf3pWvcGP+9Nk0K9d6k0QZxFAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFIlQpGgE+a5GevaF5Za6fiwtUb1rT7+W6KFWsz3zYj8t9yzfF4hnBEdAmGmXk/hZ
	 SeS3febDQO6k7bfn//SqAQm95czbDtnDTJqrqytKf672wpSoQDhkX2KxvY+4wgIe2e
	 oIKojLSyE71PyRj3IQ09Gcxyba6DQzfazlqajJVXF4Nk/yavUZojGWFWonA+dNJp34
	 nAR7v2eHwg8cO314r+2d71jgQOPf5wLdEfyEj1SVAuTnbaIqN0xvJlcYrYQY35lYE3
	 bJ4drdd+BSA8GoIyq+QBuRvhq99R4yu445+H2CQAt5QEzZMY9i9f65FtJJ75E4HwGb
	 bLLlh5qSqD+CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] workqueue: Add workqueue_cpu_intensive tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260829230517.42468-2-atomlin@atomlin.com>
References: <20260829230517.42468-1-atomlin@atomlin.com>
 <20260829230517.42468-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 23:14:03 +0000
Message-Id: <20260829231403.7F4071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] 64-bit division by a constant on 32-bit architectures causes a link=
er error (`undefined reference to '__udivdi3'`).
--

commit 87b8b280347790d2ca859c486100f7c5e7ab2a4c
Author: Aaron Tomlin <atomlin@atomlin.com>

workqueue: Add workqueue_cpu_intensive tracepoint

This commit adds a tracepoint to record when a concurrency-managed per-CPU
work item runs continuously without sleeping for longer than the CPU
intensive threshold. It enables real-time detection and attribution of
CPU-hogging work items.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bfeef512f6dd8..957a1190aa28b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
[ ... ]
> @@ -1557,9 +1558,10 @@ void wq_worker_tick(struct task_struct *task)
>  	 * double decrements. The task is releasing the CPU anyway. Let's skip.
>  	 * We probably want to make this prettier in the future.
>  	 */
> +	dur =3D (READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current=
_at) /
> +	      NSEC_PER_USEC;

[Severity: Low]
Will this cause a build failure on 32-bit architectures? Using the standard
division operator to divide a 64-bit integer by a non-power-of-2 constant
(NSEC_PER_USEC) typically results in a linker error for the missing __udivd=
i3
compiler built-in on 32-bit targets.

Could this use div_u64() or a similar helper from linux/math64.h to prevent
the linkage error?

>  	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping)=
 ||
> -	    READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at <
> -	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> +	    dur < wq_cpu_intensive_thresh_us)
>  		return;
> =20
>  	raw_spin_lock(&pool->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829230517.4246=
8-1-atomlin@atomlin.com?part=3D1
