Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440033;
	b=mpTBVqfecE6IL9UIPpYqChVbm+8cFoNLnNdPYMCfMTutyKNpUW6OF5AxWRw46lxWuGjo
	 ol42pFxFUwb2g1LzbLfo3t/o2RJad6NEa/nUXstur432Kd/ikscxr8By4kkn2yFpiey5g
	 8gCMvvBdq0r776gWRiQ4KoB/yHU7gwXvmpPP6Tp/NIza2hV4QOpY5kIcbB7uKcajZwZJo
	 Q5KyUUQCTz67wezGN6U15a6FsJKpCZrVld77kZCibqgYqS9Zz1GuoJgZf3M2zQhamNsQ0
	 vN0qYtCXGPRuaGjCcw+MrSLiRQ73qHWsfxRmNDrDq5g2zeUPMVHBo4Nm31tBQ4tQslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SAJLNdbLDS8yWOmrPFOnw0Q3UOenAvsVBK6o5nZWKOY=;
	b=2/9Xbz60Nm6pYa4YDd3vhi3T8Av+6qfRzGgqX5AK2S3sfsU7Tw0XIqikGjzOus4aQhtG
	 dGB6MDpqtkhxtUsbH6VFqqufIUuL2LVEPyr4GxpBbjIRzg0tjgghu7uokVE4GRNcpotKK
	 hJFuon/s3fzpv9lmj6AOligxgYvmxhx2eHQGCEM5sQBgsyEGgNmF+CjIHE9CNAHBg5+je
	 32G3PgED29/cQ+U1A83bxTHqQApJ5quhWHSOa/ESxVr5xYzwSY8IsksAJWawHGQWxJBoR
	 bMaEFtDOEIsEfMPlwDrSD4w4TdH5frx/ZpKY9Qq6t75qCXsBwpEtwydxkzclR/HgVnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RSrgOWeQ;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E12606A325
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E12606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RSrgOWeQ
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso4809832c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440031; x=1793044831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAJLNdbLDS8yWOmrPFOnw0Q3UOenAvsVBK6o5nZWKOY=;
        b=RSrgOWeQZxkUbq6RcvLzYGaggscw7c8st0DUxSHMUCdu8M+MigYSg0OIf0mlA4K/wu
         d6Nrd5hHuJySMxcZf1OtdepG/uqOCCxojY/b76yd/NnCnUDgiAOYoXYc9nrIl8M/xn9D
         CJhUJxBRyoGev0N9LvdpIa6+8GTA+nqqkzVBcf42/Cdfy0SHJ1QQxLeu9fSIr+n2Y2Vu
         +vfHv4WS6aXsF0vDfWJwm7tm78uWEv8qz2yXkLuVr0xyqBtS+USWieAgn/5rtzdPfSsu
         YzllzUnVNAxDkXE5KrhX2DAvo8yRR3jsWDNJMSh7SlSPT4jHXkbrgCqLHN+qdAplUvq1
         7cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440031; x=1793044831;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAJLNdbLDS8yWOmrPFOnw0Q3UOenAvsVBK6o5nZWKOY=;
        b=jAoFVJpMj+V28wwysyZ0Ms8MCBy6reUYPThf1AIH1Pm68uFJTcU5M4chlJaHkWSjxW
         eZvgAlsaMVgy4LLWbFI5xwDMAkoeiL4YX48anLgeDYTmSH+ceijDlcF3Fe4PbsYtDEmM
         Spw46TvV/jWUQPBziH5H39jDrN2xsPiNGC44umjAxSH4kwUQkAKgI/+rjAWCI2GSNJp2
         hnyT/7hqSSlru1drPqq4iUZbVqafshgyEGaIzdWhKCrwxyFquPGew6RJVYzGHTRZNJCR
         zoo+4oEDfJWS/ZYS4m1uEJtoBv0MYOVrbxe2iB+rZT7zJFnSdl6HiWFMurQtpAjfUUCq
         sUHg==
X-Forwarded-Encrypted: i=1; AKwUvBx/B0bcy/+kOeq09gz01zCW+ESfvijZ3SJRypwDJNZ7qo8gLfwiiFa9IJfOyzFq3m4fue4LW12oZ4PJDdIrlG77O+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhPNrFbkHbnD3DW+fMdwY7jUi9XJSRz/TfG3s1VljK2DFRf5Aw
	yzxG4TIu5ylLIrteH3XtBMe7xg9WPZSPbaoUy551h/8OopaWfrFkBV+N98viV5aMcfDXxaIMgZa
	LU4Cu38z7+7JE+LhWhWO/wPuSDJEXASwBZw==
