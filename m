Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C72DF3FD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841487; cv=none; b=JmCffzUxWsYvtKuOjNh4+AcWl1CdKT1BrDWt4MH9rlCTFFiP1eFcwDVddYWNbBQ2H/d/VAuxb7ga5bVueUPtwESlqDoS+gi3R6GZD/2nuvHcKGcDDC9XPCkXLgwlLNF/ro+Op4EkE5oaXS8A7qteWTdLb2lA505BjMggD/nTMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841487; c=relaxed/simple;
	bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHZBH1mYVX0nRsITJUY1ifyIFbZgerP3dsXGqwu58b5J19AUVnBo0vHC3PgyQmfqrryXSLxvvrAuPl+4YNkwKc0bRweNM2gwn0dgfNxGsY4cU+0+C57hwGCdgLpwOXoEFvI1SdB2wVQ5/bAhN8+1CRgvwmZodUYXjERLPy2HQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj/LfUBT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj/LfUBT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28e7cd34047so52130485ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841485; x=1760446285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
        b=Oj/LfUBTKsgzoVoXOkEUIsvOmfq687BCB/dCoQn1tFxHBK+IrXkIf3oBm26//bDOCP
         O27Usl0eynLvoWBNFeLaFTMcyd6V1Zcs3LG6UB2kV5QGZUzo3IccwYjH3BfvX62uogz2
         crHnP9z75KnpoB4lv3e0JLoLHxKG1ojqVbAvlIZZas0l86j3wLvFhnd69IpCMXOBTeTK
         msJ+6j1K8Tsbug34YWAgLblZa9jdkOpqV3pOiUI10uNVOTpvHWEZh8nd4v0NeGtwa9vy
         0yQcKODNJRws3SEDyKaDAhNq5HX6rYeGEA9XHm2b1ix6g/gHTq2goqjAj/ly59utH/WD
         i0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841485; x=1760446285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
        b=VuqJafJPKafDelSQv4/YjopEySabDNCrb5AXWYoHzXOh6ABlhmYBNSwwf2pF/t3mHE
         MlnDnr7vno4qYJpoELrc5deVQXCtAF6hL8RGQDFYwLQph0WayhOWdjSx3WpEj+y0EA7f
         nw88M2MscDT3ZgEnY2DDYPL7ZCZEICq29yK+rqDLZT/H76mXj5QFlAJ/Cp6rbZSyy4VU
         8tbpLDWStTN21ZbCcb0B81YrCabJgrLoSoMlMFnVAAFVY7b6GhSkfeNHf6UrejzNr5Gc
         8oWRypA7XK3oqaqOgm1YI7isY3qzVYW+7TzOewyVqeP93gEfUFgoVEzrCaCFeOZSRL34
         e57g==
X-Gm-Message-State: AOJu0YyPYpTcXYPe/AoQZAojHMLWv7RKzJ7XzPPkeoLZgRTZvdd5mydU
	Y7oO8F2tetnQeNaDZnADJKDRhenapSBiPY0jJJk+PFooHtAvh5zxk7xp
X-Gm-Gg: ASbGnctqxnl7AwrAW2IcInY8umEX8wYkViozYC6s3/t5ndiDaFQTIBy7fibJGLzgA12
	A4fxdlhpLtNscyka9PIrgV7tVTOa+L6MGiQdY0RgO4Y3GDJItz9Ui/IwvFbXhCpKTVptS9ONa3+
	scDMisHQBA2wAql2xQBD/GdOqz/Lwx0uD/1rJJN+WmxNmGY9NpKT/qWcVKlYGSug2CYyIsn/qov
	9Rj5sT/LFd0WCaJiXJf8iql0fXMUm+WV704e7WAxIajQmza30HlkV1qCMWqxcQe616BwLvtRtOe
	SqDq2jU+cruHtWYka+MVBTBmVmz0MaUXMazdCmaXLhl5uGT+P2ihYd0ZhWhPbRjmPzM2IRAM1MD
	oRoGb424geBoYhOGE7J3Qlj3/vqLEZsUrFw1t4Vu+5YOmdcgN+Q==
X-Google-Smtp-Source: AGHT+IFTrYmtFtu6V1DCF12R/dF1cAY3Dw1DuL07n3gmGJkW3ViP+is1CMwAjywaqv3EDHY01fPzPw==
X-Received: by 2002:a17:903:4b08:b0:27e:f06b:ae43 with SMTP id d9443c01a7336-28e9a649321mr194985855ad.53.1759841484702;
        Tue, 07 Oct 2025 05:51:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm164605965ad.36.2025.10.07.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:51:23 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6C85F4233431; Tue, 07 Oct 2025 19:51:20 +0700 (WIB)
Date: Tue, 7 Oct 2025 19:51:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Crystal Wood <crwood@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: fix htmldocs build error by renaming
 common_options.rst
Message-ID: <aOUMyGvkibvOV0IS@archie.me>
References: <20251007083228.17319-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqWyVnMMiWmFfUQE"
Content-Disposition: inline
In-Reply-To: <20251007083228.17319-1-krishnagopi487@gmail.com>


--aqWyVnMMiWmFfUQE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:02:26PM +0530, Gopi Krishna Menon wrote:
> Running "make htmldocs" generates the following build errors for
> common_options.rst
>=20
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitu=
tion referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitu=
tion referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substit=
ution referenced: "tool".
>=20
> common_options.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document. It contains
> substitutions that are only resolved by other documents, so building it
> independently results in 'undefined substitution referenced' errors.
>=20
> Rename common_options.rst to common_options.txt to prevent Sphinx from
> building it as a standalone document and update the include references
> accordingly.

Fixes: 05b7e10687c6 ("tools/rtla: Add remaining support for osnoise actions=
")

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--aqWyVnMMiWmFfUQE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOUMxAAKCRD2uYlJVVFO
o3YeAP9WdHh/AKliEi1H/a68qdAmPGP1E8E/I+1Uax3Rh/iTnAEAtEZNoEUlrDTD
kmIkMjKutwIPwYQG3Yr/miznYMlg1gQ=
=R3wE
-----END PGP SIGNATURE-----

--aqWyVnMMiWmFfUQE--
