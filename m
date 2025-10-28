Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52154336EE2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660936; cv=none; b=oFy2ixMHgYYDbpH2C7Kzl6pgTCijOKsWNKsAlZA39QwGq7UEwB3G1d5WR3nyzs0MToRSzrs1Y5FdJGTD0FGuqnqfEk1u/0LfJaTsJzotTBOnanp64ro32cFwmMIrhsDbQfzpf4/KUnYGA/JvrsqFIT8bvpFNH1+9vHU60ASc/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660936; c=relaxed/simple;
	bh=dvIaA9/MeX8gkzShoCxal8iTDHKOrs+Nx+s14qALqD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iExKBUcr95hplQJEtzVfTuQox8u084NzOakceHDbir6xoMEl9MfknadpWZVrAJ/NWB5GSQTR6GAYM7DNTGWJM6TqkNc0kqX7v0BED17Nti3fL+2ZUBdPcVNSKNJ7fGK0+emAvr8rV4XKlQYSNySLJF9IAgzOXpxXXCJAvK4E9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2lE5ilc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2lE5ilc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761660933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j/glKqaox2VJfoe06FG5ShrOzZnm/RxmixqK0X1DIb4=;
	b=K2lE5ilcSwGS6O5J22GNUO1IhgmXF2nvTUNZNxQgtSscDyyemKUp9L+H3aNhJUPWZgAfmw
	xRKY9PKICs+Qs7HkK/rDtsAKLq8IS9iQ8wI9qRczroddmnWmlLhFCmLxgJIRU/wD9cuV3M
	UAqM1mks4fjwHWzGdTUEHebreG4pDbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-IRthrNDwPC2sdGP-xiX_yg-1; Tue, 28 Oct 2025 10:15:31 -0400
X-MC-Unique: IRthrNDwPC2sdGP-xiX_yg-1
X-Mimecast-MFC-AGG-ID: IRthrNDwPC2sdGP-xiX_yg_1761660930
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso35460165e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660930; x=1762265730;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/glKqaox2VJfoe06FG5ShrOzZnm/RxmixqK0X1DIb4=;
        b=j3hZynZX5dOmUc8rWCn2E6mVoZT3w/Zh5CtKtjzVmMtOWa73m1ms9j6Khz5RzMbwhY
         IcwdMaIxXefNvXL3KxczW/me/C1fL2+y7HZsy9MXRuKL69dVNZty0hVzEdaf3nmEPR2Q
         tRMN4NQdx+A4YzE1mxWsSBCfuvztfLJktyLOEeFRaBxfaqM3qr2bbrNSkFPXsKUhLogc
         0mTBSPXNljVmnErYwdDjPFZbSeYZ4fxlJTcB39IzX1Tzr0uJhC6k9UDI/az4E/jjEj87
         3eNvi12hLnILs0bHawykofIWB2OtuMtUpthrpVTryCdBpvpu7d+bftxpGj2L20aznU2x
         IeKw==
X-Forwarded-Encrypted: i=1; AJvYcCWwuaCQke6QVWXPY85ENmJxDAggGKYNXVCcQ+w/r0/WY6DdpNEBkFYTec8nrePtG9FPj3gJsGgMxwYPDrpnhCNFds4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGsM29bpjSRSjg1k/s/31a8TRtcE5VbI5PSIBiEX8uMqR2BQ6
	j3hDp/m9MKcFEHV77sIfQXpA8i+fC/bgD/GBKUJTTI8j2Ju0GQyKsA5gT/zN4Hr8yz/bIGWnCbc
	sw61ti/MulJVtIYM2El+GvY4Hr1yizH4+bkPln7wYG7eIW3IayinxC4xDSsNbA04p4Inc5X669w
	==
X-Gm-Gg: ASbGncvA0qCrbQ5MzLFWsVjb83N2ceqWOZYEuj0pKmrSm4+lnKdzJwcwPN7sOEO4eqT
	ZIGUXcYo9WT1Qicl2hUCiSeaGLsCnXAEjOBv/Jiod4BjeVMlCMAMHluXnHpuivMGwfV9SaJUW2j
	2otBWj6k9a2IxmP7k9hEXBCEVuLXItgLw4yp3TYHFFWslHaS0jxTy769BSE7wDfx30g+DE7B5/x
	WbF8rWT0/tzEtuRjxNLxb3X0Ts87dxydKyhQILmRy2gVv0XmqHALWronx+KkZAP/C/6OcA+HoCI
	w+DnEA/TdHx2UG+bQY1DIXNCocUXCy9Ry7B3feyGPVmLIcenS+WY3VpmV55AQEPaek5OcvC4+gi
	vAwQsGQeIj+L/28NYGlwbiKIh6TH3hRmC
