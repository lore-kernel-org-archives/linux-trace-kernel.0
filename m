Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6C1F8BD6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752547; cv=none; b=sqhE9jmqaMAoaljFvlxh7rQHxvU7xV6TDnOaP3Hd/zmuMfCfaQI628mhvrx0KEpIICc2/xZTvI5CMCw6vBdttUa5C5XwzVNt/sv7fqh9FnNPlwY0McHh0LnbtKEqKF5kBebizhLI+NS75aOI/Y33u6R6JYVm8adK3xla0I6EIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752547; c=relaxed/simple;
	bh=8SYFwo/boI3SmOD9mmlGdc/tMJSs3M7ul1skNdTl9IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q90b1YBMRrghFHw4kFixVXEvrOe+uCdwiwwGCNfgrzqW6haC2fHJJAFhL9sMwt2tJbuQCgJBgiCB0EesUSuO4Ww5MiFIdt3mR9JhVREg96hip/tIlooH48Oc44qtf3o0R3X12cME6r/Ukt54I7YSe2CYk83yrc4fMLnzj6VnpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDh4KXYp; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDh4KXYp"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2abf5900cd5so1032284eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767752545; x=1768357345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+pY3++RoIvY9aLRkJUNxdKswch5gwSrkeohy6VF0XP8=;
        b=bDh4KXYpLdmpHCN6nq9N53Q2pZ6GAFydJ6z+WIZ76/+8f0i2NTL7U9hC1p0YovX158
         hyNRHcSMmJcoyBBSl2DvJEsR1CqviTmH3ALwFp21P2Ct2NUAKdUKGLjh2OxyTe30BIYF
         WwuengOHwV2Us82fXSeuT3jY7dU9nivJQ1iV8CA/7k2o3RmOdOT+qqM9uGA5KSkfLR3M
         lV5RycMihLxIY9JdLM7yMuR0WcGODOWWL3NhC99zCtx2HXJKzzNx+JEPrtu6tKnxJo2Y
         b50EYBMnko0qQYPM1Gt6W5nAR5ExBWu+XX/oc2Olh/RNcAU+3sLHA/MkMW9DISKDrsX8
         inQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767752545; x=1768357345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pY3++RoIvY9aLRkJUNxdKswch5gwSrkeohy6VF0XP8=;
        b=qWlGC4I/jRrsc10t/QI/xFjr2KYsP5Kt4kDy9bf9Lejzoe5z85v7Gp6uEZV0zqfd+C
         equBveG8S8TKzwm/4rSjh1PKgQi88FiifQBpjHcGk8OKM8zYpz15fmWiky9Drn+eOknY
         40HhmBYehNpJmVQc0d3iNAij430Q3mS0IGIOvJTmjL3joQiRtrD1ZPJqADcUrTeLY0MJ
         mo39Xtd8jUmdBQ9AfyKxXuyu0gjXLx0HCARYTsa1cdKQYzxQAFVcqokVwnUAaBH/C0q7
         n0Q9l34c2zl+E7AtjhFBMBxAn00dE35iRUI3PwRQEadT3/l8mBhc9uKmTGFdWbwH4vHm
         7QsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeDGzS8QDoROUQEFHf+t78IXdhiRxJdHCsZlBopzoi5FiOozYecpo7yMP2jG6vFYlCbXQbQQRMGfi0YNSVc6dREP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RXWBmFkYOftowvLD5ZtXJxJYLGWCruNNmV9MxeTb51OBuP4t
	CIYy6Y7fpQpvubdz+x4+XNVl8cpzx3EnS07yjEXY9UrbXXP+16EC7U4w
X-Gm-Gg: AY/fxX7JD/ouOHLzlrMC6/r92v9dEPBS5oLM239NDDpGfaPVKDGAbqcYtV/yqjj3x2/
	xO/qpr8Y+48RCCapyUZJL3CSIcbMJJFwP7VnxVwL5YEaq8t4AjRBeJL17Dow7tMQyjgEqtnoLPe
	3fyO9+H8N0yZV7n57nsAnxk+6fXA+RBOKiq71YgUpHLFmC87aCVGXD97owyjx3R1FWwAVoC3FhM
	nLzFAWPC42LQ8gkNPvYnKbjO3boJY0FVlOhB1YrtPDZs1KvGqxOc+Fw+RyFocng0KGUJ+8doEBs
	yVw6Q+QXMmjQoCJxgP+OrYIrmrHQfUEKF2iBwhegiLNRCJNUB8vd7FBkMU/yaw2J9znPa4SrdoC
	44alYAAcCZgBOmWaiOtxURVDN3s2NNm1QF6LtkTIdUvlu0v2TwV9uXa8IAEGFrsjcHfQ3//o0Qu
	1BaMd/aHksZM0SE/yBQmyNk/32
