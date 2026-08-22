Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9F23D2A1;
	Sat, 22 Aug 2026 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407860; cv=none; b=t2fLHK/FHygwCO0BDNF8GIfT3nP14hdaIYb6ZzAzHOu1IuOiNu35R7hveTbTM9M//YrqJ3RrahGt7fDtKrwn10p32qjfsjvLB7d/KcI8jERysUoCGnZ7BXK8CZd340OBf/D6C1OLN4cA+mRNN1AvVlio1G0xmTYP04cX1PYitQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407860; c=relaxed/simple;
	bh=kbtzcL5cHPia9PlKij41oovwD+w5VvRynWSKiyMfk8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C8Ii1rX36DN+JF1QFWvCV6GJ+03+G4jChjL/lpQTSWDEIVaE3A9mScZwum+qT3ywRwf2ItKpsUM4iQ3lvuJ8+FdTcPRSawWZIvpSmzFM/nRkFwxwF42dQtS0rNDgQ64QC8Fl30c2cPOfWh4oyg2YnN7RiiS+2NCjJdsZv15/B6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0dY7L+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0dY7L+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24451F000E9;
	Sat, 22 Aug 2026 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787407858;
	bh=RuCRdo5ufXFyjX5OqYiaj1ZQB4yzXMPz59E45z8w+GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0dY7L+rk7/k9MbFLRP3tAGoD07hwhDo5IbOWfW/yjwr9F+U8F0w2s5d1hRujZKny
	 LML+3ttUm1fogvXOY44dscwXZCgyCtJy9UvHvK/U3sicrjMhrvzeYQvoXgMUPp9Gnm
	 pZ2J6LS3cmAHpojgv/FcSFtjzVS5Uw803R40ZrdHjjcaucPnNSgih0hkRh0wCJ7JYZ
	 MYA4w7eLJ/XldaTDng12e9xQQrnKTyIcI095CDkykvNaCj7/8ciYLu+Up1CeL9GlEM
	 ILuf3sMrM/7HLidCd/nrwuq/EMucPpyC2BEuFGPG2lh1iYjETtqBXDXQaOShNX40A0
	 Ni6aOQJssNiTA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/9] arm64: mm: Permit permissions changes on huge
 vmappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260822135323.795946-16-ardb+git@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-16-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:10:57 +0000
Message-Id: <20260822141057.D24451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Live splitting of huge vmalloc mappings silently fails and trigger=
s a kernel warning.
- [High] Permission changes on small, PTE-mapped vmalloc areas are incorrec=
tly rejected.
- [High] Improper use of `WARN_ON_ONCE` for a hardware capability check cau=
ses unwarranted kernel log spam and potential panic.
- [Low] Implicit declaration of function `system_supports_bbml2_noabort()` =
breaks the build.
--

--- Patch [5]: [RFC PATCH 5/9] arm64: mm: Permit permissions changes on hug=
e vmappings ---
commit e67f32e911a059a6f372cf2818088d9fde53ee7f
Author: Ard Biesheuvel <ardb@kernel.org>

arm64: mm: Permit permissions changes on huge vmappings

This commit allows permission changes on huge vmappings without splitting
when the region is PMD-aligned or when the system supports live splitting.

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index bbe98ac9ad8c6..20ff9cb273c11 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c

[ ... ]

> @@ -179,7 +177,16 @@ static int change_memory_common(unsigned long addr, =
int numpages,
>  	if (!area ||
>  	    ((unsigned long)kasan_reset_tag((void *)end) >
>  	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
> -	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) !=3D VM_ALLOC))
> +	    !(area->flags & VM_ALLOC))
>                 return -EINVAL;
> =20
> +	/*
> +	 * Disallow VM_ALLOW_HUGE_VMAP mappings unless the region is PMD
> +	 * aligned, or splitting live huge mappings is supported.
> +	 */
> +	if ((area->flags & VM_ALLOW_HUGE_VMAP) &&
> +	   ((start % PMD_SIZE) || (size % PMD_SIZE)) &&
> +	   WARN_ON_ONCE(!system_supports_bbml2_noabort()))

[Severity: Low]
Does the function system_supports_bbml2_noabort() exist in the codebase? It
appears to be missing a definition or declaration, which might cause the
kernel to fail to compile due to an implicit function declaration.

[Severity: High]
Is WARN_ON_ONCE() the right choice for a hardware capability check here?

If an unaligned permission change is requested on an older system lacking
BBML2 support, this will trigger a warning stack trace. If panic_on_warn
is enabled, an unprivileged user loading a BPF program could trigger a
kernel panic. Should this condition fail silently instead?

[Severity: High]
Does checking area->flags & VM_ALLOW_HUGE_VMAP incorrectly reject small,
PTE-mapped vmalloc areas?

Allocators like execmem use VM_ALLOW_HUGE_VMAP as an allocation hint. If
an allocation is smaller than PMD_SIZE, it falls back to PTE mappings but
retains the VM_ALLOW_HUGE_VMAP flag in area->flags.

When change_memory_common() processes this on older hardware without
BBML2, it sees the flag alongside an unaligned size, and rejects the
request with -EINVAL, even though the page table is already PTE-mapped
and requires no splitting.

Should we check the actual page table granularity, such as inspecting
area->page_order, instead of just the allocation flag?

[Severity: High]
If this condition passes because system_supports_bbml2_noabort() is true,
will the PMD actually be split later?

change_memory_common() delegates to __change_memory_common() which
calls update_range_prot() and eventually split_kernel_leaf_mapping().

Looking at split_kernel_leaf_mapping() in arch/arm64/mm/mmu.c:

if (!linear_map_requires_bbml3 || is_kfence_address((void *)start))
    return 0;

if (!system_supports_bbml3()) {
    ...
    return 0;
}

This evaluates system_supports_bbml3() and linear_map_requires_bbml3,
ignoring both the BBML2 capability and the vmalloc context. If those are
false (for example, if rodata is off), it returns 0 without splitting the
PMD.

The subsequent lockless page table walk would then encounter an unsplit PMD
spanning a larger range than requested, resulting in a warning and a
failure.

> +		return -EINVAL;
> =20
>  	if (!numpages)
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822135323.7959=
46-11-ardb+git@google.com?part=3D5
