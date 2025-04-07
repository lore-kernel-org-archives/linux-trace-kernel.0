Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A5221569;
	Mon,  7 Apr 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049354; cv=none; b=DThzA8tfIgfJtj6/IGuCj++qAsc0dDcs/XJKlU485x+eIrefOgHbP82Yh1QENZvi0kfiDLHEiIO5FSo7eDPWYEwq8BAasUxQcvrdoQswXxGfvgCl4tHhjYhQduw0yRocrRCjAx4ZpQBlsRBPDPPNdSwMdkC8uzjJwtH7HrNuKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049354; c=relaxed/simple;
	bh=Sj5W9/T4z+INyNRE9k5vBv/SzMcR6rIum6hQa8LrCJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDiROdWSttdqZADNjJAge9l9BIKdbbedaSzTpVlfkBHM1sjrXgA7z0ufCzxbBOw8+khQBWhFGCSEnPpL1KLeZKzvxLUhYIms07N4c00Q7JWI4rCEAkDUZs0+dTirUkQIyOWxFEJjAW+kr8GpM4G6LmzISUd9sBTdPje6n2oU5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJX4Y2Td; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJX4Y2Td"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so64848905ad.0;
        Mon, 07 Apr 2025 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049352; x=1744654152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKIiqtyOydsKt6aFuPMQpVjfhS5wnmRKxjZ5aj4qfCI=;
        b=JJX4Y2Tdt88i7CQ1zKPxZpZYZvb5cWQ9N5CU8auv+mcNNUN6DA/hSYI3Sdq3MFBViO
         FNJ+HTemSDKEEibxTT+lAuKmCYBZ5eYnnyGGv1Kv2ygH68z3YVp1w1ceAv7PXe4klQ9h
         5h5XjOjYVdJrwqRcISkSa9gOBATzVo2fLAJBFREX/YsJ6cbZhnk/d3Z7GQ0q/HeHq/xO
         4kw4/qHxHeXjI+P6Tt8ktOHAecnPmKJrt0IUHoiLXKaNZh40kJfkyeCYqPunHlZRZTop
         39nRSAF/Ksop+AaDvf2R0TXrsYDqZqVwAT1xUGdY2J8z1bKB3CJKkgSNu+MJaIwU1Peq
         2yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049352; x=1744654152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKIiqtyOydsKt6aFuPMQpVjfhS5wnmRKxjZ5aj4qfCI=;
        b=emudsthX+7UxxDLUg/xnwFZu083g+WO0BY7a2vRAff2A0LNfyl6Yx0qrKkyhAsGFJt
         Sr9PwBM9HGd8hbiqCvfko8r060UpOOqb8Dy1NLySKODTFXI7d7DYRbBppYkZw67pa7Fu
         bYClZU7SmfIMSftdpMVHMh3IMNeAWFm/KQIHwlpXrPOVCjd6N9rZvIJ4xQ0XpiINswNA
         QPgmroQkD/ueFRWqQZr6iREvXqfCvTKl/eHYlORh0oKGqhI/wVGbeaJO70tg45zeQesY
         ssSpZch8xlK3tCfQgRc1nnlaRvKkxW/TqDpnPWFuzYVUhNz8QX1Qh0tYc4DJuhCCfl4G
         m+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UtSBOsOtewoQUD1sf/zRabIzqhWcW4kBos5EGqJKzw+RHgIqk8afy21RZM/3NNOlb0K5ex4XLsTiv8m4PsDWdtIH@vger.kernel.org, AJvYcCWcOiWeX1tWX50he3fyLdWUY5n8jc3a9vdF4Hxjc/yMInNf1CE8KN70mYsN76kcN/s4ZBJ604A19VYC5co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtZccam8j5KQrHYadUwtYo1h9YZZC62w3VBnQYSxAQ8r+YZbZ
	cMPpVXUS7bWAwokqp+TdkdVxZEsHdDGkMVAvW0yoTjinIe/u1MtO
