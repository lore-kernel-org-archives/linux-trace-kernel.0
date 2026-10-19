Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4B47DD44
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390915; cv=none; b=WZL1rSNjxk84EQsivV+fLENkn220nD92QfmQk5a4hL00I8ra1yXTrXeP7y9xXlcb09Fet2w2iN66zC980dZBhdiJoJKQsQe3CTDDCo9hMHQj9k8rKnnuY/kgBGEWaZ7IACyGvlTXffJwFIbyHNy6JQdDkI1Vwo+Wy+E4pTtp4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390915; c=relaxed/simple;
	bh=I4MPMNFIXchxrDocrBAZUC2FdxNIMi1x4SFGsuGksro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwInCka5EeLGQ/UrFkfL3OOTNQ4WE7lXSca6p7Jmhv3n/iHmmDDqKqR2uEOb0/Gs6ehPdwsmTGOeNvaP+J7rSCwLCW088tZ3cYYmm/fLG5wVgLJK3fuKbYEuyFJkmwdvB3B/DY6rmAjIj2PLiphvJqWSlP7xzp3gsZkxqq11X64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZeCpItu; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZeCpItu"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=I4MPMNFIXchxrDocrBAZUC2FdxNIMi1x4SFGsuGksro=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792390910; v=1; x=1792995710;
 b=PZeCpItuM79ocVG/ZTKd6RwQdP6Tps/2lRzSJ7JAm/RXajDfEmBbX5mBR0tlLaddhCmUpcII
 OaeqLlQjikHo8sJ5ktuQokskT7UgL5xw6Bf3VsI72r63+AKezog8THBAEXn1lyAJCziDW3pdtwC
 JFs3wFclqUiEoZAFKlmzI0mc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab907ebe85d37efd;
	Mon, 19 Oct 2026 06:21:50 +0000
X-Mizu-Trace-ID: ab907ebe85d37efd
X-Migadu-Flow: FLOW_OUT
Message-ID: <8ed89bac-d9f0-4dba-b733-7d678a4b47ac@linux.dev>
Date: Mon, 19 Oct 2026 14:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/mglru: add tracepoints for scan and aging paths
To: Steven Rostedt <rostedt@goodmis.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Baoquan He <baoquan.he@linux.dev>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260911102939.2485750-1-ridong.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2026 6:29 PM, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> Background
> ==========
> 
> MGLRU currently has no tracepoints of its own. The scan and evict paths
> reuse the classic-LRU tracepoints (trace_mm_vmscan_lru_isolate() and
> trace_mm_vmscan_lru_shrink_inactive()), which predate MGLRU and carry no
> generation, sequence, memcg or swappiness context. A trace of a running
> system therefore cannot tell which memcg a given scan belongs to, how far
> reclaim has progressed through the generations, or when a new generation
> is created - so how MGLRU actually operates is effectively invisible.
> 
> Implementation
> ==============
> 
> Patch 1 is a cleanup that factors the per-generation page-count
> summation into a helper, lru_gen_seq_nr_pages(), reused by patch 3.
> 
> Patch 2 adds mm_mglru_scan_folios on the scan path, and patch 3 adds
> mm_mglru_inc_max_seq on the aging path. Both carry the memcg id and the
> generation window (min_seq/max_seq), live at MGLRU-specific layers with
> no classic-LRU counterpart, and are guarded so the hot paths stay
> zero-cost when disabled.
> 
> Effect
> ======
> 
> Paired, the two tracepoints make the full aging-to-eviction window
> observable per memcg: aging advances max_seq (the leading edge), scanning
> consumes the oldest generations, and the min_seq/max_seq pair on each
> event shows how the generation window moves over time.
> 
> A sample trace, with the classic-LRU tracepoints left enabled to show
> how they interleave:
> 
>    mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=36 nr_scanned=31 nr_skipped=0 nr_taken=29 lru=inactive_file
>    mm_mglru_scan_folios: memcg_id=73 classzone=4 order=0 nr_requested=36 nr_scanned=31 nr_sorted=2 nr_skipped=0 nr_taken=29 lru=inactive_file max_seq=3 tier=3 min_seq=0
>    mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=31 nr_reclaimed=29 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=5 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>    mm_mglru_inc_max_seq: memcg_id=73 max_seq=4 anon_min_seq=1 file_min_seq=1 nr_anon={0x0,0x0,0x1,0x0} nr_file={0x0,0x427,0x6,0x4a}
>    mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=5 nr_scanned=5 nr_skipped=0 nr_taken=1 lru=inactive_file
>    mm_mglru_scan_folios: memcg_id=73 classzone=4 order=0 nr_requested=5 nr_scanned=5 nr_sorted=4 nr_skipped=0 nr_taken=1 lru=inactive_file max_seq=4 tier=3 min_seq=1
>    mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=1 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=5 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> 
> The mm_mglru_scan_folios lines carry the memcg id and the generation
> window (max_seq/min_seq) that the bare mm_vmscan_lru_isolate lines above
> them cannot - those cannot even say which memcg they came from. The
> mm_mglru_inc_max_seq line then shows a new generation being created
> (max_seq 3 -> 4) with the per-generation page counts for both types.
> 
> ---
> v2: address Sashiko AI review [1] - pass struct lruvec * into the tracepoints
>      and do the memcg lookup inside TP_fast_assign.
> 
> [1] https://sashiko.dev/#/patchset/20260911072848.2346073-1-ridong.chen@linux.dev?part=2
> 
> Ridong Chen (3):
>    mm/mglru: factor out lru_gen_seq_nr_pages()
>    mm/mglru: add tracepoint for scan_folios()
>    mm/mglru: add tracepoint for inc_max_seq()
> 
>   include/trace/events/vmscan.h | 101 ++++++++++++++++++++++++++++++++++
>   mm/vmscan.c                   |  53 +++++++++++++++---
>   2 files changed, 146 insertions(+), 8 deletions(-)
> 

Hi Steven, Baolin and Baoquan,

Thanks again for reviewing v2.

Following Steven's suggestion in this thread, I first moved the vmscan
trace header under mm/ and exposed struct scan_control to it in a
separate RFC series. Patches [2/3] and [3/3] of v2 have now been
reworked on top of that and posted together with it as one series:

   [PATCH v4 0/9] mm/vmscan: move tracepoints to mm/ and add MGLRU
   tracepoints
   https://lore.kernel.org/all/20261019034426.2354049-1-ridong.chen@linux.dev/

The two MGLRU tracepoints are [8/9] and [9/9] there. Compared with v2:

- Both events now take only lruvec/sc plus the local counters, and
   derive everything else (memcg id, order, reclaim_idx, lru, max_seq,
   min_seq and the per-generation page counts) in TP_fast_assign()
   (Steven).
- Add nid, derived from lruvec_pgdat(lruvec) (Baoquan).
- Group the int fields at the end of the entry to avoid padding on
   64-bit (Steven).
- Drop v2 [1/3] "mm/mglru: factor out lru_gen_seq_nr_pages()": the
   per-generation page count is now summed inside TP_fast_assign(), so
   the helper has no user left.

Since [8/9] and [9/9] changed substantially, I did not carry over your
Reviewed-by tags. I would really appreciate it if you could take
another look at v4.

-- 
Best regards
Ridong

