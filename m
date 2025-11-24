Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172781E8337;
	Mon, 24 Nov 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011310; cv=none; b=eBRsdGQSFBSXbttTacjVLS0YAjH2+boIUzn1IRNHwbKl2ucBXuT2LGLpOfA8SgE+F74WlKdjgOCcu3dazFT78atqf6TMsvHlGv+sbjKfjuzzyvlv0o5VnIJAv+9TyalrlrQhnrQB6Ou1sYJ9WiWiPW6aCpHp998UXB01uelbKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011310; c=relaxed/simple;
	bh=/Lj36/TF74BdZyKIfbI6DYxlTZuk5PtGh+0F2NDVaJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mdJFZ2bgqCOstlcZbZfFiK7X9Cil3q+3BUCbprpdrd215kN2R2HPP7zYAr1ajuO+/f0cCSM0Y/U9E72qBiiguQCJyZFky/88XIhrnU8yEpM8aRF8WG9GdY++zmJXZjJukEYSeEtrYrDylfm9SsBdRh2fbR3W3c49PbmJpMnZsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 93A0C130990;
	Mon, 24 Nov 2025 19:08:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id E861C20029;
	Mon, 24 Nov 2025 19:08:24 +0000 (UTC)
Date: Mon, 24 Nov 2025 14:09:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] ring-buffer: Add helper functions for allocations
Message-ID: <20251124140906.71a2abf6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E861C20029
X-Stat-Signature: irri35ijsf9m83b6k3xudyiyon6hokra
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jmDje3y9PrIF+BGd4OEzAPX/o10Zr7BU=
X-HE-Tag: 1764011304-569440
X-HE-Meta: U2FsdGVkX19SRhprQ1xivjbsQnFXTX7NtUiC3bej7pqyJopzJvrUTvD036/dD1n0EVS1GC5o0SuCalM01EbTwPk5OBulkGvvDz1cZF5nQZrW3mz0trU2KxEfr1evNtflIkQx66I9mzLJQQCtZZWNe9mVmw8VGNBh6Uv6iH0anZNSup90fqG3yHzGAmXxeaVOP8SNpmkwF0MzsLWnMwNNktSKeboBurIU8OiLsriGFR7ooaUuf6sCC6Rg/0+1YPNVnfRmZRBiLPcy4ELDTxH8By5zAeJswnCE8rAF2gKRNirQxEjgVci7A8NXO2zJ9ATrdLUwf+YiCedQ/ixIO3ip8Yh+SOv8wOa3oB5eo+sZm53k4vckJptVB0YI5UHK00xmXglTxGNztnPNAQGqtofJuG7T6Qo7ig6z7IJHZ6d8B7cikhXCm/JYf/iKRfyrhQDRWSvA8064ltH2PfKHgfrjv8Xo7ZR8AaonHXzfQ5LXao0=

From: Steven Rostedt <rostedt@goodmis.org>

The allocation of the per CPU buffer descriptor, the buffer page
descriptors and the buffer page data itself can be pretty ugly:

  kzalloc_node(ALIGN(sizeof(struct buffer_page), cache_line_size()),
               GFP_KERNEL, cpu_to_node(cpu));

And the data pages:

  page = alloc_pages_node(cpu_to_node(cpu),
                          GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO, order);
  if (!page)
	return NULL;
  bpage->page = page_address(page);
  rb_init_page(bpage->page);

Add helper functions to make the code easier to read.

This does make all allocations of the data page (bpage->page) allocated
with the __GFP_RETRY_MAYFAIL flag (and not just the bulk allocator). Which
is actually better, as allocating the data page for the ring buffer tracing
should try hard but not trigger the OOM killer.

Link: https://lore.kernel.org/all/CAHk-=wjMMSAaqTjBSfYenfuzE1bMjLj+2DLtLWJuGt07UGCH_Q@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 86 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..36330986b604 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -401,6 +401,41 @@ static void free_buffer_page(struct buffer_page *bpage)
 	kfree(bpage);
 }
 
+/*
+ * For best performance, allocate cpu buffer data cache line sized
+ * and per CPU.
+ */
+#define alloc_cpu_buffer(cpu) (struct ring_buffer_per_cpu *)		\
+	kzalloc_node(ALIGN(sizeof(struct ring_buffer_per_cpu),		\
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+
+#define alloc_cpu_page(cpu) (struct buffer_page *)			\
+	kzalloc_node(ALIGN(sizeof(struct buffer_page),			\
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+
+static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
+{
+	struct buffer_data_page *dpage;
+	struct page *page;
+	gfp_t mflags;
+
+	/*
+	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
+	 * gracefully without invoking oom-killer and the system is not
+	 * destabilized.
+	 */
+	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
+
+	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
+	if (!page)
+		return NULL;
+
+	dpage = page_address(page);
+	rb_init_page(dpage);
+
+	return dpage;
+}
+
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
@@ -2243,8 +2278,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 
-		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-				    mflags, cpu_to_node(cpu_buffer->cpu));
+		bpage = alloc_cpu_page(cpu_buffer->cpu);
 		if (!bpage)
 			goto free_pages;
 
@@ -2267,13 +2301,10 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			bpage->range = 1;
 			bpage->id = i + 1;
 		} else {
-			page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-						mflags | __GFP_COMP | __GFP_ZERO,
-						cpu_buffer->buffer->subbuf_order);
-			if (!page)
+			int order = cpu_buffer->buffer->subbuf_order;
+			bpage->page = alloc_cpu_data(cpu_buffer->cpu, order);
+			if (!bpage->page)
 				goto free_pages;
-			bpage->page = page_address(page);
-			rb_init_page(bpage->page);
 		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
 
@@ -2324,14 +2355,13 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
+	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
+		alloc_cpu_buffer(cpu);
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_page *bpage;
 	struct page *page;
 	int ret;
 
-	cpu_buffer = kzalloc_node(ALIGN(sizeof(*cpu_buffer), cache_line_size()),
-				  GFP_KERNEL, cpu_to_node(cpu));
 	if (!cpu_buffer)
 		return NULL;
 
@@ -2347,8 +2377,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
 	mutex_init(&cpu_buffer->mapping_lock);
 
-	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-			    GFP_KERNEL, cpu_to_node(cpu));
+	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
 
@@ -2370,13 +2399,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
 	} else {
-		page = alloc_pages_node(cpu_to_node(cpu),
-					GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
-					cpu_buffer->buffer->subbuf_order);
-		if (!page)
+		int order = cpu_buffer->buffer->subbuf_order;
+		bpage->page = alloc_cpu_data(cpu, order);
+		if (!bpage->page)
 			goto fail_free_reader;
-		bpage->page = page_address(page);
-		rb_init_page(bpage->page);
 	}
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
@@ -6486,22 +6512,16 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
-	if (bpage->data)
-		goto out;
-
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
-				cpu_buffer->buffer->subbuf_order);
-	if (!page) {
-		kfree(bpage);
-		return ERR_PTR(-ENOMEM);
+	if (bpage->data) {
+		rb_init_page(bpage->data);
+	} else {
+		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		if (!bpage->data) {
+			kfree(bpage);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
 
-	bpage->data = page_address(page);
-
- out:
-	rb_init_page(bpage->data);
-
 	return bpage;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
-- 
2.51.0

