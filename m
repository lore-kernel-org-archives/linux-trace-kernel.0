Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416537;
	b=aesOBIZxd8Jwf0ppMom0PQ5QmC5wCV0/8TKxlLlfFMgoq4OEhfW1Yg9fNIm9PBOa2aD8
	 31RRq5oWkbOZDcS6m1202BgXQ2UCYha6hkA7QddWrtTzT4VCLrWjzIsCg13wN0x2R+gss
	 Bc9rBwAA9HSwPgLRlPY2eAsYNYl6id/MRcIoIBzGjb7h57ZGgEdNQS9X6Aafa4nsycfOk
	 Rp99S0/SSRhACg6D4+2N1BDfF+ITb1J5X9ZmYrUpwrnALL3SAtcmhrmo9LBjKLHOJxKir
	 JPPrkCdLnVo+vsSkdyfu7OlYqxtcit0lOKtH/ltnpMesPbZEpYdVoo8I4LFAIr1Rjfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416537;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=xF5TDdXDstF+StqggfYmHRyJfgHaYpZKWVhco77XF+c=;
	b=ebcxwYP7PKX8QCOXwbu58dbIvwgndu22QDDV7fDaGfTgpUrDBJo6nBjH9fG4BejoWwH4
	 Z3Yq7wmvTrZOL/kppbwUXlRaQrxjhSPMg4e3THo2w8eSJ74HIxZc6DXdm+sZtUmpTVgpW
	 OR6tnXNN7yfirmiBCyl2VcJHatzuw3o41+f64vccmDH+OaErvS9aMNfadkXWHwXDttiwL
	 c1USKf0k21TeG8IXltsAVkxRy+slJYSCOAHeAQCr7rulMwm5ISZLBNOvCSvSd4LuNfdYV
	 6wHnS4NXwOxrRPQPzwSo/2eYT2Tf/HDKmikzFuLFqm3tOfs0xqdh6Zy0TnRMuwuo+KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405D606A331;
	Wed, 11 Nov 2026 17:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7405D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794416535; x=1825952535;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QGrd43syRvwTXt46S8mJIdzg0pM8jHJ1X2GGo/8ooHM=;
  b=bghjdxf38EqwE5Y6IpCbi6D0qoWA9KP/S1Z1kc7DHPNyqwESpu2dSqeV
   CHnHVvq05KKEIJGLVKq5e5TMxclzDImfWvaCABEJl4KmOJ/eQKa/Oxjsp
   dd/N/rhArw7/yAOK7E1ue9fWoSjb1S0gDC9xJdOP4p+GNZotpiGMkduRh
   3dzGd5Rd4w2XqgXW39EWVw7WcsxGi01x9BWHdZeMcU4OsPdLJfg8HVB9+
   09Hi0q6uZxXpHaBEVMkchEjW9MOL+W05nV9AqD1zP1cKjtgw86aGCY6ej
   DZ1hm+kIAfweIg5tH9OdHW1TvP2L+780JhLwyTXRiRM1AEaBTGhqZ3V/D
   A==;
X-CSE-ConnectionGUID: Qz7vlQ3fRuSEmC6UdJbfFQ==
X-CSE-MsgGUID: sWEIGglVRequIJqrARGZDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 19:02:07 +0200
X-CSE-ConnectionGUID: dZv3CVcbQtu26D+AVmrMyw==
X-CSE-MsgGUID: b+dUMBkQTHuIWHXkfNfiuA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 11 Nov 2026 19:10:18 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 11 Nov 2026 19:02:05 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 11 Nov 2026 19:01:08 +0200
Subject: [PATCH v2 2/2] riscv: probes: reject probes inside an LR/SC
 sequence
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
In-Reply-To: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

A kprobe or uprobe replaces an instruction with a breakpoint. The trap
clears the hart's reservation, so if the breakpoint sits on the lr, on
the sc, or on any instruction between them, the sc fails, the loop
branches back to the lr and the probe fires again. The sequence never
completes.

This has always been possible on RISC-V, because cmpxchg and the
conditional atomics are LR/SC loops. arm64 has the same problem and
rejects probes inside an exclusive-load/store-exclusive region.

Breakpoint can be on the lr unless it is part of the LR/SC loop.

