Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587407;
	b=WRwNeDi1TdeLqQxLvoLcvIfTUDluo5NE/TmkW6HYueqCrtoBzFfTXG3TRwMRC1zHLtmj
	 pCtOmIpSwh3ydFL7REwJS6r1Ko/582B5+fWdAGy1V3WVLQnxe9KPP86Bv7ZRc1PoAa2Uz
	 lhPvbTx5sE5k4nbvYoNO0eOSB1b3twOT9yVkoKNyltZNs0J3pSS4KjbSy/W6XNS5jIbbA
	 24hd/ghXFj59qRVRfwjaRsRgyV/fXzYldOiS/9utvMcm6CduHNmJkoj+XWe3c79oYJGty
	 jJtzu7DCrWkW4092N4nmgEGcqPcxPHi/AENmJ/S2oYhQBwCaTcId11ZIVlysflqv3WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=opbvbiqLtMKnZidmW1akDPMoAVRaFGJF5QXg9EIzgwM=;
	b=Qsve3RaTg3qUFIB4o8NHwkFsiLT40NLTMI1N3Y/jCl+eYDwUH0pPQnLK7fd/qfc0AErF
	 SQkKRKB53LxMjo9mibVpfSzZF3i9/hC83eKdzNNRH3EJb8jdLOrGTZdjfFn53Nk7q/b3e
	 xiCWmAgK451itUWelvVR0k492+/P8897mkq7/z9Yc+2PKPD94fzauQA2cd/txYCqR+E8U
	 GgLB5+ilg+iGk3O4uweV1hXVCnw8+d0yfGbsz+HIXpm7DUWNESMLa24wxFy53I8SuDbs5
	 3zv7+PYdW3XA7bdTgxmtZrjaUCmSc2RiAn28OOQftFRJ2AtjWNXTJQgPRX5fc351a/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="LC+1xza/";
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C90606C834
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C90606C834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LC+1xza/
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c7f887ac6bso9539005b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 22:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587405; x=1796192205; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opbvbiqLtMKnZidmW1akDPMoAVRaFGJF5QXg9EIzgwM=;
        b=LC+1xza/F+EfgVLfIRCO6xj2b9zX937Yt/VBAA/sgm7NYVeeu6aTrhFijf9guPtyqr
         RDgdDsGHPionoJqJ8SF8yy2YSCKd1tbhr/05XkigNs4hlM1KS1PYwLwc2S+G3HyzPCZd
         Q6YdSsXDkvq1xZz6WR8q/75XpIq28Pj7O8fhza60bGZ1GVmu0Ev1PzIKXSzrayPfaYLR
         FoGCZG4yiWH8DgIiFtNQyFZfhdy75mIF8U/FJXqModOsUvsJMGxdU02ziK6fddAsJnlr
         jJqLJ7o0L0ehhmS3LfuPrh0IGzN/UmZMJyFzOTHkkhzNJzVy1Mxw/z0NNFbUNbyR73Cm
         v7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587405; x=1796192205;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opbvbiqLtMKnZidmW1akDPMoAVRaFGJF5QXg9EIzgwM=;
        b=CgxaLxsKY22Wb8wucRZQQsYh2l304tC5fyTYrYFoW5or0H6RflwWf8UsMBesN+pbqA
         yZKRbWkxEVo59rrMt2eNnahXAASGJXTomAwV8s1wVPxWARJfgcE2IwC1u0AkJOTJ7jCH
         2JE7DRZ7jBJlUjRB8rjp236cgJLVQmFnFHLfzRWv+142tnVZG+v/NswimXtePAxixqY+
         ttSNe5igGhWTOMC2Xmo20C2XdUGFq6BqXZhHfuSIbqgM6gosR64SoFb6xcwmDy3ag/ho
         2zOZEILfO3mDt0pFCM4VfGNDxLSXZhbnJ9pRVbqL7I87LfSzvXcUUdrkrkhrXLRSnmSu
         cYuA==
