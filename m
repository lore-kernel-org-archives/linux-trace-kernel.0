Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F99346AE3;
	Wed, 24 Jun 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289165; cv=none; b=jz2u4Di+aFr/jiKRQ8tYpfYlp5x6yvHI2Ji/VzCigMLTH4TaQG9uPKv0JSZtJepup8kG+ru+UvmugUGhjHmDKvQnIDhkOMVakrjp7oel1XCQSWdcRh5oDE8JrK2ylgpsxYFFHpudh2r/eMtYza1AzFZtXjQWDWk6cSzkibX7r0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289165; c=relaxed/simple;
	bh=YH10X+gOgDltxKUEQHiJhCwM/uko43HaOPyvEfN1mco=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O5vvWqkEptjOMlC2sR5OEOmV++ysU10gBDYmdw5orqeWEfTwfIaeimR1tRiirWwm3PgHwWfl2GGSoCrSUa31JdnkZ0R3OpaDCKuIdW4njgRymt3Zws4GvRiNoLRsaIEwl4P6Wlbtrm9/1vHoBquWng8T5zPzlILVbAU+3P3LOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1WVML7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1WVML7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D263D1F00A3A;
	Wed, 24 Jun 2026 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782289162;
	bh=wFBYgg0R+zxSBOwwOyJZZNY8NzHH4MVmLGGXh8fqtQc=;
	h=Date:From:To:Cc:Subject:References;
	b=C1WVML7GahN8OcGMz2nPcqkt0B3THdp27gUszl0Otu+adw0DX9AbmTDZd6/WZfODf
	 5A1GM8A6HJZ9Hn0or/CcGKqyWq9RKEqhIa/MJXowecihuweVVGqqW/CvJSC7OAvTAm
	 w5QuztjRBBKRbWKcg+WYsfPvTVYWY+V3LzZt4IDahZHLOx9wO827IuitfQ3lda+96L
	 Xfa0nBiEAJw/L1vrsgCpMgtW1lPF+MH3zdb5sIXA3WwhVIpXAs8PuVzexET0rE2qyS
	 ychvY7oAoeHOny1+mgDMhO5kfe4PpQ10UtfLy2iV8D7GyLwVEbNEGz3HPQIUMoKwx+
	 +UY54Gs8A1Sug==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wcIpo-00000002KoF-1BOX;
	Wed, 24 Jun 2026 04:19:48 -0400
Message-ID: <20260624081948.147764194@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 24 Jun 2026 04:18:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 1/2] tracing: Move non-trace_printk prototypes into trace_controls.h
References: <20260624081806.120105649@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the include to trace_printk.h from kernel.h the tracing
control prototypes need to be separated into their own header file as they
are used in other common header files like rcu.h. There's no point in
removing trace_printk.h from kernel.h if it just gets added back to other
common headers.

Prototypes are very cheap for the compiler and should not be an issue.

ftrace_dump() and trace_dump_stack() are also moved into trace_controls.h,
as they are used in cases where things go wrong. The main use case is to
do a trace_dump_stack(); tracing_off(); ftrace_dump(); in a place that
detected that something went wrong, whereas, trace_printk() is added to
normal code during debugging and removed before committing upstream. The
dump code is fine to keep in production.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v2: https://patch.msgid.link/20260622131029.655382134@kernel.org

- Updated the change log

 arch/powerpc/xmon/xmon.c         |  1 +
 arch/s390/kernel/ipl.c           |  1 +
 arch/s390/kernel/machine_kexec.c |  1 +
 drivers/gpu/drm/i915/i915_gem.h  |  1 +
 drivers/tty/sysrq.c              |  1 +
 include/linux/trace_controls.h   | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h     | 51 ------------------------------
 kernel/debug/debug_core.c        |  1 +
 kernel/panic.c                   |  1 +
 kernel/rcu/rcu.h                 |  2 ++
 kernel/rcu/rcutorture.c          |  1 +
 kernel/trace/trace.h             |  1 +
 kernel/trace/trace_benchmark.c   |  1 +
 lib/sys_info.c                   |  1 +
 14 files changed, 67 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/trace_controls.h

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cb3a3244ae6f..2135f319e0dd 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
+#include <linux/trace_controls.h>
 
 #include <asm/ptrace.h>
 #include <asm/smp.h>
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..baac66cc4de4 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -22,6 +22,7 @@
 #include <linux/debug_locks.h>
 #include <linux/vmalloc.h>
 #include <linux/secure_boot.h>
+#include <linux/trace_controls.h>
 #include <asm/asm-extable.h>
 #include <asm/machine.h>
 #include <asm/diag.h>
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..33f9a89eb3ad 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
+#include <linux/trace_controls.h>
 #include <linux/debug_locks.h>
 #include <linux/cpufeature.h>
 #include <asm/guarded_storage.h>
diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index 20b3cb29cfff..1da8fb61c09e 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -116,6 +116,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
 #endif
 
 #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
+#include <linux/trace_controls.h>
 #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
 #define GEM_TRACE_ERR(...) do {						\
 	pr_err(__VA_ARGS__);						\
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699a..d3f72dc430b8 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -324,6 +324,7 @@ static const struct sysrq_key_op sysrq_showstate_blocked_op = {
 };
 
 #ifdef CONFIG_TRACING
+#include <linux/trace_controls.h>
 #include <linux/ftrace.h>
 
 static void sysrq_ftrace_dump(u8 key)
