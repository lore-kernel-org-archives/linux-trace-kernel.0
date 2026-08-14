Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888626A0A7;
	Fri, 14 Aug 2026 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672339; cv=none; b=ovlxCCU6qCkteHwAbuluKL6CDvr7wVQVGB90+w6YqE6jwhXkhG9cE75KKqZguib2j5/eYCsmFJuH0D4ocNfz6toXy2n9ZNRPYDe+L4a5mQ58XVrLYHgvAt30FlWtcRmSpM66plgewnWmZA+IxIvgRRrAXUTy0/iDawxtleMjetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672339; c=relaxed/simple;
	bh=LNHWwHbwR1rSjCEmN+gVjYVUkwxkDO6FtC8ucn2eP40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K29aDq3iucvdvkoQzuZ7wWo2iSnbxDXDnEKI4ZMDytEgwrnrmwg7xuMBY00e2BXS60bB9Ws3vs3LejGpp+50XuybJdbe7XcfPJ/iEXgPSkxhrwFQr7w5l8ncB9CwjmYMnjqu4TEK9ei4NW4vqVgqZWK74174qNQoJhAao8t4daY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=lgYsBqTO; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="lgYsBqTO"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A4FD94019C;
	Fri, 14 Aug 2026 01:52:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 15ECD18;
	Fri, 14 Aug 2026 01:52:13 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:52:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Fixes for subbuf resizing
Message-ID: <20260813215230.7aa47950@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 15ECD18
X-Stat-Signature: iqmmauui859w4mqk8neykzbot7zjjumt
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xN+T7yWXpluoRc7im6ef11N5YBHaNq5w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Lm682mm5qrmm0OYuX1GpQ4c8SSKGptGqywGx2ygh390=; b=lgYsBqTOnNu0xFhaS2997or08KTEi2wXq9weornHPnlWn40sglyExw+j7GL1hfdN7gNheKOU52DYcSgQWzy6p/vCi3hMpqGI6QGx8pAzNkKQqXAeEuDky8DqvG62oC/mAVOIJDRiy5GHkgO874GkiFl5IhqDG/x2zaKwldYWtcU=
X-HE-Tag: 1786672333-305443
X-HE-Meta: U2FsdGVkX195FY9Qg5dF/1G6Tu/ZXmYM+V4PL2j3JQBA8GB9mYVFJR7CDNTgl4Oh8lM/slCJ4FB4BLiVA+R3eQKp4YCZbUVDWCsq+kttTyqYGUqAHFQMq9syDgx0GrycMyTvIJPSt3kbP6H/X1bbt1NXLr0fberzZfVzKHiTNfCxyxNzUQw13UfXQEK1bK65/rEYyWACunBJ2QiYmyc7bj/n1nCFSQ0OYw2d2gUSPimT4tgUYgv1A8Y/WK+TjWS+BpDcNZiVNyGzEOCS9yrVeeCK2mswutePYyxQdq+9kqpV7wRGo+ofHOe40RoSFXV/f5Tz3OXYNLqVEsjFVAvyS+fUz2x9bOEtna9vj+Wt2O12YdaJhS7ntIjhqITeEbSJyW2/fY034po5hwtVHq1siH+S+VXNVQXcFQKrmgQk0VE=

From: Vincent Donnefort <vdonnefort@google.com>

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---

This is patches 1-5,7-9 of series: https://lore.kernel.org/all/20260813131152.3589632-1-vdonnefort@google.com/

I'm running them through my tests right now. But I wanted to see what
Sashiko thinks of them as one big patch. In the series, Sashiko kept
complaining about existing issues that were fixed later in the series.
Sending this as one big patch will hopefully have it give better feedback.

 kernel/trace/ring_buffer.c | 268 ++++++++++++++++++++++---------------
 1 file changed, 158 insertions(+), 110 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2667992f0aa2..5412280e45b8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -391,6 +391,17 @@ static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
 	return rb_data_page_size(bpage->page);
 }
 
