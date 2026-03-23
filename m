Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BA3A0EAF;
	Mon, 23 Mar 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269067; cv=none; b=DVt9WyNz8Ft2vOn1kqy6o9RP/RZVkPd/py3s4oAkXSqSz2hk01OeIqdaRL1KsYJSNekjrJ8HnDwdubTlNDa/DeWXFgAmQKE51XdskZYTr4KOAosJ4hJNfk6Rq1dF2sMP/vzvZfNmqkUDUD7HPN18cXz6VPTuUE+oXnpTNRUhxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269067; c=relaxed/simple;
	bh=8XVBxtOaSE2UQDAAi4PqPyWlOcPk7YjD5Mcs681R2Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D244X7d3wrU84nXoVWtcDpArHtk+dx+KvQeb/Dkn8Gn91f3G4MG57BB9G9vI+gByJUTBrPz2ZyTemVafPkGSAG2+6SMh1vRVgS0/JX9muZLufNmE0K1ylRbCTo/tEOnNwzPkLCF+a6QVPYpGmwBV7P45hwu3Foi6gEImq45ERC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goZVQz6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goZVQz6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F8FC2BC87;
	Mon, 23 Mar 2026 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774269066;
	bh=8XVBxtOaSE2UQDAAi4PqPyWlOcPk7YjD5Mcs681R2Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goZVQz6/1V07nG8eOj3gJs4N93pIATIRhSXi0EhyrOyj9i31P/fzJ5l5AFExiqYjW
	 FMavkhRtlTwMVDfNmtLiFFfibDXJE46kn8nqYEd4pFtB6mcQt1KVHNYc+47s/tZisn
	 yg+fFW5Er3sNeWKQHapNVMuKZJo06GxQjIPPefVOBHRdWR5YCFebads6GOp5KInkj1
	 kHfe22e35iwTAVAC6LUKANxedetHveYK8NC85lyaQ6HonsLw4E6Oqb84HJ6t72frF0
	 WccRixdDije3jwWihiaFbJKJWz1jSfPOkTX9tA5rTzC1rRfyROpmfn7RdBB10LSZcm
	 fDGOKTW+bh/ig==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v11 2/4] ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
Date: Mon, 23 Mar 2026 21:31:04 +0900
Message-ID:  <177426906433.3236905.18106419966920927698.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To:  <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
References:  <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/ring_buffer.c |   98 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 40 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0131ce4e018c..dd4c8cf350df 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -396,6 +396,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
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
@@ -1791,7 +1797,6 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 			      unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
-	struct buffer_data_page *subbuf;
 	unsigned long buffers_start;
 	unsigned long buffers_end;
 	int i;
@@ -1799,6 +1804,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 	if (!subbuf_mask)
 		return false;
 
+	if (meta->subbuf_size != PAGE_SIZE) {
+		pr_info("Ring buffer boot meta [%d] invalid subbuf_size\n", cpu);
+		return false;
+	}
+
 	buffers_start = meta->first_buffer;
 	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
 
@@ -1815,11 +1825,12 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
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
@@ -1827,18 +1838,12 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
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
@@ -1902,13 +1907,22 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
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
 
@@ -1919,6 +1933,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	int discarded = 0;
 	int ret;
 	u64 ts;
 	int i;
@@ -1929,14 +1944,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
 
@@ -1964,7 +1984,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			break;
 
 		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
 		if (ret < 0)
 			break;
 
@@ -2043,21 +2063,24 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2071,7 +2094,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, entries);
 	local_set(&cpu_buffer->entries_bytes, entry_bytes);
 
-	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
+		cpu_buffer->cpu, discarded);
 	return;
 
  invalid:
@@ -3258,12 +3282,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
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

