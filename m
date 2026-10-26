Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045638;
	b=bVu/rJ7LnOP6F6LTFkQ6oKCdNlQ4BpWe/+XBd9Btq27wrh7WwpzHsqf/itUk9XUEKiac
	 0mIl9S+k05MODGF/4Z/vXCNTYWKl9VlV/cIDZOV6Km6CCZnsNHHCV/FKNBE+NxD/JfMfV
	 v9y2INAT6CQKiu7FT1x2/7EqJXkVTVDtGIwr7ezLOMlJC0x0SDOlrrpz+iAaansrTDsB1
	 dOgSJqICsECNNssPe4HqOY5M2AlnxebSxHr+34Ror3+73+YxXpDKsGks/FBjhHimTfkHf
	 873me/y95l1Rj2JU4zDAdM8QfPgzYp/vfvaZPT4afqrQ/OGirDcL8JlxbxZOAt6DlxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
	b=J7O8u+mf1L5cJ71xvyYjh7KVi2JLhnvihNOFhebeW7820ZwHItHxZVGwKmIJZSqg9LVx
	 D5tIrK4b5GpqxMqGWAjlE/58waV/HdxoBKola/HRGV5a6P93ZBJHkNVvY33/du6hlmVpC
	 GtcfVEDgYlrG/FsPkji89NveY6Tc4jUNcmBbD+iqIdQ4+r8yhMO92xlfbHmAfoJzD0uMu
	 VivjBx0TsCS4aPWwWRm86XF0LITsKMYqyROPd2kIGyI1KobRL38xddOwrbrv4442In1/g
	 05QekA19QSCTYyfbyDETZtMBrymL4laElWsWTImH0vPwJ8tM3llJgXnwB1sM2RbN2Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9nqX60h;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A7606A31F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF1A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9nqX60h
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so4148437c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045637; x=1793650437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
        b=M9nqX60h6UASgVEfTP+vJ5fHXK4iggnxl8c+u1lnR7uefcFeJ9KYTdmZUHOA+9XpEV
         zuExPp84uVmsvMkYlwaW6vXWn2EXnLyo23Kdodrg2at8RCg+CM+/bqdWeL56Fv4vSDjX
         y4dS3Q/Z21K+V9pib0nUKUKjVrNAoh0m7jvzl3PTovN/UNAcECvVP5nwkXS57ij6Ba4K
         3Fliq0BP2LJn3uEbDvkMOzWQARHYPgRC+U8Ki3S8WIMsMzrVbKYvso6pxzBEGH/YJqV0
         y8RjJ+CsSZ7hVFZk+h8/1mgqkvQ+awGQAsJcPicNKqUYu85zXAkO3sB8O42VlAm9an7L
         UqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045637; x=1793650437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8AEEwHTufrmryJTMsqhvzKZ6h2afKOYiH2xqSkBe5Y=;
        b=K81BH4UBWAbYzQOJ2wGb6yM9MerGmHOxsX2pDBEYokhY0e2ewKEnSjS0sLxhvVA6Vs
         r2lJPqT5byVTyRW9i/9vTy6uTO2Hxq8/eFPk1t/Wo7EkRQS/ElWQu3Ivf954sxbftLLB
         UBioxRxhvRMctdUQwydYwbsMEKwuEshvu+Grfeqjy8Cvqy8Xa+8wKUo18+N9L6OYQ+bp
         xyUlUHSBHMjy+2oUNdeaZ6euGm9HZ39wODMzdi3ZDE0bHvX0Qe/J4eAv2jOZLtVDaWns
         rcmC9VpYptTjmMz6ysCaGyigzdacfyeKx41abKwGX3Mbwd89t60TN2RJ8b12rTOGXO0m
         i5gQ==
X-Forwarded-Encrypted: i=1; AKwUvBwF2OEvxsQ5LTrOpv3KbENbnl3975CdcXfY+seXIr3JMMRWGhPsoxWFxyN+mwtn2JRr+AmMRRr26iGj9Nz3C4PWFpY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA7lq4r7EGykpoDzIE/5modc9HctSeKuQ7YBer0NNm7FIKGtXn
	1xyFhx/rbj7xiu4d6cFanGzvkSEYTOdK0J3kTjCya/9kI8saIuLcof/a
