Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339022571BD
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200360; cv=none; b=NyaFuFqeYiiW2zFPCgxzTQOpWy8yLDflnQpkUVSuvO6/xwae3vBIPZ3EJi1pY19C9cXgFCGhx8eJQrTnY03GPlo8Wcb6B75F2/+McPU5tDugiycHrAxsC0Ix8kKaStQsskAPBDmnVCFyTu0on2C5WhVkKCr7uLXFHc+NQoq1YRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200360; c=relaxed/simple;
	bh=1CyzDpNaJbuGQLy0jghO5nrbxwhMPx/PNGf2tgNlLDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZp+8mm4ZB8nYRGc9an+j53JsKPSeqxL+Lz1Cm5V3EIfQEkZi2Ra75E8Bgb+/HjazLGqF8QLuIMcxuok3SQiW2laKHvoFeWbicSpMTZ3+rnaEPuIns81S6SSUcbGUoWEMh+nA3aT/Z2a6s7DX6WyljfdXbk0NqHKfC5MgFzyAr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjA7UNud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjA7UNud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746200357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RSbcHiqENjgdwQ8aS6PFFw/+bfZ9pm2Lqqqi4VVjILQ=;
	b=RjA7UNudTy4n/4VdAgIbbPczeTj5yR6rHYyPX7fVQELEHM9BdyGP6OhmjSF6XLxK0P2Sa1
	yUdAjm4Wy/fTj9kuBsLPOL8k0XJCO4e8U8LActuXB8aeYQMgO9qvIHR1gRx1km9fyf6leV
	FhpL8U1F+AlXxqVHfgD6Xjokc9nFi6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YuEaoiHkPM6oVayRDrahOA-1; Fri, 02 May 2025 11:39:14 -0400
X-MC-Unique: YuEaoiHkPM6oVayRDrahOA-1
X-Mimecast-MFC-AGG-ID: YuEaoiHkPM6oVayRDrahOA_1746200353
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b19so12489525e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 08:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200353; x=1746805153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSbcHiqENjgdwQ8aS6PFFw/+bfZ9pm2Lqqqi4VVjILQ=;
        b=Rke4X9ejiLwfC75RypyLDlOl0GpHzaiF2W/XnTnP/liHdsKMdMCN+3c+keZtXPW4Qi
         YbmfgzlhbiMvWbQOKy+lrtYaG9qHd5dksVsdvLnhkI9cteFkXhJEGmgQ813QYHYyBat5
         vpmoioa83EkDijj4mrcMsWfnTNfy5L9gwA4EGEVwGjtUAtQujAkCgu1yh1gvR/vFx1tj
         3LaIacmMkHq7yXiHH866opLVEvuyQHNLXGvFikchJp/HtBXU2mODqxpZU7nYOK+P5NKa
         NE2AGkagFo4+O1NxlINHox0Ji8M9LGSYtva3vpGnrukU5zWdjeKnfIRx/wFD14NIra+9
         EFjw==
X-Forwarded-Encrypted: i=1; AJvYcCXrNZmUzUh1c1BAwtKxHHxDxLue9OLvbmh5jpypce5en7CtBLJ81PZr8o3qC82BHnyjd4UWp+9s4MCD5m607Q9T5I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrc15DaAJQ35kW/HtYO6DpymiD9HQo+Y0D8bklWAZNNKxLvh72
	RJ5u1jIjp97mSHTpJF/eBXe1dAlUowfHSB2I+xNzsjHfrjqq6UxgFDuPLRwg9dHNBxLnDYDbZ6X
	pITPwELrGO0uTyDKUxWOjOO0X3NIRfAeKWwX9qII6V6F4NsqIOCipqkjkL6lkNRrK6YG7TA==
X-Gm-Gg: ASbGncsDKsWNimlGe52MQclqOtEkWchRos01qlrk4FujD/3bxPvCplKyzBCRYBVHvGT
	hlGfmVJ8TkwPU4vTVI1nEA3teXaI4d1hnURWX52fWhA3SnHG8V75PbCVWO6MgCBKNpwQGBcGbgM
	Yf+qpvG1x3JPUQ6TxSQIWeUboubHqrL9Co5GWP/U2WmLlBt16oQvq1qaMg+s4Mjob/X6lsK08nc
	HE7LdQNTGeqPfm+5tUnScN/S8HkY7vs4L36ZvuknnGo/Zo80AWGnlBL/n0Pn5oSrIrYl819Q7cr
	1g1cPnPiZ7kByRwfzCKoaeiTcy5P6wDaJGACFXtnPxgs9kG/8nsuNKFxNznF4zkYluKwnbtal5e
	Bor0hxRPMpbenHUMitTpKsrlk8TKhuBittlGxOqg=
