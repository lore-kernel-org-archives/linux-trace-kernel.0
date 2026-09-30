Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BC50E594
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800329; cv=none; b=QIWF7TJCMfTV34Py1R1ZDieibI367BXQi/MnD0dU8Caqkw3D2NbQKdeh4Ek9x++g03IwTsxY8R/HQfOITCC5RU1c31AqXeWNOAeePN0Iy9aF3pfZLoU2FSZ9EpWJnn+wceDwEUDL9Sy/JCScuaXP6ehPA5hzjzmTmnVZfk1ebAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800329; c=relaxed/simple;
	bh=IU67YLAuaCjJu5YpuQOVB88G9rpIjCwtpSIkiqXDfq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phO4VedtkIWLz/+9W5EAQBD8TCvcIOU/lBr48JCUvzMH5djw4+48Xc6+raYr5aCcJMzqgBcyACCBiCb2wO0/BroWQLfNxvRl7so5VwfTSHsDE0mTbB4m3znd+DXh2PXLqVgqSE5q4PWIbjrWBQ7AYHzfYwtVAdlKmv2C3ZSXtKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvGMiTZg; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvGMiTZg"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34d2d25127aso542693eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800326; x=1791405126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mh6g+TBRFwtJy8uHgWDr9TCO26q8JAwE1d0FUQuYehA=;
        b=fvGMiTZg68lM84Ctl2jFF/+6fw9FkNGybOTzI91IQRslb2hJ+KgKZhuocRw+p4CpZE
         UT4m9BwmWHp79TN5yu/MZcsCF9AaFu6K7FIZ/cAkHbzQdLkH71SfxtML59kIHs58XJj6
         BS6I56eyeyI1icAYiF50oDhAv/np5eoyeGhYy/f68bV6veHFVbV8unv/ETj9PueWE2qP
         t0Qa60yZ2MirOUIVMJNptte4ypD8h8IQfU8BhiHLdPwBhJm6HYURKRUwvPTGLXPeVJCJ
         +lxsQLk5WXvxNoxB2xX3oW0FZMMpDiJsGTLnTRQbNQnln3u9ynuAbH9SPdWjrK2HLv2a
         oLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800326; x=1791405126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mh6g+TBRFwtJy8uHgWDr9TCO26q8JAwE1d0FUQuYehA=;
        b=LOC9W6UC+aXJtf6fFGBChOcFIaXXXkEZtP0JOm4emd3aBVjk4Q7H7n4R+5UUgoy4kZ
         DwcznBMMrWn1YJ27nugb1Fk1YfoVAeNiU8V3B+iUd2lvHnnl5lZbMibyyPDiKYnFLdBn
         g2/MycDwiAXk22Y/XSKHTbfKwzQLRwQ7eGfKlVW6PBTCh5QLvpSFkiHdAWEBpxzVAp9C
         ZJ3aPODjrrRokyFJBywMpI7OgIR1ZKi+Cbl8aQzi8SeyNGZ32XyXflmHJPaiAeSON2hb
         rqBLUFq6ECMTq8AgAWSwmt9nOYNtJUavR5OGgOGWwfP4XsAnv6UvNNPuPK+vjEhCxhuP
         QTsg==
X-Forwarded-Encrypted: i=1; AKwUvBzgmleOxA3qr2EQmtG3ZQI3cXQDZlp41Vo1bC8wyLTB4jXSxWJhR2sU03pVj0ZQuE+bSC1aMXb0MIcyImEnHphLDeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQwTdg6ereGyVwFN/QmnHYN9aRo1PcMOoY2rLQ30myND8Mf07f
	++ihUkfb5y1mD9rTS4/OrXNtxsAHwC7YDT1BxISgJ5RN3CjxgG4mvxGe
