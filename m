Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185146;
	b=hzPt3GVtKsUlFZwHOI1REZGyhz3W11Qpz96qCea+FCP2V0hFR/vPUbPuwX0jT1YNrgBc
	 +IMBbnYyZUKGzGKCAxYuIAqietEPtQyc7dRNWMCZOtuYtKcanzSPbiV+aURZzGR9NJBCh
	 NA1gqz8O9+UaehnCAbcYIhRz+OuG8gz73P02wY5PqsqBpT6PnaWmm+lqQtwzKCBKuoE+K
	 m1zXkMM/+B6pcCoezAs6AzQ3glAkYQk7a6RKBCJZjVG0Q0TE9jAMt7yy/u6IPKQap5C71
	 CzP/7oa1K4hU5Qd1rLDBKuq88eSMucXiP3fYEQDOE+mUX7MUWh2QGncOszVsGhJU2uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/1izIu9bEdboB0UO5xnnls6YkMqoFiIG4UAcTS2UMo=;
	b=LGc8O/zpdXwR2+KMydXGB2T1bywn27KXlNbBFVv1MiOXUek1UrS6ECi4wlMaPX7tWbll
	 Je1v47ObscqcfPH7NoJhzYCZKj1ednua1jdTCIvil6ud7RyOY8pYqJ4yBM4CN22bm82nh
	 E/x4jQzvFZGwL6n3RQ8WTS/c+9i0a8oDIhY9lJCPtgbFdnHWLOAIh3WqAmyauEaOJvJQR
	 drylFbwkZC+6sm4eLSBpBmAsIDd7xemzU5gr15du/9k9w+dr+l9d3eYfQjDn3x0aFN5tj
	 PV/K5NeRYL5w7LfvpE1nYCRrnjKq5FiT4gCZIwqyOKymWxfkOizlNr6QXFKYVheJ6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H10Yk1yf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE02606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H10Yk1yf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FA71F0089F;
	Mon,  9 Nov 2026 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185145;
	bh=A/1izIu9bEdboB0UO5xnnls6YkMqoFiIG4UAcTS2UMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H10Yk1yfRoDZIW614YK+sWiTJ1KHw2hWCZLMWdQ0BornHYNq+ECgCpEMxYsvjPI+4
	 5zYEvcLFsNax33qKSXsO5bbX/RIISxxI+TyZxjqt8tqmld6RyiBy5/DU5GV/+IuEmB
	 eXMgCH4o9jnxiTIrqTVbOLoxtmlpfrGoantN5Memw8+Xv4s6ZM06B+HGY+RXSBD9QQ
	 MkL3tUd7kKWDrK0w+xtDvxn++gFQIRf8kPxf8WY8SrfLs5KBiQQAUE4r5KKlEgmQ5e
	 7n+HBFg/Lr7p/Jxqccyh1TOespVF+AJFcZXL2+Ti44MRn9RxxL8iSXS+ugJatKfPkt
	 pp2gnPfBKNV0g==
Message-ID: <sashiko-outbox-204254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] tracing/probes: Fix BTF bitfield parsing and
 out-of-bounds buffer write
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179418411197.227715.5577722703946865281.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
 <179418411197.227715.5577722703946865281.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:45:45 +0000
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
- [Medium] tracing/probes: unaligned kflag=3D0 bitfields fail in
  get_bitoffset_of_field()
--

commit 2e4831ec2095ef67023431da46d322fba9d204db
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write

This commit fixes BTF bitfield offset calculation, selects an unsigned fetch
type wide enough to cover the bit offset and width, and derives the
FETCH_OP_MOD_BF shift and basesize parameters from the selected fetch type.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index a880a90642d7c..26e02929f1ffb 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c

[ ... ]

> @@ -653,6 +661,12 @@ static int get_bitoffset_of_field(char **pfieldname,=
 const struct btf_type **pty
>  		/* Add anonymous structure/union offset */
>  		bitoffs +=3D anon_offs;
> =20
> +		type =3D btf_type_skip_modifiers(btf, field->type, NULL);
> +		if (!type) {
> +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> +			return -EINVAL;
> +		}
> +
>  		/* Accumulate the bit-offsets of the dot-connected fields */
>  		if (btf_type_kflag(container_type)) {
>  			bitoffs +=3D BTF_MEMBER_BIT_OFFSET(field->offset);
> @@ -660,12 +674,15 @@ static int get_bitoffset_of_field(char **pfieldname=
, const struct btf_type **pty
>  		} else {
>  			bitoffs +=3D field->offset;
>  			ctx->last_bitsize =3D 0;
> -		}
> +			if (BTF_INFO_KIND(type->info) =3D=3D BTF_KIND_INT) {
> +				u32 intdata =3D btf_type_int(type);
> =20
> -		type =3D btf_type_skip_modifiers(btf, field->type, NULL);
> -		if (!type) {
> -			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> -			return -EINVAL;
> +				if (BTF_INT_OFFSET(intdata) ||
> +				    BTF_INT_BITS(intdata) !=3D BYTES_TO_BITS(type->size)) {
> +					bitoffs +=3D BTF_INT_OFFSET(intdata);
> +					ctx->last_bitsize =3D BTF_INT_BITS(intdata);
> +				}
> +			}
>  		}

[Severity: Medium]
Does this leave ctx->last_bitsize as 0 when a kflag=3D0 bitfield has a bit
width matching its underlying integer type size (such as an 8-bit bitfield
backed by a 1-byte BTF_KIND_INT with BTF_INT_OFFSET(intdata) =3D=3D 0) at a
non-byte-aligned member offset (bitoffs % 8 !=3D 0)?

When that happens, parse_btf_field() sets a non-zero ctx->last_bitoffs while
ctx->last_bitsize remains 0.  fetch_type_from_btf_type() then does not widen
the fetch type to cover the unaligned field across the byte boundary, and
parse_btf_bitfield() rejects the probe with BAD_BITFIELD (-EINVAL) because
ctx->last_bitsize =3D=3D 0 while ctx->last_bitoffs !=3D 0.

Checking bitoffs % 8 !=3D 0 alongside BTF_INT_OFFSET(intdata) and
BTF_INT_BITS(intdata) !=3D BYTES_TO_BITS(type->size) would record
ctx->last_bitsize for unaligned byte-sized kflag=3D0 bitfields as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179418408457.227715=
.1485179201014819821.stgit@devnote2?part=3D3
