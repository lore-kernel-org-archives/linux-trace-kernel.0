Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27103422555
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431393; cv=none; b=atYFpVbDNVZeezICDQkolFxHyI8TwQ+LGsA8P5gFusasZca5Ms/r4MmOPeC4ruMv1PhI+q4dl3mk+GfnEmGgxL4V9MLeIHRBmXRi9h5Peqqxio67A43tpUDL1WL+4IvHCrmWDXTbpFxgGXw+opYijp5XTGvh38Bd5sZ/pYgUyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431393; c=relaxed/simple;
	bh=WFJ3OkIk0+cRC2fEyVd7FqrPVqNYZJNNbpLdjOQiuPY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ujggPBRK5Mq82LZQZdX/oJibhWSnmKc25I+z5wFyUJKOj5DGr04TfavOPMOSOSChZd5iITkG/Z97nM2jqZhWTX1IkpTMy7ZzR0TvK4QLwo59Vxw3f2dDJDACsI0FWaE83wOdAyQ6yM9bX/22txBnRe+QdR9NTXE0Y64gwVG2wJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mW2QLvCc; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW2QLvCc"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso6185495ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431390; x=1784036190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTT2EDmNQmPoFd5ibUkdhfarwMp1tgdKNvXjK9tKgTE=;
        b=mW2QLvCcimdfVhFx5JUKSlzVC9TeLN67JHVq8iwrP5hhQ00hcCxD6WKT2iFzJ0wJ9U
         KtjHCdzT3zouwA0AeVCGEYZfvgT/36flV0FXOhdnPUaMqI0TakD2SZ01OKAgG8R2KlgA
         oOChrdQU9kDPhMaw5lf9wj5PjgEMjJwOjimtCSr/R5BYMPPtMdbXghAnFZLEybdyw2HJ
         iEdqfENB3rzkpARD0aLi6W5WVlx5l2adehJt9yYRjqFlV9cS00rU8MPjHWYSjlCioahx
         nvmT3sBtHKPyS4xYAC/me2GoHhagVAqHr7QLh5GjTF4qvJZhidML5H8dJ2YxMip9NUDi
         0lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431390; x=1784036190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTT2EDmNQmPoFd5ibUkdhfarwMp1tgdKNvXjK9tKgTE=;
        b=A6AL2Q6ehPqLBwcscmmxVn2QWZm3HgzVXSdJsMXlrHdgJ+oeQ7ESrCQXKzZuaPN+9p
         NW8wptHm5rlZwQFi7wBThTycfCDfXmrtXM5xtc9AKUbmG637ciVI2qffNCq+mP5eBZ+R
         HlLyOd/C4Ccw5p94n39g0uk1GxdbcYBd982C89IYnNl5tQk1GZwbNuT/ubSgRi8X+F82
         zo+9Q1UfwYqX0opM5MIJ8/mhbmIlGwDk/2Jx9JtH0KPUwltNH3gW5hCDz6baGlxUFzKf
         6Ea/JRd+ycjJEarKGEx1/RXUIz6PHoKD17hNl6S0HZBOCi98uhMoM5Evu5ovUxYca2J5
         FBJw==
X-Forwarded-Encrypted: i=1; AHgh+RrhZHBWPKssbUm1d/XX/a1wB87LNiqKdPoOy7nuoGKCgUHizZDYw+OS2+GJnl4Eq8U5gh9hjnveZQ15G3cPMsvBSZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eZK9tNQ+chgWpIVB5+RGLzi22irgqxzb+55Ad3XFqukcGVRv
	ghkDb3W0bfbygddDSNI3g9z70dm0+/WRE32eEe1RTAjUG9+8+ceLrVqi
X-Gm-Gg: AfdE7clAEdk4RcoIOOAVfdhR4fP9+3xR28yCaYOIZS9fJU6QOBwXwVAKHF2aekHKEOI
	xHaZSeOMHq+cCf3UHNeF3J9Jidht7JyTcPPhMkecSXBZy9gCAgGUMXmftIyGo5PdZ4JH4kzINkF
	vD/+5s0Ut+L7cDjteILVVDnhxZqNIuLRxEAGsOOcnS8k4DtLgtGtLxqzGMxdQePxBFgSU83GMfF
	UE3rjfRPfhnxDTUd/AncNabzr2ayY3ebMRcI1vtLTAwM+ixOjvFCvReQ4MC6Ku2OGMwcmfZcu+q
	YrtUPEdf4RkrUTrYJp7Rn5KYMLlQdJweiXCR1rOWyrnxQpgNnXxrZZg6yn6r3ObVpMGZui98tmE
	xAOrhj2T5/1jn7WkpsCYl1//SRtILyQtXlS0v+HJThFzTvf0YEOb2jv7gTf/74ukXmpzbnkyvCV
	BPaVJ/oXvLRIn/6ymqtGKr
X-Received: by 2002:a17:903:2444:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2ccbe40b8efmr55426065ad.2.1783431390369;
        Tue, 07 Jul 2026 06:36:30 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm12488775ad.31.2026.07.07.06.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:36:29 -0700 (PDT)
Message-ID: <bd88f65e-000b-4dde-92f7-28af6a34e977@gmail.com>
Date: Tue, 7 Jul 2026 21:36:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
From: Wandun <chenwandun1@gmail.com>
To: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260707125925.3725177-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 20:59, Wandun Chen wrote:
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
> +static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
> +			unsigned long end, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +	struct list_head *folio_list = walk->private;
> +	spinlock_t *ptl;
> +	pte_t *start_pte, *pte;
> +	pte_t ptent;
> +	struct folio *folio;
> +	unsigned int step = 1;
> +
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return 0;
> +
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		if (!pmd_present(*pmd)) {
> +			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
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
> +			isolate_folio_to_list(folio, folio_list);
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
> +				walk->action = ACTION_AGAIN;
> +				return 0;
> +			}
> +			continue;
> +		}
> +		folio = vm_normal_folio(vma, addr, ptent);
> +		if (!folio || folio_is_zone_device(folio))
> +			continue;
> +		step = folio_mlock_step(folio, pte, addr, end);
> +		if (is_migrate_cma_page(&folio->page))
Here should be, sorry about this.
	if (!is_migrate_cma_page(&folio->page))
		continue;

Best regards
Wandun
> +			continue;
> +		isolate_folio_to_list(folio, folio_list);
> +	}
> +	pte_unmap(start_pte);
> +out:
> +	spin_unlock(ptl);
> +	cond_resched();
> +	return 0;
> +}
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
> +
> +	lru_cache_disable();
> +
> +	if (mmap_read_lock_killable(mm))
> +		goto out;
> +
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
> +	}
>  
>  	return ret;
>  }

