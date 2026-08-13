Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0237AA65;
	Thu, 13 Aug 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593032; cv=none; b=k2w8lnJuGXOFbz+c5hKkdSNHMZvpZ3QjNEv1MUrKHw4IirA06tnKYDjQ4u+YMz3tYV7wCkfjf9Qt0I59l8mY5OM9BbiW+12IRAIlplmVciHo1DsZFeyXxzRuZ8JVQQzj0xorQJvjQ2fb78yHNykH6eT1c9QeJdX96tV4HWK1VFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593032; c=relaxed/simple;
	bh=/DyJ/Pt5HgNY+1AYXZ1YsFD8V1gs37HPB1lvRPBQOWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJFEcAKtS+AaciJa3kgslC7R8iQNA6i9R+V7UqfhzIWHPFZwMH2rwhS/czaWCFEE6xNjNPY+c+9/7xkOSgLRYUNJ2WJGh1qdtmOzRlJntOIrThIUrK720Z87cPzCKh2eudoWFVzrdG77ABw8caNL3oM6435ZprYQ0OCnJHjQ/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=xHgBGCEm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="xHgBGCEm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLBG92N6QzKw1y;
	Thu, 13 Aug 2026 05:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1786593025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEXWfsEWtFFEp+0efKsBCvQdDR44+02Pu5SRRh4WvD8=;
	b=xHgBGCEm+3b1/xWePC0fKvD2X+/AktKduhbs5J/5JXXpF4UF5K0KM4vKDypjx3SNJqUMEi
	3i1lzTbnGNvLvW/7YTNM3TgYF08OSnvSew8OTOdxenB6arH4tzF/tR5uBe/ITZ6iIftFUU
	6Bj181XPQeoFyxwaNDO3sVN4KGxWNAjI694DaD8CZQY5/NcLdvl8eOC0M3jzqUxcdAZeAr
	F26NLiE321S3EGYlq82BDro0jhkZtOwCvmr4DcGWj3C55ZdZ5z7/OO8OetIGrUvp6SaKlS
	8tNTuhqnDI8FLqI5IbXgkNQdjbkUKR6a0QiDO56RByl5dNasyYahRzTX8C3yjA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Thu, 13 Aug 2026 11:49:07 +0800
Subject: [PATCH v5 1/5] tracing: add refcount_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-refcount-final-put-trace-v5-1-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
In-Reply-To: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kasan-dev@googlegroups.com, 
 Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5562; i=m@mavick.dev;
 h=from:subject:message-id; bh=/DyJ/Pt5HgNY+1AYXZ1YsFD8V1gs37HPB1lvRPBQOWM=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm1dgen8J9b9fMDq5pp/aWjMaqSlwrVjvyJExR7IlwSw
 x+7edvUjlIWBjEuBlkxRZaarAT3jJWzEo2PTuqBmcPKBDKEgYtTACYyk4Hhf85WLaft4Zf2337d
 8+ov+3LnJ8W3rkutXaDnWt3yw/GXgjnD/6j9k78unJKeydLcfe7ijGt/JdQTJC3jXd43MvmsrXe
 I5gMA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4hLBG92N6QzKw1y

Add refcount_final_put tracepoint and related core infrastructure

refcount_final_put fires when a reference
count reaches zero and the object enters its final release path.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- ip: return address of trace wrapper macro call
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/refcount_trace.h  | 33 +++++++++++++++++++++++++
 include/trace/events/refcount.h | 55 +++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig                     |  8 ++++++
 lib/Makefile                    |  2 ++
 lib/refcount_trace.c            | 14 +++++++++++
 5 files changed, 112 insertions(+)

