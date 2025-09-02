Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01B18C933;
	Tue,  2 Sep 2025 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780111; cv=none; b=Thbkk6zO/eYt44wq24LMPjhlR6fY9dhK448wdvOa3HfsUidrZYfdbFUgspUrYNGPHvF33hVbukeahDT7h28ZBjlLOeZ0udYHKycjYQQY714/0n5H+NEWu1Cq7EBlSWnm2q3CSLGhMoHYlBtnVMsqG98RwuOmLq+1qWKaRlEb6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780111; c=relaxed/simple;
	bh=2g9YOUmV6qRtVY8H9r9NTwL2f/S147r7pTuKS6omoZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGwEqRk0VSB4VCf9tDX80IKvoMfT7SbffM8XvmfTOcZC7Qf0M7rcTGflKNK3BGhpsNP/qDf04PwADC8giVqxPOhgYig5Dp53hxM48gRiPqa+yv+5223bzERLvq9QIhXDBQLz/BJfnpFr3V0Hmf327OV3MK3Zs3PHIOMJJoz2Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kbq59YfF; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kbq59YfF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756780099; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6NbI4kzFCdnbgFqsQU3j3woE9OiOn/2nBz2NzNgD994=;
	b=Kbq59YfFR+jJHrcPBSBT+lcut0VxAY9rNdNuIN2bnHEGGULfm/P6t3xUo3tcb4umVXMY8GrSZzjiw9/BAbcExgsZwtAokRgGPgZeuBg3jeB5cXlqD6BINLF4/iBdur6Cnly9LO2VOFsIlT1FDdSBu1NJ4J7gGn/NH1mhOdcYbWI=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wn5svZT_1756780095 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 10:28:16 +0800
Message-ID: <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com>
Date: Tue, 2 Sep 2025 10:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
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
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
 <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
 <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com>
 <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/2 00:46, David Hildenbrand wrote:
> On 29.08.25 03:55, Baolin Wang wrote:
>>
>>
>> On 2025/8/28 18:48, Dev Jain wrote:
>>>
>>> On 28/08/25 3:16 pm, Baolin Wang wrote:
>>>> (Sorry for chiming in late)
>>>>
>>>> On 2025/8/22 22:10, David Hildenbrand wrote:
>>>>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1),
>>>>>>> but not sure
>>>>>>> if we have to add that for now.
>>>>>>
>>>>>> Yeah not so sure about this, this is a 'just have to know' too, and
>>>>>> yes you
>>>>>> might add it to the docs, but people are going to be mightily
>>>>>> confused, esp if
>>>>>> it's a calculated value.
>>>>>>
>>>>>> I don't see any other way around having a separate tunable if we
>>>>>> don't just have
>>>>>> something VERY simple like on/off.
>>>>>
>>>>> Yeah, not advocating that we add support for other values than 0/511,
>>>>> really.
>>>>>
>>>>>>
>>>>>> Also the mentioned issue sounds like something that needs to be
>>>>>> fixed elsewhere
>>>>>> honestly in the algorithm used to figure out mTHP ranges (I may be
>>>>>> wrong - and
>>>>>> happy to stand corrected if this is somehow inherent, but reallly
>>>>>> feels that
>>>>>> way).
>>>>>
>>>>> I think the creep is unavoidable for certain values.
>>>>>
>>>>> If you have the first two pages of a PMD area populated, and you
>>>>> allow for at least half of the #PTEs to be non/zero, you'd collapse
>>>>> first a
>>>>> order-2 folio, then and order-3 ... until you reached PMD order.
>>>>>
>>>>> So for now we really should just support 0 / 511 to say "don't
>>>>> collapse if there are holes" vs. "always collapse if there is at
>>>>> least one pte used".
>>>>
>>>> If we only allow setting 0 or 511, as Nico mentioned before, "At 511,
>>>> no mTHP collapses would ever occur anyway, unless you have 2MB
>>>> disabled and other mTHP sizes enabled. Technically, at 511, only the
>>>> highest enabled order would ever be collapsed."
>>> I didn't understand this statement. At 511, mTHP collapses will occur if
>>> khugepaged cannot get a PMD folio. Our goal is to collapse to the
>>> highest order folio.
>>
>> Yes, I’m not saying that it’s incorrect behavior when set to 511. What I
>> mean is, as in the example I gave below, users may only want to allow a
>> large order collapse when the number of present PTEs reaches half of the
>> large folio, in order to avoid RSS bloat.
> 
> How do these users control allocation at fault time where this parameter 
> is completely ignored?

Sorry, I did not get your point. Why does the 'max_pte_none' need to 
control allocation at fault time? Could you be more specific? Thanks.
