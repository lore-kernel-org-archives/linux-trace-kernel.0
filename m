Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862731E846
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722512; cv=none; b=D2fCnQAFOdifpsZrjnDc8h0F93RePmutF2PZ732qjTTM63QQEKMmhtKO/CIZxZQjAT3FuWUtbJ1Vze6CbGpze+dGMZXeVIzoWY3xGuddukFq1TnzR+SYyNl3pQVOT4Z9Ynd0yK6ip15QpFIDOlNSnQ3NVYhvV8vByT8cb+nNZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722512; c=relaxed/simple;
	bh=vCINmSJb9yZg5xEVHdEsLNU9vN/Gy2+jMIw4/AOwC7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8rQyVxQYzLAb0S2ZEu/hqumpSt8fSS86h9WuoPJGAo7SY48QbtUgYCY1/1jGm2nuoUyIfRjNTA5gyBn9lGGUM3+x86r/sVAh9HWJCBKzGqqA3+CQaRDYzV+pp6dhJ8mu6iM+hmsfA2epBFPRj1w6IAaGFuAPjMjCp+FXC7A78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkrKBKEL; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkrKBKEL"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fecbb553bso1042591f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722507; x=1787327307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nV1pWWkD5bsCCpYwQOvn4bitJK+uOOJiLtYFD+r/bCQ=;
        b=FkrKBKELyfgs4S+8mXzFKDh5QaefPjH64UYRohTDwMrmoX4yPzQIY42f48h4bqDelk
         1T8Rmv3sNQ0C8we7u34PyeHhQqfKG3tNAOYuWE5Cxh9yl0N3cIBFVIbhIV/Ce24Z/1tZ
         EZ7Z4WPsjfSxMCsgAFZV9jsThWoahEskaUilcKLo7M09+Lh4cyhjn/2YPMJbFWa2df7M
         CwkKqqtIVV8Z1UWCk1MOplQ6dmW1xBIMr5oOWtYPlB0tqnNfKs7uHFEaykjsAR59Gaax
         UdLVYT6oSVqUzxkkVAYLJ6PeXNfTA000vvqGi77/hQEbnTQDgBiSJSunjgiX0UyKyvYK
         SWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722507; x=1787327307;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nV1pWWkD5bsCCpYwQOvn4bitJK+uOOJiLtYFD+r/bCQ=;
        b=efmow0eIw9dXOBnnE9J7z4qbxgrxev5Nbr9dznFClBcmXFoiFVB6PwG9J/MRc+Vxdc
         2fsyHjIW/IAEskwcqgnVGC+KZ+457C9jxOv5hvcMGdoYxGiOj/EdpMLGQbp63WM+oIGH
         ZW/MGN6MKXOWULS5AuaYDjEBU24vobWNO8iIvZB9OQKGm05aO647BLliCFoNQ5tMlkTf
         9GihuTGrJM3yeenNSKpxa4FzjiaqLe2ujy2/chTHVNwwGAffY3zoTG4uWop/vXd3+Duo
         QtTrwSXmie9f4nMJjre9hwUh6pSmEC7kYpoI5xFgKZ3RtUTrpbpFAnqWZ2V3Z6e7pbZo
         eObw==
X-Forwarded-Encrypted: i=1; AHgh+RqFqI92hwmpaVtd9CP0lupeTvBelgmTY/9RHC/64Xob3kkep2Qd6gEcyRx9H9/YUQUgioy/1lB8EtuNr39oWKyqvkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsUm8jLLw+sbYwEnO4GbNqn+COjrUK7PW66qAyRFQhVZlw6Mz
	Ch2Dsf0deWd57k/oNZp52QUZUFYn1NirqCGDEBTvBgPgpo718V7mHN/Hl733O5LoaUcb4CsJs7w
	GtwH0im2nTSsfP5kwtrCPgw==
X-Received: from wmti12.prod.google.com ([2002:a05:600c:8b8c:b0:495:5762:2123])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1385:b0:499:5220:db3d with SMTP id 5b1f17b1804b1-499879a50afmr75294865e9.16.1786722507053;
 Fri, 14 Aug 2026 08:48:27 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:22 +0100
In-Reply-To: <20260814154823.755406-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814154823.755406-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814154823.755406-2-vdonnefort@google.com>
Subject: [PATCH v6 1/2] tracing: Fix subbuf resize races with trace_pipe_raw readers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values.

