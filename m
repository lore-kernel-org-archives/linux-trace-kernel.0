Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42374FC333;
	Mon, 19 Oct 2026 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417307; cv=none; b=ie4ik1AyVPMdJU/uOilXYWjiPb3TfTTeEiKro0edFv9v0e2ANlTOsgtB/fC+1EaweUuFTtVXqVsUuCByHZqf5FHPaPl1lKtw4FZURlFAKI/gglxgwTRgJZGc83HblQ8HUQ4CgpbwmHVY+Kf83FMgG64UBVvI9qq7Nr+SF0N1ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417307; c=relaxed/simple;
	bh=WnQ/KPW8Ob8xv4zIo9Auk00LbR6NK85GG9F8PPbhOIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgIQQrCIyl9Y+S1Trnnnk7Te9mrd0jRu25uSFsLSAA49nUtFGnTzQ60JGP/kvkaDCd5s3/4HG/k17An52OLWa5j3UbCmPCgH/iVmqLDMQgTp/SbRoehIEbF2ZPl4PKCF9Qe0mU0q/4Az6gumztt7oxn6fza03shOK7q19MkSIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.100.71.120])
	by app2 (Coremail) with SMTP id TQJkCgAHDpwBHtZqOjWHAA--.44594S4;
	Mon, 19 Oct 2026 21:41:24 +0800 (CST)
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
Subject: [PATCH v7 2/2] riscv: kprobes: add KUnit test for LR/SC sequence rejection
Date: Mon, 19 Oct 2026 21:41:21 +0800
Message-Id: <20261019134121.1763-3-yuanxiaofeng@eswincomputing.com>
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
X-CM-TRANSID:TQJkCgAHDpwBHtZqOjWHAA--.44594S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyUGr4UtF1kGFyrAF1xuFg_yoW7ArW5pF
	srGw1YyFWkJ3ZxXry3Xw1kZFySkan5Aw43WrykXr1xCr47Jr12yFnagrWUtr1DWrZYq34f
	Zr1jq395Kr9rZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	YxBIdaVFxhVjvjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEFE2rU9LQoOwACs5

Extend the kprobes KUnit test with a function containing an LR/SC
sequence and assert that register_kprobe() accepts a probe placed right
before or right after the sequence, and rejects a probe placed on the
LR, on an instruction inside the sequence, or on the SC.

Add a second, never-executed function that pins the 16-instruction
tracking window: the 15th instruction after the LR (the last that can
still be inside the loop) must be rejected, and the 16th must be
accepted because it is either the SC (rejected during decoding) or a
plain instruction outside the loop.

Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
---
 .../kernel/tests/kprobes/test-kprobes-asm.S   | 60 +++++++++++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.c | 34 +++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.h |  6 ++
 3 files changed, 100 insertions(+)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
index 15e50934b..7924dd55a 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
@@ -100,6 +100,49 @@ test_kprobes_branch_addr8:
 	.option pop
 SYM_FUNC_END(test_kprobes_branch)
 
+/*
+ * This function is never executed; it only provides the probe addresses
+ * in test_kprobes_lrsc_allowed_addresses[] and
+ * test_kprobes_lrsc_rejected_addresses[] for test_kprobe_lrsc().  The
+ * lr.w/sc.w use the invalid address 0(x0) and would fault if executed,
+ * so do not add this function to test_kprobes_functions[].
+ */
+SYM_FUNC_START(test_kprobes_lrsc)
+.Llrsc_before:
+	nop
+1:
+.Llrsc_lr:
+	lr.w t0, 0(x0)
+.Llrsc_inside:
+	addi t0, t0, 1
+.Llrsc_sc:
+	sc.w t0, t0, 0(x0)
+	bnez t0, 1b
+.Llrsc_after:
+	ret
+SYM_FUNC_END(test_kprobes_lrsc)
+
+/*
+ * Also never executed; it pins the 16-instruction LR/SC tracking window.
+ * The LR is followed by 13 nops.  The 15th instruction (counting the LR
+ * as the 1st) is the last one that can still be inside the loop and must
+ * be rejected.  The 16th is accepted: it is either the SC, rejected later
+ * during decoding, or a plain instruction, which cannot lie inside a
+ * 16-instruction loop because that loop's 16th instruction must be the SC.
+ */
+SYM_FUNC_START(test_kprobes_lrsc_gap)
+.Llrsc_gap_lr:
+	lr.w t0, 0(x0)
+	.rept 13
+	nop
+	.endr
+.Llrsc_gap_pos15:
+	nop
+.Llrsc_gap_pos16:
+	nop
+	ret
+SYM_FUNC_END(test_kprobes_lrsc_gap)
+
 #ifdef CONFIG_RISCV_ISA_C
 
 SYM_FUNC_START(test_kprobes_c_j)
