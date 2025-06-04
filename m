Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC9746E;
	Wed,  4 Jun 2025 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748995825; cv=none; b=aPmPfT5bIxV95Evi+mAinaUPLzZyV8ZmEEcVaw4hJiMW+8DYIO0h9JIdcfVtgAG0JOOMo2BplCv2rRCTgDAbBDiZVPPot7Xa/ApnXeV23hXHQAqMceYpteInZyVD/Fvlo+tUH54GbE/Nuq8UhVWJu0jfFDYDS5hTgFb9WVXO8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748995825; c=relaxed/simple;
	bh=lUCmBlhPTd1XgwJtMI94eo6D+Fh3+d2k+hPOvppvuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G77ebIpitBwebKF1ADPx6K+uKR3nrth+/I3HUuja21inS8PfVKVgGh9o7FWZDY7p/zkrWX62Hn+eBt+OBr4L1CDhOhDtCZzqaWeLwsr2Hb9fFMPWz67/CbAssgQx92F3gQqLmYHdHUeXQnShx+q3HZ4I0+6YDIN7ihWF/w1pMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTWk8mym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTWk8mym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022FFC4CEED;
	Wed,  4 Jun 2025 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748995824;
	bh=lUCmBlhPTd1XgwJtMI94eo6D+Fh3+d2k+hPOvppvuZM=;
	h=From:To:Cc:Subject:Date:From;
	b=KTWk8mym9EejIBDNEZJkrKS3hvOuWk2dU/gvLWcYV5TW2tfN53+LXxmMM2nZlXYWe
	 BzudSRG9CiSFNb4a8GV/P2J9AOMjS6eORRPCZuvS1hNxaNO4vZxc4KOd6bUby6vHyy
	 K+g/XUIbMQMO4pn0qrJQYbgRithrK0JjU21AK1xhttJfeLIx0HcXnuVD/cawkyNK/D
	 QJ8GooY8AoT9/mgivSUA8KR/F7mluXEflrVjqmGV6RjzQ4TbP3+8sQ8JGtUooWtStW
	 VzSMjsZ3d5FCPxGVRaOrodevPMzLQg/afZ4/Ycp6dIi3FNz6pIKKOhsXn7kDuZJb8f
	 1GPjbNYYFTnOA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4] tracing: ring_buffer: Rewind persistent ring buffer when reboot
Date: Wed,  4 Jun 2025 09:10:21 +0900
Message-ID:  <174899582116.955054.773265393511190051.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
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
 Changes in v4:
  - Clear ring buffer data page when the data page swaps to
    spare page (splice case).
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
 kernel/trace/ring_buffer.c |  103 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e24509bd0af5..facbe6103714 100644
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
@@ -5342,7 +5440,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:

