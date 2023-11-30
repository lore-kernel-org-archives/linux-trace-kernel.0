Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4245949
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9oL32ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E23C43391;
	Thu, 30 Nov 2023 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701346554;
	bh=svHjq6BTZhzzPhI8kj7ht+r5VyVLRJaN4ub31HCJx4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9oL32ff+QkFBx3i3fH0/0mtKAmFM0CH0F0ufNbYTBbEiCG/7ylFsb3GKTmfh8VNy
	 rRMKrEoXB0cvPPfEql1QxbXKdPachSTbTMH9wqFnvEYGIAm5stSZbLzDOM/hs+7zt0
	 se/LW52xooEzYPnnLdH1QjeQ81/wdImJNsH0qFfzJTcK+HNxDEwlflYUIL2a1gdsPt
	 nT8EK1rshSQQgviG62rvN5WDVxzkuKjjr+RoOCzSsVW/kMk/XdKkF+F1eAE3AROh0L
	 8f9Tf7L/UYygK9dBMWYE4yzeJtFSJqvI5TL2QM3dDPSfGzP4+4vDQXMWfx0AW0BsTF
	 sQl5p+GNdog6g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Song Shuai <suagrfillet@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	songshuaishuai@tinylab.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v12 for-next 3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
Date: Thu, 30 Nov 2023 13:15:30 +0100
Message-Id: <20231130121531.1178502-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
References: <20231130121531.1178502-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Song Shuai <suagrfillet@gmail.com>

Select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
register_ftrace_direct[_multi] interfaces allowing users to register
the customed trampoline (direct_caller) as the mcount for one or more
target functions. And modify_ftrace_direct[_multi] are also provided
for modifying direct_caller.

To make the direct_caller and the other ftrace hooks (e.g.
function/fgraph tracer, k[ret]probes) co-exist, a temporary register
is nominated to store the address of direct_caller in
ftrace_regs_caller. After the setting of the address direct_caller by
direct_ops->func and the RESTORE_REGS in ftrace_regs_caller,
direct_caller will be jumped to by the `jr` inst.

Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69c95e42be9f..4684cdc754a0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -114,6 +114,7 @@ config RISCV
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index b383926f73be..329172122952 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -135,6 +135,13 @@ struct ftrace_regs;
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+static inline void __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+		regs->t1 = addr;
+}
+#define arch_ftrace_set_direct_caller(fregs, addr) \
+	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index c902a7ddb310..b7ce001779c1 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -229,6 +229,7 @@ SYM_FUNC_END(ftrace_caller)
 
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 SYM_FUNC_START(ftrace_regs_caller)
+	mv	t1, zero
 	SAVE_ABI_REGS 1
 	PREPARE_ARGS
 
@@ -236,7 +237,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
 	RESTORE_ABI_REGS 1
+	bnez	t1, .Ldirect
 	jr	t0
+.Ldirect:
+	jr	t1
 SYM_FUNC_END(ftrace_regs_caller)
 
 SYM_FUNC_START(ftrace_caller)
@@ -250,3 +254,9 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	jr	t0
 SYM_FUNC_END(ftrace_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	jr	t0
+SYM_CODE_END(ftrace_stub_direct_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
-- 
2.40.1

