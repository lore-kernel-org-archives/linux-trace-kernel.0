Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F521ADA2;
	Mon,  7 Apr 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049378; cv=none; b=FKPlCZF3ml8bo5d37s/97Y6UvfWR4g88cdCsCn6mipSwJDoEjLdRFn3R1IVB7HGTVt00ltFVglgqQjMc1iZDBcIxNjXqfROytNAYdRLfh5xVW2oydFl1fiJgjyhBbD8PfSZJkkXDd98EI6myn/+IW96oLUU3jDDipcC12xBz5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049378; c=relaxed/simple;
	bh=hnxRJfp+RtyuopBYKja1S752sf1+Gn5EWzDmLBjymm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAsmsIv7hnRQBPIWtlIOY8Nwkr2H1NIqwzb/tn6kLMoL/KOo+RU560bbF4gh/Hlk/jwooWTejQYcl1CwNM3wQ5o7jiq3x/R8PxutgHRiJA2TrgJcyEMaib4S9eg0aRq5iXHlPgbBTrwEWsPscPYkAWT8aJ6HFnzGLe3d1pLYYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwLW+jC+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwLW+jC+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2260c91576aso38997935ad.3;
        Mon, 07 Apr 2025 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049376; x=1744654176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03hAqsb3oBHKPV8p492vgGmxv28jGgXuCxUxhKcZY88=;
        b=MwLW+jC+OuM7PVb5F+bYYTvZ4OAPC2MkIhuG53/tqUAg3zD8ASRmYKO8DfXsAykOyj
         cAIlghTRIjJXFtYEQ1uBtOWNrhwkxbjwpny4cenOjzCieSp4rT0MdVQj4rY7Uh9K0IM9
         St0HlmpTc5JdBVWocR9ybBRrzRiEaA3D1eaxC4vDZ1zOCXqmh6pC+w6XZ4P/YaG8p1HI
         A4k/U1xHMIclcfDEKzI8HyfXPENLD8Njimxl8JxO0yZA/IC2eeedfcQcLwQovaGW/tud
         Qmn50H1nCQi0n5vHpKfufnu2A43V8CP1/vp9H4quaoHMhPWTZchXYcWts/tOPwUL7n4o
         teHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049376; x=1744654176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03hAqsb3oBHKPV8p492vgGmxv28jGgXuCxUxhKcZY88=;
        b=gEJx/T2vFdW18Q0EWL66pSvHt8NJVzpAQqETi2nnXJM2or+F8wIxUhWSGPN3yF9Wv8
         gh7o5thvlPCTtzDvrFsLXo5vagxuM5dSgKkVAvjUjJugv/tgHXZUEBozObWSflKa2PqK
         XE96NXzE8z9MLDh5JQN5BYO+uYTKOwPLGAnnIsBtHbMlM0txglHJ+G6RE40S7ns4WEhe
         ZEG/QzZJGSIVoBM88vpmfpf3jkipkMeHthMzERj/fJ5GYiNl0Q77w/Flxbtq9d5L+oz7
         oRtYDcPBENXUD8uFhM67QW6PE9OCHsLiFirI9rf9t3aF0NLAG2ZxAJHTTH80mzuBvR+X
         ia9w==
X-Forwarded-Encrypted: i=1; AJvYcCV4y3dSWc7M5Hw6JbSflWJb1/tb5i3Tuxa5/j8ETntbm71kTrvJsLRgdf12hWPepdL6gADg2kHCL9k9XXVEaiLpxNOr@vger.kernel.org, AJvYcCXv3MFgjdHznl2HAacnwEEz9t4UNbXL8+d+ENJJhoouksuTgFTVpCUo1qryz0wp+57k6ODKzdTbbwM5xzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAKYnG5SUPaZcdvages4k6J5iEsBb9oTwbffQkqGxjDa1Jcpu
	/OxFNAZlw1AJYcsYzMuq2LxfPA6K9PRNHO8OW9CN5QtS2QmBp39h
