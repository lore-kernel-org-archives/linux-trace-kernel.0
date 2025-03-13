Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988A2E3390;
	Thu, 13 Mar 2025 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834928; cv=none; b=EgQj1QIrzoTzCmzZpbX/gEs2RmDW0nJLi5sDthytWNtM6NlnurqSZ+v1VWCFmni3Q6sAkqB5ZUkqLsq0RKgfG+3jEW6IZ+C6xqTRUzAltTJqruCC+Agpvn05fCCnwxyxQtJHrMk5e6+z04UcseQwW6BXp5hqwk37iJHhhAf8Uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834928; c=relaxed/simple;
	bh=r+eB6iiNmZOofV/kH/cgty+BGAXEJuG9/FlGa6p1IpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXZfOLMODUsbPdFx0Rrb+HC/Ft9lMEUviGhtVsEnNZZH1DRZOfCzZ0Ps8BwPntfTJ3lfUZQK5G2LAddceN78+bhfesQXUNaj5XBrfYYeFINFCvPJnB62ehYr8SO3fFEATpGSq7K2y6rhDHHXuLsVRKkqJ1+CK2bqM2IAcQ6t4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeFCFcGw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeFCFcGw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2232aead377so10144425ad.0;
        Wed, 12 Mar 2025 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834926; x=1742439726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y4uZs9IeC823zF1KJoif+3fgDliA6beKiISozxsExc=;
        b=OeFCFcGwn6XTZ/FfCpmtBa+t6p2PbKkI0IgchmU28Eucl3DBD2l55kSwGSCS4BLHYB
         n99RgyEoqosK6P1J1rIHB4538QIAqUy4eTfJ9yDVpnXt5acU2v9yO3wU55ciOJcfMgc3
         +aEVKWqWNAQcN6JW4nnFeX8C3pv3XC7wL3ZdlC+wveW/VhOsqJCHx6k2ZIC4ImAqO/74
         9vTafDVxw0AKPQJSYO1I4BaVwTCND3mPROT3ko+/+t67BToYYM+oGqL+AAMds1vNhKVK
         RHqsL5DtkEZZcdiPji8TdYwlw1BR/I63yAJ80JZPF4ORoYDQkLyVgMxd8mz1dYlqujuH
         P6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834926; x=1742439726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y4uZs9IeC823zF1KJoif+3fgDliA6beKiISozxsExc=;
        b=TvtA23TQQZ+u2FBv38IZ/SdHAC0TihBiAuaIUIOjWaRiwhQxZ1UuT81whpjwTW+Nlo
         qZaCHEGYOBFlBEdFbdiDfeLaGOsjqW9Lwbgs1jACPVqy7y976C3nL/YVtk3bYs5fHykS
         5kGzPI4lTANffP9UhihCBrXQbChZZPmqPUWLgmV5kGjUMLIqNc0NV1seYG8FxtVupxgK
         4CbSTdRYZ7wDKwq+/22xAphA2mVe2i5IuHOVvLJkaXcHhDfOFgzOESqr5AVneP2+unb0
         Uagmyzwg8Z7PxY7kR7rNVJ4KQAVUJ5LQVcc2v2B0msxRGNMX7n32fGFN6ZMI/y6jSsAo
         MiIg==
X-Forwarded-Encrypted: i=1; AJvYcCVzoX/wVubLHv1AI7veKNYRpap/yBz6vmCxC8+oCpoV3z2oxti3SMg75hbKFXGfUtnFXUNqy5i1hsERgsqylSlmqV9q@vger.kernel.org, AJvYcCW7PVAEeR86i5MJ2uKxgk6FoThPRvh2F8blaI9RXICUQfpdVl2FAiw5U+tOjHa+dlHdlsZ1fwEW01BxBuY6@vger.kernel.org, AJvYcCWieDfK81x3l8Grjeb+GqSVgYNBDEC5cBdQVMSGEbxjXG3cBQVe4lBBINCWXJ8OeKLx9MWkj+QYlDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlXM2kqW5YYPWY9y2BoSPoj49eEia0WrlD2aNjvrbUxdsxnRG
	ERmF91pLPHhPUP3tsDAQfwvpz3A9UE9c7LAye60ZesEqFVxCikt0zI9/jg==