X-Gm-Gg: AYBFou2E+fjUOIF1A8ApgA8GrfyHPQ/zEimLHDjLF18s0Fh9KNqVC+4mtEUjurMnybc
	vb/MXGl6GwrPIUOX9rXjnEQ9OP6F3mBCRw4Zbk4U4mVY1BRvZ7Rwl9S3P0Jss40GBEhcArXTRm5
	fogLVnIunquqLgI5Eds0epS/EM/OxkGcvoKVri+1kdviq/R5cuPhVYxnADufWHrZ5GpexCvmay+
	hT5zeqnaj3Glrlia3hOgux/oanZoyrEkP5SCV79QPwDSyflSHYjwSmY5FVg2pjKM954V0Mq/vbl
	DXnfNpWkZqQ7TKPA8hcaXI9pfloTi5zmx9oCc2AmB5il92MuI468IOdtaWa3Dzb+vTZ+XHyoVT7
	SbeLTHMCcPhl6+lOUpJHnm26S8JLUufaNOMJWIWDH5Ov5xqcxeHdjtud3CIsCTsfOOCA1VDebRt
	FiWCcZjesVDGsQs6XC6MN5Yzbg5Z6Gb7aQX3JQ5vCb+1NsWvIFlj4ddIJqZxh9dUaetzevOVQgB
	xyPUxnW+0u0eKJe
X-Received: by 2002:a05:7301:1928:b0:33b:bea7:84dd with SMTP id 5a478bee46e88-34cdda8b4d4mr2596612eec.34.1790800326267;
        Wed, 30 Sep 2026 13:32:06 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:2e39:63b8:ea3c:fa28:7091])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1162411eec.29.2026.09.30.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:32:05 -0700 (PDT)
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
Subject: [PATCH v2 1/4] openrisc: Add utilities and clean up simulation of instructions
Date: Thu,  1 Oct 2026 02:01:26 +0530
Message-ID: <20260930203129.51048-2-sahilcdq0@gmail.com>
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

Introduce new instruction-related utilities and macros for OpenRISC.
This is in preparation for patches that add tracing support such as
KProbes and Kretprobes.

Currently, PC is first updated and then saved in the link register
(r9) when simulating l.jal and l.jalr. This can result in a corrupted
page table (bad page map in process). Fix this by saving PC in r9
before updating it.

Move branch simulation to its own function, simulate_branch(), so it
can be reused. It's already being used by do_illegal_instruction().
It'll also be used by KProbes in the following commit.

Introduce simulate_pc() to simulate l.adrp. KProbes will require this
instruction to be simulated as well. simulate_branch() and simulate_pc()
need to be handled differently since branch instructions change the
value of PC while l.adrp depends on PC but doesn't change its value.

Use a static key to check if delay slots are disabled. Delay slots are
a part of the CPU's configuration and won't change at runtime. Since
they are often enabled in an OpenRISC CPU, using a static key will
reduce the overhead of checking this flag in the default case while
processing KProbes inserted at branch instructions and simulating them.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
 arch/openrisc/include/asm/cpuinfo.h  |  3 +
 arch/openrisc/include/asm/insn-def.h | 64 +++++++++++++++++++--
 arch/openrisc/include/asm/spr_defs.h |  1 +
 arch/openrisc/kernel/Makefile        |  2 +-
 arch/openrisc/kernel/insn.c          | 84 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/setup.c         |  4 ++
 arch/openrisc/kernel/traps.c         | 79 +++++++++++---------------
 7 files changed, 187 insertions(+), 50 deletions(-)
 create mode 100644 arch/openrisc/kernel/insn.c

diff --git a/arch/openrisc/include/asm/cpuinfo.h b/arch/openrisc/include/asm/cpuinfo.h
index 3cfc4cf0b019..d6bb8744eba0 100644
--- a/arch/openrisc/include/asm/cpuinfo.h
+++ b/arch/openrisc/include/asm/cpuinfo.h
@@ -15,6 +15,7 @@
 #ifndef __ASM_OPENRISC_CPUINFO_H
 #define __ASM_OPENRISC_CPUINFO_H
 
+#include <linux/jump_label.h>
 #include <asm/spr.h>
 #include <asm/spr_defs.h>
 