Modify ring_buffer_alloc_read_page() to let it handle the resizing of
a previous buffer_data_read_page if necessary and add a new
ring_buffer_read_page_size() which enable ring-buffer users to not use
the racy ring_buffer_subbuf_size_get(). This makes the spare_size member
of ftrace_buffer_info redundant.

Use those functions in trace_pipe_raw readers and handle in both the
case where the subbuf order is modified in the middle of the read.

Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/ring_buffer.h          |   5 +-
 kernel/trace/ring_buffer.c           | 100 ++++++++++++++++++--------
 kernel/trace/ring_buffer_benchmark.c |   6 +-
 kernel/trace/trace.c                 | 104 +++++++++++++--------------
 kernel/trace/trace.h                 |   9 ++-
 5 files changed, 130 insertions(+), 94 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0670742b2d60..afc7daa6ee7d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -218,14 +218,15 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
 struct buffer_data_read_page;
-struct buffer_data_read_page *
-ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
+int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page **rpage);
 void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 				struct buffer_data_read_page *page);
 int ring_buffer_read_page(struct trace_buffer *buffer,
 			  struct buffer_data_read_page *data_page,
 			  size_t len, int cpu, int full);
 void *ring_buffer_read_page_data(struct buffer_data_read_page *page);
+unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *rpage);
 
 struct trace_seq;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5fc009edc1ec..ec13779922ff 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6990,56 +6990,78 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  * ring_buffer_alloc_read_page - allocate a page to read from buffer
  * @buffer: the buffer to allocate for.
  * @cpu: the cpu buffer to allocate.
+ * @rpage: pointer to pass in an already allocated page (can be NULL)
+ *         and returns the allocated page.
  *
- * This function is used in conjunction with ring_buffer_read_page.
+ * This function is used in conjunction with ring_buffer_read_page().
  * When reading a full page from the ring buffer, these functions
  * can be used to speed up the process. The calling function should
  * allocate a few pages first with this function. Then when it
  * needs to get pages from the ring buffer, it passes the result
- * of this function into ring_buffer_read_page, which will swap
+ * of this function into ring_buffer_read_page(), which will swap
  * the page that was allocated, with the read page of the buffer.
  *
+ * If @rpage is provided, and it has a different order than the current
+ * subbuffer order, its payload will be freed and re-allocated. If it
+ * already matches the order, it is simply returned.
+ *
  * Returns:
- *  The page allocated, or ERR_PTR
+ *  0 on success, < 0 on error
  */
-struct buffer_data_read_page *
-ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
+int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page **rpage)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
+	unsigned int order;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
-	bpage = kzalloc_obj(*bpage);
-	if (!bpage)
-		return ERR_PTR(-ENOMEM);
+	if (!rpage)
+		return -EINVAL;
 
-	bpage->order = buffer->subbuf_order;
+	order = buffer->subbuf_order;
+
+	if (*rpage) {
+		if ((*rpage)->order == order)
+			return 0;
+
+		/* We can reuse rpage, but we discard the payload */
+		free_pages((unsigned long)(*rpage)->data, (*rpage)->order);
+		(*rpage)->data = NULL;
+	} else {
+		*rpage = kzalloc_obj(**rpage);
+		if (!*rpage)
+			return -ENOMEM;
+	}
+
+	(*rpage)->order = order;
 	cpu_buffer = buffer->buffers[cpu];
