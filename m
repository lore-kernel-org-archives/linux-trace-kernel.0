Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E87533B6FD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106363; cv=none; b=Fk0k1NAvL2mt4W1CK8UTMUNH6X+gCTAPvtkZMfgQMZl1hNyI+8e1W/We/PrcaoIfAZNmgFYG5d+uKVSo8M11xW/B1d8hIujdnKUA+SBgZfT82ZGQSk0SKrtuQeRA2kOOuaPPjpvwB8bR+Y8h5XFniCCv1rZ6ZQwzEcz70AXkJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106363; c=relaxed/simple;
	bh=INwQND/78f2LdVRT6iz5QuzXPkcWmxQzkKeXOoDEaRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDhpzgHVJ9QAf6oUZlj0RIhIyxRGHfjUajh7ihDVJasVL8QQWamDtKQm6152mZDF5FU+BqSVL3tq42zmiIKg4XHkdirNUu2fNBUq28BnAqsyGoozOZWVfNeJ/a6Vdr551gYivS5oPUOIjve6SdosoNtTBRmHOqeB6PHppv112r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p+ImZKNT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p+ImZKNT"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [4.255.188.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id D877C20B716C;
	Thu, 22 Jan 2026 10:25:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D877C20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769106337;
	bh=Zn10ZMJYtiEcPLf2ZuRuW6L/Fov3vMISENbJTbJv6Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+ImZKNTiJPUfunSUwmJEsSQtqwL15K6ZYgS2IPRZl2iWxj6Ikg/fmyjW/3JoDRtB
	 zw83fYj6Yz+HdHJ+DJlHQMQcbxAVJKEIFM8/esOsHA985pMONs+UuLOHAfxkmgfJwv
	 JkIQ2XvOl8MehFhiuRW72rgupSS1wEf/oEuKKG/I=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v5 3/3] mm: vmscan: add PIDs to vmscan tracepoints
Date: Thu, 22 Jan 2026 10:25:10 -0800
Message-Id: <20260122182510.2126-4-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122182510.2126-1-tballasi@linux.microsoft.com>
References: <20260115123809.2257-1-tballasi@linux.microsoft.com>
 <20260122182510.2126-1-tballasi@linux.microsoft.com>
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
 include/trace/events/vmscan.h | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 20160e79eb0d7..c7f7621e48af5 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -122,18 +122,22 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 		__field(	unsigned long,	gfp_flags	)
 		__field(	u64,	memcg_id	)
 		__field(	int,	order		)
+		__field(	int,	pid		)
 	),
 
 	TP_fast_assign(
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->order		= order;
+		__entry->pid		= current->pid;
 		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("order=%d gfp_flags=%s memcg_id=%llu",
+	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%llu %s",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->memcg_id)
+		__entry->pid,
+		__entry->memcg_id,
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
@@ -168,16 +172,20 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	nr_reclaimed	)
 		__field(	u64,	memcg_id	)
+		__field(	int,	pid		)
 	),
 
 	TP_fast_assign(
 		__entry->nr_reclaimed	= nr_reclaimed;
 		__entry->memcg_id	= memcg_id;
+		__entry->pid		= current->pid;
 	),
 
-	TP_printk("nr_reclaimed=%lu memcg_id=%llu",
+	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%llu %s",
 		__entry->nr_reclaimed,
-		__entry->memcg_id)
+		__entry->pid,
+		__entry->memcg_id,
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end,
@@ -220,9 +228,10 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(unsigned long, cache_items)
 		__field(unsigned long long, delta)
 		__field(unsigned long, total_scan)
+		__field(u64, memcg_id)
 		__field(int, priority)
 		__field(int, nid)
-		__field(u64, memcg_id)
+		__field(int, pid)
 	),
 
 	TP_fast_assign(
@@ -236,19 +245,22 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 		__entry->nid = sc->nid;
 		__entry->memcg_id = memcg_id;
+		__entry->pid = current->pid;
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d %s",
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
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 TRACE_EVENT(mm_shrink_slab_end,
@@ -266,29 +278,32 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__field(long, total_scan)
 		__field(int, nid)
 		__field(int, retval)
+		__field(int, pid)
 		__field(u64, memcg_id)
 	),
 
 	TP_fast_assign(
 		__entry->shr = shr;
-		__entry->shrink = shr->scan_objects;
 		__entry->unused_scan = unused_scan_cnt;
 		__entry->new_scan = new_scan_cnt;
 		__entry->total_scan = total_scan;
 		__entry->nid = nid;
 		__entry->retval = shrinker_retval;
+		__entry->pid = current->pid;
 		__entry->memcg_id = memcg_id;
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d %s",
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
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 TRACE_EVENT(mm_vmscan_lru_isolate,
-- 
2.33.8

