Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38622B9C6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966694; cv=none; b=IDJb2mEueSJJkCd2zOxw5KGSj77NIY3iJa1X7EjZdjzLFgGpo1J83RDXRmCwi1RyZ/I+UXmarHXLIhtT4Li63ESxaDc5AwdBtWGKG3l7C9bWp1SG6K+Z9icsrfHQF5b8GKg6l/A5hfdAsbnE1XtfYw1Xe/S/5l7TOkdVQuAeqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966694; c=relaxed/simple;
	bh=jSP80QQ3RIwbB9d2cbCqSvQyj8bH6VyQMJspvBsB0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0D786yptaL8Sc0uKPeqRBsue0Uo6EICXqHVpS7WNw5gMvEdRdNZAQnkuJUUB9tsvOSfDNz7rnXvsA1hmPS/MgbCakShyeGxtS/4DH30CxNPOkPAXYPi0I66TcyLXlUep6VGfHSrzFI4L3XL//1hPKCIx2r26Gr42HqPiddGOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P10s3HNE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P10s3HNE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so9976571fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722966690; x=1723571490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEPV8O/bobIi5p9nTTiWHc/1HlnUPMSVdRAVbmjiJfA=;
        b=P10s3HNEmmZGmCx90vULhdlcrb7A96X4fR12ATSZMCfscuS90h5t/Byaf70Jrxqehk
         6/twOFQ4VoISHzNk3564BgSvZTpU474tPYfGNuW7sPuVYfydXnZsR+LZE9KwFGXcgeco
         2WAtjHxfeMir2vjrANbXkADp5R9JmBSvXwG3LDm0GyoGxsnE6oms0zRtX4MWWx4a3JIg
         zcWhmy55jQkwRS+sGn8imCkCZRhcl0dewQ6Al8E4P5RSMazCmpssKAnPektZfL5QCh2K
         1uKx33t5xXJfPYq7c8MGhzDIjQeltLqlMdKRTjcrCw1Ahtfh4gVG6oZnlEIzMW/yLIHX
         suzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966690; x=1723571490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEPV8O/bobIi5p9nTTiWHc/1HlnUPMSVdRAVbmjiJfA=;
        b=VEENf6BgGZzgUJvQtcKgi0wOWjo3VxXVs4FBtJXkYkKyYNa3I+YCDki7UelIMzwztg
         xKEn1odZJO2h0DIpMK3YxB/+PqLSxCptxRQ8HKfJgLliwTrLOC8WmSAuh1Wj7f9Or15V
         brkOYdL76dBO68oSDqz48J5jrvpCWEURrjOPzU8h5lReY9fRYQagGd0UUkqBXzEBnTDP
         rOG2YpKwTt7l8q5MJeVqAW6Xu+IrX0VfFxtm80aBtF9muDc/KbNSLfLvBT6AyWKnRnES
         ejHj+5YeWLWYmEi3WxAfSYEZ4++QEPlISn+N6fP7WFJzbbZG85DgIccEw3TDJI97zEYF
         /2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLI2NOnZfzNgyQP4Yqy6KAJodFOQ+m1bnEIgczwhKynSHM84EYzc4DRlVFe6nr9Dt9hkGZFRpzJjm65v2QAnVuWRNPKRcJDW7Cv6+0PZST7v3d
X-Gm-Message-State: AOJu0Yx1NvSKh6f3Yak0mKfljrWmIo+L4munm1+8BIF93yiitP/wgoCX
	MnN/da5gZWgzq8lbjZFlyRPO0Vui3yA6ANyJAWgTPDpXSDtfIEqHSoVuZWC7Uz4=
X-Google-Smtp-Source: AGHT+IGSi4GuJh9qmDt/eZ6cr3AQur9jVGY7A+ektYUqG98TbGGq6brOhPykx5o83fi+1WZZTOQ8kw==
X-Received: by 2002:a05:6512:3ba5:b0:52e:fefe:49c9 with SMTP id 2adb3069b0e04-530bb39ddf8mr12022225e87.36.1722966689606;
        Tue, 06 Aug 2024 10:51:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm4416778a12.81.2024.08.06.10.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:51:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 19:51:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 0/8] pwm: New abstraction and userspace API
