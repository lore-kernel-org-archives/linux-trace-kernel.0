Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD036A360;
	Tue,  7 Jul 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436116; cv=none; b=lq1oSNv1HKjqKUl9VzIKhuydlHSfgvS5GzaPSvcfSQf0KQlVMBMG7sYgbQnWx9OK7ECB7EEfaRy/L8wuCZvi66ABLEyd79o3ZkF1wEgo3kaS+I23I+uq3oC0XWg2nJEepY4z9fda0jRYcpBGpxyFFN0es3JT4vQVZww98IWbq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436116; c=relaxed/simple;
	bh=5iIRrEO/ZobSUfmJ/0nPSN+09pt77KoBcWHvqcQwkRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzB9/o45UvxU8l8fG+8zoxROwH8gOViJzMN8BpoL8XV9JEo2/iU/0rogfgZ6bbocfg11XAIRXHTF1l6u+legnS7byHhftW1h8gRS0opUeI9C9hgCI9gdy0RqNzMaUESpRxX6pO8xcEX9ixuYm4XsqnGM1QmPvAtJFK4kOEX/bLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV+ks0HY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV+ks0HY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB471F000E9;
	Tue,  7 Jul 2026 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436111;
	bh=/9mCzb7g+yV56krs+YlAAmkKn3Oaov1WcfK8GbeZDIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QV+ks0HYntwA9uKhowNtp8zOo9GveHkOSIFIr0wmdDYgDYdv+dH5Hb/h7TcwMjmad
	 LcgNzfOkd5JYiUhz7QRIgW2A6EbwtvXiXxusWJDUeLYbt1LZ2Cd1QiumWq7LCBjf1r
	 KBEnnWL/Quo3at5Tw/5VImKsO36vd1NY/MvgZtn4d2sEYuS1WatlnewFdElJGqVt10
	 ck/Rkva/2KBOeS+uYqW3Gqt7t4KnvErVhOX5pQ1NzkuOQUIzZyb86gkERENikJ5GES
	 u0Tg6ai7S90OPcXfssPxfx5gdkJiHgOxonLyoHgS1t0BVYun8G0TKAnBINd2+oLKK/
	 8LtjNwIPskezg==
Date: Tue, 7 Jul 2026 15:54:57 +0100
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
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
Message-ID: <ak0OZKzapUefmA3v@lucifer>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707125925.3725177-5-chenwandun1@gmail.com>

On Tue, Jul 07, 2026 at 08:59:25PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
> migration entries in the page table, if a memory access occurs at this
> point, it must wait for the migration to complete, which may cause
> latency spikes on the RT kernels.
>
> Try to move the migration cost into the mlock[all] caller, which is
> typically a setup path. So reduce the chance of latency spikes on RT
> kernels by migrating the currently mapped CMA pages out of CMA region.

'reduce the chances of latency' so do you have any data to back this invasive
change or not?

And for RT, but nothing in here at all checks for RT? You're using this
compaction sysctl as an RT check somehow? That's gross.

This doesn't feel like the right solution.

>
> Suggested-by: Frank van der Linden <fvdl@google.com>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/#t
> ---
>  mm/mlock.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index ac65de40b22b..f56c685533f5 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -25,6 +25,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/mm_inline.h>
>  #include <linux/secretmem.h>
> +#include <linux/migrate.h>
>  #include <linux/compaction.h>
>
>  #include "internal.h"
> @@ -428,6 +429,119 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>  	return 0;
>  }
>
> +#ifdef CONFIG_CMA

Ugh yuck. This is horrible. Why are we polluting mlock.c with CMA stuff?

Also no comment?

