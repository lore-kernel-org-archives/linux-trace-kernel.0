Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15560A3801
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E15560A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pQzPDrHQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso29570315e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492899; x=1795097699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8vj23xEBxSbVhTyLX5FnQOoGovWlUWFOQfdj55p1bs=;
        b=pQzPDrHQ5H+j1insKz0se/Q777XnL1tLnKyEHBNzxj9JztwANl3bqlQNrL9QDHVojI
         CV6xM3Nk+zZjsKvbjLnOFzLTOvLx1C2MqybZbsYuawqnxulwLhTEnFduyZJQrI6zOToU
         yc6Ndl+2J2Oon1OL/xf5cfTrmcFv/CBbd3TOhWXpk8jIm1Z3kVIXVzU0x0VHoDd23Cbp
         lMhmh5+Ok3zCkoORj3pr0cMBi9KwCRFwYAxWhoQZWnyA4KSmW3/txfs0zGQxvXcK81fS
         IuYxMKUAvNk8pzT/sUA8o1S/gydyElUEkZ+KXVGYxaaAwFcUrSOC6aZJbHSsTJVvoeM/
         Tkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492899; x=1795097699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8vj23xEBxSbVhTyLX5FnQOoGovWlUWFOQfdj55p1bs=;
        b=ns97hVrqLb30d5RK+K7Q7pA0Y2qJN0pBfPQz5xoaatCK4obwET50gxgSrL8fxReqVP
         9FGMaHlSGLX4cK9LIRIq7ICzr/5U9zy5r7W2aCyPuxiHyuHwRsz9mmj9OpfsSCNbnzpy
         m6nQJejKjm1PyGZ5Qsiv+1aA65XuvKIIPRY1hHEn+qZBJVJ7IDDD/tRVGj4vkFzyO2I9
         xsFUTzvKy5OKbhTnemVYJuzxHbbztYZZFCrf2ndY4ML1qOn1u8WfTD+LQ5MHGz3a4Zm3
         MFccs81/5goyIioBzkg254MbKeDgpvccasNA1PN2Rb/LDA50Bu56jxl8OM7dhClgjSls
         j2yQ==
X-Forwarded-Encrypted: i=1; AL+hErE9eG919ywAFmfZInTE9qNY/DLL9irRzieI/jGOUrVxbJNr+1is2bj2yIlsz+2aGARwL1sihKSVe+V5sphmpQ9LOq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P/OclhhFxlY2tVGoltsxWwZk5LF5Ax0V+329IXdmc2KqIbBlq
	4D+CR/BsRtRm0Vw/zPiSTwGXL4H9DTeXWCi0gJWUA4C/bmw3reHfv09w8o/15cSFg6M2q2X479j
	Kdu593AS1g+n1JPfjnz+K6Q==
X-Received: from wmoj19.prod.google.com ([2002:a05:600c:4853:b0:4b2:3c81:ca])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1911:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4ba091a2898mr113801235e9.0.1794492898674;
 Thu, 12 Nov 2026 06:14:58 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:40 +0000
In-Reply-To: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112141440.3050124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-10-vdonnefort@google.com>
Subject: [PATCH v1 9/9] ring-buffer: Annotate subbuf_order with __guarded_by(&mutex)
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_buffer::subbuf_order caused a few locking issues recently. To
mitigate any coming problems, annotate it with __guarded_by() to
enforce its proper locking.

The API functions are still allowed to access it locklessly: they must
externally harden the races. For each, add a note about possible
concurrency to the kerneldoc. To that end, add a set of accessors:

   rb_subbuf_order_unsafe(), rb_subbuf_size_unsafe(),
   rb_subbuf_capacity_unsafe().

Not only do they use the unsafe annotation to silence context analysis,
but they also use a READ_ONCE() which was missing in some places.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 115 ++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 99ade8b41b53..6ced0ba4fcad 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -603,10 +603,30 @@ struct trace_buffer {
 
 	struct ring_buffer_meta		*meta;
 
-	unsigned int			subbuf_order;
+	unsigned int			subbuf_order __guarded_by(&mutex);
 };
 
