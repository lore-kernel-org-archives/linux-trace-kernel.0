Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA61D432D;
	Tue,  2 Sep 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844592; cv=none; b=gZnNJmoPno3jqFpDgMXT43EYQksltXnP7mItpXg7CU4ckA+HyxOb0IJvj2/yZsBvRwpa3rhb0axK/OXIKH8ODTnVBb1sLnL0yh5sC+CELNz4EqeLua1mKFuJ4l4tfk8JF8V3aN90+8dhFxZDid5ODCdPMgaNKOxt67jnaEcvzU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844592; c=relaxed/simple;
	bh=z953w8TuT0ty1DvPPbTbg449UoKFmMOev6TWCrYF5aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD7cZ7Ui5RSQA8Hbb6jXJsJgPq3crPILv+ST51jXG3xiV5k/YjiX3cIG1PwENw4NDXRVUlcvDHHtBmOF7jbStuhV0UJSdrlDfxax481y/qaPXRdkif12iAHWP/UZHct75UCJs21Vblk5+CqtsiaKswgxo274Jhx+9BbFvDsUE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH1YwEXB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH1YwEXB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso17019605e9.3;
        Tue, 02 Sep 2025 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756844589; x=1757449389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3kOiwL5zqleYtylmerMclyHJqoKO1uL5DJ0d9m4VY4=;
        b=lH1YwEXB2F6GrwGQ2R7NsCAQpXekevJ2WdvZsrcErxjrnO92sFbF7FB7I9MaUSYRQa
         RuCjisQ8QPgySMOmEHLC452aZfkriU2/NjNdrZw84ejA+jfBFBGVGbygjl6BDqgBz3Ek
         Hh7FvDzbv/4Wk5XPrD7CoG5ZE/TIPuh5+rlv0zLxxNxIbjUPr46KF/BxP6Ns3hAJA6LA
         /mxkznGrMusWgA5p6aacoGQfPxznmSUHY+dB+/QtSu7TXxmv3Tu+zsHsFY4m9EElmR7Y
         pCDwLbogGzoDOUSMeg4wdY055KgN9Pee0TKRaQHYt32eIBFnbnkjxcjmojikUz8ZYU9q
         NJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844589; x=1757449389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3kOiwL5zqleYtylmerMclyHJqoKO1uL5DJ0d9m4VY4=;
        b=kSCVGkCi84qZvdb3cZWUA3b+OZDUOAooxISr6Pxr2I8/e3m8zHRx+JpNJ5X/utJuy+
         IYkPXhncySdxnEH5Z6sHo90GUTE1qbFa3UHxKKcszdeUluVDqLfz+PompYv7X5o10ecp
         RuN4goOCMwnnj5hbs4LrdsbABEnCgiRwr02dqg7RxTnfsxFgTGwXmfrSusn0l+vNC56u
         yavOQedUgpTWeGvffk1BgjQffxvgGpCfTop8nKWfum8O9bMFP9nC1Epvz72L7FuixCar
         NS9l2MWTYYl3/tX2axnz0dhZmAF7zEY44ZJrkIwyAMmzR6XIwGN30RXQzgjRtvKY+Ltz
         8Mew==
X-Forwarded-Encrypted: i=1; AJvYcCVQvGPJ2k10+oEYdqs42skeGlOa2H8bPTK1yfi34j+1iASR/avgPiJAW2vCKgPapvgSIlXQjHQHzWWMzRZWptH/Z6fj@vger.kernel.org, AJvYcCX7/x67ZX8RV71cnyAZDixmjj+IZbs3VxzAvNAQbioNFKMxpplhOxJcDzz23cRkOa5ksPJPmqsybyA=@vger.kernel.org, AJvYcCXi8SO7cEIDAtrM+XdSWC0UPEO5+2pKfgx1AX9FO4vZCxsy3ZOBrhzPW7H6JyBAFNPw+3OZuWSqJqNZQd8k@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiNq44Oi3k8gN5+E848V1Ap2Sgc2X0+DfMlDN/oZp2Ms0kqpc
	VNPv9zuIb9rJoy0vH9IcPjCTXrKx/xhegJJbAWSK6u93EQ5DVNMIi03+
