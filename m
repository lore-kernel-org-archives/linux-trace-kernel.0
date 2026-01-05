Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92E31AA9C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629487; cv=none; b=TEzdLSq85Cr5dXQhG0hIlQvzFnY+sIevODUf19fcVCOjTVhL4iLrS6mGy7RWRx+QfZMkeWc/tf0hwhl8XIp1jF/ZssIOO3vQ3YylA5CDskfm3jCwtScxvaYv2P7tKR+e26fkGm6QCVQaW6KJY7gmNXzTR7g/ZUXAUc0Skr4+n8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629487; c=relaxed/simple;
	bh=cibhD3unE0vOwv5NoMbSJ+/xlKS/9bn33N83oGI72oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJgyIf6Y6YhhDDJX1Lwtd9L7os9LS0cUl3EN+H4IiQWEOmXaTEtN70jrPM1rRYQkmKm8aSk+bZpiiCoQRPD1JEkD2OnQKmNFlJf/hxSkntA2jgaJzyDrAvqiIWSZZg27GSgdUOL4B1IBa/5ZkYiunMJqDmjlO1pImKwYcGgHbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=faemh3aa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="faemh3aa"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [108.142.230.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5976021260DB;
	Mon,  5 Jan 2026 08:05:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5976021260DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767629118;
	bh=h/FTPDvAe0kBCPN0cxH7L3pGPOpB1MWPz7S11VhSCwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=faemh3aaViYAj6Uua4LMH1ma42MSRKm+E1qg7J2vphI7woGFFz/AlV0t6kcA1ozrx
	 XvTdlgMkeTAY/xgYMMp7NhSctV+chFLmDcczPRPVrJ0T4X7xf0cpsKEJ0bncc0BEao
	 0C49wXBtb/XgLiqqDGR4WqLfjFaZVCrYV6fevUGE=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v3 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Date: Mon,  5 Jan 2026 08:04:23 -0800
Message-Id: <20260105160423.23708-3-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105160423.23708-1-tballasi@linux.microsoft.com>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
 <20260105160423.23708-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The changes aims at adding additionnal tracepoints variables to help
debuggers attribute them to specific processes.

The PID field uses in_task() to reliably detect when we're in process
context and can safely access current->pid.  When not in process
context (such as in interrupt or in an asynchronous RCU context), the
field is set to -1 as a sentinel value.

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
---
 include/trace/events/vmscan.h | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 93a9a9ba9405d..d438abfa03ebb 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -121,19 +121,23 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	gfp_flags	)
 		__field(	int,	order		)
+		__field(	int,	pid		)
 		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->order		= order;
+		__entry->pid		= current->pid;
 		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("order=%d gfp_flags=%s memcg_id=%u",
+	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%u %s",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->memcg_id)
+		__entry->pid,
+		__entry->memcg_id,
++		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
@@ -167,17 +171,21 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	nr_reclaimed	)
+		__field(	int,	pid		)
 		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->nr_reclaimed	= nr_reclaimed;
+		__entry->pid		= current->pid;
 		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("nr_reclaimed=%lu memcg_id=%u",
+	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%u %s",
 		__entry->nr_reclaimed,
-		__entry->memcg_id)
+		__entry->pid,
+		__entry->memcg_id,
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end,
@@ -222,6 +230,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(unsigned long, total_scan)
 		__field(int, priority)
 		__field(int, nid)
+		__field(int, pid)
 		__field(unsigned short, memcg_id)
 	),
 
@@ -235,20 +244,23 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->total_scan = total_scan;
 		__entry->priority = priority;
 		__entry->nid = sc->nid;
+		__entry->pid = current->pid;
 		__entry->memcg_id = sc->memcg ? cgroup_id(sc->memcg->css.cgroup) : 0;
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %u objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %u objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->pid,
 		__entry->memcg_id,
 		__entry->nr_objects_to_shrink,
 		show_gfp_flags(__entry->gfp_flags),
 		__entry->cache_items,
 		__entry->delta,
 		__entry->total_scan,
-		__entry->priority)
+		__entry->priority,
++		__event_in_irq() ? "(in-irq)" : "")
 );
 
 TRACE_EVENT(mm_shrink_slab_end,
@@ -266,29 +278,32 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__field(long, total_scan)
 		__field(int, nid)
 		__field(int, retval)
+		__field(int, pid)
 		__field(unsigned short, memcg_id)
 	),
 
 	TP_fast_assign(
 		__entry->shr = shr;
-		__entry->shrink = shr->scan_objects;
 		__entry->unused_scan = unused_scan_cnt;
 		__entry->new_scan = new_scan_cnt;
 		__entry->total_scan = total_scan;
 		__entry->nid = sc->nid;
 		__entry->retval = shrinker_retval;
+		__entry->pid = current->pid;
 		__entry->memcg_id = cgroup_id(sc->memcg->css.cgroup);
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %u unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %u unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->pid,
 		__entry->memcg_id,
 		__entry->unused_scan,
 		__entry->new_scan,
 		__entry->total_scan,
-		__entry->retval)
+		__entry->retval,
++		__event_in_irq() ? "(in-irq)" : "")
 );
 
 TRACE_EVENT(mm_vmscan_lru_isolate,
-- 
2.33.8

