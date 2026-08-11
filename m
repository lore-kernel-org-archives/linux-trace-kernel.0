Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC83D5652
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469747; cv=pass; b=H5Pma42jY1r5QyLsPtxbmYwVPDQQz3YytkxYtxrhPONkTYVQfGWvJ4Oa0n8BE027GGk4rchrUxAHaL8v+KI2WF8QB9Vtzw0Axe2/IHXixphqdzVQXXZixfWhCPE0K9ijaYiSlLV4r56mHsZisgMtaBYQO8vuEsVSXtsBSQVOyog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469747; c=relaxed/simple;
	bh=HFEKR1KyXmrTm3F9xUOu47SOoPRZkqoHDZ+hl5bPILM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKdD3MjTPG8nZRxEqp9zJnp+54zTLmmx0c7UGFb6fdHMTOtBXN/79Vib0u9qs36tTjl8vQqgFVGIu1LUI3tR8GF/+0tluY611WgAE7DRZ1O1IIdrrY0U+qBaZONlRreYAPbIMhYP3aXEmiF7upo8YPJB4tETpLpos+qIAJS3tVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/O29S4r; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/O29S4r"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso11255a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 10:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469744; cv=none;
        d=google.com; s=arc-20260327;
        b=lPM5b1qSVAaexH+zgoDi1YcG1EQQHGNS+h9xVO5q+gETW5ssgkk9OkCyTchNEcigiO
         M2EjIpcUm6mLxSOh0ECnnpHyxCpFGip3ZQdNaMZ6XDBeMbnhUGpr0UFHfP65N0OXHsL8
         M+JNANfs8LlJiGAuWWM4+5MhOY+UBHnKPlBd8+uw3OglZHhgECdmOt081UaI+J63lghk
         eCB9o6c9fo3HaPzmAuGIB1OgRppGVsCJqliiFxXYNFy7ZeLvFAuOtpsop7Jczg33KWYz
         kMklqRBXEO1AmL0wXzytJjISTtMxvIVdRMYLDD/M0rdgVbfj8FpoxKmwAt8/KXZwWwY8
         lJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gwkanNiJJOt3W9zGrZeGCByYdRnaM6Axwx+xtbIB3o4=;
        fh=+6Km0dXXxpDCJK1EEsWMO5kwbHnWmGt8SgN4kuoeO9k=;
        b=fQRNcrv3H0cCPIGF/A0XVMrf1bnqbPtR6VxUA/nCUA4u5cUtBT9b6Cp+MtAWUBHmOz
         ItDxfTabsnnlWFNP2E6iLjq3GMrUJ3OG14NeZsAu8rnnPxi8x/G7GbGwpn7xFCmcAfTj
         3JZ8JIcpyiy6sIvoH12iDI7Lt+EFqY34DSfYOCcJVoBJ/csAQt0MyFCEBXLgI42hIIzH
         dMOc0pcccrF6jFglx4a6mMq9tpyyv+IkybBeNd22CbrJCP4GZa226RXOh/kSUsQtohyl
         FDHU6het4cvMEWab86skRzdM0ASjC63oCCpGhJDsNbNxLgeKERfj16/LmmHrySsILEBv
         O6nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786469744; x=1787074544; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gwkanNiJJOt3W9zGrZeGCByYdRnaM6Axwx+xtbIB3o4=;
        b=a/O29S4r4YoiuC7rytL2/s0OUubS9cRYOFqtGA3gM5dRi2l9ALGBhBocGJUbOyhxpV
         vm7HReS0JgnnySLie/hPJ2iEpN2FeI6ox43ORP+/hC+WkpLGwaDWH9ySqkNZOC59/tVL
         KyIfo09xe8KgRJtKfSNYhJarXvX5eIjA0Uj5QXIk02YOKY6mLo0rxxBRN2UNAICUzo6Y
         6UWoiwYhAayjIoEnJ+NWBaikTWA5OUNns7qqgFZS+cocILxa2/Voqw7/waAcYINPgHiJ
         nW+oH6BveMgP/OUo+0ndNzzzskDRG4ZR1va418cvCp9ioT1tRsydhIA2eyQA/Ffq/+oL
         zPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469744; x=1787074544;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwkanNiJJOt3W9zGrZeGCByYdRnaM6Axwx+xtbIB3o4=;
        b=k4KLia9qXLVavC4RDCL1mb7qWGcBHI4WxUFldEkbxrG+FKAjcHUhG0Seqm2gd4Mv2m
         4QIzJvttCio0NLsEJBpttGb3IBdSZSrZcM+jKt9f6u5JpbhH5IsbdY+IcxtbgR1LjRP+
         bXiwUIxXWMDg7/BkRqHJN+Zh9h4EMWpUpKkkU4CkNksyqz/fmrRh8dmY36EfNzmKCnyG
         wdZPjbqRVG76x54OMDtcdijXLcPGvrLlMp5SyUJ9UkjaIneEZvj9i4DcIeRCSqoW3ndt
         voiR/79h55CHNYg5tddDnLeMPhQZkIoyQH5ckEM5BWnADZrpg2vKnAkhJ0kaFO7UrE2f
         Ou3w==
