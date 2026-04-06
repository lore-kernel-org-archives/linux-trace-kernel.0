Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874132E6116;
	Mon,  6 Apr 2026 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471085; cv=none; b=CS/5wfmL7Xu93nVdmPmI2vBc8bEQ75EiCYVfv9yQRM7Z3nb45JNW8uxW+4Z+3J4KBDTYy4w9RatIBlsFvWrrbkqkIGTO/h4vDabhCC5myPA9zsx++i1+Fyk3fJc5J36Sg4wa6VdusbpJ/l1pvLgwTd64sAccW2lQYaWrQIYyuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471085; c=relaxed/simple;
	bh=IiX3iAIS0Tud3lHL61RRs72AmWZT7+Pt71cqRKLfPd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfjj4LJJKUCRKq4LGpiRhl0FHJac8D6pOgMKoWngh1NySSeAz0j4PYS4vREHdw6YqOVF5KbG5iEo/WZEtRDzZPA/bdtR/JuoZEQMCh7g9nT1AQrMzF26cfIPlLRwKPyXk72l0OzyZiMEEuLOtXBkHcChuot/KoFoT+sW6/g1vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAQwZ+Nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAQwZ+Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F4C2BCB0;
	Mon,  6 Apr 2026 10:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471085;
	bh=IiX3iAIS0Tud3lHL61RRs72AmWZT7+Pt71cqRKLfPd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAQwZ+Nj7rABoCnI6LeXzjUECnpc2cUoMog+F0vIVKrkR+KzNG8gjeiyUky816xjc
	 Rn4jl2h+2TW0827t5fEmkN2w7tHpF/BUfoRwXcZf0+anIH1m5vSLMR2XbDFK1bM/fg
	 axreEg9cUAfGcTK6tLXDAPphLjJXwsbDFVce1Qja165dVaHK+P+QDZQ4xztA0rqI9a
	 ys6nVfjXdXeJz6Ghr5TS8kF2gOYvTRw9lyQNmraHclZzIu9Jok8KMxhMXGN84PiLsU
	 CPQruPMEZmjPa+DBL8wPqAO6BzuLCtPsX9JahXePQ9oRshYT3L04O3jKyNBtw54jfP
	 MwFdfMaF6t4CQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 3/5] ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
Date: Mon,  6 Apr 2026 19:24:42 +0900
Message-ID:  <177547108231.259641.7993975668235545903.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To:  <177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com>
References:  <177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Skip invalid sub-buffers when rewinding the persistent ring buffer
instead of stopping the rewinding the ring buffer. The skipped
buffers are cleared.

To ensure the rewinding stops at the unused page, this also clears
buffer_data_page::time_stamp when tracing resets the buffer. This
allows us to identify unused pages and empty pages.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v12:
   - Fix build error.
 Changes in v11:
   - Reset timestamp when the buffer is invalid.
   - When rewinding, skip subbuf page if timestamp is wrong and
     check timestamp after validating buffer data page.
 Changes in v10:
   - Newly added.
---
 kernel/trace/ring_buffer.c |   76 +++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0c284094f7d0..518a05df6ef7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -363,6 +363,7 @@ struct buffer_page {
 static void rb_init_page(struct buffer_data_page *bpage)
 {
 	local_set(&bpage->commit, 0);
+	bpage->time_stamp = 0;
 }
 
 static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
@@ -1878,12 +1879,14 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	return events;
 }
 
-static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
+static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
 			      struct ring_buffer_cpu_meta *meta)
 {
+	struct buffer_data_page *dpage = bpage->page;
 	unsigned long long ts;
 	unsigned long tail;
 	u64 delta;
+	int ret = -1;
 
 	/*
 	 * When a sub-buffer is recovered from a read, the commit value may
@@ -1892,9 +1895,17 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
 	 * subbuf_size is considered invalid.
 	 */
 	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
-	if (tail > meta->subbuf_size)
-		return -1;
-	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+	if (tail <= meta->subbuf_size)
+		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+
+	if (ret < 0) {
+		local_set(&bpage->entries, 0);
+		local_set(&bpage->page->commit, 0);
+	} else {
+		local_set(&bpage->entries, ret);
+	}
+
+	return ret;
 }
 
 /* If the meta data has been validated, now validate the events */
@@ -1915,18 +1926,14 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_head = head_page = cpu_buffer->head_page;
 
 	/* Do the reader page first */
-	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu, meta);
+	ret = rb_validate_buffer(cpu_buffer->reader_page, cpu_buffer->cpu, meta);
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
 			cpu_buffer->cpu);
 		discarded++;
-		/* Instead of discard whole ring buffer, discard only this sub-buffer. */
-		local_set(&cpu_buffer->reader_page->entries, 0);
-		local_set(&cpu_buffer->reader_page->page->commit, 0);
 	} else {
 		entries += ret;
 		entry_bytes += rb_page_size(cpu_buffer->reader_page);
-		local_set(&cpu_buffer->reader_page->entries, ret);
 	}
 
 	ts = head_page->page->time_stamp;
@@ -1945,26 +1952,33 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->tail_page)
 			break;
 
-		/* Ensure the page has older data than head. */
-		if (ts < head_page->page->time_stamp)
-			break;
-
-		ts = head_page->page->time_stamp;
-		/* Ensure the page has correct timestamp and some data. */
-		if (!ts || rb_page_commit(head_page) == 0)
-			break;
-
-		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
-		if (ret < 0)
+		/* Rewind until unused page (no timestamp, no commit). */
+		if (!head_page->page->time_stamp && rb_page_commit(head_page) == 0)
 			break;
 
-		/* Recover the number of entries and update stats. */
-		local_set(&head_page->entries, ret);
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-		entries += ret;
-		entry_bytes += rb_page_commit(head_page);
+		/*
+		 * Skip if the page is invalid, or its timestamp is newer than the
+		 * previous valid page.
+		 */
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
+		if (ret >= 0 && ts < head_page->page->time_stamp) {
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, 0);
+			head_page->page->time_stamp = ts;
+			ret = -1;
+		}
+		if (ret < 0) {
+			if (!discarded)
+				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
+					cpu_buffer->cpu);
+			discarded++;
+		} else {
+			entries += ret;
+			entry_bytes += rb_page_size(head_page);
+			if (ret > 0)
+				local_inc(&cpu_buffer->pages_touched);
+			ts = head_page->page->time_stamp;
+		}
 	}
 	if (i)
 		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
@@ -2034,15 +2048,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->reader_page)
 			continue;
 
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
 		if (ret < 0) {
 			if (!discarded)
 				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
 					cpu_buffer->cpu);
 			discarded++;
-			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
-			local_set(&head_page->entries, 0);
-			local_set(&head_page->page->commit, 0);
 		} else {
 			/* If the buffer has content, update pages_touched */
 			if (ret)
@@ -2050,7 +2061,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 			entries += ret;
 			entry_bytes += rb_page_size(head_page);
-			local_set(&head_page->entries, ret);
 		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
@@ -2083,7 +2093,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	/* Reset all the subbuffers */
 	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
 		local_set(&head_page->entries, 0);
-		local_set(&head_page->page->commit, 0);
+		rb_init_page(head_page->page);
 	}
 }
 

