Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1084A3E;
	Sun,  6 Jul 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815123; cv=none; b=pNhwdnS+Erh13zC63Gw8TZHlyPvlL8++rkAxqbH1YBqfwRajPxw6EiCqOQ7Mb81sGUoVNvk0ltGxBm2bP1lfKX+KA85KjDbbaHdCMXZdlc9sD/1KmQY7CQQoJdwrQ8LzlyzRwp0sEB8NY3c97Mm1UquCM1M4ljc+JM9uF9l7GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815123; c=relaxed/simple;
	bh=Z5dcsW2E2sUGFUJrRZn+3+E/PElClbLY/N4iXjMQSnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdlnSEnxQVcmD/w/kmVtIDLRqDM7Z8oMMauxnzfxlgT1lxCeCvjcaj/mY0hP5odwJ7nGGuLJA3X6kyrUnO/g/pfi0Jt1LXSOp1r+7Tpu5MYGMRuLyFJoucqDGY8WHtPgzg8N2rG9vskq+xgwq09M0/fcy+YH3akBZdZky/Llc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LteRMYhP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LteRMYhP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74264d1832eso2846505b3a.0;
        Sun, 06 Jul 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751815121; x=1752419921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCqosLuhec2W+iwynZpu/8Y5fuUpkpILe0aDY0KpexE=;
        b=LteRMYhPGEW2OLlYfGKTDjP08f5EtXwiTPGzFTHGxoBXJCTwkXc7MI66dwhjrj/2Et
         2oNm8cwWyVR5pUnlkgHBkoutwGN3/suRpMBJpBA+DLDgniA8gWCPTNG3l1U32W0qadpf
         Mcd0aRbTkvPuXaY6IH3j9seaeC2Awg9HWDdK5LmE0+xEFsBcnfRNQ9eQFuaENA0kXyNc
         Zhhp6CtSVF37lKe1ARNkiS6F5rC4w4QkkIAE25jCNthzouiOqXDvvHvto9FFZvhtpriy
         jt2xgW07oyJGfZWXnmHd9UDaweQkCYi6iuelS+VEcUE6L04L38/FnoIT23OJaFqUFmc3
         TX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751815121; x=1752419921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCqosLuhec2W+iwynZpu/8Y5fuUpkpILe0aDY0KpexE=;
        b=il8+kox2pYDH9CKa70D4Ba8nDYCNPzuNBiVTRIxDxKloORefTVpaIDWUuWHidtPC1t
         BIQDSH7YUjub9+wEl26BjvNyT2aohuEZ8lKkscF5cl8xLMk6AG7xwRQssI6Vy+mJSxIv
         WoCHvOwPYfwzjmWc+eINQm7Nd+HPPpsDP3/ijurp86smkINxY5k8B/oK9eGhKI76SH+D
         QaqELxt3JFgVcHW58HmCCEuxQrHVCeDbekA5nCe4t8sVOlV1H8ZAZpcnBMNmiMprh7dD
         QAsPfn83aHTRwXWIDIwQ+se4Ov2Vyf4b8+dRC14IE2YxYeZGccsY1dHC55mU30Ct/Psa
         X4rw==
X-Forwarded-Encrypted: i=1; AJvYcCWEphHfcrI/MOjrNZZ4lz04VPrm9hcL6BoJLK9ERzjDaQ9FFnj8ymfmiCVqBHm2yo5W6FEc44r5TJTm/a4=@vger.kernel.org, AJvYcCXKCguCaedTQptQ8vOQ+2DTQ1xyaDRfd6ccoPccem5WvzWWSfe8MRc6JS4y1RktXjrhXnZljH1dT4lBJGO+Tz31Y/Zy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpCc3+mgN0xEePs1WGLEP+1piLk7CRoHVGS2TQxJvd1uyu/Gi
	yYxBg93JteZj9InF7rQ7CxBU6555uSWoTBqBwz/ngiYkl1O8uGxuPefy
X-Gm-Gg: ASbGncskG5suecadw8fm//3Hqn5mBwMcn+UGomlTX6KxPo0eJSo6eXb+O2BA57eAS2V
	iasbV9KI0QMxfQXnTvG/IshTQI1tTWtMGw06ZUyUMzizyVB5wH0EKZAEuhQ3b1VOJ8lK/ianmJl
	XnUHN/vyyoEB/W9kW3SalPCK2mqok2dsieHTkfWPvl3UNQBfmBXxjbvtaoDVwRxLywJOx3bQ2+I
	4xDSwRL+ESgNOtVN+Hm4CSFUEa53aAu1TuaK+hPEg78UDiC8rP31HcNaqlJLcXSqf4aJGiTPPTo
	jfEWSm0o0i/D5GGtk4kaJ7Aoni+yM2DwnZLa+dc1H29M9MDNqfYs/PeEMquvMCmnT7jvbg7P/WJ
	UusvK51wXLz53yxs=
X-Google-Smtp-Source: AGHT+IEuNyg5wg2uEYQiKX26qznL1a/gfk1kf7ARm7d8ubEkj7znQK7RV03GfMUVt/eoSnnILswtxw==
X-Received: by 2002:a05:6a20:7f89:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-2260c2401efmr15618923637.25.1751815120662;
        Sun, 06 Jul 2025 08:18:40 -0700 (PDT)
