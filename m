Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D035F607
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886291; cv=none; b=aCsToWXqWLD5n+wpexJ+xbADi6eMH5CPkXFkWdNLpamQt1vBRfzb8vCWMqsZatMoYuO2xNEY5j2//cBNquvn51MYLPWlErF+hteOf1lLTtOGx9yxgBRfhHv4x6tGWJeuR3/ZfYu3Djgk+Mo2yuo8AOEUOe5ErjGNcYtTPArWEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886291; c=relaxed/simple;
	bh=Y4YpGMARZG9c6LwBaYM7iJMqslDF6brT9TtTvVI+1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+LvmlmQL1T9J2VJUAo5sef69gnVu7RbHaxKDDkgZRxZT2iOLIr/bwh8ZJ8egCXoI2jujaDhWveq9fvDBlDgmCKeVY8VUGR1fdFYgao+mLuMVXXxHjW4r7ln7vj1V305dmW0hrFZXoqjOSGFbSBR+uBzzfQWWMVHhFaqp4pQ9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iko/I6mh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iko/I6mh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782886288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Uz52W8u4KLE/aWGQJH75bXXpHks/NCvUx2zWmpBg4g=;
	b=iko/I6mhDklMHU9Av9nnniz5aa2jVuM3/ZmVAzK3hNkRwZUaeehoM8GoKgJufwtelvlREa
	Oufuu1DvfhdeV9rOrj4R/rc1uDI8kOiM9IL6dvm+YoAFjDHZvQwlhuR9JgN/QNnY4zcr1+
	qfGmikPXBZc94e5AkMUoW8zm9E4betw=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
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
Subject: [PATCH v5 2/9] mm/page_owner: add MR_NEVER to enum migrate_reason and use it for last_migrate_reason
Date: Wed,  1 Jul 2026 14:10:45 +0800
Message-ID: <20260701061101.344679-3-ye.liu@linux.dev>
In-Reply-To: <20260701061101.344679-1-ye.liu@linux.dev>
References: <20260701061101.344679-1-ye.liu@linux.dev>
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
macro, and updating the GDB page_owner script to use MR_NEVER instead
of the hardcoded -1 so that lx-dump-page-owner does not incorrectly
report unmigrated pages as migrated.

No functional change.

Signed-off-by: Ye Liu <ye.liu@linux.dev>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/migrate_mode.h    | 1 +
 include/trace/events/migrate.h  | 3 ++-
 mm/page_owner.c                 | 8 ++++----
 scripts/gdb/linux/page_owner.py | 4 +++-
 4 files changed, 10 insertions(+), 6 deletions(-)

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
diff --git a/scripts/gdb/linux/page_owner.py b/scripts/gdb/linux/page_owner.py
index 8e713a09cfe7..eeabaeed438b 100644
--- a/scripts/gdb/linux/page_owner.py
+++ b/scripts/gdb/linux/page_owner.py
@@ -34,6 +34,7 @@ class DumpPageOwner(gdb.Command):
     max_pfn = None
     p_ops = None
     migrate_reason_names = None
+    mr_never = None
 
     def __init__(self):
         super(DumpPageOwner, self).__init__("lx-dump-page-owner", gdb.COMMAND_SUPPORT)
@@ -65,6 +66,7 @@ class DumpPageOwner(gdb.Command):
         self.max_pfn = int(gdb.parse_and_eval("max_pfn"))
         self.page_ext_size = int(gdb.parse_and_eval("page_ext_size"))
         self.migrate_reason_names = gdb.parse_and_eval('migrate_reason_names')
+        self.mr_never = int(gdb.parse_and_eval('MR_NEVER'))
 
     def page_ext_invalid(self, page_ext):
         if page_ext == gdb.Value(0):
@@ -138,7 +140,7 @@ class DumpPageOwner(gdb.Command):
         else:
             gdb.write('page last free stack trace:\n')
             stackdepot.stack_depot_print(page_owner["free_handle"])
-        if page_owner['last_migrate_reason'] != -1:
+        if page_owner['last_migrate_reason'] != self.mr_never:
             gdb.write('page has been migrated, last migrate reason: %s\n' % self.migrate_reason_names[page_owner['last_migrate_reason']])
 
     def read_page_owner(self):
-- 
2.43.0

