Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B82402453;
	Wed, 20 May 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303007; cv=none; b=pGA3m1W6EL2eExfOoCrVQRw0G58saO3p2grlBaTDkeiPUfPxafu95wS7EEsho9eGKK6Am9zL7M+9kocRW/6/G7Daop1vZO1CLzi4WMdLWVCA685XKW53fOPmUX8fYkhJvurBK/nbb2L9d3gOxYu1k12xDO1FDcD8Q+NTM3MsdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303007; c=relaxed/simple;
	bh=b11s2AvDB+fIYqA5HC3PF5oz2tqHO/2f5Od9WenRkXg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=poQUJ2PPjg1LNIwsA1pMiU0geuQ9jRrYfDMqZ8MNIYCey2br8nD/L7vlBgezSD2erwvEz8Pqb8IaQI8RBYGYxB4FQJIkMPgbcu49tuN/Nk+GXyc5hejIjxtc0Bfpz0cymtsIYJG3yvVa6XYu6MuZS2NGj8Kv0yNhQQKSXzfqBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlsugH9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlsugH9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE771F00897;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302998;
	bh=Y9lpcbBcztVGamz9VXZGLkQV5l9j+VEU2Ro5/J9ikFk=;
	h=Date:From:To:Cc:Subject:References;
	b=UlsugH9odcFQnWDZWBKAoWQbPvKsTWWW4gBhtqWIo5GSHoIHwna8717H498IeqXRv
	 Q+6agqyja+g0NFc1u9iJWZmdCzHkHVr2ej9gg6jY12Jadwb0VhfyMoNmyfjgUOS9s8
	 h2HhzmLu2RcziHvlVXVTuyKeckdvf5+WbofhRYzOPf+RB/P0QnP3WZ9uQZRGJUSuvi
	 LJTgDh86UJ0mQbDEG/IBJObxZ22gYtifYKyGS/m48tfa6aMH5syGWu/jJSz2gFtAi+
	 292zM6D1u/ewlr7/KdbuqkkmEikiTYG/wyQYR8XBFAUO5j/oJgmU+fz6Fq8R9KsDG7
	 BivHh+CAEnwmQ==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzl-00000004qSo-3gGb;
	Wed, 20 May 2026 14:50:17 -0400
Message-ID: <20260520185017.743458353@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 05/10] ring-buffer: Cleanup persistent ring buffer validation
References: <20260520184938.749337513@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Cleanup rb_meta_validate_events() function to make it easier to read.
This includes the following cleanups:
 - Introduce rb_validatation_state to hold working variables in
   validation.
 - Move repleated validation state updates into rb_validate_buffer().
 - Move reader_page injection code outside of rb_meta_validate_events().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 198 ++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 91 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 695398d72fbb..3f1dd75ba332 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1883,8 +1883,16 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	return events;
 }
 
-static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
-			      struct ring_buffer_cpu_meta *meta, u64 prev_ts, u64 next_ts)
+struct rb_validation_state {
+	unsigned long entries;
+	unsigned long entry_bytes;
+	int discarded;
+	u64 ts;
+};
+
+static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
+				struct ring_buffer_cpu_meta *meta,
+				u64 prev_ts, u64 next_ts)
 {
 	struct buffer_data_page *dpage = bpage->page;
 	unsigned long long ts;
@@ -1922,16 +1930,94 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	return ret;
 }
 
