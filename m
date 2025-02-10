Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510624BD0E;
	Mon, 10 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202252; cv=none; b=d4j+ZYl7qjCiTWOzFjjMZZym5OnPsihHeua4d2UzR30DVwQT3aZlDZ8wqKpCAUSwmB9zWoWmmCmkRg3wRv0P8imNKGNLZC/F/dJwzLXNTYKQhPdG9oZnL409RSLqyB5V5UsHv/yYq7IkOo13G3VrqOfYIewpT6IOi59FGrYahpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202252; c=relaxed/simple;
	bh=6yj73383fNCr7f3+rQlSRto99A/AVeQ+lfiwks1wc1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoBctGV0lfjXfK8u+QZUs8bM+zQ6cuevCOsE0X5TlpLcC2q8db6sOIabJvSkaXmvGef//9dcIxuYYMGkod42QC5/eM7zRR3YXBuCYmKbN6EFDkZCyT0pRn+2KZzIG4JxXY8Eauqwo6OEHQ5ydEA5guDW+7uRLFnnfeKIlnvF0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVQjzbui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVQjzbui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7355FC4CEDF;
	Mon, 10 Feb 2025 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739202252;
	bh=6yj73383fNCr7f3+rQlSRto99A/AVeQ+lfiwks1wc1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVQjzbuiVX3bd/a9qyUKCfAl7FY/FkNbIseS22+tBhIl1/aEywAP5m85vcM+8HAzT
	 4DXgBPuBrTItQWgQRC4sS6jPECS7JsR3y4C41OckduwvlKztIDYjkhYZyRXcPkP2bE
	 Pb5RsaKx2hkB2bSlX6ilS2BfD9aGOhWoIMct3btFgHdpw+0VZW70zQBmIucP7rvGA0
	 eXG+oRkcrlSfc8uwB/qvtboRB/XEB8bJASqeyT0kiOQyWHD9hgg1paTvUViUf5RNXM
	 85cKP28li5M+4VW3rjU4qnj0MtPl5/nRaBzoIInZ2dihqJNwgjrwRDLwqf9tDPuUsr
	 3n9DG/oqGmy6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 2/3] mm/memblock: Add reserved memory release function
Date: Tue, 11 Feb 2025 00:44:08 +0900
Message-ID: <173920224789.826592.13627374781649157364.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173920222697.826592.3726270716809214055.stgit@devnote2>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
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

Add reserved_mem_release_by_name() to release a reserved memory region
with a given name. This allows us to release reserved memory which is
defined by kernel cmdline, after boot.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/mm.h |    1 +
 mm/memblock.c      |   72 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f02925447e59..a7201824c1fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4197,6 +4197,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
+int reserved_mem_release_by_name(const char *name);
 
 #ifdef CONFIG_64BIT
 int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
diff --git a/mm/memblock.c b/mm/memblock.c
index 095c18b5c430..9962fbb90597 100644
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
+static DEFINE_MUTEX(reserved_mem_lock);
 
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
+	guard(mutex)(&reserved_mem_lock);
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
+ * reserved_mem_release_by_name - Release reserved memory region with a given name
+ * @name: The name that is attatched to a reserved memory region
+ *
+ * Forcibly release the pages in the reserved memory region so that those memory
+ * can be used as free memory. After released the reserved region size becomes 0.
+ *
+ * Returns: 1 if released or 0 if not found.
+ */
+int reserved_mem_release_by_name(const char *name)
+{
+	struct reserve_mem_table *map;
+	unsigned int page_count;
+	phys_addr_t start;
+
+	guard(mutex)(&reserved_mem_lock);
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

