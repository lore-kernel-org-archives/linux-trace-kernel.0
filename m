Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621491;
	b=2lWjuQqEsunQT4sv0KGF1YGypW8jRLLGJSwhJxqDhNZIS7DcbCNvVfdrnfrgGDz0loE6
	 UmrgtQkN4uODEPC0vfkY2ycdF5vuh+sL7B48lRfpOHAyUxNAOFEJ5OdYNO5RPah944crj
	 DH/SOf//wG+WJ8K8qYDeWO/QAae0AZtTZWlgjD/Kgsk/uOolK0DDBsk8j9D9+c3kq9Dnl
	 3O3x7XeAGSb/Uxm+81Y3WVtZPswGTlVPcfalqdUQ8kBwMKbrJkxbr5OxAbpY6z+wwti21
	 U+LgKrAOP227Q2Y/fHBVyRhy6VZAwNI5T8mA3xN4ySjC4rJJE16dv6sx4/ina+JsUQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iCi31SBjchG6edMTJPjXxk3dmyE2BGaCYm2JOWMiTRo=;
	b=iv/x5Alzw5HkCSnd/ta9rlRGVZN4wNjTR5zyDMqh2KG6EaeWU2NzQGDWy+aQqOO6RUga
	 aPruYSEw1vNpYY0nvbC8+Co+dzjSjBQXan91+MMoDp6Y28AKC4WPW7UokuYeBDblgKSq6
	 AlRUoB5Yc4WWDgoGsz2+rs6/qJj0m/T42rwuVJ1qyn87pK+N0JBHayWlD/GJWHMYEgBMT
	 G/oNaYIFnIWCEwhzZ4I4Lh25BYVGvMV03VofOuIP7NP1HBcdPiKKQ9F2aoT+0f5dKEDC4
	 0+WQWuSrOeejvjjYLxYx80hwWXLPnorx60XAQsxNKBZMOxyLvrX97DXrY/1Q524Rtmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhhl5ER7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84894606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhhl5ER7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9951F00A16;
	Mon,  2 Nov 2026 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621491;
	bh=iCi31SBjchG6edMTJPjXxk3dmyE2BGaCYm2JOWMiTRo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hhhl5ER7RClWryrHcvWIDQkMj9LyAXhSGE4bNAZLdHmIhIVfFyWAZCkgfnx3aaCJ3
	 qDT0xK7DSeFZQtOjy0I4invhKhfG8dxvNuHB9BjPq++viBhFXF5Ba6ZXxniYWJmoqH
	 Vx/ATkvIS817wJW/VP45W2g6O0uifHssrhtJkGEC6T3LB9EdD70wHb2vERqUSxQisd
	 75PZuAwzz69p7g0M8mFq9jA1jfTRwdZaXGSvUMnjoSdKNu8DJ9W0Wiypbuz6Jxzz4t
	 anF3+xyvKtzNREbgctmegifHUtPNMwzkrweQNsHFhgY8DsyUQuHJOFiwh7/Lol5lji
	 xnZ3wd1oGq2uQ==
Message-ID: <sashiko-outbox-193373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/probes: bound symstr stores to reserved length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179362071772.29269.13958672165986396737@stu.pku.edu.cn>
References: <179362071772.29269.13958672165986396737@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:11:30 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing/probes: symbol format mismatch in fetch_store_symstring()
--

commit 1dd7922bca1f3057be72658bb3bb50c1a3ed082f
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

tracing/probes: bound symstr stores to reserved length

This commit bounds symbol string formatting in fetch_store_symstring() to
the length reserved during the sizing pass by replacing sprint_symbol() with
scnprintf(..., "%pS", ...), preventing out-of-bounds writes when a probed
pointer changes between passes.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..cc317cb444e43 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -95,7 +95,7 @@ fetch_store_symstring(unsigned long addr, void *dest, v=
oid *base)
> =20
>  	__dest =3D get_loc_data(dest, base);
> =20
> -	return sprint_symbol(__dest, addr);
> +	return scnprintf(__dest, maxlen, "%pS", (void *)addr) + 1;

[Severity: Medium]
Can switching fetch_store_symstring() to "%pS" while leaving
fetch_store_symstrlen() on sprint_symbol() cause a size mismatch between
the reservation pass and the store pass even when addr does not change?

In kernel/trace/trace_probe_tmpl.h, __get_data_size() ->
process_fetch_insn() -> fetch_store_symstrlen() still computes the required
buffer size with sprint_symbol():

kernel/trace/trace_probe_tmpl.h:fetch_store_symstrlen() {
	char namebuf[KSYM_SYMBOL_LEN];
	int ret;

	ret =3D sprint_symbol(namebuf, addr);
	if (ret < 0)
		return 0;

	return ret + 1;
}

However, in lib/vsprintf.c, pointer() -> symbol_string() handles "%pS"
differently from a direct sprint_symbol() call in two ways:

lib/vsprintf.c:pointer() {
	switch (*fmt) {
	case 'S':
	case 's':
		ptr =3D dereference_symbol_descriptor(ptr);
		fallthrough;
	case 'B':
		return symbol_string(buf, end, ptr, spec, fmt);
}

lib/vsprintf.c:symbol_string() {
#ifdef CONFIG_KALLSYMS
	...
	else if (*fmt !=3D 's')
		sprint_symbol(sym, value);
	...
	return string_nocheck(buf, end, sym, spec);
#else
	return special_hex_number(buf, end, value, sizeof(void *));
#endif
}

On architectures with CONFIG_HAVE_FUNCTION_DESCRIPTORS=3Dy, sprint_symbol()=
 in
fetch_store_symstrlen() inspects the raw descriptor address (for example,
formatting a short hex address when CONFIG_KALLSYMS_ALL is disabled),
whereas "%pS" in fetch_store_symstring() dereferences the descriptor to the
target function symbol, which can be longer than the reserved length.

Similarly, when CONFIG_KALLSYMS is disabled (such as with
CONFIG_EPROBE_EVENTS=3Dy), sprint_symbol() writes an empty string and
fetch_store_symstrlen() reserves 1 byte, whereas "%pS" formats the full hex
address via special_hex_number().

When the formatted "%pS" string is longer than the sprint_symbol() result,
scnprintf() either truncates the symstr field or, if another dynamic
argument (such as string, ustring, or symstr) follows in the same probe
event, consumes the remaining shared dynamic buffer maxlen passed by
store_trace_args() and causes subsequent dynamic arguments to be truncated
or fail with -ENOMEM.

Should fetch_store_symstrlen() and fetch_store_symstring() use matching
symbol formatting logic (or "%pB" if descriptor dereferencing is not
desired)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179362071772.29269.=
13958672165986396737@stu.pku.edu.cn?part=3D1
