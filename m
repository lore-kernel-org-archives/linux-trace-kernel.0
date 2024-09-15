Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76717BA7
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726443131; cv=none; b=MQaT4WQ/qCSyU0AHw0Bi69KCfIksXZGyqEJxEmEQ/xsY1N8A7sEVQFLR/7vGwv3v58pJWbqupzV2EAN4s6L7T558+tyvwPNWBqrpgOAaePVkjdihM6L5oE0sTGaR7J9kPWQum8Eyfs20cVnmn4CJIQyY05JRy+opcbmv9nyDWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726443131; c=relaxed/simple;
	bh=RiYwk5F/6buYQuAFlk4B/+LJjM+B43mlmDgYqv87JAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/onARICM2CVDyvMXNxr3GC+4DksJ1OM72SEYqR0B8uqbOJm/cKqW+uceVh+6et+75t/ECmmLstdGKz4dNv+th4mpUcTDcPjkeG3LV4Aa0heOQ6bkPC1WUnaJSbeHZRQQ3mL54c+fkE7vNwiHR4MkG2pQzKRFtKw9QcdWRnz9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1spyil-008r5p-3A;
	Sun, 15 Sep 2024 23:31:59 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1spyik-00000002OUk-3xPr;
	Mon, 16 Sep 2024 01:31:58 +0200
Date: Mon, 16 Sep 2024 01:31:58 +0200
From: Ben Hutchings <benh@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: tools/rtla: Fix installation from out-of-tree build
Message-ID: <ZudubuoU_JHjPZ7w@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SANt9ib9sA1wSVDR"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--SANt9ib9sA1wSVDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

rtla now supports out-of-tree builds, but installation fails as it
still tries to install the rtla binary from the source tree.  Use the
existing macro $(RTLA) to refer to the binary.

Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -38,7 +38,7 @@ BINDIR		:= /usr/bin
 .PHONY: install
 install: doc_install
 	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDIR)
 	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
 	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise

--SANt9ib9sA1wSVDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbnbmoACgkQ57/I7JWG
EQmKcw//cc9BB5jV2nxSvImrPJ6uxhhqW2rKTCUCOiNbrsF939OcXdUyCsJ3nHZW
r2dIvXNDYqTCowi40avW0ndZ7K0SluX1xcSSMzhKDHmbKaq77yL6Rg9XdXJjxyfe
B8D8ztbkPHCP/W0UjL16TO8KsMfBiQPd+NRj3RRoQwTX6DdiOi6xjVPKi6XYNVpJ
Hr9EgknRgKF1sHR2xO/JU9HQ3Oqq2dKyGwDOjePZNWAcDdKHBkIdvIqDtZnbCGWY
of/elxm3HVLZz+uqYYTD2wN9f3BKIEZRXfNqAWFAJu+hPd/4TkwGmJSKpAd8Xrov
h8u511EympYmkykhvFT1ZX37w8lTigt2JLrc5doXJpl2aCJdbT4dpzHxOsCuLUs8
QzyRufzRDLDfpojnP3+kZJmTP6ki6jSoSkqrnnjY1Rhnuy41R/4cBCIis4QbYUUt
0cgzUmDhJo4vGTd5VmKmoGr92icsNi5EEyOU9xRYGazIqEaPkpj8G9bPeXXrG3qY
YZIEmEMsOEprSIO91ZLAZ5WxRjK7T52o0sqCOnT84zWqPs2cpafxUS9b6GuKXE4z
iGUXSciWVaNI/xDsBsPuuDzlZC9tqeWYFq29RPQhonsCFYdajw2lF8rXCeKNeSQ9
J2Hx4ByPlB+vCvni9Bs9LEfhKOdg0zAWPQTEwAraxXDU3DsVJvM=
=PnH8
-----END PGP SIGNATURE-----

--SANt9ib9sA1wSVDR--
