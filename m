Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A040BCBB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597826; cv=none; b=UqXn66NsXwqhWOTsdsAGX1F7mZ7hg8552gnznVzo6WdVWcWUjjawvaEYq2a5+M8fQ5uUvNdJeUmv/DGdSyOsU3NfMu7M2rCC4lZ8aN0UxOaqeXTtapr4kQ4Qt8bsBJb29V8jHx3n5tBj+zqIoK74Es7CpKXXcKHqrunO+r4w0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597826; c=relaxed/simple;
	bh=+4YqdlU9chWGVXpDNbvhimmUCWjFHgBWE8aKPUtH8rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvZdC3j9XZgSmX8DDTQwUXmtviiK4JpRdJ875lJU3zGtkr7ooUCcykn/oc6cguKny04N3Hl8z8vuCZhIIDLfO5MWw9MeT8kelTZzrcN9hndv6UKCIHIfbMOqh8kg1sPfUhiOp8gg/HodX49S9Z9PsOY3QGE4xzO0C0YzNfU7VDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdJFyyTv; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdJFyyTv"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so14863355ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783597823; x=1784202623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNCN2Fdr8yqkD0LsjJkDJLi2MeWHIGyOWfhBDBuuA2k=;
        b=kdJFyyTv9j9wn6uzjHGArGdyTMCwTQoeUBdrcih13trMyWHVufhbppXjYvQwcND06L
         6qz9JI+Xr/P9C20y/MTDunUV1BMrAvjYmKE11AktUQjWne/17MJvaq2ifC2JTx1kSWfy
         4u5ke88icXKO+aBmmQfCAuYcPISKRemoEok1QS5Hb8JnD7i486PJLYdYUG3WdAdNuSpd
         1CmW9alsmoHPMioEwggDFefLA8LrOQTjlA2DWOwGF9aiBH8+vyU5x/DFEIr+XjyoG5r0
         ObUv/rO/eZxOfOkUAORPhpXVioKoX2IQL87LvUFj44gkHj2/mWNwrC5EJPlpbT4gbt4m
         LkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783597823; x=1784202623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNCN2Fdr8yqkD0LsjJkDJLi2MeWHIGyOWfhBDBuuA2k=;
        b=b4MIc22sY/+VY1nM8burmlSXQxSDFHqIbtK/m5kgkvY4EJ7tHlS0p+qVsZTyF/6wWx
         f2mOYVOet0he7kip3nWJfhPRBhYqiD3ckmgvTwKYG/fGq793F3x2PL8+7KUQWQb88OFW
         8+emclPAb7eX/BxOd/FmiehWIdsZ3tJj5qkflobSo5+WAcw4VqjZrm4z2NeRPdqJrmf3
         d5AEOCimwBKeg4+0Vm+OV4/BmNWx9l5eJkxlCrdlGvKJ/7gVnBPhDm5qigz+qpz/dlOu
         FoqT7+awGTbUFfC6UMtHAWKOwc7e0tWvUaNDQ7rgmgbVUY3CW/6lipB4eVCW51pvHa7y
         5qfA==
X-Forwarded-Encrypted: i=1; AHgh+RqjlL1DMeTNOnBlcoCGckRf9VoyyE8Wtpt6BOSGbY2Rec3+ea4Iy9M8nHtlVfaFBzn9bGijXyDEU+o7odVz6OivRCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+v4KHwDyhavIyFYGm4qXmEoAuZ7Xw5QbNd+zkZLuJU/yxW3l
	aVqA58ZaiY3zS1df8ftY3wgDSmHQiqF8jUl75eMTyxreTAEaa0WkVgAf
X-Gm-Gg: AfdE7ckZn6rLfln26vovG/fddZbN0MmxMEMNaCT0xsZhGVUpbOwFOXGcnMM4hOMwa/u
	8Dfb2hrnySkJa0h1VRcxWocj/FquSbq2rV32UJhy0w64OvhX/5uGYzquxs+y5S4CvjPMqaaOlQ2
	TAMEaxMhSocKkg6UJLcjrut0YI5L5PonN5Llnli2L8n5DQgCAepZcWpoSaLDkMcHkelPldpd9aU
	CPyUFoVTo5gNRqO8JrsEfab4OpU8CPtsHOoOnhlV5Ti8teNSixRXjMTEdl8N8vw/8xHUi/e6pYa
	yJNoR5b0LTfUn8fVPqNIdL4/3XuZicF3IgxaHy2mEmRzKg3qrOl5Y4Lc3pQsq99j/QU1M1XvDpU
	YRHhN7xC9yrFsNit6v29ZTj5ayssDEJtP4jr8GcLOyOjg1ZEKrqvHx4R5O4J3G0zKe3goj1Dt6e
	C9YKu1+JYPhsDzystebWzm
