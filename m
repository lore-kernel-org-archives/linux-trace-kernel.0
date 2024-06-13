Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B061420A6;
	Thu, 13 Jun 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277110; cv=none; b=AMOo1URJ30VWuJFurafBwqWNDiQLfRyhvlc7pCihVXKTD+oWWtAJNuM4hovH1wQy8FjvBN5ZfXxcg5LPDnuXNS4T85H6sowJOddIVjA2AedAnaDsWctc9/348lkDbGWCn09hYoQh4AJrT7Lsa61SAQB1SDXJKx3HPiijTkYLs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277110; c=relaxed/simple;
	bh=+8Jz6J4KQ6eJ3C1QBfNVhmsduMCjE85NO9/Xvp0C2yU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gsR/2sFQSPGy+fX+2qzOuUVWMRABwdIC4rq1BMXj6WYx4rogZ2heStcLyS1LgkTkFmo0oPLeAM9tu5A49zqxes91xojyDi0/XLYULcGvjGGBQJlP/pR5qFfUbXrzOL5MKMpug0r2YyaznAbojNFrkM9pQY3IVCEDl2ys0ecAzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0KSg5bX3zdbqm;
	Thu, 13 Jun 2024 19:10:11 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 61191180AA9;
	Thu, 13 Jun 2024 19:11:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 19:11:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] trace: riscv: Remove deprecated kprobe on ftrace support
Date: Thu, 13 Jun 2024 19:13:47 +0800
Message-ID: <20240613111347.1745379-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Since commit 7caa9765465f60 ("ftrace: riscv: move from REGS to ARGS"),
kprobe on ftrace is not supported by riscv, because riscv's support for
FTRACE_WITH_REGS has been replaced with support for FTRACE_WITH_ARGS, and
KPROBES_ON_FTRACE will be supplanted by FPROBES. So remove the deprecated
kprobe on ftrace support, which is misunderstood.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig                |  1 -
 arch/riscv/kernel/probes/Makefile |  1 -
 arch/riscv/kernel/probes/ftrace.c | 65 -------------------------------
 3 files changed, 67 deletions(-)
 delete mode 100644 arch/riscv/kernel/probes/ftrace.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..a1f2d604c459 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -149,7 +149,6 @@ config RISCV
 	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KPROBES if !XIP_KERNEL
-	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
 	# https://github.com/ClangBuiltLinux/linux/issues/1881
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 8265ff497977..d2129f2c61b8 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
-obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
deleted file mode 100644
index a69dfa610aa8..000000000000
--- a/arch/riscv/kernel/probes/ftrace.c
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/kprobes.h>
-
-/* Ftrace callback handler for kprobes -- called under preepmt disabled */
-void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
-{
-	struct kprobe *p;
-	struct pt_regs *regs;
-	struct kprobe_ctlblk *kcb;
-	int bit;
-
-	if (unlikely(kprobe_ftrace_disabled))
-		return;
-
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0)
-		return;
-
-	p = get_kprobe((kprobe_opcode_t *)ip);
-	if (unlikely(!p) || kprobe_disabled(p))
-		goto out;
-
-	regs = ftrace_get_regs(fregs);
-	kcb = get_kprobe_ctlblk();
-	if (kprobe_running()) {
-		kprobes_inc_nmissed_count(p);
-	} else {
-		unsigned long orig_ip = instruction_pointer(regs);
-
-		instruction_pointer_set(regs, ip);
-
-		__this_cpu_write(current_kprobe, p);
-		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			/*
-			 * Emulate singlestep (and also recover regs->pc)
-			 * as if there is a nop
-			 */
-			instruction_pointer_set(regs,
-				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
-			if (unlikely(p->post_handler)) {
-				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				p->post_handler(p, regs, 0);
-			}
-			instruction_pointer_set(regs, orig_ip);
-		}
-
-		/*
-		 * If pre_handler returns !0, it changes regs->pc. We have to
-		 * skip emulating post_handler.
-		 */
-		__this_cpu_write(current_kprobe, NULL);
-	}
-out:
-	ftrace_test_recursion_unlock(bit);
-}
-NOKPROBE_SYMBOL(kprobe_ftrace_handler);
-
-int arch_prepare_kprobe_ftrace(struct kprobe *p)
-{
-	p->ainsn.api.insn = NULL;
-	return 0;
-}
-- 
2.34.1

