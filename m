Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80D221554
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881704; cv=none; b=iDxPeQ3c3PdKVpP1OWrAMRv4ELQ5wk2vcNgAaElF2lDYxahctLX+UDb7iWyElilZmSC6MxtG5NIx9iP70F1W8VNa8KaR8mVzwwnfC9yhMexIp17BtCE52VyIZwLJhencn7hiM2adljCFDNidnLBYCpab+T858fGoaoPX/rknKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881704; c=relaxed/simple;
	bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwjaoMtJ1NfvlGllL4Ibsr2ku2TanzJ/2ruYqpTuMPwiyc/EDdb53LvGqzTCdbKVtIA11HtfJY6vhBiaDZ/DA9/VzGzAC4YULd5Ax5hvKYdxmc5KjvJaAUG/VDdMCrwyVMcB2BnmLkAW4u+C0GzhNg3KUcceGN9UucrkN4eg9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7if866x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7if866x"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26c209802c0so67653185ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881702; x=1760486502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
        b=k7if866xlxBz3a2XY010yHHPwx70SFZzEx7M0Bb46aROqne5OMbPCUVzNk7HWnWloe
         3iyLSfNPvO+YrEvURbd+i25NvBWNmnwU7bkBQmtMxqj7wN7TNH0Yug7x6j1a+EitbLCZ
         T97ivJy7unowxzc4WY+MOEUOB7zXjEXqxd3K7EJlgRfWR8esxKblt+M2VMOPF0iDgr5d
         zwwLlf4und7btFi+evVnES+xwbOnWOk+EZHkT21fZF/PNGhbyMJ2g4gPPWpjfDIUFf6o
         l5HJd/CvKraAmeJAf7Lu5gfZ7MdczCz02sraYdHxgjAstIoqORlJDAw4zVqBycxrhlcW
         qsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881702; x=1760486502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
        b=t8+c/+mR8c3lnitPU4jRpG6Yh+jGW7zjYacaKlECffm2GkB8B5qp/im1hfuE2BY5af
         K2QyZbUTTRkNYp/uwBZgVgmNMjOV7LLhl5JXxu09GDuvSHMm98C9V7Br+okgrqoWxZdZ
         mm2jaWjj2sBngO7Ncwg4UWSAsjXK6v3crvv8M4ads+SLWY+9A32WnsTIzlZKnjoOdkCR
         5lKiBbMloGXPEabj5km88f/tvR1RKNjUfWRfHQEQ5aJWNjoHmxGqanurCfZibHVuhexP
         rbFS8RkY6kNtPiK4ptuCbbK/PAlMms01E4cwVvHKTbRGsmxNfai2zT4JQ6yS2boYYqX0
         yldw==
X-Gm-Message-State: AOJu0Yw6e4C1BqHx9gA2dYDR8O9FI7Lq8Xwfs0uDV4xmhBs+KeYejfgv
	cqMjRA7ierRf4chafa0vGw7XI5qIUhvEP0NlKlJpIKlcIZ67fzau+NZW
X-Gm-Gg: ASbGncuoD8mdku/5dD0jm0YpcTGaUrW5CXybBeaP8qn+i03EGK3yefAACUy8bc9+oc5
	M/rrfClhmDeIILIscYdTN5Wqc5MUuE2xMAXCks4ipvgDECNUpgCykf5OImm9VJSHTY5mo2GAmKT
	S6EwxzbI3sH0cZbIqGmtFWw9bza1jUNoHd73tV6xFtrF1g7bDby2Q3cfyo5jvH05qbstgHuUcYd
	sfqLpQ3COQGiBUBQweX7IJen6aXjIGgzqOD0CUg5itBMslFyDnlihfv57mzDo2qKM9O50EDKvIA
	8PL5RFITibXgKXUH0lYG3Z4pKVOvtEq2X6cmWjk0rC8Qcnt7YwB6yK5UpsB861Zif7clSyPMGaC
	JXHUKluzc3I1+sDskaZl4s9a19x/mPtu4mAMhCP51EjDtM1IewQ==
X-Google-Smtp-Source: AGHT+IHI6SipQj91c1vmLSFiOqIaOwefO3QQs9+bfgg/4mvECMIsZcVKX8SEp5HMEolcaTUK42Latw==
X-Received: by 2002:a17:902:e54a:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-2902741e857mr17501365ad.53.1759881702182;
        Tue, 07 Oct 2025 17:01:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ff9a8sm980371a91.8.2025.10.07.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:01:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 062764233430; Wed, 08 Oct 2025 07:01:37 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:01:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
Message-ID: <aOWp4RXBN2iayT-p@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-2-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPrGD7sryDE01aLw"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-2-krishnagopi487@gmail.com>


--bPrGD7sryDE01aLw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:50AM +0530, Gopi Krishna Menon wrote:
> common_appendix.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_appendix.rst to common_appendix.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--bPrGD7sryDE01aLw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWp4QAKCRD2uYlJVVFO
o4OOAP4uFuO1E6ytqdspEZ4WG7emXxflG1kNie6NJqWxpwX+MgD/T4akmHZvTpT/
XIrgErE+u7Ms0xsIdcYEKAqyV9wkKQ4=
=GCZL
-----END PGP SIGNATURE-----

--bPrGD7sryDE01aLw--
