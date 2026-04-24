Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333643624BB;
	Fri, 24 Apr 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013582; cv=none; b=Bl7attnG4pDP8qdYvUQSlRf00/8olDuEXsbFnuM4JY4tbiAIhjoSVZdPhstIZcHasXQBKNnWSD1bqLj3h5U7qGUS9WK0qSVzL0U13ksll22qUtiBjkloWOxBkrrnrHeWTv2b6mKfxkH0M5MxkTeePDYP+27+XGMjGfcR+hMMY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013582; c=relaxed/simple;
	bh=ehzhVGhaTVolp1REeY4IslBziHTy1TaIC47b9qxFYjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDV+Vbe1mw7zQoqd6aABpIn4jbc6KOLCz9bJdEHYMMV86FJm3R76/XwaB3RiIxkyisjcRaHkuC+QA2VyRs4KWXu37zTdhkAS6Ilojm6kGY/Fn9rBIcNOtThusGma5kvK5Ygf7DDy8g5HKJSV1KanU4BUAX1e/tySCEkWdjVWK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+rDo9q+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+rDo9q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A68C2BCC4;
	Fri, 24 Apr 2026 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013581;
	bh=ehzhVGhaTVolp1REeY4IslBziHTy1TaIC47b9qxFYjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+rDo9q+vgg/J9/aj+D7TgxFt1T8F3Ls4251FG7LteldnRQKUD27Uc87CAx9zhN8n
	 Ikr0yI7CfL2Kuty52Vk4YSUKJttXvNCXzZzFwR05+2wwqHhpwmcS1+djGWK5AXm273
	 gvMGeOaRGEi8LNLiB1K+NYs/HBUNBlVDhUHK15HgYcxHgPnBW8dM+QQcnnxnRVEXMH
	 4/1IRK/QPYyfN1ZI8EVRa31zbchIdiZ+p1v5R7Inf9e0ll03DvcYiUPP0n9NPmTGnS
	 Jtfgc4aBHlEogXoUFt6gq6J+xfOhaVbP6yDldWHUeRjiIzBU1syHbi/meObn1qAxxW
	 6zLN/gfCvK5wg==
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
Subject: [PATCH v18 7/8] ring-buffer: Cleanup persistent ring buffer validation
Date: Fri, 24 Apr 2026 15:52:59 +0900
Message-ID:  <177701357903.2223789.1327164275262010250.stgit@mhiramat.tok.corp.google.com>
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

Cleanup rb_meta_validate_events() function to make it easier to read.
This includes the following cleanups:
 - Introduce rb_validatation_state to hold working variables in
   validation.
 - Move repleated validation state updates into rb_validate_buffer().
 - Move reader_page injection code outside of rb_meta_validate_events().

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |  186 ++++++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 91 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index de653a8e3cec..9850a0d8d24b 100644
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
@@ -1914,16 +1922,82 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	return ret;
 }
 
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
@@ -1933,25 +2007,16 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -1975,19 +2040,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2001,43 +2054,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2049,7 +2066,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		/* Nothing more to do, the only page is the reader page */
 		goto done;
 	}
-	ts = head_page->page->time_stamp;
+	state.ts = head_page->page->time_stamp;
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
@@ -2058,21 +2075,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2083,25 +2087,25 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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

