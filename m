Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EF273FD;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051494; cv=none; b=Bx+CZ8Fkb9PVhz/ytxbe6/PRn9L1aDlRA6u6VM+3A2hOwQq5WR7IRfTJRQ6o8pmCHtuuirNTb0sUtmJZ/pDi8l3LdFGYin0VkSJ3VpCQulsOk2gPzuxkLgmT2sebllxouO9XXFy4RoDiw5FjdSPhDqFGwcuZACyqsiByizHASWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051494; c=relaxed/simple;
	bh=3+LfRhStgRkOnlP0mwLCHwGugqSl/C9uw5T6xGyyMhc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mshuUlu565XEV72UISPYzOIs966Vtb6mRYsE/Jv4ojspo5diaDYuHBlTDNVok0mnFVlC10HcksQn+7KSH0mgJgT4vRqJh+MdaROrFhcq2dsfIInlE3IzMrzyyYo1tqjZejWwHZzPIK3V5LHZf9dVlxxRNpmldeH8Q+pcmRRucR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D52EC4CEEC;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpH2a-0000000CC5h-12qN;
	Mon, 03 Mar 2025 20:25:48 -0500
Message-ID: <20250304012548.100322331@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Mar 2025 20:25:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/8] ring-buffer: Add ring_buffer_meta_scratch()
References: <20250304012516.282694507@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that there's one meta data at the start of the persistent memory used by
the ring buffer, allow the caller to request some memory right after that
data that it can use as its own persistent memory.

Also fix some white space issues with ring_buffer_alloc().

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  6 ++++--
 kernel/trace/ring_buffer.c  | 34 ++++++++++++++++++++++++++++------
 kernel/trace/trace.c        |  2 +-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 8de035f4f0d9..019b59a0bbc9 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -92,9 +92,11 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
 					       int order, unsigned long start,
 					       unsigned long range_size,
+					       unsigned long scratch_size,
 					       struct lock_class_key *key);
 
 bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
@@ -112,11 +114,11 @@ bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kas
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc_range(size, flags, order, start, range_size)	\
+#define ring_buffer_alloc_range(size, flags, order, start, range_size, s_size)	\
 ({									\
 	static struct lock_class_key __key;				\
 	__ring_buffer_alloc_range((size), (flags), (order), (start),	\
-				  (range_size), &__key);		\
+				  (range_size), (s_size), &__key);	\
 })
 
 typedef bool (*ring_buffer_cond_fn)(void *data);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bd37e14990a3..2df74f3f0086 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1678,7 +1678,7 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
  * See if the existing memory contains a valid meta section.
  * if so, use that, otherwise initialize it.
  */
-static bool rb_meta_init(struct trace_buffer *buffer)
+static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
 {
 	unsigned long ptr = buffer->range_addr_start;
 	struct ring_buffer_meta *bmeta;
@@ -1696,6 +1696,7 @@ static bool rb_meta_init(struct trace_buffer *buffer)
 	/* The first buffer will start word size after the meta page */
 	ptr += sizeof(*bmeta);
 	ptr = ALIGN(ptr, sizeof(long));
+	ptr += scratch_size;
 
 	if (bmeta->magic != RING_BUFFER_META_MAGIC) {
 		pr_info("Ring buffer boot meta mismatch of magic\n");
@@ -1730,6 +1731,9 @@ static bool rb_meta_init(struct trace_buffer *buffer)
 	bmeta->total_size = total_size;
 	bmeta->buffers_offset = (void *)ptr - (void *)bmeta;
 
+	/* Zero out the scatch pad */
+	memset((void *)bmeta + sizeof(*bmeta), 0, bmeta->buffers_offset - sizeof(*bmeta));
+
 	return false;
 }
 
@@ -1954,7 +1958,7 @@ static void rb_meta_init_text_addr(struct ring_buffer_cpu_meta *meta)
 #endif
 }
 
-static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
+static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
 {
 	struct ring_buffer_cpu_meta *meta;
 	struct ring_buffer_meta *bmeta;
@@ -1969,7 +1973,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 	subbuf_mask = bitmap_alloc(nr_pages + 1, GFP_KERNEL);
 	/* If subbuf_mask fails to allocate, then rb_meta_valid() will return false */
 
-	if (rb_meta_init(buffer))
+	if (rb_meta_init(buffer, scratch_size))
 		valid = true;
 
 	bmeta = buffer->meta;
@@ -2367,6 +2371,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
+					 unsigned long scratch_size,
 					 struct lock_class_key *key)
 {
 	struct trace_buffer *buffer;
@@ -2416,10 +2421,15 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		/* Make sure that start is word aligned */
 		start = ALIGN(start, sizeof(long));
 
+		/* scratch_size needs to be aligned too */
+		scratch_size = ALIGN(scratch_size, sizeof(long));
+
 		/* Subtract the buffer meta data and word aligned */
 		buffers_start = start + sizeof(struct ring_buffer_cpu_meta);
 		buffers_start = ALIGN(buffers_start, sizeof(long));
+		buffers_start += scratch_size;
 
+		/* Calculate the size for the per CPU data */
 		size = end - buffers_start;
 		size = size / nr_cpu_ids;
 
@@ -2456,7 +2466,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		buffer->range_addr_start = start;
 		buffer->range_addr_end = end;
 
-		rb_range_meta_init(buffer, nr_pages);
+		rb_range_meta_init(buffer, nr_pages, scratch_size);
 	} else {
 
 		/* need at least two pages */
@@ -2509,7 +2519,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	/* Default buffer page size - one system page */
-	return alloc_buffer(size, flags, 0, 0, 0,key);
+	return alloc_buffer(size, flags, 0, 0, 0, 0, key);
 
 }
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
@@ -2531,9 +2541,11 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
 struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
 					       int order, unsigned long start,
 					       unsigned long range_size,
+					       unsigned long scratch_size,
 					       struct lock_class_key *key)
 {
-	return alloc_buffer(size, flags, order, start, start + range_size, key);
+	return alloc_buffer(size, flags, order, start, start + range_size,
+			    scratch_size, key);
 }
 
 /**
@@ -2557,6 +2569,16 @@ bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kas
 	return true;
 }
 
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
+{
+	if (!buffer || !buffer->meta)
+		return NULL;
+
+	*size = PAGE_SIZE - sizeof(*buffer->meta);
+
+	return (void *)buffer->meta + sizeof(*buffer->meta);
+}
+
 /**
  * ring_buffer_free - free a ring buffer.
  * @buffer: the buffer to free.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 41d463e5327c..69dcd7edaf26 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9214,7 +9214,7 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	if (tr->range_addr_start && tr->range_addr_size) {
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
-						      tr->range_addr_size);
+						      tr->range_addr_size, 0);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 		if (ring_buffer_last_boot_delta(buf->buffer, &tr->kaslr_addr))
-- 
2.47.2


