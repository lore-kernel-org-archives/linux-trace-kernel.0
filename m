Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2252D2CC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072167; cv=none; b=Vzd6HQchDVoH4UZ2v6JeNFLy1ZuIoQ+kjFiWbnirgKbzFidMr5mMYJJs/+ly7kUhbeYqTEFUfLU/3pGXNddRZTQ/tr4PHxiFycFHJrgsp7M5witBvGkio1CMBVW3nKVWBtB1V2lg7hjF2s8RR/FsnHtOnjxq02FAph/VWTvYkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072167; c=relaxed/simple;
	bh=63xvl/dCNxPpRa7UmMA45Eo3r9o0ixOEnafEzn+SAv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q5Fw6UYbcsa0vmrT83ty6ZBiVUNHiw9KnkIY3Kvr77vr1nbA7b5DFKSZjFSk5Imao/MU/p/rKlS1u3hYQsV0ZFxlbOWN7t04E/PwpHqpwV0ozzVzZxO+68nJmOx1HByzEqr1IbJRWqxOu8nCb/HlE5Bq7KI6h9Iar9gFslPR8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZilu+Lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZilu+Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1451F00898;
	Tue, 22 Sep 2026 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072158;
	bh=62/yT5MZHoqie2TwgVtD1VGhc/73aaWFHRNupMJhNxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZilu+LpbuzBTB4qUJQu/wNr7cn1vHbSgb6ZyASO1RkVzUYX56tLlYPVl/Um9xOrw
	 lIriQQW+qAcZhVsKvaa1KXXKWREurHTDqz8WRdLKC6xPiVQdpFDmm+Fxz6HKLnLNxd
	 qy6E2SU2vLA6GyvJ3fr0qimVhho0EJzpBJ5XXwauKdX82NuGHhIpo/6f88ZNYb5PVk
	 m8zfD4yHBlErIz+KEzya+nIILsOEZOMxKFVVG8zwoRQ3VPKO4gUqt2s9LPwKCely1g
	 WucxXG8H7LAPnSkoBw0Pv1SKwKc2S/3/Bha9cQxpO7efk8xlU3V1l4Zjja6X/CoA18
	 DXnI60wPuOOjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] net: drop_monitor: use drop_reason_lookup()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921101538.97286-10-johannes@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-10-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:15:57 +0000
Message-Id: <20260922101558.BC1451F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing prototype for drop_reason_lookup() on !CONFIG_TRACEP=
OINTS
--

commit 052e9cafef9be2c8ee3e8254caa3827b7ac1f5b6
Author: Johannes Berg <johannes.berg@intel.com>

net: drop_monitor: use drop_reason_lookup()

This commit updates drop_monitor to use drop_reason_lookup() instead of
exporting the drop_reasons_by_subsys list. It unconditionally exposes the
drop_reason_lookup() function.

> diff --git a/include/net/dropreason.h b/include/net/dropreason.h
> index dc4a60130c09c..4680da5964ef7 100644
> --- a/include/net/dropreason.h
> +++ b/include/net/dropreason.h
[ ... ]
> -/* Note: due to dynamic registrations, access must be under RCU */
> -extern const struct drop_reason_list __rcu *
> -drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
> -
>  #ifdef CONFIG_TRACEPOINTS
>  const char *drop_reason_lookup(unsigned long long value);

[Severity: Low]
Will this cause a missing prototype build warning when CONFIG_TRACEPOINTS
is disabled?

The drop_reason_lookup() prototype in include/net/dropreason.h is condition=
ally
guarded by CONFIG_TRACEPOINTS.

>  void drop_reason_show(struct seq_file *m);
[ ... ]
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index de294ce08a32c..a4ae26acc68c2 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
[ ... ]
> -EXPORT_SYMBOL(drop_reasons_by_subsys);
> =20
> -#ifdef CONFIG_TRACEPOINTS
>  const char *drop_reason_lookup(unsigned long long value)

However, the function definition in net/core/skbuff.c is now compiled
unconditionally. This causes a -Wmissing-prototypes compiler warning when
compiling the kernel with CONFIG_TRACEPOINTS disabled.

Could this break builds where WERROR or W=3D1 is enabled?

>  {
>  	unsigned long long subsys_id =3D value >> SKB_DROP_REASON_SUBSYS_SHIFT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921101538.9728=
6-6-johannes@sipsolutions.net?part=3D4
