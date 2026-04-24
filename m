Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155A282F3A;
	Fri, 24 Apr 2026 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013558; cv=none; b=ZJP2fE9u+/5NoHwJExQYUxQ/yo66bBXdN88KcJCxqGZS1K6IY39XwVCOVg5vPjjfLfPYEW5KHXS8NRj5gBkrGKxCJ81jKgUDN0uqPJW1X4j5LHE1qXG87jwO3Dc0v77yqdhPkrY94sblsMBLvIJgJOb80vT6Ef1hf3jCmgMuqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013558; c=relaxed/simple;
	bh=4AQ4Vdg8eXEH+XUJCU28zeCliV9qAG1d5p61FPaq3e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSDLoa9t9ZgLGWYwZb19hUjVbtJlRnOzsu3DUN2C206n7aPoJwq980WTYpwCo/eek70RPhVMLKFgyZV0Zj+jOTN2ud1RjLBS9CFpIJcc/h4jfLYn5u6zPezzdzUjYQEmYOKlrk3BxfHutc9G+sI3TjKYSWUoamNFW/KWsxOzs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbkTPWCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbkTPWCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73344C19425;
	Fri, 24 Apr 2026 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013557;
	bh=4AQ4Vdg8eXEH+XUJCU28zeCliV9qAG1d5p61FPaq3e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbkTPWCSaFyA2TpLFle19BvCNBVysxs+A0EyEBgNk8IHspxzIUpONsWWmOMUy7N4S
	 TntGY2CPZbLoBinzW3BTXAaB1zbfxdDvfa26FX7q2zYl/uFXplL54OL2yaDvRYYC7S
	 e6VSaodFW5kulxPdIP7g5UCCHAMnlLJvafYIDz3uV44wTtx+CAkCrvsw447YEkF7+t
	 5juQPw5PtQA50bm5SggMI6L0MA0uJM/sqpx8p7KXAqfEnc2dJYbGMQFlCUGnvFLl9D
	 HUnXvjLsKZYxZMub4YIyS+B/PIlnZ7DQwDsBtLsWLXilIHz8wdTa9YQfokiXQWBPCU
	 fdojdR3GBx3CQ==
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
Subject: [PATCH v18 4/8] ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
Date: Fri, 24 Apr 2026 15:52:35 +0900
Message-ID:  <177701355481.2223789.8929563537404268817.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
References:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v18:
  - Reset timestamp of reader_page when the entire cpu_buffer is
    invalid.
  - Minor update by new fix.
 Changes in v17:
  - Fix to verify head_page at first before using its timestamp.
  - Reset timestamp if the page is invalid.
 Changes in v12:
   - Fix build error.
 Changes in v11:
   - Reset timestamp when the buffer is invalid.
   - When rewinding, skip subbuf page if timestamp is wrong and
     check timestamp after validating buffer data page.
 Changes in v10:
   - Newly added.
---
 kernel/trace/ring_buffer.c |   94 ++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 404c1fcac0ae..899a78b307e6 100644
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
-			      struct ring_buffer_cpu_meta *meta)
+static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
+			      struct ring_buffer_cpu_meta *meta, u64 prev_ts, u64 next_ts)
 {
+	struct buffer_data_page *dpage = bpage->page;
 	unsigned long long ts;
 	unsigned long tail;
 	u64 delta;
+	int ret = -1;
 
 	/*
 	 * When a sub-buffer is recovered from a read, the commit value may
@@ -1892,9 +1895,19 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
 	 * subbuf_size is considered invalid.
 	 */
 	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
-	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
-		return -1;
-	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
+		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+
+	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
+		local_set(&bpage->entries, 0);
+		local_set(&bpage->page->commit, 0);
+		bpage->page->time_stamp = prev_ts ? prev_ts : next_ts;
+		ret = -1;
+	} else {
+		local_set(&bpage->entries, ret);
+	}
+
+	return ret;
 }
 
 /* If the meta data has been validated, now validate the events */
@@ -1915,25 +1928,29 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_head = head_page = cpu_buffer->head_page;
 	orig_reader = cpu_buffer->reader_page;
 
-	/* Do the reader page first */
-	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu, meta);
+	/* Do the head page first */
+	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
+	if (ret < 0) {
+		pr_info("Ring buffer meta [%d] invalid head page detected\n",
+			cpu_buffer->cpu);
+		goto skip_rewind;
+	}
+	ts = head_page->page->time_stamp;
+
+	/* Do the reader page - reader must be previous to head. */
+	ret = rb_validate_buffer(orig_reader, cpu_buffer->cpu, meta, 0, ts);
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
 			cpu_buffer->cpu);
 		discarded++;
-		/* Instead of discard whole ring buffer, discard only this sub-buffer. */
-		local_set(&orig_reader->entries, 0);
-		local_set(&orig_reader->page->commit, 0);
 	} else {
 		entries += ret;
 		entry_bytes += rb_page_size(orig_reader);
-		local_set(&orig_reader->entries, ret);
+		ts = orig_reader->page->time_stamp;
 	}
 
-	ts = head_page->page->time_stamp;
-
 	/*
-	 * Try to rewind the head so that we can read the pages which already
+	 * Try to rewind the head so that we can read the pages which are already
 	 * read in the previous boot.
 	 */
 	if (head_page == cpu_buffer->tail_page)
@@ -1946,26 +1963,27 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->tail_page)
 			break;
 
-		/* Ensure the page has older data than head. */
-		if (ts < head_page->page->time_stamp)
-			break;
-
-		ts = head_page->page->time_stamp;
-		/* Ensure the page has correct timestamp and some data. */
-		if (!ts || rb_page_commit(head_page) == 0)
+		/* Rewind until unused page (no timestamp, no commit). */
+		if (!head_page->page->time_stamp && rb_page_commit(head_page) == 0)
 			break;
 
-		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
-		if (ret < 0)
-			break;
-
-		/* Recover the number of entries and update stats. */
-		local_set(&head_page->entries, ret);
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-		entries += ret;
-		entry_bytes += rb_page_size(head_page);
+		/*
+		 * Skip if the page is invalid, or its timestamp is newer than the
+		 * previous valid page.
+		 */
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, ts);
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
@@ -2027,6 +2045,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		/* Nothing more to do, the only page is the reader page */
 		goto done;
 	}
+	ts = head_page->page->time_stamp;
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
@@ -2035,15 +2054,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == orig_reader)
 			continue;
 
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, ts, 0);
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
@@ -2051,7 +2067,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 			entries += ret;
 			entry_bytes += rb_page_size(head_page);
-			local_set(&head_page->entries, ret);
+			ts = head_page->page->time_stamp;
 		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
@@ -2079,12 +2095,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/* Reset the reader page */
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
+	rb_init_page(cpu_buffer->reader_page->page);
 
 	/* Reset all the subbuffers */
 	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
 		local_set(&head_page->entries, 0);
-		local_set(&head_page->page->commit, 0);
+		rb_init_page(head_page->page);
 	}
 }
 

