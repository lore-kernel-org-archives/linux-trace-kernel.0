Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B45264F9C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012214; cv=none; b=ulPdLIjPPtMeG6cdZM2PQ7JZMyzo4uLKF+vsDGWF2IMSUWhYlqPafvxl6BJZ0/UbOpxW+0Y4ZOjLdo37G2eUPTdYly2iI+z7MCOjLoA7DqZ4KF4L6Rq2aJY/vakXN0hrn1ezq7smxK6a79b0V62I0mMbGbhJrdj7+sp81EHIKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012214; c=relaxed/simple;
	bh=xarvoNYWqZncjjHZQkHn4mAe8i3NYFJpOF5stI5Hcbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjXRoBWSEJrrOzsAMCYhMuoCQ7PWf5anBXeSN8RQXySXc7C8UMzYXXc4SWLBcGZ+de6z4OKb61vMWE84an0wQnjxlyWyKWZJddquxNFSj0jOStbCAF9CPwrJRAyGQDawKI5wmctCjuthsD9xBcK7zfgB8pZbXob1kIng3Tcg7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCFCNbGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCFCNbGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757012211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//wY+wiCi15t97+fQ+FMBl1p8QkU5s+6Pz+y0f6tnSE=;
	b=dCFCNbGDw8IQR/b2l7hUmhKu0+reHaJ2mCdzCITCB44DBQ9qjvFDvS2iEBDSq25APZ8s4g
	HNsIDXZy9ouda/iyf9i13QNS8w4tuw4zC13o5+gvuzmG1iWxTEqCEiNX0gDqNxfAbL15j0
	gjja3iUtiXxEvGNzl3hWl9LX99tsAXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-AfNiLOUUMryExzAP6y42hA-1; Thu, 04 Sep 2025 14:56:50 -0400
X-MC-Unique: AfNiLOUUMryExzAP6y42hA-1
X-Mimecast-MFC-AGG-ID: AfNiLOUUMryExzAP6y42hA_1757012209
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9c1b74d0so7366345e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012209; x=1757617009;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//wY+wiCi15t97+fQ+FMBl1p8QkU5s+6Pz+y0f6tnSE=;
        b=KTww00lI17qmQbQqIAR7ZZi3Qqwi4yuCc+VFHjFp4t/OrHEkYkcNrcOHaHhZM+eMhV
         TBwcv81D+ymEQF34AHO2wnCUn6hAScV86B0OXrVEytwfJhjfr2n4X06srtW/AaV+r5ok
         PrYRX6/pSJ35aXkGkeV7J83ZWk3WFv4ebGbIC9ygFXrCBtjLTeq7grt0Ua4n1S/OLtGp
         VDR3NnIXsHknA8FWN4ht3Mfleu74E3MbBoS76E9YLjgFCCzEaIXEprfGzjOfsPOi+mKT
         VJrfRHRUMiojXKExEEsOZXRGlWYK7cdhHHqEwNqQp8gWc+N8ljHqs3Y4VAsF1/IaQ1BZ
         txRw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZqhjFmSkX4hDYhNf3F6MvrXTuuziyWmtKalRLt4waStRrNOVY252O5C0xfpRxdEdgwhK5zRRV62JzRHimh9ZZiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRH1onzvAOxmEDWp4vYOn7FvNJStZPDH+eSiIMigXGhM27OHhQ
	F0eyaHp4JKVMuhE0O/6h+BKrgs0iNEawYgIs3vsR/R4Hoj2kwpUEwD/jv+nOEmIsbaYfBZMyzL5
	pazLZAMcWX9y5mgX/lT/WKQS6DOSczFF9Z96ESR8qu07BGGU2AMfcCpai9dKGm6nWgzbUMyJ6ow
	==
X-Gm-Gg: ASbGncte8kPwUozYURCWuD9a+h75/nUbD76+E9XhoFvv1XUPPsexLTuy0NvTmmE5ODD
	8BtU3O6eWJVSgg7j5r493rvSE2FxiGKBkYB3wZipXjQyRAiMMpHeJCgD5zcCTCOOBXHAAqBl6+n
	jgWDmnnuH3BujXIbOfMTh6iqlopeqygWTC3bmHo1pUopj/Vx9yZqmZPb4GU+6numJsMOu+0p0UW
	/e3Bephh3RltWTEVrDUKTWx3o9KXvpCZDi431TEWCqEeC8QKkx30cDYOssOxIiaL69CIXs6Y5WG
	AV/m++uDYLtL6+DELOfX+X37bbamwAPT/SymOIM4yvCEqzBmHEPw9o1bfP9ZLJwsjvpcuycGEDu
	ATFwhmQnRAzBRIBkAR35ObnNFe1vqTbxXgQRkBJMTXhlu8olO3pLKoZHf7I8UBGIC
X-Received: by 2002:a05:600c:1d0c:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45b85528632mr169110755e9.4.1757012208913;
        Thu, 04 Sep 2025 11:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeNuNqOEHJCDLrWhEXGuSOxXZHwBD+OGhZztGaw1PGcxtN9h6/v7McFNFlb90ZhXi09IhDLQ==
X-Received: by 2002:a05:600c:1d0c:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-45b85528632mr169110445e9.4.1757012208416;
        Thu, 04 Sep 2025 11:56:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0d32a2sm415142505e9.9.2025.09.04.11.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:56:47 -0700 (PDT)
