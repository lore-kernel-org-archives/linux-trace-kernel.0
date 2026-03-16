Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8B309EFA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679569; cv=none; b=icdGT5YHJRP3DVryIIO48i5VXz7/+EkAltJ0zj7mn8hhbEyz85jHyxScxl7FIZ1rHwcfKxtmE9y6/bio9U9EnWj6gMBMijQH4eO3uHVus90muLZWh8cDsMZ39o7nTg/ZGymCOAfcK1pEPO1IJF8/66SgJOGDwmVw6SE5b3gLJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679569; c=relaxed/simple;
	bh=x3veN1AGSESlcaN8+BxreAHIRIscaBpWO+zEr/eyVJY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JM4lJ/FDJLeQrxz+e9nhotr/utp2BIgdAZ7q04XBkB57fg5TMHXKlrzZeD7PFtpOybdUOdgPoJsUnDEc1cyWX7u6ip2sVam9fZtJ3U9K8MwQWuEgqM/8bGnlXibUsgVgV5Ft9Q2w1HFS+vHgpDJH/QO8forNAtaa980JIva5su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WPHomySG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WPHomySG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A8C19421;
	Mon, 16 Mar 2026 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773679568;
	bh=x3veN1AGSESlcaN8+BxreAHIRIscaBpWO+zEr/eyVJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WPHomySGC89wv9b6Mtcd5hr61L8O0Xaydp6D/YAjTfwvS6hW8FFu54i3BJfF14jKy
	 lnf7xY9dc0wa+/3gyYKkdTTcsennhI+Y2RZFWAjykiCnu1dpORc6Q3Jh+tWpQgwgag
	 gCCjO3lqI0A1X4YXAPgnA2O1aFjx4lWARTKPIu9k=
Date: Mon, 16 Mar 2026 09:46:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: axelrasmussen@google.com, david@kernel.org, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org,
 rostedt@goodmis.org, shakeel.butt@linux.dev, weixugc@google.com,
 yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v8 0/3] mm: vmscan: add PID and cgroup ID to vmscan
 tracepoints
Message-Id: <20260316094607.d59eeaead6e7a79df74d9476@linux-foundation.org>
In-Reply-To: <20260316160908.42727-1-tballasi@linux.microsoft.com>
References: <20260223171544.4750-1-tballasi@linux.microsoft.com>
	<20260316160908.42727-1-tballasi@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 09:09:05 -0700 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> Changes in v8:
> - Removed in_task() mention in PID commit message
> - Moved __entry->pid to __entry->ent.pid
> 

Below is how this update altered mm.git.

It's a minor change, so I'll retain Shakeel's Acked-by and Reviewed-by
on the first two patches.


--- a/include/trace/events/vmscan.h~b
+++ a/include/trace/events/vmscan.h
@@ -132,20 +132,18 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_rec
 		__field(	unsigned long,	gfp_flags	)
 		__field(	u64,	memcg_id	)
 		__field(	int,	order		)
-		__field(	int,	pid		)
 	),
 
 	TP_fast_assign(
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->order		= order;
-		__entry->pid		= current->pid;
 		__entry->memcg_id	= mem_cgroup_id(memcg);
 	),
 
 	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%llu %s",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->pid,
+		__entry->ent.pid,
 		__entry->memcg_id,
 		__event_in_irq() ? "(in-irq)" : "")
 );
@@ -182,18 +180,16 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_rec
 	TP_STRUCT__entry(
 		__field(	unsigned long,	nr_reclaimed	)
 		__field(	u64,	memcg_id	)
-		__field(	int,	pid		)
 	),
 
 	TP_fast_assign(
 		__entry->nr_reclaimed	= nr_reclaimed;
 		__entry->memcg_id	= mem_cgroup_id(memcg);
-		__entry->pid		= current->pid;
 	),
 
 	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%llu %s",
 		__entry->nr_reclaimed,
-		__entry->pid,
+		__entry->ent.pid,
 		__entry->memcg_id,
 		__event_in_irq() ? "(in-irq)" : "")
 );
@@ -238,10 +234,9 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(unsigned long, cache_items)
 		__field(unsigned long long, delta)
 		__field(unsigned long, total_scan)
-		__field(u64, memcg_id)
 		__field(int, priority)
 		__field(int, nid)
-		__field(int, pid)
+		__field(u64, memcg_id)
 	),
 
 	TP_fast_assign(
@@ -255,14 +250,13 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 		__entry->nid = sc->nid;
 		__entry->memcg_id = mem_cgroup_id(memcg);
-		__entry->pid = current->pid;
 	),
 
 	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->pid,
+		__entry->ent.pid,
 		__entry->memcg_id,
 		__entry->nr_objects_to_shrink,
 		show_gfp_flags(__entry->gfp_flags),
@@ -288,7 +282,6 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__field(long, total_scan)
 		__field(int, nid)
 		__field(int, retval)
-		__field(int, pid)
 		__field(u64, memcg_id)
 	),
 
@@ -300,7 +293,6 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->total_scan = total_scan;
 		__entry->nid = nid;
 		__entry->retval = shrinker_retval;
-		__entry->pid = current->pid;
 		__entry->memcg_id = mem_cgroup_id(memcg);
 	),
 
@@ -308,7 +300,7 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
-		__entry->pid,
+		__entry->ent.pid,
 		__entry->memcg_id,
 		__entry->unused_scan,
 		__entry->new_scan,
_

