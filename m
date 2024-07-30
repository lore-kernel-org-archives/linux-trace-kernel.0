Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725D79E1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352445; cv=none; b=rgQocvezsdmW/R+rukL0ZwykoNlNi6YpQAdVkUlu1Cf76NBziHkJxBbFT9RxXMeqWzvqvVvKq7KEwDXA9G1iciAZnwbvF2BOsBMSP6fyVH/fnGt+llKyEWawMrbqqnC00RAHHkfvVunB4BrEVy4aNxsEYw6yyTQ3H1sNg+HmJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352445; c=relaxed/simple;
	bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDTGxi9fvuCrHcW5EBlHWjcFMSikD8G4bDzw5/o1zD4tVxdC0pBBty171vU9taOMOdi5CoGo3cHiS0CeiyqghkwMbK35/xLIe4R1vSP8l48FyDa0tn6ytJa+Gbt56d98T5kyah9sptbz+4Ld3geHQ4nO1byK4Eug1WiuD08HwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmYNc+ep; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmYNc+ep"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f04c29588so8497028e87.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722352441; x=1722957241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=GmYNc+epkEPEL6F3gkJQVfz2nwQKkQyjVDnt1xU3BDsuQVq49zXldJzXvsZvSPedAl
         xJvrdaui8t8p6llOi4hfo29LXpEGCZQ3mqan+i+vO+kZv3sZR/Qsk2zr/HhmFpigS9nh
         4RqB1ocIrsXCGuM3gLW9jhTSiy6cNhVMxOtyDmkgmN+z8AwkRg8n2Q8jeQHViVy1W/1q
         mKxa4NKrcWz6CPB3ynux4pauNsPsHMD068WtrdHjFw1+aUZd57+0gm1mbGYzMDKUbCt1
         N8fx7bM9H2p/UeTuZD5IgjivGJ4EfsqQbyMm3Jmsq7QPhXSD0BDYYXTPIqBFQXuenU+H
         Aokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352441; x=1722957241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=O8NuZhmW1rEgLmAXMsI2K20LQylx5Hm7WJ32iz+ex+M6WosBiIj2dXJg97kkcV7kbK
         HQhtvK13DrlFErWBt++SyrwtEalDfLdKgCmx8Qvhx5FlfkyDUw3wAvdEXymrpoL1RiBF
         /H8eUoMVmypQ4CJIkcevDmkGhRUVLJEBX6whs2aV1wH6B4Avvgk7dsGc89CuGqlZPzrQ
         ASTp2a2ZOF/xU7e87B7s8DgkZu2vufyZhHdmHQC/MU6dWKH/8kdWEKxSTbiu5JdGdMzb
         kxadQezoC04zWLgLoRVBS/qZX1ZggpTIF6dsjiqDrNcvbM6sWLF+tkcZqDOAAtRLr4Mq
         CsYA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTGt1+sQkF7pxKsBM1C7Yxw1BWD4+mJCiFgn5txBlh0nIN9nwGrrFxC8/ccgg5iW0/jXCse6Oi2Q8iXd1Y+yF4LAVj2mjEmdpyNGIo48mV7wI
X-Gm-Message-State: AOJu0YzSRDSBMZd6zuXaUIPGdsAQALlI2Iylq7HhwL1t3S3MfSYsoo3w
	48FQeQisue3QYxIsc+8+zaCUFcAWCFlv+2NwYmkYpKkfjAQ4KH/PEbtF8fX3zcs=
X-Google-Smtp-Source: AGHT+IGLH7u6gNvmP31iep2dgQ8sNneBa4byGkknFmkyHaJGeb6F7VEVA6LUgnVJgSR4NXzXiXtiLw==
X-Received: by 2002:a05:6512:b8a:b0:530:ab86:1e with SMTP id 2adb3069b0e04-530ab8601femr1807985e87.6.1722352440709;
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91010sm658249966b.172.2024.07.30.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:13:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Make info in traces about affected pwm more useful
Message-ID: <pmz5sgzaroljhbyeulvh3mf6izhwna3d2mjueo3udosy45uza5@5dljnvmtpu5v>
References: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
 <qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
 <20240730103910.6de49acf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ri2nz55ffg37fvyu"
Content-Disposition: inline
In-Reply-To: <20240730103910.6de49acf@gandalf.local.home>


--ri2nz55ffg37fvyu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:39:10AM -0400, Steven Rostedt wrote:
> On Tue, 30 Jul 2024 09:22:53 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > I think the patch is obvious enough to be ok even without the tracing
> > maintainer's blessing. I applied it to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> > .
>=20
> No problem. Thanks for the Cc. I don't always reply if the patch is pretty
> straight forward. But I do look for things like holes in the TP_struct()
> portion, that would waste ring buffer space. As well as uses of
> dereferencing pointers.

Looking at
https://lore.kernel.org/linux-pwm/7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.=
1722261050.git.u.kleine-koenig@baylibre.com
is this also in the "straight forward" category? If not, some feedback
would be appreciated there.

Thanks
Uwe

--ri2nz55ffg37fvyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmapAzMACgkQj4D7WH0S
/k4QMwf/dmmEA3gl+PIcynIa/JtYamuZSqSBc7oJ9ffWZ8YdfNaMUlcQa16DmIl/
DA5Rg8eX6Y8/ZARJG6xgB8dqgyZFf2al2+oPTE/BOiL/a3qWLsKwlJlwrQ8/FYfc
R9WQtlOYxcRO7L57iGoPR4zQ89y+UiSy0IL57O02NxNSXE130TSB2Ue7gmDEXFn1
PL571J86vCnGNaX5odZsYU/d0ZtsFX2GkuU9sk4W2i+JfZz8s3geDJPGnC0/14SI
xVHneq/7Wgqy7xDM7O/glS1BmYTjbi1P9qYR3cLhaM/sx8xVRg9DbmIsAeZc+c6M
2mCsgAd8lCb8x0Xm8hetCjylkXs/1Q==
=dJbl
-----END PGP SIGNATURE-----

--ri2nz55ffg37fvyu--
