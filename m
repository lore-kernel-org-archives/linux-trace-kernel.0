Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E32E1EF8;
	Wed, 27 Aug 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323490; cv=none; b=pPh2to7qZ3zBHDVt6LaXhpMEMzGlmD1XaU2uMfTDAxMm6/R40HGKLT3eRSrT07RTLadwPcmbRcsFfGFlZX6kFac+hXfcBz/na+CjcQ6d+jTDpfZxiAwdt6OoRTTH2Ed5uXygP43xkRe0DIjjGhoqSGSzSFmHqXstnFx+0+Hr8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323490; c=relaxed/simple;
	bh=XDdKCPGd0kRh2NlKCKevM7GKfZ9idx+4b4m4/KfGZEo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CXrdiEYh1mZd++F4dmvcb+uojc2KDm6xlj5u46jTC/tocNHmSo6+fX9ym6BWJPwtW/2g9nh6ccuu8YjSwttuDepz6i8jFkcCKblfTtLN1TXbls9VFj6RG81CtrpP23VoTbWUOnaS5QquYMN0R4Mz88BuKarmZW8RSo4FBuwaBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtWwGdaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtWwGdaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57EDC4CEF7;
	Wed, 27 Aug 2025 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323490;
	bh=XDdKCPGd0kRh2NlKCKevM7GKfZ9idx+4b4m4/KfGZEo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jtWwGdaZypyMMFSp5IWwJiqMMGGLwvwQ+cSbhFpa2dazi7Y5UvOyn8FohuPsJc3fI
	 r53geUNtdH0JFCN8hT5mxQkmIMAXJlmuLg+Tx2bVR/qAxy2jTONyM+GAWUeOlfKUmP
	 ua9k3js+TMc12L3tOrMgknj+CDq8HxqUuE3DqTCmuINi5Mrdd9+9fdlOMXxNJo4Ny5
	 RGCcPV76mFeP/h5AhgC5w4V1Mcwa0eo0w115qCqp8wg7PtIaWw45tejhsMmFSFzWH2
	 LDU1fDuWaScDwsorJKwprY1eR//vH+va8goKCMrOtuNeG5BlPP4/sPbfPNsKT63RZR
	 aj/rJOvEcyJXw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urLyW-00000003jHL-2mXc;
	Wed, 27 Aug 2025 15:38:28 -0400
Message-ID: <20250827193828.514833400@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 27 Aug 2025 15:36:46 -0400
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
Subject: [PATCH v2 2/2] unwind deferred/x86: Do not defer stack tracing for compat tasks
References: <20250827193644.527334838@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently compat tasks are not supported. If a deferred user space stack
trace is requested on a compat task, it should fail and return an error so
that the profiler can use an alternative approach (whatever it uses
today).

Add a arch_unwind_can_defer() macro that is called in
unwind_deferred_request(). Have x86 define it to a function that makes
sure that the current task is running in 64bit mode, and if it is not, it
returns false. This will cause unwind_deferred_request() to error out and
the caller can use the current method of user space stack tracing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250820190639.843442474@kernel.org

- Added #include <linux/compat.h> to use user_64bit_mode() in
  unwind_user.h. When adding this to the ftrace code, it failed to build
  due to the missing header.

 arch/x86/include/asm/unwind_user.h | 12 ++++++++++++
 include/linux/unwind_deferred.h    |  5 +++++
 kernel/unwind/deferred.c           |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..0cef2e3b08c8 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#ifdef CONFIG_IA32_EMULATION
+#include <linux/compat.h>
+/* Currently compat mode is not supported for deferred stack trace */
+static inline bool arch_unwind_can_defer(void)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	return user_64bit_mode(regs);
+}
+# define arch_unwind_can_defer	arch_unwind_can_defer
+#endif /* CONFIG_IA32_EMULATION */
+
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d00708a..0124865aaab4 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -16,6 +16,11 @@ struct unwind_work {
 	int				bit;
 };
 
+/* Architectures can add a test to not defer unwinding */
+#ifndef arch_unwind_can_defer
+# define arch_unwind_can_defer()	(true)
+#endif
+
 #ifdef CONFIG_UNWIND_USER
 
 enum {
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dc6040aae3ee..3601b2efe48d 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -237,6 +237,9 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = 0;
 
+	if (!arch_unwind_can_defer())
+		return -EINVAL;
+
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
-- 
2.50.1


