Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E735CB67;
	Fri, 24 Apr 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013592; cv=none; b=fZ/iYFQXFWxyoEgR8D9YfpCJ8QFx2PfkZHtCyinF1G4BSsalVHVfDmNeGradAf5g6eSpc+WVzHyOIQ8zDM4WRwTznuTYuTapB5+o2Sb1f9/Isqqqc+lMflXruOHIttoaRLP5mQu6zZiQwJQttrVczoW8gqVQe3BPykhLJBIeaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013592; c=relaxed/simple;
	bh=fLpOiyjDpTjhOsD1w6Nwrl43BRsmvYtPTRgU5KHxM24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWian/gsUdPqG0NU44KFVqG3c8Wd9CEiJ9AkCfiXjzKDsn2kskk2zI9hN6T7I10jll1m/DR4p11e1mDHti5RQ+W9cTkz9+2aygJ/Sj54ovGbX1h4PRjfb6x/tZN50fw3Z9vae8XCkJfMbTisHPWewxLHBszujqhOe4JljhuK8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUu1iK8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUu1iK8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B0C19425;
	Fri, 24 Apr 2026 06:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013591;
	bh=fLpOiyjDpTjhOsD1w6Nwrl43BRsmvYtPTRgU5KHxM24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUu1iK8wEwY/G3+qeANpnAz8aR+sVHHhpL3858P5I3yUdXI5EHiHY4P4UWH/noko3
	 hJ/Zk9xH7PzIp/RDYpMWNqbExyIRFK4ywK1XC3VYLDkR2n5hIzFf04tYGh8w0CFqJB
	 csjHfCFfbWpex8bTMmFrYMsKubGNwvyTxMP6bq2p+fWkYx5k9D9ZfcKyT4w3sxwbHe
	 FGxvScCwridxxHpwDLtY1aN5tRe7qLaCaUtWlspYpgbuyMj/JucbCQ+7ZIWkIF30b1
	 K9NI9VfNQ9HsnLm9jhu4xUChIK8ElpNRm1On2hKpWdbgKHz5X5fnTHGL7SoSwXzUOJ
	 WzYIjgr9zpiqQ==
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
Subject: [PATCH v18 8/8] ring-buffer: Cleanup buffer_data_page related code
Date: Fri, 24 Apr 2026 15:53:07 +0900
Message-ID:  <177701358709.2223789.720012159062013099.stgit@mhiramat.tok.corp.google.com>
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

Code cleanup related to buffer_data_page for readability,
which includes:
- Introduce rb_data_page_commit() and rb_data_page_size()
- Use 'dpage' for buffer_data_page, instead of 'bpage' because
  'bpage' is used for buffer_page.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |  112 ++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9850a0d8d24b..cb524b2afb7b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -364,21 +364,30 @@ struct buffer_page {
 #define RB_WRITE_MASK		0xfffff
 #define RB_WRITE_INTCNT		(1 << 20)
 
-static void rb_init_page(struct buffer_data_page *bpage)
+static void rb_init_data_page(struct buffer_data_page *bpage)
 {
 	local_set(&bpage->commit, 0);
 	bpage->time_stamp = 0;
 }
 
+static __always_inline long rb_data_page_commit(struct buffer_data_page *dpage)
+{
+	return local_read(&dpage->commit);
+}
+
+static __always_inline long rb_data_page_size(struct buffer_data_page *dpage)
+{
+	return rb_data_page_commit(dpage) & ~RB_MISSED_MASK;
+}
+
 static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 {
-	return local_read(&bpage->page->commit);
+	return rb_data_page_commit(bpage->page);
 }
 
-/* Size is determined by what has been committed */
 static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
 {
-	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
+	return rb_data_page_size(bpage->page);
 }
 
 static void free_buffer_page(struct buffer_page *bpage)
@@ -419,7 +428,7 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
 		return NULL;
 
 	dpage = page_address(page);
-	rb_init_page(dpage);
+	rb_init_data_page(dpage);
 
 	return dpage;
 }
@@ -659,7 +668,7 @@ static void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
 	do {
 		if (page == tail_page || WARN_ON_ONCE(stop++ > 100))
 			done = true;
-		commit = local_read(&page->page->commit);
+		commit = rb_page_commit(page);
 		write = local_read(&page->write);
 		if (addr >= (unsigned long)&page->page->data[commit] &&
 		    addr < (unsigned long)&page->page->data[write])
@@ -1906,7 +1915,7 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	 * Even after clearing these bits, a commit value greater than the
 	 * subbuf_size is considered invalid.
 	 */
-	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
+	tail = rb_data_page_size(dpage);
 	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
 		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 
@@ -2118,12 +2127,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/* Reset the reader page */
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	rb_init_page(cpu_buffer->reader_page->page);
+	rb_init_data_page(cpu_buffer->reader_page->page);
 
 	/* Reset all the subbuffers */
 	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
 		local_set(&head_page->entries, 0);
-		rb_init_page(head_page->page);
+		rb_init_data_page(head_page->page);
 	}
 }
 
