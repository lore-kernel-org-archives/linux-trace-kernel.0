Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126E1DA53
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941711; cv=none; b=gCO/N+g8b/GWxAJjyHaIaOse7Z31YOZrsiEZ/51vpTRkY1isdwBMyYrgJnBe8wbCvt1MkMGB01GJ1FubFtMKjBbLflbu342DQVeOn40O58Uqx5SHid48uyrqs4pXj7Nf/reK5AcV06r9j/+yu3sXH/0s/epKrXhoGiupXPuZ3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941711; c=relaxed/simple;
	bh=W/nEdRu05n//+j4BnofLYmeUB0FRNpUFT1+Eakz+t/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MWgpkoWpJq9zK0wW1GnOWTuumtlI4/wx6wRdDN1WEzs6c97ia/XwS8aLRwUQ7a77AlnnKvghi/AbkIKmefck+kjkyFfdR41GA+Ayb/48vZui5VeCvsSQeskkhvRNpIl3eg+KRJB7P5nLA4xvWAUPA0KW5Y+uPQwmavIRtQ8o0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT1H4Mak; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JT1H4Mak"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e52f20d0efso602956b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708941709; x=1709546509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gyI/MoWdVSABhMtiVRAkTZHZn+lW5oiA7R70q9bef8k=;
        b=JT1H4Mak/f0DteoRvLE7is0PNc5FO0OHrng4Mf9ICcUMUzU4XAXmjYm2otsqhB9pOh
         fWOSux+g9ELQ2+G6i3VJayjSimcEbXfpPuX6/0Mhisyp/Rockfo0Uoy6oYdoZNkQcTuF
         S5lAiTVZts8Trx5cbcm0iBiH9QjSTcKSDjnAfpWpC0PNfQ1v9ji0LfIsAUWMt19YZQBo
         V0dVpVDBWQx6hn8m9aoGqgXK/N2gaV5vUCrvcrFEjAN5bgppygzXcU6nTX6Ew7WoFke3
         lKzQ2MxoFS01GqlauGZy0/rs0nBwy/xPG1rA8UoBSWth2hAAdsadfu8F0uZSTy5vEwQF
         8GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708941709; x=1709546509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyI/MoWdVSABhMtiVRAkTZHZn+lW5oiA7R70q9bef8k=;
        b=pLEUws6GKjSiFNo9vKHcDfDtEtPwHzk7M4ZxuWFRTR3MozjCxWcgSW9swjhfAIBDot
         EIE3Q/f54iWHH+4/Vb8Rn5uksD3oXkWOhhtV0qWXcoe7vXzkgNSNBzovFjGCrJhZUfWu
         GAeFmyDqmcPkXGW9eNoY0Id9sJ5Syq5DCO/rwNXBXlFfe7P/b/7GYKslNwVrP4Hyzhum
         TWh1wgyqglE48ibW+wqMp1XFtowZWMWqPVKQ68n0QxgwCa14oCpzQypt5+f6h06Q1xcB
         Oxqbgy35QG8wSX/qJNxAKfapmxjWFYTxs3hfGEBeRpY2oRJ01bIDVpyo1eIeuIJEK4n7
         /U9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/jndtBJpQoLf4+pcXfSqPpOBEDoVOvbZq21qmgoy5jK4KFq44yt/RvH+35hzJTywLTjkQUQFPx/rul5a+tPdITyRBsXEg5LgFCbbcYMIO6Wg0
X-Gm-Message-State: AOJu0YzMacbQXYf1qg7SX3dJofm48qQZwWAhOQL9qszHnzopQMlduscE
	zjUGGS+pwsKLRwD2m/yJUXMJs9Krkg9MdDPh4U/3mxoqFUsPJ4wIzXHXeAXrZWe+1SDSdJO2hBQ
	VglvjF8SAlDLYkniX
