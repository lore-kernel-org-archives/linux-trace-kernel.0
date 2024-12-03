Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601C20408E;
	Tue,  3 Dec 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255797; cv=none; b=p0l6c9mIcRMF1rctso+RyvP6RQgef9hQu2t/YrnTyHuAYyO2DUU2SFzUqcKCzvgm1uxzvkJil91MY0TRnekHjuXMrozfdwD8vGsA1kIRTf0Lq2AICgKEFynw1yVnc7cAf8Gty8GwEqZXd5ksLkyPShggyYypGOykVnBjC73FtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255797; c=relaxed/simple;
	bh=lATQn35Lh/b3dk+WEOeuwOuK+UJNMeapYBTnIVg3ZVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdS2CoSydHFY2+pkKfvdfXZCkbgbrwLu2f+nxsZj9cV10P/YU37Np8Lro9+gJS95mwFeTS1FU5Iv9kfEqI8uboecnQCFr4nqP1Ogw7L56rLjIBSlUAdK3aYMRLoy8TPN81XOBNJbKJfJ5MUJuwjwFnDO14+vEI8312xxHVd0itU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=c+eKq+x+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="c+eKq+x+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A793520009;
	Tue,  3 Dec 2024 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733255788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFmvl4A54RbX2d0A+Hcc5Q1dzADd/mmBQrsMzEB+NMM=;
	b=c+eKq+x+X9OvrvZj5PDoGvQDtXxjnEjEn8fxyrItuVaL2YkC3DABbPB+9GbD2ZJ5vN/YVR
	epcemcrQ0vkk1r4CdopI4tbIdVzEFOweAO2PdExBl3Xlv5CHxGSHcETVW/eUad0JXc89HR
	MoRC4r1rfU3hWXGD8o473ujeRTo6NOVKCQpdoZx7OWn6yKlRoNZBM7drDSXDO1p0wcKAz7
	cQyWP2SrYKqBBF1ZCgfs4RGM6/7NuDFqwxgRih/fSRnBwX87AIVkGA9mZwFwqesM90iliG
	Ll0zS6Sxd0iRYzXI0yb1nNzDr5TcnWDDT4H10gacSGVYrjfVDgQtx2xWR5CmTA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 03 Dec 2024 20:56:26 +0100
Subject: [PATCH v3 2/2] arch: m68k: Add STACKTRACE support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-add-m68k-tracing-support-v3-2-4de93f6cae55@yoseli.org>
References: <20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org>
In-Reply-To: <20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255785; l=3079;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=lATQn35Lh/b3dk+WEOeuwOuK+UJNMeapYBTnIVg3ZVs=;
 b=9b9w2q+XntKKeFdrnDRrBYXPVk/GWwlEks9sY5+TE+l6RufrJe1Fs9xBQj9EwN0QZv703mV6x
 /PvmWMehrkpBBlfFVbIO2n4RMLoxJ5S7/kv3Q9Xe5+6VWIXbuzo+kP/
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

