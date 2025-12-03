Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61893482EB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795745; cv=none; b=FNgcN5UsA0whrsqQ+IDr1qw7QdXjFwRk6jukrGYRcxaMUxKMRbNQ0m+Abg3LXXElqiHesABfGcuCe+DiOKpSedwk+b/GllbyQCkleYG6LrQkczRj8ui1mm0FVvJiDkSZFru4QqklJdgGCpndENkUomqWVYNbBN6lehVqBuOiYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795745; c=relaxed/simple;
	bh=46+pHSDGECTFXKdBSlAPQ2BuXKO8kPmZ4EnH4tXtE7o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fb/9arNAWtl6qDejQl4fxgNa1w09iHb+IS4BJqSPZWRZ/n1U/urxVyU5IjXQyhelZDdSfwefuDNIwwPLD2gHJrYr289Zm2nvdXHG8jjcMiKAGBQMeLBSapsNrMjHXNyDnraIflkxGLCBo9OiGGHP6WkP1PbWXKlqq7fN+fWnmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXz3NHvW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXz3NHvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764795742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wh68DuFmuCTpixNQpqPfNYRlyM5f+TpOLFbygDNv8C0=;
	b=bXz3NHvW2JZuAt0KLsJFvOuU5nTXe6jY60H92D62oeXd0oAgH0C7Z8RQVdugyqN2EYg0TJ
	3z1DUszqbPdNv4G8AtzA2spSUBAGegSCv0INxe5dYfTpDsMtw0AO3BNAxsIWHec7C0TPUT
	zob0hmYDZynEnn7HaqKLrHuAxOSmSns=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-1PFEAGJkOMiq75rugPmlJA-1; Wed, 03 Dec 2025 16:02:21 -0500
X-MC-Unique: 1PFEAGJkOMiq75rugPmlJA-1
X-Mimecast-MFC-AGG-ID: 1PFEAGJkOMiq75rugPmlJA_1764795741
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6466f2baso5312991cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 13:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764795741; x=1765400541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh68DuFmuCTpixNQpqPfNYRlyM5f+TpOLFbygDNv8C0=;
        b=hf31B7Py5kwkUcPclsfbxnwf+ZD0s98vMTx2ztwL0pQoLPOgJKqrJzNBVD/sf5ZkKf
         63ld1WvV/HREfmdbFjY/aw2EXpcZ705od2LON9Dvg1MbGWGEYEtmtCoVtBFh8RvMMRLY
         e3Lx+Zi0peOHfR/TCWFjkwpThDpp49c17IIN7eQ5yPAmEBRqRPt6sD1r/nYB4XzJCf5m
         n7mv+HW49PwnMuOGvsb/Toyzl/BlYHRvPt6l1jWO2IOZamQjZpQ2DQkiBC58xdF4QkPK
         +guzy0cqwyXfcai2Moidkha0Nkb7+V3Rmd5xItM126tC1Fndcs/jhQ+10rCDZOxPrIWv
         srSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBWtBbYai6XxOOeK1OayOZc4vGaou8rKVwIRrfMDvOKGXPLuBbGjuvKVIe4ah1J1viPcBEcIMQJtFVR3r2Pjtcahw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqN2mlh/RpO8OaiuBlVNTq1MT3VEYjJz3DEmaSkUgtcCTixf1b
	xp4mjILPewHRAp1Hgzg4qsS/SrRVq/o//QyHY2SkcUjALvatA6G9miZEFoJsUmVpCw3DYhJ/mEl
	T1mmt4dPOUNLtdI+JfgQsSTweKhkTrpcUpMaPFm6zN8EnhZvuSLxtBVogLhMMfLQ5BGNWHVKRFg
	==
X-Gm-Gg: ASbGncsXE2oWTd2xY14yxcLBGEIJdl/HOhXOILpCoOH38fTFsRfendtKGmrv1nf7fhf
	x8dWn0TMoccGO/pzLM1RHZvVeVRImOHl9Uss6jJdIjMxuQsKF8UlIadXm7K6SBs5ZcC4nnXnwRP
	MNFnB0q4GWgCPB5svr9oSKfGSoSPR0ssxsHoJkph9IgTPO7JlH9p1a5cLXFsLyvS6Y7AAx6/kuL
	NRVB5M1Qezx/9lEoldtQ7ydgqCNVktHDGNHvXC9KUDmjpBThO+IsMM7T2RIFDNkDxQUwdIs0iiZ
	TfmNR4iUv9m0/IFtWpgyvk7KC1bbIB+biacKv8FmGt22vF6ucGhRtHUxUVlY5/CiW0DgYbayiEL
	FiuWXdPxlWqL6diBpuA==
X-Received: by 2002:ac8:5916:0:b0:4ee:49b8:fb7f with SMTP id d75a77b69052e-4f01767ea57mr52094861cf.58.1764795740310;
        Wed, 03 Dec 2025 13:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTpqaTiqS+C1vNo/L4t/xM/bulVqn8SjD+/i4c5bpbIFGDFtHnpdO6/T7V6iwwIIk5Hbfq+Q==
X-Received: by 2002:ac8:5916:0:b0:4ee:49b8:fb7f with SMTP id d75a77b69052e-4f01767ea57mr52093951cf.58.1764795739759;
        Wed, 03 Dec 2025 13:02:19 -0800 (PST)
