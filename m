Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41683D9DB4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660880; cv=none; b=BMhv4X3wQWoF+hjOLa1wwD4yDT0So9q+eu0rVl8Gwm6ij2yID7Ff8n0WcDSjSFh7NdwWxl8zkbJsYr6/gqqGtfDyXjKBXxUGxUVKZ6FEWcr1aXERP7QnbqaPJ6sD7wlGq7FRJvoW99Z2qQbl886W8nhxOvs8z0YU+QPKcOPFoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660880; c=relaxed/simple;
	bh=CDuQm5RAa6fP2MiRVZ5uOBH+aWa5eA70HoXFhMlM++0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUJkytVD9PrN6hjkUxeFx4Czqb94h0Lmb5+WFdAYhZIbthaArOWNruaJ5426kH/4c/GLoEDFAGDk6TNb/OmUNujGRzbeiqogY87fOcZE8BCw/iscaSBjnTuQjc5Nzc8cUUSGoif7YWFYrSUTCsybHga7n4LfSYH07ye+GLhp/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XZrcfOYd; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XZrcfOYd"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so2641036f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 22:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790660876; x=1791265676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JeHGaTR7TjIlYYRqp+6saqTg4D2/subzB+Hz3wyrU48=;
        b=XZrcfOYdRhbnMLJUcCaxEvlSWRp3JLGsdf0JURztGy48sU4Q/szhhNG+MdfGNq8Vd2
         wlkFBE2lU28L+cUzGdBI5/zAxwY71M39XYhiVq46nP19o4r8xjJ0VzfT/CEEycstFvep
         bs1wdffWPpnkBrwtLqbUD1+Ss6Ahxm9m6/e0aIAmZ8eigj6cMmIMF6PYftWeKXcHeC+w
         XmKJbAstR7i3FKyt9oVZbvitnKglyQCdDge1Q9iLpTNOW49Y92QFtu8dbknGuIfZrLSI
         +0Rbx16VpjrqyEQ6+CDjPHsRPHqODsgHptzdZbWW4idq8hMjqeXcvffdRqCE105OFnnt
         4twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660876; x=1791265676;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JeHGaTR7TjIlYYRqp+6saqTg4D2/subzB+Hz3wyrU48=;
        b=Ie9Zit9LDlJ5vg+gwi3vphDiYyjc8Lj7fdRAewabKIiIXnZeuxMiS2mQFzDLg4E6jo
         ZkhgTuJyUnA3qmSF8Ze/KdVnHJRh9byWYVIA56n64QNWd/sfNjLCQXZBCICuBUCoAN32
         k8TAmBhGxCcQZ17+LX4uKzYiv29zT3OZJ9LS8UVhp5qqMILWlyoBB+FlsseVR3Z4TYQT
         vvg3UghkA+Fc/K3cg3retFRbgxA/LYAORfKgPc167MKoqYsgX5K0ov7p/UdFgNFfkcaw
         8kZI5qH8iWhUlApjZFUsWp910vJ4iLwLADoOQUvEngi8Skz/0ftVJuiu+V/4J7HE/Qsi
         L3xw==
X-Forwarded-Encrypted: i=1; AKwUvBzeZj3YbExovWkhZmvbG/t/iFLDcPTg3p8hF86kylwrStAtbsiCFVSYskAb8C2mlk5lUPPrSAp2x2USj3GzPPUDWL0=@vger.kernel.org
X-Gm-Message-State: AFuF++kEnKAcd9gxbpiyN82A10btbjE1ibHznJxaX7hCVXZ4EEiAipAo
	lb9IgDblqpV9/MJx2Ln4zTzfr5ZGcc0KZQQUDiLgWZMZhzSQwcCiGLoXUeOc9zMyzvo=