X-Received: from dldyq17-n2.prod.google.com ([2002:a05:701b:4551:20b0:14e:8121:6eda])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2319:b0:175:525c:90b4 with SMTP id a92af1059eb24-185125792bamr11610444c88.20.1792440031096;
 Mon, 19 Oct 2026 13:00:31 -0700 (PDT)
Date: Mon, 19 Oct 2026 20:00:24 +0000
In-Reply-To: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792439751.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <323077f96bca23b512a86a6781ebc9dfe6ae9ec1.1792439751.git.abhishekbapat@google.com>
Subject: [PATCH v3 1/4] alloc_tag: Add trace events for tracing allocations
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

The memory allocation profiling framework intercepts allocations across
the core subsystems, but currently lacks runtime tracing hooks for
standard observability tools to dynamically track the context (stack
traces and lifecycles of the individual memory chunks) of the
allocations made.

Introduce three standard trace events to allow this tracking:

1. `alloc_tag_hit`: Fired at the exact call site. This allows userspace
   tools to trigger and capture a call stack.
2. `alloc_tag_mem_alloced`: Fired in alloc_tag_add upon successful
   allocation. It records the allocated size, the tag, and the uniquely
   generated `ptr` value which is `codetag_ref` for slab and percpu
   allocators and the pointer to the head `struct page` for the page
   allocator.
3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory is
   freed, yielding the same `ptr` value to allow tracing tools to find
   the corresponding allocation.

Because the introduced trace events occur at different stages in the
call stack, userspace tracing tools must stitch them together to form a
complete picture of a buffer's lifetime. Here's an example of how
userspace correlates these three events:

1. On `alloc_tag_hit`: The tool captures the stack trace and caches it,
   keyed by the combination of the current thread's PID and the `tag`.
2. On `alloc_tag_mem_alloced`: The tool extracts the PID and `tag` from
   the event and looks up the stack trace cached in step 1. It creates a
   new active allocation record, mapping the new provided `ptr` value
   to this cached stack trace and the newly returned allocation size.
3. On `alloc_tag_mem_freed`: When the memory is freed, the event yields
   the same `ptr` value. The tool uses this reference to look up the
   original allocation record, correlates the free, and safely retires
   the tracking entry.

Modify `alloc_tag_add()` and `alloc_tag_sub()` with a `ptr` argument to
map frees to allocations in the trace events. Slab and percpu pass the
address of the object's `codetag_ref`. The page allocator passes the
head `struct page` because its `codetag_ref` is a temporary copy on the
stack.

Also, introduce `alloc_tag_trace_key` static key to minimize the
overhead when no tags are being traced (the usual case). Once tracing
for any tag is requested, the key is set, opening the path to check
whether tracing is enabled for the current tag.
Note that the mechanism to enable tag tracing is implemented in the next
patch, therefore for now, `alloc_tag_trace_key` stays always unset.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
Acked-by: Hao Ge <hao.ge@linux.dev>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst |  53 ++++++++++
 MAINTAINERS                               |   1 +
 include/linux/alloc_tag.h                 |  67 +++++++++---
 include/trace/events/alloc_tag.h          | 122 ++++++++++++++++++++++
 mm/alloc_tag.c                            |  28 +++++
 mm/page_alloc.c                           |   4 +-
 mm/percpu.c                               |  13 ++-
 mm/slub.c                                 |   6 +-
 8 files changed, 269 insertions(+), 25 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
index b11ea77c0673..b241450394df 100644
--- a/Documentation/mm/allocation-profiling.rst
+++ b/Documentation/mm/allocation-profiling.rst
@@ -129,6 +129,59 @@ To do so:
 - Then, use the following form for your allocations:
   alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
 