@@ -253,3 +296,20 @@ SYM_DATA_START(test_kprobes_functions)
 #endif /* CONFIG_RISCV_ISA_C */
 	RISCV_PTR 0
 SYM_DATA_END(test_kprobes_functions)
+
+.section .rodata
+SYM_DATA_START(test_kprobes_lrsc_allowed_addresses)
+	RISCV_PTR .Llrsc_before
+	RISCV_PTR .Llrsc_after
+	RISCV_PTR .Llrsc_gap_pos16
+	RISCV_PTR 0
+SYM_DATA_END(test_kprobes_lrsc_allowed_addresses)
+
+.section .rodata
+SYM_DATA_START(test_kprobes_lrsc_rejected_addresses)
+	RISCV_PTR .Llrsc_lr
+	RISCV_PTR .Llrsc_inside
+	RISCV_PTR .Llrsc_sc
+	RISCV_PTR .Llrsc_gap_pos15
+	RISCV_PTR 0
+SYM_DATA_END(test_kprobes_lrsc_rejected_addresses)
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
index 027424a3f..dd2fb0749 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
@@ -43,8 +43,42 @@ static void test_kprobe_riscv(struct kunit *test)
 	kfree(kp);
 }
 
+static void test_kprobe_lrsc(struct kunit *test)
+{
+	int i;
+
+	/* probes outside the LR/SC sequence must be accepted */
+	for (i = 0; test_kprobes_lrsc_allowed_addresses[i]; i++) {
+		struct kprobe kp = {};
+		int ret;
+
+		kp.pre_handler = kprobe_dummy_handler;
+		kp.addr = test_kprobes_lrsc_allowed_addresses[i];
+
+		ret = register_kprobe(&kp);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+		if (!ret)
+			unregister_kprobe(&kp);
+	}
+
+	/* probes on or inside the LR/SC sequence must be rejected */
+	for (i = 0; test_kprobes_lrsc_rejected_addresses[i]; i++) {
+		struct kprobe kp = {};
+		int ret;
+
+		kp.pre_handler = kprobe_dummy_handler;
+		kp.addr = test_kprobes_lrsc_rejected_addresses[i];
+
+		ret = register_kprobe(&kp);
+		KUNIT_EXPECT_LT(test, ret, 0);
+		if (!ret)
+			unregister_kprobe(&kp);
+	}
+}
+
 static struct kunit_case kprobes_testcases[] = {
 	KUNIT_CASE(test_kprobe_riscv),
+	KUNIT_CASE(test_kprobe_lrsc),
 	{}
 };
 
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
index 537f44aa9..93393e77a 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.h
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
@@ -19,6 +19,12 @@ extern void *test_kprobes_addresses[];
 /* array of functions that return KPROBE_TEST_MAGIC */
 extern long (*test_kprobes_functions[])(void);
 
+/* probe points that must be accepted, terminated by NULL */
+extern void *test_kprobes_lrsc_allowed_addresses[];
+
+/* probe points that must be rejected, terminated by NULL */
+extern void *test_kprobes_lrsc_rejected_addresses[];
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* TEST_KPROBES_H */
-- 
2.34.1

