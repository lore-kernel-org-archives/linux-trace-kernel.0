Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C95483BC8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470855; cv=none; b=Ww48CbHYSNF98oGttEImRLh4OyGP3zstau311btbZzQAue9ptsADbVab6jENX9D9GKd6+BvIfjjqih8tZLgA6R75J5nlJEXHCJFum5nmrsMOk8r6qvAyMB1xUmpTDCoy2bRDNdnjV73mrXTTcZBBscUKRGSzPIgweQmUsHTidiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470855; c=relaxed/simple;
	bh=wibSmjO0uWDWPZo+iAJSWnYXVZkkfn1R+Ze2nTc0SPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMiOGh2gw4uTh1SJEoYsGDMREb/kIyilxbByUAHrCwzDbx+aeBzJX5taUa+S1G/xnL1eT7K7SLbSi8FT3ISevqE1AFDDk8Vr13wwqK9mlwkR+gG+rrJks6ivu1t+A4HWTNwEE4g5mkmhyDBTo33wUi+Zex7Q8SNFe1qebCNIGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FE2PuXkI; arc=none smtp.client-ip=91.218.175.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FE2PuXkI"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wibSmjO0uWDWPZo+iAJSWnYXVZkkfn1R+Ze2nTc0SPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789470851; v=1; x=1790075651;
 b=FE2PuXkIoaFqNjMAZYoSECHKT6ixpowIcLWuqP289hxHpEXAYJcy+eDffM+Lwy8fG8nW9sPn
 9a2wQv+/xbHrZrKeBlZFioYWAVdRVoujEJ7jxeU99ksEpB3L0xqoLJ7UW6e1fuDXxJhxI82iO4m
 unMffzWRWK3Cq72C38PpY2kI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9e5b113a4fa06a2f;
	Tue, 15 Sep 2026 11:14:10 +0000
X-Mizu-Trace-ID: 9e5b113a4fa06a2f
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 19:14:00 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
Message-ID: <aqkoeJvFzqpoGeaP@fedora>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-3-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911102939.2485750-3-ridong.chen@linux.dev>

On 09/11/26 at 06:29pm, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
...snip...
> ---
>  include/trace/events/vmscan.h | 63 +++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                   |  6 ++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 8a872990b4be..5defa8f6719c 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>  		__print_symbolic(__entry->lru, LRU_NAMES))
>  );
>  
> +TRACE_EVENT(mm_mglru_scan_folios,
> +
> +	TP_PROTO(struct lruvec *lruvec,
> +		int highest_zoneidx,
> +		int order,
> +		unsigned long nr_requested,
> +		unsigned long nr_scanned,
> +		unsigned long nr_sorted,
> +		unsigned long nr_skipped,
> +		unsigned long nr_taken,
> +		int lru,
> +		unsigned long max_seq,
> +		int tier,
> +		unsigned long min_seq),

Do we need show nid? Guess phone vendor doesn't care about multi-NUMA
system.

And I checked v1 thread, seems Steven suggested to move the two int to
avoid extra padding.

> +
> +	TP_ARGS(lruvec, highest_zoneidx, order, nr_requested, nr_scanned,
> +		nr_sorted, nr_skipped, nr_taken, lru, max_seq, tier, min_seq),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, memcg_id)
> +		__field(int, highest_zoneidx)
> +		__field(int, order)
> +		__field(unsigned long, nr_requested)
> +		__field(unsigned long, nr_scanned)
> +		__field(unsigned long, nr_sorted)
> +		__field(unsigned long, nr_skipped)
> +		__field(unsigned long, nr_taken)
> +		__field(int, lru)
> +		__field(unsigned long, max_seq)
> +		__field(int, tier)
> +		__field(unsigned long, min_seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
> +		__entry->highest_zoneidx = highest_zoneidx;
> +		__entry->order = order;
> +		__entry->nr_requested = nr_requested;
> +		__entry->nr_scanned = nr_scanned;
> +		__entry->nr_sorted = nr_sorted;
> +		__entry->nr_skipped = nr_skipped;
> +		__entry->nr_taken = nr_taken;
> +		__entry->lru = lru;
> +		__entry->max_seq = max_seq;
> +		__entry->tier = tier;
> +		__entry->min_seq = min_seq;
> +	),
> +
> +	TP_printk("memcg_id=%llu classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_sorted=%lu nr_skipped=%lu nr_taken=%lu lru=%s max_seq=%lu tier=%d min_seq=%lu",
> +		__entry->memcg_id,
> +		__entry->highest_zoneidx,
> +		__entry->order,
> +		__entry->nr_requested,
> +		__entry->nr_scanned,
> +		__entry->nr_sorted,
> +		__entry->nr_skipped,
> +		__entry->nr_taken,
> +		__print_symbolic(__entry->lru, LRU_NAMES),
> +		__entry->max_seq,
> +		__entry->tier,
> +		__entry->min_seq)
> +);
> +
>  TRACE_EVENT(mm_vmscan_write_folio,
>  
>  	TP_PROTO(struct folio *folio),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2554a6513aa8..67f59aa73fb9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>  				scanned, skipped, isolated,
>  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> +	trace_mm_mglru_scan_folios(lruvec,
> +				   sc->reclaim_idx, sc->order, nr_to_scan,
> +				   scanned, sorted, skipped, isolated,
> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
> +				   lrugen->max_seq, tier,
> +				   lrugen->min_seq[type]);

And seems Steven also suggested to calculate lru, max_seq, min_seq in
TP_fast_assign() in v1 which could be missed.

        TP_fast_assign(
                __entry->memcg_id = mem_cgroup_id(lruvec_memcg(lruvec));
                __entry->highest_zoneidx = sc->reclaim_idx;
                __entry->order = sc->order;
                __entry->nr_requested = nr_requested;
                __entry->nr_scanned = nr_scanned;
                __entry->nr_sorted = nr_sorted;
                __entry->nr_skipped = nr_skipped;
                __entry->nr_taken = nr_taken;
                __entry->lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
                __entry->max_seq = lrugen->max_seq;
                __entry->tier = tier;
                __entry->min_seq = lrugen->min_seq;
        ),


>  
>  	*isolatedp = isolated;
>  	return scanned;
> -- 
> 2.34.1
> 
