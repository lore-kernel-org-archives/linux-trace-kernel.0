Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2F3770D;
	Fri,  6 Sep 2024 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593367; cv=none; b=JLIqgrSgJRxO8CXCfjaWdhlWI913ySKguUEORyCZuQfx3T6exjgEZhSELqjEsMSrKNv44yW2rIf/+xSf4LR/u5Z9fY/bfoO/4nD8DoiiHb4boQDxlR+OV7mhcnGjmVrGwSHX1DLuROGLyt57B685ngeB4tanBLdwzRxiZ07UPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593367; c=relaxed/simple;
	bh=l45j2zN108BnhfFQh/oe/qqhuFnKqER6Pz17cWF6LQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/yVcfzwozp9sctWKo/l7AMIRNTvMLyQDlVxCO0f8JN+jxblgEI/zAoHH2LNOqWnfg84b9u1+lyIv9wGRCVoaP3NqwpnU4c5GmzJemqS4IjccDkiWK43YB9DcopkSLCTwwpzjybabpsSJCX8K+eRXWBWHx+psWyIL3KbmzBwj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0M9V0Z6nzpVDf;
	Fri,  6 Sep 2024 11:27:26 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4793F180087;
	Fri,  6 Sep 2024 11:29:21 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 6 Sep
 2024 11:29:20 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mhiramat@kernel.org>,
	<oleg@redhat.com>, <peterz@infradead.org>, <ptosi@google.com>,
	<oliver.upton@linux.dev>, <mark.rutland@arm.com>, <rppt@kernel.org>,
	<mcgrof@kernel.org>, <kristina.martsenko@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v3] arm64: Replace linked list with switch statement for BRK handlers
Date: Fri, 6 Sep 2024 03:19:30 +0000
Message-ID: <20240906031930.746118-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)

v3->v2:
Rework the implementation of v2, it includes:
1. Remove all register and unregister BRK hook related bits.
2. Place the switch statement immediately after the BRK EC is decoded
   from ESR. The existing BRK handlers are hardcoded within switch
   statement.
3. Introduce refcount and wait_queue to ensure the running KGDB handler
   would not be stopped by the caller of KGDB unregistration.

v2->v1:
Fix a bug of releasing spinlock in kgdb_arch_exit().

As suggested by Mark Rutland [0], this patch remove the linked list used
for breakpoint handlers and instroduces a switch statement based on the
immediate value.

The [u]register_break_hook() and related bits are removed entirely. All
BRK handlers are hardcoded within the switch statement. If the dependent
kernel configure is disable or related handler has been disabled (KGDB),
the corresponding case return DGB_HOOK_ERROR. After this rework, some
BRK related benchmarks are improved slightly.

This patch introduces refcount and wait_queue to ensure the acked KGDB
BRK fault will be handled even the caller of KGDB IO driver has stopped
the architecture related KGDB functionality. These changes to KGDB has
been verified on QEMU with the script below that use kgdbts.

  exec busybox sh -c 'while [ 1 ] ; do find / > /dev/null 2>&1 ; done' &
  exec busybox sh -c 'while [ 1 ] ; do find / > /dev/null 2>&1 ; done' &
  jobs=$(ps | grep 'do find' | head -n 2 | awk '{print $1}')
  echo kgdbts=V1S1000 > /sys/module/kgdbts/parameters/kgdbts
  sleep 10
  kill -9 $jobs
  ## This tests break points on kernel_clone
  exec busybox sh -c 'while [ 1 ] ; do date > /dev/null ; done' &
  exec busybox sh -c 'while [ 1 ] ; do date > /dev/null ; done' &
  jobs=$(ps | grep 'do date' | head -n 2 | awk '{print $1}')
  echo kgdbts=V1F1000 > /sys/module/kgdbts/parameters/kgdbts
  sleep 10
  kill -9 $jobs

[0] https://lore.kernel.org/all/Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com/

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h |  52 +++++++++---
 arch/arm64/kernel/debug-monitors.c      | 104 +++++++++++++++---------
 arch/arm64/kernel/kgdb.c                |  56 +++++++++----
 arch/arm64/kernel/probes/kprobes.c      |  25 +-----
 arch/arm64/kernel/probes/uprobes.c      |  10 +--
 arch/arm64/kernel/traps.c               |  51 ++----------
 6 files changed, 156 insertions(+), 142 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 13d437bcbf58..ecc77c73efdf 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -73,18 +73,50 @@ void unregister_user_step_hook(struct step_hook *hook);
 void register_kernel_step_hook(struct step_hook *hook);
 void unregister_kernel_step_hook(struct step_hook *hook);
 