+Tracing
+=======
+
+Three trace events are available under `/sys/kernel/tracing/events/alloc_tag` to
+expose the full call stack and the lifetime of individual allocations:
+
+- `alloc_tag_hit`: Fired at the exact call site, before the allocation happens.
+  Can be used to capture the call stack of the caller.
+
+- `alloc_tag_mem_alloced`: Fired once the allocation succeeds. Carries the `ptr`,
+  `tag` and `bytes` for each allocation.
+
+- `alloc_tag_mem_freed`: Fired before memory is freed. Carries the same
+  `ptr`, `tag` and `bytes` as the matching alloc event.
+
+`ptr` identifies the allocation, and its meaning depends on the allocator:
+
+- slab and percpu: the address of the object's `codetag_ref`
+- page allocator: the `struct page` pointer of the head page
+
+Correlating the events
+----------------------
+
+`alloc_tag_hit` and `alloc_tag_mem_alloced` come from different points in the
+call stack, so they have to be stitched together by the user consuming the
+events. Here's a typical flow:
+
+1. On `alloc_tag_hit`: Capture the stack trace and cache it keyed by `(pid, tag)`.
+
+2. On `alloc_tag_mem_alloced`: Look up the cached stack trace by `(pid, tag)`,
+   then create an active allocation record keyed by `ptr` that holds the stack
+   trace and `bytes`.
+
+3. On `alloc_tag_mem_freed`: Look up the record by `ptr` and retire it.
+
+Limitations
+-----------
+
+- For the page allocator, events are generated for the original allocation and
+  the free only. If the tag reference is split or moved to another folio in
+  between, no event is generated for that. As a result:
+
+  - a free event may carry a `ptr` that never appeared in an alloc event;
+  - `bytes` in a free event may be smaller than in the matching alloc event.
+
+  Tools should correlate on `ptr` but must not assume that freed bytes equal
+  allocated bytes, or that every free has a matching alloc.
+
+- Freeing a non-compound high-order page with `__free_pages()` while another CPU
+  holds a reference frees the tail pages immediately and the head page later when
+  the reference is dropped. The free event is emitted at the second point and
+  reports `PAGE_SIZE` rather than the full size.
+
 Notes
 =====
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f1f35a017a6..fb2df7b8e9ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17100,6 +17100,7 @@ S:	Maintained
 F:	Documentation/mm/allocation-profiling.rst
 F:	include/linux/alloc_tag.h
 F:	include/linux/pgalloc_tag.h
+F:	include/trace/events/alloc_tag.h
 F:	include/uapi/linux/alloc_tag.h
 F:	mm/alloc_tag.c
 F:	tools/testing/selftests/alloc_tag/
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7f2d80a59792..0319c2f1e4e2 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -128,12 +128,33 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
 
+DECLARE_STATIC_KEY_FALSE(alloc_tag_trace_key);
+
 static inline bool mem_alloc_profiling_enabled(void)
 {
 	return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 				   &mem_alloc_profiling_key);
 }
 
+static inline bool alloc_tag_trace_enabled(void)
+{
+	return static_branch_unlikely(&alloc_tag_trace_key);
+}
+
+void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
+			       size_t bytes);
+
+void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
+			      size_t bytes);
+
+void __alloc_tag_trace_hit(struct alloc_tag *tag);
+
+static __always_inline void alloc_tag_trace_hit(struct alloc_tag *tag)
+{
+	if (alloc_tag_trace_enabled())
+		__alloc_tag_trace_hit(tag);
+}
+
 bool mem_alloc_profiling_permanently_disabled(void);
 
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
@@ -198,13 +219,19 @@ static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
 	return true;
 }
 
-static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
+static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes,
+				 const void *ptr)
 {
-	if (likely(alloc_tag_ref_set(ref, tag)))
+	if (likely(alloc_tag_ref_set(ref, tag))) {
 		this_cpu_add(tag->counters->bytes, bytes);
+
+		if (alloc_tag_trace_enabled())
+			/* Trace successful allocs with their unique ptr */
+			alloc_tag_trace_mem_alloc(ptr, tag, bytes);
+	}
 }
 
-static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
+static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes, const void *ptr)
 {
 	struct alloc_tag *tag;
 
@@ -222,6 +249,10 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 	this_cpu_sub(tag->counters->bytes, bytes);
 	this_cpu_dec(tag->counters->calls);
 
+	if (alloc_tag_trace_enabled())
+		/* Trace frees with their unique ptr */
+		alloc_tag_trace_mem_free(ptr, tag, bytes);
+
 	ref->ct = NULL;
 }
 
@@ -243,25 +274,29 @@ static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
 static inline bool mem_alloc_profiling_enabled(void) { return false; }
 static inline bool mem_alloc_profiling_permanently_disabled(void) { return true; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
-				 size_t bytes) {}
-static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
+				 size_t bytes, const void *ptr) {}
+static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes,
+				 const void *ptr) {}
 static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
 static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
+#define alloc_tag_trace_hit(_tag)	/* NOOP */
 #define alloc_tag_record(p)	do {} while (0)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
