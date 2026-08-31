Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0B3DE426
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218477; cv=none; b=QzqCMIJP70Rjd6yxFbbTLDcIE0103ZJ2D+oVfuhub2poS8C9PtS6ZHmyEFh+Zr9UZf4FyOQLLHwzK30ggsfrWbjI7NEEM2DLG1uzg0hu7k2y/NCezPitxkroIZ2/jBTzsAx4nTQ+0ixsZD6PSi8gI2Uk44Hc1y9/bJqMkYZrYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218477; c=relaxed/simple;
	bh=jaGAX0TiX5UVA3ZUaS23f5isld/8Jdo1ukXTyaRLKxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kHa0AD32/SC2+tID3l0AHbJX6iGAXpJxS0uXgiggHwhc6dlljVU4UbkZyJBJBi0/io+oQaIYPRMfXAAarLzVxG9r2PQTqShcePenTe/96eD9Y+R1Tl+MUCRX3KdzjIdGohHObjUMqrjoKwdIKcO5YoYeQhe5DNgs7B25qhiomQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+xFSRzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+xFSRzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430C41F000E9;
	Mon, 31 Aug 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218474;
	bh=O3fd7QZwnhFBL19nw8h13iElUZdhY36zypaaOrWt7Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+xFSRzEokWUB1/hvLSWLdBIaUkA5VMgbGZtc96uE9LfZrrT/PS3CAzj/ucKxrfvy
	 cBy3TM0ASd7rQAlo8MKdqBnI/eZ+3TV+fxHQfZSZhcOF6d2kg24qh00Ksnz2AtNlbc
	 wzS5u2ijqKXgOrMR0dOTWWpsafGmgJMwTAPmnKb3kXJwonbMRt30GKrz9YrDfsPU4A
	 fePRhh0SpuMXDGDgHCr4gbu/SW1hGlDDVkZwje6dEN/7UnCusCmq7V6k/mxNxDgqfG
	 ZrC1SwxcXDyJMFvmVkjxI88X5y5f4DjzsTHy+KpEx+lnQBnw1Q4jVLua9FHs6Z2RLt
	 4TrCAP8CyHrTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] mm/page-flags: check page/folio->private
 instead of PG_private
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831-remove-pg_private-v2-9-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-9-3668159cd9e8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:21:13 +0000
Message-Id: <20260831232114.430C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Lockless TOCTOU race in `folio_expected_ref_count()` miscalculates=
 expected references for shmem folios during swap cache removal, allowing `=
F_SEAL_WRITE` to bypass GUP pins.
- [Low] Lockless reads of `folio->private` via `folio_test_fs_private()` la=
ck `data_race()` or `READ_ONCE()` annotations in several paths, triggering =
KCSAN warnings.

Pre-existing issues:
- [High] In `migrate_folio_unmap()`, an orphaned folio with private data is=
 blindly assumed to have `buffer_head`s, causing a type confusion crash for=
 filesystems that use other structures.
--

commit cfacca810fa1b9878c94f6054258d5e3c3b6824f
Author: Zi Yan <ziy@nvidia.com>

mm/page-flags: check page/folio->private instead of PG_private

