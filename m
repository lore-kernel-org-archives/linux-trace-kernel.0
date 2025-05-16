Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45922F767;
	Fri, 16 May 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387151; cv=none; b=cn/HBxUXV59P3/DWTl4OJDFlIM83BbhyVtW6papVkWmfnMcr5+rninYvIa3CWNaSsS3SCg2bFnQUQy5nkivPgUfiIts4LBgcGctWCXDmCJILp95xFgOmEsJWQQ0JIfIWvpES9JIlx4gQU6g8620JpfrM3UjTLvrJbYsMo2duLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387151; c=relaxed/simple;
	bh=UwUuRoP4lcyZaAyEjqOmx6ZqJcQ+Bw7MkoIugWI6KRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mkxu5wCcItKNq+l0gmX0I6PTC92KaVbzRxmce1rDPqaoKdlsvhD5IDy+g0fRZKUZCQDWoOGVM2LLfupyGpaK3J758CwiFBQM8eeeb2WGHEoibRHj4GlzQC+BCv9o7lmz6z55C9edYcxVbDUQyqpL1KMF5ggZ9GnbEyEcX3+x0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wX0qegYD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qa6VwUlm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wX0qegYD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qa6VwUlm"
Date: Fri, 16 May 2025 09:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747387147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hkh99/Lh8jC9qqdfdjd/YQLCiq8mACt3rhDU5rbTjos=;
	b=wX0qegYDlRqJYa7M8KjHukLSe12F0aM82piye4vCIhSoxjuuEdUro+hp03Yv/SM3qsEsvL
	ELnmQeRgVB1VkH5wT+pw3oHkyYAISqdg2BWCOytxrw1hIoJt/pQNObIuMNUCkSqdJeVA8l
	dN9zYJW/VhxJWGJ95Cu5WUUjUitKdpvEKtRwW6cZsWOCP9Mg8ug7T0ctsN88SHtZzHWhye
	PcI1NPJdvcsKQOUqJQlEXWSt8UKrnILfdVjh62ZW3/j9O31Ta3y2adrpOgdiVnDkn3rk3A
	iegjSg4rZRAKDztoNgV7Wf5NvE8fGaKOuyt1v1xsghqSX1kZn/1HSdtivz7ICA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747387147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hkh99/Lh8jC9qqdfdjd/YQLCiq8mACt3rhDU5rbTjos=;
	b=Qa6VwUlmbapZ86msQ3EKKaE2tjJW8FOG8KAtkYk8L+QP8LXEI7sJyara1fnCsZjZ/BAt09
	LaSNnX4yiFS0rkDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/debug] x86/tracing, x86/mm: Remove redundant trace_pagefault_key
Cc: Nam Cao <namcao@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Gabriele Monaco <gmonaco@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C827c7666d2989f08742a4fb869b1ed5bfaaf1dbf=2E17470?=
 =?utf-8?q?46848=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C827c7666d2989f08742a4fb869b1ed5bfaaf1dbf=2E174704?=
 =?utf-8?q?6848=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738714638.406.10419366957003478787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/debug branch of tip:

Commit-ID:     d49ae4172cffa51cc72bdbd668fdd2e64b0a929f
Gitweb:        https://git.kernel.org/tip/d49ae4172cffa51cc72bdbd668fdd2e64b0a929f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 12 May 2025 12:50:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:13:59 +02:00

x86/tracing, x86/mm: Remove redundant trace_pagefault_key

trace_pagefault_key is used to optimize the pagefault tracepoints when it
is disabled. However, tracepoints already have built-in static_key for this
exact purpose.

Remove this redundant key.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/827c7666d2989f08742a4fb869b1ed5bfaaf1dbf.1747046848.git.namcao@linutronix.de
---
 arch/x86/include/asm/trace/common.h      | 12 ------------
 arch/x86/include/asm/trace/exceptions.h  | 18 ++++++------------
 arch/x86/include/asm/trace/irq_vectors.h |  1 -
 arch/x86/kernel/Makefile                 |  1 -
 arch/x86/kernel/tracepoint.c             | 21 ---------------------
 arch/x86/mm/fault.c                      |  3 ---
 6 files changed, 6 insertions(+), 50 deletions(-)
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
deleted file mode 100644
index f0f9bcd..0000000
--- a/arch/x86/include/asm/trace/common.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_TRACE_COMMON_H
-#define _ASM_TRACE_COMMON_H
-
-#ifdef CONFIG_TRACING
-DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
-#define trace_pagefault_enabled()			\
-	static_branch_unlikely(&trace_pagefault_key)
-#else
-static inline bool trace_pagefault_enabled(void) { return false; }
-#endif
-
-#endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 6b1e871..34bc821 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -6,10 +6,6 @@
 #define _TRACE_PAGE_FAULT_H
 
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
-
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
 
 DECLARE_EVENT_CLASS(x86_exceptions,
 
@@ -34,15 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
 
-#define DEFINE_PAGE_FAULT_EVENT(name)				\
-DEFINE_EVENT_FN(x86_exceptions, name,				\
-	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
-		 unsigned long error_code),			\
-	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+DEFINE_EVENT(x86_exceptions, page_fault_user,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
+	TP_ARGS(address, regs, error_code));
 
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_EVENT(x86_exceptions, page_fault_kernel,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
+	TP_ARGS(address, regs, error_code));
 
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 88e7f0f..7408beb 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -6,7 +6,6 @@
 #define _TRACE_IRQ_VECTORS_H
 
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 84cfa17..99a783f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -141,7 +141,6 @@ obj-$(CONFIG_OF)			+= devicetree.o
 obj-$(CONFIG_UPROBES)			+= uprobes.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
-obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
 
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
deleted file mode 100644
index 03ae1ca..0000000
--- a/arch/x86/kernel/tracepoint.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- */
-#include <linux/jump_label.h>
-#include <linux/atomic.h>
-
-#include <asm/trace/exceptions.h>
-
-DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
-
-int trace_pagefault_reg(void)
-{
-	static_branch_inc(&trace_pagefault_key);
-	return 0;
-}
-
-void trace_pagefault_unreg(void)
-{
-	static_branch_dec(&trace_pagefault_key);
-}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294..7e3e51f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1455,9 +1455,6 @@ static __always_inline void
 trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 			 unsigned long address)
 {
-	if (!trace_pagefault_enabled())
-		return;
-
 	if (user_mode(regs))
 		trace_page_fault_user(address, regs, error_code);
 	else
