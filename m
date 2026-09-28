Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C13A6F09
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624623; cv=none; b=qXPY5KU21XWyPM3Q1+JZQqtGbRZOAd2lWOslVxjNP1bk7KEG3TiT54DQgmy3PBrc23WoV15ot+FXRT6m28g8EStxMMpBTjXa/1UIf+lhaOFd9IUjblOjie6tZP1f4MZgwmBp0y+KhCjxE9e8XvvsHtvssTS0aM1S6gKkBfKm0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624623; c=relaxed/simple;
	bh=hHbJUj9MjIHZzV/WT6UjK867+TXBSMDLnyF5p+XNjqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIaG4sSIkd3mBa/h5+Fm3kg+KSfINVwycUEKsGEsCgS/bReaXqVk3dass3T1dYJIJ5NtOzOlk74LRnMwfB8hASmdMjqHTJcdFuWtFD5EeiO8tgP9lDLiFVmjJfURfqUnrNSFGouVIcKCw/NmbqrMdTj6/RZk6n4Uj4b43qtl2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SEoArUte; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SEoArUte"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b0219bso1562663f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790624618; x=1791229418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxZSOX2/DMzIaUKEB17ch3Vac56Jr8Y6RNEiYe6dpbE=;
        b=SEoArUtePCOixmxmNwaYzf5smPiPMTU6mM4XiPO0DEeSbVYszH7rZ1TZCaegqeXjNV
         9AM8uVq5uJ7HjK8givCU+Xrs+DcozXlzIP0cjCnIFro11XoBAajlen/sLLfVgLaaEWFb
         wImm+TSRr6tzdJlJEtgymzGV/6Atjv29WMntLr15Q+3UoSOAlRCB8BXbwlF5xVwD6ouG
         SrGLACUac5QAjdyiEDT9f3ok0lqYMvlamoVu+HTcbOkCHPCO20EFjilaOiCV8Ta1aLWr
         Ml+DmBM1ncZJovnzZZ/mKKepmOUsdY3QrW3yIRL1zXa6/unYnMLApLC/57a+7OzDSSnj
         YaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624618; x=1791229418;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxZSOX2/DMzIaUKEB17ch3Vac56Jr8Y6RNEiYe6dpbE=;
        b=ddsT8gBCQx7kuGRAwYTdsE89tJnaFRPIJuEFOvkWh8cgCNXeC1pIgSlqyALwLMD0mH
         aQUjPqmb67cSrLlSqrQ79UQaaB7P0uQjeoflHdYiFmVjAfutn5vUfX5UwGhsLgPQuZio
         4a22mfjDkKBzAarMxuRZYpb2QYEQAKf3DJhRWpOb0DBtKj12v8A6hJYbZZgAo+G9iEVb
         7yUvr/7yU0K9zzV3nP3waH2eriU3G5rQSNJGVDFy2U6rrwthY3kDDnS3Vx27pQhZn1A0
         rU9Sq4ssYr+NtAveaC/d4O6NRRNJaukUuJ6t+f9CbNMjbsPXpuIHd46V0B8sfL6BtoYb
         0fHw==
X-Gm-Message-State: AFuF++nggo//xJeqT54cnFddrwWxjD9wsTqYO3tB86xIoEYieOPfpm5e
	XmTc0aHLZzgaO/K6u7EsiecpvcrXSOXR43GD0aFdt7rfoaspDfA129NAxrL2ExrsWKRDSffcmvC
	csLSh
X-Gm-Gg: AYBFou2Y/toQAplQ8Oj22Ox/+9yLuzVGmuv3FA/b86tkdtWg4i4nH0HpWcsDvgYdCEc
	yIarjJ+uPZlOPy1XIdCKG3ovp0SeAhGDhV7IEg5Syw4aaMb2QGoGIFoz4QcJsXT6D1VYsY4OlYM
	UMn1aP7PrSwW44yt+b7Fzwp4LxAqM49lrke1+yWHUItyGg+8fILkpsMOUtsoOZn/eh2GsrLoBJe
	brij32ObD4kSlLY8ln+KiNzI4TuHIg3UPSGbo5/5DdZqeTKYdpwnS/KB4G1WFofUqXh6bwvCWny
	ICXbvYW9n8MfjBpDQeBRD12R1UR6I1qGpyjsBPhi1A7/v+L3qSnICdcNP9j1wR+HEX7tXrk4tDs
	04XOz/gJt9FYDobwAzxGnaSn+OTjPJ/gvGO9PkabZpJt4BJUg/0ed6n3ahvLU80HjD5Ovy8cziI
	JwQA7zyAAaHVnpRCxj5Ss0Drx+bettD4H+oQ3Ob22OZPQ2tJLRw6/QzSxaeg910I9Q354LX2Q9V
	L2p
