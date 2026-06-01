Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B635CB89;
	Mon,  1 Jun 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322865; cv=none; b=TTniebURylmEJtbwfkH4tq7XeK+Eak2mFhdEF3Dk1SwcmB1vx/GSShmDhEdl/K/xM199vH/2e10nc+24t61QKv8lkcMkRDGDVgeVHiWgKAAES4nq9RdqdqoNCMY+xWlxBQ7vV8kJIRw3UIbZKhwkzXOMTp9PpFpekGH5oOYlAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322865; c=relaxed/simple;
	bh=95bCAV84Mhzru1pKsGxtbPcbwXGDvVJhI21g5Carfz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+SGcqxNkx5GQX/d9/i4PR+5vK2L06IjNf+uVfYgZ9zQ43jfNg4BqQYlkEgVKwZ6nrrQc4sTt1bDgFaYmuVGq1UJ5FGyAJHqAtr2rsGKzFFyWBCwUEy/EOqABv64kQFrqA0jPGaDRk8jDat8yyDLyGv5Jq1377ZY5b5l9UIqIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwZuGsqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwZuGsqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939081F00893;
	Mon,  1 Jun 2026 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322864;
	bh=xV5oIFC9FNSfUrc/Tw1WKRTCW2A5//7Qu9iRmyYgTvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fwZuGsqWBa6HD8SGBpxDRBSQcOHZrYGDQmAKJ4dA6W4CsME7Y3sOPejh2PD2bdYMB
	 Np2hqbz4QLVteWzCVcczlkJCyPaSOcJHMz03gaaBqG439JZ9sT3M0wFAtyyu0O5EfF
	 MLww95kfytpWxPtUuFxvIOuBnyW0scY4lVMM3eqokX6tBRhFVyHB2WCjVLx6R1w49n
	 aB4NJH7P/LughfryadrV63GoqDoh96o9LsOLVn1TNLwouHtVilsjDf8EmZEMD5Nh9D
	 P0855nIPngyprB/6KkMmz58FaNV738ca80fE0H0uXDgO90P7jMtyeml8HzRijMkkhi
	 QtXHYjI5Fuxqg==
Date: Mon, 1 Jun 2026 15:07:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 05/14] mm/khugepaged: require
 collapse_huge_page to enter/exit with the lock dropped
Message-ID: <ah2Ro54tMDMsPevk@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-6-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522150009.121603-6-npache@redhat.com>

On Fri, May 22, 2026 at 09:00:00AM -0600, Nico Pache wrote:
> Currently the collapse_huge_page function requires the mmap_read_lock to
> enter with it held, and exit with it dropped. This function moves the
> unlock into its parent caller, and changes this semantic to requiring it
> to enter/exit with it always unlocked.
>
> In future patches, we need this expectation, as for in mTHP collapse, we
> may have already have dropped the lock, and do not want to conditionally
> check for this by passing through the lock_dropped variable.
>
> No functional change is expected as one of the first things the
> collapse_huge_page function does is drop this lock before allocating the
> hugepage.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>

One small nit below, otherwise LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/khugepaged.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e98ba5b15163..fab35d318641 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1208,6 +1208,12 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
>  	return SCAN_SUCCEED;
>  }
>
> +/*
> + * collapse_huge_page expects the mmap_lock to be unlocked before entering and
> + * will always return with the lock unlocked, to avoid holding the mmap_lock
> + * while allocating a THP, as that could trigger direct reclaim/compaction.
> + * Note that the VMA must be rechecked after grabbing the mmap_lock again.
> + */
>  static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		int referenced, int unmapped, struct collapse_control *cc)
>  {
> @@ -1223,14 +1229,6 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>
> -	/*
> -	 * Before allocating the hugepage, release the mmap_lock read lock.
> -	 * The allocation can take potentially a long time if it involves
> -	 * sync compaction, and we do not need to hold the mmap_lock during
> -	 * that. We will recheck the vma after taking it again in write mode.
> -	 */
> -	mmap_read_unlock(mm);
> -

NIT: Maybe worth an mmap_assert_locked()?

>  	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
> @@ -1535,6 +1533,8 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>  out_unmap:
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
> +		/* collapse_huge_page expects the lock to be dropped before calling */
> +		mmap_read_unlock(mm);
>  		result = collapse_huge_page(mm, start_addr, referenced,
>  					    unmapped, cc);
>  		/* collapse_huge_page will return with the mmap_lock released */
> --
> 2.54.0
>

Cheers, Lorenzo
