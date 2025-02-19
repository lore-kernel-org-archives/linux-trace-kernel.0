Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192F199237;
	Wed, 19 Feb 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978996; cv=none; b=S1338PcEQZjuQw4ppyEoiYCGPgfJ/T3sxnRzk07n0+6LUtZnMUT3+YK2XrZ2DUu2jP84DFhwVldJhFSDa6QNb4R613S3l+Nu88DhfeQ/NiHWOQQtUrJJ8JjnS48bxupyKtvur9emKWd5c95atdDc8UJZkgKsKFVnKV5M/h0plm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978996; c=relaxed/simple;
	bh=8BSiMyKZOdyFw/92729oiwxfXkyUH7puwGPtfJpZwT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHOrTe10XdvtULyEVmRd8RfIsD/Q2j1hRE655H8OmkVfYSTkFC2WXnJjMtjhTAEv1wsm0J5e5HCodabXv9Msc84rixF/zMgdAzqBg0LSHGzMPKdYTsuuMqxOiQQokoNEunQ0iEpAIbOX59G4ASzOrC1RqBvymFYfP324aaEf9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 149B8152B;
	Wed, 19 Feb 2025 07:30:12 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B000F3F59E;
	Wed, 19 Feb 2025 07:29:45 -0800 (PST)
Message-ID: <6cdc1de1-f760-4084-8eae-102ca16fee20@arm.com>
Date: Wed, 19 Feb 2025 15:29:44 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/9] khugepaged: generalize alloc_charge_folio for mTHP
 support
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-5-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-5-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> alloc_charge_folio allocates the new folio for the khugepaged collapse.
> Generalize the order of the folio allocations to support future mTHP
> collapsing.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c834ea842847..0cfcdc11cabd 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1074,14 +1074,14 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  }
>  
>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, int order)
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
>  	int node = khugepaged_find_target_node(cc);
>  	struct folio *folio;
>  
> -	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> +	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop = NULL;
>  		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);

Stats management is different for PMD-sized THP vs mTHP. All the PMD-sized THP
stats continue to be accumulated in /proc/meminfo (or whatever its called).
Other THP sizes are not accounted here. All mTHP sizes (*including* PMD-sized)
should accounted in
/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats/*. There is a file
for each stat.

We decided to do it this way for fear of breaking unenlightened user space that
only understands PMD-sized THP.

You can find the mTHP stats machinery at count_mthp_stat().

> @@ -1125,7 +1125,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 */
>  	mmap_read_unlock(mm);
>  
> -	result = alloc_charge_folio(&folio, mm, cc);
> +	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out_nolock;
>  
> @@ -1851,7 +1851,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>  	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>  
> -	result = alloc_charge_folio(&new_folio, mm, cc);
> +	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  

