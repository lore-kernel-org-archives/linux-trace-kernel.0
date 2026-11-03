Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674652;
	b=yVWhuiwGbqJE8uXRu2vkkPOXDu6S93oqYKPb+VKA7sRmjSbiNI0+p7sn31yNG0w7v2ps
	 TEXdAKcNNAxqtD0dLSN1uIqbhcZh1YLZUYVONijSVXKPoK4ZNzuDuf+qoXqLm8/CiajIA
	 Qc5wr+tY9fyYgVc1h0tFkCf46yL386PE6H5KU1x4JPVYDnvAefv8jE8NApOp1wpxmTk0h
	 0zvo5luhCHXOBP32JNUiLLdKkn3zF8aG//M4EyzSTdTNxyneSROMxP2K1WJB0w53ezEeO
	 8X0wn/Zf3cDCwE30vliBle2uetJeBd3G3D62i/B0ER3SHiTgdXFAoLzqS+jA4B7NNSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zHUwPuvd58lHKQx4i3eRn/+c0gtbMtowy5JIGDLzQP0=;
	b=S7di3qKjHdjiEeFfQEZJ0RTJNDATqmcgoxl8SnB6ahE8eWrnZv8cZ1YUewBsl/DzZ6uz
	 KQzxSXkD49n5vWjIUKgsTGWwPdCTvbYnNOI8Q7F53uEAQUBPep6RPSYZrmPqFLC4LrEl/
	 I1ow6uZg8rgJGRwn3/B8onWp6928lYksEVdLRsBiVxNIcUGjKixcX6Tityi335H1LeyFF
	 QtFsxbhcXtynaiflmhDxwBxASGXIsdwML1wJhUhUilPEAjqh8GG5kFxM5E1FaZtOx/llc
	 4v7KGYkpoO0ZEF9dPdsoNo7usgoqK1zcHhFvsqURkfJJsF2s7Cfl1GMAAtK59eKiaWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3Kh87Qf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99650606A32D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3Kh87Qf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0908D1F000C1;
	Tue,  3 Nov 2026 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674652;
	bh=zHUwPuvd58lHKQx4i3eRn/+c0gtbMtowy5JIGDLzQP0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l3Kh87QfC8/0BEsxAFROd+scRTz/ovOnD3vyrl+1VxZnER9jzRQ+19J9pw4oUO3uy
	 Wev/PG00uZa3vbuigiGQ9s7cwGFfhXQ30FPh8Gpv6JzNu25uosvBezT7KI7Vj83LFn
	 CZQY15FDla4D3S6bFEARxxYvf3Qp0idWrQwTA4dSxZKcLSJ44t6roNkidyNbzeLMJJ
	 U+yptRFG/aGjg52hcfoafxRP1uyECfPRZpojmflJXbI3u3UeE7RN9kAcqMypb/n+J/
	 VBQtM6afJeFYPWTuBwYvW9s4MwcB9CQHEeoR4RTJrzfxD4S3i7nvZRPlXDe+Duy2Yg
	 179n5PXwbVJGw==
Message-ID: <sashiko-outbox-194477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing/probes: bound symstr stores to reserved
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179367391951.8187.17152618045554425533@stu.pku.edu.cn>
References: <179367391951.8187.17152618045554425533@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:57:31 +0000
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
- [High] tracing/probes: missing __data_loc length update in fetch_store_sy=
mstring()
--

commit 2b3ccf8dccd0967bb835452c02ebe5b581c10ea8
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

tracing/probes: bound symstr stores to reserved length

This commit bounds symbol string writes in fetch_store_symstring() to the
reserved buffer length by formatting into a stack buffer with sprint_symbol=
()
and copying at most maxlen - 1 bytes into the trace record.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..dea6772652550 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -87,15 +87,24 @@ fetch_store_symstrlen(unsigned long addr)
>  static nokprobe_inline int
>  fetch_store_symstring(unsigned long addr, void *dest, void *base)
>  {
> +	char namebuf[KSYM_SYMBOL_LEN];
>  	int maxlen =3D get_loc_len(*(u32 *)dest);
>  	void *__dest;
> +	int len;
> =20
>  	if (unlikely(!maxlen))
>  		return -ENOMEM;
> =20
>  	__dest =3D get_loc_data(dest, base);
> +	len =3D sprint_symbol(namebuf, addr);
> +	if (len < 0)
> +		return 0;
> +
> +	len =3D min(len, maxlen - 1);
> +	memcpy(__dest, namebuf, len);
> +	((char *)__dest)[len] =3D '\0';
> =20
> -	return sprint_symbol(__dest, addr);
> +	return len + 1;

[Severity: High]
Does fetch_store_symstring() also need to update *(u32 *)dest with the actu=
al
stored length via make_data_loc() (or set_data_loc()), similar to
fetch_store_string() and fetch_store_string_user() in
kernel/trace/trace_probe_kernel.h?

Before calling process_fetch_insn(), store_trace_args() in
kernel/trace/trace_probe_tmpl.h initializes the __data_loc descriptor to the
entire remaining dynamic buffer capacity across all remaining dynamic
arguments:

	if (unlikely(arg->dynamic))
		*dl =3D make_data_loc(maxlen, dyndata - base);
	ret =3D process_fetch_insn(arg->code, rec, edata, dl, base);
	if (arg->dynamic && likely(ret > 0)) {
		dyndata +=3D ret;
		maxlen -=3D ret;
	}

Because fetch_store_symstring() writes len + 1 bytes and returns len + 1
without updating *(u32 *)dest, the upper 16 bits of the __data_loc field
remain set to maxlen whenever a symstr argument is followed by another
dynamic argument, or when the probed pointer changes between
fetch_store_symstrlen() and fetch_store_symstring() to a shorter symbol so
that len + 1 < maxlen.

Downstream consumers that extract the string length from the upper 16 bits =
of
the __data_loc descriptor will then read maxlen bytes instead of len + 1
bytes, spanning into subsequent dynamic arguments or uninitialized ring-buf=
fer
tail bytes:

- filter_pred_strloc() in kernel/trace/trace_events_filter.c passes
  str_len =3D str_item >> 16 to pred->regex->match(), breaking suffix and g=
lob
  matching on symstr fields.
- add_to_key() in kernel/trace/trace_events_hist.c copies
  size =3D *(u32 *)(rec + field->offset) >> 16 bytes into the histogram
  compound key.
- print_fields() in kernel/trace/trace_output.c reads len =3D *(int *)pos >=
> 16
  bytes from the event record.

Similarly, on the len < 0 path, returning 0 without updating *(u32 *)dest t=
o a
0-length data_loc leaves get_loc_len(*(u32 *)dest) =3D=3D maxlen > 0 while =
__dest
is uninitialized, causing PRINT_TYPE_FUNC_NAME(string)() in
kernel/trace/trace_probe.c to format uninitialized ring-buffer memory inste=
ad
of printing FAULT_STRING.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179367391951.8187.1=
7152618045554425533@stu.pku.edu.cn?part=3D1
