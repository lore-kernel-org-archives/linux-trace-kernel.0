Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B652566FA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199143; cv=none; b=P65FdbwyeBtlKgoMB9wCfyy0HaJNf1hVtiY1XwTEYJCQC1fH94L/FnEwTiP9dU52H+R3cfrRigvThE4Z5NqwjGS8s+s1kugKQ7Z7AhJX2RJKIXjjvvEc2rjHvvh8RoEt1Ptj6q0zCO0Z6gpjgwuIsXUCrAMJZVFMxm0bofH/2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199143; c=relaxed/simple;
	bh=XxYqrR2p6pqZVJcclrADBp6wv1N4q5BEPDUnKHOTyJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLXe4KwLn5m/FKHrdO3qdZcTDbdmXpA/EkNY9GlSWmRRBODMUdj9md7IukjcBpiiMS71VlD57A66bG7vSEkUl2Iq9aQivLZdViIqSzlNuwzT3dJ7f1h3NgVXEFv8bpyBy7AO9Y7yWu9e5U+J/OqolZDmMdcEPdmBsHc7doKbm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeVCULi8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeVCULi8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746199140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Us6VhmJrM3rYoUULahwLW5nyfA5jGnxxOG/f0HkFpxY=;
	b=NeVCULi84IQhHIcvX3hLItXX4TBOHrFTu+Yqrlr/4dmdYUhBpLKUfhQ+OdKvWGS5qFn7kB
	kHtvMYKpmXyqnxgYJsWGJkX1XFRtSau3voODjP9S808QMKJ90tbAz77VlJSWANs1Ww1vWE
	ouwznB1qpMF7OqEDXlAHIA9g1XyH4UU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-FJ81B5XePkulyrFjw51-Xg-1; Fri, 02 May 2025 11:18:59 -0400
X-MC-Unique: FJ81B5XePkulyrFjw51-Xg-1
X-Mimecast-MFC-AGG-ID: FJ81B5XePkulyrFjw51-Xg_1746199138
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-440667e7f92so12559185e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 08:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199138; x=1746803938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Us6VhmJrM3rYoUULahwLW5nyfA5jGnxxOG/f0HkFpxY=;
        b=uDp35VlZHeMJnDM+EhJZ6UUK2QpvLBfaWwa0qr83LfyXHs/cPocpWp3HW2rXeHOuR6
         XZ2c3Rn2kule56SJZHl8lUJDN1mUxkeSOx+uC4riAyab9DblOKrx1zEQJ+EW6UHpNDpn
         iT9pu5NMHFlNJqoxaCdCvNUDzgYsWxcyT2HSd5eojhsgbbj/Vui2Y5q+v15alWFUgYZB
         AyCImf8HTVTlpICkIncPedwIPSM45odLhF7hzLIbOnmKYG5ndvuDknijfqujPoAXbRD5
         ZpIkXnFBx2TjFXxJ2x4UCIq0oYJZg36PpW4sVTPqytdmVgU8XMljPsLajf8Q9nYQXpKQ
         s4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUZVbdZO30vZxyaWcsoo1NegZh4pFG2JBY7qzxG2OeiiRQK6DhJ/Zf/cn0y6Zys6f+yhsxnIwdvf7c8pEw9pbJXcH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQzCfLKbgFzc3wSL1wQ8ZMGiIVwHoLpb50XwRHR/zVLjOO4RyF
	JoLB35c2JGBFFfPc6Bh+1QU9PJ0pYKtoJDUdmz44sTpX7fvVo1az4CKFrfHcHXWbkDMbG2XSvTh
	3n498Z83fY01jOtxhnnKNwy5OZJgYeMJiYx6ahMYoCriOvFCVHPIDJM7gEIX2hcU0BbnEew==
X-Gm-Gg: ASbGncuAUQu3GMjkhlviI6Bg5yhInbaejF1H29hCtnWsZuqXEC5CEma9qa7PqISlavY
	ibOWcKtMcTWPKSMngJgwaZrrVMxUNwWVRxmaijgcK9seNNwCw9k9f476qyMTa7hZ9+m8ssghVdC
	cON+yXvSZXcqo+f84ynrotiUWqoDgE3sxE9VxgkCaiQKOUD4Ka4Je3IP1RSbSV9YaDWY+lxexiy
	OYTCYMrmX7YTfLopBBnok9L0THZXDRqep86T7fry1oikdCDXtkNaaJo0N4ikugXQGMaBxWj5HsE
	xDJiO+eWK60IVgISqeIkEsuCgNipdoVJbauKfXFbMjbWkE+6sQOq2R8MN6AZLTn99mjfnb45Kr6
	s7iFKcci9NRWLFYku3lHA6LCSBAhZqHHxxYBZJ4U=
X-Received: by 2002:a05:600c:3155:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-441bbea0e1dmr29719635e9.4.1746199137924;
        Fri, 02 May 2025 08:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnS/LGhMWVDo80l+sUfcRD3o1SQptcjxMx9v1ekJms8PTk9f2hteIrO5vQZg96jMx3hY+Jlg==
X-Received: by 2002:a05:600c:3155:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-441bbea0e1dmr29719235e9.4.1746199137505;
        Fri, 02 May 2025 08:18:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28732sm92473995e9.37.2025.05.02.08.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 08:18:57 -0700 (PDT)
