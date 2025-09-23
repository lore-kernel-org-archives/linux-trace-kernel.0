Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66826F476;
	Tue, 23 Sep 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627789; cv=none; b=saLwqV1y4eA9yH0QeWqn6g7JaJB7rud0Mw92fapRXpUTiE4Rlr+p9l4s9+ZLKDlf6WiEBwjXvGcWtTSqUn3G6cH1IUYT6ZaDW10uNc+xMjFh1Kcju45nT6oBnhUkkp4KN9MM5+WI7gAFS9Dvn9PjQiyROMK5guuWmXzo2liAMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627789; c=relaxed/simple;
	bh=S5498ttfcfbkKlJ2YxVLo+hr4sIcM8+XjEtHFzh08IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7xxsTcwC+N2UgzqWxRoj8e197FF/gKRm7CCLZKufzE6asKs/m2/qNhLTwVqLR8Yba7Qz9ds1iI981h7k+Y9+kRJ3YUQoZz5onmZFePR7amSAT6d03xLgIf9IGIz/iP5C+v8hmw/9F4IlXEBgP2hxG1ImrWGgnYQOSNeULwhqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e59vV0PM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e59vV0PM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nVuwj4QSgAcq1rhDVzsjKFtiCX62pzO4vRMIucXNS14=; b=e59vV0PMTHU6qxtBGdKNrU/+1Z
	QzJrHf23PpgRMljesBCX4hed0uDY2kgHNprdlUK3AYcjLRfhVgD2+s7mu8y4UjdYvL6U8Xly0UUCn
	5TfTz8e0WmuKJWONlIc5FPnsTseXWlK6w0GycKdCYtTJbob8APnYwxkzIV+N2oxWKmOBvcUE7lc4x
	gJF/Rh41fLJQ7OCGsFybdr9ffS0dvi58+0tMFQ7ngoLbFsxmW2pBIF5hYo8e6wgBauRR2OdU9c7Je
	7gDsLisHWZrFNsK1vEGYb+zg3bMQYIHiof/8V/e4Y8vVgtSuPb9IV8wBy0gNVZEH23E1Qy9C/ItRn
	+khmFFZg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v11QA-00000008V6W-1UJD;
	Tue, 23 Sep 2025 11:42:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3836730050D; Tue, 23 Sep 2025 13:42:57 +0200 (CEST)
Date: Tue, 23 Sep 2025 13:42:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 2/2] unwind deferred/x86: Do not defer stack tracing
 for compat tasks
Message-ID: <20250923114257.GV4068168@noisy.programming.kicks-ass.net>
References: <20250827193644.527334838@kernel.org>
 <20250827193828.514833400@kernel.org>
 <20250923104515.GF3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104515.GF3419281@noisy.programming.kicks-ass.net>

On Tue, Sep 23, 2025 at 12:45:15PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 27, 2025 at 03:36:46PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Currently compat tasks are not supported. If a deferred user space stack
> > trace is requested on a compat task, it should fail and return an error so
> > that the profiler can use an alternative approach (whatever it uses
> > today).
> > 
> > Add a arch_unwind_can_defer() macro that is called in
> > unwind_deferred_request(). Have x86 define it to a function that makes
> > sure that the current task is running in 64bit mode, and if it is not, it
> > returns false. This will cause unwind_deferred_request() to error out and
> > the caller can use the current method of user space stack tracing.
> 
> Changelog seems to forget mentioning *why* we can't unwind compat.
> 
> I'm sure I've seen compat FP unwind support at some point in this
> series. Did that go missing somewhere?


I'm thinking something like the below ought to work. That's just about
as complicated as not supporting compat.

---

Subject: unwind: Implement compat fp unwind
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Sep 23 13:27:34 CEST 2025


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_user_types.h |    1 +
 kernel/unwind/user.c              |   25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -36,6 +36,7 @@ struct unwind_user_state {
 	unsigned long				ip;
 	unsigned long				sp;
 	unsigned long				fp;
+	unsigned int				ws;
 	enum unwind_user_type			current_type;
 	unsigned int				available_types;
 	bool					done;
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -15,6 +15,20 @@ static const struct unwind_user_frame fp
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
+static __always_inline int
+get_user_word(unsigned long *word, unsigned long __user *addr, int size)
+{
+#ifdef CONFIG_COMPAT
+	if (size == sizeof(int)) {
+		unsigned int data;
+		int ret = get_user(data, (unsigned int __user *)addr);
+		*word = data;
+		return ret;
+	}
+#endif
+	return get_user(*word, addr);
+}
+
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
 	const struct unwind_user_frame *frame = &fp_frame;
@@ -29,21 +43,23 @@ static int unwind_user_next_fp(struct un
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	cfa += frame->cfa_off;
+	cfa += state->ws * frame->cfa_off;
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	if (cfa & (sizeof(long) - 1))
+	if (cfa & (state->ws - 1))
 		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (get_user_word(&ra, (void __user *)cfa + (state->ws * frame->ra_off),
+			  state->ws))
 		return -EINVAL;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && get_user_word(&fp, (void __user *)cfa +
+					        (state->ws * frame->fp_off), state->ws))
 		return -EINVAL;
 
 	state->ip = ra;
@@ -100,6 +116,7 @@ static int unwind_user_start(struct unwi
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
+	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
 
 	return 0;
 }

---


Subject: unwind_user/x86: Enable frame pointer unwinding on x86
From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Wed, 27 Aug 2025 15:36:45 -0400

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/ptrace.h      |    9 +++++++++
 arch/x86/include/asm/unwind_user.h |   11 +++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -297,6 +297,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -255,6 +255,15 @@ static inline bool any_64bit_mode(struct
 #endif
 }
 
+static inline bool compat_user_mode(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	return !user_64bit_mode(regs);
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_X86_64
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME				\
+	.cfa_off	=  2,				\
+	.ra_off		= -1,				\
+	.fp_off		= -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
