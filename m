Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30D7E0F0;
	Wed, 22 May 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364370; cv=none; b=VgCa33IE1UfarLA9XVIuc78wY/9SnakmQDX/Xf6IgXAnMmPW8x8P7fc49qKzlirG7SUbHmTlD6VqN5dyA2YrJhg6/2jhCDX+r3eF9s/Wq1FvBKJgQ7NXo3GHghv0JS2OhtDpU+Dxz7ZV8aPbjg0RWgcxCflgpbZcHv4gLxEHuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364370; c=relaxed/simple;
	bh=IKy+zTTzSSpk4fAxmWNXR+x9NuiTAQFTb+sFDX5r7yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7ATKoUhUMHYFFVUGkVo1auk/JmTY7fn+tyVxhY6VBVRFEkBWEMgVqDbG0xrki8clFHVVaPjM/U32W8iJ2hRqxHR2Eul5zQqDTobthnM2Khia10ol7Wpd8Vy/cN+eq8fGXSxRRe4qpEPA3OlmFGe36OJB/BsiyqPKxcO4GMNC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=cwCrN5se; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="cwCrN5se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364368; x=1747900368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEJZJoUQxZzm94uJY/1EEHDB0Lg694TXdalLxZehOls=;
  b=cwCrN5seEVInnFrKlkAjDk3dVQV1Cf7TU9jNnrp4sQqbMLg18yZO/1Go
   zjs0DU9E7FRWp4Kx5gcDlYl3eqY+5iDoxrMevwaitpZhWLWJj+xWZqPFW
   9kzeh9rUMM0mlFmhHrWisvYNVR6CeQ02JjQTDsJDgHtd0gjv7JBDkXnH9
   g4vFuMt1Zd/RBaTG6jdAlHHH9GvkMaQGmVVlXCszQeE0WGTnsxpIncH9K
   ge9C7j/7qRQLDFF585Det/9+Swp8Zj5+28WohUWrowQutvLBhNSADCHe9
   hGTosay//KQf6iF+lAhlrC9Sro57BdzO5rZs1FuXbNQAXBcW3O/T3RgK/
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:34 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="390840546"
Received: from unknown (HELO OptiPlex-7080..) ([IPv6:2001:cf8:1:5f1:0:dddd:6fe5:f4d0])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 May 2024 16:42:34 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Sukrit.Bhatnagar@sony.com
Subject: [PATCH 1/2] mm: printk: introduce new format %pGs for slab flags
Date: Wed, 22 May 2024 16:46:28 +0900
Message-Id: <20240522074629.2420423-2-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slab pages have their own flags (apart from PG_slab set in struct page),
kept in the kmem_cache's flag field. These flags are visible to the users of
slab cache and are needed when creating one. It will be useful to be able to
print these slab flags, mainly for debugging purposes, if the folio tests true
for slab.

Add printk format specifier for kmem_cache flags.

Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
---
 Documentation/core-api/printk-formats.rst |  2 +
 include/linux/slab.h                      |  5 ++
 include/trace/events/mmflags.h            | 67 +++++++++++++++++++++++
 lib/test_printf.c                         | 13 +++++
 lib/vsprintf.c                            | 22 ++++++++
 mm/debug.c                                |  5 ++
 mm/internal.h                             |  1 +
 7 files changed, 115 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 4451ef501936..060af5df7a2c 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -583,6 +583,7 @@ Flags bitfields such as page flags, page_type, gfp_flags
 
 	%pGp	0x17ffffc0002036(referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff)
 	%pGt	0xffffff7f(buddy)
+	%pGs	0x10310(HWCACHE_ALIGN|PANIC|TYPESAFE_BY_RCU|CMPXCHG_DOUBLE)
 	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
 	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
 
@@ -592,6 +593,7 @@ character. Currently supported are:
 
         - p - [p]age flags, expects value of type (``unsigned long *``)
         - t - page [t]ype, expects value of type (``unsigned int *``)
