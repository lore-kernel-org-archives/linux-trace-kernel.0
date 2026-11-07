Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071598;
	b=2JFM1YBtt8SHoQgYC5mxdOgFtFNHpX0X6E3jux/6LVB2Kz8JQDPZJ93X8s2aWzIHihZ/
	 rqbCHws36eTdnqZrH6qk3/d+T7+y3Q0aI+lQI+M9gtTYKpNKWf2vN2SyqjNk+W91pb3fp
	 xVbq4QrXp8TT1QZG3VtbY4GZUGUNgMtX+DP7V8986Ju7NMyMOjL6o+UAaLuNDDPIVg0El
	 TwQcYxu9ulRxFNo/5G8OGX0P3asjGMc4XHnUgkujOUyQ3tlUhxoEP7y01jGf967HPrroA
	 7hQtcCZ90AMMBWoUDACPzYcEjBwq2+PAfOJrb7+1EMP4krTUsbFzBIfb+6HVN4MPWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xjQ6Iw+Hv54/R3GAGjgo5o5g8WjFp1eqHmNZYP09gTs=;
	b=c5cKckYuCULXOZdqvSOEM3NUm/3pMknaHd5ehX6zzkUV7hQ3Fmv6C8P9RGDNiLd504Aw
	 srQmTfRIFV0CbARFy86pTLXF+s+W5StFx+ZM2SsepRPD9QbZXdvj+8J5P/pC0DMurQXLL
	 ZIZ0JcPgH7UVSpPk8XDU7BNuOfdWT2Nf0WvRByRKTK1uWdxTmsF29Lu0Vt0Cvr7C7lh1F
	 gmKdUMW9LvwTZf4Gl1E4/XC++Z2Z2mhwTkd+dakoQyoC3iF2vPJogQZlyvi5cRtC+XHmZ
	 thkJDkK5g1a1FeDV7A+j2+Dh+TGmrUhPuUfPsqhNwIwr5qLaoU4j91tctWVdE0NSYmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsRfOqN+;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25021606EE88
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25021606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsRfOqN+
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1761655f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071596; x=1794676396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjQ6Iw+Hv54/R3GAGjgo5o5g8WjFp1eqHmNZYP09gTs=;
        b=qsRfOqN+IX/sbhSTl5Cla35emQkSxBrDb3CPQruxS0QhqgcfEUiFIqIpgannDcSlex
         hM/Uky6OSn85fV1ZjILeEYcbWfsfLCjrTGYsF1aC9RWKzwFXeCMbEZDoUcb7GI1j/emt
         5YY/ND769vkqXs15xUeFj0gV9/M6ep3DVxGxfrSQcPIRPbntXxfBoLYTlwbPjwQEczNu
         fthYBvDLRCudze6Gc1P0sU6TBjxKVvm24F7DxN/9ws8j2L/9u8SarTBUQE0f3XtLhaJd
         DdEfxTnM+VycoAZIuTR0o4M4QdTrsXgOLvAZwmD9wDWt5ZQiKIVK+7hlDUB6vL1DfkFV
         /LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071596; x=1794676396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjQ6Iw+Hv54/R3GAGjgo5o5g8WjFp1eqHmNZYP09gTs=;
        b=r4aXuEeu/A8sSaM1wvCIwo7w5cv8jPOGVapHiMsZYZmos5Hhjuze/Emt/W7nmVPPoF
         2gVH2LpBNwwT240D6ZsOf9fyGlXKETKHrfBWZcDBMHpsrKhMC1FGGnQYMB6qKBwsqdTG
         2pcUGSO/vfNEsaiGuU0WOTiF6ofGmPZjrkJRAQiScBtUseApiNIPlvCljY4HxqfEKJgs
         JDUdw5uxWe1xYt7U2/Na9+NHhQuDE5Q4dLxXsGIfYBbi0Q5GdDcv1T/xkFfZPnk5Yrmq
         Y7xFbkKVUIcuwu4uhMEohp+Gge71YXfYM6MqGGsLce58LBrOG3LjqvgsQkWbJH8b2lm8
         dr4g==
X-Forwarded-Encrypted: i=1; AL+hErFVOT9ZrZfxeG6Qr2GpXtG/UHJwwbyZDtFO+f3yr88UtkPnsV1cuEHDmNC5Nvu7QjN/M0n16stsIfWh9Qxm1VMMemY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E1cN6ANUrASXZzP7Y7Yj3iXbY6k76IOhmL+SNzSejpMUFTAcG
	Tevm7k0qFq4HX0EaETCoWQtnk1O5mLm0VufDRKhDhIwSg6vuFoLwB+3N