+/**
+ * rb_validate_buffer - validates a single buffer page and updates the state.
+ * @bpage: buffer page to validate
+ * @cpu_buffer: cpu_buffer this page belongs to
+ * @meta: meta of the cpu_buffer
+ * @state: validation state
+ * @prev_ts: previous buffer's timestamp (optional)
+ * @next_ts: next buffer's timestamp (optional)
+ *
+ * If the page is invalid (wrong event length or timestamp), it increments the
+ * discarded counter and warns it. Otherwise, it updates the validation state.
+ */
+static void rb_validate_buffer(struct buffer_page *bpage,
+			       struct ring_buffer_per_cpu *cpu_buffer,
+			       struct ring_buffer_cpu_meta *meta,
+			       struct rb_validation_state *state,
+			       u64 prev_ts, u64 next_ts)
+{
+	int ret;
+
+	ret = __rb_validate_buffer(bpage, cpu_buffer->cpu, meta, prev_ts, next_ts);
+	if (ret < 0) {
+		if (!state->discarded)
+			pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
+				cpu_buffer->cpu);
+		state->discarded++;
+	} else {
+		/* If the buffer has content, update pages_touched */
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+
+		state->entries += ret;
+		state->entry_bytes += rb_page_size(bpage);
+		state->ts = bpage->page->time_stamp;
+	}
+}
+
+static void rb_meta_inject_reader_page(struct ring_buffer_per_cpu *cpu_buffer,
+				       struct ring_buffer_cpu_meta *meta,
+				       struct buffer_page *orig_head,
+				       struct buffer_page *head_page)
+{
+	struct buffer_page *bpage = orig_head;
+	int i;
+
+	rb_dec_page(&bpage);
+	/*
+	 * Insert the reader_page before the original head page.
+	 * Since the list encode RB_PAGE flags, general list
+	 * operations should be avoided.
+	 */
+	cpu_buffer->reader_page->list.next = &orig_head->list;
+	cpu_buffer->reader_page->list.prev = orig_head->list.prev;
+	orig_head->list.prev = &cpu_buffer->reader_page->list;
+	bpage->list.next = &cpu_buffer->reader_page->list;
+
+	/* Make the head_page the reader page */
+	cpu_buffer->reader_page = head_page;
+	bpage = head_page;
+	rb_inc_page(&head_page);
+	head_page->list.prev = bpage->list.prev;
+	rb_dec_page(&bpage);
+	bpage->list.next = &head_page->list;
+	rb_set_list_to_head(&bpage->list);
+	cpu_buffer->pages = &head_page->list;
+
+	cpu_buffer->head_page = head_page;
+	meta->head_buffer = (unsigned long)head_page->page;
+
+	/* Reset all the indexes */
+	bpage = cpu_buffer->reader_page;
+	meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
+	bpage->id = 0;
+
+	for (i = 1, bpage = head_page; i < meta->nr_subbufs;
+	     i++, rb_inc_page(&bpage)) {
+		meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
+		bpage->id = i;
+	}
+}
+
 /* If the meta data has been validated, now validate the events */
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	struct buffer_page *head_page, *orig_head, *orig_reader;
-	unsigned long entry_bytes = 0;
-	unsigned long entries = 0;
-	int discarded = 0;
+	struct rb_validation_state state = { 0 };
 	int ret;
-	u64 ts;
 	int i;
 
 	if (!meta || !meta->head_buffer)
@@ -1941,25 +2027,16 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_reader = cpu_buffer->reader_page;
 
 	/* Do the head page first */
-	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
+	ret = __rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid head page detected\n",
 			cpu_buffer->cpu);
 		goto skip_rewind;
 	}
-	ts = head_page->page->time_stamp;
+	state.ts = head_page->page->time_stamp;
 
 	/* Do the reader page - reader must be previous to head. */
-	ret = rb_validate_buffer(orig_reader, cpu_buffer->cpu, meta, 0, ts);
-	if (ret < 0) {
-		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
-			cpu_buffer->cpu);
-		discarded++;
-	} else {
-		entries += ret;
-		entry_bytes += rb_page_size(orig_reader);
-		ts = orig_reader->page->time_stamp;
-	}
+	rb_validate_buffer(orig_reader, cpu_buffer, meta, &state, 0, state.ts);
 
 	/*
 	 * Try to rewind the head so that we can read the pages which are already
@@ -1983,19 +2060,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		 * Skip if the page is invalid, or its timestamp is newer than the
 		 * previous valid page.
 		 */
-		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, ts);
-		if (ret < 0) {
-			if (!discarded)
-				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
-					cpu_buffer->cpu);
-			discarded++;
-		} else {
-			entries += ret;
-			entry_bytes += rb_page_size(head_page);
-			if (ret > 0)
-				local_inc(&cpu_buffer->pages_touched);
-			ts = head_page->page->time_stamp;
-		}
+		rb_validate_buffer(head_page, cpu_buffer, meta, &state, 0, state.ts);
 	}
 	if (i)
 		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
