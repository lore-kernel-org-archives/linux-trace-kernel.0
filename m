Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22921A44F;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795823; cv=none; b=dDhyGgmL++sEyGb1e+dknDYTCEPRXqIRKciEkoKttryK26eEwZqbiN+Sm8+iDBegCw/IsYOEWv6sTIjoxsiXYopf0dBpnOKv8iyNwFW6N20mSb61C/irS9WiMCuOxUeUJzIOd+d4xwSCQ1ppggIuO+BfDlmbSsuC1n2z8YU/dDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795823; c=relaxed/simple;
	bh=KWx+nKfsPYhG7VvvVT6qCZf6sy4hNxqWWF6sr4CGiUA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VB3CaS5hg7H+eVCetynOX7ypK+U659+hCnjZpfzf3HULyeOydXfpFCwwAwyrG3fLVB/qOPw0UMny5SS23KC/kaOgo+VOK4Cz32BgIDYhtt7VS4pLzbHqaSN7aMqkY8v/IHhvnnmkxRtwA73d3PK1OPtBYdLpTH7aBm3RPP252dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEFEC4CEE5;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEZ-00000007gU9-1hJu;
	Wed, 05 Feb 2025 17:51:03 -0500
Message-ID: <20250205225103.259337686@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/8] ring-buffer: Add buffer meta data for persistent ring buffer
References: <20250205225031.799739376@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of just having a meta data at the first page of each sub buffer
that has duplicate data, add a new meta page to the entire block of memory
that holds the duplicate data and remove it from the sub buffer meta data.

This will open up the extra memory in this first page to be used by the
tracer for its own persistent data.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 165 ++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7146b780176f..0446d053dbd6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -49,7 +49,12 @@ static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
 	int		magic;
