Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB539FD9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837641; cv=none; b=jdQZ6RZ83pASRz6yy1b1xHXW66361zkz4IZVzQ7poYNwAZTCU8mDN7B3y+s6xXWCeO/Y6TZKYxMBnNa+npb7F3gWpXWgJ55Uv3ZmbPay87BKmJaxbeoNKMrxu9mC6TDfl+htJ3c1ROiRackyD2UnLZNrrQjlqCMhFNFuQNlqOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837641; c=relaxed/simple;
	bh=tHybA+sPs/+b+P0zGrwAATn7fve3huRWbNvhgJc3ask=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQUyHGGUkxW3m59CyyT8h4YEg67g4TETBjsDWD9KJ2WgET7EPfhkvH/CfPEDkrMuxGqGzBYMKmWurHLjof7fMJogPSgZ6tsupeWBEOoDAt/Ygi3SqSzx1SDxTqpzKKqk7j274ppIgbQ8atwdjz2XFElTWlVMgwocDoKIZ2dc4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FALJvdlw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FALJvdlw"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so5277206b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759837639; x=1760442439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpCgxhORN6lEa4s+DNPc1Y/IXSmA220J4nQ7qgIWmeM=;
        b=FALJvdlw0f6fzKMr7jGOs52hp5cx3iDizPSBm+MFhbWxTyGAtKKWoUBJ3vOl+XSlt+
         FLEWhGCrxqFQAMK3Kf5M9njSA29MACI4m6OPcJ8upInIkLMsJd4ZN4VyOpYMpz+rptD8
         ensBm8xczJrCLErPMhVUOXKyGiyrGML1q+8X4uSXJYr3Sl6BWLCf7Z4fL5Nq8bJBGmBD
         vqIK35NOHrPLbf4AldCLcFdVXM1yumgz+y3hyn9mw1985uLxa/45PHAIoe5C7VgV1Ewc
         FExDBn9o/NrdAWpsMktsvupJ6oXCOpwTzhujb2XcxLpyqq4osTiVOkVv1oBdc9AiUkv9
         s6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837639; x=1760442439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpCgxhORN6lEa4s+DNPc1Y/IXSmA220J4nQ7qgIWmeM=;
        b=QNZFfbQpC4a/27hc4dmtLxNiMreXcqJxDGrvqsmahJkNmawoNyG8QQLWpSYDBOqIhs
         wZ3xMdKWUkBHQtNqSqD1KEX2L6dtDo0IVKebWFYq3yLgL7tUQqX7qh/boV4OEOy+2iQW
         qqKvpx+0D0ZhursHMIzM+DizDcmLjo10vZSgIn67Nn62ulUMM1kSl01pIooFxqXxoRWF
         bARX29MILLZONpz4cJKsXJLGNcP9O4Zhg22Wy7z9hIZ5Nsh2oKX6HbyVVpGFm/NdKLBf
         vn+Pb+Sy7prc33CBfFopLS3L232NRpIOFuDkG0+Z7WbB2kpMgnigpzA7yHuqEgM6T/aP
         6ZkQ==
X-Gm-Message-State: AOJu0YzF5mdpkNLrJgeTcuxbOBqFLbZydeYYAVpJRrllreihUZgreFQY
	/tQTb3WhJFEOvXeJTmzQpDWKIMmBC9I6UII94/jkimwXSBt3z/KUFGcL
