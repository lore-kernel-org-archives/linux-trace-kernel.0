Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207142;
	b=Mj18M/dlXH1T05qi1IyvaKzNeoqtI3XcYYPGX8E75yQ5dkki5BwzPtWc/L2gQGNGWmv2
	 b1MpW29D/MlI6NBp4YhHapky4sg8S+aeMijN8XRaFO6jv/BYRNI0m7gz1L8Mmf0F1078e
	 tg/T1JPLdILNruVITZFHkaM2DkWeOTMSu+6lGCuXN2+pwrOLr6SxaauIG4nlyMsccVR4G
	 uDiidHCK6PM5GwkyQnn2TM4N1IVpn33PUOn9sBSJtA14RAokQaWBCihL+rmrsOJTOPnNi
	 Tzp9tjHLx1zjfddL98ABQtsmZJHZy8JUboQqZOe/09l4p/lIetTnt8mccyic3P2TWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qvh2/628vfW5/cZZAEdNggolqzrS25QM0cyzCgkKCm8=;
	b=Qd/25gnovjoOkJ7KNhUsZhEMGDX+zq0GHMzi6LJlL1FfbrnZunwiIedGBtCP54FGVpX4
	 Ba5NzGojoPkD2sTV4oZFumTOcCJ/QX29ipcgXWs+5V+WxOQOPCItrBbnd5WlGu6njh+Kp
	 3zkRYpJwrZyOiDFosBulYOxjcsyZWF7wD25xF3oXaTZn/zI5hvsW8OwmZdvI2DyawLR3m
	 tjHWx9fYCC5QvWHDFJHa9UyxtyTR9AUA8jCIUhtIBs0BjiKnJDgrY7GUpQygyOTx7yO8e
	 QxWKvx/xAklvsbJl8aOJZ0Ezgt92mjUkUoKUCWEumvrOyzj1GD3YJjfStIZ+syZp2sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwfkFA9h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C3606A6ED
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwfkFA9h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1321F000C6;
	Fri, 20 Nov 2026 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207141;
	bh=Qvh2/628vfW5/cZZAEdNggolqzrS25QM0cyzCgkKCm8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FwfkFA9hTyOWznVoTA4SavWnnLZ1apMma+YRoBDwVGR7/h7aDp3j51FeD33ksi0rA
	 ODvjzJXQQRD+zfyL/NOVFudTMvhuNGtg2hoMu7aiuO0C/1wv27VUYGZ88ThieMEd4k
	 aZmlwcCAFdkdzvuhTL0k4Oar93Awr74PCTMXSA5gLfcL9gfU2OrNpry6BY9o9GDmEa
	 r/fPYz7oTiRg4huVqRu+FIz75WdNSwZ+jsQvIbKs41krD+XDeBmJzQ/myLWi9KfEez
	 W4bREVOyuXXA2Dqa93Kdqn0JmQ6se2RKqebyoks0zQ33R5S7pw3BFxBek58NHbmGJQ
	 AC8o21TuB3mnA==
Message-ID: <sashiko-outbox-226078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261120152432.0dc2bdf0@gandalf.local.home>
References: <20261120152432.0dc2bdf0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:39:01 +0000
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
- [Medium] tracing/probes: stage 3 dereferences 0x0 in
  process_fetch_insn_bottom()
--

