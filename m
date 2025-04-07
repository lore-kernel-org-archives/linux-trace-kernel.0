Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736D21ADB2;
	Mon,  7 Apr 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049384; cv=none; b=T6/rSlKVgj9oGSBJ4sBjklhvy/a6TRFR9/P8A6WYF9ax52VrUWDvtkRipgopl3Ge5opvxPYXMGMGM8/v6/3FmnXJ5kFe+hwwR75jAaq3mGxW/Xb8NY9+fFrpypT9UZwKy6VL0+dDHxroeAAkCGdIxkCoBAD3zWpWeWR/0AYFv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049384; c=relaxed/simple;
	bh=yzArtyPxZSS6GVIuO0YpKR5/sQ/VpUyx8sq86u0YSE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nar7L1Fczqjfo4jnnXX8hAEL7G7UzYofc2WyypXPys0zkQlje9/NZXpFdv1MRM1BXgl+OKRzaznM9fE/B6Y6mCUXgow6mp2IbeRsYWxzdXRNJ5naW/fny5V0qglbMnBP+G1pS5c4W4rKwmw1BtOo+hSeEL3R5vhMTgcx6zqRH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7X8V+uR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7X8V+uR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso51376985ad.2;
        Mon, 07 Apr 2025 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049382; x=1744654182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2v6JJ+fSgP+xTItzSnoMH89G4xsdIkyOOxFB456+1Q=;
        b=j7X8V+uRvK0gtPhHhOwzOyLEDBYURUqOw5q7eGq3k3VffqgYAaSaETXpiMV02PvGm3
         2xF9uXtrlbGPj541sYQskCPe1tA6T3rZFSEAO73yyLvXf+T4lYPNHhFBKv7glOFFuolW
         AzEHTi2xqY1yWFLAWDZHVT7FlNdNCLLlPBIx7UIhoJYa+LJ3UA4Ew6rSOO4gUayJC1Az
         n4aDy73c6jAZkdYh7bmYghjEDZUzs4RYDTxLSpw6njF3+NEGVGdCBeNwZflKU26+lryH
         pGL56+FSjr64u37N/gcFmTMvMnZGvOI6zndpF2RaOzFfdM+keuMsjC1e0VkFuX95rNG0
         XpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049382; x=1744654182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2v6JJ+fSgP+xTItzSnoMH89G4xsdIkyOOxFB456+1Q=;
        b=IxPSoUIxj6iJvhpg4AiSc0XWBvNEdzDWwSCYB2wBCfgFDBNDZ9KKvxCwJuFTQGAsYm
         +h9O2QmWUklnowYovX3E0vqHivwMGgEaA4RYNF3BvBf9FSJXoIzSrWgtuWeQ9SPDRbtb
         B8XCClG5xlyWaDcNiM9BDmM25l4lRoCarHBPNJNXngOSHLlyxdYrx5IdvfRwbreY+pLt
         LmzDwPQP783ISAshbPOngObGA0HrahvuyGe9ttTB25HgIVeUdYl/LZprzLmTqFHcb/74
         dyQ4xa2KjNPGBxU6LCewycgxX+PjlZYCvALQ8ivUXJNQc0YxEnOLooQy6+dNYhEt9Q7G
         M/nA==
X-Forwarded-Encrypted: i=1; AJvYcCUIDIAkSgOV55g1FExe7OxmeCtWRtyTmHMCbIY+MtlB2ULrVEEVCrTPllEAzicFoBlt7A22oQL27yQpZVg=@vger.kernel.org, AJvYcCWp5nnbKnSNzcP1CCqSw/cfdR7af5DS8/EyJ6W84K85RyWOJD3ih4mtiH9I9BLiuqq5Nr0+hvBfFbIXyZ/3ExsfFKZt@vger.kernel.org
X-Gm-Message-State: AOJu0YxhT5wGhRCPH6vxiD0XopNE+3oJSug4TCQOM5O4XY06gFkZCL/s
	dS0gfjKzscehprlnHKgKgQajntAYksMnuPzKZEax4H5ELvJcrrqP
