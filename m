Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BA433BC;
	Mon,  9 Dec 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712093; cv=none; b=lfu7DaJLhUUV+tUWzo0ImzsJQhNbd+nBmwQvCl2choJyVwcWf4t94qpC21+xIYnkt4z/ADuuIUZnJwqTf1QVXTwWPWpRIN2wO1CUFUx5T50Kaiak6y/K8A17qbvq0lfuX73JZvxZnXw2b11ZDNUt0n4A85dR/9JITMJJYoiXgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712093; c=relaxed/simple;
	bh=rNRwR/igHBGhOK9H26aXWYQ+tnb/pRgzzGu4+MXqWic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK66jZqhoq2ILKPMKnkKtDqrJHu3AiDonBaThrrFvvNteOady1KcdR/Hps1Ldsm04ymOlfYqOBLt76uafVUrTSSlwK/TPdZ0Sv01GZDR+j3u24J+8dWSpvQRB9KmTEQK49mdtfHe5Alte5b1l0tdmdoGJJJr9TTSx+6ppRbE6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSBI3Q/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSBI3Q/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FB5C4CED2;
	Mon,  9 Dec 2024 02:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712093;
	bh=rNRwR/igHBGhOK9H26aXWYQ+tnb/pRgzzGu4+MXqWic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSBI3Q/d3nV7Gk/KwXCluNFvalEKcWApu6FID7y3FQR+47kcKBkia2TN0bYcfTplk
	 v6RPwUNhBg+fYxZa/7gyBroMW1cWoEMk6nhUtA4Jq3tVnVbg+sCOcsoboDQL1iPdT9
	 hiqf8v0bNkjlwfWkZu0uYZDz77JTMnoQ5MAKi4dVLSF17npqNZr7bdR9x+ThW2E5cz
	 bGOf3POkZohRcibSwbjTxH1uQzmPNhK86NU4bP24U6JesBI5s3k4IwIfuoyJuPp9rq
	 Fcb/Ulp/7Q5Zrr6GvBYGPlR/pxoVJPEuqOTrTwis63ejA7b58ZC8DUmMV65jMF6u4+
	 lsvY7ltDdwBfA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/5] kprobes: Use guard() for external locks
Date: Mon,  9 Dec 2024 11:41:26 +0900
Message-ID: <173371208663.480397.7535769878667655223.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173371205755.480397.7893311565254712194.stgit@devnote2>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
the kprobes.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |  209 +++++++++++++++++++++++-------------------------------
 1 file changed, 90 insertions(+), 119 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 62b5b08d809d..004eb8326520 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -596,41 +596,38 @@ static void kick_kprobe_optimizer(void)
 /* Kprobe jump optimizer */
 static void kprobe_optimizer(struct work_struct *work)
 {
-	mutex_lock(&kprobe_mutex);
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(mutex)(&kprobe_mutex);
 
-	/*
-	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
-	 * kprobes before waiting for quiesence period.
-	 */
-	do_unoptimize_kprobes();
+	scoped_guard(cpus_read_lock) {
+		guard(mutex)(&text_mutex);
 
-	/*
-	 * Step 2: Wait for quiesence period to ensure all potentially
-	 * preempted tasks to have normally scheduled. Because optprobe
-	 * may modify multiple instructions, there is a chance that Nth
-	 * instruction is preempted. In that case, such tasks can return
-	 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
-	 * Note that on non-preemptive kernel, this is transparently converted
-	 * to synchronoze_sched() to wait for all interrupts to have completed.
-	 */
-	synchronize_rcu_tasks();
+		/*
+		 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
+		 * kprobes before waiting for quiesence period.
+		 */
+		do_unoptimize_kprobes();
 
-	/* Step 3: Optimize kprobes after quiesence period */
-	do_optimize_kprobes();
+		/*
+		 * Step 2: Wait for quiesence period to ensure all potentially
+		 * preempted tasks to have normally scheduled. Because optprobe
+		 * may modify multiple instructions, there is a chance that Nth
+		 * instruction is preempted. In that case, such tasks can return
+		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
+		 * Note that on non-preemptive kernel, this is transparently converted
+		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 */
+		synchronize_rcu_tasks();
 
-	/* Step 4: Free cleaned kprobes after quiesence period */
-	do_free_cleaned_kprobes();
+		/* Step 3: Optimize kprobes after quiesence period */
+		do_optimize_kprobes();
 
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
+		/* Step 4: Free cleaned kprobes after quiesence period */
+		do_free_cleaned_kprobes();
+	}
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
-
-	mutex_unlock(&kprobe_mutex);
 }
 
 static void wait_for_kprobe_optimizer_locked(void)
