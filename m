Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356169;
	b=oipl/gAVza5hY9cfYidFD3eiusXYYXb2G5BTq9rAhi+O1+mP0yRr3OMUdh4Phdhr4pcK
	 bKDyJu9xeRyZUddQcB7x3CMc2cmDXVGQYU9AQsyhkMuYX3JHdHG48i1qvpvg1KndnNkEr
	 9OC0NuZUghpMxRq4cyH2hBhEHLDxkCh5uPzMR1b0hhgIsEkmIoLZqo5M9mDT1tDtiC9d2
	 IsNYPmTzV1fy/m5PphSY9InrvLOxYr+Sv46cn5wTQkjGD7EdcTmjYZjcTOFbNELtX2FMp
	 BMOAR+tBZaFGx8fVUWPS8bPxaKpY6KkLbcUsvGWoxr9VxqVDbMYaunApf6aK21wP7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356169;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vOn3SA3m5icxLPEIC05BcLHSnMYbCzWt9LEot3Y0T+4=;
	b=sRkfJressp0NmFdF4dG9+jsDTCPu9iqFlhpOiFMw3Ply+IYEURgcQLK0yWkdY769bZOa
	 mFwFl35ERaTBuetnzqk3xTdbLovGmszAfmHBXMHmJajUqVngFz2RPLuD6L+Fj11BwvVEf
	 UToiwhJH7WW+SbC/E/pG+5qlpDIttnKWpdH2ZA1fAA8ud5OdVQMlyzBjL7nfcprautQMe
	 8WmDaa+fMKKswE9UgE92jWfOrJI84haCE8p+04PKIPyGtOgu9sGUaVYmRlgq1oF4zhRIa
	 deLe5ME+vtr1jg32Hehqn9zl1LuEc5sPs2ykiXlGLdObObf/+beikXoNf0v6+KDqVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC4606A32A;
	Fri, 30 Oct 2026 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DBC4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1ea8a96d44c11f19a56ed5b684f684d-20261030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1d264fbd-1906-46cb-aec0-e6186ebfe991,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ff0b4381b8d35bf6c4a4938273a89b8c,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1ea8a96d44c11f19a56ed5b684f684d-20261030
X-User: wangxuewen@kylinos.cn
Received: from [172.30.70.102] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <wangxuewen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1079526661; Fri, 30 Oct 2026 18:29:16 +0800
Message-ID: <0c91d172-5f6a-4328-a7af-82881b4d4f89@kylinos.cn>
Date: Fri, 30 Oct 2026 18:28:35 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm/shmem: trace swapin results and allocation
 fallbacks
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 wangxuewen_ky@163.com
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
 <1793238664825191.108.seg@mailgw.kylinos.cn>
From: wangxuewen <wangxuewen@kylinos.cn>
In-Reply-To: <1793238664825191.108.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/28 15:56, Baolin Wang 写道:
> 
> 
> On 10/27/26 5:40 PM, Xuewen Wang wrote:
>> The tmpfs swapin and allocation paths are currently a blind spot for
>> tracing: the swap layer has no tracepoints at all, the existing
>> counters cannot attribute events to a file, and an mTHP request can be
>> silently downgraded at two layers - or fail outright - with only one
>> of those having any accounting.
>>
>> On the swapin side:
>>
>> - PGMAJFAULT only accounts the page fault path; swapins triggered by
>>    read()/write()/fallocate()/truncate/symlink go through
>>    shmem_get_folio() with vmf/fault_type NULL and are not counted
>> - PSWPIN/ZSWPIN are counted at the I/O and zswap layers with global
>>    and memcg granularity, but cannot be attributed to an inode or file
>> - the mTHP order degradations in shmem_swap_alloc_folio() (uffd/zswap
>>    forced order-0, order-0 retry after sync allocation failure) have
>>    no counters at all, unlike the swapout side which counts
>>    THP_SWPOUT_FALLBACK and MTHP_STAT_SWPOUT_FALLBACK
>>
>> On the allocation side:
>>
>> - the order mask from shmem_suitable_orders() (vma filtering, page
>>    cache layout conflicts) can drop the order with no counter at all;
>>    the code comment notes that -EEXIST "would be the right code, but
>>    not here"
>> - the allocation fallback loop is counted by MTHP_STAT_SHMEM_FALLBACK
>>    without attribution
>> - a fully masked-out request fails with -ENOMEM while the caller
>>    silently retries at order 0
>> - when mem_cgroup_charge() fails with the target range already
>>    occupied, the error is rewritten to -EEXIST, making a cgroup limit
>>    event indistinguishable from a benign insertion race
>>
>> Patch 1 adds a single shmem_swapin_folio event at every return from
>> shmem_swapin_folio(): the original caller index and XArray entry, the
>> requested (entry) and actual (folio) orders, the branch taken -
>> validation failure, initial swap cache hit, synchronous helper,
>> readahead helper, or poison marker - and the return value. For the
>> synchronous helper it also records why the request became order 0: a
>> fallback bitmask reporting the userfaultfd and zswap restrictions
>> together when both apply, sync_fail plus the initial errno when a
>> higher-order attempt failed and was retried, or none.
>>
>> The fallback field is a bitmask rather than an enum because the two
>> policy restrictions are independent: a VMA can have userfaultfd armed
>> while the boot-wide zswap latch is also set. Reporting only one value
>> would hide that the other restriction must also go away before large
>> folios come back. sync_fail never combines with them - a policy
>> downgrade forces order 0 before the first attempt, so the retry that
>> sets sync_fail can only run when no policy bit was set.
>>
>> Patch 2 adds a shmem_alloc_folio_finish event with the full order
>> chain (requested/suitable/actual) separating VMA and page-cache
>> filtering from allocator fallback, a stage value (filter, alloc,
>> charge, cache, account, done) identifying where the attempt ended,
>> and both the stage errno and the returned errno: a memcg charge
>> failure stays visible as error=-ENOMEM even when a page-cache
>> conflict rewrites the return to -EEXIST. A fully filtered-out request
>> reports stage=filter with error=0 and suitable_order=-1 because no
>> allocator call occurred. Successes at the requested order - including
>> ordinary base-page allocations - are omitted, so order-0 traffic
>> never floods the ring buffer.
>>
>> shmem_swapin_folio does fire on every swapin attempt, and that is
>> deliberate: a swapin is a major-fault or I/O slow path whose rate is
>> bounded by actual swap traffic, and each event is precisely what
>> PSWPIN cannot attribute. Folio allocation is the opposite - it runs
>> for every page ever touched, "succeeded at the requested order"
>> carries no information, and it is already counted by
>> MTHP_STAT_SHMEM_ALLOC and THP_FILE_ALLOC. Hence the asymmetric
>> gating between the two patches. Both events, their fields and the
>> attempt semantics are documented in Documentation/trace/events-shmem.rst.
>>
>> Three questions answered up front:
>>
>> Why not vmstat counters?  Counters show trends, tracepoints do
>> per-inode attribution; the two are complementary, and the trend side
>> already has its counters.
>>
>> Why not eBPF/kprobes?  BPF programs attach to tracepoints, so this
>> series is an enabler for BPF rather than competition. The interesting
>> data is mid-function state (suitable_order is a local consumed by the
>> fallback loop, the fallback bitmask is an internal policy decision,
>> and the charge error is rewritten in place before the return) that is
>> not visible at any function boundary; the functions involved are
>> static and may be inlined, so kprobe scripts silently break across
>> kernel versions, while a tracepoint's fields are documented in its
>> format file and any change is visible in review.
>>
>> Why not extend trace_mm_filemap_add_to_page_cache()?  tmpfs never
>> emits it.  Its only call site is in mm/filemap.c, while
>> shmem_add_to_page_cache() runs its own XArray insertion loop with no
>> trace calls at all, so tmpfs folios entering the page cache produce
>> no filemap event.  Even if they did, it reports only the final order -
>> no requested/suitable/actual chain, no stage, no errno - and nothing
>> whatsoever for the swapin side.
>>
>> Reproduced on x86_64 (8 CPUs), kernel v7.3.0-rc3 + this series, tmpfs
>> on disk-backed swap with cgroup v1 memory limits forcing swapout
>> deterministically; zram provides the SWP_SYNCHRONOUS_IO device for
>> the synchronous path.
>>
>> Swapin attribution - three tmpfs files (400M + 500M + 150M) charged
>> to one cgroup, 965M forced out with a 100M limit, then the 400M and
>> 150M files read back with read():
>>
>>      PSWPIN +116219 pages, PGMAJFAULT +0
>>
>>      ino=2 (db_shm,    400M, read back): 102400 events - every one of
>>                                          its 102400 pages
>>      ino=3 (app_cache, 500M, untouched):      0 events
>>      ino=4 (misc,      150M, read back):  16661 events, exactly the
>>                                          pages that had left memory
>>
>> 104528 events took the cache branch and 14533 the readahead branch;
>> all carry error=0 and fallback=none. PGMAJFAULT never moved while
>> 119061 read()-triggered swapin events were recorded.
>>
>> mTHP order degradation on the readahead path - huge=always mount,
>> 512M faulted in as 256 2M folios, 414M swapped out to disk swap and
>> read back:
>>
>>      102672 events  requested_order=0 actual_order=0
>>        1656 events  requested_order=5 actual_order=0
>>        1449 events  requested_order=6 actual_order=0
>>         207 events  requested_order=9 actual_order=0
>>
>> The 3312 events with requested_order > 0 all came back order 0 while
>> fallback stays none: the readahead path returning a smaller folio
>> without any policy downgrade, exactly the case the documentation
>> describes.
>>
>> Synchronous whole-folio swapin - the same workload with zram as the
>> swap device and the zswap latch unset:
>>
>>      207 events, all path=sync requested_order=9 actual_order=9
>>
>> 207 2M folios account for the 414M that went out: with no policy
>> restriction the synchronous helper preserves the entry order end to
>> end.
>>
>> zswap policy downgrade - zswap enabled once then disabled (arming the
>> one-way latch), 128M fault-written with zram swap, 90M forced out:
>>
>>      23040 events, one per page swapped out
>>        720 events with requested_order > 0, every one fallback=zswap
>>            360 order=5 / 315 order=6 / 45 order=9, all actual_order=0
>>
>> fallback_error=0 and error=0 throughout: policy downgrades, not
>> failed attempts. The remaining 22320 events are order-0 entries that
>> had nothing to downgrade (fallback=none).
>>
>> Combined policy restrictions - a userfaultfd registered over the
>> faulting VMA plus the armed zswap latch, 158M forced out and read
>> back through the armed VMA. This is the case a single-value fallback
>> field cannot report:
>>
>>      1264 events  fallback=userfaultfd|zswap
>>          632 order=5 / 553 order=6 / 79 order=9, all actual_order=0
>>
>> The 39184 order-0 events in the same run report fallback=none: an
>> order-0 request has nothing to downgrade.
>>
>> Allocation filtering - MADV_NOHUGEPAGE 64K stripes every 2M on a
>> huge=always mount, 512M fault-written:
>>
>>      1280 events, all stage=done error=0 ret=0
>>      256 each for requested_order=9 with suitable_order and
>>      actual_order of 4, 5, 6, 7 and 8
>>
>> Not one 2M folio is allocated across the whole 512M file
>> (shmem_alloc 2M stat delta 0), yet nothing today reports why.
>>
>> Allocation failures under a cgroup limit - 300M fault-written inside
>> a 100M memory limit, 8365 events in one run:
>>
>>      1976 stage=charge  error=-12 ret=-12  memcg charge failure, the
>>                                           errno preserved
>>      1976 stage=filter  error=0    ret=-12  suitable_order=-1
>>                                           actual_order=-1, no
>>                                           allocator call occurred
>>      4413 stage=done    error=0    ret=0    cascade fallback,
>>                                           suitable_order 1 to 9
>>
>> Filesystem accounting - a 16m tmpfs mount written with 64M of 4K
>> pwrites: 24576 stage=account events, all error=-28 ret=-28, firing
>> at the block where accounting ran out; 12288 carry requested_order=9
>> (the large-folio write attempt) and 12288 requested_order=0 (its
>> order-0 retry), two events per failed write.
>>
>> Negative controls: 0 events for re-reading a file already in cache,
>> 0 with the events disabled, and 0 for a 64M plain order-0 write
>> (patch 2's volume filter).
>>
>> Not exercised at runtime: path=lookup and path=poison with nonzero
>> error, fallback=sync_fail with fallback_error (these need a failing
>> higher-order synchronous attempt or fault injection), userfaultfd
>> without zswap (the latch is one-way per boot and was already armed
>> for the combined test), stage=alloc with a real allocator failure,
>> and stage=cache (a concurrent insertion race). Everything quoted
>> above was observed on the target machine.
> 
> Sorry, I'm not a fan of adding such tracepoints without any real use 
> cases in production to show which data is truly useful. And as you 
> mentioned, eBPF can do most of the data tracing.
> 
> Moreover, I don't think shmem is special. I don't want shmem to have its 
> own swapout/swapin tracepoints while anonymous memory has its own 
> swapout/swapin tracepoints. If there are swap related tracepoints that 
> are actually needed, they should be considered together as proper 
> interfaces.
> 
> Finally, tell your LLM to simplify the cover letter.
Hi Baolin,

Thanks for your feedback.
After thinking it over, I agree with you. I was only looking at the 
issue from the shmem side previously, which was indeed one-sided. The 
swapin paths for anonymous memory and shmem are essentially the same 
problem.

I didn’t explain the eBPF part clearly. What I meant is that the order 
policy and demotion decisions are handled inside these functions and not 
exposed externally, which imposes certain limitations on eBPF.

If feasible, I plan to consider both anonymous memory and shmem going 
forward, unify the logic, and provide a common interface.

I also note that the cover letter was too long. I will keep this in mind 
for future submissions.

Best regards,
Xuewen
