Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E737996C;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661476; cv=none; b=PkXwYUUXe/xy6bnfw6G5tpdNMrtL7MFFMrcf3DiJzGlNV8dO5LiolSv09AvTZPk1p65l3pLVOXv4QEtxP9dx+BgtzM+WpyZEAnkNNIscspPov4XsefGj/uHi5p6W76qM7Om9GpUPa0Hxrhg0ZnyRyk9L7X+DCf9ujljJFxfLPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661476; c=relaxed/simple;
	bh=sJwNGf50ntTffD4/Akpa0xR1rlsG3ZrhWjyIlK4Mk08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5vlrzeiVFJ3aoyyIOGB7UWSkket2CMMSglpEElYc2ltmdEPmDJTbibCuzirX7oinsSz8fnAT3S471H516fn8zlTBjEntvmSAXWSZ7IIRed2ASXugP9PngR44uEGyaydJut0zfzb/KMlcHhSCIhrV8/fn+PQDT2GTR3bcUqgip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoyoHKwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoyoHKwz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13958C2BCB8;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783661476;
	bh=sJwNGf50ntTffD4/Akpa0xR1rlsG3ZrhWjyIlK4Mk08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qoyoHKwzoiP05HCTetHmLNHeovi0PBuuKIpAM3oXyCwMTQyvrb3PxZbDsNJQ21FqZ
	 qoOyASbGcMF/UWWhC8a0dcoaN83b4n3d5KyKJFAt1wMy8qZ65YkshHhF9GcnnNAK9R
	 y8+7bZnUm5TtZEEdFq+nZgpwoIvUT0uThyWVbjqbhF+uJjrjWHtshiNFAXF4EgHDeH
	 4kjSk5gyAPRh2YqwCCpGNk79AjrkzhPC8MzAjtPglXbDBj1QgcOhEtGgkJTmMUI4CM
	 WCJHLIl+Xt6MAS5ABuGcVI6vxjo+dYgM1+Up+rg/puVkD4+KpVE5TSYaXJIKLiSfwR
	 dBKZULiGiOBiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E912AC44501;
	Fri, 10 Jul 2026 05:31:15 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Fri, 10 Jul 2026 13:30:39 +0800
Subject: [PATCH v2 1/5] tracing: add ref_trace_final_put tracepoint
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-refcount-final-put-trace-v2-1-557cfce860a2@mavick.dev>
References: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
In-Reply-To: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=qR1tr9zkvfO0Ekv8EXksBaXJupN2DKoOXEp8ReORpQI=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFkBzT0KGade/c9KdFHS3h8rXtH3ZPqyLVL5tiWiZ997v
 /MXTEjsKGVhEONikBVTZKnJSnDPWDkr0fjopB6YOaxMIEMYuDgFYCJvtzL8z0vLdXzxyiZUwe4R
 x0+dqs6sZO7uVRfrkp6uPSuhM9t4G8P/0kO8PGqhJzoeq/yr6Zf+scT6y67vgcwLzlpFrnlt3qL
 CCwA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

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
v2:
-change trace_ref_final_put macro name to do_trace_ref_final_put to
 avoid overlap with tracepoint names(trace_*)
-change, in above mentioned macro, from trace_ref_trace_final_put( to
 trace_call__ref_trace_final_put( to avoid double check
-changes suggested by Steven Rostedt
-v1:https://lore.kernel.org/all/20260705-refcount-final-put-trace-v1-1-cdd0014626a9@mavick.dev/
---
 include/linux/ref_trace.h        | 26 +++++++++++++++++++++++
 include/trace/events/ref_trace.h | 46 ++++++++++++++++++++++++++++++++++++++++
 lib/Makefile                     |  2 ++
 lib/ref_trace.c                  | 12 +++++++++++
 4 files changed, 86 insertions(+)

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
index 000000000000..e6037a325be2
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
+ * @caller: function that called the refcounting
+ * function(refcount_sub_and_test, percpu_ref_put_many)
+ * @fn: refcounting function(eg refcount_sub_and_test)
+ * @obj: refcount object(struct percpu_ref, refcount_t)
+ *
+ * Tracepoint instrumentation can be added using the ref_trace_final_put
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
index 000000000000..9102dc7117db
--- /dev/null
+++ b/lib/ref_trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/ref_trace.h>
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


