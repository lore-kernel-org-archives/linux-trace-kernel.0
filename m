Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585921FA251;
	Tue,  3 Dec 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246514; cv=none; b=UBiHQAw/FRV2SCQv8jvTRA/NgjxPXvsKwTe5TDMqsCgCYvxIV7yImOsEf3QCXsJGauRCsPp7VNj5ASameMw4iK0X11+EwHU9uhGyVFjDn6AeKhjaJbF4M1b+wkTGWRFI851lDE5NfnHolwLcLlIa0OdKGddH+v52o5Mx9YifLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246514; c=relaxed/simple;
	bh=1CN8q8CgvimUvygXr+D0mvbJuGn4uhqxoM/VGe7tMBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n60Tu9EZSHc0ARjcUeubUKaN49UhjPvwU6sSq3M3tjFwoy38zrB3fBzfLnjvIaNqhuvFrkWaTnUlRhzIdY/eIAbfd4QdaR2tpuB4zGCGylvlCSgcAkWua5Od0HtZCGGfXT32S+XRlVoPAqiTMLDOWbhCfo3P2of6LrYfydMLIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=KjWPc5vS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="KjWPc5vS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA53A24000C;
	Tue,  3 Dec 2024 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733246505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78Wm87mcvcNcizl2XQuljczepplgaf9PD3511aCnbuA=;
	b=KjWPc5vSM74LB0N3INECiT21QX3XEVi3ueDx/AP0waRDW6tPvi43adEA6TNhCNFcQ8JvP3
	H9J2G2sevee8lGzz3rtG6OaIaYzEofbgLQz7QfKPcL2gagV6irVLMP62R1nhnTTDANUHCv
	gPdA3HsWr+tw5+WW/eJs4aj8M6wzIAcErjqQ0LbX1hz4RzYxz+kotYFMovUDp1tyaaB47J
	YAd1E3ebV6oxV+6O7+IWjS6HkJBxRS2RZIdE7hvMPX4ouGFeCiwS0utGnr1iqKKr8EvjA+
	uFQ6h9zuPzodgGtLTwRcDjavtIeZSMDJHHnlD7yqGQLcEuu1e3tUcqexjYIewQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 03 Dec 2024 18:21:39 +0100
Subject: [PATCH v2 2/2] arch: m68k: Add STACKTRACE support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-add-m68k-tracing-support-v2-2-77302097a9f4@yoseli.org>
References: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
In-Reply-To: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246503; l=3232;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=1CN8q8CgvimUvygXr+D0mvbJuGn4uhqxoM/VGe7tMBk=;
 b=Ge1GOk63fVTAu5a0TTZcQM9v3E6LsCyJmDJgyWxSQFvMR54I1JAoXcrAwzT5O8lcOWL7dINR5
 kfb5DzgQwgGC9rKh3CsJYuQtiu3jg0/AC2kShcDBecgl2A2Ujmn8y9q
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

In order to use tracing, implement a basic arch_stack_walk() based on
the one in PowerPC.
Tested on a M54418 coldfire.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/Kconfig             |  6 ++++
 arch/m68k/kernel/Makefile     |  1 +
 arch/m68k/kernel/stacktrace.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 793ab1e2762609725bbf793f6dffecfa3ecfff0f..6ba3238ba2c68acaf5974396739e629b09eee3ca 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -40,6 +40,8 @@ config M68K
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
+	select ARCH_STACKWALK
+	select ARCH_WANT_FRAME_POINTERS
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -106,6 +108,10 @@ config BOOTINFO_PROC
 	  Say Y to export the bootinfo used to boot the kernel in a
 	  "bootinfo" file in procfs.  This is useful with kexec.
 
+config STACKTRACE_SUPPORT
+	bool
+	default y
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

