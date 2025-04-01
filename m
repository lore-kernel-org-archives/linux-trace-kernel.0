Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC120E32B;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539550; cv=none; b=EOglPOhRwRiDDv5pwXehJl0Ylo5mWv4UkhhA+tKVtJARqhEvvvYKhTj1AfzWt00CI1HmThuUXq9DOM1jqcjD5xbXHTmjb4A1j4kGiR6yyJX3VpBWjzuy8h5z8D6NZgN7Hg6Ly8HEHo7E79aQJ5rNc7juAxR8fpdoHV5BNwl/AMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539550; c=relaxed/simple;
	bh=ZFM9eZYL0PvWeKjx6LDsMsM3kKFi6vLW7UHPBAVvvts=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a5h5y52L4b7xTkimNULRA/OGCtdvnVheWds3W0vzw9jlji2h5kn7TjK/9J08kWFeD2tRClir0F5tBv6PbKKKoHrH80vTu2VkavFYYMZqxDCTACr2lVLMxTDU9tH9ec7FDrTXOxuVFzlgB+z5iO7uhX2KJ7e6RRnZv3JCYhBLv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521E6C4CEF1;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tziIe-00000006IeK-0CvO;
	Tue, 01 Apr 2025 16:33:32 -0400
Message-ID: <20250401203331.901028151@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 16:25:52 -0400
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
Subject: [PATCH v3 3/5] tracing: Use vmap_page_range() to map memmap ring buffer
References: <20250401202549.409271454@goodmis.org>
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
 kernel/trace/trace.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e33f3b092e2e..1d7d2b772a74 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -50,6 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 #include <linux/sort.h>
+#include <linux/io.h> /* vmap_page_range() */
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -9803,29 +9804,27 @@ static int instance_mkdir(const char *name)
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
+        unsigned long vmap_start, vmap_end;
+	struct vm_struct *area;
+	int ret;
 
-	page_count = DIV_ROUND_UP(size, PAGE_SIZE);
+        area = get_vm_area(size, VM_IOREMAP);
+        if (!area)
+                return 0;
 
-	page_start = start;
-	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return 0;
+        vmap_start = (unsigned long) area->addr;
+        vmap_end = vmap_start + size;
 
-	for (i = 0; i < page_count; i++) {
-		phys_addr_t addr = page_start + i * PAGE_SIZE;
-		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
-	}
-	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
-	kfree(pages);
+        ret = vmap_page_range(vmap_start, vmap_end,
+			      start, pgprot_nx(PAGE_KERNEL));
+        if (ret < 0) {
+                free_vm_area(area);
+                return 0;
+        }
 
-	return (u64)(unsigned long)vaddr;
+	return (u64)vmap_start;
 }
 
 /**
-- 
2.47.2


