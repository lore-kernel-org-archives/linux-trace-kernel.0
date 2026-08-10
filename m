Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B23A383C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366632; cv=none; b=d7PtR3h7cHAHtVrweWo3/H0l/aam4/igM9QuoOycoCY49rCPsYgNTxtZud1640HBRT5PVdTaZJnAAO1HzY6Ljzx/JYK92xxTg+ZsTPY0txv9XkTkWGtEHrdak0MAfO+9xHOBWzp5f6SPWKajjyWf6LQs93LqxI+6xqcYWG3iupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366632; c=relaxed/simple;
	bh=lYHqzuL9SdjQSjtM02IF41tbpOSw4zzTl6A1whR+/V0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVQUb1bQ+pUR1b6MZI+8Pj4e2btE1wWoJWwrWMQO5YeVVDn9YYlZwjQVaf5Ka78FdoF+E+IphnHQ8zY75zlRDJjPFAKqpS8VncVLQi0CjeW9it1k+Twf6wIMRHvroKify3fUQDjyUMpFdk5WqLun1aCiep80lMfJ5q520tN3Tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qz/Lwxfy; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qz/Lwxfy"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955d314945so10504555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366628; x=1786971428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+smRPGZVTyWJAhe2XupFLkEHtGYEVUwYOA9jU8hECE=;
        b=Qz/Lwxfyf8JGlFCHaM/TghW5WjQzFjSwEnDFAcP57Y7YzmP7fXG+bQX3nQ5878gGE0
         /G0wXML5++AAMXfQ8gmFwI529t+a4oe8DBXrOkQeKyszhiTkk0DXDjeqkUDjgs/5myKP
         yiQAChQNRgGyZHOC9KUeR/vEThqJ8qyukAtFTQ5oAn4+hagU6hCtHzZJ/xyXhIPo7+JM
         O0exKncLhINtpNpD9OPvqDJ+Og8xQKl6BvWyRotD8gMNvlit6B8jd2CLBD9n1MgkkmXL
         9TeFGaRD+232/bJ0tskc6k3T3Y47H6MU1ovAnTa0EvwFQfu8nqRKubXy2Xb29F5TSIMG
         jZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366628; x=1786971428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+smRPGZVTyWJAhe2XupFLkEHtGYEVUwYOA9jU8hECE=;
        b=ngcTJBEBFjIX4AUnWe0guhq3lSuAKOv8atv5GtyNi3G/cy7tq8pBUcVYTmwH68EA+Y
         NKGvBHZCUAHoZt7XHytOC9LA9XTHDqQ0IfaWIirG0lkZNt1lWDBHnVRZ57opxpTrgKAJ
         O7iLF0EYkuhevGezn4k1umQaOxZ48IOwBP6TXoflxcIhlKaUcxvpQcg1LWhS20ytT+WF
         2yExKmo9GsWPshp0OmiEKWjuY4W6hJJAUt2gJ4eWCMwCJj9P5UdOBrLMeK93ccoV5une
         mYr3hcGyhzx9QxsoDXW2i1qvM7bHVTFPl3pSJVBvFN2g/xXbc9WN5UAWYtN0/gDy3DBk
         iZrg==
X-Forwarded-Encrypted: i=1; AHgh+RrNaJuBAMONVDL34axec5MXlwisL/vXMoFxulEtJdaxboH2wKoM/JtKeoAw/AeisN4rUM1kMTaRa57D2qvVj09NkYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SRL7ss9CCjqlV/zYoxVt/XHRzpWHgWhzZyPXgF2t6BRgXh5q
	YweffV0tyKGRgGjp0YFfrHkKhZ8O5By96z0bndisEAHS06n7O+x70AERWc6ZEnURVPnLLZQrNzX
	yAI+osSArp43Oiyky/trYuw==