+static unsigned int rb_subbuf_order_unsafe(struct trace_buffer *buffer)
+{
+	/*
+	 * Unsafe read of subbuf_order, restricted to API paths that either
+	 * synchronize it externally or tolerate a race.
+	 */
+	return context_unsafe(READ_ONCE(buffer->subbuf_order));
+}
+
+static unsigned int rb_subbuf_size_unsafe(struct trace_buffer *buffer)
+{
+	return PAGE_SIZE << rb_subbuf_order_unsafe(buffer);
+}
+
+static unsigned int rb_subbuf_capacity_unsafe(struct trace_buffer *buffer)
+{
+	return rb_subbuf_size_unsafe(buffer) - BUF_PAGE_HDR_SIZE;
+}
+
 static unsigned int rb_subbuf_size(struct trace_buffer *buffer)
+	__must_hold(&buffer->mutex)
 {
 	return PAGE_SIZE << buffer->subbuf_order;
 }
@@ -621,11 +641,13 @@ static unsigned int rb_subbuf_size(struct trace_buffer *buffer)
  * Return: The maximum size available for events in a trace buffer subbuffer.
  */
 static unsigned int rb_subbuf_capacity(struct trace_buffer *buffer)
+	__must_hold(&buffer->mutex)
 {
 	return rb_subbuf_size(buffer) - BUF_PAGE_HDR_SIZE;
 }
 
 static unsigned long rb_calculate_nr_pages(struct trace_buffer *buffer, unsigned long size)
+	__must_hold(&buffer->mutex)
 {
 	return max(DIV_ROUND_UP(size, rb_subbuf_capacity(buffer)), RING_BUFFER_MIN_NR_PAGES);
 }
