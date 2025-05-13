Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316E54640;
	Tue, 13 May 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097431; cv=none; b=sgJX0JA8OImvfcs5PKDz4jJNGR1bQE8ghIQbPRxmzVGisEDqjhN5gEtMengfm0XhA0hhCCHmWeNodt7fPmP9iFAm1pDTtNCFfjjqBSgNfEHV+ul53cdgb2zLBQq8uTx7jTkwdTFqyDbvVcsQWcQ8txCMRWFfnCE69o7S7rd42A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097431; c=relaxed/simple;
	bh=Fd+P8BGD5ZHFi/NqDbXbGvpzJAUzu/oA65q/isK42lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhqPO9YvOq3Fb745MlNxjJMQxZej31zBEWVdtbi3aWSTRXtXPubc3AvVycvG2Z/4v4Tj27n4fUY4MDqIKcn/67WoLejr7LsKpW7+EtwJ2ne203cc7zh8Wblrd8onBo0germu4kR5zoNvh8CxTOgqMl7MUm9JCTw/kduUatwbjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFOc4aB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFOc4aB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357BC4CEE7;
	Tue, 13 May 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747097431;
	bh=Fd+P8BGD5ZHFi/NqDbXbGvpzJAUzu/oA65q/isK42lA=;
	h=From:To:Cc:Subject:Date:From;
	b=cFOc4aB9x+fPhg6DS2WHJaomYFCGxETDw8mFo4d66m+F56GW8oa16ZcfVDlBuq5Se
	 QuiHoZL7gfjRfdCtMUxcCUHhYcKNuX3cvVgZZMrNEyGHWLdpCNW+KZ6G3CAYgRKG00
	 MWyf/ZTN4LGw6OD3C3Bd1y6WPAKzo/2MPLNs+IAcTbmKOqnvkAjAVM3WAkKQrqNOKy
	 xUnhFAHW7h2FcSSsh3CeM79lKds7LMalwSRtcowDWOjW6WPpXDGkffDamVgVXZeXd7
	 BIPsqREv/1fhzBUhqAPrn5mVPwp7xc173NjIvQwo7FdBSytzaO09MtD/sLmixKCnMj
	 y7mn5KdPbwV6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer when reboot
Date: Tue, 13 May 2025 09:50:27 +0900
Message-ID:  <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
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
---
 kernel/trace/ring_buffer.c |   55 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1ca482955dae..a1014c8b8772 100644
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
@@ -1866,9 +1873,10 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-	struct buffer_page *head_page;
+	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	bool zero_commit;
 	int ret;
 	int i;
 
@@ -1885,7 +1893,49 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	head_page = cpu_buffer->head_page;
+	orig_head = head_page = cpu_buffer->head_page;
+
+	/*
+	 * Try to rewind the head so that we can read the pages which already
+	 * read in the previous boot.
+	 */
+	zero_commit = false;
+	rb_dec_page(&head_page);
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
+
+		/* Rewind until tail (writer) page. */
+		if (head_page == cpu_buffer->tail_page ||
+		    local_read(&head_page->write) /* under writing */)
+			break;
+
+		/* Stop rewind if the page is invalid. */
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		if (ret < 0)
+			break;
+
+		/* Recover the number of entries. */
+		local_set(&head_page->entries, ret);
+		if (ret)
+			local_inc(&cpu_buffer->pages_touched);
+		entries += ret;
+		entry_bytes += rb_page_commit(head_page);
+		/* If there are 2 zero commit pages, stop rewind. */
+		if (rb_page_commit(head_page) == 0) {
+			if (zero_commit)
+				break;
+			zero_commit = true;
+		} else
+			zero_commit = false;
+	}
+	/* The last rewind page must be skipped. */
+	rb_inc_page(&head_page);
+
+	if (head_page != orig_head) {
+		cpu_buffer->head_page = head_page;
+		head_page = orig_head;
+		if (zero_commit && rb_page_commit(head_page) == 0)
+			rb_inc_page(&head_page);
+	}
 
 	/* If both the head and commit are on the reader_page then we are done. */
 	if (head_page == cpu_buffer->reader_page &&
@@ -5346,7 +5396,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:

