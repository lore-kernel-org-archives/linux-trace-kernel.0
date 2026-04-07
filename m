Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6931195C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588308; cv=none; b=aci7ZgR8PLy+VtjdH0BtH6QOEXaHggH17hI7qLl8DmCehZej0rhKzpHOnkN2YFWqaJGxwAucyCGkw6tDa408qngoavAt4J9JcSOf270QyYKFqQ04XI7ss+TMP61NKM4bgSSKsIWkPu/qxLPJ4jJVpdsUnJP3MOxRafAag5o0R0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588308; c=relaxed/simple;
	bh=2IKDEV2NvzggWkv/fIrblQNJBFwe2ulCsavfVPQSQqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSRgfgxn1ptNjg3+QWlIpgY/sQTHaDJSTObi9QOuq6a/ItTve97kRM8oAFL+kr/jktylVQ3SuU59Jnvk5WIwjkaQIrOuaZvEnrs9JPEzTH0Q9UAhQ5XLCz/ptk7PVYnXbO8nlUunfZ7oiMl7jEKtR/mBtnUawscu6UAjgf+GHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myNY7oc9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myNY7oc9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aae146b604so34170935ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588305; x=1776193105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tENyS4UAhsyLXewunDkyxFOS4fIoNLiSb3W3F/WSw2w=;
        b=myNY7oc9DJzM88c/TMJsoxTHsKNKZUyARQi06TFfGS3GoxjRXfssCdm/8yttVFms1V
         QAANnqDJ2DANVrNZhlIzZTffp9uY7ZcEYxaOfHuB7LlhNYNTPOq77eQWLbFat+5SyKP7
         80unuhNrSe9Y5+U147guJRgiAS/gcRDrMuWTQugQl8xUgfv6/x3wsgLDIsDw0zO1d/1i
         vx5tpqJCiEHQSv9NntKd+fUn8jFKX0dzP46FT4aGvNdSG8HgazOqIa+22ycLBEPsgQEe
         2oXwV+mKnOqsG0xQ0duaE1a5yRmvUV1zkD4w8UTgc11U0pYhJkjqIm1r/2KykenUq6RG
         NFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588305; x=1776193105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tENyS4UAhsyLXewunDkyxFOS4fIoNLiSb3W3F/WSw2w=;
        b=GaqvFayJB5he2mrfP6YCtj861yUTwEw1/5GuBxj0Jw6vHLNYrqmsbkyBjy0ChI3TAq
         CuHJCDyqYoWF2MqLh59qVhKSPvpTjHSZMfUUDVHZW7TxRRB0hulLJRxtoAXTZVy53h91
         ubwvSXN6vjny3oHxu01WEQtpkHFM1LE54cMXkCRlrkQbiQULkmPG1L0w07K/qWIi/HiK
         HrkDheJPV+cTRCEajyH5L71zg0e1o1V6HzzWfrjtorogSAtNp8WADcsVTbdo3Ie6jdvY
         3fcv1kKHHGy6ygdjFgoOon7cRgos+OHEuuTRv8FNR4RejsTR2vMWBI4vRrCjdRDflZlT
         GWng==
X-Forwarded-Encrypted: i=1; AJvYcCXXLfDBVUi0LuAYv8eWV3l6x4VL02hTk7XXoPMqlFKXE1GFtg42kD187MkMLfZmzGevoksi4LjiNtou+F5Pz3T7lIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnLU2RvwjWvVrFDsZMWvZcpgQrf19Xs5O8dt5cFhnyelW4ZiI
	dsR1EZelM26bqvuWLwncpFPKBqJg6UEe/cw4QW72x918b3CsSCtjwgLW
