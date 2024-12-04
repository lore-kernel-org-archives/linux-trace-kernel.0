Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08E1E522;
	Wed,  4 Dec 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296493; cv=none; b=hZO7JxQBctmciqjTHQNa74jX08YZaYMqGE24ot0E5AV0KWIQgtu7d3FOJDvACpklQcQlEpdomNnf6ENJQ97rXKpTiYtcPRJs5zUbIGAf3h/M9/AtqItoFUOapKMaqw26/bHEUIDd9bXaye+dkP77xbJzOpSD/WwlhM2JGU3Qr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296493; c=relaxed/simple;
	bh=lATQn35Lh/b3dk+WEOeuwOuK+UJNMeapYBTnIVg3ZVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NR8Doa1sAYdFodFAmu6m7X7UUu9FoE6uA3HcwUIJyPl89sZhunXxv0KjZ9bXENBJCEpVG1eh23ETi1EHCfsr5eypzxtkMQAP2i2rdI0vEhgL8y+tDK4b26rQftziMRmbcG7Ram1/nTC55ILxavwidhdQM+fxpGNmIHiVCEvFRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Pm0A72fO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Pm0A72fO"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5343AE0002;
	Wed,  4 Dec 2024 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733296483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFmvl4A54RbX2d0A+Hcc5Q1dzADd/mmBQrsMzEB+NMM=;
	b=Pm0A72fOex7Xpk4AWwY2C3hkBHOP0yvZSFQ/vreKK8rP+GfP5FHA+ehs6b7f85EAOncn64
	eBF+VLkQgiudnnk1p3SHfql0+x6eSjbyuGprVND0Wqa1KkAgeCKtFs2vBl/ZYVN+lwjJsM
	pQ/03AlpCtwUAVQtk6auSkIwtYj/tO6bg1nwAtYecpox44mNlSC4Z5mum6lUolsW1X5NNq
	NOhX5MTJV8oxmvntUuqWHV6h4cQCbm6IkzXeP9CDG3XwwtvfmUrj9yk+umeI67BJgSJC5m
	S+3zyF2RPPlWZ7W3AwFSeTxoxhhY01F4nwgRJRqCKfGCVBK+tms7rPbDcVLe4Q==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 04 Dec 2024 08:14:40 +0100
Subject: [PATCH v4 2/2] arch: m68k: Add STACKTRACE support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-add-m68k-tracing-support-v4-2-e24fe5ef3b6b@yoseli.org>
References: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
In-Reply-To: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733296481; l=3079;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=lATQn35Lh/b3dk+WEOeuwOuK+UJNMeapYBTnIVg3ZVs=;
 b=N+MC+nVTnN0sMIPNUDszQzACCuIkYM4+P3jwOIkKdVlqpOnChOhLEWY6IO5dO17tbBzB9JHjp
 5vILhAjbQ9MD3pQ8LpXrOAAgOiI3nwfmgqR9w5eKNz/mjv7Y9O090hw
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

In order to use tracing, implement a basic arch_stack_walk() based on
the one in PowerPC.
Tested on a M54418 coldfire.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/Kconfig             |  5 ++++
 arch/m68k/kernel/Makefile     |  1 +
 arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 793ab1e2762609725bbf793f6dffecfa3ecfff0f..3ad8596aab71190807f8c11dd5876aa1198760f3 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -106,6 +106,11 @@ config BOOTINFO_PROC
 	  Say Y to export the bootinfo used to boot the kernel in a
 	  "bootinfo" file in procfs.  This is useful with kexec.
 
+config STACKTRACE_SUPPORT
+	def_bool MMU_COLDFIRE
+	select ARCH_STACKWALK
+	select ARCH_WANT_FRAME_POINTERS
+
 menu "Platform setup"
 
 source "arch/m68k/Kconfig.cpu"
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index 6c732ed3998b714a4842ee29c977550a61979779..cb02bcfe04c6b265fa97db9237395a262e649989 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_UBOOT)		+= uboot.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-y	+= stacktrace.o
diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/stacktrace.c
new file mode 100644
index 0000000000000000000000000000000000000000..4c2fb6b0cf675ee5a3a21393a50603fea98a1b03
--- /dev/null
+++ b/arch/m68k/kernel/stacktrace.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Stack trace utility functions etc.
+ *
+ * Copyright 2024 Jean-Michel Hautbois, Yoseli SAS.
+ */
+
+#include <asm/current.h>
+#include <asm/ptrace.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
+
+static inline unsigned long current_stack_frame(void)
+{
+	unsigned long sp;
+
+	asm volatile("movl %%fp, %0" : "=r"(sp));
+	return sp;
+}
+
+static inline int validate_sp(unsigned long sp, struct task_struct *task)
+{
+	unsigned long stack_start, stack_end;
+
+	if (task == current)
+		stack_start = (unsigned long)task_stack_page(task);
+	else
+		stack_start = (unsigned long)task->thread.esp0;
+
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (sp < stack_start || sp >= stack_end)
+		return 0;
+
+	return 1;
+}
+
+void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+					   struct task_struct *task, struct pt_regs *regs)
+{
+	unsigned long sp;
+
+	if (regs && !consume_entry(cookie, regs->pc))
+		return;
+
+	if (regs)
+		sp = (unsigned long) regs;
+	else if (task == current)
+		sp = current_stack_frame();
+	else
+		sp = task->thread.ksp;
+
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long newsp, ip;
+
+		if (!validate_sp(sp, task))
+			return;
+
+		newsp = stack[0];
+		ip = stack[1];
+
+		if (!consume_entry(cookie, ip))
+			return;
+
+		sp = newsp;
+	}
+}

-- 
2.39.5

