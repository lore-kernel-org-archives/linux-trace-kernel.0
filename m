Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C0279327;
	Wed, 23 Jul 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267780; cv=none; b=nPNdLpazDy550mUZfbHNhi/wLZ23Xx/aNbR6LSc9girRdXe8jb2gV6xNMdr48UF1DO1ErnGg9cS7OlWAYZRRfuoqSu/3tLvCcVf86FFRR/AJxhuPE2NdgVKTmNLVSvqfQxQt4VlfE0+Iu2JkENyg0KA6oQ+MJUtsvUmWhBmlTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267780; c=relaxed/simple;
	bh=7VwzKE9sGWkcmfi4Xv4/MJNzUZAlBn6TWR8UA8pEC2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lLbqSEynVoFbEw/fz0G3CElhVgClLLz4NfBJLHb0iHzdS7ADKwJOmKlwYqU9ReSMz+LyG4DiImQ0vMQNNQqAjVnNpy+522HMNgR3RyA5B2IUFnM6SKcPm0RV+15S1i3iEhD4xV5cqneWLoysx2V2iDH088TMeto+hayO6yb5t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1ueX2N-006tEP-0v;
	Wed, 23 Jul 2025 10:49:27 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1ueX2L-000000011VE-2oF5;
	Wed, 23 Jul 2025 12:49:25 +0200
Date: Wed, 23 Jul 2025 12:49:25 +0200
From: Ben Hutchings <benh@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Fix unaligned access when building footer
Message-ID: <aIC-NTw-cdm9ZGFw@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OD0zKPxJnQpOSJxd"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--OD0zKPxJnQpOSJxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently we add padding between the bootconfig text and footer to
ensure that the footer is aligned within the initramfs image.
However, because only the bootconfig data is held in memory, not the
full initramfs image, the footer may not be naturally aligned in
memory.

This can result in an alignment fault (SIGBUS) when writing the footer
on some architectures, such as sparc.

Build the footer in a struct on the stack before adding it to the
buffer.

References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Ds=
parc64&ver=3D6.16%7Erc7-1%7Eexp1&stamp=3D1753209801&raw=3D0
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/bootconfig/main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4988e23a1422..57c669d2aa90 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <errno.h>
 #include <endian.h>
+#include <assert.h>
=20
 #include <linux/bootconfig.h>
=20
@@ -363,7 +364,12 @@ static int delete_xbc(const char *path)
=20
 static int apply_xbc(const char *path, const char *xbc_path)
 {
-	char *buf, *data, *p;
+	struct {
+		uint32_t size;
+		uint32_t csum;
+		char magic[BOOTCONFIG_MAGIC_LEN];
+	} footer;
+	char *buf, *data;
 	size_t total_size;
 	struct stat stat;
 	const char *msg;
@@ -433,17 +439,13 @@ static int apply_xbc(const char *path, const char *xb=
c_path)
 	size +=3D pad;
=20
 	/* Add a footer */
-	p =3D data + size;
-	*(uint32_t *)p =3D htole32(size);
-	p +=3D sizeof(uint32_t);
+	footer.size =3D htole32(size);
+	footer.csum =3D htole32(csum);
+	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+	static_assert(sizeof(footer) =3D=3D BOOTCONFIG_FOOTER_SIZE);
+	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
=20
-	*(uint32_t *)p =3D htole32(csum);
-	p +=3D sizeof(uint32_t);
-
-	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	p +=3D BOOTCONFIG_MAGIC_LEN;
-
-	total_size =3D p - data;
+	total_size =3D size + BOOTCONFIG_FOOTER_SIZE;
=20
 	ret =3D write(fd, data, total_size);
 	if (ret < total_size) {

--OD0zKPxJnQpOSJxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmiAvjEACgkQ57/I7JWG
EQmT3xAAjxwbyp2rkqMdSaqNM+rAJUX2uBn1L4jY0Ti1f1CZrGleZ6PjKoPFhntY
Ep+pTr3LpGuMCWRB+dHVB+aldO7HUtTc/dvn4oTQCwC8RfLquElWpiLLpKURb9wy
wHh3DSFZ9Wtk7jIBew16Vx8zE79Crb6DGl0Y4MF8gCR69W9MbYc7R13A2fH8WF5P
IbmfxH2A1qXAghJ+Kmn36cl2v2SOp2SWRdEF6mQi62mh9mr0R1tjRwI4cf6RcM/m
NGCPN3Dx1BRZyV60AnyZU803wxmjS3VH07L7+904eJ4o7z72dS/b3QATaCSXVZga
88ysg1kDPVyHzGGlIn/CmGwxtGYdaUwv+hoM2BIY4b+S19veHCGmslzpD8fJxV99
r5Yd31EppVXOra5TOdTUu2Ewic76UsczbyQt8vB7DDYwvwkNgwVp0VeIvTdP+Q94
CemJANlwR1LX08FF60e0CYVZmoCLhA3RPZz0Os5XLkV0tfYOfLNSS+jzldee3Tpz
Kl3iA5olDRd/+xyLb713Hg1Q83IAjvdYVF9Tq2GPShaPhEunlTMuYP1FK6dc1H2n
rx4AxWfSJCxa1G75dGbYEBtMdBqmhSXXjkgUmqcx20xG9sZ/+yxTpkJ7KHmK+OaV
hzlws1qVI9e5uZLz/FMEeIFq4B8283WCeyNQgSsi9hqJMuTg9Fw=
=fRVy
-----END PGP SIGNATURE-----

--OD0zKPxJnQpOSJxd--
