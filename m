Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645660;
	b=KVfQztuzTi66SeIfX70nY5TsED8nI7r9nDfzl4QToMPC6417ClWZ+4x3yLhwdWvZShCt
	 TGohtkX3w6JNA45TADZkQJG+b5BziopIjqPBe0qEy23lmk/H0WLBGpFhgOsW9ig7qOlYY
	 NxF9pbmW1RNB5F2ntkNk4OU1gc/KzA7n/zcy+JTqS0BsRfHoqjVWxpt3J7Su54S4udJ48
	 4+Q++DOLdkPSke1PFheyU0iPC3N8TxwDbmG78570GE44penv2Eq8+gs5C++n86pfQfREl
	 mzvTwQPevcH5bN8Ffb78tK0ngUcfBNftZpp95Z4E3Kr3e9l+lu/CUip2Z6Hcvuh0F2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
	b=NarEZkNTZNywzVMgVubPRMIBvOBVyhJR6mLEwOi29uD2K+gP17SS/ajyY8cGIXZzqAlc
	 9tHX6G/j8787A/NFWasay76DdlebDHCXmhsAHs0WgMoEKtv+9XXcrYSN2k8PxJpkuueH2
	 fZ94C0ekkkhhz5h6bsPy6eWpcMc54+DzylTqDP/5t5yzxz+/X5dBxfMlisYkBpTe1Ra/Y
	 WJzI+UyIK73zwPsHq8jA5JK94krPG3lR9Mqd/LXW++GoYu0teyoDc7v2WbBUf3KVfZywH
	 N+xrvRA5USLlbCBkKGW0vLUGK+8lULdAOFmUGCa0vL024SajJmqHaG5+UNnhs/aoVkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdS9Xfv2;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAC60A2600
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FAC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdS9Xfv2
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1049136f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645658; x=1793250458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
        b=UdS9Xfv24SqWeysnJOc7FFvHxrmbmyOzpttjGarq+luMvLN3gc1i5OarNXaF1q+XQZ
         piMp2/O0kbnoB5x072H7E48bhRG9BFXYr/YiQGL5N7WT2bS8qpyMQIu5BJI9lzsKeGPG
         ybnE1r51PpegaA7y886I86xemieYQKIirPmw4frgVxeFF58k631E7pm3hhT7kEbgyekC
         2zLSbTvluo3ffoJRMYezFXpZPPeeY7a4UHnddQbsskBbrPnsjcNSk2pvPlo9W4y7MmM6
         7Wux2O5xOAYmooe6Qt85EsHU+EHpZKH9efZ0JfPuiqZon/Mzb9H7HG7WVeL9Nu14dauV
         I1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645658; x=1793250458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
        b=vLbVko3WXOYlXVnqexZBcnDz7NE2cSaEfTKQZ57izdnK3p8IzVaF0EGODkInephsrW
         KVONmJZpxnpdkfUuOaZ2Q7BYclnopglv/mF0nUODjKOEECZFwIDkrWwAEevGAfEI/uS5
         4pE9WBwiP8mztqqFSPzPNZm3WKg0AeKbk3iN0uqV+EodPobFwKyGqM3k5NaOlO75pehg
         3iQDxZCpeLxg/unE79o8DnRz/I95lP2SY6DE6HFocI1VumfczFg6vagj0qf0JxxDMdJP
         kG5Bbnt6bTDHNWm2wJ63DoQJrj/6W2tcNzGKanNHQ5yODFVagy2Uiqkhy7h7TvJmIoCi
         OsJA==
X-Forwarded-Encrypted: i=1; AKwUvBzaGjGkH1Wcec05ETPrEb/g4XTEIetm2r7bMiZaXlqZrPpzRE9nRzH7cEMl0K98zRvlDSgcqY0W2Lbou+r2KCFj/74=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOhQ3bUtYlqHpIt04Jn1XwOI5zQy2hPyZt0iCZ7JFs+VcQdtQU
	aiJ2okEDS5+EFeVoTZ9NVjQf2Z25Y4Ko+WyN2kHfhTbrTjdHZTpt7XoJ
