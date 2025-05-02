Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50421AAA11;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204608; cv=none; b=blTVWMfaNT7Ahr9yzZx/4bLS8C9cr725+Rb+uYIgkazRXtW+fHPm1HHG3FKpEv/bTe6hoAvVjHR9+1nFnTFj3TaJ/RwcZ3O4xqcCyG1Rl9qMT0Fgp7yMM7u3EDSQexrm0oIvF+2wWMyawvzaiCn1Ot6JN/IzEZp54JhEiB0Hgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204608; c=relaxed/simple;
	bh=Effmzh0OTcgr3mnTjRN5VssZtRM1VdJM06IBcRTem2U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RY5hY9xy2BqFas/11IluVEydNhKE2jG1MVWIvg2a7s6BCfbkP5sBbyY/PugVjZFFHamD4EvnudlTn/Aojo9HfiaqJyHMNG5eOjKtfIQXcdOogOWCOVbyAiaXcM9L6cURJgmM+VxzOH5WcjtaCHD5T8jowl78CpF9EGWWFoLx6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C12C4CEE9;
	Fri,  2 May 2025 16:50:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaR-000000002zk-2uPL;
	Fri, 02 May 2025 12:50:07 -0400
Message-ID: <20250502165007.549687075@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:47 -0400
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
Subject: [PATCH v7 01/17] unwind_user: Add user space unwinding API
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Introduce a generic API for unwinding user stacks.

In order to expand user space unwinding to be able to handle more complex
scenarios, such as deferred unwinding and reading user space information,
create a generic interface that all architectures can use that support the
various unwinding methods.

This is an alternative method for handling user space stack traces from
the simple stack_trace_save_user() API. This does not replace that
interface, but this interface will be used to expand the functionality of
user space stack walking.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS                       |  8 +++++
 arch/Kconfig                      |  3 ++
 include/linux/unwind_user.h       | 15 +++++++++
 include/linux/unwind_user_types.h | 31 +++++++++++++++++
 kernel/Makefile                   |  1 +
 kernel/unwind/Makefile            |  1 +
 kernel/unwind/user.c              | 55 +++++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+)
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fedcbcba8397..f94b8d05543d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25308,6 +25308,14 @@ F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
 F:	include/linux/uio_driver.h
 
+USERSPACE STACK UNWINDING
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+S:	Maintained
+F:	include/linux/unwind*.h
+F:	kernel/unwind/
+
+
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
 L:	util-linux@vger.kernel.org
diff --git a/arch/Kconfig b/arch/Kconfig
index b0adb665041f..ccbcead9fac0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config UNWIND_USER
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
new file mode 100644
index 000000000000..aa7923c1384f
--- /dev/null
+++ b/include/linux/unwind_user.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_H
+#define _LINUX_UNWIND_USER_H
+
+#include <linux/unwind_user_types.h>
+
+int unwind_user_start(struct unwind_user_state *state);
+int unwind_user_next(struct unwind_user_state *state);
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))
+
+#endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
new file mode 100644
index 000000000000..6ed1b4ae74e1
--- /dev/null
+++ b/include/linux/unwind_user_types.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_TYPES_H
+#define _LINUX_UNWIND_USER_TYPES_H
+
+#include <linux/types.h>
+
+enum unwind_user_type {
+	UNWIND_USER_TYPE_NONE,
+};
+
+struct unwind_stacktrace {
+	unsigned int	nr;
+	unsigned long	*entries;
+};
+
+struct unwind_user_frame {
+	s32 cfa_off;
+	s32 ra_off;
+	s32 fp_off;
+	bool use_fp;
+};
+
+struct unwind_user_state {
+	unsigned long ip;
+	unsigned long sp;
+	unsigned long fp;
+	enum unwind_user_type type;
+	bool done;
+};
+
+#endif /* _LINUX_UNWIND_USER_TYPES_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 434929de17ef..5a2b2be2a32d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -55,6 +55,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
new file mode 100644
index 000000000000..349ce3677526
--- /dev/null
+++ b/kernel/unwind/Makefile
@@ -0,0 +1 @@
+ obj-$(CONFIG_UNWIND_USER) += user.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
new file mode 100644
index 000000000000..d30449328981
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interfaces for unwinding user space
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_user.h>
+
+int unwind_user_next(struct unwind_user_state *state)
+{
+	/* no implementation yet */
+	return -EINVAL;
+}
+
+int unwind_user_start(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	memset(state, 0, sizeof(*state));
+
+	if ((current->flags & PF_KTHREAD) || !user_mode(regs)) {
+		state->done = true;
+		return -EINVAL;
+	}
+
+	state->type = UNWIND_USER_TYPE_NONE;
+
+	state->ip = instruction_pointer(regs);
+	state->sp = user_stack_pointer(regs);
+	state->fp = frame_pointer(regs);
+
+	return 0;
+}
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
+{
+	struct unwind_user_state state;
+
+	trace->nr = 0;
+
+	if (!max_entries)
+		return -EINVAL;
+
+	if (current->flags & PF_KTHREAD)
+		return 0;
+
+	for_each_user_frame(&state) {
+		trace->entries[trace->nr++] = state.ip;
+		if (trace->nr >= max_entries)
+			break;
+	}
+
+	return 0;
+}
-- 
2.47.2


