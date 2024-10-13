Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31406231C8D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853369; cv=none; b=ug7EmYgNgKv4w/v7hEp37Dkj2CW3kQ1JZNYN7fuSLW/FO2WMNCes9tLKnTqlG8BIvujuNOPCS15isSItNni5/Ugw2FHXQ3zzjzIKIJmNQi6lSpwkalVRwGjlreNeMVR3vK+x/DSYNt2NSzxt6kXa0c9jS1fnh+sI+XyJqOD8k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853369; c=relaxed/simple;
	bh=B17gd8a5jfA8hxcKqEKGNXRDIfGK4yjn1ezwVBWnDLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIObARe0b0R4cRlCsGjmRi8YaD5mh+JrvoJmHP5/3zujazej6qXnWlo+n3AFhAh4jw/ZK73sOQtX64urtk/sq9tT9hsWwiHAn4+sswgzdUaFB7p4VZ35poulg+CISP7KLThEIRjBq4kapLZr5KzcjZQRDGijzGObdXIsq6Tj/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=l1tyB0Kl; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="l1tyB0Kl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SKxKWiDL7w/02i2pEqRvDT81AHzeBtGyzzjGhSejj78=; b=l1tyB0KlxsIxonaHlQ2DYtcL9j
	x7lJ48u4xEVXJJHvLWWzZ6dhQLvCha16bK1KBHq+Oge3aKqqqTpVcA+bE/ibsP7JCIErnwcyc6iVv
	Sz+9OPUbsD1z26b1DefuYM6s9eOikRnJoamsA/TpHiZyeSzFqgY+y7I3pPl9CT3CGdyviKCvRmgqS
	WWv0nGPiVGYLUTKD/ZGdVPQ70pUw79nTZ0Ggw10fSYXxiyEBiUGGiKAfVwgY9Ow+Qi94MpqLBlNHY
	kMGNE4eTuI/iwIlTU1+dHkbJfLEn6Iu352eRsL23/SDc8NGwCNIpDMffn37ybhvTvLskFDnxbzj9H
	4ufmF9Zw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1t05Ip-005JT4-2p; Sun, 13 Oct 2024 20:34:58 +0000
Message-ID: <c075dbb7639d1c835b5fdb867462d6b455626e03.camel@debian.org>
Subject: Re: tools/rtla: Fix installation from out-of-tree build
From: Ben Hutchings <benh@debian.org>
To: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Date: Sun, 13 Oct 2024 22:34:49 +0200
In-Reply-To: <5508e99b-f22e-ab01-61f0-4ae352e595d2@redhat.com>
References: <ZudubuoU_JHjPZ7w@decadent.org.uk>
	 <5508e99b-f22e-ab01-61f0-4ae352e595d2@redhat.com>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-utzahS+9ymal4TmeORoI"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-utzahS+9ymal4TmeORoI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-10-10 at 13:39 -0400, John Kacur wrote:
>=20
> On Mon, 16 Sep 2024, Ben Hutchings wrote:
>=20
> > rtla now supports out-of-tree builds, but installation fails as it
> > still tries to install the rtla binary from the source tree.  Use the
> > existing macro $(RTLA) to refer to the binary.
> >=20
> > Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rt=
la")
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> > ---
> > --- a/tools/tracing/rtla/Makefile.rtla
> > +++ b/tools/tracing/rtla/Makefile.rtla
> > @@ -38,7 +38,7 @@ BINDIR		:=3D /usr/bin
> >  .PHONY: install
> >  install: doc_install
> >  	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
> > -	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
> > +	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDI=
R)
> >  	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
> >  	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/o=
snoise
> >  	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
> >=20
>=20
> Is Debian using out of tree builds Ben?
[...]

In the linux package specifically, yes, we try to do all builds out-of-
tree.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-utzahS+9ymal4TmeORoI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmcMLukACgkQ57/I7JWG
EQl2jhAAnVx3tFzCAhr+1/jRQCOqg/CrnSbcbzQIsCYmr6tL1Gl12ScP2NAfW4Hh
owBYy5Xx/CO2zl8tX5kddOYWfeF+TQHDQBznAf23EQsifUG1ZBQ8L8Hbyh8cf8iO
ieM5oXdm+ebou+K0F4snq5VpyobYAxWxxDNxACPkiglnVx+LZhbnxACkSOHFSsUv
kUpMpd4ssmlAEanw4oBwp+cPBiXne4wqhdun2lHzxjllFhmxNMp7L88nhE3HnbHM
Deq41XG+K8Pt//AazzS0ldZ0ZFtZrEZ8o6Fv5ojZ28r9i8kugHTCnNfVOIIMHebt
qkQLowHXnzYSdSmY8TzwyHxcecVGkUnOv9wKhuG0b2CnUsw8bZ0xhjc3StM36hQ6
3OMEobdFF1yUB3FmvVVMoj7Z+25PXg7FIFUSnDUUQ5rw96Zg9AIttStveNVwOagJ
uRwHXGsrKKTvBLg4rG2fFuA73qx6O2a8jEnD8cilkx81WvlMB2/q5TNcW87XqZhh
8v5bJ4C+5qfDx0vA5v3JkTSQUOa1ycZq7ImRcIanUZFKYh6foy12N9ktJ9G17DJN
rI6OtIlRFApsal0D4tJPlVhVc4sbyPsjrCJY4kT5QjuTv8bb/nuVJ2W3Zu7dpk2M
evVLYq//a7auOt9WdbeaBiYL0wGYFX7Y7tsEy4cAVVhAeNoBXEc=
=MR1s
-----END PGP SIGNATURE-----

--=-utzahS+9ymal4TmeORoI--
