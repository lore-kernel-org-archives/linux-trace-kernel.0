Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCB41441F;
	Wed, 14 Oct 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971073; cv=none; b=Xy2wYYkOTzPP1yIpTn0L+Tshdfb8uG14MdzuyQcUOky5+rwFU2w5OL2JL8OkgoLu0EkDRupg2BoMcQ/lvJBQrRMzyg9ULWTTON+mnUwbiW/BZWCspGTl/72U2pPD6Od1bjDgSikbzhS426XMeF9+QEU+Yz3HJtE2eGVgy7/OxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971073; c=relaxed/simple;
	bh=EMM0YWZbAsJdqpS0CLa378eD17p7cN6w75pfeCUKS1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4oxcCdHy+OdHLlDKJ+7tId0Dq8MdRjnQFnfJ1ns9ErKER/POINIvjjRUhz4n6Y6G68MzieF4B6I+/x7w9Ukacu9zSfBI29oKHn9YqDV7ymqweQxm8rYWc6NuSodC4tvlG95YUagMthx01fX/erxxFrqkUFvXrLzVkyxwFoZkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app1 (Coremail) with SMTP id TAJkCgCXKW7vTs9q6aSGAA--.43637S4;
	Wed, 14 Oct 2026 17:44:18 +0800 (CST)
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
Subject: [PATCH v5 2/2] riscv: kprobes: add KUnit test for LR/SC sequence rejection
Date: Wed, 14 Oct 2026 17:44:15 +0800
Message-Id: <20261014094415.374-3-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
References: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCXKW7vTs9q6aSGAA--.43637S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr43AFyrJFyDWF1fuFyDWrg_yoW5KryxpF
	nrGwn0yFWkG3ZxXry3Ww1kAa4fta1kCw43Wr1kGw18Cw47Jr4UtwnagrWUtrn8WrWFqryf
	Zw18XFZ5Kr9rZFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUF5rcDUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEAE2rOXTMYQQAAsA

Extend the kprobes KUnit test with a function containing an LR/SC
sequence and assert that register_kprobe() accepts a probe placed right
before or right after the sequence, and rejects a probe placed on the
LR, on an instruction inside the sequence, or on the SC.

Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
---
 .../kernel/tests/kprobes/test-kprobes-asm.S   | 24 +++++++++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.c | 26 +++++++++++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.h |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
index 15e50934b..6625a960c 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
@@ -100,6 +100,21 @@ test_kprobes_branch_addr8:
 	.option pop
 SYM_FUNC_END(test_kprobes_branch)
 
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
 #ifdef CONFIG_RISCV_ISA_C
 
 SYM_FUNC_START(test_kprobes_c_j)
@@ -253,3 +268,12 @@ SYM_DATA_START(test_kprobes_functions)
 #endif /* CONFIG_RISCV_ISA_C */
 	RISCV_PTR 0
 SYM_DATA_END(test_kprobes_functions)
+
+.section .rodata
+SYM_DATA_START(test_kprobes_lrsc_offsets)
+	RISCV_PTR .Llrsc_before
+	RISCV_PTR .Llrsc_lr
+	RISCV_PTR .Llrsc_inside
+	RISCV_PTR .Llrsc_sc
+	RISCV_PTR .Llrsc_after
+SYM_DATA_END(test_kprobes_lrsc_offsets)
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
index 027424a3f..272753756 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
@@ -43,8 +43,34 @@ static void test_kprobe_riscv(struct kunit *test)
 	kfree(kp);
 }
 
+static void test_kprobe_lrsc(struct kunit *test)
+{
+	/*
+	 * test_kprobes_lrsc_offsets[] points, in order, at an instruction
+	 * right before an LR/SC sequence, the LR itself, an instruction
+	 * inside the sequence, the SC, and an instruction right after it.
+	 */
+	bool reject[] = { false, true, true, true, false };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reject); i++) {
+		struct kprobe kp = {};
+
+		kp.pre_handler = kprobe_dummy_handler;
+		kp.addr = (kprobe_opcode_t *)test_kprobes_lrsc_offsets[i];
+
+		if (reject[i]) {
+			KUNIT_EXPECT_LT(test, register_kprobe(&kp), 0);
+		} else {
+			KUNIT_EXPECT_EQ(test, register_kprobe(&kp), 0);
+			unregister_kprobe(&kp);
+		}
+	}
+}
+
 static struct kunit_case kprobes_testcases[] = {
 	KUNIT_CASE(test_kprobe_riscv),
+	KUNIT_CASE(test_kprobe_lrsc),
 	{}
 };
 
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
index 537f44aa9..65a8e7217 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.h
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
@@ -19,6 +19,9 @@ extern void *test_kprobes_addresses[];
 /* array of functions that return KPROBE_TEST_MAGIC */
 extern long (*test_kprobes_functions[])(void);
 
+/* offsets of the probe points inside test_kprobes_lrsc() */
+extern void *test_kprobes_lrsc_offsets[];
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* TEST_KPROBES_H */
-- 
2.34.1

