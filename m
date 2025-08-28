Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCF26E6F2;
	Thu, 28 Aug 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374419; cv=none; b=qeFefHn4PD7+mepvDkKkjDSvlNLPjd8zPJJPRdzLwJSwTqgG4XF/NhgZEIey6kSIRZ7VHTglJPxXW+FMO+H3o2htat3xflJE7wZUAaHHu0MTgPJc2TWaaFnRcsJywlDyC+EfW6qobFYqVHTfyuvo3rsbZ41E4W5g70gQWBju/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374419; c=relaxed/simple;
	bh=LpA6H+aeQtqTKiAd+afSJ6jbJZdTff8nG98/sQA0udU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmIRYVAPGVgiy1gGKxc+s6DXhf1BG+9eEgkgBr48IRpyRqMJbWENAa9ox7yILXoYJbuCfIU6ooxukeD3juOb9UMgtoPTkRWaIsoK/1MTyHjpF1FmGvDB6lSGxcY78mThhReDMce4oqUpAMzHtMHeJQs3WY/1HnIKHN2bGNv8t/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xO0j4LAX; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xO0j4LAX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756374408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A5UZMuVtzlTYwPVWKKP1nj4b0AXXLsi60Juw56Bu+zg=;
	b=xO0j4LAXCmE+45QBgPVj4+GO9sgb5rNOjWeCPILLqH2Lcf6Y4LMgLa7S6NLmK/Mgti0P0ZMs4/OsH0ygDYPB/xpFOJNutWlHPvKrq8LKEKswUtG+2ZhbllK/ADEW7u/mR2fd4PB3WOUkqDKe5zT9E5LJiEKJgZdOp1tzUoirJcI=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmmpNqb_1756374404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 17:46:45 +0800
Message-ID: <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
Date: Thu, 28 Aug 2025 17:46:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(Sorry for chiming in late)

On 2025/8/22 22:10, David Hildenbrand wrote:
>>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1), 
>>> but not sure
>>> if we have to add that for now.
>>
>> Yeah not so sure about this, this is a 'just have to know' too, and 
>> yes you
>> might add it to the docs, but people are going to be mightily 
>> confused, esp if
>> it's a calculated value.
>>
>> I don't see any other way around having a separate tunable if we don't 
>> just have
>> something VERY simple like on/off.
> 
> Yeah, not advocating that we add support for other values than 0/511, 
> really.
> 
>>
>> Also the mentioned issue sounds like something that needs to be fixed 
>> elsewhere
>> honestly in the algorithm used to figure out mTHP ranges (I may be 
>> wrong - and
>> happy to stand corrected if this is somehow inherent, but reallly 
>> feels that
>> way).
> 
> I think the creep is unavoidable for certain values.
> 
> If you have the first two pages of a PMD area populated, and you allow 
> for at least half of the #PTEs to be non/zero, you'd collapse first a
> order-2 folio, then and order-3 ... until you reached PMD order.
> 
> So for now we really should just support 0 / 511 to say "don't collapse 
> if there are holes" vs. "always collapse if there is at least one pte 
> used".

If we only allow setting 0 or 511, as Nico mentioned before, "At 511, no 
mTHP collapses would ever occur anyway, unless you have 2MB disabled and 
other mTHP sizes enabled. Technically, at 511, only the highest enabled 
order would ever be collapsed."

In other words, for the scenario you described, although there are only 
2 PTEs present in a PMD, it would still get collapsed into a PMD-sized 
THP. In reality, what we probably need is just an order-2 mTHP collapse.

If 'khugepaged_max_ptes_none' is set to 255, I think this would achieve 
the desired result: when there are only 2 PTEs present in a PMD, an 
order-2 mTHP collapse would be successed, but it wouldn’t creep up to an 
order-3 mTHP collapse. That’s because:
When attempting an order-3 mTHP collapse, 'threshold_bits' = 1, while 
'bits_set' = 1 (means only 1 chunk is present), so 'bits_set > 
threshold_bits' is false, then an order-3 mTHP collapse wouldn’t be 
attempted. No?

So I have some concerns that if we only allow setting 0 or 511, it may 
not meet the goal we have for mTHP collapsing.

>>> Because, as raised in the past, I'm afraid nobody on this earth has a 
>>> clue how
>>> to set this parameter to values different to 0 (don't waste memory 
>>> with khugepaged)
>>> and 511 (page fault behavior).
>>
>> Yup
>>
>>>
>>>
>>> If any other value is set, essentially
>>>     pr_warn("Unsupported 'max_ptes_none' value for mTHP collapse");
>>>
>>> for now and just disable it.
>>
>> Hmm but under what circumstances? I would just say unsupported value 
>> not mention
>> mTHP or people who don't use mTHP might find that confusing.
> 
> Well, we can check whether any mTHP size is enabled while the value is 
> set to something unexpected. We can then even print the problematic 
> sizes if we have to.
> 
> We could also just just say that if the value is set to something else 
> than 511 (which is the default), it will be treated as being "0" when 
> collapsing mthp, instead of doing any scaling.
> 

