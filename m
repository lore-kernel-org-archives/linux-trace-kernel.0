Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12636165F;
	Thu, 26 Feb 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113126; cv=none; b=itXfz6C/gk2AvrjQjj7I9/1mjTeWPvJR8vMxLEhRO3Z30pAKfqUgRaKJGp5YX6ZJI2M11gGaR73GxAvqyxeqPj7i1f55TTVyz4tQyfsJyvXajq6LEU2aNukSU0b/0iTM8dJEdzNDqqscRa9mwqmQr39r5iQ6c23op4eQwnt5D80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113126; c=relaxed/simple;
	bh=tPEl7RiyBxci9RH9bwWwgOWrKzS/dFTt+z3BuPaz/Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcm/sXv9GwjLWRprSOdUoR1EAyBkqwEg7alyfIt2G3yNG6tSHYe519tjMb6fKOnOl2pjs2TI0U8wh3pr2g4H0ZWB8ieRNY/yUquzQbKG4eM44fANM8lRne3D4wfdTwtzVTc75liHfrRZwXXUJ0Q323IWBWu/YyuKkHZNn+PS/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JomJTjj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JomJTjj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D7DC116C6;
	Thu, 26 Feb 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113126;
	bh=tPEl7RiyBxci9RH9bwWwgOWrKzS/dFTt+z3BuPaz/Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JomJTjj6WSMF1UUGV193DqwVV6JIcDUp4kQAUBjI65xsJDM44Cbg/p+UUIZbxNmHx
	 PfiIN/jIlWGPxw/JYowWr2ekEBKDwf1IeGZSSzAFI3x5Nxwe70nCxkpA74JvrFGRCM
	 MziupwTSi/7C5LPUEfsuxkk8kKCnpNm+EQBjrik8w8cDULcKGqXooKIW3GE/xeaAVo
	 BDpA1OZTOHniOzDzsosD1zvbZ+m0iT9r03ucNEFN50NxkW9JTxbc3w/H4RL0dlDpfn
	 ucfTd1OZcv3lhv8tHKC6qqtsIuZWyQP0DyNZF8l1/XhOnW6Gnq5ZCMkQzClixtTwc9
	 TK3M62HycRRwg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] ring-buffer: Handle RB_MISSED_* flags on commit field correctly
Date: Thu, 26 Feb 2026 22:38:43 +0900
Message-ID:  <177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
References:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
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
index 0eb6e6595f37..2e9b8ce6b4dc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -395,6 +395,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
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
@@ -676,7 +682,7 @@ static void verify_event(struct ring_buffer_per_cpu *cpu_buffer,
 	do {
 		if (page == tail_page || WARN_ON_ONCE(stop++ > 100))
 			done = true;
-		commit = local_read(&page->page->commit);
+		commit = rb_page_size(page);
 		write = local_read(&page->write);
 		if (addr >= (unsigned long)&page->page->data[commit] &&
 		    addr < (unsigned long)&page->page->data[write])
@@ -1820,13 +1826,16 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 
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
@@ -1907,7 +1916,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	u64 delta;
 	int tail;
 
-	tail = local_read(&dpage->commit);
+	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1934,7 +1943,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto invalid;
 	}
 	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	entry_bytes += rb_page_size(cpu_buffer->reader_page);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
 	ts = head_page->page->time_stamp;
@@ -2054,7 +2063,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			local_inc(&cpu_buffer->pages_touched);
 
 		entries += ret;
-		entry_bytes += local_read(&head_page->page->commit);
+		entry_bytes += rb_page_size(head_page);
 		local_set(&cpu_buffer->head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
@@ -3256,12 +3265,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
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
@@ -4432,7 +4435,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
-		tail = local_read(&bpage->commit);
+		tail = local_read(&bpage->commit) & ~RB_MISSED_MASK;
 	} else if (info->add_timestamp &
 		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
 		/* Ignore events with absolute time stamps */

