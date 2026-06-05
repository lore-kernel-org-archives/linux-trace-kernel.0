Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC501E98E3;
	Fri,  5 Jun 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681627; cv=none; b=FEVcFQo8OfsK7CTig7Wa4SDGa9dPgNAxM39Rlau/bR1MI/N115uzp/HFre+9NorRPUYxlHEh/TpLv94bPE/TO9r8xs5Atv/csvgpsZ/SQBO2eOsCth47apPdEwcAeHefB2Iq4c/S9p3nf1XoIM4xH84hXRf1HXnnFg7QZLo+ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681627; c=relaxed/simple;
	bh=HFSuDbaA48MsHVvv33Gi8Gc+d2c6ZtNwEDJbbsgaWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDtmmmvWj0+SgY3BKUakESuTRSjd4Xvivrxd9DNbsr4nxgAtkpmCrdgXupUbgDlhvGQt6KGFB2edX1KGhsZKr460ys+umWTHxhyx+cyfLP0MVB5k8PZBy2rKpy6WVWWwpAWJZgDjNxNXBWLhtFEnEPhOGRle3bt2vHW8ite8nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkio3xuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkio3xuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EBB1F00893;
	Fri,  5 Jun 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780681619;
	bh=eogvnYwd7EDRot4mePyIFCuCOhQe1D4un50SJ/87W34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lkio3xuUd5AU8UgtD6c6jGLmmu91MDtI3qCGmPWKBE6IYaEtIGnF9GHeQHXMlqCJ4
	 5JvPvUv0EkXz3IFmbmdVFNnQZ25aWUK2JMzsGxmBWYu8nbNku41yXG5xOv8FipfYdD
	 D9pf8Fdw7S4H2c68KzK8dYzavYASaND5XbGPAVhuzklqIhvvilD7IyvfGZZs+B/6HA
	 DZbpId7SXoZMLhYEA6v1og+j2EK3mC089lWwt7szg4fYJSBdpwH4UNaSKnioZ9/7GJ
	 Z9C8RXPS5BOQesIkLOZBUb27B/5L0roWBlWC3kf6XEBsOSgoCMUxgk7MDxmeMC4eiR
	 OMcDZbFBvVylQ==
Date: Fri, 5 Jun 2026 18:46:44 +0100
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
Subject: Re: [PATCH mm-unstable v19 10/14] mm/khugepaged: introduce
 collapse_possible_orders helper functions
Message-ID: <aiMLMMtBBsJb3-3N@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-11-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605161422.213817-11-npache@redhat.com>

On Fri, Jun 05, 2026 at 10:14:17AM -0600, Nico Pache wrote:
> Add collapse_possible_orders() to generalize THP order eligibility. The
> function determines which THP orders are permitted based on collapse
> context (khugepaged vs madv_collapse). We also add collapse_possible()
> as a thin wrapper around collapse_possible_orders() that returns a bool
> rather than the whole bitmap.
>
> This consolidates collapse configuration logic and provides a clean
> interface for future mTHP collapse support where the orders may be
> different.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/khugepaged.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 26c343a6fa3d..ec886a031952 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -554,12 +554,30 @@ void __khugepaged_enter(struct mm_struct *mm)
>  		wake_up_interruptible(&khugepaged_wait);
>  }
>
> +/*
> + * Check what orders are possible based on the vma and collapse type.
> + * This is used to determine if mTHP collapse is a viable option.
> + */
> +static unsigned long collapse_possible_orders(struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, enum tva_type tva_flags)
> +{
> +	const unsigned long orders = BIT(HPAGE_PMD_ORDER);
> +
> +	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> +}
> +
> +static bool collapse_possible(struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, enum tva_type tva_flags)
> +{
> +	return collapse_possible_orders(vma, vm_flags, tva_flags);
> +}
> +
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
>  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> +		if (collapse_possible(vma, vm_flags, TVA_KHUGEPAGED))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -2700,7 +2718,7 @@ static void collapse_scan_mm_slot(unsigned int progress_max,
>  			cc->progress++;
>  			break;
>  		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> +		if (!collapse_possible(vma, vma->vm_flags, TVA_KHUGEPAGED)) {
>  			cc->progress++;
>  			continue;
>  		}
> @@ -3010,7 +3028,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	BUG_ON(vma->vm_start > start);
>  	BUG_ON(vma->vm_end < end);
>
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
> +	if (!collapse_possible(vma, vma->vm_flags, TVA_FORCED_COLLAPSE))
>  		return -EINVAL;
>
>  	cc = kmalloc_obj(*cc);
> --
> 2.54.0
>