X-Received: by 2002:a17:903:2b03:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2ccf4d46d5amr50430705ad.27.1783597822781;
        Thu, 09 Jul 2026 04:50:22 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb6e2sm43597885ad.3.2026.07.09.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:50:22 -0700 (PDT)
Message-ID: <66a0b183-825d-43e8-8a03-8ab98728c153@gmail.com>
Date: Thu, 9 Jul 2026 19:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/mlock: wait for migration to finish when
 mlocking a folio
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org,
 jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-3-chenwandun1@gmail.com> <ak0C-DP_1ZrTVSLj@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak0C-DP_1ZrTVSLj@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 22:33, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 08:59:23PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> In RT kernels, sysctl_compact_unevictable_allowed is false by default,
>> when the mlock/mlockall system call try to lock all the present page,
>> the mlock_pte_range function skips non-present entries. If these
>> non-present entries are migration entries, and the migration is not
>> guaranteed to have completed before the mlock/mlockall, it may result
>> in a page fault on subsequent access, which then waits for the
>> migration to finish, causing spike latency in RT kernels.
> 
> Is this really noticable and measurable?

Alexander Krabler reported a 1.1ms latency in [1]

https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/

> 
> I suppose not too many ranges should be mock
> 
>>
>> Fix it by waiting for the migration to complete during the mlock/mlockall
>> syscall when sysctl_compact_unevictable_allowed is false.
> 
> Probably better to reference the sysctl itself rather than an arbitrary varible
> name.
Got it.
> 
>>
>> Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
> 
> Again I have no idea why you chose this as the fixes target, especially for
> this?
You're right, the Fixes tag was wrong.

Setting sysctl_compact_unevictable_allowed to zero was introduced in v5.7 by:
	commit 6923aa0d8c62 ("mm/compaction: Disable compact_unevictable_allowed on RT")

Before this commit, mlocked page can be migrated, and dont need to wait for
migration complete.

After this commit, if don't wait for migration complete, this may result in
latency spikes.

(The batch mlock feature increases the probability of hitting migration entries.)

Will update Fixes tag in next version.

> 
> But in any case, why is this separate from the previous commit? I sthis an
> entirely separate fix?

These two patches address two aspects of the same problem,
and I split them into separate patches mainly to make review easier.

Patch 1 mainly prevents pages to be migrated due to batch mlock;
patch 2 mainly ensures that pages undergoing migration have finished
migrating once the mlock system call completes.