Message-ID: <26e6828e-78f7-4454-abaa-334257a8f8c2@redhat.com>
Date: Thu, 4 Sep 2025 20:56:45 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com>
 <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
 <CAA1CXcBVR=L5_6x5FGeR693AB_YqEF=4KAX7_2fRgGNa1j1j9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAA1CXcBVR=L5_6x5FGeR693AB_YqEF=4KAX7_2fRgGNa1j1j9A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ChhvhthlIcwikqRTQqfdANTK9qTLiyVwJflDY6bilxU_1757012209
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.25 04:44, Nico Pache wrote:
> On Thu, Aug 21, 2025 at 10:55 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> On Thu, Aug 21, 2025 at 10:46:18AM -0600, Nico Pache wrote:
>>>>>>> Thanks and I"ll have a look, but this series is unmergeable with a broken
>>>>>>> default in
>>>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
>>>>>>> sorry.
>>>>>>>
>>>>>>> We need to have a new tunable as far as I can tell. I also find the use of
>>>>>>> this PMD-specific value as an arbitrary way of expressing a ratio pretty
>>>>>>> gross.
>>>>>> The first thing that comes to mind is that we can pin max_ptes_none to
>>>>>> 255 if it exceeds 255. It's worth noting that the issue occurs only
>>>>>> for adjacently enabled mTHP sizes.
>>>>
>>>> No! Presumably the default of 511 (for PMDs with 512 entries) is set for a
>>>> reason, arbitrarily changing this to suit a specific case seems crazy no?
>>> We wouldn't be changing it for PMD collapse, just for the new
>>> behavior. At 511, no mTHP collapses would ever occur anyways, unless
>>> you have 2MB disabled and other mTHP sizes enabled. Technically at 511
>>> only the highest enabled order always gets collapsed.
>>>
>>> Ive also argued in the past that 511 is a terrible default for
>>> anything other than thp.enabled=always, but that's a whole other can
>>> of worms we dont need to discuss now.
>>>
>>> with this cap of 255, the PMD scan/collapse would work as intended,
>>> then in mTHP collapses we would never introduce this undesired
>>> behavior. We've discussed before that this would be a hard problem to
>>> solve without introducing some expensive way of tracking what has
>>> already been through a collapse, and that doesnt even consider what
>>> happens if things change or are unmapped, and rescanning that section
>>> would be helpful. So having a strictly enforced limit of 255 actually
>>> seems like a good idea to me, as it completely avoids the undesired
>>> behavior and does not require the admins to be aware of such an issue.
>>>
>>> Another thought similar to what (IIRC) Dev has mentioned before, if we
>>> have max_ptes_none > 255 then we only consider collapses to the
>>> largest enabled order, that way no creep to the largest enabled order
>>> would occur in the first place, and we would get there straight away.
>>>
>>> To me one of these two solutions seem sane in the context of what we
>>> are dealing with.
>>>>
>>>>>>
>>>>>> ie)
>>>>>> if order!=HPAGE_PMD_ORDER && khugepaged_max_ptes_none > 255
>>>>>>        temp_max_ptes_none = 255;
>>>>> Oh and my second point, introducing a new tunable to control mTHP
>>>>> collapse may become exceedingly complex from a tuning and code
>>>>> management standpoint.
>>>>
>>>> Umm right now you hve a ratio expressed in PTES per mTHP * ((PTEs per PMD) /
>>>> PMD) 'except please don't set to the usual default when using mTHP' and it's
>>>> currently default-broken.
>>>>
>>>> I'm really not sure how that is simpler than a seprate tunable that can be
>>>> expressed as a ratio (e.g. percentage) that actually makes some kind of sense?
>>> I agree that the current tunable wasn't designed for this, but we
>>> tried to come up with something that leverages the tunable we have to
>>> avoid new tunables and added complexity.
>>>>
>>>> And we can make anything workable from a code management point of view by
>>>> refactoring/developing appropriately.
>>> What happens if max_ptes_none = 0 and the ratio is 50% - 1 pte
>>> (ideally the max number)? seems like we would be saying we want no new
>>> none pages, but also to allow new none pages. To me that seems equally
>>> broken and more confusing than just taking a scale of the current
>>> number (now with a cap).
>>>
>>>
>>
>> The one thing we absolutely cannot have is a default that causes this
>> 'creeping' behaviour. This feels like shipping something that is broken and
>> alluding to it in the documentation.
> Ok I've put a lot of thought and time into this and came up with a solution.
> 
> Here is what I currently have tested and would like to proposing:
> 
> - Expand bitmap to HPAGE_PMD_NR (512)*, this increases the accuracy of
> the max_pte_none handling, and removes a lot of inaccuracies caused by
> the compression into 128 bits that was being done. This also makes the
> code a lot easier to understand.

That sounds good to me. Should make the code easier as well.

> 
> - When attempting mTHP level collapses cap max_ptes_none to 255 to
> prevent the creep issue

I guess the documentation would then state something like

* When collapsing smaller THPs, "max_ptes_none" is scaled proportional
   to the THP size.
* When collapsing smaller THPs, "max_ptes_none" may be internally
   capped at 255 if it exceeds 255 but is not set to the default (511).

Not 100% a fan of all of that, but maybe the only option when wanting to 
avoid other toggles.

The only alternative would really be respecting only 0/511 for mTHP, and 
not doing any scaling. That would obviously make the documentation 
easier and would allow us to revisit that later. The documentation would be:

* When collapsing smaller THPs, "max_ptes_none" may be interpreted as
   "0"  when set to a value different to the default (511). This behavior
   might change in the future.

> 
> Ive tested this and found this performs better than my previous
> version, allows for more granular control via max_ptes_none, and
> prevents the creep issue without any admin knowledge needed.

How would this interact with the shrinker once extended to mTHP? Would 
your RFC patch be sufficient for that or would we actually also want to 
cap? I haven't; fully thought this through yet. I'd assume we would not 
want to cap here. Which makes the doc weird as well, lol.

-- 
Cheers

David / dhildenb