@@ -2183,7 +2192,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int sc
 		 */
 		for (i = 0; i < meta->nr_subbufs; i++) {
 			meta->buffers[i] = i;
-			rb_init_page(subbuf);
+			rb_init_data_page(subbuf);
 			subbuf += meta->subbuf_size;
 		}
 	}
@@ -2235,7 +2244,7 @@ static int rbm_show(struct seq_file *m, void *v)
 	val -= 2;
 	dpage = rb_range_buffer(cpu_buffer, val);
 	seq_printf(m, "buffer[%ld]:    %d (commit: %ld)\n",
-		   val, meta->buffers[val], dpage ? local_read(&dpage->commit) : -1);
+		   val, meta->buffers[val], dpage ? rb_data_page_commit(dpage) : -1);
 
 	return 0;
 }
@@ -2626,7 +2635,7 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 
 		dpage = (void *)(ptr + idx * subbuf_size);
 		/* Skip unused pages */
-		if (!local_read(&dpage->commit))
+		if (!rb_data_page_commit(dpage))
 			continue;
 
 		/*
@@ -2638,7 +2647,7 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
 			invalid++;
 		} else {
 			/* Count total commit bytes. */
-			entry_bytes += local_read(&dpage->commit) & ~RB_MISSED_MASK;
+			entry_bytes += rb_data_page_size(dpage);
 		}
 	}
 
@@ -4167,8 +4176,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		RB_WARN_ON(cpu_buffer,
-			   local_read(&cpu_buffer->commit_page->page->commit) &
-			   ~RB_WRITE_MASK);
+			   rb_page_commit(cpu_buffer->commit_page) & ~RB_WRITE_MASK);
 		barrier();
 	}
 
@@ -4540,7 +4548,7 @@ static const char *show_interrupt_level(void)
 	return show_irq_str(level);
 }
 