-#define alloc_hooks_tag(_tag, _do_alloc)				\
-({									\
-	typeof(_do_alloc) _res;						\
-	if (mem_alloc_profiling_enabled()) {				\
-		struct alloc_tag * __maybe_unused _old;			\
-		_old = alloc_tag_save(_tag);				\
-		_res = _do_alloc;					\
-		alloc_tag_restore(_tag, _old);				\
-	} else								\
-		_res = _do_alloc;					\
-	_res;								\
+#define alloc_hooks_tag(_tag, _do_alloc)					\
+({										\
+	typeof(_do_alloc) _res;							\
+	if (mem_alloc_profiling_enabled()) {					\
+		struct alloc_tag * __maybe_unused _old;				\
+		/* Fired here to capture the caller's stack trace */	\
+		alloc_tag_trace_hit(_tag);					\
+		_old = alloc_tag_save(_tag);					\
+		_res = _do_alloc;						\
+		alloc_tag_restore(_tag, _old);					\
+	} else									\
+		_res = _do_alloc;						\
+	_res;									\
 })
 
 #define alloc_hooks(_do_alloc)						\
diff --git a/include/trace/events/alloc_tag.h b/include/trace/events/alloc_tag.h
new file mode 100644
index 000000000000..58d420e64516
--- /dev/null
+++ b/include/trace/events/alloc_tag.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM alloc_tag
+
+#if !defined(_TRACE_ALLOC_TAG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ALLOC_TAG_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * alloc_tag_hit is generated at the exact allocation call site and can be
+ * used to capture a stack trace.
+ *
+ * To link this stack trace to the actual allocated memory chunk, tools must
+ * correlate this event with the resulting alloc_tag_mem_alloced event. Since
+ * multiple threads can hit the same tag simultaneously, tools must match BOTH
+ * the `tag` field and the implicitly recorded PID provided by the core
+ * tracing subsystem.
+ */
+TRACE_EVENT(alloc_tag_hit,
+	TP_PROTO(struct alloc_tag *tag),
+
+	TP_ARGS(tag),
+
+	TP_STRUCT__entry(__field(struct alloc_tag *, tag)
+			 __string(modname, tag->ct.modname ? tag->ct.modname : "NONE")
+			 __string(filename, tag->ct.filename)
+			 __string(function, tag->ct.function)
+			 __field(unsigned int, lineno)
+	),
+
+	TP_fast_assign(__entry->tag = tag;
+		       __assign_str(modname);
+		       __assign_str(filename);
+		       __assign_str(function);
+		       __entry->lineno = tag->ct.lineno;
+	),
+
+	TP_printk("tag %p, module: %s, filename: %s, function %s, lineno %u",
+		  __entry->tag,
+		  __get_str(modname),
+		  __get_str(filename),
+		  __get_str(function),
+		  __entry->lineno
+	)
+);
+
+/*
+ * alloc_tag_mem_alloced is generated after memory is successfully allocated.
+ * It captures the exact byte size.
+ *
+ * The `ptr` value identifies the memory chunk for tracking its lifecycle
+ * (e.g., matching it with alloc_tag_mem_freed).
+ * - slab and percpu allocators: address of the object's codetag_ref
+ * - page allocator: the head struct page of the allocation
+ *
+ * Because the kernel isolates active allocations within the task struct
+ * (current->alloc_tag), this event will always share the same implicit PID as
+ * its corresponding alloc_tag_hit event. Tools should use the combination
+ * PID + `tag` to correlate them.
+ */
+TRACE_EVENT(alloc_tag_mem_alloced,
+	TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
+
+	TP_ARGS(ptr, tag, bytes),
+
+	TP_STRUCT__entry(__field(const void *, ptr)
+			 __field(struct alloc_tag *, tag)
+			 __field(size_t, bytes)
+	),
+
+	TP_fast_assign(__entry->ptr = ptr;
+		       __entry->tag = tag;
+		       __entry->bytes = bytes;
+	),
+
+	TP_printk("ptr %p, tag %p, bytes %zu",
+		  __entry->ptr,
+		  __entry->tag,
+		  __entry->bytes
+	)
+);
+
+/*
+ * alloc_tag_mem_freed event is generated immediately before memory is
+ * freed. The `ptr` value matches the one emitted during allocation,
+ * allowing tools to match it to its corresponding allocation and
+ * call stack.
+ *
+ * Page allocator caveat: Pages can be split or moved to another folio
+ * after the alloc event with no new events generated for that. As a
+ * result, a free event may carry a `ptr` that never appeared in an
+ * alloc event, and the `bytes` may be smaller than in the matching
+ * alloc event. Tools must not assume alloc bytes == free bytes, nor
+ * that every free has a matching alloc.
+ */
+TRACE_EVENT(alloc_tag_mem_freed,
+	TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
+
+	TP_ARGS(ptr, tag, bytes),
+
+	TP_STRUCT__entry(__field(const void *, ptr)
+			 __field(struct alloc_tag *, tag)
+			 __field(size_t, bytes)
+	),
+
+	TP_fast_assign(__entry->ptr = ptr;
+		       __entry->tag = tag;
+		       __entry->bytes = bytes;
+	),
+
+	TP_printk("ptr %p, tag %p, bytes %zu",
+		  __entry->ptr,
+		  __entry->tag,
+		  __entry->bytes
+	)
+);
+
+#endif /* _TRACE_ALLOC_TAG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 82e2c3448dcf..ca2412a67312 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -18,6 +18,9 @@
 #include <linux/kmemleak.h>
 #include <uapi/linux/alloc_tag.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/alloc_tag.h>
+
 #include "internal.h"
 #include "page_alloc.h"
 
@@ -54,6 +57,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
 
 DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
 
+DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
+EXPORT_SYMBOL(alloc_tag_trace_key);
+
 struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
 unsigned long alloc_tag_ref_mask;
 int alloc_tag_ref_offs;
@@ -484,6 +490,28 @@ static const struct proc_ops allocinfo_proc_ops = {
 #endif
 };
 
+void __alloc_tag_trace_hit(struct alloc_tag *tag)
+{
+	if (unlikely(!tag))
+		return;
+	trace_alloc_tag_hit(tag);
+}
+EXPORT_SYMBOL(__alloc_tag_trace_hit);
+
+void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
+			       size_t bytes)
+{
+	trace_alloc_tag_mem_alloced(ptr, tag, bytes);
+}
+EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
+
+void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
+			      size_t bytes)
+{
+	trace_alloc_tag_mem_freed(ptr, tag, bytes);
+}
+EXPORT_SYMBOL(alloc_tag_trace_mem_free);
+
 size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
 {
 	struct codetag_iterator iter;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2daf358269ae..e8bb12a6a721 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1241,7 +1241,7 @@ void __pgalloc_tag_add(struct page *page, struct task_struct *task,
 	union codetag_ref ref;
 
 	if (likely(get_page_tag_ref(page, &ref, &handle))) {
-		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
+		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr, page);
 		update_page_tag_ref(handle, &ref);
 		put_page_tag_ref(handle);
 	} else {
@@ -1270,7 +1270,7 @@ void __pgalloc_tag_sub(struct page *page, unsigned int nr)
 	union codetag_ref ref;
 
 	if (get_page_tag_ref(page, &ref, &handle)) {
-		alloc_tag_sub(&ref, PAGE_SIZE * nr);
+		alloc_tag_sub(&ref, PAGE_SIZE * nr, page);
 		update_page_tag_ref(handle, &ref);
 		put_page_tag_ref(handle);
 	}
diff --git a/mm/percpu.c b/mm/percpu.c
index d7883507dc15..16f29020bcad 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1695,16 +1695,19 @@ static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
 				      size_t size)
 {
 	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
-		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
-			      current->alloc_tag, pcpu_obj_full_size(size));
+		union codetag_ref *ref = &chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag;
+
+		alloc_tag_add(ref, current->alloc_tag, pcpu_obj_full_size(size), ref);
 	}
 }
 
 static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
