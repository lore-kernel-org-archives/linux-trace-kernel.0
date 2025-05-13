Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D82116F6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127456; cv=none; b=aTg1QkL36i655U6ahLWqxVsO4Xv+8GTlhfAdInvaAQ15tvoKnTVvbaGT3RlD7xGhhALYIirD8XiIZnPQ71qLvEXe4rN//09SdCIujZj4IHigbMEQTM4hgxDmljuizcsPc2hILMqVhyVMZXW2vE4AKAGhJ6M3IP74FUhaMft13bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127456; c=relaxed/simple;
	bh=j/KIuNIGnOG07xaRel6ctCnYGJhi0CBcYqvFNW07Czw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kICDHwJFHN1kgoA74mh3FvnCjb5QYfxct6jSNMWbzmcz48B5pb0rITBZ9bgSteU74APnI25H5lQ7x/oFd1XhIAM4KcnT+vgeWIAAHG3kx29vuYK5Tl0Rg+1rdkoWTyrd9OVwm73m2zyuycF/OBxQ06nY7HMCMx/ZRI/hEozV6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI0x/0Ih; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI0x/0Ih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xRw8K0GCG9Y9Bw/zOLR2bmWzH8I8Xdc1bw9RZcjFhAY=;
	b=MI0x/0IhtK6rY3xvHUaUISg2VQP6I+76+q4SU9llQcRO8z8x6KwldXMn79xkM+D9C6jpFD
	U9Sp2W/AB7YiFx92i1ma61yxpamEidlQL0tEbqKvoMHuE/eYJsaDYAuuIXkr0J/ZOm9erR
	YGhYHqHnSE12zKRyHrrG7dZsXB24w2w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-s_tBWLPNNMujKzix00vPKQ-1; Tue, 13 May 2025 05:10:49 -0400
X-MC-Unique: s_tBWLPNNMujKzix00vPKQ-1
X-Mimecast-MFC-AGG-ID: s_tBWLPNNMujKzix00vPKQ_1747127448
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b63ca572so3475259f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 02:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127448; x=1747732248;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xRw8K0GCG9Y9Bw/zOLR2bmWzH8I8Xdc1bw9RZcjFhAY=;
        b=Z7Ff03tbniTlSzfHOKkPijWoo+dTXRvC/UNW7wlO/G42QlVlfcWEbDIpvHNUfrz8th
         qy+i7sG7GyfJRT0tRQSJXF3kQfH1Ik/gCSFC/1Q60Z7pe96Q25cH2J5YEwfAda+3j1gg
         8U9JfUjbAOBFaAbJ4UY6yVDQRkNWSJ+cysTnh+btEKBwAykQaNlwNcCveUsHTzKrXrzp
         OXwWzgNiNpEqj1tgx4XQ0bkvT/ySpvnQG2gTeVVeeA1a+8SwDw74lqakJ4oTRN4c7WZx
         CPilJfdLoZwhIKNQhZcOR78IKK+Ke039WxQagLDKIXxBG6G7jv6aNAsqNknoZW/5/hGn
         J7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr812QDy+jbORauokYXvO/QcDEmNBz3BinWHuA7AvBR/HhCKc8TDgxO8+bsA5IdTwzp6+2vssgwF5ZSFAW9jtkqZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6e7KYPke6Hgo1wCINz128GJ5Yr2mXIwRJsJa3oVM/47J0A8s
	3nzmej0V6Yts+4lJzd1Kgpi+wbiAKcgInCt2gWpuZX3unmBdm2r+mdKIVobYL4B8J/rTzpZfZFa
	XrMRSM2HJDT2kpwrsMmFrnbI0VcZuhE9tXz20FgD+HXOBe8TvYkj94rsNF4HNmXeOmWPHWA==
