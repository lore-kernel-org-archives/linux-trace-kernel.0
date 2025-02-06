Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63E1DF24B;
	Thu,  6 Feb 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845209; cv=none; b=lSSkYhu8z7ojYBYYZ6ljOug41UHtAiJ0STJt44rY1K5igFbGsQW2eIfxhI3u9GQJR3UOVZGH3rB91Z8t+AMQUXFGXydP02UOzQ9wn1gxqvBlQEfUqgFa95FC++2Ee92R5+P48vRlrcOh9AS31GBa8FtQjmezvCRT1B8/Li++0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845209; c=relaxed/simple;
	bh=VS3+/ltfODxJOEvI5TWa+1K83w8cilcFbj/cV/YLREg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pikDu/tV6r/3bUTO7qRAiYGJhpVxryjMIBuxeBDhEvQ23qRYNMg6OWRmo+lM83Cp6MF3HmuRee+/DVmexUTTfdAZh7vc5eag3Gvo5Pj4VBLNaUO+P8v5215W5hFVl/fxvGHCV23Lt59R3R03fwmekDdYkUV7kuvbPyrvd17hnA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DyHL76O9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DyHL76O9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RAnW4IvmuyMbXuvVXckxL3B43H4dovck5Gy8dGUFYkU=; b=DyHL76O9ovG7/dcqFdwyV0pZyx
	yjacHaCzH3kYim+Q0MFGJS+KbsYe0Ij5Om9fgUOzG0QSXpbOdawhZUwVtWKmHyBzSKux2RuhnFLo2
	ekaN2WGVuIqP0tcQsWofv8IBN/8FHT1WvDkwbQl5mqerkJrwW4weba/UNixjW2oHaHmKoFSuT2P3p
	QBmkjZrvQGlT/sy5z1UFzBRjWjbCIljlT+hN7YjSXAS0nBlXAZJaqxYv0/UEHlmfYRVBTH369BSuU
	df2OHhT6/EopfTvK4uXm0uTpNQg8tNMnOUWTV4DUQ4TmkVYUDc+SwFJk/kz8wXvSndsfQvk4mGuR1
	UNvzN4VA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tg147-0000000Gvn7-2L6h;
	Thu, 06 Feb 2025 12:33:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2348D300318; Thu,  6 Feb 2025 13:33:07 +0100 (CET)
Date: Thu, 6 Feb 2025 13:33:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriel de Perthuis <g2p.code@gmail.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250206123307.GO7145@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206121328.GN7145@noisy.programming.kicks-ass.net>

On Thu, Feb 06, 2025 at 01:13:28PM +0100, Peter Zijlstra wrote:

> No, it just cleans up this utter trainwreck. I also noticed this is a
> second (new) copy of this garbage. Clearly I didn't yell loud enough
> last time and people didn't think to vomit when doing the copy/paste :/
> 
> Function will look something like:
> 
> unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> {
> 	if (is_endbr(fentry_ip - ENDBR_INSN_SIZE))
> 		fentry_op -= ENDBR_INSN_SIZE;
> 	return fentry_ip;
> }
> 
> Let me finish local build test before I push out.

Bah, still waiting for a LLVM build, but patch should be here:

git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt

I was supposed to merge this last cycle, but then akpm shat all over
arch/x86/kernel/alternative.c and we had to clean that up :/

Notably, this patch, not sure it applies out of order.

---

Subject: x86/ibt: Clean up is_endbr()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 27 09:58:06 CET 2023

Pretty much every caller of is_endbr() actually wants to test something at an
address and ends up doing get_kernel_nofault(). Fold the lot into a more
convenient helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/core.c         |    2 +-
 arch/x86/include/asm/ftrace.h  |   17 +++--------------
 arch/x86/include/asm/ibt.h     |    5 +++--
 arch/x86/kernel/alternative.c  |   20 ++++++++++++++------
 arch/x86/kernel/kprobes/core.c |   11 +----------
 arch/x86/net/bpf_jit_comp.c    |    4 ++--
 kernel/trace/bpf_trace.c       |   20 +++-----------------
 7 files changed, 27 insertions(+), 52 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2857,7 +2857,7 @@ static bool is_uprobe_at_func_entry(stru
 		return true;
 
 	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
 		return true;
 
 	return false;
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_FTRACE_H
 #define _ASM_X86_FTRACE_H
 
+#include "asm/ibt.h"
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_FUNCTION_TRACER
@@ -36,21 +37,9 @@ static inline unsigned long ftrace_call_
 
 static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 {
-#ifdef CONFIG_X86_KERNEL_IBT
-	u32 instr;
+	if (is_endbr((void*)(fentry_ip - ENDBR_INSN_SIZE)))
+		fentry_ip -= ENDBENDBR_INSN_SIZE;
 
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
-		fentry_ip -= ENDBR_INSN_SIZE;
-#endif
 	return fentry_ip;
 }
 #define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static __always_inline __attribute_const
 	return 0x001f0f66; /* osp nopl (%rax) */
 }
 
-static inline bool is_endbr(u32 val)
+static inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
@@ -74,6 +74,7 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr bool is_endbr(u32 *val);
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
@@ -98,7 +99,7 @@ extern __noendbr void ibt_restore(u64 sa
 
 #define __noendbr
 
-static inline bool is_endbr(u32 val) { return false; }
+static inline bool is_endbr(u32 *val) { return false; }
 
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -852,16 +852,24 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+__noendbr bool is_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return __is_endbr(endbr);
+
+Efault:
+	return false;
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
-	u32 endbr, poison = gen_endbr_poison();
-
-	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
-		return;
+	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(endbr)) {
+	if (!is_endbr(addr)) {
 		WARN_ON_ONCE(warn);
 		return;
 	}
@@ -984,7 +992,7 @@ static u32  cfi_seed __ro_after_init;
 static u32 cfi_rehash(u32 hash)
 {
 	hash ^= cfi_seed;
-	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+	while (unlikely(__is_endbr(hash) || __is_endbr(-hash))) {
 		bool lsb = hash & 1;
 		hash >>= 1;
 		if (lsb)
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,16 +373,7 @@ static bool can_probe(unsigned long padd
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	u32 insn;
-
-	/*
-	 * Since 'addr' is not guaranteed to be safe to access, use
-	 * copy_from_kernel_nofault() to read the instruction:
-	 */
-	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
-		return NULL;
-
-	if (is_endbr(insn)) {
+	if (is_endbr((u32 *)addr)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -641,7 +641,7 @@ int bpf_arch_text_poke(void *ip, enum bp
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
 	 * with an ENDBR instruction.
 	 */
-	if (is_endbr(*(u32 *)ip))
+	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
@@ -3036,7 +3036,7 @@ static int __arch_prepare_bpf_trampoline
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		if (is_endbr(*(u32 *)orig_call))
+		if (is_endbr(orig_call))
 			orig_call += ENDBR_INSN_SIZE;
 		orig_call += X86_PATCH_SIZE;
 	}
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1038,27 +1038,13 @@ static const struct bpf_func_proto bpf_g
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-#ifdef CONFIG_X86_KERNEL_IBT
-static unsigned long get_entry_ip(unsigned long fentry_ip)
+static inline unsigned long get_entry_ip(unsigned long fentry_ip)
 {
-	u32 instr;
-
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
+	if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
 		fentry_ip -= ENDBR_INSN_SIZE;
+
 	return fentry_ip;
 }
-#else
-#define get_entry_ip(fentry_ip) fentry_ip
-#endif
 
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {

