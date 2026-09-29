Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688C3AEF3F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701868; cv=none; b=DGHkT29+6o4OrOGecvYN9twt6ukFXVKdo3ZARdPLg8GZeMtYXhuou7AqmQEIwpqbxCFathL9wtsz1Pf0C87/u8fpDDbVek4FTQbb8Cxd2TejXnKtAX857VzS1Co4r7qIhtcv3lNYB80EH2cemJ+i/YXfqKmWprSTSCOaRgX0QaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701868; c=relaxed/simple;
	bh=nl5RNxQPCzAWJtmsi5SbRteMPNwj0J+QlcZAZWXWQ7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HspohAd+uUm8jrSJgIJHFJkNLbOh4Y/IfFoD/fg0qGo9+JYESCaBH5FnRYCCTaUBkh2i9bLKyxbkEwdFFckNxQEoGrNKeXnTckBUSeib1wpZpvrG+nipiyvhNxEAOrXJEABTbS/0lXEomiCE3EYjo5LUVU3DHopoKbREItM/W+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KpEfwLt2; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KpEfwLt2"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so50201251cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790701865; x=1791306665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNw00W9BCYnwC8xg/InU6V6F2D9xjEZKnGitOXbGDrM=;
        b=KpEfwLt2F+VTe8mbrqGSqd+tlbCX/A8fDK9gFYRju/OZxztbgo8Ck+0q6kv5YXpS4C
         7Hxq2px3nmUmt+IWkI0M+h6uMSSZ0d18hKRTV0OThhiLgfeTetE9sIK6vxQKmeAJDQ1x
         d2fY9gYyw/UgcCRI51OEt/gOR+y8hNbHotCSnPbNWcifegs02xUqNvy0T1VMSO9oucbB
         xuTyiB45/nvVQcSHgZamGDNP2LxDa8alaUYJbwNJTG104YivieGpT5wq58YSHa9dakpN
         2RE8pQBQ0J9ag7EziLvLPLWAurnFTdsXgwW3OP6+q0aGi1/rrBlYu2UGMfhSf5ZE/Miw
         4Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790701865; x=1791306665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNw00W9BCYnwC8xg/InU6V6F2D9xjEZKnGitOXbGDrM=;
        b=uF/PGNEe0066Bjgj+7lhi+9NWrehCWSeFgsYbx3Bm36SyGaglWqanMRJ7PikaaM173
         6/HCSaOln1ECLEntDDWTjY6zctDhjICc7tVvEnPp6o7EbFc/xaNcXC8ew3GS0kX5vOwq
         zfmpTIFD7QTrMQkhsq7OZFt/2onxkMmZ9jEwgRU4uCIdR6ckiWkZO65xw9Ba3Y+K1Nyb
         EeZtyDp8JeqkD/hEsW48oXOL6HiDrgQAbqWxXNXOtaR2gJ5sGtEIRBhIVkHRlaJbPPgR
         jORI+XeoiWBaSFZemSXK5iCBnrTM7zD9/a1FRrBfehO+msKbevgzwawsYbcJeGpkGCfl
         pE1A==
X-Forwarded-Encrypted: i=1; AKwUvBzUSsDf5FWcg0kICOXi8NilMIKH+YK695wfaV81ePvQCIT/NbpPAiuiwubBADaFqK+0C6lu2/JjA/nvgODU5MkVvK0=@vger.kernel.org
X-Gm-Message-State: AFuF++my5d8YNCQGTKhjRD463XMRzbmaljagxcpkkTjfukrNJ0w+Tj4N
	Ioo5uKCjVEMo4LxmXDLPgvprcg9ktetV0M0ecaWWuXe9q+OKtozyIlu9DtO8ipeGZzM=