@@ -34,6 +35,8 @@ struct cpuinfo_or1k {
 	u16 coreid;
 };
 
+DECLARE_STATIC_KEY_TRUE(delay_slot);
+
 extern struct cpuinfo_or1k cpuinfo_or1k[NR_CPUS];
 extern void setup_cpuinfo(void);
 
diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
index 1e0c028a5b95..3680c0a94faf 100644
--- a/arch/openrisc/include/asm/insn-def.h
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -3,13 +3,69 @@
  * Copyright (C) 2025 Chen Miao
  */
 
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+#include <linux/bits.h>
+
 #ifndef __ASM_OPENRISC_INSN_DEF_H
 #define __ASM_OPENRISC_INSN_DEF_H
 
-/* or1k instructions are always 32 bits. */
-#define	OPENRISC_INSN_SIZE		4
-
 /* or1k nop instruction code */
-#define OPENRISC_INSN_NOP     0x15000000U
+#define OPENRISC_INSN_CSYNC	0x23000000U
+#define OPENRISC_INSN_MACRC	0x18010000U
+#define OPENRISC_MASK_MACRC	0xfc01ffffU
+#define OPENRISC_INSN_MSYNC	0x22000000U
+#define OPENRISC_INSN_NOP	0x15000000U
+#define OPENRISC_INSN_PSYNC	0x22800000U
+#define OPENRISC_INSN_SYS	0x20000000U
+#define OPENRISC_INSN_TRAP	0x21000000U
+
+#define OPENRISC_OPCODE_ADRP	0x02
+#define OPENRISC_OPCODE_BF		0x04
+#define OPENRISC_OPCODE_BNF		0x03
+#define OPENRISC_OPCODE_J		0x00
+#define OPENRISC_OPCODE_JAL		0x01
+#define OPENRISC_OPCODE_JALR	0x12
+#define OPENRISC_OPCODE_JR		0x11
+#define OPENRISC_OPCODE_LWA		0x1b
+#define OPENRISC_OPCODE_MFSPR	0x2d
+#define OPENRISC_OPCODE_MTSPR	0x30
+#define OPENRISC_OPCODE_RFE		0x09
+#define OPENRISC_OPCODE_SWA		0x33
+
+#define OPENRISC_ADRP_IMM_MASK		GENMASK(18, 0)
+#define OPENRISC_ADRP_OFFSET_MASK	GENMASK(31, 13)
+#define OPENRISC_ADRP_IMM_SHIFT		13
+#define OPENRISC_ADRP_REG_MASK		GENMASK(25, 0)
+#define OPENRISC_ADRP_REG_SHIFT		21
+#define OPENRISC_JUMP_IMM_MASK		GENMASK(25, 0)
+#define OPENRISC_JUMP_IMM_SHIFT		2
+#define OPENRISC_JUMP_REG_MASK		GENMASK(15, 11)
+#define OPENRISC_JUMP_REG_SHIFT		11
+
+#define OPENRISC_MASK_SYS	GENMASK(31, 16)
+#define OPENRISC_MASK_TRAP	GENMASK(31, 16)
+#define OPENRISC_MASK_BCODE	GENMASK(15, 0)
+
+#define OPENRISC_OPCODE_MASK	0x3f
+#define OPENRISC_OPCODE_SHIFT	0x1a
+
+struct pt_regs;
+
+#define OPENRISC_INSN_SIZE	4
+
+/* Helpers for working with l.trap */
+static inline unsigned long __emit_trap(unsigned long code)
+{
+	return (code & OPENRISC_MASK_BCODE) | OPENRISC_INSN_TRAP;
+}
+
+static __always_inline unsigned char get_6_bit_opcode(unsigned long insn)
+{
+	return (insn >> OPENRISC_OPCODE_SHIFT) & OPENRISC_OPCODE_MASK;
+}
+
+void simulate_pc(struct pt_regs *regs, unsigned long jmp);
+void simulate_branch(struct pt_regs *regs, unsigned long jmp);
 
 #endif /* __ASM_OPENRISC_INSN_DEF_H */
