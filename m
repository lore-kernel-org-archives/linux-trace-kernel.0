Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CB25DCF8;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204609; cv=none; b=JStXytFp+fouTrw6E5YlT2WK7SOzpngmqZxJu9Hem2aF7bFP00+dwCmLR5ZLq2E24E2MWNuRmmcbl/ihhLGXelAHnhIX/FmFK99rNLw+QX2+IPVBy4WH+Rc1B4Pmmsbn+EQsp5kM6mU0b3yomrZWE2UIZSJEjo87vw6dZbgprX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204609; c=relaxed/simple;
	bh=mzbtnjJps06HCLHPOPcqSMIDBIvOi7mfpTIlyoJ7BSc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YP9kz1tUnhwZzsXVmCeKXMv88arqbKP7E0Z7Lg9Fkw50Ay+ZjxTT4CKFGAyiw+51wkQLJVMXag6cWJ62NxmlWt3jvXwyspmjwIanEL4C059pitrgBMNfX9LXf3lthBCdGlkMiP2ZZHQ9ripyvxwLu/L2eQuvOqnc/jSX5uuw0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B944BC4AF0E;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaS-0000000030k-09BU;
	Fri, 02 May 2025 12:50:08 -0400
Message-ID: <20250502165007.885738514@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 03/17] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4c33c644b92d..a6e529dc4550 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -301,6 +301,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
new file mode 100644
index 000000000000..8597857bf896
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.cfa_off	= (s32)sizeof(long) *  2,				\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.47.2


