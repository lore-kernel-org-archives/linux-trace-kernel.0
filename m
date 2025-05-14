Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887D19A;
	Wed, 14 May 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182733; cv=none; b=F75mAZADyMKr4MtiQ1AK5AQy8K8BUTEcRU6M/JdbysuHu4S3AtpqKFTkALl2v85G8pLGFenVhHJVx1SgMqidZ7kw+XVNkK8Rgt842Xda/Cyw/eNwJxmE6tt9NoX/wBbkX12Iec/4b4zy0WnO3aFgo0SNuMbxXlsSg2k+iJ1DBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182733; c=relaxed/simple;
	bh=TYA6y6LVyjRM6RpZjryDyLGn4K8/QVPIoOYa5BUTDzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZlnuDwmq6wt80r42nMX2vIBJ8Z4EsUyWmKowHd0y0LmWsmRT4RgGzu6XrOwffltywDLVaW+sFb/rldjOn/KbMay2EYTwRg/yCUgd2tGLpCQyAJy8lxol6bKjY37Pc57oxJw30K7ERqF5Xc5AfwO4DUyutEuhZxM5yUjfnrJUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE30C4CEE4;
	Wed, 14 May 2025 00:32:12 +0000 (UTC)
Date: Tue, 13 May 2025 20:32:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-ID: <20250513203237.0e7ff662@gandalf.local.home>
In-Reply-To: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
References: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:50:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Rewind persistent ring buffer pages which have been read in the
> previous boot. Those pages are highly possible to be lost before
> writing it to the disk if the previous kernel crashed. In this
> case, the trace data is kept on the persistent ring buffer, but
> it can not be read because its commit size has been reset after
> read.
> This skips clearing the commit size of each sub-buffer and
> recover it after reboot.
> 
> Note: If you read the previous boot data via trace_pipe, that
> is not accessible in that time. But reboot without clearing (or
> reusing) the read data, the read data is recovered again in the
> next boot.
> Thus, when you read the previous boot data, clear it by
> `echo > trace`.

Is that a problem? I'm thinking that the data in the buffer should not be
used. Anyway, I had to fix a bug with trace_pipe:

  https://lore.kernel.org/linux-trace-kernel/20250513115032.3e0b97f7@gandalf.local.home/

And with that applied, it doesn't rewind all the way, but still gives you
what's left on the reader page. I think that is the case without this patch
too.

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ring_buffer.c |   55
> ++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 52
> insertions(+), 3 deletions(-)

Anyway, I found that this is a lot more complex than what you have here. As
the commit size is set to zero when added back into the ring buffer, I
needed to remove that. But things get much more trickier than that!

First, we need to make the new head page found (the one that was read
already) the new "reader page". And we need to insert the old reader page
back into the ring buffer. And reset everything to handle all of this.

I played a little with it, and came up with this. It's still a bit buggy,
but it does give you an idea of what needs to be done.

-- Steve

This is on top of the trace_pipe fix in the link above.

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6859008ca34d..f5dd96ca25c9 100644
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
@@ -1862,13 +1869,17 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 }
 
+static void rb_update_meta_reader(struct ring_buffer_per_cpu *cpu_buffer,
+				  struct buffer_page *reader);
+
 /* If the meta data has been validated, now validate the events */
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-	struct buffer_page *head_page;
+	struct buffer_page *head_page, *orig_head;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
+	u64 ts;
 	int ret;
 	int i;
 
@@ -1885,8 +1896,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	head_page = cpu_buffer->head_page;
-
 	/* If the commit_buffer is the reader page, update the commit page */
 	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
 		cpu_buffer->commit_page = cpu_buffer->reader_page;
@@ -1894,6 +1903,88 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 		goto done;
 	}
 
+	orig_head = head_page = cpu_buffer->head_page;
+	ts = cpu_buffer->reader_page->page->time_stamp;
+
+	/*
+	 * Try to rewind the head so that we can read the pages which already
+	 * read in the previous boot.
+	 */
+	if (head_page != cpu_buffer->tail_page)
+		rb_dec_page(&head_page);
+
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
+
+		/* Rewind until tail (writer) page. */
+		if (head_page == cpu_buffer->tail_page)
+			break;
+
+		if (ts < head_page->page->time_stamp)
+			break;
+
+		ts = head_page->page->time_stamp;
+		if (!ts)
+			break;
+
+		if (rb_page_commit(head_page) == 0)
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
+	}
+
+	/* The last rewind page must be skipped. */
+	if (head_page != orig_head)
+		rb_inc_page(&head_page);
+
+	if (head_page != orig_head) {
+		struct buffer_page *bpage = orig_head;
+
+		rb_dec_page(&bpage);
+		/*
+		 * Move the reader page between the orig_head and the page
+		 * before it.
+		 */
+		cpu_buffer->reader_page->list.next = &orig_head->list;
+		cpu_buffer->reader_page->list.prev = orig_head->list.prev;
+		orig_head->list.prev = &cpu_buffer->reader_page->list;
+
+		bpage->list.next = &cpu_buffer->reader_page->list;
+
+		/* Make the head_page the new reader page */
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
+		head_page = orig_head;
+	}
+
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
 
@@ -5348,7 +5439,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:
@@ -6642,7 +6732,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
-		rb_init_page(bpage);
+//		rb_init_page(bpage);
 		bpage = reader->page;
 		reader->page = data_page->data;
 		local_set(&reader->write, 0);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index cf51c30b137f..2a060c62d686 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6066,6 +6066,7 @@ struct trace_mod_entry {
 };
 
 struct trace_scratch {
+	int			clock_id;
 	unsigned long		text_addr;
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
@@ -6181,6 +6182,7 @@ static void update_last_data(struct trace_array *tr)
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
 
+		tscratch->clock_id = tr->clock_id;
 		memset(tscratch->entries, 0,
 		       flex_array_size(tscratch, entries, tscratch->nr_entries));
 		tscratch->nr_entries = 0;
@@ -7403,6 +7405,12 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
 
+	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
+		struct trace_scratch *tscratch = tr->scratch;
+
+		tscratch->clock_id = i;
+	}
+
 	mutex_unlock(&trace_types_lock);
 
 	return 0;
@@ -9628,6 +9636,14 @@ static void setup_trace_scratch(struct trace_array *tr,
 
 	/* Scan modules to make text delta for modules. */
 	module_for_each_mod(make_mod_delta, tr);
+
+	/* Set trace_clock as the same of the previous boot. */
+	if (tscratch->clock_id != tr->clock_id) {
+		if (tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
+			pr_info("the previous trace_clock info is not valid.");
+			goto reset;
+		}
+	}
 	return;
  reset:
 	/* Invalid trace modules */
