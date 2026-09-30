Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725935013DB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800338; cv=none; b=EZjsBj6tNWEjJG0O300xnd/wMTm9pMc9c8BQSsOqGwryFtv604dSux2HoHNuQTXxw0983OpbFMTMAkKnrCuMl7GK0LWa7swn2pIHmBHlYC8xM8A5QzZ3/RowdXyyNYp+WSBNHLJtq1KICRCOWtSbMDnnvU/oenKdj3ESEpXypc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800338; c=relaxed/simple;
	bh=SpFmkdGebTMjhu4zWI3dnCEVkXfqVQjuv3q45dp+gAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSH7F+xtLCBCTdV64T+Z0MQXlfEJpcnPFPmKmNek/HLW1S2ypZ+jg4EKepL7RT6kUCjIBSZN1s0wkqWFrGYqcRULu65jOV+K08w0QcFMH/WVjeOLv9To2g54PfvnbeHlSnf1hM32Nsp+8OyTwfiaZRRdrsijumzeNDott/y+NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj+SX7s2; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj+SX7s2"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34daf1b9a1fso260657eec.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800335; x=1791405135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cuq0H2h2LR7DHR+6Ly+j/Muaj9VL4+qlUbAxWX1PFJA=;
        b=Pj+SX7s2yuQrLDSYDLhEbfvGRNJV94WiRYXsw0osITztrIYabdXiWgnoaQyeXgZuEn
         FwP92vUpzFIY77LsegdRjJd0R+l1OZpDC6Xuydb3Rt+XAaDtVHCmvP9aGzJ7QFsOrVkd
         pV4O5TAjb6sj9E11VpeXbn3bihG1/iDWRKQNjE9h2kpxuP+aaB+P+UZh30FWjOSmIBjz
         JU1bQCXutqESpUMuxIg9lS+KSs8V6K/gny8TzLHQ4MXxlMMHrPybFsPuUoMaEmkig9e7
         f4qqSqtkkqrhs7w9L3KIueNpMgpLie+3Fl6C72qoO5mL1gkUfaXN7mjNtqD7gdiiREC0
         orDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800335; x=1791405135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cuq0H2h2LR7DHR+6Ly+j/Muaj9VL4+qlUbAxWX1PFJA=;
        b=dtgGD266uf8LGPuSvczn/7f1eq5K2Gxj/mc6n9YPB5JrF6W4I4RsXbCqVW6IUxlVd8
         w66lN2HjsTdhiyJuXzlutEc7SLyYZrjUBulxnvufdULFFVKbPOdWK3HSjNb5x0YdgqYy
         KPj+Zdi4uHEraGrzBywyqv7QGlYl8I9+evSvZLLlE3+9O1QsWjnCeowKMz2yj4HySe9A
         uhYvoCoVhdvEVFVLW3C9zOzS2ZcqJMItBne1CG9REKvL0UvfZDDktMa2wWOcmDe+63YS
         NgzOviJV1BsEktILWtweYrEyIOVCoO2lyfsAjBqfWKPkpBV9AGwU/t6gmDGVOSBSU+3u
         BFSQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4tr57ve1ow+p4IjHm+v3J1D7eUPEbBG572ny1tsgHS1K4hipU8argsRBKVtdn/DWVeUHYa30rEsiOChRZ9nzJsTI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwhdjxofE4cFccs53T8VMxxg8tTwbV1HtTRsiJpSwPCmevZekQ
	VKH3vanAhFBNx+Bc/Zw9pewdL/nx6IzibU2P9XATK3r0eNHfQ6XOOF6v
X-Gm-Gg: AYBFou3idSLxXMwiRtVjdO/R8FDKlvlja17AOHPWgLDrlMHiO23Iy/iMTRrkxxbXUcc
	2Th8lc1yN2SiBxtsiP+oo7UcjKtc7ijaG7gXvkpr26pwUC+RXvEUq0p/cKGjpa6Gi5/6A8nmuKv
	/cRhd3tQDyId5TVubXjwN/MOcjfvD9jtHUIFyfD1Xr8VzUTvnEvxddu53UBwWFd7pBQX8JaCbOC
	oYRZlximjsSHR5YI1k4FBFVHJKeZK3Gi4QbUsEsTn8WHZQd5UsyeusHGYR0JwxPtTgPP1BaqMAJ
	SqPntvxkx9d9TJGW/qTlznXw/Wttbpi/ypixrPWhpzOXPyiaUsNK3WLpC9vnwFskSlu9bc0Qbj6
	iudlwVkeIJZWKvRnxJmRh30rO2c4Psi7SuOZPjxGsjZ/W7eTrOXSBK/ZJ5XCXzm1alXFuaLHFp9
	OIdLiLOZQLIvd1cmCgpMRdRCIDxvY12UsLOjmgm8jIfdJkCXbitlbPdznyhE564QuJqwRirM5rw
	HsW4g==
