Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F12773CD;
	Tue,  2 Sep 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809262; cv=none; b=Uz9PUR8uKqJau0bXKw1zvBLKzV+/qfq+AhR+2//5ptgMQ92yDZq6UXIzZM0NF5B3REqNA3L632uJ33bOUnkGQl8GTEUGzQTccX5MnWy1tX/tK7eYa2P6otiveKDiIfjq3MYMnvWGGpudk9S684OguYZFnhFH4Jye6oj8djipEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809262; c=relaxed/simple;
	bh=FrH6AyAfHO84vUkL3/iSVflcDEgrcRjRVX1IepxJgr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoWJ31bp2c6BDU/gI0QKfGOTjGT9GUiv/Nnw7N77m9JA0R6hlH7FsTSgV4OtpxOs1ClP1tsbmPQnLTY4peUKfW38aA1OiO6XrFUpz4r1HziuTesv7urNo6l7DAHz+YYLB05PsQ1L9uhdffI7HimDzb/IDM9qAbHRlwr8h4yW2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL0ruERa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL0ruERa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso4195575e9.0;
        Tue, 02 Sep 2025 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756809258; x=1757414058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gr05sFl9E5mGpq0zxI24mI1hqeAukkuCMWxkJ3Xa7A=;
        b=GL0ruERaCHQ7vDDoK1Uy9uYQQx2hZoZNChKeBBWsTksD846JDuqNA9wqIoYm6Eh0QW
         vk7VGygHCc5juSV/mgDgvk3FD+gb0mIIfV+8L2a1dHh9EeRH7gqmIJMm4caBHJfS/ajl
         05Ef+762RWAqxGDxg6dhEYiD6pTmEqAQvBWiT839N6dvthZHQ9vRXfESDv2nyro7b7Is
         MirqLFngBPpgSXUSAST1NtOys51cbUF5jKorvu0KuQxW1J/FYy8n0nCVJ0oR7Z1j8nFB
         QAD3Kla2QtzX4A5je3Y3EoaVaI+Htnn1j/55fCQWYP0o1MgW5FI+bSoAGMhcNdkDIzvD
         I+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809258; x=1757414058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gr05sFl9E5mGpq0zxI24mI1hqeAukkuCMWxkJ3Xa7A=;
        b=PjA2go+DSM0/D8U4riEEPxVUZH3r5QrFs8OMcsHu5YF96/cmoWBeIg1u0GlrevDAOA
         O9fFFvXsErJlGWH50OJ6s6SwV9vXMahtEQWZvF+gfxsij8S2Q+axvgZlBU0tRreSlova
         XG0BySaQBj2+T3YIUGNdVnpW809q58in+kNdDo5UrVF9aKws6FnLpbMwGE1WJy78o00V
         g+OxBNhSFJUPMN+r8NX4Cd2soKJfTSWBclWcHk86sAoG9vpy95hlCjaHhX0eL+CY5QBF
         VUhMiXG7sYSq5o2RtCJWSSlv79v3v4Q09IrYapqNeJ26uQZ0WcXAKxJD3jw69eKp3q79
         8gbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUess5qe4l4gQDq4ii5i1SvAxV7ArUP0NrJkTvSvSBCskMVSnW3RUcJJqPIaZ3XZbOaHfii3yFgC+y2euNr@vger.kernel.org, AJvYcCV3CnXUblXIajSMunqI4cVWvLkp0WOwygl2XI5stiYPhiINt/2wr7qFDcVWHqStlHfB58nlQeH9oMw=@vger.kernel.org, AJvYcCVAhDBFjzCXF+UIUcQUMfUIg3oQ5OXBKAI/3/Y0+323Nk/doi9qdLkdLuhtYmwtiYdco9Wdo/qTid+Ooe8ynLgp/4AK@vger.kernel.org