Message-ID: <ld2hbd7tnltcrwihhcjrloicpoorrve7ugtjxgyjcowoneas6p@dircm3eb6yok>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rnjsu6vonelo7pj6"
Content-Disposition: inline
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>


--rnjsu6vonelo7pj6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 04:34:16PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> here comes v3 of the series to add support for duty offset in PWM
> waveforms. For a single PWM output there is no gain, but if you have a
> chip with two (or more) outputs and both operate with the same period,
> you can generate an output like:
>=20
>=20
>                ______         ______         ______         ______
>    PWM #0  ___/      \_______/      \_______/      \_______/      \_______
>                  __             __             __             __   =20
>    PWM #1  _____/  \___________/  \___________/  \___________/  \_________
>               ^              ^              ^              ^
>=20
> Changes since v2, which is available from
> https://lore.kernel.org/linux-pwm/cover.1721040875.git.u.kleine-koenig@ba=
ylibre.com
> include:
>=20
>  - Degrade a dev_alert() to dev_warn() on feedback by David Lechner
>=20
>  - Improvement of various comments (partly in reply to David Lechner)
>=20
>  - Add _ns suffixes for members of pwm_waveform, thanks David for that su=
ggestion.
>=20
>  - Rebased to v6.11-rc1 + pwm/for-next.
>=20
> Because of these changes I didn't add Trevor's Reviewed-by tag for patch
> #3.
>=20
> I kept the BUG_ONs. There are a few check_patch warnings about it, but I =
still
> prefer these given that it is safe they don't trigger without further (bo=
gus)
> code changes and when they trigger crashing early is better than stack
> corruption. Also checkpatch tells
>         WARNING: Comparisons should place the constant on the right side =
of the test
>         #158: FILE: drivers/pwm/core.c:262:
>         +       BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
>=20
> But as the BUG_ON is about WFHWSIZE being wrong, this order is OK.
>=20
> There are a few more checkpatch warnings about line lengths. Breaking
> the criticised lines further hurts readability IMHO, so I kept them. It
> gets a bit better once stm32_pwm_mul_u64_u64_div_u64_roundup() is
> implemented (without the stm32_pwm prefix) alongside
> mul_u64_u64_div_u64() in lib/math/div64.c, but I don't want to wait for
> that. I will address that once Nicolas's patch improving precision of
> mul_u64_u64_div_u64() landed. (Hmm, it's not in next any more since
> next-20240724, before it was 3cc8bf1a81efde105d8e57398cf8554b57768777 +
> dbbe95af0fad2a9d22a4b910cfc4b87949d61a3c).
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (8):
>   pwm: Simplify pwm_capture()
>   pwm: Add more locking
>   pwm: New abstraction for PWM waveforms
>   pwm: Provide new consumer API functions for waveforms
>   pwm: Add support for pwmchip devices for faster and easier userspace
>     access
>   pwm: Add tracing for waveform callbacks
>   pwm: axi-pwmgen: Implementation of the waveform callbacks
>   pwm: stm32: Implementation of the waveform callbacks

I applied patch #1 which is a harmless cleanup for now. I will wait a
bit for the rest of the series, as during August I won't be able to
react to fall-outs reliably and quickly. I plan to apply this series
with PWM_IOCTL_GET_NUM_PWMS dropped directly after the next merge window
for cooking in next as long as possible.

Best regards
Uwe

--rnjsu6vonelo7pj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmayYpwACgkQj4D7WH0S
/k5X6Af5AcYk85/lzILYN6aUXwXaafFzMLqD0NyuhAkvVU5nIXZV4zCAe5RIcAPQ
aMYc9HZgZcjnSLLwQdfUviOyI4O5pRXsTHlbhCww1G1iS5o0QWb5ioODTaJUmAFc
cgqGhmkIlFjA98c8ByAtxtS7NqpnuAcMmZSGf5YoFj7EAElBxKEOXApRVL6oUkpc
JURo6Ea4n/grMcvwkdT0px09TdCs80ZK5efU5QgVduB3ME8fzoI/S4vvNjgp10x6
Ur4eoGnXGRoJ4Uzcv3OY/ydc3STvoJ6mmTvFO2cgCDdpdHs8LwNM7GoDx8/jJ8gZ
HW0SHHwcjYziOe9BuAsEz4bw4JwdkA==
=FH+q
-----END PGP SIGNATURE-----

--rnjsu6vonelo7pj6--
