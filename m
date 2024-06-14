Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4A183092;
	Fri, 14 Jun 2024 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331683; cv=none; b=WCcLpPs+NZSXw3PbBdjQGxqyTW2pHFnKJ9aa50uiPn58xc15ClEiVfRdIMcXEm6GMsufBkP1b+09i9JFG5gu45uwtiZ1HlgYJa+kAi5tRjsFhwsVA/rNR/LIDi05fiCZNEEvZ/YDCHIhZwinMKw02iobHX10Vjkp/zfUjH6SOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331683; c=relaxed/simple;
	bh=8pPEdPF/eqxQjBYIiMHKHu4XT+T/5Ys7ImzS3a2tcRI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJbmwor6zUx8Py41u318bk8zO+1B7fopZK5jAOzhXuyuzLFhC5nye0G8/LdgfU3g1/Ml+/3tXnNe1WDnviIFIikq7xowMcYzQ78dWK9F0oFKd3sx5m6QI5MEyTXU8U7dZVId5nYqYADPWkrpgxmc5sSQPSSHgJXNuZ+LOg0fXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W0jbR0gWXz355vc;
	Fri, 14 Jun 2024 10:17:23 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E753714035F;
	Fri, 14 Jun 2024 10:21:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 10:21:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <linux@armlinux.org.uk>, <ruanjinjie@huawei.com>,
	<ardb@kernel.org>, <yangtiezhu@loongson.cn>, <arnd@arndb.de>,
	<kees@kernel.org>, <rmk+kernel@armlinux.org.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] arm: Add KPROBES_ON_FTRACE supported
Date: Fri, 14 Jun 2024 10:23:18 +0800
Message-ID: <20240614022318.2600814-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add support for kprobes on ftrace call sites to avoid much of the overhead
with regular kprobes. Try it with simple steps:

	cd /sys/kernel/debug/tracing/
	echo 'p:myprobe sys_clone r0=%r0 r1=%r1 r2=%r2' > kprobe_events
	echo 1 > events/kprobes/enable
	echo  1 > events/kprobes/myprobe/enable
	cat trace
	# tracer: nop
	#
	# entries-in-buffer/entries-written: 2/2   #P:4
	#
	#                                _-----=> irqs-off/BH-disabled
	#                               / _----=> need-resched
	#                              | / _---=> hardirq/softirq
	#                              || / _--=> preempt-depth
	#                              ||| / _-=> migrate-disable
	#                              |||| /     delay
	#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
	#              | |         |   |||||     |         |
	              sh-75      [000] .....    33.793362: myprobe: (sys_clone+0xc/0xa0) r0=0x1200011 r1=0x0 r2=0x0
	              sh-75      [000] .....    34.817804: myprobe: (sys_clone+0xc/0xa0) r0=0x1200011 r1=0x0 r2=0x0

	cat /sys/kernel/debug/kprobes/list
		c03453e8  k  sys_clone+0xc    [FTRACE]
					       ^^^^^^

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm/Kconfig                              |  1 +
 arch/arm/include/asm/ftrace.h                 | 17 ++++++
 arch/arm/kernel/ftrace.c                      | 17 ------
 arch/arm/probes/Makefile                      |  1 +
 arch/arm/probes/ftrace.c                      | 53 +++++++++++++++++++
 arch/arm/probes/kprobes/core.c                | 32 +++++++++++
 7 files changed, 105 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/probes/ftrace.c

diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 02febc883588..4ecd7d53e859 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -8,7 +8,7 @@
     -----------------------
     |       alpha: | TODO |
     |         arc: | TODO |
-    |         arm: | TODO |
+    |         arm: |  ok  |
     |       arm64: | TODO |
     |        csky: |  ok  |
     |     hexagon: | TODO |
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac..ed13b1743f94 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -114,6 +114,7 @@ config ARM
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
+	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 5be3ddc96a50..c8e3f808b70c 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -22,6 +22,23 @@ struct dyn_arch_ftrace {
 #endif
 };
 
