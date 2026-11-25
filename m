Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624267;
	b=cszt6kP2Op0oJrs/5R+GcqfyggjSHWQdBBIUE0mLznlJ5/Sg/70Sxia6MyFK+GgcIo4Z
	 7hNzoAOwSJBJA7Xvn1uCGIslYa0TQR7Mn5fR9aWkUSpDdcTzkUKOuwT8jaF3DA4QP1b1v
	 rkLE2JXDof/s11yJCM3WjjHtF/M87pz2SyTK4Kw7BMy6cD14uM1dx4B7e6f4ksIU07lh/
	 KnpqRFsA1CPb1IbL4TD5df9jY2r3+NEnVMP8hGCtmq64V5vKgTbZ8wphzS+NvQ8iEH0GC
	 TupDDrcVUs6E6bsIRcY3v2vqM7Q2ug5rdAMoj74QptYbq8Tub9ZkVdsmJzOYi+Di/nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qLNfRh9n2WoyG25XFd6o+s8WLTwwx5OjofQgK7ES9+M=;
	b=LTwxAq1tiGeVXMnExZYzI24cJzVqAwdnu3UHZLgVKAhYl+WQFKMLFyaHCTOMAFZoBHPb
	 xqAn6oFcXPnsOIVjE4F4WOco8FrLr/y0nqAZGQ/B/kiO9ldJQ0mAAXviHFaNCF13KUrbY
	 fz2ntdW9PB+jwlQR7E7HF4HIXVEtFtaXCxppEkCCLmgwS3ztUcdd+ccUhjEVT4gokYmWW
	 tAcYgO+EG4+H7rlcGWGxc9tYWrWaLhrmOJb3F1zosirZArd1xIXPLLJ9fBZaFDZpuBTU7
	 jw/X9SzV//JlNfJqmlqg2J8NWrRgbGwBEM0yhAlkuJLEuAyXjskOwuqIaCezucWFWpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nox4gpVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6D606A332
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nox4gpVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4989A1F000C0;
	Wed, 25 Nov 2026 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624267;
	bh=qLNfRh9n2WoyG25XFd6o+s8WLTwwx5OjofQgK7ES9+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nox4gpVMxLJliiVHQ0diMgPhJ3uNTyF+eM6MArXrjDxUCxSO5UW7hKBUHi3ItkKRd
	 xghw+mfUc4zvrH2ZGNQWZWn7t0GbgHRg4jrGPHFsd3APopjepo9S0P7yD8NQuVdRjw
	 NYyCbFeRV5mFd8It0K3chEspp6am0RgFuXA0RmdvjvtpPHcwdXKaPP3zXQ6OwQMMq/
	 HBownIQGw4RNMnp0BQbjHMEu4Bj/oMMuzPJotfgkR6A9LxyyIFby6V6Mx8StKlz+8b
	 UCaZ08Qm4CDQY2TG3JXvjkR3gRuitW0/PxHWsje15U+4LSj17qOZJBNa/uYN1xyLPM
	 gOuYgqXJ6mmnw==
Message-ID: <sashiko-outbox-233758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] riscv: probes: reject probes inside an LR/SC
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261125-probes-in-lrsc-v5-2-38a32e53fcc2@mobileye.com>
References: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
 <20261125-probes-in-lrsc-v5-2-38a32e53fcc2@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:31:06 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] riscv: probes: premature return in riscv_probe_in_lrsc_body()
  on branch exit
- [Medium] riscv: probes: uprobe_in_lrsc_body() accepts probe when first
  page read fails
--

commit a67fed45f5b4b65e5ea0692a072a54d9eda46839
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: probes: reject probes inside an LR/SC sequence

This commit rejects kprobes and uprobes placed inside a constrained LR/SC
sequence by scanning forward through reachable instructions for an SC
instruction.

> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b8882..cfc59964cda88 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -4,11 +4,182 @@

[ ... ]

