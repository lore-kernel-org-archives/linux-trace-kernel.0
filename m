Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BC358D2E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686788; cv=none; b=p9MIX8RnenJm/1V2wK3bB47qoIBvVtEAz00NklZChmdoyjSvtfBmeq6qDoh40J7RwFietUYicCvigAm/cSNpKsbWGU4SuR7BnSHbHhS5cL1BK2Hiy9YhP/uqooi1g6iH4t0Aqi0uk8fCOB/mqfcFP0X1Mk+SuecS3dV7d0bUAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686788; c=relaxed/simple;
	bh=BOs6JgCi8AjR74vw93U20UCPtCoQhB7p2LgmbsDFn9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQE6ciS+mwPunTatc7YBhgyiUd1BG5oAdmyUKnA9jMZarkZDUq8d7NDYae1FRcSDexaMjZR7tkR0hupuhHKQunjxYKpMhkKvmt3uP7RU4kfOcLDtkvaN7+pkK5iP2J7x4IoLNwmui7uiZiDGfvVk4jmGQZ3pl4606AH0vvPoOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPGyrxHZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPGyrxHZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28bd8b3fa67so54211915ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686786; x=1762291586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT6L9Wf8vYbbxkXQC/mV6lXNvx+aGP0etQXMbdvClGk=;
        b=oPGyrxHZIlmgCkGqb6RH5S+ELHpT6wtPWeemkSmVjsaMP1fmSOmM/2q8mqM6H/M9dn
         ABws1kjoP0pLOsW3kqVHD71PPK5/LZKmjF2WWOmAdn4IHSsbE4stm+Dc2YxKSiUh9kx5
         hTtGT4znmlmT1s7wd1UKU/XQb7S0YrOX2xEer0hEJ4Pz4EpS3ttWMLoGFfTc0BLBO8M2
         L6/M3tjd/kDOMk+Ehptume1SgEiQryY3NlM5c3kjh0x6ckeqYcEXrUKYbd90J03oBZHA
         HjtPRt3lPSQSToMkabDE6t4fRPUKWXYAP+X8tSDGiiNWsbGrlOTODlU3/IMNARhyJO4p
         F6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686786; x=1762291586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT6L9Wf8vYbbxkXQC/mV6lXNvx+aGP0etQXMbdvClGk=;
        b=czUAQlsW2rQHJ/TRl30qRdhF+1+P1I+urJ0KHmLc+aCCovNnbZwO9A7v/COKQG0WE7
         ZgymrL1niaZz5o2stU5CZvZpQ3dqIM6SdUuynsU5yA/ncSkjhluStoPDipTC/ffB6zcb
         G9rRLGi+cwmPuJWoh8e84z7+MJqRDaPfjYwb7fcosqpsmme5+W26Rwbwr/sPckarjE4O
         3nOJK64vI5zYVYYzCOE7YKR8wKINYmyRE5KY/VtJIPjiw8kCvGW7APTY2/LP6h82mTIc
         3cRD3aADVC08/bAs9t4UZ9Uox0kZdcScQ42c2RT+oNHJ7pbQTLMQILKb3dt24XBGfUMN
         OJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOLTAVTNwLtkA8q/DgYzJImrZlhWBr5OXi1oYpOwd/66WyDa6if15cUmrc8jHf1AvDV8ih5GiR9uNsXoNGWKmLk9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsrwRWUfFiFx7EgZIslykd/0xKgkJCifa5SEAOk3vXpqcWNaR
	7TTeGYxF59yrA1+cdEEBb8HFaDBCcDQOHw6muJvN5SL9rxQKu6RdxU8WydFDs5YWXjwsoLRpyer
	UZRHKmBJbrQ4erkFo3YwBUxyUxQ==
X-Google-Smtp-Source: AGHT+IFi6r0zdzbXdNzU52THvRuL2ZA/3vJbtaWuyVKp1vecZPNJs9dG6E1pIVYt/viPctamQhX27/sMjMfGtOyTrQ==
X-Received: from pldv19.prod.google.com ([2002:a17:902:ca93:b0:290:28e2:ce4c])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c1c9:b0:249:3efa:3c99 with SMTP id d9443c01a7336-294def30f8cmr3834515ad.61.1761686786161;
 Tue, 28 Oct 2025 14:26:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:36 -0700
In-Reply-To: <20251028212528.681081-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212528.681081-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-6-kaleshsingh@google.com>
Subject: [PATCH v4 5/5] mm/tracing: introduce trace_mm_insufficient_vma_slots event
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce the trace_mm_insufficient_vma_slots tracepoint to improve
observability of VMA allocation failures.

This event fires when an operation is about to fail because it requires
more VMA slots than are currently available, according to the
sysctl_max_map_count limit. This is a preemptive check that occurs in
call paths like mmap(), mremap(), and split_vma() before they attempt
to create new VMAs.