X-Google-Smtp-Source: AGHT+IHZti3mnv8gmCGd0QAiWAd3nZiv7YmKqZBeP56OJEuXwRFyMkXjh8gyhHfXutXJFnWxAhGyYQ==
X-Received: by 2002:a05:7300:8622:b0:2ae:5b71:d226 with SMTP id 5a478bee46e88-2b17d1fa677mr829927eec.3.1767752544956;
        Tue, 06 Jan 2026 18:22:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078d818sm5445604eec.21.2026.01.06.18.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:22:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3] ftrace: Do not over-allocate ftrace memory
Date: Tue,  6 Jan 2026 18:22:21 -0800
Message-ID: <20260107022221.2907717-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pg_remaining calculation in ftrace_process_locs() assumes that
ENTRIES_PER_PAGE multiplied by 2^order equals the actual capacity of the
allocated page group. However, ENTRIES_PER_PAGE is PAGE_SIZE / ENTRY_SIZE
(integer division). When PAGE_SIZE is not a multiple of ENTRY_SIZE (e.g.
4096 / 24 = 170 with remainder 16), high-order allocations (like 256 pages)
have significantly more capacity than 256 * 170. This leads to pg_remaining
being underestimated, which in turn makes skip (derived from skipped -
pg_remaining) larger than expected, causing the WARN(skip != remaining)
to trigger.

Extra allocated pages for ftrace: 2 with 654 skipped
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7295 ftrace_process_locs+0x5bf/0x5e0

A similar problem in ftrace_allocate_records() can result in allocating
too many pages. This can trigger the second warning in
ftrace_process_locs().

Extra allocated pages for ftrace
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7276 ftrace_process_locs+0x548/0x580

Use the actual capacity of a page group to determine the number of pages
to allocate. Have ftrace_allocate_pages() return the number of allocated
pages to avoid having to calculate it. Use the actual page group capacity
when validating the number of unused pages due to skipped entries.
Drop the definition of ENTRIES_PER_PAGE since it is no longer used.

Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Restore the code calculating the number of unused pages due to skipped
    entries. Use the actual number of entries per page group when
    calculating the number of entries in unused page groups.
v2: Have ftrace_allocate_pages() return the number of allocated pages,
    and drop the page count calculation code as well as the associated
    warnings from ftrace_process_locs().

 kernel/trace/ftrace.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef2d5dca6f70..2c9692b45215 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1148,7 +1148,6 @@ struct ftrace_page {
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
-#define ENTRIES_PER_PAGE (PAGE_SIZE / ENTRY_SIZE)
 
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
@@ -3834,7 +3833,8 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	return 0;
 }
 
-static int ftrace_allocate_records(struct ftrace_page *pg, int count)
+static int ftrace_allocate_records(struct ftrace_page *pg, int count,
+				   unsigned long *num_pages)
 {
 	int order;
 	int pages;
@@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		return -EINVAL;
 
 	/* We want to fill as much as possible, with no empty pages */
-	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
 	order = fls(pages) - 1;
 
  again:
@@ -3859,6 +3859,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	}
 
 	ftrace_number_of_pages += 1 << order;
+	*num_pages += 1 << order;
 	ftrace_number_of_groups++;
 
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
@@ -3887,12 +3888,14 @@ static void ftrace_free_pages(struct ftrace_page *pages)
 }
 
 static struct ftrace_page *
-ftrace_allocate_pages(unsigned long num_to_init)
+ftrace_allocate_pages(unsigned long num_to_init, unsigned long *pages)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	int cnt;
 
+	*pages = 0;
+
 	if (!num_to_init)
 		return NULL;
 
@@ -3906,7 +3909,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	 * waste as little space as possible.
 	 */
 	for (;;) {
-		cnt = ftrace_allocate_records(pg, num_to_init);
+		cnt = ftrace_allocate_records(pg, num_to_init, pages);
 		if (cnt < 0)
 			goto free_pages;
 
@@ -7192,8 +7195,6 @@ static int ftrace_process_locs(struct module *mod,
 	if (!count)
 		return 0;
 
-	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
-
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
 	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
@@ -7206,7 +7207,7 @@ static int ftrace_process_locs(struct module *mod,
 		test_is_sorted(start, count);
 	}
 
-	start_pg = ftrace_allocate_pages(count);
+	start_pg = ftrace_allocate_pages(count, &pages);
 	if (!start_pg)
 		return -ENOMEM;
 
@@ -7305,27 +7306,27 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		unsigned long pg_remaining, remaining = 0;
-		unsigned long skip;
+		long skip;
 
 		/* Count the number of entries unused and compare it to skipped. */
-		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
 
 		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
 
 			skip = skipped - pg_remaining;
 
-			for (pg = pg_unuse; pg; pg = pg->next)
+			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
 				remaining += 1 << pg->order;
+				skip -= (PAGE_SIZE << pg->order) / ENTRY_SIZE;
+			}
 
 			pages -= remaining;
 
-			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
-
 			/*
 			 * Check to see if the number of pages remaining would
 			 * just fit the number of entries skipped.
 			 */
-			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
 			     remaining, skipped);
 		}
 		/* Need to synchronize with ftrace_location_range() */
-- 
2.45.2

