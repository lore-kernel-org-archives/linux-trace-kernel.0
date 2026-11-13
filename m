Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552942;
	b=hoCgEJN1Lmbj/+KCLfRBG7vsShPuwKXLNigOPD02C0k5kAaREkBc5OPZRZH4Uw3PX1YI
	 mJiCBPiGClcXp/OlGpIMy6INKMwNdEb3lMblKm4zUeM2TMNUFwdU/MCVTWmvK2Guq9Km7
	 Ug0gO8gQPCD9/Fju7EUBK69BYMCncietdJ7IAgipyr6S/4QUtYrogF4R42xFUXfUKvp0G
	 2Zyw/Vrz2ExzslnorSpzh2TKHuyDZQ6NbdVaV9LPEhqxGOyskWcnCAUAfOQhrtU4QmLGv
	 X2dPiZJISwlwVf6g9JcC3X7nLydwJAMY9LpofrdwDFe7ZXgQhHWNUp99UQBMtdgzKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LcjQbU5MJBFFTvxN6E0jZwUzgtDuLBFpL4y5wg2SMkI=;
	b=Qrjwq5Fm7Qko47Ib2JOoRetYLHmNyPnVskT+69jfrh2s0+fYHA7OMRD3azDq/GxRFiwe
	 MxodaXRAIq6CZ+dO1r1cI6g1oRQ0vznMAQRPQEt7E4J/COGbYA9uTXMrlun/Nvt/SFBEG
	 RJdsdsX+L2xQ/YtaR5KtmnGxcOkjy1Z7/jXFCaEl8R0mD5FbrTgTKHC9xMQ3fq8lDlnKo
	 oxjZMJNbeYv/cPzzO811RRHOYiJqxFYYj5u6WK2+kS+iY12S8IHEjypHoU7NBGiObomZx
	 5trIkF1gIOHpjLZpQdQk7m2lf1oJTezuWwpoYNSzW/DzMXm2/LoOSm8vCSHZrcs5Gsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJEn5PUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9060A3825
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJEn5PUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440DF1F000D3;
	Fri, 13 Nov 2026 06:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552942;
	bh=LcjQbU5MJBFFTvxN6E0jZwUzgtDuLBFpL4y5wg2SMkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJEn5PUgeQcxL35yZd4qN5SbLEIaXK/ymdYE9CRBKkSJEXJsFHU8BCepwKBx5D+az
	 G3ICxCRsLBUR9mGAFIW9bk96Pc36f6fGsO2TCZ2AQjMBxA8/ZRzGRAmvfB86/gBj1c
	 BmEnUxmTIonHgwrhsK1LfK2UcYAcqmliFfJ6O6/mZdh9iTdIx1p9BP7isKt1rmQvp3
	 jzLCzAaWA6JH43PfD4CIfrOL+GMX9L3h4YjjnoTofWNIRrYPi6L5XBFtizlFGBPggE
	 Md8WMBidXXDFBuxYtAvu6f+rjuIHCbRtB/mbQvGPG3mE11MCzJLfmXa1jetX6buoIN
	 JclmIraB4+Nig==
Message-ID: <sashiko-outbox-212297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] tracing/osnoise: Refuse timerlat fd open if
 tracer inactive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113064103.3041704-11-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
 <20261113064103.3041704-11-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:55:41 +0000
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
- [Low] tracing/osnoise: missing Fixes: trailer for timerlat_fd_open()
  fix
--

commit 2b08a7c2950ae2b8e79253b75767a234cab88c0c
Author: Crystal Wood <crwood@redhat.com>

> tracing/osnoise: Refuse timerlat fd open if tracer inactive
>
> Besides being generally bad, allowing an fd open when there are no active
> instances means that osnoise_options_write() and osnoise_cpus_write() will
> leave it active during reconfiguration, causing at least WARN splats.
>
> Signed-off-by: Crystal Wood <crwood@redhat.com>

[Severity: Low]
This fixes a bug in timerlat_fd_open() where a user fd can be opened while
no instances are registered.  Should this include:

  Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113064103.3041=
704-1-crwood@redhat.com?part=3D10