X-Gm-Gg: AYBFou3gBaLrAjchA7HcuVeTrIwsj4l311Z/E8LtvlxzSznuhUvUlhF8yp7l0jlJ0Bc
	cFhmNz5tBXY0cmI1exT8CSLC06qXyspUXohTJw/K9HEyOfbXJht2GD4OK0SkkEna69Zx5+qCTCs
	UEFtwYqsuMR08te9jhsmifAkurEkUsugkpdzAZOy+RLWjtkO5525X16DFsvn4OhNYLjzNA2+H3O
	o3xtDwHnnOKwpjeGJBme9DVM08BvLawcPQ58KCwq97c37MO8j88m3zqCos9CuvBxN17kIu7Cmpv
	hQFA6SllT4+n+fpvnAs/PkmYqkHMpsyRpQtIx180Kk0RD49PaXtkLMJJckF9Dy2bpo6AnnIV3HB
	VVtUqA4W1f8b+YeaL1SV42+CqqrXjEJVlvL3ObMiEOlXwnW+/PfwD/aBY8tK8wpmfx5yei86p8R
	9JeBkt50nG1SQ6i8VEZZk3cjkv/EnnbkejjaMzXuXq/rxR0a5XnWcr4TKslvxY5qualfFKHFkPk
	4mKCzzwWdfqOOKxEieYtxXMQlSieRVwkCsxOW1VlPp9u+7JDMNiifrg6uzI1ig=
X-Received: by 2002:a05:7022:1702:b0:14e:d0ba:7569 with SMTP id a92af1059eb24-199290fe34cmr9680108c88.6.1793045636848;
        Mon, 26 Oct 2026 13:13:56 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm31730486c88.6.2026.10.26.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:13:56 -0700 (PDT)
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
Subject: [PATCH v3 4/4] openrisc: Add Kretprobes
Date: Tue, 27 Oct 2026 01:42:40 +0530
Message-ID: <20261026201240.107462-5-sahilcdq0@gmail.com>
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

Add Kretprobes support for OpenRISC. Kretprobes allow a probe to be
fired when a function returns. They are built on top of the generic
rethook framework and also require the KProbe mechanism introduced
in the previous commit. This work is primarily based on similar work
done for RISC-V.

Kretprobes work by inserting a KProbe at a function's entry point.
When the function begins to execute, the KProbe is fired and its
pre-handler replaces the function's return address with that of the
rethook trampoline. The trampoline in turn calls the kretprobe handler.
Control is returned to the original caller following this.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v2 -> v3:
- arch/openrisc/kernel/rethook_trampoline.S:
  (save_all_base_regs): Save SR and SP registers
  (restore_all_base_regs): Restore SR register

Changes v1 -> v2: New commit

 arch/openrisc/Kconfig                     |   2 +
 arch/openrisc/kernel/Makefile             |   1 +
 arch/openrisc/kernel/rethook.c            |  32 +++++++
 arch/openrisc/kernel/rethook.h            |   8 ++
 arch/openrisc/kernel/rethook_trampoline.S | 111 ++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 arch/openrisc/kernel/rethook.c
 create mode 100644 arch/openrisc/kernel/rethook.h
 create mode 100644 arch/openrisc/kernel/rethook_trampoline.S

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index d240533b424b..82365eb8f574 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -28,6 +28,8 @@ config OPENRISC
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_PCI
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 0c1cade09e0c..e36537cea319 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_OR_KPROBES_KUNIT)	+= tests/
 obj-y	+= patching.o
 
