Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E744237F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975975; cv=none; b=JuIDxS7bY/TtbRNJoFDsGsOsMWAhwwKuZPF0S3IsGU2OKxViFYTw78o1HzRowiDy/m+LVapeD/UUzsy2e1BlrOfBx0SigKjcdke1+Dpw+XFcDzJGC9Mh1gpRR3PIrHoAGnRYJ+3n1YDKE9SzfRlmvl3clfMXp2KBsr5gmSvWxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975975; c=relaxed/simple;
	bh=Y65HKPPTeZBxnSLao3JEWI0PmPWtlw/TOGgp5lxaKVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGZ8HJGs5wRFvKmOvqmtRQNZAXO44JuaWE6YFBxp4IUQ/QoaYvJSlbX5wGKo4DCmmZZLV+gBUFWzjUSi88x5829eZBzFlukhpxwZn+UkB1rHkHlaaOCBOoaKTUF7u428y6++tEwHpVrbAUWNOn//XEiKZvSI0x/c+F1Fa2eTz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU9ZgeMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU9ZgeMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD471F00A3A;
	Mon, 17 Aug 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975972;
	bh=4xR5bVlhMaSaFwQqgde/QWQpoBT46WytYqP7dlNeR4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lU9ZgeMgVVnDiBqebFXjmaETZvbI6e+Zaiaj8PaORpz0DneiiDDUXHrgMPDdhcTU7
	 PBn1xzN/GAgHE8H7H/+Ih4cMy9x1fvIAa9gQ4HEnv4YL67JVEX0PEUolf/u9xts1Q+
	 o/wVtrtso6UVGeRNysw0vPqVHbApbZsldwSch4j2L74uNPvEEaioGfiU4d2eEItRGV
	 6uFoweJe9OVaz6fKovH/1Fm0U7OSQ6/L1dye5GilYv9AhjQbM5HZUIJc1E581eRy3w
	 Z0zU1p22gUQO1RKjuZwhHxSj2I8TeDg9DfTzv2OYegFvGNSd5xhtZ/wzlsZTy98zxJ
	 CVAFwBmURJDqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/18] tracing/remotes: Add trace_remote cmdline
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-17-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-17-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:12:51 +0000
Message-Id: <20260817141252.4FD471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `dump_on_panic` command-line option sets `remote->panic_on =
=3D true` but fails to dynamically register the panic handler if the trace =
buffer is already loaded.
--

--- Patch [16]: [PATCH v6 16/18] tracing/remotes: Add trace_remote cmdline =
options ---
commit 16551de261e3bdeffe51c1a5227c6a115ddbe725
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add trace_remote cmdline options
   =20
This commit introduces command-line options for trace remotes, allowing
configuration of features like dump_on_panic, dmesg, buf_size, and poll,
as well as enabling specific trace events automatically on boot.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 204d5bef7a8c4..34847463d9e43 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -1170,6 +1172,126 @@ static int poll_ms_show(struct seq_file *s, void =
*unused)
> +static void trace_remote_apply_cmdline_opts(struct trace_remote *remote,=
 char *cmdline)
> +{
> +	bool dmesg_on =3D false;
> +	char *opt;
> +	int ret;
> +
> +	while ((opt =3D strsep(&cmdline, "^"))) {
> +		if (!*opt)
> +			continue;
> +
> +		if (!strcmp(opt, "dump_on_panic")) {
> +			remote->panic_on =3D true;

[Severity: Medium]
If the trace remote was configured across multiple command line arguments, =
and
an earlier argument already enabled events (which loads the trace buffer via
trace_remote_enable_tracing()), will setting remote->panic_on =3D true here
fail to register the panic notifier?

Since this doesn't call trace_remote_panic_load() if the buffer is already
loaded, it appears the panic handler might never be registered under this
configuration pattern.

> +		} else if (!strcmp(opt, "dmesg")) {
> +			dmesg_on =3D true;
> +		} else if (!strncmp(opt, "buf_size=3D", 9)) {
> +			/* buf_size can only be applied if the buffer is unloaded */
> +			if (trace_remote_loaded(remote))
> +				pr_warn("Cannot apply buf_size after events are enabled\n");
> +			else
> +				remote->trace_buffer_size =3D memparse(opt + 9, NULL);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D16