X-Gm-Gg: AYBFou09xJo4GprbOHrcQgsd0kaDQ0wsPRbwAjmVw+/0lCOeOV3sA5YscoXXFRuj9cm
	TP+2Hk+ppa1HrygrcOGdOtbHe+ByhSCQQLU2ed8do3Jrd9iYzJvVKiHgf9nnZv7FO4Sd6Z97alu
	hIlvEwS4SOoTwutWkhwznKV9lej7KYPsOYUiApwDLx4O/oAU6BTIudGJZrxqau+ArgDHls6r7OT
	3R4oX7Ukp6VymbUr6BkJ1aXFBlJarR4PgrnjDH4zLYbdbmMha41VGXgAs0rCyr+UJHfqIrc2PNo
	nClFLF3taIlPagtzGraOUofX8XLZstLAWpWD6KzcjLedl8aooBLu2cQZZqFWtg324UztO68ZGLc
	7wbpEql4eJbIv6WAyVDHU2hAqFooNvXOH/h2KUm6iDIGY8ud7snlUVkHv6A2pWsErqOh5yBku6D
	TCu4THMcxLhr6pk4DphAroS2flBfew5z7NeQQuzG6GU8nS78aaB7kg+afy2Ye+MnI6ES5K7N6r4
	jWf
X-Received: by 2002:a05:600c:8719:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-49fe66c8a5amr268539955e9.7.1790660875688;
        Mon, 28 Sep 2026 22:47:55 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00cfafa23sm47009155e9.14.2026.09.28.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:47:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:47:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Bradley Morgan <brads@mainlining.org>, Thierry Reding <thierry.reding@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Message-ID: <artQhFRifzEj-DJd@monoceros>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <20260928215127.1811259-1-dakr@kernel.org>
 <DLRA7CWTA1K4.K2BCBX8MBNHQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7i4xitnibbpezyka"
Content-Disposition: inline
In-Reply-To: <DLRA7CWTA1K4.K2BCBX8MBNHQ@kernel.org>


--7i4xitnibbpezyka
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
MIME-Version: 1.0

Hello Danilo,

On Mon, Sep 28, 2026 at 11:53:03PM +0200, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 11:51 PM CEST, Danilo Krummrich wrote:
> > On Mon, 28 Sep 2026 18:46:01 +0200, Uwe Kleine-K=F6nig wrote:
> >> [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
> >
> > Applied, thanks!
> >
> >   Branch: driver-core-testing
> >   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/dri=
ver-core.git
> >
> > [1/3] docs: admin-guide: Handle TAINT_FORCED_BIND when parsing /proc/sy=
s/kernel/tainted
> >       commit: f1850e443b0e
> >
> >       [ Fix a typo in the commit message. - Danilo ]

Oh thanks.

> > The patch will appear in the next linux-next integration (typically wit=
hin 24
> > hours on weekdays).
> >
> > The patch is in the driver-core-testing branch and will be promoted to
> > driver-core-next after validation.
>=20
> I've picked this up, as this fix is independent from the rest of the seri=
es.

That's great, I will make sure to base the next respin on top of that.

Best regards
Uwe

--7i4xitnibbpezyka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq7UQYACgkQj4D7WH0S
/k663QgArBi4fVbOIlKZk9jI0WbkAw8kxGQecc/jC1cqoY0MaDRRd1R3MJBHFZGS
MtcolDGw4kwFN2gJDPkqm6wzBYH6gUNJD9K2vN4/pq7O/w8fwGdkql0URAkFP6d8
+bAvFqIlphHEVEkTazLtRTqrb/Lc7j08r8AqAlYfaZj04Z0152PfoIUGvjiWe7vw
AFHstULjtwUOQe6VvJTIjwwec0KJrPkcFMGZRroIi/iC6AYeyH/QIUUyBAK9S2Om
Vfw95aqzvs1k6lsqx866tRlhXwoDW8YvQWWxKyKHM/yktT/Mjqysn0rEtiFJP+Px
w/WI1772ODDDblPFv3khxpm6c03A8A==
=WTJ9
-----END PGP SIGNATURE-----

--7i4xitnibbpezyka--
