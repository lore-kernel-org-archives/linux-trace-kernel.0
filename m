Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312D3E832B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661211; cv=none; b=ogrwh/VUnRMos/ys4HEA38yX2/A7rGFQKSwUwJmOJ2SCmXDz8NQCQwxQiNYajBBY+MKoL0t4ScCGMgRx85aFyNv6V9oQsvBoLvJMtmnZYghz2LOWe3P6sEV2mHKaK+NpkjblnOUQiMFGpVwqYGUdvGrycPxxb6yuLVTfJvMObp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661211; c=relaxed/simple;
	bh=ngp0Z71bP8R1r8qPJz7GJYV+9s7Y/H9eYdP6lvbeJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJgRUxfIL8n7z0zJHArGiViKrqYm04bDvTg4KvRodlFAefdjI1cV84EPFXvg7YUETQkt4vFd0JhyjLce474DXKpfu7B2kdcSYLyMEiaDzpLG3LDz0x5c/9GbCzBdaVCYyx9mKkjxmvGhvLXIPKPaEMLXMyNiIpQ4S2TLlwK0b7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZUajjbh6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZUajjbh6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so2670605e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790661207; x=1791266007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngp0Z71bP8R1r8qPJz7GJYV+9s7Y/H9eYdP6lvbeJRY=;
        b=ZUajjbh632qGIBCg+UECNM34ZmJ2mr2syd1KV+02z6k11M/jYDxyphOw39SHKfRtNr
         IVZAFsRLLSb4WrZ+5z44CnJqU7Id5xeJXiAFp/ojHq+1MqjThtENCkPHKNJQ4oCgs7EN
         byF+pQGGfQt1EZhFOLNwNvjysHhGUBh1rGpENGXrtbdOqJMuACFYex+BYXXjb3JVuP/Y
         ggEfwoTzxtiX2Llamk3a/VqNWTFMhmP3wXtVXlbkroQEbaLtBvwjqX63BKCX0Po3kmXV
         kKrAxqQjw43w57Xq9TUeylGTWP5ZCYoGUiMb7VezhdMXo40v9FkimBqmB2f9HxZvkh2j
         LYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790661207; x=1791266007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngp0Z71bP8R1r8qPJz7GJYV+9s7Y/H9eYdP6lvbeJRY=;
        b=CrBEaPAMkmlsa8PGkyYq/lSxTskvC082SAPJ65Aw330E8ug4GYfjw8nHuI1dvzLqo5
         yb6GFMbSB7PSZIMzL7ouZ/xkYYmU9qW78Sa48r6/fnjxctSQZ9IpkhgnDGdppLyhtpz0
         gFRi/tqoYOnjcjZto3GIQqsgqqw1yMYqMGp5gm2OjyB0KNlO53nFUafnZiZbmcNDTWL9
         IT/Ko1wYL2eHF8NCD3avLlRyh/n2WxsREIyJy4dBx8P2jqEmmhTAd1p5eu1jMfhJ0Afj
         Hr9PrD61R4clAU78G8wT1HuMgbMArocf0RrecjyplXBnZEq2xaBuyySJ7vmpLAVVzuWs
         tY1A==
X-Forwarded-Encrypted: i=1; AKwUvByp2K3J20NhfhQ0p8XKtIqj8s7E7X5qATzVUBoQEF3RbrAf56oLGC9j6Cta8vkZ4NDaoilGZGCOwXEZOc6jftv8gEs=@vger.kernel.org
X-Gm-Message-State: AFuF++m/GlmpyFXBe6l6NvUhd81mjXWtr/3U+d7aLdOvChg5kCGM1481
	W6GkUi7gMb8CdVLudkvvGZmyP/+Q3hvtfXoNNi+6Aij15encfCCFO34Rd43TihPXsjw=
