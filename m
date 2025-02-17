Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CB228CB7;
	Mon, 17 Feb 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819579; cv=none; b=R5ekI5aWN7qM1oHcg+qmbkbg7e0sJCiNpixDwzOoNgRtiVdIpBidq2lpwIzwskm9AwFgumTnMaEGYt/Mq6d4D8tFOdhnls5otk7H+iTqpqF91bPOw8g0qxT7ktscwwYNVyAxJnP+9KOxBKDDd1uF+DSHqGk2y/UiHe0nayi6blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819579; c=relaxed/simple;
	bh=wroSPb75QAOFpnFIYnZvQFiY10V/BHpO7lah+Q6npC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+Yv7YF+pl6V2jsZBwwI1Mu/QD8C7yPIGyPaWHCRF/wTAQ0ZTiQkT3DpVrXGhQUPK3lXIwxzMapKgULyXq7fpE1X/DD4TYLCD4k6KdXPpFjCmy90CZKeVe5KrPr763W0VsT7ZGRlQ8pzjga7FH1sqlzUVhX5cNDhThrJAU83tJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Ui+Wqj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Ui+Wqj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab771575040so1120445566b.1;
        Mon, 17 Feb 2025 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819575; x=1740424375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1XqE+N5gxunVpF/j2ifr6T1PnuKn5HHjxQR0vrMik0=;
        b=R4Ui+Wqj3zrTvZlEbg2chXkmtn2O5UsbZvHxhYP0kGbhB4opeqvNjomHH5dD1UqWVG
         SXF9T80MLZi35B08YS1bJ+AkvFmOghAnTx7OtzAttD/YNYX6j5T3cOZzGmWR9GERHbgw
         8kHp9Lqt3ZyOE5rKI8rNp5oEh8kqw1tauhv26W9N+ieRgEAcCE5RM7XZVTubAOl4SoA2
         10p2a7QPEeTTT6nuZJ8eyA0mt2akhuzDJcuTcdn5yfY6fc6OH2uUQ5nbvuCmjvpBy9D9
         wdSCtrVAoQet02/ZDq434CHh9GmTBiAdTUgF4AZQ7Z+ZnSjlrs9n8jXhMvUQOAb9rcyc
         3cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819575; x=1740424375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1XqE+N5gxunVpF/j2ifr6T1PnuKn5HHjxQR0vrMik0=;
        b=lB9IXKN8L/njERrcgdR2sXyXPbACo97fMWkMSCTnLVNrrxFrIDeuB5KfrqAtbFx+Z/
         sjKX1c8l76pktYYk/vitDbGty9HeAvkS9tigYAtuhkOe9MdSgaWb9ootclOjtsMpnWKo
         t7cMltxW5GgvTnjlaaBxR96/AkHLNvr5wOhb0WffnakuXOXgQuWZmR+b9GT0qOH22btn
         hvrTC3axeF/lGgpA/p86SU8yAJlvi+VtHQfEhdbKNRZrebwFz8DQk6FtqL8Mbt4l1SsC
         eAxkaGjBUnmP5mKac148NBSU1P/jp06mPtJCSgKWxtqBtOhVVp2NI8MdEP33NmhRQHtc
         wjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWqX0s83K7E4Mt717OhLlFpj26L1MpXZYUfPfa9LTbOxX4rrd6uCfybsMXoDXCmerszxg70iJ5kjm4xJ+sqh1kF2f@vger.kernel.org, AJvYcCW3t2HKC3A1MY3meGAZ/heTTjbc6O0gHr2nWaordBb60OYuL1wpey/ztIz3HZ34cmGcCRHRxIFPPsdmuNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznc/3L5GZLPStwIbh0EOcl5Kxi8zG3nF/eLZL7aaJETiBFXpge
	3+igvDPnmmrpiJGxIFupmURCMfHbwYdvOcq62JWsS6aILYTQI9P/
X-Gm-Gg: ASbGnctBshuAY14xQ/Y7hIKEcpPnV6cUIy+883vx1otL/wE+Hc/GVYg59+VEYim+ImU
	T7ODDsqmYDjPi3YgYHRMeS+sLKiYmuXXxxiq1/E7/EJp1WC/ycSUZMFAGj4wsHOMFxvwM5qujwm
	s46xyQvLx/oh3JgVro3ReSjUwriy7ABSe2B31xK0NuE3tPwqx0KNidoU1VxylmaPFvnjnlfg26z
	H/u9sMTfFNtfuDfk6bKTVhLQzJuBzNvCteXTKhTcHOjkaz9ompfVDxFXU2TDELPpo29K13LOM+N
	cjfspNA5LD+3Z46aD8tp4fQs2lJCfV/ptwxTjcmi/Cv5iNvrhvVeDibFpxPku2ZhmFQ=
