Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990038;
	b=JyftdeUMxMqQRon7MFmUywf7JUw/8GJRpAe3ozSCk/Oa1R9apVf/liRJ8j441V24eJ4P
	 EerVLNZxzrkk2tArb+nYqqlpxaaJV4TvOI7eCC0pSfm8g9zgL5uRjhCXfwoWcNEPCpKi9
	 i39aKwtMxMdGnxe48Rwm8XCc1E3sIw+Afeim3/+j//0fh19sLl4KUmm+lmCLiBrYZZBBT
	 Mi0S7dS3k4FUfi5VlJSbP2fAyT/Qhox8LdmzYMIDnGUBTOwPH7UlTJkWorprIz78S34Ey
	 om6TqCo0PI+Sn+lO+bEwCy8xT/Wq5J9Fn7IAO++gALSEA5F6Zjk0ozWNFm4nqC+hYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bfEeDZNy9VOktRws6LkdyiANopNctBZHGNB+ub8cm50=;
	b=2keb8uEl+VN5HDtF2kd2oPiDFhH1Zk91taNCRZ9LNE4K0iPm+2FWXGPYHanwTiUUj5J9
	 rBneskInTkP5gUE17A722rzgh4tI26sBP9Z7a+R9/Ydr2ImXQVu0gR96WWbjnlGfC2ehT
	 oUWN8wCkH+bzUHs/SBou7EqpRCbPzlX83g+wPOxqus7jDinOYCmuP6W7Pz+vVqTWSy/6e
	 HMPRQHvpqMlfaj7NMem9lBPotrL/iHuP1xXXXf1J3PnJaIR7wkONODMdZHkL98COCJ/F4
	 qcUWE4p9uYIxIChkzcvOKELDlCf8p8WNM2EjNBInJzxx9//vTh5uXrEt5/24iOvEYWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A42Y6JCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FBF606A337
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A42Y6JCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0D01F0089F;
	Fri,  6 Nov 2026 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990038;
	bh=bfEeDZNy9VOktRws6LkdyiANopNctBZHGNB+ub8cm50=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A42Y6JCg5PUGV4K+jLO2sFrf4IkwjaMDuLPtZBTap5ecmMLi99PNlDJaQqNYO+V/3
	 BscEE08RIpJIJprVKSi9Ah1ubYpSxEWp0tLEa3xzGmp7CKI8hUXekcjyxZ5CErHSL4
	 UGKMv6sVbq8T5ysK68PZJyIQz8T2wjOz2f2C71KBJw5phrsEVMpv8owQn6H9mc7Z/y
	 AwKTNmk/5cIufc/XbmZPP/Yv3QGe7PwW8Hg+nHU3j8U93mCYiy/oo5ZlmRSWIdAtwS
	 sirFqx8HQ7rKtp98yudTisvfWXaO3yBCihG1oYTCw4r3nwuXajP4R8i8njX92chZJZ
	 QWJuHlL0GUNeg==
Message-ID: <sashiko-outbox-202043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/21] tracing/remotes: Add trace_remote cmdline
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106180657.2460376-20-vdonnefort@google.com>
References: <20261106180657.2460376-1-vdonnefort@google.com>
 <20261106180657.2460376-20-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:33:57 +0000
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
- [Low] tracing/remotes: split __free() declaration in
  trace_remote_apply_cmdline()
--

commit 3674f78ef7ea9a2c747f5fd09bdd3df0f8cecb63
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add trace_remote cmdline options

This commit adds the trace_remote=3D kernel command-line option to configure
trace remote options and enable events upon registration.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index ebfc2dd67b79c..9fa8d38caa3b8 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> +static void trace_remote_apply_cmdline(const char *name, struct trace_re=
mote *remote)
> +{
> +	char *cmdline __free(kfree) =3D NULL;
> +	char *events_cmdline =3D NULL;
> +	char *opts_cmdline =3D NULL;
> +	bool tracing_on =3D false;
> +	bool dmesg_on =3D false;
> +	char *curr, *next;
> +	int ret;
> +
> +	if (!trace_remote_cmdline[0])
> +		return;
> +
> +	cmdline =3D kstrdup(trace_remote_cmdline, GFP_KERNEL);

[Severity: Low]
This isn't a bug, but per the cleanup.h convention, __free() variables
should be defined and initialized in a single statement after the
!trace_remote_cmdline[0] check rather than declared as =3D NULL at the top
of the function and assigned later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106180657.2460=
376-1-vdonnefort@google.com?part=3D19
