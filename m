Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDB3596B;
	Thu, 15 May 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747284089; cv=none; b=pCR7YNmprThfmHme6pnJIi91jKzLZCYJEjrlzfpfM23rEEXEHOlmXXUi8JKXWSMZogp1QYlFUXNQRA85mWC91cm7X8dzDNqqY4TshhXQQAx7xesRt4+E1QPbzHeOzuij/NMDjbpFTCN9KhWrTsA8NEJh9IflyqQSfeS4VXSut/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747284089; c=relaxed/simple;
	bh=caTac13LQVC/U723M9009M6uh2ZgMJ6u9O1QnsGUjsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPWJQPOGjVPdFbKOlslyvSjihHIftdjtWL24rApa3T54cm40StO9gkOlPEeGCVwGnYXLH+FSvMVDtJCZFW53Ehq4KtqCXD/8lYfMyeVwfyWy2ovVNlsYgoCfbRW5Ysxx9KIy+V+bf7SJ6z+i/p1gqJ6w7yO/id+XvkXSqw//xJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c2XrBq4F; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2XrBq4F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bx2b5u0UIRHpVoa/cRaHEgW1QwNFD2w2QJQlPwvTLYw=; b=c2XrBq4FdmOhmUe9/Fim0tB23C
	Anh7n3crTKCIzBdlLLvXe85YGRb28OEArR6oV1dYk+lC5LgRE0+tFuu6YDHAP9W1OD7Ar5BQwTztx
	5GHIKgEqFyp9OZ3GyXtL+K83o7UyKtW+15UiQ1mG8tE8STi1rd2BdQ/XBLn7ZnsAAqBH1M+hYU5YQ
	TRJQiVQqpxoTDzYY4eBgO4PLjv51kwv0I12tMOJC9E3p2egwQzmIeZq2rIO8TXXYmwfzmJPA184nv
	LdufpwDRvQBes8/EEU9q5MvVmYEZi4ThPsmoRB+6vFVKoLsg/S/a4p9/hAmetxPfSO1crQ4noP8mh
	dFqfjQWg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFQP4-0000000HL60-02cW;
	Thu, 15 May 2025 04:41:07 +0000
Message-ID: <86845229-d8b3-4dae-89d3-888dc4d73ea2@infradead.org>
Date: Wed, 14 May 2025 21:40:57 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
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
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-13-npache@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250515032226.128900-13-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/25 8:22 PM, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidence on how to utilize it.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..5c63fe51b3ad 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,7 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.
>  
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -144,6 +144,18 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
>  
> +khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size
> +to determine collapses. When using mTHPs it's recommended to set
> +max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page
> +size). This will prevent undesired "creep" behavior that leads to
> +continuously collapsing to a larger mTHP size; When we collapse, we are

either                                      size. When
or                                          size; when

> +bringing in new non-zero pages that will, on a subsequent scan, cause the
> +max_ptes_none check of the +1 order to always be satisfied. By limiting
> +this to less than half the current order, we make sure we don't cause this
> +feedback loop. max_ptes_shared and max_ptes_swap have no effect when
> +collapsing to a mTHP, and mTHP collapse will fail on shared or swapped out
> +pages.
> +
>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular

-- 
~Randy

