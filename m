Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC3D544
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257834; cv=none; b=S+0kz+o0lqANwk0Q2E/2cd/i9MEjGgq7/FLbZctx8BBJCvIuoGtzxAcN8+Ks1kC9Gw0GHc3P/+mQggeU5b73gGVXIM1H/X3tmnkB8fdMzx+HktrG1dRBccWnKb2jNBdeDsitlPnTEbkxNlJ8LfLFtDe3GBggtelqng+oN7YOvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257834; c=relaxed/simple;
	bh=fHGm8CBhpEWvp4PXUrjiW/pxzzuIhMW9b7FowrixhH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrUzOC7XBVKkcTXxch34iFuAsnAucwVUZ26k3LQuPgaMLiUdDzT8ND7pyHRUbgvSErrrHnKXZK49j7QFBigZXbwjwZwn3t9TPux1ouuPu3omnnDRdvqklGylRucSKqIdAuLJZ8N2QGClQFewx+syyRkYFEcmQjEDS36++X3diV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cww3fojq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cww3fojq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771257830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoBTiJLuQJ9fkPhkSercyUgUATiDuyc3IG1+yyGn5p0=;
	b=cww3fojq6AJxpft6Q4NoMLB9alkb2FcIGHFdMU9na1WLoNdoeGtMGycT6hDbp3v0U6s/BU
	V+HJN/izShNhsrA8tGR5/g9WbqtjFwR/SBd3SkJ1uT6IxSOrou9R4aff6Krchincb5x33b
	RXVB2I3jlAuqLQ6i3h3D3FNdJ6fnFe0=
From: Usama Arif <usama.arif@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhiramat@kernel.org,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v6 3/3] mm: vmscan: add PIDs to vmscan tracepoints
Date: Mon, 16 Feb 2026 08:02:37 -0800
Message-ID: <20260216160247.3956707-1-usama.arif@linux.dev>
In-Reply-To: <20260213181537.54350-4-tballasi@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 13 Feb 2026 10:15:37 -0800 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> The changes aims at adding additionnal tracepoints variables to help
> debuggers attribute them to specific processes.
> 
> The PID field uses in_task() to reliably detect when we're in process
> context and can safely access current->pid.  When not in process
> context (such as in interrupt or in an asynchronous RCU context), the
> field is set to -1 as a sentinel value.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
> ---
>  include/trace/events/vmscan.h | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 1212f6a7c223e..a68b712ef757a 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -122,18 +122,22 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  		__field(	unsigned long,	gfp_flags	)
>  		__field(	u64,	memcg_id	)
>  		__field(	int,	order		)
> +		__field(	int,	pid		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
>  		__entry->order		= order;
> +		__entry->pid		= current->pid;
>  		__entry->memcg_id	= mem_cgroup_id(memcg);
>  	),
>  
> -	TP_printk("order=%d gfp_flags=%s memcg_id=%llu",
> +	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%llu %s",
>  		__entry->order,
>  		show_gfp_flags(__entry->gfp_flags),
> -		__entry->memcg_id)
> +		__entry->pid,
> +		__entry->memcg_id,
> +		__event_in_irq() ? "(in-irq)" : "")
>  );
>  
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
> @@ -168,16 +172,20 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	nr_reclaimed	)
>  		__field(	u64,	memcg_id	)
> +		__field(	int,	pid		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->nr_reclaimed	= nr_reclaimed;
>  		__entry->memcg_id	= mem_cgroup_id(memcg);
> +		__entry->pid		= current->pid;
>  	),
>  
> -	TP_printk("nr_reclaimed=%lu memcg_id=%llu",
> +	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%llu %s",
>  		__entry->nr_reclaimed,
> -		__entry->memcg_id)
> +		__entry->pid,
> +		__entry->memcg_id,
> +		__event_in_irq() ? "(in-irq)" : "")
>  );
>  
>  DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end,
> @@ -220,9 +228,10 @@ TRACE_EVENT(mm_shrink_slab_start,
>  		__field(unsigned long, cache_items)
>  		__field(unsigned long long, delta)
>  		__field(unsigned long, total_scan)
> +		__field(u64, memcg_id)
>  		__field(int, priority)
>  		__field(int, nid)
> -		__field(u64, memcg_id)
> +		__field(int, pid)
>  	),
>  
>  	TP_fast_assign(
> @@ -236,19 +245,22 @@ TRACE_EVENT(mm_shrink_slab_start,
>  		__entry->priority = priority;
>  		__entry->nid = sc->nid;
>  		__entry->memcg_id = mem_cgroup_id(memcg);
> +		__entry->pid = current->pid;
>  	),
>  
> -	TP_printk("%pS %p: nid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
> +	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d %s",
>  		__entry->shrink,
>  		__entry->shr,
>  		__entry->nid,
> +		__entry->pid,
>  		__entry->memcg_id,
>  		__entry->nr_objects_to_shrink,
>  		show_gfp_flags(__entry->gfp_flags),
>  		__entry->cache_items,
>  		__entry->delta,
>  		__entry->total_scan,
> -		__entry->priority)
> +		__entry->priority,
> +		__event_in_irq() ? "(in-irq)" : "")
>  );
>  
>  TRACE_EVENT(mm_shrink_slab_end,
> @@ -266,29 +278,32 @@ TRACE_EVENT(mm_shrink_slab_end,
>  		__field(long, total_scan)
>  		__field(int, nid)
>  		__field(int, retval)
> +		__field(int, pid)
>  		__field(u64, memcg_id)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->shr = shr;
> -		__entry->shrink = shr->scan_objects;

__entry->shrink is removed here, but still printed below. Was this an intended
change of this commit?

>  		__entry->unused_scan = unused_scan_cnt;
>  		__entry->new_scan = new_scan_cnt;
>  		__entry->total_scan = total_scan;
>  		__entry->nid = nid;
>  		__entry->retval = shrinker_retval;
> +		__entry->pid = current->pid;
>  		__entry->memcg_id = mem_cgroup_id(memcg);
>  	),
>  
> -	TP_printk("%pS %p: nid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
> +	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d %s",
>  		__entry->shrink,
>  		__entry->shr,
>  		__entry->nid,
> +		__entry->pid,
>  		__entry->memcg_id,
>  		__entry->unused_scan,
>  		__entry->new_scan,
>  		__entry->total_scan,
> -		__entry->retval)
> +		__entry->retval,
> +		__event_in_irq() ? "(in-irq)" : "")
>  );
>  
>  TRACE_EVENT(mm_vmscan_lru_isolate,
> -- 
> 2.33.8
> 
> 
