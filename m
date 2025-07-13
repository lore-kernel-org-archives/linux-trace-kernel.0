Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8F1DA60F;
	Sun, 13 Jul 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391073; cv=none; b=Tb3wzTkGVLiaazVM4Re9UyUhvuuF/q/P4p4GavjdpHoD68vRzD5TF8j+YwijYLTnKSQE8cLSvLv0Rodl51QexFeUqCT8vPzN0r2lPztk0W0FKgdwQu3b8k4N4Y+KxxgrdZA6yni4jw1CVCLs8AYkA8tge0Uh00hpnZw7xkYMxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391073; c=relaxed/simple;
	bh=3dUBpvEhYnlflMVnyRwOxMHiJIQysIRUBLUfy0VHZwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW2SC9mLa5jenSToje3FP0IQMDghomwClQu5tHd1W1hOlquRsoZABSWY7HRffS6/w+99tCdaumuwrvJzcIs919f9I2P3FcqgZYrvwprXcsgKpm5P+SDCsVUVscPAqmDs2SG3NBeqdPZw4x76z4PkZPYcblvov/pwYq3We97Yeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXpza8uf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXpza8uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C6AC4CEF9;
	Sun, 13 Jul 2025 07:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391072;
	bh=3dUBpvEhYnlflMVnyRwOxMHiJIQysIRUBLUfy0VHZwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXpza8uf1fpZTHSm35hPSgJxQLhzXrdXpH/RX0ji3Z1XguEuWUQ9JT/jx8CqQAZEl
	 7HSZz/Iq2CY2Fe1t5oS3TPYKeZ8v93bV5hK4tDYwRl7VVq03+XCmcv89gctSoJ1Vkq
	 QdWcpJsQ5TQZYb23jqSLscMepwHxYvO8QHQI8xQ58e7rTS1wIimyRqgYzrPUKGF54C
	 yBsnVy330Hp7e87+oJuxNp8rPyLFe+43pcFfqiK/hYbpWZv4YjSOfMiR+Usc/aqbQB
	 RPcsI5rnUTl5B/5/al4NEX9Fl5x7Fj3Q5zBaqUSwisYxBQRJHWtLUz8PV56DlAiahL
	 PWlIIXbzMDwkg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 2/8] execmem: introduce execmem_alloc_rw()
Date: Sun, 13 Jul 2025 10:17:24 +0300
Message-ID: <20250713071730.4117334-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713071730.4117334-1-rppt@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Some callers of execmem_alloc() require the memory to be temporarily
writable even when it is allocated from ROX cache. These callers use
execemem_make_temp_rw() right after the call to execmem_alloc().

