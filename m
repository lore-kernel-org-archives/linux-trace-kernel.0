Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530851;
	b=UB3VRxvlbxAJz0kNJos4v09/e9JA4jSsxxbRYNZsg5L3tsRAqyEsPw9714BUY2IV7XtC
	 IUwgSi1x+QBo9D45LLGlahH0b9Mtdb4o9SzzyxnY1JDGjIJ8c3p3ESY1stj3JTT2eQI2X
	 /l9MxpIgKlhrHRpZ7i0B3YXnMb/Jp6s2N4NMJwnwMTvknws4b20Tqbovmp0/ljgUJO2Af
	 +YbxuRHvvp5zrIvQPJqK+ivXaMw61HmcSplbT0PkZNWLESMLYRf/KV305wgHPr2/X3bre
	 939YrbHNKtvRdVzhEUdE8TbiyebAwNSSQemP1Nam/U83RWF1W3KUrwAAZyb9N2KvAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530851;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=d+OmU1VU579id6zin8obBb2cLrIhplvEdrcBOIeNOAg=;
	b=cEf6g4Pmf+YYNAOJBz9WT69EOjRADwBdEKv6mmaCdKP2oAcFOSbSJtdE9/zDrFUdB/MD
	 UZEacxwAT9YyXjdLyKoKq7tBI5pThLCPnsQzsFEslhwF8JYx9xU8N7hgDros6Rnzwj3Rn
	 B7KUYpgh6e/d3RZGC++Y1BrRuxLJlWsJJmcPfNakO660SWcwalBMPWdJNQ250KRXecSBy
	 2E2Y8EmukbNY3zhE4Cf02/M2UoA1JQvklKdR3imZsIyLMz4i7SMpO88cQsF+wdxCsdIIM
	 10dLmdsvXidPXllxMiU2b/ZPtCkanigtznTX+rDqMgLwGzwx6XMJFxErAbdfKfuQk+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4qpasIY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91629606A325;
	Sun,  1 Nov 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4qpasIY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4410D1F000C1;
	Sun,  1 Nov 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530851;
	bh=d+OmU1VU579id6zin8obBb2cLrIhplvEdrcBOIeNOAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k4qpasIYpQSby9KowkAKbK/aQ8DCK+rwyfbVBH4Tr1eI++KO46zFbaldOfjk/IJDN
	 SJtj+Vzn0hZnD392eSukon0D6rgsPJlAU3zJgwxAHrL+TPAHnVSqib8G5Xtpo1KioG
	 lF2t+Sw9s/sL4AyrIXEt26O1UMqG1tThJsJeDD8e2Rb70GcDUw29jzcDf8OzBSMehB
	 wHTBnTvzmrpRjtNq9z788PyC4Cd8dkYAoRiJ9dUjbDGOr9o0AvWsWQQsibeF96G9zU
	 2/UWOe74wRshH+Pi5/eEgupfrIk/GOrE2Et4mB6oskh0ofbqkubpJ9TD0U9LjRT/n0
	 lqtNz0go9cHSg==
Message-ID: <c159c1f9-34ff-41dc-a7ec-9a147a24d1e8@kernel.org>
Date: Sun, 1 Nov 2026 12:00:41 +0100
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
Subject: Re: [PATCH v5 0/12] mm: fix allocator races with memory hotplug
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, rientjes@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
 osalvador@suse.de, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, brendan.jackman@linux.dev,
 hannes@cmpxchg.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, Bessel.Wang@huawei.com, jiang.liu@huawei.com,
 mgorman@techsingularity.net, anshuman.khandual@arm.com
References: <20261101021340.2251928-1-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 03:13, Gregory Price (Meta) wrote:
> Memory hotplug rebuilds zonelists in place while allocations walk them,
> and offlining an emptied zone frees pagesets the vmstat worker can still
> hold.
> 
> These eleven fixes cover the walkers that crash, fail, or pick the wrong
> zone or node as a result, and a twelfth patch removes a helper that
> invites the same bug.
> 
>    1. a restarted slowpath loses its retry with reserves
>    2. offlining an emptied zone frees pagesets still in use
>    3. the reclaim_retry_zone tracepoint rereads a zoneref slot
>    4. the zonelist retry is compiled out without MEMORY_HOTREMOVE
>    5. zonelist_zone() may load its slot more than once
>    6. NULL preferred zone after a shrink rebuild
>    7. __next_zones_zonelist() rereads a slot
>    8. allocations land outside their zone or nodemask
>    9. the hugetlb pool walk takes another node's page
>   10. alloc_contig_pages() takes a range outside its filters
>   11. mempolicy_slab_node() rereads a slot
>   12. zonelist_node_idx() invites the same double read
> 
> Patches 1-11 are for stable.  Patch 12 is a cleanup and is not.
> 
> Patches 8-10 need patch 4, without which their retry is compiled
> out on HOTREMOVE=n kernels.
> 
> Patch 8 needs patch 1.
> 
> Patches 6, 7 and 11 need patch 5, which makes zonelist_zone() read
> the slot once.  Patch 12 needs patches 7 and 11, which remove the
> other callers of zonelist_node_idx().
> 
> Patches 2 and 3 are patches from anthropic, pulled in from Vlastimil's
> series to keep the backport issues self-contained on the series.
> 
> Testing
> =======
> 
> Each race was reproduced on unmodified source in a QEMU guest with three
> NUMA nodes and a 512M pc-dimm on node 1, left offline at boot.
> 
> A test module widens each window with a kprobe that stalls one CPU inside
> it, as an interrupt or a vCPU preemption would.
> 
>        base                            this series
> patch  outcome                  runs   outcome                  runs
> =====  =======================  =====  =======================  =====
>  1     NULL returned            3/3    page from reserves       3/3
>  2     UAF                      6/6    no UAF                   3/3
>  3     NULL dereference         3/3    allocation succeeds      3/3
>  4     allocation fails         3/3    waits for the rebuild    3/3
>  6     NULL dereference         3/3    ZONE_NORMAL page         3/3
>  7     NULL dereference         3/3    ZONE_NORMAL page         3/3
>  8     wrong zone or node       18/18  right zone and node      18/18
>  9     page from node 1         3/3    page from node 2         3/3
> 10     1G page in ZONE_MOVABLE  3/3    1G page in ZONE_NORMAL   3/3
> 11     NULL dereference         4/4    keeps allocating         3/3
> 
> 
> Cost (these tests were run on v4, v5 hasn't substantially changed)
> ====
> Kernel instructions per order-0 allocation and free in the QEMU guest,
> counted with a task-bound hardware instruction counter around 1M
> iterations on a pinned kthread, non-debug kernel, mean of 15 rounds.
> 
>                            instructions per alloc+free
>                              base   this series
>   alloc_pages()             890.5         900.5
>   bulk, nr=1, nodemask      865.5         875.5
>   bulk, nr=16, per page     477.2         478.1
> 
> 
> Bare metal, two-socket Xeon Gold 6138 (Skylake-SP, 80 CPUs).
> 
> will-it-scale page_fault1-3: each iteration touches one page, so
> the unit is millions of faults per second, summed over all tasks.
> 
> Base, millions of faults per second:
> 
>   tasks                         1     10     40     80
>   page_fault1, processes     0.46   4.16  10.51   9.23
>   page_fault1, threads       0.46   3.51   4.35   4.19
>   page_fault2, processes     0.43   3.66   9.02   8.33
>   page_fault2, threads       0.43   3.48   4.37   4.19
>   page_fault3, processes     3.89  14.78   8.10   8.00
>   page_fault3, threads       3.87  14.29   6.88   7.96
> 
> Change in faults per second with this series, + is faster:
> 
>   tasks                         1     10     40     80
>   page_fault1, processes    -0.3%  +0.1%  -3.0%  -1.7%
>   page_fault1, threads      -0.5%  -1.6%  -0.9%  -0.9%
>   page_fault2, processes    +0.0%  +0.9%  -1.4%  -0.5%
>   page_fault2, threads      +0.3%  +1.5%  -1.4%  -1.0%
>   page_fault3, processes    -1.0%  -3.8%  -0.7%  +1.2%
>   page_fault3, threads      -0.9%  -0.7%  +0.8%  -0.2%
> 
> The boot-to-boot stddev is 1.0-1.8% at 1 task and up to
> 15% in 10-80 tasks, so basically this is all within noise.
> 
> Changes in v5
> =============
> - Pulled in patches from Vlastimil's series (patches 2 and 3 here)
> - inline functions (Vlastimil)
> - Added patch 5: zonelist_zone() reads the slot with READ_ONCE(), as
>   recommended by sashiko on v4's mempolicy patch.
>   Patches 6, 7 and 11 call it instead of open-coding the load.
> - Added patch 12, removing zonelist_node_idx().  Not for stable.
> - Patch 1: reworded the changelog (Vlastimil).
> - Collected Reviewed-by tags.
> 
> Link: https://lore.kernel.org/linux-mm/20261028211930.3504634-1-gourry@gourry.net/
> Link: https://lore.kernel.org/linux-mm/20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org/
> Link: https://lore.kernel.org/linux-mm/20261014222456.2318284-1-gourry@gourry.net/
> Link: https://lore.kernel.org/linux-mm/20261015210539.3243563-1-gourry@gourry.net/
> Link: https://lore.kernel.org/linux-mm/20261019172346.3344005-1-gourry@gourry.net/
> 
> Gregory Price (Meta) (10):
>   mm/page_alloc: reset can_retry_reserves when the slowpath restarts
>   mm/page_alloc: detect zonelist rebuilds from memory hot-add
>   mm/mmzone: read the zoneref slot once in zonelist_zone()
>   mm/page_alloc: snapshot the preferred zone against shrink rebuilds
>   mm/mmzone: read each zoneref slot once when filtering by nodemask
>   mm/page_alloc: retry allocations that raced with a zonelist rebuild
>   mm/hugetlb: retry the pool walk when the zonelist is rebuilt
>   mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
>   mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
>   mm/mmzone: remove zonelist_node_idx()
> 
> Josef Bacik (2):
>   mm/page_alloc: keep the pagesets of an empty zone
>   mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone

Thanks, applied to mm/page_alloc [1] page_alloc/for-next-fixes

It should result in no conflicts with other trees AFAICS.

Following David's MAINTAINERS updates [2] and mm-next call discussions,
we'll move ahead with the page_alloc.git tree (integrated to mm-next) now to
spread the handling of the endless fixes stream. I'll send the MAINTAINERS
update soon.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mm/page_alloc.git
[2]
https://lore.kernel.org/all/20261030-maintainers-v1-0-97278f8a5f54@kernel.org/
