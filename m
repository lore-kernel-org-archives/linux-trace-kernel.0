Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225A31E830;
	Sat,  1 Aug 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582048; cv=none; b=CguuJIvYtX2nNYAZTG6u+uuZGzYtr7htgSX2m0dYOs0C4gamuEcjfGRR4BIKVV7INQ42DECa4bPGhbA4nuvQsHOqIcEc2NcPorTzDU/s+O7oahRuE+r8CiVcp84Sk2MPDLTuhzIOh/UuTSqh8dwZJQG19XO0ran/yfzcrM2F0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582048; c=relaxed/simple;
	bh=ll6nYQOrO2XWydxLfhKt+/rvzaAqc+x2/e8etpbuoBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEyyGkbgjJzkaow42Dk7oqhSf5hMmJgVW+tnNVTka30QtW5HeEEqUzyKOSJT/Unyvv2Ux+B8gpIgoQ/TwKR8LlT6BCsTuID07+LJQmD2fxTqcUD/k3mRBg1+7mSbSpc3LCm3ZhmRQz9hldonOCxA9ycZGCz+rXN+ET2bIiGpXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=u81cA4nq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="u81cA4nq"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hC0NB6WcLzMlGG;
	Sat, 01 Aug 2026 13:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785582042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bbvo5JM5EzDceFV5HFBn3Tn1Nvzi+vQVAFu4wTmlqI=;
	b=u81cA4nqP3SwSZYYHDPT/c5iJMa/mvGsUCdVoLwzxrcGgMFdrtexAyfBe4goeV8CnoZjmp
	Y8QnIl1s+PhdvBc1uZ67SH+P2UaPM0wBkVnrC+24JdQDekZnjHXK0r1hvcI9G8U6J7NYb0
	GCCAq5M8x3jgV7eAiA8AiD6S1s+UCp9bvRP16OM6cb3/Jyv5mOV/wewYycedofExfwcFoI
	B/bCmIOP2cc3iImIeld1Rds/k5ogd28dgZPxvk8gfIb2Kql+LxMpp37/g8R0ra44dqB2oq
	9FxmU2xf61PGf8Ow4QVc3bBeLX5rbaVXjqV/rrIUGLiFyYarvXjg33CZOAHzgQ==
From: Eugene Mavick <m@mavick.dev>
Date: Sat, 01 Aug 2026 18:59:41 +0800
Subject: [PATCH v4 1/5] tracing: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-refcount-final-put-trace-v4-1-2e58678f0ffd@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4872; i=m@mavick.dev;
 h=from:subject:message-id; bh=ll6nYQOrO2XWydxLfhKt+/rvzaAqc+x2/e8etpbuoBQ=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFm5FzdGbl2SrP/R6MkG6f0mqz+8/KArc/GXXJBuwnVnm
 8LVi1U2dZSyMIhxMciKKbLUZCW4Z6yclWh8dFIPzBxWJpAhDFycAjCRnGWMDHdzXrOYP4isqmRz
 VKud4Pf8y/2zOpe+ZH+4tbBw2o2QC16MDA/PHJbIWcL2r+Ttg51bNy/dYv5h9/yWhML3E88wfKt
 XfsAKAA==
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F

Add ref_trace_final_put tracepoint and related core infrastructure

ref_trace_final_put fires when a reference
count reaches zero and the object enters its final release path.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- ip: return address of trace wrapper macro call
- obj: refcount object(struct percpu_ref, refcount_t)

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
 include/linux/ref_trace.h        | 40 +++++++++++++++++++++++++++++++
 include/trace/events/ref_trace.h | 51 ++++++++++++++++++++++++++++++++++++++++
 lib/Makefile                     |  2 ++
 lib/ref_trace.c                  | 13 ++++++++++
 4 files changed, 106 insertions(+)

diff --git a/include/linux/ref_trace.h b/include/linux/ref_trace.h
new file mode 100644
index 000000000000..c93c30bc20d2
--- /dev/null
+++ b/include/linux/ref_trace.h
@@ -0,0 +1,40 @@
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
+extern void do_ref_trace_final_put(unsigned long caller, unsigned long ip, const void *obj);
+
+#define do_trace_ref_final_put(obj)						\
+	do {									\
+		if (tracepoint_enabled(ref_trace_final_put))			\
+			do_ref_trace_final_put(_RET_IP_, _THIS_IP_, obj);	\
+	} while (0)
+
+#define do_trace_ref_final_put_cond(cond, obj)					\
+	do {									\
+		if (tracepoint_enabled(ref_trace_final_put)) {			\
+			if (cond)						\
+				do_ref_trace_final_put(_RET_IP_, _THIS_IP_, obj);\
+		}								\
+	} while (0)
+
+#else /* !CONFIG_TRACEPOINTS */
+static inline void do_ref_trace_final_put(
+					  unsigned long caller,
+					  unsigned long ip,
+					  const void *obj)
+{
+}
+#define do_trace_ref_final_put(obj) do { } while (0)
+#define do_trace_ref_final_put_cond(cond, obj) do { } while (0)
+#endif
+
+#endif /* _LINUX_REF_TRACE_H */
diff --git a/include/trace/events/ref_trace.h b/include/trace/events/ref_trace.h
new file mode 100644
index 000000000000..8bd9aa30a540
--- /dev/null
+++ b/include/trace/events/ref_trace.h
@@ -0,0 +1,51 @@
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
+ * @ip: return address of trace wrapper macro call,
+ * inlining may cause it to be something else tho
+ * @obj: refcount object(struct percpu_ref, refcount_t)
+ *
+ * Tracepoint instrumentation can be added using the do_ref_trace_final_put
+ * macro defined in include/linux/ref_trace.h
+ * which uses _RET_IP_ and _THIS_IP_ for caller and ip arguments respectively,
+ * thus only requiring obj arg to be supplied
+ */
+TRACE_EVENT(ref_trace_final_put,
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
index 000000000000..22fe372f468f
--- /dev/null
+++ b/lib/ref_trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/ref_trace.h>
+#include <linux/ref_trace.h>
+
+//Wrapper function for functions defined entirely in header files
+void do_ref_trace_final_put(unsigned long caller, unsigned long ip, const void *obj)
+{
+	trace_call__ref_trace_final_put(caller, ip, obj);
+}
+EXPORT_SYMBOL_GPL(do_ref_trace_final_put);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(ref_trace_final_put);

-- 
2.51.2

