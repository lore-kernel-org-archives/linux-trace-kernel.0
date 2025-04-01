Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5720C002;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539550; cv=none; b=RKxCS7KhNkPOjE5Rf/e8pXVbnnDPONXCvG8tGJMgGAUXykFT0WmnpTdXMYICmX4M4R8URRaPw4KF1uSHGwh1W6E9EI90YIGwm3m7A4J9hFOj/tnLRNQvWc2a4YfZBUl1FxHUIvkKC/+Fn+FZfLDsEz/C61jlLLe+PIpskNIytqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539550; c=relaxed/simple;
	bh=eWruYTEMFqsg9MgWbzhFWe9qMXUyoTYzvL3kERLjFFU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uaEkP320qQ+pbdC8OMJF99ipun1+6jocmMzePq4ZavxZHA2u/PcS3PivTv+N+Sj/NsCyluQpIFmDTCz1zNIJFF2OPBi/PWzAqpUMpsGWGu+DkRN1XQx7JRQkrIbNWfEBSFBVJYNzD/NaSSBDB4oyNCF5CQuLqyxwb1T4W8bahFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F91C4CEED;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tziId-00000006Ido-3guf;
	Tue, 01 Apr 2025 16:33:31 -0400
Message-ID: <20250401203331.728113626@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 16:25:51 -0400
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
Subject: [PATCH v3 2/5] tracing: Have reserve_mem use phys_to_virt() and separate from memmap
 buffer
References: <20250401202549.409271454@goodmis.org>
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
using memblock_reserve() would be. This means that the physical memory
returned by the reserve_mem command line option can be converted directly
to virtual memory by simply using phys_to_virt().

When freeing the buffer allocated by reserve_mem, use free_reserved_area().

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
 kernel/trace/trace.c | 28 ++++++++++++++++++++++------
 kernel/trace/trace.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1288e0aaadf8..e33f3b092e2e 100644
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
@@ -9601,8 +9605,12 @@ static void free_trace_buffers(struct trace_array *tr)
 	free_trace_buffer(&tr->max_buffer);
 #endif
 
-	if (tr->range_addr_start)
-		vunmap((void *)tr->range_addr_start);
+	if (tr->range_addr_start) {
+		void *start = (void *)tr->range_addr_start;
+		void *end = start + tr->range_addr_size;
+
+		free_reserved_area(start, end, 0, tr->range_name);
+	}
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -10696,6 +10704,7 @@ static inline void do_allocate_snapshot(const char *name) { }
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
+	bool memmap_area = false;
 	char *curr_str;
 	char *name;
 	char *str;
@@ -10764,6 +10773,7 @@ __init static void enable_instances(void)
 					name);
 				continue;
 			}
+			memmap_area = true;
 		} else if (tok) {
 			if (!reserve_mem_find_by_name(tok, &start, &size)) {
 				start = 0;
@@ -10786,7 +10796,10 @@ __init static void enable_instances(void)
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
@@ -10813,10 +10826,13 @@ __init static void enable_instances(void)
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


