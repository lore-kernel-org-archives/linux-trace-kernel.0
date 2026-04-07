Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37D33A9DE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588323; cv=none; b=qvdU+8uFW9CjTbbL8gExJ9Dm/yUI1Jz12UzSmJYxBwIIMdtf5BGKa+B30tk8HeKYyS1Xts39O/tRVQRLy9m+VR+uUQWaf+ipCUwNgdstjkIAg+ZUiUxB4lSKkCr48MuSMkVanKxuwc4K3Exl2BAw4fpj5P+CCJKkDjlN3ovlQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588323; c=relaxed/simple;
	bh=M/kGRbL/4LArPoM4UqPQVrEqZbvE9S8tBqqRfQLPQ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMxq0K4ou4G8BJ6OHo4w8LyO2pAGa56nl4V0IiIXT01x+1CRLIcFeWvj6+7Eurvk008WZHO5UpJ8ZDMpuhEVIVA2xNMuYXb/XBl4YLPFlFRT0U+1xbAj1+g2qfkxdyb640wsjdDocZ5PKMAX7pNVammRT7F6bLitvKJzvSPPOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU/Wm9sC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU/Wm9sC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b23fcf90b2so53093555ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588321; x=1776193121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qpfl67BwNUGKz5mtCYNigYyMPxt2kbknFc7+Iynv6Hg=;
        b=rU/Wm9sCo/Jhqh9qJnKPsajXBNRW8kUPnXS3+t3DjjuYaA08Q3kXDU1Hp9N5x2zMn6
         feNiWp9vUqkprr/d9IlOTXZnuMbxVyVZSbqY3uYOnShxXMs5WBKZiONBZL/6ekXdjAlz
         Qyyfcw7hRKQYURTlOuo9jK72hIZ+wIZvOHsWX4rE0pJO5l/vr2RpY8oKXo6aaE1jWl7a
         zn2BgJO77tuCj+UfL4yDsHWStC0GGX0wv2gqBnMfOFrtfme7ORkgatZW1RDseMBd1E/a
         1dUeftD9lMR/++F2EVBWPDylzslx/0rP8SkCTGH1PojjadwXTR4BeGHARE6xgEEawm4B
         nCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588321; x=1776193121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qpfl67BwNUGKz5mtCYNigYyMPxt2kbknFc7+Iynv6Hg=;
        b=rbuDPS+cb7et1WOjA6GVQMxj2fkrOCLkp7TSify38PPsQm8fuFZOYdgLih8vssOwwp
         W+EftWh9rxeGSvMnZXNN+Lex8BU8oi6SB0oNoygqNZRqFaC5T9H9+/Kn7JATil6KVuaL
         OjzRvORC4QLc0n/oHgnVoEHLSw+psqLlO9cdWXGF0zL5mJTE0X0oxfShTCFdd8Hht8w/
         WKImggpnkZXobddfT32f5BeeCJjI7YkDgjNpv5uHhXAcHss+wqzDk42qGfgg0xC4OmXa
         PyJIS+IieGxCmRXbhiIdiAtodA1tS2aPKczOtSgkwj7QEe8d8CegrpMpsojf+oii4jOZ
         uQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWYgyC245kYN2inUzN5zvCvFd0907z09tzAiUKm8aEiIznvkvpLhKZpcRIgVdVVKruXAhH6CgOiETDH62bADO7FtcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBuNepCJiGJ0zB3PanFtDk2jGLGz//g7VbBcLzRCqdKLI1Fbc
	JCE2w0oVFGtH3y10xdWQkcFuO8Ftkt/TVIhx8AsQlfxsznH4NaIGbiRwc0z0BA==
X-Gm-Gg: AeBDietju8bj7HpfGZzkOlWite7mjEJDrjIs7MT3V3j18PfPbA7pGMzeyYYvHAnL7rU
	SfxCbR7slbvFCIkfgH3/AKKCy7kruMUxSHcVnECeIrtImhKa800bcRiMa5cKCcdckiYENGWag8O
	Rkkz4aUthEPjUSXD/N5Zy6wRP3ti7UMzC/miSubIF0UnT2kj426KTwVF6TWpHxoj1RZ8W/od4af
	eY/tygZHlXVIQFFa+MfDR4TxWzbzWwfLhYJWT/kEW4S5I8kaIqqbk0WiwiIrFgbyi6kAGqqOhB5
	F5F7OMr+gP2Ji+LiKmyhG5bm/nuKNmGiFUZYFbPVRrxB7cWRokaa2ZjP7DX/mqk1bBdQ/5op78k
	9oyxzQfFwxuTLqfnnvGrKyvRBJ4rZkAYfsx7SxzaQ5vypR2BasYuOewRnRA2U2xzK7I9CRVcb6b
	5E8R6uy91AwdHrAR1cc+JoN4Q4XETUcHU=
