Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559183;
	b=DITsIrm5Elt3xZwguNs9zSM3e5/JPbimEIrv56IN0MvbjBKSjFwfYL4AYaklhgqGtgfZ
	 lDwonZUFWCbE8RUGdQAUJv/ZQFLrjVFJ9gfGNuVEdyu9adQ9D7zjyQtjPJYboHClGPFIP
	 6ao/ySEDUvV/beC2DA5QLvL55kpYM+Sa+iJYbCJ7mZWYGwTXVpJJbJWp4WkKlqV6qRlXL
	 x7njw1w/LSsigaCyHCo9dRyTAjzGIzh5DZlZPk5wirTzoe0je8pkWE0SOgzrEUc+Eg1ow
	 nBx0oZtPnlW+Nw4Sqd3JIWg07ShEptJOZAaTRr+PX1/YJsGyJ/mgxcYXhnpqpigUNuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jo2D7rafSXn7MRHONzUOWQTch/mRK7gpHYvtztE3N20=;
	b=H9ouJ2AntgUnerr0sRXxhQabIDhzGas8V63ZkufwCIW4HafIaA6GZL7cARWjVezmW/ct
	 OcFgtbtrMAS+M9t97UgKCEKeAyklajC/ROsiZVhkCUmOlep8QAnppwVHYoOgfUJ5OKf26
	 kunxB4Me9+GoEhdkEyNYIQqbyEsFaWudPQE1iE+oAD1qsp/hSNBFHiaQ1QAm46qyYszM3
	 ooleihB1C5xs1hPYPIVPzfxYl0aM+ehO4+01xOrp+28q7bWKshY5vyZlk/vp6Bds703wc
	 sUq8D5GJRQzOt4+E3+2U+BTOlPyLMzitxap3+3qEt8DASi83HPCCMLEM+oP05Zf0aow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH+mQ36T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44660A2613
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH+mQ36T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A82D1F000C8;
	Fri, 13 Nov 2026 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559183;
	bh=jo2D7rafSXn7MRHONzUOWQTch/mRK7gpHYvtztE3N20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NH+mQ36TdKu7t3ThsAKNU0UO9CT6YDjFgBEXe+BvQ59sXz3J1PLrvFTpvFzhL+hKV
	 stQ5OuLHzkucjZ6Qq66FGpyqOYSx0ZKCh3O2YN2oU2RjxglUXWdOypDk9BhUjrSo5N
	 D22DU6o29MXYmjzlOnj1ihA15NPkhJAoxKxBwN3noANNj2hf6GmEhIXMrGeUp4eRkf
	 BxCf1ewrQHmyQctMwdTK1g6qoiWQdYMHUcAwunTUknWQdsaNPDXfmPVFRVu9gBH4Mv
	 aNaJObrZBctGSWl5wwxKBkPhSW6kB9q8GbWYUafDg68dveTIp3j1awYtiM6V0ySoRM
	 2+XTqQxKb1KCA==
Message-ID: <sashiko-outbox-212435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] tracing/probes: Allow symstr type for function
 entry arguments in return probes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179455857080.403392.10171666250083335438.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
 <179455857080.403392.10171666250083335438.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:39:42 +0000
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
- [Low] tracing/probes: missing Fixes trailer for FETCH_OP_EDATA symstr
  fix
--

commit 48b9066b7edfcc25acab7912c4c55cf34cf5c88d
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> tracing/probes: Allow symstr type for function entry arguments in return =
probes
>
> Function entry arguments accessed in return probes ($argN or BTF entry
> arguments) are fetched from the entry data buffer via FETCH_OP_EDATA,
> which was omitted from the allowed operations for the "symstr" type and
> rejected with BAD_SYMSTRING.
>
> Allow FETCH_OP_EDATA to be formatted as "symstr".
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[Severity: Low]
FETCH_OP_EDATA was introduced after the symstr type check in
finalize_fetch_insn() already existed.  Should this include:

  Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kpro=
be and fprobe)")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179455847934.403392=
.15146485751358774349.stgit@devnote2?part=3D10