X-Gm-Gg: AYBFou17NPabRjB5BMTrw9uMBWX0pXJSQq1YC1NDQBZQmf7Sji2sj8W33KvsGaofWeW
	D5RTqHgndOMCezwHsz1YLpikmho3R4hoZew+Fu9qbOhkf8Vd2MXnasuiKx8McCYWfmPT8WCj6g/
	RS9quIqFrzskW6j1mHMzZgkLZIVTn2qa3IE40cJjmLZS4gB67q14KRgFG6NErWNtT8QhB9OXgGM
	4lh5vhtC5weCTj3VZUl9w7W84zq/10V9rBCMkCv1q5Cim2Xwi9vgrNGDBcNd03LLf8zSmTOutc0
	kvmKNQElsYUJEW8IHU0Em0QUnaPtXKOvQaUFmPvA7CYxZShqhsj+88WILDcT49FJkU/MZJYbdZk
	MlRCKeTp5jYijEmZJUcAkf6PkGSENA6MUbILWEq6PLFmQ0xkuPCow7BUzvUzegAEM/+we9U8PSq
	Pml67GsfhHkrNAu6ZD1WAQz4ihgkm2oEwWw34DN21/kb7TOrcNis2G7fGVj43HRrvXZdbVcoD2p
	Kdsea5YzYZ+7XQ=
X-Received: by 2002:a05:622a:4016:b0:532:b31f:820e with SMTP id d75a77b69052e-5330b5b8118mr305631011cf.18.1790701864547;
        Tue, 29 Sep 2026 10:11:04 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53369af75edsm66981cf.9.2026.09.29.10.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:11:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:21 +0000
Subject: [PATCH v6 04/14] kprobes: Expose the optprobe jump window to Tasks
 RCU
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-4-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701681; l=7126;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=nl5RNxQPCzAWJtmsi5SbRteMPNwj0J+QlcZAZWXWQ7c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFFZEOaRfIVTqNnNhc5U/7HS1t7xUbawjml8+bJSR8yFK3V4XE1G+BlfVkIeDKMdjqiUSidKrEZ
 kwtnR55o1Hgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kprobe_optimizer() is the one synchronize_rcu_tasks() user that is not
about trampoline text: it waits for tasks that were interrupted on an
instruction boundary inside the bytes it is about to overwrite with the
optimized jump, so that none of them resumes into the middle of the new
instruction.  Those bytes are ordinary kernel or module text with no
Tasks Trace reader around them, so on CONFIG_TASKS_RCU_TRAMPOLINE_READERS
kernels the irq-exit quiescent-state check has to be told about them.

Add kprobe_in_optimized_region(), a lockless and conservative form of
get_optimized_kprobe() that reports whether any registered kprobe lies
within MAX_OPTIMIZED_LENGTH before the given address regardless of its
optimization state, and have rcu_tasks_trampoline_text() consult it for
core and module text so that a task interrupted there becomes a holdout
rather than a quiescent event. The hash walk only runs while
kprobe_optimizer() is actually inside its synchronize_rcu_tasks(),
tracked by a flag it sets around the call; otherwise the check is a
single load. That check cannot see a task that was already preempted in
the region before the flag went up (possibly before the kprobe even
existed), and the new grace period does not otherwise wait for a
preempted task to run again, so before synchronize_rcu_tasks() the
optimizer calls rcu_tasks_wait_irq_preempted() to wait until no parked
task's recorded irq-exit preemption IP is inside such a region; its
leading synchronize_rcu() also publishes the flag to every (interrupts-
disabled) check in flight. The kprobe hash is RCU-protected and every
free path waits for a grace period after unhashing, so the lockless walk
from the irq-exit path is safe.

On other configurations the flag is set and cleared but nothing reads
it and rcu_tasks_wait_irq_preempted() is a stub; the classic
implementation already waits for such tasks.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/kprobes.h |  8 +++++++-
 kernel/kprobes.c        | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h      | 11 ++++++++---
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e6de7ae55bda..74cc48c04417 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -530,11 +530,17 @@ static inline bool is_kprobe_insn_slot(unsigned long addr)
 }
 #endif /* !CONFIG_KPROBES */
 
-#ifndef CONFIG_OPTPROBES
+#ifdef CONFIG_OPTPROBES
+bool kprobe_in_optimized_region(unsigned long addr);
+#else /* !CONFIG_OPTPROBES */
 static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 {
 	return false;
 }