commit 6464703716b264ea3aea879ca95045129fa2a909
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit introduces do_probe_mem_read() and do_probe_mem_read_user() to
zero out the destination buffer on read faults, and updates
process_fetch_insn_bottom() to continue to stage 3 with val set to 0 rather
than returning early when a dereference fails or encounters NULL.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..3e9dea89e90ca 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -121,13 +121,37 @@ process_common_fetch_insn(struct fetch_insn *code, =
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
>  /* From the 2nd stage, routine is same */
>  static nokprobe_inline int
>  process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  			   void *dest, void *base)
>  {
>  	struct fetch_insn *s3 =3D NULL;
> -	int total =3D 0, ret =3D 0, i =3D 0;
> +	int total =3D 0, ret =3D 0, i =3D 0, offset;
>  	u32 loc =3D 0;
>  	unsigned long lval, llval =3D val;
> =20
> @@ -135,25 +159,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  	/* 2nd stage: dereference memory if needed */
>  	do {
>  		lval =3D val;
> +		/* Prevent dereferencing NULL val pointer */
> +		offset =3D val ? code->offset : 0;
>  		switch (code->op) {
>  		case FETCH_OP_DEREF:
> -			ret =3D probe_mem_read(&val, (void *)val + code->offset,
> -					     sizeof(val));
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				do_probe_mem_read(&val, (void *)val + offset,
> +						  sizeof(val));
>  			break;
>  		case FETCH_OP_UDEREF:
> -			ret =3D probe_mem_read_user(&val,
> -				 (void *)val + code->offset, sizeof(val));
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				do_probe_mem_read_user(&val, (void *)val + offset,
> +						       sizeof(val));
>  			break;
>  		case FETCH_OP_CPU_PTR:
> -			val =3D (unsigned long)this_cpu_ptr((void __percpu *)val);
> -			ret =3D 0;
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				val =3D (unsigned long)this_cpu_ptr((void __percpu *)val);
>  			break;
>  		default:
>  			lval =3D llval;
>  			goto out;
>  		}
> -		if (ret)
> -			return ret;
>  		llval =3D lval;
>  		code++;
>  	} while (1);
> @@ -161,19 +190,25 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
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
> +			ret =3D fetch_store_strlen(val + offset);
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_USTRING:
> -			ret =3D fetch_store_strlen_user(val + code->offset);
> +			ret =3D fetch_store_strlen_user(val + offset);
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_SYMSTR:
> -			ret =3D fetch_store_symstrlen(val + code->offset);
> +			ret =3D fetch_store_symstrlen(val + offset);
>  			code++;
>  			goto array;
>  		default:
> @@ -181,27 +216,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
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
>  	case FETCH_OP_ST_STRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string(val + offset, dest, base);
> +		ret =3D fetch_store_string(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_USTRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string_user(val + code->offset, dest, base);
> +		ret =3D fetch_store_string_user(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_SYMSTR:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_symstring(val + code->offset, dest, base);
> +		ret =3D fetch_store_symstring(val + offset, dest, base);
>  		break;
>  	default:
>  		return -EILSEQ;

[Severity: Medium]
Does stage 3 still attempt to read from virtual address 0x0 when val is
0?

finalize_fetch_insn() converts the final dereference in a chain (such as
ppgd=3D(task_struct)prev->mm->pgd) into FETCH_OP_ST_MEM, FETCH_OP_ST_UMEM,
FETCH_OP_ST_STRING, or FETCH_OP_ST_USTRING.  When val is 0 entering
stage 3 (either because a pointer in stage 2 was NULL or because a
stage 2 read faulted and zeroed val), setting offset =3D 0 passes address
0x0 to the stage 3 helpers instead of skipping the memory read.

This causes three problems when val is 0 in stage 3:

1. If address 0x0 is readable, stage 3 records data from 0x0 instead of
zeroing the field or recording a fault.  On s390, kernel address 0x0 is
mapped to S390_lowcore, so copy_from_kernel_nofault() succeeds and copies
lowcore bytes into dest.  On architectures with
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE (such as x86 and arm64),
probe_mem_read(), fetch_store_strlen(), and fetch_store_string() check
(unsigned long)src < TASK_SIZE and redirect address 0x0 to user space,
reading from user page 0 if mapped.  For FETCH_OP_ST_SYMSTR, a stage 2
fault zeroes val and formats 0x0 instead of (fault).

2. On every NULL pointer (such as prev->mm =3D=3D NULL on kernel thread
switches in sched_switch) or after any stage 2 fault, stage 3 triggers an
unnecessary hardware page fault and exception-table fixup at 0x0 (or one
per element in a FETCH_OP_LP_ARRAY loop).

3. In stage 2, offset =3D val ? code->offset : 0 is only used inside
if (val) blocks where val is already non-zero, and in stage 3, offset is
computed twice without val or code changing in between.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120152432.0dc2=
bdf0@gandalf.local.home?part=3D1
