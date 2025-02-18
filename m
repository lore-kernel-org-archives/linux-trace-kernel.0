Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B0269AF4;
	Tue, 18 Feb 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891343; cv=none; b=sBkORgSwAkhCIjSU+1JtYVN0807Mwki+88ktE3p2mTFe6SXgQo6ka+XYWJesYAsHkbt98ve7Fk2Q+DwBMtZlLqame2LU12AjFKC5KfAZOv8dggzqajznfQSQjA0mjXm8bYqzVLg29IwMh6h1e6ABauTIaHivGdWMQgHdMS2nF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891343; c=relaxed/simple;
	bh=8v4zZwccKy+E3kLDMp/TBNu5P5+5ygdWnFUDTOV6vhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqM9m3MU0tBkKEMNGEdRbwUgLcbDoysN5y0yaI0ihX4j7TTFhe5wplrbjc8PkWuhnnXUpsbhK0RxaeFG5KHgO40+ocL91qjV9Ztj6tBbtieJjJ7I3Wl5uYOh4ucE0+3fODi9VCIhfyURYEjGbe7BNiSOrLB5XNI9BBZw9W4tYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6dVhIcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6dVhIcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ADCC4CEE7;
	Tue, 18 Feb 2025 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891342;
	bh=8v4zZwccKy+E3kLDMp/TBNu5P5+5ygdWnFUDTOV6vhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6dVhIcOxjQStAmdg1frwiYYMzwqNWrkW5KnknEwHxn6tpy53X+QuZUBlpcLgZCf1
	 CKEhu0DH9fC/Je+UIYpHOPzeiwPitaHanVUV2TRGiHdKr/MFRFPslLVWDEouuekeZX
	 1PRKaxuasqXI3LWVdzF6hhzr8gJH93z6XH3BwEZEB0FX+PMovWkseGWpUlgTsaX1ZQ
	 ce/usigvzflPg5s2CUSHiT/il3eC3bi6Xw3PXcd+ok8GBdoAez7t5tu9UCAdiAEX43
	 b1t6ue9XccNUA4FWE4IVLXzP5PnCWTOlfmlahs6HObelUFY4EQCD5F8DYhatYhD2Yu
	 YOO2wMctHY73g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH v4 1/2] mm/memblock: Add reserved memory release function
Date: Wed, 19 Feb 2025 00:08:58 +0900
Message-ID: <173989133862.230693.14094993331347437600.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173989132750.230693.15749600013776132201.stgit@devnote2>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 Changes in v4:
  - Use free_reserved_area() according to Mike's comment.
 Changes in v2:
  - Rename reserved_mem_* to reserve_mem_*.
---
 include/linux/mm.h |    1 +
 mm/memblock.c      |   66 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ee9e7447485 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4123,6 +4123,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
+int reserve_mem_release_by_name(const char *name);
 
 #ifdef CONFIG_64BIT
 int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..8cd95f60015d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/mutex.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2283,6 +2284,7 @@ struct reserve_mem_table {
 };
 static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
 static int reserved_mem_count;
+static DEFINE_MUTEX(reserve_mem_lock);
 
 /* Add wildcard region with a lookup name */
 static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
@@ -2296,6 +2298,21 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
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
@@ -2309,22 +2326,47 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
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
+	char buf[RESERVE_MEM_NAME_SIZE + 12];
+	struct reserve_mem_table *map;
+	void *start, *end;
+
+	guard(mutex)(&reserve_mem_lock);
+	map = reserve_mem_find_by_name_nolock(name);
+	if (!map)
+		return 0;
+
+	start = phys_to_virt(map->start);
+	end = start + map->size - 1;
+	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
+	free_reserved_area(start, end, 0, buf);
+	map->size = 0;
+
+	return 1;
+}
+
 /*
  * Parse reserve_mem=nn:align:name
  */

