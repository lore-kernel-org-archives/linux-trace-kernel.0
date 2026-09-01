Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1138D6A9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271827; cv=none; b=QCM1R0MUxkZIe74QT7mTAQP7R1hF+YypCxPztUFh5zy33pCknqMiB2CqTCd9bOX5rM3hA6ymXoizKqELROZIXYbGrh2NkIPL0WwlK604AQu7lLK1kuQBzf6RqfOyVbUh6FOcAtpGSWE4DOMqIK1v09RGUspW6vFMVcgXRhDOmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271827; c=relaxed/simple;
	bh=wb4AdGa9tTWmffovcZttarcJARLWA/tEkS4eMVX7rJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+Dy4aeThT14Gld+WU4jh+kaldZpTOGG7tA4UAepsp8ESi49ljdGPWmVz+shV4N8UzmxLK9cFyGSL3inpi/Jdfl1Tt/CLgAwZtbwPfHHRznAgRhcuZq8wAFYuEXGrWSskgs2dCZ+nCYNswgwTlZSuaClu/KvqRfceZr0gyVdYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DylaHod9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DylaHod9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26521F00A3D;
	Tue,  1 Sep 2026 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271820;
	bh=QSFcM7MSPX3/dcZT1IPVM6Cdz/kQLTIHItyxZoDhrrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DylaHod971jYBN1ScJnnU4tK+DNtLIbWseaMMJ+T0r7uUIJCoaKug5pJeYNV8Z+KU
	 31TWE7XN6Co2S/rhtxCQ7eH0s+CfZZAVLPYehWEwNwAACgK0XBKoA2ONosUuK3BDia
	 +I3N770wejwJBsb+dOSp2/WcQDJVV1Woyq5f446MO2ytiGAxyOvUnb6WKuK/GHm2ru
	 07xltJw+MgOeXHULPRy9b3ZjaA91jl5SSp/dC1NWvCU7S/RVgfaxmzLs/rHP5PymQP
	 PdjJUuYFwhIPfmEV2AZBQQEpC2Ya/rupLaLv1VkymeFKglUaewuttynhHXuw7/EU0N
	 xCphS/MG5tAJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donglin Peng" <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901134604.4052265-3-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
 <20260901134604.4052265-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:10:19 +0000
Message-Id: <20260901141019.D26521F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling bpf_find_btf_id() during trace formatting introduces a spi=
nlock acquisition into atomic/NMI contexts, leading to deadlocks and kernel=
 panics during oops reporting.
- [High] bpf_find_btf_id() performs global name-based BTF lookups per trace=
 event, causing severe O(N) performance degradation, lock contention, and i=
ncorrect typing for module/static functions.
- [Medium] Functions returning empty structs (size 0) cause an integer unde=
rflow in the bitmask calculation, triggering undefined behavior in the GENM=
ASK macro.
- [Medium] btf_trim_retval incorrectly zero-extends signed narrow types (e.=
g., s8, s16), breaking the formatting of negative values and error codes.
--

commit b33d384f150276d1e47f02dbd04205841c0951e8
Author: pengdonglin <pengdonglin@xiaomi.com>

fgraph: Enhance funcgraph-retval with BTF-based type-aware output

The current funcgraph-retval implementation suffers from two accuracy issue=
s:
void-returning functions print return values, and narrower types can contain
undefined data in high bits. This patch leverages BTF to obtain the exact
return type of each traced function, eliminating clutter for void functions
and properly truncating/formatting return values.

> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 00172f301f25a..38825f5662351 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
[ ... ]
> @@ -120,3 +121,70 @@ const struct btf_member *btf_find_struct_member(stru=
ct btf *btf,
>  	return member;
>  }
> =20
> +#ifdef CONFIG_DEBUG_INFO_BTF
> +void btf_trim_retval(unsigned long func, unsigned long *retval, bool *pr=
int_retval,
> +			int *fmt)
> +{
[ ... ]
> +	switch (kind) {
[ ... ]
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		if (kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_UNION)
> +			*fmt =3D RETVAL_FMT_HEX;
> +		else
> +			*fmt =3D RETVAL_FMT_DEC;
> +
> +		if (t->size > sizeof(unsigned long)) {
> +			*fmt |=3D RETVAL_FMT_TRUNC;
> +		} else {
> +			msb =3D BITS_PER_BYTE * t->size - 1;
> +			*retval &=3D GENMASK(msb, 0);
> +		}

[Severity: Medium]
Can this calculation underflow msb?=20

If the traced function returns an empty struct (e.g., struct {} in GNU C),=
=20
t->size is 0. The calculation BITS_PER_BYTE * 0 - 1 will underflow to
4294967295.

Passing this huge value to GENMASK(msb, 0) invokes C undefined behavior due=
 to
out-of-bounds bitwise shifts.

> +		break;
> +	case BTF_KIND_INT:
> +		v =3D *(u32 *)(t + 1);
> +		if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL) {
> +			*fmt =3D RETVAL_FMT_BOOL;
> +			msb =3D 0;
> +		} else {
> +			if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_SIGNED)
> +				*fmt =3D RETVAL_FMT_DEC;
> +			else
> +				*fmt =3D RETVAL_FMT_HEX;
> +
> +			if (t->size > sizeof(unsigned long)) {
> +				*fmt |=3D RETVAL_FMT_TRUNC;
> +				msb =3D BITS_PER_LONG - 1;
> +			} else {
> +				msb =3D BTF_INT_BITS(v) - 1;
> +			}
> +		}
> +		*retval &=3D GENMASK(msb, 0);

[Severity: Medium]
Will this unconditional masking destroy the sign bit extension for signed
narrow integers like s8 or s16?

The masking clears the upper sign-extension bits. Since the legacy
IS_ERR_VALUE() check in print_graph_retval() only inspects bit 31, which wi=
ll
be 0 for these narrow types, negative values (like error codes) will be
incorrectly printed as positive integers.

> +		break;
> +	default:
> +		*fmt =3D RETVAL_FMT_HEX;
> +		break;
> +	}
> +
> +	btf_put(btf);
> +}
> +#endif
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index ff7cb1a76b953..89a64982df2cc 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
[ ... ]
> @@ -888,17 +889,35 @@ static void print_graph_retval(struct trace_seq *s,=
 struct ftrace_graph_ent_entr
>  	print_retaddr =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
>  #endif
> =20
> -	if (print_retval && retval && !hex_format) {
> -		/* Check if the return value matches the negative format */
> -		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> -			(((u64)retval) >> 32) =3D=3D 0) {
> -			err_code =3D sign_extend64(retval, 31);
> -		} else {
> -			err_code =3D retval;
> -		}
> +	if (print_retval) {
> +		int fmt =3D RETVAL_FMT_HEX;
> =20
> -		if (!IS_ERR_VALUE(err_code))
> -			err_code =3D 0;
> +		btf_trim_retval((unsigned long)func, &retval, &print_retval, &fmt);

[Severity: High]
Is it safe to call bpf_find_btf_id() from this trace formatting path,
considering it might run in atomic/NMI contexts?

This trace formatting function can run in NMI context via ftrace_dump_one(),
which executes with local IRQs disabled:

kernel/trace/trace.c:ftrace_dump_one()
    ...
    local_irq_save(flags);
    ...

btf_trim_retval() eventually calls bpf_find_btf_id(), which unconditionally
acquires btf_idr_lock using spin_lock_bh(). Taking a bottom-half lock in ha=
rd
IRQ/NMI context triggers WARN_ON_ONCE(irqs_disabled()) and causes deadlocks
if the lock is already held.

[Severity: High]
Could this global name-based lookup cause severe O(N) performance degradati=
on
during trace reads?

Trace formatting executes for every function return event. btf_trim_retval()
uses lookup_symbol_name() to convert the IP to a string, and then globally
searches BTF by name.

For module functions, this requires acquiring the global btf_idr_lock and
iterating over all modules per event, completely stalling trace formatting =
and
contending with BPF operations. Additionally, it causes incorrect typing for
static functions with common names, as it will just return the first match =
in
vmlinux.

> +		if (print_retval) {
> +			if (opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX)
> +				retval_fmt =3D RETVAL_FMT_HEX;
> +
> +			if (retval && retval_fmt !=3D RETVAL_FMT_HEX) {
> +				/* Check if the return value matches the negative format */
> +				if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> +					(((u64)retval) >> 32) =3D=3D 0) {
> +					err_code =3D sign_extend64(retval, 31);
> +				} else {
> +					err_code =3D retval;
> +				}
> +
> +				if (!IS_ERR_VALUE(err_code))
> +					err_code =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901134604.4052=
265-1-dolinux.peng@gmail.com?part=3D2
