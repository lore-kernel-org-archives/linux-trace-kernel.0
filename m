Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0623EAB7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474089; cv=none; b=qdK0L5sHGkBJK7deEZ6Ru5Hf5SD1dp3x26hdMyiIHlAb6npxGNfuolqg8Bx1gQAI9qh4WBB9Jpm41Y1bvVz5X83n4QDuUtmCISq2nQLgdstLq90FiO2MeaAzr5jNqZOJG4KnDRKbUjPXg/hzmIxYnbr/43zq8e0Eg/2SUfQYaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474089; c=relaxed/simple;
	bh=5kXxN1buPCEibtli7PNMck74QLCWKVIezrFApVtyX7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO/lfA+/tOvdvuZKVEEYHMLzPu4eVXG/kQPyZxyEhv/Ap4Qrg/USis93Anz6tOf7e15JXuwYYwztyMUZMc9qml1hrURF54ETdgAnqvLEDnruUiNaD46mF6fKKAD4CQIWyaKLmVyPE99V7wka3/biQqABcd71bIKVVp17oQVQ9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMPPOG5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMPPOG5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777474087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvYLtl/btGLGL1tvGyFSRjjJ5sO/Papa+85rbGP6yJ4=;
	b=XMPPOG5QUFcYqc84JR6Hlq4vREHt4rd5ZgkhuYIpjhoTaO6F9MDsDzI+reAijYslpQ08fL
	7upUl0oXNTg63JtJ0J7d7SgHp8+Y8Iv5SOxv8NScc66IYnYaM8jRlV7b/zhgFEUtRAwGGA
	Zu6B67QdqZTcbfWo0ygU7Q0KT38OSrk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Xp7BTeohNhWHyg0ar_CuRQ-1; Wed, 29 Apr 2026 10:48:06 -0400
X-MC-Unique: Xp7BTeohNhWHyg0ar_CuRQ-1
X-Mimecast-MFC-AGG-ID: Xp7BTeohNhWHyg0ar_CuRQ_1777474086
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-649deeeb00fso4956108d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 07:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474086; x=1778078886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvYLtl/btGLGL1tvGyFSRjjJ5sO/Papa+85rbGP6yJ4=;
        b=mT9I17CG179mkrKkYTy5kuIqI184uF3If4rBbrwW6GUuGUjpAPOGkw+MXHwnS3JnsN
         FpS/SfoAGU7pheouBKiogj+S2wNB9O/FrAZg7Vigwz53SWedxLb5z3M0wsdMzZJXg9yY
         RcIoIDDWiC3GpRZrpBJRTWS1GJ8pjI3VPnZYRme7PRpuYzJF01pIBrNdBGllZKV7bk6S
         sYF1rg5NJW9OJ9FZR1Z2CQfGlwlpGHMoS8rPK5PrugE9CuoI3qYAciiUz5xsNr342Vft
         D1nCRrAb6lkG7mwUownhD41DtR5nm6BIxyXJ6eVSenaLRh+T0OebcLAT1OW+ey/7WVpl
         rFcg==
X-Forwarded-Encrypted: i=1; AFNElJ/3gmIgmAu3GcXVnFDGEAILqPw3+suuuH2Aq/mklnI+rbdFKzQmxUPVZYTJbJTBu0QbSpJbLyga9fE3VeFuiGPiH60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eFs1/3VSnwgFXefYb64JNDDRx5h1TFFbVioQ12iuoMGeUJVP
	Lw+d0SbTBvXWQGa1Ha5ynC/fRUdguuh/gosc8XzcCcmXWNwQt3eBKWXLfoSnqMvpl60q2I7HJZO
	vdDFIm3pHxX49/QCGSpjEj+kCiUp0kMUiEjtHDA26NBEYM5lagzKz0DO/7hq/tYhZAdmwV03x0r
	7Uq3iSXUvOsAaoUBpzND0+INZCrwS/EYVIcg5gaICBorm6nTze
X-Gm-Gg: AeBDieslMRnnc/855ZsAefs4tIebz3AUZqOdlUwIDap53XcM3MNGt8rupfOqNl5PAqp
	58nPnughzSz10JEPTGusS6LT0btdYz/1iFrZ4W0376/mncTHU0SDNh/h+quITO7eUnfgsveMThK
	T7urGpQQwwyQ6ZZNLpbA6q5Yx00xgMpzp2/9TGUjrwC+WsZu30i0tmC3nNJon890L6txAl9TeuI
	UbIQAnt5jM2AQsEgHXQt7qljS1nwiVwz1B0pepEsaWuHjm0saY=
X-Received: by 2002:a05:690e:4388:b0:651:bb21:e7fd with SMTP id 956f58d0204a3-65bfb6e20f6mr3328305d50.42.1777474085478;
        Wed, 29 Apr 2026 07:48:05 -0700 (PDT)
X-Received: by 2002:a05:690e:4388:b0:651:bb21:e7fd with SMTP id
 956f58d0204a3-65bfb6e20f6mr3328242d50.42.1777474084850; Wed, 29 Apr 2026
 07:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-4-npache@redhat.com>
 <c82a0b73-67ff-45e6-a792-e610b35a5b2f@kernel.org>