+
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
 	if (cpu_buffer->free_page.data) {
-		*bpage = cpu_buffer->free_page;
+		**rpage = cpu_buffer->free_page;
 		cpu_buffer->free_page.data = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
-	if (bpage->data) {
-		rb_init_data_page(bpage->data);
+	if ((*rpage)->data) {
+		rb_init_data_page((*rpage)->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, bpage->order);
-		if (!bpage->data) {
-			kfree(bpage);
-			return ERR_PTR(-ENOMEM);
+		(*rpage)->data = alloc_cpu_data(cpu, (*rpage)->order);
+		if (!(*rpage)->data) {
+			kfree(*rpage);
+			*rpage = NULL;
+			return -ENOMEM;
 		}
 	}
 
-	return bpage;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
 
@@ -7047,21 +7069,30 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
  * ring_buffer_free_read_page - free an allocated read page
  * @buffer: the buffer the page was allocate for
  * @cpu: the cpu buffer the page came from
- * @data_page: the page to free
+ * @rpage: the buffer_dat_read_page to free
  *
  * Free a page allocated from ring_buffer_alloc_read_page.
  */
 void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
-				struct buffer_data_read_page *data_page)
+				struct buffer_data_read_page *rpage)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *dpage = data_page->data;
-	struct page *page = virt_to_page(dpage);
+	struct buffer_data_page *dpage;
 	unsigned long flags;
+	struct page *page;
 
 	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
 		return;
 
+	if (!rpage)
+		return;
+
+	dpage = rpage->data;
+	if (!dpage)
+		goto out;
+
+	page = virt_to_page(dpage);
+
 	cpu_buffer = buffer->buffers[cpu];
 
 	/*
@@ -7069,14 +7100,14 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	 * is different from the subbuffer order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
+	if (page_ref_count(page) > 1 || rpage->order != buffer->subbuf_order)
 		goto out;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
 	if (!cpu_buffer->free_page.data) {
-		cpu_buffer->free_page = *data_page;
+		cpu_buffer->free_page = *rpage;
 		dpage = NULL;
 	}
 
@@ -7084,8 +7115,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_restore(flags);
 
  out:
-	free_pages((unsigned long)dpage, data_page->order);
-	kfree(data_page);
+	free_pages((unsigned long)dpage, rpage->order);
+	kfree(rpage);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -7122,6 +7153,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
  * Returns:
  *  >=0 if data has been transferred, returns the offset of consumed data.
  *  <0 if no data has been transferred.
+ *  -EAGAIN if the subbuf size has changed and @data_page must be reallocated.
  */
 int ring_buffer_read_page(struct trace_buffer *buffer,
 			  struct buffer_data_read_page *data_page,
@@ -7159,7 +7191,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
 	if (data_page->order != cpu_buffer->reader_page->order)
-		return -1;
+		return -EAGAIN;
 
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
@@ -7323,6 +7355,18 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
 
+/**
+ * ring_buffer_read_page_size - get size of the read page.
+ * @page:  the page to get the size from
+ *
+ * Returns size of the page in bytes.
+ */
+unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *rpage)
+{
+	return PAGE_SIZE << rpage->order;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_read_page_size);
+
 /**
  * ring_buffer_subbuf_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 593e3b59e42e..c3d34c0e64e2 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -104,7 +104,7 @@ static enum event_status read_event(int cpu)
 
 static enum event_status read_page(int cpu)
 {
-	struct buffer_data_read_page *bpage;
+	struct buffer_data_read_page *bpage = NULL;
 	struct ring_buffer_event *event;
 	struct rb_page *rpage;
 	unsigned long commit;
@@ -114,8 +114,8 @@ static enum event_status read_page(int cpu)
 	int inc;
 	int i;
 
-	bpage = ring_buffer_alloc_read_page(buffer, cpu);
-	if (IS_ERR(bpage))
+	ret = ring_buffer_alloc_read_page(buffer, cpu, &bpage);
+	if (ret < 0)
 		return EVENT_DROPPED;
 
 	page_size = ring_buffer_subbuf_size_get(buffer);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 395238b2b715..355278083b3f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
+	unsigned int spare_size;
 	void *trace_data;
-	int page_size;
 	ssize_t ret = 0;
 	ssize_t size;
 
@@ -7091,36 +7091,21 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
-
-	/* Make sure the spare matches the current sub buffer size */
-	if (info->spare) {
-		if (page_size != info->spare_size) {
-			ring_buffer_free_read_page(iter->array_buffer->buffer,
-						   info->spare_cpu, info->spare);
-			info->spare = NULL;
-		}
-	}
-
-	if (!info->spare) {
-		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
-							  iter->cpu_file);
-		if (IS_ERR(info->spare)) {
-			ret = PTR_ERR(info->spare);
-			info->spare = NULL;
-		} else {
-			info->spare_cpu = iter->cpu_file;
-			info->spare_size = page_size;
-		}
-	}
-	if (!info->spare)
-		return ret;
-
+again:
 	/* Do we have previous read data to read? */
-	if (info->read < page_size)
+	if (info->spare && (info->read < ring_buffer_read_page_size(info->spare)))
 		goto read;
 
