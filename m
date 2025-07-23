Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB1153BE9;
	Wed, 23 Jul 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302858; cv=none; b=QpotMVEqw6O3LvgmgopMaRgrLU0fxRocExF7gHRBUUY5xbNmOTKoYWtYvhW5AIU7Stouz65fg6pWNAjc7XSdMhbSOmwZs/A5PUT0l68v9uW9epkVh+iksI4QptcrV6CsYLV4X5Tm9DBWSXkNCTz30mqR+3BgkEUudGxFT1isRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302858; c=relaxed/simple;
	bh=Fa1TydQmcbEplUN9Ue2WFSBPuMVdPsBHqy8CCEXazHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qgap9RNNGqDWn07O+JiqTxLfouAFx40bo18DL2wBsveKQdelqg4IDcXYsJmFjxKyJCKEON0KGt3Xy29T7TPBb2kmet+ZtEuk9LOin3gXk9Wujj8eSLAMjckq+E7rZ+QAkrfGHWGHaIilaKzEIl3CF5x7ZF6e+lsqIxt8G4Evczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HuBK411J; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HuBK411J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K7ENK4quCFj4h2rmsOlNkdpHTFmDs5XQg7NJ8SZ+eWQ=; b=HuBK411JOPmQNqWylZweNV02J8
	gUmB34tsL0OGwCzn2qqufwboHewOtdA2DXBh/Idbx9CQbcmv9gT95MK6NVBktrYT/DhR29mw0SLa8
	/CUyu77dveWnhJN5J3eZVcOASTcEWrQjIYvTFWu/z/s24PlxnZK/XUlG5X3qF2yY3S84N23AQJKEL
	g/mKeHamUN/Jc9WJC13uWlsVEqXGwhOG42akUhpBHtIzxWQ+PYbAC0iZl1jQX1fPi91RWx7jECcz5
	QCDI1mhEhCyHUhRKigi5OP8n9OynbJrKpvjAs7vYvHcYJpVqRHlUm3fSiQNUkD898c7113Zog/A/h
	C0tSOL9Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1uefxC-008oPr-I9; Wed, 23 Jul 2025 20:20:42 +0000
Message-ID: <59abcb9262e97b76bfdf18d6de71c15eb2af8a6e.camel@debian.org>
Subject: Re: [PATCH] bootconfig: Fix unaligned access when building footer
From: Ben Hutchings <benh@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Wed, 23 Jul 2025 22:20:35 +0200
In-Reply-To: <20250724003747.be2a733e2e7fcf8a9e263cc4@kernel.org>
References: <aIC-NTw-cdm9ZGFw@decadent.org.uk>
	 <20250724003747.be2a733e2e7fcf8a9e263cc4@kernel.org>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-CHm9RwRlU5x4w+5IhN7/"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-CHm9RwRlU5x4w+5IhN7/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-24 at 00:37 +0900, Masami Hiramatsu wrote:
> On Wed, 23 Jul 2025 12:49:25 +0200
> Ben Hutchings <benh@debian.org> wrote:
[...]
> >  static int apply_xbc(const char *path, const char *xbc_path)
> >  {
> > -	char *buf, *data, *p;
> > +	struct {
> > +		uint32_t size;
> > +		uint32_t csum;
> > +		char magic[BOOTCONFIG_MAGIC_LEN];
> > +	} footer;
>=20
> Don't we need __attribute__((__packed__)) for the footer?

I don't see any reason for there to be padding in this structure, since
it has an alignment of 4 and the size of each member is a multiple of 4.

I included an assertion that there is no padding:

[...]
> > +	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> > +	static_assert(sizeof(footer) =3D=3D BOOTCONFIG_FOOTER_SIZE);
> > +	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
[...]

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-CHm9RwRlU5x4w+5IhN7/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmiBRBQACgkQ57/I7JWG
EQkKXA/8DGUMoUCzq6YYLQb5vNJK+a3hjeIlTY4ZncEBbzAejjN6OVBQWo+SvGIM
KDwcdIiKh2GIghM4fD42lFizqPFJEMi5CIjkzztxZhSj0CAvlxvekxUerGhcanEL
kNmvirp+4HW2d85IG5YI3qEYxx2203x0ev4KRkNtDpy/QWNfLbgvl6C+clR+k/ph
Zxc9Ml042Y4kWC8lcoPJkAObDnSixgMF2klUvwLWyX1Wcwv9hlgStsieHEI6BOZy
Xmo4OpmRXjlQ0Y3FCrJeRNzNdJ02PoPQbSXZ7npNyvCo4QTzJLgIFxVEfPJbxPIV
+MjHO+VLCs9iuFpMl8wlA1ezVb3QYOKVWxoZp/rjndKW7kknbTAJ1PYjfE+tV5nM
W8eC9XKOYGHKRTZcN5GrTg8fbQUhuzi8fHR5/OctHF8BM9gGbiuQ9/2CwXKyo92T
IF9tMAqEMBuXQ2pes8NywMPfBrk4TC/UuHc4+o+bARlS0Ru52Kre/m1Phy5QqG4l
SLucV2dxsBNYv7gDX7AfqPRxo1RmmxINUQxUY8z6zdc3VGEEqXztfDzIvT/T9AvM
QtCjbVw+xIoILU8a7Km8eChgNTQx/N95OB0hUYxdW+/O+AzGauCpEuXisnKh//lD
+/FZ2TI/q03waWrLtTRHbGwyr52phYg8/HLS3dNayacjwyYN5Mk=
=UQao
-----END PGP SIGNATURE-----

--=-CHm9RwRlU5x4w+5IhN7/--
