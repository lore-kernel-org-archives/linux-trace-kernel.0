Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA423481231;
	Mon, 14 Sep 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396983; cv=none; b=tJ3DruamwtvoMQMO81gDjEfPNf6oBeQeU0hL8zts2kHodnaEU7qEHLoGDfMEL3cyrTFqWiIGrkOCrrovbqhTAcv3M3dWOgsQ+WSfv5dhx5XgE2aZBywqWyVC3ckctNI5VkALkQM/GrhFjkGPfzAXNWt4LKfQ5JRB3pCktxhVGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396983; c=relaxed/simple;
	bh=qDHyq0JxA0MQzYqGwlRzx8FMlW/YU8I4giAFJmKG5So=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBW+bvBefuWWD2m7h6wI4xgPQ7mdQkBFPVD8syrRYtPAGSJJMXEVYX4PjOxcabkBshejidghNi0X2zV12tmRNZGNi+v5f2RvMxIAaVoFcA4QxvoHNb/UR0jOKoYR5uI/O8QldMlTucg16eeYmagONWL9Wqna63xC4/x6GRGVaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocljVY4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocljVY4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245361F000FF;
	Mon, 14 Sep 2026 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396981;
	bh=0wlhzG9211FugmcEcAxbGZisX5jqXngmpLRpkamgPh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocljVY4c2MVV/J7VMi8JrRsiHTpNZq5yHED574puZxaBQH1FLicCnLU6/yT8oFpP8
	 T0fl2W9pTx25dJcddUhg10JCNKEALkVomZXurtEVS2UyUjZdtUU7Ann8kk5Wf11E/T
	 +QIkMcFimHG5UhHwIg5XuRHrlM/jsEDK4WxMEUIDGCnRCzQmAw39vBtAEk9AivYklf
	 wjMNTPiOTvKkIvsuuXvVNJQVcKPoqQa0hLq9EjkfeajDIXx+MVvaldP9vJ9jpIaR1f
	 dkxjpkP4gqx16pITO73PBFiK04shIc506WaS97dil8GnHB8t6acMQo1vF+esK686gq
	 zA/YZH+DoZozg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914-bind_taint-v4-3-eadf8a090903@linuxfoundation.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <20260914-bind_taint-v4-3-eadf8a090903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:43:00 +0000
Message-Id: <20260914144301.245361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The documentation incorrectly states that the kernel is tainted =
only when a device is 'successfully' bound or removed, but the code taints =
the kernel before the operation, even if it fails.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a TOCTOU race in=
 `unbind_store` allows detaching the wrong driver from a device due to a lo=
ckless check followed by an unconditional detach.
--

commit ab4daed0c54fee77e3c6d683fc2a55fadc4aaef3
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

driver core: add TAINT_FORCED_BIND for when userspace manually messes with =
devices and drivers

This commit adds a new taint flag, TAINT_FORCED_BIND, which is set when
userspace manually binds or unbinds a device from a driver via sysfs. The
taint is added before the callback runs to ensure oops reports reflect the
attempted manual manipulation. This aims to help kernel developers identify
when crashes result from abnormal userspace driver binding operations.

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index 9ead927a37c0f..abbf5e3dd7495 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst

[ ... ]

> @@ -189,3 +190,6 @@ More detailed explanation for tainting
>   19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DE=
BUG_WRITE
>       to use the devices debugging features. Device debugging features co=
uld
>       cause the device to malfunction in undefined ways.
> +
> + 20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files and
> +     successfully bound or removed a device from a driver.

[Severity: Medium]
The documentation here explicitly says "successfully bound or removed", but
looking at the code in bind_store() and unbind_store() in drivers/base/bus.=
c,
the kernel is tainted before the operation is attempted. Does this mean the
kernel remains permanently tainted even if the attach or detach operation
fails, making this documentation inaccurate?

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
This isn't a bug introduced by this patch, but looking at unbind_store(), is
there a TOCTOU race window here?

The check dev->driver =3D=3D drv evaluates without holding a lock. If Threa=
d A
evaluates this check, and concurrently Thread B unbinds the driver and bind=
s a
new driver to the same device:

Thread A
unbind_store()
    if (dev && dev->driver =3D=3D drv) { // true

Thread B
unbinds original driver
binds new unrelated driver

Thread A then continues:

> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>  		device_driver_detach(dev);

and calls device_driver_detach(dev). Since device_driver_detach() in
drivers/base/dd.c calls device_release_driver_internal(dev, NULL, dev->pare=
nt),
the NULL passed as the driver argument bypasses the specific driver match
validation inside device_release_driver_internal.

Does this mean the new, unrelated driver could be unconditionally detached =
by
Thread A?

>  		err =3D count;
>  	}
>  	put_device(dev);
> @@ -264,6 +266,7 @@ static ssize_t bind_store(struct device_driver *drv, =
const char *buf,
> =20
>  	dev =3D bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && driver_match_device(drv, dev)) {
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>  		err =3D device_driver_attach(drv, dev);

[Severity: Medium]
This matches the observation above: if device_driver_attach(drv, dev) fails,
the kernel is already tainted, which contradicts the documentation stating =
it
only happens on success. Could the documentation be updated to clarify that
the taint is applied on the attempt, regardless of success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-bind_taint=
-v4-0-eadf8a090903@linuxfoundation.org?part=3D3
