Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638A1EF37E;
	Fri, 28 Mar 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199709; cv=none; b=BXY9HVYaJEVbDWyfFeu3j+Gi/VJRrydp84s6N89DOX/ThPHLA/xRuS7R7UIvcqIhNrfwyjfilkNfwYp1xbQhaX23TOvAQeDn0sIDQjWbNj+s9kblvvPAPjHSFQHPvQpnuWalzwv9GrucN3IWOks16GPzorxdf7fCg57L7lAFoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199709; c=relaxed/simple;
	bh=cSU2Inx8Dav5WoF7W80uSRAyVT7kcYSrWtjI51sWu/g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=o0JTTMRpCoctuhx6U6L9V8wZ73eLTP3f5UpSzD6yBAR62Z5pXB5sZ8r1Zknz8TvHe9NQIzskpDBy8zplApKVnuvJSz8H6XnRum7vHE+wNEuw6o9IzFCROtiL7qIBcEiY00avYk8SODSQHR3OKeox2nCMyEOdGERPfEjWkXgNKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9F1C4CEEE;
	Fri, 28 Mar 2025 22:08:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tyHtB-000000044Co-2fPs;
	Fri, 28 Mar 2025 18:09:21 -0400
Message-ID: <20250328220921.477268698@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 28 Mar 2025 18:08:38 -0400
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
Subject: [PATCH 2/2] ring-buffer: Allow persistent ring buffers to be mmapped
References: <20250328220836.812222422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The persistent ring buffer uses vmap()'d memory to map the reserved memory
from boot. But the user space mmap() to the ring buffer requires
virt_to_page() to return a valid page. But that only works for core kernel
addresses and not for vmap() addresses.

To address this, save the physical and virtual address of where the
persistent memory is mapped. Create a rb_struct_page() helper function
that returns the page via virt_to_page() for normal buffer pages that were
allocated with page_alloc() but for the physical memory vmap()'d pages, it
uses the saved physical and virtual addresses of where the memory was
located to calculate the physical address of the virtual page that needs
the struct page. Then it uses pfn_to_page() to get the page for that
physical address.

New helper functions are created for flushing the cache for architectures
that need it between user and kernel space.

Also, the persistent memory uses the page->id for its own purpose where as
the user mmap buffer currently uses that for the subbuf array mapped to
user space. If the buffer is a persistent buffer, use the page index into
that buffer as the identifier instead of the page->id.

That is, the page->id for a persistent buffer, represents the order of the
buffer is in the link list. ->id == 0 means it is the reader page.
When a reader page is swapped, the new reader page's ->id gets zero, and
the old reader page gets the ->id of the page that it swapped with.

The user space mapping has the ->id is the index of where it was mapped in
user space and does not change while it is mapped.

Since the persistent buffer is fixed in its location, the index of where
a page is in the memory range can be used as the "id" to put in the meta
page array, and it can be mapped in the same order to user space as it is
in the persistent memory.

A new rb_page_id() helper function is used to get and set the id depending
on if the page is a normal memory allocated buffer or a physical memory
mapped buffer.

Link: https://lore.kernel.org/all/CAHk-=wgD9MQOoMAGtT=fXZsWY39exRVyZgxuBXix4u=1bdHA=g@mail.gmail.com/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 110 +++++++++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0f5481d8d0b1..d5c502bc2b27 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -558,6 +558,7 @@ struct trace_buffer {
 	struct ring_buffer_meta		*meta;
 
 	unsigned long			phys_start;
+	unsigned long			virt_start;
 
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
@@ -2455,6 +2456,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 		start = addr;
 		end = start + size;
+		buffer->virt_start = start;
 
 		/* scratch_size needs to be aligned too */
 		scratch_size = ALIGN(scratch_size, sizeof(long));
