Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470489;
	b=lgKAssJJ4HL88gbinE990pxiJL4MZyng9f2zoOQxCxFOL8JE+bJl6UJzpdvH+SpmX++i
	 etm90K0EDxoc2hkUYntZX6qESFJ1dBdQstjN79eAv4lkUOYorGBF0FYNvgw1dfXRU56ar
	 pJD/Vdgjf8f8hoSlzrMGFFOGbq9t18AUrBw1VsB7ip8abZAa4qf4H4UdOSp7hOOVJ7fKg
	 1rWysOFCTClR2n8t2aknk3j1DEaPTeNmrR10sBy0S1aG9DHRhtz6d7htRYjRfxK92OX6K
	 5yQW9XFlkinJkmGoy5AanD4mhhxvz/fXDBttDvCtY32hQhVh0bGIdCPTtztPmsY7qpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AQnAVWw3jkOxbPJWEU/N5tEI0G2hSCTCKjqMFLucWeI=;
	b=SFbYZ7Cje0Q8HCLzGUKrsAqSfxME89yqOUZOrbNQUZA7uU7QcWgGEEydYIb5a6tBFCBI
	 UefYC/RIm3LytYn5bNmYqDHI9/OlmsvzmNt6Pa9OP9JwdDDrfEkpZrimswdkXNbf+T97Z
	 hZUO4Qs9jn2jk4a0nkRdpC2+hHUOBlDLmf77VGyfQSExLYy9GIHgta8HhzqojosK0vjMZ
	 kH4ComWjmzD48h5Cp/ZLJzp9vR7QjpZnSe9JAY1YOlPcBQtgQyuvwsIjZY+3Z63aGnNq0
	 +kWbireAC7nLhi10KoItfhpDSK4YJk4Jsw6pF8XqLDN+V072AmnJR6nOpfnhOc/66OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfIYtDj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F92606A31E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfIYtDj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890D41F000C0;
	Mon, 23 Nov 2026 21:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470488;
	bh=AQnAVWw3jkOxbPJWEU/N5tEI0G2hSCTCKjqMFLucWeI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FfIYtDj5Q4oQLxpQ5wgfXNSDo1mmJPTPLP48tyoexqzz6L7PLeDpZvDhlHQVQ02q7
	 F0tIBUf/m2BDTQbLG0opKnW3Kf6ru6AvNtrAKVN7QLTY2Yqh6rsNa535cBBBEgKdla
	 UBL3dR1V2X0NR37KgMwpLPSolxURwJim6cuyU+LasXrAH0vjj+LyrI4xIx8ar6+jm0
	 HWRUjaf7VYIJWaBOWVwm8XRUxLYVbhawBpy2Oit9fJbTuhLH0jaTL9NKsqOU8l7qlx
	 oilF+b+t9wseO7qeLiCiw04z/AGOjGZo6qMS3PbApLw9EVU0sbaRIAbzEu+J2KcJce
	 /5dOPeujjHc/A==
Message-ID: <sashiko-outbox-230090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261123163027.4d101385@gandalf.local.home>
References: <20261123163027.4d101385@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:48:08 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] tracing/probes: undeclared __dest in do_fetch_store_string*()
- [High] tracing/probes: FETCH_OP_ST_SYMSTR size mismatch when val is 0
- [Medium] tracing/probes: NULL pointer read in do_probe_mem_read() at
  stage 3
--

