Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953315;
	b=Mkdl2jJPAyXsDyjBUKNe0AoLUEL3scPlGxF+qu72XjE/uxjb0PqxLHAWQkW9wxv4aEwh
	 oSbifRMmkFx0gRolem/XFnv8dFQWAbz5T2OZXvtosfT0cNKOiGGvXByVXl2j/uIVeTANb
	 XnBdSXL3n5bPBLHsPVjGhtNvVBYt5a/1I1HtgdIfl7OCObkMn116klaq1gT45tBvoVXNB
	 l3rKJ58hWBlHZMvTYfeuzHTTlhIOAP+DT30ARYPTJKEs1qn4zYDe6ND2Mi1Ia7vCNUeCt
	 xd4B4qpjR3s0kQQASXGs7n5SUqJVpbqL0pkPoM/mW0i8YCiMt/IT6Br162yDCZHzAjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953315;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=v0pad5rhFZNVf/DcwG2P+Ojp8s+P0GwyLe5Cg7QYVCI=;
	b=r4A87QAYw0qA47dq2hxBcFCEF4Gb0tAOppo3jEuwJIA3RDK49+bErLLCXz2K8iApYzXZ
	 Vicd8A3FcCvbhWyWWv3X2/q9u8mVfVAR5IEN9bLRaFujzMYMVEunTOiBeCLUxR+qYoJhD
	 5doRxxAMeLA4OVeuLfaQaOKFfGXOIZm0MRPHR+Um51kZcH2n3dq9MFbSCfmYzOmjlKKjR
	 TNA2XeqIff4kKWKjQ9VZr0zhKJTAHh1v9+3Jc19NdXo3wjCvPS23I/RXQxpX6iPH9Xhuk
	 LxPNkfl0WvUeRCD360zMURFuxIiejBAOioBYVmj17yjesH+pqqbWjmOAUSvqkrphDAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P17xzKtE;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193E606A31C;
	Tue, 17 Nov 2026 22:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9193E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P17xzKtE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794953312;
	bh=YKI1+orUhC7UVyTNXTw2Fvdl/90JM9tFKLlKjK3PlCM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P17xzKtEYoIkyovYIg//JNQKvg/4GEj5FVwp99jX0cDdTXC9lQb/W9EhSjy4qC5rs
	 SWkD0sCZu5NTMCaxzxbsJL19dNuSkifRrI8fGB3BPCDj1XvojM2cG4QDqghRjwLaIu
	 WTiessdUsZfL+VwYjKirmOfUXFqlqB5PGPdvMmVtjcQDYEDr5UvG6zzjlWgGO33Dvg
	 LMPhArW19gbGU4LJpPydyQF9KKMw0CqrDVR0ciJLhS/nyPJR5GfoST5B90V96R/6IG
	 DFRH4M2kpdKrojE9CszMkgTUQ6iEyN+G1hUOLh0K+s2tSgrKDzDD41OygH0Uq2jUjV
	 qrnTFlt0Q+w2w==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF37017E00E8;
	Tue, 17 Nov 2026 23:08:30 +0100 (CET)
Message-ID: <fa76c2a0093bc0c75702dcdbfacbf0b2adc8ad9c.camel@collabora.com>
Subject: Re: [PATCH v2 0/9] v4l2: Add tracing for stateless codecs
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Detlev Casanova <detlev.casanova@collabora.com>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
  Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Benjamin Gaignard	 <benjamin.gaignard@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Heiko Stuebner	 <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Date: Tue, 17 Nov 2026 17:08:30 -0500
In-Reply-To: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
References: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+9L0I7/vQ9auKcdun9Ph"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-+9L0I7/vQ9auKcdun9Ph
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 10 juin 2026 =C3=A0 10:33 -0400, Detlev Casanova a =C3=A9crit=
=C2=A0:
> Hi !
>=20
> This patchset aims to improve codec event tracing in v4l2.
>=20
> The traces added in visl by Daniel Almeida are moved to the global trace
> events.
> They are adapted to trace each each field separately and not just the
> whole struct so that userspace can filter on different fields and
> libraries like libtracefs and libtraceevent can be used to list the
> fields instead of parsing the trace printk's.
>=20
> The trace event templates are also reworked to avoid long lines, but
> quoted string splits are kept as they don't cut words.
>=20
> To each trace event are also added a tgid and fd fields, helping
> userspace track different decoding sessions (contexts) based on the given
> file descriptor used by the given process id.
>=20
> Also for better tracking, stream on and stream off events are added as
> well as HW run and HW done events to track decoder core usage.
>=20
> The main focus is to be able to generate perfetto traces to show VPU usag=
e,
> a perfetto producer using this can be found at [1] (it will be renamed to
> match the more generic approach than hantro).
> Other controls can be traced later as well, this patch set only focuses o=
n
> mem2mem type drivers.