> +bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
> +{
> +	bool reachable_idx[RISCV_LRSC_SCAN_BYTES / 2] =3D { false };
> +	int idx =3D -1;
> +
> +	reachable_idx[0] =3D true; /* instruction at idx 0 is reachable */
> +	len =3D min(len, RISCV_LRSC_SCAN_BYTES);
> +
> +	if (len < 4) /* SC is 32 bit instruction */
> +		return false;
> +
> +	for (;;) {
> +		s32 imm;
> +
> +		/* find next nearest reachable idx */
> +		while (++idx < ARRAY_SIZE(reachable_idx) && !reachable_idx[idx])
> +			;
> +		if (idx >=3D ARRAY_SIZE(reachable_idx))
> +			return false;
> +
> +		/* fetch full instruction, 16 or 32 bit */
> +		size_t off =3D idx * 2; /* buffer offset in bytes */
> +		u32 insn =3D buf[idx];
> +		size_t insn_len =3D GET_INSN_LENGTH(insn);
> +
> +		if (insn_len =3D=3D 4) {
> +			if (off + 4 > len)
> +				return false;
> +			insn |=3D (u32)buf[idx + 1] << 16;
> +		}
> +
> +		/* Validate current instruction */
> +		/* If we hit an SC, the forward path successfully completes the atomic=
 block */
> +		if (riscv_insn_is_sc(insn))
> +			return true;
> +
> +		if (idx =3D=3D 0) {
> +			if (!riscv_insn_is_lr(insn) && !riscv_insn_is_lrsc_body(insn))
> +				return false;
> +		} else {
> +			if (!riscv_insn_is_lrsc_body(insn))
> +				return false;
> +		}

[Severity: Medium]
Should the idx > 0 check (and the off + 4 > len check above) use continue
instead of return false so that hitting a non-body instruction on one branch
path does not abort the scan of other pending entries in reachable_idx[]?

When a conditional branch inside an LR/SC loop jumps forward to the sc block
and falls through to an exit instruction such as ret (for example: 0: lr.w =
a0,
(a1); beq a0, a2, 1f; ret; 1: sc.w a3, a4, (a1); bnez a3, 0b), reachable_id=
x[]
has both the fallthrough exit and the forward target marked. Because the lo=
op
visits lower indices first, it hits ret before 1: sc.w and returns false
immediately, allowing a probe inside the LR/SC sequence that livelocks when
the branch to sc is taken.

> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index eb177d0ce8ab0..d97a102621665 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -28,6 +28,34 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *reg=
s)
>  	return instruction_pointer(regs);
>  }
> =20
> +/*
> + * Is the instruction at addr inside a constrained LR/SC sequence? Only =
the
> + * probed instruction was copied, so read the text that follows it from =
the
> + * task. The caller holds mmap_lock, as uprobe_write_opcode() requires t=
oo.
> + * Text that cannot be read ends the scan early, which accepts the probe.
> + */
> +static bool uprobe_in_lrsc_body(struct mm_struct *mm, unsigned long addr)
> +{
> +	u16 buf[RISCV_LRSC_SCAN_BYTES / sizeof(u16)];
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	size_t got =3D 0;
> +	int len;
> +
> +	while (got < sizeof(buf)) {
> +		len =3D min_t(size_t, sizeof(buf) - got,
> +			    PAGE_SIZE - offset_in_page(addr + got));
> +		page =3D get_user_page_vma_remote(mm, addr + got, FOLL_FORCE, &vma);
> +		if (IS_ERR(page))
> +			break;
> +		uprobe_copy_from_page(page, addr + got, (void *)buf + got, len);
> +		put_page(page);
> +		got +=3D len;
> +	}
> +
> +	return riscv_probe_in_lrsc_body(buf, got);
> +}
> +
>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_stru=
ct *mm,
>  			     unsigned long addr)
>  {
> @@ -53,6 +81,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprob=
e, struct mm_struct *mm,
>  		return -EINVAL;
>  	}
> =20
> +	if (uprobe_in_lrsc_body(mm, addr))
> +		return -EINVAL;
> +
>  	return 0;
>  }

[Severity: Medium]
What happens if get_user_page_vma_remote() fails on the first page (got =3D=
=3D 0)?

Breaking out of the loop passes got =3D=3D 0 to riscv_probe_in_lrsc_body(),=
 which
returns false because len < 4 without checking even the already-copied
instruction in auprobe->insn. arch_uprobe_analyze_insn() then returns 0 and
prepare_uprobe() permanently sets UPROBE_COPY_INSN on uprobe->flags, so lat=
er
installations of this uprobe skip prepare_uprobe() and arm the breakpoint
even if the probed instruction sits inside an LR/SC loop or directly on an =
sc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-probes-in-=
lrsc-v5-0-38a32e53fcc2@mobileye.com?part=3D2
