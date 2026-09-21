Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC57321F5F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958666; cv=none; b=ZHpBQP30pEacWlvYMlP/o4chf2/NGySQFSwEI+MhZiKz49UQrckwTWNXoJnG6t1k9eIeDycVvqS23xL3gqW/Y68Q4j/3wkVQ4VWhofGWATBgmicZQXLx0yG9G/M6a0QEw9BDkVrI9LqiP6JcYyNLyi3TTZ/n53+oJYLkQrMpYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958666; c=relaxed/simple;
	bh=Q0SL86Hucoq2YT5f0OtAE/vZ/+VgNrysyDWUna50Ha0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HtZPh5bRqK5Fgksl2NTELtRcAtAu8ZbhU1MQbC04gc5q/z5MzhTszVYKuLLUN4QB2QZ0mE/qi74o/27BWMvtxsWkJNSI1BrcTX2R0/Cs1Sb3h+At1eaWmeg3I+eGQT0Kwq4H0i2I5i0degXC/Lsl2wGHNoaIIYqamhJaJfqy+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb7K5Cj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb7K5Cj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F951F000FF;
	Mon, 21 Sep 2026 02:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789958665;
	bh=nEMJv9geylp793uC0MDXMRXVK22ALw1G/Xp+3Zm/glg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gb7K5Cj7hUoowcRXkhnt/GdZgkjr8zkupAbaS46BwkZ2zOyqOo4zfagdyGIUum5fF
	 pdUtGyI98UeaeFxTdEWR3EElXZYdD8RjJdgA2y19dAMwzCNJcZ2ZoSNpOcvR/Xc1RC
	 ncgfLCODT17e1+gle27h80okNOo9klydccpgJRbWcd//+a7NDZCYjwrejjBz5kki+W
	 AmaEHBKuuqW7pBGq6sDqLIQtZouGVV2rcmtn1FWnUwpt2pGV/8sN5a2IPQ+HvgvTi6
	 p1qnMN7LM/Gm1zmyXvLFfBWb+abWgUbgjT0V6ZroY6LBr9/+/ID7WjGab5gbvqayA0
	 tFetcbYsAXTVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] mm/page-flags: check page/folio->private
 instead of PG_private
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260920-remove-pg_private-v5-10-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-10-bb68b6a21869@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:44:24 +0000
Message-Id: <20260921024424.F0F951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: silent loss of memory leak detection for page->private on head=
 pages at free time
- [Medium] mm: removal of KPF_PRIVATE from /proc/kpageflags breaks userspac=
e ABI
--

commit 11221906706fcf50f2069964f35b9ce234eeabe6
Author: Zi Yan <ziy@nvidia.com>

mm/page-flags: check page/folio->private instead of PG_private

After the changes of the prior commits, page/folio->private !=3D NULL is now
equivalent to checking PG_private. Stop checking PG_private on pages and
folios and use page/folio->private instead, except swapcache and hugetlb.

> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 260772b20bd99..f90e1030825e9 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -232,7 +232,6 @@ u64 stable_page_flags(const struct page *page)
> =20
>  	u |=3D kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>  	u |=3D kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
> -	u |=3D kpf_copy_bit(k, KPF_PRIVATE,	PG_private);

[Severity: Medium]
Does removing the KPF_PRIVATE bit from stable_page_flags() break the
userspace ABI?

Any userspace tool or script relying on this bit to identify private pages
will silently fail to detect them. Could this be preserved by computing it
via folio_has_attached_private(folio) instead?

[ ... ]

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7080a6a1a79e7..6d839f50bdcb7 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h

[ ... ]

> @@ -1169,7 +1191,7 @@ static __always_inline void __ClearPageAnonExclusiv=
e(struct page *page)
>   */
>  #define PAGE_FLAGS_CHECK_AT_FREE				\
>  	(1UL << PG_lru		| 1UL << PG_locked	|	\
> -	 1UL << PG_private	| 1UL << PG_private_2	|	\
> +	 1UL << PG_private_2	|				\

[Severity: High]
Does removing PG_private from PAGE_FLAGS_CHECK_AT_FREE mask memory leaks
of filesystem private data for head pages?

Any buggy filesystem or driver that frees a page with an attached
page->private structure will silently leak it without a kernel warning.
In mm/page_alloc.c, __free_pages_prepare() unconditionally executes:

    page->private =3D 0;

Since PG_private was removed from PAGE_FLAGS_CHECK_AT_FREE, there is no
longer a check that page->private was zero before this assignment, meaning
the leaked pointer is zeroed out for the head page without any validation
or warning.

The equivalent explicit check for tail pages was preserved, indicating the
loss of the head page check might be an unintended oversight when removing
the flag.

[ ... ]

> diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
> index 7fc5a8be5997f..47e4781c5fc38 100644
> --- a/tools/mm/page-types.c
> +++ b/tools/mm/page-types.c

[ ... ]

> @@ -131,7 +130,6 @@ static const char * const page_flag_names[] =3D {
>  	[KPF_RESERVED]		=3D "r:reserved",
>  	[KPF_MLOCKED]		=3D "m:mlocked",
>  	[KPF_OWNER_2]		=3D "d:owner_2",
> -	[KPF_PRIVATE]		=3D "P:private",
>  	[KPF_PRIVATE_2]		=3D "p:private_2",

[Severity: Medium]
Does removing the flag name from page_flag_names in page-types.c break
parsing tools relying on the P:private designation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-pg_=
private-v5-0-bb68b6a21869@nvidia.com?part=3D10