X-Received: by 2002:a05:6000:2507:b0:39a:cb5b:78fe with SMTP id ffacd0b85a97d-3a099addcfemr2359141f8f.34.1746200352761;
        Fri, 02 May 2025 08:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnhW0Pnrk5h6Vk74Y3f0qi3YSQtYQ/2x2XGBwUbyQAt5gxgGilCqo0Szci655DbDOYPQhlYA==
X-Received: by 2002:a05:6000:2507:b0:39a:cb5b:78fe with SMTP id ffacd0b85a97d-3a099addcfemr2359092f8f.34.1746200352184;
        Fri, 02 May 2025 08:39:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a5fsm96540615e9.20.2025.05.02.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 08:39:11 -0700 (PDT)
Message-ID: <c3c4395c-62eb-4862-9258-13ffc50bc060@redhat.com>
Date: Fri, 2 May 2025 17:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
 <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
 <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
 <35fc73ea-39f7-4d60-9d78-d700b8ef6ff6@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <35fc73ea-39f7-4d60-9d78-d700b8ef6ff6@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3VlXIYboCgFcNlPRfed__eg3spSW1mUD951C-eEbFEw_1746200353
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 17:24, Lorenzo Stoakes wrote:
> On Fri, May 02, 2025 at 05:18:54PM +0200, David Hildenbrand wrote:
>> On 02.05.25 14:50, Jann Horn wrote:
>>> On Fri, May 2, 2025 at 8:29 AM David Hildenbrand <david@redhat.com> wrote:
>>>> On 02.05.25 00:29, Nico Pache wrote:
>>>>> On Wed, Apr 30, 2025 at 2:53 PM Jann Horn <jannh@google.com> wrote:
>>>>>>
>>>>>> On Mon, Apr 28, 2025 at 8:12 PM Nico Pache <npache@redhat.com> wrote:
>>>>>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>>>>>> While scanning PMD ranges for potential collapse candidates, keep track
>>>>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>>>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
>>>>>>> mTHPs are enabled we remove the restriction of max_ptes_none during the
>>>>>>> scan phase so we dont bailout early and miss potential mTHP candidates.
>>>>>>>
>>>>>>> After the scan is complete we will perform binary recursion on the
>>>>>>> bitmap to determine which mTHP size would be most efficient to collapse
>>>>>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>>>>>> determine how full a THP must be to be eligible.
>>>>>>>
>>>>>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>>>>>> pages, we dont perform the collapse.
>>>>>> [...]
>>>>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>>>>            vma_start_write(vma);
>>>>>>>            anon_vma_lock_write(vma->anon_vma);
>>>>>>>
>>>>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>>>>>> -                               address + HPAGE_PMD_SIZE);
>>>>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
>>>>>>> +                               _address + (PAGE_SIZE << order));
>>>>>>>            mmu_notifier_invalidate_range_start(&range);
>>>>>>>
>>>>>>>            pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>>>>>> +
>>>>>>>            /*
>>>>>>>             * This removes any huge TLB entry from the CPU so we won't allow
>>>>>>>             * huge and small TLB entries for the same virtual address to
>>>>>>
>>>>>> It's not visible in this diff, but we're about to do a
>>>>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
>>>>>> entire page table, meaning it tears down 2MiB of address space; and it
>>>>>> assumes that the entire page table exclusively corresponds to the
>>>>>> current VMA.
>>>>>>
>>>>>> I think you'll need to ensure that the pmdp_collapse_flush() only
>>>>>> happens for full-size THP, and that mTHP only tears down individual
>>>>>> PTEs in the relevant range. (That code might get a bit messy, since
>>>>>> the existing THP code tears down PTEs in a detached page table, while
>>>>>> mTHP would have to do it in a still-attached page table.)
>>>>> Hi Jann!
>>>>>
>>>>> I was under the impression that this is needed to prevent GUP-fast
>>>>> races (and potentially others).
>>>
>>> Why would you need to touch the PMD entry to prevent GUP-fast races for mTHP?
>>>
>>>>> As you state here, conceptually the PMD case is, detach the PMD, do
>>>>> the collapse, then reinstall the PMD (similarly to how the system
>>>>> recovers from a failed PMD collapse). I tried to keep the current
>>>>> locking behavior as it seemed the easiest way to get it right (and not
>>>>> break anything). So I keep the PMD detaching and reinstalling for the
>>>>> mTHP case too. As Hugh points out I am releasing the anon lock too
>>>>> early. I will comment further on his response.
>>>
>>> As I see it, you're not "keeping" the current locking behavior; you're
>>> making a big implicit locking change by reusing a codepath designed
>>> for PMD THP for mTHP, where the page table may not be exclusively
>>> owned by one VMA.
>>
>> That is not the intention. The intention in this series (at least as we
>> discussed) was to not do it across VMAs; that is considered the next logical
>> step (which will be especially relevant on arm64 IMHO).
>>
>>>
>>>>> As I familiarize myself with the code more, I do see potential code
>>>>> improvements/cleanups and locking improvements, but I was going to
>>>>> leave those to a later series.
>>>>
>>>> Right, the simplest approach on top of the current PMD collapse is to do
>>>> exactly what we do in the PMD case, including the locking: which
>>>> apparently is no completely the same yet :).
>>>>
>>>> Instead of installing a PMD THP, we modify the page table and remap that.
>>>>
>>>> Moving from the PMD lock to the PTE lock will not make a big change in
>>>> practice for most cases: we already must disable essentially all page
>>>> table walkers (vma lock, mmap lock in write, rmap lock in write).
>>>>
>>>> The PMDP clear+flush is primarily to disable the last possible set of
>>>> page table walkers: (1) HW modifications and (2) GUP-fast.
>>>>
>>>> So after the PMDP clear+flush we know that (A) HW can not modify the
>>>> pages concurrently and (B) GUP-fast cannot succeed anymore.
>>>>
>>>> The issue with PTEP clear+flush is that we will have to remember all PTE
>>>> values, to reset them if anything goes wrong. Using a single PMD value
>>>> is arguably simpler. And then, the benefit vs. complexity is unclear.
>>>>
>>>> Certainly something to look into later, but not a requirement for the
>>>> first support,
>>>
>>> As I understand, one rule we currently have in MM is that an operation
>>> that logically operates on one VMA (VMA 1) does not touch the page
>>> tables of other VMAs (VMA 2) in any way, except that it may walk page
>>> tables that cover address space that intersects with both VMA 1 and
>>> VMA 2, and create such page tables if they are missing.
>>
>> Yes, absolutely. That must not happen. And I think I raised it as a problem
>> in reply to one of Dev's series.
>>
>> If this series does not rely on that it must be fixed.
>>
>>>
>>> This proposed patch changes that, without explicitly discussing this
>>> locking change.
>>
>> Yes, that must not happen. We must not zap a PMD to temporarily replace it
>> with a pmd_none() entry if any other sane page table walker could stumble
>> over it.
>>
>> This includes another VMA that is not write-locked that could span the PMD.
> 
> I feel like we should document these restrictions somewhere :)
> 
> Perhaps in a new page table walker doc, or on the
> https://origin.kernel.org/doc/html/latest/mm/process_addrs.html page.
> 
> Which sounds like I'm volunteering myself to do so doesn't it...
> 
> [adds to todo...]

:) that would be nice.

Yeah, I mean this is very subtle, but essentially: unless you exclude 
all page table walkers (well, okay, HW and GUP-fast are a bit special), 
temporarily replacing a present PTE by pte_none() will cause trouble. 
Same for PMDs.

That's also one of the problems of looking into only using the PTE table 
lock and not any other heavy-weight locking in khugepaged. As soon as we 
temporarily unlock the PTE table, but have to temporarily unmap the PTEs 
(->pte_none()) as well, we need something else (e.g., migration entry) 
to tell other page table walkers to back off and wait for us to re-take 
the PTL lock and finish. Zapping must still be able to continue, at 
which point it gets hairy ...

... which is why I'm hoping that we can play with that once we have the 
basics running. With the intend of reusing the existing locking scheme 
-> single VMA spans the PMD.

-- 
Cheers,

David / dhildenb

