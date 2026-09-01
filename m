Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1B442B1C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278097; cv=none; b=pyDzzkIWMjDKq+9jeEe5gUjUspmRH5M5uVhOUPwe7QWAu+Az+0yYTFqQx6FJfy3cZbJi6U8xddci0sCuvAkdr2DS9KJMjriq2iU2+mtADSbOvVfIBogMb3ShOX/RShAoqF3ycuD15eiBs3dZ1fAFsmzZE+NdsGNevdu7yU+jJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278097; c=relaxed/simple;
	bh=FNxs5pCwRARHart0e2CaTOpzOrGphTVRLNOLLCperL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pinbhdapkVJ+/h6qqFR/OLNnt83Kq6zC8m+bQ9Ga3vp5EDC3TB7hL32tsM7d48WOdy8qqMuyluI/foaMKUAFFNKYHok13zvLamthaRbbjnuoftSCyWOw2BjHkPz1gJe18bDj2PgxAwfvwp3DJTS2IzKLvFK0gGkG6ENysAgljCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZS9GiWw; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZS9GiWw"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so18926865e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278093; x=1788882893; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTgJgjeHYOkviSh0AwJCPWEp/KgVduk8utkYvFtIsK4=;
        b=wZS9GiWwskBnli3wbPtJUZO3QZHWWPzyChKZNx3vhZUvDSgND9zgvpCCs3MFolCYtN
         4LDrRostPBIqgTUBa+1ejJlRoMyBSp2T1q9jUQEFcwBcN1D0iqcY1qIowS+tLKw8vDEk
         O28CZqc+RBd73F3396EBHkHvLtopYFBcRMOyGQKLA10l7w8GiXPIvzsj0X6dcfc2thLJ
         vBK12Pnyv9gXHyZbduNdsekX5xgvhxsI/BHzlbyqbJIsAbHc2ocEZUbGhdIuS4hq9HAp
         xwbFV9OyNaprbthzu9L/WXiSjRWcz7x9/ljLsrDVFR1s0CY+snVuOw8H/wo4YQbEylYa
         4aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278093; x=1788882893;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTgJgjeHYOkviSh0AwJCPWEp/KgVduk8utkYvFtIsK4=;
        b=UBAVZJHBHuxm55kSUne2qpVQaBoDr/cjdF+geuklKdFT+lcRmy+VQokmhErFZz7r0+
         Vib5AxPBqZ8mSLUW20jgBqz6gPGFy7PzOl3GjlWqJHNre5jFAz3QNq3i6WfG1PqegttN
         2oU77O3yIz/MdvEZ6KbB3i4vj5lEV54h3LEUes92n3P+mxTmlbESokLlAEHFcE95mRn3
         4mx0X+dKD0/6RXUMfnjtfYzR9m8hxZk/YOvOAzpa9Jy37K5ILDe3tmd5CwnivCwgz4Az
         HHiDjFTX9M1WyWTgAjePSYALcVCfCKsWqpiaQi+zJVcyVRCiwwuQ0W9tzuq82R7t9IAl
         hSbw==
X-Forwarded-Encrypted: i=1; AHgh+Rqbp5akCbGMW/Q+bFMR3TLkQ3pex7zr9hn3XEM3XNtwM1BI8qzfIasnAadKrn5ubFmZyixxjqZ6iIHJDswpqT1a13U=@vger.kernel.org
X-Gm-Message-State: AFuF++mmKvSOs7cj7s0YQRzZ54GeNriUcqAsXScx3E0+9ecLz7+jVkwb
	U89FBJE1Mug556EMjVPKWkt99s8L57tAAzYoFRpF3ESmMK6GRdcljjHH16RhgQToJAf/W5/hdHi
	EzL7PzItBhRlF1VNPK77vEQ==
X-Received: from wmpb24.prod.google.com ([2002:a05:600c:4a98:b0:493:f83f:e304])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c11c:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cdc422c5bmr173400175e9.2.1788278093177;
 Tue, 01 Sep 2026 08:54:53 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:54:43 +0100
In-Reply-To: <20260901155445.1475405-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901155445.1475405-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901155445.1475405-3-vdonnefort@google.com>
Subject: [PATCH v9 2/4] tracing: Fix subbuf resize races with trace_pipe_raw readers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values.

Modify ring_buffer_alloc_read_page() to handle the resizing of an
existing buffer_data_read_page if necessary and add a new
ring_buffer_read_page_size(). This new function enables ring-buffer
buffer_data_read_page users to not call the racy
ring_buffer_subbuf_size_get(). This makes the spare_size member of
ftrace_buffer_info redundant.

Finally, handle buffer_data_read_page/reader_page order discrepancy in
ring_buffer_read_page(). On a mismatch simply copy manually the data to
the buffer_data_read_page.

Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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
index 84fd4cdd486f..28dd76edfecf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -330,6 +330,11 @@ struct buffer_data_read_page {
 	struct buffer_data_page	*data;	/* actual data, stored in this page */
 };
 