diff --git a/arch/openrisc/include/asm/spr_defs.h b/arch/openrisc/include/asm/spr_defs.h
index f0b6b492e9f4..5d13a9b96263 100644
--- a/arch/openrisc/include/asm/spr_defs.h
+++ b/arch/openrisc/include/asm/spr_defs.h
@@ -179,6 +179,7 @@
 #define SPR_CPUCFGR_OF32S  0x00000080  /* ORFPX32 supported */
 #define SPR_CPUCFGR_OF64S  0x00000100  /* ORFPX64 supported */
 #define SPR_CPUCFGR_OV64S  0x00000200  /* ORVDX64 supported */
+#define SPR_CPUCFGR_ND     0x00000400  /* No delay slot */
 #define SPR_CPUCFGR_RES	   0xfffffc00  /* Reserved */
 
 /*
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 19e0eb94f2eb..150779fbf010 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -5,7 +5,7 @@
 
 always-$(KBUILD_BUILTIN)	:= vmlinux.lds
 
-obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
+obj-y	:= head.o insn.o setup.o or32_ksyms.o process.o dma.o \
 	   traps.o time.o irq.o entry.o ptrace.o signal.o \
 	   sys_call_table.o unwinder.o cacheinfo.o
 
diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
new file mode 100644
index 000000000000..285658512b43
--- /dev/null
+++ b/arch/openrisc/kernel/insn.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * OpenRISC instruction utils
+ *
+ * Linux architectural port borrowing liberally from similar works of
+ * others.  All original copyrights apply as per the original source
+ * declaration.
+ *
+ * OpenRISC implementation:
+ * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#include <linux/ptrace.h>
+#include <asm/insn-def.h>
+#include <asm/cpuinfo.h>
+
+DEFINE_STATIC_KEY_TRUE(delay_slot);
+
+void simulate_pc(struct pt_regs *regs, unsigned long pc_insn)
+{
+	int page_offset;
+	unsigned int rd, op;
+
+	page_offset = sign_extend32(
+		(pc_insn & OPENRISC_ADRP_IMM_MASK) << OPENRISC_ADRP_IMM_SHIFT, 31);
+	rd = (pc_insn & OPENRISC_ADRP_REG_MASK) >> OPENRISC_ADRP_REG_SHIFT;
+	op = get_6_bit_opcode(pc_insn);
+
+	switch (op) {
+	case OPENRISC_OPCODE_ADRP:
+		regs->gpr[rd] = page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);
+		regs->pc += OPENRISC_INSN_SIZE;
+		return;
+	default:
+		break;
+	}
+}
+
+void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
+{
+	int displacement;
+	unsigned int rb, op, link_offset, temp;
+
+	displacement = sign_extend32(
+		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
+	rb = (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
+	op = get_6_bit_opcode(jmp_insn);
+	link_offset = OPENRISC_INSN_SIZE;
+
+	if (static_branch_likely(&delay_slot))
+		link_offset <<= 1;
+
+	switch (op) {
+	case OPENRISC_OPCODE_J: /* l.j */
+		regs->pc += displacement;
+		return;
+	case OPENRISC_OPCODE_JAL: /* l.jal */
+		regs->gpr[9] = regs->pc + link_offset;
+		regs->pc += displacement;
+		return;
+	case OPENRISC_OPCODE_BNF: /* l.bnf */
+		if (regs->sr & SPR_SR_F)
+			regs->pc += link_offset;
+		else
+			regs->pc += displacement;
+		return;
+	case OPENRISC_OPCODE_BF: /* l.bf */
+		if (regs->sr & SPR_SR_F)
+			regs->pc += displacement;
+		else
+			regs->pc += link_offset;
+		return;
+	case OPENRISC_OPCODE_JR: /* l.jr */
+		regs->pc = regs->gpr[rb];
+		return;
+	case OPENRISC_OPCODE_JALR: /* l.jalr */
+		temp = regs->pc + link_offset;
+		regs->pc = regs->gpr[rb];
+		regs->gpr[9] = temp;
+		return;
+	default:
+		break;
+	}
+}
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 000a9cc10e6f..0f69c36472d5 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -255,6 +255,10 @@ void __init setup_arch(char **cmdline_p)
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
+	/* determine if the processor supports delay slots */
+	if (mfspr(SPR_CPUCFGR) & SPR_CPUCFGR_ND)
+		static_branch_disable(&delay_slot);
+
 	*cmdline_p = boot_command_line;
 
 	printk(KERN_INFO "OpenRISC Linux -- http://openrisc.io\n");
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index c195be9cc9fc..c9ab630ec895 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -32,6 +32,7 @@
 
 #include <asm/bug.h>
 #include <asm/fpu.h>
