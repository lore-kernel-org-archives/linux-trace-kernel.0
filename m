Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61915327C00;
	Mon,  6 Apr 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471077; cv=none; b=eq9YqE5tDRt+K36uqXR1ppJIhFAxriC6ow/HdJp++nHAbnr7Iz2O6WszXUXjC/sp4nziZNQM8Xl9Y38Nj106nC5gfDiOQ0XNgkKVim778mnB8gQUKFsG29WtdOVVB4VUWg/vYGQya84XDc+IBhumn1D/ingw6lJL8zW30WA1DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471077; c=relaxed/simple;
	bh=7n5MYeapY896oPrdhOd97GzM5OgAj9c57Ec4UzMRsps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8xEFuWn+H7cI2soy3xpoJRGery5gwUbTuP0nlKIKgeutsXo8s48ccxC4bpE0b8wAKW8psEeEwYwyeRupotaAcgdSQgbhQ3mX0ZL/dV8TgKOr+ibTRtRgokOGyr33nocUccmMeUFHCSd3HY4CoUp9mjZywZzguoBxlu5Q9ZfhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNOAb9Uy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNOAb9Uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3EEC4CEF7;
	Mon,  6 Apr 2026 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471077;
	bh=7n5MYeapY896oPrdhOd97GzM5OgAj9c57Ec4UzMRsps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNOAb9UyMUyeKgQwzL3FLwy9PdcKn190XPc9230hVDtJxYyxYu3L++pSj2uu/0ozz
	 3dCKoDwCOH1UBprveuXncikkDyU/nxz84CVf6UaUoEYv2jEAjQLPEWvio3bmq82v19
	 nk2eBIwXSiYDdiNCNDrsIt6ItAVurCcmYV+4NNYHeqaQBoAI9nHxcVzN6pBzXzvlJ9
	 UOTwxbk2H0f+xP8hAYAOfWUtBb6sexfmQBjV7kesOFSPgY7f+4QjfGSX7OOmfPO0e8
	 KLpzRwZ9SOzQXiQNbgysQvep4IMTKD3hWPl7G/iO7447I9hWfNZ4dUsVDfLgB0c3KG
	 hLAAIscZfQweg==
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
Subject: [PATCH v16 2/5] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Mon,  6 Apr 2026 19:24:34 +0900
Message-ID:  <177547107421.259641.8573640291559263589.stgit@mhiramat.tok.corp.google.com>
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

Skip invalid sub-buffers when validating the persistent ring buffer
instead of discarding the entire ring buffer. Only skipped buffers
are invalidated (cleared).

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data. Only discard the
subbuffers that are found to be corrupted.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v15:
  - Skip reader_page loop check on persistent ring buffer because
    there can be contiguous empty(invalidated) pages.
  - Do not show discarded page number information if it is 0.
  Changes in v11:
  - Fix a typo.
  Changes in v9:
  - Add meta->subbuf_size check.
  - Fix a typo.
  - Handle invalid reader_page case.
  Changes in v8:
  - Add comment in rb_valudate_buffer()
  - Clear the RB_MISSED_* flags in rb_valudate_buffer() instead of
    skipping subbuf.
  - Remove unused subbuf local variable from rb_cpu_meta_valid().
  Changes in v7:
  - Combined with Handling RB_MISSED_* flags patch, focus on validation at boot.
  - Remove checking subbuffer data when validating metadata, because it should be done
    later.
  - Do not mark the discarded sub buffer page but just reset it.
  Changes in v6:
  - Show invalid page detection message once per CPU.
  Changes in v5:
  - Instead of showing errors for each page, just show the number
    of discarded pages at last.
  Changes in v3:
  - Record missed data event on commit.
---
 kernel/trace/ring_buffer.c |  109 ++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4d5817286791..0c284094f7d0 100644
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
+	if (tail > meta->subbuf_size)
+		return -1;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1890,6 +1904,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	int discarded = 0;
 	int ret;
 	u64 ts;
 	int i;
@@ -1900,14 +1915,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_head = head_page = cpu_buffer->head_page;
 
 	/* Do the reader page first */
-	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
+	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu, meta);
 	if (ret < 0) {
-		pr_info("Ring buffer reader page is invalid\n");
-		goto invalid;
+		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
+			cpu_buffer->cpu);
+		discarded++;
+		/* Instead of discard whole ring buffer, discard only this sub-buffer. */
+		local_set(&cpu_buffer->reader_page->entries, 0);
+		local_set(&cpu_buffer->reader_page->page->commit, 0);
+	} else {
+		entries += ret;
+		entry_bytes += rb_page_size(cpu_buffer->reader_page);
+		local_set(&cpu_buffer->reader_page->entries, ret);
 	}
-	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
-	local_set(&cpu_buffer->reader_page->entries, ret);
 
 	ts = head_page->page->time_stamp;
 
@@ -1935,7 +1955,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			break;
 
 		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
 		if (ret < 0)
 			break;
 
@@ -2014,21 +2034,24 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->reader_page)
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
@@ -2042,7 +2065,10 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, entries);
 	local_set(&cpu_buffer->entries_bytes, entry_bytes);
 
-	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	pr_info("Ring buffer meta [%d] is from previous boot!", cpu_buffer->cpu);
+	if (discarded)
+		pr_cont(" (%d pages discarded)", discarded);
+	pr_cont("\n");
 	return;
 
  invalid:
@@ -3329,12 +3355,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
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
@@ -5647,11 +5667,12 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
  again:
 	/*
 	 * This should normally only loop twice. But because the
-	 * start of the reader inserts an empty page, it causes
-	 * a case where we will loop three times. There should be no
-	 * reason to loop four times (that I know of).
+	 * start of the reader inserts an empty page, it causes a
+	 * case where we will loop three times. There should be no
+	 * reason to loop four times unless the ring buffer is a
+	 * recovered persistent ring buffer.
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
+	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3 && !cpu_buffer->ring_meta)) {
 		reader = NULL;
 		goto out;
 	}

