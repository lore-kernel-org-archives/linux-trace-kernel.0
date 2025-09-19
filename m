Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B282FBE1A;
	Fri, 19 Sep 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279005; cv=none; b=SBj0PtTqqJZzWdju7yDXhR4I1JmBaIoqvgwONuHrugfuwN5SrIbv8GdrLKARR28FbYoHA2g/mLvo/DZkk6fdTlvTI7excUsy0rjeVzAEbfjNTE+S169Q9jbkJNSlc2AzmYKJkpzk/IW3A6ff+Ld4ZRUfJCRnfgm1YodgFkAR6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279005; c=relaxed/simple;
	bh=acFE/oh1Dc7mGV6VIuQDL65dlXqmFOyHtSOCfH234nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VNcbiDtr4vp67ZOoWu7/Ifxvw2v2Zm1hIIMj+v5miZ2ssBST0xs0yxnFn0LyPAE7Rgwa+X+yAYEBw+TXNH5ZRB2v5YAqtsURMx0Qs6VMhLhdc7VwhUNCT0rlzMMtawncYVwnvJ223Z02ghaP2OD3fo3g8DRoH+k4gxyIXkOgNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GsYR9uuc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bktwdl+7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GsYR9uuc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bktwdl+7"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758279001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NrgksehHdmbItvDaxvO7eMDRhdzNTOYzcCKDnaeckQ=;
	b=GsYR9uuc2nE/aHwLS0Isy41A7POkGFTk3hVfOqBvTjcfQMksmIPiXgGvbqFCpFgqggBHeM
	i+CVAQXiY0b/eHlpymtCHQBgzhpV0GBaHu+ooVWHJxqRAq21NgFNu6yN46zB+UdXq/Bwkd
	FM/NDWLhbE2CtoyEoxRmD8Jpy6qPaPh8rF+KtSyZB9EDQlK4Kc1dK1zLFuGhrN8KEw54Tk
	vjp2FL3sTWcGfhSsmYETItKm0NBsouQwzt/HXwI0iGlLKMoCk6JA07WSMfHX6Ydz0J0Y6G
	trFDscBx0M6WqHtpADU/D60VL0XSQJFygdhNZ6XDJGDYvRTkkkKODx9KbW49vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758279001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NrgksehHdmbItvDaxvO7eMDRhdzNTOYzcCKDnaeckQ=;
	b=Bktwdl+7EBE50XAQt2Prdmcb9+OlVMrqMTEzOjDCcfjeUDKrce0KemwqG2hJ7JL6rcQ7Za
	LsyoN5YSvow+LLAA==
Date: Fri, 19 Sep 2025 12:49:56 +0200
Subject: [PATCH] rv: Add signal reactor
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAFM1zWgC/x3MTQqAIBBA4avErBtQwf6uEi3MphoIizEkCO+et
 PwW770QSZgiDNULQokjn6FA1xX43YWNkJdiMMpY1SuNklDI+fsUjLwFd+BsbdORao1xPZTuElr
 5+Z/jlPMHaDlp8WMAAAA=
X-Change-ID: 20250901-rv-reactor-signal-b5568e0722a9
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758278999; l=5848;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=acFE/oh1Dc7mGV6VIuQDL65dlXqmFOyHtSOCfH234nw=;
 b=gtT9aGm1fDjD2EfUKLAOusauLST9NuH/Wt2S796yrrebjuUcFnlD/jDa5l+Y3hkidPtiiCOyR
 i90MgWqhzaLCadynJlDHPguMJeLbQDRkaA2Z/xXK6QEhjwLd4REc+R2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Reactions of the existing reactors are not easily detectable from programs
and also not easily attributable to the triggering task.
This makes it hard to test the monitors themselves programmatically.

The signal reactors allows applications to validate the correct operations
of monitors either by installing custom signal handlers or by forking a
child and waiting for the expected exit code.

For now only SIGBUS is supported, but additional signals can be added.

As the reactors are called from tracepoints they need to be able to run in
any context. To avoid taking any of the looks used during signal delivery
from an invalid context, schedule it through task_work. The delivery will
be delayed, for example when then sleep monitor detects an invalid sleep.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/Kconfig          |   8 +++
 kernel/trace/rv/Makefile         |   1 +
 kernel/trace/rv/reactor_signal.c | 114 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 5b4be87ba59d3fa5123a64efa746320c9e8b73b1..dc7b546615a67c811ce94c43bb1db2826cd00c77 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -93,3 +93,11 @@ config RV_REACT_PANIC
 	help
 	  Enables the panic reactor. The panic reactor emits a printk()
 	  message if an exception is found and panic()s the system.
