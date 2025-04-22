Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDB1DEFC8;
	Tue, 22 Apr 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346931; cv=none; b=RH9onyYaBCOx/R65O5zE8RA3CKgvxjkKnb658srZ0MsEidiX8p9Hrm+dr8/vVEwDtPKwaZJz+Dy5eh7wEsqvE6yYAC4mYIE6ZfoUjwrEqRlFnEOyXqz4nyAnuYSVadK4Zs3VL0VHjMiKUZicN/MzGihl+qyIrhVQDEAzlCYxCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346931; c=relaxed/simple;
	bh=CayS5OAoG+jEWAfNo0q90M7R6fNDrO+CxAEV6GDanqw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UoJ1jAUdprJpjcopmKsNRWO0zgRkOLhejplgAeBfzCaX9XV9TcSlbysVVElsSDJLkRCsl9bHw3ymhjO8nmHOCDJUQsmK6DVYgHWMW4yaq5HNEHkQSW3di6PhRiWpcP+fA1VoJciM8oNBt0XvEtYuzZhwwelZ/OfL6u8nwyyqcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A60C4CEED;
	Tue, 22 Apr 2025 18:35:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7IUk-0000000Fw7v-1brT;
	Tue, 22 Apr 2025 14:37:22 -0400
Message-ID: <20250422183722.237323078@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 22 Apr 2025 14:34:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jens Remus <jremus@linux.ibm.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 2/6] x86/asm: Avoid emitting DWARF CFI for non-VDSO
References: <20250422183439.895236512@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

It was decided years ago that .cfi_* annotations aren't maintainable in
the kernel.  They were replaced by objtool unwind hints.  For the kernel
proper, ensure the CFI_* macros don't do anything.

On the other hand the VDSO library *does* use them, so user space can
unwind through it.

Make sure these macros only work for VDSO.  They aren't actually being
used outside of VDSO anyway, so there's no functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/dwarf2.h | 51 ++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 302e11b15da8..65d958ef1178 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -6,6 +6,15 @@
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
+#ifdef BUILD_VDSO
+
+	/*
+	 * For the vDSO, emit both runtime unwind information and debug
+	 * symbols for the .dbg file.
+	 */
+
+	.cfi_sections .eh_frame, .debug_frame
+
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA		.cfi_def_cfa
@@ -21,21 +30,31 @@
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
 
-#ifndef BUILD_VDSO
-	/*
-	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-	 * The latter we currently just discard since we don't do DWARF
-	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if we
-	 * ever decide to enable DWARF unwinding at runtime.
-	 */
-	.cfi_sections .debug_frame
-#else
-	 /*
-	  * For the vDSO, emit both runtime unwind information and debug
-	  * symbols for the .dbg file.
-	  */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+#else /* !BUILD_VDSO */
+
+/*
+ * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
+ * they're fragile and very difficult to maintain.
+ */
+
+.macro nocfi args:vararg
+.endm
+
+#define CFI_STARTPROC		nocfi
+#define CFI_ENDPROC		nocfi
+#define CFI_DEF_CFA		nocfi
+#define CFI_DEF_CFA_REGISTER	nocfi
+#define CFI_DEF_CFA_OFFSET	nocfi
+#define CFI_ADJUST_CFA_OFFSET	nocfi
+#define CFI_OFFSET		nocfi
+#define CFI_REL_OFFSET		nocfi
+#define CFI_REGISTER		nocfi
+#define CFI_RESTORE		nocfi
+#define CFI_REMEMBER_STATE	nocfi
+#define CFI_RESTORE_STATE	nocfi
+#define CFI_UNDEFINED		nocfi
+#define CFI_ESCAPE		nocfi
+
+#endif /* !BUILD_VDSO */
 
 #endif /* _ASM_X86_DWARF2_H */
-- 
2.47.2


