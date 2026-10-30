Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355174;
	b=ZoiaHpJbBpc46+uz3Ei34AM8GyzUCyQURnSQLaD/nMlP970n0Xlnuf3rJV9DLVmInSyo
	 J1jpmB9l2sH6+HK00vUrGkfkbnwYI8stRQV7j56IxyPQjvte3mqGc/tov/gIOvNwKTLpG
	 tmCIyu4vNYIJ8EjZ3oiSTAJ4GrA5w0DVQ1T2wqTX7CnST+JOz0/CGcmhomnFHPUkBHidF
	 JOA1+CxYT40KiL2Z+Hkej1rg6GnFMkgQsI1oJ4qZTZiaT0y78/zfdc+35X9TSWYu5JIuZ
	 96LnuwBbq78c/ugMJDzL6LFneWLao2bmbBcVhg1XP6l/Rx6yLjMHKk0+FOb0ngu+O3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4tYDtJid68SRru4uZjKZRvvAoXLCMBoY5roZrQvhHKY=;
	b=a/4wdETaObDgpqC8mTK4V5aTsOsght+tNHKGMRWG8SEhQtWiUpsXoGF84jRZwD+XjlUv
	 FF6dYVduuKtr3b1bOK0+KlP/Oez1aJWM6/F3J9zFkbS5Y1/F7giO64db7/RcS66m07KXy
	 n3JcyXyOLamiwn6OramsywFrRJrtL8RJNGtniZHcPjEF2u5PIJjr1iMRT3L9KVNrjMmkc
	 EL9aEls6iXsANjZzHl6mW9+ZJ7ZwcJI8Vabl73f0b3jXYQt1lvElzgB11bBAxFtc7po0d
	 45by9Vx4OAzLfKZwrV0rD33GjRbjK4bM0+nfkFKGQhnk0YnKR9uLLc6L/48X6cBsm7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VLkYoMCu;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A203606A31A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 10:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A203606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VLkYoMCu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so2303485e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793355171; x=1793959971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4tYDtJid68SRru4uZjKZRvvAoXLCMBoY5roZrQvhHKY=;
        b=VLkYoMCugVUFenq+N50Skcr47KLkpmh/XKhR+/YIdlcV+8nrK4xSn2IfwxtJjpZVpZ
         AWy+p2R1G+kEgehnqBdtlxIaJxppJQk4QfNTPyWMP8US10mnrNkoP66juo8K87JxLqSf
         AMN3cDf0R8O3jF+/1NTYIGM3PWvXVCnarI9bPo5Iw0NoerSfSJ1un7zvpuZgn7eNxlgs
         WzlPdchqPfddqkhafYPyWA3PrSveMuK90Vuo3+/i/zmSyKI/+D3ZCs5vIGrtyz40gZd5
         o7TXCCkXBG6ol77zUzCYYBFH29mlsO3N0g8neiPesRRdAl1NVSKyZBnllJvlIbmHf6nZ
         UeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355171; x=1793959971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tYDtJid68SRru4uZjKZRvvAoXLCMBoY5roZrQvhHKY=;
        b=pjFt0m/UfqXKadmXQhD78v5uX+PIyLt7SbuN7gGdOYtZ9CzdiTvuvoqXl1qfWCcNNG
         Q6KsmE6vuoakX0JCv2GlUJO9CxCzQEB/PSS7ylRnLxwemerSufphgkjqBeXTRLdE9Bd4
         MTxqGcnG9QwHYD1XWWW/7MKn/+DUjRBo77eCYFfohjgmVFKScB5wWKwJLWfJrxE0t/4n
         Vt1G9S7zXezkqQCC0tFTFkFbZUp7Wqevl4cSeWbRJR1FCb7QxD1TBczR0qEJg/StSSTf
         WhKzQmoIaPIdAwN1E8LD+Sixn6+3TypFOaS+YJyX7KFHshv/2KSX8awCzMAaoJ2Guvh9
         /8Yw==
X-Forwarded-Encrypted: i=1; AKwUvBz7QmK5icpQiR6upyOTsrBqGDCA4Zvg9Eear+5Gv07kEUHnD5eTTJXzDmA6uCzMtT5XaSJJD1MQq8PsIYl8y3R9K6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3q6oBPMgF4/iBbIjnfOFbpNkmrQhzNiHrxGZZQK6yOWyo3h3C
	R0jfWY1H7GAJwCQaaZ7rL0VkHc6GpwcjKDHnIzdAnljZWCO3X2JO2oJfRTGRyZq2Y+M=
