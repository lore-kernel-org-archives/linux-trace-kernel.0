Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D501D5AB9;
	Thu, 20 Feb 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021536; cv=none; b=pjKHzUvmmbISmEfzkhJm84pZSjU/uJQIAIpdWybbY2BrZrLvv14+fpqNO86FX0klH9T61+xvGGN3iAw6Zi1u61pdmDYShEO9yrVlycaO1WS+J/EwHka872zFpRwyqbIxfgQr+qjvgtmwiXesBxgQBFhL6JGN03K4+uFLpqOOJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021536; c=relaxed/simple;
	bh=xjrysQy4SMqexJaXH/JywgUVOOdsIMMo4pMZSdVGdLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEevvApkHOPhhSc/BtS8qo7gJBV+QZM2RS4PWVpuTMV5NlnPXodHNHlJlalOeFltcqMPPY6EqVkYBrc0TeTJ/dWOF5A5zdUbA7nhkqw8GkqMwvEWrgUWfWSrEBOAuS+fCYHOhlIbiLND9DjwSaqBQIx9Ulnd6dj9DBtrq6V03w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzybw0Nk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzybw0Nk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso953134a91.0;
        Wed, 19 Feb 2025 19:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740021534; x=1740626334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjrysQy4SMqexJaXH/JywgUVOOdsIMMo4pMZSdVGdLI=;
        b=Bzybw0NkQzOSgIKeVQ/ucuXKFT5OwAgwsKIxmboW7YHsMBGvKrcPWmSKr4OFsHZBYo
         2CTyFGl4rYih9fqpQ+ECoD7ke2FhY5laqJ46MiWnqFi4aDxpvuJYcTVA/uID+HQlLFls
         kOkP+ySNVm0Il09PgtMmLR45tt//++FJTrv+rHADFkP2LO/zAUvxyRRNzNzLexKs0+HP
         yFJoSoe+5nlQFmN86BAtwdqn7VksRMAxisdnLQfIVMjSFz3rKHuMIAmRZnfXTpVq4KxR
         KJhGVwPp4yQS7J8og/h3ywxMCdShYSNrm96FcXbz4YNOVchozDHiLWoiDRFD9LgI4dP7
         Lclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740021534; x=1740626334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjrysQy4SMqexJaXH/JywgUVOOdsIMMo4pMZSdVGdLI=;
        b=M/q55kfQzJ2aU2F2Bi5fP2dR9tsD88Yd944gpMRgDl4MWR7AygatONoN0Jjg27RVvw
         8HSK0pD8aXKb+pg271S5nJ2WG84eKcrTtXxZX69HSFHi/1r2EwhJcAk2ceHuDwtTh+1o
         aAozs8SK2o/O4xt1jnjhh8W2tm2hOiEb/ZP0dIENH8jM1ftBbwlt36DkS0AhRgzsMLXB
         h4mr5JXjCS8t5r1egmKULeg9GvrhEjc1+1LWwHvZgFjQahWfxn/yQeo5KvbkkoreXnil
         pk7wBnjojPRcwa8BKgiDWtSUW/713RpGlhU9vfaN497wVqI+Bj8dI1OuRNH+LADgBzHc
         Tzuw==
X-Forwarded-Encrypted: i=1; AJvYcCVfeirRFO4/cK10KQYENQBChfVSI9/U8db7U1Hr5G7fvmmzlgFV+elux2oLXaOfgR0Q739MKerTJQE=@vger.kernel.org, AJvYcCW8mnQ1p68LgGYLgcHruTGribFX48/FukbPVs5qEqxLfEcoxPHGzzVS+tnOQNP55rPmPRG6ZjuqA/kjlU1+r3fzqvOj@vger.kernel.org, AJvYcCWefo/19MElbkmwbcRxq6hQ2cn1POCmwhWo5+RJTlG9qDlkp3Jsrgp6ubdHBPPBAuReMl49Dc4dcgxsJKvm@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoBOyJ153wIp1jOWfHN+T1Si1C76geyZaTYBUNGFwFIOB2RMq
	G1C7zvGMBjlnY4PlpJ5tfFCdBA2ddZaqxPjS+BnNlJxfMx2/V2tWoKhkIw==
X-Gm-Gg: ASbGnctncTZ76+w39z4IDQnv0cmL2jTQoR29aqiu6nYsvRYafSN+yFLRH6wDqeZmPQS
	0h7UmxFMpTzo6advhtov2wtqeKM4sOQl7n27j2gmKu9+0otCooL6yxu0lTsND4HChDCR1FHdu6D
	Ji+ecmmpV1ntAY46FUMDrXn84X90p5yNWSIPo24hTvtWXrn/sO4VbAyR8u9h0zx3DJCnM7FOdgf
	KpfdUB9uwxnBWCdk1xS0by3VsTLX6bS4PE7zZQpT806f54VbjEtlkYfDvY0e71ys8kNQFSVBh0e
	XTV/azqZgH1zLzg=
X-Google-Smtp-Source: AGHT+IEJoBfsxRer9lbde6XgogooEbiO0GxRJ3kCGJXLsGzUbktCY3cqONbRUvBeih8D7ChBub6SSA==
X-Received: by 2002:a05:6a00:a15:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-7326179e95bmr31619829b3a.6.1740021534094;
        Wed, 19 Feb 2025 19:18:54 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73275615173sm7299638b3a.168.2025.02.19.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:18:53 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6BCD94208FB6; Thu, 20 Feb 2025 10:18:50 +0700 (WIB)
Date: Thu, 20 Feb 2025 10:18:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: tracing: Refactor index.rst documentation
Message-ID: <Z7afGvIggz4T8Edm@archie.me>
References: <20250217110637.6640-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fer2Llm/mlj0dA0W"
Content-Disposition: inline
In-Reply-To: <20250217110637.6640-1-purvayeshi550@gmail.com>


--fer2Llm/mlj0dA0W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 04:36:37PM +0530, Purva Yeshi wrote:
> Refactor Documentation/trace/index.rst to improve clarity, structure,
> and organization. Reformat sections and add appropriate headings for
> better readability.
>=20
> Improve section grouping and refine descriptions for better usability.
>=20

Aside of :maxdepth:, the change LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--fer2Llm/mlj0dA0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7afGgAKCRD2uYlJVVFO
o9nXAQDoKdSnI4quT+RsCT34BYvVReQJRh1lCgS32dg0ZtzlZAEAxsUs5m5N8RT7
DzyUBEO6MO2itjLkrKBbhTRgMBfubg0=
=ASIh
-----END PGP SIGNATURE-----

--fer2Llm/mlj0dA0W--
