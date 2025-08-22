Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FA2E5B08;
	Fri, 22 Aug 2025 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845986; cv=none; b=nHVAYym6+rfGz/ecQwcgHGQYsyi73asShSKeET+MewnAsx2lHjPVYtD+yhJ9YaS+Zma+RiTbEC1iJhCTbGKgzbfL0V3Xi2aEnVOqJiOD9D6Bzfc/WIrkZQ9hVmby1OI95OOvOjTqh44izJzF5RG7KhwLnJtryFRd5ABN7KXsnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845986; c=relaxed/simple;
	bh=Uy5vBO8psVXG0UKZHrZHg1PImkJWgCbcwnHvjRqYzzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlScNKN2nJtseSJWCZWSf0Wqxn0H/pYCK7W0HZsmwzKd0BKoxXUFacSo5x7HqA9qC6lnS7YzVZ78F7wEXQ2LVyKojZ/aDr4ZOvEEpg4aI0rBA3W3aVaK4eHQCZC4miEtZvV24/EE88Ph7QAHRNo+PzCnFB+kCCrVCx9H6gTU8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L/brIPPp; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L/brIPPp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755845973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YkM4XdDBFAdRbT5J+s3/gC6XHNJgFJP15TsoieCtwm0=;
	b=L/brIPPp0+mMFJnyW98o1Dd0P5d/w3Wul5CR4iFkqbyXx3Q+cDQZoMrdn3fA0rtJn/KFoBaaiLgmjTzMGXW5t59lrtxhhH/deiYmbEc30wzItYwbF0cziBh9BT+Z99XaLtMeMi6EYVnOiyEWzKRRxRRvRq+DEoYb+zz2tigiGkU=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmIuUdM_1755845969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 14:59:30 +0800
Message-ID: <0269b6d4-23ce-416f-8c44-907478c3d6dd@linux.alibaba.com>
Date: Fri, 22 Aug 2025 14:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/13] khugepaged: kick khugepaged for enabling
 none-PMD-sized mTHPs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
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
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-11-npache@redhat.com>
 <d9a02ed5-0d6e-41e6-985d-23f5a2de093d@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d9a02ed5-0d6e-41e6-985d-23f5a2de093d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/21 22:18, Lorenzo Stoakes wrote:
> On Tue, Aug 19, 2025 at 07:42:02AM -0600, Nico Pache wrote:
>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> When only non-PMD-sized mTHP is enabled (such as only 64K mTHP enabled),
> 
> I don't think this example is very useful, probably just remove it.
> 
> Also 'non-PMD-sized mTHP' implies there is such a thing as PMD-sized mTP :)
> 
>> we should also allow kicking khugepaged to attempt scanning and collapsing
> 
> What is kicking? I think this should be rephrased to something like 'we should
> also allow khugepaged to attempt scanning...'
> 
>> 64K mTHP. Modify hugepage_pmd_enabled() to support mTHP collapse, and
> 
> 64K mTHP -> "of mTHP ranges". Put the 'Modify...' bit in a new paragraph to
> be clear.
> 
>> while we are at it, rename it to make the function name more clear.
> 
> To make this clearer let me suggest:
> 
> 	In order for khugepaged to operate when only mTHP sizes are
> 	specified in sysfs, we must modify the predicate function that
> 	determines whether it ought to run to do so.
> 
> 	This function is currently called hugepage_pmd_enabled(), this
> 	patch renames it to hugepage_enabled() and updates the logic to
> 	check to determine whether any valid orders may exist which would
> 	justify khugepaged running.

Thanks. This looks good to me.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
> 
>> ---
>>   mm/khugepaged.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 2cadd07341de..81d2ffd56ab9 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -430,7 +430,7 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>>   		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>>   }
>>
>> -static bool hugepage_pmd_enabled(void)
>> +static bool hugepage_enabled(void)
>>   {
>>   	/*
>>   	 * We cover the anon, shmem and the file-backed case here; file-backed
>> @@ -442,11 +442,11 @@ static bool hugepage_pmd_enabled(void)
> 
> The comment above this still references PMD-sized, please make sure to update
> comments when you change the described behaviour, as it is now incorrect:
> 
> 	/*
> 	 * We cover the anon, shmem and the file-backed case here; file-backed
> 	 * hugepages, when configured in, are determined by the global control.
> 	 * Anon pmd-sized hugepages are determined by the pmd-size control.
> 	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
> 	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
> 	 */
> 
> Please correct this.

Sure. How about:

/*
  * We cover the anon, shmem and the file-backed case here; file-backed
  * hugepages, when configured in, are determined by the global control.
  * Anon hugepages are determined by its per-size mTHP control.
  * Shmem pmd-sized hugepages are also determined by its pmd-size control,
  * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
  */

>>   	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>   	    hugepage_global_enabled())
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>> +	if (READ_ONCE(huge_anon_orders_always))
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>> +	if (READ_ONCE(huge_anon_orders_madvise))
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>> +	if (READ_ONCE(huge_anon_orders_inherit) &&
>>   	    hugepage_global_enabled())
> 
> I guess READ_ONCE() is probably sufficient here as memory ordering isn't
> important here, right?

Yes, I think so.
