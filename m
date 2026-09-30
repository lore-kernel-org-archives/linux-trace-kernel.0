Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D35013DB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800355; cv=none; b=fSqiHrvIDIwLvjpDgTN0s9r/FiiWDhG6z3URDZbWIHMrh55e2f3kGU4BM+PDd/dmJ1khuVGFSwLZu8mgiDBbvQume/Ygqw72eVn1LKNLS+f5+A73psSfNYC8bE65rAmJHEkbvoU9xjaRMhNirTfvibqQMUOJQgCSt0NUMLitvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800355; c=relaxed/simple;
	bh=ZMGEdProbbpZNb5nPv2AhFlJlrmq3NVRdzI5pT7KQlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTtGaKFRAvtCmMOrZIlqVbbFZsPUX+JvyMxo3GSje1VWEUFSQCJiXMA4fYNNKaQ1WvEhh7/33I0tWtom5yIKcpRhyg5vCrkOUfjCYUsbFCmF98BpnjQ0ld+izjkFgBYyZPj7iAHJaW2sCoxUKyOHfc64vAD8c6fx448p3ju47a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbDRuXTk; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbDRuXTk"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344447f9c3dso3161664eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800353; x=1791405153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdpiiZi7ht9I6UhkYo2G0GEqr51ID69V00rMoZHRdVw=;
        b=KbDRuXTkghK+1DIBXR8XaqqD6Zv/OeRf7yYf91xHCBKg1hShTPeaHTRvnZL9AE2WzB
         oVVktZpXh6Jt/CIImL8GxQMGeKZ4WNbX95PtMRq1cmhRAdwBvAY1I6ogrJZkHx/Pvxmv
         QaHwMpFGI4mrk1Ss2GYw8Bq8Xff/lF1zLYpKadQsAAWy7XhK9z5zF2NBj8ngqa93Hyhp
         0FQF2xme+A7UomWuV7BB39NuE9PkSk1AQILJSzcoGeElgGLxUuSVWmhZ16O0cFqBOs8F
         XlbAJMZ5gi6IWwehqL5DzFfacCEflDH+meCuArjutcsqMqZIJWvt01UN0rew0SNIn21q
         TvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800353; x=1791405153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DdpiiZi7ht9I6UhkYo2G0GEqr51ID69V00rMoZHRdVw=;
        b=HTAKtBvj/BO7mEz5HiSwEmLSuO2DnmM0ydkReTIVwSPe0d3Ra4hkqIAm+93/vtJpYL
         VWINYm+o3ccTVT9U85s7lxoS6lOjTw54xW09Z7btvp+7jS6uItl9cjpafTSu800jxL7b
         xhSmmXZpwDb0WJkfWiTkIten+496aTun7YMgCwK4ONOX48eWJemcUBcK39/7t52NyID4
         ac08X+ztxM8oxutz3N3MwnWvSUaIhvQ1+rybcqWjdiXR1HbDAIf8Ed4XrJr34aVXk23U
         OZNkq45KyDfZDosX/aU5s0PvVe1KsGc84H4M1qFzFsmCo7506800t/7fxGWjVjPZcW5U
         UzEA==
X-Forwarded-Encrypted: i=1; AKwUvBw4iF0VO8TNwow3aT/d7+oxrhG4+kQxWVqKdfesNtyvIdT6L74r1LognGWosTofLaTPswXRFgyetyOOy7P8v9AMzGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGhzD04rmEQPgNpfOCoF//TVjjru7h88ogNhUrnkGqGBpICPDm
	K4Xt/bfbS6j0v2rF4Jaa4oY9GmXpwb5fP4tRIFTcXmBPGhhHu/Nok1Qv
X-Gm-Gg: AYBFou0D3h/4ld4QITLvxE8imb+UwgFfG89P5CoV/y2VgesXTWwgDjjN5PafLu9r6Es
	PqkLrjaxKoyS+V1hjjqO0iSyekVP9Nzhtlk5+IKZ/eeCkeb+866MarnieBFzJrko1egVMfQh3a6
	P62aN5PWyIOAMCgSQIa3d7cyszgT7Z2dNqivdQSSJrwg042RJ9ELqQrpzqusU/8Ik9w9Yp8eVmz
	2OPJNP1CrlMDi71XENyfoVtYAza8v5hWBIrFXxzvAStNJrEuc8WLKagUrYV/HnGCDwiQD2LRfI5
	R6R2v6iQiAhpn9S9S5SoLhUb1MGM9kpajtD3vn3VE0QsC88s9JUH1HEDIsNPcH8u1h0smQ9y3z9
	sQYW5d8AZI1q/eiQQjXHzrE13YXY51eTkzjP1vJaQcPbohye1Kp9KWghkid7nPV8VSXtkn9h+Hi
	LxW75NLXzjKXGqxuq/nsc4eRmnAqMeoalvvYI1eH7JfGqyFo0XB/xWbmFln/iD0v61fJa/SL/uY
	As1MPbZuMJmwTAN
X-Received: by 2002:a05:7301:4b12:b0:343:bcfc:fd1 with SMTP id 5a478bee46e88-34cddd83c25mr2683541eec.39.1790800353135;
        Wed, 30 Sep 2026 13:32:33 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:2e39:63b8:ea3c:fa28:7091])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1162411eec.29.2026.09.30.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:32:32 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: tytso@mit.edu,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	pjw@kernel.org,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v2 4/4] openrisc: Add Kretprobes
Date: Thu,  1 Oct 2026 02:01:29 +0530
Message-ID: <20260930203129.51048-5-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260407185650.79816-2-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
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
 arch/openrisc/Kconfig                     |  2 +
 arch/openrisc/kernel/Makefile             |  1 +
 arch/openrisc/kernel/rethook.c            | 32 ++++++++
 arch/openrisc/kernel/rethook.h            |  8 ++
 arch/openrisc/kernel/rethook_trampoline.S | 97 +++++++++++++++++++++++
 5 files changed, 140 insertions(+)
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
index 000000000000..ac4ca0ecc669
--- /dev/null
+++ b/arch/openrisc/kernel/rethook_trampoline.S
@@ -0,0 +1,97 @@
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
+	.endm
+
+	.macro restore_all_base_regs
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

