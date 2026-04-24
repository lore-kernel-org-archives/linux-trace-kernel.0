Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736235DA61;
	Fri, 24 Apr 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013550; cv=none; b=aef/Kz7lB3Ypua3cSfHwMkP7wOuO5U6CtWqJnpBqAhhvFK281kG5H886xPgUJb6qz7d3l60bMkiWYs5E7M29F7iHX9WL3yiJVkfVeS17ZZEtNfVHxUNpY7kAoUKaqhM9NU9CtSDvkAcYc53C8y6NL55mNdY0PyoXd1FZTqUQH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013550; c=relaxed/simple;
	bh=a28vAEw+cfGHLl3UdhvSQTjct12I7y+1Ujb8QlQ1S0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH/mcvMkZ8nP19QazI+D/7Wmx1AoSHkkWnGu2pJ51XcFfim96oGnTOuDaoUsmkSnqZmGVUhX5b5xGdXpFpaEyGqSF1hHvRkhKvokClfivdYYBcqiFttwlIDTCiaD7P7CjxZVWZIVCgoTAiGk56InaNXyH3jg/LmAcFBdKr+WZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcSp7d+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcSp7d+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6972AC19425;
	Fri, 24 Apr 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013549;
	bh=a28vAEw+cfGHLl3UdhvSQTjct12I7y+1Ujb8QlQ1S0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lcSp7d+UH8R5wQaSTUSYVI8Bbu+z/lvWpKAzVs+YurObTsUpcNW3K1Oiuo5zu8Yhq
	 qdAdzhfiXyBza6xMyoLuorlk0BBDYbmXrJKyLl7ZcAX5X/LfpC1Ppq++1rQbCz6E0G
	 nXxvGh1cXa05ExKaks3LHshn6i3lP7rfDvorYwJYOhBIvP5Il6P/WjchGK3yMWqDrZ
	 43uSnDS19e+795CdzOmQA7lnQLPLoULiSa10dT72Yl9vdgl1/GmEbY7ugM3WIKp4DD
	 qitE8epUcKz0MazPOveUzJiGqHkVScqVm6+WHzDxb099AGvbxWVVutVWdMnTElLaw0
	 G8FEuEh/xgq5g==
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
Subject: [PATCH v18 3/8] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Fri, 24 Apr 2026 15:52:27 +0900
Message-ID:  <177701354681.2223789.14633430761021638378.stgit@mhiramat.tok.corp.google.com>
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

Skip invalid sub-buffers when validating the persistent ring buffer
instead of discarding the entire ring buffer. Only skipped buffers
are invalidated (cleared).

If the cache data in memory fails to be synchronized during a reboot,
the persistent ring buffer may become partially corrupted, but other
sub-buffers may still contain readable event data. Only discard the
subbuffers that are found to be corrupted.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v18:
  - Minor update by the new fix.
  - Fix to substract BUF_PAGE_HDR_SIZE from meta->subbuf_size
    to make the limit of commit size.
  Changes in v17:
  - Fix to use rb_page_size() of rewound pages for entry_bytes.
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
 kernel/trace/ring_buffer.c |  111 ++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7288383b1f27..404c1fcac0ae 100644
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
@@ -5648,11 +5668,12 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
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

