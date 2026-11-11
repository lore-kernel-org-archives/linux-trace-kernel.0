Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392234;
	b=wVeViIJnTwVu8kl0GqWJoiXxIKxNXvEN/RDYGXloNgkhRCmF4N9Qf+82MY3GTG4iqmcx
	 yVSnbvgNuCGffDrRn4S9FMZpJU7hMxCSHLy4i8IiQxf4r4l2coCRjcN0q241P3pk3sG9Z
	 8hbVKlD5//XQpgbRpF3ArsHiSQ1EkwzvWx4uOxwWXEdsmwQno4Nu/iMY0o4bQXkH7DNaO
	 1vc61d2G1oclOomt2RB3j/U3INCHbtj6vHazXShvg9Gf4rAFgGEj9wjl8tPXMNdpHiJ9s
	 4S/MxZnV1Ea5ZMvHT3cnlADUHmpurz3+VHUfGCyZG/BP9hHrsXVAEuDrlPRonaXH0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oe/wzp1CGQlS9WtnjEoMuXxeq+pW6LuZSUlg8W2K9No=;
	b=lDT1uMWyepxLLCNXoqfHs86ScTzC6mDB/Yp2OopqYddpRwRGOzsn/uGoVBI0XbhAtvcC
	 gn+dLgch3uufV+EL7noOZTdUjHaLA3qXdpee55BgQz4AT3DFZP0IWNK+rOqdLRfPiEYF6
	 Ns/GJx7lXe9TJdyZOssZ9yCNpUANn81OHYvGuuQcvOoKouFSv466HZwnA1JLl1DurQ/ul
	 8spmSUl44IKnMOtNN6/7x9noVkNlv11XJn60UAkqgEVH3anoZUGeBxyIqln63gJP1urGk
	 0lJkymW4DBJTBA/4A4vV/9Xlba/+s+1SSo7mfDg6vz6wcI2klIMIRlR6RaUfhGoMV3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxCM44Ni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA1606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxCM44Ni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE0D1F00A05;
	Wed, 11 Nov 2026 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392233;
	bh=oe/wzp1CGQlS9WtnjEoMuXxeq+pW6LuZSUlg8W2K9No=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oxCM44Ni5wNLyFilP/I2eQr3tpKWuUgoRvgJBqux+4hqRyneKo2gWuOlW9WyW1I9S
	 CD46pALNccfrYnQaIlU/V1XNIf7XAgpys/j7nilCqS48P05eJ26xM/FW55+cwF7CDZ
	 eIU2e4WGIv9H2EWWalfEK39q/uhKEjIEqnyB/1KB3EQUzY7mXLEwcYbX8QoSidPS/v
	 aUxn5p8DGkrEjVvs2JUwGvV32lnBexWOt8qiDYKxrd+pezKWuhtHpbaP5pTr9LsVjB
	 co0wAoyqV8oS1mpSbyx5YZFVzPWlesMeriD292mr1xflPRerhWy1dbmt8O5nsTxSVm
	 6VPqVg1+pQDwA==
Message-ID: <sashiko-outbox-208768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261111050322.49bbebfa@fedora>
References: <20261111050322.49bbebfa@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:17:13 +0000
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
- [Medium] tracing/probes: uninitialized field on stage 2 fault in
  store_trace_args()
--

commit 721571368356f203544d8ff8abc91509e1c7eea8
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit zeroes the destination buffer in probe_mem_read() and
probe_mem_read_user() when a nofault memory read fails so that failed
dereferences do not leave stale ring buffer contents in trace event fields.

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

[Severity: Medium]
Does this still leave the trace event field uninitialized in the ring
buffer when an intermediate dereference faults in stage 2 of
process_fetch_insn_bottom()?

In the commit message's "(task_struct)prev->mm->pgd" example, prev is
valid and prev->mm is NULL, so stage 2 (FETCH_OP_DEREF) succeeds and loads
val =3D 0, and the fault happens on the final dereference in stage 3
(FETCH_OP_ST_MEM), where dest points to the ring buffer field.

However, if a chain has another dereference after the NULL pointer (such as
"(task_struct)prev->mm->exe_file->f_inode" when prev->mm is NULL), the
fault happens in stage 2:

kernel/trace/trace_probe_tmpl.h:process_fetch_insn_bottom() {
    ...
stage2:
	/* 2nd stage: dereference memory if needed */
	do {
		lval =3D val;
		switch (code->op) {
		case FETCH_OP_DEREF:
			ret =3D probe_mem_read(&val, (void *)val + code->offset,
					     sizeof(val));
			break;
		case FETCH_OP_UDEREF:
			ret =3D probe_mem_read_user(&val,
				 (void *)val + code->offset, sizeof(val));
			break;
    ...
		}
		if (ret)
			return ret;
    ...
}

Here probe_mem_read() only zeroes the stack variable val, and
process_fetch_insn_bottom() returns early before reaching stage 3.
Because store_trace_args() ignores a negative return value from
process_fetch_insn(), the destination field in the ring buffer is never
written to and retains stale ring buffer data (or, for a dynamic string
argument, keeps the pre-initialized *dl =3D make_data_loc(maxlen, ...)
header without calling set_data_loc()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111050322.49bb=
ebfa@fedora?part=3D1