Wrap this sequence in execmem_alloc_rw() API.

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/alternative.c |  3 +--
 include/linux/execmem.h       | 38 ++++++++++++++++++++---------------
 kernel/module/main.c          | 13 ++----------
 mm/execmem.c                  | 27 ++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ea1d984166cd..526a5fef93ab 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -120,7 +120,7 @@ struct its_array its_pages;
 
 static void *__its_alloc(struct its_array *pages)
 {
-	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+	void *page __free(execmem) = execmem_alloc_rw(EXECMEM_MODULE_TEXT, PAGE_SIZE);
 	if (!page)
 		return NULL;
 
@@ -237,7 +237,6 @@ static void *its_alloc(void)
 	if (!page)
 		return NULL;
 
-	execmem_make_temp_rw(page, PAGE_SIZE);
 	if (pages == &its_pages)
 		set_memory_x((unsigned long)page, 1);
 
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 734fbe83d98e..8b61b05da7d5 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -67,21 +67,6 @@ enum execmem_range_flags {
  */
 void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable);
 
-/**
- * execmem_make_temp_rw - temporarily remap region with read-write
- *			  permissions
- * @ptr:	address of the region to remap
- * @size:	size of the region to remap
- *
- * Remaps a part of the cached large page in the ROX cache in the range
- * [@ptr, @ptr + @size) as writable and not executable. The caller must
- * have exclusive ownership of this range and ensure nothing will try to
- * execute code in this range.
- *
- * Return: 0 on success or negative error code on failure.
- */
-int execmem_make_temp_rw(void *ptr, size_t size);
-
 /**
  * execmem_restore_rox - restore read-only-execute permissions
  * @ptr:	address of the region to remap
@@ -95,7 +80,6 @@ int execmem_make_temp_rw(void *ptr, size_t size);
  */
 int execmem_restore_rox(void *ptr, size_t size);
 #else
-static inline int execmem_make_temp_rw(void *ptr, size_t size) { return 0; }
 static inline int execmem_restore_rox(void *ptr, size_t size) { return 0; }
 #endif
 
@@ -165,6 +149,28 @@ struct execmem_info *execmem_arch_setup(void);
  */
 void *execmem_alloc(enum execmem_type type, size_t size);
 
+/**
+ * execmem_alloc_rw - allocate writable executable memory
+ * @type: type of the allocation
+ * @size: how many bytes of memory are required
+ *
+ * Allocates memory that will contain executable code, either generated or
+ * loaded from kernel modules.
+ *
+ * Allocates memory that will contain data coupled with executable code,
+ * like data sections in kernel modules.
+ *
+ * Forces writable permissions on the allocated memory and the caller is
+ * responsible to manage the permissions afterwards.
+ *
+ * For architectures that use ROX cache the permissions will be set to R+W.
+ * For architectures that don't use ROX cache the default permissions for @type
+ * will be used as they must be writable.
+ *
+ * Return: a pointer to the allocated memory or %NULL
+ */
+void *execmem_alloc_rw(enum execmem_type type, size_t size);
+
 /**
  * execmem_free - free executable memory
  * @ptr: pointer to the memory that should be freed
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea3702..d009326ef7bb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1292,20 +1292,11 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	else
 		execmem_type = EXECMEM_MODULE_TEXT;
 
-	ptr = execmem_alloc(execmem_type, size);
+	ptr = execmem_alloc_rw(execmem_type, size);
 	if (!ptr)
 		return -ENOMEM;
 
-	if (execmem_is_rox(execmem_type)) {
-		int err = execmem_make_temp_rw(ptr, size);
-
-		if (err) {
-			execmem_free(ptr);
-			return -ENOMEM;
-		}
-
-		mod->mem[type].is_rox = true;
-	}
+	mod->mem[type].is_rox = execmem_is_rox(execmem_type);
 
 	/*
 	 * The pointer to these blocks of memory are stored on the module
diff --git a/mm/execmem.c b/mm/execmem.c
index 0712ebb4eb77..6b040fbc5f4f 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -336,7 +336,7 @@ static bool execmem_cache_free(void *ptr)
 	return true;
 }
 
-int execmem_make_temp_rw(void *ptr, size_t size)
+static int execmem_force_rw(void *ptr, size_t size)
 {
 	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long addr = (unsigned long)ptr;
@@ -358,6 +358,16 @@ int execmem_restore_rox(void *ptr, size_t size)
 }
 
 #else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
+/*
+ * when ROX cache is not used the permissions defined by architectures for
+ * execmem ranges that are updated before use (e.g. EXECMEM_MODULE_TEXT) must
+ * be writable anyway
+ */
+static inline int execmem_force_rw(void *ptr, size_t size)
+{
+	return 0;
+}
+
 static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 {
 	return NULL;
@@ -387,6 +397,21 @@ void *execmem_alloc(enum execmem_type type, size_t size)
 	return kasan_reset_tag(p);
 }
 
+void *execmem_alloc_rw(enum execmem_type type, size_t size)
+{
+	void *p __free(execmem) = execmem_alloc(type, size);
+	int err;
+
+	if (!p)
+		return NULL;
+
+	err = execmem_force_rw(p, size);
+	if (err)
+		return NULL;
+
+	return no_free_ptr(p);
+}
+
 void execmem_free(void *ptr)
 {
 	/*
-- 
2.47.2

