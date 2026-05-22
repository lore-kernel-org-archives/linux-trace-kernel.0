Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6247A0D4;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469829; cv=none; b=Tcz8FrWkrtyf/DKl7MD6OPsjxnmLOabeDIYAhtf4EdHAV1AiVv37j9zx1f/8SyEfAMNGZbga7UYO/0WEXxHx/lhN+ftXDJ8V60QprXeCkiV/016MNbEzk8gyRrSSOy8j5AcAbx00OiGsTDvryGe6g50dlRZDpP7ZeiSxUKSoo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469829; c=relaxed/simple;
	bh=r7hNw3n9KBYpD19yh0kCs6d+AWyeYaJGiVqsCNncpZw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Bzfqh3/eFnKs2Budbsm1IdAR5j/gZNyMvo/+qRa6ck1NMZHxziFflVSANIJrBNWGC/K0IIEBBhOQHyfqOkA1hc1j9zReTWdwBi79MGhI6bM/GOx7VR/OSIS+yPQzxLY26w9ydjzA81hAvy9i5Xf4KPmM6aKCvgCDZPjYMOmRbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4M0xF9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4M0xF9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BC31F00A3D;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=DGWHHbwNQZQ2sTW+8oQihPGJHqXNQCHUQGwwseLY8Xw=;
	h=Date:From:To:Cc:Subject:References;
	b=L4M0xF9DCjxoDRrntRtoQKOQvwHkzzvC48xk4qWx/LkgnQY4+b9OJgaASxTSScqyG
	 Ywo5CW57Df0LvmORo/djB05ZVw7dCm/JtfYSCfVfXi/20LK3DtFBcc16obPN1/TzZe
	 qXok2G9lGJrSChb8Q730Bfnz8s1ndBGcyFbKz7bdI8KlMKW0Z2WBOS/wFymHuuRn2W
	 2hE7ip8fZM3rChoxSG92h0++fJt38QMPOXnoqRcn2yuce8xv32fNCGKntgwW/LbzrM
	 a9RRn6TNtkAY7M/fEEfxYxpq3W405aXKqULaS6mY7CkiA2Z96cQ6fUEyshbcur4x4P
	 zROINlQqz5KVA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BUR-0FN7;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171050.914418536@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:08:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 1/9] ring-buffer: Skip invalid sub-buffers when validating persistent ring
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

Skip invalid sub-buffers when validating the persistent ring buffer
instead of discarding the entire ring buffer. Only skipped buffers
are invalidated (cleared).

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data. Only discard the
subbuffers that are found to be corrupted.

Link: https://lore.kernel.org/all/20260520185018.051228084@kernel.org/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[SDR: Fixed max_loops in rb_iter_peek() as well ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v20: https://patch.msgid.link/20260520185017.044376275@kernel.org

- squashed the fix for max_loops in rb_iter_peek()

 kernel/trace/ring_buffer.c | 120 ++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 47 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7b07d2004cc6..6afd8ea5081a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -370,6 +370,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 	return local_read(&bpage->page->commit);
 }
 
+/* Size is determined by what has been committed */
+static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
+{
+	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	/* Range pages are not to be freed */
@@ -1762,7 +1768,6 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 			      unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
-	struct buffer_data_page *subbuf;
 	unsigned long buffers_start;
 	unsigned long buffers_end;
 	int i;
@@ -1770,6 +1775,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 	if (!subbuf_mask)
 		return false;
 
+	if (meta->subbuf_size != PAGE_SIZE) {
+		pr_info("Ring buffer boot meta [%d] invalid subbuf_size\n", cpu);
+		return false;
+	}
+
 	buffers_start = meta->first_buffer;
 	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
 
@@ -1786,11 +1796,12 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 		return false;
 	}
 
-	subbuf = rb_subbufs_from_meta(meta);
-
 	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
 
-	/* Is the meta buffers and the subbufs themselves have correct data? */
+	/*
+	 * Ensure the meta::buffers array has correct data. The data in each subbufs
+	 * are checked later in rb_meta_validate_events().
+	 */
 	for (i = 0; i < meta->nr_subbufs; i++) {
 		if (meta->buffers[i] < 0 ||
 		    meta->buffers[i] >= meta->nr_subbufs) {
@@ -1798,18 +1809,12 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 			return false;
 		}
 
-		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
-			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
-			return false;
-		}
-
 		if (test_bit(meta->buffers[i], subbuf_mask)) {
 			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
 			return false;
 		}
 
 		set_bit(meta->buffers[i], subbuf_mask);
-		subbuf = (void *)subbuf + subbuf_size;
 	}
 
 	return true;
@@ -1873,13 +1878,22 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	return events;
 }
 