+static inline bool kprobe_in_optimized_region(unsigned long addr)
+{
+	return false;
+}
 #endif /* !CONFIG_OPTPROBES */
 
 #ifdef CONFIG_KRETPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6337da5cab9e..a63f31045b14 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -511,6 +511,46 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
+/* See kprobe_in_optimized_region(). */
+static bool kprobe_optimizer_waiting;
+
+/**
+ * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optimized
+ *	kprobe replaces?
+ * @addr: kernel text address, typically an interrupted instruction pointer
+ *
+ * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for tasks that
+ * were interrupted on an instruction boundary inside the region about to be
+ * overwritten by the optimized jump.  Where Tasks RCU is built on
+ * reader-marked trampolines that region has no reader, so the irq-exit
+ * quiescent-state check asks this instead (see rcu_tasks_trampoline_text()).
+ * This is the lockless, conservative form of get_optimized_kprobe(): it does
+ * not care whether the kprobe found is, or ever will be, optimized.  May be
+ * called from any context with preemption disabled; the kprobe hash is
+ * RCU-protected and every free path waits for a grace period after unhashing.
+ *
+ * The hash walk only runs while the optimizer is actually waiting
+ * (kprobe_optimizer_waiting); otherwise this is a single load.  A task that
+ * was preempted in such a region before the flag went up is invisible to
+ * that check, so the optimizer first waits those out by their recorded
+ * preemption IP (rcu_tasks_wait_irq_preempted(), a no-op on other
+ * configurations, whose leading synchronize_rcu() also publishes the flag to
+ * every check in flight).
+ */
+bool kprobe_in_optimized_region(unsigned long addr)
+{
+	int i;
+
+	if (!READ_ONCE(kprobe_optimizer_waiting))
+		return false;
+
+	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+		if (get_kprobe((kprobe_opcode_t *)addr - i))
+			return true;
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_in_optimized_region);
+
 /* Optimization staging list, protected by 'kprobe_mutex' */
 static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
@@ -644,8 +684,12 @@ static void kprobe_optimizer(void)
 		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
 		 * Note that on non-preemptive kernel, this is transparently converted
 		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 * See kprobe_in_optimized_region() for the flag and the extra wait.
 		 */
+		WRITE_ONCE(kprobe_optimizer_waiting, true);
+		rcu_tasks_wait_irq_preempted(kprobe_in_optimized_region);
 		synchronize_rcu_tasks();
+		WRITE_ONCE(kprobe_optimizer_waiting, false);
 
 		/* Step 3: Optimize kprobes after quiesence period */
 		do_optimize_kprobes();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e7498601c28c..3f127e47ffc2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -996,7 +996,9 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
  *    trampolines, kprobe slots and other dynamically allocated text; this
  *    deliberately does not ask is_ftrace_trampoline() and friends, since
  *    text being torn down may already be unregistered there);
- *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text().
+ *  - whatever the architecture adds via arch_rcu_tasks_trampoline_text();
+ *  - the bytes after a kprobe that a pending jump optimization is about to
+ *    overwrite, the one synchronize_rcu_tasks() user with no trampoline.
  *
  * A false positive only makes the task a holdout until its next quiescent
  * event.  Called with interrupts disabled from the irq-exit path.
@@ -1004,8 +1006,11 @@ bool __weak arch_rcu_tasks_trampoline_text(unsigned long ip)
 bool rcu_tasks_trampoline_text(unsigned long ip)
 {
 	if (core_kernel_text(ip))
-		return arch_rcu_tasks_trampoline_text(ip);
-	return !is_module_text_address(ip);
+		return arch_rcu_tasks_trampoline_text(ip) ||
+		       kprobe_in_optimized_region(ip);
+	if (is_module_text_address(ip))
+		return kprobe_in_optimized_region(ip);
+	return true;
 }
 NOKPROBE_SYMBOL(rcu_tasks_trampoline_text);
 

-- 
2.55.0

