Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592972D1F60;
	Tue, 29 Apr 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928103; cv=none; b=YggeE4eo3F/UHqEwXLcdlDykYC0F+VT70bZ5c4PnImDZNCQjkPs8annLPk6bgYOvBk+qVI2fqo+WP3gO9DD7RNacsxAyp/GDgEuAWW4kAsj1nPB/QD25lGhOiVi6o/HJeu6P2aH5yhFMm+g8XwW3H2t7pY28koqy/LCdQYEHkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928103; c=relaxed/simple;
	bh=ERsSHF6cveMP56swmamcYhe2qaD2zoqTzJM+wQ07ysg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OlkBcsctXxjiitZHaSN3d/wdg+3CSHwFA84msIrSqKDv4FTy1SEU7MzgnM8aSC3z2qIU9bzhVWelifVdVFlaGzr15t+zG8lBrjWl73bVeWl/VFPNqT1ZrZfqcCXKq4hEAwb+e8BvRPb4uhwCVHg9wMiXCFMJwslpddsqDsHr13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijQW8H6R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6jz0lIly; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijQW8H6R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6jz0lIly"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPn4Z3qJtGRDNuo4zQemDZcbXpzyUcw6dR3h1cNGvUo=;
	b=ijQW8H6RuYMpdkhSKnwnR38U8/5Xiw2DfjqTF3S5NrJ2P7w9Cm58e6WWqOFLNGA9moXBY1
	2fEpnOyoQj5PiyLEaOIfG7crOVpnkXUpUqYOV69oEJXcb2lssRd7Othpj+t4bEzYL5sEzC
	9QbFV1aBGRXFnziSpFVd8oVb4ukSDMCzBUOogpX3YZurSrb5P6INGamS7P0QuTOR3nvUI9
	7/yV+IasYY6viWhLezwy+kOFSB+s5lxT5WAFKqbYE/UdUACiktN5rcbU1yLkjFaKGvc/4e
	YWzsnptDOIn/Oi6wCQJmXKTOJG1iUah7Q4tiel1ebqvSgpP/gaPNZ1pUvFzVng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPn4Z3qJtGRDNuo4zQemDZcbXpzyUcw6dR3h1cNGvUo=;
	b=6jz0lIlyqbw8VU9poZQneS4CxrX9aAXztEa24kN4OalGIRD4yQcfxh/9HgwIkHn7aWfqq6
	GcE7I9vA2GKl1cDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 15/23] x86/tracing: Remove redundant trace_pagefault_key
Date: Tue, 29 Apr 2025 14:01:00 +0200
Message-Id: <c73668e917883f8dd3e47037a1d0d25a9a7ee69b.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

trace_pagefault_key is used to optimize the pagefault tracepoints when it
is disabled. However, tracepoints already have built-in static_key for this
exact purpose.

Remove this redundant key.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/tra=
ce/common.h
deleted file mode 100644
index f0f9bcdb74d9..000000000000
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
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm=
/trace/exceptions.h
index 6b1e87194809..34bc8214a2d7 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -6,10 +6,6 @@
 #define _TRACE_PAGE_FAULT_H
=20
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
-
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
=20
 DECLARE_EVENT_CLASS(x86_exceptions,
=20
@@ -34,15 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
=20
-#define DEFINE_PAGE_FAULT_EVENT(name)				\
-DEFINE_EVENT_FN(x86_exceptions, name,				\
-	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
-		 unsigned long error_code),			\
-	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+DEFINE_EVENT(x86_exceptions, page_fault_user,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
+	TP_ARGS(address, regs, error_code));
=20
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_EVENT(x86_exceptions, page_fault_kernel,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
+	TP_ARGS(address, regs, error_code));
=20
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/as=
m/trace/irq_vectors.h
index 88e7f0f3bf62..7408bebdfde0 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -6,7 +6,6 @@
 #define _TRACE_IRQ_VECTORS_H
=20
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
=20
 #ifdef CONFIG_X86_LOCAL_APIC
=20
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eb..e8e33ec684ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,7 +139,6 @@ obj-$(CONFIG_OF)			+=3D devicetree.o
 obj-$(CONFIG_UPROBES)			+=3D uprobes.o
=20
 obj-$(CONFIG_PERF_EVENTS)		+=3D perf_regs.o
-obj-$(CONFIG_TRACING)			+=3D tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+=3D itmt.o
 obj-$(CONFIG_X86_UMIP)			+=3D umip.o
=20
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
deleted file mode 100644
index 03ae1caaa878..000000000000
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
index 296d294142c8..7e3e51fa1f95 100644
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
--=20
2.39.5

