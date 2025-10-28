Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA534D4F9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674929; cv=none; b=lwV2YKAXyiLkLBg/H2U/Xlhb+hqK4fGq0RFIgM8YDdmsTSOC8+kh8GfmNo3vWkC9ZVgkWCpXRdXcslAbMSQZ7UqMeruQ1uuKCtlODZTmn2jZPIuYcRhLpSxroT/Gw3hSYlr29zjm8L/1de1EtW3sr0WYwDhkqYFzNj9QlCn2TKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674929; c=relaxed/simple;
	bh=c8tz9cCxGAyo8JgGkAk+HB6Ye3I3mFn5bvPmNrt8Hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyFYvQCnK8oNQ2cd1WSF0OoWLXAXfxfzTdThV8kTxba9xvmy4KIyy9XcLCgTfR6GWkaDfVdDRuk4LLRk/evEX8Cw+wCXLCS3elW4OUHfDTn55oBbekyRVSkGOzHkCGoIDQALGPOf/qDKYm0b2fQmUA/gKxNvNbRnNyQankNcbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPItGr89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPItGr89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761674925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pBqhGMpkBgXLCeSNj2J5u4xC14JwlF+KRKG8Dy0pN44=;
	b=SPItGr89eD31R0MOurXf2A7RWc/iydNbqAHYYfHSu/ADvErckyokRucz+r/hlq+2cKWCZ8
	WxTFwLWvpaKU/p0KNrJMAgRkjwX/cxJGkmMBVO+oh6eECazzvX0i8/Xm7GQb6t5bYORLL1
	BDoP0otxOsU53rQE2ycaTogmr0WbgsI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-jiQdX-FRMTm0ieBiOIIM7g-1; Tue, 28 Oct 2025 14:08:44 -0400
X-MC-Unique: jiQdX-FRMTm0ieBiOIIM7g-1
X-Mimecast-MFC-AGG-ID: jiQdX-FRMTm0ieBiOIIM7g_1761674923
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso879035e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674923; x=1762279723;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBqhGMpkBgXLCeSNj2J5u4xC14JwlF+KRKG8Dy0pN44=;
        b=EDUXJxZuQYkxjWllcRhQfKypLI5FuoRs8n4LltnE3d48sfKLDLUA3iYyJ5ajsHMn8P
         qtfFhVYPOVtuU85hj6Ge/8UtKJ6v3f/bvREn5cHI+1Oenl0H4WK86LOvsAbokdj+NvHC
         GeLhtYHQYQhbUc2CkkhRyD8yjX4F6sHJ2Gwx4zzCmFMbBrEi0Kv+1YxAjdQva04gFe5S
         isHnIcZNKyvyHRDeXHZ+UQpmlC9dy85zZg4w2YqR7JgDMB5yI5YuaWjI6D2Ht4cfaRMj
         gC8l0Olyi6un9c7SJMsabCZZrS2zGZHKq2kXSV3ffJfBZQTBGSYGPJkfoqSbkwuD0r4p
         PJng==
X-Forwarded-Encrypted: i=1; AJvYcCU28MjV1HkJZpzbr4aweQWUKh2Z52jN7QDeqhynY05idpUFEvU11K+2AOlbUescdJdcEGa9/8QOkMRFkaOWAkjJLOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCeFBQMPOC8L/EH3CiRI52x2xSxknyH0C9B1WSMOVlrA7xCIQ
	YsXrPcpkjqEkJAJaeGSAkpL3L/yr3BDCpORh21eH0U76L0BShXSx9gQ52vjhQNYkVaSMpU+aYUs
	WmlpPfne83KqX2PzHEdLt8DSPNqfXOhry1Zfv39bhsZgRgOPHMb68mwTLmo3y6GcdSkpbJ9p+Eg
	==
X-Gm-Gg: ASbGnct+d7Si0wregNbQnhUSqeQk5Iw6psZ/f8ExyQ9zSz23LBgEbJ40fPgccuvCoo/
	ja92TbpubdwG4awAMPBjDgxEQxTUZvODEH3CckXfxRKaBIgwkm99MRVQpMLcU3ltePQBxnfgNWE
	JEvHTIaNt8sX6Cax1n1WegSUPWPub5/nzT8Q+kQjVNH0fvEjQIZSrOPdl8nIXXUiUb9Ord5D55+
	suQBc7TSY/SG6j+ATOL6SLllgGU69iuItSE8ONBwHN9Qax15pEzLTu/qPQlM8C0j8vcOHXba1WM
	edSBbJyt/Sf510xMqb0syTtVfROcZXhsWM5RXCZ0QZoljwPXS0M3prz7VTA1n45vdtIfV4cxhRP
	9C9h3vWyxoBC9TU6NKCHyzd6tI9JAEu2F6lhtl4c=
X-Received: by 2002:a05:600d:834a:b0:475:f16f:6e10 with SMTP id 5b1f17b1804b1-4771e851587mr397075e9.18.1761674923063;
        Tue, 28 Oct 2025 11:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCrpjgKDo5yTymBdfrcUO58K/LAOUrhDUrhh/kPmj0YlBGWfe50Y1oWbofPkyyJUC+7QTyQQ==
X-Received: by 2002:a05:600d:834a:b0:475:f16f:6e10 with SMTP id 5b1f17b1804b1-4771e851587mr396505e9.18.1761674922574;
        Tue, 28 Oct 2025 11:08:42 -0700 (PDT)