For the instructions between LR and SC, use the rules for a constrained
LR/SC sequence: at most 16 instructions between lr and sc, all base
integer instructions other than loads, stores, JALR, FENCE, SYSTEM and
backward jumps or branches, or their compressed forms. Scan forward
from the probed instruction. Reaching an sc through permitted
instructions only means the probe sits inside a sequence; any other
instruction, an lr, the end of the window or the end of the readable
text means it does not. Only a sequence that follows these rules is
guaranteed to make progress, so a probe inside any other one is
already on unsupported ground. Scanning forward rather than tracking
state from the start of the function also keeps an lr that has no sc,
such as the one in __cmpwait() before wrs.nto, from affecting probes
later in the same function.

kprobes scan the kernel text up to the end of the enclosing symbol.
uprobes have only the probed instruction copied, so they read the
text that follows it from the task, which the caller's mmap_lock
allows.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/include/asm/insn.h          | 28 +++++++++++
 arch/riscv/kernel/probes/decode-insn.c | 91 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h |  7 +++
 arch/riscv/kernel/probes/kprobes.c     | 27 +++++++---
 arch/riscv/kernel/probes/uprobes.c     | 31 ++++++++++++
 5 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index c3005573e8c9..f5de81753bec 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -10,11 +10,16 @@
 
 #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
 #define RV_INSN_FUNCT3_OPOFF	12
+#define RV_INSN_FUNCT5_MASK	GENMASK(31, 27)
+#define RV_INSN_FUNCT5_OPOFF	27
+#define RV_INSN_FUNCT7_MASK	GENMASK(31, 25)
+#define RV_INSN_FUNCT7_OPOFF	25
 #define RV_INSN_OPCODE_MASK	GENMASK(6, 0)
 #define RV_INSN_OPCODE_OPOFF	0
 #define RV_INSN_FUNCT12_OPOFF	20
 
 #define RV_ENCODE_FUNCT3(f_)	(RVG_FUNCT3_##f_ << RV_INSN_FUNCT3_OPOFF)
+#define RV_ENCODE_FUNCT5(f_)	(RVG_FUNCT5_##f_ << RV_INSN_FUNCT5_OPOFF)
 #define RV_ENCODE_FUNCT12(f_)	(RVG_FUNCT12_##f_ << RV_INSN_FUNCT12_OPOFF)
 
 /* The bit field of immediate value in I-type instruction */
@@ -136,7 +141,13 @@
 
 /* parts of opcode for RVG*/
 #define RVG_OPCODE_FENCE	0x0f
+#define RVG_OPCODE_OP_IMM	0x13
 #define RVG_OPCODE_AUIPC	0x17
+#define RVG_OPCODE_OP_IMM_32	0x1b
+#define RVG_OPCODE_AMO		0x2f
+#define RVG_OPCODE_OP		0x33
+#define RVG_OPCODE_LUI		0x37
+#define RVG_OPCODE_OP_32	0x3b
 #define RVG_OPCODE_BRANCH	0x63
 #define RVG_OPCODE_JALR		0x67
 #define RVG_OPCODE_JAL		0x6f
@@ -188,6 +199,17 @@
 #define RVG_FUNCT12_EBREAK	0x1
 #define RVG_FUNCT12_SRET	0x102
 
+/* parts of funct5 code for A extension */
+#define RVG_FUNCT5_LR		0x02
+#define RVG_FUNCT5_SC		0x03
+
+/*
+ * The AMO funct3 field holds the access width: 010 for .w, 011 for .d.
+ * Matching bits 14:13 alone accepts both and nothing else.
+ */
+#define RVG_AMO_WIDTH_MASK	GENMASK(14, 13)
+#define RVG_AMO_WIDTH_WD	BIT(13)
+
 #define RVG_MATCH_AUIPC		(RVG_OPCODE_AUIPC)
 #define RVG_MATCH_JALR		(RV_ENCODE_FUNCT3(JALR) | RVG_OPCODE_JALR)
 #define RVG_MATCH_JAL		(RVG_OPCODE_JAL)
@@ -200,6 +222,8 @@
 #define RVG_MATCH_BGEU		(RV_ENCODE_FUNCT3(BGEU) | RVG_OPCODE_BRANCH)
 #define RVG_MATCH_EBREAK	(RV_ENCODE_FUNCT12(EBREAK) | RVG_OPCODE_SYSTEM)
 #define RVG_MATCH_SRET		(RV_ENCODE_FUNCT12(SRET) | RVG_OPCODE_SYSTEM)