X-Received: from wmbdx12.prod.google.com ([2002:a05:600c:63cc:b0:495:59ae:3d1f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4585:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4996198e51dmr234243785e9.13.1786366628207;
 Mon, 10 Aug 2026 05:57:08 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:28 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-2-vdonnefort@google.com>
Subject: [PATCH 1/6] ring-buffer: Fix subbuf resize concurrency
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
index 2667992f0aa2..29901668e18c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -391,6 +391,11 @@ static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
 	return rb_data_page_size(bpage->page);
 }
 
+static __always_inline unsigned int rb_page_capacity(struct buffer_page *bpage)
+{
+	return (PAGE_SIZE << bpage->order) - BUF_PAGE_HDR_SIZE;
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	/* Range pages are not to be freed */
@@ -586,11 +591,20 @@ struct trace_buffer {
 
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
+static __always_inline unsigned int rb_subbuf_capacity(struct trace_buffer *buffer)
+{
+	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -630,7 +644,7 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)(buffer ? buffer->subbuf_size :
+			 (unsigned int)(buffer ? rb_subbuf_capacity(buffer) :
 						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
@@ -1620,7 +1634,7 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
  */
 static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 {
-	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
 	unsigned long ptr;
@@ -2432,8 +2446,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -2556,8 +2570,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		bpage->range = 1;
 		cpu_buffer->subbuf_ids[0] = bpage;
 	} else {
-		int order = cpu_buffer->buffer->subbuf_order;
-		bpage->page = alloc_cpu_data(cpu, order);
+		bpage->page = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->page)
 			goto fail_free_reader;
 	}
@@ -2731,10 +2744,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
-	buffer->subbuf_size = subbuf_size - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
+	buffer->max_data_size = rb_subbuf_capacity(buffer) - (sizeof(u32) * 2);
 
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
@@ -2818,9 +2830,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
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
@@ -3203,7 +3214,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * buffer->subbuf_size.
+ * Minimum size is 2 * rb_subbuf_capacity(buffer).
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -3225,12 +3236,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
@@ -3241,6 +3246,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
@@ -3513,7 +3524,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
 {
 	unsigned long addr = (unsigned long)event;
 
-	addr &= (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1;
+	addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
 
 	return addr - BUF_PAGE_HDR_SIZE;
 }
@@ -3755,8 +3766,8 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *tail_page = info->tail_page;
+	unsigned long bsize = rb_page_capacity(tail_page);
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
 
@@ -4102,7 +4113,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	new_index = rb_event_index(cpu_buffer, event);
 	old_index = new_index + rb_event_ts_length(event);
 	addr = (unsigned long)event;
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
@@ -4767,7 +4778,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
+	if (unlikely(write > rb_page_capacity(tail_page))) {
 		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
@@ -5012,7 +5023,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage = cpu_buffer->commit_page;
 	struct buffer_page *start;
 
-	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
+	addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
 
 	/* Do the likely case first */
 	if (likely(bpage->page == (void *)addr)) {
@@ -5799,7 +5810,6 @@ static struct buffer_page *
 __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	int max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
@@ -5947,7 +5957,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 #define USECS_WAIT	1000000
         for (nr_loops = 0; nr_loops < USECS_WAIT; nr_loops++) {
 		/* If the write is past the end of page, a writer is still updating it */
-		if (likely(!reader || rb_page_write(reader) <= bsize))
+		if (likely(!reader || rb_page_write(reader) <= rb_page_capacity(reader)))
 			break;
 
 		udelay(1);
@@ -6380,36 +6390,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
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
 
@@ -6463,7 +6481,7 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
+	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -7094,15 +7112,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
@@ -7228,7 +7246,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    buffer->subbuf_size - size >= sizeof(missed_events)) {
+		    rb_page_capacity(reader) - size >= sizeof(missed_events)) {
 			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7248,8 +7266,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (size < buffer->subbuf_size)
-		memset(&dpage->data[size], 0, buffer->subbuf_size - size);
+	if (size < rb_page_capacity(reader))
+		memset(&dpage->data[size], 0, rb_page_capacity(reader) - size);
 
 	return read;
 }
@@ -7275,7 +7293,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
  */
 int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
 {
-	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	return rb_subbuf_size(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
 
@@ -7320,7 +7338,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
-	int old_order, old_size;
+	unsigned int old_capacity;
+	int old_order;
 	int nr_pages;
 	int psize;
 	int err;
@@ -7329,9 +7348,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (!buffer || order < 0)
 		return -EINVAL;
 
-	if (buffer->subbuf_order == order)
-		return 0;
-
 	psize = (1 << order) * PAGE_SIZE;
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
@@ -7340,18 +7356,21 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
+	old_capacity = (PAGE_SIZE << old_order) - BUF_PAGE_HDR_SIZE;
+
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
 	buffer->subbuf_order = order;
-	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -7367,8 +7386,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
+		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -7454,7 +7473,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 error:
 	buffer->subbuf_order = old_order;
-	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
 
@@ -7532,7 +7550,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
-	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	meta->subbuf_size = rb_subbuf_size(cpu_buffer->buffer);
 	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
@@ -7894,7 +7912,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 			 * missed events, then record it there.
 			 */
 			commit = rb_page_size(reader);
-			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+			if (rb_subbuf_capacity(buffer) - commit >= sizeof(missed_events)) {
 				memcpy(&dpage->data[commit], &missed_events,
 				       sizeof(missed_events));
 				local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7926,7 +7944,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
-				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
+				rb_subbuf_size(buffer));
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.55.0.654.g21b8a5bc05-goog

