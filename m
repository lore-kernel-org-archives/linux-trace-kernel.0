Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2731426C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882069; cv=none; b=tLE5R2BIo8kziO7U3aZ5NF8DUJoAltpoNdCL4ziaMDnNYFC7doPm0quFzrd2HUHXPS/soKjhWrPhIXJ787YOx/KU5hwsY0JIcTl8nTtlHHYP5Y8pbEzG2tOZK09nT0Wtm6EqCy45YqtseKDOQ1ibF96QiQLnCwynsVBABHjLZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882069; c=relaxed/simple;
	bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQZg69TTMXfGiGlwDTLVrktBk+Yz/rbZLMWPrW1L8HQZlFOkdE650WEg3++7wg50T8etePTLrPu6U4LDsBzSbAV8NHMvS+RIoBdmX5Dy/0KVe0SZHel7wVmjGBrVykCMYGUhO/5PNe5HQ6NJG12PVZBMZQctFXec4BjjwAQJg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOi0Bqlm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOi0Bqlm"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so4224926a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882067; x=1760486867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
        b=eOi0BqlmjnkjpLi/J9aJ/pQHE0cLgHvakbsgbEuQykHg3WX5c1DR9lR9GZqJWid9Sm
         MZhx1AAYqKDTwJyfUPnO1JjLsAX4biK3yHwglKCCgDhujg/eZiTN6MVBrcG9Hzp3LBYW
         9IkYUaarQbtwPaLjueK2MjE2i2qKyveVDNDxeZOMTKRkjbAV/Tqn4e/LU/PEPETgFBUj
         PVS3H9dhVhTd8pzlM9aiOYEBtMm0hesmjXzdslCeYhety78qWJUbubSyab9flXvVISju
         2Sa5FdquNXcVxUWQZb29afckAdkxCWHQ85r9dWs6Cfibm4TcKwOn9v6y1j+DRtbXfJyG
         JAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882067; x=1760486867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
        b=ZYx5H2+dnL0auYB30AWJTbpWZwd/pADVtihJLIJOlOwaGvHUfIhPEEWuCRAjW1uAh7
         tvGpQSEWv5z7Mh3p2+ff3GNdyogyUAUrEBq9ITcLftkkl/PV6hxwq2RyoMKyZm50RtdX
         J4SCM3SgQl1/MM7b38vdLCpalHb5t6y5p9wcbv+ZPvKk7shadFxq7gH1eFmEN2MEbbwZ
         qfBoIERLsrXC4p6BOa+OCVQVqzb/F3gbLgMVvxt11cpHZ6JwVl1+TNiUm2L520AM6pOZ
         jNESIeKoIQ9tDJfAO6qVj+BeXyC7sIN9/u1xKNxls34GV/QydHN9VYvB/EnOuldu8I01
         r8Pw==
X-Gm-Message-State: AOJu0YwjiX0NsWmjneQn1DnoTHO5Z3+shN4KxpQe82deR3rMZ+t+IVk+
	aC1/re86MvX5cyD+/91VhNbrQWNTNfVzODWU4LjIWFoYV5j3YYqS0stL
X-Gm-Gg: ASbGncto4RZB9Ns8xkepLzE/OcYbUEGW0bYKztAhaJ1OQG9XfzSbgrUuEuf/DT09yQd
	Wn3jdJGfZKJioorrgAtjqxYA6aXFPFTGb5Z7aDpYmzbWuDHuMLhq4tr67JCiXsw7dNAR1DGGTZP
	3SjOWcVJJrNOeffR1bo4PeEggkDt2nQ7RARSiP+h+iWDOWXk1pPnoim/nTGpxUu8xtuJTKMHwI1
	QWcbutLrGgxyuLhc2AilUc3M3X+zhcz3XUFKYBHG98/vHNUrQgm5tqMclRNWoPnmMaqwGxSsDy1
	k5FrPhZONauH9AJCvbtXFDJlDBG5fhcidCBwwwTyyLrcB+weIhKc0uhuUXnX6gJDhzKKHoCn5nH
	5EL560kw4vqVLCoPHHhB5oW/4u3gZYzydHPHOiNqHVoXryd3DyA==
X-Google-Smtp-Source: AGHT+IFvLrrTtLYc/WdPj/MLYULIodTkELvA/9nEoTpJDQVKXDnFiVL5AgqY4kmgosIYn/DoCBNTOg==
X-Received: by 2002:a17:902:e550:b0:268:15f:8358 with SMTP id d9443c01a7336-29027402ca0mr18266115ad.42.1759882066181;
        Tue, 07 Oct 2025 17:07:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28ea1d99ab1sm140124385ad.9.2025.10.07.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:07:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 262AE4233430; Wed, 08 Oct 2025 07:07:43 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:07:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 3/8] Documentation/rtla: rename
 common_osnoise_description.rst
Message-ID: <aOWrT79N-Pavz-6z@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-4-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v16T4K3LqUohqyO6"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-4-krishnagopi487@gmail.com>


--v16T4K3LqUohqyO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:52AM +0530, Gopi Krishna Menon wrote:
> common_osnoise_description.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_osnoise_description.rst to common_osnoise_description.txt
> to maintain consistency with other common_*.txt files and prevent Sphinx
> from building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--v16T4K3LqUohqyO6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrTgAKCRD2uYlJVVFO
ozVZAQC5CsLiy7sQl+rTtl5xrbElBxWgvxQ21/IMGdTbJfuv9QD/WSnjn7oWG8BK
g6i2dSDUeR5aG7vCmABdR1Qmzhp+ggY=
=skU1
-----END PGP SIGNATURE-----

--v16T4K3LqUohqyO6--
