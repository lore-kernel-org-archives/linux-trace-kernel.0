Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13E2C15BE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784435; cv=none; b=GN3b2HprNjQHoPFVjZWwdFUoknRCNZ822ZC9GDzEXlc+MOY9HSxV5hPtmmp/OZhm/00b+NwIW2ZKuwdLVm7VWjqmtcLtQ+sxDlruy5xBR7XwB9ivtM4AK0usAEAlkdUuD/Yt5EoX74m0l7NZ4wFzXaQ4bFdil7L5uhrhpzEbC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784435; c=relaxed/simple;
	bh=vnf7JPkMu9uAlmUFnocqbmWTOfwkd6mWLZGraSk0JA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvW1imDUiZfKks3iAU2m/BmP8kI/AlNsAmvP5bVHWhdIaDreSNGw0sY6/V/xKXi8ZXYSxpPSDVRoggaeePZ7fXN747UqOquZ4NplgtzyO89UBpPvz+EzgIi6BLlT4rxV9cYVNXhhaZ2vWpomZlmVpRpD/+7xj+SP/PD03MglW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TMgXlUlz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TMgXlUlz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782784430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+9YrpEU34OPDz2iHabTDbvzWefArLaf4fpVcXgkiMk=;
	b=TMgXlUlzodF1IoLeynZ74eaIyV4U7rjvQXiu7RJXnASDsdrob6kxCYb1iZ3Oj2sGEoImCo
	PpbCJQ3Y7D4H1RmilH3Ccx34B3/dsJZlglzP80/GxM6U5g9lqjT0ZKC4rAuGD3D7z53R4e
	iFzxQ+Akjbb+4xLM01Ojlc64dPgqoAM=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Ye Liu <ye.liu@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] mm/page_owner: add MR_NEVER to enum migrate_reason and use it for last_migrate_reason
Date: Tue, 30 Jun 2026 09:53:19 +0800
Message-ID: <20260630015331.147174-3-ye.liu@linux.dev>
In-Reply-To: <20260630015331.147174-1-ye.liu@linux.dev>
References: <20260630015331.147174-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The last_migrate_reason field uses -1 as a sentinel value to mean "no
migration has happened".  Replace the four bare -1 occurrences by
adding a proper MR_NEVER member to enum migrate_reason, defining a
corresponding "never_migrated" string in the MIGRATE_REASON trace
macro, and removing the local MIGRATE_REASON_NONE define.

No functional change.

Signed-off-by: Ye Liu <ye.liu@linux.dev>
---
 include/linux/migrate_mode.h   | 1 +
 include/trace/events/migrate.h | 3 ++-
 mm/page_owner.c                | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 265c4328b36a..05102d4d2490 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -25,6 +25,7 @@ enum migrate_reason {
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
 	MR_DAMON,
+	MR_NEVER,		/* page has never been migrated */
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index cd01dd7b3640..11bc0aa14c7e 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -23,7 +23,8 @@
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
 	EM( MR_DEMOTION,	"demotion")			\
-	EMe(MR_DAMON,		"damon")
+	EM( MR_DAMON,		"damon")			\
+	EMe(MR_NEVER,		"never_migrated")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 342549891a8d..c2f43ab860eb 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -339,7 +339,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	depot_stack_handle_t handle;
 
 	handle = save_stack(gfp_mask);
-	__update_page_owner_handle(page, handle, order, gfp_mask, -1,
+	__update_page_owner_handle(page, handle, order, gfp_mask, MR_NEVER,
 				   ts_nsec, current->pid, current->tgid,
 				   current->comm);
 	inc_stack_record_count(handle, gfp_mask, 1 << order);
@@ -596,7 +596,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (ret >= count)
 		goto err;
 
-	if (page_owner->last_migrate_reason != -1) {
+	if (page_owner->last_migrate_reason != MR_NEVER) {
 		ret += scnprintf(kbuf + ret, count - ret,
 			"Page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
@@ -667,7 +667,7 @@ void __dump_page_owner(const struct page *page)
 		stack_depot_print(handle);
 	}
 
-	if (page_owner->last_migrate_reason != -1)
+	if (page_owner->last_migrate_reason != MR_NEVER)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	page_ext_put(page_ext);
@@ -826,7 +826,7 @@ static void init_pages_in_zone(struct zone *zone)
 
 			/* Found early allocated page */
 			__update_page_owner_handle(page, early_handle, 0, 0,
-						   -1, local_clock(), current->pid,
+						   MR_NEVER, local_clock(), current->pid,
 						   current->tgid, current->comm);
 			count++;
 ext_put_continue:
-- 
2.43.0

