Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC747CC8E;
	Fri, 22 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469832; cv=none; b=FyMFBpajMxPWDHTJmlGy2jkwJYxsDz8+5qrtGAk4tx3ZI+xQAUudNDyd/VVd312SoFrHspqyI8svnpF9PjEW8evelC9kw4aft6oacztAX/8OavwxhMaXrl8VqECJsaIejfcO7kcPPMx1l4aCrQ2XT+VNRBsXzawVNKJDTAef4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469832; c=relaxed/simple;
	bh=/Yfi0k2mmYG4QJm7slwGkwyDWS3rKCI779y/CR0KssM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G0B4inRjpcMjP3tXK90j1Tuz7hxpAk6xiqCgzA26ph4EO5V0o7QEh7GmX7pDJygPKQICjjpAYIN7MylTsyxFcQqg9XfluPSqFosdJaRHkG9QIfja9x5PuWqvs0i3MSZh7dxVpJrUnG7Mw/mKMSp2EbHQR+TWimX24oSIHe4cTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpNhVxsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpNhVxsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0E1F0155A;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=t6T5NiSoSnXoyNroUOvXG5NU+XzkIqSGTkITsLZbn44=;
	h=Date:From:To:Cc:Subject:References;
	b=gpNhVxsQKV0N3Q5qBHGH1dvC8Wz0tCB4WTfOtvuQYOYPjzPib3OANglJ7mFfrrgl7
	 zOzsXw/XiqKhdYYIOHIfVx1DvufEmHnpdzbRxnGwPBx240xbnTDSMba+FfnQlKSgVC
	 B4rbKAEu0q7iitc/AZzT7KbroS3UsDn9mugwbLDY7a5WV8ilu7QtcqsIqhuNoI58vU
	 cJN9FxtXkB5fYGyeuCUbk28EzZrNu8TSVHSf/HfCNbhUAHg2zvR+5t8lQ262+MRsWq
	 e0zOE3RKBoq1RzsFUzE36cMfemuMFb4Cfo960QXDKKVvFierDMFCbtk6BdG7JSuNQN
	 CkM/AYd0PownQ==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BWO-2xnX;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171051.577231395@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:02 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 5/9] ring-buffer: Cleanup persistent ring buffer validation
References: <20260522170857.263969486@kernel.org>
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
 kernel/trace/ring_buffer.c | 200 ++++++++++++++++++++-----------------
 1 file changed, 108 insertions(+), 92 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 88e613e78632..73f453ba12ce 100644
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
@@ -1922,17 +1930,95 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
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
 	bool skip = false;
 	int ret;
-	u64 ts;
 	int i;
 
 	if (!meta || !meta->head_buffer)
@@ -1942,28 +2028,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_reader = cpu_buffer->reader_page;
 
 	/* Do the head page first */
-	ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
+	ret = __rb_validate_buffer(head_page, cpu_buffer->cpu, meta, 0, 0);
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid head page detected\n",
 			cpu_buffer->cpu);
 		/* Don't bother rewinding */
 		skip = true;
-		ts = 0;
+		state.ts = 0;
 	} else {
-		ts = head_page->page->time_stamp;
+		state.ts = head_page->page->time_stamp;
 	}
 
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
 
 	if (skip)
 		goto skip_rewind;
@@ -1990,19 +2067,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2016,43 +2081,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2064,7 +2093,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		/* Nothing more to do, the only page is the reader page */
 		goto done;
 	}
-	ts = head_page->page->time_stamp;
+	state.ts = head_page->page->time_stamp;
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
@@ -2073,21 +2102,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2098,25 +2114,25 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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