X-Gm-Gg: AYBFou031eUTcqtbUQWrUTE0EN6mn+2N8uA+qDsvaAlHYjVCzM8FaOil58aeXEclBfi
	hnPi2u9RdqBi+LschZ671o5YbTdl8lLSzPQQT9+8Sub3KRkr2Jq4+5HMYfj92rq+0QLjVfYuGAB
	dpxngpt19nNWE7lafFOZVdcbaryw7EQgvveYZTmWuNRQfB1ebrhY1yL5z71xqSZtC1YlEKzfMPH
	61Rwu2hHaek+uoxceU4lILUWLAyy3fxOL9ONuXGuaRLAA70vHKijOCASxltyyh80eWQel+0s2DN
	cHOS6dcNKg7nCmcKVTYiiTBY0GTxid6SPi78kUxYjTlkIPHFedrS4p34mwzXIwOtCbMfrjYfEGl
	+Q65pqN9IsI5pk3cRtiblte8EiPWP5lTVApji9aNjwxLbVDtYLROtsQciO6Ed4JhwVuekIOWmWT
	iGzaQD45lebQSurym5HwzCIueCgg0gC58M7XRgMll1wsGkKhJPAp49P/e+g6T/vJ2/vupy8xDL+
	EMhI9A6TciPhPtdZCp3FemJ6suHhFuNNc0LFyxPpobsmcjuk6Qm76v5cvEiwvAHXqv1BbrNqJWo
	OXz7zJNSovn4AfRhJl3grGTDV4QLLNkwmkHEMj6TFXkodU49V4nJPMaGiPryV1vvcbW3EewWj56
	qH55AY38QLAnfrBxNznLoEbSq7C5fAExehjIThENw+91Ar2VUClJBsGY5U0R71cUQmn6NVJS1tG
	A/+rs31Jp5J94GMD8vRh09yoOfFkq64AM=
X-Received: by 2002:a05:6000:178a:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-49273f500f0mr12243251f8f.5.1794071596353;
        Sat, 07 Nov 2026 09:13:16 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:15 -0800 (PST)
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
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/9] rv: Add a monitor for IRQ-exit scheduling ownership
Date: Sat,  7 Nov 2026 18:12:47 +0100
Message-Id: <20261107171252.25090-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
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

Existing scheduler events do not retain the task that owns a
preempt_schedule_irq() invocation after that task switches out.

Add a per-task irqexit hybrid-automaton monitor. It follows an
invocation through entry, suspension, migration, resumption, and return.
Its guards verify hardirq context, local interrupt state, and task
ownership.

The monitor covers preempt_schedule_irq() only. It does not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

The generated model header is reproducible from the included DOT file
with the unmodified rvgen tool.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |  14 ++
 kernel/trace/rv/monitors/irqexit/irqexit.c    | 159 ++++++++++++++++++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |  85 ++++++++++
 .../trace/rv/monitors/irqexit/irqexit_trace.h |  19 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/irq/irqexit.dot     |  21 +++
 8 files changed, 301 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
 create mode 100644 tools/verification/models/irq/irqexit.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index a9238e41806a6..9cdc881b8da29 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -75,6 +75,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
 
 source "kernel/trace/rv/monitors/irq/Kconfig"
 source "kernel/trace/rv/monitors/irqstate/Kconfig"
+source "kernel/trace/rv/monitors/irqexit/Kconfig"
 # Add new irq monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 3c92202933207..90ad2361e0b05 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_IRQ) += monitors/irq/irq.o
 obj-$(CONFIG_RV_MON_IRQSTATE) += monitors/irqstate/irqstate.o
+obj-$(CONFIG_RV_MON_IRQEXIT) += monitors/irqexit/irqexit.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/irqexit/Kconfig b/kernel/trace/rv/monitors/irqexit/Kconfig
new file mode 100644
index 0000000000000..292aae51be19f
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQEXIT
+	depends on RV
+	depends on RV_MON_IRQ
+	default y
+	select HA_MON_EVENTS_ID
+	bool "irqexit monitor"
+	help
+	  Verify that IRQ-exit scheduling starts outside hardirq context
+	  with interrupts disabled and returns to its original task.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irq.rst
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
new file mode 100644
index 0000000000000..f09a6ce5c463a
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
+#include <monitors/irq/irq.h>
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
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_entry_tp, probe_resched_entry);
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_exit_tp, probe_resched_exit);
+	rv_attach_trace_probe("irqexit", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_irqexit(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_entry_tp, probe_resched_entry);
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_exit_tp, probe_resched_exit);
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
+	return rv_register_monitor(&rv_this, &rv_irq);
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
diff --git a/tools/verification/models/irq/irqexit.dot b/tools/verification/models/irq/irqexit.dot
new file mode 100644
index 0000000000000..eb2e5499ad7a7
--- /dev/null
+++ b/tools/verification/models/irq/irqexit.dot
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