@@ -6058,6 +6060,80 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+/*
+ * Get the struct page for the given buffer page.
+ *
+ * For normal ring buffer pages that are allocated via page_alloc()
+ * the struct page can simply be retrieved via virt_to_page().
+ *
+ * But if the buffer was created via a physical mapping and vmap()
+ * was used to get to the virtual addresses, use the stored virtual
+ * and physical of the start address to calculate the original
+ * physical address of the given page and use pfn_to_page() to return
+ * the struct page.
+ */
+static struct page *rb_struct_page(struct trace_buffer *buffer, void *vaddr)
+{
+	if (buffer->flags & RB_FL_PHYSICAL) {
+		unsigned long addr = (unsigned long)vaddr;
+
+		addr -= buffer->virt_start;
+		addr += buffer->phys_start;
+		return pfn_to_page(addr >> PAGE_SHIFT);
+	}
+	return virt_to_page(vaddr);
+}
+
+/* Some archs do not have data cache coherency between kernel and user-space */
+static void rb_flush_buffer_page(struct trace_buffer *buffer,
+				 struct buffer_page *bpage)
+{
+	struct page *page = rb_struct_page(buffer, bpage->page);
+
+	flush_dcache_folio(page_folio(page));
+}
+
+/* The user mapped meta page is always allocated via page_alloc() */
+static void rb_flush_meta(void *meta)
+{
+	struct page *page = virt_to_page(meta);
+
+	flush_dcache_folio(page_folio(page));
+}
+
+/*
+ * When the buffer is memory mapped to user space, each sub buffer
+ * has a unique id that is used by the meta data to tell the user
+ * where the current reader page is.
+ *
+ * For a normal allocated ring buffer, the id is saved in the buffer page
+ * id field, and updated via this function.
+ *
+ * But for a physical memory mapped buffer, the id is already assigned for
+ * memory ording in the physical memory layout and can not be used. Instead
+ * the index of where the page lies in the memory layout is used.
+ *
+ * For the normal pages, set the buffer page id with the passed in @id
+ * value and return that.
+ *
+ * For memory mapped pages, get the page index in the physical memory layout
+ * and return that as the id.
+ */
+static int rb_page_id(struct ring_buffer_per_cpu *cpu_buffer,
+		      struct buffer_page *bpage, int id)
+{
+	/*
+	 * For boot buffers, the id is the index,
+	 * otherwise, set the buffer page with this id
+	 */
+	if (cpu_buffer->ring_meta)
+		id = rb_meta_subbuf_idx(cpu_buffer->ring_meta, bpage->page);
+	else
+		bpage->id = id;
+
+	return id;
+}
+
 static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
@@ -6066,15 +6142,16 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 		return;
 
 	meta->reader.read = cpu_buffer->reader_page->read;
-	meta->reader.id = cpu_buffer->reader_page->id;
+	meta->reader.id = rb_page_id(cpu_buffer, cpu_buffer->reader_page,
+				     cpu_buffer->reader_page->id);
+
 	meta->reader.lost_events = cpu_buffer->lost_events;
 
 	meta->entries = local_read(&cpu_buffer->entries);
 	meta->overrun = local_read(&cpu_buffer->overrun);
 	meta->read = cpu_buffer->read;
 
-	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+	rb_flush_meta(meta);
 }
 
 static void
@@ -6982,23 +7059,29 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
 	struct buffer_page *first_subbuf, *subbuf;
+	int cnt = 0;
 	int id = 0;
 
-	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
-	cpu_buffer->reader_page->id = id++;
+	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
+	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
 	do {
+		id = rb_page_id(cpu_buffer, subbuf, id);
+
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
 		subbuf_ids[id] = (unsigned long)subbuf->page;
-		subbuf->id = id;
 
 		rb_inc_page(&subbuf);
 		id++;
+		cnt++;
 	} while (subbuf != first_subbuf);
 
+	WARN_ON(cnt != nr_subbufs);
+
 	/* install subbuf ID to kern VA translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
@@ -7134,6 +7217,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	if (!pgoff) {
 		unsigned long meta_page_padding;
 
+		/* The meta page is always allocated via alloc_page() */
 		pages[p++] = virt_to_page(cpu_buffer->meta_page);
 
 		/*
@@ -7163,7 +7247,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		page = rb_struct_page(cpu_buffer->buffer,
+				      (void *)cpu_buffer->subbuf_ids[s]);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7196,14 +7281,6 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	unsigned long flags, *subbuf_ids;
 	int err = 0;
 
-	/*
-	 * Currently, this does not support vmap()'d buffers.
-	 * Return -ENODEV as that is what is returned when a file
-	 * does not support memory mapping.
-	 */
-	if (buffer->flags & RB_FL_PHYSICAL)
-		return -ENODEV;
-
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
@@ -7384,8 +7461,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	goto consume;
 
 out:
-	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+	rb_flush_buffer_page(buffer, cpu_buffer->reader_page);
 
 	rb_update_meta_page(cpu_buffer);
 
-- 
2.47.2


