Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582947B408;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469832; cv=none; b=Da9whFRjrLNeknLq5Q02r8bCj4mPbPwLxqJGnFsW9t3xJhbHK2OAlCvvqJNipsIwScFJxHSnzbIsyVTrbLrzT0XFZIMDfsY2r0dGGGmf4RfggUu+CFY80o0nnAgdxHD4TPbDe9Fd3pXdUbxkBe9R4tULKY2umA2EwVrswqs9JXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469832; c=relaxed/simple;
	bh=uvCizJawz5ieSP6dmFxEsPPBFu/Tv027hBmU9V2YXzM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MuIQ6npQlNI4g7vvQfxGJ7lgpDU5OL9Y8hy8D3C5GIKP8VR7OaQtLHRRr0gny2TkWHn6rnN5YvNZlZU9ksnjWK3R/YcxwDx3vDuEEtI2jQDuH8AZ69AMQwTdSki1QmeM6XL/kTB5AoOohVaH/2X7k8D1bh2Z01rLJHv+Tirn8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzugAnd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzugAnd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1631F00A3F;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=Z/nfxtxhwK+osIk8Dj8i76fjDmnTIXF2KNMpNKEEb5U=;
	h=Date:From:To:Cc:Subject:References;
	b=FzugAnd64DqW04VqipzXMo2L7WbY9+FxKofRdFh6XHOyoxVD4p+XpXPjJ1jxQ+9NP
	 VNF7860IzVX+HOk8dO7GID6OxaHxIdGCrl2g2WrFUE2VdQSr4x8RHJGjMzHiVoovph
	 P5uyLce8qtjO9cg1xmZx2GJCghbg3vewkBliGSbxIGlZwxJugkNDY9cgWfRt28aTx1
	 Z05uNWeJ5UCHzabK3MfYBmAcCTueF/KogLUU68hUUNZb4rgPjLQRIY/n1C3VcTCG+L
	 E9JjJYri0l9EyTRHmcT+sOFhxFXmAIh2DGcczOojZU+eQQFMv9NbOPx7aA2Cqnm152
	 P7ryWF+PtuueA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BUw-10ci;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171051.091265852@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:08:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 2/9] ring-buffer: Skip invalid sub-buffers when rewinding persistent ring
 buffer
References: <20260522170857.263969486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Skip invalid sub-buffers when rewinding the persistent ring buffer
instead of stopping the rewinding the ring buffer. The skipped
buffers are cleared.

To ensure the rewinding stops at the unused page, this also clears
buffer_data_page::time_stamp when tracing resets the buffer. This
allows us to identify unused pages and empty pages.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ SDR: Have reader_page still get evaluated if header_page fails ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v20: https://patch.msgid.link/20260520185017.219342323@kernel.org

- Still process reader page if head page fails validation (Sashiko)

 kernel/trace/ring_buffer.c | 107 ++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6afd8ea5081a..c10cf4ba91d6 100644
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
+	int ret;
 
 	/*
 	 * When a sub-buffer is recovered from a read, the commit value may
@@ -1892,9 +1895,27 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
 	 * subbuf_size is considered invalid.
 	 */
 	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
-	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
-		return -1;
-	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
+		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+	else
+		ret = -1;
+
+	/*
+	 * The timestamp must be greater than @prev_ts and smaller than @next_ts.
+	 * Since this function works in both forward (verify) and reverse (unwind)
+	 * loop, we don't know both @prev_ts and @next_ts at the same time.
+	 * So use the known boundary as the boundary.
+	 */
+	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
+		local_set(&bpage->entries, 0);
+		local_set(&dpage->commit, 0);
+		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
+		ret = -1;
+	} else {
+		local_set(&bpage->entries, ret);
+	}
+
+	return ret;
 }
 
 /* If the meta data has been validated, now validate the events */
@@ -1905,6 +1926,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
 	int discarded = 0;
+	bool skip = false;
 	int ret;
 	u64 ts;
 	int i;
@@ -1915,25 +1937,35 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_head = head_page = cpu_buffer->head_page;
 	orig_reader = cpu_buffer->reader_page;
 
-	/* Do the reader page first */
-	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu, meta);
+	/* Do the head page first */
+	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
+	if (ret < 0) {
+		pr_info("Ring buffer meta [%d] invalid head page detected\n",
+			cpu_buffer->cpu);
+		/* Don't bother rewinding */
+		skip = true;
+		ts = 0;
+	} else {
+		ts = head_page->page->time_stamp;
+	}
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
+	if (skip)
+		goto skip_rewind;
 
 	/*
-	 * Try to rewind the head so that we can read the pages which already
+	 * Try to rewind the head so that we can read the pages which are already
 	 * read in the previous boot.
 	 */
 	if (head_page == cpu_buffer->tail_page)
@@ -1946,26 +1978,27 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->tail_page)
 			break;
 
-		/* Ensure the page has older data than head. */
-		if (ts < head_page->page->time_stamp)
+		/* Rewind until unused page (no timestamp, no commit). */
+		if (!head_page->page->time_stamp && rb_page_commit(head_page) == 0)
 			break;
 
-		ts = head_page->page->time_stamp;
-		/* Ensure the page has correct timestamp and some data. */
-		if (!ts || rb_page_commit(head_page) == 0)
-			break;
-
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
@@ -2027,6 +2060,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		/* Nothing more to do, the only page is the reader page */
 		goto done;
 	}
+	ts = head_page->page->time_stamp;
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
@@ -2035,15 +2069,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2051,7 +2082,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 			entries += ret;
 			entry_bytes += rb_page_size(head_page);
-			local_set(&head_page->entries, ret);
+			ts = head_page->page->time_stamp;
 		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
@@ -2079,12 +2110,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
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
 
-- 
2.53.0


