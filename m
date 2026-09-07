Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1246C4BE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809212; cv=none; b=Wxo19IuDkyhSSbiAt9PK42/8P6DltAYv9izmOxT5MI8EMLRlv28bx3tzPU5Q8ZzB4JBeq3UII1yazvOKLhxa79ejQDLxpHhe4F0cfAwK/zwo94GnmdItvx0W9Z66DVlAJoa3XgQqsLt+R1TyRvvTIEVLj6Rm9Ys2ExVCUNdWuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809212; c=relaxed/simple;
	bh=NynFTKt6RVr+op3xbyiJQrAs6KI2YX8pjMHi+7qOb8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqUZCyRnB7mWhIgtwKnl2S2ciBaXCu3qA2ueheAHF3mX+dC4OY3Hhb3Z+Vv3JmLp+Vvy52Y/1UZimaTecLyn8MhgQumpOtz1odaj5kLNkQI0uNEwOEZhUtmh97zSn1ssxZrvXYe69iJO/mh0nTDI9TkbegfQ5HYOZSJTypb9fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbf18RL0; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbf18RL0"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so26156015e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788809208; x=1789414008; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCveXykaK8vLD9VcikbfF1R8BHSS4OZomyQEA0R1gnk=;
        b=nbf18RL0D/fKT8sXeYPEWsiu2bCUygluJtq72PzkukNS9YzDpbBiHozAfEYFG/7OFV
         1UrzH5oAA9u1mN421FPh/uwRhWex59KReMkcLvB/exJAQ687uiXj5vNSb2brs6e8l+n1
         rAvkmJ7yDI0l5IT7eD16whO+6fOe1Uq/gFe/Jz/Vk6YueQdAyOQNOIhdo4m7BG7UESNS
         pJv2nADrX9grc7w/QbbsrEqM7N7W6q1jwUj+0TXZQ9rET05oERTSYaMTPX9KHyyyxMze
         g/I8CBZuAmWiiD9j4qGWr25fXn5q4/ivD7wz0lK52KYikxZe4JPIApNA5jGiC2omNyyf
         HHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809208; x=1789414008;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCveXykaK8vLD9VcikbfF1R8BHSS4OZomyQEA0R1gnk=;
        b=lPt4xrG+T5Pm1vjbfzAHiahBDsVEnXuIFGWeq40CN8wtP2s7MdF/t3dsOAHXjufDau
         oAjdHDvB+0KGJZzAJ3rs84B/B0+9t4AMtlPjOyO/dEm28Thd1xr0FchkniAHU//qOIe+
         Cxp9H5H7p2h4o/hWIDIS4oYOBZDebm7tRVgaMfWfYQp0wY08ySiZ4G6pljYB9fdqWHkq
         l8x34FQazIOyAy1NRL6ydshTNtP3fgWCLDPiaEnYITp+tqzRUW1BYgN9yTnXdQUlXfLO
         bu81tnDLMyvBJ4PbZW5+OXll7VlLmaD7C4YI+6/04rlnsPAy0CYghoQB892r1lLhHSCo
         d/NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJYRpjR/YOxc/DFSEG5padsasjpZxQ4nQzPXwRwklr7x241TP9hoV/1Onbz33VOqI/TAUzgN3ZzMkv36C6EVLzkq8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVp/0pv6/3zq3vnO/SeJAe95IWRDrLkCU3tOW2D5XLASzHjSjZ
	Y5rMUlU0sKRY/N/zlzBOvL51jM+l+NUkG27Ep7Hapr0yCSjrgVvbAzNGlnpCyeLYkMIMT8Sc++0
	LodvoJzOblC5mcDCUMyfr9g==
X-Received: from wmbf11.prod.google.com ([2002:a05:600c:594b:b0:49c:cea7:ac80])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b99:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cf81fb72amr262383675e9.1.1788809207764;
 Mon, 07 Sep 2026 12:26:47 -0700 (PDT)
Date: Mon,  7 Sep 2026 20:26:43 +0100
In-Reply-To: <20260907192643.42513-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907192643.42513-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907192643.42513-3-vdonnefort@google.com>
Subject: [PATCH v1 2/2] ring-buffer: Unify ring buffer minimum page calculations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The codebase scatters hardcoded minimum page limits across multiple
places. Introduce RING_BUFFER_MIN_NR_PAGES and rb_size_to_nr_pages() to
formalize the requirement of two pages in a ring buffer.

