Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74006264FA5;
	Fri,  2 May 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204609; cv=none; b=qaoL++E5B5biiTsyNmCjDDwB11N9+0zkEB42Lr2OMPEdGi3BUTcLvQ3G81dOzU+UU+w8nitY9MD4CLSzef7CDO39PBCwyj6LZiejRvGvHgnvMflaqIw6lbzrSoNncI454Tw1RPOaZJ0V7rnXb1KYwYM/KOD6HvH3D0moDhYf6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204609; c=relaxed/simple;
	bh=JTFH4J/aPfmXUm6zG2FJR1h1yEhf4M7031l6ypEpMj0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LGwECcx6nY5FHlYJyevIXtmmiB4t+OaOn4uajpf2oSsM9cLLGziRER7W18MqoMcts57KaYt2+wmh4TmUbq6t3mlRKvrjF0zEkRY4OTsjlECSCiVDicGmdG0nm3Ms/pneSYtnBHwed85YLj724Tb4ydnJSCP04aaJ+gGhjR1SWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21B5C4CEF2;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaS-0000000031E-0rnq;
	Fri, 02 May 2025 12:50:08 -0400
Message-ID: <20250502165008.057614236@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 04/17] perf/x86: Rename and move get_segment_base() and make it global
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_segment_base() will be used by the unwind_user code, so make it
global and rename it so it doesn't conflict with a KVM function of the
same name.

As the function is no longer specific to perf, move it to ptrace.c as that
seems to be a better location for a generic function like this.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/events/core.c        | 44 ++++-------------------------------
 arch/x86/include/asm/ptrace.h |  2 ++
 arch/x86/kernel/ptrace.c      | 38 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2e10dcf897c5..cc6329235b68 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -43,6 +43,7 @@
 #include <asm/ldt.h>
 #include <asm/unwind.h>
 #include <asm/uprobes.h>
+#include <asm/ptrace.h>
 #include <asm/ibt.h>
 
 #include "perf_event.h"
@@ -2809,41 +2810,6 @@ valid_user_frame(const void __user *fp, unsigned long size)
 	return __access_ok(fp, size);
 }
 
-static unsigned long get_segment_base(unsigned int segment)
-{
-	struct desc_struct *desc;
-	unsigned int idx = segment >> 3;
-
-	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		struct ldt_struct *ldt;
-
-		/*
-		 * If we're not in a valid context with a real (not just lazy)
-		 * user mm, then don't even try.
-		 */
-		if (!nmi_uaccess_okay())
-			return 0;
-
-		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = smp_load_acquire(&current->mm->context.ldt);
-		if (!ldt || idx >= ldt->nr_entries)
-			return 0;
-
-		desc = &ldt->entries[idx];
-#else
-		return 0;
-#endif
-	} else {
-		if (idx >= GDT_ENTRIES)
-			return 0;
-
-		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
-	}
-
-	return get_desc_base(desc);
-}
-
 #ifdef CONFIG_UPROBES
 /*
  * Heuristic-based check if uprobe is installed at the function entry.
@@ -2900,8 +2866,8 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	if (user_64bit_mode(regs))
 		return 0;
 
-	cs_base = get_segment_base(regs->cs);
-	ss_base = get_segment_base(regs->ss);
+	cs_base = segment_base_address(regs->cs);
+	ss_base = segment_base_address(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
@@ -3020,11 +2986,11 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 		return 0x10 * regs->cs;
 
 	if (user_mode(regs) && regs->cs != __USER_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #else
 	if (user_mode(regs) && !user_64bit_mode(regs) &&
 	    regs->cs != __USER32_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #endif
 	return 0;
 }
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..59357ec98e52 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -314,6 +314,8 @@ static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 	return !(regs->flags & X86_EFLAGS_IF);
 }
 
+unsigned long segment_base_address(unsigned int segment);
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..81353a09701b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -41,6 +41,7 @@
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
 #include <asm/io_bitmap.h>
+#include <asm/mmu_context.h>
 
 #include "tls.h"
 
@@ -339,6 +340,43 @@ static int set_segment_reg(struct task_struct *task,
 
 #endif	/* CONFIG_X86_32 */
 
+unsigned long segment_base_address(unsigned int segment)
+{
+	struct desc_struct *desc;
+	unsigned int idx = segment >> 3;
+
+	lockdep_assert_irqs_disabled();
+
+	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+		struct ldt_struct *ldt;
+
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
+		/* IRQs are off, so this synchronizes with smp_store_release */
+		ldt = smp_load_acquire(&current->mm->context.ldt);
+		if (!ldt || idx >= ldt->nr_entries)
+			return 0;
+
+		desc = &ldt->entries[idx];
+#else
+		return 0;
+#endif
+	} else {
+		if (idx >= GDT_ENTRIES)
+			return 0;
+
+		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
+	}
+
+	return get_desc_base(desc);
+}
+
 static unsigned long get_flags(struct task_struct *task)
 {
 	unsigned long retval = task_pt_regs(task)->flags;
-- 
2.47.2


