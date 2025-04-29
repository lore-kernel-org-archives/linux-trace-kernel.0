Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019C1C5D7D;
	Tue, 29 Apr 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910985; cv=none; b=YcFfY0/s3meZOzVRQ+iYaJdmymEuxy6TUeVWDHFzLlA+yA+Cdzs+dyuVpZvCxY8zq2rEd/vFI7lOcYVVe/fXQQqrNPQFzSU2HPA8Z3xpDMWbsW/qGEYJNmPtOjg7qws3JuVU/wUKo/YYCt0zavhBT3KTl8/MmIVJOb+Zls7hTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910985; c=relaxed/simple;
	bh=mDsXvFYCqLUt6MkNyVoQCAOGXZknjiPYiw5eBAG99RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPHwEUfMiJEVjg4XDVmcUDFH3mPNsvG0+Uqxdpdd3+8VvUDNUqKYG10atHYRH4kYQ+4kfOu0YrLR8DUbicWoimNnEYypV/KgSzyqwYBb10kl1U1oL7Xe6L55fPM/lWy+U1Sr2mVF3QLTUau1L2cdmA75iHbmzrle0C6FxT754zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w2giMlaa; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w2giMlaa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745910973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V7fNVsPJQwk08b50EHm4veDfd70FS94pJvf8TbPo+hE=;
	b=w2giMlaajiwYE2LKJFE7DccGA4gBQUSLbJAsA5RRq0kriJztZtsJKaDflBpDJqq5tJxrjN3yJBuBLPYEbp62Hssghp5fyM94vku05MDORzbarObgPm0snpniPnhwwPvnBlIn23pEHFtK7jm1ofE6lI2zSlz42eldZAJsaHYnARI=
Received: from 30.74.146.169(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYcmdSq_1745910969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Apr 2025 15:16:10 +0800
Message-ID: <ad93f480-431a-4f9b-9225-136d8c6c37df@linux.alibaba.com>
Date: Tue, 29 Apr 2025 15:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-7-npache@redhat.com>
 <5de38fe3-4a73-443b-87d1-0c836ffdbe30@linux.alibaba.com>
 <CAA1CXcAiiBJ4mMp0WJUk7tWTF20guJi80P8wBh271yJ9P+c_VA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcAiiBJ4mMp0WJUk7tWTF20guJi80P8wBh271yJ9P+c_VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/4/28 22:47, Nico Pache wrote:
> On Sat, Apr 26, 2025 at 8:52 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/4/17 08:02, Nico Pache wrote:
>>> khugepaged scans PMD ranges for potential collapse to a hugepage. To add
>>> mTHP support we use this scan to instead record chunks of utilized
>>> sections of the PMD.
>>>
>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
>>> that represents chunks of utilized regions. We can then determine what
>>> mTHP size fits best and in the following patch, we set this bitmap while
>>> scanning the PMD.
>>>
>>> max_ptes_none is used as a scale to determine how "full" an order must
>>> be before being considered for collapse.
>>>
>>> When attempting to collapse an order that has its order set to "always"
>>> lets always collapse to that order in a greedy manner without
>>> considering the number of bits set.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    include/linux/khugepaged.h |  4 ++
>>>    mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>>>    2 files changed, 89 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>>> index 1f46046080f5..18fe6eb5051d 100644
>>> --- a/include/linux/khugepaged.h
>>> +++ b/include/linux/khugepaged.h
>>> @@ -1,6 +1,10 @@
>>>    /* SPDX-License-Identifier: GPL-2.0 */
>>>    #ifndef _LINUX_KHUGEPAGED_H
>>>    #define _LINUX_KHUGEPAGED_H
>>> +#define KHUGEPAGED_MIN_MTHP_ORDER    2
>>
>> Why is the minimum mTHP order set to 2? IMO, the file large folios can
>> support order 1, so we don't expect to collapse exec file small folios
>> to order 1 if possible?
> I should have been more specific in the patch notes, but this affects
> anonymous only. I'll go over my commit messages and make sure this is
> reflected in the next version.

OK. I am looking into how to support shmem mTHP collapse based on your 
patch series.

>> (PS: I need more time to understand your logic in this patch, and any
>> additional explanation would be helpful:) )
> 
> We are currently scanning ptes in a PMD. The core principle/reasoning
> behind the bitmap is to keep the PMD scan while saving its state. We
> then use this bitmap to determine which chunks of the PMD are active
> and are the best candidates for mTHP collapse. We start at the PMD
> level, and recursively break down the bitmap to find the appropriate
> sizes for the bitmap.
> 
> looking at a simplified example: we scan a PMD and get the following
> bitmap, 1111101101101011 (in this case MIN_MTHP_ORDER= 5, so each bit
> == 32 ptes, in the actual set each bit == 4 ptes).
> We would first attempt a PMD collapse, while checking the number of
> bits set vs the max_ptes_none tunable. If those conditions arent
> triggered, we will try the next enabled mTHP order, for each half of
> the bitmap.
> 
> ie) order 8 attempt on 11111011 and order 8 attempt on 01101011.
> 
> If a collapse succeeds we dont keep recursing on that portion of the
> bitmap. If not, we continue attempting lower orders.
> 
> Hopefully that helps you understand my logic here! Let me know if you
> need more clarification.

Thanks for your explanation. That's pretty much how I understand it.:) 
I'll give a test for your new version.

> 
> I gave a presentation on this that might help too:
> https://docs.google.com/presentation/d/1w9NYLuC2kRcMAwhcashU1LWTfmI5TIZRaTWuZq-CHEg/edit?usp=sharing&resourcekey=0-nBAGld8cP1kW26XE6i0Bpg

Unfortunately, this link requires access permission.
