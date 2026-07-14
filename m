Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125D3DDDB3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010538; cv=none; b=tzM0XuaxTLMOeIskbx9giSJb6p68PjrQUKrvCjHmnQRIdrTOt/o3Li6tPPOeYDN9kxtLFtfx3bEjZHu7q8RHXb4gH+lRMt2SSc6fx81ioT4rZVWl1CU9U7v9ydrpvFqn0pXVClEeqecu62hVw6HxRBR8xmKZoPxj4XL4XNLau0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010538; c=relaxed/simple;
	bh=LtoHqTPBK0DX3WOwAFsacl5nrZHuMpGDYyECsc/nNHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRxxYLeJI3U4qjo1kV5Pt1FeEyYR8c7mrrPzQY5qtiuN+0FLj8P3gx9OPTlyxgbNUq5VoQGke0KJSNhIq0lLaSaG4sOUbNRGtb2i8+601h5/o0oHUBXCer4LM7a9H9PqYYej9lKG4KpvkdMMCDZhBauccim7WumdC5IzleEIFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYVpKfHv; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYVpKfHv"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cab1b0bb489so424421a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784010535; x=1784615335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crd7Xg7SoeCwZRC39cwMbg/cTdFhUS9QG4xnLU9ZNdk=;
        b=AYVpKfHvD+A5aZB/GjDv0hPtE2oNHVuszexIOA3Kwbv+UsAYAE5mUnji6NJpjPi5V0
         rfbuvmsHzldUh+BQsluw6vcoGeXLX+Muv3oMSdl8lWvzYYShLAjzbTzUrY8ylUpzIs02
         75kaH5g4mhvp+eYdTJGhbtWkKuZpD0wzmXfRtIeeZUMhzTg8VeoaemU9qQ7zZecxLhwz
         tS24qX+iU5IXVcpEasEyMtBDef4sbWDG04qjN4BIkhz82fIswu6bxaVlyVwexwPIw15N
         bVTijKesgkwi5YjqbjcuRFOu9TcHVHRwQuOsVfEtWL/wo6zx+6N1oUKDZ7tc6G1x/NhG
         PFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010535; x=1784615335;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crd7Xg7SoeCwZRC39cwMbg/cTdFhUS9QG4xnLU9ZNdk=;
        b=ibST0PRphsotCQcPJdQBhvPkQbzFkse4+yfifSRihnluwnBvus6mExseonXynvDwZ3
         668GZjCEi6x4bQEKsz0R2eH7JoEVx4eQEDEztBnIgjEh37ZNKYeARFBOWBHLcMU99KQr
         YZexnezSrVWiBfSj28+JYS6Q/Q2gQ/0j5e0hVjFK5+l9UthNm6GMoLPKefryaUnLgyI+
         9w/+ZsqzsUCsIOq+U3BIo2Ls3egFkwAY1cYIzkANumZG7uwbBajmrkvuiimI18jRc/LS
         As9hszEZAURkGdYfZzmqPOq3DWmhQh6N8k3KrVpGX9VZFXmh7cE4oeZJfLUHXQnNKsQn
         /NUQ==
X-Forwarded-Encrypted: i=1; AHgh+RquNgo6IpaxDrvj3elYAVMa/DIeKSF/06XWLx1wBnq54OY25bpF1eYimG+HrUKR9Bxf7OrDrWNdrbkxMvq2Su28dZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZI6VelokgsqDqVpFxO4iUyzRr0a5bp5DapsyI50IIMNol8N7
	Ubj9/opZZ94PDMgebnU4zmJYTOzfllhad8hiAIECMBz2F+wUKzPAkTeQ
X-Gm-Gg: AfdE7clrUW8yHFvWHZr9HdhpeBPgYUlRsWG39fK9wClnaZoH76+NBEhWeF/Q/2ncIV/
	Mpn3cq8UfNBOJzbeXUUHgTg6wYRouPGKB2F4mFe1Rb8BndBKQdfgpi1sFgNkKVxwxyBcbVER4w6
	B6QZg84nn/pGfvDtcZ24Ha82nBmkPTLTTSss3rSa5ble+Y/2oC1Ed2FG+A/a9xLc0wjBzmrGO0p
	H8CKXU2JmOKTe+3tHd1/VH8NBqTgnhOuoWiIF+jGqAOoM5oADWuJbqvFWFLkvoJe/GlK4b5DHDC
	2PfZG/l16El2TEFidJ+UAy9DKeIQoqPt53sydqYi9ZgLbeygGmV6yRAzUcJntl89T/1zTUlO/W2
	9Ah//nQkmrt9rCUXs8aR3Vmp2EpEXTCvxrKulmH1Uux481SsVYFtDsFHf7fs7tqgZkmqrj1t8pE
	2hDVfuRqDvrjxSTTK774p6