X-Gm-Gg: AeBDiet8BVP/KXMKp37r1AA584CYzAmKIJ2gb+e27kEdNMk3yckruWA4oBL17TPRUQt
	3bXvJDFm261x8eaUbiavhJJkYzNnbmBPZKqttJH2PCYtWo0semADwTuVcL1SLMFas8iLtiFjat9
	n2kbR4V7FqzbghYnkwv6CxF3xgYqLgN2bu0NbIedn96AANs8xhpebXU10BCneZ04+V+yjkMhGqd
	ZIuVCRUnP+eKUEuaKdujGAzJE5Zn4RwePix6EQ4dZNRbRxBkoAfNIKvsnYRSD1swWuaUM65/Rjl
	jUjZ7+nkGvtglPakuf5TOzcotwY3qWMj/8ruIgHy8QbHk1rtCQAfeBtVvrobjLZoQrwsCA5Tjpg
	9hqgxS13+GRtQfYlNEu4UTp/dD1xi8Z//aODNrcUy1e6//qbNBUsB9S/wU9obAMoEOeJdqiZJlU
	xGk1cmTDVYtlqWLbByPq2M4TsKMEqzheM=
X-Received: by 2002:a17:903:185:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b2819180d1mr189564715ad.23.1775588305331;
        Tue, 07 Apr 2026 11:58:25 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c45:a41c:c2d5:268a:232e:d07e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm193486145ad.81.2026.04.07.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:58:24 -0700 (PDT)
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
Subject: [RFC 1/2] openrisc: Add utilities and clean up simulation of instructions
Date: Wed,  8 Apr 2026 00:26:49 +0530
Message-ID: <20260407185650.79816-2-sahilcdq0@gmail.com>
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

Introduce new instruction-related utilities and macros for OpenRISC.
This is in preparation for patches that add tracing support such as
KProbes.

Simulate l.adrp. Fix bugs in simulation of l.jal and l.jalr. Earlier,
PC was being updated and then saved in the link register r9, resulting
in a corrupted page table (bad page map in process). Instead, update
PC after storing it in r9.

Move instruction simulation to its own file to enable reuse. Clean it
up and replace hardcoded values with computed expressions.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
 arch/openrisc/include/asm/insn-def.h | 61 +++++++++++++++++++++--
 arch/openrisc/include/asm/spr_defs.h |  1 +
 arch/openrisc/kernel/Makefile        |  2 +-
 arch/openrisc/kernel/insn.c          | 74 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/jump_label.c    |  2 +-
 arch/openrisc/kernel/traps.c         | 41 +--------------
 6 files changed, 136 insertions(+), 45 deletions(-)
 create mode 100644 arch/openrisc/kernel/insn.c

diff --git a/arch/openrisc/include/asm/insn-def.h b/arch/openrisc/include/asm/insn-def.h
index 1e0c028a5b95..c98f9770c52e 100644
--- a/arch/openrisc/include/asm/insn-def.h
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -3,13 +3,66 @@
  * Copyright (C) 2025 Chen Miao
  */
 
+#include <asm/spr.h>
+#include <asm/spr_defs.h>
+
 #ifndef __ASM_OPENRISC_INSN_DEF_H
 #define __ASM_OPENRISC_INSN_DEF_H
 
-/* or1k instructions are always 32 bits. */
-#define	OPENRISC_INSN_SIZE		4
-
 /* or1k nop instruction code */
