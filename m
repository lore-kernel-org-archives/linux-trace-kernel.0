Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCD28DBD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709613; cv=none; b=feYk+ttnF2m0vroB4odTYG3wtkdgnV/B2VtC/oVgjkfLCrLnbPgqzn5Yayb9DLi/BzUT3yyDh/K6xDWcGjrHPcAFRQU3GaN71Mo90xS59VRSZiGkbfcnBxDVDdlJfXT2mtvfNUVYj6IE8XENzYZdBIN120KkeNBs7KigcqqoWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709613; c=relaxed/simple;
	bh=kDiVEVqGIbNw48l4VCGSSBQ5AM/n6nqj601r1w7M4Zk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W9oYgJRnlf+QRdfe2ABu3ysQOWIrpPe0yy8izE5NSigfrFwLQJt2TfynSFpV9ABglgh4rIwl0Pp6EE6GhRP1gN/lPr3YuhmzJGk0sVVhBJZKV69/ekcUNF4JscPgxmmr6iE7cQ9nQ+U5ikNHj+MDu39DEWDMhKugut20aSCc3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--carlosgalo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS9UdDs/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--carlosgalo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS9UdDs/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1649405276.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708709611; x=1709314411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uB4sepnqluOGCQzWosSupcXtilnk0cI5dxVNZLd+dk0=;
        b=aS9UdDs/asUHqbLFhlLFO7FZS4nhi9cOhTD2O76p3kEGdqf4Uneafmh5ZSMwKARhE0
         IA7BVW8zxhRgV1ctFFEsYIJcSyd7GPxnX2XuAN6gzveZNfxJsA2ZmgvtLenAfg0nqGkb
         ubpeTp1HSdGIOvPhZeR5AmGndSQ+3ZmziQtRCU0TkPKKK7Nq38RQkVmj3FcS5eCCophu
         yj7XNldli3jUX79cKl2o7BIB67uTfcq797i3GZBQwCQO+syj7v6bo87i7PW3yu3AkZ9A
         qfRZkiELm/E6UvTkpqE+vkPwf78kVSn/RyRc6cFijrRVvh/8rswsbZi99nm9D/fwdVxa
         8C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709611; x=1709314411;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB4sepnqluOGCQzWosSupcXtilnk0cI5dxVNZLd+dk0=;
        b=LDgTivhAvm6c3AeQvrP0ygyzHo+8784rCqLTQmgf85N4qcrj/g8FufXOaQxoct3bWS
         iOSyaXec9YeTCfTQoc4eJjKLcoVuW4o9coIsyv8AaIZyXMzI6Lzq0RNS0Gf5RkwyNBtp
         DrBXXEoK5gWOlC+HqRJmYTRfRbre9wxx9bk2iDEVibDDOJP2DO3PMJN9nb+tVrZ4sSe9
         pHWWd7mDKCQPcA2LXZNnQ8hd8i5Rf12Sc6ZZ6iswayTJ+PvC2yYYoWmHa/buMefHoLCT
         rou+LCilouBTIIjes01L5coDTxJItq8LcOKcGm62hsrrSMATe4u0Cx+yHdiec0YEiIWA
         nFyA==
X-Forwarded-Encrypted: i=1; AJvYcCXi8rzRTlboE7OKZr/TeCwwWaO6F1LOqqPdphPAlh/dwXtuTv6xzg1+ttPZYsz5GRUsmsRCSTBolehwbhb4ffm5SemI+D9tP/5k+2lMM0zG4NAE
X-Gm-Message-State: AOJu0YxCopQuRcY9X1ylCxv4hNCCKm91WbDn2Nc4RTmOnY1/6qy/9w9G
	Y3wb5QoAtkbutVdpnnId5wVQ76Rvhee8aTNNOtHJal0q58vPlrQwbIL2c74IJwEksFxulTVdW+u
	G9MJQM7rVPKiTR8yVHA==
X-Google-Smtp-Source: AGHT+IHVRK3LPQO5y/JakeL60p382oMqTXfrOuVmR62hgfxoKp6aQ2jEjXhQkVkn+lJufBcDrmjuFkr7l+uc036t
X-Received: from cgalo-android-cuttlefish.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:24f8])
 (user=carlosgalo job=sendgmr) by 2002:a05:6902:1501:b0:dc7:66ec:9038 with
 SMTP id q1-20020a056902150100b00dc766ec9038mr31443ybu.1.1708709611093; Fri,
 23 Feb 2024 09:33:31 -0800 (PST)
Date: Fri, 23 Feb 2024 17:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223173258.174828-1-carlosgalo@google.com>
Subject: [PATCH v3] mm: Update mark_victim tracepoints fields
From: Carlos Galo <carlosgalo@google.com>
To: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	mhocko@suse.com
Cc: android-mm@google.com, kernel-team@android.com, 
	Carlos Galo <carlosgalo@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The current implementation of the mark_victim tracepoint provides only
