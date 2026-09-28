Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E34EFFDF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614672; cv=none; b=Gar1IbXqxFVJ3yca3gKMsCMSm1uzA+eRAxoZoHuOY6iJ8yNna+akN5b4buuGsH4KiLSX4+e/I7FMOMVzzPsXQkmvKWZ/j8XoGnzeswNXFZOW3fV+VwamfilImwO2pzgtF1RpPX6D4thtqf+N2nWwC5tCJ0v7axvbObW9xzqBNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614672; c=relaxed/simple;
	bh=s7puc+T+8yz87YwY2ykl3VIM9xgFMkd5LFtxTMhamMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nyz4PD6jhMpW+2pdRK222MVbxN5ik3dvPILu93XOwTGID0LQdFxPtCON45EpCNzp598PfuoNOSkAcXlp/XmV1NK3xliuXidclcPZaOpckVVocsyuLCbxYDBoTC8lc2Eo+J3+xlsEW7nWy+SybPF6w9sN6a3RxinLc38RaTWL6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEPajW4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEPajW4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2006D1F00893;
	Mon, 28 Sep 2026 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614671;
	bh=9Tvw1eXP12PP6u31heQZqO8j3lEK5e4DcHsx649Pmpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEPajW4KaGOot3zydacIC+XLqINRsv4VWV3EormgEeG6OdaSljwES9ch7eCaRrUbZ
	 pPEQnkpdYUQzRQ9WbbR18PKRcZzxMpra1/LTpf/NBhEiCD8Lana/+DiksqWXXshsAZ
	 kw9TgJV30BFQ57iRrYuyvyZewL7eqPME7kZX+GOVa/1PmhBBF7RwEnwxdH2O5hcTHt
	 GYkEfyph8NGYkar5ztcOj1DgpqE5hpoNcb8U73qrfsfTXfiBE6KerQlEXVYYjDBKBL
	 Ng8iHSHx6ana/Gauq7CCIyjGEB8iM6S7rlEyz4Jcbk3JLfUY7AkDuyBCPJ9WC286aG
	 cA3fMQh5SThgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] driver core: Disable driver overriding by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:57:50 +0000
Message-Id: <20260928165751.2006D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] driver core: ABI breakage by disabling driver_override by defa=
ult
- [High] driver core: KASLR bypass via %ps on data pointer
- [Medium] driver core: allow_driver_override_setup ignores parameter value
--

commit a37d7b534fa418f6be2fd16c1a3c890b91a11aec
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

driver core: Disable driver overriding by default

This patch disallows matching via driver_override unless the driver explici=
tly
allows it or the safe guard is disabled using the allow_driver_override
kernel parameter. It also un-inlines device_match_driver_override() and mov=
es
it to an exported function.

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index c51ad96d4de4b..d294c198ab0c3 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -606,6 +606,49 @@ int bus_add_device(struct device *dev)
>  	return error;
>  }
> =20
> +static int __read_mostly allow_driver_override;
> +
> +static int __init allow_driver_override_setup(char *str)
> +{
> +	allow_driver_override =3D 1;

[Severity: Medium]
Does this setup function ignore the user-provided string value? If an
administrator passes allow_driver_override=3D0 or allow_driver_override=3Do=
ff
on the kernel command line, it appears this will still unconditionally set
allow_driver_override =3D 1. Should standard boolean parsing such as
kstrtobool(str, &allow_driver_override) be used here instead to honor the
user intent?

> +
> +	return 1;
> +}

[ ... ]

> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv)
> +{
> +	guard(spinlock)(&dev->driver_override.lock);
> +	if (dev->driver_override.name) {
> +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> +
> +		if (ret > 0) {
> +			if (!allow_driver_override && !drv->support_driver_override) {

[Severity: Critical]
Could this unconditionally suppress the override match for drivers that
haven't been updated, and break existing userspace ABIs? Userspace
frameworks like libvirt, QEMU, or DPDK that rely on this feature for PCI
passthrough via vfio-pci or uio_pci_generic might silently fail to bind
devices if they lack the kernel command-line parameter.

> +				pr_info("Suppress driver override binding. Allow %ps to do overridin=
g or boot with allow_driver_override on cmdline\n",
> +					drv);

[Severity: High]
Does applying the %ps specifier to a data pointer (drv) instead of a string
(drv->name) leak a raw kernel address? If the kernel is built without
CONFIG_KALLSYMS_ALL, kallsyms will fail to resolve the data symbol, and the
print routine falls back to printing the unhashed hexadecimal pointer,
which could bypass KASLR when exposed in dmesg.

> +				return -1;
> +			}
> +
> +			add_taint_module(drv->owner,
> +					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> +		}
> +
> +		return ret;
> +	}
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790612298.gi=
t.u.kleine-koenig@baylibre.com?part=3D3