@@ -853,29 +850,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 		return;
 
 	/* For preparing optimization, jump_label_text_reserved() is called. */
-	cpus_read_lock();
-	jump_label_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(jump_label_lock)();
+	guard(mutex)(&text_mutex);
 
 	ap = alloc_aggr_kprobe(p);
 	if (!ap)
-		goto out;
+		return;
 
 	op = container_of(ap, struct optimized_kprobe, kp);
 	if (!arch_prepared_optinsn(&op->optinsn)) {
 		/* If failed to setup optimizing, fallback to kprobe. */
 		arch_remove_optimized_kprobe(op);
 		kfree(op);
-		goto out;
+		return;
 	}
 
 	init_aggr_kprobe(ap, p);
 	optimize_kprobe(ap);	/* This just kicks optimizer thread. */
-
-out:
-	mutex_unlock(&text_mutex);
-	jump_label_unlock();
-	cpus_read_unlock();
 }
 
 static void optimize_all_kprobes(void)
@@ -1158,12 +1150,9 @@ static int arm_kprobe(struct kprobe *kp)
 	if (unlikely(kprobe_ftrace(kp)))
 		return arm_kprobe_ftrace(kp);
 
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&text_mutex);
 	__arm_kprobe(kp);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-
 	return 0;
 }
 
@@ -1172,12 +1161,9 @@ static int disarm_kprobe(struct kprobe *kp, bool reopt)
 	if (unlikely(kprobe_ftrace(kp)))
 		return disarm_kprobe_ftrace(kp);
 
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&text_mutex);
 	__disarm_kprobe(kp, reopt);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-
 	return 0;
 }
 
@@ -1294,62 +1280,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	int ret = 0;
 	struct kprobe *ap = orig_p;
 