X-Google-Smtp-Source: AGHT+IH7FT7dwaTGDtD7OHpQ+eIRglHZ11kMv1CSIodwYEeW1DhLomSnsedDeLX6GIb2YnfnGleW3g==
X-Received: by 2002:a17:906:99d2:b0:abb:b666:8e4e with SMTP id a640c23a62f3a-abbb6668e5emr40552066b.26.1739819575268;
        Mon, 17 Feb 2025 11:12:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:fb:39c9:9a24:d181? ([2620:10d:c092:500::7:6466])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232275sm926999866b.31.2025.02.17.11.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 11:12:54 -0800 (PST)
Message-ID: <e3f2ca48-7e33-4079-9e89-0d60d304e2b8@gmail.com>
Date: Mon, 17 Feb 2025 19:12:53 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 6/9] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 audra@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-7-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250211003028.213461-7-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/02/2025 00:30, Nico Pache wrote:
> khugepaged scans PMD ranges for potential collapse to a hugepage. To add
> mTHP support we use this scan to instead record chunks of fully utilized
> sections of the PMD.
> 
> create a bitmap to represent a PMD in order MTHP_MIN_ORDER chunks.

nit:

s/MTHP_MIN_ORDER/MIN_MTHP_ORDER/


> by default we will set this to order 3. The reasoning is that for 4K 512
> PMD size this results in a 64 bit bitmap which has some optimizations.
> For other arches like ARM64 64K, we can set a larger order if needed.
> 
> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the PMD.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> If a order is set to "always" lets always collapse to that order in a
> greedy manner.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/khugepaged.h |  4 ++
>  mm/khugepaged.c            | 89 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 86 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 1f46046080f5..1fe0c4fc9d37 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
> +#define MIN_MTHP_ORDER	3
> +#define MIN_MTHP_NR	(1<<MIN_MTHP_ORDER)
> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE * PAGE_SIZE) - MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - MIN_MTHP_ORDER))
>  
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 3776055bd477..c8048d9ec7fb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>  
>  static struct kmem_cache *mm_slot_cache __ro_after_init;
>  
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>  struct collapse_control {
>  	bool is_khugepaged;
>  
> @@ -102,6 +107,15 @@ struct collapse_control {
>  
>  	/* nodemask for allocation fallback */
>  	nodemask_t alloc_nmask;
> +
> +	/* bitmap used to collapse mTHP sizes. 1bit = order MIN_MTHP_ORDER mTHP */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>  };
>  
>  /**
> @@ -851,10 +865,6 @@ static void khugepaged_alloc_sleep(void)
>  	remove_wait_queue(&khugepaged_wait, &wait);
>  }
>  
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>  static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>  {
>  	int i;
> @@ -1112,7 +1122,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  
>  static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)
>  {
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> @@ -1130,8 +1141,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * The allocation can take potentially a long time if it involves
>  	 * sync compaction, and we do not need to hold the mmap_lock during
>  	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>  	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>  
>  	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
> @@ -1266,12 +1281,71 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  out_up_write:
>  	mmap_write_unlock(mm);
>  out_nolock:
> +	*mmap_locked = false;
>  	if (folio)
>  		folio_put(folio);
>  	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>  	return result;
>  }
>  
> +// Recursive function to consume the bitmap
> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +			int referenced, int unmapped, struct collapse_control *cc,
> +			bool *mmap_locked, unsigned long enabled_orders)
> +{

Introducing a function and not using it probably might make the kernel test bot
and compiler complain at this commit, you might want to merge this with the next
commit where you actually use it.

> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1 << (state.order);
> +		// Skip mTHP orders that are not enabled
> +		if (!test_bit(order, &enabled_orders))
> +			goto next;
> +
> +		// copy the relavant section to a new bitmap
> +		bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
> +				  MTHP_BITMAP_SIZE);
> +
> +		bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
> +		threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
> +				>> (HPAGE_PMD_ORDER - state.order);
> +
> +		//Check if the region is "almost full" based on the threshold
> +		if (bits_set > threshold_bits
> +			|| test_bit(order, &huge_anon_orders_always)) {
> +			ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
> +					mmap_locked, order, offset * MIN_MTHP_NR);
> +			if (ret == SCAN_SUCCEED) {
> +				collapsed += (1 << order);
> +				continue;
> +			}
> +		}
> +
> +next:
> +		if (state.order > 0) {
> +			next_order = state.order - 1;
> +			mid_offset = offset + (num_chunks / 2);
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, mid_offset };
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, offset };
> +			}
> +	}
> +	return collapsed;
> +}
> +
>  static int khugepaged_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
> @@ -1440,7 +1514,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
>  		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc);
> +					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>  		/* collapse_huge_page will return with the mmap_lock released */
>  		*mmap_locked = false;
>  	}
> @@ -2856,6 +2930,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	mmdrop(mm);
>  	kfree(cc);
>  
> +
>  	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
>  			: madvise_collapse_errno(last_fail);
>  }

