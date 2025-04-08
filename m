Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8E25F78C;
	Tue,  8 Apr 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073738; cv=none; b=d4u/Ld/825u/ZP7HCeYAtu9Tx8lpgzuVPTZNf5gWXkqNUfQ+hSZHEtgoKrtQVeJB8JaK9rVd+i3yJdigbQcNkK8JmeNtYB0NP0cI+mZJ5wOHn4YrM0g1uj3EMlsb0oqfQv/buBzUZ6NnROw+sKXhIkZiRorW5rvCzXdIHieMVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073738; c=relaxed/simple;
	bh=Yrn+F4gkavee79k5sj+XAefUc0dwD5+qTayzy9SZ/O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6jVmSmr5WSA354DePkUh9xo7XX2qMcG9e6dEWIlHh0EtqoyfzRbl3vk3GepSaZogfKAtF9LkAA0zeQFOxUuMD58ePH/KZbTKiHRTzJbuIkD2ZO+v4UNAMpNdqCuQ9VoBwCmBuzURSDLgIIJCD902UOFakZa46WK1utgVogsmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmAA/4Vr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmAA/4Vr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b433so47249845ad.2;
        Mon, 07 Apr 2025 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744073736; x=1744678536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrn+F4gkavee79k5sj+XAefUc0dwD5+qTayzy9SZ/O8=;
        b=CmAA/4VrYQX0sAu0SOH2NfkBxArNSf6eYGb3JU3m7laIoeTrnSMifx/mFZjKW/g/W8
         JThWKwD0Npi43OfVi5hYTCFxqcU3qgFIrtsTBEFWGjwtFvVcy9cOuCGrLT2wSlbaNTS5
         vDi7d8txA1elWNIy8qrjpkFGaAZsugUBCZuv/iHHtB3g5O9CA+1+bywXQFfYZDaO4o3h
         k5TWuyIdsQDQ2HC3Uw1CtEPuCX6AlK63K5+AKSDTMcGSo+Qxnh1u8Of5yfpCyhgQJyPn
         bbmyKIfmRvOOxQSXN+qgsIGOiN5LkOzOGgSi7R3NVQqdWNCkoZS2t/GV5jT7ZDWkFfSm
         /3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744073736; x=1744678536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrn+F4gkavee79k5sj+XAefUc0dwD5+qTayzy9SZ/O8=;
        b=ubcWR/g0eKw2WLzCbOvQdHQ2JhIVuH2tEVIEoql7atAf4IglVM/dRSzJqPrHUw9Ba3
         DEgJU9zljlIfrY/fDaNlC08WpFgDQ5FhFkuTJyrERKnFsUv9reDhjyaAjwll8+qxp7HA
         yLNoBRN+Gln7SZcHrO3cP+SnpPe6KzKaPXuGCBJ/JoLD20yREfJUovWKgBiB4l/mPbTr
         pDZA/1PGlv0V+WkMdnfwXMSsufW/mCG/p8LiU8Uqlase/smaOjsmDAtvaSBB/0cBQ8Iz
         MBTVBiS/8aUwRA1ZU3/9jLWhMlnql5MlTQiIpoeHGnLFoXxjz7iLaafYrZ4c5Yn+RAzD
         IXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUHmlZTX38z2dzSgtiRsX2uc8e6wmtMp7+amCLEKfiAGuTmfoowIEwzwPY0knEP9pKgvj/pprQEVmX2J2qI@vger.kernel.org, AJvYcCW0rL3PEAzthFn37ytn7n5kAB9a6gCtVI8r9bQgoAQvqcGV/+bUlWxIRmlbfbiXxAtIeKMzmSaCi9E=@vger.kernel.org, AJvYcCWvytjvd4wzMr+Xd+4ckli0cVJ2z2crdLlG3nnsr7oDdNP14mQ+VF+EMsU7TIdo9t0G63wKSLVDHyrielRLyuNgc1Af@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8svUpmvLY7zLqim5fnxpC0djMsmbIqRSc/vDZP8x/nlnFSGK0
	CPXPthACdF+LdSEFreDTh6thaQ6FxmJQCbmCmXYXXBu949iSigZf3XsY2g==
X-Gm-Gg: ASbGncudjZygh5PoHDa8TQk9RJpcUwGwcIkba5/YMcxVJpF4g6ivaGjoEbRu43y3XPl
	2/wYf97uPAVCweBNlNDKADb1F1qK388eJePrSs7wPUl5yDI79Qs4S84tUDFO7hX0upFGDeYxf0C
	7luL0+7WXRFYzBKibrpAwK7Su5XWCMKQEIJb1RUHXpVziPYxrF1y9anjyCs7WY2+E1+R8nm4z0j
	qItDsf7mQcpoN4+h9viwFTL233NRTDS/rT97B4ucbVkEl74YC6waHLluYel7Cu3vII5snSmdxoF
	7PKVe30Bc2y06pqeQlvUJEaAYY6iKGQw8r48tHrAo/XC
X-Google-Smtp-Source: AGHT+IHFNncfVvM01qF9QOuw/9iQjTqaaKeztLYsvBrrjmKV2un7O54E6L8ET8/5h1hTByzWg07nyQ==
X-Received: by 2002:a17:902:ea0d:b0:223:628c:199 with SMTP id d9443c01a7336-22a8a0b4154mr169169355ad.52.1744073735710;
        Mon, 07 Apr 2025 17:55:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978776a2fsm87625365ad.253.2025.04.07.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 17:55:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DD359420A696; Tue, 08 Apr 2025 07:55:32 +0700 (WIB)
Date: Tue, 8 Apr 2025 07:55:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Purva Yeshi <purvayeshi550@gmail.com>, corbet@lwn.net
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] docs: tracing: Refactor index.rst for clarity
Message-ID: <Z_R0BEVn0eFpmWEA@archie.me>
References: <20250318113230.24950-1-purvayeshi550@gmail.com>
 <20250318113230.24950-2-purvayeshi550@gmail.com>
 <20250321102507.6f02060d@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ScWWEJjtWDu8/daV"
Content-Disposition: inline
In-Reply-To: <20250321102507.6f02060d@batman.local.home>


--ScWWEJjtWDu8/daV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:25:07AM -0400, Steven Rostedt wrote:
> Jon,
>=20
> Feel free to apply these to your tree.

Hi Jon,

It seems like this series didn't make it to 6.15 merge window. What about
applying it on current cycle (for 6.16) instead? Or should I carry and resu=
bmit
it?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ScWWEJjtWDu8/daV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/R0BAAKCRD2uYlJVVFO
oyeWAP9Eb3KivZiYcAClWbNsDJU8025YFLY61m0OgcdhU5N+pgEAt8vMq7N4QMKT
L6I1mn2U1Jjhcplh+29aJaan7QJvMQ4=
=liO0
-----END PGP SIGNATURE-----

--ScWWEJjtWDu8/daV--
