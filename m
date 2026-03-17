Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E9373C18;
	Tue, 17 Mar 2026 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767338; cv=none; b=SxHyUd6zO0+6fLfIcG4lauW4uWmGZ44qdYMLloXPGv9oWsLEUBK0cedMgmJJ5rwhogXlSZ8y6+4QvOMb+keC0yzpPqvg6kbMP3wOuznNoe6TvBJf7h35/D6u3oLtnDsrAzQG3+WswgEKc2K3tKLNlegx5mg8Gwfc0dcRWjZdLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767338; c=relaxed/simple;
	bh=x9BTIGZzr3hc80r0W62D2cj+dgKrooZSBRROfEEbIcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg1KNfWFfzZIrwGn74X68wF4b1rT+3t2oE41D1n0WkvUxoTYBeU9lN6yps0Tq7oQT1WCHkzBzHQZahNhjmUSZ3A3zHuqugVOXzHWEvK+VtBBQ/1HGI6JaF1o4lpqfpCm0r3lKFFFGIVZozg4jxxNk51F1l9znZs8zR1mHD56UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usGdVw0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usGdVw0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE0C4CEF7;
	Tue, 17 Mar 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767338;
	bh=x9BTIGZzr3hc80r0W62D2cj+dgKrooZSBRROfEEbIcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usGdVw0rP3j+0LhJLU2epl98cNaZ0uScq4rblM4OenxjiW4jGQLxs7eu0wjSl+qDp
	 0BoZnqlw2iM2xjT8ez+Sz6+/GMpISO6VRiC1kebcQxPbdcucPUZpSMsXsNF3eKJBI3
	 MsWHdF0pfJCUXkfymaY9R9xYdco82zqx/oJ8aV7MZeaxGBQfL2KML3lqZ54bCEXa6R
	 lsobOAFjVonT7uvMfKqCbAep7/1NY/zehfITw2nD+ycbFiMjW2Wl8wH+g6tPc0kXVZ
	 lxyLfxzmWVokRGmA8fBRg+pdSAFWIUyrvUf49oDch52dan6BWM/+POkfM+3GG/z3yU
	 iBAkk79KaA4aQ==
Date: Tue, 17 Mar 2026 17:08:56 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v15 09/13] mm/khugepaged: introduce
 collapse_allowable_orders helper function
Message-ID: <0f8d6387-8ab1-4175-aa5d-667c7176fa05@lucifer.local>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032542.233891-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226032542.233891-1-npache@redhat.com>

On Wed, Feb 25, 2026 at 08:25:42PM -0700, Nico Pache wrote:
> Add collapse_allowable_orders() to generalize THP order eligibility. The
> function determines which THP orders are permitted based on collapse
> context (khugepaged vs madv_collapse).
>
> This consolidates collapse configuration logic and provides a clean
> interface for future mTHP collapse support where the orders may be
> different.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2e66d660ee8e..2fdfb6d42cf9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -486,12 +486,22 @@ static unsigned int collapse_max_ptes_none(unsigned int order)
>  	return -EINVAL;
>  }
>
> +/* Check what orders are allowed based on the vma and collapse type */
> +static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
> +			vm_flags_t vm_flags, bool is_khugepaged)

You're always passing vma->vm_flags, maybe just pass vma and you can grab
vma->vm_flags?

Really it would be better for it to be &vma->flags, but probably best to wait
for me to do a follow up VMA flags series for that.

> +{
> +	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
> +	unsigned long orders = BIT(HPAGE_PMD_ORDER);

Const?

Also not sure if we decided BIT() was right here or not :P For me fine though.

> +
> +	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> +}
> +
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
>  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> +		if (collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=*/true))

I agree with David, let's pass through the enum value please :)

>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -2637,7 +2647,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
>  			progress++;
>  			break;
>  		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> +		if (!collapse_allowable_orders(vma, vma->vm_flags, /*is_khugepaged=*/true)) {
>  			progress++;
>  			continue;
>  		}
> @@ -2949,7 +2959,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	BUG_ON(vma->vm_start > start);
>  	BUG_ON(vma->vm_end < end);
>
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> +	if (!collapse_allowable_orders(vma, vma->vm_flags, /*is_khugepaged=*/false))
>  		return -EINVAL;
>
>  	cc = kmalloc_obj(*cc);
> --
> 2.53.0
>

Cheers, Lorenzo