X-Gm-Gg: ASbGncuS+6yDHeCiA8i2Rbm9kiGP1UunQv692knS9oRL3xqCrPP0jnIC4jvDBMxTQba
	JtGCIryzDV5mDZhHbkEVaaWjE1hZN+JZRxukVbBc2Wqip0hBXVZSkBOfidChCjuQv1g0B4veU3m
	x+9KsthSmKoTzqdpe+mnQ5vskZmBobiTeVzJ9GHNiz4N6kfPvQ0iYZcEJ33c5zrx0XB40V4nbCx
	6R29g8SPExsHF9LkHm6Ag1plTqbHx9E9YOe73A4+PvYLXzMD30j0kghmNUJmooY3omETvsARUIl
	9xtdF1bCqikro9Zy9TLVEwIay/EZ9STw7qoE8Vqekbh6
X-Google-Smtp-Source: AGHT+IE5WEfPIfF4QrUqCJHEwJWNexMfzYu+4pAeyH5oaXl/EiijH+acC2vEQ0UuApgKnnVlp9lrJg==
X-Received: by 2002:a05:6a00:10d2:b0:736:ff65:3fd0 with SMTP id d2e1a72fcca58-736ff654674mr6089565b3a.16.1741834925985;
        Wed, 12 Mar 2025 20:02:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116944easm263593b3a.134.2025.03.12.20.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 20:02:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AE6DE46D5683; Thu, 13 Mar 2025 10:02:01 +0700 (WIB)
Date: Thu, 13 Mar 2025 10:02:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Purva Yeshi <purvayeshi550@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
Message-ID: <Z9JKqVvG1iw0bFXR@archie.me>
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
 <20250312134907.06d27d78@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OR65uIcLb+LKpD3Q"
Content-Disposition: inline
In-Reply-To: <20250312134907.06d27d78@batman.local.home>


--OR65uIcLb+LKpD3Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 01:49:07PM -0400, Steven Rostedt wrote:
> On Wed, 12 Mar 2025 18:17:17 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
>=20
> > Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
> > contents, showing only top-level document titles for better readability.
> >=20
> > Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> > ---
> >  Documentation/trace/index.rst | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.=
rst
> > index 6b268194f..5ddd47ee7 100644
> > --- a/Documentation/trace/index.rst
> > +++ b/Documentation/trace/index.rst
> > @@ -14,7 +14,7 @@ This section provides an overview of Linux tracing me=
chanisms
> >  and debugging approaches.
> > =20
> >  .. toctree::
> > -   :maxdepth: 2
> > +   :maxdepth: 1
>=20
> If you made this the first patch, you would only need to modify one place.
>=20
> This is a patch series. If the end result is going to be maxdepth 1,
> you shouldn't add a bunch of maxdepth 2 and then in the next patch make
> them all maxdepth 1 as the only change.

If you'd like to generate a patch series, you can refer to thoughtbot
blogpost at [1].

And you can also add cover letter by passing --cover-letter to
git-format-patch(1).

Thanks.

[1]: https://thoughtbot.com/blog/send-a-patch-to-someone-using-git-format-p=
atch

--=20
An old man doll... just what I always wanted! - Clara

--OR65uIcLb+LKpD3Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9JKogAKCRD2uYlJVVFO
o5CjAQCaV/dydXz3zK+4Z4t2QUeb1aEHk8WuYeajHfMSa1ZW7AD+IJLtw//3U6ew
YxBuPzBVu0EQlugaFb1r38CpHWVx8gA=
=pIVS
-----END PGP SIGNATURE-----

--OR65uIcLb+LKpD3Q--