X-Received: by 2002:a05:7301:628a:b0:34d:2084:12d3 with SMTP id 5a478bee46e88-34d20841382mr2070951eec.39.1790800335248;
        Wed, 30 Sep 2026 13:32:15 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:2e39:63b8:ea3c:fa28:7091])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1162411eec.29.2026.09.30.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:32:14 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: tytso@mit.edu,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	pjw@kernel.org,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v2 2/4] openrisc: Add KProbes
Date: Thu,  1 Oct 2026 02:01:27 +0530
Message-ID: <20260930203129.51048-3-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260407185650.79816-2-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KProbes support for OpenRISC. This work is primarily based
on similar work done for LoongArch, MIPS and RISC-V.

KProbes make it possible to trap at almost any address in the
kernel to collect performance/debugging info.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
 arch/openrisc/Kconfig                   |   1 +
 arch/openrisc/configs/or1ksim_defconfig |   2 +
 arch/openrisc/configs/virt_defconfig    |   2 +
 arch/openrisc/include/asm/asm.h         |  22 ++
 arch/openrisc/include/asm/break.h       |  19 ++
 arch/openrisc/include/asm/kprobes.h     |  77 +++++
 arch/openrisc/kernel/Makefile           |   1 +
 arch/openrisc/kernel/entry.S            |  16 +
 arch/openrisc/kernel/kprobes.c          | 400 ++++++++++++++++++++++++
 arch/openrisc/kernel/traps.c            |   3 +
 arch/openrisc/lib/memcpy.c              |   2 +
 arch/openrisc/lib/memset.S              |   4 +
 arch/openrisc/mm/fault.c                |   5 +
 samples/kprobes/kprobe_example.c        |   8 +
 14 files changed, 562 insertions(+)
 create mode 100644 arch/openrisc/include/asm/asm.h
 create mode 100644 arch/openrisc/include/asm/break.h
 create mode 100644 arch/openrisc/include/asm/kprobes.h
 create mode 100644 arch/openrisc/kernel/kprobes.c

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9156635dd264..d240533b424b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,6 +27,7 @@ config OPENRISC
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_PCI
+	select HAVE_KPROBES
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 769705ac24d5..24d2915e7609 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -10,7 +10,9 @@ CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
+CONFIG_OPENRISC=y
 CONFIG_JUMP_LABEL=y
+CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
 CONFIG_SLUB_TINY=y
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index 0b9979b35ca8..2eccb506032f 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -11,8 +11,10 @@ CONFIG_OPENRISC_HAVE_INST_SEXT=y
 CONFIG_NR_CPUS=8
 CONFIG_SMP=y
 CONFIG_HZ_100=y
+CONFIG_OPENRISC=y
 # CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
 CONFIG_JUMP_LABEL=y
