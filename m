Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4A1684A4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745474; cv=none; b=GV9SWZqZ3GjkuqT//hT4SOWW3Nvzsh0zdsQ+kA0QzDsPtEf+mfBlMFA3RZSS8KH5rbIpKrQaSzEc6AQoSBYZSgwTf7mrdtd0jgbwouykqW3qJJnAUw4suBykUpdd2RBU38lAfjXQv+YFTiptAks0P3gMErVqMS32pLTHhyzP/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745474; c=relaxed/simple;
	bh=sm6kqVtf0K7w9K5dHVkvn/+lh489TTX6PtRzV0xr6ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9VPaMlVKq1Nr/NZ0MZr7bjwV/6+vZcLakKRjxdk7VBTaCbwX4CIlhiBBpj7KnguiHzqv2Gui4qXHB2ksxAWWuie52VLXM6M73+avzXQ9rQgu7h8Vl+uOkP9+VhTHv2YgVtepIQ3ekaJyEJOSzFNghguSNMrrRBZ5mkntkN1J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0t7zosi; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0t7zosi"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121b14d0089so996457c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 16:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767745472; x=1768350272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P4NEy/evxLtquvElmXdudeXmemOTXjDwfQllVxs2DqY=;
        b=F0t7zosiH3izpfMDrfwKcE/IqMHc4OrZGg+iWev4M7ZFNJKaPEEM0ekfL+RjmgYIeZ
         H82ZC928orKjBvuKI69wxoZ6YQSdEeXHUrAiZ2w32aU6JRHmVoDbF3ftQJ8mGq/flY9B
         FZECfWrFXFkbQBmLwq8SvspOhmg44gUK3z/ktI4oNbEOy7GIBflkpdoGCmuPiSLPJ/IF
         nfgmLlVQWWHxbY0aBVIeIEljHbDULDvPz/8bsxA0eq4/5w4XZzawh/zTsPfoJBXN9pUx
         t9gy7md8QQoT5vvyUjMW/Pi67S2Huy5x7/yt5xXFaaQ7MlMX5vz0G9zFAXVXOFhCo9Er
         iB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767745472; x=1768350272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4NEy/evxLtquvElmXdudeXmemOTXjDwfQllVxs2DqY=;
        b=kfIhWLCXN+aimzLtkDmKzYd0dreFydX14GuCVmalclZvxUriiyIuQ0Y8tlWg6f7HNk
         JU+CW+JibyTavHL3HiCQf3fQefvYLMkqkZFLgXUKZpODjmNtdBu6D4+leVPAWufiaxxo
         EA1SXg3cVkLppCAJos0qQlw+UAP49eHRntR0XtxNNSPozdp0jpDjnAmEUeDC/Oaezc+f
         MkTNFo6i2sSg3gpQDobG0Tp6qZbKRgdZrnYnDddNUVBFYTUpAlyZJUXyvCIRVlTTtzC5
         EYRPlHdXuxTSCLAz4Hsy9E7jCCVsYp3gqTo5UhzfQzXbMGdyxNMcsYGNxcBruA++EU+s
         9d6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/6E4jWhpkFEmhnenSnvxhWpMbLR0QntnOAWRYT5mP1YCV4mitEsiGMTS4Bc5hIC9FbrLJoTHuK8xisK58g0VEy8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgDFL5kUiowL2T0J5Q+ChYyJgXZqhYst2bWkH0mNSZg71Zcl9
	UOvZXePpEg2+fbeQLjaVPhk1RxQBJ9exrKZ+JTWB3CjMP1qUG1fPpGXQ
X-Gm-Gg: AY/fxX4evcs/uBFc4uQUfYWhb5O3iBT6WL9p4irtLDD6ZQScZj+dVKlal99910hJalp
	Q0PYXchpRpvgayqP8EhjwmG1XqXfkgk4oMQaSqHRS+5mwoXmWDhV/afrswQn+eKsW7lzSGlKrKx
	mRj+CRG5NEzpNEZfHpwg1oaHSuUhAwz0jNcfdYASHyjCHC5d30YiUosJwDw59gQFTf+y0xzKHB7
	oXSSVKlr7xSB3VvLpDEMOGgfQWgMiZjAJFe5esG3ZFVtTJeNC3SWy9S0vxWV1rGR+6cVVJA2PpK
	LI2T/rMmnegkzyAeG+Dc18CoPRT61LJzBtJito/NS+mM+EJkpEy0AsDeri0SyTqsaavPqYn0mVG
	z66xuwc0aMc7b6Rg7yEfuRB/S0KZbJ8LA0RNkcLEF6z2JzGJ0PaETbf+SZOyeX62BYkx4tDYrX2
	YEl7dWNS1ZRa5JhQ//XLcMp1AQ
X-Google-Smtp-Source: AGHT+IFztVj1GjS3hGk8PSehzOb66RD2mNwcrW4HjOGIQh/h0nLbKrSNKm9X49kajXJ6WyTEXQ7M6w==
X-Received: by 2002:a05:7022:41c:b0:11d:bea3:c93d with SMTP id a92af1059eb24-121f8b7931bmr499008c88.29.1767745471463;
        Tue, 06 Jan 2026 16:24:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24985d1sm8240642c88.16.2026.01.06.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 16:24:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Date: Tue,  6 Jan 2026 16:24:28 -0800
Message-ID: <20260107002428.2904852-1-linux@roeck-us.net>
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
pages to avoid having to calculate it. Drop the code calculating the
actual page count since it is no longer needed, and with it the warning
backtraces. Also drop the ENTRIES_PER_PAGE definition since it is no longer
needed either.

Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Have ftrace_allocate_pages() return the number of allocated pages,
    and drop the page count calculation code as well as the associated
    warnings from ftrace_process_locs().

 kernel/trace/ftrace.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef2d5dca6f70..755a11f13808 100644
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
 
@@ -7304,30 +7305,6 @@ static int ftrace_process_locs(struct module *mod,
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
-		unsigned long pg_remaining, remaining = 0;
-		unsigned long skip;
-
-		/* Count the number of entries unused and compare it to skipped. */
-		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
-
-		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
-
-			skip = skipped - pg_remaining;
-
-			for (pg = pg_unuse; pg; pg = pg->next)
-				remaining += 1 << pg->order;
-
-			pages -= remaining;
-
-			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
-
-			/*
-			 * Check to see if the number of pages remaining would
-			 * just fit the number of entries skipped.
-			 */
-			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
-			     remaining, skipped);
-		}
 		/* Need to synchronize with ftrace_location_range() */
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
-- 
2.45.2

