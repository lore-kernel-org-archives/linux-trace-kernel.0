Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31372E2665
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317769; cv=none; b=a4dBu72jwnfMP+M+3fijF15e+tDLWRhZA1Jp7wcEp4hte3Oadk8hUanxpoQVbxVHF8ilZ1rRHqJaHmdrvgIZmfPY46VlCyUq385Nrh5xBI0U6XHVY0dJ3O32bwD7eSKpOibQ4ou3tYuIkdZwn0I1bhsgkRPhmqU6ShVh7rvumxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317769; c=relaxed/simple;
	bh=v/pubWU2o+LF8Fm4+Pc9p0cSEU9u4yo7FopG5RQNfJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNXdOzkyoLezLtL1xv0lT6cOvzxb3VHMXITHnaQPKmdG4uZrzbBkmf9BlkAHDWbl9E9Euxp/bNz2OOkxigKjT3ZkLR+VNp00MIINVeY5BEju79DAW+Ey4avw1QQzN4evGj2bZ5pzeFXyEoX6bqoSX6ZWHmIFzJ0gdXBU2ZLwaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG13jeRA; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG13jeRA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f3a10dcbbso6980415c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 07:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768317767; x=1768922567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zPxkPE9vmpXrdgPOhaXZlpEE80loeUwlEanosBQMlkE=;
        b=fG13jeRAb2IvygqKgsOmxDodb9HjUylSVtruH6LCTCjHMElrWyI0vyjkEI6CGb2sFx
         3qz+nGg5H8IQ/kFmcr8OvvkI1dvi2nUiuEUP180cvpB1aiad5S6/yByMZ1U1okBVdjmE
         N3T3jHLj5RM4DjFk2T1FTJdHsK0b1zVgDmdRTegLjWdpHA6o8GIE2r4oNfi1gJDYI7Tu
         6p/uK/ITybqQ8eVGi0MYkS+WGUah+yDe8fsM4HRT6lnxREFeJRGiyyMR7jvSIn1WuR/D
         wUzKX8hordhbKuiZXHfcrUmAoIv/DgApbmBQa1rVqL6Hu+WNnZ7bMCq6sQ+L9SwFokoY
         ZyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317767; x=1768922567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPxkPE9vmpXrdgPOhaXZlpEE80loeUwlEanosBQMlkE=;
        b=TgqKu3c3O3MgmyV2GaMudyk5u68PpOEWAlI151VqoQJbFN5crebxi9a0Y69WIAS3AN
         vz5atAXE2ZUa8ijqnEKshYNl/WPFUWPKItNcFJfszUMZGUXgQhCkRWg66KpWan2VTNW4
         6BTexomLTFHIKvI0eaJiHcKQBHk52eAIFwiWFzthqJf2113J1kMELJPJhkUbFrMTx0g/
         2YN3sjvon0egPcl+Yxct7cqRuOgMEd7vrcNhmIBzAPu5IAL74vtFcm+WTWcS/1iRUu+W
         F2W7bxQtklMibqI6+pz+zSQF+eW3dmHSAS3kro8AIey+7f2tJU2vuR+7f8tgRGSDFmrb
         9WCw==
X-Forwarded-Encrypted: i=1; AJvYcCWIzLhuje7i2XSxRHM9gV8iAVXTgRauiYlm+uHC6Y//LY0yhaOIKTtAtpSbK6KxRi9wVuqLNYuIVcsoDBc8MgSbulw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLImMEPgkJ5+cxY8qPnTpwLgsle95X4E+ejrXOWCE/5zelg/gi
	nKt5vstXQtCIxerFE2ZeuR8wzonYDR/FB6Y2vGXlOSUo1NqwvnnPtAgx
X-Gm-Gg: AY/fxX4LOzCXWw+abUl+VfbjrQQWP22XqE4I6FNlZWWZQFhf+bP4GCrQtUAYx7qhaDk
	LAFuwrvhweyF/pvxahMQwl2EKbmvgXDD2WeiNZH9Pdl/NDGISLDbYFwMOHs4H+DfcZYx4e6+Q2z
	OZ5DF7ilNA13rdx1jkAe1ej3d3wjSCKHPbLMMwLU+z2P3SW0/mhdOBmwOzhTMWUjE6ml6sy054L
	AVrY7rgw2o6u5pqQ3BQ3haz0M4YrNh6Y4YuuYY16i34XFcF+hsTq1E3r6UOwJr60gPxth66RBlM
	uNIG/OcXylplD7COeSv8dbqDp8y9Tze1WBUY6lXTeqH3qvsYMrNW3cYzn1AeYd8TnvBbJ1DEeLo
	n0y/Ciqvxeppcilz+dC+Rher9ZmVGJ5qRrA90Zh5Knb3KLAhfr/omSYGfubOoTXl4a8nnsyHEqw
	rQTZWU8tIfmRxWyQ3jA4qxO/y9
X-Google-Smtp-Source: AGHT+IFrBeGudtLGN3TbOb8XjAbBsDY0cIkl8iWE7WbTTrBhiC0v+T4/xDYdLqW1IjHoQHTP6UPLyA==
X-Received: by 2002:a05:7022:43a0:b0:119:e569:f609 with SMTP id a92af1059eb24-121f8afbcfemr19437114c88.2.1768317766525;
        Tue, 13 Jan 2026 07:22:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm18316745eec.2.2026.01.13.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:22:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 1/2] ftrace: Do not over-allocate ftrace memory
Date: Tue, 13 Jan 2026 07:22:42 -0800
Message-ID: <20260113152243.3557219-1-linux@roeck-us.net>
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
v4: Renamed pages -> num_pages in ftrace_allocate_pages()
v3: Restore the code calculating the number of unused pages due to skipped
    entries. Use the actual number of entries per page group when
    calculating the number of entries in unused page groups.
v2: Have ftrace_allocate_pages() return the number of allocated pages,
    and drop the page count calculation code as well as the associated
    warnings from ftrace_process_locs().

 kernel/trace/ftrace.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef2d5dca6f70..aa758efc3731 100644
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
+ftrace_allocate_pages(unsigned long num_to_init, unsigned long *num_pages)
 {
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	int cnt;
 
+	*num_pages = 0;
+
 	if (!num_to_init)
 		return NULL;
 
@@ -3906,7 +3909,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	 * waste as little space as possible.
 	 */
 	for (;;) {
-		cnt = ftrace_allocate_records(pg, num_to_init);
+		cnt = ftrace_allocate_records(pg, num_to_init, num_pages);
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