+/**
+ * rb_page_capacity - Get the capacity of a buffer page
+ * @bpage:	The buffer page
+ *
+ * Return: The maximum size available for events in the given buffer page.
+ */
+static __always_inline unsigned int rb_page_capacity(struct buffer_page *bpage)
+{
+	return (PAGE_SIZE << bpage->order) - BUF_PAGE_HDR_SIZE;
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	/* Range pages are not to be freed */
@@ -503,11 +514,11 @@ struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
 	atomic_t			resize_disabled;
-	struct trace_buffer	*buffer;
+	struct trace_buffer		*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
 	struct lock_class_key		lock_key;
-	struct buffer_data_page		*free_page;
+	struct buffer_data_read_page	free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
@@ -541,7 +552,6 @@ struct ring_buffer_per_cpu {
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
 
-	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
 	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
@@ -561,7 +571,6 @@ struct ring_buffer_per_cpu {
 
 struct trace_buffer {
 	unsigned			flags;
-	int				cpus;
 	atomic_t			record_disabled;
 	atomic_t			resizing;
 	cpumask_var_t			cpumask;
@@ -586,11 +595,63 @@ struct trace_buffer {
 
 	struct ring_buffer_meta		*meta;
 
-	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
-	unsigned int			max_data_size;
 };
 
+static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
+{
+	return PAGE_SIZE << buffer->subbuf_order;
+}
+
+/**
+ * rb_subbuf_capacity - Get the capacity of a subbuffer
+ * @buffer:	A trace buffer
+ *
+ * Unsafe to use without holding trace_buffer::mutex or with resizing enabled.
+ * Consider rb_page_capacity() instead.
+ *
+ * Return: The maximum size available for events in a trace buffer subbuffer.
+ */
+static __always_inline unsigned int rb_subbuf_capacity(struct trace_buffer *buffer)
+{
+	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
+}
+
+/**
+ * rb_subbuf_max_data_size - Get the maximum payload size of a single event
+ * @buffer:	A trace buffer
+ *
+ * Return: The maximum data payload size that can be stored in a single event.
+ */
+static __always_inline unsigned int rb_subbuf_max_data_size(struct trace_buffer *buffer)
+{
+	struct ring_buffer_event *event;
+
+	/*
+	 * surely rb_subbuf_capacity() is bigger than
+	 * RINGBUF_TYPE_DATA_TYPE_LEN_MAX (see ring_buffer_event_length).
+	 */
+	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
+}
+
+/**
+ * rb_subbuf_start - Get the start address of a subbuffer
+ * @buffer:	A trace buffer
+ * @addr:	An address of an event on a subbuffer
+ *
+ * Return: The start of the subbuffer for where @addr sits
+ */
+static __always_inline
+unsigned long rb_subbuf_start(struct trace_buffer *buffer, unsigned long addr)
+{
+	return addr & ~((unsigned long)(rb_subbuf_size(buffer) - 1));
+}
+
+static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -630,7 +691,7 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)(buffer ? buffer->subbuf_size :
+			 (unsigned int)(buffer ? rb_subbuf_capacity(buffer) :
 						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
@@ -1620,7 +1681,7 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
  */
 static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 {
-	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
 	unsigned long ptr;
@@ -2432,8 +2493,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			bpage->id = i + 1;
 			cpu_buffer->subbuf_ids[i + 1] = bpage;
 		} else {
-			int order = cpu_buffer->buffer->subbuf_order;
-			bpage->page = alloc_cpu_data(cpu_buffer->cpu, order);
+			bpage->page = alloc_cpu_data(cpu_buffer->cpu,
+						     cpu_buffer->buffer->subbuf_order);
 			if (!bpage->page)
 				goto free_pages;
 		}
@@ -2521,7 +2582,6 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		 * Range mapped buffers have the same restrictions as memory
 		 * mapped ones do.
 		 */
-		cpu_buffer->mapped = 1;
 		cpu_buffer->ring_meta = rb_range_meta(buffer, nr_pages, cpu);
 		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
@@ -2556,8 +2616,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		bpage->range = 1;
 		cpu_buffer->subbuf_ids[0] = bpage;
 	} else {
-		int order = cpu_buffer->buffer->subbuf_order;
-		bpage->page = alloc_cpu_data(cpu, order);
+		bpage->page = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->page)
 			goto fail_free_reader;
 	}
@@ -2631,7 +2690,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_page((unsigned long)cpu_buffer->free_page);
+	free_pages((unsigned long)cpu_buffer->free_page.data, cpu_buffer->free_page.order);
 
 	kfree(cpu_buffer);
 }
@@ -2731,10 +2790,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
-	buffer->subbuf_size = subbuf_size - BUF_PAGE_HDR_SIZE;
-
-	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
 
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
@@ -2743,7 +2798,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-	buffer->cpus = nr_cpu_ids;
 
 	bsize = sizeof(void *) * nr_cpu_ids;
 	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
@@ -2818,9 +2872,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		if (nr_pages < 2)
 			goto fail_free_buffers;
 	} else {
-
 		/* need at least two pages */
-		nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
+		nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
 		if (nr_pages < 2)
 			nr_pages = 2;
 	}
@@ -3203,7 +3256,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * buffer->subbuf_size.
+ * Minimum size is 2 * rb_subbuf_capacity(buffer).
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -3225,12 +3278,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
 		return 0;
 
-	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
-
-	/* we need a minimum of two pages */
-	if (nr_pages < 2)
-		nr_pages = 2;
-
 	/*
 	 * Keep CPUs from coming online while resizing to synchronize
 	 * with new per CPU buffers being created.
@@ -3241,6 +3288,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
 
+	nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
+
+	/* we need a minimum of two pages */
+	if (nr_pages < 2)
+		nr_pages = 2;
+
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
 		 * Don't succeed if resizing is disabled, as a reader might be
@@ -3513,7 +3566,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
 {
 	unsigned long addr = (unsigned long)event;
 
-	addr &= (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1;
+	addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
 
 	return addr - BUF_PAGE_HDR_SIZE;
 }
@@ -3755,8 +3808,8 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *tail_page = info->tail_page;
+	unsigned long bsize = rb_page_capacity(tail_page);
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
 
@@ -4101,8 +4154,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	new_index = rb_event_index(cpu_buffer, event);
 	old_index = new_index + rb_event_ts_length(event);
-	addr = (unsigned long)event;
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr = rb_subbuf_start(cpu_buffer->buffer, (unsigned long)event);
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
@@ -4767,7 +4819,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
+	if (unlikely(write > rb_page_capacity(tail_page))) {
 		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
@@ -4903,7 +4955,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
-		if (info.length > cpu_buffer->buffer->max_data_size)
+		if (info.length > rb_subbuf_max_data_size(cpu_buffer->buffer))
 			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
@@ -4978,7 +5030,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > buffer->max_data_size))
+	if (unlikely(length > rb_subbuf_max_data_size(buffer)))
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -5012,7 +5064,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage = cpu_buffer->commit_page;
 	struct buffer_page *start;
 
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr = rb_subbuf_start(cpu_buffer->buffer, addr);
 
 	/* Do the likely case first */
 	if (likely(bpage->page == (void *)addr)) {
@@ -5125,7 +5177,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		return -EBUSY;
 
-	if (length > buffer->max_data_size)
+	if (length > rb_subbuf_max_data_size(buffer))
 		return -EBUSY;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -5799,7 +5851,6 @@ static struct buffer_page *
 __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	int max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
@@ -5947,7 +5998,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 #define USECS_WAIT	1000000
         for (nr_loops = 0; nr_loops < USECS_WAIT; nr_loops++) {
 		/* If the write is past the end of page, a writer is still updating it */
-		if (likely(!reader || rb_page_write(reader) <= bsize))
+		if (likely(!reader || rb_page_write(reader) <= rb_page_capacity(reader)))
 			break;
 
 		udelay(1);
@@ -6380,36 +6431,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
 struct ring_buffer_iter *
 ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 {
+	struct ring_buffer_iter *iter __free(kfree) = kzalloc_obj(*iter, flags);
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_iter *iter;
 
-	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		return NULL;
-
-	iter = kzalloc_obj(*iter, flags);
 	if (!iter)
 		return NULL;
 
-	/* Holds the entire event: data and meta data */
-	iter->event_size = buffer->subbuf_size;
-	iter->event = kmalloc(iter->event_size, flags);
-	if (!iter->event) {
-		kfree(iter);
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
-	}
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	iter->cpu_buffer = cpu_buffer;
+	/*
+	 * Only KDB is using GFP_ATOMIC, for the others, lock the buffer to
+	 * prevent concurrent resizing.
+	 */
+	if (gfpflags_allow_blocking(flags))
+		mutex_lock(&buffer->mutex);
 
 	atomic_inc(&cpu_buffer->resize_disabled);
 
+	if (gfpflags_allow_blocking(flags))
+		mutex_unlock(&buffer->mutex);
+
+	/* Holds the entire event: data and meta data. */
+	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
+	iter->event = kmalloc(iter->event_size, flags);
+	if (!iter->event) {
+		atomic_dec(&cpu_buffer->resize_disabled);
+		return NULL;
+	}
+	iter->cpu_buffer = cpu_buffer;
+
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 	arch_spin_lock(&cpu_buffer->lock);
 	rb_iter_reset(iter);
 	arch_spin_unlock(&cpu_buffer->lock);
 
-	return iter;
+	return_ptr(iter);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_start);
 
@@ -6463,7 +6522,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
+	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -6477,8 +6536,9 @@ unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
 	/* If abs timestamp is requested, events have a timestamp too */
 	if (ring_buffer_time_stamp_abs(buffer))
-		return buffer->max_data_size - RB_LEN_TIME_EXTEND;
-	return buffer->max_data_size;
+		return rb_subbuf_max_data_size(buffer) - RB_LEN_TIME_EXTEND;
+
+	return rb_subbuf_max_data_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
 
@@ -6610,12 +6670,11 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 
-	if (cpu_buffer->mapped) {
-		rb_update_meta_page(cpu_buffer);
-		if (cpu_buffer->ring_meta) {
-			struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
-			meta->commit_buffer = meta->head_buffer;
-		}
+	rb_update_meta_page(cpu_buffer);
+	if (cpu_buffer->ring_meta) {
+		struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
+
+		meta->commit_buffer = meta->head_buffer;
 	}
 }
 
@@ -6864,8 +6923,8 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
-	/* It's up to the callers to not try to swap mapped buffers */
-	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
+	/* It's up to the callers to not try to swap static buffers */
+	if (WARN_ON_ONCE(rb_is_static(cpu_buffer_a) || rb_is_static(cpu_buffer_b)))
 		return -EBUSY;
 
 	/* At least make sure the two buffers are somewhat the same */
@@ -6962,9 +7021,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (cpu_buffer->free_page) {
-		bpage->data = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+	if (cpu_buffer->free_page.data) {
+		*bpage = cpu_buffer->free_page;
+		cpu_buffer->free_page.data = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
@@ -6973,7 +7032,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);
@@ -7016,8 +7075,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
-		cpu_buffer->free_page = dpage;
+	if (!cpu_buffer->free_page.data) {
+		cpu_buffer->free_page = *data_page;
 		dpage = NULL;
 	}
 
@@ -7077,7 +7136,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
-	bool force_memcpy;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -1;
@@ -7094,15 +7152,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	if (data_page->order != cpu_buffer->reader_page->order)
+		return -1;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;
@@ -7116,8 +7174,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	force_memcpy = cpu_buffer->mapped || cpu_buffer->remote;
-
 	/*
 	 * If this page has been partially read or
 	 * if len is not big enough to read the rest of the page or
@@ -7127,7 +7183,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 */
 	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    force_memcpy) {
+	    rb_is_static(cpu_buffer)) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7228,7 +7284,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    buffer->subbuf_size - size >= sizeof(missed_events)) {
+		    rb_page_capacity(reader) - size >= sizeof(missed_events)) {
 			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7248,8 +7304,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (size < buffer->subbuf_size)
-		memset(&dpage->data[size], 0, buffer->subbuf_size - size);
+	if (size < rb_page_capacity(reader))
+		memset(&dpage->data[size], 0, rb_page_capacity(reader) - size);
 
 	return read;
 }
@@ -7275,7 +7331,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
  */
 int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
 {
-	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	return rb_subbuf_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
 
@@ -7320,7 +7376,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
-	int old_order, old_size;
+	unsigned int old_capacity;
+	int old_order;
 	int nr_pages;
 	int psize;
 	int err;
@@ -7329,9 +7386,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (!buffer || order < 0)
 		return -EINVAL;
 
-	if (buffer->subbuf_order == order)
-		return 0;
-
 	psize = (1 << order) * PAGE_SIZE;
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
@@ -7340,18 +7394,21 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
-	old_order = buffer->subbuf_order;
-	old_size = buffer->subbuf_size;
-
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
+
+	old_order = buffer->subbuf_order;
+	if (old_order == order)
+		return 0;
+
+	old_capacity = rb_subbuf_capacity(buffer);
+
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
 	buffer->subbuf_order = order;
-	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -7367,8 +7424,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
+		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -7390,7 +7447,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_data_page *old_free_data_page;
+		struct buffer_data_read_page old_free_data_page;
 		struct list_head old_pages;
 		unsigned long flags;
 
@@ -7431,8 +7488,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
+		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
-		cpu_buffer->free_page = NULL;
+		cpu_buffer->free_page.data = NULL;
+		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
 
@@ -7443,7 +7502,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
-		free_pages((unsigned long)old_free_data_page, old_order);
+		free_pages((unsigned long)old_free_data_page.data, old_free_data_page.order);
 
 		rb_check_pages(cpu_buffer);
 	}
@@ -7454,7 +7513,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 error:
 	buffer->subbuf_order = old_order;
-	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
 
@@ -7532,7 +7590,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
-	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->subbuf_size = rb_subbuf_size(cpu_buffer->buffer);
 	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
@@ -7574,11 +7632,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
-	/* mapped is always greater or equal to user_mapped */
-	if (WARN_ON(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		return -EINVAL;
-
-	if (inc && cpu_buffer->mapped == UINT_MAX)
+	if (inc && cpu_buffer->user_mapped == UINT_MAX)
 		return -EBUSY;
 
 	if (WARN_ON(!inc && cpu_buffer->user_mapped == 0))
@@ -7587,13 +7641,10 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 	mutex_lock(&cpu_buffer->buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	if (inc) {
+	if (inc)
 		cpu_buffer->user_mapped++;
-		cpu_buffer->mapped++;
-	} else {
+	else
 		cpu_buffer->user_mapped--;
-		cpu_buffer->mapped--;
-	}
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	mutex_unlock(&cpu_buffer->buffer->mutex);
@@ -7765,7 +7816,6 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 		/* This is the first time it is mapped by user */
-		cpu_buffer->mapped++;
 		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
@@ -7822,8 +7872,6 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
-	if (!WARN_ON_ONCE(cpu_buffer->mapped < cpu_buffer->user_mapped))
-		cpu_buffer->mapped--;
 	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
@@ -7894,7 +7942,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 			 * missed events, then record it there.
 			 */
 			commit = rb_page_size(reader);
-			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+			if (rb_page_capacity(reader) - commit >= sizeof(missed_events)) {
 				memcpy(&dpage->data[commit], &missed_events,
 				       sizeof(missed_events));
 				local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7926,7 +7974,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
-				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
+				rb_subbuf_size(buffer));
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.53.0

