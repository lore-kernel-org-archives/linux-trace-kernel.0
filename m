Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBC1DF258;
	Tue,  1 Apr 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544352; cv=none; b=mJrpDcff5eMJGga2Vf5vadu7dyuU9aMS2GjAJk5j9u6wSC+kfMjxqIMpuaQ91OwCwJH9ujbty9GYbJA4rzyds79FKCMNCnKceciq2O6vgsUleehOl0QyX9goHxCoobAcv/oDj6WPX7t307N3WT1RMoyIJZzgFWKDG1g+vx61cRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544352; c=relaxed/simple;
	bh=Iyp390rbcCwAnXTaQmy8r08tCmhbu0jByvK7exZghUU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ajtUZlW+TzxE9iMuHPBrBI1J1AAep7ZYLL0SMFAz8AOmZojZ18X/EvbthMnA2qoJHhqwTTDPbN7TGvakxMEoFuytlmj0AUxg7zs/Qxl/tRzQVlZNxj7TSt0VTa0nDeyb/mPiOMCrZI4Sgx0wwhT8rCPhsmqwUOLMR1sWAfYyjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2349C4CEED;
	Tue,  1 Apr 2025 21:52:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzjY5-00000006Jus-2R6j;
	Tue, 01 Apr 2025 17:53:33 -0400
Message-ID: <20250401215333.427506494@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 17:51:17 -0400
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
Subject: [PATCH v4 2/4] tracing: Have reserve_mem use phys_to_virt() and separate from memmap
 buffer
References: <20250401215115.602501043@goodmis.org>
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
index de9c237e5826..d960f80701bd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8505,6 +8505,10 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct trace_iterator *iter = &info->iter;
 	int ret = 0;
 
+	/* A memmap'ed buffer is not supported for user space mmap */
+	if (iter->tr->flags & TRACE_ARRAY_FL_MEMMAP)
+		return -ENODEV;
+
 	/* Currently the boot mapped buffer is not supported for mmap */
 	if (iter->tr->flags & TRACE_ARRAY_FL_BOOT)
 		return -ENODEV;
@@ -9615,8 +9619,12 @@ static void free_trace_buffers(struct trace_array *tr)
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
@@ -10710,6 +10718,7 @@ static inline void do_allocate_snapshot(const char *name) { }
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
+	bool memmap_area = false;
 	char *curr_str;
 	char *name;
 	char *str;
@@ -10778,6 +10787,7 @@ __init static void enable_instances(void)
 					name);
 				continue;
 			}
+			memmap_area = true;
 		} else if (tok) {
 			if (!reserve_mem_find_by_name(tok, &start, &size)) {
 				start = 0;
@@ -10800,7 +10810,10 @@ __init static void enable_instances(void)
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
@@ -10827,10 +10840,13 @@ __init static void enable_instances(void)
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
index c20f6bcc200a..f9513dc14c37 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -447,6 +447,7 @@ enum {
 	TRACE_ARRAY_FL_BOOT		= BIT(1),
 	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
 	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
+	TRACE_ARRAY_FL_MEMMAP		= BIT(4),
 };
 
 #ifdef CONFIG_MODULES
-- 
2.47.2