Message-ID: <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
Date: Fri, 2 May 2025 17:18:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Jann Horn <jannh@google.com>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
 <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
 <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -bIwXwX2x0vKvUOulV4oj6oYOu4xAPmrk4WtBo_cGNA_1746199138
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 14:50, Jann Horn wrote:
> On Fri, May 2, 2025 at 8:29 AM David Hildenbrand <david@redhat.com> wrote:
>> On 02.05.25 00:29, Nico Pache wrote:
>>> On Wed, Apr 30, 2025 at 2:53 PM Jann Horn <jannh@google.com> wrote:
>>>>
>>>> On Mon, Apr 28, 2025 at 8:12 PM Nico Pache <npache@redhat.com> wrote:
>>>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>>>> While scanning PMD ranges for potential collapse candidates, keep track
>>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
>>>>> mTHPs are enabled we remove the restriction of max_ptes_none during the
>>>>> scan phase so we dont bailout early and miss potential mTHP candidates.
>>>>>
>>>>> After the scan is complete we will perform binary recursion on the
>>>>> bitmap to determine which mTHP size would be most efficient to collapse
>>>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>>>> determine how full a THP must be to be eligible.
>>>>>
>>>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>>>> pages, we dont perform the collapse.
>>>> [...]
>>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>>           vma_start_write(vma);
>>>>>           anon_vma_lock_write(vma->anon_vma);
>>>>>
>>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>>>> -                               address + HPAGE_PMD_SIZE);
>>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
>>>>> +                               _address + (PAGE_SIZE << order));
>>>>>           mmu_notifier_invalidate_range_start(&range);
>>>>>
>>>>>           pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>>>> +
>>>>>           /*
>>>>>            * This removes any huge TLB entry from the CPU so we won't allow
>>>>>            * huge and small TLB entries for the same virtual address to
>>>>
>>>> It's not visible in this diff, but we're about to do a
>>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
>>>> entire page table, meaning it tears down 2MiB of address space; and it
>>>> assumes that the entire page table exclusively corresponds to the
>>>> current VMA.
>>>>
>>>> I think you'll need to ensure that the pmdp_collapse_flush() only
>>>> happens for full-size THP, and that mTHP only tears down individual
>>>> PTEs in the relevant range. (That code might get a bit messy, since
>>>> the existing THP code tears down PTEs in a detached page table, while
>>>> mTHP would have to do it in a still-attached page table.)
>>> Hi Jann!
>>>
>>> I was under the impression that this is needed to prevent GUP-fast
>>> races (and potentially others).
> 
> Why would you need to touch the PMD entry to prevent GUP-fast races for mTHP?
> 
>>> As you state here, conceptually the PMD case is, detach the PMD, do
>>> the collapse, then reinstall the PMD (similarly to how the system
>>> recovers from a failed PMD collapse). I tried to keep the current
>>> locking behavior as it seemed the easiest way to get it right (and not
>>> break anything). So I keep the PMD detaching and reinstalling for the
>>> mTHP case too. As Hugh points out I am releasing the anon lock too
>>> early. I will comment further on his response.
> 
> As I see it, you're not "keeping" the current locking behavior; you're
> making a big implicit locking change by reusing a codepath designed
> for PMD THP for mTHP, where the page table may not be exclusively
> owned by one VMA.

That is not the intention. The intention in this series (at least as we 
discussed) was to not do it across VMAs; that is considered the next 
logical step (which will be especially relevant on arm64 IMHO).

> 
>>> As I familiarize myself with the code more, I do see potential code
>>> improvements/cleanups and locking improvements, but I was going to
>>> leave those to a later series.
>>
>> Right, the simplest approach on top of the current PMD collapse is to do
>> exactly what we do in the PMD case, including the locking: which
>> apparently is no completely the same yet :).
>>
>> Instead of installing a PMD THP, we modify the page table and remap that.
>>
>> Moving from the PMD lock to the PTE lock will not make a big change in
>> practice for most cases: we already must disable essentially all page
>> table walkers (vma lock, mmap lock in write, rmap lock in write).
>>
>> The PMDP clear+flush is primarily to disable the last possible set of
>> page table walkers: (1) HW modifications and (2) GUP-fast.
>>
>> So after the PMDP clear+flush we know that (A) HW can not modify the
>> pages concurrently and (B) GUP-fast cannot succeed anymore.
>>
>> The issue with PTEP clear+flush is that we will have to remember all PTE
>> values, to reset them if anything goes wrong. Using a single PMD value
>> is arguably simpler. And then, the benefit vs. complexity is unclear.
>>
>> Certainly something to look into later, but not a requirement for the
>> first support,
> 
> As I understand, one rule we currently have in MM is that an operation
> that logically operates on one VMA (VMA 1) does not touch the page
> tables of other VMAs (VMA 2) in any way, except that it may walk page
> tables that cover address space that intersects with both VMA 1 and
> VMA 2, and create such page tables if they are missing.

Yes, absolutely. That must not happen. And I think I raised it as a 
problem in reply to one of Dev's series.

If this series does not rely on that it must be fixed.

> 
> This proposed patch changes that, without explicitly discussing this
> locking change.

Yes, that must not happen. We must not zap a PMD to temporarily replace 
it with a pmd_none() entry if any other sane page table walker could 
stumble over it.

This includes another VMA that is not write-locked that could span the PMD.

-- 
Cheers,

David / dhildenb

