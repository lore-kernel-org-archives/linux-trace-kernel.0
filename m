Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80422D4C7;
	Tue, 11 Feb 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285228; cv=none; b=f+cL1vloZ3bkvX+RJXQ5UfuzypMaBEgKoyE8v2yw6leKsHPbPSbB3bfyFeLwjCKE9E0DA9Rl+Fo+5lwio8ZVhLOOY7o2LqTI/iHVdXNhqC3z1adn/VUbL68nNLj5ZUND+N0IpMdeiVfFALlnb3tMvRnJj/0oNatkS7kjvGzkw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285228; c=relaxed/simple;
	bh=DMViBbSOugoNjsJLF18TFotJSuIP9xNSW1tu6G2Q2rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZkR2BGwPxFh31rT5f9xeA7rSSGr+kofviQAefsoCcUReBmuS89SDvt3N/CcOKR9FDoQU8xoi6bpMc/dPqZLIxMp0Ct3CETqBgoGqfpXZHRaoSFTr8P4N9rKWO2xofFQr9kGQ/EtV6Re2Xjwkk70C9ppbbia7gYBR42Oj9AnZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR3a101D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR3a101D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EEDC4CEDD;
	Tue, 11 Feb 2025 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739285227;
	bh=DMViBbSOugoNjsJLF18TFotJSuIP9xNSW1tu6G2Q2rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LR3a101DC/gAO4T26kfswaxUVnDf3Es4g2pAvrIR2JMbbjf3Sh62GeaROYo0Ys56Q
	 ZMoyFhd4L03fyzkJsmdoWQEJ4hNuCcixZrm0OFa+879ee8FrODkdN0hlYBbEGu/Eko
	 E9inHT440sirJCYY4NJHcSg7NZJHhmJUPcvN8rMfV0apPLX25+wtd55aQ9j2q5O6TR
	 bOqBX8wosx0a+prj0Ijl+jNoEZouJPgSNpIF9ayN3P2IlzgR5ArdFf1th0COxBG77m
	 ijH7oErqwqU7Qp2s257ZlKUx/SElB5PvTyiUZigNN9gX9Z/EVHI9meDm7LnnJ1XXdv
	 r6muUu53zVhKw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/2] mm/memblock: Add reserved memory release function
Date: Tue, 11 Feb 2025 23:47:03 +0900
Message-ID: <173928522350.906035.5626965043208329135.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173928521419.906035.17750338150436695675.stgit@devnote2>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add reserve_mem_release_by_name() to release a reserved memory region
with a given name. This allows us to release reserved memory which is
defined by kernel cmdline, after boot.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
---
 Changes in v2:
  - Rename reserved_mem_* to reserve_mem_*.
---
 include/linux/mm.h |    1 +
 mm/memblock.c      |   72 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f02925447e59..fe5f7711df04 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4197,6 +4197,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
+int reserve_mem_release_by_name(const char *name);
 
 #ifdef CONFIG_64BIT
 int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
diff --git a/mm/memblock.c b/mm/memblock.c
index 095c18b5c430..c8d207ebb93c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/mutex.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2263,6 +2264,7 @@ struct reserve_mem_table {
 };
 static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
 static int reserved_mem_count;
+static DEFINE_MUTEX(reserve_mem_lock);
 
 /* Add wildcard region with a lookup name */
 static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
@@ -2276,6 +2278,21 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 	strscpy(map->name, name);
 }
 
+static struct reserve_mem_table *reserve_mem_find_by_name_nolock(const char *name)
+{
+	struct reserve_mem_table *map;
+	int i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		map = &reserved_mem_table[i];
+		if (!map->size)
+			continue;
+		if (strcmp(name, map->name) == 0)
+			return map;
+	}
+	return NULL;
+}
+
 /**
  * reserve_mem_find_by_name - Find reserved memory region with a given name
  * @name: The name that is attached to a reserved memory region
@@ -2289,22 +2306,53 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
 {
 	struct reserve_mem_table *map;
-	int i;
 
-	for (i = 0; i < reserved_mem_count; i++) {
-		map = &reserved_mem_table[i];
-		if (!map->size)
-			continue;
-		if (strcmp(name, map->name) == 0) {
-			*start = map->start;
-			*size = map->size;
-			return 1;
-		}
-	}
-	return 0;
+	guard(mutex)(&reserve_mem_lock);
+	map = reserve_mem_find_by_name_nolock(name);
+	if (!map)
+		return 0;
+
+	*start = map->start;
+	*size = map->size;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
+/**
+ * reserve_mem_release_by_name - Release reserved memory region with a given name
+ * @name: The name that is attatched to a reserved memory region
+ *
+ * Forcibly release the pages in the reserved memory region so that those memory
+ * can be used as free memory. After released the reserved region size becomes 0.
+ *
+ * Returns: 1 if released or 0 if not found.
+ */
+int reserve_mem_release_by_name(const char *name)
+{
+	struct reserve_mem_table *map;
+	unsigned int page_count;
+	phys_addr_t start;
+
+	guard(mutex)(&reserve_mem_lock);
+	map = reserve_mem_find_by_name_nolock(name);
+	if (!map)
+		return 0;
+
+	start = map->start;
+	page_count = DIV_ROUND_UP(map->size, PAGE_SIZE);
+
+	for (int i = 0; i < page_count; i++) {
+		phys_addr_t addr = start + i * PAGE_SIZE;
+		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
+
+		page->flags &= ~BIT(PG_reserved);
+		__free_page(page);
+	}
+	map->size = 0;
+
+	return 1;
+}
+
 /*
  * Parse reserve_mem=nn:align:name
  */

