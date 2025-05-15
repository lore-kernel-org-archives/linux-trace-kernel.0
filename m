Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72B202C5D;
	Thu, 15 May 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307761; cv=none; b=DbrJhtcgRsKgn2MySjn7u8WHXNdqDhXP4MwFt5f4QUZ1Uvpg91Viot6fF6y45l7+Gnzc60dXgEjb9lStYo59trePWpyFZqh4ovXZUfz2IcjCZAh7ek2e8ANC1fRH9CInanW+OqnPZ4SdRdI8UtL6I0vNP7xsIE/dupnV4ojtCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307761; c=relaxed/simple;
	bh=15KP2pl6dWb1y5/Go7dvJ7kbiOO+tNWUThlBC2YivmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SX4vDmQDlzbr/NLFWHK7PabekUeMOgHbc0tZaNigiM9eaeJPZw2dvQt/u4IeI784m2lII7vbZHS8Be8cc9ulNKZ98YqbPOqYASylpeBvqMKWQXD4TE1nTeFyvGXATdNbb7vb7F60D7rh+W8FzMgLzjQNPB5+kuKEk82bPE9BjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyBnSX10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyBnSX10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F96C4CEE7;
	Thu, 15 May 2025 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747307760;
	bh=15KP2pl6dWb1y5/Go7dvJ7kbiOO+tNWUThlBC2YivmE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZyBnSX10tyblkRxhmOiwlDFQulDd2bDibTSzQPGXi6i3yyH1BYCxHSfHK56elpRJq
	 GcYJ8YF5ORkfHwgyBccI6P0EJXcg7ADzjGILpz6MTn5k04D6pmAabAMIYfmykukkOB
	 jZd+tnvB0M6mjcGZ5LKYGAyznOakpmbpE/oIHCWmxK+j0270J619f7aO3hmIogCfIu
	 QR7Fm29pVfvHGmSn+XTh4jsEoyF2cFfJ2H+F/l+q0DN6a6xCKqa6XRZ5dJu2nDoDGq
	 mkTDSxQJlIOUzkbBm2jrspv7G0wS1BpCRljPlV5c/KGTfRboNuxR4gSWcDFMxqWYF1
	 bHovMBag8j1Kw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: ring_buffer: Rewind persistent ring buffer when reboot
Date: Thu, 15 May 2025 20:15:56 +0900
Message-ID:  <174730775661.3893490.10420015749079085314.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
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
 Changes in v2:
  - Stop rewind if timestamp is not older.
  - Rewind reader page and reset all indexes.
  - Make ring_buffer_read_page() not clear the commit size.
---
 kernel/trace/ring_buffer.c |   99 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6859008ca34d..48f5f248eb4c 100644
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
@@ -1885,8 +1893,93 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
+		goto rewound;
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
+
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
+	pr_info("Rewound %d pages on cpu%d\n", i, cpu_buffer->cpu);
+
+	/* The last rewound page must be skipped. */
+	if (head_page != orig_head)
+		rb_inc_page(&head_page);
 
+	/* If there are rewound pages, rewind the reader page too. */
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
+		/* Make the head_page tthe new read page */
+		cpu_buffer->reader_page = head_page;
+		bpage = head_page;
+		rb_inc_page(&head_page);
+		head_page->list.prev = bpage->list.prev;
+		rb_dec_page(&bpage);
+		bpage->list.next = &head_page->list;
+		rb_set_list_to_head(&bpage->list);
+
+		cpu_buffer->head_page = head_page;
+		meta->head_buffer = (unsigned long)head_page->page;
+
+		/* Reset all the indexes */
+		bpage = cpu_buffer->reader_page;
+		meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
+		bpage->id = 0;
+
+		for (i = 0, bpage = head_page; i < meta->nr_subbufs;
+		     i++, rb_inc_page(&bpage)) {
+			meta->buffers[i + 1] = rb_meta_subbuf_idx(meta, bpage->page);
+			bpage->id = i + 1;
+		}
+
+		/* We'll restart verifying from orig_head */
+		head_page = orig_head;
+	}
+
+ rewound:
 	/* If the commit_buffer is the reader page, update the commit page */
 	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
 		cpu_buffer->commit_page = cpu_buffer->reader_page;
@@ -5348,7 +5441,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:
@@ -6642,7 +6734,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
-		rb_init_page(bpage);
 		bpage = reader->page;
 		reader->page = data_page->data;
 		local_set(&reader->write, 0);