X-Forwarded-Encrypted: i=1; AHgh+Rq/g6Mbz2n+SnW+v+T95OyXtxbMap/JAWkVLX9SNSBNuqz+diCA7LgojaoepU6KgWburWp/k+6hwg0bj3HafTg8QpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVWZqI5RXbvzZcQlPWsywlB3YjUIzUchCsfW8CX22QuTDT0EC
	pY6wsttuYarIqcJ6wzAa0BQqsujqcHEzfJa/P6n8wyKzRkYEthRKEoxz0Z8RVnhk7w6Ui2dGBij
	Xt504Sgl3T9Pr0KMvdcvFIEn3ny72CG5QuJ4vKQOF
X-Gm-Gg: AR+sD11gixL3KAO72iFjTYhHqQZ6qBG+KU4VxwL9AqnTyRfADpF3598WFUUx2KrWZPt
	Ko+gwktuuwLddPbqVaF9eI9ZODl8Vlw6mZAjuUNgTjQQpaRXj/lk7vduWuajAB7P7R5JRI05ZVF
	fDjwHqqhtKGkeGGSh5jy5BQs0bqYv4oGSlyPzDz83WEtTgli8W9BWBL2rRcDwwqV2ySBiYJrHIH
	hEXmrSbnr2b2ewVeIMnWe5gFh3/TbT94CMBy+5asmYeeGyT72LjY9HOqTzU1X/DgLfew9R3tSRv
	gyR1Kv5OndCZsn4RhMJ7F+zqmVKvljcO3R5izAs21UIHNGgV6EYOGFrlUBdzeeHOLif4ZevfFUq
	fwGJsNRM7JP8kePzQ6WoIPq2nNe7xqHsRPK+TWmLnr6s/lg==
X-Received: by 2002:a05:6a20:9146:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3cc37e9e740mr1534763637.37.1786469743361; Tue, 11 Aug 2026
 10:35:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 10:35:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 10:35:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com> <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
 <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com> <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 10:35:42 -0700
X-Gm-Features: AUfX_mzVH_IxH_llFqF_n5qSatkkY6boTgbwv62Y4hoT6hGdHCS9TGJ6hA5mdxs
Message-ID: <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Mon, Aug 10, 2026 at 07:17:11PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> > On Mon, Aug 10, 2026 at 02:06:06PM -0700, Ackerley Tng wrote:
>> >> Yan Zhao <yan.y.zhao@intel.com> writes:
>> >>
>> >> >
>> >> > [...snip...]
>> >> >
>> >> >> > @@ -542,8 +576,21 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> >> >> >
>> >> >> >  	mas_init(&mas, mt, start);
>> >> >> >  	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>> >> >> > -	if (r)
>> >> >> > +	if (r) {
>> >> >> > +		*err_index = start;
>> >> >> >  		goto out;
>> >> >> > +	}
>> >> >> > +
>> >> >> > +	if (to_private) {
>> >> >> > +		unmap_mapping_pages(mapping, start, nr_pages, false);
>> >> >> > +
>> >> >> > +		if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
>> >> >> > +						     err_index)) {
>> >> >> Note: conversion failures could occur if another vCPU is attempting to map a GFN
>> >> >> within this range.
>> >> >>
>> >> >> CPU 0 (setting attributes)          CPU 1 (attempting to map)
>> >> >> --------------------------          --------------------
>> >> >>                                  A: mmu_invalidate_retry_gfn_unsafe
>> >> >>                                     filemap_invalidate_lock_shared
>> >> >>                                     __kvm_gmem_get_pfn ==> folio refcount++
>> >> >>                                     filemap_invalidate_unlock_shared
>> >> >>
>> >> >> filemap_invalidate_lock
>> >> >> filemap_get_folios
>> >> >> check folio_ref_count(folio) ==> Not match !!
>> >> >> filemap_invalidate_unlock
>> >> >>
>> >> >>                                  B: read_lock(&vcpu->kvm->mmu_lock);
>> >> >>                                     is_page_fault_stale
>> >> >>                                     kvm_mmu_finish_page_fault ==>folio recount--
>> >> >> 				    read_unlock(&vcpu->kvm->mmu_lock);
>> >> >>
>> >> >>
>> >>
>> >> Thanks for reporting this!
>> >>
>> >> >> Retrying in kvm_gmem_is_safe_for_conversion() or moving the invocation of
>> >> >> kvm_mmu_invalidate_start() + kvm_mmu_invalidate_range_add() to an earlier
>> >> >> position does not help as long as CPU 1 stays at stage A.
>> >> >>
>> >>
>> >> IIUC CPU 1 isn't blocked by a conversion so stages A and B should
>> >> complete fine, and CPU 0 would already be retrying for other reasons
>> >> anyway, like speculative refcounts from elsewhere in the kernel, so the
>> >> conversion would take longer but it'd work out.
>> >>
>> >> Is that understanding right, that this doesn't completely break
>> >> conversions?
>> > It depends on the timing. The max retry count cannot be expected under unlucky
>> > conditions.
>> >
>> >> >> So, should we avoid this failure?
>> >> >> e.g., by moving filemap_invalidate_unlock_shared() from stage A to after
>> >> >> stage B?
>> >>
>> >> Not really sure about this, how will control go back to guest_memfd
>> >> after the fault finishes for guest_memfd to unlock the filemap?
>> > I don't understand your question. But I find this solution is less ideal than my
>> > below proposal.
>> >
>>
>> When kvm_gmem_get_pfn() is called from kvm_mmu_faultin_pfn_gmem(), KVM
>> MMU takes over from there, there isn't another call when KVM MMU
>> finishes mapping the page into the stage 2 page tables back into
>> guest_memfd.
>>
>> After stage B, how is filemap_invalidate_unlock_shared() going to be
>> called? Do you mean filemap_invalidate_unlock_shared(folio->mapping)?
> Something like this. However, since this would cause the shared filemap
> invalidate lock to be held longer, conversions may have to wait for any on-going
> faults regardless of the GFN range, which I don't quite like.
>
>> I think filemap_invalidate_unlock_shared(folio->mapping) is a little
>> asymmetric...
>>
>> >> > Or what about having KVM always treat gmem page as non-refcounted, and have
>> >> > kvm_gmem_get_pfn() put folio refcount before releasing the filemap invalidate
>> >> > lock?
>> >> > Below patch is applied and tested at the end of this series.
>> >> >
>> >> > From 8c2f29bc15bceb6a8fa103cf2585ec11354fd74e Mon Sep 17 00:00:00 2001
>> >> > From: Yan Zhao <yan.y.zhao@intel.com>
>> >> > Date: Mon, 10 Aug 2026 06:24:52 +0800
>> >> > Subject: [PATCH] KVM: guest_memfd: Return gmem page as non-refcounted
>> >> >
>> >> > Have kvm_gmem_get_pfn() put gmem page refcount before releasing filemap
>> >> > invalidate lock and return the gmem page as non-refcounted. This avoids
>> >> > gmem memory attribute conversion failure caused by temporarily holding gmem
>> >> > page after faulting and before completing mapping.
>> >> >
>> >> > guest_memfd always holds gmem page in filemap cache. TDX does not increment
>> >> > gmem page refcount when having gmem pages mapped in S-EPT. Additionally,
>> >> > as gmem pages are not swappable, setting dirty or accessed bit is not
>> >> > necessary. Therefore, there's no need to treat gmem pages as refcounted
>> >> > pages.
>> >> >
>> >> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>> >> > ---
>> >> >  virt/kvm/guest_memfd.c | 5 ++---
>> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >> >
>> >> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> >> > index 2115e73e455a..e357b4ffa777 100644
>> >> > --- a/virt/kvm/guest_memfd.c
>> >> > +++ b/virt/kvm/guest_memfd.c
>> >> > @@ -1332,11 +1332,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >> >  #endif
>> >> >
>> >> >  	folio_unlock(folio);
>> >> > +	folio_put(folio);
>> >> >
>> >> >  	if (!r)
>> >> > -		*page = folio_file_page(folio, index);
>> >> > -	else
>> >> > -		folio_put(folio);
>> >> > +		*page = NULL;
>> >> >
>> >> >  out:
>> >> >  	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>> >> > --
>> >> > 2.43.2
>> >>
>> >> Hmm going with the above CPU 0 and 1 illustration, if instead CPU 0
>> >> truncates the folio and the folio ends up being freed, then KVM's MMU
>> >> has a pointer to a page that is already
>> >> freed. kvm_release_faultin_page() is passed the pointer to this page and
>> >> will dereference the page.
>> > Not really. It's just like KVM mapping non-refcounted pages.
>> > kvm_release_faultin_page() does not access the non-refcounted pages.
>> > The invalidate protocol also ensures no mapping of stale pfn.
>> >
>> > As below, if CPU 0 truncates the folio, it needs to hold filemap invalidate lock,
>> > add KVM mmu invalidate range, hold mmu_lock, zap KVM mappings before the
>> > truncation.
>> >
>> >
>> > CPU 0                                      CPU 1
>> > -----                                    --------
>> >                                          Save fault->mmu_seq
>> >
>> >                                      B1. filemap_invalidate_lock_shared
>> >                                          __kvm_gmem_get_pfn
>> >                                          folio_put
>> >                                          filemap_invalidate_unlock_shared
>> >
>> > 				     B2. read_lock
>> >                                          is_page_fault_stale
>> >
>> >                                      B3. kvm_tdp_mmu_map
>> >                                      B4. kvm_mmu_finish_page_fault
>> >                                          read_unlock
>> > A1. filemap_invalidate_lock
>> >     kvm_gmem_invalidate_start
>> >
>> > A2. write_lock
>> >     zap KVM MMU
>> >     write_unlock
>> >     truncate
>> >
>> > A3. kvm_gmem_invalidate_end
>> >     filemap_invalidate_unlock
>> >
>> >
>> > A1 occurs either before or after B1.
>> > 1) If A1 occurs before B1, B1 will find the correct pfn.
>> > 2) If A1 occurs after B1 and before B2,
>> >    a. if A2 is before B2, B2 must find the fault is stale, so it's fine.
>> >    b. if A2 is after B2, A2 must be after B4 as well. So, accessing stale pfn
>> >       in CPU 1 is fine.
>> > 3) If A1 occurs after B2 and before B3,
>> > 4) If A1 occurs after B3 and before B4,
>> > 5) If A1 occurs after B4,
>> >    A2 must be after B4 (for 3-5 conditions).
>> >    So, accessing stale pfn in CPU 1 is fine.
>>
>> It's not about the stale PFN, if there's no refcount on the page
>> returned from B1, then after A3, the page can be freed.
>>
>> Contractually, I think KVM is allowed to reference the page?
>> kvm_release_page_clean() calls kvm_set_page_accessed() on the page
> In my patch, "*page = NULL;" is returned in kvm_gmem_get_pfn(). So,
> fault->refcounted_page is NULL. With it, kvm_release_faultin_page() does
> not access the faultin PFN or the page.
> So, no worry about UAF.
>

