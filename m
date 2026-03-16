Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBF329E6C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677365; cv=none; b=WTG5rRy627cPYlZGOGSzZryaa7JL6vEoyvBY17H7bmjiEmSc3dcSf66f+7eBv8gssIvla8E/EVh9SYJ7iNMV8vLO2lKWAJohZ+Cng9B0m5germUyq4AFYj8fvJSjUuokdVHLLm+G9J648iUkdLYyqcjm71qRBkQPH6a3cIEmuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677365; c=relaxed/simple;
	bh=ZbESQgROV0hqrHE3lOVIl3pvm2CqxX6RbxEhdiqzHZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iftrMaEcL+lGMN8ZhW1kRmpYYtRUXUTPfI8m3bQrTZYQvSbMu1rFNemgHDKr39diojaeOGWr4KYEv7rk425sCViMymxIOJJo9OaI64j5Lyc3M8RhvWxAV0Qkf1Mmn3horHoekCM7hFBxDSAZf8jlKh22IxGfXJbknPXFK/0IN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FB3cdTRf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FB3cdTRf"
Received: from LAPTOP-U3CCR7C6.lan (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9F7020B6F12;
	Mon, 16 Mar 2026 09:09:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9F7020B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773677364;
	bh=VcslTGd7Gwos3Z8Yii274STD1R1lKDBM+pUFy34ylok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB3cdTRfo3+snO46oMEGmJXEAuozyG8yA+S+kxdnoj/rjSJxeeCwC8n6x4JvSRfEz
	 aSCn5sQzAcOzLMEQ0U5O/oxpOjV/Bc/zTn0BCBuW93O8Ew4QESji7iisuaobP1l6OZ
	 kcmkcnNYQoMmQhkFnqHTqkmH2dCMseIe2uj/RiwU=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
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
Subject: [PATCH v8 3/3] mm: vmscan: add PIDs to vmscan tracepoints
Date: Mon, 16 Mar 2026 09:09:08 -0700
Message-Id: <20260316160908.42727-4-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316160908.42727-1-tballasi@linux.microsoft.com>
References: <20260223171544.4750-1-tballasi@linux.microsoft.com>
 <20260316160908.42727-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The changes aims at adding additionnal tracepoints variables to help
debuggers attribute them to specific processes.

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
---
 include/trace/events/vmscan.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1212f6a7c223e..645b036572707 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -130,10 +130,12 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 		__entry->memcg_id	= mem_cgroup_id(memcg);
 	),
 
-	TP_printk("order=%d gfp_flags=%s memcg_id=%llu",
+	TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%llu %s",
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->memcg_id)
+		__entry->ent.pid,
+		__entry->memcg_id,
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
@@ -175,9 +177,11 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
 		__entry->memcg_id	= mem_cgroup_id(memcg);
 	),
 
-	TP_printk("nr_reclaimed=%lu memcg_id=%llu",
+	TP_printk("nr_reclaimed=%lu pid=%d memcg_id=%llu %s",
 		__entry->nr_reclaimed,
-		__entry->memcg_id)
+		__entry->ent.pid,
+		__entry->memcg_id,
+		__event_in_irq() ? "(in-irq)" : "")
 );
 
 DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end,
@@ -238,17 +242,19 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->memcg_id = mem_cgroup_id(memcg);
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu objects to shrink %ld gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->ent.pid,
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
@@ -280,15 +286,17 @@ TRACE_EVENT(mm_shrink_slab_end,
 		__entry->memcg_id = mem_cgroup_id(memcg);
 	),
 
-	TP_printk("%pS %p: nid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d",
+	TP_printk("%pS %p: nid: %d pid: %d memcg_id: %llu unused scan count %ld new scan count %ld total_scan %ld last shrinker return val %d %s",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
+		__entry->ent.pid,
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
2.45.3