X-Received: by 2002:a05:6a00:1398:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-84889649003mr11827641b3a.32.1784010535341;
        Mon, 13 Jul 2026 23:28:55 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dc8e7sm902307b3a.47.2026.07.13.23.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:28:54 -0700 (PDT)
Message-ID: <0e597d80-e115-490e-af69-f84ad1c0588e@gmail.com>
Date: Tue, 14 Jul 2026 14:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <ljs@kernel.org>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 riel@surriel.com, liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com> <akz7ythMxfIZeT0d@lucifer>
 <c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com>
 <6A08B6C8-E94C-4690-A29E-B9A0DAFE19EF@nvidia.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <6A08B6C8-E94C-4690-A29E-B9A0DAFE19EF@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/26 00:10, Zi Yan wrote:
> On 8 Jul 2026, at 23:31, Wandun wrote:
> 
>> On 7/7/26 21:44, Lorenzo Stoakes wrote:
>>> (Being really nitty, your subject line is too long)
>>>
>>> Please don't reference legacy VMA flags for newer patches 'do not migrate
>>> folios mapped into mlocked VMAs...' works just as well.
>> Got it.
>>>
>>> On Tue, Jul 07, 2026 at 08:59:22PM +0800, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> When compact_unevictable_allowed=0, unevictable pages should not be
>>>> migrated. However, mlock_folio_batch in the mlock[all] syscall introduces
>>>> a race, mlock_folio() sets PG_mlocked immediately but defers PG_unevictable
>>>> to mlock_folio_batch(), causing pages that are about to become unevictable
>>>> to be migrated, which violates the intent of compact_unevictable_allowed,
>>>> and causes spike latency in RT kernels [1].
>>>>
>>>> In order to fix this, migration is forbidden for pages mapped into VMAs
>>>> marked with VM_LOCKED. In addition, two early-return paths are introduced,
>>>
>>> Please don't reference legacy VMA flags. -> VMA_LOCKED_BIT.
>> Got it.
>>>
>>>> filter out mlocked pages, return early to avoid unnecessary operations.
>>>>
>>>> Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
>>>
>>> Hmmmm why do you think my patch caused this? That was just a folio conversion?
>>
>> Oh, I made a mistake, your patch was just a folio conversion.
>>
>> Batching mlocked page was introduced in v5.18 by:
>> 	commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
>>
>> Setting sysctl_compact_unevictable_allowed to zero was introduced in v5.7 by:
>> 	commit 6923aa0d8c62 ("mm/compaction: Disable compact_unevictable_allowed on RT")
>>
>> So this issue exist after v5.18.
>>
>>>
>>> Also I didn't think we liked having fixes spotted about a series with non-fixes
>>> tags?
>> Got it, will split this series in next version.
>>>
>>>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>>>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/ [1]
>>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> Link: https://lore.kernel.org/linux-rt-users/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/#t
>>>> ---
>>>>  include/linux/compaction.h |  6 ++++++
>>>>  include/linux/rmap.h       |  3 +++
>>>>  mm/compaction.c            |  8 +++++++-
>>>>  mm/migrate.c               | 23 +++++++++++++++++++----
>>>>  mm/rmap.c                  | 12 +++++++++---
>>>>  5 files changed, 44 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>>>> index f29ef0653546..04e60f65b976 100644
>>>> --- a/include/linux/compaction.h
>>>> +++ b/include/linux/compaction.h
>>>> @@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>>>>  extern void __meminit kcompactd_run(int nid);
>>>>  extern void __meminit kcompactd_stop(int nid);
>>>>  extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
>>>> +extern bool compaction_allow_unevictable(void);
>>>
>>> Don't use extern. We remove extern as we go it's not needed.
>> Got it.
>>>
>>>>
>>>>  #else
>>>>  static inline void reset_isolation_suitable(pg_data_t *pgdat)
>>>> @@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
>>>>  {
>>>>  }
>>>>
>>>> +static inline bool compaction_allow_unevictable(void)
>>>> +{
>>>> +	return true;
>>>> +}
>>>> +
>>>>  #endif /* CONFIG_COMPACTION */
>>>>
>>>>  struct node;
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 8dc0871e5f00..359c7426b6b9 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -102,6 +102,9 @@ enum ttu_flags {
>>>>  					 * do a final flush if necessary */
>>>>  	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>>>>  					 * caller holds it */
>>>> +	TTU_RESPECT_MLOCK	= 0x100,/* leave VM_LOCKED vmas mapped instead
>>>
>>> -> VMA_LOCKED_BIT please. Also maybe just say mlock'd?
>> Got it.
>>>
>>>> +					 * of installing a migration entry
>>>> +					 */
>>>>  };
>>>>
>>>>  #ifdef CONFIG_MMU
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index f08765ade014..5d256930e389 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>>  		is_unevictable = folio_test_unevictable(folio);
>>>>
>>>>  		/* Compaction might skip unevictable pages but CMA takes them */
>>>> -		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
>>>> +		if (!(mode & ISOLATE_UNEVICTABLE) &&
>>>> +		    (is_unevictable || folio_test_mlocked(folio)))
>>>
>>> Maybe just change is_unevictable to include this check?
>>>
>>> Like:
>>>
>>> 	is_unevictable = folio_test_unevictable(folio) ||
>>> 		folio_test_mlocked(folio);
>>>
>>> ?
>> Sounds good, I'll fold mlock into is_unevictable so both checks
>> stay consistent.
>>>
>>> Also later you have:
>>>
>>> 		if (((mode & ISOLATE_ASYNC_MIGRATE) && is_dirty) ||
>>> 		    (mapping && is_unevictable)) {
>>> 		    	...
>>>
>>> Which doesn't account for mlock as-is? Is that correct?
>> IIUC, The is_unevictable check here mainly serves as a cheap pre-filter
>> for inaccessible mappings (which are always unevictable folio).
>> It's unrelated to the mlock.
>>
>>>
>>>
>>>
>>>>  			goto isolate_fail_put;
>>>>
>>>>  		/*
>>>> @@ -1898,6 +1899,11 @@ typedef enum {
>>>>   * compactable pages.
>>>>   */
>>>>  static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
>>>> +
>>>> +bool compaction_allow_unevictable(void)
>>>> +{
>>>> +	return sysctl_compact_unevictable_allowed;
>>>> +}
>>>
>>> You add this helper but isolate_migratepages() still references
>>> sysctl_compact_unevictable_allowed directly?
>> I'll route that reference through compaction_allow_unevictable()
>> in next version.
>>>
>>>>  /*
>>>>   * Tunable for proactive compaction. It determines how
>>>>   * aggressively the kernel should compact memory in the
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index a786549551e3..3a15eb13e82b 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1202,7 +1202,7 @@ static void migrate_folio_done(struct folio *src,
>>>>  static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>  		free_folio_t put_new_folio, unsigned long private,
>>>>  		struct folio *src, struct folio **dstp, enum migrate_mode mode,
>>>> -		struct list_head *ret)
>>>> +		struct list_head *ret, enum migrate_reason reason)
>>>>  {
>>>>  	struct folio *dst;
>>>>  	int rc = -EAGAIN;
>>>> @@ -1210,6 +1210,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>  	struct anon_vma *anon_vma = NULL;
>>>>  	bool locked = false;
>>>>  	bool dst_locked = false;
>>>> +	enum ttu_flags ttu = 0;
>>>
>>> You reference ttu only in an if-block below no? So why are you declaring
>>> this here? Move it to the if-block.
>> Got it. I'll move it to the if-block in next version.
>>>
>>>>
>>>>  	dst = get_new_folio(src, private);
>>>>  	if (!dst)
>>>> @@ -1249,9 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>  		folio_lock(src);
>>>>  	}
>>>>  	locked = true;
>>>> -	if (folio_test_mlocked(src))
>>>> +	if (folio_test_mlocked(src)) {
>>>>  		old_folio_state |= FOLIO_WAS_MLOCKED;
>>>>
>>>> +		if (reason == MR_COMPACTION && !compaction_allow_unevictable()) {
>>>
>>> This should really be a helper since you repeat yourself and it's not
>>> obvious what this is checking.
>>>
>>> Like:
>>>
>>> 	static migrate_mlock_allowed(enum migrate_reason reason)
>>> 	{
>>> 		/* Only compaction is disallowed. */
>>> 		if (reason != MR_COMPACTION)
>>> 			return true;
>>>
>>> 		/* If we can compact unevictable folios, we are ok. */
>>> 		if (compaction_allow_unevictable())
>>> 			return true;
>>>
>>> 		/* Conservative: if any folio could be mlock()'d, disallow. */
>>> 		return false;
>>> 	}
>>>
>>> Then you could self-document what you're checking and avoid code duplication below.
>> Got it, it is more clear, thanks.
>>>
>>>> +			rc = -EBUSY;
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	if (folio_test_writeback(src)) {
>>>>  		/*
>>>>  		 * Only in the case of a full synchronous migration is it
>>>> @@ -1324,7 +1331,14 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>  		/* Establish migration ptes */
>>>>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>>>>  			       !folio_test_ksm(src) && !anon_vma, src);
>>>
>>> Useful to convert VM_BUG_*() -> VM_WARN_*() (possibly _ONCE() here also) as we go!
>> Got it.
>>>
>>>> -		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
>>>> +
>>>> +		if (mode == MIGRATE_ASYNC)
>>>> +			ttu |= TTU_BATCH_FLUSH;
>>>> +
>>>> +		if (reason == MR_COMPACTION && !compaction_allow_unevictable())
>>>
>>> See above about deduplicating.
>>>
>>>> +			ttu |= TTU_RESPECT_MLOCK;
>>>
>>> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
>>> being compaction here.
>> Right, we only know about the reason.
>>>
>>> But I'm confused anyway. We have the folio, why aren't we just checking for
>>> PG_mlocked() here instead of getting the rmap to see if it's mapped
>>> anywhere with VMA_LOCKED_BIT?
>>
>> There was a race scenario without patch 02, vma may already marked with
>> VMA_LOCKED_BIT but folio has't marked with mlocked, such as below:
>>
>>
>> CPUA: mlock()                                  		CPUB: compaction / migration
>>
>> mmap_write_lock()
>>     mlock_fixup set VM_CLOKED
>>     mlock_pte_range
>>     	mlock_folio(page N)
>>
>>                                              		isolate page N+50 (mlock hasn't reached it)
>>                                             		migrate_folio_unmap
>>                                        			folio_test_mlocked() --> false, but VMA:VM_LOCKED
>>                                        			try_to_migrate()
>>                                          			rmap_walk(P) [anon_vma rwsem / i_mmap_rwsem, read]
>>                                            			try_to_migrate_one -->install migration entry
>>         ...reaches page N+50
>>         skip migration entry (without patch 02)
>> mmap_write_unlock()
>>
>>
>> access page N + 50 --> wait for migration complete
>> 							
>> 							migrate_folios_move
>> 							....
>>                                              		migrate complete
>>
>>
>>
>> If apply patch 02, mlock itself will wait migration complete, so checking
>> VMA_LOCKED_BIT in the rmap path is no longer necessary, but this logic is
>> retained to avoid unnecessary migration operations.
>>
> 
> For this race condition, since VMA has VM_LOCKED_BIT set, maybe you can
> extend rwc->invalid_vma semantics to return 1:SKIP, 0:OK, -1:STOP.
> Then install an invalid_vma function when !compaction_allow_unevictable().
> The invalid_vma function returns -1:STOP for any vma with VM_LOCKED_BIT set.
> __rmap_walk_file() and rmap_walk_anon() will need to break when -1:STOP
> is returned.

Hi Zi Yan,

Thanks for the suggestion, I really like this approach.
Adding a TTU flag and the corresponding check in the rmap logic does
make the code more complex. With the addition of STOP logic, the
entire patch becomes very clear and readable.

Hi, Lorenzo, would you be happy with Yan's invalid_vma STOP extension?
I'm inclined toward the this since it removes the new flag and reads
more clearly.

Best regards,
Wandun
> 
> This approach will not require a new TTU flag, although it requires more
> code changes.
> 
> Best Regards,
> Yan, Zi

