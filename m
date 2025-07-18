Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0611185;
	Fri, 18 Jul 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752815105; cv=none; b=uCjJSo6uY5MwjmAS7bR+kfe+GnMlU/WHSz8XqpQS86iOcjHbjj4B8HjrqOY2G35al/gDQv707fUYO7gjYjTujN5yW5sFYP/xbd+KjNaR0BG1ZwO0MDggHAzbmr6svMRQgcOEKHcKwWl6iqJ9prbzYTdfFCKIMOraiWa/749FpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752815105; c=relaxed/simple;
	bh=QJkcVlrtRmJ/Urf2nkTkEVMPVtNRpUTiVHKA8+4168I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ//d14G3jw7GofN80BTJEak4qg8/EnB1GVS9pfHAenMD7V6IYfHWr7PbvENqI3Z9ba1T3fbrpr/62MkXZfis5YTfIPzsy0tkcr9g+Q4h50EKuOfz+5DnGdqD3v1IqdHthBV4M82UK5+a+jdyp/S2pVSNc0ciOF4s2mXbuTTb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LldAl/65; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LldAl/65"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752815099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YKO4x322R/4libGDkuLPQbhsl6xeu44Ft0umh6Z5k6I=;
	b=LldAl/65R2PMYHrGWYFi42Jbd0gbLJyYiTOwcoeNbsuDd3G5VgMJ8+e9t/AZjdUIKLJfTmjs1Y2EmcAmOpnKvkTrPajboogQyQ8lSh+iJLGOAOvgmlrAm8wZm7g3iJfWfqud+CtnYzJTcBEPg1z3Wc73184zWjvTEhmiI05kX3Q=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjBB8C1_1752815095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 13:04:56 +0800
Message-ID: <94c8899a-f116-4b6a-94d3-f8295ee3f535@linux.alibaba.com>
Date: Fri, 18 Jul 2025 13:04:54 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/14] khugepaged: add per-order mTHP khugepaged stats
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-14-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250714003207.113275-14-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/14 08:32, Nico Pache wrote:
> With mTHP support inplace, let add the per-order mTHP stats for
> exceeding NONE, SWAP, and SHARED.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 17 +++++++++++++++++
>   include/linux/huge_mm.h                    |  3 +++
>   mm/huge_memory.c                           |  7 +++++++
>   mm/khugepaged.c                            | 15 ++++++++++++---
>   4 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 2c523dce6bc7..28c8af61efba 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -658,6 +658,23 @@ nr_anon_partially_mapped
>          an anonymous THP as "partially mapped" and count it here, even though it
>          is not actually partially mapped anymore.
>   
> +collapse_exceed_swap_pte
> +       The number of anonymous THP which contain at least one swap PTE.
> +       Currently khugepaged does not support collapsing mTHP regions that
> +       contain a swap PTE.
> +
> +collapse_exceed_none_pte
> +       The number of anonymous THP which have exceeded the none PTE threshold.
> +       With mTHP collapse, a bitmap is used to gather the state of a PMD region
> +       and is then recursively checked from largest to smallest order against
> +       the scaled max_ptes_none count. This counter indicates that the next
> +       enabled order will be checked.
> +
> +collapse_exceed_shared_pte
> +       The number of anonymous THP which contain at least one shared PTE.
> +       Currently khugepaged does not support collapsing mTHP regions that
> +       contain a shared PTE.
> +
>   As the system ages, allocating huge pages may be expensive as the
>   system uses memory compaction to copy data around memory to free a
>   huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4042078e8cc9..e0a27f80f390 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -141,6 +141,9 @@ enum mthp_stat_item {
>   	MTHP_STAT_SPLIT_DEFERRED,
>   	MTHP_STAT_NR_ANON,
>   	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
> +	MTHP_STAT_COLLAPSE_EXCEED_SWAP,
> +	MTHP_STAT_COLLAPSE_EXCEED_NONE,
> +	MTHP_STAT_COLLAPSE_EXCEED_SHARED,
>   	__MTHP_STAT_COUNT
>   };
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e2ed9493df77..57e5699cf638 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -632,6 +632,10 @@ DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>   DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
>   DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_swap_pte, MTHP_STAT_COLLAPSE_EXCEED_SWAP);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_none_pte, MTHP_STAT_COLLAPSE_EXCEED_NONE);
> +DEFINE_MTHP_STAT_ATTR(collapse_exceed_shared_pte, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> +
>   
>   static struct attribute *anon_stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
> @@ -648,6 +652,9 @@ static struct attribute *anon_stats_attrs[] = {
>   	&split_deferred_attr.attr,
>   	&nr_anon_attr.attr,
>   	&nr_anon_partially_mapped_attr.attr,
> +	&collapse_exceed_swap_pte_attr.attr,
> +	&collapse_exceed_none_pte_attr.attr,
> +	&collapse_exceed_shared_pte_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d0c99b86b304..8a5873d0a23a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -594,7 +594,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				if (order == HPAGE_PMD_ORDER)
> +					count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				else
> +					count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);

Please follow the same logic as other mTHP statistics, meaning there is 
no need to filter out PMD-sized orders, because mTHP also supports 
PMD-sized orders. So logic should be:

if (order == HPAGE_PMD_ORDER)
	count_vm_event(THP_SCAN_EXCEED_NONE_PTE);

count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_NONE);

>   				goto out;
>   			}
>   		}
> @@ -623,8 +626,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		/* See khugepaged_scan_pmd(). */
>   		if (folio_maybe_mapped_shared(folio)) {
>   			++shared;
> -			if (order != HPAGE_PMD_ORDER || (cc->is_khugepaged &&
> -			    shared > khugepaged_max_ptes_shared)) {
> +			if (order != HPAGE_PMD_ORDER) {
> +				result = SCAN_EXCEED_SHARED_PTE;
> +				count_mthp_stat(order, MTHP_STAT_COLLAPSE_EXCEED_SHARED);
> +				goto out;
> +			}

Ditto.

> +
> +			if (cc->is_khugepaged &&
> +				shared > khugepaged_max_ptes_shared) {
>   				result = SCAN_EXCEED_SHARED_PTE;
>   				count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>   				goto out;

