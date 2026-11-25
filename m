Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623165;
	b=2n4q5zB5lv9vdMaSpHT9HnaGkFveC4+E4JJNTx93vfMwBtbB00T/sH2JyguVxoJ88qix
	 XkLtIC2LZvCPx3uSo5/9xXMUV2jX9HEBzODV/LjgAxgAxkR1a6b2Fm9R3nttb+RfUYDqB
	 /7DW+y/tzI/RDbY/PDLaXnbRuhrrkv4JEgmerzHHEIyshuBn/cgaSlFGXHTc+M85B7UuY
	 zfg3qKZANwzceYJ+vjRnaTbIjZRrFtydG5QQkTdagTboPlBeTW5deOqJiKn+EEGVzET2D
	 dv94RgLaOVE0K38f4vGy1jDnt8RHAqI6axb6PVOxqBd37A5oBoyax648KdnwiRmWQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=fnDaFNRj4GfWQQkDrgMRbvl8s1BwtLMl+3KcUPARE3A=;
	b=JBW1YETES4a1ldWCWe+dKWKJPDwUV1lZEewx04YxoN9eNigBPOaKzkBOdKmblh4EoGM5
	 F8ABHK71TmSieuHyFefZCmneyjALzhu1owHvw5hKUBqanU6tvE8ChH/hywrNWXoH6iqTq
	 mF96h2/p9Pit016k0DHJtxdQVXfjymyjgpUsJk3CyLDrac764Xqy99lg8NqVoVLvtAGV2
	 lmN5aHmVvqG16n+A7lp3TcJrZe4nNyNge9c6yr79eKmh5nKAc28NVBpsQk5+M4KgRCFN0
	 NsgjmrU3u+cOPrwMX/rxNaYVceaz2sIcTJpnsWqBUOP7pwww084+tvIQ32jimTgkGIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB1606A331;
	Wed, 25 Nov 2026 16:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52DB1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795623164; x=1827159164;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=93CUW0ltfn+fDRMiF2/1YmduFy0cjUnVNDTW+AqFsuY=;
  b=sfZecbfuW+Iq42Lt2nbCqnv354qgBrBJszQ1HOAz7hJP5JRf32wGV0+1
   KMOgqk+z0m5gfckSnIB9iKERw0/4inppQVkGKA9t8E2p2UJvOx483/nzX
   6YsyY6LL1GYLDwKFTpYpFOfiUNLEoViPkKPutxBklOPs4LDQi+DluPUXO
   XjOZH7AeJgDQdrUdHgSBSrf76CB3NgE/ziHeYlt00gwQ5ROlwkzojYXyq
   8f+j5hAwoM4x4u6MxRxQ39krceqdqf4YE//scY0AGPa971EtKt2IbNDqO
   IBs2hlSYLKNgurB+/f6miUnD6jIz2K6jpqL2QNczRR/3jmFWuYadsdBPM
   w==;
X-CSE-ConnectionGUID: 5jfIbITHSPah9eRB415GJQ==
X-CSE-MsgGUID: YsmC8H3PRRSGYYlq4sWn+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:12:36 +0200
X-CSE-ConnectionGUID: 8WCEC6TfSd2z1sYJ7io/kw==
X-CSE-MsgGUID: A3rWdrzOQcOqS0eqcNjINw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 25 Nov 2026 18:20:49 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 25 Nov 2026 18:12:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 25 Nov 2026 18:12:18 +0200
Subject: [PATCH v5 2/3] riscv: probes: reject probes inside an LR/SC
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
Message-Id: <20261125-probes-in-lrsc-v5-2-38a32e53fcc2@mobileye.com>
References: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
In-Reply-To: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>, 
 Pekka Enberg <penberg@kernel.org>, 
 =?utf-8?q?Patrick_St=C3=A4hlin?= <me@packi.ch>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

A kprobe or uprobe replaces an instruction with a breakpoint. The trap
clears the hart's reservation, so if the breakpoint sits on the LR, on
the SC, or on any instruction between them, the SC fails, the loop
branches back to the LR and the probe fires again. The sequence never
completes.

This has always been possible on RISC-V, because cmpxchg and the
conditional atomics are LR/SC loops. arm64 has the same problem and
rejects probes inside an exclusive-load/store-exclusive region.

On the other hand, if LR is not paired with SC, breakpoit at LR or
after it is OK. LR/WRS sequence is an example - breakpoint can be set
anywhere.

For the instructions between LR and SC, use the rules for a constrained
LR/SC loop. According to the spec [1], valid constrained LR/SC loop
shall spat at most 16 instructions placed sequentially in memory,
including

- LR instruction that begins the LR/SC sequence
- dynamic code between LR and SC
- SC instruction that ends the LR/SC sequence
- code to retry

The dynamic code executed between the LR and SC instructions can only
contain instructions from the base ''I'' instruction set, excluding
loads, stores, backward jumps, taken backward branches, JALR, FENCE,
and SYSTEM instructions. Compressed forms of the aforementioned ''I''
instructions in the C (hence Zca) and Zcb extensions are also permitted.

