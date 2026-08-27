Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426C339379
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816372; cv=none; b=ecLzxk0TjKoZ9bjMiF+2F0srvwkRtCmDCTeMe+XnMgvZSzvTHsOZlbPBNMiLU9MGPTgKvdiDWgNXm3Hm39c1HAqjHvg+CIpRdeIkf5XFJeveWMXHaM8BdH0pyXFaRq8UkT9DnUU3mtFcJNXZWi4KCmH9oU2UKUVT4mDxlMSR1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816372; c=relaxed/simple;
	bh=FGXbdn3IXp7z6XJl0jLy2OynxDBV9LvKV9hcTa09+hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FsoVM8rNp/iK04xlGMP11eSV7Xm2OAXjfB9SJSU6eQedS/BU9iH/jqTA6h7MQYn0hsKju1LFfnIw2TPZSqDmMgGVIItogbOM5TIS0uvTI+jNA+pRj8AzWpmJvSL/sHNQAsG9+Rfy8ICbr6e2lJL1rGewiPQ6Rv+C3ZESR1Or2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC6gvlJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC6gvlJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150F91F000E9;
	Thu, 27 Aug 2026 07:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816371;
	bh=sxFHIPOI5QzUMU9QperXuDrbQrrxlliXwEk/uW4+H/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RC6gvlJhz7czItjSdY8kuDxNw9dbgTqutr2xTa8R5SyMoZ2ZDckOX713vhdtMkZKk
	 fJXaC7FsUknE7lOg0Bmq8NDck7X86zDvSOH9gfbWfViRN1yNQrYej5VdND4EdxD3Jd
	 INqGhx5vZI2n8dlnK0MZgAJvGa7fszLUytSMUxTRZPN9+bQvVHiJSr5OwlkbZ+7ynp
	 XpN9f/tixbOu5FKa1H6LtWnK7msGIhmR+HyzS76XA0VcI97Re5es+Y+a4Xyfms/DXl
	 uhukCe8u+M9ILYzaDXXu9PWkpEtWp3NMnVz/RaL2+O+yUkmx2Y1LsSTgMsIaAJA0nc
	 7W6ZO7hhkdBvQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/3] rv: add per-monitor edge-stat facility and stats file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827072400.45734-3-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
 <20260827072400.45734-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:39:30 +0000
Message-Id: <20260827073931.150F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] destroy_monitor_dir() frees mon->edge_pcpu before VFS synchronizat=
ion, allowing concurrent readers to access freed memory via the tracefs sta=
ts file.
- [Medium] Non-atomic memset corrupts local64_t counters, racing with concu=
rrent NMI tracepoint updates and lockless tracefs reads.
- [Medium] rv_edge_reset() only resets statistics on currently online CPUs,=
 violating the guarantee that counters are fully cleared on enablement.
--

commit 5d961f88b7dec86f152d8e652fbd68ebc65c3317
Author: Tobias Schaffner <tobias.schaffner@siemens.com>
rv: add per-monitor edge-stat facility and stats file

This commit introduces CONFIG_RV_EDGE_STAT, an optional feature that records
how long a monitor's automaton dwells in a state. It allocates a per-CPU
buffer on first enable and exposes the counters via a per-monitor stats fil=
e.

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index ee4e68102f175..88a0bbaec4d0a 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c

[ ... ]

> @@ -289,9 +298,15 @@ static int rv_enable_single(struct rv_monitor *mon)
> =20
>  	retval =3D mon->enable();
> =20
> -	if (!retval)
> +	if (!retval) {
>  		mon->enabled =3D 1;
> =20
> +		if (rv_edge_setup(mon))
> +			pr_warn("rv: %s: edge statistics unavailable (out of memory)\n",
> +				mon->name);
> +		rv_edge_reset(mon);

[Severity: Medium]
Does resetting the statistics with memset() after the monitor is already
enabled risk data corruption?

Since mon->enable() is called before rv_edge_reset(), NMI tracepoint
updates can fire concurrently. Using memset() in rv_edge_reset_ipi() to
clear the array of local64_t counters could race with these
read-modify-write updates, potentially resulting in torn reads or
corrupted atomic statistics when rv_edge_stats_show() accesses them.

> +	}
> +
>  	return retval;
>  }

[ ... ]

> +static void rv_edge_reset_ipi(void *info)
> +{
> +	struct rv_monitor *mon =3D info;
> +
> +	memset(this_cpu_ptr(mon->edge_pcpu), 0, rv_edge_blob_size(mon));
> +}
> +
> +/* rv_edge_reset - zero the statistics; call from a monitor reset/enable=
. */
> +static void rv_edge_reset(struct rv_monitor *mon)
> +{
> +	if (mon->edge_pcpu)
> +		on_each_cpu(rv_edge_reset_ipi, mon, 1);
> +}

[Severity: Medium]
Will this skip clearing the statistics on offline CPUs?

Because on_each_cpu() only targets online CPUs, dynamically allocated
per-CPU edge statistics buffers for offline CPUs remain uncleared. If
an offline CPU is later brought online, reading the tracefs stats file
will iterate over it via for_each_online_cpu() and report stale,
un-reset values from previous runs.

[ ... ]

> @@ -747,6 +857,10 @@ static const struct file_operations monitoring_on_fo=
ps =3D {
> =20
>  static void destroy_monitor_dir(struct rv_monitor *mon)
>  {
> +#ifdef CONFIG_RV_EDGE_STAT
> +	free_percpu(mon->edge_pcpu);
> +	mon->edge_pcpu =3D NULL;
> +#endif
>  	rv_remove(mon->root_d);
>  }

[Severity: High]
Could this lead to a use-after-free if the tracefs stats file is read
while the monitor is being unregistered?

The per-cpu buffer is explicitly freed here before the rv_remove()
synchronization point removes the tracefs file. A concurrent lockless
reader using rv_edge_stats_show() could access the freed mon->edge_pcpu
memory:

kernel/trace/rv/rv.c:rv_edge_stats_show() {
    ...
    if (!mon->edge_pcpu)
        return 0;

    for_each_online_cpu(cpu) {
        struct rv_edge_stat *s =3D per_cpu_ptr(mon->edge_pcpu, cpu);
    ...
}

Should rv_remove() be called before freeing the per-CPU buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827072400.4573=
4-1-tobias.schaffner@siemens.com?part=3D2
