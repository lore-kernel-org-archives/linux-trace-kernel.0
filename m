Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC53CAE89;
	Mon, 30 Mar 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875015; cv=none; b=JGmeFCtphf7zDLun/JPs3WyX2FQ4TEeDp5hHaYbWIrAQWd1WG8ZfoxSZJmxC5TRpC7RIuivKEb/OeCyUoRSimik4ELp/wvzDABzqLLjOyChcAuWSpyeYa7zaHD5LkAKVchtd3ew0OphX7Loeg7oumOp4XI2s1Qm5Q1mY/wObNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875015; c=relaxed/simple;
	bh=IRjdI8UdKKsi6dG8Or3gV8oUCFYxFsta5yCcLV1LQn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsJHLv2N5+XHyqsfhzWlRWVxvw0KWaK7MZshVaNy52TcRSeHL5jmS0A5sagrWJ1GcwOaSvQjdlOPalodawMp4mssGD+sEuNxbaSnEZnKctFW7tms1E29HKOhXwjIVnuogTBFrEoaK4rqndhzLk8h8G/r3CvRYElS1gPj3wy7b44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMrbPaCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMrbPaCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8004C4CEF7;
	Mon, 30 Mar 2026 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875014;
	bh=IRjdI8UdKKsi6dG8Or3gV8oUCFYxFsta5yCcLV1LQn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMrbPaCF7Z72+oj8JADLFzcZCZ3ZhqOrTcjeAsPjn+gBbQJQFt7IZecmI4SaawJZm
	 2QwY1BKxjyCBXXy7WTgZJ0zQqm/yE+wJ5Yff2bK13246vIT+yTG3C8wBoJ1jgmq/Vp
	 A0tNq0xRZhk83DrWb5JNMV34qILan5mP+P+vQSU7sR1FOoQNClSLdUrTOsao28sJHz
	 tX+ODIsx1XE3pj+BBA7LmK9/rz5azaZ3j3ejXbNDh/wFwPKhnZRGhCFSyfvUBkS387
	 8iSrmG5A+NqQIPPNK6cAuUX3ToTn343kTFMQYym5STlhhDAYxv1nalqkT8rCoobzen
	 xBnUwWroO5n+Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v14 3/5] ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
Date: Mon, 30 Mar 2026 21:50:12 +0900
Message-ID:  <177487501208.3463592.7006376990661947220.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To:  <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
References:  <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
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

Skip invalid sub-buffers when rewinding the persistent ring buffer
instead of stopping the rewinding the ring buffer. The skipped
buffers are cleared.

To ensure the rewinding stops at the unused page, this also clears
buffer_data_page::time_stamp when tracing resets the buffer. This
allows us to identify unused pages and empty pages.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v12:
   - Fix build error.
 Changes in v11:
   - Reset timestamp when the buffer is invalid.
   - When rewinding, skip subbuf page if timestamp is wrong and
     check timestamp after validating buffer data page.
 Changes in v10:
   - Newly added.
---
 kernel/trace/ring_buffer.c |   76 +++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 31cad8edd488..e5178239f2f9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -363,6 +363,7 @@ struct buffer_page {
 static void rb_init_page(struct buffer_data_page *bpage)
 {
 	local_set(&bpage->commit, 0);
+	bpage->time_stamp = 0;
 }
 
 static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
@@ -1878,12 +1879,14 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	return events;
 }
 
-static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
+static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
 			      struct ring_buffer_cpu_meta *meta)
 {
+	struct buffer_data_page *dpage = bpage->page;
 	unsigned long long ts;
 	unsigned long tail;
 	u64 delta;
+	int ret = -1;
 
 	/*
 	 * When a sub-buffer is recovered from a read, the commit value may
@@ -1892,9 +1895,17 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
 	 * subbuf_size is considered invalid.
 	 */
 	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
-	if (tail > meta->subbuf_size)
-		return -1;
-	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+	if (tail <= meta->subbuf_size)
+		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+
+	if (ret < 0) {
+		local_set(&bpage->entries, 0);
+		local_set(&bpage->page->commit, 0);
+	} else {
+		local_set(&bpage->entries, ret);
+	}
+
+	return ret;
 }
 
 /* If the meta data has been validated, now validate the events */