X-Gm-Gg: ASbGncscXZq4Lfl7lT3VTnhG6e5YrIOqt0pYYJk3OAQ5J/ry3Zn/mRBnMpN4kQ2Pb/7
	eiy8RhCLScj0BoX6eQkRgQDeo9QSEpmMwZlpAO24vRjMWm+fPHEIeT53EIyn81vWbH5d4yLuPrJ
	62qrlYv2mcEvanBy0REvcA5DozexKp8OYGeGqMOdNX7OdwuT9BRpUil3f/U72dpjmNYWV8sPdB7
	WELfmYMjMpCghYGCvWhfI2XUlesLh9wqFkkX7CPgpRTL1mkN79aH6h9PNIvr+ut2pw6gBqE1PV9
	ZRmfFmEpkr3/BoV72J4l85b3PPW07VfmZoxBmNy6zR7zYTxARxB8EiC8RZQtF/pa74oDTW7hV6+
	nd7pQ4dhu9VRXIoIF/2LXonfrrpgwx5tRFw==
X-Google-Smtp-Source: AGHT+IFyGAlxdHGG370vb/DIpO+e45DzeZTKqsr/viKkGC6+OYzxqciYF2p6d0343L0+h7DTNjZrcg==
X-Received: by 2002:a17:902:d4cd:b0:224:e33:889b with SMTP id d9443c01a7336-22a8a05a433mr185510495ad.12.1744049375896;
        Mon, 07 Apr 2025 11:09:35 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:09:35 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 10/12] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Date: Tue,  8 Apr 2025 02:08:34 +0800
Message-Id: <20250407180838.42877-10-andybnac@gmail.com>
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

From: Puranjay Mohan <puranjay12@gmail.com>

This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
This allows each ftrace callsite to provide an ftrace_ops to the common
ftrace trampoline, allowing each callsite to invoke distinct tracer
functions without the need to fall back to list processing or to
allocate custom trampolines for each callsite. This significantly speeds
up cases where multiple distinct trace functions are used and callsites
are mostly traced by a single tracer.

The idea and most of the implementation is taken from the ARM64's
implementation of the same feature. The idea is to place a pointer to
the ftrace_ops as a literal at a fixed offset from the function entry
point, which can be recovered by the common ftrace trampoline.

We use -fpatchable-function-entry to reserve 8 bytes above the function
entry by emitting 2 4 byte or 4 2 byte  nops depending on the presence of
CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a pointer
to the associated ftrace_ops for that callsite. Functions are aligned to
8 bytes to make sure that the accesses to this literal are atomic.

This approach allows for directly invoking ftrace_ops::func even for
ftrace_ops which are dynamically-allocated (or part of a module),
without going via ftrace_ops_list_func.

We've benchamrked this with the ftrace_ops sample module on Spacemit K1
Jupiter:

Without this patch:

baseline (Linux rivos 6.14.0-09584-g7d06015d936c #3 SMP Sat Mar 29
+-----------------------+-----------------+----------------------------+
|  Number of tracers    | Total time (ns) | Per-call average time      |
|-----------------------+-----------------+----------------------------|
| Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
|----------+------------+-----------------+------------+---------------|
|        0 |          0 |        1357958 |          13 |             - |
|        0 |          1 |        1302375 |          13 |             - |
|        0 |          2 |        1302375 |          13 |             - |
|        0 |         10 |        1379084 |          13 |             - |
|        0 |        100 |        1302458 |          13 |             - |
|        0 |        200 |        1302333 |          13 |             - |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |       13677833 |         136 |           123 |
|        1 |          1 |       18500916 |         185 |           172 |
|        1 |          2 |       22856459 |         228 |           215 |
|        1 |         10 |       58824709 |         588 |           575 |
|        1 |        100 |      505141584 |        5051 |          5038 |
|        1 |        200 |     1580473126 |       15804 |         15791 |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |       13561000 |         135 |           122 |
|        2 |          0 |       19707292 |         197 |           184 |
|       10 |          0 |       67774750 |         677 |           664 |
|      100 |          0 |      714123125 |        7141 |          7128 |
|      200 |          0 |     1918065668 |       19180 |         19167 |
+----------+------------+-----------------+------------+---------------+

Note: per-call overhead is estimated relative to the baseline case with
0 relevant tracers and 0 irrelevant tracers.

With this patch:

v4-rc4 (Linux rivos 6.14.0-09598-gd75747611c93 #4 SMP Sat Mar 29
+-----------------------+-----------------+----------------------------+
|  Number of tracers    | Total time (ns) | Per-call average time      |
|-----------------------+-----------------+----------------------------|
| Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
|----------+------------+-----------------+------------+---------------|
|        0 |          0 |         1459917 |         14 |             - |
|        0 |          1 |         1408000 |         14 |             - |
|        0 |          2 |         1383792 |         13 |             - |
|        0 |         10 |         1430709 |         14 |             - |
|        0 |        100 |         1383791 |         13 |             - |
|        0 |        200 |         1383750 |         13 |             - |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |         5238041 |         52 |            38 |
|        1 |          1 |         5228542 |         52 |            38 |
|        1 |          2 |         5325917 |         53 |            40 |
|        1 |         10 |         5299667 |         52 |            38 |
|        1 |        100 |         5245250 |         52 |            39 |
|        1 |        200 |         5238459 |         52 |            39 |
|----------+------------+-----------------+------------+---------------|
|        1 |          0 |         5239083 |         52 |            38 |
|        2 |          0 |        19449417 |        194 |           181 |
|       10 |          0 |        67718584 |        677 |           663 |
|      100 |          0 |       709840708 |       7098 |          7085 |
|      200 |          0 |      2203580626 |      22035 |         22022 |
+----------+------------+-----------------+------------+---------------+

Note: per-call overhead is estimated relative to the baseline case with
0 relevant tracers and 0 irrelevant tracers.

As can be seen from the above:

 a) Whenever there is a single relevant tracer function associated with a
    tracee, the overhead of invoking the tracer is constant, and does not
    scale with the number of tracers which are *not* associated with that
    tracee.

 b) The overhead for a single relevant tracer has dropped to ~1/3 of the
    overhead prior to this series (from 122ns to 38ns). This is largely
    due to permitting calls to dynamically-allocated ftrace_ops without
    going through ftrace_ops_list_func.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

[update kconfig, asm, refactor]

Signed-off-by: Andy Chiu <andybnac@gmail.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
Changelog v4:
 - include benchmark result from a real hardware, shout-out to Björn!
 - new patch copy from Puranjay's RFC implementation
 - Drop code related to !WITH_ARG && DYNAMIC_FTRACE
---
 arch/riscv/Kconfig              |  2 +
 arch/riscv/Makefile             |  4 +-
 arch/riscv/kernel/asm-offsets.c |  3 ++
 arch/riscv/kernel/ftrace.c      | 67 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/mcount-dyn.S  | 35 +++++++++++++++--
 5 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index dc0fc11b6e96..ec986c9120e3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -99,6 +99,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
+	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
@@ -152,6 +153,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select FUNCTION_ALIGNMENT_4B if HAVE_DYNAMIC_FTRACE && RISCV_ISA_C
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 539d2aef5cab..df57654a615e 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -15,9 +15,9 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 ifeq ($(CONFIG_RISCV_ISA_C),y)
-	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=8,4
 else
-	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
 endif
 endif
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 7c43c8e26ae7..2d96197a8abf 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -493,6 +493,9 @@ void asm_offsets(void)
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
 	OFFSET(STACKFRAME_FP, stackframe, fp);
 	OFFSET(STACKFRAME_RA, stackframe, ra);
+#ifdef CONFIG_FUNCTION_TRACER
+	DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
+#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct __arch_ftrace_regs), STACK_ALIGN));
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index aca1a322e0aa..30bcf60135d8 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -15,6 +15,9 @@
 
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return addr + 8;
+
 	return addr + MCOUNT_AUIPC_SIZE;
 }
 
@@ -64,9 +67,52 @@ static int __ftrace_modify_call(unsigned long source, unsigned long target, bool
 	return 0;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrace *rec)
