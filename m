Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416F5038FE;
	Mon, 19 Oct 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417310; cv=none; b=T2D8nz/F+oWl01daFYarhtxoSZ4Fjm6p4UKXsSNVmvWE0ckDOqCAIPzu5upJA3t+b9I0Nouti876/KdS/BwJUyFQZKPdJx0D3WQ3NV5/HWlV4zOWoclH3iGAvlbPSBGSNAIsNPfzoDluGUn/uNFShMaWYiSeKKFp4cUNE5d5LPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417310; c=relaxed/simple;
	bh=tTQhr/O24NNKkodUwnVa47jfdCLNHr7AsTzzbH3SV20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+D8fGee1VKiJt1/wjD1/jAsJpOBvfBNBycOeMh2iBqk2QEDzafIAdUTkOYR4P1DirTdfTWMA+wgLOt++Yv7Q5uOL7I6BoiQsvzgHhsF1Zc1B93u0FSwfR2yVbDfjeXIHTLPiQTixkxMKTUob56koCaNIrkyD2Ru5LLyi8j2v4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.100.71.120])
	by app2 (Coremail) with SMTP id TQJkCgAHDpwBHtZqOjWHAA--.44594S3;
	Mon, 19 Oct 2026 21:41:23 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Nam Cao <namcao@linutronix.de>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Subject: [PATCH v7 1/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Mon, 19 Oct 2026 21:41:20 +0800
Message-Id: <20261019134121.1763-2-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20261019134121.1763-1-yuanxiaofeng@eswincomputing.com>
References: <20261019134121.1763-1-yuanxiaofeng@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHDpwBHtZqOjWHAA--.44594S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XF47GrW7WFy7AFW8tw4fZrb_yoWftFykpF
	s5Cw15JrWDXFs3C34SyF4kZw4Syw45Kw47Gryq9a4ftayjqw1rtF9aqw43KF1DCFZY9r1f
	ZrWYqrn8ur9rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgEFE2rU9Soo8AAAss

A trap taken in the middle of an LR/SC sequence clears the load
reservation, so an SC following the probed instruction always fails and
the enclosing retry loop re-enters the breakpoint, livelocking the CPU.
Reject probes of the LR/SC instructions themselves and of any address
between them.

arm64's kprobes rejects its equivalent exclusive load/store instructions
and, in arm_kprobe_decode_insn(), walks backward from the probe address
(bounded by the enclosing symbol) to reject any address inside an
exclusive sequence.  RISC-V cannot walk backward because
variable-length instructions make instruction boundaries ambiguous, so
walk forward from the enclosing symbol, a known instruction boundary, up
to the probe address and track whether an LR is still outstanding.

A Zalrsc-constrained LR/SC retry loop holds at most 16 instructions: the
LR, the SC, and up to MAX_LRSC_GAP instructions between them.  An LR
MAX_LRSC_GAP or more instructions ahead of the probe cannot start a
sequence containing it.  Count instructions, not bytes: compressed
instructions would make a byte window ambiguous.

The LR/SC instructions themselves are rejected in
riscv_probe_decode_insn(), and an address inside a sequence is rejected
in arch_check_kprobe().

Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/riscv/include/asm/insn.h          | 63 ++++++++++++++++++++-----
 arch/riscv/kernel/probes/decode-insn.c |  2 +
 arch/riscv/kernel/probes/kprobes.c     | 65 +++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index ad348d8b8..6fdd61e6e 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -10,6 +10,8 @@
 
 #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
 #define RV_INSN_FUNCT3_OPOFF	12
+#define RV_INSN_FUNCT5_MASK	GENMASK(31, 27)
+#define RV_INSN_FUNCT5_OPOFF	27
 #define RV_INSN_OPCODE_MASK	GENMASK(6, 0)
 #define RV_INSN_OPCODE_OPOFF	0
 #define RV_INSN_FUNCT12_OPOFF	20
@@ -141,6 +143,7 @@
 #define RVG_OPCODE_JALR		0x67
 #define RVG_OPCODE_JAL		0x6f
 #define RVG_OPCODE_SYSTEM	0x73
+#define RVG_OPCODE_AMO		0x2f
 #define RVG_SYSTEM_CSR_OFF	20
 #define RVG_SYSTEM_CSR_MASK	GENMASK(11, 0)
 
@@ -175,6 +178,8 @@
 #define RVG_FUNCT3_BGE		0x5
 #define RVG_FUNCT3_BLTU		0x6
 #define RVG_FUNCT3_BGEU		0x7
+#define RVG_FUNCT3_AMO_W	0x2
+#define RVG_FUNCT3_AMO_D	0x3
 
 /* parts of funct3 code for C extension*/
 #define RVC_FUNCT3_C_BEQZ	0x6
@@ -263,6 +268,53 @@ __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
 __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
 __RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
 
+/*
+ * LR/SC are identified by the AMO opcode plus the funct3 width field
+ * (.w/.d) and the funct5 field (funct7[6:2]) distinguishing LR from SC.
+ * The aq/rl bits (funct7[1:0]) are ignored.  For LR the rs2 field must
+ * encode x0.
+ */
+#define RVG_AMO_FUNCT5_LR	0x02
+#define RVG_AMO_FUNCT5_SC	0x03
+
+#define RV_X_MASK(X, s, mask)	(((X) >> (s)) & (mask))
+#define RV_X(X, s, n)		RV_X_MASK(X, s, ((1 << (n)) - 1))
+
+#define RV_EXTRACT_FUNCT3(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X_MASK(x_, RV_INSN_FUNCT3_OPOFF, \
+		   RV_INSN_FUNCT3_MASK >> RV_INSN_FUNCT3_OPOFF)); })
+
+#define RV_EXTRACT_FUNCT5(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X_MASK(x_, RV_INSN_FUNCT5_OPOFF, \
+		   RV_INSN_FUNCT5_MASK >> RV_INSN_FUNCT5_OPOFF)); })
+
+#define RV_EXTRACT_RS2_REG(x) \
+	({typeof(x) x_ = (x); \
+	(RV_X_MASK(x_, RVG_RS2_OPOFF, RVG_RS2_MASK)); })
+
+static __always_inline bool riscv_insn_is_lr(u32 code)
+{
+	u32 funct5 = RV_EXTRACT_FUNCT5(code);
+	u32 funct3 = RV_EXTRACT_FUNCT3(code);
+
+	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_AMO &&
+	       funct5 == RVG_AMO_FUNCT5_LR &&
+	       (funct3 == RVG_FUNCT3_AMO_W || funct3 == RVG_FUNCT3_AMO_D) &&
+	       !RV_EXTRACT_RS2_REG(code);
+}
+
+static __always_inline bool riscv_insn_is_sc(u32 code)
+{
+	u32 funct5 = RV_EXTRACT_FUNCT5(code);
+	u32 funct3 = RV_EXTRACT_FUNCT3(code);
+
+	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_AMO &&
+	       funct5 == RVG_AMO_FUNCT5_SC &&
+	       (funct3 == RVG_FUNCT3_AMO_W || funct3 == RVG_FUNCT3_AMO_D);
+}
+
 /* special case to catch _any_ system instruction */
 static __always_inline bool riscv_insn_is_system(u32 code)
 {
@@ -432,8 +484,6 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 
 #define RV_IMM_SIGN(x)		(-(((x) >> 31) & 1))
 #define RVC_IMM_SIGN(x)		(-(((x) >> 12) & 1))
-#define RV_X_MASK(X, s, mask)	(((X) >> (s)) & (mask))
-#define RV_X(X, s, n)		RV_X_MASK(X, s, ((1 << (n)) - 1))
 #define RVC_LW_IMM(x)		((RV_X(x, 6, 1) << 2) | \
 				 (RV_X(x, 10, 3) << 3) | \
 				 (RV_X(x, 5, 1) << 6))
