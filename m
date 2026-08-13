Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D547D460
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626726; cv=none; b=bvzdGegOaDHOVYG3SOYaQ/wD5gHupOM+KERmMuB2QNNg6/nH5h6G0jW+u7hDna/Y23VRcwt7ra5nW8pw1a3wt3RVk/VLZSQTH3yYhRi5PogPLHeuaVrc4v7Tq6yEkRWqFCuExfoGieavpuGbC/FJaPHulb2hMw6hy+bO70xr8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626726; c=relaxed/simple;
	bh=DsYs08DZ8hUFmwet/nRRalkwUO3cPuWy/3juGUkblz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLYCTGrpjUztPBLtJZPxorwHYklqBbE1n+X0Y8KiKsFaviz8qq7GOs/iLaDsJxi395OQ7pwHyIgWSLLwBWHyTJlRsb+JMNuR07otd54Ns+/+mKJPvWrYc13+AaJpRNvaCMCvpEtfgDY3G5rl90hD8IzL3dPmee/bNK/79UZU1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1sH0juu; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1sH0juu"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49955a9dbcdso5500695e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626723; x=1787231523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twJkNHd+AncbDm6mXlA6aGD5++EB4AgkIIRMWTAGPMM=;
        b=D1sH0juuVHJ69FGOL2TY1ckgLZ0zb5Kg7EWK+6qmwBcQyAfOVMkdD1lOv2QpyyGZCR
         6A751W1KWAfD6WWJ3wFTyDeQ8sJQFMUG1qKL3ilHmc4MQOA1R4OCxQm1Q883sKGKCt0I
         Mn9Z+OyqJc92XasJPd8GtuZw2Sur5iLu2b4tgNvSuW+F3yxDWEgdeY0d0ZK4eN1WILw6
         ji12hQi+5KP4dbrCMj24dDC51r6fcArZEb3UBbWTSbu6d9kx79d4sKiEvT2IuRVxn53w
         dwB6AByL+H/2ahSG14rc/gMtabkGRfuhVT7yWT9UBnF///BUyxpS8Sx9GMoLudcttQi8
         XNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626723; x=1787231523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twJkNHd+AncbDm6mXlA6aGD5++EB4AgkIIRMWTAGPMM=;
        b=Fwy4gwnsfPoEaKUWDxkkWz8DwUimyE2xbnwkhTI6jQ6LPLGwX3kJa8feMSP/Sk77JI
         613yHstzVRA4EXwjtpOa08TAUDIWrGTIsv6F/s3tdII8WIIZvDx0ErZkE01T/hGSYx3o
         CpIzEUt+7CWUJFK+/AudCnjMDA+j+5f3rgDAJ+lJpXwV+0D5Jr8RqiIJPaleJNh4HQ1V
         p+cJRByh84JwJP/UF4sotgK0Ibaxm/PdQVQDUMDcI37EOa3AhneZKwxBAriF0q4sEK43
         78uoj/3h3yE1Y3s+gA9jjJk4nGSTV3ZQu9F5oyesmf6ehFQHenD2MaB2cAZ3ajtr0ee2
         ylfg==
X-Forwarded-Encrypted: i=1; AHgh+RpbCgvIQFIbPQIuE8E4PpSjoAvfsfrhPE3Du3zbeNSiu3PIiLZ9lmS9P0diG3BUI7Hre0H9vj6KEwqVTajRmPrAYCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZA3qXvt9TKHGqOs18MfR/TetisA/iDZnaxTkBKHhe8YhE1SO
	fzrNkrHQZZaCrljlDi1nXT+XZiwgocTX+lS//4ZaKqhf/x/hfzjgGa8aNRuTPJYX40k4LtmBCtY
	Z4n2fiKztacDmKSd4lLC19Q==
X-Received: from wmbgw9.prod.google.com ([2002:a05:600c:8509:b0:490:b1af:78f3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4585:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-499821fe9ecmr54599945e9.16.1786626722527;
 Thu, 13 Aug 2026 06:12:02 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:48 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-7-vdonnefort@google.com>
Subject: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace_pipe_raw readers
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

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0670742b2d60..fafbeb327037 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -219,13 +219,15 @@ size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
 struct buffer_data_read_page;
 struct buffer_data_read_page *
-ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
+ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
+			    struct buffer_data_read_page *prev);
 void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 				struct buffer_data_read_page *page);
 int ring_buffer_read_page(struct trace_buffer *buffer,
 			  struct buffer_data_read_page *data_page,
 			  size_t len, int cpu, int full);
 void *ring_buffer_read_page_data(struct buffer_data_read_page *page);
+unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *page);
 
 struct trace_seq;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a00ab8a9cbd0..83292d90599e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6976,34 +6976,52 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  * ring_buffer_alloc_read_page - allocate a page to read from buffer
  * @buffer: the buffer to allocate for.
  * @cpu: the cpu buffer to allocate.
+ * @prev: The previous page to be repurposed (can be NULL).
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
+ * If @prev is provided, and it has a different order than the current
+ * subbuffer order, its payload will be freed and re-allocated. If it
+ * already matches the order, it is simply returned.
+ *
  * Returns:
  *  The page allocated, or ERR_PTR
  */
-struct buffer_data_read_page *
-ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
+struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
+							  struct buffer_data_read_page *prev)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_read_page *bpage = NULL;
+	struct buffer_data_read_page *bpage;
 	unsigned long flags;
