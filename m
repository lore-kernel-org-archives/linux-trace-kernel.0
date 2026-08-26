Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0216399CED;
	Wed, 26 Aug 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740493; cv=none; b=cmHxjUcoUifNbxolWgAEHnbpc0L1OAqgemus2GMjdPsl6bAd5WJs7Wks5SLnm06T8enBrVtuZzFIXlwd1XfYSMboDDtbxBaWg/k76JkPxYB+BoSIDCS9vU3sZ9iLCL6RIGBBXN4gGqNXBtonqyoQ9FXpzOk3s+vJVrSLUIUTqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740493; c=relaxed/simple;
	bh=qwjw96CT2f9n2i/wAtn+2ch7oPz2ad31/nHWO//p9Bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OrtcTp8eF1QvPIcwmEmZZceDBj/A6MBqDezAAYOHyr617t2lGh1VOQPeprgyX54sKjJwiotcgd+hOVyrdTowpfVTl6p+8NlCn/VVeTp/yfrJ9F1MtetGUEnoBbcSYlsSyyNyIrEQs1pW02yk4j6CxgDF4Xzjakg3rDHWNxYWogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ9oR2xB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ9oR2xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385891F000E9;
	Wed, 26 Aug 2026 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740491;
	bh=qKGtjMs8le4m1OzWypkxQBSOk1A2TIi4KKhlCMMi0Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJ9oR2xB0bZ3JrnTKBcmLvFfNjjSzTEm4Dd2hCfOtFPBXPzocHnhu/B++uuUHl7rb
	 xQ0WbtfHTVZZHW5wHWXB+aTzcARKKEAQbtgK75yXyvc+fQVEnGQoDa0GukmlY9T2cv
	 teZXh/LabdaTAOFEzql7siQ/+DYhitKyca3sLo21udzzFpVtrKc9Il7iwkE8KSjNJQ
	 gp/OLuayJ6Bg7KEAVVkJe/4XEFZcC4t8ZFX9N6YcD6AxJordVFfqW8UUFSL/j+pwtQ
	 yyzMJtiAVkz3sMBeydY7OloOcQe0vKRgJbi8XrF3YujiJWQ8bvif5lOKMmqHTccMKz
	 Letaa6YJtr0eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260826-bind_taint-v1-2-52b05f4a965c@linuxfoundation.org>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-2-52b05f4a965c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:34:50 +0000
Message-Id: <20260826103451.385891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `add_taint_module()` unconditionally dereferences `drv->ow=
ner`, causing a kernel panic for built-in drivers where `drv->owner` is `NU=
LL`.
- [Low] The patch breaks the build when `CONFIG_MODULES` is disabled due to=
 a syntactically invalid inline stub for `add_taint_module` introduced in t=
he previous patch.
- [Low] Malformed reStructuredText simple table and outdated `seq 20` scrip=
t in the tainted-kernels documentation.

Pre-existing issues:
- [High] A race condition in `unbind_store` allows detaching an unintended =
driver if `dev->driver` changes concurrently.
--

commit 4cfb386dac8b53407ce0309b005475cf263546f7
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

driver core: add TAINT_FORCED_BIND for when userspace manually messes with =
devices and drivers
   =20
Add a new TAINT_FORCED_BIND taint flag to track when userspace successfully
adds or removes devices from a driver via the sysfs bind and unbind files.
This helps identify when userspace fuzzing or manual interference causes
subsequent kernel crashes.

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index 9ead927a37c0f..d4ca8b9e3819e 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -79,30 +79,31 @@ which bits are set::
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Bit  Log  Number  Reason that got the kernel tainted
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D  =3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Bit  Log   Number  Reason that got the kernel tainted
> +=3D=3D=3D  =3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ ... ]
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/Y  1048576  device was manually bound or unbound from a driver
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
The header separator for the Number column is 6 characters wide, but the
footer separator is 7 characters wide. Can this mismatch break Sphinx
reStructuredText table parsing?

Also, does the quick-check script just above this table need to be updated?
It uses seq 20, which fails to cover this newly added 20th taint bit
(requires seq 21).

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index d17bd91490ee4..c51ad96d4de4b 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
[ ... ]
> @@ -241,6 +242,7 @@ static ssize_t unbind_store(struct device_driver *drv=
, const char *buf,
> =20
>  	dev =3D bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && dev->driver =3D=3D drv) {

[Severity: High]
This is a pre-existing issue, but is there a race condition here?

The check of dev->driver is performed without holding the device lock. If t=
he
driver is detached and a new driver attaches immediately after, could the
subsequent call to device_driver_detach(dev) blindly detach the unintended
new driver?

> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);

[Severity: High]
For built-in drivers, drv->owner is NULL. Does calling add_taint_module
unconditionally dereference drv->owner, causing a kernel panic when a user
writes to the unbind sysfs file for a statically compiled driver?

[Severity: Low]
Will this unconditional call cause a compilation error when CONFIG_MODULES=
=3Dn?

The inline stub for add_taint_module in include/linux/module.h omits the
parameter name for enum lockdep_ok, making it syntactically invalid, which
is activated by this new call.

>  		device_driver_detach(dev);
>  		err =3D count;
>  	}
> @@ -264,6 +266,7 @@ static ssize_t bind_store(struct device_driver *drv, =
const char *buf,
> =20
>  	dev =3D bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && driver_match_device(drv, dev)) {
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);

[Severity: High]
Similarly, for built-in drivers where drv->owner is NULL, does this
unconditionally dereference it and cause a kernel panic here as well?

>  		err =3D device_driver_attach(drv, dev);
>  		if (!err) {
>  			/* success */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-bind_taint=
-v1-0-52b05f4a965c@linuxfoundation.org?part=3D2
