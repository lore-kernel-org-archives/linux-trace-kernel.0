Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C423395F;
	Mon, 31 Aug 2026 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174473; cv=none; b=mRQpAoCGkiX7gOlBv26W620hnivwgpn71vo8MNvBhWk7sZ3lOFTIId5cDQOMFi0/+XZ8r8pytmBQgwFyAPaXupi3YWecfa0HUAAaeA+QMFfpBP1euWzvljrDljWtlKanclo4VRMIneH7hIlYJQyMidzBmRWoPDHNjCoIq7hadCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174473; c=relaxed/simple;
	bh=7GxSLxwbz/XV8dSwH/1lnNX51yVOQSHNNolBFSMW8sQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXwEY18ktYryQuK2QoRMg171h3BzW+La2qiYjFa7Y6hkKBAJX/R6vL/MLlC/BQbD/7G0p3V2EJIgetY6dCLD3S+u/tOka3cTNY76aLgNUQaIvPMloppYuVSy9zw0sDsaRjYyLUP5j6G8P3kJkgH65HVlxddwhEVgiElQg8wcDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcEwHVpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcEwHVpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43E71F000E9;
	Mon, 31 Aug 2026 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788174472;
	bh=UfOPHDjDAx52YG1Rfiiu5HUQxXWX+kq/IS9ClAcqFv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BcEwHVpeVjHyIfVRwXgdc6C/1X0aevLmnROp1GI1HG9RSTiiKFdtar6HsSDC8Qezq
	 6RFJ1eQwuuEkodc6ZzAETsqthObL3/wFrRXFVGqgFxrwbd1pzilJlvjvGfADhcfX7Z
	 40OXGfgXTMlNlYIWbKUPPCJcQTdEzKccf3eTOtfoaBtPUMZ+QFYuIvKjjvDl41EOeI
	 UL18R4aW7d6PkRe8Jn5vbrmveBeHoj9ixlijACSgkMN9ntfZB/mBZkNrE1SvI09sKb
	 EbHWAHQf3G7lb814oW38jfTBxsXWKjIkyJA15IEo7/H0yu1109/32dPFtu40QzUtgt
	 YyYfq0fGG3Q2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831-bind_taint-v2-2-1082d631213b@linuxfoundation.org>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
 <20260831-bind_taint-v2-2-1082d631213b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:07:51 +0000
Message-Id: <20260831110751.D43E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Syntax error in the !CONFIG_MODULES fallback stub of add_taint_modu=
le() causes a hard build failure.
--

commit 14dacce69702c442db10ec87f486fae504b3514f
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

driver core: add TAINT_FORCED_BIND for when userspace manually messes with =
devices and drivers

This commit adds a new taint flag, TAINT_FORCED_BIND, which is set whenever
userspace binds or unbinds a driver via sysfs. This helps developers identi=
fy
when fuzzing tools or userspace have forcefully reassigned devices.

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
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);

[Severity: Low]
Does this call break the build when CONFIG_MODULES is disabled?

Looking at the fallback stub in include/linux/module.h for !CONFIG_MODULES,
there is a syntax error in the parameter list (an extra comma instead of a
space):

static inline void add_taint_module(struct module *mod, unsigned flag,
				    enum lockdep_ok, lockdep_ok)
{
	add_taint(flag, lockdep_ok);
}

Using add_taint_module() here exposes this syntax error, which causes a hard
build failure when compiling without module support.

>  		device_driver_detach(dev);
>  		err =3D count;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-bind_taint=
-v2-0-1082d631213b@linuxfoundation.org?part=3D2
