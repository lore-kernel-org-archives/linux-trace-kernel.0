Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828987;
	b=xeN5OtT9B4D1Vfyt7KM/5mM5KRBZhum7u8Mxn4hq5qMFoMM5UiwUabB7h1dURgtqSwfO
	 CI64goT23DwMFHANjEh+ASURqdNtdRm8dmtIeM+jROXYDiFZoKDujRLoPE/oDeMJf0jg/
	 Gibt0gEqhWSF0T8lZeSE+exXfQi2xMqid3R+mLUHlSgXrWUjdhpOEghZnBVB4FsPxkmx7
	 IU4Thl0VeMxnbcZYB0SYziBY3QiWzsUQc2hqiuRrtBtRqB3F9ZV54TyeVCqgTEkbqXaD8
	 PHUQb95DAk1NJUv5RSTTG/YdaNkTP6hs863AhOmB3Ba+g1TsQ9vER9UDGJkoblu2Liw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=58MafB7uq94J6VeVyrPBpdqGJpGR7GFEwYOxoX71i5M=;
	b=BNmM5U8JxuMGB8hVh9MyA7q8vCHNqPEELnhSMqLdng1G/alKmKnrDuiqmYJBuKaMX/Zi
	 aRYlVyNABHsfrZrSK92lB2166aSHjzSBjhseVSLZY4Dhg301WS7ClBApqaBC2e3KjSOzj
	 jfCqJdkIiy5xzUF5rIEzGKCXQaDx7q3N/6KQCHLRtEUGX9OMiZR39+bbHlmwR9mJA8vFS
	 oDXwPz7ilrVAjEADRdvfbapCPbcLPFYMjk6BKusU0SX7cC7PBy9k/7Maf6j2mNl+U4E9C
	 MIJLosDRVKrJsCyPuRjNW43hakKtFt1fF6FyuONbbF9D8u4wljY1WJrqHMGCAosj8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otf42Plk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15ED606A32C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otf42Plk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C0A1F000C6;
	Mon, 16 Nov 2026 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828986;
	bh=58MafB7uq94J6VeVyrPBpdqGJpGR7GFEwYOxoX71i5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otf42PlkH7Fqr4iTlY9qB6rTNZfKAU+sAVEmyL6xwjCYACgESIn75lTvXdwCpdznF
	 9YAxcTGrOx8ULgH9jhLjJyEY5QCIoUQPUHVyBGA7J9Q5ddXfIm2W3vuH5AHJIaImfm
	 BObOHlxKjEllyNWckxyMyajYTQO3T6iwj80d6b2nuGqQyFhy+lBiHKdUq2NAgr5o28
	 9+ZBh0KVE5YI3XBli4NmLwCvTEnV7DVPebV+aiSsGgFoYQz10dbo1HQg5qtcKHmygR
	 2+gYvByijWg/YrQeb0b5es28NlDqoS1KdItWPST/b4adR6ZXMD8WEDFWJZ2VAnT9Qt
	 hbhN6InKPsB/A==
Message-ID: <sashiko-outbox-216950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] driver core: Disable driver overriding by default
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
References: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:36:25 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] driver core: device_match_driver_override() returns -1 instead
  of 0
- [High] driver core: disabling driver_override by default breaks
  in-tree drivers
- [Low] driver core: allow_driver_override_setup() enables override on
  parse error
--

commit 06f24686a63b0776fbdf7d5d7bb34b7905ceba41
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

driver core: Disable driver overriding by default

This commit disables driver_override matching unless a driver sets
support_driver_override or the allow_driver_override=3D1 boot parameter is
used, and adds TAINT_DRIVER_OVERRIDE when an unsupported override match is
allowed.

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 396097fdb3162..5344b20488fde 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -603,6 +603,56 @@ int bus_add_device(struct device *dev)
>  	return error;
>  }
> =20
> +static bool __read_mostly allow_driver_override;
> +
> +static int __init allow_driver_override_setup(char *str)
> +{
> +	if (!str || kstrtobool(str, &allow_driver_override) < 0)
> +		allow_driver_override =3D true;
> +
> +	return 1;
> +}
> +__setup("allow_driver_override=3D", allow_driver_override_setup);

