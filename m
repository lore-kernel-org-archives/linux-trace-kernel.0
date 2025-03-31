Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069921C16E;
	Mon, 31 Mar 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431674; cv=none; b=YEjU50/9v6XIpEmFU0509ppKxYqE7OPJT1vqTmJxyjxBBJpdZOmJaek3ny3u1qLsZawOEfeeBR+Af1iW92s2Tuxl6N75PUBqQioULtwNfZgiLCgg4VQIq9VIK/qdRHiIfhgskDmUD0+iJOIXSSbnmGbRDNlvrm4IM7sDsoTr/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431674; c=relaxed/simple;
	bh=6P/iSs4dSHVA63nA+HwqNLTKJJQI2AkjTx/BUwwen4w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lKEUJE8bUhxU8LFZpJ0naPnS85SuMumVRWeFGKVjMEx8Dd7mKBC7rhDxizB62cD1UobJzfkzses0fGFjQNtwdavR3Q93PMR3DHI2e58WnT6fNICtmyPf+tXIQKhG/EKU3SLUm5iuUMp7OMeM1LmkOM21mwt5Mho6iRZgzMz4bG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7CBC4CEEE;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzGEe-00000005pAm-2Z1p;
	Mon, 31 Mar 2025 10:35:32 -0400
Message-ID: <20250331143532.459810712@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 31 Mar 2025 10:34:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do the vmap of
 physical memory
References: <20250331143426.947281958@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently, when reserve_mem is used on the kernel command line to reserve
"persistent" memory to map the ring buffer on. The tracing code will do
the vmap() on the physical memory provided by reserve_mem and pass that to
ring_buffer_alloc_range() where it will map the ring buffer on top of the
given memory. It will also look at the current content of the memory there
and if the memory already contains valid content, it will use that content
for the ring buffer.

But this method makes the ring buffer code not know where that memory came
from. Here, the tracing code used vmap() but it could have also used
vmalloc(), or whatever. And many of these methods may not be supported by
the ring buffer code.

Instead, rename ring_buffer_alloc_range() to ring_buffer_alloc_physical()
where contiguous physical memory is passed to the ring buffer code, and it
will be responsible for mapping it as well as freeing it. This simplifies
the callers from having to keep track of whether the code is mapped or
not.

The ring buffer can also take control of whether it can memory map the
buffer to user space or not. Currently it does not allow this physical
memory to be mapped to user space, but now that it has control over the
struct pages of this memory, it can easily do so in the future.

As the ring buffer mapping of a physical memory mapped buffer will now
fail, the tracing code no longer keeps track if the buffer is the "last
boot" buffer or not and will try to map it anyway. It will still fail, but
when the ring buffer code is modified to allow it, it will then succeed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h | 19 ++++----
 kernel/trace/ring_buffer.c  | 86 ++++++++++++++++++++++++++++++++-----
 kernel/trace/trace.c        | 65 +++++++---------------------
 3 files changed, 101 insertions(+), 69 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 56e27263acf8..a31dff0a9f09 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -89,11 +89,11 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 struct trace_buffer *
 __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *key);
 
-struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
-					       int order, unsigned long start,
-					       unsigned long range_size,
-					       unsigned long scratch_size,
-					       struct lock_class_key *key);
+struct trace_buffer *__ring_buffer_alloc_physical(unsigned long size, unsigned flags,
+						  int order, unsigned long start,
+						  unsigned long range_size,
+						  unsigned long scratch_size,
+						  struct lock_class_key *key);
 
 void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
 
@@ -113,11 +113,11 @@ void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc_range(size, flags, order, start, range_size, s_size)	\
+#define ring_buffer_alloc_physical(size, flags, order, start, range_size, s_size) \
 ({									\
 	static struct lock_class_key __key;				\
-	__ring_buffer_alloc_range((size), (flags), (order), (start),	\
-				  (range_size), (s_size), &__key);	\
+	__ring_buffer_alloc_physical((size), (flags), (order), (start),	\
+				     (range_size), (s_size), &__key);	\
 })
 
 typedef bool (*ring_buffer_cond_fn)(void *data);