-#define OPENRISC_INSN_NOP     0x15000000U
+#define INSN_NOP	0x15000000U
+
+#define INSN_CSYNC	0x23000000U
+#define INSN_MSYNC	0x22000000U
+#define INSN_PSYNC	0x22800000U
+
+#define OPCODE_TRAP	0x21000000U
+#define OPCODE_SYS	0x20000000U
+#define OPCODE_MACRC	0x18010000U
+
+struct pt_regs;
+
+enum six_bit_opcodes {
+	l_rfe = 0x09,
+	l_lwa = 0x1b,
+	l_mfspr = 0x2d,
+	l_mtspr = 0x30,
+	l_swa = 0x33,
+	l_j = 0x00,
+	l_jal = 0x01,
+	l_adrp = 0x02,
+	l_bnf = 0x03,
+	l_bf = 0x04,
+	l_jr = 0x11,
+	l_jalr = 0x12,
+};
+
+struct insn {
+	unsigned int opcode: 6;
+	unsigned int operands: 26;
+};
+
+union openrisc_instruction {
+	unsigned int word;
+	struct insn opcodes_6bit;
+};
+
+#define OPENRISC_INSN_SIZE  (sizeof(union openrisc_instruction))
+
+/* Helpers for working with l.trap */
+static inline unsigned long __emit_trap(unsigned int code)
+{
+	return (code & 0xffff) | OPCODE_TRAP;
+}
+
+static inline bool has_delay_slot(void)
+{
+	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
+
+	return !(cpucfgr & SPR_CPUCFGR_ND);
+}
+
+void simulate_pc(struct pt_regs *regs, unsigned int jmp);
+void simulate_branch(struct pt_regs *regs, unsigned int jmp, bool has_delay_slot);
 
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
index 000000000000..2c97eceee6d7
--- /dev/null
+++ b/arch/openrisc/kernel/insn.c
@@ -0,0 +1,74 @@
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
+
+void simulate_pc(struct pt_regs *regs, unsigned int jmp)
+{
+	int displacement;
+	unsigned int rd, op;
+
+	displacement = sign_extend32(((jmp) & 0x7ffff) << 13, 31);
+	rd = (jmp & 0x3ffffff) >> 21;
+	op = jmp >> 26;
+
+	switch (op) {
+	case l_adrp:
+		regs->gpr[rd] = displacement + (regs->pc & (-8192));
+		return;
+	default:
+		break;
+	}
+}
+
+void simulate_branch(struct pt_regs *regs, unsigned int jmp_insn, bool has_delay_slot)
+{
+	int displacement;
+	unsigned int rb, op, jmp;
+
+	displacement = sign_extend32(((jmp_insn) & 0x3ffffff) << 2, 27);
+	rb = (jmp_insn & 0x0000ffff) >> 11;
+	op = jmp_insn >> 26;
+	jmp = has_delay_slot ? 2 * OPENRISC_INSN_SIZE : OPENRISC_INSN_SIZE;
+
+	switch (op) {
+	case l_j: /* l.j */
+		regs->pc += displacement;
+		return;
+	case l_jal: /* l.jal */
+		regs->gpr[9] = regs->pc + jmp;
+		regs->pc += displacement;
+		return;
+	case l_bnf: /* l.bnf */
+		if (regs->sr & SPR_SR_F)
+			regs->pc += jmp;
+		else
+			regs->pc += displacement;
+		return;
+	case l_bf: /* l.bf */
+		if (regs->sr & SPR_SR_F)
+			regs->pc += displacement;
+		else
+			regs->pc += jmp;
+		return;
+	case l_jr: /* l.jr */
+		regs->pc = regs->gpr[rb];
+		return;
+	case l_jalr: /* l.jalr */
+		regs->gpr[9] = regs->pc + jmp;
+		regs->pc = regs->gpr[rb];
+		return;
+	default:
+		break;
+	}
+}
diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
index ab7137c23b46..fe082eb847a4 100644
--- a/arch/openrisc/kernel/jump_label.c
+++ b/arch/openrisc/kernel/jump_label.c
@@ -34,7 +34,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 		insn = offset;
 	} else {
-		insn = OPENRISC_INSN_NOP;
+		insn = INSN_NOP;
 	}
 
 	if (early_boot_irqs_disabled)
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index c195be9cc9fc..ee87a3af34fc 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -32,6 +32,7 @@
 
 #include <asm/bug.h>
 #include <asm/fpu.h>
+#include <asm/insn-def.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
@@ -269,47 +270,9 @@ static inline int in_delay_slot(struct pt_regs *regs)
 
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
+		simulate_branch(regs, *((unsigned int *)regs->pc), has_delay_slot());
 	} else {
 		regs->pc += 4;
 	}
-- 
2.53.0