diff --git a/include/linux/refcount_trace.h b/include/linux/refcount_trace.h
new file mode 100644
index 000000000000..6f8d0ba910f0
--- /dev/null
+++ b/include/linux/refcount_trace.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_REFCOUNT_TRACE_H
+#define _LINUX_REFCOUNT_TRACE_H
+
+#include <linux/tracepoint-defs.h>
+#include <linux/instruction_pointer.h>
+
+#ifdef CONFIG_REFCOUNT_TRACE_FINAL_PUT
+/* Declare the tracepoint so tracepoint_enabled() can be used */
+DECLARE_TRACEPOINT(refcount_final_put);
+
+/* Wrapper function implemented in lib/ref_trace.c */
+extern void do_refcount_trace_final_put(unsigned long caller, unsigned long ip, const void *obj);
+
+#define do_trace_refcount_final_put(obj)					\
+	do {									\
+		if (tracepoint_enabled(refcount_final_put))			\
+			do_refcount_trace_final_put(_RET_IP_, _THIS_IP_, obj);	\
+	} while (0)
+
+#define do_trace_refcount_final_put_cond(cond, obj)				\
+	do {									\
+		if (tracepoint_enabled(refcount_final_put) && cond)		\
+			do_refcount_trace_final_put(_RET_IP_, _THIS_IP_, obj);	\
+	} while (0)
+
+#else /* !CONFIG_REFCOUNT_TRACE_FINAL_PUT */
+extern void do_refcount_trace_final_put(unsigned long caller, unsigned long ip, const void *obj);
+#define do_trace_refcount_final_put(obj) do { } while (0)
+#define do_trace_refcount_final_put_cond(cond, obj) do { } while (0)
+#endif
+
+#endif /* _LINUX_REFCOUNT_TRACE_H */
diff --git a/include/trace/events/refcount.h b/include/trace/events/refcount.h
new file mode 100644
index 000000000000..a4dc23aff93b
--- /dev/null
+++ b/include/trace/events/refcount.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM refcount
+
+#if !defined(_TRACE_REFCOUNT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_REFCOUNT_H
+
+#include <linux/tracepoint.h>
+
+#ifdef CONFIG_REFCOUNT_TRACE_FINAL_PUT
+
+/**
+ * refcount_final_put - trace when a reference count reaches zero
+ * @caller: return address of refcount
+ * function(refcount_sub_and_test, percpu_ref_put_many)
+ * @ip: return address of trace wrapper macro call,
+ * inlining may cause it to be something else tho
+ * @obj: refcount object(struct percpu_ref, refcount_t)
+ *
+ * Tracepoint instrumentation can be added using the do_refcount_trace_final_put
+ * macro defined in include/linux/refcount_trace.h
+ * which uses _RET_IP_ and _THIS_IP_ for caller and ip arguments respectively,
+ * thus only requiring obj arg to be supplied
+ */
+TRACE_EVENT(refcount_final_put,
+
+	TP_PROTO(unsigned long caller, unsigned long ip, const void *obj),
+
+	TP_ARGS(caller, ip, obj),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,		caller	)
+		__field(	unsigned long,		ip	)
+		__field(	const void *,		obj	)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->ip = ip;
+		__entry->obj = obj;
+	),
+
+	TP_printk("caller=%pS ip=%pS obj=%p",
+		  (void *)__entry->caller,
+		  (void *)__entry->ip,
+		  __entry->obj
+	)
+);
+
+#endif /* CONFIG_REFCOUNT_TRACE_FINAL_PUT */
+
+#endif /* _TRACE_REFCOUNT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..12bc59515a3e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -52,6 +52,14 @@ config PACKING_KUNIT_TEST
 
 	  When in doubt, say N.
 
+config REFCOUNT_TRACE_FINAL_PUT
+	bool "Trace final puts on multiple refcount implementations"
+	depends on TRACEPOINTS && DEBUG_KERNEL
+	help
+	  Trace when a refcount implementation considers refcounted object dead.
+
+	  If unsure, say N.
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19..e75e88f0c870 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -335,3 +335,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
 obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
 
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
+
+obj-$(CONFIG_REFCOUNT_TRACE_FINAL_PUT) += refcount_trace.o
diff --git a/lib/refcount_trace.c b/lib/refcount_trace.c
new file mode 100644
index 000000000000..2476bb5f2f60
--- /dev/null
+++ b/lib/refcount_trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/refcount.h>
+#include <linux/refcount_trace.h>
+
+//Wrapper function for functions defined entirely in header files
+void do_refcount_trace_final_put(unsigned long caller,
+				 unsigned long ip,
+				 const void *obj)
+{
+	trace_call__refcount_final_put(caller, ip, obj);
+}
+EXPORT_SYMBOL_GPL(do_refcount_trace_final_put);
+EXPORT_TRACEPOINT_SYMBOL_GPL(refcount_final_put);

-- 
2.51.2