X-Gm-Gg: ASbGncsUolhGe6+Nq+tmx87/kAO3EK7yaN3jOYSHvUHmZDOzqMEESR8ctaScsbLf3sW
	oXqyb7uSSc7NhjLs0x8n6HGNPmZCw2DUOzlWxn+HLiXFlnzKG9NvusW0vJYmo2BZzo5jr022nXo
	a9oIPqq3mtXYA4r0/VBsScc1YB2PWqxaR6frhPwV6Hk9DSCyDJNjfROzhr7yXtc+w/jqpveRxXd
	XXaLTriKZzhGvwKzwSgAFMfLWZajZhpebkFhoIxrOn4zAMfAi/hX2BDbv8PYETlDYLykjoPROOQ
	pKtfXgtNP7rBOP0d07FnxB/UoHKl0rK8AD57q8SBFijwePSa+gCVI0y0jsduUr6hKp9b4lJA8pS
	xT9zF0jMeHma4wF85ksmr+cUFpdwl4h/NHQGrkcAxTIQiVYmXbg==
X-Google-Smtp-Source: AGHT+IH44vhk9d17Lw4GXZ5yzA6My6EceoSjc9zLI8SRcAEeP+70+Ts8xj+ACG9aEOYyI9bijbzveA==
X-Received: by 2002:a17:902:ce0a:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-28ec9c97565mr36083695ad.16.1759837639170;
        Tue, 07 Oct 2025 04:47:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d12608fsm164155715ad.33.2025.10.07.04.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:47:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 865214233431; Tue, 07 Oct 2025 18:47:15 +0700 (WIB)
Date: Tue, 7 Oct 2025 18:47:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] Documentation/rtla: fix htmldocs build error by renaming
 common_options.rst
Message-ID: <aOT9wttB8cQvFDdj@archie.me>
References: <20251007083228.17319-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YjlEHS0UDQisqRua"
Content-Disposition: inline
In-Reply-To: <20251007083228.17319-1-krishnagopi487@gmail.com>


--YjlEHS0UDQisqRua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:02:26PM +0530, Gopi Krishna Menon wrote:
> diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/=
tools/rtla/common_options.txt
> similarity index 100%
> rename from Documentation/tools/rtla/common_options.rst
> rename to Documentation/tools/rtla/common_options.txt
> diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/to=
ols/rtla/rtla-hwnoise.rst
> index 3a7163c02ac8..cc2721315552 100644
> --- a/Documentation/tools/rtla/rtla-hwnoise.rst
> +++ b/Documentation/tools/rtla/rtla-hwnoise.rst
> @@ -33,7 +33,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentati=
on/tools/rtla/rtla-osnoise-hist.rst
> index 1fc60ef26106..a11c485f127a 100644
> --- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
> +++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
> @@ -28,7 +28,7 @@ OPTIONS
> =20
>  .. include:: common_hist_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt

For consistency, though, you may want (in separate patches) also rename
other common_*.rst files.

> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentatio=
n/tools/rtla/rtla-osnoise-top.rst
> index b1cbd7bcd4ae..c7bc716b2899 100644
> --- a/Documentation/tools/rtla/rtla-osnoise-top.rst
> +++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
> @@ -30,7 +30,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  EXAMPLE
>  =3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentat=
ion/tools/rtla/rtla-timerlat-hist.rst
> index 4923a362129b..547dfc7ace58 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
> @@ -29,7 +29,7 @@ OPTIONS
> =20
>  .. include:: common_hist_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  .. include:: common_timerlat_aa.rst
> =20
> diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentati=
on/tools/rtla/rtla-timerlat-top.rst
> index 50968cdd2095..3740fd386ea8 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-top.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
> @@ -30,7 +30,7 @@ OPTIONS
> =20
>  .. include:: common_top_options.rst
> =20
> -.. include:: common_options.rst
> +.. include:: common_options.txt
> =20
>  .. include:: common_timerlat_aa.rst
> =20

For this patch's scope, LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--YjlEHS0UDQisqRua
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOT9uwAKCRD2uYlJVVFO
o26DAPwO4e7EjANEwcmc6zau/qLSOmqV1xhe8ihZQO2SN2a7QgEA2X3LzAtWqe1I
Kid1Ufu3MBRc5B/abDTix3q8NM7L6Q8=
=FDcR
-----END PGP SIGNATURE-----

--YjlEHS0UDQisqRua--
