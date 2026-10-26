Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045597;
	b=hljVzYUW15Lno/E9UXfyTd3O/upuMpjq1HmZ5o1sVOPEXHZlenFU65fCqb5d7iyrUd4M
	 rK9/T/4W+fAR1qs6sjvlPOXc222LN8KPSdxZtiTsHkXVvilNjis/uNEZearqlsKqV8VyD
	 sUgJDHssycAuGlxapEVIXiynwxntPES08YYslqNFepBuoWbcelWzKMEYpPO5u0NuWzFvE
	 Mj8jfI9SQszLifBxF5j45Qj3VFJLfFzM1sTmJqsdfakFX7kdrF+vBZPnT2ANsncHh5YF3
	 l4GQQhHy4053mccfYzvdElGSQhZlXLtG34T1Fv7Iq8PtGiKNNZkoQTPv24799Pl8GrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iz0yAPrw7MX6e+9uMdtvgq+whCXT9b67fIW/pxgfu48=;
	b=HvsjM0hqJWqMhm/xO5n+mUn+PFyQbP2O4tkHbmw3/HEC79yxr3DDSirU1eOekPHVltvK
	 nsqrGPZ7PsK/HuQEYjkZNWxMJKzrnvlFPZJesM3IVhFspxhyPKowNXfXdQeWiXmuc6mUf
	 87IFNhEZOP13iaDDwUo1RJBuDIiidQth2OBj83NofJBjD35GWg0jC8ZcIv1w7hvYW70O8
	 0s4r+vReWSuDUYw+qIfnAAJvrRJDN7twAua4Pgf7l2QmCPo423bRIOCzba26OBwZ7w5u/
	 sJ+bJuk2vVsTKjgxUnGLpxc5bo06yWQmM29mlxWpgWFSi2X5bU4AIvUMNqULpXl8eiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sY0KlKT3;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497C606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8497C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sY0KlKT3
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so5920380c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045596; x=1793650396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iz0yAPrw7MX6e+9uMdtvgq+whCXT9b67fIW/pxgfu48=;
        b=sY0KlKT3y34w4e38Vw7LriFs8Z/x/gt3tnNGGswRlFCQzn1ld9wkwKEMxrImKZyK0m
         grriCL7k/6O2fSUstdcJ6APzsxnDHWkyyicNODXQbCYIBbulnriM2iNdA7MBb6pNQ2BW
         1Al+ch6kWJ1BGB8+kmeY5YD1oyaIdhHZZJrGJCDqe6MrnznyD5YYXl2mlrfUItX0VB1D
         YnwOuLhUYFs7Ozv+k2ty7xOW8UIEnSkSXGI04lUjPDawDikAymkNfY48+DKHkrJKwZHl
         iuWSNJl/I1tRNSV01aeCyZqchLckunqbJKgx0sCXiOawHqHH+E/IL4sZHd94RrzesSPG
         orVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045596; x=1793650396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iz0yAPrw7MX6e+9uMdtvgq+whCXT9b67fIW/pxgfu48=;
        b=LVdTjRC/n59XSv9VaaLyxktvxJb5cvyXQy7lInQBY/JQX5FdlwiPw8ROuCjQCtpXDM
         563hwlsu/zPiClKrK2aw8MUOolwV9f3DWRfRzE/4aGv1ASjEtXqnupfDEGwyFCexAtC/
         dh2SIYP48t6OU4GdoazMafJFXEGkdIC1890hsCzmufvnTWGL44KOiIrCsaJ+WCMyJ4Zt
         4HWm+Be111AHq7/yjyfSGSHQHPifY80uBkYguDrPKJ8QsaoCJSpQ2BHL3efVJJiyuAbX
         upeNYIMbSOX737MgqE1k/WXdmDl77zRycI7QiBwUJZc2Y+Kac1MmHDpD7wjfRVkHzewq
         AhzQ==
X-Forwarded-Encrypted: i=1; AKwUvByozucgxsuVC4fVAw8uA+n1vaRRTlPrJGTfV8B6R1/0ju2i7jiWmzsa3YwcIr0gMsFFiXWQPP3HypmTyzKL2ANrGvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe0yadwHimlFE0iWxtECpMasmN4v1wTYLhRTsRB/rlS3G3NHcY
	NKFfXLJJyuwKj0pi357Det6UwifsLBPSgVZLzDh9xzWs0PwzHHVYmIOtglan7g==
