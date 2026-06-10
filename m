Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD893A7F59
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083236; cv=none; b=jKaaIIDPK+k+QHLlResu/92aTga96G+n7YcUDYUrjgm2BV8iMv+mYGQx9liZJM80qVUuXH0HpQ4ms0UBlJit5ayuIkgrOVQnOQckBmC5I/hlfs7l5KqaalWLjlgY+zcu2tdcmn2NAY6b3ru2DPAysFSK1on0DUtSoNZ7AJe4vuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083236; c=relaxed/simple;
	bh=JZtlJ+beIEsb+5JoGGJxHSjHGhAzuesnwnW5hQsKILI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R6K/xo68OhlsMMNYFtNqanCQOVdTiLjp6ScdeSVBQC+QT/lAzR8H8kis2UfI3J16Dk2/ipH2Knyr5VZIASXUf7ddQJgEo8YnnIodvSGR+Va0naHyoMFtDqxhY3Y6uX7pqe9X4kyjueeXbDEwFhLWSM5BDhxUQ7AOyp/fF1tjo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IHhxwtzp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IHhxwtzp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso54145135e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781083233; x=1781688033; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZtlJ+beIEsb+5JoGGJxHSjHGhAzuesnwnW5hQsKILI=;
        b=IHhxwtzpPsbyDvOmq/sJvrFiU5Y4IIeaEi2wpg89aMDC5jD+W9UePSbviQPLF7KrIX
         SaZu7Vw512lBAHVl0wNU9hsilaqBD4HAtGg7Er6a9f4DKHnZ3nVifyqsxwq7bvRyIJC4
         mhm6HOHD55ObICc21dBOXvf0qstn/3oIpthjEoQ8QRiNELC6k3ZcfF99mHSv6go22Xrl
         XMSJAV/nj6x5sVMFxQmUEwUe1P3j+wX5M91Ze+UKj92CCWJrY8QPy9A0ZmgOeyFxNsEX
         fMGU5WiJR9mf0rP4NFXw5MsXmUI943EvLnHmN388VxWTIwLYWMQUUNojXOSpOQC30E7A
         Aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083233; x=1781688033;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZtlJ+beIEsb+5JoGGJxHSjHGhAzuesnwnW5hQsKILI=;
        b=j+5fbN942LGqwhZ2tfaJzOjEVv3M3o8w0ifcgkB4MFSffHjETDBH7v6GG2yfNkk9z0
         Qsv4TF9cGt0PlvNsM7v9yK80ay+1kxy8ce3wfxvNuIqetj1xDZRcepNjmkWFf5N7Cy/4
         2QuFutuToiOejiAoryDQpPyA9asvRP6GtfXhPGWbE0nksx00KeaUWJCoNQj54n5J4IR4
         WBMMpybXxF8JT+tgZVPzwNQI4tlSe2MdYn6DMfee6p/umhN49ub4EGunR+aSl7KuWmUs
         2GDbjwbQD5S0BKJ4HLYmp4lqMdU9VuOVEMCVBSCSoH0S4/OkbLyqxto58H3NcUSEI515
         A2mQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ucAMvD5TouYa8zZxYVqa6uqKWRcLIheYRVRG9ilx3CYpp+HHPulKyNxI9/Lg1Xac8EI9R17u4IpvytsD1fGS0NU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUqPa+kcHfn6c4ZayJrO1pvQtF3v1Zs+MMThLxRL/EVzMATuH
	652hJIaNU8HHet4cEVCZ72k/ya55RKoJcIoTzml2aaS6aUBmhsI+/2zX8v+WqJPi30k=
X-Gm-Gg: Acq92OFEbWm/VKzqB5VCPj0g4oVdaOfg/64Apgw56cH50iyc8izyUMAmT6Wa6yMtLWJ
	Ysl4gGG9QlgixP5xC7hE9lKNiXRR9LxzXORmFPF05ASGuK+0wwujcs5DO/CmI8PpKEjNS05ARoK
	wChGJyq2N971EdBCOsu2SweiP1crNl9GJvJIIMoaSKfFYvSqHGICD77TpT4WxtBH3IvVQWfgoRy
	AuqENPB8Z0XAwoFk53C0YM27CIFhIg4pFW9cNtJTinvoiSJlYRoRbaKdaPEkBhjW8hpcEuyt5Qn
	btsTVq1DHQHPSLZ5uEllgK7zalZgkmPQQZ8Ztr+k0MjdwvYN10e9lggK1qr7npqJ9HL/8IGq00B
	5sol7Z9Ldz2YrOpHCwTYKnCnXQhw34SbdTJ9uxp6mYny7cTiIlXawW3ZVsmXbjwbYPjdM6dpvRs
	/rryS2hEqICMUW9BAVbcK50ToeIe23fA==
X-Received: by 2002:a05:600c:3f0a:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490d71fa51cmr81358065e9.9.1781083232862;
        Wed, 10 Jun 2026 02:20:32 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:6881:1355:3b75:b347])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm633039335e9.10.2026.06.10.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ca7b5cacdb3361e55674bdc0434b191ed01cedd7c55020e7ce73af9ada17;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Jun 2026 11:20:24 +0200
Message-Id: <DJ59B5LEGPER.3UURGUC8IW7E2@baylibre.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Masami Hiramatsu" <mhiramat@kernel.org>, "Markus Schneider-Pargmann
 (The Capable Hub)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com> <20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
In-Reply-To: <20260610171740.c30c43c5faee0beac3ad7546@kernel.org>

--ca7b5cacdb3361e55674bdc0434b191ed01cedd7c55020e7ce73af9ada17
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Masami,

On Wed Jun 10, 2026 at 10:17 AM CEST, Masami Hiramatsu wrote:
> Hi Markus,
>
> Thanks for ping me.
>
> On Tue, 28 Apr 2026 10:30:29 +0200
> "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote:
>
>> fp pointer and unsigned long have the same size on all relevant
>> architectures that build Linux. Furthermore this struct is only used in
>> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
>> set only for 64bit architectures (apart from LoongArch).
>>=20
>> Both fields are aligned on these architectures so the struct with
>> __packed and without it are the same.
>>=20
>> Remove the __packed as it is unnecessary.
>>=20
>> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
>
> NOTE: This is not a Fix, but just cleanup or minor update. Or, you have
> any problem with this __packed attribute?

Thanks, yes it is not fixing a bug, I can remove this.

>
> Unless there is no problem (or any concern), I would like to keep this
> as it is.

There is currently no problem with __packed in the upstream kernel. I
just thought this would be a good cleanup to remove the unnecessary
attribute. I am working on CHERI architectures where pointers have
capabilities. __packed breaks these capability tags and therefore
doesn't work on CHERI. When looking into why this struct has a __packed
attribute I didn't see a reason, so I thought this would be a good patch
for upstream as well even though CHERI is not yet relevant for upstream
linux.

Best
Markus

--ca7b5cacdb3361e55674bdc0434b191ed01cedd7c55020e7ce73af9ada17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaiksWBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNL
xQD6A40BTioLtstMuJ6m78MtzsUWYsTKiO8iMlubmeUz7S4BAOCPSwFaXd1BlNDw
XKqIg41ZHrPV9UMaPiA8uJ3vpDsK
=wFsY
-----END PGP SIGNATURE-----

--ca7b5cacdb3361e55674bdc0434b191ed01cedd7c55020e7ce73af9ada17--