+        - s - [s]lab flags, expects value of type (``slab_flags_t *``)
         - v - [v]ma_flags, expects value of type (``unsigned long *``)
         - g - [g]fp_flags, expects value of type (``gfp_t *``)
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..b1ca372f5ee1 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -21,6 +21,10 @@
 #include <linux/cleanup.h>
 #include <linux/hash.h>
 
+/*
+ * In case of any changes, please don't forget to update the flags
+ * in include/linux/events/mmflags.h
+ */
 enum _slab_flag_bits {
 	_SLAB_CONSISTENCY_CHECKS,
 	_SLAB_RED_ZONE,
@@ -64,6 +68,7 @@ enum _slab_flag_bits {
 
 #define __SLAB_FLAG_BIT(nr)	((slab_flags_t __force)(1U << (nr)))
 #define __SLAB_FLAG_UNUSED	((slab_flags_t __force)(0U))
+#define SLAB_FLAG_MASK		((slab_flags_t __force)(1U << _SLAB_FLAGS_LAST_BIT) - 1)
 
 /*
  * Flags to pass to kmem_cache_create().
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e46d6e82765e..1457bc23206f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -141,6 +141,73 @@ IF_HAVE_PG_ARCH_X(arch_3)
 	DEF_PAGETYPE_NAME(table),					\
 	DEF_PAGETYPE_NAME(buddy)
 
+#ifdef CONFIG_DEBUG_OBJECTS
+#define IF_HAVE_SLAB_DEBUG_OBJECTS(_name) {1UL << _SLAB_##_name, __stringify(_name)},
+#else
+#define IF_HAVE_SLAB_DEBUG_OBJECTS(_name)
+#endif
+
+#ifdef CONFIG_FAILSLAB
+#define IF_HAVE_SLAB_FAILSLAB(_name) {1U << _SLAB_##_name, __stringify(_name)},
+#else
+#define IF_HAVE_SLAB_FAILSLAB(_name)
+#endif
+
+#ifdef CONFIG_MEMCG_KMEM
+#define IF_HAVE_SLAB_MEMCG_KMEM(_name) {1U << _SLAB_##_name, __stringify(_name)},
+#else
+#define IF_HAVE_SLAB_MEMCG_KMEM(_name)
+#endif
+
+#ifdef CONFIG_KASAN_GENERIC
+#define IF_HAVE_SLAB_KASAN_GENERIC(_name) {1UL << _SLAB_##_name, __stringify(_name)},
+#else
+#define IF_HAVE_SLAB_KASAN_GENERIC(_name)
+#endif
+
+#ifdef CONFIG_KFENCE
+#define IF_HAVE_SLAB_KFENCE(_name) {1UL << _SLAB_##_name, __stringify(_name)},
+#else
+#define IF_HAVE_SLAB_KFENCE(_name)
+#endif
+
+#ifdef CONFIG_SLUB_TINY
+#define IF_HAVE_SLAB_SLUB_TINY(_name) {1UL << _SLAB_##_name, __stringify(_name)}
+#else
+#define IF_HAVE_SLAB_SLUB_TINY(_name)
+#endif
+
+#define DEF_SLABFLAG_NAME(_name) { 1UL <<  _SLAB_##_name, __stringify(_name) }
+
+#define __def_slabflag_names						\
+	DEF_SLABFLAG_NAME(CONSISTENCY_CHECKS),				\
+	DEF_SLABFLAG_NAME(RED_ZONE),					\
+	DEF_SLABFLAG_NAME(POISON),					\
+	DEF_SLABFLAG_NAME(KMALLOC),					\
+	DEF_SLABFLAG_NAME(HWCACHE_ALIGN),				\
+	DEF_SLABFLAG_NAME(CACHE_DMA),					\
+	DEF_SLABFLAG_NAME(CACHE_DMA32),					\
+	DEF_SLABFLAG_NAME(STORE_USER),					\
+	DEF_SLABFLAG_NAME(PANIC),					\
+	DEF_SLABFLAG_NAME(TYPESAFE_BY_RCU),				\
+	DEF_SLABFLAG_NAME(TRACE),					\
+IF_HAVE_SLAB_DEBUG_OBJECTS(DEBUG_OBJECTS)				\
+	DEF_SLABFLAG_NAME(NOLEAKTRACE),					\
+	DEF_SLABFLAG_NAME(NO_MERGE),					\
+IF_HAVE_SLAB_FAILSLAB(FAILSLAB)						\
+IF_HAVE_SLAB_MEMCG_KMEM(MEMCG_KMEM)					\
+IF_HAVE_SLAB_KASAN_GENERIC(KASAN_GENERIC)				\
+	DEF_SLABFLAG_NAME(NO_USER_FLAGS),				\
+IF_HAVE_SLAB_KFENCE(KFENCE)						\
+IF_HAVE_SLAB_SLUB_TINY(SLUB_TINY)					\
+	DEF_SLABFLAG_NAME(OBJECT_POISON),				\
+	DEF_SLABFLAG_NAME(CMPXCHG_DOUBLE)
+
+#define show_slab_flags(flags)						\
+	(flags) ? __print_flags(flags, "|",				\
+	__def_slabflag_names						\
+	) : "none"
+
 #if defined(CONFIG_X86)
 #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
 #elif defined(CONFIG_PPC)
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 69b6a5e177f2..37f3f837bcbf 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -681,6 +681,19 @@ flags(void)
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 	test("read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
 
+	flags = 0;
+	scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags, "");
+	test(cmp_buffer, "%pGs", &flags);
+
+	flags = 1U << _SLAB_FLAGS_LAST_BIT;
+	scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags, "");
+	test(cmp_buffer, "%pGs", &flags);
+
+	flags = SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_USER_FLAGS;
+	scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags,
+		  "HWCACHE_ALIGN|PANIC|NO_USER_FLAGS");
+	test(cmp_buffer, "%pGs", &flags);
+
 	gfp = GFP_TRANSHUGE;
 	test("GFP_TRANSHUGE", "%pGg", &gfp);
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275..67f3584db58c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2054,6 +2054,25 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
 	return buf;
 }
 
+static
+char *format_slab_flags(char *buf, char *end, unsigned int flags)
+{
+	buf = number(buf, end, flags, default_flag_spec);
+	if (buf < end)
+		*buf = '(';
+	buf++;
+
+	flags &= SLAB_FLAG_MASK;
+	if (flags)
+		buf = format_flags(buf, end, (__force unsigned long)flags, slabflag_names);
+
+	if (buf < end)
+		*buf = ')';
+	buf++;
+
+	return buf;
+}
+
 static
 char *format_page_type(char *buf, char *end, unsigned int page_type)
 {
@@ -2088,6 +2107,9 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 		return format_page_flags(buf, end, *(unsigned long *)flags_ptr);
 	case 't':
 		return format_page_type(buf, end, *(unsigned int *)flags_ptr);
+	case 's':
+		flags = (__force unsigned int)(*(slab_flags_t *)flags_ptr);
+		return format_slab_flags(buf, end, flags);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
diff --git a/mm/debug.c b/mm/debug.c
index 69e524c3e601..2ef516f310e8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -41,6 +41,11 @@ const struct trace_print_flags pagetype_names[] = {
 	{0, NULL}
 };
 
+const struct trace_print_flags slabflag_names[] = {
+	__def_slabflag_names,
+	{0, NULL}
+};
+
 const struct trace_print_flags gfpflag_names[] = {
 	__def_gfpflag_names,
 	{0, NULL}
diff --git a/mm/internal.h b/mm/internal.h
index 2adabe369403..6a15f4937db8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1123,6 +1123,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 
 extern const struct trace_print_flags pageflag_names[];
 extern const struct trace_print_flags pagetype_names[];
+extern const struct trace_print_flags slabflag_names[];
 extern const struct trace_print_flags vmaflag_names[];
 extern const struct trace_print_flags gfpflag_names[];
 
-- 
2.34.1