+/*
+ * The compiler emitted profiling hook consists of
+ *
+ *   PUSH    {LR}
+ *   BL	     __gnu_mcount_nc
+ *
+ * To turn this combined sequence into a NOP, we need to restore the value of
+ * SP before the PUSH. Let's use an ADD rather than a POP into LR, as LR is not
+ * modified anyway, and reloading LR from memory is highly likely to be less
+ * efficient.
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+#define	NOP		0xf10d0d04	/* add.w sp, sp, #4 */
+#else
+#define	NOP		0xe28dd004	/* add   sp, sp, #4 */
+#endif
+
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/* With Thumb-2, the recorded addresses have the lsb set */
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index a0b6d1e3812f..f0f1bdf27637 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -25,23 +25,6 @@
 #include <asm/stacktrace.h>
 #include <asm/patch.h>
 
-/*
- * The compiler emitted profiling hook consists of
- *
- *   PUSH    {LR}
- *   BL	     __gnu_mcount_nc
- *
- * To turn this combined sequence into a NOP, we need to restore the value of
- * SP before the PUSH. Let's use an ADD rather than a POP into LR, as LR is not
- * modified anyway, and reloading LR from memory is highly likely to be less
- * efficient.
- */
-#ifdef CONFIG_THUMB2_KERNEL
-#define	NOP		0xf10d0d04	/* add.w sp, sp, #4 */
-#else
-#define	NOP		0xe28dd004	/* add   sp, sp, #4 */
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static int __ftrace_modify_code(void *data)
diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
index 8b0ea5ace100..b3c355942a21 100644
--- a/arch/arm/probes/Makefile
+++ b/arch/arm/probes/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o uprobes/
 obj-$(CONFIG_KPROBES)		+= decode.o kprobes/
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)		+= decode-thumb.o
 else
diff --git a/arch/arm/probes/ftrace.c b/arch/arm/probes/ftrace.c
new file mode 100644
index 000000000000..0f54b8e5d2a6
--- /dev/null
+++ b/arch/arm/probes/ftrace.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kprobes.h>
+
+/* Ftrace callback handler for kprobes -- called under preepmt disabled */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *regs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		return;
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip = instruction_pointer(&(regs->regs));
+
+		instruction_pointer_set(&(regs->regs), ip);
+
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, &(regs->regs))) {
+			/*
+			 * Emulate singlestep (and also recover regs->pc)
+			 * as if there is a nop
+			 */
+			instruction_pointer_set(&(regs->regs),
+						(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, &(regs->regs), 0);
+			}
+			instruction_pointer_set(&(regs->regs), orig_ip);
+		}
+
+		/*
+		 * If pre_handler returns !0, it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.insn = NULL;
+	return 0;
+}
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index d8238da095df..5e2f18cfd766 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -45,6 +45,38 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
+					 bool *on_func_entry)
+{
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	unsigned long nop_offset = 0;
+	u32 insn = 0;
+
+	/*
+	 * Since 'addr' is not guaranteed to be safe to access, use
+	 * copy_from_kernel_nofault() to read the instruction:
+	 */
+	if (copy_from_kernel_nofault(&insn, (void *)(addr + nop_offset),
+				     sizeof(u32)))
+		return NULL;
+
+	while (insn != NOP) {
+		nop_offset += 4;
+		if (copy_from_kernel_nofault(&insn, (void *)(addr + nop_offset),
+					     sizeof(u32)))
+			return NULL;
+	}
+
+	*on_func_entry = offset <= nop_offset;
+	if (*on_func_entry)
+		offset = nop_offset;
+#else
+	*on_func_entry = !offset;
+#endif
+
+	return (kprobe_opcode_t *)(addr + offset);
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	kprobe_opcode_t insn;
-- 
2.34.1