X-Forwarded-Encrypted: i=1; AL+hErFd3WMtlDOrro5nSWRKUp+IizTYlO2mhLF7WP1f5nJhGUNIiWO/75d2X4AiTws6GJE3dYgAMlptoVXJFaIFWZSPlBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YdCz7aWC9kWt/JI8dZlmnAFCFRBLsoLJJVKiP6vXJCtBzSSRZ
	AmyJy5mZaSeVwmTNfue8P3NNDFqiGPLEdrXjESLNZTCT1et0UipXAIlpdaO8LP8fhGMYvBMy6+M
	17KwLtds1RA==
X-Received: from oigu20-n1.prod.google.com ([2002:a05:6809:5d4:10b0:4f5:740:2bcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:319b:b0:4f5:eaac:5173
 with SMTP id 5614622812f47-57a0b84fa3dmr15864618b6e.57.1795587405164; Tue, 24
 Nov 2026 22:16:45 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:17 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-25-irogers@google.com>
Subject: [RFC PATCH v2 24/30] tools headers: Add linux/unwind_dwarf_cfi.h copy
 from the kernel sources
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Copy include/linux/unwind_dwarf_cfi.h to
tools/include/linux/unwind_dwarf_cfi.h for host unwinding verification
tools under tools/, and add it to tools/perf/check-headers.sh.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/unwind_dwarf_cfi.h | 181 +++++++++++++++++++++++++
 tools/perf/check-headers.sh            |   1 +
 2 files changed, 182 insertions(+)
 create mode 100644 tools/include/linux/unwind_dwarf_cfi.h

diff --git a/tools/include/linux/unwind_dwarf_cfi.h b/tools/include/linux/unwind_dwarf_cfi.h
new file mode 100644
index 000000000000..3530794c8543
--- /dev/null
+++ b/tools/include/linux/unwind_dwarf_cfi.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+#ifndef _LINUX_UNWIND_DWARF_CFI_H
+#define _LINUX_UNWIND_DWARF_CFI_H
+
+#include <linux/types.h>
+
+/*
+ * Minimal DWARF Call Frame Information (CFI) unwinder subset.
+ *
+ * Evaluates a strictly bounded, non-Turing-complete subset of .eh_frame and
+ * .eh_frame_hdr tables matching SFrame's stack-unwinding state model (plus
+ * fixed-pattern DRAP stack-realignment and signal-frame expressions):
+ *  - Advances PC monotonically through a single FDE (no backward jumps)
+ *  - Tracks CFA = (SP | FP | scratch) + cfa_off or *(FP/SP + cfa_off)
+ *  - Tracks stack save offsets for SP, FP, and RA (ignoring callee-saved GPR
+ *    spills)
+ *  - Rejects general DWARF expressions, register-to-register rules on SP/FP/RA,
+ *    and DW_EH_PE_indirect FDE/table pointer encodings (skipping CIE
+ *    personality and LSDA fields without dereferencing).
+ */
+
+/* Hard safety bounds enforced on CIE/FDE lengths, offsets, and state stack */
+#define DWARF_CFI_MAX_CIE_LEN		128U
+#define DWARF_CFI_MAX_FDE_LEN		4096U
+#define DWARF_CFI_MAX_CIE_DELTA		(64U * 1024U * 1024U)
+#define DWARF_CFI_MAX_FDE_COUNT		(4U * 1024U * 1024U)
+#define DWARF_CFI_MAX_STATE_STACK	4U
+
+/**
+ * enum dwarf_cfi_base - Base register or addressing mode for computing the CFA
+ * @DWARF_CFI_BASE_UNDEFINED: CFA rule has not been established yet.
+ * @DWARF_CFI_BASE_SP: CFA = stack pointer + cfa_off.
+ * @DWARF_CFI_BASE_FP: CFA = frame pointer + cfa_off.
+ * @DWARF_CFI_BASE_FP_INDIRECT: DRAP stack realignment: CFA = *(FP + cfa_off).
+ * @DWARF_CFI_BASE_SP_INDIRECT: Signal trampoline frame: CFA = *(SP + cfa_off).
+ * @DWARF_CFI_BASE_REG: Transient prologue/epilogue scratch register:
+ *                      CFA = reg(cfa_reg) + cfa_off.
+ */
+enum dwarf_cfi_base {
+	DWARF_CFI_BASE_UNDEFINED = 0,
+	DWARF_CFI_BASE_SP,
+	DWARF_CFI_BASE_FP,
+	DWARF_CFI_BASE_FP_INDIRECT,
+	DWARF_CFI_BASE_SP_INDIRECT,
+	DWARF_CFI_BASE_REG,
+};
+
+/**
+ * enum dwarf_cfi_rule - Recovery rule for caller's SP, FP, or return address
+ * @DWARF_CFI_RULE_SAME: Register retains its value from the current frame
+ *                       (or defaults to CFA for SP).
+ * @DWARF_CFI_RULE_OFFSET: Saved on the stack at *(CFA + off).
+ * @DWARF_CFI_RULE_FP_OFFSET: Saved relative to FP at *(FP + off) (DRAP frame).
+ * @DWARF_CFI_RULE_SP_OFFSET: Saved relative to SP at *(SP + off) (sigframe).
+ * @DWARF_CFI_RULE_UNDEFINED: Explicitly undefined (DW_CFA_undefined); marks
+ *                            the bottom of a stack (e.g. _start or clone).
+ */
+enum dwarf_cfi_rule {
+	DWARF_CFI_RULE_SAME = 0,
+	DWARF_CFI_RULE_OFFSET,
+	DWARF_CFI_RULE_FP_OFFSET,
+	DWARF_CFI_RULE_SP_OFFSET,
+	DWARF_CFI_RULE_UNDEFINED,
+};
+
+/**
+ * struct dwarf_cfi_arch - Architecture DWARF register numbers and word size
+ * @ws: Target address/word size in bytes (4 or 8).
+ * @sp_reg: DWARF register number for the stack pointer.
+ * @fp_reg: DWARF register number for the frame pointer.
+ * @ra_reg: Default DWARF return-address column number.
+ */
+struct dwarf_cfi_arch {
+	u8 ws;
+	u8 sp_reg;
+	u8 fp_reg;
+	u8 ra_reg;
+};
+
+/**
+ * struct dwarf_cfi_row - Evaluated Minimal DWARF unwind state at a target PC
+ * @cfa_off: Byte offset added to the CFA base register before or as the CFA.
+ * @sp_off: Byte offset used to load the saved SP when @sp_rule is an offset.
+ * @fp_off: Byte offset used to load the saved FP when @fp_rule is an offset.
+ * @ra_off: Byte offset used to load the saved RA when @ra_rule is an offset.
+ * @cfa_base: CFA computation mode (&enum dwarf_cfi_base).
+ * @cfa_reg: DWARF register number when @cfa_base is %DWARF_CFI_BASE_REG.
+ * @sp_rule: Recovery rule for the stack pointer (&enum dwarf_cfi_rule;
+ *           %DWARF_CFI_RULE_SAME indicates caller SP equals CFA).
+ * @fp_rule: Recovery rule for the frame pointer (&enum dwarf_cfi_rule).
+ * @ra_rule: Recovery rule for the return address (&enum dwarf_cfi_rule).
+ * @signal: True if the CIE carries the 'S' signal/interrupt frame augmentation,
+ *          indicating that the saved PC points directly to the interrupted
+ *          instruction rather than after a call instruction.
+ * @ra_signed: True on AArch64 when DW_CFA_AARCH64_negate_ra_state indicates
+ *             that the saved return address carries a PAC signature.
+ */
+struct dwarf_cfi_row {
+	s32 cfa_off;
+	s32 sp_off;
+	s32 fp_off;
+	s32 ra_off;
+	u8 cfa_base;
+	u8 cfa_reg;
+	u8 sp_rule;
+	u8 fp_rule;
+	u8 ra_rule;
+	bool signal;
+	bool ra_signed;
+};
+
+/**
+ * struct eh_frame_hdr_entry - Binary-search index entry for an FDE
+ * @start_off: Signed 32-bit offset from the table base (or entry field) to the
+ *             FDE's initial PC location.
+ * @fde_off: Signed 32-bit offset from the table base (or entry field) to the
+ *           start of the FDE record in .eh_frame.
+ */
+struct eh_frame_hdr_entry {
+	s32 start_off;
+	s32 fde_off;
+};
+
+#ifdef CONFIG_UNWIND_DWARF_CFI
+
+extern const u8 __start_eh_frame_hdr[];
+extern const u8 __stop_eh_frame_hdr[];
+extern const u8 __start_eh_frame[];
+extern const u8 __stop_eh_frame[];
+
+int dwarf_cfi_eval_fde_kmem(const u8 *fde, const u8 *eh_start,
+			    const u8 *eh_end, unsigned long pc,
+			    const struct dwarf_cfi_arch *arch,
+			    struct dwarf_cfi_row *out_row);
+
+int dwarf_cfi_unwind_eh_frame_hdr(const u8 *hdr, size_t hdr_size,
+				  const u8 *eh_start, const u8 *eh_end,
+				  unsigned long pc,
+				  const struct dwarf_cfi_arch *arch,
+				  struct dwarf_cfi_row *out_row);
+
+int dwarf_cfi_scan_eh_frame_kmem(const u8 *eh_start, size_t eh_size,
+				 const struct dwarf_cfi_arch *arch,
+				 unsigned long base_addr,
+				 struct eh_frame_hdr_entry *entries,
+				 unsigned int max_entries,
+				 unsigned int *out_count);
+
+int dwarf_cfi_unwind_user_eh_frame_hdr(unsigned long hdr_uaddr,
+				       size_t hdr_size, unsigned long pc,
+				       const struct dwarf_cfi_arch *arch,
+				       struct dwarf_cfi_row *out_row);
+
+#if defined(CONFIG_UNWINDER_DWARF_CFI) && defined(CONFIG_MODULES)
+/**
+ * struct mod_dwarf_cfi_index - Sorted FDE lookup table for a loadable module
+ * @num_fdes: Number of sorted FDE index entries in @entries.
+ * @eh_frame: Pointer to the module's in-memory SHF_ALLOC .eh_frame section;
+ *            also serves as the base address for @entries offsets.
+ * @eh_frame_size: Size in bytes of the module's .eh_frame section.
+ * @entries: Sorted binary-search table mapping PCs to module FDEs.
+ */
+struct mod_dwarf_cfi_index {
+	unsigned int num_fdes;
+	const u8 *eh_frame;
+	size_t eh_frame_size;
+	struct eh_frame_hdr_entry entries[] __counted_by(num_fdes);
+};
+
+struct mod_dwarf_cfi_index *dwarf_cfi_mod_alloc(const void *eh_frame,
+						size_t eh_frame_size,
+						const struct dwarf_cfi_arch *arch);
+void dwarf_cfi_mod_free_rcu(struct mod_dwarf_cfi_index *idx);
+int dwarf_cfi_mod_eval(const struct mod_dwarf_cfi_index *idx, unsigned long ip,
+		       const struct dwarf_cfi_arch *arch,
+		       struct dwarf_cfi_row *out_row);
+#endif
+
+#endif /* CONFIG_UNWIND_DWARF_CFI */
+
+#endif /* _LINUX_UNWIND_DWARF_CFI_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 3e684c851a86..1b1bd04a6690 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -30,6 +30,7 @@ declare -a FILES=(
   "include/linux/hash.h"
   "include/linux/kmsan-checks.h"
   "include/linux/list-sort.h"
+  "include/linux/unwind_dwarf_cfi.h"
   "include/uapi/linux/hw_breakpoint.h"
   "arch/x86/include/asm/cpufeatures.h"
   "arch/x86/include/asm/inat_types.h"
-- 
2.56.1.831.g720f3f5937-goog

