Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597723CBE66
	for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Sep 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496799; cv=none; b=MgDqsQQQmjGOF6/lBI2EN4i4N5AWaxWqjdr/rlHKqAcz8gCikYyM5QOGGzYbnauDOGimIYKe2n5pDdnLMcHzDGqd19tjoixLQ58b1JPkAGSUQBDU+Q1PLfQOaA/qP6Tvo4TCqxwNJBKiRpesaKqk5aofGYrAoiz5tKPJePm9sXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496799; c=relaxed/simple;
	bh=f05sHYHgxj5NToxSUoWiuGtjc4W3Ag0etaG8AwV0kG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6H+vtOIl4F2Z7WqrdDOHuW9CrVLAXrqSybpwo1jSuu7rV1dMAQR5DgJVIrN8HvNgcgo6LDVUUCjOdmsZgn3TjpYfTIJHK63TxQcGBUIo4cY8tfQ6m851ymHISXwGq9vAugRWEz5Vw3PfaEsCsSaIRke6qKcBEY2Bc/FJTxZKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKuk6OXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKuk6OXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44771F000FF;
	Sun, 27 Sep 2026 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790496798;
	bh=q8hdkYLVqjenOOxCDW6NT/XRyqurwxM4avTtLwyWxUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKuk6OXnGXs6QjU3GkBo6//dM/JDpO7xDeKJk0z9PyzR+aEEIW6+Sraen4ViZH7aa
	 CNMWQpdm9KnOX3oVj3IiQ8XGz9BiA8ZNjcWheCV3eTgcr9VhSvN5yMafXAPO2qpLRL
	 a8yt7MzT2k5lSE1n5Pi5PzqvGKmfWVOBC7r6z9xDVR8mUaCfMG0szBWDsPn0Pb+PNl
	 zWtI3tZRT2fwHpT54OMhg6mpZCnEb0K+EzxvblEz6iJXUrCwBUVamy0KJE6F1BypCt
	 276laWMi0yvUjll3QeBXt5mjxuaxoTZc4ID9rjZUjUX5wQ3i6zgI/qgwYvj1Lv+DjZ
	 qctGCGrbH7huw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 08:13:17 +0000
Message-Id: <20260927081317.D44771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] sysfs: driver_override taint is bypassed by subsystem-specific c=
allbacks
- [Medium] sysfs: restoring default driver binding unconditionally taints t=
he kernel
- [Low] trace: TAINT_DRIVER_OVERRIDE bit in module_load event is dead code
- [Low] panic: off-by-one calculation in verbose taint string comment
--

commit a5915871a0d2d9897b48b1d7e230f229bd1e51f7
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Add TAINT_DRIVER_OVERRIDE for usage of driver_override

This commit introduces a new taint flag, TAINT_DRIVER_OVERRIDE, to track wh=
en=20
userspace manually triggers driver binding via the driver_override sysfs fi=
le.=20
It includes updates to the core bus sysfs callbacks, documentation, and the=
=20
module tracepoint definitions.

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index c51ad96d4de4b..7d5dc016a457c 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *d=
ev,
>  {
>  	int ret;
> =20
> +	add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);

[Severity: Medium]
Does this unconditionally taint the kernel even when restoring the default
driver binding?

If userspace writes an empty string or a newline to clear a previous overri=
de,
the kernel is permanently marked as tainted. This seems to contradict the
intent of only tainting when forcing a driver.

[Severity: Medium]
Is this taint bypassed by subsystem-specific callbacks?

Subsystems like SPI and AP queue define their own custom driver_override_st=
ore
callbacks which directly call __device_set_driver_override() and completely
skip this new taint injection.

For example, in drivers/spi/spi.c:

static ssize_t driver_override_store(...)
{
    ...
    ret =3D __device_set_driver_override(dev, buf, count);
    ...
}

Should this taint be applied within __device_set_driver_override() instead
to catch these custom subsystem sysfs callbacks?

>  	ret =3D __device_set_driver_override(dev, buf, count);
>  	if (ret)
>  		return ret;

[ ... ]

> diff --git a/include/trace/events/module.h b/include/trace/events/module.h
> index 19df3e39bba43..c7cdb1f53bc64 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -27,7 +27,8 @@ struct module;
>  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>  	{ (1UL << TAINT_CRAP),			"C" },		\
>  	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> -	{ (1UL << TAINT_FORCED_BIND),		"Y" })
> +	{ (1UL << TAINT_FORCED_BIND),		"Y" },		\
> +	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })

[Severity: Low]
Is this trace bit reachable?

Since add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK) is
called with NULL rather than a struct module, the taint is only applied
globally to the kernel.

Because the bit is never set in any individual module's taints bitmask, add=
ing
this to the module trace event flags appears to be dead code.

> =20
>  TRACE_EVENT(module_load,

[ ... ]

> diff --git a/kernel/panic.c b/kernel/panic.c
> index b824b68fcb084..f5476a61f6f39 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c

[ ... ]

> @@ -862,7 +863,7 @@ static void print_tainted_seq(struct seq_buf *s, bool=
 verbose)
>   * exact size is allocated dynamically; the initial buffer remains
>   * as a fallback if allocation fails.
>   *
> - * The verbose taint string currently requires up to 344 characters.
> + * The verbose taint string currently requires up to 364 characters.

[Severity: Low]
Does this undercount the required buffer size by one character?

The newly added DRIVER_OVERRIDE flag requires exactly 21 characters (15 for
the descriptor "DRIVER_OVERRIDE", 2 for the ", " separator, and 4 for the
format "[Z]=3D").

The true required length without the null terminator would be 344 + 21 =3D =
365
characters. INIT_TAINT_BUF_MAX is sufficiently padded (370) so this doesn't
cause an overflow, but the documentation appears to have an off-by-one.

>   */
>  #define INIT_TAINT_BUF_MAX 370
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790495516.gi=
t.u.kleine-koenig@baylibre.com?part=3D2
