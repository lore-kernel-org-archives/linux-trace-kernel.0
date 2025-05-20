Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3925D1E3;
	Tue, 20 May 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735773; cv=none; b=lrIsiIUehaRxyd69dK1hMaQHqOapgZb9X1FvJLGIOGz93P1/x2+DK2MiS4GVA1HjL5nUZfGRlFvgsRCkBoYjJo6Bsfys+hDg7lqyaaC7XIHNO+cGEOMIpGkvgZvC7CbptxzLsh4zjMOmMJdkCVOvFZl4tWYteWoefiuFRlXzfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735773; c=relaxed/simple;
	bh=m8e9n+oAOVs4AsRimdeo9+sr4PG/7AecItEb1VRBeuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWDSdAdiKPuzWnbrNWq7S6YNR2N/U1bV+iiE9Rby8OeW/5FIr32gdYZEaj8kFsoougbFoqkAW6+LJyznsHy2oOfls6WDig2ExNWOkR84cNi9cSi3hEAW7+/5BymvKyEuH50Ak7UcmLOHAyG917AnCpudmGBw0F3KffKdDU16GHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ygOzCSXw; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ygOzCSXw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747735761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v+l36cqnPW2zFk54RHXHgtbnmyLJo7eF/GoyqNRtyHo=;
	b=ygOzCSXwtV1iMeD6LWrdiuqYAy1WYsPJjlI2ZQPrjge7Dhi4vclJnuy+8b7IOSeYMHRYinW4NQbA7Glsy2SJH/20FziviWtXFMIWZW839aSpj6Qn0QiRJZsAxgJIEC00WaBtAva5+v2CFcTVfr4V9kMOW8LbZuyFvzjDdesFkfk=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbNVW2L_1747735757 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 May 2025 18:09:18 +0800
Message-ID: <ed1d1281-ece3-4d2c-8e58-aaeb436d3927@linux.alibaba.com>
Date: Tue, 20 May 2025 18:09:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
 <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for late reply.

On 2025/5/17 14:47, Nico Pache wrote:
> On Thu, May 15, 2025 at 9:20 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/5/15 11:22, Nico Pache wrote:
>>> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
>>> To add mTHP support we use this scan to instead record chunks of utilized
>>> sections of the PMD.
>>>
>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
>>> that represents chunks of utilized regions. We can then determine what
>>> mTHP size fits best and in the following patch, we set this bitmap while
>>> scanning the anon PMD. A minimum collapse order of 2 is used as this is
>>> the lowest order supported by anon memory.
>>>
>>> max_ptes_none is used as a scale to determine how "full" an order must
>>> be before being considered for collapse.
>>>
>>> When attempting to collapse an order that has its order set to "always"
>>> lets always collapse to that order in a greedy manner without
>>> considering the number of bits set.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>
>> Sigh. You still haven't addressed or explained the issues I previously
>> raised [1], so I don't know how to review this patch again...
> Can you still reproduce this issue?

Yes, I can still reproduce this issue with today's (5/20) mm-new branch.

I've disabled PMD-sized THP in my system:
[root]# cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]
[root]# cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
always inherit madvise [never]

And I tried calling madvise() with MADV_COLLAPSE for anonymous memory, 
and I can still see it collapsing to a PMD-sized THP.

> I can no longer reproduce this issue, that's why I posted... although
> I should have followed up, and looked into what the original issue
> was. Nothing really sticks out so perhaps something in mm-new was
> broken and pulled out... not sure.
> 
> It should now follow the expected behavior, which is that no mTHP
> collapse occurs because if the PMD size is disabled so is khugepaged
> collapse.
> 
> Lmk if you are still experiencing this issue please.
> 
> Cheers,
> -- Nico
>>
>> [1]
>> https://lore.kernel.org/all/83a66442-b7c7-42e7-af4e-fd211d8ed6f8@linux.alibaba.com/
>>