-	int		struct_size;
+	int		struct_sizes;
+	unsigned long	total_size;
+	unsigned long	buffers_offset;
+};
+
+struct ring_buffer_cpu_meta {
 	unsigned long	kaslr_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
@@ -517,7 +522,7 @@ struct ring_buffer_per_cpu {
 	struct mutex			mapping_lock;
 	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
-	struct ring_buffer_meta		*ring_meta;
+	struct ring_buffer_cpu_meta	*ring_meta;
 
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -550,6 +555,8 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
+	struct ring_buffer_meta		*meta;
+
 	unsigned long			kaslr_addr;
 
 	unsigned int			subbuf_size;
@@ -1270,7 +1277,7 @@ static void rb_head_page_activate(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_set_list_to_head(head->list.prev);
 
 	if (cpu_buffer->ring_meta) {
-		struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+		struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 		meta->head_buffer = (unsigned long)head->page;
 	}
 }
@@ -1568,7 +1575,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 static unsigned long
 rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 {
-	addr += sizeof(struct ring_buffer_meta) +
+	addr += sizeof(struct ring_buffer_cpu_meta) +
 		sizeof(int) * nr_subbufs;
 	return ALIGN(addr, subbuf_size);
 }
@@ -1579,19 +1586,22 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 {
 	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
-	unsigned long ptr = buffer->range_addr_start;
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
+	struct ring_buffer_meta *bmeta;
+	unsigned long ptr;
 	int nr_subbufs;
 
-	if (!ptr)
+	bmeta = buffer->meta;
+	if (!bmeta)
 		return NULL;
 
+	ptr = (unsigned long)bmeta + bmeta->buffers_offset;
+	meta = (struct ring_buffer_cpu_meta *)ptr;
+
 	/* When nr_pages passed in is zero, the first meta has already been initialized */
 	if (!nr_pages) {
-		meta = (struct ring_buffer_meta *)ptr;
 		nr_subbufs = meta->nr_subbufs;
 	} else {
-		meta = NULL;
 		/* Include the reader page */
 		nr_subbufs = nr_pages + 1;
 	}
@@ -1623,7 +1633,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 }
 
 /* Return the start of subbufs given the meta pointer */
-static void *rb_subbufs_from_meta(struct ring_buffer_meta *meta)
+static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
 {
 	int subbuf_size = meta->subbuf_size;
 	unsigned long ptr;
@@ -1639,7 +1649,7 @@ static void *rb_subbufs_from_meta(struct ring_buffer_meta *meta)
  */
 static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 {
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
 	unsigned long ptr;
 	int subbuf_size;
 
@@ -1664,14 +1674,73 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 	return (void *)ptr;
 }
 
+/*
+ * See if the existing memory contains a valid meta section.
+ * if so, use that, otherwise initialize it.
+ */
+static bool rb_meta_init(struct trace_buffer *buffer)
+{
+	unsigned long ptr = buffer->range_addr_start;
+	struct ring_buffer_meta *bmeta;
+	unsigned long total_size;
+	int struct_sizes;
+
+	bmeta = (struct ring_buffer_meta *)ptr;
+	buffer->meta = bmeta;
+
+	total_size = buffer->range_addr_end - buffer->range_addr_start;
+
+	struct_sizes = sizeof(struct ring_buffer_cpu_meta);
+	struct_sizes |= sizeof(*bmeta) << 16;
+
+	/* The first buffer will start one page after the meta page */
+	ptr += sizeof(*bmeta);
+	ptr = ALIGN(ptr, PAGE_SIZE);
+
+	if (bmeta->magic != RING_BUFFER_META_MAGIC) {
+		pr_info("Ring buffer boot meta mismatch of magic\n");
+		goto init;
+	}
+
+	if (bmeta->struct_sizes != struct_sizes) {
+		pr_info("Ring buffer boot meta mismatch of struct size\n");
+		goto init;
+	}
+
+	if (bmeta->total_size != total_size) {
+		pr_info("Ring buffer boot meta mismatch of total size\n");
+		goto init;
+	}
+
+	if (bmeta->buffers_offset > bmeta->total_size) {
+		pr_info("Ring buffer boot meta mismatch of offset outside of total size\n");
+		goto init;
+	}
+
+	if (bmeta->buffers_offset != (void *)ptr - (void *)bmeta) {
+		pr_info("Ring buffer boot meta mismatch of first buffer offset\n");
+		goto init;
+	}
+
+	return true;
+
+ init:
+	bmeta->magic = RING_BUFFER_META_MAGIC;
+	bmeta->struct_sizes = struct_sizes;
+	bmeta->total_size = total_size;
+	bmeta->buffers_offset = (void *)ptr - (void *)bmeta;
+
+	return false;
+}
+
 /*
  * See if the existing memory contains valid ring buffer data.
  * As the previous kernel must be the same as this kernel, all
  * the calculations (size of buffers and number of buffers)
  * must be the same.
  */
-static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
-			  struct trace_buffer *buffer, int nr_pages)
+static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
+			      struct trace_buffer *buffer, int nr_pages)
 {
 	int subbuf_size = PAGE_SIZE;
 	struct buffer_data_page *subbuf;
@@ -1679,20 +1748,6 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
-	/* Check the meta magic and meta struct size */
-	if (meta->magic != RING_BUFFER_META_MAGIC ||
-	    meta->struct_size != sizeof(*meta)) {
-		pr_info("Ring buffer boot meta[%d] mismatch of magic or struct size\n", cpu);
-		return false;
-	}
-
-	/* The subbuffer's size and number of subbuffers must match */
-	if (meta->subbuf_size != subbuf_size ||
-	    meta->nr_subbufs != nr_pages + 1) {
-		pr_info("Ring buffer boot meta [%d] mismatch of subbuf_size/nr_pages\n", cpu);
-		return false;
-	}
-
 	buffers_start = meta->first_buffer;
 	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
 
@@ -1730,7 +1785,7 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	return true;
 }
 
-static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
+static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf);
 
 static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
 			       unsigned long long *timestamp, u64 *delta_ptr)
@@ -1797,7 +1852,7 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
 /* If the meta data has been validated, now validate the events */
 static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	struct buffer_page *head_page;
 	unsigned long entry_bytes = 0;
 	unsigned long entries = 0;
