Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC731A808;
	Tue, 25 Nov 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090677; cv=none; b=uF58FDMjObbIFVeFyof+Fdi28mOlD1GcM3BeEwh+uQVFxdpG/OPgzgG4qcB4r07RrRrXK69EEYoD/FpldFdCvAnLi/jN/zXGW3OhPMj2cN4zT/yiyOjlbtonbWXVylFcgJbN6cfmNkyyiLY5nJHrv2wCItKcJawd2j/80pEYhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090677; c=relaxed/simple;
	bh=8BelYeXi5kx6IRgaKaF5XwGicTK5GLEpnV3B0KEKnpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LknkWSBPQYLtR/G8HhyXbDFOQN0ZvLjZvKobJRtfMcqAfPPubtCE1jTj3rcqQOroQUgBMQwrXFkfrdUL2rfk6VRO0vvUJ11OpfRqZ7etie8wWx/quhOhb621UN4iq943nx4+AER+yHwOVr5JPPF5WW8YezQ1WrbDoFUft9efDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 6B03FB835C;
	Tue, 25 Nov 2025 17:11:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id A980340;
	Tue, 25 Nov 2025 17:11:09 +0000 (UTC)
Date: Tue, 25 Nov 2025 12:11:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH v2] ring-buffer: Add helper functions for allocations
Message-ID: <20251125121153.35c07461@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A980340
X-Stat-Signature: r1ezct79uyoiitigncop64wenam8ziy3
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/aeUEsXBcpty1luRX37bFDeSrN/hyyCY8=
X-HE-Tag: 1764090669-783161
X-HE-Meta: U2FsdGVkX1/VTKnHqI+1lf4IKDcq30RyA4PEKMUw4/Hha8EmsG1DxHAeQ60FSZddzcCFX9QETjoVBITTMf+JMx7JtjxesUBDCtKq7yM6FJgeW+cmaDP0qSJb9Nr0ahzbOug3KFb+oAlSbJiPTnOw4I2zCQovNEbadpYLi6DYF26G+vyMY/6WqxoYKP95lr+z3PAxHR0dIQFkCw/lMO2apciFwWa8yj/SoA/zpnQQ2q+9Veu66KqUIdyHvjqXtF1k7UVeIxpnWEdceu0GaFJo3xFv/oSOrFe4vYIdrh5lfS6YiWsLKL9KEHrGGD2H+E1ZOVU37Zr7oNsFdONh5L4y1gbKUVBF30i9pDdoNCJP2ZQbbKv/9sTlmqCBhA5iNn8yGR64rloMhpVBTlYLG+SNjalGlhvDp21yJrSl1yaiGJzqDPYz5xENPQZaHcz24b2PDy6pClLI9IN1f5isCNZzYP4d8Z6MmZASJgx8BDDAS46BcZDy/0pYxZr2fqqjyK4iyul8Ot+TjgTKzbTS2egCcZF9vv8sU8O4ixHBI4IJJ9U4ggtDkL3cYcIc/eTUUE4/

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
Changes since v1: https://patch.msgid.link/20251124140906.71a2abf6@gandalf.local.home

- Removed set but unused variables (kernel test robot)

 kernel/trace/ring_buffer.c | 97 +++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..6295443b0944 100644
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
@@ -2204,7 +2239,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	struct ring_buffer_cpu_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
-	gfp_t mflags;
 	long i;
 
 	/*
@@ -2218,13 +2252,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	if (i < nr_pages)
 		return -ENOMEM;
 
-	/*
-	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
-	 * gracefully without invoking oom-killer and the system is not
-	 * destabilized.
-	 */
-	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
-
 	/*
 	 * If a user thread allocates too much, and si_mem_available()
 	 * reports there's enough memory, even though there is not.
@@ -2241,10 +2268,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *page;
 
-		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-				    mflags, cpu_to_node(cpu_buffer->cpu));
+		bpage = alloc_cpu_page(cpu_buffer->cpu);
 		if (!bpage)
 			goto free_pages;
 
@@ -2267,13 +2292,10 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
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
 
@@ -2324,14 +2346,12 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
+	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
+		alloc_cpu_buffer(cpu);
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_page *bpage;
-	struct page *page;
 	int ret;
 
-	cpu_buffer = kzalloc_node(ALIGN(sizeof(*cpu_buffer), cache_line_size()),
-				  GFP_KERNEL, cpu_to_node(cpu));
 	if (!cpu_buffer)
 		return NULL;
 
@@ -2347,8 +2367,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
 	mutex_init(&cpu_buffer->mapping_lock);
 
-	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-			    GFP_KERNEL, cpu_to_node(cpu));
+	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
 
@@ -2370,13 +2389,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
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
@@ -6464,7 +6480,6 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
-	struct page *page;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
@@ -6486,22 +6501,16 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
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

