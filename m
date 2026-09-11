Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E235F60A;
	Fri, 11 Sep 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135811; cv=none; b=ZpmSQW46RoWsEVK/+8J6MyEYOSCUwz+FCtS+H2qXheRuHMRZVZy+nyttXcu7aeZ3ZIAqZYaZgUHLUVNhvSMyo0KFokx0s6MCqUTb2TgBhQjMsuk17zeIpwmDMfQWlkjnAVsjW7dzu6d/lAEDYPqxLSxdfrdKqlAS68NW8OcR6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135811; c=relaxed/simple;
	bh=hZ9xzrt4yyeD9cnR2YBm71XlWbyTcuBCsTUisFq7y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3DQxUmU/3K8qMaq2BTkDtt3JOCn98U4HHkthP2dJ9r3A2kscGllD1NMSpicEin2U4/+SP+vFdc5bduD306UfqOCvCD+0jsJMcDBfKc4LTm1SHID/SAJKqLHO9qhJsOYJ1ZXT3O2cJNZFqhMawIzGWb8TOJeSb5vv7Yr0IFryZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Y2VxROuq; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Y2VxROuq"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6324E1C1C17;
	Fri, 11 Sep 2026 14:10:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 7288820028;
	Fri, 11 Sep 2026 14:09:59 +0000 (UTC)
Date: Fri, 11 Sep 2026 10:11:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kairui Song
 <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)),
 Ridong Chen <chenridong@xiaomi.com>
Subject: Re: [PATCH 2/3] mm/mglru: add tracepoint for scan_folios()
Message-ID: <20260911101120.25e3495a@gandalf.local.home>
In-Reply-To: <20260911072848.2346073-3-ridong.chen@linux.dev>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
	<20260911072848.2346073-3-ridong.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z4qikr9ze6ijf13jt3i4esh36hxubsui
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 7288820028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19T0oTOyvjgt5li9uFXcMUJERRsN76FEGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mNBI0OlIe4nzIdsfwzVCeMqFH4qZxaPBgm0tmhtgZaE=; b=Y2VxROuqMdZ4zfgK9/f6AKrfKHXGoeUDmeQv85XnbiZZQOMTF84x1FM/RTeVyxo4c567bHvNLMv8fTaprArehqeBQaXu9+F3Fwb7c2U9XoNA2SABG8sRvSLIVDKgnIixjSDjNqUuEvsMg+yDH0sL5ZDc4JhdSUkDNxS7ijgRmm4=
X-HE-Tag: 1789135799-473225
X-HE-Meta: U2FsdGVkX1+EGFXRnXr/J3wqoz/KqkpAHbA33YbqajygCWkhwg0wfXJt4aZhAuaXRBNKSnOvt5Z3reG4g4wu6PCXgzdWSCgHqVcFVkESUfxoMO/77XBjhN99o1EqRO41WYpphK4aOzeD0N1FBkMjLmsBujhRKUu/j4e/7ZyF7tAFOB+E5VfYDkQQ7ywkxfGmY11K29qi83HDWYmpUgikZxAp408wyXkvXPXELwZXt2ND5qHAPSv4zy2c8iVVDfodX1h/OMI5ap/AS19+U1ehwrEg+EO8tBTvAO3Bqn+HsYG9dTSgMQb1FqtrqWMTU9l0

On Fri, 11 Sep 2026 15:28:47 +0800
Ridong Chen <ridong.chen@linux.dev> wrote:

> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 8a872990b4be..c39dfacef033 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -392,6 +392,69 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>  		__print_symbolic(__entry->lru, LRU_NAMES))
>  );
>  
> +TRACE_EVENT(mm_mglru_scan_folios,
> +
> +	TP_PROTO(u64 memcg_id,
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
> +
> +	TP_ARGS(memcg_id, highest_zoneidx, order, nr_requested, nr_scanned,
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

Please keep "int"s together. This creates a structure that is used to write
into the ring buffer. On 64bit machines, the above would add 4 bytes of
padding after each int, whereas:

		__field(unsigned long, max_seq)
		__field(unsigned long, min_seq)
		__field(int, lru)
		__field(int, tier)


would not.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->memcg_id = memcg_id;
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
> index 2554a6513aa8..bd1b9ecf2e84 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4876,6 +4876,12 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>  				scanned, skipped, isolated,
>  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> +	trace_mm_mglru_scan_folios(mem_cgroup_id(lruvec_memcg(lruvec)),
> +				   sc->reclaim_idx, sc->order, nr_to_scan,
> +				   scanned, sorted, skipped, isolated,
> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
> +				   lrugen->max_seq, tier,
> +				   lrugen->min_seq[type]);

Can't this information be processed in the tracepoint? That is:

	TP_PROTO(struct lruvec *lruvec,
		 struct scan_control *sc,
		 struct lru_gen_folio *lrugen,
		 unsigned long nr_requested,
		 unsigned long nr_scanned,
		 unsigned long nr_sorted,
		 unsigned long nr_skipped,
		 unsigned long nr_taken,
		 int type),

	TP_ARGS(lruvec, sc, lrugen, nr_requested, nr_scanned,
		nr_sorted, nr_skipped, nr_taken, type),

	TP_STRUCT__entry(
		__field(u64, memcg_id)
		__field(int, highest_zoneidx)
		__field(int, order)
		__field(unsigned long, nr_requested)
		__field(unsigned long, nr_scanned)
		__field(unsigned long, nr_sorted)
		__field(unsigned long, nr_skipped)
		__field(unsigned long, nr_taken)
		__field(unsigned long, max_seq)
		__field(unsigned long, min_seq)
		__field(int, lru)
		__field(int, tier)
	),

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


This moves the code to generate the parameters into the TP_fast_assign()
which is in a separate text section. It remove code from the work flow
improving instruction cache.

Same can be done for that trace_mm_vmscan_lru_isolate() trace event.

-- Steve

>  
>  	*isolatedp = isolated;
>  	return scanned;
> -- 