X-Gm-Gg: AYBFou2v6I2WN7c1l+IMe4bAyGlX7ZuFpHoYxbMI3PBbhFvdzhfF6vGyc9Sl5ef7kAE
	AwaNt0pSysnn2lkLtrcsI5XFjTr00nQQXiJiWgGnqtC/Akp/aNMlGqB89VqHWKhEV+fjJyDAmvd
	+1qz7RHkLc31JNUJLoOAALdRLeDZValbGon/n3exCIRMU9knSnaHn/7r12YDaV1eMHreDmL4Jj5
	dVDoBfIJnUa0bcO3dY9S/n4yd4MrruiKTgr90CrqorVsUXrwUX/I+m2boQBo6D3JcEU3YMNqlTY
	qiU+kNn5DswcBB60WRsgfVCGGxewZMleMwZxndcW37gdZElWHRbEYB1avbHSkzTY9w0GXHCGwXa
	ZaADlnswosp+iXgxd5qrRbsZU/qEY6OpNyjyLfbBASAZUh4newGhDt3mRe6f2IOVy/LJGG5Z+BO
	PiFurZ/g1MS4XWNfSA7u8nWEsFkDI2qUduUqk05cc0g58G10t6S+VpcQ6oMJjbAH5GNPmfBsXVi
	3Ij+bFD2aOo07gtpfrs2vksBdACXyfjx5kqwfjnSWdS1KwZF3WD2I2ri8WZEh4qDr/vX+BMF91v
	Jo3C14mqFKlKrCvEdSB36tavcPEL5H3tg5KxobzIYOBjKkJ62lckclon3vvTuclTKwxw7R/h6He
	btgV2/aboWBy/MtC1UHnB4iirhN0QWubFJcYz/IfbRxfLeodaB9LLF6abrMo=
X-Received: by 2002:a05:6000:2901:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-48e2642e9aemr8678202f8f.3.1792645658351;
        Wed, 21 Oct 2026 22:07:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] rv: Add a monitor for IRQ-exit scheduling ownership
Date: Thu, 22 Oct 2026 07:07:07 +0200
Message-Id: <20261022050712.75035-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing scheduler events do not identify the task that owns a
preempt_schedule_irq() invocation after it switches out.

Add irqexit, a per-task hybrid-automaton monitor that follows an
invocation through entry, suspension, migration, resumption, and return.
Its guards check hardirq context, local interrupt state, and task
ownership.

The monitor covers preempt_schedule_irq() only. It does not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

The generated model header is reproducible from the included DOT file
with the unmodified rvgen tool.

Assisted-by: LLM
---
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |  14 ++
 kernel/trace/rv/monitors/irqexit/irqexit.c    | 159 ++++++++++++++++++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |  85 ++++++++++
 .../trace/rv/monitors/irqexit/irqexit_trace.h |  19 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 .../verification/models/irqentry/irqexit.dot  |  21 +++
 8 files changed, 301 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
 create mode 100644 tools/verification/models/irqentry/irqexit.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e7b30668a559b..12854fc9643f9 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -75,6 +75,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
 
 source "kernel/trace/rv/monitors/irqentry/Kconfig"
 source "kernel/trace/rv/monitors/irqstate/Kconfig"
+source "kernel/trace/rv/monitors/irqexit/Kconfig"
 # Add new irqentry monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f39a9f8815764..c9a0bf8d9f9b8 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_IRQENTRY) += monitors/irqentry/irqentry.o
 obj-$(CONFIG_RV_MON_IRQSTATE) += monitors/irqstate/irqstate.o