X-Gm-Gg: ASbGncuqB+6mttwfWAJWjmSSzZHCrFA8ksZIaaIA1Bn9oeroN9DhgyTD2+Y3oZBi5lh
	yqK7CRswfzy20LaHtbWv8+wC4tCjk0YVinxC/H+PH5zEwqlm7XgASJ2q+raxqTGyDw0Z5CX+hrg
	KVGYvOLDjJxirlfesu/ej1kAPcFzAXsLBiBRrD/b3a1Y86QIQghSPp1Fc5hnQblUA73jyVQ52DJ
	7mZ60pk632DHGEYMzby60Pm2JP+z4geqEF0SpmzkcM6HKv72U6F+D0LsiR1J9IWMbpfhuiMMYtY
	BV2cZ4K7hL0qHt4JoaHtRAvzZn8J9Nb07LygFmAODZ4yIk29uXL+kNYMdHPcZS9f8ETHn9HEI/3
	KCOlaWdEC1eF6rZv+SyqHGCFyyN6XaoLNmc8NOAI=
X-Received: by 2002:a05:6000:3102:b0:39c:cd5:4bc0 with SMTP id ffacd0b85a97d-3a1f64ae7bamr14020847f8f.52.1747127448245;
        Tue, 13 May 2025 02:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhMfGXX+LfoTaRmQxDRv9M6jlSovi0I1OJwxnluMn2RG9cmrKRWpV5jdZZJbJOGzf1wyCCZw==