X-Gm-Gg: AYBFou0Wjl2q1Liy6QSFIhdluV66q/o5PevD++qxXdAVSuX8o9Wxy3y1TOJvQdGBARE
	T3kA4WKIVTA0cjTgCt3TKcxr1sIdQJf5mPoQqVUyeAlrA5VaO3CoPednFc/oLsK4h9cVWofZau2
	tl992GbliNrG4YCDNk+kDZ5KIlRKe0r8Pg0MEnlMVp5JhWPc1XTv+jQVQiMgQEfkrQZMgkkIfOV
	ohVVZgWXytOOXBrPAP7lI0on9iEyo3m/DgI07vB1vVhBuPhpPDgsrzpU00XKw3sleBsxaMePeRl
	2DW4ZqwP+3Clbyk7eVsJDhUajFkDOceebYo2yRRyZhzVwyOj01yglSESNg4HSDVB/iByGWZ+zfy
	AXsR49Lg/rD/2INLnUQrcvGlc/UZobol+VTwCRJVmdHv+SpYfHSLyw6c6ciN3NNLpszPxM88GgB
	25kg810RpbZ1vjwNUNq8lAd9i9L4caM+y14dxQElv7f/u3maA7KTjOW3sJoEf4uCUeEn3p5qhKJ
	ccDjdvNqTBtfQHP5UkHYTf+J53HgR4Q6RPCpvrH1+nz5NCvwUramdwt+KATnc6c7wuCBdI4sfBF
	Zf0ayJ4SZL0Lh5XPm4Av9jQgjJzToQHTqKB/NcZOEigpaNmIttgoa8QSK1Lk3s+e4S7ncNAAlDM
	VF5XcnpkxkBBRyU5h
X-Received: by 2002:a05:600c:3f06:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4ac181e75c2mr35620425e9.13.1793355171498;
        Fri, 30 Oct 2026 03:12:51 -0700 (PDT)
Received: from localhost (p200300f65f19a904f4ce339f1421d16f.dip0.t-ipconnect.de. [2003:f6:5f19:a904:f4ce:339f:1421:d16f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4abf5b27e46sm80092625e9.3.2026.10.30.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:12:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:12:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Michal Pecio <michal.pecio@gmail.com>
Subject: Re: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
Message-ID: <auRs-6y8ox4EWDcS@monoceros>
References: <20261028-bind_taint-revert-v1-1-7c6b9cef30c9@linuxfoundation.org>
 <auODHyLrfQylISX2@monoceros>
 <DMHL9O0EWLKU.3F47YHYEGNURK@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3i3dqzye2ignvny"
Content-Disposition: inline
In-Reply-To: <DMHL9O0EWLKU.3F47YHYEGNURK@kernel.org>


--p3i3dqzye2ignvny
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
MIME-Version: 1.0

Hello Danilo,

On Thu, Oct 29, 2026 at 09:02:35PM +0100, Danilo Krummrich wrote:
> On Thu Oct 29, 2026 at 6:39 PM CET, Uwe Kleine-K=F6nig wrote:
> > It's not part of commit fcbfaffee51a452cc8efcbaa3b88ec4595678424, but
> > conceptually we need=20
> >
> > diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentat=
ion/admin-guide/tainted-kernels.rst
> > index 3d312bc17942..fcb8b9734548 100644
> > --- a/Documentation/admin-guide/tainted-kernels.rst
> > +++ b/Documentation/admin-guide/tainted-kernels.rst
> > @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that t=
o the aforementioned
> >  script, but if you need something quick you can use this shell command=
 to check
> >  which bits are set::
> > =20
> > -	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)=
>>$i&1));done
> > +	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)=
>>$i&1));done
> > =20
> >  Table for decoding tainted state
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > in this change which was fixed in commit f1850e443b0e ("docs:
> > admin-guide: Handle TAINT_FORCED_BIND when parsing
> > /proc/sys/kernel/tainted"), but that commit shouldn't be reverted as it
> > contains a simplification that we should keep.
>=20
> Fixed it up, thanks!

Thanks. Looking at a287f97d4256b5f5527f5b5a54f8ada55e1482c7:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

(just in case you're still willing to rewrite the commit for adding
that).

Best regards
Uwe

--p3i3dqzye2ignvny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrkbZ4ACgkQj4D7WH0S
/k5H6QgAjdChEcwuB16UGAH94yVcVY96eqaJTIs2lSSXrN5mF/j8+wojtf6d88zs
DBUdsIkALsB6jIBpNQ6JVgKn85jEDmiUoaOryV/lU68VYYkeS/s7FVQFvj8YEef9
iOdBZr5OwsHxvvrecVFcd1psXr8oXFYra6CYHs8Z0Cv5JXqt3DLxWjLtAgc0TVTj
hPLgALy7vx5AGw5S+Al5GMGlvCDk1ZgDTtxIWx4CUWAEPXMMwXVe0GO+0LHSqam6
/oVmyhz56OyzkBvx1Y71mPtZ1CMB8jSWENEn7ouZN0clusKo8yTdsCBwCMnNDJR7
6T5dYqDGih58q0J2wYKJqB06kpwLlw==
=ViXi
-----END PGP SIGNATURE-----

--p3i3dqzye2ignvny--