-static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
+static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
+			      struct ring_buffer_cpu_meta *meta)
 {
 	unsigned long long ts;
+	unsigned long tail;
 	u64 delta;
-	int tail;
 
-	tail = local_read(&dpage->commit);
+	/*
+	 * When a sub-buffer is recovered from a read, the commit value may
+	 * have RB_MISSED_* bits set, as these bits are reset on reuse.
+	 * Even after clearing these bits, a commit value greater than the
+	 * subbuf_size is considered invalid.
+	 */
+	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
+	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
+		return -1;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1890,6 +1904,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head, *orig_reader;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	int discarded = 0;
 	int ret;
 	u64 ts;
 	int i;
@@ -1901,14 +1916,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_reader = cpu_buffer->reader_page;
 
 	/* Do the reader page first */
-	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu);
+	ret = rb_validate_buffer(orig_reader->page, cpu_buffer->cpu, meta);
 	if (ret < 0) {
-		pr_info("Ring buffer reader page is invalid\n");
-		goto invalid;
+		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
+			cpu_buffer->cpu);
+		discarded++;
+		/* Instead of discard whole ring buffer, discard only this sub-buffer. */
+		local_set(&orig_reader->entries, 0);
+		local_set(&orig_reader->page->commit, 0);
+	} else {
+		entries += ret;
+		entry_bytes += rb_page_size(orig_reader);
+		local_set(&orig_reader->entries, ret);
 	}
-	entries += ret;
-	entry_bytes += local_read(&orig_reader->page->commit);
-	local_set(&orig_reader->entries, ret);
 
 	ts = head_page->page->time_stamp;
 
@@ -1936,7 +1956,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			break;
 
 		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
 		if (ret < 0)
 			break;
 
@@ -1945,7 +1965,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (ret)
 			local_inc(&cpu_buffer->pages_touched);
 		entries += ret;
-		entry_bytes += rb_page_commit(head_page);
+		entry_bytes += rb_page_size(head_page);
 	}
 	if (i)
 		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
@@ -2015,21 +2035,24 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == orig_reader)
 			continue;
 
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
 		if (ret < 0) {
-			pr_info("Ring buffer meta [%d] invalid buffer page\n",
-				cpu_buffer->cpu);
-			goto invalid;
-		}
-
-		/* If the buffer has content, update pages_touched */
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-
-		entries += ret;
-		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&head_page->entries, ret);
+			if (!discarded)
+				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
+					cpu_buffer->cpu);
+			discarded++;
+			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, 0);
+		} else {
+			/* If the buffer has content, update pages_touched */
+			if (ret)
+				local_inc(&cpu_buffer->pages_touched);
 
+			entries += ret;
+			entry_bytes += rb_page_size(head_page);
+			local_set(&head_page->entries, ret);
+		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
 	}
@@ -2043,7 +2066,10 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, entries);
 	local_set(&cpu_buffer->entries_bytes, entry_bytes);
 
-	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	pr_info("Ring buffer meta [%d] is from previous boot!", cpu_buffer->cpu);
+	if (discarded)
+		pr_cont(" (%d pages discarded)", discarded);
+	pr_cont("\n");
 	return;
 
  invalid:
@@ -3330,12 +3356,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	return NULL;
 }
 
-/* Size is determined by what has been committed */
-static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
-{
-	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
-}
-
 static __always_inline unsigned
 rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5636,8 +5656,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 static struct buffer_page *
 __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *reader = NULL;
+	int max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
 	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
+	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
 	int nr_loops = 0;
@@ -5649,11 +5670,14 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
  again:
 	/*
 	 * This should normally only loop twice. But because the
-	 * start of the reader inserts an empty page, it causes
-	 * a case where we will loop three times. There should be no
-	 * reason to loop four times (that I know of).
+	 * start of the reader inserts an empty page, it causes a
+	 * case where we will loop three times. There should be no
+	 * reason to loop four times unless the ring buffer is a
+	 * recovered persistent ring buffer. For persistent ring buffers,
+	 * invalid pages are reset during recovery, so there may be more
+	 * than 3 contiguous pages can be empty, but less than nr_pages.
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
+	if (RB_WARN_ON(cpu_buffer, ++nr_loops > max_loops)) {
 		reader = NULL;
 		goto out;
 	}
@@ -5950,12 +5974,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
+	int max_loops;
 
 	if (ts)
 		*ts = 0;
 
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
+	max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
 
 	/*
 	 * Check if someone performed a consuming read to the buffer
@@ -5978,7 +6004,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	 * the ring buffer with an active write as the consumer is.
 	 * Do not warn if the three failures is reached.
 	 */
-	if (++nr_loops > 3)
+	if (++nr_loops > max_loops)
 		return NULL;
 
 	if (rb_per_cpu_empty(cpu_buffer))
-- 
2.53.0