X-Gm-Gg: ASbGncuOWXxxA8sB7EFP8ttzK9dHrUCZKklkhqxGmlhSNTRvo3f9nhzcwNMac8n+GXN
	b2CYx6esWK8JlMs+TLLyUS423Q5of8qTS980J2264ishhd+2VQX7jJinNzeIMGLRkW7V4ZCsMl3
	G2LtP4gVYHAy1ARIBKutkFzCugwOBd3VVG5cAHYQGicBlskPjsBDyCt64vFEW+kaDdRY4+D9ICj
	ACGMqXWmbo7hx7Y37Ae51ps1VIF7Hx6V0bt780I+JMsmptRCN9MLSlLv+ixAmGNnpdTitvNLHLa
	59jUPP0S0juOwKAy93g9PppTIrtPrehUuO5fS/DycEJSkybwn2D3zvu8JTu14ivT91hs1SGl5M8
	De+puAbKNFuKN5jZ9L4Feit7eDBEV6GnHSQ==
X-Google-Smtp-Source: AGHT+IGpl2ZX/KJd8sDDwi4VaUQ2lbuaEclQ6Z2k9mbwyZpgmsomMKjEgg3NkOT9ap9NMbGdOVe6Ig==
X-Received: by 2002:a17:903:22c2:b0:223:6744:bfb9 with SMTP id d9443c01a7336-22a955738c0mr164235845ad.41.1744049352095;
        Mon, 07 Apr 2025 11:09:12 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.09.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:09:11 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
Subject: [PATCH v4 05/12] riscv: ftrace: prepare ftrace for atomic code patching
Date: Tue,  8 Apr 2025 02:08:29 +0800
Message-Id: <20250407180838.42877-5-andybnac@gmail.com>
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

The new don't-stop-the-world text patching on change only one RISC-V
instruction:

  |  -8: &ftrace_ops of the associated tracer function.
  | <ftrace enable>:
  |   0: auipc  t0, hi(ftrace_caller)
  |   4: jalr   t0, lo(ftrace_caller)
  |
  |  -8: &ftrace_nop_ops
  | <ftrace disable>:
  |   0: auipc  t0, hi(ftrace_caller)
  |   4: nop

This means that f+0x0 is fixed, and should not be claimed by ftrace,
e.g. kprobe should be able to put a probe in f+0x0. Thus, we adjust the
offset and MCOUNT_INSN_SIZE accordingly.

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v4:
 - Include Björn's fix for kprobe
 - Refactor code for better reading (Robbin, Björn)
 - Remove make_call_ra and friedns (Björn)
 - Update comments to match reality (Björn)
 - Drop code defined by !WITH_ARG
 - Add a synchronization point when updating ftrace_call_dest (Björn)
---
 arch/riscv/include/asm/ftrace.h |  49 ++++++------
 arch/riscv/kernel/ftrace.c      | 130 ++++++++++++++++----------------
 arch/riscv/kernel/mcount-dyn.S  |   9 +--
 3 files changed, 92 insertions(+), 96 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index d8b2138bd9c6..6a5c0a7fb826 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -20,10 +20,9 @@ extern void *return_address(unsigned int level);
 #define ftrace_return_address(n) return_address(n)
 
 void _mcount(void);
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	return addr;
-}
+unsigned long ftrace_call_adjust(unsigned long addr);
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
+#define ftrace_get_symaddr(fentry_ip) arch_ftrace_get_symaddr(fentry_ip)
 
 /*
  * Let's do like x86/arm64 and ignore the compat syscalls.
@@ -57,12 +56,21 @@ struct dyn_arch_ftrace {
  * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
  *          return address (original pc + 4)
  *
+ * The first 2 instructions for each tracable function is compiled to 2 nop
+ * instructions. Then, the kernel initializes the first instruction to auipc at
+ * boot time (<ftrace disable>). The second instruction is patched to jalr to
+ * start the trace.
+ *
+ *<Image>:
+ * 0: nop
+ * 4: nop
+ *
  *<ftrace enable>:
- * 0: auipc  t0/ra, 0x?
- * 4: jalr   t0/ra, ?(t0/ra)
+ * 0: auipc  t0, 0x?
+ * 4: jalr   t0, ?(t0)
  *
  *<ftrace disable>:
- * 0: nop
+ * 0: auipc  t0, 0x?
  * 4: nop
  *
  * Dynamic ftrace generates probes to call sites, so we must deal with
@@ -75,10 +83,9 @@ struct dyn_arch_ftrace {
 #define AUIPC_OFFSET_MASK	(0xfffff000)
 #define AUIPC_PAD		(0x00001000)
 #define JALR_SHIFT		20
-#define JALR_RA			(0x000080e7)
-#define AUIPC_RA		(0x00000097)
 #define JALR_T0			(0x000282e7)
 #define AUIPC_T0		(0x00000297)
+#define JALR_RANGE		(JALR_SIGN_MASK - 1)
 
 #define to_jalr_t0(offset)						\
 	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
@@ -96,26 +103,14 @@ do {									\
 	call[1] = to_jalr_t0(offset);					\
 } while (0)
 
-#define to_jalr_ra(offset)						\
-	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_RA)
-
-#define to_auipc_ra(offset)						\
-	((offset & JALR_SIGN_MASK) ?					\
-	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_RA) :	\
-	((offset & AUIPC_OFFSET_MASK) | AUIPC_RA))
-
-#define make_call_ra(caller, callee, call)				\
-do {									\
-	unsigned int offset =						\
-		(unsigned long) (callee) - (unsigned long) (caller);	\
-	call[0] = to_auipc_ra(offset);					\
-	call[1] = to_jalr_ra(offset);					\
-} while (0)
-
 /*
- * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
+ * Only the jalr insn in the auipc+jalr is patched, so we make it 4
+ * bytes here.
  */