Received: from ?IPV6:2601:282:1c83:9aa0::72b3? ([2601:282:1c83:9aa0::72b3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b4aed6sm139789696d6.37.2025.12.03.13.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:02:18 -0800 (PST)
Message-ID: <b9f49744-932e-45ed-abd3-a9dcf6458b17@redhat.com>
Date: Wed, 3 Dec 2025 14:02:14 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 mm-new 07/16] khugepaged: introduce
 collapse_max_ptes_none helper function
From: Nico Pache <npache@redhat.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-8-npache@redhat.com>
In-Reply-To: <20251201174627.23295-8-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wAoHkn0w5yq2m_Vl4NsQfxeiPhFmE4FQ4eKSA1aX7ro_1764795741
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

The bot has reported a potential uninitialized use of a variable.

Can you please squash the following fixup to this commit.

Thank you,
Nico

----8<----

From 846f79d91a25ebad76cbab3690ae315cfe3cf278 Mon Sep 17 00:00:00 2001
From: Nico Pache <npache@redhat.com>
Date: Wed, 3 Dec 2025 13:42:18 -0700
Subject: [PATCH] khugepaged: fixup unintialized _pte variable

There is a potential use of an uninitialized variable after
`khugepaged: introduce collapse_max_ptes_none helper function`

Andrew can you please append this to Patch 7 of my series

as reported by the kernel test robot
>> mm/khugepaged.c:593:6: warning: variable '_pte' is used uninitialized
whenever 'if' condition is true [-Wsometimes-uninitialized]
593 | if (max_ptes_none == -EINVAL)
| ^~~~~~~~~~~~~~~~~~~~~~~~
mm/khugepaged.c:724:25: note: uninitialized use occurs here
724 | release_pte_pages(pte, _pte, compound_pagelist);
| ^~~~
mm/khugepaged.c:593:2: note: remove the 'if' if its condition is always false
593 | if (max_ptes_none == -EINVAL)
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
594 | goto out;
| ~~~~~~~~
mm/khugepaged.c:588:13: note: initialize the variable '_pte' to silence this warning
588 | pte_t *_pte;
| ^
| = NULL
1 warning generated.

Signed-off-by: Nico Pache <npache@redhat.com>
---
mm/khugepaged.c | 5 ++---
1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f425238d5d4f..7c7d04d6737e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -585,7 +585,7 @@ static int __collapse_huge_page_isolate(struct
vm_area_struct *vma,
struct page *page = NULL;
struct folio *folio = NULL;
unsigned long addr = start_addr;
- pte_t *_pte;
+ pte_t *_pte = pte;
int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
const unsigned long nr_pages = 1UL << order;
int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
@@ -593,8 +593,7 @@ static int __collapse_huge_page_isolate(struct
vm_area_struct *vma,
if (max_ptes_none == -EINVAL)
goto out;
- for (_pte = pte; _pte < pte + nr_pages;
- _pte++, addr += PAGE_SIZE) {
+ for (; _pte < pte + nr_pages; _pte++, addr += PAGE_SIZE) {
pte_t pteval = ptep_get(_pte);
if (pte_none_or_zero(pteval)) {
++none_or_zero;

--
2.52.0

On 12/1/25 10:46 AM, Nico Pache wrote:
> The current mechanism for determining mTHP collapse scales the
> khugepaged_max_ptes_none value based on the target order. This
> introduces an undesirable feedback loop, or "creep", when max_ptes_none
> is set to a value greater than HPAGE_PMD_NR / 2.
> 
> With this configuration, a successful collapse to order N will populate
> enough pages to satisfy the collapse condition on order N+1 on the next
> scan. This leads to unnecessary work and memory churn.
> 
> To fix this issue introduce a helper function that will limit mTHP
> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> This effectively supports two modes:
> 
> - max_ptes_none=0: never introduce new none-pages for mTHP collapse.
> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>   available mTHP order.
> 
> This removes the possiblilty of "creep", while not modifying any uAPI
> expectations. A warning will be emitted if any non-supported
> max_ptes_none value is configured with mTHP enabled.
> 
> The limits can be ignored by passing full_scan=true, this is useful for
> madvise_collapse (which ignores limits), or in the case of
> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> collapse is available.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8dab49c53128..f425238d5d4f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -463,6 +463,44 @@ void __khugepaged_enter(struct mm_struct *mm)
>  		wake_up_interruptible(&khugepaged_wait);
>  }
>  
> +/**
> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
> + * @order: The folio order being collapsed to
> + * @full_scan: Whether this is a full scan (ignore limits)
> + *
> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> + *
> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
> + * khugepaged_max_ptes_none value.
> + *
> + * For mTHP collapses, we currently only support khugepaged_max_pte_none values
> + * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and no mTHP
> + * collapse will be attempted
> + *
> + * Return: Maximum number of empty PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
> +{
> +	/* ignore max_ptes_none limits */
> +	if (full_scan)
> +		return HPAGE_PMD_NR - 1;
> +
> +	if (!is_mthp_order(order))
> +		return khugepaged_max_ptes_none;
> +
> +	/* Zero/non-present collapse disabled. */
> +	if (!khugepaged_max_ptes_none)
> +		return 0;
> +
> +	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
> +		return (1 << order) - 1;
> +
> +	pr_warn_once("mTHP collapse only supports max_ptes_none values of 0 or %d\n",
> +		      HPAGE_PMD_NR - 1);
> +	return -EINVAL;
> +}
> +
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> @@ -550,7 +588,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>  	const unsigned long nr_pages = 1UL << order;
> -	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +	int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
> +
> +	if (max_ptes_none == -EINVAL)
> +		goto out;
>  
>  	for (_pte = pte; _pte < pte + nr_pages;
>  	     _pte++, addr += PAGE_SIZE) {

