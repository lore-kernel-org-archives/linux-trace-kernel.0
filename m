Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31F1DF980;
	Tue, 27 May 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748370648; cv=none; b=vCpMj7ZZTUtEQ+FZzUOtFMnCLbkwatV7955I4DjfGxWVmIb2kHjhdDrYfp35F+2uH11cKkzQaZNM8qApgM2c1avEAFcNrsJt+jNl1KVQYcnywMRwyL+EOVp3OPb6Q1LE/ruIdMIMQ4n4HfK+FaCjOv4Na9CDCzYsKySMwA+NWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748370648; c=relaxed/simple;
	bh=GEDIbhORhKep+1g5usIwwVHueluWRim6spHM5BBG+Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e7IhGUugenWzHYdY4q5xz+HQ05CcVyjqPCtpL8Xxym9TkAQvAMrIWsiuUzDzV8hKW4xUc8929EBjNh2CRwCa1SJVLLidYAq6YGA3/H7wEuG5rmF2/HtLBNOghbBCB1e1JR3+TVQbvy8XPoOqkNlcdIkn3l/KaaY17O2qrR2HPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84256C4CEE9;
	Tue, 27 May 2025 18:30:47 +0000 (UTC)
Date: Tue, 27 May 2025 14:31:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Simplify functions with __free(kfree) to free
 allocations
Message-ID: <20250527143144.6edc4625@gandalf.local.home>
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

The function rb_allocate_pages() allocates cpu_buffer and on error needs
to free it. It has a single return. Use __free(kfree) and return directly
on errors and have the return use return_ptr(cpu_buffer).

The function alloc_buffer() allocates buffer and on error needs to free
it. It has a single return. Use __free(kfree) and return directly on
errors and have the return use return_ptr(buffer).

The function __rb_map_vma() allocates a temporary array "pages". Have it
use __free() and not worry about freeing it when returning.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f3aa18c89166..10a4b26929ae 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2226,7 +2226,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) = NULL;
 	struct ring_buffer_cpu_meta *meta;
 	struct buffer_page *bpage;
 	struct page *page;
@@ -2252,7 +2252,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
 	if (!bpage)
-		goto fail_free_buffer;
+		return NULL;
 
 	rb_check_bpage(cpu_buffer, bpage);
 
@@ -2318,13 +2318,11 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		rb_head_page_activate(cpu_buffer);
 	}
 
-	return cpu_buffer;
+	return_ptr(cpu_buffer);
 
  fail_free_reader:
 	free_buffer_page(cpu_buffer->reader_page);
 
- fail_free_buffer:
-	kfree(cpu_buffer);
 	return NULL;
 }
 
@@ -2359,7 +2357,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 unsigned long scratch_size,
 					 struct lock_class_key *key)
 {
-	struct trace_buffer *buffer;
+	struct trace_buffer *buffer __free(kfree) = NULL;
 	long nr_pages;
 	int subbuf_size;
 	int bsize;
@@ -2373,7 +2371,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		return NULL;
 
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
-		goto fail_free_buffer;
+		return NULL;
 
 	buffer->subbuf_order = order;
 	subbuf_size = (PAGE_SIZE << order);
@@ -2472,7 +2470,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
-	return buffer;
+	return_ptr(buffer);
 
  fail_free_buffers:
 	for_each_buffer_cpu(buffer, cpu) {
@@ -2484,8 +2482,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
  fail_free_cpumask:
 	free_cpumask_var(buffer->cpumask);
 
- fail_free_buffer:
-	kfree(buffer);
 	return NULL;
 }
 
@@ -7076,7 +7072,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
-	struct page **pages;
+	struct page **pages __free(kfree) = NULL;
 	int p = 0, s = 0;
 	int err;
 
@@ -7144,10 +7140,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 		struct page *page;
 		int off = 0;
 
-		if (WARN_ON_ONCE(s >= nr_subbufs)) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (WARN_ON_ONCE(s >= nr_subbufs))
+			return -EINVAL;
 
 		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 
@@ -7162,9 +7156,6 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 
 	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
 
-out:
-	kfree(pages);
-
 	return err;
 }
 #else
-- 
2.47.2

