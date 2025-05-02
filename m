Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353E23B0
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 May 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200554; cv=none; b=g/xELnnJ0wxBo9+UsO3axTEvWLKUu5XemV4xxe3WU2X4+7KgaOyopeGlgfE2Y/kpMJgMh8sNRoTmtIDwJ3tFZanFMQgUQ6Zo32O6WPNOKloCgA7oyzGsrYJg9s7kp7kOjMEpVEbme93KqGdK9R1j9qCdQWSgg+P4SdtKSZttMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200554; c=relaxed/simple;
	bh=Lgo3oPvJN4TmDwml+hlw26Vb+KFGfqwA06+QuXWnm/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG/nN6/vebhG22197B31ypYUheLtMUYdx/4sYeSRxhgOSPbLiwh4+lAPyGQlmxACLd4LjOQZMhXZz2An5ECAyIGa9Lcv5i0Sub6sYEFvsiWTvd31PjR5BzRh5ADaKhi2lc2NNpCFWC32kZo8FO8ojlgxs6qr+GUEgwddpOMhqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgGT/SJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgGT/SJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746200551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7cqDJLWyNwhnnHN+5VqQ5VJiv3rSNdDAibInwFuRIg=;
	b=CgGT/SJwhCF4gPobCwIIC//xY1LVu+v5ceGXy4hKPQ68XGgUIxCLs9F0if2jYkUJub864d
	ZMMzvh5juN1tEGzzgM9n8LaHcgfniBilgwub3gMjZ5/omcioyQB7qLJFrh4njEyjE7a8Si
	HvkVeIJoM57wX3x9hoPHii1WBa2NLGY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-CFoUtKAYPgWADp_2-CICCA-1; Fri, 02 May 2025 11:42:30 -0400
X-MC-Unique: CFoUtKAYPgWADp_2-CICCA-1
X-Mimecast-MFC-AGG-ID: CFoUtKAYPgWADp_2-CICCA_1746200549
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so659016f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 May 2025 08:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200549; x=1746805349;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T7cqDJLWyNwhnnHN+5VqQ5VJiv3rSNdDAibInwFuRIg=;
        b=QLU0XkPyjraLIdk7zd1WQhB8bmujJ2dF+k2uv6/G8iyHxZ6ScMcv2RdRY6yVE/XkYm
         NUEPIZ75oPYxrny+DfqwlxM8VWrSneCm7sYNa9jJt+4ejsKlOptzkJxum8V7Uc0bSFC4
         sr5x+1SQZ97CQhNSIkHQmJtfZsBrT2+tNLJgflR1qsuMB84+lGS73RVtrc1EFaKizzvu
         nk9zFwpzlAjbqTu5y+63QAWc1lB0Ntv+7FcXbGmTKFuZiejeR6OFnzsOTbnMoRK0jcuD
         NZo6d42PuLUDStG15q6kkrGR1n5TzraTGP7rSaCkWy/40yFCH5biIatji5zTXLE9Fo5x
         mSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG7pcG/OVyvaGzoAbWFqq15eCdR/Je2TT656JQpfE7ktr1hvSK6Ea02wczDACh3Daxzn1e2vJ3kBPNSG6FWFn5u7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMNjEHB4t6Z0wTfJ7QxcNX8tQGKFL12/a7l4YckGKN/LhA7lO
	XwBHP72Ba7MAzoieAgcfLUks7L5Gye/ZN8WGLPcY2ifBUR9tjz1Fu+AK/UuQKL2uAqltBqcACZN
	AwHppzF15WNMQxGjTJ25noG8WrGeoJfPyiDqxMPQ8+I4zdd0utR20cZ834Tl2zq6vccae8A==
X-Gm-Gg: ASbGncuGFrs/nXa78p7QACQ1r70FgxNgF2rPHDqu7qvgWfXixCzyR3KqeXIEKZ+2qDw
	KsbuC112CsqsHV4CBXHNIg/cbmVF8DbvruUkLXSWoUgzrVLPf7pUDCsWc5j4qirHllAf4joOvza
	5tTR/8uCVnAAACVbh2iZmCCDXjajbQIn4iSuErJ6RL28eMh/A6Qw2ztytwiQK7KLZt6OidbNsDB
	i+EipbehvylqWuTx0+i/9EU//kvSITTjvk4tloGngVhi0iebBkgdR9MdcGHH2ZW02BlYpdsHWFI
	ZhgoIqd2LyrjdKor5cV5jkQ5+NecP8+xZwMYTDxIZRCmQqlvUWwzqKyfzwySVBZErRjsmO8GUAf
	kCLbUH6OHJbEgGYX5eqr6DNQFEMLNHSWvQ2nxlzc=
X-Received: by 2002:a05:6000:2c8:b0:3a0:7f90:2e2e with SMTP id ffacd0b85a97d-3a099ad6379mr2543664f8f.24.1746200548767;
        Fri, 02 May 2025 08:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHksxJt4q2NvAKXafUh3Noz69LskLRP5kl9AuC6VrOlPInFhsJt/6w4PnefBiSeeay/3Kr9EQ==
X-Received: by 2002:a05:6000:2c8:b0:3a0:7f90:2e2e with SMTP id ffacd0b85a97d-3a099ad6379mr2543613f8f.24.1746200548288;
        Fri, 02 May 2025 08:42:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c48sm2457341f8f.8.2025.05.02.08.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 08:42:27 -0700 (PDT)