-	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
-		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
-			      pcpu_obj_full_size(size));
+	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		union codetag_ref *ref = &chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag;
+
+		alloc_tag_sub(ref, pcpu_obj_full_size(size), ref);
+	}
 }
 #else
 static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
diff --git a/mm/slub.c b/mm/slub.c
index 544cff39762c..a866576ccb98 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2404,7 +2404,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
 		obj_ext = slab_obj_ext(s, slab, obj_exts, object);
 		ref = slab_obj_ext_codetag_ref(slab, obj_ext);
 
-		alloc_tag_add(ref, current->alloc_tag, s->size);
+		alloc_tag_add(ref, current->alloc_tag, s->size, ref);
 
 		put_slab_obj_exts(obj_exts);
 	} else {
@@ -2444,9 +2444,11 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	get_slab_obj_exts(obj_exts);
 	for (int i = 0; i < objects; i++) {
 		struct slabobj_ext *ext;
+		union codetag_ref *ref;
 
 		ext = slab_obj_ext(s, slab, obj_exts, p[i]);
-		alloc_tag_sub(slab_obj_ext_codetag_ref(slab, ext), s->size);
+		ref = slab_obj_ext_codetag_ref(slab, ext);
+		alloc_tag_sub(ref, s->size, ref);
 	}
 	put_slab_obj_exts(obj_exts);
 }
-- 
2.56.0.218.g1ec904b173-goog

