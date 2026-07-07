Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AB41D4D7;
	Tue,  7 Jul 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431897; cv=none; b=BKxYRgYqXlPo8NzSKXOm2khMrEFXnIGgiYlMnlkCBKB1UqlvLHGoCFWlVcIFXRIvmvcZZG4Ilmgx1cStGtRiHaQbjTkutQP2YKRT4cK+mo/gktydoYZLdwfijTKDn9exY8UgAfNdXzcSfPWWQT7irrzyDwgIJHATmnLb0cYU/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431897; c=relaxed/simple;
	bh=Fo76j/lvwi/uAkAd1wxZMOGToBuBtNt3yuiCVhEmJwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQi57wTljMP/R2gKZrIt1Msbk+ho+3doZyUI5EWWsSHn+PdWYWzzMwZTxRbmPWKofZtQXcq54Hj3qMT9exKl38P8DXRm5w4JrRHMSooBHiCqLo1XsDB+Lg80EjaRtTqUwsaLws9Ve+Vza0kyTnVrigthGxApxT6HBUFiixHVDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/DFErVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/DFErVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B61F000E9;
	Tue,  7 Jul 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431895;
	bh=3FE35IwpQDJmTMF7Gn7CIbRO/UUkVX17zT0f3KEH/EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/DFErVDU+OIkM5FWHrTs6KBIFwRztqAZq4TRVTOafqPqhqNBl4T7j/Bc0yLzFp3Y
	 BK20OAOetxvF1mJzkWZpv0Whe/WkcafH+OjeHy31LKTJctf/XfkGJnwEVW8l8Episq
	 OJ43W+1PdI5Xyz7Ci9tyD34ObFo5VFdiSqWT66brADyCIJxnh3/HfGd5sJCx/zAzkw
	 WpwL+f5sb/VrPTFSl1P46wApzJWddk1u9IFOySE+OiIfRsdW9W3l/N36NGbaHDvA8F
	 ekrryjgu+rE3AfZo6Hclp8lpXVOpHQKNueU/E2jWYHVyWcvtUtFRSub3TAewN4oK+Y
	 sI7zZJdZN7F4Q==
Date: Tue, 7 Jul 2026 14:44:42 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com, 
	bigeasy@linutronix.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org, 
	jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
Message-ID: <akz7ythMxfIZeT0d@lucifer>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707125925.3725177-2-chenwandun1@gmail.com>

(Being really nitty, your subject line is too long)

Please don't reference legacy VMA flags for newer patches 'do not migrate
folios mapped into mlocked VMAs...' works just as well.

On Tue, Jul 07, 2026 at 08:59:22PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> When compact_unevictable_allowed=0, unevictable pages should not be
> migrated. However, mlock_folio_batch in the mlock[all] syscall introduces
> a race, mlock_folio() sets PG_mlocked immediately but defers PG_unevictable
> to mlock_folio_batch(), causing pages that are about to become unevictable
> to be migrated, which violates the intent of compact_unevictable_allowed,
> and causes spike latency in RT kernels [1].
>
> In order to fix this, migration is forbidden for pages mapped into VMAs
> marked with VM_LOCKED. In addition, two early-return paths are introduced,

Please don't reference legacy VMA flags. -> VMA_LOCKED_BIT.

> filter out mlocked pages, return early to avoid unnecessary operations.
>
> Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")

Hmmmm why do you think my patch caused this? That was just a folio conversion?

Also I didn't think we liked having fixes spotted about a series with non-fixes
tags?

> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/ [1]
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/linux-rt-users/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/#t
> ---
>  include/linux/compaction.h |  6 ++++++
>  include/linux/rmap.h       |  3 +++
>  mm/compaction.c            |  8 +++++++-
>  mm/migrate.c               | 23 +++++++++++++++++++----
>  mm/rmap.c                  | 12 +++++++++---
>  5 files changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index f29ef0653546..04e60f65b976 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  extern void __meminit kcompactd_run(int nid);
>  extern void __meminit kcompactd_stop(int nid);
>  extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
> +extern bool compaction_allow_unevictable(void);

Don't use extern. We remove extern as we go it's not needed.

>
>  #else
>  static inline void reset_isolation_suitable(pg_data_t *pgdat)
> @@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
>  {
>  }
>
> +static inline bool compaction_allow_unevictable(void)
> +{
> +	return true;
> +}
> +
>  #endif /* CONFIG_COMPACTION */
>
>  struct node;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 8dc0871e5f00..359c7426b6b9 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -102,6 +102,9 @@ enum ttu_flags {
>  					 * do a final flush if necessary */
>  	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>  					 * caller holds it */
> +	TTU_RESPECT_MLOCK	= 0x100,/* leave VM_LOCKED vmas mapped instead

-> VMA_LOCKED_BIT please. Also maybe just say mlock'd?

> +					 * of installing a migration entry
> +					 */
>  };
>
>  #ifdef CONFIG_MMU
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f08765ade014..5d256930e389 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		is_unevictable = folio_test_unevictable(folio);
>
>  		/* Compaction might skip unevictable pages but CMA takes them */
> -		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
> +		if (!(mode & ISOLATE_UNEVICTABLE) &&
> +		    (is_unevictable || folio_test_mlocked(folio)))

Maybe just change is_unevictable to include this check?

Like:

	is_unevictable = folio_test_unevictable(folio) ||
		folio_test_mlocked(folio);