Message-ID: <cc8e253f-5dd1-488d-b5a4-a9e0c0466ed3@redhat.com>
Date: Fri, 2 May 2025 17:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>, Jann Horn <jannh@google.com>
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
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
 <CAG48ez25Wo7BSt4dn3v+xO0mojvjtBpd02kaAu7kn_+AfgSrNQ@mail.gmail.com>
 <CAA1CXcBn3eZpcdzsG5DRNBa+rFBg1dQjssC=SYyXW5_7fDmwXg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcBn3eZpcdzsG5DRNBa+rFBg1dQjssC=SYyXW5_7fDmwXg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C1fCex9FpCKatbcYNaEmVuKBSQug3OxvSp1v3Yn97uQ_1746200549
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 17:30, Nico Pache wrote:
> On Fri, May 2, 2025 at 9:27 AM Jann Horn <jannh@google.com> wrote:
>>
>> On Fri, May 2, 2025 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 02.05.25 14:50, Jann Horn wrote:
>>>> On Fri, May 2, 2025 at 8:29 AM David Hildenbrand <david@redhat.com> wrote:
>>>>> On 02.05.25 00:29, Nico Pache wrote:
>>>>>> On Wed, Apr 30, 2025 at 2:53 PM Jann Horn <jannh@google.com> wrote:
>>>>>>>
>>>>>>> On Mon, Apr 28, 2025 at 8:12 PM Nico Pache <npache@redhat.com> wrote:
>>>>>>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>>>>>>> While scanning PMD ranges for potential collapse candidates, keep track
>>>>>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>>>>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
>>>>>>>> mTHPs are enabled we remove the restriction of max_ptes_none during the
>>>>>>>> scan phase so we dont bailout early and miss potential mTHP candidates.
>>>>>>>>
>>>>>>>> After the scan is complete we will perform binary recursion on the
>>>>>>>> bitmap to determine which mTHP size would be most efficient to collapse
>>>>>>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>>>>>>> determine how full a THP must be to be eligible.
>>>>>>>>
>>>>>>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>>>>>>> pages, we dont perform the collapse.
>>>>>>> [...]
>>>>>>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>>>>>>            vma_start_write(vma);
>>>>>>>>            anon_vma_lock_write(vma->anon_vma);
>>>>>>>>
>>>>>>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>>>>>>> -                               address + HPAGE_PMD_SIZE);
>>>>>>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
>>>>>>>> +                               _address + (PAGE_SIZE << order));
>>>>>>>>            mmu_notifier_invalidate_range_start(&range);
>>>>>>>>
>>>>>>>>            pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>>>>>>> +
>>>>>>>>            /*
>>>>>>>>             * This removes any huge TLB entry from the CPU so we won't allow
>>>>>>>>             * huge and small TLB entries for the same virtual address to
>>>>>>>
>>>>>>> It's not visible in this diff, but we're about to do a
>>>>>>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
>>>>>>> entire page table, meaning it tears down 2MiB of address space; and it
>>>>>>> assumes that the entire page table exclusively corresponds to the
>>>>>>> current VMA.
>>>>>>>
>>>>>>> I think you'll need to ensure that the pmdp_collapse_flush() only
>>>>>>> happens for full-size THP, and that mTHP only tears down individual
>>>>>>> PTEs in the relevant range. (That code might get a bit messy, since
>>>>>>> the existing THP code tears down PTEs in a detached page table, while
>>>>>>> mTHP would have to do it in a still-attached page table.)
>>>>>> Hi Jann!
>>>>>>
>>>>>> I was under the impression that this is needed to prevent GUP-fast
>>>>>> races (and potentially others).
>>>>
>>>> Why would you need to touch the PMD entry to prevent GUP-fast races for mTHP?
>>>>
>>>>>> As you state here, conceptually the PMD case is, detach the PMD, do
>>>>>> the collapse, then reinstall the PMD (similarly to how the system
>>>>>> recovers from a failed PMD collapse). I tried to keep the current
>>>>>> locking behavior as it seemed the easiest way to get it right (and not
>>>>>> break anything). So I keep the PMD detaching and reinstalling for the
>>>>>> mTHP case too. As Hugh points out I am releasing the anon lock too
>>>>>> early. I will comment further on his response.
>>>>
>>>> As I see it, you're not "keeping" the current locking behavior; you're
>>>> making a big implicit locking change by reusing a codepath designed
>>>> for PMD THP for mTHP, where the page table may not be exclusively
>>>> owned by one VMA.
>>>
>>> That is not the intention. The intention in this series (at least as we
>>> discussed) was to not do it across VMAs; that is considered the next
>>> logical step (which will be especially relevant on arm64 IMHO).
>>
>> Ah, so for now this is supposed to only work for PTEs which are in a
>> PMD which is fully covered by the VMA? So if I make a 16KiB VMA and
>> then try to collapse its contents to an order-2 mTHP page, that should
>> just not work?
> Correct! As I started in reply to Hugh, the locking conditions explode
> if we drop that requirement.

Right. Adding to that, one could evaluate how much we would gain by 
trying to lock, say, up to $MAGIC_NUMBER related VMAs.

Of course, if no other VMA spans the PMD, and the VMA only covers it 
partially, it is likely still fine as long as we hold the mmap lock in 
write mode.

But probably, looking into a different locking scheme would be 
beneficial at this point.

-- 
Cheers,

David / dhildenb

