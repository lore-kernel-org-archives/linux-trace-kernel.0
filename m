Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448625;
	b=Kp+rHTmmi8tnMkOPK8DBAZOGBGFA6hcygOhDlxiwLEAMcCI8Me7XWcn9sTOdQuVVGt8w
	 Avvyz/ByqkVOHp9/Oa85+yN9IIrIAJ9CZEgNb/Uy+uioVl2Zu1mRCrYr1+O3dm6OdBmMw
	 y/zOu+Dg/hs7/P74ODA6wTe3Wy+2PobeD8d7+QqUb5zYOKlAvi9dq59G9tygCLSgAoXpx
	 gFDs53I3P4qpM2RlqjEZz4Z3rrU/G+hC7XrVWtsNtfcEGAh7yQZ6QzwXKjbSg0ZSOnJmZ
	 OKFsaG2tjPrRIvSiHcurmj+d0DCXwgf8PPQ3v18Q94vqjYOhqKX+1STDwT88BwEMSUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5tVrpnSnYawFKbxnVswfSEykWDGab2cU3kO/w7VCiY0=;
	b=2NWCTdDtFxGMBE1qrD6hO1moORBa/zZRp66EOAEMVcFuGnL+TBJYW3Bp+LwSG2epXN1V
	 NFNG2bD1rp30LIDtaicT+JtFo6ZLFedRdXq0qANrl9gjYeEU/I5Rv7MucY1/HUzm2c63m
	 I0CdKDKMDBNh4RbpgBoVvXfKWaNek1bcdtDUnDAwiMhd10Rs/qlRtuJJQUc8tr4T1xdZI
	 9L7ETOEyjQQALZzc9qhFVNxP7eGMesaWd4b0nlIA2zIM+MXQCiUJv7DLY8tQNDbnJa+y7
	 rn41qevgkKTHis72dUhg7NM8Xy/jRP0V4PbaywmW/9wo6zh+Kf+9ZoT6xGs10CX7R2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bf/pSIyF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A3606A881
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bf/pSIyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD56E1F00A05;
	Thu, 12 Nov 2026 01:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448624;
	bh=5tVrpnSnYawFKbxnVswfSEykWDGab2cU3kO/w7VCiY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bf/pSIyF/7wT5f4e5qeo3OciVTOFpM9kZtqY05g6YwQKvZWB9DrYa9/vPudP89Klo
	 eVMuk493BJ93F6D0ZSxVteag6BYiF2Sk2a6XvoChrqGoCZ53EPNp2t1UuZhVASUUn2
	 Tz0/XWSi3IRPy6TCDtLy7UFLXcBIcwuqegtwtC8+dvM62NiR041P4FzyRGhbcPudqT
	 jzYG+MjyTtzPqHy55vr7Yd/PRFxLbvUNmXfHEcy7i4OIlsmRzCTKPvMCBq3OGI7O75
	 aG3lpmYhcQpGcbTF4MrwyFBhHy0Uybva5OvGX1zjovBHTMl0ypqmoPG62SUh7Vi1WL
	 TtEtJ0Kr/bkOA==
Message-ID: <sashiko-outbox-210125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] tracing/probes: Fix BTF bitfield parsing and
 out-of-bounds buffer write
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179444682679.345731.13247927117747302891.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
 <179444682679.345731.13247927117747302891.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:57:04 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tracing/probes: wrong bitfield lshift on big-endian in
  parse_btf_bitfield()
--

commit e5cd5bf4ce18aa0d644893f624a1f1a581f88aeb
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write

This commit updates BTF bitfield parsing in trace_probe.c to compute byte
and bit offsets consistently, select a matching unsigned fetch type, and
size FETCH_OP_MOD_BF shifts to the selected fetch type.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index a880a90642d7c..3a57fe6b67cce 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c

[ ... ]

> @@ -858,13 +876,22 @@ static const struct fetch_type *find_fetch_type_fro=
m_btf_type(
>  }
> =20
>  static int parse_btf_bitfield(struct fetch_insn **pcode,
> +			      const struct fetch_type *t,
>  			      struct traceprobe_parse_context *ctx)
>  {
>  	struct fetch_insn *code =3D *pcode;
> =20
> -	if ((ctx->last_bitsize % 8 =3D=3D 0) && ctx->last_bitoffs =3D=3D 0)
> +	if ((ctx->last_bitsize =3D=3D 0 ||
> +	     ctx->last_bitsize =3D=3D BYTES_TO_BITS(t->size)) &&
> +	    ctx->last_bitoffs =3D=3D 0)
>  		return 0;
> =20
> +	if (ctx->last_bitsize =3D=3D 0 ||
> +	    BYTES_TO_BITS(t->size) < (ctx->last_bitsize + ctx->last_bitoffs)) {
> +		trace_probe_log_err(ctx->offset, BAD_BITFIELD);
> +		return -EINVAL;
> +	}
> +
>  	code++;
>  	if (code->op !=3D FETCH_OP_NOP) {
>  		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
> @@ -873,9 +900,9 @@ static int parse_btf_bitfield(struct fetch_insn **pco=
de,
>  	*pcode =3D code;
> =20
>  	code->op =3D FETCH_OP_MOD_BF;
> -	code->lshift =3D 64 - (ctx->last_bitsize + ctx->last_bitoffs);
> -	code->rshift =3D 64 - ctx->last_bitsize;
> -	code->basesize =3D 64 / 8;
> +	code->lshift =3D BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->las=
t_bitoffs);
> +	code->rshift =3D BYTES_TO_BITS(t->size) - ctx->last_bitsize;
> +	code->basesize =3D t->size;
>  	return 0;
>  }

[Severity: Medium]
Does this calculate the wrong code->lshift on __BIG_ENDIAN_BITFIELD
architectures?

At runtime, FETCH_OP_ST_MEM copies t->size bytes starting at bitoffs / 8
into buf, and fetch_apply_bitfield() shifts that native-endian integer left
by code->lshift and right by code->rshift.  On big-endian systems, BTF bit
offsets are numbered from the most significant bit of the first byte, which
is loaded into the most significant byte of the integer in buf, so there
are ctx->last_bitoffs bits above the bitfield rather than
BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->last_bitoffs).  Using
the little-endian formula shifts out the bitfield bits and records
corrupted values in the trace buffer on big-endian architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179444679892.345731=
.5271591537517106679.stgit@devnote2?part=3D3
