Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB90299A8F;
	Thu, 22 May 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929287; cv=none; b=j1VxVZD6vKtFopkNLdHNZ5jlMOrVGPotF0pOJ6ytvHOT2OrfWlsius2bOjOsVOyyky2b2dyvneLoktm2efEWxx2noOIuygylrz7bgA/Jbd/4/xGGKIuEi7EcBY1FeyHYjXFrd2oN6VocBFlU9JThfXvoFVAqwwzCPEcsls2JmSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929287; c=relaxed/simple;
	bh=twdaxWJ5KdWT1Fd9LQOPLrLc+gq1MhsOwx75trBu/fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfh1BTofJ8zLE66vuTKK9zZ7TUgqwWjq1OcW9B156uzpQwzVpsYEGe2pTtMOyusQolM+ywZaNMuP3rGsvbwUOwT2WE7472/G0/LeozFqA9VFiQPsUaiQWMtEdRRBY+S/3gkoFsgWsOdyWNeUan+ut0CttnRm6WmPjTC6vZfrlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFmNiE+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFmNiE+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E24C4CEE4;
	Thu, 22 May 2025 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929286;
	bh=twdaxWJ5KdWT1Fd9LQOPLrLc+gq1MhsOwx75trBu/fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFmNiE+KwzMusW+ZzZS/xysfgKGTcM2s8BQkjawHDwPV43l/9JyJt2zByNR1IbYwP
	 iPQzi9+MOtESKZniPgv/V+CG0wPqpb0ae6xctVa0+GMwrYihYenroeoM4CTaIneXQa
	 kFOB8AS3W6dGBeABp88wF0sm958FxXOxMNPq1a+lT+yl7H7qVJT/hpuVM1r3FwBRDy
	 gxy1TE5sVC+B4N9GP2lqG49+EFLV6YeiHS+NCqq37qjltgrIdk4pCWugzcwtDCR48r
	 hSvCvQGq0cOuReuBE4I+rHsN+BAdIAVZHigygV1ym9gYRGIhXLtZdRrAWwatHq0fOw
	 HD8/xiIJZu7uA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring buffer when reboot
Date: Fri, 23 May 2025 00:54:44 +0900
Message-ID:  <174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To:  <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
References:  <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
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

Rewind persistent ring buffer pages which have been read in the
previous boot. Those pages are highly possible to be lost before
writing it to the disk if the previous kernel crashed. In this
case, the trace data is kept on the persistent ring buffer, but
it can not be read because its commit size has been reset after
read.
This skips clearing the commit size of each sub-buffer and
recover it after reboot.

Note: If you read the previous boot data via trace_pipe, that
is not accessible in that time. But reboot without clearing (or
reusing) the read data, the read data is recovered again in the
next boot.
Thus, when you read the previous boot data, clear it by
`echo > trace`.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v3:
  - Fix a label name to better one. (skip_rewind)
  - Fix comments.
  - Fix rewound log message and show only if rewound pages.
  - Fix to adjust cpu_buffer->pages correctly.
  - Fix a buffer overflow.
 Changes in v2:
  - Stop rewind if timestamp is not older.
  - Rewind reader page and reset all indexes.
  - Make ring_buffer_read_page() not clear the commit size.
---
 kernel/trace/ring_buffer.c |  104 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6859008ca34d..5034bae02f08 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1358,6 +1358,13 @@ static inline void rb_inc_page(struct buffer_page **bpage)
 	*bpage = list_entry(p, struct buffer_page, list);
 }
 
+static inline void rb_dec_page(struct buffer_page **bpage)
+{
+	struct list_head *p = rb_list_head((*bpage)->list.prev);
+
+	*bpage = list_entry(p, struct buffer_page, list);
+}
+
 static struct buffer_page *
 rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -1866,10 +1873,11 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-	struct buffer_page *head_page;
+	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
 	int ret;
+	u64 ts;
 	int i;
 
 	if (!meta || !meta->head_buffer)
@@ -1885,8 +1893,98 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	head_page = cpu_buffer->head_page;
+	orig_head = head_page = cpu_buffer->head_page;
+	ts = head_page->page->time_stamp;
+
+	/*
+	 * Try to rewind the head so that we can read the pages which already
+	 * read in the previous boot.
+	 */
+	if (head_page == cpu_buffer->tail_page)
+		goto skip_rewind;
+
+	rb_dec_page(&head_page);
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
+
+		/* Rewind until tail (writer) page. */
+		if (head_page == cpu_buffer->tail_page)
+			break;
+
+		/* Ensure the page has older data than head. */
+		if (ts < head_page->page->time_stamp)
+			break;
+
+		ts = head_page->page->time_stamp;
+		/* Ensure the page has correct timestamp and some data. */
+		if (!ts || rb_page_commit(head_page) == 0)
+			break;
 
+		/* Stop rewind if the page is invalid. */
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		if (ret < 0)
+			break;
+
+		/* Recover the number of entries and update stats. */
+		local_set(&head_page->entries, ret);
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+		entries += ret;
+		entry_bytes += rb_page_commit(head_page);
+	}
+	if (i)
+		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
+
+	/* The last rewound page must be skipped. */
+	if (head_page != orig_head)
+		rb_inc_page(&head_page);
+
+	/*
+	 * If the ring buffer was rewound, then inject the reader page
+	 * into the location just before the original head page.
+	 */
+	if (head_page != orig_head) {
+		struct buffer_page *bpage = orig_head;
+
+		rb_dec_page(&bpage);
+		/*
+		 * Insert the reader_page before the original head page.
+		 * Since the list encode RB_PAGE flags, general list
+		 * operations should be avoided.
+		 */
+		cpu_buffer->reader_page->list.next = &orig_head->list;
+		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
+		orig_head->list.prev = &cpu_buffer->reader_page->list;
+		bpage->list.next = &cpu_buffer->reader_page->list;
+
+		/* Make the head_page the reader page */
+		cpu_buffer->reader_page = head_page;
+		bpage = head_page;
+		rb_inc_page(&head_page);
+		head_page->list.prev = bpage->list.prev;
+		rb_dec_page(&bpage);
+		bpage->list.next = &head_page->list;
+		rb_set_list_to_head(&bpage->list);
+		cpu_buffer->pages = &head_page->list;
+
+		cpu_buffer->head_page = head_page;
+		meta->head_buffer = (unsigned long)head_page->page;
+
+		/* Reset all the indexes */
+		bpage = cpu_buffer->reader_page;
+		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
+		bpage->id = 0;
+
+		for (i = 1, bpage = head_page; i < meta->nr_subbufs;
+		     i++, rb_inc_page(&bpage)) {
+			meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
+			bpage->id = i;
+		}
+
+		/* We'll restart verifying from orig_head */
+		head_page = orig_head;
+	}
+
+ skip_rewind:
 	/* If the commit_buffer is the reader page, update the commit page */
 	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
 		cpu_buffer->commit_page = cpu_buffer->reader_page;
@@ -5348,7 +5446,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:
@@ -6642,7 +6739,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
-		rb_init_page(bpage);
 		bpage = reader->page;
 		reader->page = data_page->data;
 		local_set(&reader->write, 0);