+obj-$(CONFIG_RV_MON_IRQEXIT) += monitors/irqexit/irqexit.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/irqexit/Kconfig b/kernel/trace/rv/monitors/irqexit/Kconfig
new file mode 100644
index 0000000000000..55d85e3aa3fca
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQEXIT
+	depends on RV
+	depends on RV_MON_IRQENTRY
+	default y
+	select HA_MON_EVENTS_ID
+	bool "irqexit monitor"
+	help
+	  Verify that IRQ-exit scheduling starts outside hardirq context
+	  with interrupts disabled and returns to its original task.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irqentry.rst
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
new file mode 100644
index 0000000000000..a088b28b62b17
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/tracepoint.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "irqexit"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/irqentry/irqentry.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "irqexit.h"
+#include <rv/ha_monitor.h>
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_irqexit env, u64 time_ns)
+{
+	switch (env) {
+	case hardirq_irqexit:
+		return hardirq_count();
+	case irq_off_irqexit:
+		return !!irqs_disabled();
+	case owner_current_irqexit:
+		return ha_get_target(ha_mon) == rv_get_current();
+	default:
+		return ENV_INVALID_VALUE;
+	}
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_irqexit && event == resched_entry_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == idle_irqexit && event == switch_in_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	else if (curr_state == idle_irqexit && event == switch_out_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	else if (curr_state == rescheduling_irqexit && event == resched_exit_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == rescheduling_irqexit && event == switch_out_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == suspended_irqexit && event == switch_in_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	return res;
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns);
+}
+
+static void handle_resched_entry(void *data, struct task_struct *owner)
+{
+	da_handle_start_run_event(owner, resched_entry_irqexit);
+}
+
+static void handle_resched_exit(void *data, struct task_struct *owner)
+{
+	/* Do not hide an invalid return behind enable-mid-invocation sync. */
+	if (owner != rv_get_current() || hardirq_count() || !irqs_disabled())
+		da_handle_start_run_event(owner, resched_exit_irqexit);
+	else
+		da_handle_start_event(owner, resched_exit_irqexit);
+}
+
+static void probe_resched_entry(void *data, struct task_struct *owner,
+				unsigned long pc, bool irq_off)
+{
+	handle_resched_entry(data, owner);
+}
+
+static void probe_resched_exit(void *data, struct task_struct *owner,
+			       unsigned long pc, bool irq_off)
+{
+	handle_resched_exit(data, owner);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	/* current is still prev; the incoming task must not use that guard. */
+	da_handle_event(prev, switch_out_irqexit);
+	da_handle_event(next, switch_in_irqexit);
+}
+
+static int enable_irqexit(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_entry, probe_resched_entry);
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_exit, probe_resched_exit);
+	rv_attach_trace_probe("irqexit", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_irqexit(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_entry, probe_resched_entry);
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_exit, probe_resched_exit);
+	rv_detach_trace_probe("irqexit", sched_switch, handle_sched_switch);
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "irqexit",
+	.description = "Verify IRQ-exit scheduling ownership.",
+	.enable = enable_irqexit,
+	.disable = disable_irqexit,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_irqexit(void)
+{
+	return rv_register_monitor(&rv_this, &rv_irqentry);
+}
+
+static void __exit unregister_irqexit(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_irqexit);
+module_exit(unregister_irqexit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irqexit: verify IRQ-exit scheduling ownership");
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.h b/kernel/trace/rv/monitors/irqexit/irqexit.h
new file mode 100644
index 0000000000000..f48d44d1dff73
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of irqexit automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME irqexit
+
+enum states_irqexit {
+	idle_irqexit,
+	rescheduling_irqexit,
+	suspended_irqexit,
+	state_max_irqexit,
+};
+
+#define INVALID_STATE state_max_irqexit
+
+enum events_irqexit {
+	resched_entry_irqexit,
+	resched_exit_irqexit,
+	switch_in_irqexit,
+	switch_out_irqexit,
+	event_max_irqexit,
+};
+
+enum envs_irqexit {
+	hardirq_irqexit,
+	irq_off_irqexit,
+	owner_current_irqexit,
+	env_max_irqexit,
+	env_max_stored_irqexit = hardirq_irqexit,
+};
+
+_Static_assert(env_max_stored_irqexit <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_irqexit {
+	char *state_names[state_max_irqexit];
+	char *event_names[event_max_irqexit];
+	char *env_names[env_max_irqexit];
+	unsigned char function[state_max_irqexit][event_max_irqexit];
+	unsigned char initial_state;
+	bool final_states[state_max_irqexit];
+};
+
+static const struct automaton_irqexit automaton_irqexit = {
+	.state_names = {
+		"idle",
+		"rescheduling",
+		"suspended",
+	},
+	.event_names = {
+		"resched_entry",
+		"resched_exit",
+		"switch_in",
+		"switch_out",
+	},
+	.env_names = {
+		"hardirq",
+		"irq_off",
+		"owner_current",
+	},
+	.function = {
+		{
+			rescheduling_irqexit,
+			INVALID_STATE,
+			idle_irqexit,
+			idle_irqexit,
+		},
+		{
+			INVALID_STATE,
+			idle_irqexit,
+			INVALID_STATE,
+			suspended_irqexit,
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			rescheduling_irqexit,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = idle_irqexit,
+	.final_states = { 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_trace.h b/kernel/trace/rv/monitors/irqexit/irqexit_trace.h
new file mode 100644
index 0000000000000..f35366875feff
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_IRQEXIT
+DEFINE_EVENT(event_da_monitor_id, event_irqexit,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_irqexit,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_irqexit,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_IRQEXIT */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 040b3635ef289..c90dae4338bcc 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -190,6 +190,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/irqexit/irqexit_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/irqentry/irqexit.dot b/tools/verification/models/irqentry/irqexit.dot
new file mode 100644
index 0000000000000..eb2e5499ad7a7
--- /dev/null
+++ b/tools/verification/models/irqentry/irqexit.dot
@@ -0,0 +1,21 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = doublecircle] "idle"};
+	{node [shape = circle] "rescheduling"};
+	{node [shape = circle] "suspended"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "idle" [ label = "switch_in;hardirq == 0 && irq_off == 1\nswitch_out;hardirq == 0 && irq_off == 1" ];
+	"idle" -> "rescheduling" [ label = "resched_entry;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"rescheduling" [label = "rescheduling"];
+	"rescheduling" -> "idle" [ label = "resched_exit;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"rescheduling" -> "suspended" [ label = "switch_out;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"suspended" [label = "suspended"];
+	"suspended" -> "rescheduling" [ label = "switch_in;hardirq == 0 && irq_off == 1" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.39.5 (Apple Git-154)

