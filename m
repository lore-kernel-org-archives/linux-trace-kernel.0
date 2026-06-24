Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53A2EC09B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299300; cv=none; b=TyoRx8l4NvO6enMgC1NRDvhWHTB4BrDfZM2xGRv+KTfNfcFAQTMNNFo/IwMP8okfAyJdLsKyrNm+soCiiEygJ9iwaV19p8PxTEPgpVyzWPqfEs4Ziz5NSt1sKCm4W4rnRPQLAfUQw55zUu2Lv8MjgRfUwdnSE9+/XgnFmTxLZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299300; c=relaxed/simple;
	bh=IoBEiolJATWxZV1vpooXXrlpswz8LM+XlrdVTKXE2U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWGiQIid1NNxtVBeXM5Ge8rJGpYhpbyJbRGAQWbur3KX9xWM/dst3P3bxpL8JMlUMF1hccCotn8XAefSJ58lCZt6/MQyCTBUA+YoSTl4g4d+vHCGP/XU7Qq/XmbabDLCicsy2l3luzMHuli6uKZ3N7slJwr8cCHiMd7uaCm3hTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZJUu+58; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZJUu+58"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8423610ec93so1025844b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782299297; x=1782904097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXtuRuNUX2Rp2ayyKmvIq6nuFd+B5mhsEfkXh3sxMRw=;
        b=JZJUu+58fOy0l45aJnUx1/Pv0UlrQyCGFlJ0W4bXYZ9bb6LNsnasMv1T3kb8Ifn8Mo
         TuODECwCe3KY/lhVtb5U19SDQdcKjBkitB6Vvs/AjcblAxN3GyyYcgDiGdh4HSRBhBL4
         +5jrv5WunsxYRnzJ4jsxTWyUVyzKq/H6sQ7tPk03Om884Eew+vIhkNLqegVo8LuB95SH
         h3DQIlUpmKLq57Wem5xAg62CpB3Sb6yJvJxVX/1eajiOz2Vp1x0CHYhUooGhe1kya02b
         Cwv3LO6NgTduxJlDDfa18hH1UGIvwqORJdULCDnx4M5Xl/LscRvMpGjKlvhdFlZRUeUC
         QqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782299297; x=1782904097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXtuRuNUX2Rp2ayyKmvIq6nuFd+B5mhsEfkXh3sxMRw=;
        b=XoiBQGMux+z4dJHuqfVzxpx78o7O3V628uoXPNI15sOF8hT4bTyBZ5krEqGEEPCOtk
         WFpuMzLSAvg1iEOmjobYoMLwX32+Ym9GL76IofGcSzYueEMPoOVszn7mqzlGcjJ6t8mt
         BpYYX3vV/hKECpCHTqbPy5qTB4iVC60N9UFpi3KPQvXZAbNIzlJK3b+FmlLYrViN+ac/
         D3U2olgBc5DznbnwVFlcf0UVvF580wdYuIlpINGdvFOVmDpBu+Wl1E5KWfScif4kwHZu
         QXU+XTTZ+sxndYCjdsbhvUuWjZtpAs1O6OppT1MqpyR6bkS59pIxdz+/VNmZPYcWEc0J
         dOcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DN8SyCYA2Kbzlv2fb+UDw3HrpjHdEeK2WmJCoHrFsf9WlVmmDOy0FiHANOjRataQvztc25+MJ2AoMMjqiBpsteJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysx3q+mJYfKAwwX1FKBJssYvwvVo7zt5nZBBw9zHUy/YHRJiKF
	uQP7eIXPqX8AuY4abP4zTNgT7nkXW7WA7S5o3f8raXUHMsrULuMmor8D
X-Gm-Gg: AfdE7ckedqjjhA6kmAXx0gZ0VDyx4lx/k+FhS2AWw4eu4t59TxV0tsl+7XO2myV33h2
	90Z9H3relwIHabMN4xi1WZZz1c0bVvk9UbYZD/Y3++QTv74dfWvXB7qLTghDmkr9f+qXUDlKkNj
	hMWS9MEn65dI/WwNjCD7cv4E3a0VGMUboFHbjMSbrntQWukCBGao9Aw4kd6C37UI4btsAS+Jv7z
	Jx3CXjW+eAeQv5MzGdJCm5QVvM9dPf+bOLSRML8Tj2COkpWr+jahpQcyX+ouaQWScbJAOwsxBuR
	tBEg1F/Zcq+EJ4UChjanIGzrFCMsuDueiInHDt9bsBT0IYradpQpNrwxtBVLnQ426im7Ey9c6BC
	gZf1oAILtiQud+5TN17J1v7Odz8GHHKSoFXyh4uV/orwNx+J6yoISIQ6trf0pgw0A7J5ml3zCUB
	MakFa7EL4JMRufZ1/nERFK