+#define RVG_MATCH_LR		(RV_ENCODE_FUNCT5(LR) | RVG_AMO_WIDTH_WD | RVG_OPCODE_AMO)
+#define RVG_MATCH_SC		(RV_ENCODE_FUNCT5(SC) | RVG_AMO_WIDTH_WD | RVG_OPCODE_AMO)
 #define RVC_MATCH_C_BEQZ	(RVC_ENCODE_FUNCT3(C_BEQZ) | RVC_OPCODE_C1)
 #define RVC_MATCH_C_BNEZ	(RVC_ENCODE_FUNCT3(C_BNEZ) | RVC_OPCODE_C1)
 #define RVC_MATCH_C_J		(RVC_ENCODE_FUNCT3(C_J) | RVC_OPCODE_C1)
@@ -227,6 +251,8 @@
 #define RVC_MASK_C_EBREAK	0xffff
 #define RVG_MASK_EBREAK		0xffffffff
 #define RVG_MASK_SRET		0xffffffff
+#define RVG_MASK_LR		(RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_SC		(RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK | RV_INSN_OPCODE_MASK)
 
 #define __INSN_LENGTH_MASK	_UL(0x3)
 #define __INSN_LENGTH_GE_32	_UL(0x3)
@@ -262,6 +288,8 @@ __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
 __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
 __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
 __RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
+__RISCV_INSN_FUNCS(lr, RVG_MASK_LR, RVG_MATCH_LR)
+__RISCV_INSN_FUNCS(sc, RVG_MASK_SC, RVG_MATCH_SC)
 
 /* special case to catch _any_ system instruction */
 static __always_inline bool riscv_insn_is_system(u32 code)
diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 433d9035b888..0789754f682c 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -4,11 +4,102 @@
 #include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/bug.h>
 #include <asm/sections.h>
 
 #include "decode-insn.h"
 #include "simulate-insn.h"
 
+/*
+ * Can insn sit between the lr and the sc of a constrained LR/SC sequence?
+ * The ISA allows base integer instructions there, except loads, stores,
+ * JALR, FENCE, SYSTEM, backward jumps and taken backward branches, plus
+ * their compressed forms. Backward branches are treated as not allowed:
+ * the retry branch follows the sc, so one inside the body is not a
+ * constrained sequence.
+ */
+static bool __kprobes riscv_insn_is_lrsc_body(u32 insn)
+{
+	u32 funct3;
+
+	if (GET_INSN_LENGTH(insn) == 2) {
+		switch (insn & RVC_INSN_OPCODE_MASK) {
+		case RVC_OPCODE_C0:
+			/* c.addi4spn; the rest of the quadrant is loads and stores */
+			return (insn & RVC_INSN_FUNCT3_MASK) == 0;
+		case RVC_OPCODE_C1:
+			/* Arithmetic, c.j, c.jal and branches, bit 12 is the offset sign */
+			if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn) ||
+			    riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
+				return !(insn & BIT(12));
+			return true;
+		case RVC_OPCODE_C2:
+			funct3 = (insn & RVC_INSN_FUNCT3_MASK) >> RVC_INSN_FUNCT3_OPOFF;
+			if (funct3 == 0)	/* c.slli */
+				return true;
+			if (funct3 == 4)	/* c.mv, c.add, but not c.jr, c.jalr, c.ebreak */
+				return !riscv_insn_is_c_jr(insn) &&
+				       !riscv_insn_is_c_jalr(insn) &&
+				       !riscv_insn_is_c_ebreak(insn);
+			return false;	/* stack loads and stores */
+		}
+		return false;
+	}
+
+	switch (insn & RV_INSN_OPCODE_MASK) {
+	case RVG_OPCODE_OP_IMM:
+	case RVG_OPCODE_OP_IMM_32:
+	case RVG_OPCODE_LUI:
+	case RVG_OPCODE_AUIPC:
+		return true;
+	case RVG_OPCODE_OP:
+	case RVG_OPCODE_OP_32:
+		/* funct7 0 or 0x20 is base I; anything else is M, B or another extension */
+		return !((insn & RV_INSN_FUNCT7_MASK) & ~(0x20U << RV_INSN_FUNCT7_OPOFF));
+	case RVG_OPCODE_BRANCH:
+	case RVG_OPCODE_JAL:
+		/* forward only, bit 31 is the offset sign */
+		return !(insn & BIT(31));
+	}
+	return false;
+}
+
+/*
+ * Does the instruction at the start of buf lie inside a constrained LR/SC
+ * sequence? Such a sequence holds at most RISCV_LRSC_MAX_BODY instructions
+ * between the lr and the sc, all from the set above. Walk forward from the
+ * probed instruction: reaching an sc through permitted instructions only
+ * means the probe sits in the body; anything else, including an lr that
+ * opens a new sequence, means it does not. The walk stops at the end of
+ * buf, so a short buffer only makes the answer more permissive.
+ */
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
+{
+	size_t off = 0;
+	u32 insn;
+	int n;
+
+	for (n = 0; n < RISCV_LRSC_MAX_BODY + 2; n++) { // 2 for LR and SC itself
+		if (off + 2 > len)
+			return false;
+		insn = buf[off / 2];
+		if (GET_INSN_LENGTH(insn) == 4) {
+			if (off + 4 > len)
+				return false;
+			insn |= (u32)buf[off / 2 + 1] << 16;
+		}
+		/* if probed instruction is not lr, scan one instruction less */
+		if (n == 0 && !riscv_insn_is_lr(insn))
+			n++;
+		if (riscv_insn_is_sc(insn))
+			return true;
+		if (!riscv_insn_is_lrsc_body(insn))
+			return false;
+		off += GET_INSN_LENGTH(insn);
+	}
+	return false;
+}
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
index 42269a7d676d..0ea952cc7595 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -15,4 +15,11 @@ enum probe_insn {
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
+/* A constrained LR/SC sequence has at most this many instructions between lr and sc */
+#define RISCV_LRSC_MAX_BODY	16
+/* Bytes from the probed instruction (can be lr) through the farthest possible sc */
+#define RISCV_LRSC_SCAN_BYTES	((RISCV_LRSC_MAX_BODY + 2) * 4)
+
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len);
+
 #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 63ee5066def5..9b26052a0c4d 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -49,35 +49,46 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(unsigned long addr)
