Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171337B010
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614700; cv=none; b=UOKrduDP7c6a5TkOG14+Xwy0V5oJeFr5tneYOX05a1y3HQr+bR+83cgs2aIK7HB0ERxbZQJbDL2ID03XF/VzPOYkz/DHmuScDAo6fbCjDdd1Dx3zApBxdiyOWQnoZETe2Kle0GddYjl3CzQc/C8yMQUuqe0LOv2pPgHTS9f9iZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614700; c=relaxed/simple;
	bh=Iiq1i40tNvgCc8a2o2C/phgu3fvRXchPbgx54Vtk6ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y09BdGXzhfoXlLz6yWYIbkYVSmnlmnox4DW6vfFPo6/4FO20mJ8dnfVPzYEJZcOSkdcOjURWxKpBsPKb+P5BqmHp1vu5Xm67s/gLpZbJwiGNGNKPfAc8qELYV9tmVc5X9xCx5V2IwkOutcG9cdIAsOUHWEYjdIqFW28naQaTXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqYJsOet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqYJsOet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F321F000FF;
	Mon, 28 Sep 2026 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614698;
	bh=3fyEgJIhlSFe6INoEINXaXAd0GW24C1VGN9rGmOtUtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqYJsOetDvge3OdZ9GnaiqNhqicVi4/Ei1s6Bm8wc8RSM0VQNhF6dOWSFJkLflrR/
	 3F4CVa96lZXSU/DGkGUIHLbGfLtJjCbNax1IR5ym06v9rMAT+zvW5CsuR61IzOXdyv
	 cl/QMhDsw6WA55/OpxMqLwh2XKaZqXtCfux6yPGCbg/Q79Yrdkzd4QwGL/rYJwTXaR
	 B3C/xfHbFVoYG9YJPPyWan7WHHBuUXVPDG2IKOWGlrHxhpEaXrJ1Ai8T1T/ynTvqXN
	 iot0sbxUl5Eg05IPH3d4LoC6eMcc8fLcxmPLN+c47czjbV3JwCWdInCl3LVLObUEuQ
	 tU29Uz3klElGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:58:18 +0000
Message-Id: <20260928165818.69F321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] device: false kernel taint from internal driver_override usage
--

commit 224a6c2cd832599abb4180f63153f96e5c11d2a8
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Add TAINT_DRIVER_OVERRIDE for usage of driver_override

This commit introduces a new kernel taint, TAINT_DRIVER_OVERRIDE, which is
applied when a driver is matched to a device via the driver_override
mechanism. It aims to distinguish overrides from manual sysfs bindings, as
overrides can lead to driver crashes if the driver expects specific match d=
ata.

Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel=
.org/

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 879eb758b5eec..4dac5e09b74c1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -905,8 +905,15 @@ static inline int device_match_driver_override(struc=
t device *dev,
>  					       const struct device_driver *drv)
>  {
>  	guard(spinlock)(&dev->driver_override.lock);
> -	if (dev->driver_override.name)
> -		return !strcmp(dev->driver_override.name, drv->name);
> +	if (dev->driver_override.name) {
> +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> +
> +		if (ret > 0)
> +			add_taint_module(drv->owner,
> +					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);

[Severity: Medium]
Will this unconditionally taint the kernel even for valid internal usages of
driver_override?

Many kernel subsystems and drivers use device_set_driver_override()
programmatically to force driver matching for dynamically instantiated devi=
ces
during normal operation or probing.

For example, in drivers/clk/imx/clk-scu.c:imx_clk_scu_alloc_dev() sets the
override internally:

	ret =3D device_set_driver_override(&pdev->dev, "imx-scu-clk");

Since device_match_driver_override() cannot distinguish between a userspace
sysfs override and a legitimate internal programmatic override, won't this
cause production systems using these platforms to falsely report as tainted=
 on
boot?

Falsely tainting the kernel breaks the reliability of the taint mechanism a=
nd
could lead to valid bug reports being ignored by maintainers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790612298.gi=
t.u.kleine-koenig@baylibre.com?part=3D2
