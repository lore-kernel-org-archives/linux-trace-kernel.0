Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409928003A;
	Wed, 11 Feb 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823412; cv=none; b=sdmW/zWdPd+sKcRcYZnptpq16alB1D+Qrd7sB83TNWHM7QOPnvUoUBexwYFZVkPmuryX9iATn8nF54H0n8G01m5xxa7Eet5fd1wI2sMqq+HQAd1cB3VZjltJ4Rnw+ccsCRdzC6y4nocwujJoyRDZeUA6OoJOybpmBqnmPKArENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823412; c=relaxed/simple;
	bh=Wg+tozHMNvvqYzCeEMnnMMz2oiyvzq2d+LAvxIuEgpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxZ1gtG1+msDSm3yuY/ACtgR2cpqA/99sLF7gWv0kv4PYDiTh6F+C+jJEC04mN7xkj4gyvPzZpJBn0IDL2lybgZPEQyjcycCvgn6Lx+y6LXL+VB5HnEMolOFGL2o5LlAS/0xCC/QZhgHcqVkvyUVmZb99FX7qsBpf2cIMhrD3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=EnNKT7M3; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="EnNKT7M3"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id B6507B2591;
	Wed, 11 Feb 2026 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1770823404;
	bh=WI9HzWB33RHOS7x2iM4is6SHnBj+us5QajX97yLBu8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EnNKT7M3TS3ryf7KVT447cgDcaIceytqYXzKU1+bD221uVnfKF5m7bpAMnXDRHx79
	 7pvy+2IjemivNf4Iu5+zUFr0aAZ1nDn2Yx8vgl6Ew9riIW67mirzm3v/bMBLk1fhh0
	 1nqXinwuEJ6IksxPU61gSyVI39gCQxtp+yEpEsF0=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 4/4] mm: add tracepoints for zone lock
Date: Wed, 11 Feb 2026 15:22:16 +0000
Message-ID: <1d2a7778aeee03abf8a11528ce8d4926ca78e9b4.1770821420.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770821420.git.d@ilvokhin.com>
References: <cover.1770821420.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracepoint instrumentation to zone lock acquire/release operations
via the previously introduced wrappers.

The implementation follows the mmap_lock tracepoint pattern: a
lightweight inline helper checks whether the tracepoint is enabled and
calls into an out-of-line helper when tracing is active. When
CONFIG_TRACING is disabled, helpers compile to empty inline stubs.

The fast path is unaffected when tracing is disabled.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 MAINTAINERS                      |  2 +
 include/linux/zone_lock.h        | 64 +++++++++++++++++++++++++++++++-
 include/trace/events/zone_lock.h | 64 ++++++++++++++++++++++++++++++++
 mm/Makefile                      |  2 +-
 mm/zone_lock.c                   | 31 ++++++++++++++++
 5 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/zone_lock.h
 create mode 100644 mm/zone_lock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 680c9ae02d7e..711ffa15f4c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16499,6 +16499,7 @@ F:	include/linux/ptdump.h
 F:	include/linux/vmpressure.h
 F:	include/linux/vmstat.h
 F:	include/linux/zone_lock.h
+F:	include/trace/events/zone_lock.h
 F:	kernel/fork.c
 F:	mm/Kconfig
 F:	mm/debug.c
@@ -16518,6 +16519,7 @@ F:	mm/sparse.c
 F:	mm/util.c
 F:	mm/vmpressure.c
 F:	mm/vmstat.c
+F:	mm/zone_lock.c
 N:	include/linux/page[-_]*
 
 MEMORY MANAGEMENT - EXECMEM
diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
index c531e26280e6..cea41dd56324 100644
--- a/include/linux/zone_lock.h
+++ b/include/linux/zone_lock.h
@@ -4,6 +4,53 @@
 
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/tracepoint-defs.h>
+
+DECLARE_TRACEPOINT(zone_lock_start_locking);
+DECLARE_TRACEPOINT(zone_lock_acquire_returned);
+DECLARE_TRACEPOINT(zone_lock_released);
+
+#ifdef CONFIG_TRACING
+
+void __zone_lock_do_trace_start_locking(struct zone *zone);
+void __zone_lock_do_trace_acquire_returned(struct zone *zone, bool success);
+void __zone_lock_do_trace_released(struct zone *zone);
+
+static inline void __zone_lock_trace_start_locking(struct zone *zone)
+{
+	if (tracepoint_enabled(zone_lock_start_locking))
+		__zone_lock_do_trace_start_locking(zone);
+}
+
+static inline void __zone_lock_trace_acquire_returned(struct zone *zone,
+						      bool success)
+{
+	if (tracepoint_enabled(zone_lock_acquire_returned))
+		__zone_lock_do_trace_acquire_returned(zone, success);
+}
+
+static inline void __zone_lock_trace_released(struct zone *zone)
+{
+	if (tracepoint_enabled(zone_lock_released))
+		__zone_lock_do_trace_released(zone);
+}
+
+#else /* !CONFIG_TRACING */
+
+static inline void __zone_lock_trace_start_locking(struct zone *zone)
+{
+}
+
+static inline void __zone_lock_trace_acquire_returned(struct zone *zone,
+						      bool success)
+{
+}
+
+static inline void __zone_lock_trace_released(struct zone *zone)
+{
+}
+
+#endif /* CONFIG_TRACING */
 
 static inline void zone_lock_init(struct zone *zone)
 {
@@ -12,26 +59,41 @@ static inline void zone_lock_init(struct zone *zone)
 
 #define zone_lock_irqsave(zone, flags)				\
 do {								\
+	bool success = true;					\
+								\
+	__zone_lock_trace_start_locking(zone);			\
 	spin_lock_irqsave(&(zone)->lock, flags);		\
+	__zone_lock_trace_acquire_returned(zone, success);	\
 } while (0)
 
 #define zone_trylock_irqsave(zone, flags)			\
 ({								\
-	spin_trylock_irqsave(&(zone)->lock, flags);		\
+	bool success;						\
+								\
+	__zone_lock_trace_start_locking(zone);			\
+	success = spin_trylock_irqsave(&(zone)->lock, flags);	\
+	__zone_lock_trace_acquire_returned(zone, success);	\
+	success;						\
 })
 
 static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
 {
+	__zone_lock_trace_released(zone);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static inline void zone_lock_irq(struct zone *zone)
 {
+	bool success = true;
+
+	__zone_lock_trace_start_locking(zone);
 	spin_lock_irq(&zone->lock);
+	__zone_lock_trace_acquire_returned(zone, success);
 }
 
 static inline void zone_unlock_irq(struct zone *zone)
 {
+	__zone_lock_trace_released(zone);
 	spin_unlock_irq(&zone->lock);
 }
 
diff --git a/include/trace/events/zone_lock.h b/include/trace/events/zone_lock.h
new file mode 100644
index 000000000000..3df82a8c0160
--- /dev/null
+++ b/include/trace/events/zone_lock.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM zone_lock
+
+#if !defined(_TRACE_ZONE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ZONE_LOCK_H
+
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+struct zone;
+
+DECLARE_EVENT_CLASS(zone_lock,
+
+	TP_PROTO(struct zone *zone),
+
+	TP_ARGS(zone),
+
+	TP_STRUCT__entry(
+		__field(struct zone *, zone)
+	),
+
+	TP_fast_assign(
+		__entry->zone = zone;
+	),
+
+	TP_printk("zone=%p", __entry->zone)
+);
+
+#define DEFINE_ZONE_LOCK_EVENT(name)			\
+	DEFINE_EVENT(zone_lock, name,			\
+		TP_PROTO(struct zone *zone),		\
+		TP_ARGS(zone))
+
+DEFINE_ZONE_LOCK_EVENT(zone_lock_start_locking);
+DEFINE_ZONE_LOCK_EVENT(zone_lock_released);
+
+TRACE_EVENT(zone_lock_acquire_returned,
+
+	TP_PROTO(struct zone *zone, bool success),
+
+	TP_ARGS(zone, success),
+
+	TP_STRUCT__entry(
+		__field(struct zone *, zone)
+		__field(bool, success)
+	),
+
+	TP_fast_assign(
+		__entry->zone = zone;
+		__entry->success = success;
+	),
+
+	TP_printk(
+		"zone=%p success=%s",
+		__entry->zone,
+		__entry->success ? "true" : "false"
+	)
+);
+
+#endif /* _TRACE_ZONE_LOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/Makefile b/mm/Makefile
index 0d85b10dbdde..fd891710c696 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -55,7 +55,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o show_mem.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o zone_lock.o vma_init.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/zone_lock.c b/mm/zone_lock.c
new file mode 100644
index 000000000000..f647fd2aca48
--- /dev/null
+++ b/mm/zone_lock.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#define CREATE_TRACE_POINTS
+#include <trace/events/zone_lock.h>
+
+#include <linux/zone_lock.h>
+
+EXPORT_TRACEPOINT_SYMBOL(zone_lock_start_locking);
+EXPORT_TRACEPOINT_SYMBOL(zone_lock_acquire_returned);
+EXPORT_TRACEPOINT_SYMBOL(zone_lock_released);
+
+#ifdef CONFIG_TRACING
+
+void __zone_lock_do_trace_start_locking(struct zone *zone)
+{
+	trace_zone_lock_start_locking(zone);
+}
+EXPORT_SYMBOL(__zone_lock_do_trace_start_locking);
+
+void __zone_lock_do_trace_acquire_returned(struct zone *zone, bool success)
+{
+	trace_zone_lock_acquire_returned(zone, success);
+}
+EXPORT_SYMBOL(__zone_lock_do_trace_acquire_returned);
+
+void __zone_lock_do_trace_released(struct zone *zone)
+{
+	trace_zone_lock_released(zone);
+}
+EXPORT_SYMBOL(__zone_lock_do_trace_released);
+
+#endif /* CONFIG_TRACING */
-- 
2.47.3