This patch changes the kernel to check page/folio->private instead of=20
PG_private, except for swapcache and hugetlb folios. It annotates
folio_expected_ref_count to prevent data races and removes KPF_PRIVATE.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a9fbe26536f45..8be6399a5e4a0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -3050,10 +3050,18 @@ static inline int folio_expected_ref_count(const =
struct folio *folio)
>  	ref_count +=3D folio_test_swapcache(folio) << order;
> =20
>  	if (!folio_test_anon(folio)) {
> -		/* One reference per page from the pagecache. */
> -		ref_count +=3D !!folio->mapping << order;
> -		/* One reference from PG_private. */
> -		ref_count +=3D folio_test_private(folio);
> +		/*
> +		 * One reference per page from the pagecache.
> +		 * Use data_race() since folio might not be locked.
> +		 */
> +		ref_count +=3D !!data_race(folio->mapping) << order;
> +		/*
> +		 * One reference from filesystem private data.
> +		 * Use data_race() since folio might not be locked.
> +		 */
> +		ref_count +=3D data_race(folio_test_private(folio)) &&
> +			     !folio_test_hugetlb(folio) &&
> +			     !folio_test_swapcache(folio);

[Severity: High]
Could this lockless evaluation of folio->private and PG_swapcache lead to a
TOCTOU race for shmem folios during swap cache removal?

During __delete_from_swap_cache, folio->swap.val (which aliases
folio->private) is cleared before PG_swapcache. Without memory barriers, a
lockless reader like memfd_tag_pins calling folio_expected_ref_count could
observe the stale non-zero folio->private and the newly cleared PG_swapcach=
e.

This would evaluate the condition above as true, falsely inflating the
expected refcount by 1. If the folio has exactly one extra GUP pin, the
inflated expected refcount would match the actual refcount, bypassing the
F_SEAL_WRITE protections.

>  	}
> =20
>  	/* One reference per page table mapping. */
> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagema=
p.h
> index 36c3a90f0acca..fb9abec40ec79 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -22,7 +22,9 @@
>  	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
>  	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
>  	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
> -	(folio_test_private(folio)	? PAGEMAP_BUFFERS    : 0) \
> +	(folio_test_private(folio) && \
> +	 !folio_test_swapcache(folio) && \
> +	 !folio_test_hugetlb(folio)	? PAGEMAP_BUFFERS    : 0) \

[Severity: Low]
Should this lockless read of folio->private be annotated with data_race() or
READ_ONCE()?

Since tracepoints like TRACE_EVENT(mm_lru_insertion) are often executed
without the folio lock, concurrent modifications to folio->private could
trigger KCSAN data race warnings here.

>  	)
> =20
>  TRACE_EVENT(mm_lru_insertion,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 54494c3fa9835..5f2964a5fffbb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4858,7 +4858,9 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
>  		 * will try to drop it before split and then check if the folio
>  		 * can be split or not. So skip the check here.
>  		 */
> -		if (!folio_test_private(folio) &&
> +		if (!(folio_test_private(folio) &&
> +		      !folio_test_swapcache(folio) &&
> +		      !folio_test_hugetlb(folio)) &&

[Severity: Low]
Can this similarly trigger a KCSAN data race warning?

This block in split_huge_pages_pid checks the private flags locklessly befo=
re
folio_trylock is called, so reading folio->private here without data_race()
could cause issues.

>  		    folio_expected_ref_count(folio) !=3D folio_ref_count(folio))
>  			goto next;
> =20
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a369d0c95c386..9d6c8b6f57475 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1327,7 +1327,8 @@ static int migrate_folio_unmap(new_folio_t get_new_=
folio,
>  	 * free the metadata, so the page can be freed.
>  	 */
>  	if (!src->mapping) {
> -		if (folio_test_private(src)) {
> +		if (folio_test_private(src) && !folio_test_swapcache(src) &&
> +		    !folio_test_hugetlb(src)) {
>  			try_to_free_buffers(src);

[Severity: High]
This is a pre-existing issue, but does this generic migration code blindly
assume all private data on an orphaned folio corresponds to buffer heads?

If a folio is orphaned after truncation (src->mapping is NULL) but retains
private data because an earlier release failed, try_to_free_buffers is
unconditionally called. For filesystems like iomap, folio->private contains
custom structures (like iomap_folio_state), not a linked list of buffer
heads. Calling try_to_free_buffers here could lead to type confusion and a
kernel panic when accessing what it expects to be bh->b_this_page.

>  			goto out;
>  		}
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eeab25d6ce364..4022d6c381896 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2705,7 +2705,10 @@ bool filemap_dirty_folio(struct address_space *map=
ping, struct folio *folio)
>  	if (folio_test_set_dirty(folio))
>  		return false;
> =20
> -	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
> +	__folio_mark_dirty(folio, mapping,
> +			   !(folio_test_private(folio) &&
> +			     !folio_test_swapcache(folio) &&
> +			     !folio_test_hugetlb(folio)));

[Severity: Low]
Is a data_race() annotation missing here as well?

Functions like filemap_dirty_folio can be called locklessly (for example,
from zap_pte_range with only the pte lock held), resulting in an unannotated
read of folio->private that might race with concurrent modifications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-remove-pg_=
private-v2-0-3668159cd9e8@nvidia.com?part=3D9
