Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="OT4OnGfp"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15C10B;
	Tue, 12 Dec 2023 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375963;
	bh=Lx01uUzZBLjfFlGQlKARFoT+Vf/QEeNIG29aSuy6Lf8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=OT4OnGfpCidozTgeKJqlenrtbf0JerI1R/jU8yP204BjK4j3qeUs4ZqZNwq+f6H//
	 wKV4HqXL7mYXXFJBLq2OKLvweJzrd2nRxE/rO5JGD4Ud/xGcZeyQuVEh6jmP1Udhog
	 F1sTysJ+py9xrbtTHlxfK1QRFaZU0qzUB2Zj4tlnMrRM/ceBvOATJsNlsbAVtek1xP
	 ouydr8agHAM56ic655re4rEW/1CWxSZE2nbSX6g89ldVK3ux4shwpRzDKF+qQVtqQd
	 ph+hT5GDTBF728he4SOcBE2bdo9J9iPxtaP3Xf5qRpwFLPN20bh99gPmenALHXd0Oz
	 N1dY4hhdd8a4Q==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0700D12A7C;
	Tue, 12 Dec 2023 11:12:43 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:42 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH RESEND 04/11] tracing: tracing_buffers_splice_read: behave
 as-if non-blocking I/O
Message-ID: <11b84f2e4e5eaad501ff7b2bb03e2ad2f25ecdf14.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hv3lx7g2ikvzxdyu"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--hv3lx7g2ikvzxdyu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 kernel/trace/trace.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abaaf516fcae..9be7a4c0a3ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8477,7 +8477,6 @@ tracing_buffers_splice_read(struct file *file, loff_t=
 *ppos,
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
=20
- again:
 	trace_access_lock(iter->cpu_file);
 	entries =3D ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu=
_file);
=20
@@ -8528,35 +8527,12 @@ tracing_buffers_splice_read(struct file *file, loff=
_t *ppos,
=20
 	/* did we read anything? */
 	if (!spd.nr_pages) {
-		long wait_index;
-
-		if (ret)
-			goto out;
-
-		ret =3D -EAGAIN;
-		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
-			goto out;
-
-		wait_index =3D READ_ONCE(iter->wait_index);
-
-		ret =3D wait_on_pipe(iter, iter->tr->buffer_percent);
-		if (ret)
-			goto out;
-
-		/* No need to wait after waking up when tracing is off */
-		if (!tracer_tracing_is_on(iter->tr))
-			goto out;
-
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index !=3D iter->wait_index)
-			goto out;
-
-		goto again;
+		if (!ret)
+			ret =3D -EAGAIN;
+	} else {
+		ret =3D splice_to_pipe(pipe, &spd);
 	}
=20
-	ret =3D splice_to_pipe(pipe, &spd);
-out:
 	splice_shrink_spd(&spd);
=20
 	return ret;
--=20
2.39.2

--hv3lx7g2ikvzxdyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhoACgkQvP0LAY0m
WPEQ4w/+LmJ9g+sTLdWI+2h/NDpBO07CFF47oOhsehFB7o3yH8UophMOzrOdxYZQ
NYzzY+11ga72QE+rwRD3yLxdbQfZzDE2PUNT4eJdgAXA/3hsKqkw4VbuTN4tlrPP
5MTyjKC3GX5LjeBO32neK8SYUhZkabu108eflv+8XcpE32cW22gGuA71YcajuDj1
3Y9jblVjAT8acO0Zec6ZHOB6ZYBggwMMYyA0M+Me16sqxmBR1JToqNLeZkSh2Nfn
1IR1tzixc82NRPkFDYormthq5PEg3w/VIj0yvCEDRJKU1DqPrmYRBxahOe3JjKMI
54oQTopZEFK7vR9m0Vv31wmeXjw4da15elHNYE9FJj24URAJuCqMsHObwyt2BRmp
GOwcWPL89TVL4sN/lywa5Vb0A+DqxwCT0mfdrbhzAtwiBfnWbFCe3znyA+Jzcvwi
ube6KYote7bsLxDbbogcptP0RoL5+++cWissl4jGp2taZntQ6YWwx1P7qEyyKKvO
GZ94AXF4Vy159bJYlVdMp1JHzibVtC0XkRlzgrmU976HE0ycbz4eW5/Bjc7lYJqh
H0hlrwy8yUL6nnAjEfq6FEXo/rFJg5/s8ocWOMxHw/z+qUgv2+vP1bmt896AeL94
lCjPfm9DK0AA9/8wzdStv8q26yvVepmBROjWiQhsaGM4Vplx7Uk=
=KLoG
-----END PGP SIGNATURE-----

--hv3lx7g2ikvzxdyu--
