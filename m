Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360113D899;
	Wed, 27 Nov 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728606; cv=none; b=K0MzDOLrdNw1Yn8Sj9/8x82YuVN1/e0BGFa7Qz+gKzfkzqmD2LpqWv5kgoxXMWXkxbEOBPmDFJ7yiLO42E+54NvKegSNd4Wfvi/W+hErHb9FyIQo5kI3yeZbY5wZloSBf+soTbqVFBtyXy15ZW7+9qkeOStHjILR/qdaGYxCvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728606; c=relaxed/simple;
	bh=ycDrQrX8gZHEUT0jV8doyx6zCNX6hRoiZ/fYCbDs2vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TOEuEw7Cs7VqH5rFBQN70kZSEgE50kYiyXVyZq7PZ9XOV9luUAI1esVn6+bwUoU0I/Z0p7WBlAkZExFdym6vB0D9eAu0LorkBUqE/JUBDRiYO6QZHUimSOpay/vSIHkrIpuEYkuQS0MdDpwgDjo6n0VpHxNSN9+kYIkcCERnMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkCamA2m; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkCamA2m"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d4fceec9aso1651668a34.3;
        Wed, 27 Nov 2024 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728603; x=1733333403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IR7fJnOIGqt6b1nWAQZJYrqcHCadpu+itzDI+rPODg=;
        b=CkCamA2mA7cVEDeWY7M7kty9ev1sHPUGKUqEOBSLPPaiAEFnM3FGHtT5sWvi6+weMv
         y9IdfvqmRISNq71d6ObmZb4UTke0pIMHuCAIzxHCsTIcJ4aKu4auViFhEUPOCWkf0bVv
         WyNrbNBqsIbW4WIdii6KbkFAZc2lTpiPASEPKXr6QaLjH97yX1AG099f45PzTRFVtBDw
         3SgAcRxBA/au+eU/Pnvt89S5/A8SQSpnreRHqwZVsJrrFb3MHIVwmyPsmeIj079FhfeY
         W3mSknNYWA56JY8wdqlJx0WQZE/+S1OmyiQU0qh4xzyfzgKJ8XVYBmr4e0ybm8Rna9NI
         ueLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728603; x=1733333403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IR7fJnOIGqt6b1nWAQZJYrqcHCadpu+itzDI+rPODg=;
        b=XCQYuYPDv6cXt+Cuj1Us9A9y0yPgLzKHNZwR0fLL7B4fueS+xbCwiYE5sCraoDPNjd
         2wWVNnp7ZNDkHhR3JegvaXRXOFPoelmk8DGiUWx/GA82qQupsbZK6qx1YhcvLrbe08IQ
         JYTS8z2UCfcmPx2MnC50JXXcKxnED6/YpNd11kitVQYvZL60osxmPTuUzpMl4MRekfDo
         0tNc0SF7i5GkmWh0WE0cOJYedeo27qnVXba9p/Jd+dhKshQ9gwOeAM+RIu6bfxdhuUuR
         uBCSmvpyG8bJrydbiQXlvsJKZIHp3aNnzpb9jLYSjoyt3SiYLGgimasTCoWZVfT0Qngb
         YpKA==
X-Forwarded-Encrypted: i=1; AJvYcCWzFaAhokSWAtILxyt9Meh5mVLYhy9kLHpWj2IyS7kvZixNjN4g+hmtKzguxbIz78NxBM0tJUfPg72GT3yUABZdjug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yLH3BQhOlMFEHUmpRv1bGYzGOkEtbgEeqwiSKfTyx6CSL5Uu
	bCbdAP67eMWVbWnDYFJ1R7Cb3CILLOEmlCexfPdBC62FGuLefmNCTVgChbyD
X-Gm-Gg: ASbGncsQhCU7wSPpASqX7g+QbJYw3ozUr7c4QCaj8oF4kNETAH/Jt4AL81UdQnNggEq
	kz8yo7afHBKnrHG2u65uHmguk+4eBczfr0HNtOpZcOrnnK0dJO2FweA2yAwbaHdFbl6UU2F3DVP
	hR7bzLmYyO0MA2dwFsrg6OturtmE7zZ5a8y3SWSOXeoAfFeQX853bc8uRGepiQzIjKwk5tEFWxX
	X1hoJGs9TZXtCvmmU7MFN3jvyaO0TGXul9y9Kx1wdONhaMBrRo1gPqxlIUpDHInOmFOEd7sXegY
	XuUDzjvyhsaqlHQ+ImaGS2k+PlnE
X-Google-Smtp-Source: AGHT+IHruXTFUTfiaojyTMlhAizY2Drw8OyNcxeu1vFbTUarM1m1Pec3RyTRvOVVRoAzScO0flWjxQ==
X-Received: by 2002:a05:6830:6e90:b0:71d:4bd9:8b98 with SMTP id 46e09a7af769-71d65d07e94mr4292715a34.25.1732728603299;
        Wed, 27 Nov 2024 09:30:03 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.29.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:30:02 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 3/7] riscv: ftrace: prepare ftrace for atomic code patching
Date: Thu, 28 Nov 2024 01:29:04 +0800
Message-Id: <20241127172908.17149-4-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

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
 arch/riscv/include/asm/ftrace.h |  4 ++
 arch/riscv/kernel/ftrace.c      | 80 +++++++++++++++++++++------------
 arch/riscv/kernel/mcount-dyn.S  |  9 ++--
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 4ca7ce7f34d7..36734d285aad 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -80,6 +80,7 @@ struct dyn_arch_ftrace {
 #define JALR_T0			(0x000282e7)
 #define AUIPC_T0		(0x00000297)
 #define NOP4			(0x00000013)
+#define JALR_RANGE		(JALR_SIGN_MASK - 1)
 
 #define to_jalr_t0(offset)						\
 	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
@@ -117,6 +118,9 @@ do {									\
  * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
  */
 #define MCOUNT_INSN_SIZE 8
+#define MCOUNT_AUIPC_SIZE	4
+#define MCOUNT_JALR_SIZE	4
+#define MCOUNT_NOP4_SIZE	4
 
 #ifndef __ASSEMBLY__
 struct dyn_ftrace;
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4b95c574fd04..5ebe412280ef 100644
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
@@ -114,21 +136,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
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
@@ -182,7 +206,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call(caller, addr, true, false);
+	return __ftrace_modify_call(caller, addr, true);
 }
 #endif
 
@@ -217,17 +241,17 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
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
2.39.3 (Apple Git-145)

