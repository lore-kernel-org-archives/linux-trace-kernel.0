Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DF28506A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954848; cv=none; b=L1nYTCa514JYtXIHeCO11mGf/gv7B1sX1tdJiEaLN22OMvJfaLha7C9PI8X5YRnbDiD7LQN718Q403cBa2iGE6CdEW7+gQfBuw78vcdTTE566qEfO41QDcRb23FpJtZeyqpTX3fSUqDcY2k5lpff8gzx0gKdBlGpe/kWzHjlkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954848; c=relaxed/simple;
	bh=XFR6sya9J2xG2hfxSf1a8GNZ3av4lo6QHIK09umVRAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bsajpEa1xmUHcbJeKfPLuiIfLDc2JzZJFQ15BFf/4GeX1BybKzMe0bVTVaROFr7t1vktNi5Ffl5b0Y37BJRBhen6+VErERgShNAjFB3+ydX1521+hhizagw4Q1nSr/PHVIuTO9dcjJ4vaiQmSmdtYUD49gMyJJPCKzO061+JTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4QAmWol; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4QAmWol"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26076dd11d1so24527765ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954845; x=1758559645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59uH0/Rs24hPqNuUZQXolv8jQt8VsNO5VNNB4W0XCmc=;
        b=g4QAmWolSYP/Ed9ydbSy+KIA8l92LSjJj+8sG3pzGH5w13aHY+AiLC3d+3C6gOLUSi
         eyOQL+EixJoK8kycW0C2xNJdBqrMbodeultUPbyJhxugZSLs1rcqX0oLcwQ11h42ZZ3I
         HxI115Q/I55b2pos6MXXkNHm7oquDjII6JxW81cnJddBTRrQ9y/vjLtp3WWSRoQNyBjt
         JLlzNO7Aj7W569UK/AIqBVgF7o4rJo65wmzm6wYhKO/15ypJXRWi37MD+3OII4iv+RRV
         ojSpkz8CU3zHn9X5Dpu+AzG7asbpSAGBoBPt9a8LB9Uh10wtd1slV7/dCJiTKv7V7I+o
         BICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954845; x=1758559645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59uH0/Rs24hPqNuUZQXolv8jQt8VsNO5VNNB4W0XCmc=;
        b=C52JmofL6+3MQxQUPQJ/YgpmUzl17p5R/X3cbt5V80oRZoWyktFgBYEKsZ4BkLK17j
         anDJFaDqdlDZ93sOsnAM/N+vsB6kVICsRyaVlJR9lmMAWKc1kjqaT/s1BLM2D8oeTgZr
         oMa5dzp0s8wlFMY0kr20Z5ARtxyt/13fNs+rPVxdyOqFrsDs1FBcFFER5HyIBqJwvy1e
         4l/TfMRgF7ICj8n2cw/LZPqRpQ1aJbGunDaAvD1xroUQOtGoq08JvJHWldFRHTVpAlq1
         npWKb0XiHIy+kNp1YLIDm5kLcIKSC2fEG+e3l1Lr1r2cHAd6XkEOxyWBvpjGfNW6Hwko
         oouw==
X-Forwarded-Encrypted: i=1; AJvYcCUgxu7NxOjSwh6AQ4NsxpPnNSWriLrlbn4zbYdynzAdWmrByCe3sUcX2uf0Qcwm6w7j95c8aauEo6+yhLQESjxEJBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ck/r5vNtCivX5Vus+arBM8q/r/dG0VvGDFfqmSXyGkZpFEgD
	ONvhmo/+3QWZWcyGDd3w+PBscafQmMqD8DtqPOopphGzaU2lhZIFIN0d/YFdxNvKHhQFEzurAmm
	Kb9Kx5pqFwUTwqHHmjtlEZFHLog==