-struct break_hook {
-	struct list_head node;
-	int (*fn)(struct pt_regs *regs, unsigned long esr);
-	u16 imm;
-	u16 mask; /* These bits are ignored when comparing with imm */
-};
+#ifdef CONFIG_KPROBES
+int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr);
+int kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr);
+int kretprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr);
+#else
+#define kprobe_breakpoint_handler(regs, esr) 		(DBG_HOOK_ERROR)
+#define kprobe_breakpoint_ss_handler(regs, esr) 	(DBG_HOOK_ERROR)
+#define kretprobe_breakpoint_handler(regs, esr) 	(DBG_HOOK_ERROR)
+#endif
 
-void register_user_break_hook(struct break_hook *hook);
-void unregister_user_break_hook(struct break_hook *hook);
+#ifdef CONFIG_UPROBES
+int uprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr);
+#else
+#define uprobe_breakpoint_handler(regs, esr)		(DBG_HOOK_ERROR)
+#endif
+
+#ifdef CONFIG_KGDB
+int kgdb_brk_fn(struct pt_regs *regs, unsigned long esr);
+int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned long esr);
+#else
+#define kgdb_brk_fn(regs, esr)				(DBG_HOOK_ERROR)
+#define kgdb_compiled_brk_fn(regs, esr) 		(DBG_HOOK_ERROR)
+#endif
+
+#ifdef CONFIG_KASAN_SW_TAGS
+int kasan_handler(struct pt_regs *regs, unsigned long esr);
+#else
+#define kasan_handler(regs, esr)			(DBG_HOOK_ERROR)
+#endif
+
+#ifdef CONFIG_UBSAN_TRAP
+int ubsan_handler(struct pt_regs *regs, unsigned long esr);
+#else
+#define ubsan_handler(regs, esr)			(DBG_HOOK_ERROR)
+#endif
+
+#ifdef CONFIG_CFI_CLANG
+int cfi_handler(struct pt_regs *regs, unsigned long esr);
+#else
+#define cfi_handler(regs, esr)				(DBG_HOOK_ERROR)
+#endif
 
-void register_kernel_break_hook(struct break_hook *hook);
-void unregister_kernel_break_hook(struct break_hook *hook);
+int bug_handler(struct pt_regs *regs, unsigned long esr);
+int reserved_fault_handler(struct pt_regs *regs, unsigned long esr);
 
 u8 debug_monitors_arch(void);
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 024a7b245056..bcd1c313082e 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -276,65 +276,89 @@ static int single_step_handler(unsigned long unused, unsigned long esr,
 }
 NOKPROBE_SYMBOL(single_step_handler);
 
-static LIST_HEAD(user_break_hook);
-static LIST_HEAD(kernel_break_hook);
-
-void register_user_break_hook(struct break_hook *hook)
+static int __handle_el1_brk(struct pt_regs *regs, unsigned long esr)
 {
-	register_debug_hook(&hook->node, &user_break_hook);
-}
+	unsigned long imm = esr_brk_comment(esr);
 
-void unregister_user_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
+	switch (imm) {
+	case KPROBES_BRK_IMM:
+		return kprobe_breakpoint_handler(regs, esr);
 
-void register_kernel_break_hook(struct break_hook *hook)
-{
-	register_debug_hook(&hook->node, &kernel_break_hook);
-}
+	case KPROBES_BRK_SS_IMM:
+		return kprobe_breakpoint_ss_handler(regs, esr);
 
-void unregister_kernel_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
+	case KRETPROBES_BRK_IMM:
+		return kretprobe_breakpoint_handler(regs, esr);
+
+	case FAULT_BRK_IMM:
+		return reserved_fault_handler(regs, esr);
+
+	case KGDB_DYN_DBG_BRK_IMM:
+		return kgdb_brk_fn(regs, esr);
+
+	case KGDB_COMPILED_DBG_BRK_IMM:
+		return kgdb_compiled_brk_fn(regs, esr);
+
+	case BUG_BRK_IMM:
+		return bug_handler(regs, esr);
+
+	case KASAN_BRK_IMM ... (KASAN_BRK_IMM | KASAN_BRK_MASK):
+		return kasan_handler(regs, esr);
+
+	case UBSAN_BRK_IMM ... (UBSAN_BRK_IMM | UBSAN_BRK_MASK):
+		return ubsan_handler(regs, esr);
+
+	case CFI_BRK_IMM_BASE ... (CFI_BRK_IMM_BASE | CFI_BRK_IMM_MASK):
+		return cfi_handler(regs, esr);
+
+	default:
+		return DBG_HOOK_ERROR;
+	}
 }