@@ -696,8 +718,9 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)(buffer ? rb_subbuf_capacity(buffer) :
-						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
+			 (unsigned int)(buffer ?
+					rb_subbuf_capacity_unsafe(buffer) :
+					PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
@@ -1685,15 +1708,17 @@ rb_range_align_subbuf(unsigned long addr, unsigned int subbuf_size, unsigned lon
  */
 static void *rb_range_meta(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
 {
-	unsigned int subbuf_size = rb_subbuf_size(buffer);
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
 	unsigned long ptr, nr_subbufs;
+	unsigned int subbuf_size;
 
 	bmeta = buffer->meta;
 	if (!bmeta)
 		return NULL;
 
+	/* persistent buffers are static and cannot be resized */
+	subbuf_size = context_unsafe(rb_subbuf_size(buffer));
 	ptr = (unsigned long)bmeta + bmeta->buffers_offset;
 	meta = (struct ring_buffer_cpu_meta *)ptr;
 
@@ -2427,10 +2452,11 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
 	return page_id >= desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
 }
 
-static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
+static int __rb_allocate_pages(struct trace_buffer *buffer,
+			       struct ring_buffer_per_cpu *cpu_buffer,
 			       unsigned long nr_pages, struct list_head *pages)
+	__must_hold(&buffer->mutex)
 {
-	struct trace_buffer *buffer = cpu_buffer->buffer;
 	unsigned int subbuf_order = buffer->subbuf_order;
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
@@ -2531,14 +2557,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	return -ENOMEM;
 }
 
-static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
+static int rb_allocate_pages(struct trace_buffer *buffer,
+			     struct ring_buffer_per_cpu *cpu_buffer,
 			     unsigned long nr_pages)
+	__must_hold(&buffer->mutex)
 {
 	LIST_HEAD(pages);
 
 	WARN_ON(!nr_pages);
 
-	if (__rb_allocate_pages(cpu_buffer, nr_pages, &pages))
+	if (__rb_allocate_pages(buffer, cpu_buffer, nr_pages, &pages))
 		return -ENOMEM;
 
 	/*
@@ -2558,6 +2586,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
+	__must_hold(&buffer->mutex)
 {
 	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
 		alloc_cpu_buffer(cpu);
@@ -2636,7 +2665,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
 
-	ret = rb_allocate_pages(cpu_buffer, nr_pages);
+	ret = rb_allocate_pages(buffer, cpu_buffer, nr_pages);
 	if (ret < 0)
 		goto fail_free_reader;
 
@@ -2783,6 +2812,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 unsigned long scratch_size,
 					 struct lock_class_key *key,
 					 struct ring_buffer_remote *remote)
+	__context_unsafe(init)
 {
 	struct trace_buffer *buffer __free(kfree) = NULL;
 	unsigned int subbuf_size;
@@ -2800,6 +2830,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
 		return NULL;
 
+	mutex_init(&buffer->mutex);
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
 
@@ -2807,7 +2838,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
 
-	mutex_init(&buffer->mutex);
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
@@ -3350,7 +3380,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			 * allocated without receiving ENOMEM
 			 */
 			INIT_LIST_HEAD(&cpu_buffer->new_pages);
-			if (__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
+			if (__rb_allocate_pages(buffer, cpu_buffer,
+						cpu_buffer->nr_pages_to_update,
 						&cpu_buffer->new_pages)) {
 				/* not enough memory for new pages */
 				err = -ENOMEM;
@@ -3410,8 +3441,9 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
 		if (cpu_buffer->nr_pages_to_update > 0 &&
-			__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
-					    &cpu_buffer->new_pages)) {
+		    __rb_allocate_pages(buffer, cpu_buffer,
+					cpu_buffer->nr_pages_to_update,
+					&cpu_buffer->new_pages)) {
 			err = -ENOMEM;
 			goto out_err;
 		}
@@ -6536,8 +6568,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
  * @buffer: The ring buffer.
  * @cpu: The CPU to get ring buffer capacity from.
  *
- * Capacity is the total memory available for recording event data in the
- * ring buffer. It excludes subbuffer headers.
+ * Capacity is the total memory available for recording event data in the ring
+ * buffer. It excludes subbuffer headers. No synchronization with either
+ * ring_buffer_subbuf_order_set() or ring_buffer_resize() is provided.
  *
  * Returns the capacity in bytes, or 0 if the CPU is not set in the buffer mask.
  */
@@ -6546,7 +6579,7 @@ unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return rb_subbuf_capacity(buffer) * buffer->buffers[cpu]->nr_pages;
+	return rb_subbuf_capacity_unsafe(buffer) * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_capacity);
 
@@ -6554,6 +6587,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_capacity);
  * ring_buffer_max_event_size - return the max data size of an event
  * @buffer: The ring buffer.
  *
+ * No synchronization with ring_buffer_subbuf_order_set() is provided.
+ *
  * Returns the maximum size an event can be.
  */
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
@@ -6562,11 +6597,11 @@ unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 	unsigned long max_data_size;
 
 	/*
-	 * surely rb_subbuf_capacity() is bigger than
+	 * surely rb_subbuf_capacity_unsafe() is bigger than
 	 * RINGBUF_TYPE_DATA_TYPE_LEN_MAX (see ring_buffer_event_length).
 	 */
-	max_data_size = rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE -
-			sizeof(event->array[0]);
+	max_data_size = rb_subbuf_capacity_unsafe(buffer) -
+			RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
 
 	/* If abs timestamp is requested, events have a timestamp too */
 	if (ring_buffer_time_stamp_abs(buffer))
@@ -6941,7 +6976,8 @@ int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
  * This function is useful for tracers that want to take a "snapshot"
  * of a CPU buffer and has another back up buffer lying around.
  * it is expected that the tracer handles the cpu buffer not being
- * used at the moment.
+ * used at the moment. No synchronization with
+ * ring_buffer_subbuf_order_set() is provided.
  */
 int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 			 struct trace_buffer *buffer_b, int cpu)
@@ -6965,7 +7001,8 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		return -EINVAL;
 
-	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
+	/* Up to the callers to synchronize with a subbuf order change */
+	if (rb_subbuf_order_unsafe(buffer_a) != rb_subbuf_order_unsafe(buffer_b))
 		return -EINVAL;
 
 	if (atomic_read(&buffer_a->record_disabled))
@@ -7037,7 +7074,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  *
  * If @rpage is provided, and it has a different order than the current
  * subbuffer order, its payload will be freed and re-allocated. If it
- * already matches the order, it is simply returned.
+ * already matches the order, it is simply returned. No synchronization
+ * with ring_buffer_subbuf_order_set() is provided.
  *
  * Returns:
  *  0 on success, < 0 on error
@@ -7055,7 +7093,7 @@ int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
 	if (!rpage)
 		return -EINVAL;
 
-	order = READ_ONCE(buffer->subbuf_order);
+	order = rb_subbuf_order_unsafe(buffer);
 
 	if (*rpage) {
 		if ((*rpage)->order == order)
@@ -7134,7 +7172,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	 * is different from the subbuffer order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || rpage->order != READ_ONCE(buffer->subbuf_order))
+	if (page_ref_count(page) > 1 ||
+	    rpage->order != rb_subbuf_order_unsafe(buffer))
 		goto out;
 
 	local_irq_save(flags);
@@ -7400,11 +7439,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_size);
  * ring_buffer_subbuf_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
  *
+ * No synchronization with ring_buffer_subbuf_order_set() is provided.
+ *
  * Returns size of the sub buffer, in bytes.
  */
 int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
 {
-	return rb_subbuf_size(buffer);
+	return rb_subbuf_size_unsafe(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
 
@@ -7412,9 +7453,10 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
  * ring_buffer_subbuf_order_get - get order of system sub pages in one buffer page.
  * @buffer: The ring_buffer to get the system sub page order from
  *
- * By default, one ring buffer sub page equals to one system page. This parameter
- * is configurable, per ring buffer. The size of the ring buffer sub page can be
- * extended, but must be an order of system page size.
+ * By default, one ring buffer sub page equals to one system page. This
+ * parameter is configurable, per ring buffer. The size of the ring buffer sub
+ * page can be extended, but must be an order of system page size. No
+ * synchronization with ring_buffer_subbuf_order_set() is provided.
  *
  * Returns the order of buffer sub page size, in system pages:
  * 0 means the sub buffer size is 1 system page and so forth.
@@ -7425,7 +7467,7 @@ int ring_buffer_subbuf_order_get(struct trace_buffer *buffer)
 	if (!buffer)
 		return -EINVAL;
 
-	return buffer->subbuf_order;
+	return rb_subbuf_order_unsafe(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
 
@@ -7502,7 +7544,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		/* Allocate the new size buffer */
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
-		if (__rb_allocate_pages(cpu_buffer, nr_pages,
+		if (__rb_allocate_pages(buffer, cpu_buffer, nr_pages,
 					&cpu_buffer->new_pages)) {
 			/* not enough memory for new pages */
 			err = -ENOMEM;
@@ -7617,8 +7659,10 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->meta_page = NULL;
 }
 
-static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+static void rb_setup_ids_meta_page(struct trace_buffer *buffer,
+				   struct ring_buffer_per_cpu *cpu_buffer,
 				   struct buffer_page **subbuf_ids)
+	__must_hold(&buffer->mutex)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned long nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7651,7 +7695,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	meta->meta_struct_len = sizeof(*meta);
 	meta->nr_subbufs = nr_subbufs;
-	meta->subbuf_size = rb_subbuf_size(cpu_buffer->buffer);
+	meta->subbuf_size = rb_subbuf_size(buffer);
 	meta->meta_page_size = meta->subbuf_size;
 
 	rb_update_meta_page(cpu_buffer);
@@ -7715,7 +7759,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	    !(vma->vm_flags & VM_MAYSHARE))
 		return -EPERM;
 
-	subbuf_order = cpu_buffer->buffer->subbuf_order;
+	/* We either have the buffer mutex or user_mapped is set */
+	subbuf_order = context_unsafe(cpu_buffer->buffer->subbuf_order);
 	subbuf_pages = 1 << subbuf_order;
 
 	if (subbuf_order && pgoff % subbuf_pages)
@@ -7848,7 +7893,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	 * assigned.
 	 */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+	rb_setup_ids_meta_page(buffer, cpu_buffer, subbuf_ids);
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
@@ -8018,7 +8063,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
-				rb_subbuf_size(buffer));
+				PAGE_SIZE << cpu_buffer->reader_page->order);
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.56.0.567.gdb80ae8cd5-goog