X-Gm-Gg: AYBFou1DWS+720E3JmAAmT6lbnra+AhXQzpCcP0IJU8kXThw3XcEScPJyUq0q7vBn5C
	dGu/0GL1EqZxnz9fFUUNY8xyy9q76bCihpE3+KBoregHxHOLyYCp9C8qsB8jnC47odWmmhOD0rz
	+dESnoy2ZzWtV9BfMUdmvC2A7ob00c4pqcPqOtTqGRBJ2BidGOgj5XZSaBYotAKGQ7yQ0LD6UVZ
	w5dvoWe3yQd7Qzk/8uoAtdnBt3bKPkeXUa2/pYFLsyKlHfvlsNKOJBG9J/CYqJl9NC81ZL9TAPd
	FljqbLcj4HB3i6tMFhMBzuG8h/3v7OaVzSxMeLoYK3TO0onVU4Yfr+ytH7DyyAzy18yiCUTqfLi
	qfpfLnbYpr4Fu4cK7LMGDo75hYWc1SDQCHicL5a7w++LAhHms1X34CTxQoMobj1O5buDpRW8oFK
	YwdWZtWzpGZVHy5yIeutsHa6tEB0RcGLYgT2UI6l8HJ4fHWKy3t+z1WoPvXnih5ijlRwTb7IrBp
	cO1rXnciocJ4Wfng70cYcImsVisDo2BV6cFKOEYbgRuijFKhvUGMG5+WzHUJeTqQxKQdXEb2jKl
	7LzndFU5Wn7Bt8z8TfunlsaJdbHSlCb5TxxOpA==
X-Received: by 2002:a05:7023:b83:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-19935905e61mr13071094c88.33.1793045595438;
        Mon, 26 Oct 2026 13:13:15 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm31730486c88.6.2026.10.26.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:13:14 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: pjw@kernel.org,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v3 1/4] openrisc: Add utilities and clean up simulation of instructions
Date: Tue, 27 Oct 2026 01:42:37 +0530
Message-ID: <20261026201240.107462-2-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
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
Changes v2 -> v3:
- arch/openrisc/kernel/insn.c:
  - (simulate_pc):
    Handle case when rd=0
    Add function to KProbe blacklist
  - (simulate_branch): Likewise
- arch/openrisc/kernel/setup.c:
  - (setup_arch): Set static key before calling paging_init()
- arch/openrisc/kernel/traps.c:
  - (do_trap): Move handling of Kprobes in commit #2

Changes v1 -> v2:
- arch/openrisc/include/asm/cpuinfo.h: Introduce "delay_slot" static key
- arch/openrisc/include/asm/insn-def.h:
   - Use macros instead of union
   - Use better names for macros
   - Use genmask() for masks
- arch/openrisc/kernel/insn.c:
   - Use macros instead of magic values
   - (simulate_pc): Update PC
   - (simulate_branch): Handle rb=r9 in l.jalr simulation
- arch/openrisc/kernel/setup.c: Use "delay slot" static key
- arch/openrisc/kernel/traps.c: Use macros instead of magic values

 arch/openrisc/include/asm/cpuinfo.h  |  3 +
 arch/openrisc/include/asm/insn-def.h | 58 ++++++++++++++++--
 arch/openrisc/include/asm/spr_defs.h |  1 +
 arch/openrisc/kernel/Makefile        |  2 +-
 arch/openrisc/kernel/insn.c          | 88 ++++++++++++++++++++++++++++
 arch/openrisc/kernel/setup.c         |  4 ++
 arch/openrisc/kernel/traps.c         | 53 +++--------------
 7 files changed, 159 insertions(+), 50 deletions(-)
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
index 1e0c028a5b95..ccbda049171f 100644
--- a/arch/openrisc/include/asm/insn-def.h
+++ b/arch/openrisc/include/asm/insn-def.h
@@ -3,13 +3,63 @@
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
index 000000000000..619d8080d822
--- /dev/null
+++ b/arch/openrisc/kernel/insn.c
@@ -0,0 +1,88 @@
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
+#include <linux/kprobes.h>
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
+		if (rd != 0)
+			regs->gpr[rd] = page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);
+		regs->pc += OPENRISC_INSN_SIZE;
+		return;
+	default:
+		break;
+	}
+}
+NOKPROBE_SYMBOL(simulate_pc)
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
+		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
+		return;
+	case OPENRISC_OPCODE_JALR: /* l.jalr */
+		temp = regs->pc + link_offset;
+		regs->pc = rb == 0 ? 0 : regs->gpr[rb];
+		regs->gpr[9] = temp;
+		return;
+	default:
+		break;
+	}
+}
+NOKPROBE_SYMBOL(simulate_branch)
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 000a9cc10e6f..9c231b320d45 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -252,6 +252,10 @@ void __init setup_arch(char **cmdline_p)
 	/* perform jump_table sorting before paging_init locks down read only memory */
 	jump_label_init();
 
+	/* determine if the processor supports delay slots */
+	if (mfspr(SPR_CPUCFGR) & SPR_CPUCFGR_ND)
+		static_branch_disable(&delay_slot);
+
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index c195be9cc9fc..a59abbca3555 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -32,6 +32,7 @@
 
 #include <asm/bug.h>
 #include <asm/fpu.h>
+#include <asm/insn-def.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
@@ -252,12 +253,12 @@ static inline int in_delay_slot(struct pt_regs *regs)
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
+		simulate_branch(regs, *((unsigned int *)regs->pc));
 	} else {
 		regs->pc += 4;
 	}
-- 
2.55.0

