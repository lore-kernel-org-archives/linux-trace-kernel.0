Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623165;
	b=KH0C+eUD5qfOUpoGSzRAN2SREhKmsObjuAueeSYAdpXCZOXGNN1BILmF1NLz585krSeV
	 x/e5vnA4vI77b6iIZ4Bmo2bdo+v3mqCFLMzdulOcPOlm9BWpIeHYTVf5ylrZk3gsGpC8s
	 +WcVawJNNwHnrXpDPDW55ITvlu05rdf0LsmxiWyOLs5m5KMbvFx0T/RI7l/xCW+xCwhp6
	 LvEozUq5s7tlLfPMRlphsDMneH5PRp4Ypy4YIvNBs/umaDT9tnN9+6vgA0I+GIvzNvaJA
	 GEhxV0U+8ByBS/8ScH9rRco8sALY4024jdYIRCgVPQR0LqIbEgx/umEUY9FbsuKx8rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=8sG9y+HpEBKk+8rBHlccjXzFbK/DwmNjqNCMvwk8o1U=;
	b=P2QMdx0qsSWtSELtjNTT65af6wewDhbQ0ss8jAoSPQ6S7ssG8WGUwbOfA8CDCEGrs3x0
	 QJF+3H87frWxO1/RpN9yE/4fZm5I5ST7wjt7yeHOjb7zVLF9SLNmU4s9ti6ar6KFkn9Vs
	 u12yiMxtjoC5wHTxrPrkYPcW7SLXmEc4ixGgglwqEBBdke/37/k1ww/Ap3vn4sdC2Fv+b
	 EZf1JxUbKitIhIYcsY8ZOn+agbyG1c26xwJH/n8TrKXULwTvwbxxQ5yu7XuvFnX/XKqys
	 G9/AVbQ2XJ73ydygnQD0JaH6ahlxgBK53twAWQ2yrjbdwh6CE+MHtttH0p9bEuM2dng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AB606A330;
	Wed, 25 Nov 2026 16:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518AB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795623164; x=1827159164;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FcwHKGQZvxuxocnNkeTXhHb+QTd10Uycq7uPGuNhmps=;
  b=rAvDHo12comsBRkU5Rki5gGTPesXT58IZIarXP4ImlVw65wNw4s9Aovm
   ygPc1EpsEpScoXoMohFUq4i28jESE4i7k76kmQzKBxNBUvTa40VMCrqfj
   mjd3jPtu9fV53IcmojjFFwboUyGRvLy7hjYj6smSqT6yVk4SpdjOdw9FP
   BW6ojm+tBa+VDt+CfBT7dI8TCuykVreHK7v9BvIHHGY8/pYEb6KGQ2QfH
   wfMBuyziU2QJ6VTPqX415QDGt70Dw+xe3Fv/l7enOuUWt4z/DYBxrIgmT
   dvXi+TMRScwZscWfN5k2ejRWJbEmyUWMzA8ibxa0T6S5rBSGikbo+aaXU
   w==;
X-CSE-ConnectionGUID: Vu/W3OKiQ6KOtG2eVdR+jg==
X-CSE-MsgGUID: wjoKJ4NIRSiPR4LpTBcvOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:12:37 +0200
X-CSE-ConnectionGUID: LCkOwF02RD6ZFRu/myprrw==
X-CSE-MsgGUID: DTOuvwIeRXKDMowbWemXIw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 25 Nov 2026 18:21:05 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 25 Nov 2026 18:12:35 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 25 Nov 2026 18:12:19 +0200
Subject: [PATCH v5 3/3] riscv: kprobes: add KUnit test for LR/SC sequence
 rejection
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
Message-Id: <20261125-probes-in-lrsc-v5-3-38a32e53fcc2@mobileye.com>
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
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
X-Mailer: b4 0.16.0

Extend the kprobes KUnit test with a function containing an LR/SC
sequence and assert that register_kprobe() accepts a probe placed
right before or right after the sequence, and rejects a probe
placed on the LR, on an instruction inside the sequence, or on
the SC.