the process ID (pid) of the victim process. This limitation poses
challenges for userspace tools requiring real-time OOM analysis and
intervention. Although this information is available from the kernel
logs, it=E2=80=99s not the appropriate format to provide OOM notifications.=
 In
Android, BPF programs are used with the mark_victim trace events to
notify userspace of an OOM kill. For consistency, update the trace
event to include the same information about the OOMed victim as the
kernel logs.

- UID
   In Android each installed application has a unique UID. Including
   the `uid` assists in correlating OOM events with specific apps.

- Process Name (comm)
   Enables identification of the affected process.

- OOM Score
  Will allow userspace to get additional insight of the relative kill
  priority of the OOM victim. In Android, the oom_score_adj is used to
  categorize app state (foreground, background, etc.), which aids in
  analyzing user-perceptible impacts of OOM events [1].

- Total VM, RSS Stats, and pgtables
  Amount of memory used by the victim that will, potentially, be freed up
  by killing it.

[1] https://cs.android.com/android/platform/superproject/main/+/246dc8fc95b=
6d93afcba5c6d6c133307abb3ac2e:frameworks/base/services/core/java/com/androi=
d/server/am/ProcessList.java;l=3D188-283

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Carlos Galo <carlosgalo@google.com>
---

v3:
- Added total_vm, rss fields, and pgtables  per Michal Hocko.
- Added Steven Rostedt reviewed by
- Updated commit description to include android usecase

v2: Fixed build error. Added missing comma when printing `__entry->uid`.

 include/trace/events/oom.h | 36 ++++++++++++++++++++++++++++++++----
 mm/oom_kill.c              |  6 +++++-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b799f3bcba82 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -7,6 +7,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
=20
+#define PG_COUNT_TO_KB(x) ((x) << (PAGE_SHIFT - 10))
+
 TRACE_EVENT(oom_score_adj_update,
=20
 	TP_PROTO(struct task_struct *task),
@@ -72,19 +74,45 @@ TRACE_EVENT(reclaim_retry_zone,
 );
=20
 TRACE_EVENT(mark_victim,
-	TP_PROTO(int pid),
+	TP_PROTO(struct task_struct *task, uid_t uid),
=20
-	TP_ARGS(pid),
+	TP_ARGS(task, uid),
=20
 	TP_STRUCT__entry(
 		__field(int, pid)
+		__string(comm, task->comm)
+		__field(unsigned long, total_vm)
+		__field(unsigned long, anon_rss)
+		__field(unsigned long, file_rss)
+		__field(unsigned long, shmem_rss)
+		__field(uid_t, uid)
+		__field(unsigned long, pgtables)
+		__field(short, oom_score_adj)
 	),
=20
 	TP_fast_assign(
-		__entry->pid =3D pid;
+		__entry->pid =3D task->pid;
+		__assign_str(comm, task->comm);
+		__entry->total_vm =3D PG_COUNT_TO_KB(task->mm->total_vm);
+		__entry->anon_rss =3D PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_ANONPAG=
ES));
+		__entry->file_rss =3D PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_FILEPAG=
ES));
+		__entry->shmem_rss =3D PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_SHMEMP=
AGES));
+		__entry->uid =3D uid;
+		__entry->pgtables =3D mm_pgtables_bytes(task->mm) >> 10;
+		__entry->oom_score_adj =3D task->signal->oom_score_adj;
 	),
=20
-	TP_printk("pid=3D%d", __entry->pid)
+	TP_printk("pid=3D%d comm=3D%s total-vm=3D%lukB anon-rss=3D%lukB file-rss:=
%lukB shmem-rss:%lukB uid=3D%u pgtables=3D%lukB oom_score_adj=3D%hd",
+		__entry->pid,
+		__get_str(comm),
+		__entry->total_vm,
+		__entry->anon_rss,
+		__entry->file_rss,
+		__entry->shmem_rss,
+		__entry->uid,
+		__entry->pgtables,
+		__entry->oom_score_adj
+	)
 );
=20
 TRACE_EVENT(wake_reaper,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 91ccd82097c2..8d6a207c3c59 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/cred.h>
=20
 #include <asm/tlb.h>
 #include "internal.h"
@@ -754,6 +755,7 @@ static inline void queue_oom_reaper(struct task_struct =
*tsk)
  */
 static void mark_oom_victim(struct task_struct *tsk)
 {
+	const struct cred *cred;
 	struct mm_struct *mm =3D tsk->mm;
=20
 	WARN_ON(oom_killer_disabled);
@@ -773,7 +775,9 @@ static void mark_oom_victim(struct task_struct *tsk)
 	 */
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
-	trace_mark_victim(tsk->pid);
+	cred =3D get_task_cred(tsk);
+	trace_mark_victim(tsk, cred->uid.val);
+	put_cred(cred);
 }
=20
 /**
--=20
2.44.0.rc0.258.g7320e95886-goog

