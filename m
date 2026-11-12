Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500789;
	b=5f/blrCGmsa+tYckgF8FVCmKSqA9ElKLXmbLS/qxtPNFYF82tOqV4fE8P/Po0gPLJllw
	 ANE0z9EA4BZQDMbkkFEuoU/rPFoGu3Rw+HkfVSpNkvfce9CxdUv1nzSiJ1d621ECFO3om
	 tkp/vjTsM32RqENaojhN95wxGgZZ1/jBisSuX8dYOmHQq8Vod/3YRU8VFX22AQ7RfkR4D
	 xzWqJfRmcocXmBAsFdsg6wLVZlNb8uAk6WpU56XClOz80a7ou6WH4HJpRM3sCTnLsw+Aj
	 WRUNf3uBs1bJ2IFury8j8PDgS18MFyT3L167hxdlC60727840mAfFRVKoiiGRV/J0RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yxXrtliWeSJ717XUx9PvrC1CitvRE+/KB+qyxrdt/AA=;
	b=jE+FmgWFz9M9aC2nFYlIKEwz8ZvdIHuOAMx4vcIPJRZ/IWgeLMRYszHi11USmGVSyds7
	 ZMgKPVJuObhPuHDelKkeBr53qeuTKyOEb0tlO6VWEFg+G0QVEMylR3UdwfVCQuGlg4itz
	 pFj7a59Go9/XV7eTqcNwzESvgJ0FdcfRnbf1rGlHaCloz0HrzeX4ez+FTZUZBwFCT6Zbs
	 JKcK7ZoQRramsYRKRdOvih7Bm727DLQHOw1VOlN5Jlr3qYWp4uX63DmTlfOzy3GbADTyk
	 Zesz467zlZ6Mz5bItclPDu1d1bIxl+tzYlzkhcqFKlSmLjELoksobHQ3WLomHkKLXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bx4dMrWm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FF606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bx4dMrWm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D551F000C4;
	Thu, 12 Nov 2026 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500789;
	bh=yxXrtliWeSJ717XUx9PvrC1CitvRE+/KB+qyxrdt/AA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Bx4dMrWmXh/O9T4iweMo9A/Nano0DQCU0Q1T1pyAMwHCxLdfH2uZ52g5aPbZLhoMa
	 AsMaAFSi/Ar4Q7pvqJa7tHapHZ7Ml7M7eWNbgaYrpsB9/9jb26NKefevwpf1hHlqNY
	 paiZTM9uQOHqBsW1Sm1DL1FuwupiJn0islojMPYcM30rtP7AVU+co7s+PKlNuAbOIo
	 rN4knMehVj2aMmy1Wt8Jv4cIS2yKCAlgwFkCAwMm/oWcV2TpX4RzuE2EPwJRSQOhfH
	 goza1rj8Z4D0TQbXuic/Xv1Qro42DiChW+wgTXJImuTqdORVAzPRlal0JVoiBoEt39
	 JR0CXvIhhYQUA==
Message-ID: <sashiko-outbox-211496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261112105853.38bd39be@fedora>
References: <20261112105853.38bd39be@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:26:27 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] tracing/probes: stage 3 in process_fetch_insn_bottom()
  dereferences NULL val
- [Medium] tracing/probes: FETCH_OP_CPU_PTR in
  process_fetch_insn_bottom() shifts NULL
- [Medium] tracing/probes: FETCH_OP_LP_ARRAY in
  process_fetch_insn_bottom() advances NULL
- [Low] tracing/probes: trace_uprobe probe_mem_read() leaves partial
  bytes on fault
--

commit 0adbcc076a7e0ebaeea272396034e57fe028eb89
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit zeroes the destination buffer in probe_mem_read() and
probe_mem_read_user() on read failure, and updates stage 2 of
process_fetch_insn_bottom() to skip NULL pointer dereferences and continue
instead of returning on fault.

> diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe=
_kernel.h
> index 4eb4acfa09ba1..00542a162d307 100644
> --- a/kernel/trace/trace_probe_kernel.h
> +++ b/kernel/trace/trace_probe_kernel.h
> @@ -102,18 +102,27 @@ static nokprobe_inline int
>  probe_mem_read_user(void *dest, void *src, size_t size)
>  {
>  	const void __user *uaddr =3D  (__force const void __user *)src;
> +	int ret;
> =20
> -	return copy_from_user_nofault(dest, uaddr, size);
> +	ret =3D copy_from_user_nofault(dest, uaddr, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
>  }
> =20
>  static nokprobe_inline int
>  probe_mem_read(void *dest, void *src, size_t size)
>  {
> +	int ret;
> +
>  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	if ((unsigned long)src < TASK_SIZE)
>  		return probe_mem_read_user(dest, src, size);
>  #endif
> -	return copy_from_kernel_nofault(dest, src, size);
> +	ret =3D copy_from_kernel_nofault(dest, src, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
>  }

[Severity: Low]
Does probe_mem_read() in kernel/trace/trace_uprobe.c also need to zero dest
when copy_from_user() fails?

kernel/trace/trace_uprobe.c defines its own probe_mem_read() and includes
kernel/trace/trace_probe_tmpl.h:

kernel/trace/trace_uprobe.c:probe_mem_read() {
	void __user *vaddr =3D (void __force __user *)src;

	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
}

On a partial fault across a page boundary, _inline_copy_from_user() only
zeroes the uncopied tail bytes, leaving the initial copied bytes in dest.
Because stage 2 in process_fetch_insn_bottom() now ignores the return value
of probe_mem_read(), an unaligned uprobe dereference that faults partway
through a pointer leaves a partially written val that subsequent stage 2 or
stage 3 operations continue to dereference or store.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..210a75ed5a92f 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -137,23 +137,24 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  		lval =3D val;
>  		switch (code->op) {
>  		case FETCH_OP_DEREF:
> -			ret =3D probe_mem_read(&val, (void *)val + code->offset,
> -					     sizeof(val));
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				probe_mem_read(&val, (void *)val + code->offset,
> +					       sizeof(val));
>  			break;
>  		case FETCH_OP_UDEREF:
> -			ret =3D probe_mem_read_user(&val,
> -				 (void *)val + code->offset, sizeof(val));
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				probe_mem_read_user(&val, (void *)val + code->offset,
> +						    sizeof(val));
>  			break;

[Severity: Medium]
When val is 0 (or becomes 0 after a stage 2 fault), doesn't stage 3 still
dereference (void *)0 + code->offset?

finalize_fetch_insn() converts the final FETCH_OP_DEREF or FETCH_OP_UDEREF
of a dereference chain (such as ->pgd in prev->mm->pgd) into
FETCH_OP_ST_MEM, FETCH_OP_ST_UMEM, FETCH_OP_ST_STRING, or
FETCH_OP_ST_USTRING in stage 3, which do not check if (val):

kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
    ...
	switch (code->op) {
	case FETCH_OP_ST_RAW:
		fetch_store_raw(val, code, dest);
		break;
	case FETCH_OP_ST_MEM:
		probe_mem_read(dest, (void *)val + code->offset, code->size);
		break;
	case FETCH_OP_ST_UMEM:
		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
		break;
	case FETCH_OP_ST_STRING:
		loc =3D *(u32 *)dest;
		ret =3D fetch_store_string(val + code->offset, dest, base);
		break;
    ...
}

When val is 0, stage 3 still attempts to read from (void *)0 + code->offset.
On architectures with CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
probe_mem_read(), fetch_store_strlen(), and fetch_store_string() see
(unsigned long)src < TASK_SIZE for positive offsets and redirect this NULL
kernel pointer dereference to user space via probe_mem_read_user() or
fetch_store_string_user(), which raises a page fault on every NULL pointer
event and copies unrelated user-space memory into the trace event if that
address is mapped in current.  In addition, when a stage 2 dereference
preceding FETCH_OP_ST_SYMSTR faults, continuing to stage 3 with val =3D=3D 0
passes 0 + code->offset to fetch_store_symstrlen() and
fetch_store_symstring(), formatting 0x0 instead of failing.

>  		case FETCH_OP_CPU_PTR:
>  			val =3D (unsigned long)this_cpu_ptr((void __percpu *)val);
> -			ret =3D 0;
>  			break;

[Severity: Medium]
Should FETCH_OP_CPU_PTR also check if (val) before calling this_cpu_ptr()?

In expressions such as this_cpu_ptr(+0($arg1)) or this_cpu_read(+0($arg1)),
unwind_parse_states() emits FETCH_OP_DEREF followed by FETCH_OP_CPU_PTR.
Now that stage 2 continues with val =3D=3D 0 when the preceding FETCH_OP_DE=
REF
reads NULL or faults, FETCH_OP_CPU_PTR computes this_cpu_ptr(NULL), turning
val into the non-zero per-CPU base offset (my_cpu_offset on SMP) so
subsequent instructions record or dereference my_cpu_offset + code->offset
instead of 0.

>  		default:
>  			lval =3D llval;
>  			goto out;
>  		}
> -		if (ret)
> -			return ret;
>  		llval =3D lval;
>  		code++;
>  	} while (1);

[Severity: Medium]
Can continuing past stage 2 when val is 0 cause FETCH_OP_LP_ARRAY to advance
from NULL into non-zero addresses on subsequent array elements?

kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
    ...
array:
	/* the last stage: Loop on array */
	if (code->op =3D=3D FETCH_OP_LP_ARRAY) {
		if (ret < 0)
			ret =3D 0;
		total +=3D ret;
		if (++i < code->param) {
			code =3D s3;
			if (s3->op !=3D FETCH_OP_ST_STRING &&
			    s3->op !=3D FETCH_OP_ST_USTRING) {
				dest +=3D s3->size;
				val +=3D s3->size;
				goto stage3;
			}
			code--;
			val =3D lval + sizeof(char *);
			if (dest) {
				dest +=3D sizeof(u32);
				*(u32 *)dest =3D update_data_loc(loc, ret);
			}
			goto stage2;
		}
    ...
}

When the base pointer of an array argument is NULL or a stage 2 dereference
faults, execution now reaches array: with val =3D=3D 0 (or lval =3D=3D 0). =
 On the
next iteration, scalar arrays increment val by s3->size and jump to stage3,
while string arrays set val =3D lval + sizeof(char *) and jump to stage2 wh=
ere
val is now non-zero, bypassing the if (val) check and dereferencing
sizeof(char *) + code->offset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112105853.38bd=
39be@fedora?part=3D1
