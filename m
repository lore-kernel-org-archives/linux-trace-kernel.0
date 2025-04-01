Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF319214221;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539550; cv=none; b=TaXtyx4HU6N171CHkg5KNF1eRiJfPV6VCF90nDPXLnk5DPtdRd1pnVMqvdBpZuUBzkjA4EJw6/qzCSQ2tO5mQhULTWyuQSQoU1KDuln4b3FRqZE8BbD8N46h4iqcsKkE2AkC5yVFagAB5hKEWRqmyoV/LhGDzzMii1Uei7b9hCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539550; c=relaxed/simple;
	bh=Gp13WAunse4VyJM266TXO63VppQOLLyoxgk8UnWLdwU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bNByDEs1OSwv1/71huR0jAsDIEu3AMD1brlomXgPKAN4Aq7Pnz065OpbQMZt2kfJXMdWltEPqVk4majIDLZaPtse0C/GQVTENignWsgKKQjmh3eECUayzP6aWy+bHoErRC2trXMcca4Vb2na9Rv7zqWLVTzS4GHqsgvk8bCaUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F47C4CEE4;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tziIe-00000006IfI-1fDZ;
	Tue, 01 Apr 2025 16:33:32 -0400
Message-ID: <20250401203332.246646011@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 16:25:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: [PATCH v3 5/5] ring-buffer: Allow reserve_mem persistent ring buffers to be mmapped
References: <20250401202549.409271454@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the persistent ring buffer is created from the memory returned by
reserve_mem there is nothing prohibiting it to be memory mapped to user
space. The memory is the same as the pages allocated by alloc_page().

The way the memory is managed by the ring buffer code is slightly
different though and needs to be addressed.

The persistent memory uses the page->id for its own purpose where as the
user mmap buffer currently uses that for the subbuf array mapped to user
space. If the buffer is a persistent buffer, use the page index into that
buffer as the identifier instead of the page->id.

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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 49 ++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.c       |  4 ----
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d4b0f7b55cce..f7a10f754066 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6000,6 +6000,39 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+/*
+ * When the buffer is memory mapped to user space, each sub buffer
+ * has a unique id that is used by the meta data to tell the user
+ * where the current reader page is.
+ *
+ * For a normal allocated ring buffer, the id is saved in the buffer page
+ * id field, and updated via this function.
+ *
+ * But for a fixed memory mapped buffer, the id is already assigned for
+ * fixed memory ording in the memory layout and can not be used. Instead
+ * the index of where the page lies in the memory layout is used.
+ *
+ * For the normal pages, set the buffer page id with the passed in @id
+ * value and return that.
+ *
+ * For fixed memory mapped pages, get the page index in the memory layout
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
@@ -6008,7 +6041,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 		return;
 
 	meta->reader.read = cpu_buffer->reader_page->read;
-	meta->reader.id = cpu_buffer->reader_page->id;
+	meta->reader.id = rb_page_id(cpu_buffer, cpu_buffer->reader_page,
+				     cpu_buffer->reader_page->id);
+
 	meta->reader.lost_events = cpu_buffer->lost_events;
 
 	meta->entries = local_read(&cpu_buffer->entries);
@@ -6924,23 +6959,29 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
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
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1d7d2b772a74..5e7f8113c024 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8497,10 +8497,6 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (iter->tr->flags & TRACE_ARRAY_FL_MEMMAP)
 		return -ENODEV;
 
-	/* Currently the boot mapped buffer is not supported for mmap */
-	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
-		return -ENODEV;
-
 	ret = get_snapshot_map(iter->tr);
 	if (ret)
 		return ret;
-- 
2.47.2


