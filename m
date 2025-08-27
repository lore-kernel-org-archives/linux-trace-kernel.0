Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B85212546;
	Wed, 27 Aug 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323490; cv=none; b=Ic3O3DH9qDrcggip4W7d+Jg2huUmXhPujUy60FsVgzrv4puEKU1MRdibO25a0AkvvXpM8mk8QWtiHBH6uDBQPZz4G/zTpKkK+p7ghXg2iXGYcxnlVTNWPuDp/Wo2OEok64wjmTrNCiH10hP56Lvqh7g95PP9sHqtRH3YXk9UlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323490; c=relaxed/simple;
	bh=nLJGoGeuqPkpzEuh03+jK8eWmMrjjG2N95dLqjOBEos=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=udrT2jQOd8B+OsNQVqbds5zdK8gVherseB6d0Ho671OQ6cc/jA/YarZiZPNgUmwa9laExexSxoZk7Nc+a1YPu9q6hDuQDlcv9WG7tEG7kSH2NJdD+bl627QifLNvXmY2z4HMOSgraOUTAQQwdOOxIEyxGtN2ut+ppQm4Pj/kD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8kFIKaw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8kFIKaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1AC4CEF4;
	Wed, 27 Aug 2025 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323489;
	bh=nLJGoGeuqPkpzEuh03+jK8eWmMrjjG2N95dLqjOBEos=;
	h=Date:From:To:Cc:Subject:References:From;
	b=h8kFIKawVBefXiWwzK9U0GbpGATeURNrmRnjKY35827ph1AG5BoEtOyXyBej0rean
	 EWslgMF+3HLPR52ud7P67taYAMrjSVKZfjYYvLNeGxet25/w1IYW4wzKi6cMkQCMpV
	 MZBjW//eFdcS17k5j4r7G1Fj9/vQiErnSuIW8/KAyJcNnKhUz/tqJG/8ZJQlvy7Spq
	 ZfNpJVmM7wHRJQWXKlVQzl7vQlf5G+UQqJEYev9KFgmyp9xPWgvgTEitiyG78sftFh
	 iKGKaV9rFwsMC7t5SwnqnBa6ProY42HiuaDSjs8IQPCr9NuAahopAd6yP58xlvi05b
	 BRc6Wm3jQW9jw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urLyW-00000003jGq-24ik;
	Wed, 27 Aug 2025 15:38:28 -0400
Message-ID: <20250827193828.347397433@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 15:36:45 -0400
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
Subject: [PATCH v2 1/2] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250827193644.527334838@kernel.org>
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