X-Google-Smtp-Source: AGHT+IHsMsnGd+L6Ih3NO8l76Y1KOj9vYrg8gPa96vnLXi5uITU09PrnBtcNIlKstccydMSWJ4PxB/iLZvaiHzoW
X-Received: from richardycc.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:f5f])
 (user=richardycc job=sendgmr) by 2002:aa7:88d4:0:b0:6e5:3590:5dc3 with SMTP
 id k20-20020aa788d4000000b006e535905dc3mr9037pff.4.1708941709522; Mon, 26 Feb
 2024 02:01:49 -0800 (PST)
Date: Mon, 26 Feb 2024 10:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226100045.2083962-1-richardycc@google.com>
Subject: [PATCH] mm: add alloc_contig_migrate_range allocation statistics
From: Richard Chang <richardycc@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, richardycc@google.com
Cc: liumartin@google.com, surenb@google.com, minchan@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

alloc_contig_migrate_range has every information to be able to
understand big contiguous allocation latency. For example, how many
pages are migrated, how many times they were needed to unmap from
page tables.

This patch adds the trace event to collect the allocation statistics.
In the field, it was quite useful to understand CMA allocation
latency.

Signed-off-by: Richard Chang <richardycc@google.com>
---
 include/trace/events/kmem.h | 39 +++++++++++++++++++++++++++++++++++++
 mm/internal.h               |  3 ++-
 mm/page_alloc.c             | 30 +++++++++++++++++++++++-----
 mm/page_isolation.c         |  2 +-
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 58688768ef0f..964704d76f9f 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -304,6 +304,45 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(mm_alloc_contig_migrate_range_info,
+
+	TP_PROTO(unsigned long start,
+		 unsigned long end,
+		 int migratetype,
+		 unsigned long nr_migrated,
+		 unsigned long nr_reclaimed,
+		 unsigned long nr_mapped),
+
+	TP_ARGS(start, end, migratetype,
+		nr_migrated, nr_reclaimed, nr_mapped),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(int, migratetype)
+		__field(unsigned long, nr_migrated)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_mapped)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->migratetype = migratetype;
+		__entry->nr_migrated = nr_migrated;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_mapped = nr_mapped;
+	),
+
+	TP_printk("start=0x%lx end=0x%lx migratetype=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
+		  __entry->start,
+		  __entry->end,
+		  __entry->migratetype,
+		  __entry->nr_migrated,
+		  __entry->nr_reclaimed,
+		  __entry->nr_mapped)
+);
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..e114c647e278 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -537,7 +537,8 @@ isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end);
+					unsigned long start, unsigned long end,
+					int migratetype);
 
 /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
 void init_cma_reserved_pageblock(struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..f840bc785afa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6219,9 +6219,14 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
 	}
 }
 
-/* [start, end) must belong to a single zone. */
+/*
+ * [start, end) must belong to a single zone.
+ * @migratetype: using migratetype to filter the type of migration in
+ *		trace_mm_alloc_contig_migrate_range_info.
+ */
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					int migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -6232,6 +6237,10 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		.nid = zone_to_nid(cc->zone),
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
+	struct page *page;
+	unsigned long total_mapped = 0;
+	unsigned long total_migrated = 0;
+	unsigned long total_reclaimed = 0;
 
 	lru_cache_disable();
 
@@ -6257,9 +6266,16 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
+		total_reclaimed += nr_reclaimed;
+		list_for_each_entry(page, &cc->migratepages, lru)
+			total_mapped += page_mapcount(page);
+
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
+		if (!ret)
+			total_migrated += cc->nr_migratepages;
+
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
 		 * to retry again over this error, so do the same here.
@@ -6273,9 +6289,13 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
-		return ret;
 	}
-	return 0;
+
+	trace_mm_alloc_contig_migrate_range_info(start, end, migratetype,
+						 total_migrated,
+						 total_reclaimed,
+						 total_mapped);
+	return (ret < 0) ? ret : 0;
 }
 
 /**
@@ -6355,7 +6375,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index cd0ea3668253..a5c8fa4c2a75 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -434,7 +434,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				}
 
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
-							head_pfn + nr_pages);
+							head_pfn + nr_pages, page_mt);
 
 				/*
 				 * restore the page's migratetype so that it can
-- 
2.44.0.rc0.258.g7320e95886-goog