X-Received: by 2002:a05:6a00:a112:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-845a2ae22e4mr3475551b3a.13.1782299296908;
        Wed, 24 Jun 2026 04:08:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4002c51sm1926735b3a.27.2026.06.24.04.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 04:08:15 -0700 (PDT)
Message-ID: <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
Date: Wed, 24 Jun 2026 19:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/26 17:55, Vlastimil Babka (SUSE) wrote:
> On 6/18/26 13:43, Wandun wrote:
>>
>>
>> On 6/18/26 02:52, Vlastimil Babka (SUSE) wrote:
>>> On 6/4/26 04:38, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> compact_unevictable_allowed is default 0 under PREEMPT_RT,
>>>> isolate_migratepages_block() skips folios with PG_unevictable set.
>>>> However, mlock_folio() sets PG_mlocked immediately but defers
>>>> PG_unevictable to mlock_folio_batch(), result in a folio with
>>>> PG_mlocked=1 but PG_unevictable=0. Compaction will isolate such a
>>>> folio.
>>>>
>>>> Fix by checking folio_test_mlocked() together with the existing
>>>> folio_test_unevictable() check.
>>>>
>>>> A similar issue has been reported by Alexander Krabler on a 6.12-rt
>>>> aarch64 system. Vlastimil suggested to check the mlocked flag [1].
>>>>
>>>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>>>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
>>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
>>>
>>> Well in that thread, Hugh doubted my suggestion and then it seems we didn't
>>> concluded anything. Did you actually in practice observe the issue that
>>> Alexander had, and that this patch fixed it, or is that theoretical?
>>>
>> Yes, I wrote a test case that can reproduce it in a few second.
>>
>> The test case contains 3 steps:
>> 1. mlockall
>> 2. mmap file(2GB) + trigger file write page fault;
>> 3. during step 1, trigger compact via /proc/sys/vm/compact_memory
>>
>>
>> My reproduction environment is qemu with 4GB ram, 8 core, aarch64,
>> preempt_rt and includes the tracepoint in patch 02.
>> After running the reproduction program for a few seconds, the
>> following output appears.
> 
> Ah, nice.
> 
>> repro-403     [004] ....1   101.270505: mm_compaction_isolate_folio: pfn=0x71e3a mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270507: mm_compaction_isolate_folio: pfn=0x71e3b mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270513: mm_compaction_isolate_folio: pfn=0x71e3c mode=0x0 flags=referenced|uptodate|mlocked
>> repro-403     [004] ....1   101.270515: mm_compaction_isolate_folio: pfn=0x71e3d mode=0x0 flags=uptodate|mlocked
>> repro-403     [004] ....1   101.270517: mm_compaction_isolate_folio: pfn=0x71e3e mode=0x0 flags=uptodate|mlocked
>> repro-403     [004] ....1   101.270520: mm_compaction_isolate_folio: pfn=0x71e3f mode=0x0 flags=uptodate|mlocked
>>
>>
>> Unfortunately, I recently found that there is still a bug in the
>> fix patch. Setting mlocked in the mlock_folio function could happen
>> even after the page is successfully isolated, so it still cannot
>> prevent migration. Because of this, I need to think more about how
>> to fix it.
>>
>> Perhaps we should double-check whether the page is mlocked during
>> the actual migration phase.
> 
> So IIUC the isolation+migration might be started between the folio is
> allocated, and mlocked? In that case the check during migration could still

Yes, in that case it still be racy, it is not a good idea to check page flags.

> be racy, and if the page is isolated, it's already bad for the RT process.

IIUC, more accurately, the migration entry in the page talbe is real a bad for
RT process, because isolate page doesn't modify the page table, so memory
access continues as usual, therefore a new idea occur.

