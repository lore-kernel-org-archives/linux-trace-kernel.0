Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BC47D94D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626728; cv=none; b=YJGkdWBUQ18X3YaVGexz36VgMPuDofbhG5OuthSs+3pFecKvpyiFCVeIqLm44T04xu6AtsErEhPxVuACxPV1u+DSzBKVHVOfnXjP10Z+DAa4m1SWFS42P7g1E2Rhz3PKZuQMD/pofm0SFIiJoRoQ7zG6uxrSqL+SDpKn7NTlLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626728; c=relaxed/simple;
	bh=ajIoEyfb1D7FgWU035XmHhc/950sWbSJvTdKCHSsWDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXYTTEZx12O233zX9Lis/qZVLVilAFVTCNXHPxPGFu+6fjmDCWbfkvhAjbgPq7rsfPdh74krsXuSDBb7peh9er6mqkekzee/V85OllJUwRcM++LukHROhlqA8AQxZsDTjW5ozsqHkQAgyaw7BUjqjcOBoaRvMojxWeMBJZ6CZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGgqC/20; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGgqC/20"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so20151115e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626721; x=1787231521; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i381zhUNdDXU/dyA74ABOy7xndTbTrQQoiRpAn1jHa8=;
        b=mGgqC/20cZuSiJT+GFvvea1khgeMxikfU5wtntnYwePk35kfJ69TzoaA1lgCeeI4hm
         cDfTe0/1LZjSt2jg+CpzYi26YgYCjV2aFE+DFG5ED/ixxfNJt5roJbIONMvoL+XtBEbM
         9upU0qFvZtpqDBX0p7tjLaYabA7KG7Xuo2HDAGukM3wtOQI6aJERDAA8dejJEKLfXDBE
         KyO6F35QncPgZnIJek3/wjVsUE1LZQwt1YV+DAG0j3603rGyZalP8d0K0PMibzM/4LuS
         wzGPan6laeV+XN74PAQkX9HWFZLy/g0+OIGzFsstKX2dV6dKMSH246HiWXup/wiKM+77
         BreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626721; x=1787231521;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i381zhUNdDXU/dyA74ABOy7xndTbTrQQoiRpAn1jHa8=;
        b=qChXCA0B1NZCl8cIVZDJq6ldJ69vE9APCVWHTxmH6+TA+35j72qMEKvadDBkys8q8u
         DgpprD0md7VjmZULosOi0WUZYsId9VPQLUuTfIYWu9z2++oyiRC+QpPSQ8rwq7e2GCOo
         sD+L8tbXhNjYdXYCpCu3WYRSNAJstwI8VoV5ghvO1lO/5JUkzutYmJTezNEMwrZ1dVz6
         q5bjqfBeAmZLmQaACq2JA7wfjKRqXOWSHy/rgFm/GSU2BfKFBGVvVRt9YlJkb8Uqxxus
         Va2EfZdADEGLq6+jNhTgyJNoa+yuNcqE89Zzv8jbn8C29T9bX55s5ZYioVDrqBfT+SRf
         TKcg==
X-Forwarded-Encrypted: i=1; AHgh+RoLfjXVThpac8V1YQbc/P+zp+0POpjKdVuLIc+Q6MCbexro4bH/12gA8tW9/vc5gMyu3V9jv/KNGaOcEfESBewfkII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJd8FcvYnJXiKeqjLdm8d2GU8V4ZyFZ8Lf1zlTnAu+ecZl7VdP
	Yn2BszPEGFzr8tQERIx91JbRzBRpDDbaAq7dTpWmBeE5emmlD9rLEHEM2UjS/RxB6tm1k1qWk2A
	EAwhod86fWgeNUQ8CaNvJPQ==
