Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB32F4327;
	Thu,  3 Jul 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566877; cv=none; b=ApY6tHJKp4Fz5VbNTFIKdLndJ8bUUfHqD4TmLAwt4uueQR2jpfDkrntTZBn05QFoIadEZX4os7mqC4pI/vj71rhQT3JSwZXyInmBFuYUg7bebk94UsgUQKMo29Bdnmepnyn/qLc6u5VFiyHYDLDp3ooOokXTf2eEJQT10rfqjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566877; c=relaxed/simple;
	bh=aK5BGIPAnLlDK2DcLG20FyVQPYNP6IsQ4xVEf9jXgn0=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VEIZXrwyZlFPMd//LTcWI2xa6WzkTOHoDvRURedxd9V5EFN4mi1I0hJ/Tc3bFjSkRhyR4CraKuBjDa7aGfBlKPD90q2W+ZVbsjRnk5v523NDHQjJiOa26FHVzxeceUHorY7YnvrTOLkUL4TURGE51vsQCOVy9GHbnY1zTKbOtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=R/edhYDB; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="R/edhYDB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566869;
	bh=aK5BGIPAnLlDK2DcLG20FyVQPYNP6IsQ4xVEf9jXgn0=;
	h=Date:From:Cc:Subject:From;
	b=R/edhYDBjTWDQfcjDbNxHSBQRNUmpwaLaUNQ84aLBTkir/bX347/2iSOvOdC8EWPB
	 gs0PN1xMskT6iQBtFpG32rW0u7ux66VFAy8FlytO0brdGoLBLU1L+1F5/vXoYN160c
	 RThLd4ZwW8miacXZPyyuhD+nI6LsD4uceaO6iQ8rMidu3QYscOkZyJUaXdoFNLvI7O
	 Jr/eOQKeDnILJd7AfYEdPXvG817s2BKwcxL9XpTzFPBc7dfWSAugM/mGpPn9dfdvxd
	 Dx7B2ctxPneV9OuyKDnbw/s4ePCKAibf06X0n2h0u2HOJ63zSmCScaXkzIAH8uM2AO
	 4igjen5ArFqlw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9FE7E36A;
	Thu,  3 Jul 2025 20:21:09 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:09 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2] tracing: doc: fix "for a while" typo
Message-ID: <xygdnynf7m55p7d27ovzqtdjaa7pua3bxuk5c22cnmoovaji5e@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3kgz5vvztx6zh7dz"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--3kgz5vvztx6zh7dz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 Documentation/trace/histogram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histog=
ram.rst
index 0aada18c38c6..2b98c1720a54 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -249,7 +249,7 @@ Extended error information
   table, it should keep a running total of the number of bytes
   requested by that call_site.
=20
-  We'll let it run for awhile and then dump the contents of the 'hist'
+  We'll let it run for a while and then dump the contents of the 'hist'
   file in the kmalloc event's subdirectory (for readability, a number
   of entries have been omitted)::
=20
--=20
2.39.5

--3kgz5vvztx6zh7dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyhIACgkQvP0LAY0m
WPFD4A//bFS2MxLU0WVJQhOnXSrjKl0M+OR/eRlXk6exVysizFEjUoZfptV6js8I
DJtP3sa6lLVA/qDIkk2h5VznKl08y2thFzr0Cj7/MqKHoWtc2EKQNnz8d1e1aqLo
kpL1Hm8orZ5V9OsnxobD6JbixDwx08osmr4orDyeVSUpd4JRtwy0/gXxKUlIVHrU
UK7qU9oAZuC9cncO9HEfRjadT9n8GNTbJQHVkknCGKugBkamRQ49mUsQv26bmauh
IolN/54XUoyBsaYrdgoDZBhCcpH3uWssIQBRd82WJFPBzhtF2qpZdI9PT+x+g0wL
1R9VZ7RJRT7OHpPcLF9U2QNjs3xQtYKPZL65pqyjfRoaai0qpmR3NjtR0uFedVz0
lSVSofx423cBV36J/klUqeHNyuaAtyDhREF1wuE86QeXUS0COfjK+RdYippei6cq
XGlN4oHNU+KhR+m9lLlhKdUQ57abQlV+L+JIXrcT3aDGXfZcXhl+StNTnYlvzV4v
I0ZdvjOzUh17wOyISQt89NfFSBVgM/azwG0OFakLeMS8khP4S4EWLdKrsOfAwqQd
+WGrUesePk2JGUHeCXkr8VJvOe5J1AxITALRpiaRluLfT5tq6j3O6xFhebJOhPbn
9Q8SxqZ80Y2xMSJOAlueaEYRg/FtyqHLXhsX43AvD9rpBeSBlfw=
=VZAt
-----END PGP SIGNATURE-----

--3kgz5vvztx6zh7dz--
