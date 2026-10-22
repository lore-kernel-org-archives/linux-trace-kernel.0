Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634283;
	b=M/UUGA5QNfoS/RkpHS0Z36aGu/yN4r2siCXsQ2cqTdXo6W8PYwrbxLjv0NAMfcpoMfE7
	 WIXw0optv2X6lzMkBnUesam5CUARdkUc/EEifRi8/3dPEjhbNOPmuU6DCuBt6px+0Utch
	 a9ENgCKyrdzZXlhG9owIPYQ2LgoPePoSM2pw/Jwhx5qK1uzg+LjOOjMnuzDb74//+i0Il
	 W2QHR4W49xu+fewN222Nu6KIvvRUy+W/OEZmr8McCGB8853d4SdQw6+JaqLXvuauGsW/v
	 Z41U+UMU3z7NZmOohjr3G3gl6VQec5+G6Zod9QY6BmeUtmeyAaJKvr1Lf8MFDwjISsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
	b=2J6dU3vZwNLKoop49M3hEn+DWt9+jh2/nwPvKjIgHASoDG62qJIB27mCyXpyqD4X2vDU
	 ApRsm4wNVVkhA/Tdh31qjDVhyG8dKuHCoQ8F3KNcfp+EXfMdvzJoYCOwfTKokTJ9Snh3w
	 /Jq1Z9OLhuq0rEQPkL663TzFRQBXgxYgQTsy08R7wXsoyJuvl1sB7P/UHKRjTDbKiywPO
	 RY6mM6LgWGl4kMiA9atL+94NxopBj4awwnGIzEHdyKyFQ+4QV0dz8B2UhRWbKTUhxPb7e
	 w9mZyzn7GF9WU2ajuJ2fT6NonUQG3zXpb8mWING7Yv9e1mrBUFUR/jE7TT5XAHkHR7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAC606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAAAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IFKEKRsq
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so430233a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634282; x=1793239082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=IFKEKRsqFaZjucw+rqR4ryTGBSp6IDf1i5gaP/nvE9Wndr/QCOZn/7yv9UpaKZHjDW
         8/qyEA5iS19EeITAWkeyWrMT+JTRum1RMsLopl0wBBbhATjbhMHOkwMspb7/m6mO/BmT
         pfVK8W7BlQpeEkx7qfVaNeDcMUgnW4ewjeTmIoIFaKAue3DgHNDQZS/6PVOffg3EDz9t
         k9mZgSSMef4WmBGQmCR6sCoBnqW9r1Hm6mhecwOw4RqmvPO1etWZqFuPJzYWB7QaFvPK
         PNESNeRhCzNr+XEjblAL7LZO5n9/FCFC9VKwF+DgX0t7XnCL861klOfl4Nys4q4D2M7y
         OkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634282; x=1793239082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erBvMxyeCCyC8K/1NyLhHI0mkOqFJyJCPxOLNLg56iI=;
        b=0dPkQd9hvjn/FyBYRFn1Rq108C3LxpecmK6nVZIu0hb8GpfCauuUb3Z36EYBH+SmmE
         HegwH/828aWGpjDP7oJyjdTWrmSOa4sQOubb8zly8dP+MZ6dvGm9IGzCwX+P7WMhSHN2
         V8GBrELei/etPtzYLujQ60LZ3PbkxAEel/rguB/YM3PpZhFgnV7peSl77l5Kt8SnO+dy
         9W42O4DjrqJ2lkFvHEDjVmUO4do1/ZOIJw+yEQsGS6LLWs/26bGZpAr/FK1cqcGVcrh0
         Ywb14SmXzGZlzCiRvC9uPCHLD+yzq1qZ9IsOJLBhT5FY3dYpuhLw7pS20vD1Yj46KgXM
         J24Q==
X-Forwarded-Encrypted: i=1; AKwUvBx+QKK8LOj5kmIXMcpob6q8CPZn1byZX+jupK6+bxRuxYUFSKsdXo17lswbQ9ikUqgU6HQohpbOvot/yga6A1/34Jo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlPH0DM/Npg7kjmEVHnf/FTN2tGUtDcgpL1B5RpuaJOIM93tH6
	Fbzk2e1eFop16JCo1D5uHU3ajuZYKfW0ca609LlflOTENVsIxucwtHkw