X-Google-Smtp-Source: AGHT+IHzc/fMWSswS4eA5+I14M9qXHKcg1jQwLLx5RpIwI8nZ9BGgFMV8dLNy7m9xz0Qp5xRzbGmEY4nirx7Uqh/jg==
X-Received: from plhs1.prod.google.com ([2002:a17:903:3201:b0:24c:b6df:675e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d552:b0:260:df70:f753 with SMTP id d9443c01a7336-260df70fbdcmr125334005ad.38.1757954845285;
 Mon, 15 Sep 2025 09:47:25 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:38 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-8-kaleshsingh@google.com>
Subject: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Needed observability on in field devices can be collected with minimal
overhead and can be toggled on and off. Event driven telemetry can be
done with tracepoint BPF programs.

The process comm is provided for aggregation across devices and tgid is
to enable per-process aggregation per device.

This allows for observing the distribution of such problems in the
field, to deduce if there are legitimate bugs or if a bump to the limit is
warranted.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Chnages in v2:
  - Add needed observability for operations failing due to the vma count limit,
      per Minchan
    (Since there isn't a common point for debug logging due checks being
    external to the capacity based vma_count_remaining() helper. I used a
    trace event for low overhead and to facilitate event driven telemetry
    for in field devices)

 include/trace/events/vma.h | 32 ++++++++++++++++++++++++++++++++
 mm/mmap.c                  |  5 ++++-
 mm/mremap.c                | 10 ++++++++--
 mm/vma.c                   | 11 +++++++++--
 4 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 include/trace/events/vma.h

diff --git a/include/trace/events/vma.h b/include/trace/events/vma.h
new file mode 100644
index 000000000000..2fed63b0d0a6
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
+TRACE_EVENT(max_vma_count_exceeded,
+
+	TP_PROTO(struct task_struct *task),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__string(comm,	task->comm)
+		__field(pid_t,	tgid)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->tgid = task->tgid;
+	),
+
+	TP_printk("comm=%s tgid=%d", __get_str(comm), __entry->tgid)
+);
+
+#endif /*  _TRACE_VMA_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index 30ddd550197e..0bb311bf48f3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -56,6 +56,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmap.h>
+#include <trace/events/vma.h>
 
 #include "internal.h"
 
@@ -374,8 +375,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (!vma_count_remaining(mm))
+	if (!vma_count_remaining(mm)) {
+		trace_max_vma_count_exceeded(current);
 		return -ENOMEM;
+	}
 
 	/*
 	 * addr is returned from get_unmapped_area,
diff --git a/mm/mremap.c b/mm/mremap.c
index 14d35d87e89b..f42ac05f0069 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -30,6 +30,8 @@
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 
+#include <trace/events/vma.h>
+
 #include "internal.h"
 
 /* Classify the kind of remap operation being performed. */
@@ -1040,8 +1042,10 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (vma_count_remaining(current->mm) < 4)
+	if (vma_count_remaining(current->mm) < 4) {
+		trace_max_vma_count_exceeded(current);
 		return -ENOMEM;
+	}
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
@@ -1817,8 +1821,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * the threshold. In other words, is the current map count + 6 at or
 	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if (vma_count_remaining(current->mm) < 6)
+	if (vma_count_remaining(current->mm) < 6) {
+		trace_max_vma_count_exceeded(current);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/mm/vma.c b/mm/vma.c
index 0e4fcaebe209..692c33c3e84d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,6 +7,8 @@
 #include "vma_internal.h"
 #include "vma.h"
 
+#include <trace/events/vma.h>
+
 struct mmap_state {
 	struct mm_struct *mm;
 	struct vma_iterator *vmi;
@@ -621,8 +623,10 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (!vma_count_remaining(vma->vm_mm))
+	if (!vma_count_remaining(vma->vm_mm)) {
+		trace_max_vma_count_exceeded(current);
 		return -ENOMEM;
+	}
 
 	return __split_vma(vmi, vma, addr, new_below);
 }
@@ -1375,6 +1379,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 */
 		if (vms->end < vms->vma->vm_end &&
 		    !vma_count_remaining(vms->vma->vm_mm)) {
+			trace_max_vma_count_exceeded(current);
 			error = -ENOMEM;
 			goto vma_count_exceeded;
 		}
@@ -2801,8 +2806,10 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (!vma_count_remaining(mm))
+	if (!vma_count_remaining(mm)) {
+		trace_max_vma_count_exceeded(current);
 		return -ENOMEM;
+	}
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
-- 
2.51.0.384.g4c02a37b29-goog