In-Reply-To: <c82a0b73-67ff-45e6-a792-e610b35a5b2f@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 08:48:10 -0600
X-Gm-Features: AVHnY4KJXyCS0pyZ03HCURX89EqHRn0KObQgQxv-NQzUy6bFSsVv_67rAsVp3HM
Message-ID: <CAA1CXcCNpLHkRO82m+XZUVEKsNrvQgUFWVbV7=4PwL8M7jmsug@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 03/13] mm/khugepaged: rework max_ptes_* handling
 with helper functions
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKghO7TZ-eAeORMRIQLPrwNJFikEY1i2YhOXTRGpQHo_1777474086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 1:52 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
>> The following cleanup reworks all the max_ptes_* handling into helper
>> functions. This increases the code readability and will later be used to
>> implement the mTHP handling of these variables.
>>
>> With these changes we abstract all the madvise_collapse() special casing
>> (dont respect the sysctls) away from the functions that utilize them. And
>> will later in this series to cleanly restrict mTHP collapses behaviors.
>>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 114 +++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 78 insertions(+), 36 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index afac6bc4e76d..f42b55421191 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -348,6 +348,58 @@ static bool pte_none_or_zero(pte_t pte)
>>      return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>>   }
>>
>> +/**
>> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>
> empty PTE or PTE mapping the shared zeropage ? That should be clarified also below.

Ah fair point, "empty" isn't the best representation of a "none"/zeropage.

>
>> + * @cc: The collapse control struct
>> + * @vma: The vma to check for userfaultfd
>> + *
>> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>> + * empty page.
>
> Not completely accurate due to uffd. And it's not really "empty page".

Sorry I forgot to update this comment. I originally planned on skipping
the VMA passing, but then figured later that it would make the code even
more uniform (as you suggested)

>
> Is that information really necessary for the caller? I'd suggest you drop this
> here and instead add a comment inline above the "return HPAGE_PMD_NR;".

Yeah, I'm not really sure; I can shorten them. I was heeding to lorenzos
request to add these with docstring headers

>
>> + *
>> + * Return: Maximum number of empty PTEs allowed for the collapse operation
>> + */
>> +static unsigned int collapse_max_ptes_none(struct collapse_control *cc,
>> +            struct vm_area_struct *vma)
>> +{
>> +    if (vma && userfaultfd_armed(vma))
>> +            return 0;
>> +    if (!cc->is_khugepaged)
>> +            return HPAGE_PMD_NR;
>> +    return khugepaged_max_ptes_none;
>> +}
>> +
>> +/**
>> + * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse
>
> "shared PTE" is not quite clear.
>
> "PTEs that map shared anonymous pages" ?

That works for me, thank you

>
>> + * @cc: The collapse control struct
>> + *
>> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>> + * shared page.
>
> Same comment as above.

ack

>
>> + *
>> + * Return: Maximum number of shared PTEs allowed for the collapse operation
>> + */
>> +static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
>> +{
>> +    if (!cc->is_khugepaged)
>> +            return HPAGE_PMD_NR;
>> +    return khugepaged_max_ptes_shared;
>> +}
>> +
>> +/**
>> + * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse
>
> We're actually checking non-present page table entries (anonymous THP collapse)
> or non-present pagecache entries (file THP collapse).
>
> I wonder if there is an easy way to clarify that here, at least in the
> description (confusing name can stay unless we find something better).

I'll update the comment to include some form of this. In my mind the
name should probably stay relatively consistent to the sysctl value.

>
>> + * @cc: The collapse control struct
>> + *
>> + * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>> + * swap page.
>
> Dito.

ack!

>
>> + *
>> + * Return: Maximum number of swap PTEs allowed for the collapse operation
>> + */
>> +static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
>> +{
>> +    if (!cc->is_khugepaged)
>> +            return HPAGE_PMD_NR;
>> +    return khugepaged_max_ptes_swap;
>> +}
>> +
>>   int hugepage_madvise(struct vm_area_struct *vma,
>>                   vm_flags_t *vm_flags, int advice)
>>   {
>> @@ -546,21 +598,19 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>      pte_t *_pte;
>>      int none_or_zero = 0, shared = 0, referenced = 0;
>>      enum scan_result result = SCAN_FAIL;
>> +    unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
>> +    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
>
> These could be const, right? Or will that change in future patches?

Yes I believe these can be const now! Thank you

>
>>
>>      for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>>           _pte++, addr += PAGE_SIZE) {
>>              pte_t pteval = ptep_get(_pte);
>>              if (pte_none_or_zero(pteval)) {
>> -                    ++none_or_zero;
>> -                    if (!userfaultfd_armed(vma) &&
>> -                        (!cc->is_khugepaged ||
>> -                         none_or_zero <= khugepaged_max_ptes_none)) {
>> -                            continue;
>> -                    } else {
>> +                    if (++none_or_zero > max_ptes_none) {
>>                              result = SCAN_EXCEED_NONE_PTE;
>>                              count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>                              goto out;
>>                      }
>> +                    continue;
>>              }
>>              if (!pte_present(pteval)) {
>>                      result = SCAN_PTE_NON_PRESENT;
>> @@ -591,9 +641,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>
>>              /* See collapse_scan_pmd(). */
>>              if (folio_maybe_mapped_shared(folio)) {
>> -                    ++shared;
>> -                    if (cc->is_khugepaged &&
>> -                        shared > khugepaged_max_ptes_shared) {
>> +                    if (++shared > max_ptes_shared) {
>>                              result = SCAN_EXCEED_SHARED_PTE;
>>                              count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
>>                              goto out;
>> @@ -1270,6 +1318,9 @@ static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
>>      unsigned long addr;
>>      spinlock_t *ptl;
>>      int node = NUMA_NO_NODE, unmapped = 0;
>> +    unsigned int max_ptes_none = collapse_max_ptes_none(cc, vma);
>> +    unsigned int max_ptes_shared = collapse_max_ptes_shared(cc);
>> +    unsigned int max_ptes_swap = collapse_max_ptes_swap(cc);
>
> Same question here.

ack! will adjust.

>
>>
>>      VM_BUG_ON(start_addr & ~HPAGE_PMD_MASK);
>>
>
>
> In general, LGTM. With the doc fixed up
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thank you Ill get those updated.
>

