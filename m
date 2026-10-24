Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861462;
	b=Txs9FAGTvrNgRYmK9h5DhnJotddLrnKZuW/BmxInz+f8rc9XoA+yKpyxFzuXCbry495i
	 lCCFpi7f/3ZTltCde96T5kg78KKGhl/sPdHbPwF80P9PfyNkW+9GaWtjd3Ikit2WyHR6k
	 QxcZR7Sgxa/6B2/jX4Ba/GZ1A8sQRPQKGsv0aBiW+KPBtLW67ogcwCO7lzkU+qUySVGx2
	 N7rWPRE9ptd0ylZBw9E/NekgFB+fxY4gZ6b6MDqu2gktdc/o6jsHqoQ/tNH11ULgAnwsP
	 /l0CjxQq8WEunOM6F5aBbOfgvyT3X56ZuNgPZzkBlCgWBef1kZlelywkLGIzlo2BrKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqcn0kOQCNUMTn80W/4dxzz1m1TO5ZUJbRCXuB8UhOU=;
	b=uSS+MyEjR2vXteEsmd0C5go3OjLZLOTv3Lo0U2mkkx3nSKhLp6d3Fz1JvmgfN+f5mqZz
	 SvW8i+Ib0a7FMOG5qMDc88Adwmpuflg4C5XamTaG4NZLVrSwG7E/I8Xw0cpLGGem4aUs/
	 HMIjI52Pb6gjrXhRAgQpsM95/gXVAMhYKHrpO1KOq5LY8VZi40wI5aQQHsVBMQ+5cNi7F
	 6dYPIHnT9vJV4JGU2SAXryUC0Wys2gH2+foJvyJ7djDcziQymbIqhQlO/fKcBx0a1xK6p
	 fEJAaQX4bO6Cp1EEqgQybiwpgV1IUm9Mf8SBhChzliX4wYdqZTQRVSwqCorfK+I93gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtBgCEuK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B601606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtBgCEuK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED41F01825;
	Sat, 24 Oct 2026 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792861462;
	bh=yqcn0kOQCNUMTn80W/4dxzz1m1TO5ZUJbRCXuB8UhOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtBgCEuK0RfhT0iqYU23Ip1McGkkvW/BkP6dEVx6ml5aKKd12F/p6qjlfEBbt/Gla
	 O3CnJOFsyA2UrIwSnbuSvjSJK6K9RFRz6TjXgcaMdwu1oxB3y2NTtb0tI6ydhZVR59
	 4XDLgcKgoBYvkGjikSjOuB2NZBYwBulYPkIYcWDlrS/UdGKsBcV9xwd/RjiH3nf3D4
	 AK/QgbjE28Z+Y6kGvJE8G7VKKjqk+wkNDp+ZxPo7JG/EowX/ER9drPCAg4EusVNHaR
	 t2YmQCAkS6Eva3nIBWTO+e9G4Q1J3zKVNvU8xEDcO1R8ZJHwurPcEZF5HpgpU6ShNJ
	 +oF1W8sqUDSwQ==
Message-ID: <sashiko-outbox-183817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] tracing/filters: Check CPU bounds before
 cpumask_test_cpu() in do_filter_cpumask_scalar()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179285915196.466249.7067056297377577459.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
 <179285915196.466249.7067056297377577459.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 17:04:21 +0000
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
- [Medium] tracing/filters: unreachable CPU bounds check in do_filter_cpuma=
sk_scalar()
--

commit 3eff3e01752bc54a2dfd5503608817b42e7186d2
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Check CPU bounds before cpumask_test_cpu() in do_filter_cp=
umask_scalar()

This commit adds a bounds check comparing cpu against nr_cpu_ids at the
beginning of do_filter_cpumask_scalar() to avoid out-of-bounds bit tests
when evaluating single-CPU cpumask predicates.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index c2c35b4de85e0..69da95f425410 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -695,6 +695,9 @@ do_filter_scalar_cpumask(int op, unsigned int cpu, co=
nst struct cpumask *mask)
>  static inline int
>  do_filter_cpumask_scalar(int op, const struct cpumask *mask, unsigned in=
t cpu)
>  {
> +	if (cpu >=3D nr_cpu_ids)
> +		return op =3D=3D OP_NE;

[Severity: Medium]
Can cpu >=3D nr_cpu_ids ever be true in do_filter_cpumask_scalar()?

The commit description states that cpulist_parse() checks against
nr_cpumask_bits (NR_CPUS). However, since commit aa47a7c215e7 ("lib/cpumask:
deprecate nr_cpumask_bits"), include/linux/cpumask.h unconditionally defines
nr_cpumask_bits as nr_cpu_ids:

    #define nr_cpumask_bits nr_cpu_ids

    static __always_inline int cpulist_parse(const char *buf, struct cpumas=
k *dstp)
    {
        return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
    }

When parse_pred() in kernel/trace/trace_events_filter.c parses a cpumask
filter via cpulist_parse()->bitmap_parselist()->bitmap_check_region(), any
CPU number >=3D nr_cpu_ids is rejected with -ERANGE:

    if (cpulist_parse(tmp, pred->mask)) {
        kfree(tmp);
        parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
        goto err_free;
    }
    ...
    single =3D cpumask_weight(pred->mask) =3D=3D 1;
    if (single) {
        pred->val =3D cpumask_first(pred->mask);
        kfree(pred->mask);
        pred->mask =3D NULL;
    }

Since filter_pred_cpumask_cpu() is the only caller of
do_filter_cpumask_scalar() and passes pred->val as cpu, isn't cpu guaranteed
to be less than nr_cpu_ids here, making this check unreachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179285912318.466249=
.7425922682086130057.stgit@devnote2?part=3D3