+NOKPROBE_SYMBOL(__handle_el1_brk);
 
-static int call_break_hook(struct pt_regs *regs, unsigned long esr)
+static int __handle_el0_brk(struct pt_regs *regs, unsigned long esr)
 {
-	struct break_hook *hook;
-	struct list_head *list;
-	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
+	unsigned long imm = esr_brk_comment(esr);
 
-	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
+	switch (imm) {
+	case UPROBES_BRK_IMM:
+		return uprobe_breakpoint_handler(regs, esr);
 
-	/*
-	 * Since brk exception disables interrupt, this function is
-	 * entirely not preemptible, and we can use rcu list safely here.
-	 */
-	list_for_each_entry_rcu(hook, list, node) {
-		if ((esr_brk_comment(esr) & ~hook->mask) == hook->imm)
-			fn = hook->fn;
+	default:
+		return DBG_HOOK_ERROR;
 	}
-
-	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
-NOKPROBE_SYMBOL(call_break_hook);
+NOKPROBE_SYMBOL(__handle_el0_brk);
 
-static int brk_handler(unsigned long unused, unsigned long esr,
-		       struct pt_regs *regs)
+static int handle_el1_brk(struct pt_regs *regs, unsigned long esr)
 {
-	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
-		return 0;
-
-	if (user_mode(regs)) {
-		send_user_sigtrap(TRAP_BRKPT);
-	} else {
+	if (__handle_el1_brk(regs, esr) != DBG_HOOK_HANDLED) {
 		pr_warn("Unexpected kernel BRK exception at EL1\n");
 		return -EFAULT;
 	}
 
 	return 0;
 }
+NOKPROBE_SYMBOL(handle_el1_brk);
+
+static int handle_el0_brk(struct pt_regs *regs, unsigned long esr)
+{
+	if (__handle_el0_brk(regs, esr) != DBG_HOOK_HANDLED)
+		send_user_sigtrap(TRAP_BRKPT);
+
+	return 0;
+}
+NOKPROBE_SYMBOL(handle_el0_brk);
+
+static int brk_handler(unsigned long unused, unsigned long esr,
+		       struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return handle_el0_brk(regs, esr);
+	else
+		return handle_el1_brk(regs, esr);
+}
 NOKPROBE_SYMBOL(brk_handler);
 
 int aarch32_break_handler(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4e1f983df3d1..5bbdc283713b 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -101,6 +101,9 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "fpcr", 4, -1 },
 };
 
+static refcount_t kgdb_brk_ref = REFCOUNT_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(kgdb_brk_wq);
+
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 {
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
@@ -234,17 +237,50 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 	return err;
 }
 
-static int kgdb_brk_fn(struct pt_regs *regs, unsigned long esr)
+static int kgdb_brk_start(void)
+{
+	return refcount_inc_not_zero(&kgdb_brk_ref);
+}
+
+static void kgdb_brk_complete(void)
+{
+	refcount_dec(&kgdb_brk_ref);
+	if (waitqueue_active(&kgdb_brk_wq))
+		wake_up(&kgdb_brk_wq);
+}
+
+static void kgdb_brk_exit(void)
+{
+	if (!refcount_dec_if_one(&kgdb_brk_ref))
+		wait_event(kgdb_brk_wq, refcount_dec_if_one(&kgdb_brk_ref));
+}
+
+static void kgdb_brk_init(void)
+{
+	WARN_ON(refcount_read(&kgdb_brk_ref) != 0);
+	refcount_set(&kgdb_brk_ref, 1);
+}
+
+int kgdb_brk_fn(struct pt_regs *regs, unsigned long esr)
 {
+	if (!kgdb_brk_start())
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+	kgdb_brk_complete();
+
 	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_brk_fn)
 
-static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned long esr)
+int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned long esr)
 {
+	if (!kgdb_brk_start())
+		return DBG_HOOK_ERROR;
+
 	compiled_break = 1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+	kgdb_brk_complete();
 
 	return DBG_HOOK_HANDLED;
 }
@@ -260,16 +296,6 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned long esr)
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
 
-static struct break_hook kgdb_brkpt_hook = {
-	.fn		= kgdb_brk_fn,
-	.imm		= KGDB_DYN_DBG_BRK_IMM,
-};
-
-static struct break_hook kgdb_compiled_brkpt_hook = {
-	.fn		= kgdb_compiled_brk_fn,
-	.imm		= KGDB_COMPILED_DBG_BRK_IMM,
-};
-
 static struct step_hook kgdb_step_hook = {
 	.fn		= kgdb_step_brk_fn
 };
@@ -316,8 +342,7 @@ int kgdb_arch_init(void)
 	if (ret != 0)
 		return ret;
 
-	register_kernel_break_hook(&kgdb_brkpt_hook);
-	register_kernel_break_hook(&kgdb_compiled_brkpt_hook);
+	kgdb_brk_init();
 	register_kernel_step_hook(&kgdb_step_hook);
 	return 0;
 }
@@ -329,8 +354,7 @@ int kgdb_arch_init(void)
  */
 void kgdb_arch_exit(void)
 {
-	unregister_kernel_break_hook(&kgdb_brkpt_hook);
-	unregister_kernel_break_hook(&kgdb_compiled_brkpt_hook);
+	kgdb_brk_exit();
 	unregister_kernel_step_hook(&kgdb_step_hook);
 	unregister_die_notifier(&kgdb_notifier);
 }
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 4268678d0e86..fbde6c8dd6a4 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -291,7 +291,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-static int __kprobes
+int __kprobes
 kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 {
 	struct kprobe *p, *cur_kprobe;
@@ -335,12 +335,7 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 	return DBG_HOOK_HANDLED;
 }
 
-static struct break_hook kprobes_break_hook = {
-	.imm = KPROBES_BRK_IMM,
-	.fn = kprobe_breakpoint_handler,
-};
-
-static int __kprobes
+int __kprobes
 kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
 {
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -359,12 +354,7 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
 	return DBG_HOOK_ERROR;
 }
 
-static struct break_hook kprobes_break_ss_hook = {
-	.imm = KPROBES_BRK_SS_IMM,
-	.fn = kprobe_breakpoint_ss_handler,
-};
-
-static int __kprobes
+int __kprobes
 kretprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 {
 	if (regs->pc != (unsigned long)__kretprobe_trampoline)
@@ -374,11 +364,6 @@ kretprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 	return DBG_HOOK_HANDLED;
 }
 
