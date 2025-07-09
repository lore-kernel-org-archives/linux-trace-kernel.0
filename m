Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EEBE4A;
	Wed,  9 Jul 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068995; cv=none; b=jXONs44nHXuisG7NytNSEBn0/5bFDBvfv7f/a2oW6v3xngEWiMAk6Yvp5AkWIO3e/uvSWwsP7Aa7WQ+GUm4peXStGwTU+D9Qoi1ucRX4zGyNhqwXCN516azsLEq9sbNeLrPjHywWFR3vcM+Ujv2yH7xKrvpghfRRBDF722SsUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068995; c=relaxed/simple;
	bh=NrvBoIv7ihWz3msr5ucNgQMNcZ4XLlRn/Kum2bPi/3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPxgNe3WOG1K/0lO+LKuN3G6ZwFF9OD3xwTzv4xG9o2HNcDa+FnASRibTtbVTyaAie24ZCPrJlBwUgtikDgQVgzeObFiVSKSH2inBHhIs7WmS9jwtMsyG+L2jNJHWTcbUKNleuW4PATyCbyxCCqfuiwwoCZTaYVlxi0KZ2ZLJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCHSnLqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCHSnLqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE75C4CEF1;
	Wed,  9 Jul 2025 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068994;
	bh=NrvBoIv7ihWz3msr5ucNgQMNcZ4XLlRn/Kum2bPi/3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCHSnLqs7TP//QU/xFeQP80uOujzFdZryawOScaDjys/43cMqUe5rrA2XhVwuKD87
	 sozc0iIvGcC+JWZH3v5hhw/4Ikzi4tEPEJCcmgcYSZHIM4lSwKwlgwP3jDg1wBfuXh
	 vKUpr7j9ezdow7SFhsBAkH4XFm6/mFvx0l0S7IdPjkVf+n2nH8ENgo0TG2Y/5uQuH/
	 mo9kyqWkxt8g5jOkzUN1HNEpo5WmwSV1vaMJ3ZHxnTl2HRoaPJ5lNwCBBRRoo4+kVX
	 axpQGPmKUQCHlRxYAOEmpQLfllXL7DKKk1bqcS6xkjMPjZrkHz0v/vUylwkNEVIynF
	 E8N7WxdsnKOJQ==
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
Subject: [PATCH v2 2/8] execmem: introduce execmem_alloc_rw()
Date: Wed,  9 Jul 2025 16:49:27 +0300
Message-ID: <20250709134933.3848895-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
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
index 734fbe83d98e..4e510d1c609c 100644
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
+ * execmem_alloc_rw - allocate writatble executable memory
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