commit dcb397510a770194fc859548d8d68da35739732e
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit zeroes the destination buffer when probe memory reads fail and
continues past NULL or faulted dereferences in process_fetch_insn_bottom()
so that failed probe fields are zeroed in the ring buffer.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..de43966e40e7d 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -121,13 +121,59 @@ process_common_fetch_insn(struct fetch_insn *code, =
unsigned long *val)
>  	return 0;
>  }
> =20
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read_user(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	ret =3D probe_mem_read_user(dest, src, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
> +
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	ret =3D probe_mem_read(dest, src, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
> +
> +static nokprobe_inline int
> +do_fetch_store_string(unsigned long addr, void *dest, void *base)
> +{
> +	/* NULL addr gets zero size string */
> +	if (!addr) {
> +		*(u32 *)dest =3D make_data_loc(0, __dest - base);
> +		return 0;
> +	}
> +	return fetch_store_string(addr, dest, base);
> +}
> +
> +static nokprobe_inline int
> +do_fetch_store_string_user(unsigned long addr, void *dest, void *base)
> +{
> +	/* NULL addr gets zero size string */
> +	if (!addr) {
> +		*(u32 *)dest =3D make_data_loc(0, __dest - base);
> +		return 0;
> +	}
> +	return fetch_store_string_user(addr, dest, base);
> +}

[Severity: High]
Does this fail to build because __dest is undeclared in both
do_fetch_store_string() and do_fetch_store_string_user()?

[ ... ]

> @@ -161,19 +212,25 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
> =20
>  	s3 =3D code;
>  stage3:
> +	/*
> +	 * Once val is zero, it is pointing to NULL. Any new dereference is
> +	 * also treated as a NULL pointer.
> +	 */
> +	offset =3D val ? code->offset : 0;
> +
>  	/* 3rd stage: store value to buffer */
>  	if (unlikely(!dest)) {
>  		switch (code->op) {
>  		case FETCH_OP_ST_STRING:
> -			ret =3D fetch_store_strlen(val + code->offset);
> +			ret =3D val ? fetch_store_strlen(val + offset) : 0;
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_USTRING:
> -			ret =3D fetch_store_strlen_user(val + code->offset);
> +			ret =3D val ? fetch_store_strlen_user(val + offset) : 0;
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_SYMSTR:
> -			ret =3D fetch_store_symstrlen(val + code->offset);
> +			ret =3D val ? fetch_store_symstrlen(val + offset) : 0;
>  			code++;
>  			goto array;
>  		default:
> @@ -181,27 +238,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  		}
>  	}
> =20
> +	/* When val is NULL, so should the val + offset */
> +	offset =3D val ? code->offset : 0;
> +
>  	switch (code->op) {
>  	case FETCH_OP_ST_RAW:
>  		fetch_store_raw(val, code, dest);
>  		break;
>  	case FETCH_OP_ST_MEM:
> -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_UMEM:
> -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
>  		break;

[Severity: Medium]
When val is 0 in stage 3, offset is forced to 0, so FETCH_OP_ST_MEM and
FETCH_OP_ST_UMEM pass src =3D=3D NULL to do_probe_mem_read() and
do_probe_mem_read_user().  Should those helpers (or these call sites)
check for a NULL address and memset(dest, 0, size) directly instead of
reading from virtual address 0x0?

On s390, virtual address 0x0 is mapped to struct lowcore, so
copy_from_kernel_nofault() succeeds and copies lowcore bytes into the
ring buffer instead of zeroing the field.  On architectures with
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE, probe_mem_read() redirects
src =3D=3D NULL (< TASK_SIZE) to probe_mem_read_user(), reading user address
0x0 if mapped or taking a page fault on every NULL dereference.

>  	case FETCH_OP_ST_STRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string(val + code->offset, dest, base);
> +		ret =3D do_fetch_store_string(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_USTRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string_user(val + code->offset, dest, base);
> +		ret =3D do_fetch_store_string_user(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_SYMSTR:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_symstring(val + code->offset, dest, base);
> +		ret =3D fetch_store_symstring(val + offset, dest, base);
>  		break;

[Severity: High]
Can FETCH_OP_ST_SYMSTR write past the end of the ring buffer entry when
val is 0?

During the sizing pass (!dest), FETCH_OP_ST_SYMSTR now returns 0 when val
is 0, reserving 0 bytes for this argument.  During the store pass,
store_trace_args() sets *dl =3D make_data_loc(maxlen, dyndata - base) with
the total remaining maxlen across all dynamic arguments, and
FETCH_OP_ST_SYMSTR still calls fetch_store_symstring(0, dest, base):

kernel/trace/trace_probe_tmpl.h:fetch_store_symstring() {
	int maxlen =3D get_loc_len(*(u32 *)dest);
	void *__dest;

	if (unlikely(!maxlen))
		return -ENOMEM;

	__dest =3D get_loc_data(dest, base);

	return sprint_symbol(__dest, addr);
}

If a later dynamic argument in the same probe reserved 1 to 3 bytes,
maxlen is non-zero and sprint_symbol(__dest, 0) writes 4 bytes ("0x0\0")
into __dest and returns 3, overflowing the reserved ring buffer space and
underflowing maxlen in store_trace_args() for the next dynamic argument.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123163027.4d10=
1385@gandalf.local.home?part=3D1