@@ -235,7 +235,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order);
 int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
 
 enum ring_buffer_flags {
-	RB_FL_OVERWRITE		= 1 << 0,
+	RB_FL_OVERWRITE		= BIT(0),
+	RB_FL_PHYSICAL		= BIT(1),
 };
 
 #ifdef CONFIG_RING_BUFFER
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f25966b3a1fc..36665754340f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kthread.h>	/* for self test */
+#include <linux/vmalloc.h>	/* for vmap */
 #include <linux/module.h>
 #include <linux/percpu.h>
 #include <linux/mutex.h>
@@ -556,6 +557,8 @@ struct trace_buffer {
 
 	struct ring_buffer_meta		*meta;
 
+	unsigned long			phys_start;
+
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -2351,6 +2354,43 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+static unsigned long map_pages(unsigned long *start, unsigned long *end)
+{
+	struct page **pages;
+	phys_addr_t page_start;
+	unsigned long size;
+	unsigned long page_count;
+	unsigned long i;
+	void *vaddr;
+
+	/* Make sure the mappings are page aligned */
+	*start = ALIGN(*start, PAGE_SIZE);
+
+	size = *end - *start;
+
+	/* The size must fit full pages */
+	page_count = size >> PAGE_SHIFT;
+
+	if (!page_count)
+		return 0;
+
+	page_start = *start;
+	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return 0;
+
+	for (i = 0; i < page_count; i++) {
+		phys_addr_t addr = page_start + i * PAGE_SIZE;
+		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	}
+	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
+	kfree(pages);
+
+	*end = *start + page_count * PAGE_SIZE;
+
+	return (unsigned long)vaddr;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2395,14 +2435,26 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers)
 		goto fail_free_cpumask;
 
-	/* If start/end are specified, then that overrides size */
+	/* If start/end are specified, then this is a physical mapping */
 	if (start && end) {
 		unsigned long buffers_start;
+		unsigned long addr;
 		unsigned long ptr;
+		u64 size;
 		int n;
 
-		/* Make sure that start is word aligned */
-		start = ALIGN(start, sizeof(long));
+		addr = map_pages(&start, &end);
+		if (!addr)
+			goto fail_free_cpumask;
+
+		/* end and start have have been updated for alignment */
+		size = end - start;
+
+		buffer->phys_start = start;
+		buffer->flags |= RB_FL_PHYSICAL;
+
+		start = addr;
+		end = start + size;
 
 		/* scratch_size needs to be aligned too */
 		scratch_size = ALIGN(scratch_size, sizeof(long));
@@ -2479,6 +2531,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	}
 	kfree(buffer->buffers);
 
+	if (buffer->phys_start)
+		vunmap((void *)buffer->phys_start);
+
  fail_free_cpumask:
 	free_cpumask_var(buffer->cpumask);
 
@@ -2508,11 +2563,11 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
 
 /**
- * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
+ * __ring_buffer_alloc_physical - allocate a new ring_buffer from physical memory
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
  * @order: sub-buffer order
- * @start: start of allocated range
+ * @start: start of the physical memory range
  * @range_size: size of allocated range
  * @scratch_size: size of scratch area (for preallocated memory buffers)
  * @key: ring buffer reader_lock_key.
@@ -2522,11 +2577,11 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
  * when the buffer wraps. If this flag is not set, the buffer will
  * drop data when the tail hits the head.
  */
-struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
-					       int order, unsigned long start,
-					       unsigned long range_size,
-					       unsigned long scratch_size,
-					       struct lock_class_key *key)
+struct trace_buffer *__ring_buffer_alloc_physical(unsigned long size, unsigned flags,
+						  int order, unsigned long start,
+						  unsigned long range_size,
+						  unsigned long scratch_size,
+						  struct lock_class_key *key)
 {
 	return alloc_buffer(size, flags, order, start, start + range_size,
 			    scratch_size, key);
@@ -2569,6 +2624,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 	kfree(buffer->buffers);
 	free_cpumask_var(buffer->cpumask);
 
+	if (buffer->flags & RB_FL_PHYSICAL)
+		vunmap((void *)buffer->phys_start);
+
 	kfree(buffer);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free);
@@ -7138,6 +7196,14 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	unsigned long flags, *subbuf_ids;
 	int err = 0;
 
+	/*
+	 * Currently, this does not support vmap()'d buffers.
+	 * Return -ENODEV as that is what is returned when a file
+	 * does not support memory mapping.
+	 */
+	if (buffer->flags & RB_FL_PHYSICAL)
+		return -ENODEV;
+
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 14c38fcd6f9e..20724d64e02e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8492,10 +8492,6 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
-	/* Currently the boot mapped buffer is not supported for mmap */
-	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
-		return -ENODEV;
-
 	ret = get_snapshot_map(iter->tr);
 	if (ret)
 		return ret;
@@ -8503,8 +8499,8 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
 	if (ret)
 		put_snapshot_map(iter->tr);
-
-	vma->vm_ops = &tracing_buffers_vmops;
+	else
+		vma->vm_ops = &tracing_buffers_vmops;
 
 	return ret;
 }
@@ -9520,10 +9516,17 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
 	if (tr->range_addr_start && tr->range_addr_size) {
 		/* Add scratch buffer to handle 128 modules */
-		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
-						      tr->range_addr_start,
-						      tr->range_addr_size,
-						      struct_size(tscratch, entries, 128));
+		buf->buffer = ring_buffer_alloc_physical(size, rb_flags, 0,
+							 tr->range_addr_start,
+							 tr->range_addr_size,
+							 struct_size(tscratch, entries, 128));
+		if (!buf->buffer) {
+			pr_warn("Tracing: Failed to map boot instance %s\n", tr->name);
+			return -1;
+		}
+
+		pr_info("Tracing: mapped boot instance %s at physical memory %lx of size 0x%lx\n",
+			tr->name, tr->range_addr_start, tr->range_addr_size);
 
 		tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
 		setup_trace_scratch(tr, tscratch, scratch_size);
@@ -9600,9 +9603,6 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
-
-	if (tr->range_addr_start)
-		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -9795,31 +9795,6 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
-static u64 map_pages(u64 start, u64 size)
-{
-	struct page **pages;
-	phys_addr_t page_start;
-	unsigned int page_count;
-	unsigned int i;
-	void *vaddr;
-
-	page_count = DIV_ROUND_UP(size, PAGE_SIZE);
-
-	page_start = start;
-	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return 0;
-
-	for (i = 0; i < page_count; i++) {
-		phys_addr_t addr = page_start + i * PAGE_SIZE;
-		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
-	}
-	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
-	kfree(pages);
-
-	return (u64)(unsigned long)vaddr;
-}
-
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
  * @name: The name of the trace array to be looked up/created.
@@ -10708,7 +10683,6 @@ __init static void enable_instances(void)
 	while ((curr_str = strsep(&str, "\t"))) {
 		phys_addr_t start = 0;
 		phys_addr_t size = 0;
-		unsigned long addr = 0;
 		bool traceprintk = false;
 		bool traceoff = false;
 		char *flag_delim;
@@ -10773,22 +10747,13 @@ __init static void enable_instances(void)
 			rname = kstrdup(tok, GFP_KERNEL);
 		}
 
-		if (start) {
-			addr = map_pages(start, size);
-			if (addr) {
-				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
-					name, &start, (unsigned long)size);
-			} else {
-				pr_warn("Tracing: Failed to map boot instance %s\n", name);
-				continue;
-			}
-		} else {
+		if (!start) {
 			/* Only non mapped buffers have snapshot buffers */
 			if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
 				do_allocate_snapshot(name);
 		}
 
-		tr = trace_array_create_systems(name, NULL, addr, size);
+		tr = trace_array_create_systems(name, NULL, (unsigned long)start, size);
 		if (IS_ERR(tr)) {
 			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
-- 
2.47.2