X-Received: by 2002:a17:902:f541:b0:2b0:ac1e:973a with SMTP id d9443c01a7336-2b281889a3dmr174544395ad.39.1775588320486;
        Tue, 07 Apr 2026 11:58:40 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c45:a41c:c2d5:268a:232e:d07e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm193486145ad.81.2026.04.07.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:58:40 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	chenmiao.ku@gmail.com,
	johannes@sipsolutions.net,
	nsc@kernel.org,
	masahiroy@kernel.org,
	tytso@mit.edu,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [RFC 2/2] openrisc: Add KProbes
Date: Wed,  8 Apr 2026 00:26:50 +0530
Message-ID: <20260407185650.79816-3-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407185650.79816-1-sahilcdq0@gmail.com>
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
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
 arch/openrisc/include/asm/kprobes.h     |  76 +++++
 arch/openrisc/kernel/Makefile           |   1 +
 arch/openrisc/kernel/entry.S            |  16 +
 arch/openrisc/kernel/kprobes.c          | 381 ++++++++++++++++++++++++
 arch/openrisc/kernel/traps.c            |  26 ++
 arch/openrisc/lib/memcpy.c              |   2 +
 arch/openrisc/lib/memset.S              |   4 +
 arch/openrisc/mm/fault.c                |   5 +
 samples/kprobes/kprobe_example.c        |   8 +
 14 files changed, 565 insertions(+)
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
index 000000000000..1a9c8bbb4430
--- /dev/null
+++ b/arch/openrisc/include/asm/asm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
index 000000000000..4bd04f4dd17a
--- /dev/null
+++ b/arch/openrisc/include/asm/break.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
index 000000000000..50b6dc6d5a0c
--- /dev/null
+++ b/arch/openrisc/include/asm/kprobes.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+	/* address of next instruction in case of SSOL */
+	unsigned long restore;
+};
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	unsigned long irq_flags;
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
index 000000000000..f9073a1cb6eb
--- /dev/null
+++ b/arch/openrisc/kernel/kprobes.c
@@ -0,0 +1,381 @@
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
+#include <asm/insn-def.h>
+#include <asm/text-patching.h>
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe);
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+#define KPROBE_BP_INSN		__emit_trap(BRK_KPROBE_BP)
+#define KPROBE_SSTEPBP_INSN	__emit_trap(BRK_KPROBE_SSTEPBP)
+
+static bool insn_not_supported(union openrisc_instruction insn)
+{
+	switch (insn.word) {
+	case INSN_CSYNC:
+	case INSN_MSYNC:
+	case INSN_PSYNC:
+		return true;
+	}
+
+	if ((insn.word & 0xffff0000) == OPCODE_SYS)
+		return true;
+
+	if ((insn.word & 0xfc01ffff) == OPCODE_MACRC)
+		return true;
+
+	switch (insn.opcodes_6bit.opcode) {
+	case l_rfe:
+	case l_lwa:
+	case l_mfspr:
+	case l_mtspr:
+	case l_swa:
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(insn_not_supported)
+
+static bool is_branch_insn(union openrisc_instruction insn)
+{
+	switch (insn.opcodes_6bit.opcode) {
+	case l_j:
+	case l_jal:
+	case l_bnf:
+	case l_bf:
+	case l_jr:
+	case l_jalr:
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(is_branch_insn)
+
+static bool is_pc_insn(union openrisc_instruction insn)
+{
+	if (insn.opcodes_6bit.opcode == l_adrp)
+		return true;
+
+	return false;
+}
+NOKPROBE_SYMBOL(is_pc_insn)
+
+static bool insns_need_simulation(union openrisc_instruction insn, bool *exec_delay_slot)
+{
+	if (is_branch_insn(insn)) {
+		*exec_delay_slot = has_delay_slot();
+		return true;
+	}
+
+	if (is_pc_insn(insn)) {
+		*exec_delay_slot = false;
+		return true;
+	}
+
+	*exec_delay_slot = false;
+	return false;
+}
+NOKPROBE_SYMBOL(insns_need_simulation)
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	union openrisc_instruction insn;
+	union openrisc_instruction prev_insn;
+	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
+	bool ss_delay_slot = false, exec_delay_slot = false;
+
+	/* Attempt to probe at unaligned address */
+	if ((unsigned long)p->addr & 0x3)
+		return -EILSEQ;
+
+	p->opcode = *p->addr;
+	insn.word = p->opcode;
+
+	if (insn_not_supported(insn)) {
+		pr_notice("Can't insert KProbe at blacklisted instruction.\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
+			OPENRISC_INSN_SIZE) == 0 &&
+		insns_need_simulation(prev_insn, &exec_delay_slot) && exec_delay_slot) {
+		pr_notice("Can't insert KProbe in delay slot.\n");
+		return -EINVAL;
+	}
+
+	if (insns_need_simulation(insn, &exec_delay_slot) && !exec_delay_slot) {
+		p->ainsn.insn = NULL;
+		p->ainsn.restore = 0;
+	} else {
+		/*
+		 * Single step probed instruction or, in case of branch instructions, single
+		 * step instruction in delay slot.
+		 */
+		p->ainsn.insn = get_insn_slot();
+		if (!p->ainsn.insn)
+			return -ENOMEM;
+
+		if (exec_delay_slot) {
+			patch_insn_write(p->ainsn.insn, *(p->addr + 1));
+			p->ainsn.restore = 0;
+		} else {
+			patch_insn_write(p->ainsn.insn, p->opcode);
+			p->ainsn.restore = (unsigned long)p->addr + OPENRISC_INSN_SIZE;
+		}
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
+}
+NOKPROBE_SYMBOL(save_previous_kprobe);
+
+static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	set_current_kprobe(kcb->prev_kprobe.kp);
+}
+NOKPROBE_SYMBOL(restore_previous_kprobe);
+
+static void post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb,
+				struct pt_regs *regs)
+{
+	if (cur->ainsn.restore != 0)
+		instruction_pointer_set(regs, (unsigned long)cur->ainsn.restore);
+
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		preempt_enable_no_resched();
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
+	union openrisc_instruction insn;
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
+	insn.word = p->opcode;
+	if (is_branch_insn(insn)) {
+		simulate_branch(regs, insn.word, has_delay_slot());
+		/* Save target addr before updating PC to SSOL slot */
+		p->ainsn.restore = regs->pc;
+	} else if (is_pc_insn(insn)) {
+		simulate_pc(regs, insn.word);
+		/* No SSOL is required here, so call post-process immediately. */
+		post_kprobe_handler(p, kcb, regs);
+		return;
+	}
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
+		break;
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
+	if ((*addr & 0xffff0000) != OPCODE_TRAP) {
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
+		local_irq_restore(kcb->irq_flags);
+		post_kprobe_handler(cur, kcb, regs);
+		return true;
+	}
+
+	preempt_enable_no_resched();
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
index ee87a3af34fc..ae6bfcca388e 100644
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
@@ -216,10 +218,34 @@ asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 	if (user_mode(regs)) {
 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
 	} else {
+		unsigned int trap = *(unsigned int *)regs->pc, cpucfgr = mfspr(SPR_CPUCFGR), bcode;
+
+		/*
+		 * Trap instruction was probably removed and no further processing
+		 * is required.
+		 */
+		if ((trap & 0xffff0000) != OPCODE_TRAP)
+			return;
+
+		bcode = (trap & 0xffff);
+		switch (bcode) {
+		case BRK_KPROBE_BP:
+			if (kprobe_breakpoint_handler(regs))
+				return;
+			break;
+		case BRK_KPROBE_SSTEPBP:
+			if (kprobe_singlestep_handler(regs))
+				return;
+			break;
+		default:
+			break;
+		}
+
 		pr_emerg("KERNEL: Illegal trap exception 0x%.8lx\n", regs->pc);
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
2.53.0

