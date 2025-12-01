Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A8DF72;
	Mon,  1 Dec 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614345; cv=none; b=uYkmwoL/gnAUe92JS5UEj6DSpro9oNJAlTlk4RezbtXtXP5p6VxCkgta7w1Qn/q9eD9Dvd2NWFOmvhkA8Wqyp+M8zPCVVAJ8Z+cyfHJi2C0RHF2GiLJF72FrViySSDLuT55GuZyMoSD7oe1T71IxUzAeTJjWK1iANl6CyOlr18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614345; c=relaxed/simple;
	bh=3EJvnyc/jcabyykc1MitwC+ykMnzEJpqcsrSDH4bVos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4eV4uQW3ozRqvrjXx/ztl/nXupQUitzNY1+Oyk4RqE2fOZlDjNbW9N0Z/S6hIMbNW3LXcN8Lh6F57Ym+W1kxv+if8whz9yqrXpjTpwFxcY7rYTwd9Vkl8ZzM5zp6Id8kx4XuklrDpQYGr+uROvQhHa+j7mlhVHDfLrloAsLKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kn5gHxRd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kn5gHxRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Jvo3HfTGdOgZmyDWsndn9CedHCVWn6B7/Qgyo4cTBnw=; b=Kn5gHxRd9UKdQKCSJQJBuzNm8c
	OJMVgBNG3O3TEKQelzD1dJa5JlvBf8twwHCzXuDaiGz10BEcop6qBaNWvllcCsIo8ADIwUKhwggEU
	Qrf8w8LpQ6d3+pxr1/SoLjrmzAzCKW2JtGEYzAsuZyqK38tIzv8eXnjdsCpBE6ihQ9JgrN2+7hmQv
	KLY71Rfdv5VW5LYMfbDZZvK0q8tzAPL7Y0uRHLxUic6uD3xR9/qYPBRbIgHHxNf7483msyvww48p8
	YW/y877cEf8Ot+Fd822pyAUw8JdezMe4LWYHR0b41ffDOng/+emP9MYIuUAgmR6q8s0v+8TBti06i
	FPjUyTBA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ8na-00000004Qxz-2pUB;
	Mon, 01 Dec 2025 18:38:58 +0000
Message-ID: <654dc140-3ee6-4c0c-96d6-c1405b048dc1@infradead.org>
Date: Mon, 1 Dec 2025 10:38:55 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 mm-new 10/16] khugepaged: add per-order mTHP collapse
 failure statistics
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, hughd@google.com,
 richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
 rppt@kernel.org, jannh@google.com, pfalcato@suse.de
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-11-npache@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251201174627.23295-11-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 9:46 AM, Nico Pache wrote:
> Add three new mTHP statistics to track collapse failures for different
> orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:
> 
> - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to swap
> 	PTEs
> 
> - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
>   	exceeding the none PTE threshold for the given order
> 
> - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to shared
>   	PTEs
> 
> These statistics complement the existing THP_SCAN_EXCEED_* events by
> providing per-order granularity for mTHP collapse attempts. The stats are
> exposed via sysfs under
> `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
> supported hugepage size.
> 
> As we currently dont support collapsing mTHPs that contain a swap or
> shared entry, those statistics keep track of how often we are
> encountering failed mTHP collapses due to these restrictions.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  mm/huge_memory.c                           |  7 +++++++
>  mm/khugepaged.c                            | 16 ++++++++++++---
>  4 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index c51932e6275d..d396d1bfb274 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -714,6 +714,30 @@ nr_anon_partially_mapped
>         an anonymous THP as "partially mapped" and count it here, even though it
>         is not actually partially mapped anymore.
>  
> +collapse_exceed_none_pte
> +       The number of collapse attempts that failed due to exceeding the
> +       max_ptes_none threshold. For mTHP collapse, Currently only max_ptes_none

	                                              currently

> +       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other value will
> +       emit a warning and no mTHP collapse will be attempted. khugepaged will
> +       try to collapse to the largest enabled (m)THP size, if it fails, it will

	                                                size. If
or
	                                                size; if

> +       try the next lower enabled mTHP size. This counter records the number of
> +       times a collapse attempt was skipped for exceeding the max_ptes_none
> +       threshold, and khugepaged will move on to the next available mTHP size.
> +
> +collapse_exceed_swap_pte
> +       The number of anonymous mTHP pte ranges which were unable to collapse due

	                               PTE

> +       to containing at least one swap PTE. Currently khugepaged does not
> +       support collapsing mTHP regions that contain a swap PTE. This counter can
> +       be used to monitor the number of khugepaged mTHP collapses that failed
> +       due to the presence of a swap PTE.
> +
> +collapse_exceed_shared_pte
> +       The number of anonymous mTHP pte ranges which were unable to collapse due

	                               PTE

> +       to containing at least one shared PTE. Currently khugepaged does not
> +       support collapsing mTHP pte ranges that contain a shared PTE. This

	                          PTE

> +       counter can be used to monitor the number of khugepaged mTHP collapses
> +       that failed due to the presence of a shared PTE.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help


-- 
~Randy