@@ -1873,7 +1928,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
+static void rb_meta_init_text_addr(struct ring_buffer_cpu_meta *meta)
 {
 #ifdef CONFIG_RANDOMIZE_BASE
 	meta->kaslr_addr = kaslr_offset();
@@ -1884,18 +1939,25 @@ static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
+	struct ring_buffer_meta *bmeta;
 	unsigned long delta;
 	void *subbuf;
+	bool valid = false;
 	int cpu;
 	int i;
 
+	if (rb_meta_init(buffer))
+		valid = true;
+
+	bmeta = buffer->meta;
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
-		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+		if (valid && rb_cpu_meta_valid(meta, cpu, buffer, nr_pages)) {
 			/* Make the mappings match the current address */
 			subbuf = rb_subbufs_from_meta(meta);
 			delta = (unsigned long)subbuf - meta->first_buffer;
@@ -1913,9 +1975,6 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 
 		memset(meta, 0, next_meta - (void *)meta);
 
-		meta->magic = RING_BUFFER_META_MAGIC;
-		meta->struct_size = sizeof(*meta);
-
 		meta->nr_subbufs = nr_pages + 1;
 		meta->subbuf_size = PAGE_SIZE;
 
@@ -1943,7 +2002,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 static void *rbm_start(struct seq_file *m, loff_t *pos)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val;
 
 	if (!meta)
@@ -1968,7 +2027,7 @@ static void *rbm_next(struct seq_file *m, void *v, loff_t *pos)
 static int rbm_show(struct seq_file *m, void *v)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long val = (unsigned long)v;
 
 	if (val == 1) {
@@ -2017,7 +2076,7 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 static void rb_meta_buffer_update(struct ring_buffer_per_cpu *cpu_buffer,
 				  struct buffer_page *bpage)
 {
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 
 	if (meta->head_buffer == (unsigned long)bpage->page)
 		cpu_buffer->head_page = bpage;
@@ -2032,7 +2091,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
-	struct ring_buffer_meta *meta = NULL;
+	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
 	gfp_t mflags;
@@ -2156,7 +2215,7 @@ static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
 	struct buffer_page *bpage;
 	struct page *page;
 	int ret;
@@ -2327,10 +2386,16 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	/* If start/end are specified, then that overrides size */
 	if (start && end) {
+		unsigned long buffers_start;
 		unsigned long ptr;
 		int n;
 
 		size = end - start;
+
+		/* Subtract the buffer meta data */
+		size -= PAGE_SIZE;
+		buffers_start = start + PAGE_SIZE;
+
 		size = size / nr_cpu_ids;
 
 		/*
@@ -2340,7 +2405,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		 * needed, plus account for the integer array index that
 		 * will be appended to the meta data.
 		 */
-		nr_pages = (size - sizeof(struct ring_buffer_meta)) /
+		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
 			(subbuf_size + sizeof(int));
 		/* Need at least two pages plus the reader page */
 		if (nr_pages < 3)
@@ -2348,8 +2413,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
  again:
 		/* Make sure that the size fits aligned */
-		for (n = 0, ptr = start; n < nr_cpu_ids; n++) {
-			ptr += sizeof(struct ring_buffer_meta) +
+		for (n = 0, ptr = buffers_start; n < nr_cpu_ids; n++) {
+			ptr += sizeof(struct ring_buffer_cpu_meta) +
 				sizeof(int) * nr_pages;
 			ptr = ALIGN(ptr, subbuf_size);
 			ptr += subbuf_size * nr_pages;
@@ -3075,7 +3140,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 }
 
 /* Return the index into the sub-buffers for a given sub-buffer */
-static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
+static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
 {
 	void *subbuf_array;
 
@@ -3087,7 +3152,7 @@ static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
 static void rb_update_meta_head(struct ring_buffer_per_cpu *cpu_buffer,
 				struct buffer_page *next_page)
 {
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	unsigned long old_head = (unsigned long)next_page->page;
 	unsigned long new_head;
 
@@ -3104,7 +3169,7 @@ static void rb_update_meta_head(struct ring_buffer_per_cpu *cpu_buffer,
 static void rb_update_meta_reader(struct ring_buffer_per_cpu *cpu_buffer,
 				  struct buffer_page *reader)
 {
-	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 	void *old_reader = cpu_buffer->reader_page->page;
 	void *new_reader = reader->page;
 	int id;
@@ -3733,7 +3798,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(&cpu_buffer->commit_page);
 		if (cpu_buffer->ring_meta) {
-			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 			meta->commit_buffer = (unsigned long)cpu_buffer->commit_page->page;
 		}
 		/* add barrier to keep gcc from optimizing too much */
@@ -5986,7 +6051,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	if (cpu_buffer->mapped) {
 		rb_update_meta_page(cpu_buffer);
 		if (cpu_buffer->ring_meta) {
-			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
 			meta->commit_buffer = meta->head_buffer;
 		}
 	}
@@ -6020,7 +6085,7 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
@@ -6058,7 +6123,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_meta *meta;
+	struct ring_buffer_cpu_meta *meta;
 	int cpu;
 
 	/* prevent another thread from changing buffer sizes */
-- 
2.45.2