Scan forward from the probed instruction. Perform CFG (call flow graph)
analysis to unambiguate constructs like literals inside the code.
Simple linear scan does not work here. Consider

	j 1f
	.word 0x18c7b62f /* sc.d    a2,a2,(a5) */
1:

Linear scan will mis-interpret literal as instruction.

No reasonable code uses SC instruction that is not part of the
constrained LR/SC loop, thus reaching an SC through permitted
instructions only means the probe sits inside a sequence; any other
instruction, an LR, the end of the window or the end of the readable
text means it does not. Only a sequence that follows these rules is
guaranteed to make progress, so a probe inside any other one is already
on unsupported ground.
Scanning forward rather than tracking state from the start of the
function also keeps an LR that has no SC, such as the one in
__cmpwait() where LR followed by WRS.NTO, from affecting probes later
in the same function.

kprobes scan the kernel text up to the end of the reachable text
within the maximum possible buffer for the LR/SC sequence. Due to CFG
analysis only reachable instructions read, meaning no out of code
segment access performed.

uprobes have only the probed instruction copied, so they read the
text that follows it from the task, which the caller's mmap_lock
allows.

[1] https://docs.riscv.org/reference/isa/v20260120/unpriv/a-st-ext.html#sec:lrscseq

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/include/asm/insn.h          |  29 ++++++
 arch/riscv/kernel/probes/decode-insn.c | 171 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h |   7 ++
 arch/riscv/kernel/probes/kprobes.c     |  37 +++++--
 arch/riscv/kernel/probes/uprobes.c     |  31 ++++++
 5 files changed, 266 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index c3005573e8c9..15ea119a537e 100644
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
@@ -258,10 +284,13 @@ __RISCV_INSN_FUNCS(bltu, RVG_MASK_BLTU, RVG_MATCH_BLTU)
 __RISCV_INSN_FUNCS(bgeu, RVG_MASK_BGEU, RVG_MATCH_BGEU)
 __RISCV_INSN_FUNCS(c_beqz, RVC_MASK_C_BEQZ, RVC_MATCH_C_BEQZ)
 __RISCV_INSN_FUNCS(c_bnez, RVC_MASK_C_BNEZ, RVC_MATCH_C_BNEZ)
+__RISCV_INSN_FUNCS(c_branch, RVC_MASK_C_BNEZ & ~BIT(13), RVC_MATCH_C_BEQZ)
 __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
 __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
 __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
 __RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
+__RISCV_INSN_FUNCS(lr, RVG_MASK_LR, RVG_MATCH_LR)
+__RISCV_INSN_FUNCS(sc, RVG_MASK_SC, RVG_MATCH_SC)
 
 /* special case to catch _any_ system instruction */
 static __always_inline bool riscv_insn_is_system(u32 code)
diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 433d9035b888..cfc59964cda8 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -4,11 +4,182 @@
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
+ * their compressed forms. Backward branches are allowed on the exit path.
+ */
+static bool __kprobes riscv_insn_is_lrsc_body(u32 insn)
+{
+	u32 funct3;
+
+	if (GET_INSN_LENGTH(insn) == 2) {
+		switch (insn & RVC_INSN_OPCODE_MASK) {
+		case RVC_OPCODE_C0:
+			/* c.addi4spn; the rest of the quadrant is loads and stores */
+			/*
+			 * 0x0000 is illegal instruction, shouldn't encounter it in the
+			 * reachable code but worth to check to be on the safe side
+			 */
+			return (insn & RVC_INSN_FUNCT3_MASK) == 0 && insn != 0;
+		case RVC_OPCODE_C1:
+			/* Arithmetic, c.j, c.jal and branches, bit 12 is the offset sign */
+			if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn))
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
+	case RVG_OPCODE_BRANCH:
+		return true;
+	case RVG_OPCODE_OP:
+	case RVG_OPCODE_OP_32:
+		/* funct7 0 or 0x20 is base I; anything else is M, B or another extension */
+		return !((insn & RV_INSN_FUNCT7_MASK) & ~(0x20U << RV_INSN_FUNCT7_OPOFF));
+	case RVG_OPCODE_JAL:
+		/* forward only, bit 31 is the offset sign */
+		return !(insn & BIT(31));
+	}
+	return false;
+}
+
+/* 32-bit Branch Offset (B-Type Format) */
+static inline s32 riscv_get_branch_offset(u32 insn)
+{
+	return RV_EXTRACT_BTYPE_IMM(insn);
+}
+
+/* 32-bit Jump and Link Offset (J-Type Format) */
+static inline s32 riscv_get_jal_offset(u32 insn)
+{
+	return RV_EXTRACT_JTYPE_IMM(insn);
+}
+
+/* Compressed Branch Offset (CB-Type Format) */
+static inline s32 riscv_get_c_branch_offset(u16 insn)
+{
+	return RVC_EXTRACT_BTYPE_IMM(insn);
+}
+
+/* Compressed Jump Offset (CJ-Type Format) */
+static inline s32 riscv_get_c_jal_offset(u16 insn)
+{
+	return RVC_EXTRACT_JTYPE_IMM(insn);
+}
+
+/*
+ * Does the instruction at the start of buf lie inside a constrained LR/SC
+ * sequence? Such a sequence holds at most RISCV_LRSC_MAX_BODY instructions
+ * including the lr and the sc, all from the set above, see comment for the
+ * riscv_insn_is_lrsc_body. Walk forward from the
+ * probed instruction: reaching an sc through permitted instructions only
+ * means the probe sits in the body; anything else, including an lr that
+ * opens a new sequence, means it does not. The walk stops at the end of
+ * buf, so a short buffer only makes the answer more permissive.
+ * Backward branch targets ignored - if it is before LR, this branch is legal;
+ * if it is not, following SC would be in unconstrained LR/SC loop and this is
+ * unsupported.
+ * Only reachable instructions read, all these addresses should be accessible
+ */
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
+{
+	bool reachable_idx[RISCV_LRSC_SCAN_BYTES / 2] = { false };
+	int idx = -1;
+
+	reachable_idx[0] = true; /* instruction at idx 0 is reachable */
+	len = min(len, RISCV_LRSC_SCAN_BYTES);
+
+	if (len < 4) /* SC is 32 bit instruction */
+		return false;
+
+	for (;;) {
+		s32 imm;
+
+		/* find next nearest reachable idx */
+		while (++idx < ARRAY_SIZE(reachable_idx) && !reachable_idx[idx])
+			;
+		if (idx >= ARRAY_SIZE(reachable_idx))
+			return false;
+
+		/* fetch full instruction, 16 or 32 bit */
+		size_t off = idx * 2; /* buffer offset in bytes */
+		u32 insn = buf[idx];
+		size_t insn_len = GET_INSN_LENGTH(insn);
+
+		if (insn_len == 4) {
+			if (off + 4 > len)
+				return false;
+			insn |= (u32)buf[idx + 1] << 16;
+		}
+
+		/* Validate current instruction */
+		/* If we hit an SC, the forward path successfully completes the atomic block */
+		if (riscv_insn_is_sc(insn))
+			return true;
+
+		if (idx == 0) {
+			if (!riscv_insn_is_lr(insn) && !riscv_insn_is_lrsc_body(insn))
+				return false;
+		} else {
+			if (!riscv_insn_is_lrsc_body(insn))
+				return false;
+		}
+
+		/* Control Flow Graph Tracking: mark next reachable positions */
+		if (riscv_insn_is_c_branch(insn) || riscv_insn_is_branch(insn)) {
+			if (insn_len == 2)
+				imm = riscv_get_c_branch_offset(insn);
+			else
+				imm = riscv_get_branch_offset(insn);
+
+			size_t target_off = off + imm;
+
+			if (imm > 0 && target_off < len)
+				reachable_idx[target_off / 2] = true;
+			if (off + insn_len < len)
+				reachable_idx[(off + insn_len) / 2] = true;
+		} else if (riscv_insn_is_c_jal(insn) || riscv_insn_is_c_j(insn) ||
+			   riscv_insn_is_jal(insn)) {
+			if (insn_len == 2)
+				imm = riscv_get_c_jal_offset(insn);
+			else
+				imm = riscv_get_jal_offset(insn);
+
+			size_t target_off = off + imm;
+
+			if (imm > 0 && target_off < len)
+				reachable_idx[target_off / 2] = true;
+		} else {
+			if (off + insn_len < len)
+				reachable_idx[(off + insn_len) / 2] = true;
+		}
+	}
+
+	unreachable();
+}
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
index 42269a7d676d..996eb4256e0f 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -15,4 +15,11 @@ enum probe_insn {
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
+/* A constrained LR/SC sequence has at most this many instructions including lr and sc */
+#define RISCV_LRSC_MAX_BODY	16
+/* Bytes from the probed instruction (can be lr) through the farthest possible sc */
+#define RISCV_LRSC_SCAN_BYTES	(RISCV_LRSC_MAX_BODY * 4)
+
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len);
+
 #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 63ee5066def5..b49f4e935f0d 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -49,35 +49,54 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
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
 	unsigned long tmp, offset;
 
-	/* start iterating at the closest preceding symbol */
+	/*
+	 * start iterating at the closest preceding symbol
+	 * The symbol size does not help here, plain named label within
+	 * the function get listed in the kallsyms_offsets[] and
+	 * symbol size will be mis-reported
+	 */
 	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
-		return false;
+		return -EILSEQ;
 
 	tmp = addr - offset;
 
 	while (tmp <= addr) {
-		if (tmp == addr)
-			return true;
-
+		if (tmp == addr) {
+			if (riscv_probe_in_lrsc_body((u16 *)addr, RISCV_LRSC_SCAN_BYTES))
+				return -EINVAL;
+			else
+				return 0;
+		}
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