X-Gm-Gg: AYBFou1uw6qfasovjRTNLZ/ArCVNpUNUcTa1vq722SgFmP8nkpC3tXaztTdmL5onBF3
	DVp98TkfNO3XzIyPyAwuTChTXN/oAfh7/sykrQG9axhNzAZtc4ts/2yZStVPR6Qd7srBHTiyQX+
	w7hd/Z+jiE/4p4qldv1g//D6Kq4L/i38+Wwl4jH5+OtsB+TuaXDxY4UEdPwzRkUSgigxqzuP4Cv
	H+eQwdH76N0E7F+GV7+vFSXUhARH+krCr4IaKslQcEFnZSSQ2U9fb8VnoejrQMM6M8kRkhNYF+i
	pRA743nMIpulcNZfInQo2hsGCFCInvX3k7gziIZ/Baz5+g46FXRdpPtJmcQLItGxzEdvCZFc3Fg
	hjfd+OXCC0vWcRNC1tFfUJemOkuGnkwFRqkyJ0JKCXexGfygnOXczj4gTOaDmTxZvNukGqNJW31
	HJsxXfI7Od0t2ozOPr6uqExI7YnI1TESS2iuzGHF3XIHmXPwNqlcZGhmqGauwGr7YWX8suPONAI
	C05RYPgrdKB4IVGyyfsl1/EtxJkGhPzNMmMOVaCgE9tDHiUD9eVXqXZayld8KjR1k/KsiFswGG9
	ITVySb9mwfO4kgGFPxhrsMG4Z8LsiOSnnWyBv+KUQ6a0hVFxJX95SYsHEIaD4hCxpo0BANUXDIa
	xefcyjhU+1VhopSiRlcgUKBjW
X-Received: by 2002:a17:90a:e7c8:b0:3ab:d45c:59e2 with SMTP id 98e67ed59e1d1-3ad86f1b28fmr2821607a91.55.1792634281882;
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5edsm1751706a91.8.2026.10.21.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 7/9] fork: Let the new task point to its mm before uprobes can find it
Date: Thu, 22 Oct 2026 01:57:10 +0000
Message-ID: <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

uprobe_perf_filter() compares event->hw.target->mm with mm. The target of
an inherited event is the new task. copy_mm() sets tsk->mm after dup_mm()
returned, but register_for_each_vma() can find the new mm as soon as
dup_mmap() releases dup_mmap_sem. No task points to this mm yet, so
the filter says that nobody wants it.

The walk that removes the breakpoint, because another consumer of the same
uprobe goes away, sees !filter_chain() and removes it from the child.
Nobody installs it again, and the inherited event doesn't see this child.

It's an old bug with a short window. The previous patch releases
dup_mmap_sem before dup_userfaultfd_complete(), so with UFFD_EVENT_FORK
the window is as long as the monitor likes.

Set tsk->mm at the end of dup_mmap() before it releases dup_mmap_sem.
Not earlier. The new task can be reached via its perf events and from bpf
progs. They shouldn't find mm that is half copied. Clear tsk->mm when
dup_mm() fails after dup_mmap(). Do both under task_lock() like exec_mmap()
and exit_mm().

The tasks with such event fork, while another consumer of the same uprobe
comes and goes. 5 cpu VM, 90 sec and 7000 children per run. The number of
children that the inherited event didn't see:

  without this series          11 to 24, 8 runs
  patches 1, 2, 5, 6 only      23, 12, 21
  this series                  0, 0, 0

With UFFD_EVENT_FORK monitor that reads the event after 5 sec the child
lost the breakpoint in 5 of 5 runs without this patch, and in 0 of 5 with.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/fork.c |  9 ++++++++-
 mm/internal.h |  3 ++-
 mm/mmap.c     | 14 +++++++++++++-
 mm/nommu.c    |  3 ++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8fd6be932afe..5a2f571b64b7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1539,7 +1539,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk))
 		goto fail_nomem;
 
-	err = dup_mmap(mm, oldmm);
+	err = dup_mmap(tsk, mm, oldmm);
 	if (err)
 		goto free_pt;
 
@@ -1552,6 +1552,13 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return mm;
 
 free_pt:
+	/*
+	 * dup_mmap() has set it if it succeeded. get_task_mm() must not find
+	 * it after the mmput() below.
+	 */
+	task_lock(tsk);
+	tsk->mm = NULL;
+	task_unlock(tsk);
 	/* don't put binfmt in mmput, we haven't got module yet */
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
diff --git a/mm/internal.h b/mm/internal.h
index 9e3be236f18c..70e40306d881 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1520,7 +1520,8 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
 			  pgd_t *pgd, void *private);
 
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm);
 
 int remap_pfn_range_prepare(struct vm_area_desc *desc);
 int remap_pfn_range_complete(struct vm_area_struct *vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 6ce654e33e3b..3167272a77ad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
 
@@ -1705,7 +1706,8 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	return true;
 }
 
-__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+__latent_entropy int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+			      struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp;
 	int retval;
@@ -1897,6 +1899,16 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	if (!retval) {
+		/*
+		 * As soon as dup_mmap_sem is released uprobes can find mm via
+		 * the rmap tree and ask the consumers if they want it. The
+		 * filter of an inherited perf event looks for mm in tsk->mm.
+		 */
+		task_lock(tsk);
+		tsk->mm = mm;
+		task_unlock(tsk);
+	}
 	uprobe_end_dup_mmap();
 	if (!retval)
 		dup_userfaultfd_complete(&uf);
diff --git a/mm/nommu.c b/mm/nommu.c
index 68b05565e15a..7529e03d3f2c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1885,7 +1885,8 @@ static int __meminit init_admin_reserve(void)
 }
 subsys_initcall(init_admin_reserve);
 
-int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
+	     struct mm_struct *oldmm)
 {
 	mmap_write_lock(oldmm);
 	dup_mm_exe_file(mm, oldmm);
-- 
2.55.0