+/*
+ * Walk the instructions from the enclosing symbol up to addr to check that
+ * addr is an instruction boundary. Then reject a probe inside an LR/SC
+ * sequence: the breakpoint trap drops the reservation, so the SC would fail
+ * and the loop would hit the probe again on every retry. The sequence is
+ * recognised by a forward scan with the constrained-sequence rules, as for
+ * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) does
+ * not taint the rest of the function.
+ */
+static int __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp, offset;
+	unsigned long tmp, size, offset;
 
 	/* start iterating at the closest preceding symbol */
-	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
-		return false;
+	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
+		return -EILSEQ;
 
 	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
-			return true;
+			return riscv_probe_in_lrsc_body((u16 *)addr, size - offset) ? -EINVAL : 0;
 
 		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
 	}
 
-	return false;
+	return -EILSEQ;
 }
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	u16 *insn = (u16 *)p->addr;
+	int ret;
 
 	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
-	if (!arch_check_kprobe((unsigned long)p->addr))
-		return -EILSEQ;
+	ret = arch_check_kprobe((unsigned long)p->addr);
+	if (ret)
+		return ret;
 
 	/* copy instruction */
 	p->opcode = (kprobe_opcode_t)(*insn++);
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index eb177d0ce8ab..d97a10262166 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -28,6 +28,34 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
+/*
+ * Is the instruction at addr inside a constrained LR/SC sequence? Only the
+ * probed instruction was copied, so read the text that follows it from the
+ * task. The caller holds mmap_lock, as uprobe_write_opcode() requires too.
+ * Text that cannot be read ends the scan early, which accepts the probe.
+ */
+static bool uprobe_in_lrsc_body(struct mm_struct *mm, unsigned long addr)
+{
+	u16 buf[RISCV_LRSC_SCAN_BYTES / sizeof(u16)];
+	struct vm_area_struct *vma;
+	struct page *page;
+	size_t got = 0;
+	int len;
+
+	while (got < sizeof(buf)) {
+		len = min_t(size_t, sizeof(buf) - got,
+			    PAGE_SIZE - offset_in_page(addr + got));
+		page = get_user_page_vma_remote(mm, addr + got, FOLL_FORCE, &vma);
+		if (IS_ERR(page))
+			break;
+		uprobe_copy_from_page(page, addr + got, (void *)buf + got, len);
+		put_page(page);
+		got += len;
+	}
+
+	return riscv_probe_in_lrsc_body(buf, got);
+}
+
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			     unsigned long addr)
 {
@@ -53,6 +81,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		return -EINVAL;
 	}
 
+	if (uprobe_in_lrsc_body(mm, addr))
+		return -EINVAL;
+
 	return 0;
 }
 

-- 
2.43.0