Oh sorry, I missed that. I did see *page = NULL but I didn't connect the
dots.

Wait but in the above trace, if CPU 1 got the page correctly, wouldnt it
take the !r branch where page is not set to NULL? It's only later that
CPU 0 truncates the page, but by that time KVM MMU already holds a
non-NULL page pointer?

Unless on both branches guest_memfd just doesn't provide the page to KVM
MMU?

>> (UAF?). Not sure which other KVM architectures reference the struct page
>> itself. Are we going to teach the rest of KVM to not reference and not
>> do kvm_release_page_*?
> It's just like how KVM maps non-refcounted pages.
> And guest_memfd actually asks consumers (like TDX) not to take page refcount.
> __kvm_gmem_populate() also puts the folio refcount before invoking
> filemap_invalidate_unlock().
>

I guess long term this is what guest_memfd would like, that KVM should
just be getting PFNs from guest_memfd.

>> Would like to see what Sean thinks of this. Either way, is it okay to
>> follow up after conversions lands?
> Let's see what Sean thinks of this :)
> I raised this because the issue was encountered by one TDX's stress selftest.

Which stress selftest is this? I can try running this on my side too.

> I have no strong opinion on whether it should be fixed after this series lands.
> But the fix I proposed is quite small :)

Small code change, big implications! Might be nice to have this for the
future where guest_memfd no longer hands out pages.