diff --git a/include/linux/trace_controls.h b/include/linux/trace_controls.h
new file mode 100644
index 000000000000..995b97e963b4
--- /dev/null
+++ b/include/linux/trace_controls.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TRACE_CONTROLS_H
+#define _LINUX_TRACE_CONTROLS_H
+
+
+/*
+ * General tracing related utility functions - trace_printk(),
+ * tracing_on/tracing_off and tracing_start()/tracing_stop
+ *
+ * Use tracing_on/tracing_off when you want to quickly turn on or off
+ * tracing. It simply enables or disables the recording of the trace events.
+ * This also corresponds to the user space /sys/kernel/tracing/tracing_on
+ * file, which gives a means for the kernel and userspace to interact.
+ * Place a tracing_off() in the kernel where you want tracing to end.
+ * From user space, examine the trace, and then echo 1 > tracing_on
+ * to continue tracing.
+ *
+ * tracing_stop/tracing_start has slightly more overhead. It is used
+ * by things like suspend to ram where disabling the recording of the
+ * trace is not enough, but tracing must actually stop because things
+ * like calling smp_processor_id() may crash the system.
+ *
+ * Most likely, you want to use tracing_on/tracing_off.
+ */
+enum ftrace_dump_mode {
+	DUMP_NONE,
+	DUMP_ALL,
+	DUMP_ORIG,
+	DUMP_PARAM,
+};
+
+#ifdef CONFIG_TRACING
+void tracing_on(void);
+void tracing_off(void);
+int tracing_is_on(void);
+void tracing_snapshot(void);
+void tracing_snapshot_alloc(void);
+void tracing_start(void);
+void tracing_stop(void);
+void trace_dump_stack(int skip);
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
+#else
+static inline void tracing_start(void) { }
+static inline void tracing_stop(void) { }
+static inline void tracing_on(void) { }
+static inline void tracing_off(void) { }
+static inline int tracing_is_on(void) { return 0; }
+static inline void tracing_snapshot(void) { }
+static inline void tracing_snapshot_alloc(void) { }
+static inline void trace_dump_stack(int skip) { }
+static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
+#endif
+
+#endif /* _LINUX_TRACE_CONTROLS_H */
diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 3d54f440dccf..a488ea9e9f85 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -7,43 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-/*
- * General tracing related utility functions - trace_printk(),
- * tracing_on/tracing_off and tracing_start()/tracing_stop
- *
- * Use tracing_on/tracing_off when you want to quickly turn on or off
- * tracing. It simply enables or disables the recording of the trace events.
- * This also corresponds to the user space /sys/kernel/tracing/tracing_on
- * file, which gives a means for the kernel and userspace to interact.
- * Place a tracing_off() in the kernel where you want tracing to end.
- * From user space, examine the trace, and then echo 1 > tracing_on
- * to continue tracing.
- *
- * tracing_stop/tracing_start has slightly more overhead. It is used
- * by things like suspend to ram where disabling the recording of the
- * trace is not enough, but tracing must actually stop because things
- * like calling smp_processor_id() may crash the system.
- *
- * Most likely, you want to use tracing_on/tracing_off.
- */
-
-enum ftrace_dump_mode {
-	DUMP_NONE,
-	DUMP_ALL,
-	DUMP_ORIG,
-	DUMP_PARAM,
-};
-
 #ifdef CONFIG_TRACING
-void tracing_on(void);
-void tracing_off(void);
-int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
-
-extern void tracing_start(void);
-extern void tracing_stop(void);
-
 static inline __printf(1, 2)
 void ____trace_printk_check_format(const char *fmt, ...)
 {
@@ -149,8 +113,6 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
 extern int __trace_bputs(unsigned long ip, const char *str);
 extern int __trace_puts(unsigned long ip, const char *str);
 
-extern void trace_dump_stack(int skip);
-
 /*
  * The double __builtin_constant_p is because gcc will give us an error
  * if we try to allocate the static variable to fmt if it is not a
@@ -173,19 +135,7 @@ __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
 
 extern __printf(2, 0) int
 __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
 #else
-static inline void tracing_start(void) { }
-static inline void tracing_stop(void) { }
-static inline void trace_dump_stack(int skip) { }
-
-static inline void tracing_on(void) { }
-static inline void tracing_off(void) { }
-static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
-
 static inline __printf(1, 2)
 int trace_printk(const char *fmt, ...)
 {
@@ -196,7 +146,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
 {
 	return 0;
 }
-static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
 #endif
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b276504c1c6b..f9c83a470c98 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -27,6 +27,7 @@
 
 #define pr_fmt(fmt) "KGDB: " fmt
 
+#include <linux/trace_controls.h>
 #include <linux/pid_namespace.h>
 #include <linux/clocksource.h>
 #include <linux/serial_core.h>
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..1415e910371d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -9,6 +9,7 @@
  * This function is used through-out the kernel (including mm and fs)
  * to indicate a major problem.
  */
+#include <linux/trace_controls.h>
 #include <linux/debug_locks.h>
 #include <linux/sched/debug.h>
 #include <linux/interrupt.h>
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..b3e2c8f25a4f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -280,6 +280,8 @@ extern int rcu_cpu_stall_notifiers;
 
 #ifdef CONFIG_RCU_STALL_COMMON
 
+#include <linux/trace_controls.h>
+
 extern int rcu_cpu_stall_ftrace_dump;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 882a158ada7b..76bf0184b267 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -39,6 +39,7 @@
 #include <linux/srcu.h>
 #include <linux/slab.h>
 #include <linux/trace_clock.h>
+#include <linux/trace_controls.h>
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..2537c33ddd49 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
 #include <linux/ftrace_regs.h>
+#include <linux/trace_controls.h>
 #include <linux/llist.h>
 
 #include "pid_list.h"
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index e19c32f2a938..69cc39008c36 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/trace_clock.h>
+#include <linux/trace_controls.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace_benchmark.h"
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..e3c9ca05601b 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
+#include <linux/trace_controls.h>
 #include <linux/string.h>
 #include <linux/sysctl.h>
 
-- 
2.53.0