> 
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/lkml/c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org/#t
> 
> A nit but please strip that #t.
Got it.
> 
>> ---
>>  mm/mlock.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 97e49038d8d3..ac65de40b22b 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/mm_inline.h>
>>  #include <linux/secretmem.h>
>> +#include <linux/compaction.h>
>>
>>  #include "internal.h"
>>
>> @@ -361,8 +362,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>>
>>  	ptl = pmd_trans_huge_lock(pmd, vma);
>>  	if (ptl) {
>> -		if (!pmd_present(*pmd))
>> +		if (!pmd_present(*pmd)) {
>> +			if (unlikely((vma->vm_flags & VM_LOCKED) &&
> 
> -> vma_test(vma, VMA_LOCKED_BIT)...
> 
> What is the basis for your unlikely()? Don't use likely()/unlikely() just
> because it feels right. Leave them out unless you have actual profiling data to
> prove it.
> 
> Remove it please.
Got it.
> 
> But I'm also confused here - why are you checking for VMAs that already had
> VMA_LOCKED_BIT set when you are about to set it?
> 
> Surely this shouldn't be predicated on VMA_LOCKED_BIT?
munlock also would call mlock_pte_range, if page is under undergoing migration,
munlock dont need to wait migration complete.

> 
> 
>> +			    !compaction_allow_unevictable() &&
> 
> Why do we care about compaction here? Are we assuming the softleaf migration
> entry is present only for compaction reasons?
> 
> So these migration entries could be there for any reason? Does it matter? Is it
> such a big deal, on mlock, to wait for migration entries? I think probably not.
> 
> But then maybe some weird workload gets affected... hmm.

Indeed, there are workloads that are affected by this.
In RT kernels, RT processes typically use mlock to prevent their memory from
being swapped out, and sysctl_compact_unevictable_is set to default 0 in the
RT kernels, so mlocked memory won't be migrated and won't encounter migration
entries on access.

Using compaction_allow_unevictable here is mainly to check whether the system
is latency-sensitive. In RT kernels, sysctl_compact_unevictable_is set to 0 by
default.

If there is no waiting, the migration may won't have completed by the time of
the subsequent memory access, and then we would have to wait for migration
to finish in the page fault path. Since pmd_migration_entry_wait/migration_entry_wait
has no priority-propagation mechanism, if the process executing mlock is an
RT process, this can lead to priority inversion and latency spike occurs.

> 
>> +			    softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
> 
> Use pmd_is_migration_entry()? :)
Got it.
> 
> And technically you should use pmdp_get() I think? Maybe a situation where we
> don't care/need the READ_ONCE() though.
> 
>> +				spin_unlock(ptl);
>> +				pmd_migration_entry_wait(vma->vm_mm, pmd);
>> +				walk->action = ACTION_AGAIN;
>> +				return 0;
>> +			}
> 
> This code is really disgusting, let's please not just copy/paste open-coded
> nested horror shows like this.
> 
> A good rule of thumb is if you see a bunch of code 'poking out' like this and
> certainly if you copy/paste it or something very much like it, break it out into
> a function.
Got it, will do in next version.
> 
> So:
> 
> static bool wait_for_migration(const struct vm_area_struct *vma, softleaf_t entry)
> {
>>>>> As above I'm not sure should even be checking this?
> 	if (!vma_test(vma, VMA_LOCKED_BIT))
> 		return false;
>>>>> As above I'm not sure this makes sense?
> 	if (compaction_allowed_unevictable())
> 		return false;
> 
> 	return softleaf_is_migration(entry);
> }
> 
> Then call it like:
> 
> 	if (ptl) {
> 		const pmd_t pmd = pmdp_get(pmd);
> 
> 		if (!pmd_present(pmd)) {
> 			const softleaf_t entry = softleaf_from_pmd(pmd);
> 
> 			if (!wait_for_migration(vma, entry))
> 				goto out;
> 
> 			spin_unlock(ptl);
> 			pmd_migration_entry_wait(vma->vm_mm, pmd);
> 			walk->action = ACTION_AGAIN;
> 			return 0;
> 		}
> 		if (is_huge_zero_pmd(pmd))
> 			goto out;
> 
> (etc. going *pmd -> pmd)
> 
> But we could probably do even better than that, and assuming your dubious checks
> above aren't needed, we don't even need a helper then:
> 
> 	if (ptl) {
> 		const pmd_t pmd = pmdp_get(pmd); // possibly just *pmd?
> 		const softleaf_t entry = softleaf_from_pmd(pmd);
> 
> 		if (softleaf_is_migration(entry)) {
> 			/* Wait for migration entries. */
> 			spin_unlock(ptl);
> 			pmd_migration_entry_wait(vma->vm_mm, pmd);
> 			walk->action = ACTION_AGAIN;
> 			return 0;
> 		}
> 		if (!pmd_present(pmd))
> 			goto out;
> 		etc.
> 
> And similar for the PTE stuff below.
> 
> This works because softleaf_from_pmd() (and pte) will give you a 'none' softleaf
> if the entry is not a softlaf entry. So you can unconditionally call it on a
> PMD.
Got it.
> 
>>  			goto out;
>> +		}
>>  		if (is_huge_zero_pmd(*pmd))
>>  			goto out;
>>  		folio = pmd_folio(*pmd);
>> @@ -383,8 +393,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>>
>>  	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
>>  		ptent = ptep_get(pte);
>> -		if (!pte_present(ptent))
>> +		if (!pte_present(ptent)) {
>> +			if (unlikely((vma->vm_flags & VM_LOCKED) &&
>> +			    !compaction_allow_unevictable() &&
>> +			    softleaf_is_migration(softleaf_from_pte(ptent)))) {
>> +				pte_unmap_unlock(start_pte, ptl);
>> +				migration_entry_wait(vma->vm_mm, pmd, addr);
>> +				walk->action = ACTION_AGAIN;
>> +				return 0;
>> +			}
>>  			continue;
>> +		}
>>  		folio = vm_normal_folio(vma, addr, ptent);
>>  		if (!folio || folio_is_zone_device(folio))
>>  			continue;
>> --
>> 2.43.0
>>
> 
> Thanks, Lorenzo

Thanks again.
Wandun