diff --git a/arch/openrisc/kernel/rethook.c b/arch/openrisc/kernel/rethook.c
new file mode 100644
index 000000000000..50ef6715d044
--- /dev/null
+++ b/arch/openrisc/kernel/rethook.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Generic return hook for OpenRISC. Depends on KProbes.
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
+#include <linux/rethook.h>
+#include "rethook.h"
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->gpr2);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback)
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	/* Store original return address and frame pointer */
+	rhn->ret_addr = regs->gpr9;
+	rhn->frame = regs->gpr2;
+
+	/* Set return address to trampoline */
+	regs->gpr9 = (unsigned long)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare)
diff --git a/arch/openrisc/kernel/rethook.h b/arch/openrisc/kernel/rethook.h
new file mode 100644
index 000000000000..332306a5c380
--- /dev/null
+++ b/arch/openrisc/kernel/rethook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __OPENRISC_RETHOOK_H
+#define __OPENRISC_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/kernel/rethook_trampoline.S
new file mode 100644
index 000000000000..5e8fd5a65222
--- /dev/null
+++ b/arch/openrisc/kernel/rethook_trampoline.S
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Sahil Siddiq <sahilcdq0@gmail.com>
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ptrace.h>
+
+	.text
+
+	.macro save_all_base_regs
+	l.sw	PT_GPR2(r1),r2
+	l.sw	PT_GPR3(r1),r3
+	l.sw	PT_GPR4(r1),r4
+	l.sw	PT_GPR5(r1),r5
+	l.sw	PT_GPR6(r1),r6
+	l.sw	PT_GPR7(r1),r7
+	l.sw	PT_GPR8(r1),r8
+	l.sw	PT_GPR9(r1),r9
+	l.sw	PT_GPR10(r1),r10
+	l.sw	PT_GPR11(r1),r11
+	l.sw	PT_GPR12(r1),r12
+	l.sw	PT_GPR13(r1),r13
+	l.sw	PT_GPR14(r1),r14
+	l.sw	PT_GPR15(r1),r15
+	l.sw	PT_GPR16(r1),r16
+	l.sw	PT_GPR17(r1),r17
+	l.sw	PT_GPR18(r1),r18
+	l.sw	PT_GPR19(r1),r19
+	l.sw	PT_GPR20(r1),r20
+	l.sw	PT_GPR21(r1),r21
+	l.sw	PT_GPR22(r1),r22
+	l.sw	PT_GPR23(r1),r23
+	l.sw	PT_GPR24(r1),r24
+	l.sw	PT_GPR25(r1),r25
+	l.sw	PT_GPR26(r1),r26
+	l.sw	PT_GPR27(r1),r27
+	l.sw	PT_GPR28(r1),r28
+	l.sw	PT_GPR29(r1),r29
+	l.sw	PT_GPR30(r1),r30
+	l.sw	PT_GPR31(r1),r31
+	/* Save SR in pt_regs */
+	l.mfspr	r13,r0,SPR_SR
+	l.sw	PT_SR(r1),r13
+	/* Save SP in pt_regs as it was prior to setting up this frame */
+	l.addi	r13,r1,PT_SIZE
+	l.sw	PT_SP(r1),r13
+	.endm
+
+	.macro restore_all_base_regs
+	/* Restore SR from pt_regs */
+	l.lwz	r13,PT_SR(r1)
+	l.mtspr	r0,r13,SPR_SR
+	/*
+	 * r1 doesn't need to be explicitly restored from pt_regs. When
+	 * arch_rethook_trampoline_callback finishes, it restores SP to
+	 * what it was before its frame was set up.
+	 */
+	l.lwz	r2,PT_GPR2(r1)
+	l.lwz	r3,PT_GPR3(r1)
+	l.lwz	r4,PT_GPR4(r1)
+	l.lwz	r5,PT_GPR5(r1)
+	l.lwz	r6,PT_GPR6(r1)
+	l.lwz	r7,PT_GPR7(r1)
+	l.lwz	r8,PT_GPR8(r1)
+	/* Return address in r9 is stale, so don't restore it */
+	l.lwz	r10,PT_GPR10(r1)
+	l.lwz	r11,PT_GPR11(r1)
+	l.lwz	r12,PT_GPR12(r1)
+	l.lwz	r13,PT_GPR13(r1)
+	l.lwz	r14,PT_GPR14(r1)
+	l.lwz	r15,PT_GPR15(r1)
+	l.lwz	r16,PT_GPR16(r1)
+	l.lwz	r17,PT_GPR17(r1)
+	l.lwz	r18,PT_GPR18(r1)
+	l.lwz	r19,PT_GPR19(r1)
+	l.lwz	r20,PT_GPR20(r1)
+	l.lwz	r21,PT_GPR21(r1)
+	l.lwz	r22,PT_GPR22(r1)
+	l.lwz	r23,PT_GPR23(r1)
+	l.lwz	r24,PT_GPR24(r1)
+	l.lwz	r25,PT_GPR25(r1)
+	l.lwz	r26,PT_GPR26(r1)
+	l.lwz	r27,PT_GPR27(r1)
+	l.lwz	r28,PT_GPR28(r1)
+	l.lwz	r29,PT_GPR29(r1)
+	l.lwz	r30,PT_GPR30(r1)
+	l.lwz	r31,PT_GPR31(r1)
+	.endm
+
+SYM_CODE_START(arch_rethook_trampoline)
+	/* Allocate enough space on stack for pt_regs */
+	l.addi	r1,r1,-PT_SIZE
+	save_all_base_regs
+
+	l.addi	r3,r1,0	/* pt_regs */
+	l.jal	arch_rethook_trampoline_callback
+	l.nop
+
+	/* use the result as the return-address */
+	l.addi	r9,r11,0
+
+	restore_all_base_regs
+	l.addi	r1,r1,PT_SIZE
+
+	l.jr	r9
+	l.nop
+SYM_CODE_END(arch_rethook_trampoline)
-- 
2.55.0

