Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C0377AB3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624873; cv=none; b=lqM+Pr5X8R/mYlvLUTLBy7MDgBP1dZ4HvL3DbuHpR7GaS3aPlsaJrqhoIft1FOWyejWyD2RNEchz1SenuB3slhAGuMz9Lwl0dPX5jNi/a0+XiAI1Yifup5j+sjVuZ0VSfCSeMYWT3+0CuRRjljc/1ZjACSerjwV4VTRIfFrETzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624873; c=relaxed/simple;
	bh=oa0ATEHdDrPBHnBwtYdTsdCDqSjSClVf4hvLC15s1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Opwq4nNIjHlHX2Mra6HUnQiOt334PYJ3iJe3AYVZkefZI+sWyceY2ajR0PtYINWR8YMrFQrKwQZs6hyU1FJ0gUzllhMBpmsx35MkaUZbyxD+1wubRxOJ8t2Wfhpcb3X8WsUqHdvsJfLaMnQJU3BrI6r2IAKE86dFmrKMq6qWOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hlMSslDS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hlMSslDS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso18209605e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790624869; x=1791229669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDjGN6T4DEeN+hVmhBYLcGwoTGCn8dVW/lQSls4C50E=;
        b=hlMSslDSEDHC4F5IWoX2kfBcMgQ0rUvvuxVvyjJ6qhSOf0ar5gCkhEMBmzVUDWERFz
         rynjVqfWdo5njGlhZDSUmxtBcoxM7y+/Y88BunhYVpmFsSHPddS9Fp+aKzgQJW9VAbaT
         SX9Cg+ixb+WKbGGS4vk4TEU06qkY8RsOI2SVVEdOZ67FeMRmpQaA8llS3Tnyx9YtzyDd
         kksh2iW0Z9erMiQM1w5J4FCPhZxhjYbE4JU9/WE4Wbtz0knlPYxAddTF8qCyKUuEVyYn
         QckQWEAAPIvEOMZ0P8zfMhETpJIWyeE0qL8DucuOesDq9zpA7HG44BYbhp8OgXC5jeSY
         re+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624869; x=1791229669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDjGN6T4DEeN+hVmhBYLcGwoTGCn8dVW/lQSls4C50E=;
        b=sBhAmfvVUm1maF/iSh8heJ3dRAzvSusmReVhfjjFe2JINf2FbU59d1LHVdGRUgSY9T
         lbug+pkNVHQ61HiiVzuE2hdQFnK9uoTU/zBhFbYImaJHmw+oXB8Vd3fvyuU9onoooVWe
         XF1v/m4PuibmSTdsWDja575ozQ/eNbL3haeKfT2fwTHUA+YyL3b1NQRVx5RAJGtw5HGW
         NO+RjJRQbcltXnjRTsOKlIXmK3mlEDYJdK3Z8Bfly9nhXGGndstqJEvTEQ5N2yfbhhWP
         /jbH3u2lj0pMkJoa0rrxP7e+oFntq4vHcSeQ39qkjI+6xsAftdsYDrzWyOmqxzuGewWv
         t99w==
X-Gm-Message-State: AFuF++kvCYIVCAHofxla+9G1UP3rnw6qE3ML3VryuCJLplNJOz6EeIPH
	FX2zcpOR69LZuFNbq48iobPmxamCTZsztUnySHrmU4o1dHNYkvJpApl7D8H+sjhHtEc=
X-Gm-Gg: AYBFou35Sov9lCWC36sijANs5VFVOGJlwaPPD4QxoLacOHKx0tRg7ouZeedVtLwFDSi
	AFiLkhV+W+PAz+yAO168WC2R4Y+ea/DkUakuYfj1Ta8viLwDIyQr/5TtE0Z2qsjKFEC63OVhtur
	kPwswixG9Fo3Bf8y8PoGXdZ+1iJ8GfKa0stT0Tca3n4UZxjekalObnGh8XcF7kystpe1pdtf0Iw
	XqvUPNkcPCJlgYdkpWTS+uA2sP4y2nq5jdO+AXANwUPfE9Ypo6jaZpiUPzSSuauKY2l1376kDUu
	dUN+E8you+kHpr6FbTC9CdEGTkl9K8EWbDalTccdRoFdeEd9AYqctj4ac7vJS8wVkhnQt9gp39s
	9TFiprPUgfeRRXqx5K5rfZ+puNVveYYzrToID/DyQv+uFShvKhJ2ZDiwVXSMMiJx8RN1R8BXEPj
	zgmF7ZS3NqQzox0cZ65bsHcUJ7xhDp28ku08+6fju3J03bQ97h2/pb4O4VxKqupAHH4w/ZBMhxc
	1XeYdaHXhaM3KI=
