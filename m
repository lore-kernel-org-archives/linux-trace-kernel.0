Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5114A4F0;
	Thu,  6 Feb 2025 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811569; cv=none; b=lDIpGXzta4hByKiQEr92EWnt8/fZCw4JnAGtpkez81pU4XfbzXCJ2+mjo148aRxrGsW2KjPGLOjH6Y90pSgQhX0r9qa/3BXGvZiaasMyQKiB0kFPFdphCsExRF/E+2JrVOHE0UmL94kEXWHoNYVGThZldlyIpLN80ABdMavTx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811569; c=relaxed/simple;
	bh=Fj+mlnMPpUC5soIHZqTztR74wvvQB9iem7Yha5sC0AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ptG6ocoKOmmOog4gj1uZhIxD3GfSRuGtlZz+YcdHCuLrBRLp4W8gMbImJJyY0XlXYpReEekP3TTcCdP8aSutuUHFhsATEY+3qJT9llf6HTUY5oOECTHBWRIqdYnS6qXNbWI6eEmWtBM9NPU62/H1EWJwIOEK2edUPAIwCYghDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEc0NiPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEc0NiPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C3C4CED1;
	Thu,  6 Feb 2025 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738811568;
	bh=Fj+mlnMPpUC5soIHZqTztR74wvvQB9iem7Yha5sC0AI=;
	h=From:To:Cc:Subject:Date:From;
	b=kEc0NiPw+CmUv1HcAKgkBUVPlaEWnj16wVGaFoP4/4SDqMkfoVe0lHG0unM+8c2wK
	 x9wCSKyXNiR0m+WOm5Gt6jOiRMMgiD3ZagLK99TOHvAGvxXh+Lyj+cjVn6iAVMBZwO
	 xOENSY35XoDa2ImL7CiGO8CH1TZMA1NOtAnwaXsP8/UuUJZ3Ie5ACzutJTmu56WKPw
	 tl2b+g7U+JrhmR5C5NJ2fOZHqfSnTy7wqvLsSHHZFmZ/WQiF/DxS0B+ha7xGr7OWjJ
	 dRazmklWsturnsY+vdHxJkUyTJOuOggoleQWGwhxoS1MVSeYz/OmMDTFkT9pDeOcdm
	 pYU6oj3zllOAA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriel de Perthuis <g2p.code@gmail.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace: x86: Fix a compile error about get_kernel_nofault()
Date: Thu,  6 Feb 2025 12:12:42 +0900
Message-ID: <173881156244.211648.1242168038709680511.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix a compile error about get_kernel_nofault() which is defined in the
linux/uaccess.h. Since asm/ftrace.h is widely used, including
linux/uaccess.h in asm/ftrace.h caused another error. Thus this
moves arch_ftrace_get_symaddr() into arch/x86/kernel/ftrace.c.

The original errors look like:

In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
                 from <stdin>:3:
./arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_get_symaddr':
./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of function 'get_kernel_nofault' [-Werror=implicit-function-declaration]
   46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
      |                     ^~~~~~~~~~~~~~~~~~

This also makes ftrace_get_symaddr() available only when
CONFIG_HAVE_FENTRY=y on x86.

Reported-by: Gabriel de Perthuis <g2p.code@gmail.com>
Closes: https://lore.kernel.org/all/a87f98bf-45b1-4ef5-aa77-02f7e61203f4@gmail.com/
Reported-by: Haiyue Wang <haiyuewa@163.com>
Closes: https://lore.kernel.org/all/20250205180116.88644-1-haiyuewa@163.com/
Fixes: 2bc56fdae1ba ("ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/ftrace.h |   23 ++++-------------------
 arch/x86/kernel/ftrace.c      |   26 +++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d07df58..1ed08f2de366 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,26 +34,11 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
-{
-#ifdef CONFIG_X86_KERNEL_IBT
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
-		fentry_ip -= ENDBR_INSN_SIZE;
-#endif
-	return fentry_ip;
-}
+/* This does not support mcount. */
+#ifdef CONFIG_HAVE_FENTRY
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
 #define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
+#endif
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 166bc0ea3bdf..7250118005fc 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -29,11 +29,35 @@
 
 #include <trace/syscall.h>
 
-#include <asm/kprobes.h>
 #include <asm/ftrace.h>
+#include <asm/ibt.h>
+#include <asm/kprobes.h>
 #include <asm/nops.h>
 #include <asm/text-patching.h>
 
+#ifdef CONFIG_HAVE_FENTRY
+/* Convert fentry address to the symbol address. */
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+#ifdef CONFIG_X86_KERNEL_IBT
+	u32 instr;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
+		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
+			return fentry_ip;
+	} else {
+		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
+	}
+	if (is_endbr(instr))
+		fentry_ip -= ENDBR_INSN_SIZE;
+#endif
+	return fentry_ip;
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static int ftrace_poke_late = 0;

