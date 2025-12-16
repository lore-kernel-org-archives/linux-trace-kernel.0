Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99E19D093
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893813; cv=none; b=hpDiRKDv7UstlqpX0TsGErckyKfjWkJZjaDnH7rZfvGg0LLKvT5pCcAPq/sJojG/e6XVJmzrFz6pf8zXmsUgpEoNkc2oCKroE8MDjrnxu4hRbQr0mYFlOo5vks2UfhHkBA3zSpLJCi806Z8bKpZ+KOf7Hc2K6YYOWxWVnimFtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893813; c=relaxed/simple;
	bh=dxsAJOzIbmKeuhK+aadU0s3X8+k3JUbT3bRdrflveTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n05ot0lfEmrFqznLDj0Rl+ENIhBA/rijXARcLN0lteZgcFyKjwwzkibj9D0zlCftdotA3V7nyWsXrIlYIW6TtA9k0tAYCHSVuYqYN5X80eHl7gKpuOTjgepsyJYOZQ5HHGU1ZRRJE+5e1lIr6xnAGts4U4CKygIfz3dtOBBpwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y9N8buna; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y9N8buna"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [40.68.199.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BF6D200D653;
	Tue, 16 Dec 2025 06:03:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BF6D200D653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765893810;
	bh=4j5utBX4YaZFXMornXvVJFK8v9wGb1f/34l9iOWO/8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9N8bunaxylY1ELiOjPh/ejm1t6KbVpf3y6rx36E/2boP5hz0Zs9HrwjtBhY3cFb3
	 rhf3UbrtHJCiaWwapSAqfg+VkG67pJ9hVV+FATfsU1LHWkMsp1ZQzADk8MmbZEdCyP
	 h2IYzkYZTddQqvPUkQU41y94bo/VGc/ex8bZ6GWs=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Date: Tue, 16 Dec 2025 06:02:52 -0800
Message-Id: <20251216140252.11864-3-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216140252.11864-1-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
 <20251216140252.11864-1-tballasi@linux.microsoft.com>
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
 include/trace/events/vmscan.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index afc9f80d03f34..315725f30b504 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -120,19 +120,22 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
 	TP_STRUCT__entry(
 		__field(	int,	order		)
+		__field(	int,	pid		)
 		__field(	unsigned long,	gfp_flags	)
 		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->order		= order;
+		__entry->pid		= in_task() ? current->pid : -1;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("order=%d gfp_flags=%s memcg_id=%u",
+	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%u",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags),
+		__entry->pid,
 		__entry->memcg_id)
 );
 
@@ -167,16 +170,19 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	nr_reclaimed	)
+		__field(	int,	pid		)
 		__field(	unsigned short,	memcg_id	)
 	),
 
 	TP_fast_assign(
 		__entry->nr_reclaimed	= nr_reclaimed;
+		__entry->pid		= in_task() ? current->pid : -1;
 		__entry->memcg_id	= memcg_id;
 	),
 
-	TP_printk("nr_reclaimed=%lu memcg_id=%u",
+	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%u",
 		__entry->nr_reclaimed,
+		__entry->pid,
 		__entry->memcg_id)
 );
 
@@ -216,6 +222,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(struct shrinker *, shr)
 		__field(void *, shrink)
 		__field(int, nid)
+		__field(int, pid)
 		__field(unsigned short, memcg_id)
 		__field(long, nr_objects_to_shrink)
 		__field(unsigned long, gfp_flags)
@@ -229,6 +236,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->shr = shr;
 		__entry->shrink = shr->scan_objects;
 		__entry->nid = sc->nid;
+		__entry->pid = in_task() ? current->pid : -1;
 		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
 		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
 		__entry->gfp_flags = (__force unsigned long)sc->gfp_mask;
@@ -238,10 +246,11 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->priority = priority;
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %u objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %u objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->pid,
 		__entry->memcg_id,
 		__entry->nr_objects_to_shrink,
 		show_gfp_flags(__entry->gfp_flags),
@@ -261,6 +270,7 @@ TRACE_EVENT(mm_shrink_slab_end,
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
 		__field(int, nid)
+		__field(int, pid)
 		__field(unsigned short, memcg_id)
 		__field(void *, shrink)
 		__field(long, unused_scan)
@@ -272,6 +282,7 @@ TRACE_EVENT(mm_shrink_slab_end,
 	TP_fast_assign(
 		__entry->shr = shr;
 		__entry->nid = sc->nid;
+		__entry->pid = in_task() ? current->pid : -1;
 		__entry->memcg_id = sc->memcg ? mem_cgroup_id(sc->memcg) : 0;
 		__entry->shrink = shr->scan_objects;
 		__entry->unused_scan = unused_scan_cnt;
@@ -280,10 +291,11 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->total_scan = total_scan;
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %u unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %u unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->pid,
 		__entry->memcg_id,
 		__entry->unused_scan,
 		__entry->new_scan,
-- 
2.33.8