X-Received: by 2002:a05:600c:3510:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-47717e7a904mr25568445e9.41.1761660930401;
        Tue, 28 Oct 2025 07:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6iHKdLinZwipLvbxyK8tSUWzITslXdYkBnM4jqasA/6Z+uup38j+j3RmLA0yP5Cd8Tmrz8w==
X-Received: by 2002:a05:600c:3510:b0:46f:b42e:e394 with SMTP id 5b1f17b1804b1-47717e7a904mr25567925e9.41.1761660929806;
        Tue, 28 Oct 2025 07:15:29 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a36easm199704855e9.10.2025.10.28.07.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:15:29 -0700 (PDT)
Message-ID: <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
Date: Tue, 28 Oct 2025 15:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
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
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j0TleZ07x-64-4tyYm2fEimXG_PiqDCWcTnAzsaVCKk_1761660930
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.10.25 14:36, Nico Pache wrote:
> On Mon, Oct 27, 2025 at 11:54 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> On Wed, Oct 22, 2025 at 12:37:08PM -0600, Nico Pache wrote:
>>> The current mechanism for determining mTHP collapse scales the
>>> khugepaged_max_ptes_none value based on the target order. This
>>> introduces an undesirable feedback loop, or "creep", when max_ptes_none
>>> is set to a value greater than HPAGE_PMD_NR / 2.
>>>
>>> With this configuration, a successful collapse to order N will populate
>>> enough pages to satisfy the collapse condition on order N+1 on the next
>>> scan. This leads to unnecessary work and memory churn.
>>>
>>> To fix this issue introduce a helper function that caps the max_ptes_none
>>> to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
>>> the max_ptes_none number by the (PMD_ORDER - target collapse order).
>>>
>>> The limits can be ignored by passing full_scan=true, this is useful for
>>> madvise_collapse (which ignores limits), or in the case of
>>> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
>>> collapse is available.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>   mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 4ccebf5dda97..286c3a7afdee 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
>>>                wake_up_interruptible(&khugepaged_wait);
>>>   }
>>>
>>> +/**
>>> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>>> + * @order: The folio order being collapsed to
>>> + * @full_scan: Whether this is a full scan (ignore limits)
>>> + *
>>> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
>>> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
>>> + *
>>> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
>>> + * khugepaged_max_ptes_none value.
>>> + *
>>> + * For mTHP collapses, scale down the max_ptes_none proportionally to the folio
>>> + * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedback loop.
>>> + *
>>> + * Return: Maximum number of empty PTEs allowed for the collapse operation
>>> + */
>>> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
>>> +{
>>> +     unsigned int max_ptes_none;
>>> +
>>> +     /* ignore max_ptes_none limits */
>>> +     if (full_scan)
>>> +             return HPAGE_PMD_NR - 1;
>>> +
>>> +     if (order == HPAGE_PMD_ORDER)
>>> +             return khugepaged_max_ptes_none;
>>> +
>>> +     max_ptes_none = min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - 1);
>>
> 
> Hey Lorenzo,
> 
>> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
>> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> 
> I spoke to David and he said to continue forward with this series; the
> "eagerness" tunable will take some time, and may require further
> considerations/discussion.

Right, after talking to Johannes it got clearer that what we envisioned 
with "eagerness" would not be like swappiness, and we will really have 
to be careful here. I don't know yet when I will have time to look into 
that.

If we want to avoid the implicit capping, I think there are the 
following possible approaches

(1) Tolerate creep for now, maybe warning if the user configures it.
(2) Avoid creep by counting zero-filled pages towards none_or_zero.
(3) Have separate toggles for each THP size. Doesn't quite solve the
     problem, only shifts it.

Anything else?

IIUC, creep is less of a problem when we have the underused shrinker 
enabled: whatever we over-allocated can (unless longterm-pinned etc) get 
reclaimed again.

So maybe having underused-shrinker support for mTHP as well would be a 
solution to tackle (1) later?

-- 
Cheers

David / dhildenb

