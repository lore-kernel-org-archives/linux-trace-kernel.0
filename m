Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5630205F;
	Fri,  4 Jul 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637004; cv=none; b=X4XZIUoaw67DtMDntP+Zi+H55jMEwmmdpVWoP9+BYHwwBmKU7w9auCKwuVXoti3YMBqgGbu9hzTvBanfxMIXPyATEWXnz0C7yYHWdBVdn4RHEqeHgo7wLI61OiHnxz3Zdly+HbQTaXsEikr/p0H9JVgEaXwcn882h7R7gJS2dvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637004; c=relaxed/simple;
	bh=NrvBoIv7ihWz3msr5ucNgQMNcZ4XLlRn/Kum2bPi/3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO6REvpDUpqDvRNVEyvCgKNgknQkduGgL+a3TcuS+eYtGHs9dhMoxX/pmA/XWgQLQho0n0Xjscb9hAd3JPFlAG0yX2J+ske9cMcgy/j4nlKI4xU9RB0QmyYhP8Ft67yWXokRlelgEGHGQk5KOdoYl1lyUGcGBQMnnyMNo8autZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du9mSzGa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du9mSzGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C19C4CEE3;
	Fri,  4 Jul 2025 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637003;
	bh=NrvBoIv7ihWz3msr5ucNgQMNcZ4XLlRn/Kum2bPi/3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=du9mSzGaCObmMu4AJfvOoggVAr+IvAH88kHSLClKN/Mfwta17SYcXTn/8LmevqoGx
	 AcvO1HVvuNnHtYa2S3cTeJpP/UAadzyjKs+bueQhrshFpa73GQXfrPqjv/3xZAl5oJ
	 ZuHXPvfRdopM8RuzgkMy1C4gekeUHMofMNM79RXoQkBZ19n34qDLy1rE3DU/u18JZ9
	 ajmTCNtxJpyfh9oBrBWU0N1CsaKDxgBBnnqkQUC5tMFeaaxSfXsni9oXxgiycthABl
	 whmMPdoAKby8UIZBKLXZUi6axYTd9YPeIGG9ZyGSxn9RkmCzQgrPDQawnEKDvsGZVC
	 0+BAZ5kPr6WrA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/8] execmem: introduce execmem_alloc_rw()
Date: Fri,  4 Jul 2025 16:49:37 +0300
Message-ID: <20250704134943.3524829-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704134943.3524829-1-rppt@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
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