-	cpus_read_lock();
-
-	/* For preparing optimization, jump_label_text_reserved() is called */
-	jump_label_lock();
-	mutex_lock(&text_mutex);
-
-	if (!kprobe_aggrprobe(orig_p)) {
-		/* If 'orig_p' is not an 'aggr_kprobe', create new one. */
-		ap = alloc_aggr_kprobe(orig_p);
-		if (!ap) {
-			ret = -ENOMEM;
-			goto out;
+	scoped_guard(cpus_read_lock) {
+		/* For preparing optimization, jump_label_text_reserved() is called */
+		guard(jump_label_lock)();
+		guard(mutex)(&text_mutex);
+
+		if (!kprobe_aggrprobe(orig_p)) {
+			/* If 'orig_p' is not an 'aggr_kprobe', create new one. */
+			ap = alloc_aggr_kprobe(orig_p);
+			if (!ap)
+				return -ENOMEM;
+			init_aggr_kprobe(ap, orig_p);
+		} else if (kprobe_unused(ap)) {
+			/* This probe is going to die. Rescue it */
+			ret = reuse_unused_kprobe(ap);
+			if (ret)
+				return ret;
 		}
-		init_aggr_kprobe(ap, orig_p);
-	} else if (kprobe_unused(ap)) {
-		/* This probe is going to die. Rescue it */
-		ret = reuse_unused_kprobe(ap);
-		if (ret)
-			goto out;
-	}
 
-	if (kprobe_gone(ap)) {
-		/*
-		 * Attempting to insert new probe at the same location that
-		 * had a probe in the module vaddr area which already
-		 * freed. So, the instruction slot has already been
-		 * released. We need a new slot for the new probe.
-		 */
-		ret = arch_prepare_kprobe(ap);
-		if (ret)
+		if (kprobe_gone(ap)) {
 			/*
-			 * Even if fail to allocate new slot, don't need to
-			 * free the 'ap'. It will be used next time, or
-			 * freed by unregister_kprobe().
+			 * Attempting to insert new probe at the same location that
+			 * had a probe in the module vaddr area which already
+			 * freed. So, the instruction slot has already been
+			 * released. We need a new slot for the new probe.
 			 */
-			goto out;
+			ret = arch_prepare_kprobe(ap);
+			if (ret)
+				/*
+				 * Even if fail to allocate new slot, don't need to
+				 * free the 'ap'. It will be used next time, or
+				 * freed by unregister_kprobe().
+				 */
+				return ret;
 
-		/* Prepare optimized instructions if possible. */
-		prepare_optimized_kprobe(ap);
+			/* Prepare optimized instructions if possible. */
+			prepare_optimized_kprobe(ap);
 
-		/*
-		 * Clear gone flag to prevent allocating new slot again, and
-		 * set disabled flag because it is not armed yet.
-		 */
-		ap->flags = (ap->flags & ~KPROBE_FLAG_GONE)
-			    | KPROBE_FLAG_DISABLED;
-	}
-
-	/* Copy the insn slot of 'p' to 'ap'. */
-	copy_kprobe(ap, p);
-	ret = add_new_kprobe(ap, p);
+			/*
+			 * Clear gone flag to prevent allocating new slot again, and
+			 * set disabled flag because it is not armed yet.
+			 */
+			ap->flags = (ap->flags & ~KPROBE_FLAG_GONE)
+					| KPROBE_FLAG_DISABLED;
+		}
 
-out:
-	mutex_unlock(&text_mutex);
-	jump_label_unlock();
-	cpus_read_unlock();
+		/* Copy the insn slot of 'p' to 'ap'. */
+		copy_kprobe(ap, p);
+		ret = add_new_kprobe(ap, p);
+	}
 
 	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
@@ -1559,26 +1538,23 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
-	jump_label_lock();
+
+	guard(jump_label_lock)();
 
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
 	if (!core_kernel_text((unsigned long) p->addr)) {
 		guard(preempt)();
 		*probed_mod = __module_text_address((unsigned long) p->addr);
-		if (!(*probed_mod)) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!(*probed_mod))
+			return -EINVAL;
 
 		/*
 		 * We must hold a refcount of the probed module while updating
 		 * its code to prohibit unexpected unloading.
 		 */
-		if (unlikely(!try_module_get(*probed_mod))) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (unlikely(!try_module_get(*probed_mod)))
+			return -ENOENT;
 	}
 	/* Ensure it is not in reserved area. */
 	if (in_gate_area_no_mm((unsigned long) p->addr) ||
@@ -1588,8 +1564,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    find_bug((unsigned long)p->addr) ||
 	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		module_put(*probed_mod);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get module refcount and reject __init functions for loaded modules. */
@@ -1601,14 +1576,11 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
 		    !module_is_coming(*probed_mod)) {
 			module_put(*probed_mod);
-			ret = -ENOENT;
+			return -ENOENT;
 		}
 	}
 
-out:
-	jump_label_unlock();
-
-	return ret;
+	return 0;
 }
 
 static int __register_kprobe(struct kprobe *p)
@@ -1623,14 +1595,13 @@ static int __register_kprobe(struct kprobe *p)
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
 		return register_aggr_kprobe(old_p, p);
 
-	cpus_read_lock();
-	/* Prevent text modification */
-	mutex_lock(&text_mutex);
-	ret = prepare_kprobe(p);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-	if (ret)
-		return ret;
+	scoped_guard(cpus_read_lock) {
+		/* Prevent text modification */
+		guard(mutex)(&text_mutex);
+		ret = prepare_kprobe(p);
+		if (ret)
+			return ret;
+	}
 
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,

