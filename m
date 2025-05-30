Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA0155335;
	Fri, 30 May 2025 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574171; cv=none; b=XoaRa6gh5/GixAheqiRNCEq5acGZkJFr+Fs+1DliGwRbflifuRt49RPVuotsNyJ7kTiH3ZLNoBQgHgdSXz9MvLgVAdgVlFPq4W+4WQNlYDyq4X9pzZtJUvUIC2FTzRYqlknq9FzQrjQ0MhuvYUEr5gjT9x9tucO+z77s3xOquFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574171; c=relaxed/simple;
	bh=H20DZxJJ1yGzZ/Nk6Ga7RSWoWgAA3WXWsCcc8u22kLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCmrNOHsYegMhSv9pRvsjNDW5HlizYBQDUgWbGgCTnvKHp+iXjFwQ0bgTtUbIawU0HUJqmLzkqBpLQEYm11x+A+CO4OcpH0HfaHZMxGhjhswirn2/QuMlQqMCsm2WGT6+4txD1DOwtSXiIlTx+S2z04IDxa3BSZIgTrPqZtGWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n0E5f/jQ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n0E5f/jQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748574166; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DAgpEBG7lmS2E9GcUvqSz/E0dYP9VfRFSqUiZg8V0VE=;
	b=n0E5f/jQ4KYapFdporPqlcAh6WAwP0lvvfJOYnGY7EvC4TUJHEQ45RNU0kCcgQ/7brU4WkvV3ORWWoGKMtcX1MR4Y8F+VBzNRoSEsUfR+JeuejeSnM7hYdU76gX/p6bzBespahVQhd9FF+ywnDxqvTOZl/MyqLDTEidUoQh20Ts=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcJjWJe_1748574162 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 11:02:43 +0800
Message-ID: <07b4db81-095d-4f02-a34f-16f0743039ce@linux.alibaba.com>
Date: Fri, 30 May 2025 11:02:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
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
 <20250515032226.128900-4-npache@redhat.com>
 <469db7d1-ba99-4dc7-af13-b5fe850d4031@linux.alibaba.com>
 <CAA1CXcA4a3pJ_dJ77TvRRimPiNYacyRe5GMY=iUEz-27NHCVxQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcA4a3pJ_dJ77TvRRimPiNYacyRe5GMY=iUEz-27NHCVxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/29 12:00, Nico Pache wrote:
> On Fri, May 23, 2025 at 12:55 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/5/15 11:22, Nico Pache wrote:
>>> For khugepaged to support different mTHP orders, we must generalize this
>>> to check if the PMD is not shared by another VMA and the order is
>>> enabled.
>>>
>>> No functional change in this patch.
>>>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    mm/khugepaged.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 5457571d505a..0c4d6a02d59c 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct collapse_control *cc)
>>>    static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>>                                   bool expect_anon,
>>>                                   struct vm_area_struct **vmap,
>>> -                                struct collapse_control *cc)
>>> +                                struct collapse_control *cc, int order)
>>>    {
>>>        struct vm_area_struct *vma;
>>>        unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>>> @@ -934,7 +934,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>>
>>>        if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>>
>> Sorry, I missed this before. Should we also change 'PMD_ORDER' to
>> 'order' for the thp_vma_suitable_order()?
> This was changed since the last version (v5) due to an email from Hugh.
> https://lore.kernel.org/lkml/7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com/
> 
> As I noted in my reply to him, although he was not able to reproduce
> an issue due to this, we always need to revalidate the PMD order to
> verify the PMD range is not shared by another VMA.

OK. I see. Better to add some comments like Hugh did to make it clear.