X-Gm-Gg: AYBFou2iHhbPsgGDQrssaD0p4bNyFIYH3djDt7NZx0ak4m4Kk4M0V0cJIogjGORjjCT
	m9EeZyZ9X6H4IEGwC2lLVpsAUYTIfRHptGSHH5npCXYqtY5rTNo00yS6/P41gIsAIxjVBkcFjgA
	JU8Ekrf6qyO8bb5k7BKYzoQ9rasG/CbikpwNplhPaziNv4J2khEv3gbDzmLfiY0XqFnX1BR81IV
	kNgxIGdSMK0XuR2rgmbIxJvw5zEoRBJjkVszBihFoL0OpBJ5lOwFnF8irQuQ4xFblWEL1NZuXW8
	EgLlQqoPrFX/R7S2HVjQJpZatpbDihvgcQhUpM9IgNl47RVZYvSWYyavzMP+SRQzhU3SIbNcvl3
	O9jw5mN3tYUbKqRb8HJolE7qj8gtJvwFT+DTVXGkmUk02hd/9r1MHK70+r/ozKkG4/WhMbf3LQp
	Gj1+5JkoL2jeM/SU3XfiHhjAZTaGODTYOgoLZGJ+G1q3KcEfpDpVmyyyZX1bXHKgDbgNovHSV2H
	dE=
X-Received: by 2002:a05:600c:1daa:b0:4a0:ec5:46d9 with SMTP id 5b1f17b1804b1-4a00ec54708mr13164425e9.0.1790661207369;
        Mon, 28 Sep 2026 22:53:27 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00d10bb26sm36434675e9.0.2026.09.28.22.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:53:25 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:53:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Bradley Morgan <brads@mainlining.org>, Thierry Reding <thierry.reding@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Message-ID: <artRKXU0jygdcxx3@monoceros>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <DLR4AMFM8QZ2.36R6G0LD9D53Q@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmkyuzojfuhp3rl4"
Content-Disposition: inline
In-Reply-To: <DLR4AMFM8QZ2.36R6G0LD9D53Q@kernel.org>


--nmkyuzojfuhp3rl4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 07:15:12PM +0200, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 6:46 PM CEST, Uwe Kleine-K=F6nig wrote:
> > Note that different to Danilo's suggestion I don't differentiate between
> > driver_overrides setup in userspace and those setup in kernel space.
> > IMHO all are bad and there are alternatives for the legitimate cases.
>=20
> I agree that the implementation - i.e. (ab)using driver override - the af=
fected
> subsystems have chosen is wrong.
>=20
> But, there is a difference between picking the wrong implementation and b=
eing
> semantically wrong to a point that we need to taint the kernel.
>=20
> So, yes this should be cleaned up, but we should not taint the kernel for
> otherwise correct code. Otherwise we could as well taint the kernel for e=
very
> other abuse of an API.

My position on that is: Do the global change now and help the subsystems
to clean up the mess. In my experice waiting with changes until all
affected parties are smooth with it is a recipe for failure.

> > I think applying this complete patch set and keeping fcbfaffee51a ("dri=
ver
> > core: add TAINT_FORCED_BIND for when userspace manually messes with dev=
ices and
> > drivers") is too much, so this series serves mainly as discussion groun=
d for
> > choosing a sane way to prevent fuzzing results of only mild interest an=
d stop
> > patch sets harding drivers for driver_override handling.
> > My preference would be to revert (or drop) fcbfaffee51a and then only
> > apply patch #3. Maybe also keep patch #2 to taint if
> > "allow_driver_override" is provided.
>=20
> Agreed, but as mentioned in [1], I think it is also reasonable to only ke=
ep
> TAINT_FORCED_BIND for buses that do not support hotplug in the first plac=
e.
>=20
> [1] https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel=
=2Eorg/

Fine for me, that would mean to apply the whole series and restrict
TAINT_FORCED_BIND to "static" busses.

Best regards
Uwe

--nmkyuzojfuhp3rl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq7UlEACgkQj4D7WH0S
/k5Ltgf/VeTTEIetbw5CxkvMrdNO+abbUIbuqST/lOMuzUIceHqJNYOIMDMmyjkw
xj1U7U4uEbm/xPTPwPmeqmAaW5N0yLxTw8aM+N+/c8aZF9BAGIVB5oZxmKMYC9Ui
vcvs4rDvokk3GKxvKaRagr8oxD4JjNWAJY+6aO4DpcWQGcYdLDoSThTsQkZeiU3h
tF6qBM90NoLUwVRpYsAWplhY6UYcspHYpQqZGlHnTXZRXPQ3aw13N/I75qi4YYzk
0zKiyYJt+1rsujTnSL5iMOjcCdYWjhq42qsmSdalfBhWdn4USszYLkdP+SiftCN4
WKQQxD58vg8NQh3dgBjs7fQRXgFy3Q==
=Igh3
-----END PGP SIGNATURE-----

--nmkyuzojfuhp3rl4--
