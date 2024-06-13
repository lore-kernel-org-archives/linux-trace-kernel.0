Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56B13D25B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263982; cv=none; b=dB4mSw0V8009TgzPFjnbi5OW86LxWemhg4OGQNjSry0Wwy8z/rE4RxdHUlvE9zr8V0tjQL9ZHXNJaiFmFq12rS0DX4sqDV59jVyS9qOZfoDWBC89svgjG+N58b406U6o37H0QmdDFghuGpn5YqL7yRBBBpEb+FRL/lZnINgBmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263982; c=relaxed/simple;
	bh=tupMDt20s7S7PlhgqDhuVkvtJDEBbx3ofqpMD3PiZ2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/uvXeKYOtEmhPFtUyPhXkziuZuB7L/LRs5MshCUEmyRbNOnSS5H3l3Zw4npoZd9SpxfGm/IlnPqvy+eSfXk29bMJEntuhNLnr9yr7qQeFoMMS7e1FJkKtwgwkHuYJoEz/zxPcdmpOEJMHHaEZN9a+5ZuOh5pP9bmkxHbSpnzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FcdI8T+8; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FcdI8T+8"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d24a231342so39139b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263980; x=1718868780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpwccXm6VSga0glYezh9Lcoo9mdtNlokYTZmh5MRn+k=;
        b=FcdI8T+80T80YU+ZQFMin0zapvV8rJZJ2673hnqQVSA4yfnH1wF0GtzLY8GFUjI5wn
         /Qop6ysDY0Zyfbm85odiJJy4DZIlxifiGdy6t8H1cXs6dcBTxvpzG7PMOtqlmyZmkxv/
         FrB5urjcZktyYh4CpHURWCGNhGcAYVelDTQIPJEczdYfsHt2Kv4ReyGb9Lk6QrIhYR46
         1B+1HZlKu0Iae80el5r4j50aFXDJ2zqEP9gv1PqO3T4qH/NNAEm4Ydx6A0tIMfaG881F
         ad3IleVEHQ8Qlqq1kTnptM1NBfnjp9PPRzGLn9ozRW7EDuIiO3yytScnlxIVIyDGXGcl
         V3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263980; x=1718868780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpwccXm6VSga0glYezh9Lcoo9mdtNlokYTZmh5MRn+k=;
        b=By0otqn5YsvAzfzPJK0/t75t5KjQEaoNMELJj/K4p0XOoEauvr6cUV2Vf9+0CtuuYq
         uBWWFTDKE5AT9hQ81LqSZkpAFk9TISJMezw6ZUlKNRTojuGEyPggMGFudv/o1mBAKkSj
         xSORf2D2j81TcZmICB3coaprQ/r1SgCx7z/q+05qoueU6yhjbxBpnjTMgBQvfgkHNI+o
         3j/5oDYGz/Pj9LfBN7dmafyk2GVDY4+BdYTHdfUr0O27Mt8j2xiMicgTDLU02dOzEy5F
         i5QpLzWTQNrtKM+miRiEe0VWDeVhwKRoQExpxMP3WhcQpqfEiASiU9UM64Kbo33XrYfl
         Nbfw==
X-Forwarded-Encrypted: i=1; AJvYcCUu3dCBYpy1984Dq2gES7k6tgv92uowqqsItoX3KTcbyOkzCW2sUqS9aW2Yr/S/Z7+viUHZjxqzlYppb8t/WZFIB3FxfpqbGUmRHTIuEBZNkt5H
X-Gm-Message-State: AOJu0YzFNoT+43stexaPYfZ+JtGVUNut4ozIzcpeXBtpZ5puGHxdp4/I
	+KrkLLt/7BWvKKJ9GTlQxOgwn39i8aOozf68VRy+b3oFEeHIn2ETj5rKVvfqk0g=
X-Google-Smtp-Source: AGHT+IEzkbVgn0G1G4t0BzOnoC4MTfTDVP2Z/BlOjvozamyY5nqFEfSfIU6N3LGNo64kZ62JzW5oRQ==
X-Received: by 2002:a05:6808:1a24:b0:3d2:4a08:2c99 with SMTP id 5614622812f47-3d24a0832b0mr183168b6e.23.1718263979694;
        Thu, 13 Jun 2024 00:32:59 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:59 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:10 +0800
Subject: [PATCH 5/8] riscv: ftrace: prepare ftrace for atomic code patching
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-5-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
instruction fetch can break down to 4 byte at a time, it is impossible
to update two instructions without a race. In order to mitigate it, we
initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
patching can change NOP4 to JALR to eable/disable ftrcae from a
function. This limits the reach of each ftrace entry to +-2KB displacing
from ftrace_caller.

Starting from the trampoline, we add a level of indirection for it to
reach ftrace caller target. Now, it loads the target address from a
memory location, then perform the jump. This enable the kernel to update
the target atomically.

