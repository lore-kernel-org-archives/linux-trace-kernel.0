Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587367;
	b=Deo9lZPPNp14KPS8m79WmSZrjA61ocIihwgLZS3MeJRXUyKlJ4r3cz3TaZ3WFpxvlUuN
	 VzRh5MiQm3JT+WyLTxT2TmSQlFUrHfcjl9ay0vijc/CTCgI0/Hf+PPsXs/X9mrxigG6pM
	 ZOTIB0Y6sPVq8ZEv3mfFkKG1yavQ0u6cLKQJEt9qISmbC3i0Zf6YXu3axwkk9KC1+NWP0
	 GGBk5TpdcPUdbyqss+Zstdu6W1UQGjQu7I3/5BaMDqAxl5jgdTFc2iUyqDZWBl+llQSrU
	 JY5Rii2Ddjr/sc71ZIcM0SdHURwLKtTrRCz05Y24d6YmE90YylSS/XY9A6RKg+nNVDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
	b=a2XJHMT3Z8xYexdhxVPwZKUga7OmoA4I3eZvfPdklRE8rf5XH3z/w7a9VYEu66l+nijw
	 H6fOTuJ/mv6vxM4aS6Mgcft9XEtjUKnfhBXZf2a8Y/lidPYv4zOLxsdtO+zNHpqLZs1cw
	 9ao7hVxGhhcyRV2kJSpN9wSvNwaa7Tr0bDDKdWpxRmm4qGHSB05aFhLY29Gi438HN9YSP
	 ua8JebY8Kkc3lTq5Tl3/2EmpMz0/JPOTXCNTZlDpm9ORGMR9QW29QzBMMkl6jM98ZpOkQ
	 OW0IxxAg4kmULsMG9rhH/T8uQd8ABrGDzFu4xlPaw/jJep+mOkZQn53+VVH2n3IaQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7B606DE4A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A7B606DE4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386c3309469so1559859eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587365; x=1796192165; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=XBc4yd4IuYHvDt/TolT0eq4CqFjuUCPoHs1qRWCRIlkUa0/ma9Bz2B/ehlL4XD70+/
         L6+Ja9pugipWLAAQ5CWFoSAiRZ+G1rGhoR8HSno+f73YqXbyKxlpUifvKG4u34DS2l7r
         QNEfZcEmteBBKozX5KWdb9OM3f6HoyiBGSJEalQ4Kt6uL2rD4/1QQ0j/syZ8y2ohh1np
         NgY6X/O278pXS3bjNr3irHwfr0XCGHOGiJS+CY2d9wZ2yWz6tSDjK6XIYeK0FmHJ8k8c
         oGYnKF5qiMgoLWaXUf06OGasQXvEIcn5I64ilKLYya0QeFqeTbZsop9rltdvX4QNJpBc
         DV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587365; x=1796192165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=HCvyy0Hx6oXamC24oRlMP8NeLyd2OJW6s8mTQp0xwWMiKIer+1F6BrwldRMKfmVAeT
         0+8+o3/ioW4pMtqxFOpzsYRRGaeiv7xHQuRlWb4lKr+AvHrEwB8vYQs0T7uwltLSbkmh
         SIO3VKbzK5oTxb/vJlePWQRNHvHKavr96fKAjOXh0AH+R/WB2J0pFkhQ0g4aEIpfG+pC
         G5+b236PDdYn0ekLSGIavNDOUR3WyZfKNA+Jvhob2W36taOzpETIHwGa6vQDK4OZ2MJn
         dgA89s3s3f0wipdeVOBdEziY3MG+Deq3ECXjr5iPE3SL59LkXb7m5tFmWiy1IiZa5EVo
         OTSw==
X-Forwarded-Encrypted: i=1; AL+hErGINMF1My3hjWEJ4/JSVxzI0guEkteb3+vTKxZLmrnJLqi36DkU0wq5Dmq4+RsZvGud5/8NBCArxsbap/OBz30CE2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RuZmm5RjgD38nZZ/bKrhxbYO18kvt5F9lfUpkt/U8+CENRK86
	/GHUyddC0hU7+xymAR5kVtIeAj397HeavoY0J3hPHnXNsZDgisSA3W+9twuUjRZXLBtgff/jCRc
	+dEpBcbNUnQ==
X-Received: from dyckx5.prod.google.com ([2002:a05:7300:c7c5:b0:386:c57e:ee36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4201:b0:385:b8f4:755d
 with SMTP id 5a478bee46e88-385b8f47ad3mr17347048eec.20.1795587364179; Tue, 24
 Nov 2026 22:16:04 -0800 (PST)
Date: Tue, 24 Nov 2026 22:14:57 -0800
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
Message-ID: <20261125061523.1540234-5-irogers@google.com>
Subject: [RFC PATCH v2 04/30] x86: unwind_user: Support Minimal DWARF CFI user unwinding
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

Provide unwind_user_cfi_arch() in arch/x86/include/asm/unwind_user.h for
both 64-bit x86-64 (%rsp=7, %rbp=6, %rip=16) and 32-bit IA-32 compat
(%esp=4, %ebp=5, %eip=8) user tasks, and select HAVE_UNWIND_USER_CFI on
X86_64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 47 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..c8096cf66c38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -300,6 +300,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_CFI		if X86_64
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 6e469044e4de..1a6be08968c3 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -4,9 +4,17 @@
 
 #ifdef CONFIG_UNWIND_USER
 
+#include <linux/unwind_dwarf_cfi.h>
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
+/**
+ * unwind_user_word_size() - Return the user-space word size in bytes on x86
+ * @regs: User-mode register state.
+ *
+ * Return: 8 for 64-bit user mode, 4 for 32-bit IA-32/compat mode, or 0 for
+ * VM86 mode stacks which cannot be unwound.
+ */
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -15,22 +23,61 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+/**
+ * unwind_user_cfi_arch() - Populate x86/x86-64 DWARF register numbers
+ * @ws: User word size in bytes (8 for x86-64, 4 for i386).
+ * @arch: Output DWARF CFI architecture descriptor.
+ *
+ * Return: true if @ws is 4 or 8, false otherwise.
+ */
+static inline bool unwind_user_cfi_arch(unsigned int ws,
+					struct dwarf_cfi_arch *arch)
+{
+	if (ws == 8) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 8,
+			.sp_reg	= 7,	/* %rsp */
+			.fp_reg	= 6,	/* %rbp */
+			.ra_reg	= 16,	/* %rip */
+		};
+		return true;
+	}
+	if (ws == 4) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 4,
+			.sp_reg	= 4,	/* %esp */
+			.fp_reg	= 5,	/* %ebp */
+			.ra_reg	= 8,	/* %eip */
+		};
+		return true;
+	}
+	return false;
+}
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
+/* Standard x86 frame record: {saved_bp, ret_addr} at [bp, bp + 2 * ws). */
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
+/* At function entry before push %rbp: return address is at [sp, sp + ws). */
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
 	.use_fp		= false,
 
+/**
+ * unwind_user_at_function_start() - Check if @regs is at a function entry point
+ * @regs: User-mode register state.
+ *
+ * Return: true if stopped on an entry uprobe before the frame prologue ran.
+ */
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.56.1.831.g720f3f5937-goog