+{
+	const struct ftrace_ops *ops = NULL;
+
+	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
+		ops = ftrace_find_unique_ops(rec);
+		WARN_ON_ONCE(!ops);
+	}
+
+	if (!ops)
+		ops = &ftrace_list_ops;
+
+	return ops;
+}
+
+static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
+			      const struct ftrace_ops *ops)
+{
+	unsigned long literal = rec->ip - 8;
+
+	return patch_text_nosync((void *)literal, &ops, sizeof(ops));
+}
+
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
+}
+
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
+{
+	return ftrace_rec_set_ops(rec, riscv64_rec_get_ops(rec));
+}
+#else
+static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
+static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
+#endif
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long distance, orig_addr, pc = rec->ip - MCOUNT_AUIPC_SIZE;
+	int ret;
+
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
 
 	orig_addr = (unsigned long)&ftrace_caller;
 	distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
@@ -79,6 +125,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
 	u32 nop4 = RISCV_INSN_NOP4;
+	int ret;
+
+	ret = ftrace_rec_set_nop_ops(rec);
+	if (ret)
+		return ret;
 
 	if (patch_insn_write((void *)rec->ip, &nop4, MCOUNT_NOP4_SIZE))
 		return -EPERM;
@@ -99,6 +150,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	unsigned int nops[2], offset;
 	int ret;
 
+	ret = ftrace_rec_set_nop_ops(rec);
+	if (ret)
+		return ret;
+
 	offset = (unsigned long) &ftrace_caller - pc;
 	nops[0] = to_auipc_t0(offset);
 	nops[1] = RISCV_INSN_NOP4;
@@ -113,6 +168,13 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 ftrace_func_t ftrace_call_dest = ftrace_stub;
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
+	/*
+	 * When using CALL_OPS, the function to call is associated with the
+	 * call site, and we don't have a global function pointer to update.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return 0;
+
 	WRITE_ONCE(ftrace_call_dest, func);
 	/*
 	 * The data fence ensure that the update to ftrace_call_dest happens
@@ -138,8 +200,13 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 {
 	unsigned long caller = rec->ip - MCOUNT_AUIPC_SIZE;
 	unsigned int call[2];
+	int ret;
 
 	make_call_t0(caller, old_addr, call);
+	ret = ftrace_rec_update_ops(rec);
+	if (ret)
+		return ret;
+
 	return __ftrace_modify_call(caller, addr, true);
 }
 #endif
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 8aa554d56096..699684eea7f0 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -139,10 +139,34 @@
 
 	.macro PREPARE_ARGS
 	addi	a0, t0, -MCOUNT_JALR_SIZE	// ip (callsite's jalr insn)
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	/*
+	 * When CALL_OPS is enabled (2 or 4) nops [8B] are placed before the
+	 * function entry, these are later overwritten with the pointer to the
+	 * associated struct ftrace_ops.
+	 *
+	 * -8: &ftrace_ops of the associated tracer function.
+	 *<ftrace enable>:
+	 *  0: auipc  t0/ra, 0x?
+	 *  4: jalr   t0/ra, ?(t0/ra)
+	 *
+	 * -8: &ftrace_nop_ops
+	 *<ftrace disable>:
+	 *  0: nop
+	 *  4: nop
+	 *
+	 * t0 is set to ip+8 after the jalr is executed at the callsite,
+	 * so we find the associated op at t0-16.
+	 */
+	mv 	a1, ra				// parent_ip
+	REG_L   a2, -16(t0)			// op
+	REG_L   ra, FTRACE_OPS_FUNC(a2)		// op->func
+#else
 	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	mv	a1, ra
-	mv	a3, sp
+	REG_L	a2, 0(a1)			// op
+	mv	a1, ra				// parent_ip
+#endif
+	mv	a3, sp				// regs
 	.endm
 
 SYM_FUNC_START(ftrace_caller)
@@ -150,10 +174,13 @@ SYM_FUNC_START(ftrace_caller)
 	SAVE_ABI_REGS
 	PREPARE_ARGS
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	jalr	ra
+#else
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	REG_L	ra, ftrace_call_dest
 	jalr	ra, 0(ra)
-
+#endif
 	RESTORE_ABI_REGS
 	bnez	t1, .Ldirect
 	jr	t0
-- 
2.39.3 (Apple Git-145)

