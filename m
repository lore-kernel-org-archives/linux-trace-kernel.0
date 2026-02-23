Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAD2F1FE3;
	Mon, 23 Feb 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863375; cv=none; b=QXuGRarhD3REPbA+xdBx00RyqD5bMwPfypBVSAAhrwIP4klBRwMBSDZ+R2KLDBk6y4YzodjGohsXM3U60psaCHO7McAss0GvqdgvIYXRAzZgiJzhhSxrRjQgJPaYqIlP62fic2dcu7w1MJu3i/QY4FId+UVAQ5wR0rSsAF4rYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863375; c=relaxed/simple;
	bh=0pbqO0F3l3QRs4B59lfrQV2R9nevsILl2m+O42Mcm3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzQE3zpyLHsNM+lJMT8vcM7dBTZe31uJKw1mZJS4s7zy7Ln+YI1o+2e2dbALL9tesIjgugCBpNg6CZmOs7sudAAB63svOQ5Bw2UnOOm2DClp1oLelw3Ph1kN25s6c3mHgvsbcvFqYlkp70O+qCnhUaHHRxtd105ud54OQ7SNUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayRCzYTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayRCzYTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B998C116D0;
	Mon, 23 Feb 2026 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771863374;
	bh=0pbqO0F3l3QRs4B59lfrQV2R9nevsILl2m+O42Mcm3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayRCzYTlHL3DkZa9lv5+664wmx2agVZNfol8cmPfOpTmF0RSfvIS9ogMyFEW8QFAr
	 DYY14NsVNKSFfs6mvQZdTt/ryVxtfbFlFTZw/x2ETh9ui7uasgkl1ku42ycHMuUwYm
	 DzPDC6Sd/bc8AJfrcELUmYBdixddgQPxsdc8bWaqPbK+HJ1+G/sM1/K4xVVYdI4zoA
	 WC4DQ03dggYPrVy+6MKAc2xCO2SKQmeqL5dQhi40bITuC1Rv3kwOfs/se/AubGsnfN
	 zQDLl0dqcZ772OjsDTh6lqFfiAvmV89M0oIb+2b91lC/3C1JlGyVbLmtU5H8Mst+0E
	 e8+jh/J2RlUwg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ring-buffer: Handle RB_MISSED_* flags on commit field correctly
Date: Tue, 24 Feb 2026 01:16:11 +0900
Message-ID: <177186337098.133407.17816322157924593847.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177186335195.133407.907308822749006594.stgit@devnote2>
References: <177186335195.133407.907308822749006594.stgit@devnote2>
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
 Changes in v3:
  - Newly added.
---
 kernel/trace/ring_buffer.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 84a6459ed494..1ef718d21796 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -395,6 +395,18 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 	return local_read(&bpage->page->commit);
 }
 
+/* Size is determined by what has been committed */
+static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
+{
+	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
+}
+
+static __always_inline unsigned
+rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return rb_page_commit(cpu_buffer->commit_page);
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	/* Range pages are not to be freed */
@@ -1907,7 +1919,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	u64 delta;
 	int tail;
 
-	tail = local_read(&dpage->commit);
+	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
@@ -1934,7 +1946,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto invalid;
 	}
 	entries += ret;
-	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	entry_bytes += rb_page_size(cpu_buffer->reader_page);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
 	ts = head_page->page->time_stamp;
@@ -2054,7 +2066,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 			local_inc(&cpu_buffer->pages_touched);
 
 		entries += ret;
-		entry_bytes += local_read(&head_page->page->commit);
+		entry_bytes += rb_page_size(head_page);
 		local_set(&cpu_buffer->head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
@@ -3257,18 +3269,6 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	return NULL;
 }
 
-/* Size is determined by what has been committed */
-static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
-{
-	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
-}
-
-static __always_inline unsigned
-rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
-{
-	return rb_page_commit(cpu_buffer->commit_page);
-}
-
 static __always_inline unsigned
 rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event *event)
 {
@@ -4433,7 +4433,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (tail == CHECK_FULL_PAGE) {
 		full = true;
-		tail = local_read(&bpage->commit);
+		tail = local_read(&bpage->commit) & ~RB_MISSED_MASK;
 	} else if (info->add_timestamp &
 		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
 		/* Ignore events with absolute time stamps */