The ordering of reading/updating the targert address should be guarded
by generic ftrace code, where it sends smp_rmb ipi.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/ftrace.h |  4 +++
 arch/riscv/kernel/ftrace.c      | 80 ++++++++++++++++++++++++++---------------
 arch/riscv/kernel/mcount-dyn.S  |  9 +++--
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 5f81c53dbfd9..7199383f8c02 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -81,6 +81,7 @@ struct dyn_arch_ftrace {
 #define JALR_T0			(0x000282e7)
 #define AUIPC_T0		(0x00000297)
 #define NOP4			(0x00000013)
+#define JALR_RANGE		(JALR_SIGN_MASK - 1)
 
 #define to_jalr_t0(offset)						\
 	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
@@ -118,6 +119,9 @@ do {									\
  * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
  */
 #define MCOUNT_INSN_SIZE 8
+#define MCOUNT_AUIPC_SIZE	4
+#define MCOUNT_JALR_SIZE	4
+#define MCOUNT_NOP4_SIZE	4
 
 #ifndef __ASSEMBLY__
 struct dyn_ftrace;
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 87cbd86576b2..f3b09f2d3ecc 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -64,42 +64,64 @@ static int ftrace_check_current_call(unsigned long hook_pos,
 	return 0;
 }
 
-static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
-				bool enable, bool ra)
+static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target, bool validate)
 {
 	unsigned int call[2];
-	unsigned int nops[2] = {NOP4, NOP4};
+	unsigned int replaced[2];
+
+	make_call_t0(hook_pos, target, call);
 
-	if (ra)
-		make_call_ra(hook_pos, target, call);
-	else
-		make_call_t0(hook_pos, target, call);
+	if (validate) {
+		/*
+		 * Read the text we want to modify;
+		 * return must be -EFAULT on read error
+		 */
+		if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
+					     MCOUNT_INSN_SIZE))
+			return -EFAULT;
+
+		if (replaced[0] != call[0]) {
+			pr_err("%p: expected (%08x) but got (%08x)\n",
+			       (void *)hook_pos, call[0], replaced[0]);
+			return -EINVAL;
+		}
+	}
 
-	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
+	/* Replace the jalr at once. Return -EPERM on write error. */
+	if (patch_insn_write((void *)(hook_pos + MCOUNT_AUIPC_SIZE), call + 1, MCOUNT_JALR_SIZE))
 		return -EPERM;
 
 	return 0;
 }
 
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+static int __ftrace_modify_call_site(ftrace_func_t *hook_pos, ftrace_func_t target, bool enable)
 {
-	unsigned int call[2];
+	ftrace_func_t call = target;
+	ftrace_func_t nops = &ftrace_stub;
 
-	make_call_t0(rec->ip, addr, call);
-
-	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
-		return -EPERM;
+	WRITE_ONCE(*hook_pos, enable ? call : nops);
 
 	return 0;
 }
 
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long distance, orig_addr;
+
+	orig_addr = (unsigned long)&ftrace_caller;
+	distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
+	if (distance > JALR_RANGE)
+		return -EINVAL;
+
+	return __ftrace_modify_call(rec->ip, addr, false);
+}
+
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned int nops[2] = {NOP4, NOP4};
+	unsigned int nops[1] = {NOP4};
 
-	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)(rec->ip + MCOUNT_AUIPC_SIZE), nops, MCOUNT_NOP4_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -114,10 +136,14 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
  */
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
+	unsigned int nops[2];
 	int out;
 
+	make_call_t0(rec->ip, &ftrace_caller, nops);
+	nops[1] = NOP4;
+
 	mutex_lock(&text_mutex);
-	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+	out = patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE);
 	mutex_unlock(&text_mutex);
 
 	if (!mod)
@@ -126,12 +152,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	return out;
 }
 
+ftrace_func_t ftrace_call_dest = ftrace_stub;
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
-				       (unsigned long)func, true, true);
-
-	return ret;
+	return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
 }
 
 struct ftrace_modify_param {
@@ -185,7 +209,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call(caller, addr, true, false);
+	return __ftrace_modify_call(caller, addr, true);
 }
 #endif
 
@@ -220,17 +244,17 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
 }
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
-extern void ftrace_graph_call(void);
+ftrace_func_t ftrace_graph_call_dest = ftrace_stub;
 int ftrace_enable_ftrace_graph_caller(void)
 {
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true, true);
+	return __ftrace_modify_call_site(&ftrace_graph_call_dest,
+					 &prepare_ftrace_return, true);
 }
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false, true);
+	return __ftrace_modify_call_site(&ftrace_graph_call_dest,
+					 &prepare_ftrace_return, false);
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index e988bd26b28b..bc06e8ab81cf 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -162,7 +162,8 @@ SYM_FUNC_START(ftrace_caller)
 	mv	a3, sp
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
+	REG_L	ra, ftrace_call_dest
+	jalr	0(ra)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	addi	a0, sp, ABI_RA
@@ -172,7 +173,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	mv	a2, s0
 #endif
 SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
-	call	ftrace_stub
+	REG_L	ra, ftrace_graph_call_dest
+	jalr	0(ra)
 #endif
 	RESTORE_ABI
 	jr	t0
@@ -185,7 +187,8 @@ SYM_FUNC_START(ftrace_caller)
 	PREPARE_ARGS
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
+	REG_L	ra, ftrace_call_dest
+	jalr	0(ra)
 
 	RESTORE_ABI_REGS
 	bnez	t1, .Ldirect

-- 
2.43.0

