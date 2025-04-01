Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41F219306;
	Tue,  1 Apr 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548261; cv=none; b=ZIG3JCs3MZJLAe26r1tCE5vjPXw5VzTrojtvqB8cvTmgKAOCc4d/ThqPPa/JXFeEWLRI5ZwSpDQ9rsNSbwHoq2Y2QG+siMR8hEOlspURYCjykUL3HZ+lYnefb1+Z/lIhfIzrfZZB5TDEZtyyr6pTv/K4QEomqXE9jFsLXn6gi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548261; c=relaxed/simple;
	bh=XYlOBYSIYETSQDHzjhTSckqROknCCMTut+9+C8IhgSs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZRcl0mvp0EjzivOxXpntpn6kcpHE1JgMRK/3gCDEBgAWoPLIhu6nuGKLE0pLEtxjceGpdYe5+zPjL6Bx0rMOwA9V0lgRicXh9DTGLKhlFGEUKjA+fMlimb20bMTuv8KwoYvks+x/zhugTf78Qmgz71nUs9wRBNJct4DC2Jt9POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC931C4CEE8;
	Tue,  1 Apr 2025 22:57:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzkZ8-00000006KZk-38t4;
	Tue, 01 Apr 2025 18:58:42 -0400
Message-ID: <20250401225842.597899085@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 18:58:14 -0400
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
Subject: [PATCH v5 3/4] tracing: Use vmap_page_range() to map memmap ring buffer
References: <20250401225811.008143218@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code to map the physical memory retrieved by memmap currently
allocates an array of pages to cover the physical memory and then calls
vmap() to map it to a virtual address. Instead of using this temporary
array of struct page descriptors, simply use vmap_page_range() that can
directly map the contiguous physical memory to a virtual address.

Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2f9c91f26d5b..e30d1e058fea 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -50,6 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 #include <linux/sort.h>
+#include <linux/io.h> /* vmap_page_range() */
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -9810,29 +9811,27 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
-static u64 map_pages(u64 start, u64 size)
+static u64 map_pages(unsigned long start, unsigned long size)
 {
-	struct page **pages;
-	phys_addr_t page_start;
-	unsigned int page_count;
-	unsigned int i;
-	void *vaddr;
-
-	page_count = DIV_ROUND_UP(size, PAGE_SIZE);
+	unsigned long vmap_start, vmap_end;
+	struct vm_struct *area;
+	int ret;
 
-	page_start = start;
-	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
 		return 0;
 
-	for (i = 0; i < page_count; i++) {
-		phys_addr_t addr = page_start + i * PAGE_SIZE;
-		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	vmap_start = (unsigned long) area->addr;
+	vmap_end = vmap_start + size;
+
+	ret = vmap_page_range(vmap_start, vmap_end,
+			      start, pgprot_nx(PAGE_KERNEL));
+	if (ret < 0) {
+		free_vm_area(area);
+		return 0;
 	}
-	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
-	kfree(pages);
 
-	return (u64)(unsigned long)vaddr;
+	return (u64)vmap_start;
 }
 
 /**
-- 
2.47.2