X-Received: by 2002:a05:600c:4e49:b0:49f:cc2a:f73a with SMTP id 5b1f17b1804b1-49ff06ed754mr173176835e9.25.1790624617351;
        Mon, 28 Sep 2026 12:43:37 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00cfecb39sm16755135e9.7.2026.09.28.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:43:36 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:43:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Message-ID: <arrCUYnwhK68Q46T@monoceros>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
 <20260928165818.69F321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e2btm2zbxiwiyxbf"
Content-Disposition: inline
In-Reply-To: <20260928165818.69F321F000FF@smtp.kernel.org>


--e2btm2zbxiwiyxbf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 04:58:18PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] device: false kernel taint from internal driver_override usage
> --
>=20
> commit 224a6c2cd832599abb4180f63153f96e5c11d2a8
> Author: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Add TAINT_DRIVER_OVERRIDE for usage of driver_override
>=20
> This commit introduces a new kernel taint, TAINT_DRIVER_OVERRIDE, which is
> applied when a driver is matched to a device via the driver_override
> mechanism. It aims to distinguish overrides from manual sysfs bindings, as
> overrides can lead to driver crashes if the driver expects specific match=
 data.
>=20
> Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kern=
el.org/
>=20
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 879eb758b5eec..4dac5e09b74c1 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -905,8 +905,15 @@ static inline int device_match_driver_override(str=
uct device *dev,
> >  					       const struct device_driver *drv)
> >  {
> >  	guard(spinlock)(&dev->driver_override.lock);
> > -	if (dev->driver_override.name)
> > -		return !strcmp(dev->driver_override.name, drv->name);
> > +	if (dev->driver_override.name) {
> > +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> > +
> > +		if (ret > 0)
> > +			add_taint_module(drv->owner,
> > +					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>=20
> [Severity: Medium]
> Will this unconditionally taint the kernel even for valid internal usages=
 of
> driver_override?

Well, if you assume there are valid internal usages of driver_override,
yes. I think it is possible to not need these all.
=20
> Many kernel subsystems and drivers use device_set_driver_override()
> programmatically to force driver matching for dynamically instantiated de=
vices
> during normal operation or probing.
>=20
> For example, in drivers/clk/imx/clk-scu.c:imx_clk_scu_alloc_dev() sets the
> override internally:
>=20
> 	ret =3D device_set_driver_override(&pdev->dev, "imx-scu-clk");

Here I think you need to change `platform_device_alloc(name,
PLATFORM_DEVID_NONE)` to `platform_device_alloc("imx-scu-clk",
PLATFORM_DEVID_NONE)` plus maybe create uniq device ids (using a static
int that is increased for each call).

> Since device_match_driver_override() cannot distinguish between a userspa=
ce
> sysfs override and a legitimate internal programmatic override, won't this
> cause production systems using these platforms to falsely report as taint=
ed on
> boot?
>=20
> Falsely tainting the kernel breaks the reliability of the taint mechanism=
 and
> could lead to valid bug reports being ignored by maintainers.

Best regards
Uwe

--e2btm2zbxiwiyxbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq6w2QACgkQj4D7WH0S
/k713QgAuYGFOD8zr18eUyBJO0UxhmdDG/wvrKbHotQLYnJ05hM07+9ENNV9iLQw
o8IjBj0j0INhu9NrJsK1YxH8yyIbSt3Gi8eZjJVfO+blKFQKucdwAG3/532WaN2P
4VJuA3GVG6z656qY4omCJgleHpjkOF1xx17TkdzjnXj3p8ne1h4vt6JTyy9xNW24
frVtuk/Llje62jDIq6ZtnEoeyddBiqcx94t5OITmnr+LXXKhmmFKwypHO08sNjck
/y51XSz0Hv5lBE+mgLF8JoMAwB+D1Xg/liZs3XTZ14H6ruLjuNMK7m0LtXgTpOru
42UhIyXsoV3uE4dIkAvsa3WZCf1Y3A==
=rjkE
-----END PGP SIGNATURE-----

--e2btm2zbxiwiyxbf--
