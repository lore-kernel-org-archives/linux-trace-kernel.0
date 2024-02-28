Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235E210EC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097106; cv=none; b=g3ZvmJZrnSQ2cgMKC51ckGtgkuiSw/lK3M1W8gw7S8q1TVpBy1uGZn7QMYZJ3evoFO9xBLFzT8Pg04KMIYmcdWqavrtFHszmohwj9HqrLidgu9nJhtBzKnMZt7iiSPr1+UjbIjjD8Ih9OZZE8QhiV7gQX8CXqCnOPkTGb9zG8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097106; c=relaxed/simple;
	bh=CJHY3E3l0STl1mnEmS9k7x6uJ3VjL+97RnCR4NbqExw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uonij0THXqx56/brx5W/FGtSWBAjKpdyvlOqDwolLMcXBKDJAy9y5Ar7taLYJjKLmjM64tXje8wlfagCJd946SMfccFTRHQbmlnnKtUtS8/5vR8EL+CtVoNBOSYlnJ9gssVZJlEgpeevkupzeVPi+3K7UTqmYCZSZNdxOXHCNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sg8xeHhZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sg8xeHhZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so82232187b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709097102; x=1709701902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqML4vY0pGUSQ+ssAelgPTzgnCg/ot5G0/OjWps3luM=;
        b=sg8xeHhZkApqcWnjmVQO3DfekVWLtaf2cMm/zfkMvNy4mIWcEuLpAp7o0dedNZ0uWr
         hLEbhhK79KgBpqtCzufyVsF2mqwJGr1JrWgbb6dEanUiRTlS6J9wkDdrknOSsoDDRmyU
         ijL/j2jj8IrjiIiud7IWFL7l6R+Dp5tLTg7K6p2CFaiMO95l3kKXXG2cir94YDQHez8K
         js5Nv6yoDSj4kWhUuKq4FqBXoW+Bw6iT3ozvCIAae7NcLFZRZ+jsaYipgi0eynK5Uro7
         mdKkAFMYS3g84foDc573bLbIhyPs8m/8YIBXuuCJ4q4XrbmeIWU3QOL5bEhlzewiNFj5
         Fyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097102; x=1709701902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqML4vY0pGUSQ+ssAelgPTzgnCg/ot5G0/OjWps3luM=;
        b=uJQaedgS7m+hk3YXnE3c8x+rKzW0ta3s3oyOy3IooP/aSoWoV7fNg7NVFGFgMxsQ+r
         k/0u01sP/D9JnNnA15qysk9RCNrlGdvWIOrx/V0MlXgPOwWNNn0Pl2V+cZelcHzPQYWs
         JjQtu7sUq7MV906pGJDF+mqMpBMpKdYGx+TYobld/o94XnaO2JH/TP9++KHWXiMqMCJj
         lIMGIlHeoTBa2oNJAVfFhPc9+KaJufzV0ciniTOnMrsqpemk0xCWNvYgZBrKygJ8x6XJ
         xB0VdvQ3yarBQOEkPoU9VFlieB37cv0ekpKOFRxmjYzKq9SsfJyHVxitpAC+Shn3RtQ3
         q31g==
X-Forwarded-Encrypted: i=1; AJvYcCUCXb26SPSujESIaJCUW/XGhDLJCcI1waZQYcCGzBnzR8Krjql4YSKrrWCT91LeaVHNevH0n0xR5jgFvj0FB4g/yasyVDpUxM7NCiiwjg0QUmsj
X-Gm-Message-State: AOJu0Yw6gNzVV4PrdBz9/J1uPVdsxiQKjBFyzvQiA71fFGOVXCmsncF0
	5Ltes00zE8K0PthsBnkYYGIlMhGpx8uf5EARXBf6alAnyOkewRgbKm00rVXGIitc6DU/S9ozEDW
	kooO4PZcHE+LX/npb
X-Google-Smtp-Source: AGHT+IHyzMYAk41ghRY9BmWyJ7wM13H2JKhk13gZrcP4KgPdiL8ORxRnV4ac5QW5ZsOurSY8RayignJdNKweROeL
X-Received: from richardycc.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:f5f])
 (user=richardycc job=sendgmr) by 2002:a05:690c:88:b0:609:247a:bdc5 with SMTP
 id be8-20020a05690c008800b00609247abdc5mr955171ywb.4.1709097102017; Tue, 27
 Feb 2024 21:11:42 -0800 (PST)
Date: Wed, 28 Feb 2024 05:11:17 +0000
In-Reply-To: <20240226120728.3f495fa7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226120728.3f495fa7@gandalf.local.home>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228051127.2859472-1-richardycc@google.com>
Subject: [PATCH v2] mm: add alloc_contig_migrate_range allocation statistics
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
* from v1 - https://lore.kernel.org/linux-mm/20240226100045.2083962-1-richardycc@google.com/
  * Move the trace event int field to the end of the longs - rostedt
  * Do the calculation only when tracing is enabled - rostedt

 include/trace/events/kmem.h | 38 +++++++++++++++++++++++++++++++++++++
 mm/internal.h               |  3 ++-
 mm/page_alloc.c             | 32 ++++++++++++++++++++++++++-----
 mm/page_isolation.c         |  2 +-
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 58688768ef0f..6e62cc64cd92 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -304,6 +304,44 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(mm_alloc_contig_migrate_range_info,
+
+	TP_PROTO(unsigned long start,
+		 unsigned long end,
+		 unsigned long nr_migrated,
+		 unsigned long nr_reclaimed,
+		 unsigned long nr_mapped,
+		 int migratetype),
+
+	TP_ARGS(start, end, nr_migrated, nr_reclaimed, nr_mapped, migratetype),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned long, nr_migrated)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_mapped)
+		__field(int, migratetype)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->nr_migrated = nr_migrated;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_mapped = nr_mapped;
+		__entry->migratetype = migratetype;
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
index 150d4f23b010..da169fa20d8e 100644
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
 
@@ -6257,9 +6266,18 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
+		if (trace_mm_alloc_contig_migrate_range_info_enabled()) {
+			total_reclaimed += nr_reclaimed;
+			list_for_each_entry(page, &cc->migratepages, lru)
+				total_mapped += page_mapcount(page);
+		}
+
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
+		if (trace_mm_alloc_config_migrate_range_info_enabled() && !ret)
+			total_migrated += cc->nr_migratepages;
+
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
 		 * to retry again over this error, so do the same here.
@@ -6273,9 +6291,13 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
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
@@ -6355,7 +6377,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
2.44.0.rc1.240.g4c46232300-goog