- again:
+	/* Make sure the read page order is aligned with the current buffer subbuf order */
+	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
+					  &info->spare);
+	if (ret < 0)
+		return ret;
+
+	spare_size = ring_buffer_read_page_size(info->spare);
+	info->read = spare_size;
+	info->spare_cpu = iter->cpu_file;
+
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
 				    info->spare,
@@ -7128,7 +7113,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 				    iter->cpu_file, 0);
 	trace_access_unlock(iter->cpu_file);
 
-	if (ret < 0) {
+	if (ret == -EAGAIN) {
+		goto again;
+	} else if (ret < 0) {
 		if (trace_empty(iter) && !iter->closed) {
 			if (update_last_data_if_empty(iter->tr))
 				return 0;
@@ -7146,8 +7133,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	}
 
 	info->read = 0;
+
  read:
-	size = page_size - info->read;
+	size = spare_size - info->read;
 	if (size > count)
 		size = count;
 	trace_data = ring_buffer_read_page_data(info->spare);
@@ -7197,17 +7185,17 @@ int tracing_buffers_release(struct inode *inode, struct file *file)
 }
 
 struct buffer_ref {
-	struct trace_buffer	*buffer;
-	void			*page;
-	int			cpu;
-	refcount_t		refcount;
+	struct trace_buffer		*buffer;
+	struct buffer_data_read_page	*rpage;
+	int				cpu;
+	refcount_t			refcount;
 };
 
 static void buffer_ref_release(struct buffer_ref *ref)
 {
 	if (!refcount_dec_and_test(&ref->refcount))
 		return;
-	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
+	ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->rpage);
 	kfree(ref);
 }
 
@@ -7268,23 +7256,12 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	};
 	struct buffer_ref *ref;
 	bool woken = false;
-	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
 
 	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
-	if (*ppos & (page_size - 1))
-		return -EINVAL;
-
-	if (len & (page_size - 1)) {
-		if (len < page_size)
-			return -EINVAL;
-		len &= (~(page_size - 1));
-	}
-
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
 
@@ -7292,7 +7269,8 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 
-	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
+	for (i = 0; i < spd.nr_pages_max && len && entries; i++) {
+		unsigned int page_size;
 		struct page *page;
 		int r;
 
@@ -7304,25 +7282,38 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->array_buffer->buffer;
-		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
-		if (IS_ERR(ref->page)) {
-			ret = PTR_ERR(ref->page);
-			ref->page = NULL;
+
+new_read_page:
+		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
+		if (ret < 0) {
 			kfree(ref);
 			break;
 		}
 		ref->cpu = iter->cpu_file;
 
-		r = ring_buffer_read_page(ref->buffer, ref->page,
-					  len, iter->cpu_file, 1);
+		page_size = ring_buffer_read_page_size(ref->rpage);
+
+		r = -EINVAL;
+		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
+			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
+			if (r == -EAGAIN)
+				goto new_read_page;
+		} else if (!i) {
+			/*
+			 * If the first iteration fails this is an invalid userspace input.
+			 * Otherwise, this is because the subbuf order has been modified. Do not
+			 * report an error and finish the read.
+			 */
+			ret = -EINVAL;
+		}
+
 		if (r < 0) {
-			ring_buffer_free_read_page(ref->buffer, ref->cpu,
-						   ref->page);
+			ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->rpage);
 			kfree(ref);
 			break;
 		}
 
-		page = virt_to_page(ring_buffer_read_page_data(ref->page));
+		page = virt_to_page(ring_buffer_read_page_data(ref->rpage));
 
 		spd.pages[i] = page;
 		spd.partial[i].len = page_size;
@@ -7330,6 +7321,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		spd.partial[i].private = (unsigned long)ref;
 		spd.nr_pages++;
 		*ppos += page_size;
+		len -= page_size;
 
 		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bf77331f56a4..cbf54eded447 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -745,11 +745,10 @@ static inline int tracing_get_cpu(struct inode *inode)
 void tracing_reset_cpu(struct array_buffer *buf, int cpu);
 
 struct ftrace_buffer_info {
-	struct trace_iterator	iter;
-	void			*spare;
-	unsigned int		spare_cpu;
-	unsigned int		spare_size;
-	unsigned int		read;
+	struct trace_iterator		iter;
+	struct buffer_data_read_page	*spare;
+	unsigned int			spare_cpu;
+	unsigned int			read;
 };
 
 /**
-- 
2.55.0.691.gc56d675ccc-goog