> +static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
> +			unsigned long end, struct mm_walk *walk)
> +{

You've literally copy/pasted mlock_pte_range(), this is disgusting.

Please don't copy/paste code like this, this isn't PHP, it's the kernel, it's
completely unacceptable.

> +	struct vm_area_struct *vma = walk->vma;
> +	struct list_head *folio_list = walk->private;
> +	spinlock_t *ptl;
> +	pte_t *start_pte, *pte;
> +	pte_t ptent;
> +	struct folio *folio;
> +	unsigned int step = 1;
> +
> +	if (!(vma->vm_flags & VM_LOCKED))

Once again vma_test(vma, VMA_LOCKED_BIT) please.

But also, again (since you copy/pasted), why? You're literally mlocking here...

You going for that 'mlocking already mlocked ranges' sweet spot or am I missing
something?

> +		return 0;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		if (!pmd_present(*pmd)) {
> +			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {

OK so you're not actually checking for CMA here at all, you're just doing the
migration wait stuff... again here? What?

> +				spin_unlock(ptl);
> +				pmd_migration_entry_wait(vma->vm_mm, pmd);
> +				walk->action = ACTION_AGAIN;
> +				return 0;
> +			}
> +			goto out;
> +		}
> +		if (is_huge_zero_pmd(*pmd))
> +			goto out;
> +		folio = pmd_folio(*pmd);
> +		if (folio_is_zone_device(folio))
> +			goto out;
> +		if (is_migrate_cma_page(&folio->page))

Err isn't this per-page, and you just checked that this is a huge folio, and
you're only checking the first page? That seems wrong?

> +			isolate_folio_to_list(folio, folio_list);

Then you just take the whole folio?

It's really horrible that you're burying this in copy/pasted code from the rest.

> +		goto out;
> +	}
> +
> +	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!start_pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
> +	for (pte = start_pte; addr != end; pte += step, addr += step * PAGE_SIZE) {
> +		step = 1;
> +		ptent = ptep_get(pte);
> +		if (!pte_present(ptent)) {
> +			if (unlikely(softleaf_is_migration(softleaf_from_pte(ptent)))) {
> +				pte_unmap_unlock(start_pte, ptl);
> +				migration_entry_wait(vma->vm_mm, pmd, addr);

BTW I also wonder if we have guaranteed forward progress here if say a migration
happened to migrate back and forth again across a range...?

> +				walk->action = ACTION_AGAIN;
> +				return 0;
> +			}

Again, since you copy/pasted, same comment - this is disgusting.

And again I'm confused why you're waiting here again after you did it previously
due to the previous commit that already does it?

And why for a non-CMA range, if somebody happens to set CONFIG_CMA they now get
this done twice?

> +			continue;
> +		}
> +		folio = vm_normal_folio(vma, addr, ptent);
> +		if (!folio || folio_is_zone_device(folio))
> +			continue;
> +		step = folio_mlock_step(folio, pte, addr, end);
> +		if (is_migrate_cma_page(&folio->page))
> +			continue;

You mean ! surely?

Why are you inverting this vs. the above? you replied to the patch so maybe you
correct this there.

> +		isolate_folio_to_list(folio, folio_list);

And again you bury the actual point of this in one easily missed line and zero
comments.

No.

> +	}
> +	pte_unmap(start_pte);
> +out:
> +	spin_unlock(ptl);
> +	cond_resched();
> +	return 0;
> +}

Yeah this is just completely unacceptable. You have to find a way to deduplicate
code. Copy/paste code dumps are not ok.

But at the same time, you're dumping CMA crap in core mm mlock code which is
horrible, you've also dumped some migration code so you're really mixing things
up here horribly, and it doesn't seem justified?

> +
> +static const struct mm_walk_ops mlock_collect_migratable_ops = {
> +	.pmd_entry	= mlock_collect_migratable_pte_range,
> +	.walk_lock	= PGWALK_RDLOCK,
> +};
> +
> +static void mlock_migrate_cma_range(unsigned long start, unsigned long len)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long end = start + len;
> +	LIST_HEAD(folio_list);
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_HIGHUSER | __GFP_NOWARN,
> +		.reason = MR_SYSCALL,
> +	};
> +
> +	if (compaction_allow_unevictable())
> +		return;

Again you're assuming compaction for some reason. Why?

It feels like you're just gating specific behaviour for your workload on this
flag and assuming that's ok.

> +
> +	lru_cache_disable();

What, why?

> +
> +	if (mmap_read_lock_killable(mm))
> +		goto out;

OK so you got a fatal signal and you don't bother telling anybody about it and
just skip migration?...

> +

Weird whitespace...

> +	walk_page_range(mm, start, end, &mlock_collect_migratable_ops,
> +			&folio_list);
> +	mmap_read_unlock(mm);
> +
> +	if (list_empty(&folio_list))
> +		goto out;
> +
> +	if (migrate_pages(&folio_list, alloc_migration_target, NULL,
> +			  (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL))
> +		putback_movable_pages(&folio_list);
> +out:
> +	lru_cache_enable();
> +}
> +#else
> +static inline void mlock_migrate_cma_range(unsigned long start,

inline in a .c file? Why? Drop it.

> +					   unsigned long len)
> +{
> +}
> +#endif /* CONFIG_CMA */
> +
>  /*
>   * mlock_vma_pages_range() - mlock any pages already in the range,
>   *                           or munlock all pages in the range.
> @@ -678,6 +792,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	error = __mm_populate(start, len, 0);
>  	if (error)
>  		return __mlock_posix_error_return(error);
> +	mlock_migrate_cma_range(start, len);

Err, unconditionally?

>  	return 0;
>  }
>
> @@ -790,8 +905,10 @@ SYSCALL_DEFINE1(mlockall, int, flags)
>  	    capable(CAP_IPC_LOCK))
>  		ret = apply_mlockall_flags(flags);
>  	mmap_write_unlock(current->mm);
> -	if (!ret && (flags & MCL_CURRENT))
> +	if (!ret && (flags & MCL_CURRENT)) {
>  		mm_populate(0, TASK_SIZE);
> +		mlock_migrate_cma_range(0, TASK_SIZE);

Err what? Why are you doing this? You're forcing a wait on migration of
literally everything across the whole of the process whether or not they're CMA
ranges, but as a one time thing?


> +	}
>
>  	return ret;
>  }
> --
> 2.43.0
>

In general this feels like the wrong solution for a specific workload that
sticks horrible stuff in core mm and I don't really love it :)

Thanks, Lorenzo
