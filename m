Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768C22539E;
	Sun, 17 Aug 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755440517; cv=none; b=AcP6WKTeXfh7bEibHKvcQmYLx/knwZ8SyZU62pB0re4dczQ+oLAobHKoiboGNE9JoRjptHM/AHiP4i/qX18HztdXobBbklq/dIlcnj2ryOyKUt95ZCbrOEJjnMEx6l0Zjhc6mLJYILN+JXDpUoZUHLmmTNoeNH6HUg4fAH8wqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755440517; c=relaxed/simple;
	bh=/l6cK9M1l86GAWzlzuomdOZiWW/2+anNeSWsz9q/idE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kyEj9IFqGbr+whLQcwRV9DbfB03gQjADIMXtbzVKMOVVjJArSEKpbjG4YPbbTfrvYWDVWkD6y1WOIEUKUZ0vS8w2Mp+45kACj5Hs17FHqwwVwyvnPZ9+1bXlg56/C5QgVdDotVnD1Z6iYSlnEdXcsbURh4ykTMiHAIpVcRrJzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uneGZ-009tCO-0s;
	Sun, 17 Aug 2025 14:21:47 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uneGY-00000005rtc-1e2B;
	Sun, 17 Aug 2025 16:21:46 +0200
Date: Sun, 17 Aug 2025 16:21:46 +0200
From: Ben Hutchings <benh@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Fix negative seeks on 32-bit with LFS enabled
Message-ID: <aKHlevxeg6Y7UQrz@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jIQehSLm+Zrad7oy"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--jIQehSLm+Zrad7oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit 26dda5769509 "tools/bootconfig: Cleanup bootconfig footer size
calculations" replaced some expressions of type int with the
BOOTCONFIG_FOOTER_SIZE macro, which expands to an expression of type
size_t, which is unsigned.

On 32-bit architectures with LFS enabled (i.e. off_t is 64-bit), the
seek offset of -BOOTCONFIG_FOOTER_SIZE now turns into a positive
value.

Fix this by casting the size to off_t before negating it.

Just in case someone changes BOOTCONFIG_MAGIC_LEN to have type size_t
later, do the same thing to the seek offset of -BOOTCONFIG_MAGIC_LEN.

Fixes: 26dda5769509 ("tools/bootconfig: Cleanup bootconfig footer size calc=
ulations")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/bootconfig/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 57c669d2aa90..55d59ed507d5 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -193,7 +193,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
=20
-	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
+	if (lseek(fd, -(off_t)BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for magic", -errno);
=20
 	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
@@ -203,7 +203,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) !=3D 0)
 		return 0;
=20
-	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
+	if (lseek(fd, -(off_t)BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
=20
 	if (read(fd, &size, sizeof(uint32_t)) < 0)

--jIQehSLm+Zrad7oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmih5XAACgkQ57/I7JWG
EQnUjxAAgfj9SvSU6rxNRR61rTwCLRKBimB0rNb52WHoZTiMf+qpI8lsE4NOO1jt
iTH6mBIQ9n5JQPVEkIzmBR3O6hmtNI1n3h4AVvcNMvlhVpGOFoKTHEIqWxadun5S
No0VYXO6UreeORdPGV/R0YYIh0eTEQqbukFNaXqTqN7lZwKQBJ/R9iYp2ow0xz9Y
SnMTGBv48e3tJNoOjqGwKgSb8tIvxpvi6eIJ1W85o/55qoBk3c7BsKwfxUVAHa3/
QFm0rioDUZ0OQwNBtf663U9KDOM7St/1vuy3i1H79p4FnMh7A2usov/a0mqk+uVq
bW+6ysFOX/T2OYqIGTfLX2NiGPtuJaxWsoZ0Mbv1PIV0+pgWnu/ibzlFT2quyiA0
i8geRqV8Y+erGZYjI/ZYxEPUJnQyJ3n/GQ7Jci2cly1iOb+qJjnfZ72WeEQTfoSx
j95dCzFy90VSSCSFq69GtD9HsUMTpWb39BytX2/vWA4ArP2lvsmGYBtKTXROLKwH
v9ljLXVfsdQOLQ2hFqusjQ/Me5D1oY7uDnplKzXjev5e+Zy/m3har/gSiEOkQoYB
2Hn/GIqtSlXCprB6diKkCWE0ZKltziqqv2C3yZNW89tNn0TTFRy0VyibYZHv1kuL
iiM6O8bkIQXOaztLeNEfNGXcIiupPfvwaXuTtFjVptgb0ZCQQl4=
=9dbG
-----END PGP SIGNATURE-----

--jIQehSLm+Zrad7oy--