+#include <asm/insn-def.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
@@ -215,6 +216,32 @@ asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 	if (user_mode(regs)) {
 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
 	} else {
+		unsigned long trap, bcode;
+
+		if (get_kernel_nofault(trap, (unsigned long *)regs->pc) < 0)
+			return;
+
+		/*
+		 * Trap instruction was probably removed and no further processing
+		 * is required.
+		 */
+		if ((trap & OPENRISC_MASK_TRAP) != OPENRISC_INSN_TRAP)
+			return;
+
+		bcode = (trap & OPENRISC_MASK_BCODE);
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
@@ -252,12 +279,12 @@ static inline int in_delay_slot(struct pt_regs *regs)
 	insn = *((unsigned int *)regs->pc);
 	op = insn >> 26;
 	switch (op) {
-	case 0x00: /* l.j */
-	case 0x01: /* l.jal */
-	case 0x03: /* l.bnf */
-	case 0x04: /* l.bf */
-	case 0x11: /* l.jr */
-	case 0x12: /* l.jalr */
+	case OPENRISC_OPCODE_J: /* l.j */
+	case OPENRISC_OPCODE_JAL: /* l.jal */
+	case OPENRISC_OPCODE_BNF: /* l.bnf */
+	case OPENRISC_OPCODE_BF: /* l.bf */
+	case OPENRISC_OPCODE_JR: /* l.jr */
+	case OPENRISC_OPCODE_JALR: /* l.jalr */
 		return 1;
 	default:
 		return 0;
@@ -269,47 +296,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
 
 static inline void adjust_pc(struct pt_regs *regs, unsigned long address)
 {
-	int displacement;
-	unsigned int rb, op, jmp;
-
 	if (unlikely(in_delay_slot(regs))) {
 		/* In delay slot, instruction at pc is a branch, simulate it */
-		jmp = *((unsigned int *)regs->pc);
-
-		displacement = sign_extend32(((jmp) & 0x3ffffff) << 2, 27);
-		rb = (jmp & 0x0000ffff) >> 11;
-		op = jmp >> 26;
-
-		switch (op) {
-		case 0x00: /* l.j */
-			regs->pc += displacement;
-			return;
-		case 0x01: /* l.jal */
-			regs->pc += displacement;
-			regs->gpr[9] = regs->pc + 8;
-			return;
-		case 0x03: /* l.bnf */
-			if (regs->sr & SPR_SR_F)
-				regs->pc += 8;
-			else
-				regs->pc += displacement;
-			return;
-		case 0x04: /* l.bf */
-			if (regs->sr & SPR_SR_F)
-				regs->pc += displacement;
-			else
-				regs->pc += 8;
-			return;
-		case 0x11: /* l.jr */
-			regs->pc = regs->gpr[rb];
-			return;
-		case 0x12: /* l.jalr */
-			regs->pc = regs->gpr[rb];
-			regs->gpr[9] = regs->pc + 8;
-			return;
-		default:
-			break;
-		}
+		simulate_branch(regs, *((unsigned int *)regs->pc));
 	} else {
 		regs->pc += 4;
 	}
-- 
2.55.0

