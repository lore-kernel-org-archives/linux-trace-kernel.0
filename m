Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8C281530;
	Wed, 20 Aug 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716797; cv=none; b=LBC/QNX0gjxF0RTSn5Z+FMxQtEAt+Ce4iVq2Gl/sy8SAvwlsaskuv8jHkgpj8SXVqenS02v3tJqgpPBt2NYEdDW8rXUmsweiYlsKzSQ6eEgUU4Q/c9ukWiSggeeqoAb2Bsz5w975EKfJELfFrdxOMkbLChGUZAUgcefxD3iLvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716797; c=relaxed/simple;
	bh=gFyS+4phEZAJBQPEgmZZT7FNcIkNb7GGQjLxE06/dZQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VbPpVqP3vsvSUhrR38lOBaUylPOj0gPkeUbP6bfeRDeV4qCUWpY8CvwAnd6I9gGJ/oeAXykU6UG9dK1CamRqidWTBf91nMlFBfeRfFPIm9/xKhgsyJ9TA55N5qn/u4/LN50HqVYRlCA6W1s1C/FedUlpLOorzjZN0lXMcw2LZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRv04Rr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRv04Rr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E2C116D0;
	Wed, 20 Aug 2025 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716797;
	bh=gFyS+4phEZAJBQPEgmZZT7FNcIkNb7GGQjLxE06/dZQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XRv04Rr3yZ/naw5p9gclt8nvPimId3AZXxTyKau7Fx/JPcRyLqMF8nK2Hv1RiJQqL
	 d/bvT8geCAY+DdDdD8sUsQhWDRK16KXoQkMPfzEpXjdQ/ztD+GqBJFoulknoucCl2S
	 45MyRRzO5h/9r82URGEKdO2VJGV7BCnFSwRA0gG0+LIZZCyhNGH1YC916Vz4QubL6I
	 Kihi8MAaCwLrdN9sIcBbXhE+w151jGkSBjIaiKqYnM5TXbO6qlcWKcbVK4jmSVAD3W
	 T5oDvpOmwvcwAJyIONKOoLuLNhVkznVGFIxfXhziH2HHDP17zN6Sh10a/a5SQZZP1R
	 SQi2/uozOxBag==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uoo8t-00000000tFP-49xA;
	Wed, 20 Aug 2025 15:06:39 -0400
Message-ID: <20250820190639.843442474@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 15:05:48 -0400
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
Subject: [PATCH 2/2] unwind deferred/x86: Do not defer stack tracing for compat tasks
References: <20250820190546.172023727@kernel.org>
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
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 include/linux/unwind_deferred.h    |  5 +++++
 kernel/unwind/deferred.c           |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..220fd0a6e175 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#ifdef CONFIG_IA32_EMULATION
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


