Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2A34FF79;
	Sat, 22 Aug 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407818; cv=none; b=L2w+VtV+aAAGoidr0Kz6D4frUVngIkA3c5KWWTAJIUuPuRXTm7QFFIEPeUXU7eYU1SMYex9cgfEPpooOHdYEYI3zSrMYazMB1RFL0uKqUYpCyHwKZxH/doyxEy/EEz699xAkjYKisb0HNEPXwWRLwvrpM+e8TtS78c/3PiDj+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407818; c=relaxed/simple;
	bh=f0IunGG2mGbzG+N94BDdOsd2YEWHXsg9H9umn9tRI2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A7Cx1OULfNT1HrR6G/BuzSLhR2apIuxNfP1e+/uE+e9bo4FzyIJr4bW9tkzyYV/KAVfv6zgKB1GaFc5u+SQaafXBMSECqi7m2effpfrXUH72Kl/YH2+BofttvW1szlr4q9hUS4i2IOGbjrxYyAeXDaI4U8pVHUOCi2wbmrmtpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKES40kc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKES40kc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199431F000E9;
	Sat, 22 Aug 2026 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787407817;
	bh=kMFgtJl0mk+tMHD4wQ/xs5aEuXPF1zOFLmpN9FpZFbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EKES40kcFoSiwLfV2VGt28mqAsrjf74agB9bao2M3Co50u7+z8zYj/U0b2T+l4ACP
	 e1prRsM6ZKmIHB1EycecMf0snW0hZV708pAH5RITyekt3Y1jgVmkkkPJVfFnV1sM0X
	 x7oUnSKB0dZF1UHl84pxYwa8oKLrYXRuaJnBLkX0yrdOCzTeynQBw1hFtSs4fz0SYL
	 q2nidp2iUM3rnJWlRbjn94dZhcVJDZJJVq1SxP/8ErPGET/R8f23on8v1+3/3UI+Vt
	 ejR/tYgcgF4AbKLybrfVmu2HC5dkCtgTsM0ALw6gT8+QC9qlJTe2xrTn3K1XGwPF3z
	 aQim0HUrvF9JQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/9] mm: execmem: Allow huge vmappings to be avoided
 for execmem caches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260822135323.795946-13-ardb+git@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-13-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:10:16 +0000
Message-Id: <20260822141017.199431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Omitting VM_ALLOW_HUGE_VMAP breaks the ROX cache shrinker by strip=
ping PMD_SIZE alignment, causing a permanent memory leak of cached module m=
emory.

Pre-existing issues:
- [High] Fallback allocations in execmem_cache_populate_alloc() leak memory=
 due to failing the PMD_SIZE alignment checks in the cache shrinker.
- [High] Ignored return value of execmem_restore_rox() allows memory to be =
silently returned to the ROX cache with RW permissions.
--

--- Patch [2]: [RFC PATCH 2/9] mm: execmem: Allow huge vmappings to be avoi=
ded for execmem caches ---
commit 3d4b59f7ca74d71807be337626018d273686c686
Author: Ard Biesheuvel <ardb@kernel.org>

mm: execmem: Allow huge vmappings to be avoided for execmem caches
   =20
Only recent arm64 systems are guaranteed to be able to manipulate the
permissions on live kernel mappings that may use huge mappings. Older
ones can only do so on live mappings that are mapped down to pages.

In order to make execmem caches work on arm64 despite this distinction,
allow huge vmappings to be omitted when allocating the caches.

> diff --git a/mm/execmem.c b/mm/execmem.c
> index 6db0c1d82a9d6..5790d4a8532af 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -276,7 +276,8 @@ static void *__execmem_cache_alloc(struct execmem_ran=
ge *range, size_t size)
> =20
>  static void *execmem_cache_populate_alloc(struct execmem_range *range, s=
ize_t size)
>  {
> -	unsigned long vm_flags =3D VM_ALLOW_HUGE_VMAP;
> +	unsigned long vm_flags =3D (range->flags & EXECMEM_NO_HUGE_VMAP)
> +						? 0 : VM_ALLOW_HUGE_VMAP;

[Severity: High]
Does dropping VM_ALLOW_HUGE_VMAP here cause a permanent memory leak in the
ROX cache?

When VM_ALLOW_HUGE_VMAP is omitted, the allocation may fall back to the
standard alignment (typically PAGE_SIZE) instead of being PMD_SIZE aligned.=
=20

However, the shrinker in execmem_cache_clean() strictly requires PMD_SIZE
alignment to free the memory:

mm/execmem.c:execmem_cache_clean() {
	...
	mas_for_each(&mas, area, ULONG_MAX) {
		size_t size =3D mas_range_len(&mas);

		if (IS_ALIGNED(size, PMD_SIZE) &&
		    IS_ALIGNED(mas.index, PMD_SIZE)) {
			struct vm_struct *vm =3D find_vm_area(area);
	...
}

If the starting address (mas.index) of the chunk allocated without
VM_ALLOW_HUGE_VMAP is not PMD_SIZE aligned, the shrinker will skip it,
never returning it to the vmalloc subsystem.

>  	struct mutex *mutex =3D &execmem_cache.mutex;
>  	struct vm_struct *vm;
>  	size_t alloc_size;
> 	int err =3D -ENOMEM;
> 	void *p;
>=20
> 	alloc_size =3D round_up(size, PMD_SIZE);
> 	p =3D execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> 	if (!p) {
> 		alloc_size =3D size;
> 		p =3D execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);

[Severity: High]
This is a pre-existing issue, but does this exact-size fallback allocation
leak memory for the same reason?

If the PMD_SIZE rounded allocation fails under pressure, the fallback
allocates the exact requested size. Since this fallback size is not
guaranteed to be PMD_SIZE aligned, it will also permanently fail the
IS_ALIGNED(size, PMD_SIZE) check in execmem_cache_clean(), leaking the
vmalloc space.

[ ... ]

> static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gf=
p_mask)
> {
> 	size_t size =3D mas_range_len(mas);
> 	int err;
>=20
> 	err =3D execmem_force_rw(ptr, size);
> 	if (err)
> 		return err;
>=20
> 	execmem_fill_trapping_insns(ptr, size);
> 	execmem_restore_rox(ptr, size);
>=20
> 	err =3D execmem_cache_add_locked(ptr, size, gfp_mask);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to ignore the
return value of execmem_restore_rox() here?

If restoring the ROX permissions fails (for example, if set_memory_rox() fa=
ils
internally), the chunk is still added back to the free_areas tree. Subseque=
nt
allocations could then receive memory that is still writable, silently brea=
king
the W^X security guarantee.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822135323.7959=
46-11-ardb+git@google.com?part=3D2