X-Received: by 2002:a05:600c:8707:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a0008968a1mr95353755e9.16.1790624869320;
        Mon, 28 Sep 2026 12:47:49 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00c0d538fsm26948145e9.1.2026.09.28.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:47:48 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:47:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] driver core: Disable driver overriding by default
Message-ID: <arrDbfOnXHxgVjdi@monoceros>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
 <20260928165751.2006D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4esvmsh5o4odqif"
Content-Disposition: inline
In-Reply-To: <20260928165751.2006D1F00893@smtp.kernel.org>


--s4esvmsh5o4odqif
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] driver core: Disable driver overriding by default
MIME-Version: 1.0

Hello,

On Mon, Sep 28, 2026 at 04:57:50PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index c51ad96d4de4b..d294c198ab0c3 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -606,6 +606,49 @@ int bus_add_device(struct device *dev)
> >  	return error;
> >  }
> > =20
> > +static int __read_mostly allow_driver_override;
> > +
> > +static int __init allow_driver_override_setup(char *str)
> > +{
> > +	allow_driver_override =3D 1;
>=20
> [Severity: Medium]
> Does this setup function ignore the user-provided string value? If an
> administrator passes allow_driver_override=3D0 or allow_driver_override=
=3Doff
> on the kernel command line, it appears this will still unconditionally set
> allow_driver_override =3D 1. Should standard boolean parsing such as
> kstrtobool(str, &allow_driver_override) be used here instead to honor the
> user intent?

I copied from sysrq_always_enabled_setup(), I guess both could indeed
benefit from kstrtobool().

> > +	return 1;
> > +}
>=20
> [ ... ]
>=20
> > +int device_match_driver_override(struct device *dev,
> > +				 const struct device_driver *drv)
> > +{
> > +	guard(spinlock)(&dev->driver_override.lock);
> > +	if (dev->driver_override.name) {
> > +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> > +
> > +		if (ret > 0) {
> > +			if (!allow_driver_override && !drv->support_driver_override) {
>=20
> [Severity: Critical]
> Could this unconditionally suppress the override match for drivers that
> haven't been updated, and break existing userspace ABIs? Userspace
> frameworks like libvirt, QEMU, or DPDK that rely on this feature for PCI
> passthrough via vfio-pci or uio_pci_generic might silently fail to bind
> devices if they lack the kernel command-line parameter.

The idea is to mark the relevant drivers with .support_driver_override =3D
1 before this patch is applied to minimize the fallout. I added the two
drivers pointed out to my list to check.
=20
> > +				pr_info("Suppress driver override binding. Allow %ps to do overrid=
ing or boot with allow_driver_override on cmdline\n",
> > +					drv);
>=20
> [Severity: High]
> Does applying the %ps specifier to a data pointer (drv) instead of a stri=
ng
> (drv->name) leak a raw kernel address? If the kernel is built without
> CONFIG_KALLSYMS_ALL, kallsyms will fail to resolve the data symbol, and t=
he
> print routine falls back to printing the unhashed hexadecimal pointer,
> which could bypass KASLR when exposed in dmesg.

I wasn't aware of that leak. Is that a real thing?
=20
Best regards
Uwe

--s4esvmsh5o4odqif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq6xGAACgkQj4D7WH0S
/k6aIAf/cgx3W92bl5m4i7KV0NkpwBwolFmeAummQEMnPiWtQ6w6nZVSWCzDo4QS
eLn3uGa8HOlp8Uyghbm9EmeWOugzoXCKiAaprH823YXjdOIj70W4Bc0FFToNsPX8
32SLNzUgu0K0PB3AkYg2OuecA4wP5KI4Brqo6KvHukBlTGGoL9uMyv4g1xu+g2nP
Lt6mnYFXnDxfh/2a+UDVFKIq3+2ynrX+uDtnfCiFlG6TA6/4PaZyw+uBX9MgwiYN
56VyUolywxnfemV6msMuPc3hISBoQXnXyuognRuPki1T0FhSS6l1L/EG4LbE2adW
A+bzGA+GwHJ/l4dTr76iGg2x5oMM4Q==
=UiR7
-----END PGP SIGNATURE-----

--s4esvmsh5o4odqif--