+CONFIG_KPROBES=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/openrisc/include/asm/asm.h b/arch/openrisc/include/asm/asm.h
new file mode 100644
index 000000000000..aafe08029b4b
--- /dev/null
+++ b/arch/openrisc/include/asm/asm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Macros for OpenRISC asm
+ *
+ * Linux architectural port borrowing nearly verbatim from
+ * LoongArch and Arm. All original copyrights apply as per
+ * the original source declaration.
+ */
+
+#ifndef __ASM_ASM_H
+#define __ASM_ASM_H
+
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(symbol)			\
+	.pushsection "_kprobe_blacklist", "aw";	\
+	.long symbol;				\
+	.popsection
+#else
+#define _ASM_NOKPROBE(symbol)
+#endif
+
+#endif /* __ASM_ASM_H */
diff --git a/arch/openrisc/include/asm/break.h b/arch/openrisc/include/asm/break.h
new file mode 100644
index 000000000000..04a74d863eef
--- /dev/null
+++ b/arch/openrisc/include/asm/break.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * OpenRISC trap codes used internally by the kernel
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * Modifications for the OpenRISC architecture:
+ * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#ifndef __ASM_BREAK_H
+#define __ASM_BREAK_H
+
+#define BRK_KPROBE_BP       512     /* Kprobe break */
+#define BRK_KPROBE_SSTEPBP  1024    /* Kprobe single-step software implementation */
+
+#endif /* __ASM_BREAK_H */
diff --git a/arch/openrisc/include/asm/kprobes.h b/arch/openrisc/include/asm/kprobes.h
new file mode 100644
index 000000000000..2b5847002141
--- /dev/null
+++ b/arch/openrisc/include/asm/kprobes.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * OpenRISC Linux
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#ifndef __ASM_OPENRISC_KPROBES_H
+#define __ASM_OPENRISC_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+
+#ifdef CONFIG_KPROBES
+#include <asm/break.h>
+#include <asm/cacheflush.h>
+
+#define	 __ARCH_WANT_KPROBES_INSN_SLOT
+
+struct pt_regs;
+struct kprobe;
+
+typedef u32 kprobe_opcode_t;
+
+/*
+ * MAX_INSN_SIZE is used as the number of slots in an executable
+ * page for single-stepping out of line (SSOL). We need two slots
+ * since we single-step using software breakpoints. The probed
+ * instruction is placed in the first slot with a breakpoint
+ * instruction in the second slot.
+ */
+#define MAX_INSN_SIZE	2
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of original instruction */
+	kprobe_opcode_t *insn;
+};
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+	unsigned long restore_pc;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	unsigned long irq_flags;
+	/* address of next instruction in case of SSOL */
+	unsigned long restore_pc;
+	struct prev_kprobe prev_kprobe;
+};
+
+#define flush_insn_slot(p)		do { } while (0)
+#define kretprobe_blacklist_size	0
+
+void arch_remove_kprobe(struct kprobe *p);
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+bool kprobe_breakpoint_handler(struct pt_regs *regs);
+bool kprobe_singlestep_handler(struct pt_regs *regs);
+#else /* !CONFIG_KPROBES */
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	return false;
+}
+
+static inline bool kprobe_singlestep_handler(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_KPROBES */
+#endif /* __ASM_OPENRISC_KPROBES_H */
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 150779fbf010..2ac824867963 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-y	+= patching.o
 
 clean:
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c7e90b09645e..cd28bf1f7a3b 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -15,6 +15,7 @@
 #include <linux/linkage.h>
 #include <linux/pgtable.h>
 
+#include <asm/asm.h>
 #include <asm/processor.h>
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
@@ -640,6 +641,7 @@ ENTRY(_sys_call_handler)
 	/* r30 is the only register we clobber in the fast path */
 	/* r30 already saved */
 /*	l.sw    PT_GPR30(r1),r30 */
+_ASM_NOKPROBE(_sys_call_handler)
 
 _syscall_check_trace_enter:
 	/* syscalls run with interrupts enabled */
@@ -652,12 +654,14 @@ _syscall_check_trace_enter:
 	l.sfne	r30,r0
 	l.bf	_syscall_trace_enter
 	 l.nop
+_ASM_NOKPROBE(_syscall_check_trace_enter)
 
 _syscall_check:
 	/* Ensure that the syscall number is reasonable */
 	l.sfgeui r11,__NR_syscalls
 	l.bf	_syscall_badsys
 	 l.nop
+_ASM_NOKPROBE(_syscall_check)
 
 _syscall_call:
 	l.movhi r29,hi(sys_call_table)
@@ -668,12 +672,14 @@ _syscall_call:
 
 	l.jalr  r29
 	 l.nop
+_ASM_NOKPROBE(_syscall_call)
 
 _syscall_return:
 	/* All syscalls return here... just pay attention to ret_from_fork
 	 * which does it in a round-about way.
 	 */
 	l.sw    PT_GPR11(r1),r11           // save return value
+_ASM_NOKPROBE(_syscall_return)
 
 #if 0
 _syscall_debug:
@@ -708,6 +714,7 @@ _syscall_check_trace_leave:
 	l.sfne	r30,r0
 	l.bf	_syscall_trace_leave
 	 l.nop
+_ASM_NOKPROBE(_syscall_check_trace_leave)
 
 /* This is where the exception-return code begins... interrupts need to be
  * disabled the rest of the way here because we can't afford to miss any
@@ -744,6 +751,7 @@ _syscall_check_work:
 	/* _work_pending needs to be called with interrupts disabled */
 	l.j	_work_pending
 	 l.nop
+_ASM_NOKPROBE(_syscall_check_work)
 
 _syscall_resume_userspace:
 //	ENABLE_INTERRUPTS(r29)
@@ -800,6 +808,7 @@ _syscall_resume_userspace:
 	l.mtspr r0,r13,SPR_EPCR_BASE
 	l.mtspr r0,r15,SPR_ESR_BASE
 	l.rfe
+_ASM_NOKPROBE(_syscall_resume_userspace)
 
 /* End of hot path!
  * Keep the below tracing and error handling out of the hot path...
@@ -829,6 +838,7 @@ _syscall_trace_enter:
 
 	l.j	_syscall_check
 	 l.lwz	r8,PT_GPR8(r1)
+_ASM_NOKPROBE(_syscall_trace_enter)
 
 _syscall_trace_leave:
 	l.jal	do_syscall_trace_leave
@@ -836,6 +846,7 @@ _syscall_trace_leave:
 
 	l.j	_syscall_check_work
 	 l.nop
+_ASM_NOKPROBE(_syscall_trace_leave)
 
 _syscall_badsys:
 	/* Here we effectively pretend to have executed an imaginary
@@ -845,6 +856,7 @@ _syscall_badsys:
 	 */
 	l.j	_syscall_return
 	 l.addi	r11,r0,-ENOSYS
+_ASM_NOKPROBE(_syscall_badsys)
 
 /******* END SYSCALL HANDLING *******/
 
@@ -870,6 +882,7 @@ EXCEPTION_ENTRY(_trap_handler)
 
 	l.j     _ret_from_exception
 	 l.nop
+_ASM_NOKPROBE(_trap_handler)
 
 /* ---[ 0xf00: Reserved exception ]-------------------------------------- */
 
@@ -1004,6 +1017,8 @@ ENTRY(_ret_from_exception)
 	 l.nop
 	l.j	_resume_userspace
 	 l.nop
+_ASM_NOKPROBE(_ret_from_exception)
+_ASM_NOKPROBE(_ret_from_intr)
 
 ENTRY(ret_from_fork)
 	l.jal	schedule_tail
@@ -1038,6 +1053,7 @@ ENTRY(ret_from_fork)
 
 	l.j	_syscall_return
 	 l.nop
+_ASM_NOKPROBE(ret_from_fork)
 
 /* ========================================================[ switch ] === */
 
diff --git a/arch/openrisc/kernel/kprobes.c b/arch/openrisc/kernel/kprobes.c
new file mode 100644
index 000000000000..3268ffb0d707
--- /dev/null
+++ b/arch/openrisc/kernel/kprobes.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Kernel probes (KProbes) for OpenRISC
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#include <linux/kprobes.h>
+#include <asm/cpuinfo.h>
+#include <asm/insn-def.h>
+#include <asm/text-patching.h>
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe);
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+#define KPROBE_BP_INSN		__emit_trap(BRK_KPROBE_BP)
+#define KPROBE_SSTEPBP_INSN	__emit_trap(BRK_KPROBE_SSTEPBP)
+
+static bool insn_not_supported(kprobe_opcode_t insn)
+{
+	switch (insn) {
+	case OPENRISC_INSN_CSYNC:
+	case OPENRISC_INSN_MSYNC:
+	case OPENRISC_INSN_PSYNC:
+		return true;
+	}
+
+	if ((insn & OPENRISC_MASK_TRAP) == OPENRISC_INSN_TRAP)
+		return true;
+
+	if ((insn & OPENRISC_MASK_SYS) == OPENRISC_INSN_SYS)
+		return true;
+
+	if ((insn & OPENRISC_MASK_MACRC) == OPENRISC_INSN_MACRC)
+		return true;
+
+	unsigned char opcode = get_6_bit_opcode(insn);
+
+	switch (opcode) {
+	case OPENRISC_OPCODE_RFE:
+	case OPENRISC_OPCODE_LWA:
+	case OPENRISC_OPCODE_MFSPR:
+	case OPENRISC_OPCODE_MTSPR:
+	case OPENRISC_OPCODE_SWA:
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(insn_not_supported)
+
+static bool is_branch_insn(kprobe_opcode_t insn)
+{
+	unsigned char opcode = get_6_bit_opcode(insn);
+
+	switch (opcode) {
+	case OPENRISC_OPCODE_BF:
+	case OPENRISC_OPCODE_BNF:
+	case OPENRISC_OPCODE_J:
+	case OPENRISC_OPCODE_JAL:
+	case OPENRISC_OPCODE_JALR:
+	case OPENRISC_OPCODE_JR:
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(is_branch_insn)
+
+static bool is_pc_insn(kprobe_opcode_t insn)
+{
+	unsigned char opcode = get_6_bit_opcode(insn);
+
+	if (opcode == OPENRISC_OPCODE_ADRP)
+		return true;
+
+	return false;
+}
+NOKPROBE_SYMBOL(is_pc_insn)
+
+static bool insns_need_simulation(kprobe_opcode_t insn, bool *exec_delay_slot)
+{
+	*exec_delay_slot = false;
+
+	if (is_branch_insn(insn)) {
+		if (static_branch_likely(&delay_slot))
+			*exec_delay_slot = true;
+		return true;
+	}
+
+	if (is_pc_insn(insn))
+		return true;
+
+	return false;
+}
+NOKPROBE_SYMBOL(insns_need_simulation)
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	kprobe_opcode_t insn;
+	kprobe_opcode_t prev_insn, next_insn;
+	bool exec_delay_slot = false;
+
+	/* Attempt to probe at unaligned address */
+	if ((unsigned long)p->addr & 0x3)
+		return -EILSEQ;
+
+	p->opcode = *p->addr;
+	insn = p->opcode;
+
+	if (insn_not_supported(insn)) {
+		pr_notice("Can't insert KProbe at blacklisted instruction.\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
+			OPENRISC_INSN_SIZE) == 0 && is_branch_insn(prev_insn)) {
+		if (static_branch_likely(&delay_slot)) {
+			pr_notice("Can't insert KProbe in delay slot.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (copy_from_kernel_nofault(&next_insn, p->addr + 1, OPENRISC_INSN_SIZE) == 0 &&
+	    insns_need_simulation(next_insn, &exec_delay_slot) && is_branch_insn(insn)) {
+		if (static_branch_likely(&delay_slot)) {
+			pr_notice("Can't insert KProbe if following instruction is in a delay slot and depends on PC.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (insns_need_simulation(insn, &exec_delay_slot) && !exec_delay_slot) {
+		p->ainsn.insn = NULL;
+	} else {
+		/*
+		 * Single step probed instruction or, in case of branch instructions, single
+		 * step instruction in delay slot.
+		 */
+		p->ainsn.insn = get_insn_slot();
+		if (!p->ainsn.insn)
+			return -ENOMEM;
+
+		if (exec_delay_slot)
+			patch_insn_write(p->ainsn.insn, *(p->addr + 1));
+		else
+			patch_insn_write(p->ainsn.insn, p->opcode);
+		patch_insn_write(&p->ainsn.insn[1], KPROBE_SSTEPBP_INSN);
+	}
+
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_prepare_kprobe);
+
+void arch_arm_kprobe(struct kprobe *p)
+{
+	patch_insn_write(p->addr, KPROBE_BP_INSN);
+	flush_insn_slot(p);
+}
+NOKPROBE_SYMBOL(arch_arm_kprobe);
+
+void arch_disarm_kprobe(struct kprobe *p)
+{
+	patch_insn_write(p->addr, p->opcode);
+	flush_insn_slot(p);
+}
+NOKPROBE_SYMBOL(arch_disarm_kprobe);
+
+void arch_remove_kprobe(struct kprobe *p)
+{
+	if (p->ainsn.insn) {
+		free_insn_slot(p->ainsn.insn, 0);
+		p->ainsn.insn = NULL;
+	}
+}
+NOKPROBE_SYMBOL(arch_remove_kprobe);
+
+static void set_current_kprobe(struct kprobe *p)
+{
+	__this_cpu_write(current_kprobe, p);
+}
+NOKPROBE_SYMBOL(set_current_kprobe);
+
+static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.restore_pc = kcb->restore_pc;
+}
+NOKPROBE_SYMBOL(save_previous_kprobe);
+
+static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->restore_pc = kcb->prev_kprobe.restore_pc;
+	set_current_kprobe(kcb->prev_kprobe.kp);
+}
+NOKPROBE_SYMBOL(restore_previous_kprobe);
+
+static void post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb,
+				struct pt_regs *regs)
+{
+	instruction_pointer_set(regs, kcb->restore_pc);
+
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		return;
+	}
+
+	kcb->kprobe_status = KPROBE_HIT_SSDONE;
+
+	if (cur->post_handler)
+		cur->post_handler(cur, regs, 0);
+
+	reset_current_kprobe();
+	preempt_enable_no_resched();
+}
+NOKPROBE_SYMBOL(post_kprobe_handler);
+
+static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
+			     struct kprobe_ctlblk *kcb, int reenter)
+{
+	kprobe_opcode_t insn;
+
+	if (reenter) {
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p);
+		kcb->kprobe_status = KPROBE_REENTER;
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+	}
+
+	/* Emulate instruction if required. */
+	insn = p->opcode;
+	if (is_branch_insn(insn)) {
+		simulate_branch(regs, insn);
+		/* Save target addr before updating PC to SSOL slot */
+		kcb->restore_pc = regs->pc;
+	} else if (is_pc_insn(insn)) {
+		simulate_pc(regs, insn);
+		kcb->restore_pc = regs->pc;
+		/* No SSOL is required here, so call post-process immediately. */
+		post_kprobe_handler(p, kcb, regs);
+		return;
+	} else
+		kcb->restore_pc = regs->pc + OPENRISC_INSN_SIZE;
+
+	if (p->ainsn.insn) {
+		/* Disable IRQs before single stepping */
+		local_irq_save(kcb->irq_flags);
+		instruction_pointer_set(regs, (unsigned long)p->ainsn.insn);
+	} else {
+		/*
+		 * The instruction is a branch but delay slots are disabled.
+		 * Simply call the post-handler.
+		 */
+		post_kprobe_handler(p, kcb, regs);
+	}
+}
+NOKPROBE_SYMBOL(setup_singlestep);
+
+static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
+			   struct kprobe_ctlblk *kcb)
+{
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_HIT_SSDONE:
+	case KPROBE_HIT_ACTIVE:
+		kprobes_inc_nmissed_count(p);
+		setup_singlestep(p, regs, kcb, 1);
+		break;
+	case KPROBE_REENTER:
+		pr_warn("Unrecoverable KProbe detected.\n");
+		dump_kprobe(p);
+		WARN_ON_ONCE(1);
+		return false;
+	default:
+		WARN_ON(1);
+		return false;
+	}
+
+	return true;
+}
+NOKPROBE_SYMBOL(reenter_kprobe);
+
+bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	struct kprobe *p, *curr_kprobe;
+	struct kprobe_ctlblk *kcb;
+	kprobe_opcode_t *addr = (kprobe_opcode_t *)regs->pc;
+	kprobe_opcode_t insn;
+
+	/*
+	 * We don't want to be preempted for the entire
+	 * duration of kprobe processing.
+	 */
+	preempt_disable();
+
+	kcb = get_kprobe_ctlblk();
+	curr_kprobe = kprobe_running();
+	p = get_kprobe(addr);
+	if (p) {
+		if (curr_kprobe) {
+			if (reenter_kprobe(p, regs, kcb))
+				return true;
+		} else {
+			/* Probe hit */
+			set_current_kprobe(p);
+			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+			/*
+			 * If there's no pre-handler or it returns 0, continue
+			 * processing the KProbe as usual. A non-zero return
+			 * value implies the saved registers have been modified
+			 * and the execution path might deviate from what's
+			 * expected. Reset the KProbe and return.
+			 */
+			if (!p->pre_handler || !p->pre_handler(p, regs)) {
+				setup_singlestep(p, regs, kcb, 0);
+			} else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+			}
+			return true;
+		}
+	}
+
+	/*
+	 * The breakpoint instruction was removed right after we hit it
+	 * possibly by another cpu. If the original instruction was also
+	 * a trap instruction then return to the trap handler for further
+	 * processing, else no further processing is required.
+	 */
+	if (get_kernel_nofault(insn, addr) < 0
+		|| (*addr & OPENRISC_MASK_TRAP) != OPENRISC_INSN_TRAP) {
+		preempt_enable_no_resched();
+		return true;
+	}
+
+	preempt_enable_no_resched();
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_breakpoint_handler);
+
+bool kprobe_singlestep_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long addr = instruction_pointer(regs);
+
+	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
+	    ((unsigned long)&cur->ainsn.insn[1] == addr)) {
+		/* Single stepping has been completed. Enable IRQs. */
+		regs->sr |= kcb->irq_flags;
+		local_irq_restore(kcb->irq_flags);
+		post_kprobe_handler(cur, kcb, regs);
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_singlestep_handler);
+
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * The instruction being single-stepped caused a page fault.
+		 * Reset the current KProbe and set PC to the probe's address.
+		 * Then allow the page fault handler to continue as usual.
+		 */
+		instruction_pointer_set(regs, (unsigned long)cur->addr);
+
+		if (kcb->kprobe_status == KPROBE_REENTER) {
+			restore_previous_kprobe(kcb);
+		} else {
+			regs->sr |= kcb->irq_flags;
+			local_irq_restore(kcb->irq_flags);
+			reset_current_kprobe();
+			preempt_enable_no_resched();
+		}
+		break;
+	}
+
+	return 0;
+}
+NOKPROBE_SYMBOL(kprobe_fault_handler);
+
+int __init arch_init_kprobes(void)
+{
+	return 0;
+}
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index c9ab630ec895..2d6b29ea8c4f 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -30,10 +30,12 @@
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
 