-#define MCOUNT_INSN_SIZE 8
+#define MCOUNT_INSN_SIZE	4
+#define MCOUNT_AUIPC_SIZE	4
+#define MCOUNT_JALR_SIZE	4
+#define MCOUNT_NOP4_SIZE	4
 
 #ifndef __ASSEMBLY__
 struct dyn_ftrace;
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 1fd10555c580..cf78eef073a0 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,10 +8,21 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/irqflags.h>
 #include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/text-patching.h>
 
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr + MCOUNT_AUIPC_SIZE;
+}
+
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+	return fentry_ip - MCOUNT_AUIPC_SIZE;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
@@ -32,51 +43,32 @@ void ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
 	mutex_unlock(&text_mutex);
 }
 
-static int ftrace_check_current_call(unsigned long hook_pos,
-				     unsigned int *expected)
+static int __ftrace_modify_call(unsigned long source, unsigned long target, bool validate)
 {
+	unsigned int call[2], offset;
 	unsigned int replaced[2];
-	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
 
-	/* we expect nops at the hook position */
-	if (!expected)
-		expected = nops;
+	offset = target - source;
+	call[1] = to_jalr_t0(offset);
 
-	/*
-	 * Read the text we want to modify;
-	 * return must be -EFAULT on read error
-	 */
-	if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
-			MCOUNT_INSN_SIZE))
-		return -EFAULT;
-
-	/*
-	 * Make sure it is what we expect it to be;
-	 * return must be -EINVAL on failed comparison
-	 */
-	if (memcmp(expected, replaced, sizeof(replaced))) {
-		pr_err("%p: expected (%08x %08x) but got (%08x %08x)\n",
-		       (void *)hook_pos, expected[0], expected[1], replaced[0],
-		       replaced[1]);
-		return -EINVAL;
+	if (validate) {
+		call[0] = to_auipc_t0(offset);
+		/*
+		 * Read the text we want to modify;
+		 * return must be -EFAULT on read error
+		 */
+		if (copy_from_kernel_nofault(replaced, (void *)source, 2 * MCOUNT_INSN_SIZE))
+			return -EFAULT;
+
+		if (replaced[0] != call[0]) {
+			pr_err("%p: expected (%08x) but got (%08x)\n",
+			       (void *)source, call[0], replaced[0]);
+			return -EINVAL;
+		}
 	}
 
-	return 0;
-}
-
-static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
-				bool enable, bool ra)
-{
-	unsigned int call[2];
-	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
-
-	if (ra)
-		make_call_ra(hook_pos, target, call);
-	else
-		make_call_t0(hook_pos, target, call);
-
-	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
+	/* Replace the jalr at once. Return -EPERM on write error. */
+	if (patch_insn_write((void *)(source + MCOUNT_AUIPC_SIZE), call + 1, MCOUNT_JALR_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -84,22 +76,21 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned int call[2];
+	unsigned long distance, orig_addr, pc = rec->ip - MCOUNT_AUIPC_SIZE;
 
-	make_call_t0(rec->ip, addr, call);
-
-	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
-		return -EPERM;
+	orig_addr = (unsigned long)&ftrace_caller;
+	distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
+	if (distance > JALR_RANGE)
+		return -EINVAL;
 
-	return 0;
+	return __ftrace_modify_call(pc, addr, false);
 }
 
-int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
-		    unsigned long addr)
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
+	u32 nop4 = RISCV_INSN_NOP4;
 
-	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, &nop4, MCOUNT_NOP4_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -114,21 +105,38 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
  */
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
-	int out;
+	unsigned long pc = rec->ip - MCOUNT_AUIPC_SIZE;
+	unsigned int nops[2], offset;
+	int ret;
+
+	offset = (unsigned long) &ftrace_caller - pc;
+	nops[0] = to_auipc_t0(offset);
+	nops[1] = RISCV_INSN_NOP4;
 
 	mutex_lock(&text_mutex);
-	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
 	mutex_unlock(&text_mutex);
 
-	return out;
+	return ret;
 }
 