Add never-executed functions that imitates:
- valid short LR/SC loop
- valid maximum size LR/SC loop
- CAS like valid LR/SC with fail and success exit paths
- LR without SC mimicking __cmpwait where LR is followed by
  the conditional branch
- literals inside code, with value interpreted as SC

Suggested-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S | 148 +++++++++++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.c     |  32 +++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |   6 +
 3 files changed, 186 insertions(+)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
index 15e50934bbd7..f09b098bf771 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
@@ -198,6 +198,118 @@ SYM_FUNC_END(test_kprobes_c_jal)
 
 #endif /* CONFIG_RISCV_ISA_C */
 
+SYM_FUNC_START(test_kprobes_lrsc)
+test_kprobes_lrsc_addr0:
+	nop
+	/* valid short LR/SC loop */
+1:
+test_kprobes_lrsc_addr1: /* expect: rejected */
+	lr.w t0, 0(a0)
+test_kprobes_lrsc_addr2: /* expect: rejected */
+	addi t0, t0, 1
+test_kprobes_lrsc_addr3: /* expect: rejected */
+	sc.w t0, t0, 0(a0)
+test_kprobes_lrsc_addr4:
+	bnez t0, 1b
+
+	/* part of __cmpwait - not a valid LR/SC sequence - no SC */
+test_kprobes_lrsc_addr5:
+	lr.w	t0, 0(a0)
+test_kprobes_lrsc_addr6:
+	and	t0, t0, a1
+	xor	t0, t0, a2
+	bnez	t0, 1f
+test_kprobes_lrsc_addr7:
+	nop /* shoult be wrs.nto on platforms with zawrs */
+1:
+	nop
+	ret
+
+	/* valid LR/SC loop with maximum number of instructions */
+1:
+test_kprobes_lrsc_addr8: /* expect: rejected */
+	lr.w t0, 0(a0)
+test_kprobes_lrsc_addr9: /* expect: rejected */
+	.rept 13
+	nop
+	.endr
+	sc.w t0, t0, 0(a0)
+	bnez t0, 1b
+	ret
+SYM_FUNC_END(test_kprobes_lrsc)
+
+/*
+ * CAS with both success and fail exit paths using
+ * instructions not acceptable inside LR/SC loop. Probe
+ * rejected for "cas*" labels inside LR/SC and accepted for
+ * "after_cas*" locations
+ */
+SYM_FUNC_START(test_kprobes_cas)
+1:
+cas0: /* expect: rejected */
+	lr.w   t0, (a0)
+cas1: /* expect: rejected */
+	bne    t0, a1, 2f
+cas2: /* expect: rejected */
+	sc.w   t0, a2, (a0)
+after_cas0:
+	bnez   t0, 1b
+	li     a0, 0
+	ret
+2:
+after_cas1:
+	lw     a0, (a0)
+	ret
+SYM_FUNC_END(test_kprobes_cas)
+
+/*
+ * valid constrained LR/SC sequence can contain a backward branch on a failure path.
+ *
+ * Consider this CAS example, where the failure path placed before the LR/SC sequence
+ */
+
+SYM_FUNC_START(test_kprobes_inv_cas)
+before_invcas0:
+	j 1f
+2:
+	li a0, -1
+before_invcas1:
+	ret
+1:
+invcas0: /* expect: rejected */
+	lr.w   t0, (a0)
+invcas1: /* expect: rejected */
+	bne    t0, a1, 2b
+invcas2: /* expect: rejected */
+	sc.w   t0, a2, (a0)
+after_invcas0:
+	bnez   t0, 1b
+	li     a0, 0
+after_invcas1:
+	ret
+SYM_FUNC_END(test_kprobes_inv_cas)
+
+
+/*
+ * Literals inside code, with value interpreted as CS
+ * shall not confuse the parser
+ * All locations acceptable
+ */
+SYM_FUNC_START(test_kprobes_literal)
+lit0:
+	nop
+lit1:
+	j 1f
+	.word 0x18c7b62f /* sc.d    a2,a2,(a5) */
+1:
+lit2:
+	jal x0, 1f /* force 32-bit jump instruction */
+	.word 0x18c7b62f /* sc.d    a2,a2,(a5) */
+1:
+lit3:
+	ret;
+SYM_FUNC_END(test_kprobes_literal)
+
 .section .rodata
 SYM_DATA_START(test_kprobes_addresses)
 	RISCV_PTR test_kprobes_add_addr1