S1. In the mlock[all] syscall, if mlock_vma_pages_range hit a migration entry,
    then, it should wait for the migration to complete.

S2. During the unmap phase of memory migration, prevent a page from being unmapped
    if the page's associated vma is markd with VM_LOCKED, similar to how reclaim is
    disabled for pages in a VM_LOCKED vma(try_to_unmap_one).


For a page handled during the mlock[all] syscall:
  - if migration has been already finished, there is noting to do;
  - if migration is in progress and the migration etnry is already filled, we
    wait (S1)
  - if the page is in-fight, going to be isolated/migrated, S2 prevents the unmap.

For a page handled during a page fault: VM_LOCKED is already set on the vma,
so S2 guarantees it will not be unmapped, hence no migration entry.


Thanks a lot for the detailed feedback, Vlastimil.

Best regards,
Wandun


> 
> So this would only be a short-term problem after the mlockall, but we don't
> have a way for the RT process to know the moment it's all settled, right?

Yes, some pages may have been isolated and will do migration.

> Probably the proper solution would be for mlock[all]() itself to wait for an
> isolated page, and only continue once it knows it can't be isolated anymore.
> This might howver would go against some of the folio batching optimizations?
> 
>> What do you think of this best-effort approach?
>>
>>
>> Best regards,
>> Wandun
>>
>>
>>
>>
>>
>> The full reproducer is as below:
>>
>> /* gcc repro.c -o repro -lpthread */
>>
>> #define _GNU_SOURCE
>> #include <fcntl.h>
>> #include <pthread.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sys/mman.h>
>> #include <unistd.h>
>>
>> #define PAGE_SIZE       4096
>> #define NR_PAGES        32
>> #define FILE_SIZE       (2ULL * 1024 * 1024 * 1024)
>>
>> static void *worker_fn(void *arg)
>> {
>> 	int fd = (long)arg;
>> 	size_t len = (size_t)FILE_SIZE;
>> 	char *p = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> 	if (p == MAP_FAILED)
>> 		return NULL;
>>
>> 	for (size_t off = 0; off + NR_PAGES * PAGE_SIZE <= len;
>> 	     off += NR_PAGES * PAGE_SIZE) {
>> 		for (int i = 0; i < NR_PAGES; i++)
>> 			p[off + i * PAGE_SIZE] = 1;
>> 		usleep(200);
>> 	}
>>
>> 	munmap(p, len);
>> 	return NULL;
>> }
>>
>> static void *compact_fn(void *arg)
>> {
>> 	(void)arg;
>> 	int fd = open("/proc/sys/vm/compact_memory", O_WRONLY);
>> 	if (fd < 0)
>> 		return NULL;
>>
>> 	while (1) {
>> 		if (write(fd, "1", 1) < 0) {}
>> 		usleep(5000);
>> 	}
>> }
>>
>> int main(void)
>> {
>> 	mlockall(MCL_CURRENT | MCL_FUTURE);
>>
>> 	int fd = open("./repro_largefile.dat", O_RDWR | O_CREAT, 0600);
>> 	if (fd < 0)
>> 		return 1;
>> 	unlink("./repro_largefile.dat");
>> 	if (ftruncate(fd, (off_t)FILE_SIZE) < 0)
>> 		return 1;
>>
>> 	printf("repro_largefile: 1 worker, %d pages/batch, Ctrl-C to stop\n",
>> 	       NR_PAGES);
>>
>> 	pthread_t compact, worker;
>> 	pthread_create(&compact, NULL, compact_fn, NULL);
>> 	pthread_create(&worker, NULL, worker_fn, (void *)(long)fd);
>>
>> 	pthread_join(worker, NULL);
>> 	return 0;
>> }
>>
>>>> ---
>>>>  mm/compaction.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index b776f35ad020..7e07b792bcb5 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>>  		is_unevictable = folio_test_unevictable(folio);
>>>>  
>>>>  		/* Compaction might skip unevictable pages but CMA takes them */
>>>> -		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
>>>> +		if (!(mode & ISOLATE_UNEVICTABLE) &&
>>>> +		    (is_unevictable || folio_test_mlocked(folio)))
>>>>  			goto isolate_fail_put;
>>>>  
>>>>  		/*
>>>
>>
> 

