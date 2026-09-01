Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F12F7F0F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221776; cv=none; b=gWNI2K9uLjufzf367s8htinyk1vjHcmkGcZp0rLR0xEcuMiDdrRJQALbTBbCSCoRmR/xZS3I+Ioyu65LgaLJlay79yeMM6V50+O7MFzjmTbpB1dgrx6YMsrRvofFBAnku+/SUJTEWS6n0tehIohs2GlbgTOimVoLNmDJFFba+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221776; c=relaxed/simple;
	bh=IzaWq35h5zR1LoMSbNBCxn1jMHRdg30RP2CzM9mUHdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgKZJCInW5ouSQjg/FnHHT4CtIQzyqkYH0K9b6aDlPmlDS/KSXyl/x7pNbwS7yeMcMcaHEF5o5Y34IAEc80XzIEJyXXuuvWdxmPzKWEUd2Rr+tklEtKTrcBAYl4wRd/epmrtfUs+KrK1HJNaqACW3Wj+bu+RDlkySM3vYnqyCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO47QjLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO47QjLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D451F000E9;
	Tue,  1 Sep 2026 00:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788221775;
	bh=bw/T5vCGqUReV+hxML0ofGYXQfQq1dVfHQEdNGJO0nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iO47QjLykw1+IlFV4MUvwVYbAvGL9OcL4qi+cfpLeNSx8N/lEN4Hd69bjNsbHjGCG
	 T6gbbQAfFAeGZEW3ML0iZt9j0XLpn9wjSeBThH71V4yA8nq/TeoFAK2soTbwQrs1G8
	 dlHWuaH3Oq33B8ckGevngku87fkxQUNjqwPUvNvpvGdzwHfgVV6uX7SNpbSeN1aJFF
	 o7E3EJYmTCtzRwVxTFW46ypLx9XuGlcxeuIuGKcV5TLhBJ3dZo7xVCjis7b+Vcki1S
	 4dhZcyE/NhVnbrxBfvmK7ucUM9vS3yB4PNaeGW9LIE41eOfxUlF+rsYfp5Ybm+KSEj
	 Nq+TR+8LpzVOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:16:14 +0000
Message-Id: <20260901001614.D5D451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of PG_private safety check causes leaked filesystem privat=
e data to go undetected.
--

commit 9b27f18c6460a8f0a47a836096a558c0ddbb879d
Author: Zi Yan <ziy@nvidia.com>
Subject: mm/page-flags: remove PG_private

This patch removes the PG_private flag and repurposes its space as
__PG_folio. It replaces the flag checks with checking if
folio->private !=3D NULL to determine if a folio carries private data. It
also updates relevant documentation to reflect these changes.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index ae2ebaed6d4d9..02e67307ffff4 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
[ ... ]
> @@ -1169,7 +1170,7 @@ static __always_inline void __ClearPageAnonExclusiv=
e(struct page *page)
>   */
>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
> +	 1UL << PG_private_2	|				\
>  	 1UL << PG_writeback	| 1UL << PG_reserved	|	\
>  	 1UL << PG_active 	|				\
>  	 1UL << PG_unevictable	| __PG_MLOCKED | LRU_GEN_MASK)

[Severity: High]
Does removing PG_private from this mask cause leaked filesystem private data
to go undetected?

By removing the PG_private check without adding a replacement check for
folio->private !=3D NULL on the head page, the memory allocator's validation
routines no longer catch this leak.

Instead, when a buggy filesystem or subsystem frees a page with a non-NULL
private field, free_pages_prepare() in mm/page_alloc.c will unconditionally
zero it without warning:

mm/page_alloc.c:free_pages_prepare() {
    ...
    page->flags.f &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
    page->private =3D 0;
    ...
}

Could this silently erase the leaked private data (such as buffer heads) and
mask the underlying memory leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-remove-pg_=
private-v2-0-3668159cd9e8@nvidia.com?part=3D14
