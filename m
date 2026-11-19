Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121403;
	b=lr4mPaW8RkKykKPiALQgxFhWBrsJFztMCjmb3bmMIh67neuT+ENJNNV4e9Q0zfo9L7kY
	 yNO0SitPezUB40LO4+uHfsC0/K/sSnoamW4GD6lOL1JHtSpU35apIAIgJTLZc5NVMlQCU
	 ksBdH6WSZu5kFA2Ho9ZhwxhHoPOKoU1TDEpUzZZ7vdouNB8KzCOgH51UDUJO/2gay0RYm
	 O0gMZZ8B6V55LwOc4sRoDOmALCpBOcifHqLkmriNB6AZni4KWdxy0iGmi2XGup/h3TLLC
	 R+lGOglyPLk7XLEVmrCEpex8ll4FIp0v/qeKXwUtRFY7laFsrZJKtBcvEFSTIU85SHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=18Mnzc/2jcuIQqG9/nXUKdn7+EaF0lPK0ALtudUKl1U=;
	b=WSys1TNSI5vzTm5IHI3wy1A1NXDCXKHZc0c0NncXcbnCsOCSxB2dULV0g1baN2ddVn9V
	 kMYK/kJniBa72RJzaf/ZwZLfM92IAdaY5ggm9lYVfzOmJAw4rkcL8+gd2RIAfAHHkftZo
	 8JKN3pZ9SUE894lKIN/BqWgBgeURWiC2kv/1oyUTerSQeLFGzDDvC0vZTnNHN/o+X1gSw
	 4gFnAktmh16YYI/sn18gOL63vj5ECUh9emEnjhGp3X5ckLpdrk4ktTRkJKFTaafoA4UXw
	 AA3sP0pCRXUcasu9U0nnB0X2QjGv1RriNg1qEA5V++YUzCeCEAtorW6K4dV9DrjqnGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bo2xEbXV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4405606A337
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bo2xEbXV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5AF1F000C0;
	Thu, 19 Nov 2026 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121403;
	bh=18Mnzc/2jcuIQqG9/nXUKdn7+EaF0lPK0ALtudUKl1U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bo2xEbXVTJ8DvNmh16ia2vlNvZKQZ83EzPfQW1LDz3f5/Z3m9VssNnwmyB7bksmfT
	 CEBye6D3Cc5R8ZyL3hZGv0NyUjOgqV49tCDaMej9CAeHJQYgBraT4a/9KVkZPboxHS
	 nudl+aOhZDZT6sxEseCPE1iqb8mZgSjKuzjYO6syL7yba79sSxzwBiBtxxmcqklzrz
	 RJmUeEBZint0vkUhNbPI+I1aoQzs2ZNnz+YymldRrtflBDXb+NymrJvZAXh8IXG4qb
	 a/I2rYmLuF3VHmb12i9KOJOdGVJFExWnGPnXE+4xTY7xFjlvsDju+VTEuDs6k6V3zQ
	 JfQNe3jfIlhvw==
Message-ID: <sashiko-outbox-224053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261119152922.5a66f10e@gandalf.local.home>
References: <20261119152922.5a66f10e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:50:02 +0000
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
- [Medium] tracing/probes: FETCH_OP_LP_ARRAY in
  process_fetch_insn_bottom() advances NULL
- [Medium] tracing/probes: FETCH_OP_CPU_PTR in
  process_fetch_insn_bottom() shifts NULL
- [Low] tracing/probes: trace_uprobe probe_mem_read() leaves partial
  bytes on fault
--

commit 754d85e0c0dcb5af755f3a74bd787872a07c54fd
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit zeroes the destination buffer in probe_mem_read() and
probe_mem_read_user() on read failure, and updates
process_fetch_insn_bottom() to skip NULL dereferences and continue to
stage 3 so faulted fields are zeroed in the trace event.

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
Does probe_mem_read() in kernel/trace/trace_uprobe.c need the same
memset(dest, 0, size) on error?

kernel/trace/trace_uprobe.c:probe_mem_read() {
	void __user *vaddr =3D (void __force __user *)src;

	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
}