+#include <asm/break.h>
 #include <asm/bug.h>
 #include <asm/fpu.h>
 #include <asm/insn-def.h>
 #include <asm/io.h>
+#include <asm/kprobes.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
 #include <asm/sections.h>
@@ -246,6 +248,7 @@ asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 		die("Die:", regs, SIGILL);
 	}
 }
+NOKPROBE_SYMBOL(do_trap)
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 {
diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
index e2af9b510804..701262a40134 100644
--- a/arch/openrisc/lib/memcpy.c
+++ b/arch/openrisc/lib/memcpy.c
@@ -16,6 +16,7 @@
 
 #include <linux/export.h>
 
+#include <linux/kprobes.h>
 #include <linux/string.h>
 
 #ifdef CONFIG_OR1K_1200
@@ -122,4 +123,5 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
 }
 #endif
 
+NOKPROBE_SYMBOL(memcpy);
 EXPORT_SYMBOL(memcpy);
diff --git a/arch/openrisc/lib/memset.S b/arch/openrisc/lib/memset.S
index c3ac2a8b68d3..14e63af12d73 100644
--- a/arch/openrisc/lib/memset.S
+++ b/arch/openrisc/lib/memset.S
@@ -9,6 +9,8 @@
  * Copyright (C) 2015 Olof Kindgren <olof.kindgren@gmail.com>
  */
 
