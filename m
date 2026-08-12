Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190647126E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548821; cv=none; b=lkvveDJoV3dFFA+OMNiFuQ+u1LfcT6VUAk4G71kUSa4eOg6Y0V5rf0muv8InizW/Fhb37cq9BvjZ5aneYBc4uQ9MROEQ454jwidhAOptRmEMCUWKUUdvWpRojIQLm8IaSvqhnjbil4GemkZ/VgYC1O5ss1CnB9LezM5SA6Hujhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548821; c=relaxed/simple;
	bh=6FtLsQYKVQkq8eKe4kxIxaeChk70Ii2CX2Fxd1Baa0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HcQcItpoBm70cxubMSnmlqMC2u3BkwoWI/LrdH5WRQB2SQKKNGnu7S6LsiqAM6DsDyvvfuw4N/tWvZgY/iofnt+jdOdNxRQ0HBEkvPciI4SHvZ2mOhR+LR8QVpFdnT6HH5QFGx1vYrAe1nvLEviJ+eou5UXsEgDMqhIgn6WwZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/yaHrHx; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/yaHrHx"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f810c8aebso650299f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548813; x=1787153613; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKE00euLggKlVbFxAuzkgaPfYF8e4gj5N76eLvD7Pfg=;
        b=m/yaHrHxqp0qSSF9G+YNMJu69Jg5+WYs9mFVcFabMkwkERlzDP4BpRYh/INXJmmZzh
         lnS4cTl0LCwBg3s9qg/aSHyFi59mNFrDO/3LzKW1DEj3Bx/+cvhvfk61tMApY4NYrtqY
         UQcf2iYomqwlFJI1oapPo9gGuXiHrBVl66rgeuL18tvqIcT5ZZchnnP78/MWmunteh2j
         6sdJjCikvy8b+p4du2nMNPVPZj5sEXD2GA6mZ+RdxQEs7vv+MfKbYuJIW1pcrEGkMfNp
         LBefrt7Cdx+ejXv4DaNOdAzWlYQNbPhcRuV6s3cwfBdgrpCc8ninZz4m+NMUXYSTjE8W
         sNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548813; x=1787153613;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKE00euLggKlVbFxAuzkgaPfYF8e4gj5N76eLvD7Pfg=;
        b=AZJWrFhYa+LHpjl4146MsxMHv6lSjTpS9bIlG7z8R5VrOeqoFOt9zg9f9YRr3Rj4uO
         KAy+axUe8J/jd1w7Iguopm6aT5dur5kAKuPmtckc1cJ/ZUs4QRacessg8TaUd6lhve3J
         8tw9Yh37j7N/T0oGF536C7soQEpPbEW+4DHxfzKNu4ANGU+irYQjsGbTGOD6T4GNyHOc
         Zg6WDsvjtkd7S8PyuVKwlLl+WtLktFwZipHfnH2YxAS3wf58cfzWUbkESLkBDPIJJe4/
         uP6AxqMmFmc+7HtuPfltCvQ0g2Y8tg/QH+1OntdXnPwPEpakr0s5ZSLHzKpWy8tSfIg+
         7q2w==
X-Forwarded-Encrypted: i=1; AHgh+Rp/knlYhTPV+jKR/05viuKMby2sj92mV7fc7+dT83xWc4YkBvo26NgxhppIj6Lr+AKKeOJpGYh16GWY0QRGKVMZ5Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMsD1jLGBWpSwFWqRtFqYYsD2666AIm71I+ilmtyBps5VESE9
	9bSmq1BYgzp1WjD5j63Vk7OSCRVlwVGomje6qiUji48LLl+wqn+KFXzLbYQrJQ6Q7w+1iZTdzqn
	Bu/AAoCwLqGb+Sly2diDAzA==
X-Received: from wrwk14.prod.google.com ([2002:a5d:66ce:0:b0:45e:6a78:7fad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d89:0:b0:47f:fb57:8c7f with SMTP id ffacd0b85a97d-481528fb898mr7955494f8f.29.1786548812612;
 Wed, 12 Aug 2026 08:33:32 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:06 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-6-vdonnefort@google.com>
Subject: [PATCH v4 5/9] tracing: Fix subbuf resize races in trace_pipe_raw readers
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
index 94552a433228..f62d6853ee5c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6988,22 +6988,34 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  * Returns:
  *  The page allocated, or ERR_PTR
  */
-struct buffer_data_read_page *
-ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
+struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
+							  struct buffer_data_read_page *prev)
 {
+	struct buffer_data_read_page *bpage = prev;
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
+	unsigned int order;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
-	bpage = kzalloc_obj(*bpage);
-	if (!bpage)
-		return ERR_PTR(-ENOMEM);
-
-	bpage->order = buffer->subbuf_order;
+	order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
+
+	if (!bpage) {
+		bpage = kzalloc_obj(*bpage);
+		if (!bpage)
+			return ERR_PTR(-ENOMEM);
+	} else {
+		if (bpage->order == order)
+			return bpage;
+
+		free_pages((unsigned long)bpage->data, bpage->order);
+		bpage->data = NULL;
+	}
+
+	bpage->order = order;
+
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
@@ -7020,7 +7032,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
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
@@ -7041,13 +7055,22 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
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
@@ -7312,6 +7335,18 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
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
index 395238b2b715..0409d20a168b 100644
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
 
@@ -7091,36 +7091,31 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
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
+	info->read = 0;
+
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
+	info->spare_cpu = iter->cpu_file;
 
- again:
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
 				    info->spare,
@@ -7129,6 +7124,10 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
+		/* Did we race with ring_buffer_subbuf_order_set ? */
+		if (spare_size != ring_buffer_subbuf_size_get(iter->array_buffer->buffer))
+			goto again;
+
 		if (trace_empty(iter) && !iter->closed) {
 			if (update_last_data_if_empty(iter->tr))
 				return 0;
@@ -7142,12 +7141,12 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 			goto again;
 		}
+
 		return 0;
 	}
 
-	info->read = 0;
  read:
-	size = page_size - info->read;
+	size = spare_size - info->read;
 	if (size > count)
 		size = count;
 	trace_data = ring_buffer_read_page_data(info->spare);
@@ -7268,23 +7267,12 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
 
@@ -7292,9 +7280,10 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
@@ -7304,7 +7293,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		refcount_set(&ref->refcount, 1);
 		ref->buffer = iter->array_buffer->buffer;
-		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
+		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, NULL);
 		if (IS_ERR(ref->page)) {
 			ret = PTR_ERR(ref->page);
 			ref->page = NULL;
@@ -7313,11 +7302,21 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
@@ -7330,6 +7329,7 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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

