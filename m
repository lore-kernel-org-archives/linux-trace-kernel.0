Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3437AA90;
	Fri, 27 Feb 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184037; cv=none; b=c6tSa/W09H8LV0P7gF+veyB0I4sfbE0b8Z8n7t1DJ0bplpYmqR97YMg6saG8nlRVdn7JiMwBzPe3x9pEhy9gmTqKn+eMxYzlKygVA+NyRTGtIzC2V3PxPyVESwKdnTnmG/Fm1PHhvzQ/hLpQT2kyYBBnRz1GMImWF9VW0sZFjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184037; c=relaxed/simple;
	bh=7CTdl1fzOdmeH/Uzee6UCB/qqZjpNr2TNVQjKcODxB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ3brEFRk6jxxACOK+zt6cYQoCuMCQacZ/TyC4aUdyXNUQw9B+UjXlJY9hZU9X+70M5EQrgADbkChmQ/oOq8nCYMgszTREqAVHKICk6ppa5XDsAgLP2AvviXyYnFL+dxTcsQZRW/uzwFUQU90rjqsPV0BUyxePzPUETw1FibCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prrvnng7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prrvnng7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0069C116C6;
	Fri, 27 Feb 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772184037;
	bh=7CTdl1fzOdmeH/Uzee6UCB/qqZjpNr2TNVQjKcODxB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Prrvnng7IY5fJMCI/mtNCcsgfs76ZnuobSKEdsHlUNK6ErpmQcwdkEY5aRJIeY02s
	 HkRnev2aKF/OMhiEZDlPTeqiZGfOZohxrFjM2Il+26VigmcvsnMkTNBuQq+prvwkPs
	 uxVujz2xOdR9LW8KT9qppI98Mi7BKrViRGQqfdb9YYIZpolidi300mCgGQ+HA3n6se
	 JB/wiqvrHvU4Il6NQfmMj6/CSiWMo9N6jH0g4oLHjV/bxcHmwesWhnct7klZar7sfs
	 bZnWrdYweUuOX1k/4jgzwsma6YzpREfNVx4WVnns+WGg1VdGYDjPP0R5BFefz39PU5
	 21D8za3XjGfNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] ring-buffer: Handle RB_MISSED_* flags on commit field correctly
Date: Fri, 27 Feb 2026 18:20:35 +0900
Message-ID:  <177218403512.1988514.11156837978785772102.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To:  <177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com>
References:  <177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com>
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

Since the MSBs of rb_data_page::commit are used for storing
RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
when it is used for finding the size of data pages.

Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v5:
   - Do not move rb_commit_index().
   - Fix verify_event() and rb_cpu_meta_valid() too.
 Changes in v4:
   - Fix to move rb_commit_index() after ring_buffer_per_cpu definition.
---
 kernel/trace/ring_buffer.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 156ed19fb569..87d6958e9656 100644
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
@@ -677,7 +683,7 @@ static void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
 	do {
 		if (page == tail_page || WARN_ON_ONCE(stop++ > 100))
 			done = true;
-		commit = local_read(&page->page->commit);
+		commit = rb_page_size(page);
 		write = local_read(&page->write);
 		if (addr >= (unsigned long)&page->page->data[commit] &&
 		    addr < (unsigned long)&page->page->data[write])
@@ -1821,13 +1827,16 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 
 	/* Is the meta buffers and the subbufs themselves have correct data? */
 	for (i = 0; i < meta->nr_subbufs; i++) {
+		unsigned long commit;
+
 		if (meta->buffers[i] < 0 ||
 		    meta->buffers[i] >= meta->nr_subbufs) {
 			pr_info("Ring buffer boot meta [%d] array out of range\n", cpu);
 			return false;
 		}
 
-		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
+		commit = local_read(&subbuf->commit) & ~RB_MISSED_MASK;
+		if (commit > subbuf_size) {
 			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
 			return false;
 		}
@@ -1908,7 +1917,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	u64 delta;
 	int tail;
 
-	tail = local_read(&dpage->commit);
+	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1935,7 +1944,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto invalid;
 	}
 	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	entry_bytes += rb_page_size(cpu_buffer->reader_page);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
 	ts = head_page->page->time_stamp;
@@ -2055,7 +2064,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			local_inc(&cpu_buffer->pages_touched);
 
 		entries += ret;
-		entry_bytes += local_read(&head_page->page->commit);
+		entry_bytes += rb_page_size(head_page);
 		local_set(&cpu_buffer->head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
@@ -3258,12 +3267,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
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
@@ -4434,7 +4437,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
-		tail = local_read(&bpage->commit);
+		tail = local_read(&bpage->commit) & ~RB_MISSED_MASK;
 	} else if (info->add_timestamp &
 		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
 		/* Ignore events with absolute time stamps */