+static __always_inline unsigned int rb_read_page_capacity(struct buffer_data_read_page *rpage)
+{
+	return (PAGE_SIZE << rpage->order) - BUF_PAGE_HDR_SIZE;
+}
+
 /*
  * Note, the buffer_page list must be first. The buffer pages
  * are allocated in cache lines, which means that each buffer
@@ -6993,56 +6998,78 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
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
 
@@ -7050,21 +7077,30 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
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
@@ -7072,14 +7108,14 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
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
 
@@ -7087,8 +7123,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	local_irq_restore(flags);
 
  out:
-	free_pages((unsigned long)dpage, data_page->order);
-	kfree(data_page);
+	free_pages((unsigned long)dpage, rpage->order);
+	kfree(rpage);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -7159,10 +7195,9 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!dpage)
 		return -1;
 
-	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
+	len = min_t(size_t, len, rb_read_page_capacity(data_page));
 
-	if (data_page->order != cpu_buffer->reader_page->order)
-		return -1;
+	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
@@ -7177,16 +7212,18 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
 
-	/*
-	 * If this page has been partially read or
-	 * if len is not big enough to read the rest of the page or
-	 * a writer is still on the page, then
-	 * we must copy the data from the page to the buffer.
-	 * Otherwise, we can simply swap the page with the one passed in.
-	 */
+	 /*
+	  * It is not possible to swap the reader page if:
+	  *   - It has been partially read
+	  *   - len is not big enough to read it entirely
+	  *   - A writer is still on it
+	  *   - The ring buffer is static
+	  *   - The order doesn't match
+	  */
 	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
-	    rb_is_static(cpu_buffer)) {
+	    rb_is_static(cpu_buffer) ||
+	    data_page->order != reader->order) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -7280,7 +7317,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    rb_page_capacity(reader) - size >= sizeof(missed_events)) {
+		    rb_read_page_capacity(data_page) - size >= sizeof(missed_events)) {
 			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
@@ -7300,8 +7337,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (size < rb_page_capacity(reader))
-		memset(&dpage->data[size], 0, rb_page_capacity(reader) - size);
+	if (size < rb_read_page_capacity(data_page))
+		memset(&dpage->data[size], 0, rb_read_page_capacity(data_page) - size);
 
 	return read;
 }
@@ -7319,6 +7356,18 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
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
index a946e0183fd1..7ba3856daf44 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7082,8 +7082,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
+	unsigned int spare_size;
 	void *trace_data;
-	int page_size;
 	ssize_t ret = 0;
 	ssize_t size;
 
@@ -7093,36 +7093,24 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
-
-	/* Make sure the spare matches the current sub buffer size */
+again:
 	if (info->spare) {
-		if (page_size != info->spare_size) {
-			ring_buffer_free_read_page(iter->array_buffer->buffer,
-						   info->spare_cpu, info->spare);
-			info->spare = NULL;
-		}
+		spare_size = ring_buffer_read_page_size(info->spare);
+		/* Do we have previous read data to read? */
+		if (info->read < spare_size)
+			goto read;
 	}
 
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
+	/* Make sure the read page order is aligned with the current subbuf order */
+	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
+					  &info->spare);
+	if (ret)
 		return ret;
 
-	/* Do we have previous read data to read? */
-	if (info->read < page_size)
-		goto read;
+	spare_size = ring_buffer_read_page_size(info->spare);
+	info->read = spare_size;
+	info->spare_cpu = iter->cpu_file;
 
- again:
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
 				    info->spare,
@@ -7148,8 +7136,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	}
 
 	info->read = 0;
+
  read:
-	size = page_size - info->read;
+	size = spare_size - info->read;
 	if (size > count)
 		size = count;
 	trace_data = ring_buffer_read_page_data(info->spare);
@@ -7199,17 +7188,17 @@ int tracing_buffers_release(struct inode *inode, struct file *file)
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
 
@@ -7270,23 +7259,12 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
 
@@ -7294,7 +7272,8 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 
-	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
+	for (i = 0; i < spd.nr_pages_max && len && entries; i++) {
+		unsigned int page_size;
 		struct page *page;
 		int r;
 
@@ -7306,25 +7285,36 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->array_buffer->buffer;
-		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
-		if (IS_ERR(ref->page)) {
-			ret = PTR_ERR(ref->page);
-			ref->page = NULL;
+
+		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
+		if (ret) {
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
+		} else if (!i) {
+			/*
+			 * If the first iteration fails this is an invalid
+			 * userspace input. Otherwise, this is because the
+			 * subbuf order has been modified. Do not report an
+			 * error and finish the read.
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
@@ -7332,6 +7322,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		spd.partial[i].private = (unsigned long)ref;
 		spd.nr_pages++;
 		*ppos += page_size;
+		len -= page_size;
 
 		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..203d098ee14e 100644
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
2.55.0.897.gb25b4bd76c-goog

