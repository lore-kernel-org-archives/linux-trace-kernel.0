Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA113213A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508076; cv=none; b=ZsCRkU+JTR3qF55TjJL+bQxc4ILJkJCXCcWLMaTc59Lkfbqu36TqTelntSr1kRXUvdk/R1h7Sj0+RZtORnbcfGikrPpxeSPJlJeda1BrSUvzLu4QsPtUT9NpY2Ja9D8s+LtB+HlqXbkyirQBCEsGJBxaMqbG959jbprDyub4cxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508076; c=relaxed/simple;
	bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMpU4DwIU5oZR1n+KPAAfAzITqOOST6Vt1omZsTCFBsEQE2aB8lp0SY/3Q753JFMW7qzVHqoZ5u+n75kvWS9FILmPakT8TBxdYvmjQ6F2ldTPWy5lw8TCy/WWtEq9daibzv1gpwQN4nwpO3KvpO0ru3t8Vyq4I4LcCi/77/8mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0T8OLOIJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0T8OLOIJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so7742127a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720508073; x=1721112873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
        b=0T8OLOIJD1XAwRKy+aNUltYNjOVVxDVGl5i8W6Ox68sJdHim2ZrWyEj3Cx6u+fSard
         VWVoG5z02ZDLg0j4IDUKyhGrZcdkJuAcyyTMsMyeGEelf9mwCqLrDSaPI6jc9LeUII3o
         Vo1n07UrcsVuX+YMcvKeOvbhMJ9GdnZejYZthY6bxETJrCVJsoCgqhI2ZTBBvwbNAfeb
         ABc6xryMDC0Ri8DnxvnLEhrjGF++C9T54Uabf22giGRNmMT6yl949BUwV1YKBgrzjbag
         tVbf8PX5OhDSMFv67a5sTyZ8SE0wT2T5eLuGbQ4gFkfdGWdLRf/gluKnANHi15tpvwBz
         LdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508073; x=1721112873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
        b=WVLPe3gNc4SjNu2n0OHy+B8q8f4PoyoPwpYHEZzfHarqyOVzqtjiYyG1/O4vOfSaP5
         BWp4AGMWPL/85QFG4NoiTsB+PufU2jJk1QOzBApT1h4ik8ZyPpUGnN8des7vVBNCO6H3
         /8mYAp3Hg91RUBxQS29Sf+Sn3fcwcopaLAH7g2QR4vg4ExDAeT+l0t0VqnPhNYLSdfZV
         GHIdH0qUsNlmbILQoKgTvUYRAVc9y0W3AO7zvQ5w9MPIJj2jIvhMM6a9TAXywZJUC4UK
         uflIpP+vuNC1hVW6otz02IvI0MWk69/cjJc1z1DnzcCxIOmia5K4Lt5CkwdmAdfYtU6S
         xiBw==
X-Forwarded-Encrypted: i=1; AJvYcCVexzMT/dWMnsmioTAuF4mn4A7MC6Mcm6K6Og8+nUk5D8lu8itmIBBg0zs2UKnOsgs1vnhKarDSAfvGXkH5/qGtn6DEP1/9tjdasuA4KG+e3AW8
X-Gm-Message-State: AOJu0YxBmmbfIYlzeuxpJ2SRfhVFQrojWWGntr5Zk/wcADAcsiMBpNJ7
	to4WtcxOAacdm5A3Kmg9t4Z6Xgjcr5PreRnM9l5aXP60LG+IcY8BwNtCLVj5J7s=
X-Google-Smtp-Source: AGHT+IGwlKmGrMdFOnjAKchORxMJC1zLzVMahY0rbUUEDJMua3Vkl2zKW51j3oKcjCmefGMmIvJryA==
X-Received: by 2002:a50:fa97:0:b0:58b:4a7:2a04 with SMTP id 4fb4d7f45d1cf-594de604d45mr902106a12.20.1720508072979;
        Mon, 08 Jul 2024 23:54:32 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cf93sm706724a12.33.2024.07.08.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:54:32 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:54:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] pwm: Add tracing for waveform callbacks
Message-ID: <yz57gqlyqk2f3r6rtwun3yplns2rxwfaqdgqey5ipmqmdqgrcu@koclgglkjtwq>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7f7ce46efc76e02a472ed52ab1fc06c3575a14e8.1720435656.git.u.kleine-koenig@baylibre.com>
 <c12fe2f2-404b-454a-8474-0020a4aaafb6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcjng6xahjawfwjm"
Content-Disposition: inline
In-Reply-To: <c12fe2f2-404b-454a-8474-0020a4aaafb6@baylibre.com>


--tcjng6xahjawfwjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 02:14:09PM -0400, Trevor Gamblin wrote:
> Missing a sign-off?

Yes, and a commit log.

Thanks for your review!

Best regards
Uwe

--tcjng6xahjawfwjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaM3qUACgkQj4D7WH0S
/k7jZggAi0uG9uwtF+gXHub7qdnBzopWLzdItTN+jviBIRaKZf1PiCnsFn5weriY
VosJwlbLry9/TUtf3lqf2xHxo03IjrXxgzXUT+bMG9Kk91tbCDFsHhXwaCxEvbPF
oAspz+V7PgEIN4o8zKQu4U3GvUUETWjGriDR9FtgBl2Pna04/zcg+GkGVJ11GbjW
K1noG/Hsx71SASB6pnb2HxCUHd6L4QkctE8rFF84kc7CrgQQOEnjxAHw4ibQ4OU8
44OCr/2J4dfhGO39bpZ//nuHeCg0DC6w6ps+M3cwh2JgUOSBurKuUrwh7wrF2JH8
dWAgA6BoUj7lzjP6PInoMrfHpelCmQ==
=fWj3
-----END PGP SIGNATURE-----

--tcjng6xahjawfwjm--