X-Gm-Gg: ASbGncs7PGzIcUQ5bjgZgWua7scPCUF0JVK8kzZEUZV4U3yw6zXtM51ibkQQf6oAqk1
	jKgALY2LKqNQbyhsrf6u5aR0w8oAXngUVDW16YKVGSD0ld31H+rJuAqP7MlY7ZVh5K1ZIIQs4Tj
	/TPVet7jL7PI3jFlBJLkfSgvWXtT1xZY8UNA0uFVAE7MUlp2q6oR7XWjnGzz2rWj0jLuN2HDap1
	RKGWsw+NYqwzu1FxSd8u34A3TYXBl8+CrXzQ3iCUxxM2Ryy17woOLsvEVYWOAKpi5cjVoCq0YFW
	3ewFAbqRR3UelKidfRmwJBolzGVcs9/3p/qLORbe5HfgNdGjxg945um1Zzb/+sKqtGRsTfp9A5X
	iXDh+GodBaxOpfjZtxYf0aBDq/gd19vUX7Wop7eTXs89ir3+Q8CGdgJayRp1ZTerI+E/VgyzcLB
	/4vxclw5M5PlWRaqhjrrl2UHhkP961
X-Google-Smtp-Source: AGHT+IEh5zVEDLWkkm40Gzc0xQdpKMazKhJsQrIOonj4uGsn8SXP4VX6pG/odlqnt8wetWFbUq75gQ==
X-Received: by 2002:a05:600c:4705:b0:45b:74fc:d6ec with SMTP id 5b1f17b1804b1-45b8553f1e8mr116428895e9.8.1756844588788;
        Tue, 02 Sep 2025 13:23:08 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm211259005e9.18.2025.09.02.13.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 13:23:08 -0700 (PDT)
Message-ID: <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
Date: Tue, 2 Sep 2025 21:23:04 +0100
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
 <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com>
 <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/09/2025 12:03, David Hildenbrand wrote:
> On 02.09.25 12:34, Usama Arif wrote:
>>
>>
>> On 02/09/2025 10:03, David Hildenbrand wrote:
>>> On 02.09.25 04:28, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2025/9/2 00:46, David Hildenbrand wrote:
>>>>> On 29.08.25 03:55, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/8/28 18:48, Dev Jain wrote:
>>>>>>>
>>>>>>> On 28/08/25 3:16 pm, Baolin Wang wrote:
>>>>>>>> (Sorry for chiming in late)
>>>>>>>>
>>>>>>>> On 2025/8/22 22:10, David Hildenbrand wrote:
>>>>>>>>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1),
>>>>>>>>>>> but not sure
>>>>>>>>>>> if we have to add that for now.
>>>>>>>>>>
>>>>>>>>>> Yeah not so sure about this, this is a 'just have to know' too, and
>>>>>>>>>> yes you
>>>>>>>>>> might add it to the docs, but people are going to be mightily
>>>>>>>>>> confused, esp if
>>>>>>>>>> it's a calculated value.
>>>>>>>>>>
>>>>>>>>>> I don't see any other way around having a separate tunable if we
>>>>>>>>>> don't just have
>>>>>>>>>> something VERY simple like on/off.
>>>>>>>>>
>>>>>>>>> Yeah, not advocating that we add support for other values than 0/511,
>>>>>>>>> really.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Also the mentioned issue sounds like something that needs to be
>>>>>>>>>> fixed elsewhere
>>>>>>>>>> honestly in the algorithm used to figure out mTHP ranges (I may be
>>>>>>>>>> wrong - and
>>>>>>>>>> happy to stand corrected if this is somehow inherent, but reallly
>>>>>>>>>> feels that
>>>>>>>>>> way).
>>>>>>>>>
>>>>>>>>> I think the creep is unavoidable for certain values.
>>>>>>>>>
>>>>>>>>> If you have the first two pages of a PMD area populated, and you
>>>>>>>>> allow for at least half of the #PTEs to be non/zero, you'd collapse
>>>>>>>>> first a
>>>>>>>>> order-2 folio, then and order-3 ... until you reached PMD order.
>>>>>>>>>
>>>>>>>>> So for now we really should just support 0 / 511 to say "don't
>>>>>>>>> collapse if there are holes" vs. "always collapse if there is at
>>>>>>>>> least one pte used".
>>>>>>>>
>>>>>>>> If we only allow setting 0 or 511, as Nico mentioned before, "At 511,
>>>>>>>> no mTHP collapses would ever occur anyway, unless you have 2MB
>>>>>>>> disabled and other mTHP sizes enabled. Technically, at 511, only the
>>>>>>>> highest enabled order would ever be collapsed."
>>>>>>> I didn't understand this statement. At 511, mTHP collapses will occur if
>>>>>>> khugepaged cannot get a PMD folio. Our goal is to collapse to the
>>>>>>> highest order folio.
>>>>>>
>>>>>> Yes, I’m not saying that it’s incorrect behavior when set to 511. What I
>>>>>> mean is, as in the example I gave below, users may only want to allow a
>>>>>> large order collapse when the number of present PTEs reaches half of the
>>>>>> large folio, in order to avoid RSS bloat.
>>>>>
>>>>> How do these users control allocation at fault time where this parameter
>>>>> is completely ignored?
>>>>
>>>> Sorry, I did not get your point. Why does the 'max_pte_none' need to
>>>> control allocation at fault time? Could you be more specific? Thanks.
>>>
>>> The comment over khugepaged_max_ptes_none gives a hint:
>>>
>>> /*
>>>   * default collapse hugepages if there is at least one pte mapped like
>>>   * it would have happened if the vma was large enough during page
>>>   * fault.
>>>   *
>>>   * Note that these are only respected if collapse was initiated by khugepaged.
>>>   */
>>>
>>> In the common case (for anything that really cares about RSS bloat) you will just a
>>> get a THP during page fault and consequently RSS bloat.
>>>
>>> As raised in my other reply, the only documented reason to set max_ptes_none=0 seems
>>> to be when an application later (after once possibly getting a THP already during
>>> page faults) did some MADV_DONTNEED and wants to control the usage of THPs itself using
>>> MADV_COLLAPSE.
>>>
>>> It's a questionable use case, that already got more problematic with mTHP and page
>>> table reclaim.
>>>
>>> Let me explain:
>>>
>>> Before mTHP, if someone would MADV_DONTNEED (resulting in
>>> a page table with at least one pte_none entry), there would have been no way we would
>>> get memory over-allocated afterwards with max_ptes_none=0.
>>>
>>> (1) Page faults would spot "there is a page table" and just fallback to order-0 pages.
>>> (2) khugepaged was told to not collapse through max_ptes_none=0.
>>>
>>> But now:
>>>
>>> (A) With mTHP during page-faults, we can just end up over-allocating memory in such
>>>      an area again: page faults will simply spot a bunch of pte_nones around the fault area
>>>      and install an mTHP.
>>>
>>> (B) With page table reclaim (when zapping all PTEs in a table at once), we will reclaim the
>>>      page table. The next page fault will just try installing a PMD THP again, because there is
>>>      no PTE table anymore.
>>>
>>> So I question the utility of max_ptes_none. If you can't tame page faults, then there is only
>>> limited sense in taming khugepaged. I think there is vale in setting max_ptes_none=0 for some
>>> corner cases, but I am yet to learn why max_ptes_none=123 would make any sense.
>>>
>>>
>>
>> For PMD mapped THPs with THP shrinker, this has changed. You can basically tame pagefaults, as when you encounter
>> memory pressure, the shrinker kicks in if the value is less than HPAGE_PMD_NR -1 (i.e. 511 for x86), and
>> will break down those hugepages and free up zero-filled memory.
> 
> You are not really taming page faults, though, you are undoing what page faults might have messed up :)
> 
> I have seen in our prod workloads where
>> the memory usage and THP usage can spike (usually when the workload starts), but with memory pressure,
>> the memory usage is lower compared to with max_ptes_none = 511, while still still keeping the benefits
>> of THPs like lower TLB misses.
> 
> Thanks for raising that: I think the current behavior is in place such that you don't bounce back-and-forth between khugepaged collapse and shrinker-split.
> 

Yes, both collapse and shrinker split hinge on max_ptes_none to prevent one of these things thrashing the effect of the other.

> There are likely other ways to achieve that, when we have in mind that the thp shrinker will install zero pages and max_ptes_none includes
> zero pages.
> 
>>
>> I do agree that the value of max_ptes_none is magical and different workloads can react very differently
>> to it. The relationship is definitely not linear. i.e. if I use max_ptes_none = 256, it does not mean
>> that the memory regression of using THP=always vs THP=madvise is halved.
> 
> To which value would you set it? Just 510? 0?
> 

There are some very large workloads in the meta fleet that I experimented with and found that having
a small value works out. I experimented with 0, 51 (10%) and 256 (50%). 51 was found to be an optimal
comprimise in terms of application metrics improving, having an acceptable amount of memory regression and
improved system level metrics (lower TLB misses, lower page faults). I am sure there was a better value out
there for these workloads, but not possible to experiment with every value.

In terms of wider rollout across the fleet, we are going to target 0 (or a very very small value)
when moving from THP=madvise to always. Mainly because it is the least likely to cause a memory regression as
THP shrinker will deal with page faults faulting in mostly zero-filled pages and khugepaged wont collapse
pages that are dominated by 4K zero-filled chunks. 