+#include <asm/asm.h>
+
 	.global memset
 	.type	memset, @function
 memset:
@@ -92,3 +94,5 @@ memset:
 
 4:	l.jr		r9
 	 l.ori		r11, r3, 0
+
+_ASM_NOKPROBE(memset)
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 29e232d78d82..5263a832562f 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/extable.h>
+#include <linux/kprobes.h>
 #include <linux/sched/signal.h>
 #include <linux/perf_event.h>
 
@@ -55,6 +56,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	tsk = current;
 
+	if (kprobe_page_fault(regs, vector))
+		return;
+
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -351,3 +355,4 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		return;
 	}
 }
+NOKPROBE_SYMBOL(do_page_fault)
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 53ec6c8b8c40..84e26ebef70b 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -59,6 +59,10 @@ static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
 	pr_info("<%s> p->addr = 0x%p, era = 0x%lx, estat = 0x%lx\n",
 		p->symbol_name, p->addr, regs->csr_era, regs->csr_estat);
 #endif
+#ifdef CONFIG_OPENRISC
+	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
+		p->symbol_name, p->addr, regs->pc, regs->sr);
+#endif
 
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
@@ -100,6 +104,10 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 	pr_info("<%s> p->addr = 0x%p, estat = 0x%lx\n",
 		p->symbol_name, p->addr, regs->csr_estat);
 #endif
+#ifdef CONFIG_OPENRISC
+	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
+		p->symbol_name, p->addr, regs->sr);
+#endif
 }
 
 static int __init kprobe_init(void)
-- 
2.55.0

