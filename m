Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B7175BF;
	Wed, 21 May 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789423; cv=none; b=B1fwcV+LzQ1tSm8ABAH6eFdoe4Yt5/KMWpZ14Sxu3KwMVHSqIzYW7EIjOzdNVXS+svfjs85fLHLaVNUZlM0M9mV7AvuX4PC+rMOuFDa29ZRTNiGnEEclmROdjn7uh25EFk+bcJCssTxjpEoC+qG3RwFkn4npe4Yar2xELh3X7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789423; c=relaxed/simple;
	bh=uR4Ma7zIdJi1QfzSZgJu8WSzigmCvCeP1WJ3cebQ7io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPZIP/OJx1eergmPhjXm2sS2M275jwdgLibcb7Vbeh356W9TlMDLT5t3CH/0GRN62xR6tazvvhvuOh88W7xgnbTccei0NOYu6Ehs10pUmx/9xDk4l/Z9lhoiJQMTOZl319psoS+fRPeihizpGs4+kmu7jfocQdnfH9XdHyBGI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zymw/q3g; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zymw/q3g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747789410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IbxzWj46aDkmP6ud0D2tY3tdDM9QG1secqyWNuptJB0=;
	b=Zymw/q3gJzIEYNgqg0tzVLduieqJqcaWOieEswHoQmQoZaSsq5pRwKXGYWUZgGErE1l1ihxCzYdVUz4P/f5Lt/MQy6OnZoXWpgk/EWM0Qx3HO47T+RMG495lR8gNKdkbRgtPIR8mPDDkCB/jurDaKxDqbNY47MgpA8CkOl0hgEQ=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbPLCQs_1747789406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 May 2025 09:03:27 +0800
Message-ID: <048f7e1c-2ae8-41d9-a46a-964ca6253314@linux.alibaba.com>
Date: Wed, 21 May 2025 09:03:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: David Hildenbrand <david@redhat.com>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
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
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
 <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
 <ed1d1281-ece3-4d2c-8e58-aaeb436d3927@linux.alibaba.com>
 <13f8e557-da9d-4ccf-9372-6acdc865586a@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <13f8e557-da9d-4ccf-9372-6acdc865586a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/20 18:26, David Hildenbrand wrote:
> On 20.05.25 12:09, Baolin Wang wrote:
>> Sorry for late reply.
>>
>> On 2025/5/17 14:47, Nico Pache wrote:
>>> On Thu, May 15, 2025 at 9:20 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/5/15 11:22, Nico Pache wrote:
>>>>> khugepaged scans anons PMD ranges for potential collapse to a 
>>>>> hugepage.
>>>>> To add mTHP support we use this scan to instead record chunks of 
>>>>> utilized
>>>>> sections of the PMD.
>>>>>
>>>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a 
>>>>> bitmap
>>>>> that represents chunks of utilized regions. We can then determine what
>>>>> mTHP size fits best and in the following patch, we set this bitmap 
>>>>> while
>>>>> scanning the anon PMD. A minimum collapse order of 2 is used as 
>>>>> this is
>>>>> the lowest order supported by anon memory.
>>>>>
>>>>> max_ptes_none is used as a scale to determine how "full" an order must
>>>>> be before being considered for collapse.
>>>>>
>>>>> When attempting to collapse an order that has its order set to 
>>>>> "always"
>>>>> lets always collapse to that order in a greedy manner without
>>>>> considering the number of bits set.
>>>>>
>>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>>
>>>> Sigh. You still haven't addressed or explained the issues I previously
>>>> raised [1], so I don't know how to review this patch again...
>>> Can you still reproduce this issue?
>>
>> Yes, I can still reproduce this issue with today's (5/20) mm-new branch.
>>
>> I've disabled PMD-sized THP in my system:
>> [root]# cat /sys/kernel/mm/transparent_hugepage/enabled
>> always madvise [never]
>> [root]# cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>> always inherit madvise [never]
> 
> Thanks for the easy reproducer, Baolin! It's certainly something that 
> must be fixed.
> 
>>
>> And I tried calling madvise() with MADV_COLLAPSE for anonymous memory,
>> and I can still see it collapsing to a PMD-sized THP.
> 
> This almost sounds like it could be converted into an easy selftest.
> 
> Baolin, do you have other ideas for easy selftests? It might be good to 
> include some in the next version. >
> I can think of: enable only a single size, then MADV_COLLAPSE X times 
> and see if it worked. etc.

Yes. And some easy test cases I want to write are:

(1) Enable all mTHP size, tuning 'max_ptes_none' parameter to check if 
the suitable sized mTHP is being collapsed (including MADV_COLLAPSE and 
khugepaged).
(2) Enable only a single size, calling MADV_COLLAPSE madvise() or 
khugepaged to check if the suitable sized mTHP is being collapsed.