X-Gm-Gg: ASbGncuYzoMcHjY2bzCNL9u02AWvkaWCqH+RAoSwOC2jra3kY5pvAGaEo0bAunAMWfl
	qK+yQ4RF4TtOaGbW+HksvZrSO5z0AYmcM/LIYHQs3vZrTNUMMANAqHcBKkU+96DVMxqIeiX+WjQ
	bsjAc/JbYwcs847akhZHpjC/1TuG6q+4M+pRKtvHXRbDQHJXhZL1Xbqv72sN51bwllSz4mU7VYr
	lKnHl2KXIwFBRRa2M8Yh07uUK9hNHtmiW7AI47CjVnrYmJx6pRyC3cdGxHCe/FOGynHMvqTe2aD
	NSZgLjGUPQmA/Tn6dCJVVqSy29qUq/sBOVDE9HVr+WAw1hpgX5oN2m4auDeOBfqfu/8y1alc75v
	N0DtWGiJIn6pPUD+hVrELR7UiW0ntneP3Dw==
X-Google-Smtp-Source: AGHT+IF0udAYv5YxmJjouLsOvzvtc+Qr6BlHLnxA7et5jBerKapGPE4rwrJM9iedDZmRKfzeHULDtQ==
X-Received: by 2002:a17:903:1665:b0:223:35cb:e421 with SMTP id d9443c01a7336-22a955a19e8mr145567285ad.49.1744049381669;
        Mon, 07 Apr 2025 11:09:41 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.09.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:09:41 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andybnac@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Rutland <mark.rutland@arm.com>,
	puranjay12@gmail.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vicent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH v4 11/12] riscv: ftrace: support direct call using call_ops
Date: Tue,  8 Apr 2025 02:08:35 +0800
Message-Id: <20250407180838.42877-11-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

jump to FTRACE_ADDR if distance is out of reach

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
Changelog v4:
 - New patch since v4
 - Include Björn's fix for kprobe (adjusting ftrace address with
   MCOUNT_INSN_SIZE)
 - Clean out an unused variable
---
 arch/riscv/Kconfig              |  2 +-
 arch/riscv/include/asm/ftrace.h |  6 ++++
 arch/riscv/kernel/asm-offsets.c |  3 ++
 arch/riscv/kernel/ftrace.c      | 13 ++++-----
 arch/riscv/kernel/mcount-dyn.S  | 51 +++++++++++++++++++++------------
 5 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ec986c9120e3..8fdca6345fa3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -152,7 +152,7 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select FUNCTION_ALIGNMENT_4B if HAVE_DYNAMIC_FTRACE && RISCV_ISA_C
-	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS if HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 6a5c0a7fb826..22ebea3c2b26 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -130,6 +130,9 @@ struct __arch_ftrace_regs {
 	unsigned long sp;
 	unsigned long s0;
 	unsigned long t1;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long direct_tramp;
+#endif
 	union {
 		unsigned long args[8];
 		struct {
@@ -223,10 +226,13 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
 	arch_ftrace_regs(fregs)->t1 = addr;
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 2d96197a8abf..b26334075697 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -495,6 +495,9 @@ void asm_offsets(void)
 	OFFSET(STACKFRAME_RA, stackframe, ra);
 #ifdef CONFIG_FUNCTION_TRACER
 	DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 30bcf60135d8..d65f06bfb457 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -16,7 +16,7 @@
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
-		return addr + 8;
+		return addr + 8 + MCOUNT_AUIPC_SIZE;
 
 	return addr + MCOUNT_AUIPC_SIZE;
 }
@@ -83,10 +83,9 @@ static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrace *rec)
 	return ops;
 }
 
-static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
-			      const struct ftrace_ops *ops)
+static int ftrace_rec_set_ops(const struct dyn_ftrace *rec, const struct ftrace_ops *ops)
 {
-	unsigned long literal = rec->ip - 8;
+	unsigned long literal = ALIGN_DOWN(rec->ip - 12, 8);
 
 	return patch_text_nosync((void *)literal, &ops, sizeof(ops));
 }
@@ -117,7 +116,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	orig_addr = (unsigned long)&ftrace_caller;
 	distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
 	if (distance > JALR_RANGE)