-static struct break_hook kretprobes_break_hook = {
-	.imm = KRETPROBES_BRK_IMM,
-	.fn = kretprobe_breakpoint_handler,
-};
-
 /*
  * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
  * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
@@ -421,9 +406,5 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 
 int __init arch_init_kprobes(void)
 {
-	register_kernel_break_hook(&kprobes_break_hook);
-	register_kernel_break_hook(&kprobes_break_ss_hook);
-	register_kernel_break_hook(&kretprobes_break_hook);
-
 	return 0;
 }
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..638704d2cb41 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -165,8 +165,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 	return NOTIFY_DONE;
 }
 
-static int uprobe_breakpoint_handler(struct pt_regs *regs,
-				     unsigned long esr)
+int uprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 {
 	if (uprobe_pre_sstep_notifier(regs))
 		return DBG_HOOK_HANDLED;
@@ -186,12 +185,6 @@ static int uprobe_single_step_handler(struct pt_regs *regs,
 	return DBG_HOOK_ERROR;
 }
 
-/* uprobe breakpoint handler hook */
-static struct break_hook uprobes_break_hook = {
-	.imm = UPROBES_BRK_IMM,
-	.fn = uprobe_breakpoint_handler,
-};
-
 /* uprobe single step handler hook */
 static struct step_hook uprobes_step_hook = {
 	.fn = uprobe_single_step_handler,
@@ -199,7 +192,6 @@ static struct step_hook uprobes_step_hook = {
 
 static int __init arch_init_uprobes(void)
 {
-	register_user_break_hook(&uprobes_break_hook);
 	register_user_step_hook(&uprobes_step_hook);
 
 	return 0;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9e22683aa921..0f2f671b9bc2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -973,7 +973,7 @@ int is_valid_bugaddr(unsigned long addr)
 }
 #endif
 
-static int bug_handler(struct pt_regs *regs, unsigned long esr)
+int bug_handler(struct pt_regs *regs, unsigned long esr)
 {
 	switch (report_bug(regs->pc, regs)) {
 	case BUG_TRAP_TYPE_BUG:
@@ -993,13 +993,8 @@ static int bug_handler(struct pt_regs *regs, unsigned long esr)
 	return DBG_HOOK_HANDLED;
 }
 
-static struct break_hook bug_break_hook = {
-	.fn = bug_handler,
-	.imm = BUG_BRK_IMM,
-};
-
 #ifdef CONFIG_CFI_CLANG
-static int cfi_handler(struct pt_regs *regs, unsigned long esr)
+int cfi_handler(struct pt_regs *regs, unsigned long esr)
 {
 	unsigned long target;
 	u32 type;
@@ -1022,15 +1017,9 @@ static int cfi_handler(struct pt_regs *regs, unsigned long esr)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook cfi_break_hook = {
-	.fn = cfi_handler,
-	.imm = CFI_BRK_IMM_BASE,
-	.mask = CFI_BRK_IMM_MASK,
-};
 #endif /* CONFIG_CFI_CLANG */
 
-static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
+int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
 		"Kernel text patching",
@@ -1040,11 +1029,6 @@ static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
 	return DBG_HOOK_ERROR;
 }
 
-static struct break_hook fault_break_hook = {
-	.fn = reserved_fault_handler,
-	.imm = FAULT_BRK_IMM,
-};
-
 #ifdef CONFIG_KASAN_SW_TAGS
 
 #define KASAN_ESR_RECOVER	0x20
@@ -1052,7 +1036,7 @@ static struct break_hook fault_break_hook = {
 #define KASAN_ESR_SIZE_MASK	0x0f
 #define KASAN_ESR_SIZE(esr)	(1 << ((esr) & KASAN_ESR_SIZE_MASK))
 
-static int kasan_handler(struct pt_regs *regs, unsigned long esr)
+int kasan_handler(struct pt_regs *regs, unsigned long esr)
 {
 	bool recover = esr & KASAN_ESR_RECOVER;
 	bool write = esr & KASAN_ESR_WRITE;
@@ -1083,26 +1067,14 @@ static int kasan_handler(struct pt_regs *regs, unsigned long esr)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook kasan_break_hook = {
-	.fn	= kasan_handler,
-	.imm	= KASAN_BRK_IMM,
-	.mask	= KASAN_BRK_MASK,
-};
 #endif
 
 #ifdef CONFIG_UBSAN_TRAP
-static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
+int ubsan_handler(struct pt_regs *regs, unsigned long esr)
 {
 	die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
 	return DBG_HOOK_HANDLED;
 }
-
-static struct break_hook ubsan_break_hook = {
-	.fn	= ubsan_handler,
-	.imm	= UBSAN_BRK_IMM,
-	.mask	= UBSAN_BRK_MASK,
-};
 #endif
 
 /*
@@ -1110,7 +1082,7 @@ static struct break_hook ubsan_break_hook = {
  * This handler only used until debug_traps_init().
  */
 int __init early_brk64(unsigned long addr, unsigned long esr,
-		struct pt_regs *regs)
+		       struct pt_regs *regs)
 {
 #ifdef CONFIG_CFI_CLANG
 	if (esr_is_cfi_brk(esr))
@@ -1129,16 +1101,5 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 
 void __init trap_init(void)
 {
-	register_kernel_break_hook(&bug_break_hook);
-#ifdef CONFIG_CFI_CLANG
-	register_kernel_break_hook(&cfi_break_hook);
-#endif
-	register_kernel_break_hook(&fault_break_hook);
-#ifdef CONFIG_KASAN_SW_TAGS
-	register_kernel_break_hook(&kasan_break_hook);
-#endif
-#ifdef CONFIG_UBSAN_TRAP
-	register_kernel_break_hook(&ubsan_break_hook);
-#endif
 	debug_traps_init();
 }
-- 
2.34.1

