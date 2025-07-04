Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D52101B3;
	Fri,  4 Jul 2025 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608301; cv=none; b=J5yGHL7MTUYHfhXASvcLYUb7yiRU2dK3YLVcGQyrdYQYd9Lxxkh8Et1aUerA+BpWW0oxzoQHuEjGpknSKb0PeFiLug/C/eOcSP1c57oW4JGKCgPn9qCElD+APfDqvUN7MfUvyVi9pCYlyIfkZRrirEQl6UA4CPootc755shQEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608301; c=relaxed/simple;
	bh=p8Bbbo9iPnfydy2MzoF0+xYVAUH03f2bXGlENc6b+/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el/BKLuw4hmVtzcbXi18YHzg6odyGjqto2G0oqRIfhfPK3n3Ch1zTy6GHKjD/GXHxso37tiQUoWyMUiPnAmYYrAcFYM4qjDwNcW/U4grC4YcJ2bS7G6aG3crn7x2xY7OgwIEi+Ba6GFd3zGIC6ZapchTep4jP5bXXpE7oD4mfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Aqxyo+WJ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Aqxyo+WJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751608294; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TX9+9h0KSjwgkpYF/X1VMPdbIjBum8fWzahSSY+SukQ=;
	b=Aqxyo+WJYhPBg38N9D3eaRynHExNphaLykSo5EtAvIoq9Yxq6sxWomvRempvURc/41VqJqwKmxVvuLfEf8JDGuB1NuJUcWQL3GCqKmMLbPBSlAfgcdzfbJUL0SedjaV5I83vILtlNpHqLW4kzBR4WX6PMhI2Hrw9cHC2f/bWPyQ=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WhBmuXj_1751608290 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 13:51:31 +0800
Message-ID: <28917c0a-a58c-4d19-bcc3-aef1c1969e8c@linux.alibaba.com>
Date: Fri, 4 Jul 2025 13:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
To: Nico Pache <npache@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-3-npache@redhat.com>
 <ca0d8c87-2998-48f8-bef6-3e99a92f28e4@linux.alibaba.com>
 <CAA1CXcDH5xTSGHJu13Gb3EfNnntKwQn6Oq6rhS5uFoyLwid0Jw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcDH5xTSGHJu13Gb3EfNnntKwQn6Oq6rhS5uFoyLwid0Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/4 12:20, Nico Pache wrote:
> On Thu, Jul 3, 2025 at 9:51 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/7/2 13:57, Nico Pache wrote:
>>> The khugepaged daemon and madvise_collapse have two different
>>> implementations that do almost the same thing.
>>>
>>> Create khugepaged_collapse_single_pmd to increase code reuse and create an
>>> entry point these two users.
>>>
>>> Refactor madvise_collapse and khugepaged_scan_mm_slot to use the new
>>> khugepaged_collapse_single_pmd function. This introduces a minor
>>> behavioral change that is most likely an undiscovered bug. The current
>>> implementation of khugepaged tests khugepaged_test_exit_or_disable
>>> before calling khugepaged_pte_mapped_thp, but we weren't doing it in the
>>> madvise_collapse case. By unifying these two callers madvise_collapse
>>> now also performs this check.
>>>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
>>>    1 file changed, 49 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index f27fe7ca9b86..bf69e81a3d82 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -2354,6 +2354,50 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>>>        return result;
>>>    }
>>>
>>> +/*
>>> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
>>> + * the results.
>>> + */
>>> +static int khugepaged_collapse_single_pmd(unsigned long addr,
>>> +                                struct vm_area_struct *vma, bool *mmap_locked,
>>> +                                struct collapse_control *cc)
>>> +{
>>> +     int result = SCAN_FAIL;
>>> +     struct mm_struct *mm = vma->vm_mm;
>>> +
>>> +     if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
>>
>> Seems you still forgot to drop 'IS_ENABLED(CONFIG_SHMEM)' :)
> Hi Baolin,
> 
> You had me questioning my sanity for a moment because I SWEAR I did do
> this! but now I see the issue, I accidentally merged the fixup into
> patch 6 (not entirely sure how or why I would have done that given my
> notes say it belongs in this patch...)

Ah, yes.

> I'm sorry about that :< I'll see if I can work with Andrew to get some
> fixups into mm-new (this was merged a few hours ago) for this patch
> and patch 6.

OK. Thanks.