-		return -EINVAL;
+		addr = FTRACE_ADDR;
 
 	return __ftrace_modify_call(pc, addr, false);
 }
@@ -199,15 +198,13 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
 	unsigned long caller = rec->ip - MCOUNT_AUIPC_SIZE;
-	unsigned int call[2];
 	int ret;
 
-	make_call_t0(caller, old_addr, call);
 	ret = ftrace_rec_update_ops(rec);
 	if (ret)
 		return ret;
 
-	return __ftrace_modify_call(caller, addr, true);
+	return __ftrace_modify_call(caller, FTRACE_ADDR, true);
 }
 #endif
 
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 699684eea7f0..48f6c4f7dca0 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -82,12 +82,9 @@
 *                       +++++++++
 **/
 	.macro SAVE_ABI_REGS
-	mv	t4, sp			// Save original SP in T4
 	addi	sp, sp, -FREGS_SIZE_ON_STACK
-
 	REG_S	t0,  FREGS_EPC(sp)
 	REG_S	x1,  FREGS_RA(sp)
-	REG_S	t4,  FREGS_SP(sp)	// Put original SP on stack
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	REG_S	x8,  FREGS_S0(sp)
 #endif
@@ -108,9 +105,12 @@
 	REG_S	x15, FREGS_A5(sp)
 	REG_S	x16, FREGS_A6(sp)
 	REG_S	x17, FREGS_A7(sp)
+	mv	a0, sp
+	addi	a0, a0, FREGS_SIZE_ON_STACK
+	REG_S	a0, FREGS_SP(sp)	// Put original SP on stack
 	.endm
 
-	.macro RESTORE_ABI_REGS, all=0
+	.macro RESTORE_ABI_REGS
 	REG_L	t0, FREGS_EPC(sp)
 	REG_L	x1, FREGS_RA(sp)
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
@@ -139,6 +139,19 @@
 
 	.macro PREPARE_ARGS
 	addi	a0, t0, -MCOUNT_JALR_SIZE	// ip (callsite's jalr insn)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	mv 	a1, ra				// parent_ip
+	REG_L   a2, -16(t0)			// op
+	REG_L   ra, FTRACE_OPS_FUNC(a2)		// op->func
+#else
+	la	a1, function_trace_op
+	REG_L	a2, 0(a1)			// op
+	mv	a1, ra				// parent_ip
+#endif
+	mv	a3, sp				// regs
+	.endm
+
+SYM_FUNC_START(ftrace_caller)
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
 	/*
 	 * When CALL_OPS is enabled (2 or 4) nops [8B] are placed before the
@@ -158,19 +171,17 @@
 	 * t0 is set to ip+8 after the jalr is executed at the callsite,
 	 * so we find the associated op at t0-16.
 	 */
-	mv 	a1, ra				// parent_ip
-	REG_L   a2, -16(t0)			// op
-	REG_L   ra, FTRACE_OPS_FUNC(a2)		// op->func
-#else
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)			// op
-	mv	a1, ra				// parent_ip
-#endif
-	mv	a3, sp				// regs
-	.endm
+	REG_L	t1, -16(t0) // op Should be SZ_REG instead of 16
 
-SYM_FUNC_START(ftrace_caller)
-	mv	t1, zero
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * If the op has a direct call, handle it immediately without
+	 * saving/restoring registers.
+	 */
+	REG_L	t1, FTRACE_OPS_DIRECT_CALL(t1)
+	bnez	t1, ftrace_caller_direct
+#endif
+#endif
 	SAVE_ABI_REGS
 	PREPARE_ARGS
 
@@ -182,10 +193,14 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	jalr	ra, 0(ra)
 #endif
 	RESTORE_ABI_REGS
-	bnez	t1, .Ldirect
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	bnez	t1, ftrace_caller_direct
+#endif
 	jr	t0
-.Ldirect:
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_INNER_LABEL(ftrace_caller_direct, SYM_L_LOCAL)
 	jr	t1
+#endif
 SYM_FUNC_END(ftrace_caller)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-- 
2.39.3 (Apple Git-145)

