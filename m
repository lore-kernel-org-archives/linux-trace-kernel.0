Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A2286D70;
	Sat, 11 Jul 2026 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744870; cv=none; b=ibHjaoFIIEOzzgDLd+8gjYdRaBCnt7pxBIZQP5U4S4Tpz+tSGZSBDM83lAtDIc60J5U4gZepMlTrdkifKNODECjwPKUByCM2Mx963Xlvak+YW8BotiSUBV1sTF0CyePfBj+iMPVNYjMSY9rBJDxj3j3bGgyEFfcCqSrr/kilvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744870; c=relaxed/simple;
	bh=togALykcuUOAaOKZnU5+keMWktwavqkGC+6SZdVlIpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOS9LrahBEKY/aUvmGq7mx5NrNQ/gw7cfeHC+H4sVHgRBjgpqaY+vqLhjTKG0kvYQmFA1vZkWnSiM8PoRo9UH3VFbspLaPpcObuRbSbNPfEdm1b6G+cfVJC6gxC6x9MckjaQ6Q0UTty/PkMfCEipxRTFnh81viSbYxYuPgSH408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=i9Xo9o4D; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="i9Xo9o4D"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gxwxt41NSz8v1p;
	Sat, 11 Jul 2026 06:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1783744866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fRYBbl/zFHo/ph55CpxjBKpforkcs9UdExdzuIQ868=;
	b=i9Xo9o4De01YdLlfiFfiUO4cTTk+rdHz9XoaG27qFEXE8Dr2HpfhUlzoH9sqJ5FJ5+S3p2
	1UDvwaIavR7TQSjMd2scSqfFieEPssjD9yEbWuGaHjjl97INZAgw7UhSqPXsG3KssX5oKj
	xcgRhqffsfD+Qinnf1y0HAwo2t3xOrQyoHAKk1EHFp8fI/j/FMWUnVnO2oX/J4Or3eKz2y
	pJrR25bJCRYlGvZ+653qV72ImAm3q310S/yZD0u5B2l8qrtCocQ/vcpNM6NYglC458J0Ep
	lv/gn1+E4i0utnWL+Kf7TIy7X+dxPN3rhbY0b8GqJxF3X25uA6atUto+AAsYCg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 11 Jul 2026 12:40:19 +0800
Subject: [PATCH v3 1/5] tracing: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-refcount-final-put-trace-v3-1-674c8f03d9f9@mavick.dev>
References: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
In-Reply-To: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418; i=m@mavick.dev;
 h=from:subject:message-id; bh=togALykcuUOAaOKZnU5+keMWktwavqkGC+6SZdVlIpU=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmBJ20vBxSl+CqVOyzui55aOcfuqR/rIrPjf5PmrK87L
 bWtzWxSRykLgxgXg6yYIktNVoJ7xspZicZHJ/XAzGFlAhnCwMUpABMpNGT4K/dCtMKuz5OT9X4p
 /92Sq1Pn3Shns5Xlrl2m2WT1xm5bFSPDCo7AM3P+er9OesvRs++ogfkx9pdPPt+sDmyqMPwXWHe
 BGwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Rspamd-Queue-Id: 4gxwxt41NSz8v1p

Add ref_trace_final_put tracepoint and related core infrastructure

ref_trace_final_put fires when a reference
count reaches zero and the object enters its final release path.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- fn: refcounting function(eg refcount_sub_and_test)
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/ref_trace.h        | 26 +++++++++++++++++++++++
 include/trace/events/ref_trace.h | 46 ++++++++++++++++++++++++++++++++++++++++
 lib/Makefile                     |  2 ++
 lib/ref_trace.c                  | 13 ++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/include/linux/ref_trace.h b/include/linux/ref_trace.h
new file mode 100644
index 000000000000..6c6600938a47
--- /dev/null
+++ b/include/linux/ref_trace.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_REF_TRACE_H
+#define _LINUX_REF_TRACE_H
+
+#include <linux/tracepoint-defs.h>
+#include <linux/instruction_pointer.h>
+
+/* Declare the tracepoint so tracepoint_enabled() can be used */
+DECLARE_TRACEPOINT(ref_trace_final_put);
+
+#ifdef CONFIG_TRACEPOINTS
+/* Wrapper function implemented in lib/ref_trace.c */
+extern void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj);
+
+#define do_trace_ref_final_put(obj)						\
+	do {									\
+		if (tracepoint_enabled(ref_trace_final_put))			\
+			do_ref_trace_final_put(_RET_IP_, __func__, obj);	\
+	} while (0)
+
+#else /* !CONFIG_TRACEPOINTS */
+static inline void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj) { }
+#define do_trace_ref_final_put(obj) do { } while (0)
+#endif
+
+#endif /* _LINUX_REF_TRACE_H */
diff --git a/include/trace/events/ref_trace.h b/include/trace/events/ref_trace.h
new file mode 100644
index 000000000000..3bf1b1d390b8
--- /dev/null
+++ b/include/trace/events/ref_trace.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ref_trace
+
+#if !defined(_TRACE_REF_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_REF_TRACE_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * ref_trace_final_put - trace when a reference count reaches zero
+ * @caller: return address of refcount
+ * function(refcount_sub_and_test, percpu_ref_put_many)
+ * @fn: refcounting function(eg refcount_sub_and_test)
+ * @obj: refcount object(struct percpu_ref, refcount_t)
+ *
+ * Tracepoint instrumentation can be added using the do_ref_trace_final_put
+ * macro defined in include/linux/ref_trace.h
+ * which uses _RET_IP_ and __func__ for caller and fn arguments respectively,
+ * thus only requiring obj arg to be supplied
+ */
+TRACE_EVENT(ref_trace_final_put,
+
+	TP_PROTO(unsigned long caller, const char *fn, const void *obj),
+
+	TP_ARGS(caller, fn, obj),
+
+	TP_STRUCT__entry(
+	__field(unsigned long, caller)
+	__string(fn, fn)
+	__field(const void *, obj)
+	),
+
+	TP_fast_assign(
+	__entry->caller = caller;
+	__assign_str(fn);
+	__entry->obj = obj;
+	),
+
+	TP_printk("caller=%pS fn=%s obj=%p", (void *)__entry->caller, __get_str(fn), __entry->obj)
+);
+
+#endif /* _TRACE_REF_TRACE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19..41737090a95d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -335,3 +335,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
 obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
 
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
+
+obj-$(CONFIG_TRACEPOINTS) += ref_trace.o
diff --git a/lib/ref_trace.c b/lib/ref_trace.c
new file mode 100644
index 000000000000..466647772ce1
--- /dev/null
+++ b/lib/ref_trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/ref_trace.h>
+#include <linux/ref_trace.h>
+
+//Wrapper function for functions defined entirely in header files
+void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj)
+{
+	trace_call__ref_trace_final_put(caller, fn, obj);
+}
+EXPORT_SYMBOL_GPL(do_ref_trace_final_put);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(ref_trace_final_put);

-- 
2.51.2