Received: from nyaos.. (v133-18-109-250.vir.kagoya.net. [133.18.109.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42b8044sm6942761b3a.143.2025.07.06.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 08:18:40 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux RISCV <linux-riscv@lists.infradead.org>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE selection
Date: Sun,  6 Jul 2025 15:18:28 +0000
Message-ID: <20250706151830.25091-1-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

V1: The first version mainly involves modifications to the
configuration of the dynamic ftracer.

Link https://lore.kernel.org/all/f7e12c6d-892e-4ca3-9ef0-fbb524d04a48@ghiti.fr/

V2: After a series of discussions, Steven concluded that only
supporting the dynamic ftracer would suffice. Alex also pointed
out that if only the dynamic ftracer needs to be supported, the
code related to the static ftracer would become obsolete and
turn into dead code. He had already done some preliminary work on this.

Based on this, the modifications to the configuration were made,
and the dead code generated by the ftracer
(originally related to the static ftracer) was also removed.

Link https://lore.kernel.org/all/20250703115222.2d7c8cd5@batman.local.home/
Link https://github.com/linux-riscv/linux/pull/556/commits/0481092a5bec3818658981c11f629e06e66382b3

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/riscv/Kconfig              |  3 +-
 arch/riscv/include/asm/ftrace.h |  3 --
 arch/riscv/kernel/ftrace.c      | 11 +-----
 arch/riscv/kernel/mcount.S      | 64 ---------------------------------
 kernel/trace/Kconfig            |  2 +-
 5 files changed, 4 insertions(+), 79 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..95d24b19c466 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,8 +97,9 @@ config RISCV
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
+	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select EDAC_SUPPORT
-	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
+	select FRAME_POINTER if PERF_EVENTS
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ARCH_TOPOLOGY
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 22ebea3c2b26..77ddb6dce0a8 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -49,7 +49,6 @@ struct dyn_arch_ftrace {
 };
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * A general call in RISC-V is a pair of insts:
  * 1) auipc: setting high-20 pc-related bits to ra register
@@ -237,6 +236,4 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4c6c24380cfd..93bad646d233 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -13,7 +13,6 @@
 #include <asm/cacheflush.h>
 #include <asm/text-patching.h>
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
@@ -191,13 +190,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return 0;
 }
 
-#else /* CONFIG_DYNAMIC_FTRACE */
-unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	return addr;
-}
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
@@ -236,7 +228,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 		*parent = return_hooker;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
@@ -257,5 +248,5 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
 		*parent = return_hooker;
 }
-#endif /* CONFIG_DYNAMIC_FTRACE */
+
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index da4a4000e57e..bb550c15f1c9 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -14,13 +14,6 @@
 
 	.text
 
-	.macro SAVE_ABI_STATE
-	addi	sp, sp, -16
-	REG_S	s0, 0*SZREG(sp)
-	REG_S	ra, 1*SZREG(sp)
-	addi	s0, sp, 16
-	.endm
-
 	/*
 	 * The call to ftrace_return_to_handler would overwrite the return
 	 * register if a0 was not saved.
@@ -34,12 +27,6 @@
 	addi	s0, sp, FREGS_SIZE_ON_STACK
 	.endm
 
-	.macro RESTORE_ABI_STATE
-	REG_L	ra, 1*SZREG(sp)
-	REG_L	s0, 0*SZREG(sp)
-	addi	sp, sp, 16
-	.endm
-
 	.macro RESTORE_RET_ABI_STATE
 	REG_L	ra, FREGS_RA(sp)
 	REG_L	s0, FREGS_S0(sp)
@@ -49,10 +36,8 @@
 	.endm
 
 SYM_TYPED_FUNC_START(ftrace_stub)
-#ifdef CONFIG_DYNAMIC_FTRACE
        .global _mcount
        .set    _mcount, ftrace_stub
-#endif
 	ret
 SYM_FUNC_END(ftrace_stub)
 
@@ -79,53 +64,4 @@ SYM_FUNC_START(return_to_handler)
 SYM_FUNC_END(return_to_handler)
 #endif
 
-#ifndef CONFIG_DYNAMIC_FTRACE
-SYM_FUNC_START(_mcount)
-	la	t4, ftrace_stub
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	la	t0, ftrace_graph_return
-	REG_L	t1, 0(t0)
-	bne	t1, t4, .Ldo_ftrace_graph_caller
-
-	la	t3, ftrace_graph_entry
-	REG_L	t2, 0(t3)
-	la	t6, ftrace_graph_entry_stub
-	bne	t2, t6, .Ldo_ftrace_graph_caller
-#endif
-	la	t3, ftrace_trace_function
-	REG_L	t5, 0(t3)
-	bne	t5, t4, .Ldo_trace
-	ret
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-/*
- * A pseudo representation for the function graph tracer:
- * prepare_to_return(&ra_to_caller_of_caller, ra_to_caller)
- */
-.Ldo_ftrace_graph_caller:
-	addi	a0, s0, -SZREG
-	mv	a1, ra
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	REG_L	a2, -2*SZREG(s0)
-#endif
-	SAVE_ABI_STATE
-	call	prepare_ftrace_return
-	RESTORE_ABI_STATE
-	ret
-#endif
-
-/*
- * A pseudo representation for the function tracer:
- * (*ftrace_trace_function)(ra_to_caller, ra_to_caller_of_caller)
- */
-.Ldo_trace:
-	REG_L	a1, -SZREG(s0)
-	mv	a0, ra
-
-	SAVE_ABI_STATE
-	jalr	t5
-	RESTORE_ABI_STATE
-	ret
-SYM_FUNC_END(_mcount)
-#endif
 EXPORT_SYMBOL(_mcount)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..28afc6941e7a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -275,7 +275,7 @@ config FUNCTION_TRACE_ARGS
 	  funcgraph-args (for the function graph tracer)
 
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y

base-commit: fda589c286040d9ba2d72a0eaf0a13945fc48026
-- 
2.45.2

