Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A2AD04
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882248; cv=none; b=AOAMgEuULsr24BPygEs379xwG6dOjwLkZC132gBLBUqMpAYC7MIcanm0iejU+SR5sQZn6XRgu0GHJgrN3910ac5zztDmVZ4k2N7lWjJpRBIS7jcVN5xOesdAqWfD0hdNdM4kkGhW4qNTNU8n6tRGuuGsgMSwe1TbHjtXi8/cIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882248; c=relaxed/simple;
	bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlnqlcmB47EzplWEAR7OmaFSuIa4OMeXmexVj4kBrjbbxErsJ5CMmqMu2IMSEbgQIXOEHD8f/D3zjur54Qzx0xmJrhheaz7nv1qQPL86f5puF3txixJCZT66C1at4UdKhpg+eNkz1B5wlfb9XyDEv8DmuIOjGTPY3WxMgU2bu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a++kbnUX; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a++kbnUX"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b523fb676efso5746085a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882246; x=1760487046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
        b=a++kbnUXls80kZ7XDSqSEUInqPJigojDkH1eqmCqIJUWuypYFfVGtXW3ZHIJqZY7PA
         yOpKfzgrO0WU5YQeq4K/W3gytLpg8jEZogcysb3PMtSPPbusoZ+Jqr5GfWga0UMNXNWK
         ovWrlwzhkDxmo4Wek+3ivWsy18Vz2Hfw7k+ffmLaxFQ8zTZWFBthL8LkbVXcBOTs5aq8
         1OrXH3zDPEFn1R3tltilA45keyc9Cda+gYo8lp0blJBW18owJsjWoDqOKOgLWwh6pg0I
         GFmd49pmmdMoE/QcYASB/wHlo6WKu1jET9e1uxnBX8CxJWF8++6XclgbRvBPtOQYPSCN
         HDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882246; x=1760487046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DjQq9GiDEKkg86E8LlrByJSBd0L+Mv47bskd5ivaiE=;
        b=uAeKaYvcSnBY4vSDyfSdSqREwCD0K5zQtTZYrM3wGICrDE3OYGDcNNn9fyBWzc0Lic
         leAbwrG3p/aJNI1sEWjung9rH/OKrmJJCG5tHJ75qM/6px8FS51cQBXqP6OgCR34h9X1
         arVKBl13+yX1tdMHyzZvC3uEwOxKm+qosz1orslwAmIQSgsyA69x5vQL/aofPbeWCnBG
         eQumbYBb32lVChYPMl5N1MYJL0nVhofbID2Sj3IsxUU/ysJjFnwHGFF9J2Uxp37yQZOM
         CGQKZLNtwGjtbebNzgq1vrMx3bPlP9boU0quPRQzRQ4EZXnPQG2ZUyfVLBB0/uzQ0FYs
         DuMQ==
X-Gm-Message-State: AOJu0YzIRhCokJF7FwtxkOSsKBY3KsS6JP4gfxMMCCUdk0Rv//yOlTLG
	Y82kPFtGABd/0Z4QJBzSYrKeADuktheNShiN4t20AQO493LujmcYqtus
X-Gm-Gg: ASbGncu4oKOAF00SlrJiszetVLmbp2MvJBNJICa01MZF5Y6yrHNnGaycnCnIOuzJ5xH
	9x8exUBh0uFVSGCrNeCaDQAdJWvY8JT8d3bazCK9F9ZzAnX12yz4mj5p/5LSnSImQqqfA/T2sw9
	a0d0s72KbGJ7BF87UexdM0FD13Va2pDdaTLem1XEnOQ5rgFra+I5cdB1CAnsAQNtesW3bXmvleK
	2/7/PE/VCuIJOQ63I47Svtt/VMVPqQMRGjBriHIzJ6dH2KpE1CU7P48mOxu8PdoRG1HZaf4XCzc
	+Ec2kVlHpmNbyvoYq6HgnhORhS8ZSzHTM3TaMLOMM7s95FAgGBZKW/XHuI1bmQv/SqMuqUi/MPM
	laEoJgEdhIMdspBSDwAls31cwVYfbS5E/jWKv7tNJ06V+elB/2A==
X-Google-Smtp-Source: AGHT+IHgwCD+l9vU2RGoqSNi25s3Y73FXtbqCN1chUFkrAL5OHXH3HCXgZb11azdn0WBZQ2RZ5Ft7g==
X-Received: by 2002:a17:902:ea0d:b0:267:44e6:11b3 with SMTP id d9443c01a7336-2902737494amr19890155ad.45.1759882246372;
        Tue, 07 Oct 2025 17:10:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87acsm179342975ad.76.2025.10.07.17.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:10:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B28884233430; Wed, 08 Oct 2025 07:10:43 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:10:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 7/8] Documentation/rtla: rename common_top_options.rst
Message-ID: <aOWsA-HaX7A9Uqox@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-8-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xXfMCs0OD+RwnfE/"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-8-krishnagopi487@gmail.com>


--xXfMCs0OD+RwnfE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:56AM +0530, Gopi Krishna Menon wrote:
> common_top_options.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_top_options.rst to common_top_options.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xXfMCs0OD+RwnfE/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWsAwAKCRD2uYlJVVFO
o3/hAQCgsR/Awy30I6u1h473v37KycMP9YzYPoQLzG7GDP3h9wD/fINZ49mckUaV
QQJZIpiPaubn2Y1EnpJshktreCf2igo=
=4+9L
-----END PGP SIGNATURE-----

--xXfMCs0OD+RwnfE/--