@@ -1915,18 +1926,14 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	orig_head = head_page = cpu_buffer->head_page;
 
 	/* Do the reader page first */
-	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu, meta);
+	ret = rb_validate_buffer(cpu_buffer->reader_page, cpu_buffer->cpu, meta);
 	if (ret < 0) {
 		pr_info("Ring buffer meta [%d] invalid reader page detected\n",
 			cpu_buffer->cpu);
 		discarded++;
-		/* Instead of discard whole ring buffer, discard only this sub-buffer. */
-		local_set(&cpu_buffer->reader_page->entries, 0);
-		local_set(&cpu_buffer->reader_page->page->commit, 0);
 	} else {
 		entries += ret;
 		entry_bytes += rb_page_size(cpu_buffer->reader_page);
-		local_set(&cpu_buffer->reader_page->entries, ret);
 	}
 
 	ts = head_page->page->time_stamp;
@@ -1945,26 +1952,33 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->tail_page)
 			break;
 
-		/* Ensure the page has older data than head. */
-		if (ts < head_page->page->time_stamp)
-			break;
-
-		ts = head_page->page->time_stamp;
-		/* Ensure the page has correct timestamp and some data. */
-		if (!ts || rb_page_commit(head_page) == 0)
-			break;
-
-		/* Stop rewind if the page is invalid. */
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
-		if (ret < 0)
+		/* Rewind until unused page (no timestamp, no commit). */
+		if (!head_page->page->time_stamp && rb_page_commit(head_page) == 0)
 			break;
 
-		/* Recover the number of entries and update stats. */
-		local_set(&head_page->entries, ret);
-		if (ret)
-			local_inc(&cpu_buffer->pages_touched);
-		entries += ret;
-		entry_bytes += rb_page_commit(head_page);
+		/*
+		 * Skip if the page is invalid, or its timestamp is newer than the
+		 * previous valid page.
+		 */
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
+		if (ret >= 0 && ts < head_page->page->time_stamp) {
+			local_set(&head_page->entries, 0);
+			local_set(&head_page->page->commit, 0);
+			head_page->page->time_stamp = ts;
+			ret = -1;
+		}
+		if (ret < 0) {
+			if (!discarded)
+				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
+					cpu_buffer->cpu);
+			discarded++;
+		} else {
+			entries += ret;
+			entry_bytes += rb_page_size(head_page);
+			if (ret > 0)
+				local_inc(&cpu_buffer->pages_touched);
+			ts = head_page->page->time_stamp;
+		}
 	}
 	if (i)
 		pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
@@ -2034,15 +2048,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		if (head_page == cpu_buffer->reader_page)
 			continue;
 
-		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu, meta);
+		ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
 		if (ret < 0) {
 			if (!discarded)
 				pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
 					cpu_buffer->cpu);
 			discarded++;
-			/* Instead of discard whole ring buffer, discard only this sub-buffer. */
-			local_set(&head_page->entries, 0);
-			local_set(&head_page->page->commit, 0);
 		} else {
 			/* If the buffer has content, update pages_touched */
 			if (ret)
@@ -2050,7 +2061,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 			entries += ret;
 			entry_bytes += rb_page_size(head_page);
-			local_set(&head_page->entries, ret);
 		}
 		if (head_page == cpu_buffer->commit_page)
 			break;
@@ -2081,7 +2091,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	/* Reset all the subbuffers */
 	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
 		local_set(&head_page->entries, 0);
-		local_set(&head_page->page->commit, 0);
+		rb_init_page(head_page->page);
 	}
 }
 

