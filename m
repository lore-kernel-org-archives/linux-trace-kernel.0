Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04F43D510
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123227; cv=none; b=hZ5CKMtvwLovvpc9VX1kHMc0ppBp5L84THO+llIwrWPw7zdup2fMHpvu58l+/XJPCwVZLx2f7k9gH0jR6kNErTRzhFDS+goek9wZPChOTlwfQxzxW8oraCfyrs6KdjleqO90ksKY7Qx6rfNodDAl6vzeqWVYWySfhkCymokq3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123227; c=relaxed/simple;
	bh=HKqtr3coDZJQB8tfZLk/fEJRSL3Be6NnnvgjgP9uZHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNmQ4WThUEUaYH/uaFUrDXPu7Zb9Ark/7I4Stzk4GKnDXAFI10aexnb9Efbv+KzQzDXimDLvwHtttZLOLxuMC3fCXHCG6jEl+7bgf117LTttFWJt+jfGfJC2xz6e6tmdLkTt1oAI0LQiXtCKZjE404oAHTw8y0NBPQx0mOHnwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYncBP7R; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYncBP7R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772123222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhpPpUmawavr8/7XO4FkbjGyfWyIYMOEPuIKrXPIOZ8=;
	b=oYncBP7RaHS8J3MMylYArslXoH71eizg7mSGfgLGYgnJQMZRPlGt3Og7eMjJ3PDXcu0Cjf
	Iiuihwux6vl14q6/NYTTenfiDG7eC8xz67swamRfYHsVdoFeTWT3Bp41LT1gfO69H4ips3
	QprD6BI2Yb6LF4d3T1CZMn9JbixT3Hc=
From: Usama Arif <usama.arif@linux.dev>
To: Nico Pache <npache@redhat.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH mm-unstable v15 11/13] mm/khugepaged: avoid unnecessary mTHP collapse attempts
Date: Thu, 26 Feb 2026 08:26:52 -0800
Message-ID: <20260226162653.3802758-1-usama.arif@linux.dev>
In-Reply-To: <20260226032631.234234-1-npache@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 25 Feb 2026 20:26:31 -0700 Nico Pache <npache@redhat.com> wrote:

> There are cases where, if an attempted collapse fails, all subsequent
> orders are guaranteed to also fail. Avoid these collapse attempts by
> bailing out early.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1c3711ed4513..388d3f2537e2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1492,9 +1492,42 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>  			ret = collapse_huge_page(mm, collapse_address, referenced,
>  						 unmapped, cc, mmap_locked,
>  						 order);
> -			if (ret == SCAN_SUCCEED) {
> +
> +			switch (ret) {
> +			/* Cases were we continue to next collapse candidate */
> +			case SCAN_SUCCEED:
>  				collapsed += nr_pte_entries;
> +				fallthrough;
> +			case SCAN_PTE_MAPPED_HUGEPAGE:
>  				continue;
> +			/* Cases were lower orders might still succeed */
> +			case SCAN_LACK_REFERENCED_PAGE:
> +			case SCAN_EXCEED_NONE_PTE:
> +			case SCAN_EXCEED_SWAP_PTE:
> +			case SCAN_EXCEED_SHARED_PTE:
> +			case SCAN_PAGE_LOCK:
> +			case SCAN_PAGE_COUNT:
> +			case SCAN_PAGE_LRU:
> +			case SCAN_PAGE_NULL:
> +			case SCAN_DEL_PAGE_LRU:
> +			case SCAN_PTE_NON_PRESENT:
> +			case SCAN_PTE_UFFD_WP:
> +			case SCAN_ALLOC_HUGE_PAGE_FAIL:
> +				goto next_order;
> +			/* Cases were no further collapse is possible */
> +			case SCAN_CGROUP_CHARGE_FAIL:

The only one that stands out to me is SCAN_CGROUP_CHARGE_FAIL. memcg charging
of higher order folio might fail, but a lower order folio might pass?
That said, if the cgroup is that tight, continuing collapse work may not
be productive.

Acked-by: Usama Arif <usama.arif@linux.dev>

> +			case SCAN_COPY_MC:
> +			case SCAN_ADDRESS_RANGE:
> +			case SCAN_NO_PTE_TABLE:
> +			case SCAN_ANY_PROCESS:
> +			case SCAN_VMA_NULL:
> +			case SCAN_VMA_CHECK:
> +			case SCAN_SCAN_ABORT:
> +			case SCAN_PAGE_ANON:
> +			case SCAN_PMD_MAPPED:
> +			case SCAN_FAIL:
> +			default:
> +				return collapsed;
>  			}
>  		}
>  
> -- 
> 2.53.0
> 
> 