trace_uprobe.c includes trace_probe_tmpl.h, where
process_fetch_insn_bottom() now ignores the return value of
probe_mem_read() in stage 2 and relies on it to zero dest on failure.
When an unaligned multi-byte read faults across a page boundary,
copy_from_user() only zeroes the uncopied trailing bytes, leaving the
initial bytes from the first page in val and causing stage 2 to
dereference a truncated non-zero address.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..8be14c00d66f9 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -127,7 +127,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, un=
signed long val,
>  			   void *dest, void *base)
>  {
>  	struct fetch_insn *s3 =3D NULL;
> -	int total =3D 0, ret =3D 0, i =3D 0;
> +	int total =3D 0, ret =3D 0, i =3D 0, offset;
>  	u32 loc =3D 0;
>  	unsigned long lval, llval =3D val;
> =20
> @@ -135,25 +135,28 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
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
> +				probe_mem_read(&val, (void *)val + offset,
> +					       sizeof(val));
>  			break;
>  		case FETCH_OP_UDEREF:
> -			ret =3D probe_mem_read_user(&val,
> -				 (void *)val + code->offset, sizeof(val));
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				probe_mem_read_user(&val, (void *)val + offset,
> +						    sizeof(val));
>  			break;
>  		case FETCH_OP_CPU_PTR:
>  			val =3D (unsigned long)this_cpu_ptr((void __percpu *)val);
> -			ret =3D 0;
>  			break;

[Severity: Medium]
Should FETCH_OP_CPU_PTR also check if (val) before calling
this_cpu_ptr()?

Now that stage 2 continues after a failed or NULL dereference, an inner
dereference in an expression such as this_cpu_ptr(+8($arg1)) or
this_cpu_read(+8($arg1)) can reach FETCH_OP_CPU_PTR with val =3D=3D 0.
On SMP kernels, this_cpu_ptr((void __percpu *)0) evaluates to
__my_cpu_offset, so subsequent instructions will record or dereference
the current CPU's per-CPU base address + offset instead of zero.

>  		default:
>  			lval =3D llval;
>  			goto out;
>  		}
> -		if (ret)
> -			return ret;
>  		llval =3D lval;
>  		code++;
>  	} while (1);
> @@ -161,19 +164,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
> =20
>  	s3 =3D code;
>  stage3:
> +	/* Prevent dereferencing NULL val pointer */
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
> @@ -181,27 +187,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  		}
>  	}
> =20
> +	/* Prevent dereferencing NULL val pointer */
> +	offset =3D val ? code->offset : 0;
> +
>  	switch (code->op) {
>  	case FETCH_OP_ST_RAW:
>  		fetch_store_raw(val, code, dest);
>  		break;
>  	case FETCH_OP_ST_MEM:
> -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> +		probe_mem_read(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_UMEM:
> -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> +		probe_mem_read_user(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_STRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string(val + code->offset, dest, base);
> +		ret =3D fetch_store_string(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_USTRING:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_string_user(val + code->offset, dest, base);
> +		ret =3D fetch_store_string_user(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_SYMSTR:
>  		loc =3D *(u32 *)dest;
> -		ret =3D fetch_store_symstring(val + offset, dest, base);
> +		ret =3D fetch_store_symstring(val + offset, dest, base);
>  		break;
>  	default:
>  		return -EILSEQ;

[Severity: Medium]
Does setting offset to 0 in stage 3 still dereference address 0 when val
is NULL?

finalize_fetch_insn() converts the final FETCH_OP_DEREF or
FETCH_OP_UDEREF of a dereference chain (such as ->pgd in prev->mm->pgd)
into FETCH_OP_ST_MEM, FETCH_OP_ST_UMEM, FETCH_OP_ST_STRING or
FETCH_OP_ST_USTRING in stage 3.  When val is 0, val + offset is 0, and
stage 3 still calls probe_mem_read(), fetch_store_strlen(),
fetch_store_string() and their user counterparts with address 0.

On CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE architectures, 0 <
TASK_SIZE is true, so probe_mem_read(), fetch_store_strlen() and
fetch_store_string() redirect the NULL kernel pointer read to current's
user virtual address 0, faulting on every NULL pointer or reading user
page 0 if mapped.  On s390, where address 0 is mapped to struct lowcore,
copy_from_kernel_nofault() succeeds and copies lowcore bytes into the
trace buffer instead of zeroing dest.

[Severity: Medium]
What happens in the FETCH_OP_LP_ARRAY loop below stage 3 when val or
lval is 0?

kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
    ...
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
    ...
}

Because stage 2 no longer returns early on a dereference fault, a NULL or
faulted array base pointer now enters the FETCH_OP_LP_ARRAY loop with
val =3D=3D 0 (or lval =3D=3D 0).  On the next iteration, val +=3D s3->size =
or
val =3D lval + sizeof(char *) turns 0 into a non-zero value (such as 8), so
val ? code->offset : 0 and if (val) treat it as a valid pointer and
dereference i * elem_size + code->offset for the remaining array
elements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119152922.5a66=
f10e@gandalf.local.home?part=3D1