[Severity: Low]
Does allow_driver_override_setup() enable allow_driver_override when
kstrtobool() fails?  Passing an unrecognized argument such as
allow_driver_override=3Ddisabled or allow_driver_override=3D causes kstrtob=
ool()
to return -EINVAL, setting allow_driver_override to true instead of keeping
it disabled.

> +
> +/**
> + * device_match_driver_override() - Match a driver against the device's =
driver_override.
> + * @dev: device to check
> + * @drv: driver to match against
> + *
> + * Returns > 0 if a driver override is set and matches the given driver,=
 0 if a
> + * driver override is set but does not match, or < 0 if a driver overrid=
e is not
> + * set at all.
> + */
> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv)
> +{
> +	guard(spinlock)(&dev->driver_override.lock);
> +	if (dev->driver_override.name) {
> +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> +
> +		if (ret > 0 && !drv->support_driver_override) {

[Severity: High]
Does rejecting driver_override by default before any in-tree driver sets
support_driver_override break in-kernel callers of
device_set_driver_override() and git bisectability?

Several subsystems call device_set_driver_override() internally to bind
kernel-created devices whose names or ID tables do not match via normal bus
matching.  For example, i2s_create_secondary_device() creates a "%s-sec"
platform device, sets its override to "samsung-i2s", and calls
device_attach():

sound/soc/samsung/i2s.c:i2s_create_secondary_device() {
	...
	ret =3D device_set_driver_override(&pdev_sec->dev, "samsung-i2s");
	...
	ret =3D device_attach(&pdev_sec->dev);
	if (ret <=3D 0) {
		platform_device_unregister(priv->pdev_sec);
		dev_info(&pdev_sec->dev, "device_attach() failed\n");
		return ret;
	}
	...
}

Because samsung_i2s_driver does not set support_driver_override,
platform_match() fails, device_attach() returns 0 while priv->pdev_sec is
still NULL (leaking pdev_sec), and samsung_i2s_probe() then dereferences
priv->pdev_sec.  Other internal users such as imx_clk_scu_alloc_dev() and
rpmsg_ns_register_device() also fail to bind their drivers at boot, and all
VFIO, UIO, and stub driver_override workflows are broken at this commit.

In addition, PCI and CDX drivers that use PCI_DRIVER_OVERRIDE_DEVICE_VFIO()
or CDX_DEVICE_DRIVER_OVERRIDE() rely on device_match_driver_override()
returning > 0 so do_pci_match_id() and cdx_bus_match() match override_only
ID table entries, whereas setting support_driver_override on those drivers
would also allow pci_match_device() to bind arbitrary non-matching devices
via pci_device_id_any without tainting.

> +			if (allow_driver_override) {
> +				add_taint_module(drv->owner,
> +						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> +			} else {
> +				/*
> +				 * If you hit this warning and you need to
> +				 * quickly workaround this check, boot with
> +				 * allow_driver_override=3D1 on the kernel
> +				 * commandline. The right fix is to set the
> +				 * driver's .support_driver_override property.
> +				 */
> +				dev_warn(dev, "Suppressed driver override binding to %s.\n", drv->na=
me);
> +				return -1;

[Severity: High]
Should device_match_driver_override() return 0 rather than -1 when
suppressing a match?

Per the function comment, < 0 means no driver_override is set at all, while
0 means an override is set but does not match drv.  Returning -1 for the
matching driver while returning 0 for all other drivers causes callers to
fall through to normal bus matching for the overridden driver:

drivers/vdpa/vdpa.c:vdpa_dev_match() {
	int ret;

	/* Check override first, and if set, only use the named driver */
	ret =3D device_match_driver_override(dev, drv);
	if (ret >=3D 0)
		return ret;

	/* Currently devices must be supported by all vDPA bus drivers */
	return 1;
}

On vDPA (and similarly in css_bus_match(), ap_device_probe(), and wildcard
PCI drivers), returning -1 logs that the override was suppressed, skips
TAINT_DRIVER_OVERRIDE, and still binds the device to the overridden driver.
And because device_match_driver_override() runs before normal bus matching,
setting driver_override to a driver that also matches the device natively
(such as in of_qcom_slim_ngd_register() or when rebinding a device to its
native driver) either logs a false suppression warning before binding anyway
or taints the kernel with TAINT_DRIVER_OVERRIDE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116110853.3418=
077-2-u.kleine-koenig@baylibre.com?part=3D1
