Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEE3AE198;
	Fri,  4 Sep 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499330; cv=none; b=P2RAETzOwbzjueqTsOaKZvXF8n1pn195G4XNpm3n0gT41NNbUnMCu2Ids7MIrD8tHl+HGK1sI/au7/hJv3kF3FkT4yBMVoc4gV3g9w1EVCKwK0MWdN0VHulufo6i5asq2uOmM3Nu2ZTCZzcimJYVuc+p7VSFa+WsrThm1/Ymmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499330; c=relaxed/simple;
	bh=rTrt+q6TS6h+DCj42AoStwYcKK631TAq2PvTHqFqwXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCG5EBI22XKQcftbRMt9ib7KNoh8E7dhqiLtOGFa/p2XuAMwNB1HaPMdzMQPcuWHUxKPb6wmYBHBQcHRCDsf0mMfU9PGv3geAjwkzPHksiWoXp6zkd61yfwrELnoOwKGLWfzwDQAmk3/fCTu8rYzi5ToWb++EAdr7fQ4NX/jHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrFtsWTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrFtsWTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4211F00A3E;
	Fri,  4 Sep 2026 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499329;
	bh=gok6+JC7+Em+ZzbkORBDiuruKhcq/J5gIrEeQeceWAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrFtsWTMTctk/v+bqdTg8WA9CLmqkVgigya1TYq2LLdcdxYNOWwZ7nz610ifvqIZt
	 FwtUOqpdgzbEID4y8HAVWiVtran5fF4bBaB7mkVGaJCxbCnMhaYgVtH/u7e3SIN9df
	 qagXwtkEMO1cJ4xG+61QxEdQfvf1WZ9sduxVRSQ3G++CLDAQtuG6cTo5pxs+7HSp9y
	 7C6yNDXfewOw08CgxemGvwSk3/CH3mrfw9mJw9HcQKRitr9ogs/sTE8oAUZrMRuDhA
	 s3smOiKnzJtJK21j+CKTY3Hm5qj30YaxnLQ39mdRsQ3vPUv2VjZPxP1APfuRCWiGyB
	 0oUQUmbjZCOkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-bind_taint-v3-2-30025465f38a@linuxfoundation.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-2-30025465f38a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:22:08 +0000
Message-Id: <20260904052208.DF4211F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tainting the kernel unconditionally on any sysfs bind/unbind opera=
tion marks legitimate, standard virtualization and networking setups as tai=
nted.
--

commit 5047195fb07d09f62b1e24672350bc622948fa9e
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

driver core: add TAINT_FORCED_BIND for when userspace manually messes with =
devices and drivers

This commit adds a new TAINT_FORCED_BIND flag to track when userspace binds
or unbinds devices via sysfs, aiming to flag potentially unstable fuzzing or
unsupported states. It sets this taint flag unconditionally in the sysfs bi=
nd
and unbind store callbacks.

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

[Severity: High]
Will this unconditionally taint the kernel during officially supported unbi=
nd
operations? The sysfs unbind file is the documented UAPI for legitimate
subsystems and setups like VFIO PCI passthrough, DPDK, and USB over IP.=20

Applying this taint for standard operations might cause normal enterprise
environments to be permanently marked as tainted, causing valid bug reports
to be ignored, and could trigger panics on systems running with panic_on_ta=
int
enabled.

>  		device_driver_detach(dev);
>  		err =3D count;
>  	}
[ ... ]
> @@ -264,6 +266,7 @@ static ssize_t bind_store(struct device_driver *drv, =
const char *buf,
> =20
>  	dev =3D bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && driver_match_device(drv, dev)) {
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);

[Severity: High]
Similarly, will this mark the kernel as tainted when standard virtualization
daemons or userspace networking tools write to the bind file? Is there a way
to distinguish between abusive fuzzing attempts and normal administrative
actions so we do not invalidate valid bug reports from these common setups?

>  		err =3D device_driver_attach(drv, dev);
>  		if (!err) {
>  			/* success */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-bind_taint=
-v3-0-30025465f38a@linuxfoundation.org?part=3D2
