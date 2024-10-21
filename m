Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BF946C;
	Mon, 21 Oct 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503895; cv=none; b=o0/pthBJiAKRYPwY2o4j1JiPgSPsC8dRutsu/GCzBMe2XQCmPmo5Os2BR0F1n7z70duK2RuorqK06q/QiAlVaDkQQXcc7Hw7sf5v8TBAmqGdxH8AX5RISkulowMJ3lpR8yA8DuGB5fFQiQQ9j2jv07D5CBieWOhmJuQD+ms0bqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503895; c=relaxed/simple;
	bh=0xBD3A8MKB2zAVhLnpz+RBecfEobXW6DqqxmgJzTRQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbIkSyQWes2i5cFmAx9odUQOgSFThl7bEbCc8gyGUxFEETGbd5S3ehchVyXJnlw+CfWN6Lz6bWiFDrahbsl2tvYclHaxoIJ0c4BsvUlZseA1a3+U7vqBO37iZk1GaE/dLrKM5OAWikRJKs6TDZsTKy9dou8eO1hFXIRWELHMoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=bl4phBrr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="bl4phBrr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B01C1C0006;
	Mon, 21 Oct 2024 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729503885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+btbJTjZs1+lS1NAnUYjVfMHwFlz7titLmmGTREl3s=;
	b=bl4phBrrYC9KDxapFsTg5eDARIJrHeAabZk1ZNjr+nlJUvpptFhoV22FSG/Pczs7IRG5he
	4MkxG3Xmdr3l50ypsycWRbZIsx6hrikliM5YgXc9g+LNBXpNdO38FMxh1FsSsB/4DE3H6v
	XfvIe2iM39vr4PpwJh9ISsnIijIBQFpmfdediamJClW5mU/3CdtIUZGdN0NoTuY+0HrnGy
	Zpp8fgqzFVRP+Ui0w7DhTz4ElxQHYk6xhD544s9EJEsAncUZEy3sR7KKOhPBfNl46x9aVT
	M2D6TidbdLxpEHe8iR+lfhFg8340VA7HppexXT8NFv2n855yf1pFnD709UpwUw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 21 Oct 2024 11:44:43 +0200
Subject: [PATCH RFC 2/2] arch: m68k: Add STACKTRACE support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-add-m68k-tracing-support-v1-2-0883d704525b@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
In-Reply-To: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729503882; l=3197;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=0xBD3A8MKB2zAVhLnpz+RBecfEobXW6DqqxmgJzTRQY=;
 b=zFWQdtyHJmiGamfZyWwH9J+qr9vfkOA9rNEYW/hcR1Pc1AC+I0W3hUAX7EdAX8oqRCzV1AN8j
 KstOEx18llODcBKoOZnENOjOk4Yipcew21bDx1hyix/bVlqbMcoL2sa
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
index ab3375475721fa63418c40d4ba6ac76679ebc77d..7142f9759181a90269ae1ba9e682d331ee2ddbf6 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -40,6 +40,7 @@ config M68K
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
+	select ARCH_STACKWALK
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -107,6 +108,10 @@ config BOOTINFO_PROC
 	  Say Y to export the bootinfo used to boot the kernel in a
 	  "bootinfo" file in procfs.  This is useful with kexec.
 
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 menu "Platform setup"
 
 source "arch/m68k/Kconfig.cpu"
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index f335bf3268a108a45bab079fbf0a1c8ead9beb71..4efe92af0b711b19cb1d5129f74e67a739e289b1 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_UBOOT)		+= uboot.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+obj-y	+= stacktrace.o
diff --git a/arch/m68k/kernel/stacktrace.c b/arch/m68k/kernel/stacktrace.c
new file mode 100644
index 0000000000000000000000000000000000000000..06c7459373bd25b3bb3540cfe2a909259c1db3ce
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
+	asm volatile("movl %%sp, %0" : "=r"(sp));
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