?

Also later you have:

		if (((mode & ISOLATE_ASYNC_MIGRATE) && is_dirty) ||
		    (mapping && is_unevictable)) {
		    	...

Which doesn't account for mlock as-is? Is that correct?



>  			goto isolate_fail_put;
>
>  		/*
> @@ -1898,6 +1899,11 @@ typedef enum {
>   * compactable pages.
>   */
>  static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
> +
> +bool compaction_allow_unevictable(void)
> +{
> +	return sysctl_compact_unevictable_allowed;
> +}

You add this helper but isolate_migratepages() still references
sysctl_compact_unevictable_allowed directly?

>  /*
>   * Tunable for proactive compaction. It determines how
>   * aggressively the kernel should compact memory in the
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a786549551e3..3a15eb13e82b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1202,7 +1202,7 @@ static void migrate_folio_done(struct folio *src,
>  static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		free_folio_t put_new_folio, unsigned long private,
>  		struct folio *src, struct folio **dstp, enum migrate_mode mode,
> -		struct list_head *ret)
> +		struct list_head *ret, enum migrate_reason reason)
>  {
>  	struct folio *dst;
>  	int rc = -EAGAIN;
> @@ -1210,6 +1210,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  	struct anon_vma *anon_vma = NULL;
>  	bool locked = false;
>  	bool dst_locked = false;
> +	enum ttu_flags ttu = 0;

You reference ttu only in an if-block below no? So why are you declaring
this here? Move it to the if-block.

>
>  	dst = get_new_folio(src, private);
>  	if (!dst)
> @@ -1249,9 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		folio_lock(src);
>  	}
>  	locked = true;
> -	if (folio_test_mlocked(src))
> +	if (folio_test_mlocked(src)) {
>  		old_folio_state |= FOLIO_WAS_MLOCKED;
>
> +		if (reason == MR_COMPACTION && !compaction_allow_unevictable()) {

This should really be a helper since you repeat yourself and it's not
obvious what this is checking.

Like:

	static migrate_mlock_allowed(enum migrate_reason reason)
	{
		/* Only compaction is disallowed. */
		if (reason != MR_COMPACTION)
			return true;

		/* If we can compact unevictable folios, we are ok. */
		if (compaction_allow_unevictable())
			return true;

		/* Conservative: if any folio could be mlock()'d, disallow. */
		return false;
	}

Then you could self-document what you're checking and avoid code duplication below.

> +			rc = -EBUSY;
> +			goto out;
> +		}
> +	}
> +
>  	if (folio_test_writeback(src)) {
>  		/*
>  		 * Only in the case of a full synchronous migration is it
> @@ -1324,7 +1331,14 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		/* Establish migration ptes */
>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>  			       !folio_test_ksm(src) && !anon_vma, src);

Useful to convert VM_BUG_*() -> VM_WARN_*() (possibly _ONCE() here also) as we go!

> -		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
> +
> +		if (mode == MIGRATE_ASYNC)
> +			ttu |= TTU_BATCH_FLUSH;
> +
> +		if (reason == MR_COMPACTION && !compaction_allow_unevictable())

See above about deduplicating.

> +			ttu |= TTU_RESPECT_MLOCK;

Hmm. I don't love 'respect mlock'. I guess we only know about the reason
being compaction here.

But I'm confused anyway. We have the folio, why aren't we just checking for
PG_mlocked() here instead of getting the rmap to see if it's mapped
anywhere with VMA_LOCKED_BIT?

> +
> +		try_to_migrate(src, ttu);
>  		old_folio_state |= FOLIO_WAS_MAPPED;
>  	}
>
> @@ -1905,7 +1919,8 @@ static int migrate_pages_batch(struct list_head *from,
>  			}
>
>  			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
> -					private, folio, &dst, mode, ret_folios);
> +					private, folio, &dst, mode, ret_folios,
> +					reason);
>  			/*
>  			 * The rules are:
>  			 *	0: folio will be put on unmap_folios list,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0fb7a1b82cf3..3cb7f6337d38 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2420,6 +2420,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  	unsigned long pfn;
>  	unsigned long hsz = 0;
>
> +	if ((flags & TTU_RESPECT_MLOCK) && (vma->vm_flags & VM_LOCKED))

Please use the modern API for VMA flags. So:

	if ((flags & TTU_RESPECT_MLOCK) && vma_test(VMA_LOCKED_BIT))

> +		return false;
> +
>  	/*
>  	 * When racing against e.g. zap_pte_range() on another cpu,
>  	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
> @@ -2741,11 +2744,14 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
>  	};
>
>  	/*
> -	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
> -	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
> +	 * Migration normally ignores mlock, but TTU_RESPECT_MLOCK asks it to
> +	 * leave folios mapped into VM_LOCKED vmas alone.  Only TTU_RMAP_LOCKED,

Again -> VMA_LOCKED_BIT.

> +	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, TTU_BATCH_FLUSH and TTU_RESPECT_MLOCK
> +	 * are supported.
>  	 */
>  	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -					TTU_SYNC | TTU_BATCH_FLUSH)))
> +					TTU_SYNC | TTU_BATCH_FLUSH |
> +					TTU_RESPECT_MLOCK)))
>  		return;
>
>  	if (folio_is_zone_device(folio) &&
> --
> 2.43.0
>

Thanks, Lorenzo
