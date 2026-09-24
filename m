Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F9360EC3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262982; cv=none; b=Mqlz2wwRgrS3cUKpRGRxYB8l6eM1i76x3ZjRbYmrETKgajs/0mFS2lo+ypw2kcHljIxuv+MU0raPal0ttIpaIfPSs+QVArHsimyQjEsuF7iy+XYlhR3g+cGXW8B6SgGRIe7E2IJ1j1s46TrI/sNZn1oDdv38auZ/4udSKiRY6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262982; c=relaxed/simple;
	bh=1KpITRxDtMDetz8lP4p6Mz087e49+ytQChsp6qN+ykw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+TchgcM1P/8k5YnuD1POPNVaBCLY8SvkgAeG8GKXsiWmYfRj3psxJnE3ndPD4ErOAbcBy6Qg5XGZQyNOA4YupE+wIpBa8N0Nj220J93lGj7/5/Lpl7dn+kJ2o9yPcNZCfSzgMfR1ycNqp263JeRFlvO/cz7jj3YyAKoYRjEXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+dcVvHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+dcVvHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23551F000FF;
	Thu, 24 Sep 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262981;
	bh=Q4B39xYWmCp75q1iPKAssIF1p04OsxZGSA9vVcMNEVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+dcVvHvxOMAaEPurSWBRfZ8GtTAwFCCL02kwAl7P4gkw6+ebc2T5QVHfIW7PRM+Y
	 XWm98jL06UM5BQcBbKswfjH8t1KcD47Gq10bD6cR+9u9Qehn/PLg0KVuaLzlUXoOFl
	 2XERxveuC/qiAc3FeRu/bxyzqa73C6FuhNS/jE2HkIZjQ3FMCAbLd4u0Y0Ws5OUZ5b
	 zynlP7kasZeGXwYnt5Eap75mvbIjUFh3CMVK1/xnn+A1Lw1DsL3y7nYzGfwzlug5Cf
	 UWqShbWCxaWIPEWiH+uf4nRWFX3ltxLLxb4ofe9n7bS32DhK2fWL13r2sBF8x0Wx+i
	 zZINbY4V7SQfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/20] tracing/remotes: Add trace_remote cmdline
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260924145754.1285146-19-vdonnefort@google.com>
References: <20260924145754.1285146-1-vdonnefort@google.com>
 <20260924145754.1285146-19-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:16:20 +0000
Message-Id: <20260924151620.D23551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tracing: missing validation and truncation of buf_size in trace_=
remote
- [Low] tracing: data race in trace_remote cmdline parsing due to missing W=
RITE_ONCE
--

commit 6359480e2f0f5e3b0022cfdf6db7a85cba580136
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add trace_remote cmdline options

This patch adds a command-line interface to configure trace remotes upon
registration. It parses options such as dump_on_panic, dmesg, buf_size,
and poll parameters, and enables tracing automatically when events are
activated.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index b2547eb117f85..de41f36e9a0e3 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> +static bool trace_remote_apply_cmdline_opts(struct trace_remote *remote,=
 char *cmdline)
> +{
> +	bool dmesg_on =3D false;
> +	char *opt;
> +
> +	while ((opt =3D strsep(&cmdline, "^"))) {
> +		if (!*opt)
> +			continue;
> +
> +		if (!strcmp(opt, "dump_on_panic")) {
> +			WRITE_ONCE(remote->panic_on, true);
> +		} else if (!strcmp(opt, "dmesg")) {
> +			dmesg_on =3D true;
> +		} else if (!strncmp(opt, "buf_size=3D", 9)) {
> +			WRITE_ONCE(remote->trace_buffer_size, memparse(opt + 9, NULL));

[Severity: Medium]
Is it possible for this to silently truncate large buffer sizes on 32-bit
architectures?

Since memparse() returns a 64-bit unsigned long long, but
remote->trace_buffer_size is an unsigned long (32 bits on 32-bit
architectures), values like 4G might truncate.

Additionally, what happens if a privileged user specifies buf_size=3D0 on
the command line? It seems this bypasses validation and might cause
undefined behavior in ring buffer allocation or remote driver
initialization.

> +		} else if (!strncmp(opt, "poll=3D", 5)) {
> +			unsigned int poll_ms;
> +
> +			if (!kstrtouint(opt + 5, 10, &poll_ms) && poll_ms > 0)
> +				remote->poll_ms =3D poll_ms;

[Severity: Low]
Should this assignment use WRITE_ONCE()?

Concurrent lockless readers like poll_ms_show() access this variable via
READ_ONCE(). A plain assignment here without WRITE_ONCE() violates kernel
concurrency rules and could trigger a KCSAN data race warning if accessed
while the boot cmdline is being applied during remote registration.

> +			else
> +				pr_warn("Invalid trace remote poll '%s'\n", opt);
> +		} else {
> +			pr_warn("Unknown trace remote option '%s'\n", opt);
> +		}
> +	}
> +
> +	return dmesg_on;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924145754.1285=
146-1-vdonnefort@google.com?part=3D18
