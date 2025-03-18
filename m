Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548220CCDE;
	Tue, 18 Mar 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307757; cv=none; b=oV0YjsROnaEkePq2hDlHUC/8ad0q4CMXQmHAUA/fxBXtER2AdvVP47lnWJqcNBC99+CZEQ4SXf586Fz7OyXaYsXP68DsZPDT/Bz5xEAnYVoxxKYsB3Pi7AJvNi+Z/Bb3ESWUHY6r0tRhb7SWPMxibLCRlYsq9A4Hq+nZh4qXwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307757; c=relaxed/simple;
	bh=bhxjBtgp4kDQksgqi1xMuHbxYBdn6tncSJ72WND0hEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aATVvpCDwunAqrg63TfE5UgNMxuz6uLWmlBwl/aT+iIYM7RgejAtUm/L2+UYP4u+EunWAq3zXpN8dekzl91uRk6pE8WNcKNhMM2jxoMIl9oXbpOd+Z5+XGZLTa8ldMbssqFSvvvLZQei8GkEUz40hlobbITYfL+XulAHkThz6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePBB5nTX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePBB5nTX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22622ddcc35so43413555ad.2;
        Tue, 18 Mar 2025 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742307754; x=1742912554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38DYhU9NeR63OPkTYaO3IDcR1iMpXAwYZ8MimJ8MOoY=;
        b=ePBB5nTXoEW3nM0MNbWQ8BUiSex8V5KKP1SjIIbv0Hd/NBq1+9mn2wy1meQMKvTojW
         X6V2oQg9UkAGAE7dOhAiUgw+kyDpR9rqlXcApm9OuFteXGJgdilAOnojoZ0P4p6faqyU
         Dt9V1I50I61ija6T5ybG8PaetmqT712TuXhdNxPDBrCo9jPB6gW/1Cd65bfidIbb3IeT
         /oUiVLija5kX2yPxLZDXG0of16p2u1suY7YxVgJP+Edz4qgF5SxmdX4Lz+ISgHuTq5cc
         z5nJ5Fc6HlKl/ewV28/ZP/6F32FMgcfG3hCoERsG4odFKa93qn5839ytDKh72H67U5Wh
         xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307754; x=1742912554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38DYhU9NeR63OPkTYaO3IDcR1iMpXAwYZ8MimJ8MOoY=;
        b=EfCKKmRemx6oCxCfilGg2hLfdHOoUHjDwZaEY2T+5DviJHoZ6Ynt7gO3uCWwOSKCEL
         /W41cwRBdI5z5AP7oSIRZIFYCKmqskaBH2AD7pM92G5L+DH2ktibYttL4BiTOFV6FI0K
         CfTVJviFoooNxzwHlqj+3V6XXXVvjePeXbYjIMjtVdOP8Bgcx5Qabc2+GYYs7vKTDbBQ
         6YDWAs4NgnQsE963A+GHTBbMXi7s5fr/m5OsJgXw6VIr9/BuqIWclWFYqi/dNxBNoJUT
         pM+oTIsc251QQTBXLEtKysD74CN8FF1IXDCEpfpBzgB7Z3xCsYhKnM2MlT6dz/6vjXZu
         rm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2NCxLRbv5Q2FmmD2evSISCx3xOqddvilu4qvrJALgisrgCrIlnUEQSDQP2ireXKDgPdWv4XjVFuo=@vger.kernel.org, AJvYcCWr1aVBlt+9Zow+/4H1prQ79bTZj8nlg2ZbJij5m9YUyk9riiiVRcth3/3wdS0R73wjYQClI4SWdcws6qmsU+f+gzcY@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0EjC6iA3/K4JcxLeJbDlPP99mZ428ZsWNpYSrmLRIrv8Pys+
	2FwWRXGfVUl9NuCmTGbeeF9399hNEGpngs3dwolQZwcZkqoVdoHI
X-Gm-Gg: ASbGnctkkM6cYsZh5E9bQWfweVGHGrbM5XvdlKSMfRbNu+2/Phy8YEDLLFqMhQRXcbS
	z+C0DNtn+i3NNTBWVWYMRSIh3oUt8DMN1uAlp8pSxoaCn3fmspliizguO2oNw4/0cBehOJ9KoO9
	aXoLULhqVKdDxXf9MYrmJFEcaNGEUYbf/kUVVRtOcS/Q/5a675E+vKNKozQaBslkBMOp1vA8bMx
	nhChvcx5J2xWEym2GqCVed8b1oj0IAi8jwyDdbNIa8q1oMfx32lkivlqAjol2I28jFGW5icwqKk
	z+HYcinYrOYgKzUKY1Iyhoyp6EdBjXDG8ucxW4dFU1OjsIV/I4uER24=
X-Google-Smtp-Source: AGHT+IHfn0YOiCrJgDVT6D9vqLwbLWYvefBjGXOzK93X9X8ZKF+gyG7wU5swUF3rcICsNkfF/3qi5Q==
X-Received: by 2002:a05:6a00:1398:b0:736:3e50:bfec with SMTP id d2e1a72fcca58-737572301a9mr6633064b3a.8.1742307753469;
        Tue, 18 Mar 2025 07:22:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e40sm9868696b3a.139.2025.03.18.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:22:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1D388420A74B; Tue, 18 Mar 2025 21:22:30 +0700 (WIB)
Date: Tue, 18 Mar 2025 21:22:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] docs: tracing: Reduce maxdepth in index.rst for
 clarity
Message-ID: <Z9mBpct7G7FigDjB@archie.me>
References: <20250318113230.24950-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UJyZX/jSXsbpe7Bj"
Content-Disposition: inline
In-Reply-To: <20250318113230.24950-1-purvayeshi550@gmail.com>


--UJyZX/jSXsbpe7Bj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 05:02:29PM +0530, Purva Yeshi wrote:
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 2c991dc96..fecc4adf7 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -3,7 +3,7 @@ Linux Tracing Technologies
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
> =20
>     ftrace-design
>     tracepoint-analysis

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UJyZX/jSXsbpe7Bj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9mBnwAKCRD2uYlJVVFO
o0jEAQC7OPAraS6ohemlhA4Ek88bLqk2VU+WWwCNlNJwUj8qgwD/eIMVDcV/FFZW
IS4ho0D+usixVNFETzxpIw4cnm7UwQE=
=YS9d
-----END PGP SIGNATURE-----

--UJyZX/jSXsbpe7Bj--