-static void dump_buffer_page(struct buffer_data_page *bpage,
+static void dump_buffer_page(struct buffer_data_page *dpage,
 			     struct rb_event_info *info,
 			     unsigned long tail)
 {
@@ -4548,12 +4556,12 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 	u64 ts, delta;
 	int e;
 
-	ts = bpage->time_stamp;
+	ts = dpage->time_stamp;
 	pr_warn("  [%lld] PAGE TIME STAMP\n", ts);
 
 	for (e = 0; e < tail; e += rb_event_length(event)) {
 
-		event = (struct ring_buffer_event *)(bpage->data + e);
+		event = (struct ring_buffer_event *)(dpage->data + e);
 
 		switch (event->type_len) {
 
@@ -4603,7 +4611,7 @@ static atomic_t ts_dump;
 		}							\
 		atomic_inc(&cpu_buffer->record_disabled);		\
 		pr_warn(fmt, ##__VA_ARGS__);				\
-		dump_buffer_page(bpage, info, tail);			\
+		dump_buffer_page(dpage, info, tail);			\
 		atomic_dec(&ts_dump);					\
 		/* There's some cases in boot up that this can happen */ \
 		if (WARN_ON_ONCE(system_state != SYSTEM_BOOTING))	\
@@ -4619,16 +4627,16 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 			 struct rb_event_info *info,
 			 unsigned long tail)
 {
-	struct buffer_data_page *bpage;
+	struct buffer_data_page *dpage;
 	u64 ts, delta;
 	bool full = false;
 	int ret;
 
-	bpage = info->tail_page->page;
+	dpage = info->tail_page->page;
 
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
-		tail = local_read(&bpage->commit);
+		tail = rb_data_page_commit(dpage);
 	} else if (info->add_timestamp &
 		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
 		/* Ignore events with absolute time stamps */
@@ -4639,7 +4647,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	 * Do not check the first event (skip possible extends too).
 	 * Also do not check if previous events have not been committed.
 	 */
-	if (tail <= 8 || tail > local_read(&bpage->commit))
+	if (tail <= 8 || tail > rb_data_page_commit(dpage))
 		return;
 
 	/*
@@ -4648,7 +4656,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
 
-	ret = rb_read_data_buffer(bpage, tail, cpu_buffer->cpu, &ts, &delta);
+	ret = rb_read_data_buffer(dpage, tail, cpu_buffer->cpu, &ts, &delta);
 	if (ret < 0) {
 		if (delta < ts) {
 			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld clock:%pS\n",
@@ -6436,7 +6444,7 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 {
 	local_set(&page->write, 0);
 	local_set(&page->entries, 0);
-	rb_init_page(page->page);
+	rb_init_data_page(page->page);
 	page->read = 0;
 }
 
@@ -6921,7 +6929,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	local_irq_restore(flags);
 
 	if (bpage->data) {
-		rb_init_page(bpage->data);
+		rb_init_data_page(bpage->data);
 	} else {
 		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
 		if (!bpage->data) {
@@ -6946,8 +6954,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 				struct buffer_data_read_page *data_page)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *bpage = data_page->data;
-	struct page *page = virt_to_page(bpage);
+	struct buffer_data_page *dpage = data_page->data;
+	struct page *page = virt_to_page(dpage);
 	unsigned long flags;
 
 	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
@@ -6967,15 +6975,15 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	arch_spin_lock(&cpu_buffer->lock);
 
 	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = bpage;
-		bpage = NULL;
+		cpu_buffer->free_page = dpage;
+		dpage = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
  out:
-	free_pages((unsigned long)bpage, data_page->order);
+	free_pages((unsigned long)dpage, data_page->order);
 	kfree(data_page);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
@@ -7020,7 +7028,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 	struct ring_buffer_event *event;
-	struct buffer_data_page *bpage;
+	struct buffer_data_page *dpage;
 	struct buffer_page *reader;
 	unsigned long missed_events;
 	unsigned int commit;
@@ -7046,8 +7054,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (data_page->order != buffer->subbuf_order)
 		return -1;
 
-	bpage = data_page->data;
-	if (!bpage)
+	dpage = data_page->data;
+	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
@@ -7113,7 +7121,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			 * We have already ensured there's enough space if this
 			 * is a time extend. */
 			size = rb_event_length(event);
-			memcpy(bpage->data + pos, rpage->data + rpos, size);
+			memcpy(dpage->data + pos, rpage->data + rpos, size);
 
 			len -= size;
 
@@ -7129,9 +7137,9 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			size = rb_event_ts_length(event);
 		} while (len >= size);
 
-		/* update bpage */
-		local_set(&bpage->commit, pos);
-		bpage->time_stamp = save_timestamp;
+		/* update dpage */
+		local_set(&dpage->commit, pos);
+		dpage->time_stamp = save_timestamp;
 
 		/* we copied everything to the beginning */
 		read = 0;
@@ -7141,13 +7149,13 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
-		rb_init_page(bpage);
-		bpage = reader->page;
+		rb_init_data_page(dpage);
+		dpage = reader->page;
 		reader->page = data_page->data;
 		local_set(&reader->write, 0);
 		local_set(&reader->entries, 0);
 		reader->read = 0;
-		data_page->data = bpage;
+		data_page->data = dpage;
 
 		/*
 		 * Use the real_end for the data size,
@@ -7155,12 +7163,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * on the page.
 		 */
 		if (reader->real_end)
-			local_set(&bpage->commit, reader->real_end);
+			local_set(&dpage->commit, reader->real_end);
 	}
 
 	cpu_buffer->lost_events = 0;
 
-	commit = local_read(&bpage->commit);
+	commit = rb_data_page_commit(dpage);
 	/*
 	 * Set a flag in the commit field if we lost events
 	 */
@@ -7169,19 +7177,19 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
-			memcpy(&bpage->data[commit], &missed_events,
+			memcpy(&dpage->data[commit], &missed_events,
 			       sizeof(missed_events));
-			local_add(RB_MISSED_STORED, &bpage->commit);
+			local_add(RB_MISSED_STORED, &dpage->commit);
 			commit += sizeof(missed_events);
 		}
-		local_add(RB_MISSED_EVENTS, &bpage->commit);
+		local_add(RB_MISSED_EVENTS, &dpage->commit);
 	}
 
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
 	if (commit < buffer->subbuf_size)
-		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
+		memset(&dpage->data[commit], 0, buffer->subbuf_size - commit);
 
 	return read;
 }
@@ -7812,7 +7820,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 
 	if (missed_events) {
 		if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
-			struct buffer_data_page *bpage = reader->page;
+			struct buffer_data_page *dpage = reader->page;
 			unsigned int commit;
 			/*
 			 * Use the real_end for the data size,
@@ -7820,18 +7828,18 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 			 * on the page.
 			 */
 			if (reader->real_end)
-				local_set(&bpage->commit, reader->real_end);
+				local_set(&dpage->commit, reader->real_end);
 			/*
 			 * If there is room at the end of the page to save the
 			 * missed events, then record it there.
 			 */
 			commit = rb_page_size(reader);
 			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
-				memcpy(&bpage->data[commit], &missed_events,
+				memcpy(&dpage->data[commit], &missed_events,
 				       sizeof(missed_events));
-				local_add(RB_MISSED_STORED, &bpage->commit);
+				local_add(RB_MISSED_STORED, &dpage->commit);
 			}
-			local_add(RB_MISSED_EVENTS, &bpage->commit);
+			local_add(RB_MISSED_EVENTS, &dpage->commit);
 		} else if (!WARN_ONCE(cpu_buffer->reader_page == cpu_buffer->tail_page,
 				      "Reader on commit with %ld missed events",
 				      missed_events)) {