Remote and persistent ring buffers must account for the reader page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 7a1a92f87650..a9401b8ebc72 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -99,6 +99,13 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
+/*
+ * A minimum of 2 pages ensures we can always swap a page out of the ring
+ * buffer. This does not account for the reader page or any other page
+ * containing meta data used by static ring buffers.
+ */
+#define RING_BUFFER_MIN_NR_PAGES 2UL
+
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
@@ -281,10 +288,15 @@ static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buf
 	return (struct ring_buffer_desc *)(&desc->__data[0]);
 }
 
+static inline unsigned long __ring_buffer_size_to_desc_pages(size_t size)
+{
+	/* Takes into account the reader page */
+	return max(DIV_ROUND_UP(size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), RING_BUFFER_MIN_NR_PAGES) + 1;
+}
+
 static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
 {
-	unsigned long nr_pages =
-		max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
+	unsigned long nr_pages = __ring_buffer_size_to_desc_pages(buffer_size);
 	struct ring_buffer_desc *rbdesc;
 
 	/* Capped by ring_buffer_desc::nr_page_va */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..88e39d98332a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -642,6 +642,11 @@ static __always_inline unsigned int rb_subbuf_max_data_size(struct trace_buffer
 	return rb_subbuf_capacity(buffer) - RB_EVNT_HDR_SIZE - sizeof(event->array[0]);
 }
 
+static unsigned long rb_size_to_nr_pages(struct trace_buffer *buffer, unsigned long size)
+{
+	return max(DIV_ROUND_UP(size, rb_subbuf_capacity(buffer)), RING_BUFFER_MIN_NR_PAGES);
+}
+
 /**
  * rb_subbuf_start - Get the start address of a subbuffer
  * @buffer:	A trace buffer
@@ -2865,7 +2870,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 			goto fail_free_buffers;
 
 		/* Need at least two pages plus the reader page */
-		if (nr_pages < 3)
+		if (nr_pages < RING_BUFFER_MIN_NR_PAGES + 1)
 			goto fail_free_buffers;
 
  again:
@@ -2877,7 +2882,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 			ptr += subbuf_size * nr_pages;
 		}
 		if (ptr > end) {
-			if (nr_pages <= 3)
+			if (nr_pages <= RING_BUFFER_MIN_NR_PAGES + 1)
 				goto fail_free_buffers;
 			nr_pages--;
 			goto again;
@@ -2900,13 +2905,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		if (nr_pages > rb_static_max_pages())
 			goto fail_free_buffers;
 
-		if (nr_pages < 2)
+		if (nr_pages < RING_BUFFER_MIN_NR_PAGES)
 			goto fail_free_buffers;
 	} else {
-		/* need at least two pages */
-		nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
-		if (nr_pages < 2)
-			nr_pages = 2;
+		nr_pages = rb_size_to_nr_pages(buffer, size);
 	}
 
 	cpumask_set_cpu(cpu, buffer->cpumask);
@@ -3319,11 +3321,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	mutex_lock(&buffer->mutex);
 	atomic_inc(&buffer->resizing);
 
-	nr_pages = DIV_ROUND_UP(size, rb_subbuf_capacity(buffer));
-
-	/* we need a minimum of two pages */
-	if (nr_pages < 2)
-		nr_pages = 2;
+	nr_pages = rb_size_to_nr_pages(buffer, size);
 
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
@@ -7495,12 +7493,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 
 		/* Update the number of pages to match the new size */
-		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
-
-		/* we need a minimum of two pages */
-		if (nr_pages < 2)
-			nr_pages = 2;
+		nr_pages = rb_size_to_nr_pages(buffer,
+					       old_capacity * buffer->buffers[cpu]->nr_pages);
 
 		cpu_buffer->nr_pages_to_update = nr_pages;
 
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 49913bb0057a..abfaf9bee12e 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -383,8 +383,8 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
 	void *page;
 	int i;
 
-	/* At least 1 reader page and two pages in the ring-buffer */
-	if (desc->nr_page_va < 3)
+	/* At least RING_BUFFER_MIN_NR_PAGES and 1 reader page */
+	if (desc->nr_page_va < RING_BUFFER_MIN_NR_PAGES + 1)
 		return -EINVAL;
 
 	memset(cpu_buffer, 0, sizeof(*cpu_buffer));
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2e0fdbb730b7..0d90e02b1f4b 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -994,7 +994,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 	desc->struct_len = min_desc_size;
 
 	rb_desc = __first_ring_buffer_desc(desc);
-	nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
+	nr_pages = __ring_buffer_size_to_desc_pages(buffer_size);
 
 	for_each_cpu(cpu, cpumask) {
 		unsigned int id;
-- 
2.55.0.979.g7e5102b832-goog