X-Gm-Message-State: AOJu0YyAC/SWiXN3mKn3wjpLIKad25LIBoOEIUXDmUWXiHE1EAB6cC4x
	i3g5IC/h4N6+7HJtuopwr8ZZHa1+yNKqSM4y9OetDJebE42F0mhWpsqz
X-Gm-Gg: ASbGnct1bah6FEZj4bK1Z/Rf6eHaNBwjpVxoFBjL2JKeW4COMZIodkHEauwokE8VaiC
	klR9Qb7oqCCbKZQArXRasrqwVojgtI1UakGLk7tyuD5BUypkqknAvGlHzK2FmnzSmLn7GBjRv5V
	0umOipM/HSjb1PblVYPHtf6vJL4X/CxMN+guFeqz2BVFQSxWZ8KewSyiPAnUgH+ypsEeZMqYKMv
	X3Tx4qm8gSGE3qkypV8JiLg1SMmB7jbSaaiqrerNlW229NVp2QHV8cyaPe2usJ1cESPpZ9NB24F
	X5+/YYSF/dBwEaEFlAgnd8x0bNDeqNFXWgBs+nG6D4bokPCxy+Du49TaM44nX/IGYvNL45O75qC
	khQIFtvPFtToaTrB/psrSogvY5wIJOn0qsiRPcsWKMlB+cQzuyM+/F0Ze6D6EWYbcPX6p2qKQnh
	uNOOqOpt3JWTfmsNrT
X-Google-Smtp-Source: AGHT+IHr9wRTUh3+XFyRCz1Zu9zWA4/sbliCfxf1+3LDP5RehEXdAv+muRODoSoFjICHs5NQzhGYrg==
X-Received: by 2002:a05:600c:1389:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b85589e58mr99248955e9.11.1756809258185;
        Tue, 02 Sep 2025 03:34:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::6:2ee9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b813816desm103955815e9.4.2025.09.02.03.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:34:17 -0700 (PDT)
Message-ID: <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com>
Date: Tue, 2 Sep 2025 11:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
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
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
 <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
 <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com>
 <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
 <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com>
 <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/2025 10:03, David Hildenbrand wrote:
> On 02.09.25 04:28, Baolin Wang wrote:
>>
>>
>> On 2025/9/2 00:46, David Hildenbrand wrote:
>>> On 29.08.25 03:55, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/8/28 18:48, Dev Jain wrote:
>>>>>
>>>>> On 28/08/25 3:16 pm, Baolin Wang wrote:
>>>>>> (Sorry for chiming in late)
>>>>>>
>>>>>> On 2025/8/22 22:10, David Hildenbrand wrote:
>>>>>>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1),
>>>>>>>>> but not sure
>>>>>>>>> if we have to add that for now.
>>>>>>>>
>>>>>>>> Yeah not so sure about this, this is a 'just have to know' too, and
>>>>>>>> yes you
>>>>>>>> might add it to the docs, but people are going to be mightily
>>>>>>>> confused, esp if
>>>>>>>> it's a calculated value.
>>>>>>>>
>>>>>>>> I don't see any other way around having a separate tunable if we
>>>>>>>> don't just have
>>>>>>>> something VERY simple like on/off.
>>>>>>>
>>>>>>> Yeah, not advocating that we add support for other values than 0/511,
>>>>>>> really.
>>>>>>>
>>>>>>>>
>>>>>>>> Also the mentioned issue sounds like something that needs to be
>>>>>>>> fixed elsewhere
>>>>>>>> honestly in the algorithm used to figure out mTHP ranges (I may be
>>>>>>>> wrong - and
>>>>>>>> happy to stand corrected if this is somehow inherent, but reallly
>>>>>>>> feels that
>>>>>>>> way).
>>>>>>>
>>>>>>> I think the creep is unavoidable for certain values.
>>>>>>>
>>>>>>> If you have the first two pages of a PMD area populated, and you
>>>>>>> allow for at least half of the #PTEs to be non/zero, you'd collapse
>>>>>>> first a
>>>>>>> order-2 folio, then and order-3 ... until you reached PMD order.
>>>>>>>
>>>>>>> So for now we really should just support 0 / 511 to say "don't
>>>>>>> collapse if there are holes" vs. "always collapse if there is at
>>>>>>> least one pte used".
>>>>>>
>>>>>> If we only allow setting 0 or 511, as Nico mentioned before, "At 511,
>>>>>> no mTHP collapses would ever occur anyway, unless you have 2MB
>>>>>> disabled and other mTHP sizes enabled. Technically, at 511, only the
>>>>>> highest enabled order would ever be collapsed."
>>>>> I didn't understand this statement. At 511, mTHP collapses will occur if
>>>>> khugepaged cannot get a PMD folio. Our goal is to collapse to the
>>>>> highest order folio.
>>>>
>>>> Yes, I’m not saying that it’s incorrect behavior when set to 511. What I
>>>> mean is, as in the example I gave below, users may only want to allow a
>>>> large order collapse when the number of present PTEs reaches half of the
>>>> large folio, in order to avoid RSS bloat.
>>>
>>> How do these users control allocation at fault time where this parameter
>>> is completely ignored?
>>
>> Sorry, I did not get your point. Why does the 'max_pte_none' need to
>> control allocation at fault time? Could you be more specific? Thanks.
> 
> The comment over khugepaged_max_ptes_none gives a hint:
> 
> /*
>  * default collapse hugepages if there is at least one pte mapped like
>  * it would have happened if the vma was large enough during page
>  * fault.
>  *
>  * Note that these are only respected if collapse was initiated by khugepaged.
>  */
> 
> In the common case (for anything that really cares about RSS bloat) you will just a
> get a THP during page fault and consequently RSS bloat.
> 
> As raised in my other reply, the only documented reason to set max_ptes_none=0 seems
> to be when an application later (after once possibly getting a THP already during
> page faults) did some MADV_DONTNEED and wants to control the usage of THPs itself using
> MADV_COLLAPSE.
> 
> It's a questionable use case, that already got more problematic with mTHP and page
> table reclaim.
> 
> Let me explain:
> 
> Before mTHP, if someone would MADV_DONTNEED (resulting in
> a page table with at least one pte_none entry), there would have been no way we would
> get memory over-allocated afterwards with max_ptes_none=0.
> 
> (1) Page faults would spot "there is a page table" and just fallback to order-0 pages.
> (2) khugepaged was told to not collapse through max_ptes_none=0.
> 
> But now:
> 
> (A) With mTHP during page-faults, we can just end up over-allocating memory in such
>     an area again: page faults will simply spot a bunch of pte_nones around the fault area
>     and install an mTHP.
> 
> (B) With page table reclaim (when zapping all PTEs in a table at once), we will reclaim the
>     page table. The next page fault will just try installing a PMD THP again, because there is
>     no PTE table anymore.
> 
> So I question the utility of max_ptes_none. If you can't tame page faults, then there is only
> limited sense in taming khugepaged. I think there is vale in setting max_ptes_none=0 for some
> corner cases, but I am yet to learn why max_ptes_none=123 would make any sense.
> 
> 

For PMD mapped THPs with THP shrinker, this has changed. You can basically tame pagefaults, as when you encounter
memory pressure, the shrinker kicks in if the value is less than HPAGE_PMD_NR -1 (i.e. 511 for x86), and
will break down those hugepages and free up zero-filled memory. I have seen in our prod workloads where
the memory usage and THP usage can spike (usually when the workload starts), but with memory pressure,
the memory usage is lower compared to with max_ptes_none = 511, while still still keeping the benefits
of THPs like lower TLB misses.

I do agree that the value of max_ptes_none is magical and different workloads can react very differently
to it. The relationship is definitely not linear. i.e. if I use max_ptes_none = 256, it does not mean
that the memory regression of using THP=always vs THP=madvise is halved.


