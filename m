Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D6332EC8;
	Mon, 27 Apr 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321289; cv=none; b=lYGOJ2S9c6uJISAJOrL7XGbV3xw9013I1uG/OD2U4kMS3mE9HLCIRqN3x31tapqQhnB4Na7KASMVQ/g18OQl6rR4mypSFQWvNk2+R2IkgYzWT2IfUob6i83dI9vw/5K8qci7VYmtQLoTiMh8ESFs/hoxvCra72dD6cWaATF8gWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321289; c=relaxed/simple;
	bh=LfEO2GoA4tssIBvxQvA9KN/YDpW25UUMbOSLYE27780=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be/PQeLskA+trWBNziv0O5ht6ue9trsOhz+w302OzI7tZG9S9ohjJcF4hjRCn9vhN5gIIJyqFDkJij8pR/HPYHLGGow22Dm6HaGlBZcWLS7334E4Ckn4ZBykCDp5PB24bf5fAGqV66xmStAP59WCSCtEaUBB+bbxPo9g5SRN0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scn2FMus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scn2FMus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBFC19425;
	Mon, 27 Apr 2026 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321288;
	bh=LfEO2GoA4tssIBvxQvA9KN/YDpW25UUMbOSLYE27780=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=scn2FMus/b0JjqogLdL1wDKbOhtjb4L+4fyveZh+6uhBqW7Y0g/71/8fbdUzOr3SN
	 QLG50KMOmamw+Y1/wXVXBqMm2LDSFWLU5TSDbwfgNlxpM/aZKD9rysUOEjIrftifAx
	 F14WVFAnNNEEis874EELBsfe7CwrOLJDwFBNdUBN7LRz91k5xHPhn3za0ga5vYC/du
	 NoOO6W1ZDCxyeII4mvcuOR6RFMenXxzNPetoA1GFxiqrAU7cEQ4s5doIZvEApqndOz
	 eOsM3q6AFxWuMN0rIaoEouIjHCumxMVBhMbrAQ9xh1/qUkEZUyMhNgl7SJ8Eo7AgHp
	 LnIkrFJ/wFRNw==
Message-ID: <f05f4506-2930-44ba-918a-e0e5bcb9d0f9@kernel.org>
Date: Mon, 27 Apr 2026 22:21:08 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 v16 07/13] mm/khugepaged: add per-order mTHP collapse
 failure statistics
To: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com,
 cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
 jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260419185750.260784-1-npache@redhat.com>
 <20260419185750.260784-8-npache@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260419185750.260784-8-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/26 20:57, Nico Pache wrote:
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

s/dont/do not/

> shared entry, those statistics keep track of how often we are
> encountering failed mTHP collapses due to these restrictions.
> 
> Now that we plan to support mTHP collapse for anon pages, lets also track

"We will add support for mTHP collapse for anonymous pages next; let's also ..."

> when this happens at the PMD level within the per-mTHP stats.

What about file collapse? For example, we do adjust
count_vm_event(THP_SCAN_EXCEED_SWAP_PTE) and
count_vm_event(THP_SCAN_EXCEED_NONE_PTE) there.

Wouldn't we want to update the HPAGE_PMD_ORDER side of things there already? or
would we want to use a different counter for that?

> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
>  include/linux/huge_mm.h                    |  3 +++
>  mm/huge_memory.c                           |  7 +++++++
>  mm/khugepaged.c                            | 21 +++++++++++++++++--
>  4 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index c51932e6275d..eebb1f6bbc6c 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -714,6 +714,30 @@ nr_anon_partially_mapped
>         an anonymous THP as "partially mapped" and count it here, even though it
>         is not actually partially mapped anymore.
>  
> +collapse_exceed_none_pte
> +       The number of collapse attempts that failed due to exceeding the
> +       max_ptes_none threshold. For mTHP collapse, Currently only max_ptes_none
> +       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other value will
> +       emit a warning and no mTHP collapse will be attempted. khugepaged will
> +       try to collapse to the largest enabled (m)THP size; if it fails, it will
> +       try the next lower enabled mTHP size. This counter records the number of
> +       times a collapse attempt was skipped for exceeding the max_ptes_none
> +       threshold, and khugepaged will move on to the next available mTHP size.

Why is everything after the first sentence worth documenting here? This doesn't
read like it belongs to a failure counter?

> +
> +collapse_exceed_swap_pte
> +       The number of anonymous mTHP PTE ranges which were unable to collapse due
> +       to containing at least one swap PTE. Currently khugepaged does not
> +       support collapsing mTHP regions that contain a swap PTE. This counter can
> +       be used to monitor the number of khugepaged mTHP collapses that failed
> +       due to the presence of a swap PTE.

Can we similarly simplify that (and make it consistent with the one above) to

"The number of collapse attempts that failed due to exceeding the max_ptes_swap
threshold."

> +
> +collapse_exceed_shared_pte
> +       The number of anonymous mTHP PTE ranges which were unable to collapse due
> +       to containing at least one shared PTE. Currently khugepaged does not
> +       support collapsing mTHP PTE ranges that contain a shared PTE. This
> +       counter can be used to monitor the number of khugepaged mTHP collapses
> +       that failed due to the presence of a shared PTE.

Same here

"The number of collapse attempts that failed due to exceeding the
max_ptes_shared threshold."

?

> +

[...]

-- 
Cheers,

David
