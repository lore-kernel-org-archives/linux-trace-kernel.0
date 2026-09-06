Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF3126C02
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715389; cv=none; b=f98I4O03A2z4MAwIGUxNvHsLxf/HLomafPgagghFX6a4ULSKqFS5QG/67aiVS2Aj2MFh3BXIKeqdZmdRwdXgnVGONmaOUPbG76jRPCBYEiAN1XJD6aJgPopiCkvZuPm/LQfdRnqgD+mw1qBKa2bk8hjHvl+AQcsHdl9SUsDV4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715389; c=relaxed/simple;
	bh=F0mCvkYHkfVq3eTyPfhHggLNWWEkSFa3EK2G2hDr65c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EpT0AMl7kq4Ieh7sgRChQMCk2YihNDiZlfwlwnYOmvg74BHvHFzJ+yW97a221JNYlPCIe2uyIU3+vu7t5polEe6lRmyf9x2yyyl+UWOQp1a64mkEmc23POdC04JGq1fSU15zdkF/bCeeYv2QSetn0u+Ld/F6CTWOHkMqaLfciGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNLKjdOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNLKjdOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A651F00A3A;
	Sun,  6 Sep 2026 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715387;
	bh=oAIJHphXUcNOaAI0P/iCL7NS8YWRZv5uGJSQCJXO8sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UNLKjdOGDK82RVOXrre/YDKZp1MZeXI//hBNoqD0RR45c5LQlqqk+VHwRQtITAksu
	 sY8hGRS0XH0BhquhKS9XlU5ZlBi3dflHZ8QhyUgqIPpFdAt7WtNEDLHCffKyfE/MTF
	 CpIqlUd8ZYht233oAl8Uu1avQJ8rAtTp12tckgPzFy1+aYKpzm2Z3cvMueT+bHeQH9
	 2wNUcJIM1vbS8SDUrsBQIIpI/eDnst5ebUQrlNNdiQj+v5BFh0eQh+CoWV/WAxyx6X
	 khvsH6eOBXbR+q9Dty8pVd9Enby9cJ3NQnKzLPvKFM2qJjpY276o6f7l0NYyekZY5h
	 YNcTjQJC9pEsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] rv/reactors: add KUnit tests for reactor
 registration and dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <1262e72539bd8ebc66707eb6f6598549a48285f7.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
 <1262e72539bd8ebc66707eb6f6598549a48285f7.1788705281.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:23:06 +0000
Message-Id: <20260906172307.67A651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typos in commit message and comments, and non-standard use of _Stat=
ic_assert.
--

commit a14edcfd6c547b97a3d6e82ee3b87a759234cdc5
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: add KUnit tests for reactor registration and dispatch

This commit adds KUnit tests to cover the reactor register and unregister
lifecycle, including duplicate and name-length rejection. It also tests
the rv_react() dispatch logic.

> The dispatch tests rely o reacting_on being enabled, since rv_react()
> returns early when it if off.

[Severity: Low]
There appear to be a few typos in the commit message: "rely o" instead of
"rely on", and "it if off" instead of "it is off".

[ ... ]

> diff --git a/kernel/trace/rv/rv_reactors_kunit.c b/kernel/trace/rv/rv_rea=
ctors_kunit.c
> new file mode 100644
> index 0000000000000..a408edcdde04f
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors_kunit.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for RV reactor registration and dispatch.
> + *
> + * The dispatch tests rely on reacting_on beinng enabled, since rv_react=
()
> + * returns early when it is off. It is on by default when the suites run
> + * built-in; as a module, re-enable it if disabled via
> + * /sys/kerne/tracing/rv/reacting_on.
> + */

[Severity: Low]
There are a couple of typos in this file header comment: "beinng" instead of
"being", and "/sys/kerne/" instead of "/sys/kernel/".

[ ... ]

> +static const char long_reactor_name[] =3D "kunit_reactor_name_too_long_x=
xx_";
> +_Static_assert(sizeof(long_reactor_name) - 1 >=3D MAX_RV_REACTOR_NAME_SI=
ZE,
> +	       "long_reactor_name must be at least MAX_RV_REACTOR_NAME_SIZE cha=
rs");
> +
> +static void test_name_too_long(struct kunit *test)

[Severity: Low]
Does this code use the C11 keyword _Static_assert directly rather than the
kernel's standard static_assert macro? The kernel typically wraps this in
include/linux/build_bug.h as static_assert(), which is the standard
convention for compile-time assertions across the tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788705281.gi=
t.wen.yang@linux.dev?part=3D4
