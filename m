Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E491501F25
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566352; cv=none; b=kUg7diBNO8u/sJg4UnxG6Gv376pgXrKX4BvcF08DN8FvytDDr0r3dvo41s26LrKdcjgR2bMpqCKxx11hA6V3n0Iqs+wKSstvjvSwgFLP8qBFEysOfAWpnB3D7XNXyCC1SRtkwvbjEyXEXmMB04Hf2XZiBJhUwoGutHNIAtuyfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566352; c=relaxed/simple;
	bh=j307BYPz6FAOVsovF83UIvjVJJYoHk7dyVXflj6Cz9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c4J+B93TiL3XNq5JvKvSk5XNwvIC0zAmdXoChjnroCxqig7VCPsWLdU3CpSWPHQfe/mqcsKMPY0RuZY25D+Kh+EhiV0yJCNMrsTfdNus/l7mZhCVnC5vRayMxQfBxSdlWuu0saRrqegxnLc0cVfaAx4VUstXCF1axgfJNZPK36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYJSIpWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYJSIpWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05781F000FF;
	Wed, 16 Sep 2026 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566348;
	bh=zzKr+9U+KyR7SMb48HFLKJTVuFa4lQl+DK1REANklCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYJSIpWzPWaS+fFLjh+gf8VcfuSwnGbyYdVvYtry03t/JljTBjqva9EHXD8lKsO95
	 4qDoLuPw7zUAKr09RSvbZxwE4ei1cVhCn1VwW2JSuB2DCrjQeDDNIqv+x8cQ5ln44J
	 orzCWV/rYSg60SuJhPHjCpODgXNCn0/uixXjGqxPWECynTmlrPy2ouPw0CNL2emlIr
	 6Gpx7W8MsbSvrRnwvbV+gE6JmtPnz9xDRvhlzkSPYWhjYNvedyzMlJdvsfqqBbOp1/
	 kfJEFm3fETYjAMbmX3F8LnzPgni5L2ad0RcRV5p4Ct3ZRHO5qlA+19MvK3DDV/X4Al
	 +LHjLvhqpUehA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donglin Peng" <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260916133218.1282590-4-dolinux.peng@gmail.com>
References: <20260916133218.1282590-1-dolinux.peng@gmail.com>
 <20260916133218.1282590-4-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:45:47 +0000
Message-Id: <20260916134547.D05781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] trace: incorrect BTF formatting for static functions due to name c=
ollision
- [Medium] trace: O(Modules) overhead per missing BTF function return
- [Medium] trace: error pointers are unconditionally printed as raw hex
--

commit adb7ea59c69663f88eec1f3f789cb7dab120bb0f
Author: pengdonglin <pengdonglin@xiaomi.com>

    fgraph: Enhance funcgraph-retval with BTF-based type-aware output
   =20
    The current funcgraph-retval implementation suffers from two accuracy
    issues:
   =20
    1. Void-returning functions still print a return value, creating
       misleading noise in the trace output.
   =20
    2. For functions returning narrower types (e.g., char, short), the
       displayed value can be incorrect because high bits of the register
       may contain undefined data.

> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index ae562192b619f..bcf65fec7bb14 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -123,3 +124,85 @@ const struct btf_member *btf_find_struct_member(stru=
ct btf *btf,
>  	return member;
>  }
> =20
> +void btf_trim_retval(unsigned long func, unsigned long *retval, bool *pr=
int_retval,
> +			int *fmt, bool hex)
> +{
> +	const struct btf_type *t;
> +	char name[KSYM_NAME_LEN];
> +	struct btf *btf;
> +	u32 v, msb;
> +	bool signed_type;
> +	int kind;
> +
> +	if (lookup_symbol_name(func, name))
> +		return;
> +
> +	t =3D btf_find_func_proto(name, &btf);

[Severity: High]
Is it possible that converting the instruction pointer to a string name here
causes incorrect BTF formatting for static functions due to name collisions?

When tracing a static function, `btf_find_func_proto` falls back to scanning
the vmlinux BTF and returning the first function with that name. Since the
kernel has thousands of name collisions for static functions, couldn't this
silently corrupt trace precision by applying the wrong return type formatti=
ng
(e.g., truncating an int or silencing a return value by treating it as void=
)?

[ ... ]

> +	case BTF_KIND_INT:
> +		v =3D *(u32 *)(t + 1);
> +		signed_type =3D false;
> +		if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL) {
> +			*fmt =3D RETVAL_FMT_BOOL;
> +			msb =3D 0;
> +		} else {
> +			signed_type =3D BTF_INT_ENCODING(v) & BTF_INT_SIGNED;
> +			if (signed_type)
> +				*fmt =3D RETVAL_FMT_DEC;
> +			else
> +				*fmt =3D RETVAL_FMT_HEX;
> +
> +			if (t->size > sizeof(unsigned long)) {
> +				*fmt |=3D RETVAL_FMT_TRUNC;
> +				msb =3D BITS_PER_LONG - 1;
> +			} else {
> +				msb =3D min_t(u32, BTF_INT_BITS(v) - 1,
> +					    BITS_PER_LONG - 1);
> +			}
> +		}
> +		*retval &=3D GENMASK(msb, 0);
> +		if (signed_type && !hex)
> +			*retval =3D sign_extend64(*retval, msb);
> +		break;
> +	default:
> +		*fmt =3D RETVAL_FMT_HEX;
> +		break;

[Severity: Medium]
Will this default fallback for pointer types bypass the error code heuristi=
c?

When `btf_trim_retval` identifies a pointer return type (`BTF_KIND_PTR`), it
sets `RETVAL_FMT_HEX` and later flags it with `RETVAL_FMT_BTF`.

In `print_graph_retval`:

    if (retval && retval_fmt !=3D RETVAL_FMT_HEX &&
        !(fmt & RETVAL_FMT_BTF)) {
            /* Check if the return value matches the negative format */

The condition `!(fmt & RETVAL_FMT_BTF)` evaluates to false, causing the leg=
acy
`IS_ERR_VALUE()` error decoding heuristic to be skipped. Could this cause a=
ny
function returning an error pointer to be unconditionally printed as an
unreadable hexadecimal (e.g., `0xfffffffffffffff4` instead of `-12`)?

> +	}
> +
> +	if (*print_retval)
> +		*fmt |=3D RETVAL_FMT_BTF;
> +	btf_put(btf);
> +}

> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index ff7cb1a76b953..8645a33f0388a 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -875,9 +876,10 @@ static void print_graph_retval(struct trace_seq *s, =
struct ftrace_graph_ent_entr
>  {
>  	unsigned long err_code =3D 0;
>  	unsigned long retval =3D 0;
> +	bool hex_format;
>  	bool print_retaddr =3D false;
>  	bool print_retval =3D false;
> -	bool hex_format =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
> +	int retval_fmt =3D 0;
> =20
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	retval =3D graph_ret->retval;
> @@ -888,17 +890,38 @@ static void print_graph_retval(struct trace_seq *s,=
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
> +	if (print_retval) {
> +		int fmt =3D RETVAL_FMT_HEX;
> +
> +		hex_format =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
> +		btf_trim_retval((unsigned long)func, &retval, &print_retval, &fmt,
> +				hex_format);

[Severity: Medium]
Could this call introduce an O(Modules) overhead per missing BTF function
return?

When formatting a trace event for a function missing from vmlinux BTF (e.g.
asm routines), `btf_find_func_proto` falls back to `bpf_find_btf_id`, which
iterates over all loaded modules:

kernel/bpf/btf.c:bpf_find_btf_id() {
    idr_for_each_entry(&btf_idr, btf, id) {
        if (!btf_is_module(btf))
            continue;
        /* linear search could be slow hence unlock/lock
         * the IDR to avoiding holding it for too long
         */
        btf_get(btf);
        spin_unlock_bh(&btf_idr_lock);
        ret =3D btf_find_by_name_kind(btf, name, kind);
        ...
}

Might this result in a severe performance degradation during trace output
formatting, as any user reading the trace file can trigger this string sear=
ch
and lock/unlock per module?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916133218.1282=
590-1-dolinux.peng@gmail.com?part=3D3