@@ -454,19 +504,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 #define RVC_RS2(insn)		RV_X(insn, SH_RS2C, 5)
 #define RVC_X(X, s, mask)	RV_X_MASK(X, s, mask)
 
-#define RV_EXTRACT_FUNCT3(x) \
-	({typeof(x) x_ = (x); \
-	(RV_X_MASK(x_, RV_INSN_FUNCT3_OPOFF, \
-		   RV_INSN_FUNCT3_MASK >> RV_INSN_FUNCT3_OPOFF)); })
-
 #define RV_EXTRACT_RS1_REG(x) \
 	({typeof(x) x_ = (x); \
 	(RV_X_MASK(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
 
-#define RV_EXTRACT_RS2_REG(x) \
-	({typeof(x) x_ = (x); \
-	(RV_X_MASK(x_, RVG_RS2_OPOFF, RVG_RS2_MASK)); })
-
 #define RV_EXTRACT_RD_REG(x) \
 	({typeof(x) x_ = (x); \
 	(RV_X_MASK(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 433d9035b..e6a889467 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -23,6 +23,8 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	 */
 	RISCV_INSN_REJECTED(system,		insn);
 	RISCV_INSN_REJECTED(fence,		insn);
+	RISCV_INSN_REJECTED(lr,			insn);
+	RISCV_INSN_REJECTED(sc,			insn);
 
 	/*
 	 * Simulate instructions list:
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index a76eab297..273b26ac2 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -7,11 +7,13 @@
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
 #include <linux/vmalloc.h>
+#include <linux/unaligned.h>
 #include <asm/ptrace.h>
 #include <linux/uaccess.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/bug.h>
+#include <asm/insn.h>
 #include <asm/text-patching.h>
 
 #include "decode-insn.h"
@@ -49,35 +51,74 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(unsigned long addr)
+/*
+ * A trap taken in the middle of an LR/SC sequence clears the load
+ * reservation, so an SC following the probed instruction would always
+ * fail and the enclosing retry loop would re-enter the breakpoint.
+ * Reject probes inside such a sequence.
+ *
+ * RISC-V instruction boundaries cannot be recovered by walking
+ * backwards - a 32-bit instruction whose upper halfword looks like a
+ * compressed instruction is ambiguous - so walk forward from the
+ * enclosing symbol, a known instruction boundary, up to the probe address
+ * and track whether an LR is still outstanding.  A Zalrsc-constrained
+ * LR/SC retry loop holds at most 16 instructions: the LR, the SC, and
+ * up to MAX_LRSC_GAP instructions between them.  The walk counts only
+ * the instructions between the LR and the probe, so an LR MAX_LRSC_GAP
+ * or more instructions ahead of the probe cannot start a sequence
+ * containing it.  Count instructions, not bytes: compressed instructions
+ * would make a byte window ambiguous.
+ */
+#define MAX_LRSC_GAP	14
+
+/*
+ * Verify that @addr points at the start of an instruction and is not
+ * inside an LR/SC sequence.  Returns 0 on success, -EILSEQ if @addr is
+ * not an instruction boundary, or -EINVAL if the probe would land
+ * inside an LR/SC sequence.
+ */
+static int __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp, offset;
+	unsigned long pc, offset;
+	int outstanding_lr = -1;
 
-	/* start iterating at the closest preceding symbol */
 	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
-		return false;
+		return -EILSEQ;
 
-	tmp = addr - offset;
+	/* pc starts at the closest preceding symbol, a known instruction boundary */
+	pc = addr - offset;
 
-	while (tmp <= addr) {
-		if (tmp == addr)
-			return true;
+	while (pc < addr) {
+		u32 insn = get_unaligned((u32 *)pc);
+		unsigned int len = GET_INSN_LENGTH(insn);
 
-		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
+		if (riscv_insn_is_lr(insn))
+			outstanding_lr = 0;
+		else if (riscv_insn_is_sc(insn))
+			outstanding_lr = -1;
+		else if (outstanding_lr >= 0 && ++outstanding_lr >= MAX_LRSC_GAP)
+			outstanding_lr = -1;
+
+		pc += len;
 	}
 
-	return false;
+	if (pc != addr)
+		return -EILSEQ;
+
+	return outstanding_lr >= 0 ? -EINVAL : 0;
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
-- 
2.34.1

