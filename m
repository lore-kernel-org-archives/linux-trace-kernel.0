Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD118A95E;
	Fri, 14 Feb 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556272; cv=none; b=fHkt4WPGza7fTvP2qtiX6Zq8NyFtkatwYswIPXhZU2ePKiYUNP9CsVhVdqXGgBxYOTHW8pRL8BicJUOZOdD+9RPkNEaVcaZsiV8jj3890OsKiZi76vovWZIs81qUosCb1C0Nqwr3sGvbtqyNJH7ZgWO9LVMnwjxrV7Ny7Xtz/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556272; c=relaxed/simple;
	bh=i8eBRsGFqX7u/OaXDisHtA5IiCuO9McveZ0pd21c1r4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FXu7MpDIV5eNp8+1NPU9FzoybLm/qtPAbsDDilzWhpttFFOS8LgoLTuAdRPWeaRsuO+Zcg1xWlybhIGKfvyHj2CtyT8OQQXb/ZrdtwzH9Ln4yrYrMpX0G65AeVGEp7F/Mca4wVKM81HxFxDvhm9rKv13hAwyckR2S+HCd7UB/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B081DC4CED1;
	Fri, 14 Feb 2025 18:04:30 +0000 (UTC)
Date: Fri, 14 Feb 2025 13:04:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Allow persistent ring buffers to be mmapped
Message-ID: <20250214130442.3f4fee5d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The persistent ring buffer uses vmap()'d memory to map the reserved memory
from boot. But the user space mmap() to the ring buffer requires
virt_to_page() to return a valid page. But that only works for core kernel
addresses and not for vmap() addresses.

If virt_addr_valid() fails on the page to be mapped, use vmalloc_to_page()
instead.

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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 49 ++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c       |  4 ----
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb6089c2951e..87caf9d48edb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5950,12 +5950,18 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	struct page *page;
 
 	if (!meta)
 		return;
 
 	meta->reader.read = cpu_buffer->reader_page->read;
-	meta->reader.id = cpu_buffer->reader_page->id;
+	/* For boot buffers, the id is the index */
+	if (cpu_buffer->ring_meta)
+		meta->reader.id = rb_meta_subbuf_idx(cpu_buffer->ring_meta,
+						     cpu_buffer->reader_page->page);
+	else
+		meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
 
 	meta->entries = local_read(&cpu_buffer->entries);
@@ -5963,7 +5969,12 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->read = cpu_buffer->read;
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+	if (virt_addr_valid(cpu_buffer->meta_page))
+		page = virt_to_page(cpu_buffer->meta_page);
+	else
+		page = vmalloc_to_page(cpu_buffer->meta_page);
+
+	flush_dcache_folio(page_folio(page));
 }
 
 static void
@@ -6883,23 +6894,38 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
 	struct buffer_page *first_subbuf, *subbuf;
+	int cnt = 0;
 	int id = 0;
 
-	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
-	cpu_buffer->reader_page->id = id++;
+	if (cpu_buffer->ring_meta)
+		id = rb_meta_subbuf_idx(cpu_buffer->ring_meta,
+					cpu_buffer->reader_page->page);
+	else
+		cpu_buffer->reader_page->id = id;
+
+	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
 	do {
+		if (cpu_buffer->ring_meta)
+			id = rb_meta_subbuf_idx(cpu_buffer->ring_meta,
+						subbuf->page);
+		else
+			subbuf->id = id;
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
 
@@ -7064,7 +7090,10 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		if (virt_addr_valid(cpu_buffer->subbuf_ids[s]))
+			page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		else
+			page = vmalloc_to_page((void *)cpu_buffer->subbuf_ids[s]);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7210,6 +7239,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	unsigned long missed_events;
 	unsigned long reader_size;
 	unsigned long flags;
+	struct page *page;
 
 	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
 	if (IS_ERR(cpu_buffer))
@@ -7278,7 +7308,12 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+	if (virt_addr_valid(cpu_buffer->meta_page))
+		page = virt_to_page(cpu_buffer->meta_page);
+	else
+		page = vmalloc_to_page(cpu_buffer->meta_page);
+
+	flush_dcache_folio(page_folio(page));
 
 	rb_update_meta_page(cpu_buffer);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..25ff37aab00f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8279,10 +8279,6 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
-	/* Currently the boot mapped buffer is not supported for mmap */
-	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
-		return -ENODEV;
-
 	ret = get_snapshot_map(iter->tr);
 	if (ret)
 		return ret;
-- 
2.47.2