@@ -2009,43 +2074,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	 * into the location just before the original head page.
 	 */
 	if (head_page != orig_head) {
-		struct buffer_page *bpage = orig_head;
-
-		rb_dec_page(&bpage);
-		/*
-		 * Insert the reader_page before the original head page.
-		 * Since the list encode RB_PAGE flags, general list
-		 * operations should be avoided.
-		 */
-		cpu_buffer->reader_page->list.next = &orig_head->list;
-		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
-		orig_head->list.prev = &cpu_buffer->reader_page->list;
-		bpage->list.next = &cpu_buffer->reader_page->list;
-
-		/* Make the head_page the reader page */
-		cpu_buffer->reader_page = head_page;
-		bpage = head_page;
-		rb_inc_page(&head_page);
-		head_page->list.prev = bpage->list.prev;
-		rb_dec_page(&bpage);
-		bpage->list.next = &head_page->list;
-		rb_set_list_to_head(&bpage->list);
-		cpu_buffer->pages = &head_page->list;
-
-		cpu_buffer->head_page = head_page;
-		meta->head_buffer = (unsigned long)head_page->page;
-
-		/* Reset all the indexes */
-		bpage = cpu_buffer->reader_page;
-		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
-		bpage->id = 0;
-
-		for (i = 1, bpage = head_page; i < meta->nr_subbufs;
-		     i++, rb_inc_page(&bpage)) {
-			meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
-			bpage->id = i;
-		}
-
+		rb_meta_inject_reader_page(cpu_buffer, meta, orig_head, head_page);
 		/* We'll restart verifying from orig_head */
 		head_page = orig_head;
 	}
@@ -2057,7 +2086,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		/* Nothing more to do, the only page is the reader page */
 		goto done;
 	}
-	ts = head_page->page->time_stamp;
+	state.ts = head_page->page->time_stamp;
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
@@ -2066,21 +2095,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == orig_reader)
 			continue;
 
-		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, ts, 0);
-		if (ret < 0) {
-			if (!discarded)
-				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
-					cpu_buffer->cpu);
-			discarded++;
-		} else {
-			/* If the buffer has content, update pages_touched */
-			if (ret)
-				local_inc(&cpu_buffer->pages_touched);
+		rb_validate_buffer(head_page, cpu_buffer, meta, &state, state.ts, 0);
 
-			entries += ret;
-			entry_bytes += rb_page_size(head_page);
-			ts = head_page->page->time_stamp;
-		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
 	}
@@ -2091,25 +2107,25 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto invalid;
 	}
  done:
-	local_set(&cpu_buffer->entries, entries);
-	local_set(&cpu_buffer->entries_bytes, entry_bytes);
+	local_set(&cpu_buffer->entries, state.entries);
+	local_set(&cpu_buffer->entries_bytes, state.entry_bytes);
 
 	pr_info("Ring buffer meta [%d] is from previous boot!", cpu_buffer->cpu);
-	if (discarded)
-		pr_cont(" (%d pages discarded)", discarded);
+	if (state.discarded)
+		pr_cont(" (%d pages discarded)", state.discarded);
 	pr_cont("\n");
 
 #ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
 	if (meta->nr_invalid)
 		pr_warn("Ring buffer testing [%d] invalid pages: %s (%d/%d)\n",
 			cpu_buffer->cpu,
-			(discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
-			discarded, meta->nr_invalid);
+			(state.discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
+			state.discarded, meta->nr_invalid);
 	if (meta->entry_bytes)
 		pr_warn("Ring buffer testing [%d] entry_bytes: %s (%ld/%ld)\n",
 			cpu_buffer->cpu,
-			(entry_bytes == meta->entry_bytes) ? "PASSED" : "FAILED",
-			(long)entry_bytes, (long)meta->entry_bytes);
+			(state.entry_bytes == meta->entry_bytes) ? "PASSED" : "FAILED",
+			(long)state.entry_bytes, (long)meta->entry_bytes);
 	meta->nr_invalid = 0;
 	meta->entry_bytes = 0;
 #endif
-- 
2.53.0