@@ -253,3 +365,39 @@ SYM_DATA_START(test_kprobes_functions)
 #endif /* CONFIG_RISCV_ISA_C */
 	RISCV_PTR 0
 SYM_DATA_END(test_kprobes_functions)
+
+.section .rodata
+SYM_DATA_START(test_kprobes_lrsc_allowed_addresses)
+	RISCV_PTR test_kprobes_lrsc_addr0
+	RISCV_PTR test_kprobes_lrsc_addr4
+	RISCV_PTR test_kprobes_lrsc_addr5
+	RISCV_PTR test_kprobes_lrsc_addr6
+	RISCV_PTR test_kprobes_lrsc_addr7
+	RISCV_PTR after_cas0
+	RISCV_PTR after_cas1
+	RISCV_PTR lit0
+	RISCV_PTR lit1
+	RISCV_PTR lit2
+	RISCV_PTR lit3
+	RISCV_PTR before_invcas0
+	RISCV_PTR before_invcas1
+	RISCV_PTR after_invcas0
+	RISCV_PTR after_invcas1
+	RISCV_PTR 0
+SYM_DATA_END(test_kprobes_lrsc_allowed_addresses)
+
+.section .rodata
+SYM_DATA_START(test_kprobes_lrsc_rejected_addresses)
+	RISCV_PTR test_kprobes_lrsc_addr1
+	RISCV_PTR test_kprobes_lrsc_addr2
+	RISCV_PTR test_kprobes_lrsc_addr3
+	RISCV_PTR test_kprobes_lrsc_addr8
+	RISCV_PTR test_kprobes_lrsc_addr9
+	RISCV_PTR cas0
+	RISCV_PTR cas1
+	RISCV_PTR cas2
+	RISCV_PTR invcas0
+	RISCV_PTR invcas1
+	RISCV_PTR invcas2
+	RISCV_PTR 0
+SYM_DATA_END(test_kprobes_lrsc_rejected_addresses)
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
index 027424a3ff7b..ff9d5bb2b998 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
@@ -43,8 +43,40 @@ static void test_kprobe_riscv(struct kunit *test)
 	kfree(kp);
 }
 
+static void test_kprobe_riscv_lrsc(struct kunit *test)
+{
+	/* probes outside the LR/SC sequence must be accepted */
+	for (int i = 0; test_kprobes_lrsc_allowed_addresses[i]; i++) {
+		struct kprobe kp = {};
+		int ret;
+
+		kp.pre_handler = kprobe_dummy_handler;
+		kp.addr = test_kprobes_lrsc_allowed_addresses[i];
+
+		ret = register_kprobe(&kp);
+		KUNIT_EXPECT_EQ_MSG(test, ret, 0, "location %pS rejected", kp.addr);
+		if (!ret)
+			unregister_kprobe(&kp);
+	}
+
+	/* probes on or inside the LR/SC sequence must be rejected */
+	for (int i = 0; test_kprobes_lrsc_rejected_addresses[i]; i++) {
+		struct kprobe kp = {};
+		int ret;
+
+		kp.pre_handler = kprobe_dummy_handler;
+		kp.addr = test_kprobes_lrsc_rejected_addresses[i];
+
+		ret = register_kprobe(&kp);
+		KUNIT_EXPECT_LT_MSG(test, ret, 0, "location %pS accepted", kp.addr);
+		if (!ret)
+			unregister_kprobe(&kp);
+	}
+}
+
 static struct kunit_case kprobes_testcases[] = {
 	KUNIT_CASE(test_kprobe_riscv),
+	KUNIT_CASE(test_kprobe_riscv_lrsc),
 	{}
 };
 
diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
index 537f44aa9d3f..93393e77a2cf 100644
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
2.43.0