This tracepoint can be used with event-driven telemetry, such as BPF
programs, to collect data from devices in the field with minimal
overhead.

The tracepoint captures the mm_struct pointer and the current vma_count
at the time of failure. This allows for observing the distribution of
these events to determine if there are legitimate bugs or if an increase
to the limit is warranted.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
 - Update commit description to accurately reflect the trace event's
   parameters.

Changes in v3:
 - capture the mm pointer as the unique identifier and capture
   the vma_count as well, instead of current task tgid, per Steve
 - Add include/trace/events/vma.h to MEMORY MAPPING section in
   MAINTAINERS, per Lorenzo
 - rename trace_max_vma_count_exceeded() to
   trace_mm_insufficient_vma_slots(), since this is a preemptive
   check, per Lorenzo
 - Fix tools/testing/vma build errors, per Lorenzo

 MAINTAINERS                      |  1 +
 include/trace/events/vma.h       | 32 ++++++++++++++++++++++++++++++++
 mm/mmap.c                        |  5 ++++-
 mm/mremap.c                      | 10 ++++++++--
 mm/vma.c                         |  4 +++-
 mm/vma_internal.h                |  2 ++
 tools/testing/vma/vma_internal.h |  5 +++++
 7 files changed, 55 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/vma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 66f7ca5b01ad..223124cb7d21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16567,6 +16567,7 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/trace/events/mmap.h
+F:	include/trace/events/vma.h
 F:	mm/interval_tree.c
 F:	mm/mincore.c
 F:	mm/mlock.c
diff --git a/include/trace/events/vma.h b/include/trace/events/vma.h
new file mode 100644
index 000000000000..4540fa607f66
--- /dev/null
+++ b/include/trace/events/vma.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vma
+
+#if !defined(_TRACE_VMA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VMA_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mm_insufficient_vma_slots,
+
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+		__field(void *,	mm)
+		__field(int,	vma_count)
+	),
+
+	TP_fast_assign(
+		__entry->mm		= mm;
+		__entry->vma_count	= mm->vma_count;
+	),
+
+	TP_printk("mm=%p vma_count=%d", __entry->mm, __entry->vma_count)
+);
+
+#endif /*  _TRACE_VMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index 647a676c0ab4..3ebe9d5f7dfe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -56,6 +56,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmap.h>
+#include <trace/events/vma.h>
 
 #include "internal.h"
 
@@ -383,8 +384,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * sysctl_max_map_count limit by one. This behavior is preserved to
 	 * avoid breaking existing applications.
 	 */
-	if (max_vma_count() - mm->vma_count < 0)
+	if (max_vma_count() - mm->vma_count < 0) {
+		trace_mm_insufficient_vma_slots(mm);
 		return -ENOMEM;
+	}
 
 	/*
 	 * addr is returned from get_unmapped_area,
diff --git a/mm/mremap.c b/mm/mremap.c
index 4874729cd65c..dfb481c5bfb1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -30,6 +30,8 @@
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
 
+#include <trace/events/vma.h>
+
 #include "internal.h"
 
 /* Classify the kind of remap operation being performed. */
@@ -1040,8 +1042,10 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (max_vma_count() - current->mm->vma_count < 4)
+	if (max_vma_count() - current->mm->vma_count < 4) {
+		trace_mm_insufficient_vma_slots(current->mm);
 		return -ENOMEM;
+	}
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
@@ -1814,8 +1818,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * the threshold. In other words, is the current map count + 6 at or
 	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if (max_vma_count() - current->mm->vma_count < 6)
+	if (max_vma_count() - current->mm->vma_count < 6) {
+		trace_mm_insufficient_vma_slots(current->mm);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/mm/vma.c b/mm/vma.c
index fbb8d1a0449d..2c35c3d008bc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -594,8 +594,10 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (max_vma_count() - vma->vm_mm->vma_count < 1)
+	if (max_vma_count() - vma->vm_mm->vma_count < 1) {
+		trace_mm_insufficient_vma_slots(vma->vm_mm);
 		return -ENOMEM;
+	}
 
 	return __split_vma(vmi, vma, addr, new_below);
 }
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index 2f05735ff190..86823ca6857b 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -52,4 +52,6 @@
 
 #include "internal.h"
 
+#include <trace/events/vma.h>
+
 #endif	/* __MM_VMA_INTERNAL_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index d89b26e81679..0fdde2eb5a57 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1497,4 +1497,9 @@ static int max_vma_count(void)
 	return sysctl_max_map_count;
 }
 
+/* Stub for trace_mm_insufficient_vma_slots */
+static inline void trace_mm_insufficient_vma_slots(struct mm_struct *mm)
+{
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.1.851.g4ebd6896fd-goog

