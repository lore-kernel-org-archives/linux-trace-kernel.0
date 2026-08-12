Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54144C64B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554710; cv=none; b=dRNTReeBIK4WruqoctzAP1Xmmym0shjH3am5RyPYKT+KcrnnqhPXJD8Sb2jPenbfzYMgXXxDluEqSN/hXqyQ9e2cCHZLzfKCKDoeVvWFAF+01r55kFuzZMuQj+BWIk+JDMNsmZaFRnADViD2t2Rs1GaMb3zn/GSN5dgkYrGb8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554710; c=relaxed/simple;
	bh=UHc61Kz+zRvjLOzy0mPpOlhcDc/Wbz8rhXSR4SOJHC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6AhHGOyJJT/z4XFxEJvKOUMcjQce5cqbpKrkcsaemlwQAorwbJrqbxekBeXv3nkwy/tfg/B7JB0VtD++0u8SqY9hCvkRstxj6vwmHMY5WAb63bEYGi7y7E5mcGBZaJBdfhHY7UdWCEuRIzIFF9OuP1rc4exsmvB3dxGbwEZ3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMsNFlKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMsNFlKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E9F1F00A3E;
	Wed, 12 Aug 2026 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554709;
	bh=E9r0IXV9CyR/r40IEV4uOFSibfHez2fnCxK2lm9uBZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMsNFlKJDrjhL3zesfWIF33gQKtLhtw7Ovt9Knp8HbSqtW9ccZezq1ptPP0QHckeJ
	 mLhkk6C2ejqHRFt4hWxowGjyi+v+DkklmpQZMW/J8xtDxBwHk/C0EW999m7A8ZWGNc
	 o8vQQz3agdbmKGqLZjtbvTtfFRuh8QZKpyExKAt8khYtm/4OQbi3VBZHtWPguEIJ+t
	 JR3KjfJwCmLqyZsAQOR8udZs16+wbbJdpdqXXpt81oTMk3fghSV8gugC6M+A2C5y7h
	 a6XNpyyIeDhT7y3AmKbTq6P1TC+6lnOZrYSFnQWp4BVVtg1LWEzj8Nkl/edmjtOVGb
	 JPNOjdYekJ90w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/18] tracing/remotes: Add trace_remote cmdline
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-17-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-17-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:11:48 +0000
Message-Id: <20260812171148.D9E9F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] User-controllable command-line arguments inappropriately trigger=
 a WARN_ON().
--

--- Patch [16]: [PATCH v5 16/18] tracing/remotes: Add trace_remote cmdline =
options ---
commit 473129b2ec6ced6d4d23093ce86b83497f7202d2
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add trace_remote cmdline options

This commit adds a trace_remote=3D boot command-line option to configure a
trace remote upon registration. It enables configuring various options like
buffer size, polling interval, and activating specific tracing events.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index b1c75666ab638..8764d0ed39097 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -1169,6 +1171,124 @@ static int poll_ms_show(struct seq_file *s, void =
*unused)

[ ... ]

> +static void trace_remote_apply_cmdline_opts(struct trace_remote *remote,=
 char *cmdline)
> +{

[ ... ]

> +		} else if (!strncmp(opt, "buf_size=3D", 9)) {
> +			/* buf_size can only be applied if the buffer is unloaded */
> +			if (!WARN_ON(trace_remote_loaded(remote)))
> +				remote->trace_buffer_size =3D memparse(opt + 9, NULL);

[Severity: Medium]
Should this be a pr_warn() instead of a WARN_ON()?

If the bootloader passes multiple trace_remote=3D parameters, and an earlier
parameter enables events (which loads the buffer) before a later parameter
tries to set buf_size=3D for the same remote, this check will fail and emit=
 a
warning.

Because WARN_ON() is used here, a simple typo or misordered boot command li=
ne=20
will trigger a splat and cause a kernel panic during boot on any system=20
configured with panic_on_warn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D16