+	unsigned int order;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
-	bpage = kzalloc_obj(*bpage);
-	if (!bpage)
-		return ERR_PTR(-ENOMEM);
+	order = buffer->subbuf_order;
 
-	bpage->order = buffer->subbuf_order;
+	if (prev && prev->order == order) {
+		return prev;
+	} else if (prev) {
+		/* We can reuse prev, but we discard the payload */
+		free_pages((unsigned long)prev->data, prev->order);
+		prev->data = NULL;
+		bpage = prev;
+	} else {
+		bpage = kzalloc_obj(*bpage);
+		if (!bpage)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	bpage->order = order;
 	cpu_buffer = buffer->buffers[cpu];
+
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
@@ -7020,7 +7038,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	} else {
 		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
-			kfree(bpage);
+			if (!prev)
+				kfree(bpage);
+
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -7041,13 +7061,22 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 				struct buffer_data_read_page *data_page)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *dpage = data_page->data;
-	struct page *page = virt_to_page(dpage);
+	struct buffer_data_page *dpage;
 	unsigned long flags;
+	struct page *page;
 
 	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
 		return;
 
+	if (!data_page)
+		return;
+
+	dpage = data_page->data;
+	if (!dpage)
+		goto out;
+
+	page = virt_to_page(dpage);
+
 	cpu_buffer = buffer->buffers[cpu];
 
 	/*
@@ -7312,6 +7341,18 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
 
+/**
+ * ring_buffer_read_page_size - get size of the read page.
+ * @page:  the page to get the size from
+ *
+ * Returns size of the page in bytes.
+ */
+unsigned int ring_buffer_read_page_size(struct buffer_data_read_page *page)
+{
+	return PAGE_SIZE << page->order;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_read_page_size);
+
 /**
  * ring_buffer_subbuf_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 593e3b59e42e..39b7dee21ed3 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -114,7 +114,7 @@ static enum event_status read_page(int cpu)
 	int inc;
 	int i;
 
-	bpage = ring_buffer_alloc_read_page(buffer, cpu);
+	bpage = ring_buffer_alloc_read_page(buffer, cpu, NULL);
 	if (IS_ERR(bpage))
 		return EVENT_DROPPED;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 395238b2b715..f9399f391ac6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
-	void *trace_data;
-	int page_size;
+	void *trace_data, *prev_spare;
+	unsigned int spare_size;
 	ssize_t ret = 0;
 	ssize_t size;
 
@@ -7091,36 +7091,30 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
 		return -EBUSY;
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+again:
+	prev_spare = info->spare;
+	if (prev_spare) {
+		spare_size = ring_buffer_read_page_size(info->spare);
 
-	/* Make sure the spare matches the current sub buffer size */
-	if (info->spare) {
-		if (page_size != info->spare_size) {
-			ring_buffer_free_read_page(iter->array_buffer->buffer,
-						   info->spare_cpu, info->spare);
-			info->spare = NULL;
-		}
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
+	/* Make sure the read page order is aligned with the current buffer subbuf order */
+	info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
+						  prev_spare);
+	if (IS_ERR(info->spare)) {
+		ret = PTR_ERR(info->spare);
+		info->spare = NULL;
+		ring_buffer_free_read_page(iter->array_buffer->buffer, info->spare_cpu, prev_spare);
 		return ret;
+	}
 
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
@@ -7129,6 +7123,10 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
+		/* Did we race with ring_buffer_subbuf_order_set ? */
+		if (spare_size != ring_buffer_subbuf_size_get(iter->array_buffer->buffer))
+			goto again;
+
 		if (trace_empty(iter) && !iter->closed) {
 			if (update_last_data_if_empty(iter->tr))
 				return 0;
@@ -7142,12 +7140,14 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 			goto again;
 		}
+
 		return 0;
 	}
 
 	info->read = 0;
+
  read:
-	size = page_size - info->read;
+	size = spare_size - info->read;
 	if (size > count)
 		size = count;
 	trace_data = ring_buffer_read_page_data(info->spare);
@@ -7268,23 +7268,12 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
 
@@ -7292,9 +7281,10 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 
-	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
+	for (i = 0; i < spd.nr_pages_max && len && entries; i++) {
+		unsigned int page_size;
 		struct page *page;
-		int r;
+		int r = -EINVAL;
 
 		ref = kzalloc_obj(*ref);
 		if (!ref) {
@@ -7304,7 +7294,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->array_buffer->buffer;
-		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
+		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, NULL);
 		if (IS_ERR(ref->page)) {
 			ret = PTR_ERR(ref->page);
 			ref->page = NULL;
@@ -7313,11 +7303,21 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		}
 		ref->cpu = iter->cpu_file;
 
-		r = ring_buffer_read_page(ref->buffer, ref->page,
-					  len, iter->cpu_file, 1);
+		page_size = ring_buffer_read_page_size(ref->page);
+
+		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
+			r = ring_buffer_read_page(ref->buffer, ref->page, len, iter->cpu_file, 1);
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
+			ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->page);
 			kfree(ref);
 			break;
 		}
@@ -7330,6 +7330,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		spd.partial[i].private = (unsigned long)ref;
 		spd.nr_pages++;
 		*ppos += page_size;
+		len -= page_size;
 
 		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bf77331f56a4..981e87b0f5a9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -748,7 +748,6 @@ struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
 	unsigned int		spare_cpu;
-	unsigned int		spare_size;
 	unsigned int		read;
 };
 
-- 
2.55.0.691.gc56d675ccc-goog

