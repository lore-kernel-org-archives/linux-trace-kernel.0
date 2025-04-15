Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A4E552;
	Tue, 15 Apr 2025 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679391; cv=none; b=LUkwTzfstxbUyQH6SngvLjyvZSgrkpeDlvp7VJ/Xyd4mOPFwZJq/Tk6c4B/4rpWvXg5ukeXHxYGToqa5hVLdES8AxnfjD27j2Ec0hjxAEj3ZXAJxI4fMDu0TMoDmCera7qda6NcXoDAPI0k9MFyfZ2F6jlSchswSysepPBLHzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679391; c=relaxed/simple;
	bh=LMeLUEKg5xDcGioaeFPFvRZ04XyTLfjMaXAPpjddU/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuRkLtnVsiEl5lFtBSvqmPDL440LIEj+OUAI9AUx0rw5spjKA1B4RQ4CK+1GHgCy6QmMPqNjhNSjSyqO7A5LsQsb55Hs9sZKBTherHYNrfITSLnI3jqE4mD5VHkp03sw1AL3/m+f1RXprusBZWdrBT1THXakkU7p1D0JTRWT7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mGWRfMcB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGWRfMcB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=tkpYvkCIQ/uMw3T3hwTBxYM93KgGHR0Qg2Z4WopPNg8=; b=mGWRfMcBluKY5szv4YyyZdWO0A
	tGJjrHZD61V16NoOYr/Bdp8TvKCrOZ0D7brHyZfAtH/OGTRderEz/ZNE9KpG7c7G7+hsH64EcH53N
	3lmD4riYUr5WpDa22yfHucMb3N+5L/ABxB3TC5CVq6cDcc7Bo3uEOzl+aqvO7RegCZ9ZPQFxqAlbx
	fhNLtFz+t0eW4D6rBqZMyRZUjKScqdPhzfNCsT5EQufORCl095Tdnu16bPWWXN7bR/vd1H+sRd+E+
	VKpgtst32G/nkc+OmCBmS2Xx0XRR9jFSLR3o4wkpuOjf+GPPC0IXRML3OWBMGSBq7Jc5qhRP7LV2J
	ItGDSmSA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Uns-00000007kMN-3dik;
	Tue, 15 Apr 2025 01:09:33 +0000
Message-ID: <984797ec-9073-4a83-b3ee-7c5041f2d423@infradead.org>
Date: Mon, 14 Apr 2025 18:09:22 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com
References: <20250414220557.35388-1-npache@redhat.com>
 <20250414220557.35388-13-npache@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250414220557.35388-13-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/14/25 3:05 PM, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidence on how to utilize it.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..f0d4e78cedaa 100644
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
> @@ -144,6 +144,13 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
>  
> +khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size to
> +determine collapses. When using mTHPs its recommended to set max_ptes_none low.

                                         it's

> +Ideally less than HPAGE_PMD_NR / 2 (255 on 4k page size). This will prevent

   ^^^ not a sentence

> +undesired "creep" behavior that leads to continuously collapsing to a larger
> +mTHP size. max_ptes_shared and max_ptes_swap have no effect when collapsing to a
> +mTHP, and mTHP collapse will fail on shared or swapped out pages.
> +
>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular

-- 
~Randy

