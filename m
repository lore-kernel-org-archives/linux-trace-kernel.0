Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1781DED4C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882276; cv=none; b=jIxnkakUy0U6pgQlwtbAruq9As3ShrYdYEgYcRGy9j1RglOf6WPhrZ52jwSCFqjgkDHa7g6O5X1OVM8/mKRaS3bIabOTTclTCkEItfctpRE/UqS4uWnB7OSIMSTzBUQbA8j82Er3TUaJlXkNcPQ/DTUTbwTqrEr4iRdNdPLldwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882276; c=relaxed/simple;
	bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8jxnPJ3gnFCTdzizosUAYgxl0zbCehyMhqdjg/qe2mYHJp06WBct4nfaOKXXRY6YkHC1CmiAUQxI2CTffib1bzuUe2TUg3A+U9AlPbjf+Q1rt0xkIB5lWXPCZeJxbqDEmJBvanHj6kisx4ZzhAIaVFOirLuzHfyPfP898B3lzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqPvGvGf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPvGvGf"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so363805b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882274; x=1760487074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
        b=DqPvGvGfwdmRIVnyIqALBpWdX64FDmbXB7dT3Vav6Ml3duf8skiIYDkMDlC7nl+WRJ
         mEVcw5P+VN1nNPcT5drAD8DmGBW35eqfDgtUAXmwM1fqedmZZm4UxyyVYz0jYVRcS53X
         RmI25t1t+MfBDs5AH7eroLGROTC25KcAySjpnafYuZ8hDJ3AREQV1fwsarP92qKJHPrv
         CorwO1uDYwI+AMoSih6vs7e6fb8GNfYLsLtVLktjIWum5Faw/lStkM+ViB0B+OWNR5EX
         +YAOXLQjlgE3zDrSEmDDZRqXz5QOoIszog/mvw+UhTlFoTl3ogXu35YEj4sqsAGxQbUa
         RRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882274; x=1760487074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIJx91VEzutYWV6rmjWMuQo94kEzRhO28O6Sss2x0vY=;
        b=d5o54/rUZ+KFTkpGCbFLUjtqEDO9c/OVg5PXMsgqSmrHDbfH1oHky9LBJ02q4VslCt
         HSEG+QPKwJDaUdhK4ech3eFOOJrVLlupGwCFl/cQ9PYRIKRt71CdPhkSX09mexATokEG
         IvWOwPigxzepyL91ZYwy1xCKY/E48oHRooKmcY2q7uLyBa/96gFxVKg6M1W0YOUkK3Sg
         LfdPGcWs/KPMRmVBweDWMB/XeGky0u9hZmVtyvyhjRrv9cDYERLRfFdf9ELkcIVSoxB1
         2XOpX2FLwh/MQ/liIKfy0gu6U5VS3NavqKRnIH4z9NbSCZHjgNTkCz9GTLwQpH5+bKrR
         +QOQ==
X-Gm-Message-State: AOJu0YxJigDUKkd8+VhWXbq1xK1gy1gmZEN8SLtqYTYDKB13IVUMxI97
	QgKcyj0c6mHyFVlZ0TUNYm3ckmndumgrqjIESHnBdHJ5y4CKkJOL4dld
X-Gm-Gg: ASbGncscgoegODd0Ut+vNb6yHo0aahg1mssdyC5wzVZrTVJaFhjs3lVCx+eCnNiiztC
	QrKZbxjSOMUO/k0TkYefUq4cZVf9z+2gzTZQnHyYfHPc1Gb0YuDRe9KkR7Nw/WKDuyGdKW/HXPC
	oTcGMxlTmV0GB+twnZ39YRh9koLVkzMgROsbOR9BiR2GYTWJ1EjHCU0ErZ6cq8Xm7SmB6Iks15o
	X9R8YBm9gihO9GIgFrzFHYvt8WbztKUYGqgGdYPLznJoS1zmdQRd81LxV5Ved0y4a4MmxbbI/G2
	iRitDQbwGy2HkmRpB0ClEz+Eolvrmng99PpIlAMmBJPIFGnMvmota37jofNOnssae0Q09BoG/NZ
	uvg0P8P/BS9AI8HpnYN2uEQFdkO4PsW/E60AMR3zvuHNdGygz9w==
X-Google-Smtp-Source: AGHT+IFW3sow5y/lVKkATKYFm04W7RgDI6fSuHLvh6sjhQYKQ7ak+ZYw+RTchKbkNXukK9zwt+mgiA==
X-Received: by 2002:a05:6a20:3d1c:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-32da8df23aemr1423045637.6.1759882274312;
        Tue, 07 Oct 2025 17:11:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dcb3sm16910186b3a.11.2025.10.07.17.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:11:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A0A074233430; Wed, 08 Oct 2025 07:11:11 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:11:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 8/8] Documentation/rtla: rename common_osnoise_options.rst
Message-ID: <aOWsH5Lgra60g9-k@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-9-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+2lsue7TXY5gcQ4"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-9-krishnagopi487@gmail.com>


--W+2lsue7TXY5gcQ4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:57AM +0530, Gopi Krishna Menon wrote:
> common_osnoise_options.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_osnoise_options.rst to common_osnoise_options.txt to
> maintain consistency with other common_*.txt files and prevent Sphinx
> from building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--W+2lsue7TXY5gcQ4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWsHwAKCRD2uYlJVVFO
o7BjAQDfo1t5Lr12kg1pMMFioSkS+Xkr4egh4nTgsiztQ9ybyAEAnvnzwOgWbSWl
t5mwwHHqH9/4f2X5NKq6K97vtzUEKAU=
=VmlC
-----END PGP SIGNATURE-----

--W+2lsue7TXY5gcQ4--
