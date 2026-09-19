Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8242368D40
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789789101; cv=none; b=GEwooQ4nqSGY51wxYBvx/Lp+hMMpuJ49DTJynoRMHRK3WRQBywSWmDcBFrRH3TnNBdg6E9l+kualLSjoD4d6cOPH+dVKosCTmPykJ3CeQQjmtr8w2kroC9YfwJ0FlgjPHeV7+P7Lscvp7ifEija07OMb1r4r8qWhd0ljNMqVe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789789101; c=relaxed/simple;
	bh=X8heIndhjaL0J1x4VNQ8WUV230+MNuFvnt8ZppdQL0s=;
	h=To:Date:Mime-Version:In-Reply-To:Content-Type:Cc:Message-Id:
	 References:From:Subject; b=Wqbkpp7d81Ta5mWnHOu9GW8FjUP5ebYMqWIfdTQoHgmMOvKObKV0NI6+NWjiV6E3A4r6z0aAF37q7yx42Xli+V9iqZJEkoBerX/e7f9XcBehSnJxSKBivYlkhWkwvqkvEoQE/XHxmn7/k5qjg125OQCdDlqLk6WlDjTQkKee0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PGTbCAW3; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PGTbCAW3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789789094; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=W8TBtJ6IM0md7XKM9TP3O7DHtc171bBY9OmQaBcVFCE=;
 b=PGTbCAW35qyxcV9R1LO8ShDtOsRomtefiAAZDmkg91ttmLOf5mkL2VWkLz5IR0RcZBffy/
 f6lFI51BT2EyvxdSADsrMat261lG2l9vmJ4kdAQ5KsRTmOPNEULHZqg5z/Q/iSyWOHYT1h
 87DyTCmxYtvpAQac0OZ0QmPficJlro5n0RQ4863JJfPbFSR9Lij2egFp+MaQTBJkiw0NrT
 8lP7FmvmjVPPaBlSfuHzwgp9h1HXnTPJDUiR2vmV3DybG1vGwwEJQsRc4S6gxr8q0WJNAe
 rkF9pttzyzsc63vkdRDgOSOX5ZgAT1qtBI9RoPQXLmY/sCedOYkfKvQXoaqPLw==
To: <rostedt@goodmis.org>
Date: Sat, 19 Sep 2026 11:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260919033726.1361382-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Cc: "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	=?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
	"Chunyan Zhang" <zhangchunyan@iscas.ac.cn>, 
	"Guo Ren" <guoren@kernel.org>, "Jiakai Xu" <xujiakai2025@iscas.ac.cn>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley" <pjw@kernel.org>, 
	"Song Shuai" <suagrfillet@gmail.com>
Message-Id: <20260919033726.1361382-3-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26aae03a4+8d6af0+vger.kernel.org+qirui.001@bytedance.com>
References: <20260919033726.1361382-1-qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH 2/2] riscv: ftrace: Use frame CFA for function graph retp
X-Original-From: Rui Qi <qirui.001@bytedance.com>

RISC-V dynamic function graph tracing currently uses &fregs->ra for two
different purposes. As the parent argument, it is the temporary slot where
ftrace_caller saved the incoming ra. Reading that slot and replacing it
with return_to_handler is correct, because ftrace_caller reloads the slot
into the hardware ra register before returning to the traced function.

It is wrong to save the same address as the function graph retp. The retp
is not used to patch the return address later; ftrace_graph_ret_addr()
uses it as a lookup key for the shadow stack entry. Once ftrace_caller
returns, its temporary fregs frame is gone. Later stack unwinding finds
return_to_handler in the traced function's own frame, so the unwinder
cannot match a key that points back into the vanished ftrace_caller frame.

This also breaks function_get_true_parent_ip(), which looks up the
original parent with ftrace_regs_get_stack_pointer(fregs). On RISC-V that
is the saved entry SP, not &fregs->ra, so ftrace_graph_ret_addr() cannot
match the graph return entry.

Use the frame CFA as the RISC-V graph retp identity instead. The static
_mcount path derives it from &frame->ra, the dynamic ftrace path uses the
saved entry SP, and the frame-pointer unwinder uses the same CFA when
recovering graph return addresses.

Fixes: 35e61e8827ee ("riscv: ftrace: Make function graph use ftrace directly")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/riscv/kernel/ftrace.c     | 10 ++++++++--
 arch/riscv/kernel/stacktrace.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index be8b68514417..faad2608216f 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -229,11 +229,16 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * Most of this function is copied from arm64.
+ *
+ * Use the frame CFA as the RISC-V graph return address identity: static
+ * _mcount derives it from &frame->ra, dynamic ftrace uses the saved entry
+ * SP, and the unwinder tracks the same value when walking frame records.
  */
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long *retp = parent + 1;
 	unsigned long old;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
@@ -245,7 +250,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	if (!function_graph_enter(old, self_addr, frame_pointer, parent))
+	if (!function_graph_enter(old, self_addr, frame_pointer, retp))
 		*parent = return_hooker;
 }
 
@@ -256,6 +261,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long frame_pointer = arch_ftrace_regs(fregs)->s0;
 	unsigned long *parent = &arch_ftrace_regs(fregs)->ra;
+	unsigned long *retp = (unsigned long *)arch_ftrace_regs(fregs)->sp;
 	unsigned long old;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
@@ -267,7 +273,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	 */
 	old = *parent;
 
-	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
+	if (!function_graph_enter_regs(old, ip, frame_pointer, retp, fregs))
 		*parent = return_hooker;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index c7555447149b..96fb7d29ebb1 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -88,7 +88,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = READ_ONCE_TASK_STACK(task, frame->fp);
 			pc = READ_ONCE_TASK_STACK(task, frame->ra);
 			pc = ftrace_graph_ret_addr(task, &graph_idx, pc,
-						   &frame->ra);
+						   (unsigned long *)sp);
 			if (pc >= (unsigned long)handle_exception &&
 			    pc < (unsigned long)&ret_from_exception_end) {
 				if (unlikely(!fn(arg, pc)))
-- 
2.20.1
