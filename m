Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F823BFA6;
	Wed,  2 Apr 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605330; cv=none; b=V0geR+TeYwna4ZTpklEgPa4iRspCA7h9dl+m1e1Sksxz7jtJ08mB0H5xzJR4jDj/hU9D2y8OoMTZwsLQztMG1z81LvsuEt0fgZG73KWK8yEZ8t9+5BevCZ2SBw1a7afXOXEAE/0f+HelgQNhx/Ih8T/8TEYChBrQvPTgv7nCNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605330; c=relaxed/simple;
	bh=NkrZFm87HlJc8esdzVgQ3RER7T9L0z8JKggbOBdeFdM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=U9ejObsTA+ZVusXskZGNM1gSjj2SDQeexskO/PIHiirpPLmIAif2h0VxaRVvq5YenNPby24q44QkLxCCun63ejIAehOsMBeCk8sUIDPgUDEtu+IiVJXzsv27xH+cwtjykpw6ryrKlL37W810lOSSEkZvT8V8r5GgH/CTGcaJTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395BFC4CEE7;
	Wed,  2 Apr 2025 14:48:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzzPd-00000006SOe-3520;
	Wed, 02 Apr 2025 10:49:53 -0400
Message-ID: <20250402144953.583750106@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 02 Apr 2025 10:49:05 -0400
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
Subject: [PATCH v6 2/4] tracing: Have reserve_mem use phys_to_virt() and separate from memmap
 buffer
References: <20250402144903.993276623@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The reserve_mem kernel command line option may pass back a physical
address, but the memory is still part of the normal memory just like
using memblock_alloc() would be. This means that the physical memory
returned by the reserve_mem command line option can be converted directly
to virtual memory by simply using phys_to_virt().

When freeing the buffer there's no need to call vunmap() anymore as the
memory allocated by reserve_mem is freed by the call to
reserve_mem_release_by_name().

Because the persistent ring buffer can also be allocated via the memmap
option, which *is* different than normal memory as it cannot be added back
to the buddy system, it must be treated differently. It still needs to be
virtually mapped to have access to it. It also can not be freed nor can it
ever be memory mapped to user space.

Create a new trace_array flag called TRACE_ARRAY_FL_MEMMAP which gets set
if the buffer is created by the memmap option, and this will prevent the
buffer from being memory mapped by user space.

Also increment the ref count for memmap'ed buffers so that they can never
be freed.

Link: https://lore.kernel.org/all/Z-wFszhJ_9o4dc8O@kernel.org/

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/linux-trace-kernel/20250401225842.429332654@goodmis.org/

- Updated change log to use memblock_alloc() instead of memblock_reserve()
  (Mike Rapoport)

 kernel/trace/trace.c | 23 ++++++++++++++++-------
 kernel/trace/trace.h |  1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 96129985e81c..e58b72e61573 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8492,6 +8492,10 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
+	/* A memmap'ed buffer is not supported for user space mmap */
+	if (iter->tr->flags & TRACE_ARRAY_FL_MEMMAP)
+		return -ENODEV;
+
 	/* Currently the boot mapped buffer is not supported for mmap */
 	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
 		return -ENODEV;
@@ -9600,9 +9604,6 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
-
-	if (tr->range_addr_start)
-		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -10696,6 +10697,7 @@ static inline void do_allocate_snapshot(const char *name) { }
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
+	bool memmap_area = false;
 	char *curr_str;
 	char *name;
 	char *str;
@@ -10764,6 +10766,7 @@ __init static void enable_instances(void)
 					name);
 				continue;
 			}
+			memmap_area = true;
 		} else if (tok) {
 			if (!reserve_mem_find_by_name(tok, &start, &size)) {
 				start = 0;
@@ -10784,7 +10787,10 @@ __init static void enable_instances(void)
 				continue;
 			}
 
-			addr = map_pages(start, size);
+			if (memmap_area)
+				addr = map_pages(start, size);
+			else
+				addr = (unsigned long)phys_to_virt(start);
 			if (addr) {
 				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
 					name, &start, (unsigned long)size);
@@ -10811,10 +10817,13 @@ __init static void enable_instances(void)
 			update_printk_trace(tr);
 
 		/*
-		 * If start is set, then this is a mapped buffer, and
-		 * cannot be deleted by user space, so keep the reference
-		 * to it.
+		 * memmap'd buffers can not be freed.
 		 */
+		if (memmap_area) {
+			tr->flags |= TRACE_ARRAY_FL_MEMMAP;
+			tr->ref++;
+		}
+
 		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
 			tr->range_name = no_free_ptr(rname);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ab7c7a1930cc..9d9dcfad6269 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -446,6 +446,7 @@ enum {
 	TRACE_ARRAY_FL_BOOT		= BIT(1),
 	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
 	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
+	TRACE_ARRAY_FL_MEMMAP		= BIT(4),
 };
 
 #ifdef CONFIG_MODULES
-- 
2.47.2