Received: from [192.168.200.155] (host-80-81-2-50.customer.m-online.net. [80.81.2.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a8209sm3460265e9.11.2025.10.28.11.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 11:08:42 -0700 (PDT)
Message-ID: <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com>
Date: Tue, 28 Oct 2025 19:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
 <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qV5Aeq2CMUOgk6Hrv0SVRldtgEHKbKbeT4ZEF1Dvv3M_1761674923
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> Hey Lorenzo,
>>>
>>>> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
>>>> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
>>>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
>>>
>>> I spoke to David and he said to continue forward with this series; the
>>> "eagerness" tunable will take some time, and may require further
>>> considerations/discussion.
>>
>> Right, after talking to Johannes it got clearer that what we envisioned with
> 
> I'm not sure that you meant to say go ahead with the series as-is with this
> silent capping?

No, "go ahead" as in "let's find some way forward that works for all and 
is not too crazy".

[...]

>> "eagerness" would not be like swappiness, and we will really have to be
>> careful here. I don't know yet when I will have time to look into that.
> 
> I guess I missed this part of the converastion, what do you mean?

Johannes raised issues with that on the list and afterwards we had an 
offline discussion about some of the details and why something 
unpredictable is not good.

> 
> The whole concept is that we have a paramaeter whose value is _abstracted_ and
> which we control what it means.
> 
> I'm not sure exactly why that would now be problematic? The fundamental concept
> seems sound no? Last I remember of the conversation this was the case.

The basic idea was to do something abstracted as swappiness. Turns out 
"swappiness" is really something predictable, not something we can 
randomly change how it behaves under the hood.

So we'd have to find something similar for "eagerness", and that's where 
it stops being easy.

> 
>>
>> If we want to avoid the implicit capping, I think there are the following
>> possible approaches
>>
>> (1) Tolerate creep for now, maybe warning if the user configures it.
> 
> I mean this seems a viable option if there is pressure to land this series
> before we have a viable uAPI for configuring this.
> 
> A part of me thinks we shouldn't rush series in for that reason though and
> should require that we have a proper control here.
> 
> But I guess this approach is the least-worst as it leaves us with the most
> options moving forwards.

Yes. There is also the alternative of respecting only 0 / 511 for mTHP 
collapse for now as discussed in the other thread.

> 
>> (2) Avoid creep by counting zero-filled pages towards none_or_zero.
> 
> Would this really make all that much difference?

It solves the creep problem I think, but it's a bit nasty IMHO.

> 
>> (3) Have separate toggles for each THP size. Doesn't quite solve the
>>      problem, only shifts it.
> 
> Yeah I did wonder about this as an alternative solution. But of course it then
> makes it vague what the parent values means in respect of the individual levels,
> unless we have an 'inherit' mode there too (possible).
> 
> It's going to be confusing though as max_ptes_none sits at the root khugepaged/
> level and I don't think any other parameter from khugepaged/ is exposed at
> individual page size levels.
> 
> And of course doing this means we
> 
>>
>> Anything else?
> 
> Err... I mean I'm not sure if you missed it but I suggested an approach in the
> sub-thread - exposing mthp_max_ptes_none as a _READ-ONLY_ field at:
> 
> /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
> 
> Then we allow the capping, but simply document that we specify what the capped
> value will be here for mTHP.

I did not have time to read the details on that so far.

It would be one solution forward. I dislike it because I think the whole 
capping is an intermediate thing that can be (and likely must be, when 
considering mTHP underused shrinking I think) solved in the future 
differently. That's why I would prefer adding this only if there is no 
other, simpler, way forward.

> 
> That struck me as the simplest way of getting this series landed without
> necessarily violating any future eagerness which:
> 
> a. Must still support khugepaged/max_ptes_none - we aren't getting away from
>     this, it's uAPI.
> 
> b. Surely must want to do different things for mTHP in eagerness, so if we're
>     exposing some PTE value in max_ptes_none doing so in
>     khugepaged/mthp_max_ptes_none wouldn't be problematic (note again - it's
>     readonly so unlike max_ptes_none we don't have to worry about the other
>     direction).
> 
> HOWEVER, eagerness might want want to change this behaviour per-mTHP size, in
> which case perhaps mthp_max_ptes_none would be problematic in that it is some
> kind of average.
> 
> Then again we could always revert to putting this parameter as in (3) in that
> case, ugly but kinda viable.
> 
>>
>> IIUC, creep is less of a problem when we have the underused shrinker
>> enabled: whatever we over-allocated can (unless longterm-pinned etc) get
>> reclaimed again.
>>
>> So maybe having underused-shrinker support for mTHP as well would be a
>> solution to tackle (1) later?
> 
> How viable is this in the short term?

I once started looking into it, but it will require quite some work, 
because the lists will essentially include each and every (m)THP in the 
system ... so i think we will need some redesign.

> 
> Another possible solution:
> 
> If mthp_max_ptes_none is not workable, we could have a toggle at, e.g.:
> 
> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_cap_collapse_none
> 
> As a simple boolean. If switched on then we document that it caps mTHP as
> per Nico's suggestion.
> 
> That way we avoid the 'silent' issue I have with all this and it's an
> explicit setting.

Right, but it's another toggle I wish we wouldn't need. We could of 
course also make it some compile-time option, but not sure if that's 
really any better.

I'd hope we find an easy way forward that doesn't require new toggles, 
at least for now ...

-- 
Cheers

David / dhildenb

