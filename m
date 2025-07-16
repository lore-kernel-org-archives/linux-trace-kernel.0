Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B81F9F73
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674737; cv=none; b=dtLft4BuxhJ2JaJ1xjfjRaZFEfrm5ZWFXl8k6/ljcWU36wGjsh+By5w8gT5/ftfgfygPUhQ0d3ufscn0e+pyWkQmCj2DMjPFQ1UskVDnX3RzKoLmiABky1aaMQcoknoVuXiijSVqqCJbRCLoiJSe7m7bCkg7GdKO7GAOnzYNOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674737; c=relaxed/simple;
	bh=sXNYf8jKYN0j47CCXRie214M7GiYRmA2mfhk8b1asfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAJ1XF+65MUYMmHasEh1KDoaG/ZZptcU2kimgzNv121YkAdfIYm9hD1ZICFsjA9dDC83OOXyzng6ZS87V3VNmEI0jM84Sw+/rnGWqA18MXLWCRgURk6q/UwCG/spkzsQJLwt/xWs9z+Fm9Md96yzcpS6fjv4pyLmhUjp7TgpAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C97dB/aR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C97dB/aR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HKL/ioqMRL+OVZUNMLvu4+x8icxMSgPzuG9e7wSgWIg=;
	b=C97dB/aRzzyDtRI1Ffc0pNi2GBgYEbVZARTRZlr0zrOo64u0SqAZKfyC7V9V4hvHNhFUzh
	D1KX9wdthUKwKvTSF5TKVZIiXVAvwCl4wdFd8zr2VkI9OlKf62IcOIxHZH/VSCRWrBO9Up
	6xBBsJRVmriv/OX7B4v6fpRK+pv95xI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-eP2qHoj3PNOnnEDaS2Y84w-1; Wed, 16 Jul 2025 10:03:53 -0400
X-MC-Unique: eP2qHoj3PNOnnEDaS2Y84w-1
X-Mimecast-MFC-AGG-ID: eP2qHoj3PNOnnEDaS2Y84w_1752674620
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so3354300f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674618; x=1753279418;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HKL/ioqMRL+OVZUNMLvu4+x8icxMSgPzuG9e7wSgWIg=;
        b=B3FJQ+yhYIhGAiuJczGfw1YUNo6ZUNppLs1Gp4PU5U7//ursCtWncpuUGajJmdNUbw
         KY1ADKGoQcRopUq7VmmvprjRd4+vNCpgz1SEYSgUCs2q+qP4BxPraJQY5gclc4B542hO
         Wxqtv2sdJmkkYZoJNkeRPLaSMdqOEuQranGsoh71twksz0UFNFasXouyqOnDYl68pmor
         Wq8JzNdE9zmpJhETNCfqGug6Yl1kFKLfQpkw8tnWu8jDtfg3d1zVPQlVtpDTTWTRiWa0
         lYQbShq+68iTBnzLk+4+cOBKfCXgHhZx4ehxaIon8DjBoubfdDXU8iXw7rQBDbqynRjH
         a3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXS6l4lT7u33D9CG54BPVr4QP6m5kmGaDiWAvuKoZBngM8wRMGmvfMf/x19YOj4PciRtLYUNzkzHK53U7NomqiRkJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk+O1d31V1e/r5+9H71vKXTXfgcy57ifjaHWlF3/Xi6EJ/eHY
	v32JGvu0ocj5Tab2FYb53nOWhJN8RJeHRNpr6TPCGiIkxqqJuz/2FAopNv1iW8BW3+xJUEupYgc
	oodSuuX0s/cZ2Qy4o2Q98z3qA7oU2T0sb6cLgr9tz2YcXFoCWWaN9kklAvmiXL0pc92TiUW96yQ
	==
X-Gm-Gg: ASbGncs7UYHWXpBlHcBXaHv5XJC+mzuPo0uixKEAr+QBemqYfMVpEt/UbnopY/+bUiP
	4KHNPT2fX79ks6P5ryIJJ7X8MKCuGGpcs4T7/VMCOLj3BJmnxzE4tcCpwo8Z0QDfhCU+6hiZQzQ
	sMxjx46ywbVxLG0sOWP4vz7SRZrwihRj5xQ2615R67I63tKv6nY5M9+jUtEcFWImgdzGRe4C5dL
	m2Mce/7VBWQEGh7g5bYYwi/kNtxkTgpp7P9Ts+FKT1y5FDpQud+87MHIiS91Q2JUxY36jhXYQFG
	TbqLYzh1CrE/K+OmyytOVKhDYZrdffXj9QyZzmXNchc330+xPwYf2DoujDGEBCsQPFBAUI/PecV
	7INc4wnvM/4pJmKPO64qSxJXJF6hn9yl/5B2oeH/8NETXPNt/BGTnOn8t6yPIG+8MW5Q=
X-Received: by 2002:a05:6000:2882:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b60e4b8693mr2515233f8f.11.1752674617522;
        Wed, 16 Jul 2025 07:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7KJZbS3pdZOSz3nC1L0zpBMMFme0idl7aovGYW3kMKKv80JSc2vBIoa7ahtKy0zFGkndhXg==
X-Received: by 2002:a05:6000:2882:b0:3b4:9721:2b19 with SMTP id ffacd0b85a97d-3b60e4b8693mr2515114f8f.11.1752674616749;
        Wed, 16 Jul 2025 07:03:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm22135135e9.10.2025.07.16.07.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:03:36 -0700 (PDT)
Message-ID: <82cd57c2-d72f-423a-8dbc-d9b64d1d469b@redhat.com>
Date: Wed, 16 Jul 2025 16:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/14] khugepaged: introduce collapse_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
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
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-7-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-7-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBhLcPbM6icDoCwrC2XvyEcchIemvzQifyueQOB9IVk_1752674620
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> To add mTHP support we use this scan to instead record chunks of utilized
> sections of the PMD.
> 
> collapse_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the anon PMD. A minimum collapse order of 2 is used as this is
> the lowest order supported by anon memory.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> When attempting to collapse an order that has its order set to "always"
> lets always collapse to that order in a greedy manner without
> considering the number of bits set.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Any reason this should not be squashed into the actual mTHP collapse patch?

In particular

a) The locking changes look weird without the bigger context

b) The compiler complains about unused functions

> ---
>   include/linux/khugepaged.h |  4 ++
>   mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ff6120463745..0f957711a117 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef _LINUX_KHUGEPAGED_H
>   #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
> +#define KHUGEPAGED_MIN_MTHP_NR	(1<<KHUGEPAGED_MIN_MTHP_ORDER)

"1 << "

> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>   
>   extern unsigned int khugepaged_max_ptes_none __read_mostly;
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee54e3c1db4e..59b2431ca616 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
>   static struct kmem_cache *mm_slot_cache __ro_after_init;
>   
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>   struct collapse_control {
>   	bool is_khugepaged;
>   
> @@ -102,6 +107,18 @@ struct collapse_control {
>   
>   	/* nodemask for allocation fallback */
>   	nodemask_t alloc_nmask;
> +
> +	/*
> +	 * bitmap used to collapse mTHP sizes.
> +	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> +	 */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>   };
>   
>   /**
> @@ -838,10 +855,6 @@ static void khugepaged_alloc_sleep(void)
>   	remove_wait_queue(&khugepaged_wait, &wait);
>   }
>   
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>   static bool collapse_scan_abort(int nid, struct collapse_control *cc)
>   {
>   	int i;
> @@ -1115,7 +1128,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>   
>   static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)

Indent broken.

>   {
>   	LIST_HEAD(compound_pagelist);
>   	pmd_t *pmd, _pmd;
> @@ -1134,8 +1148,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * The allocation can take potentially a long time if it involves
>   	 * sync compaction, and we do not need to hold the mmap_lock during
>   	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>   	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>   
>   	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
> @@ -1272,12 +1290,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   out_up_write:
>   	mmap_write_unlock(mm);
>   out_nolock:
> +	*mmap_locked = false;
>   	if (folio)
>   		folio_put(folio);
>   	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>   	return result;
>   }
>   
> +/* Recursive function to consume the bitmap */
> +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +			int referenced, int unmapped, struct collapse_control *cc,
> +			bool *mmap_locked, unsigned long enabled_orders)
> +{
> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +	bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1 << (state.order);
> +		// Skip mTHP orders that are not enabled


/* */

Same applies to the other instances.

-- 
Cheers,

David / dhildenb

