Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDC275AEB;
	Wed, 20 Aug 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716797; cv=none; b=kyklt4bDfknCcz3xJD5iio2wSDpQUFvmAkS0SIiJYBbr5Or18yFm18rzPZuVOTOD3/qVCjpntlMkeJ11Dacyk5u2HlNHjbO6IDiGnHo4dTUIf/7YXWYV+PjnE9rf+61FbJb1ZjdafaTanwA3RikrEc+O9clQEztNdMhMYPzWgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716797; c=relaxed/simple;
	bh=nLJGoGeuqPkpzEuh03+jK8eWmMrjjG2N95dLqjOBEos=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j1oDQywVD6M7YGN07hWlPuidNrOregqH98dbCqc7Xz5z9RJpidEDE6tJTl4tPGfB+FiPI3lYd50nw9Ck17KYKpxfZvmJdLqAmU3l9aIF1fyDoI11a/FUD622+vAHqa3i6qIKBwlEPeYE7+XjiXncTxn+OyIjDdO8lB+Y5eJA+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZrXLEd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZrXLEd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C965FC113D0;
	Wed, 20 Aug 2025 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716796;
	bh=nLJGoGeuqPkpzEuh03+jK8eWmMrjjG2N95dLqjOBEos=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OZrXLEd7XzCFcqMBGb928PUq3hxO2MjCNNOFVsd667EUAwcxddJcIUQqS+VIF6VlI
	 wYo+ooA8movVa2KF1TglArkFLnD3F0Sl0c63KsJmhsrGzhChi96IrDTyKAQ9qSbsVE
	 6bWCff1u6v2eHvCWOiwfBK4KQxpg2ghZsHDNYxionrdq5chrHAhz+gcr7/UXbmA7LF
	 j4F7BZbnQOihcwLd8FWf+6YIjB/FgChypDohUCE9pO4roXKZ3maQc4zwtbjs2CyuBy
	 jFYPeY8Mj+eOyeP1bmmfEz79VISFsej6VVt1ULY3OCzRCpD5ql0/xaVVxtVT9sy1ZK
	 HC8qaXYK9njAA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uoo8t-00000000tEv-3SFu;
	Wed, 20 Aug 2025 15:06:39 -0400
Message-ID: <20250820190639.676050639@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 15:05:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 1/2] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250820190546.172023727@kernel.org>
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
index 58d890fe2100..8f94c58d4de8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -299,6 +299,7 @@ config X86
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
2.50.1


