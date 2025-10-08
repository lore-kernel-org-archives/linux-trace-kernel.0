Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CF34BA2D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882034; cv=none; b=motecJKLgtvJMMEf1ubfa2eUGiiBJfES4/D82QnHWUt79mElhunEOL3GjLhY8+c0/+NlCUZk13tpFJ9Uq3ZS9VCsVGnqWQH2QMfupFDnB4SdUn8Rmil9diS7bbrLws8CRFaH/zGvnJoGByAn900bOvppRDVGT/D9IX3s/SGAy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882034; c=relaxed/simple;
	bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWWeQEiX+K/kgsP1lxRrId8A4n46GR0RmKNxso+UzSJ7ByoDTj9FWXyfaoCNC3CxvRBRDUJKvnqfpHAFyWXb0xP8UXlKXXT3xV8Ofmrkn9NRb3BnHT832jZUuIAFEc4f+iODWr8zvzbIm0RdHuADDCceQzxzDiIr1ckGGZlkzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq3YzqhF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq3YzqhF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781db5068b8so5730454b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882031; x=1760486831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
        b=Pq3YzqhFrWQhgS8sBvscxPq4JRDaw9JfdcZRYivF9acsS1Q9pyXtRGgrRfcpJBahTv
         LL5TKM2sp5WfdL3XvY17I+jrWlsskBzdrO7PPXN4ceuwZ1dUd8ftlCY7UGNeiX0TREWV
         dSkLAuJspqpd2mO20l2nyhO/9ovPItTwNpj2K5H3/B+OcbFB6B98NBlBGWOFb5GFjWLl
         vXDPAUT/rR4srMKv2MKe22sfEXuQkgVWXF+GNuChdjxZgjc4Vx8TtJ+BKRVvndCxyz7M
         ubVSDLagaFX0gXAf3fXLgD0PLWfHgszehyRSdV5QBihebyzK+Xs371EXE9f2a3RBBK0g
         ahuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882031; x=1760486831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC8ooiip9yJoKnRrYy59NMGAT5KdgSyvEGK3SSFeUbc=;
        b=ufPejYISEqJePX3qnzWRhj15YSkgjCpKOiWCkzLoGxo3Yt088Qvj9c21wx+e0xQXnh
         bQ1q3zdJRvfSjFBzdGHBR5ZFhI1y+GJuIzSUiXwbUbhMdTV26OiteHAhMTF4jXFwAHDM
         YNj617wt+rs2CJwU4G8Ox39fimbOjlrQKVxDgb3sHXJnlNNPokqtEN2cseyB/Iq6p15W
         8Wp7On/QKtW6vWdLy+miMaBNFZXP2cuV9V0wE/NTM/bBAtQB456RozUFNRtPInTtlR5i
         Y4211ZT8dzCj5WIMTe7Q0PcNUyG/AzDph6Cdake3qFY+XXMphCvjFWltRaconGNeUgqN
         kgtA==
X-Gm-Message-State: AOJu0Yx5SAZmnfRP13rdgPb8YY4GuWyMCzjCxzvpRrxngMwpnGb2OWzz
	ekPJ6ax63f7Kvm5iLINOcPDxcR/ScDZkgo+EmnzDEDLCoGleI46dX5d9
X-Gm-Gg: ASbGncsNpy0kffA8ZO9CF6q0SKJC53S0CerpEvOQ4Asn4+kAWyD+lkcpyVH4EmU714Q
	sP5RXnT5kdbqERlpKLRdB6HzBY3Mdwwl5UjouYWu2TU0V7IPBxSWI6UwhbM55JQcP72JnPru+DI
	q8L9e1RxDbBQ7nKLQgo0L2GD2jlEXDIA59mD1H3LodTuzL74RXlRzhD+HQp6qhoij9QrJslbE3W
	gQZ6ZOFuKG7wlv9YcxT4zqQhMziO6L5XFQcyqr39kQISPsQ9r/mWUCGLL7/A7vqgnsjMLZanEAd
	u3e/Ypo6pglNsZSQOZMpME/S6QrekyPVW6aSlcrgJ/tP8BkrSS0BwybwSg5UeRWpnfL6thf1T10
	Y3D9O5j/WnQmmq9DaWnryycgRQ5u4VwXGKsCkqGXjbe1U6hwVww==
X-Google-Smtp-Source: AGHT+IFc8t5RIReyxhe/YhSffa5uXVtkzd3/79NpH3j4fjj8RiMnktaajaSJ8gcmock1LzX66HbTfg==
X-Received: by 2002:a05:6a00:17a5:b0:78c:99a8:d294 with SMTP id d2e1a72fcca58-79382c6bb87mr1630730b3a.0.1759882030944;
        Tue, 07 Oct 2025 17:07:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537d2sm16845105b3a.58.2025.10.07.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:07:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 50F3C4233430; Wed, 08 Oct 2025 07:07:07 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:07:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 2/8] Documentation/rtla: rename common_hist_options.rst
Message-ID: <aOWrK-vPQaqbgUAH@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B//GlOCCMvZhY8mv"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-3-krishnagopi487@gmail.com>


--B//GlOCCMvZhY8mv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:51AM +0530, Gopi Krishna Menon wrote:
> common_hist_options.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_hist_options.rst to common_hist_options.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--B//GlOCCMvZhY8mv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrKwAKCRD2uYlJVVFO
oy9ZAQDYJV6qE/AzMUzQwGGq8HBR5bcwCtyChfYiU9bhnHMyLgD/bkifhp6WZd4p
YPpU7zjarwlFUjfFPhgF7OOFDRTrkAk=
=kSCJ
-----END PGP SIGNATURE-----

--B//GlOCCMvZhY8mv--