+ftrace_func_t ftrace_call_dest = ftrace_stub;
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
-				       (unsigned long)func, true, true);
-
-	return ret;
+	WRITE_ONCE(ftrace_call_dest, func);
+	/*
+	 * The data fence ensure that the update to ftrace_call_dest happens
+	 * before the write to function_trace_op later in the generic ftrace.
+	 * If the sequence is not enforced, then an old ftrace_call_dest may
+	 * race loading a new function_trace_op set in ftrace_modify_all_code
+	 *
+	 * If we are in stop_machine, then we don't need to call remote fence
+	 * as there is no concurrent read-side of ftrace_call_dest.
+	 */
+	smp_wmb();
+	if (!irqs_disabled())
+		smp_call_function(ftrace_sync_ipi, NULL, 1);
+	return 0;
 }
 
 struct ftrace_modify_param {
@@ -172,17 +180,11 @@ void arch_ftrace_update_code(int command)
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
+	unsigned long caller = rec->ip - MCOUNT_AUIPC_SIZE;
 	unsigned int call[2];
-	unsigned long caller = rec->ip;
-	int ret;
 
 	make_call_t0(caller, old_addr, call);
-	ret = ftrace_check_current_call(caller, call);
-
-	if (ret)
-		return ret;
-
-	return __ftrace_modify_call(caller, addr, true, false);
+	return __ftrace_modify_call(caller, addr, true);
 }
 #endif
 
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 3f06b40bb6c8..8aa554d56096 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -13,7 +13,6 @@
 
 	.text
 
-#define FENTRY_RA_OFFSET	8
 #define ABI_SIZE_ON_STACK	80
 #define ABI_A0			0
 #define ABI_A1			8
@@ -62,8 +61,7 @@
 * After the stack is established,
 *
 * 0(sp) stores the PC of the traced function which can be accessed
-* by &(fregs)->epc in tracing function. Note that the real
-* function entry address should be computed with -FENTRY_RA_OFFSET.
+* by &(fregs)->epc in tracing function.
 *
 * 8(sp) stores the function return address (i.e. parent IP) that
 * can be accessed by &(fregs)->ra in tracing function.
@@ -140,7 +138,7 @@
 	.endm
 
 	.macro PREPARE_ARGS
-	addi	a0, t0, -FENTRY_RA_OFFSET
+	addi	a0, t0, -MCOUNT_JALR_SIZE	// ip (callsite's jalr insn)
 	la	a1, function_trace_op
 	REG_L	a2, 0(a1)
 	mv	a1, ra
@@ -153,7 +151,8 @@ SYM_FUNC_START(ftrace_caller)
 	PREPARE_ARGS
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
+	REG_L	ra, ftrace_call_dest
+	jalr	ra, 0(ra)
 
 	RESTORE_ABI_REGS
 	bnez	t1, .Ldirect
-- 
2.39.3 (Apple Git-145)