X-Received: by 2002:a05:6000:3102:b0:39c:cd5:4bc0 with SMTP id ffacd0b85a97d-3a1f64ae7bamr14020781f8f.52.1747127447724;
        Tue, 13 May 2025 02:10:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34? (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de. [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a07sm15737321f8f.50.2025.05.13.02.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:10:47 -0700 (PDT)
Message-ID: <c7a4d470-16a7-423f-b9a4-a73210596d8b@redhat.com>
Date: Tue, 13 May 2025 11:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] mm: convert VM_PFNMAP tracking to pfnmap_track()
 + pfnmap_untrack()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250512123424.637989-1-david@redhat.com>
 <20250512123424.637989-5-david@redhat.com>
 <d180a8d2-87e2-4878-bca1-e6986b7fc110@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d180a8d2-87e2-4878-bca1-e6986b7fc110@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8edsbHJ00j1zfF6hAPldGKUlMhHNoTYrhcal93Aa4UA_1747127448
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.05.25 18:42, Lorenzo Stoakes wrote:
> On Mon, May 12, 2025 at 02:34:17PM +0200, David Hildenbrand wrote:
>> Let's use our new interface. In remap_pfn_range(), we'll now decide
>> whether we have to track (full VMA covered) or only lookup the
>> cachemode (partial VMA covered).
>>
>> Remember what we have to untrack by linking it from the VMA. When
>> duplicating VMAs (e.g., splitting, mremap, fork), we'll handle it similar
>> to anon VMA names, and use a kref to share the tracking.
>>
>> Once the last VMA un-refs our tracking data, we'll do the untracking,
>> which simplifies things a lot and should sort our various issues we saw
>> recently, for example, when partially unmapping/zapping a tracked VMA.
>>
>> This change implies that we'll keep tracking the original PFN range even
>> after splitting + partially unmapping it: not too bad, because it was
>> not working reliably before. The only thing that kind-of worked before
>> was shrinking such a mapping using mremap(): we managed to adjust the
>> reservation in a hacky way, now we won't adjust the reservation but
>> leave it around until all involved VMAs are gone.
>>
>> If that ever turns out to be an issue, we could hook into VM splitting
>> code and split the tracking; however, that adds complexity that might
>> not be required, so we'll keep it simple for now.
>>
>> Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Other than small nit below,
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   include/linux/mm_inline.h |  2 +
>>   include/linux/mm_types.h  | 11 ++++++
>>   mm/memory.c               | 82 +++++++++++++++++++++++++++++++--------
>>   mm/mmap.c                 |  5 ---
>>   mm/mremap.c               |  4 --
>>   mm/vma_init.c             | 50 ++++++++++++++++++++++++
>>   6 files changed, 129 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>> index f9157a0c42a5c..89b518ff097e6 100644
>> --- a/include/linux/mm_inline.h
>> +++ b/include/linux/mm_inline.h
>> @@ -447,6 +447,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
>>
>>   #endif  /* CONFIG_ANON_VMA_NAME */
>>
>> +void pfnmap_track_ctx_release(struct kref *ref);
>> +
>>   static inline void init_tlb_flush_pending(struct mm_struct *mm)
>>   {
>>   	atomic_set(&mm->tlb_flush_pending, 0);
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 15808cad2bc1a..3e934dc6057c4 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -763,6 +763,14 @@ struct vma_numab_state {
>>   	int prev_scan_seq;
>>   };
>>
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +struct pfnmap_track_ctx {
>> +	struct kref kref;
>> +	unsigned long pfn;
>> +	unsigned long size;	/* in bytes */
>> +};
>> +#endif
>> +
>>   /*
>>    * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
>>    * manipulate mutable fields which will cause those fields to be updated in the
>> @@ -900,6 +908,9 @@ struct vm_area_struct {
>>   	struct anon_vma_name *anon_name;
>>   #endif
>>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +	struct pfnmap_track_ctx *pfnmap_track_ctx;
>> +#endif
>>   } __randomize_layout;
>>
>>   #ifdef CONFIG_NUMA
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 064fc55d8eab9..4cf4adb0de266 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1371,7 +1371,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   	struct mm_struct *dst_mm = dst_vma->vm_mm;
>>   	struct mm_struct *src_mm = src_vma->vm_mm;
>>   	struct mmu_notifier_range range;
>> -	unsigned long next, pfn = 0;
>> +	unsigned long next;
>>   	bool is_cow;
>>   	int ret;
>>
>> @@ -1381,12 +1381,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   	if (is_vm_hugetlb_page(src_vma))
>>   		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
>>
>> -	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
>> -		ret = track_pfn_copy(dst_vma, src_vma, &pfn);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	/*
>>   	 * We need to invalidate the secondary MMU mappings only when
>>   	 * there could be a permission downgrade on the ptes of the
>> @@ -1428,8 +1422,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>   		raw_write_seqcount_end(&src_mm->write_protect_seq);
>>   		mmu_notifier_invalidate_range_end(&range);
>>   	}
>> -	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
>> -		untrack_pfn_copy(dst_vma, pfn);
>>   	return ret;
>>   }
>>
>> @@ -1924,9 +1916,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>>   	if (vma->vm_file)
>>   		uprobe_munmap(vma, start, end);
>>
>> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
>> -		untrack_pfn(vma, 0, 0, mm_wr_locked);
>> -
>>   	if (start != end) {
>>   		if (unlikely(is_vm_hugetlb_page(vma))) {
>>   			/*
>> @@ -2872,6 +2861,36 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
>>   	return error;
>>   }
>>
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +static inline struct pfnmap_track_ctx *pfnmap_track_ctx_alloc(unsigned long pfn,
>> +		unsigned long size, pgprot_t *prot)
>> +{
>> +	struct pfnmap_track_ctx *ctx;
>> +
>> +	if (pfnmap_track(pfn, size, prot))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (unlikely(!ctx)) {
>> +		pfnmap_untrack(pfn, size);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	ctx->pfn = pfn;
>> +	ctx->size = size;
>> +	kref_init(&ctx->kref);
>> +	return ctx;
>> +}
>> +
>> +void pfnmap_track_ctx_release(struct kref *ref)
>> +{
>> +	struct pfnmap_track_ctx *ctx = container_of(ref, struct pfnmap_track_ctx, kref);
>> +
>> +	pfnmap_untrack(ctx->pfn, ctx->size);
>> +	kfree(ctx);
>> +}
>> +#endif /* __HAVE_PFNMAP_TRACKING */
>> +
>>   /**
>>    * remap_pfn_range - remap kernel memory to userspace
>>    * @vma: user vma to map to
>> @@ -2884,20 +2903,51 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
>>    *
>>    * Return: %0 on success, negative error code otherwise.
>>    */
>> +#ifdef __HAVE_PFNMAP_TRACKING
>>   int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
>>   		    unsigned long pfn, unsigned long size, pgprot_t prot)
>>   {
>> +	struct pfnmap_track_ctx *ctx = NULL;
>>   	int err;
>>
>> -	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
>> -	if (err)
>> +	size = PAGE_ALIGN(size);
>> +
>> +	/*
>> +	 * If we cover the full VMA, we'll perform actual tracking, and
>> +	 * remember to untrack when the last reference to our tracking
>> +	 * context from a VMA goes away. We'll keep tracking the whole pfn
>> +	 * range even during VMA splits and partial unmapping.
>> +	 *
>> +	 * If we only cover parts of the VMA, we'll only setup the cachemode
>> +	 * in the pgprot for the pfn range.
>> +	 */
>> +	if (addr == vma->vm_start && addr + size == vma->vm_end) {
>> +		if (vma->pfnmap_track_ctx)
>> +			return -EINVAL;
>> +		ctx = pfnmap_track_ctx_alloc(pfn, size, &prot);
>> +		if (IS_ERR(ctx))
>> +			return PTR_ERR(ctx);
>> +	} else if (pfnmap_setup_cachemode(pfn, size, &prot)) {
>>   		return -EINVAL;
>> +	}
>>
>>   	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
>> -	if (err)
>> -		untrack_pfn(vma, pfn, PAGE_ALIGN(size), true);
>> +	if (ctx) {
>> +		if (err)
>> +			kref_put(&ctx->kref, pfnmap_track_ctx_release);
>> +		else
>> +			vma->pfnmap_track_ctx = ctx;
>> +	}
>>   	return err;
>>   }
>> +
>> +#else
>> +int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
>> +		    unsigned long pfn, unsigned long size, pgprot_t prot)
>> +{
>> +	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
>> +}
>> +#endif
>>   EXPORT_SYMBOL(remap_pfn_range);
>>
>>   /**
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 50f902c08341a..09c563c951123 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1784,11 +1784,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>>   		tmp = vm_area_dup(mpnt);
>>   		if (!tmp)
>>   			goto fail_nomem;
>> -
>> -		/* track_pfn_copy() will later take care of copying internal state. */
>> -		if (unlikely(tmp->vm_flags & VM_PFNMAP))
>> -			untrack_pfn_clear(tmp);
>> -
>>   		retval = vma_dup_policy(mpnt, tmp);
>>   		if (retval)
>>   			goto fail_nomem_policy;
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 7db9da609c84f..6e78e02f74bd3 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -1191,10 +1191,6 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
>>   	if (is_vm_hugetlb_page(vma))
>>   		clear_vma_resv_huge_pages(vma);
>>
>> -	/* Tell pfnmap has moved from this vma */
>> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
>> -		untrack_pfn_clear(vma);
>> -
>>   	*new_vma_ptr = new_vma;
>>   	return err;
>>   }
>> diff --git a/mm/vma_init.c b/mm/vma_init.c
>> index 967ca85179864..8e53c7943561e 100644
>> --- a/mm/vma_init.c
>> +++ b/mm/vma_init.c
>> @@ -71,7 +71,51 @@ static void vm_area_init_from(const struct vm_area_struct *src,
>>   #ifdef CONFIG_NUMA
>>   	dest->vm_policy = src->vm_policy;
>>   #endif
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +	dest->pfnmap_track_ctx = NULL;
>> +#endif
>> +}
>> +
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +static inline int vma_pfnmap_track_ctx_dup(struct vm_area_struct *orig,
>> +		struct vm_area_struct *new)
>> +{
>> +	struct pfnmap_track_ctx *ctx = orig->pfnmap_track_ctx;
>> +
>> +	if (likely(!ctx))
>> +		return 0;
>> +
>> +	/*
>> +	 * We don't expect to ever hit this. If ever required, we would have
>> +	 * to duplicate the tracking.
>> +	 */
>> +	if (unlikely(kref_read(&ctx->kref) >= REFCOUNT_MAX))
> 
> How not expected is this? :) maybe use WARN_ON_ONCE() if it really should
> never happen?
I guess if we mmap a large PFNMAP and then split it into individual 
PTE-sized chunks, we could get many VMAs per-process referencing that 
tracing.

Combine that with fork() and I assume one could hit this -- when really 
trying hard to achieve it. (probably as privileged user to get a big 
VM_PFNMAP, though, but not sure)

In that case, a WARN_ON_ONCE() would be bad -- because it could be 
triggered by the user.

We could do a pr_warn_once() instead, stating that this is not supported 
right now?

-- 
Cheers,

David / dhildenb