+
+config RV_REACT_SIGNAL
+	bool "Signal reactor"
+	depends on RV_REACTORS
+	default y
+	help
+	  Enables the signal reactor. The signal reactors sends a signal to the
+	  task triggering an exception.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 42ff5d5aa9dde3ed2964e0b8d4ab7b236f498319..adf56bbd03ffa0d48de1f0d86ca5fcce1628bdba 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
+obj-$(CONFIG_RV_REACT_SIGNAL) += reactor_signal.o
diff --git a/kernel/trace/rv/reactor_signal.c b/kernel/trace/rv/reactor_signal.c
new file mode 100644
index 0000000000000000000000000000000000000000..e123786d94371a240beb63b2d1b2f3044a466404
--- /dev/null
+++ b/kernel/trace/rv/reactor_signal.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Thomas Weißschuh, Linutronix GmbH
+ *
+ * Signal RV reactor:
+ *   Prints the exception msg to the kernel message log and sends a signal to the offending task.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/rv.h>
+#include <linux/sched/signal.h>
+#include <linux/task_work.h>
+
+struct rv_signal_work {
+	struct callback_head twork;
+	int signal;
+	char message[256];
+};
+
+static mempool_t *rv_signal_task_work_pool;
+
+static void rv_signal_force_sig(int signal, const char *message)
+{
+	/* The message already contains a subsystem prefix, so use raw printk() */
+	printk(KERN_WARNING "%s", message);
+	pr_warn("Killing PID %d with signal %d", task_pid_nr(current), signal);
+	force_sig(signal);
+}
+
+static void rv_signal_task_work(struct callback_head *cbh)
+{
+	struct rv_signal_work *work = container_of_const(cbh, struct rv_signal_work, twork);
+
+	rv_signal_force_sig(work->signal, work->message);
+
+	mempool_free(work, rv_signal_task_work_pool);
+}
+
+static void rv_reaction_signal(int signal, const char *fmt, va_list args)
+{
+	struct rv_signal_work *work;
+	char message[256];
+
+	work = mempool_alloc_preallocated(rv_signal_task_work_pool);
+	if (!work) {
+		pr_warn_ratelimited("Unable to signal through task_work, sending directly\n");
+		vsnprintf(message, sizeof(message), fmt, args);
+		rv_signal_force_sig(signal, message);
+		return;
+	}
+
+	init_task_work(&work->twork, rv_signal_task_work);
+	work->signal = signal;
+	vsnprintf(work->message, sizeof(work->message), fmt, args);
+
+	/*
+	 * The reactor can be called from any context through tracepoints.
+	 * To avoid any locking or other operations not usable from all contexts, use TWA_RESUME.
+	 * The signal might be delayed, but that shouldn't be an issue.
+	 */
+	task_work_add(current, &work->twork, TWA_RESUME);
+}
+
+__printf(1, 2)
+static void rv_reaction_sigbus(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	rv_reaction_signal(SIGBUS, fmt, args);
+	va_end(args);
+}
+
+static struct rv_reactor rv_sigbus = {
+	.name		= "sigbus",
+	.description	= "Kill the current task with SIGBUS",
+	.react		= rv_reaction_sigbus,
+};
+
+static int __init register_react_signal(void)
+{
+	int ret;
+
+	rv_signal_task_work_pool = mempool_create_kmalloc_pool(num_possible_cpus(),
+							       sizeof(struct rv_signal_work));
+	if (!rv_signal_task_work_pool)
+		return -ENOMEM;
+
+	ret = rv_register_reactor(&rv_sigbus);
+	if (ret) {
+		mempool_destroy(rv_signal_task_work_pool);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit unregister_react_signal(void)
+{
+	rv_unregister_reactor(&rv_sigbus);
+	mempool_destroy(rv_signal_task_work_pool);
+}
+
+module_init(register_react_signal);
+module_exit(unregister_react_signal);
+
+MODULE_AUTHOR("Thomas Weißschuh <thomas.weissschuh@linutronix.de>");
+MODULE_DESCRIPTION("signal rv reactor: send a signal if an exception is found.");

---
base-commit: adbdaac63f5024a9a117ef8ce9732a4272fbc931
change-id: 20250901-rv-reactor-signal-b5568e0722a9

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

