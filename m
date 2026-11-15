Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746336;
	b=tCDLD3GPWoZe1Vf3xwBWnFJ9JH07H1cWlNPx+j3OrQcSCTUpo8OIZtROHLeiIt9cex/g
	 Qh2u+hIVx3O0+0Yj/kKk3mKd/zYQha6jlw7yNP9wOatxWYSHbl/3tVnT4LyW/DmwzO0hv
	 xEseaKrwcksqCoX1w07DHNpW944Yn2udrsvjK1zkyhXkVgD08WqHGZ5TgkZvk9CZUk9Sa
	 EXzbVqu6YI91BbPeZ88CjNfKVu4c3a2pMl0pli9+AuBQVwE04jWRUK7h5we01txVOpnQJ
	 4ePaC6suasxDeb+N8O5jlAIiAgnR1hzqdM8yTBPnIfHI1SRAXZLLpI3i+4i3tZ3odMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746336;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=9jcJWN0NdKgEN4LDyk1MwP0Pevti1LkkFkttcpC7LC4=;
	b=QmnvtTHEhGFR5WiGZ8/NdouVVI0krxgeHQMCfDz+jSR9/A0iCnSSPBqfDojNWQj35Ozn
	 o9vP24FIcY4rc7sfzYK7U/uOrQVm/k+SiO/c/p55fYasYng+Dm76e/+QI6z2XetO8M5wC
	 Vrhkqp8W7A1iL/bzj3Ll5osupzay9ZlKCHY02qF1Kx8eaEHkMmoqFXLWIwcJjRvHqoOtN
	 uUXlDXU3E6eNFFSV+HR6fYErW5Mat4lhR+dYKz/mjsRRo4JVuSmz4IiOaRPN170Eu37Dk
	 MUH8PX+EeUY0csdf19wcGb05I41GvQS+CTfrzv5fd5OpyAFdYE4AsFU1xJCVKS6K1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC56606A33F;
	Sun, 15 Nov 2026 12:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC56606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794746344; x=1826282344;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BUw7JeXvBZLkWxt5vkiT5i6cqwipH2FSgC84R9mmaUA=;
  b=G9888Hd3/pGuPoczw6iX3Dl5f9sZ2jVEMIMqG/hTNNQhoAEa71h4DQR/
   374dO/wQud45hviImsThLYUVMuIWrPIzt1lt9St8UCDsCm3Xn+MFCuIcC
   1GSibJ+6R8fBSVg7ghwSHO9HSuAnvDTQDUzIKpGLg9CgufkbLU+jBu2Hj
   PWov59HU11UEHe9fIhjw3zmGR+VSZ2hP4iQ8wxi2lqtD0SipKYM11g3dk
   +ilF22HuBnHJ8YSVTfjHI7rfoTuzsCOEHIgDVCGOZ123oVYQL5zBP/vqQ
   qoOdKpt9GymJ+lieJPcW5WgRv1ULQxGZ1HDgP16XeP+WXEpStLWwkKuhp
   Q==;
X-CSE-ConnectionGUID: aEAkvD/zReCyKrrAwScpaw==
X-CSE-MsgGUID: Gl6xOM3wRZi07Moj1112gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 14:38:53 +0200
X-CSE-ConnectionGUID: yxI1yTDiRGCBQZJr7fk+nA==
X-CSE-MsgGUID: 5mDrb12bTFmvJxspl4pAPQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 15 Nov 2026 14:46:46 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 15 Nov 2026 14:38:44 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Sun, 15 Nov 2026 14:37:35 +0200
Subject: [PATCH v4 3/3] riscv: kprobes: add KUnit test for LR/SC sequence
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
Message-Id: <20261115-probes-in-lrsc-v4-3-48b9b036bd1d@mobileye.com>
References: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
In-Reply-To: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
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
sequence and assert that register_kprobe() accepts a probe placed right
before or right after the sequence, and rejects a probe placed on the
LR, on an instruction inside the sequence, or on the SC.

Add never-executed function that imitates s valid LR/SC section, one
with short and one with maximum valis size body, and section with
LR and no SC, mimicking __cmpwait where LR is followed by the
conditional branch.

Suggested-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S | 58 ++++++++++++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.c     | 32 ++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |  6 +++
 3 files changed, 96 insertions(+)

diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
index 15e50934bbd7..ca5b9223f885 100644
--- a/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
+++ b/arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S
@@ -198,6 +198,44 @@ SYM_FUNC_END(test_kprobes_c_jal)
 
 #endif /* CONFIG_RISCV_ISA_C */
 
+SYM_FUNC_START(test_kprobes_lrsc)
+test_kprobes_lrsc_addr0:
+	nop
+	/* valid LR/SC sequence */
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
+	/* not a valid LR/SC sequence - no SC */
+test_kprobes_lrsc_addr5:
+	lr.w	t0, 0(a0)
+test_kprobes_lrsc_addr6:
+	and	t0, t0, a1
+	xor	t0, t0, a2
+	bnez	t0, 1f
+test_kprobes_lrsc_addr7:
+	nop
+1:
+	nop
+
+	/* valid LR/SC sequence */
+test_kprobes_lrsc_addr8: /* expect: rejected */
+	lr.w t0, 0(a0)
+test_kprobes_lrsc_addr9: /* expect: rejected */
+	.rept 16
+	nop
+	.endr
+	sc.w t0, t0, 0(a0)
+	nop
+	ret
+SYM_FUNC_END(test_kprobes_lrsc)
+
 .section .rodata
 SYM_DATA_START(test_kprobes_addresses)
 	RISCV_PTR test_kprobes_add_addr1
@@ -253,3 +291,23 @@ SYM_DATA_START(test_kprobes_functions)
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