This is getting old, can you rebase and fix all the checkpatch and smatch i=
ssue.
There might be some build issues too?

https://gitlab.freedesktop.org/linux-media/users/patchwork/-/pipelines/1683=
571/

cheers,
Nicolas

>=20
> [1]:
> https://gitlab.collabora.com/detlev/hantro-perf/-/tree/hantro-improved-in=
fo
>=20
> Changes since v1:
> - Don't modify the printk format
> - Trace all fields of the structs instead of the whole struct as a buffer
> - Remove fdinfo patches (they will come in another patch set)
> - Fix long lines
> - Rename v4l2_requests.h trace header to v4l2_controls.h
> - Add basic documentation
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
> Detlev Casanova (9):
>       media: Move visl traces to v4l2-core
>       media: Map each struct field to its own trace field
>       media: Add tgid and fd fields in v4l2_fh struct
>       media: Add tgid and fd to the v4l2-requests trace fields
>       media: Add missing types to v4l2_ctrl_ptr
>       media: Trace the stateless controls when set in v4l2-ctrls-core.c
>       media: Add stream on/off traces and run them in the ioctl
>       media: Add HW run/done trace events
>       media: hantro: Add v4l2_hw run/done traces
>=20
>  drivers/media/platform/verisilicon/hantro.h        |    1 +
>  drivers/media/platform/verisilicon/hantro_drv.c    |   10 +
>  .../platform/verisilicon/rockchip_vpu981_regs.h    |    1 +
>  .../media/platform/verisilicon/rockchip_vpu_hw.c   |    4 +
>  drivers/media/test-drivers/visl/Makefile           |    2 +-
>  drivers/media/test-drivers/visl/visl-dec.c         |   76 -
>  drivers/media/test-drivers/visl/visl-trace-av1.h   |  314 ---
>  drivers/media/test-drivers/visl/visl-trace-fwht.h  |   66 -
>  drivers/media/test-drivers/visl/visl-trace-h264.h  |  349 ---
>  drivers/media/test-drivers/visl/visl-trace-hevc.h  |  464 ----
>  drivers/media/test-drivers/visl/visl-trace-mpeg2.h |   99 -
>  .../media/test-drivers/visl/visl-trace-points.c    |   11 -
>  drivers/media/test-drivers/visl/visl-trace-vp8.h   |  156 --
>  drivers/media/test-drivers/visl/visl-trace-vp9.h   |  292 ---
>  drivers/media/v4l2-core/v4l2-ctrls-api.c           |   10 +
>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  114 +
>  drivers/media/v4l2-core/v4l2-fh.c                  |    1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   37 +-
>  drivers/media/v4l2-core/v4l2-trace.c               |   48 +
>  include/media/v4l2-ctrls.h                         |   19 +
>  include/media/v4l2-fh.h                            |    4 +
>  include/trace/events/v4l2.h                        |   77 +
>  include/trace/events/v4l2_controls.h               | 2708 ++++++++++++++=
++++++
>  23 files changed, 3033 insertions(+), 1830 deletions(-)
> ---
> base-commit: acb7500801e98639f6d8c2d796ed9f64cba83d3a
> change-id: 20260608-v4l2-add-ftrace-aec6e7f60a6c
>=20
> Best regards,
> -- =20
> Detlev Casanova <detlev.casanova@collabora.com>
>=20

--=-+9L0I7/vQ9auKcdun9Ph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCavzQXgAKCRDZQZRRKWBy
9O3jAQDZ8BZcn7gZDDvbPjsacktSHHnvBQ6sV6/UOIhaT59xmwD/dc0B0IzmagZI
neZLwegym+RxxGBk7Fn60KARGmqsGgE=
=eJc6
-----END PGP SIGNATURE-----

--=-+9L0I7/vQ9auKcdun9Ph--