X-Received: from wmij20.prod.google.com ([2002:a05:600c:4114:b0:495:5b3d:ed8e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1993:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49982187725mr57630225e9.3.1786626720257;
 Thu, 13 Aug 2026 06:12:00 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:46 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-5-vdonnefort@google.com>
Subject: [PATCH v5 04/10] ring-buffer: Fix subbuf resize race with ring buffer readers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

trace_buffer subbuf_size is read lockless in ring_buffer_read_page() and
ring_buffer_read_start(), while it can simultaneously be resized with
ring_buffer_subbuf_order_set().

Instead of trace_buffer::subbuf_size, use bpage::order in
ring_buffer_read_start() and ring_buffer_read_page().

In ring_buffer_read_start(), even with resize_disabled, there is still a
possibility of a race with a buffer modification. Hold the trace_buffer
mutex to synchronise with any pending ring buffer order modification.

trace_buffer::subbuf_size is now actually useless, remove it. Also,
create accessors rb_subbuf_capacity() and rb_page_capacity() which
return the actual size available for storing events, while
rb_subbuf_size() returns the actual subbuf page-size.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b6fa258aafe2..ec520c72124e 100644
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
@@ -586,11 +597,42 @@ struct trace_buffer {
 
 	struct ring_buffer_meta		*meta;
 
-	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
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
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -630,7 +672,7 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)(buffer ? buffer->subbuf_size :
+			 (unsigned int)(buffer ? rb_subbuf_capacity(buffer) :
 						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
@@ -1620,7 +1662,7 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
  */
 static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 {
-	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
 	unsigned long ptr;
@@ -2432,8 +2474,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -2556,8 +2598,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		bpage->range = 1;
 		cpu_buffer->subbuf_ids[0] = bpage;
 	} else {
-		int order = cpu_buffer->buffer->subbuf_order;
-		bpage->page = alloc_cpu_data(cpu, order);
+		bpage->page = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->page)
 			goto fail_free_reader;
 	}
@@ -2731,10 +2772,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
-	buffer->subbuf_size = subbuf_size - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
+	buffer->max_data_size = rb_subbuf_capacity(buffer) - (sizeof(u32) * 2);
 
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
@@ -2818,9 +2858,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
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
@@ -3203,7 +3242,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * buffer->subbuf_size.
+ * Minimum size is 2 * rb_subbuf_capacity(buffer).
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -3225,12 +3264,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
@@ -3241,6 +3274,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
@@ -3513,7 +3552,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
 {
 	unsigned long addr = (unsigned long)event;
 
-	addr &= (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1;
+	addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
 
 	return addr - BUF_PAGE_HDR_SIZE;
 }
@@ -3755,8 +3794,8 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *tail_page = info->tail_page;
+	unsigned long bsize = rb_page_capacity(tail_page);
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
 
@@ -4101,8 +4140,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	new_index = rb_event_index(cpu_buffer, event);
 	old_index = new_index + rb_event_ts_length(event);
-	addr = (unsigned long)event;
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr = rb_subbuf_start(cpu_buffer->buffer, (unsigned long)event);
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
@@ -4767,7 +4805,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
+	if (unlikely(write > rb_page_capacity(tail_page))) {
 		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
@@ -5012,7 +5050,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage = cpu_buffer->commit_page;
 	struct buffer_page *start;
 
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr = rb_subbuf_start(cpu_buffer->buffer, addr);
 
 	/* Do the likely case first */
 	if (likely(bpage->page == (void *)addr)) {
@@ -5799,7 +5837,6 @@ static struct buffer_page *
 __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	int max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
@@ -5947,7 +5984,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 #define USECS_WAIT	1000000
         for (nr_loops = 0; nr_loops < USECS_WAIT; nr_loops++) {
 		/* If the write is past the end of page, a writer is still updating it */
-		if (likely(!reader || rb_page_write(reader) <= bsize))
+		if (likely(!reader || rb_page_write(reader) <= rb_page_capacity(reader)))
 			break;
 
 		udelay(1);
@@ -6380,36 +6417,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
 struct ring_buffer_iter *
 ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 {
+	struct ring_buffer_iter *iter __free(kfree) = kzalloc_obj(*iter, flags);
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_iter *iter;
+
+	if (!iter)
+		return NULL;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
-	iter = kzalloc_obj(*iter, flags);
-	if (!iter)
-		return NULL;
-
-	/* Holds the entire event: data and meta data */
-	iter->event_size = buffer->subbuf_size;
-	iter->event = kmalloc(iter->event_size, flags);
-	if (!iter->event) {
-		kfree(iter);
-		return NULL;
-	}
-
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
 
@@ -6463,7 +6508,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
+	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -7094,15 +7139,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
@@ -7228,7 +7273,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    buffer->subbuf_size - size >= sizeof(missed_events)) {
+		    rb_page_capacity(reader) - size >= sizeof(missed_events)) {
 			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7248,8 +7293,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (size < buffer->subbuf_size)
-		memset(&dpage->data[size], 0, buffer->subbuf_size - size);
+	if (size < rb_page_capacity(reader))
+		memset(&dpage->data[size], 0, rb_page_capacity(reader) - size);
 
 	return read;
 }
@@ -7275,7 +7320,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
  */
 int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
 {
-	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	return rb_subbuf_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
 
@@ -7320,7 +7365,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
-	int old_order, old_size;
+	unsigned int old_capacity;
+	int old_order;
 	int nr_pages;
 	int psize;
 	int err;
@@ -7329,9 +7375,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (!buffer || order < 0)
 		return -EINVAL;
 
-	if (buffer->subbuf_order == order)
-		return 0;
-
 	psize = (1 << order) * PAGE_SIZE;
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
@@ -7340,18 +7383,21 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
@@ -7367,8 +7413,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
+		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -7456,7 +7502,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 error:
 	buffer->subbuf_order = old_order;
-	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
 
@@ -7534,7 +7579,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
-	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->subbuf_size = rb_subbuf_size(cpu_buffer->buffer);
 	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
@@ -7896,7 +7941,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 			 * missed events, then record it there.
 			 */
 			commit = rb_page_size(reader);
-			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+			if (rb_subbuf_capacity(buffer) - commit >= sizeof(missed_events)) {
 				memcpy(&dpage->data[commit], &missed_events,
 				       sizeof(missed_events));
 				local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7928,7 +7973,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
-				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
+				rb_subbuf_size(buffer));
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.55.0.691.gc56d675ccc-goog

