Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071596;
	b=WlxE38uZ7BAA0qgGGTCznXYEZv8W9wLe3OMsz3H6WFGLJ9fgfl5ngBRA51D6M97eG1Tl
	 TMkOMaJb+udnS00KOM7RUYfMdxLFOKWvrKc9o3BzriHtcVd+51+MPYYW/dwSE91wJokw6
	 wi65gsCxiFQNij2rDXVmYvK1kvA5szAld/i/pUEL/mszuD8vPGDfuXcdcrlpC7Dvm1MKu
	 YlEVMTN5nD5y3yqkiffqrCq7Mi24Qv8tP8Oe49F/dXAagG4T4XRztgwYqbqpJyxg2yoSC
	 xwfpgfrdHqiD4P7KubaScfYYWJMBxoXGAPfCbJnSzjoeTA1P3ektP/Qwk3Z7Rbvg10Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTMlOWbbnRfNiQisiEUTqHwz1SYjVGxkr36fm3glthQ=;
	b=qEXsrdfUdgcyYT3S0mLPBlvTjzFKjRx3Fzr7KOc0K3mgm8yAa7TIKC002bb6R3hm39ED
	 ASDfEmedofvH5R88fKwf5UMVw/oaFsZR87VKBTkAxNL88eZwU9svoQm3CMgu2iSogxMtl
	 zEhsoYezhaHuJW1hoBsBle4Aj99OXIx2CDI4GCGPCl/lClKFTMjJwyCI0eRhWpaO/v6XQ
	 Ldi+HdAWalVPCH/UeRCg0GkyPhAAJrK9FoWdTATHgRTVdDz+/zx49xcvu14+dBiBCYpF7
	 pdlhnPCeia6+fWhxpWpOQ7Zc6viENvt1XJDiy9hlORIfaRtLb2I0PJEvEJaa7YfADYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShxqP9+u;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2922606D814
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 17:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2922606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShxqP9+u
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e4831c028so1672573f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071594; x=1794676394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTMlOWbbnRfNiQisiEUTqHwz1SYjVGxkr36fm3glthQ=;
        b=ShxqP9+uSozG66O4SLtDPfT9hF/bsvW81EczXSps92RRbt3nG6BbPAmiikKqwNgqo6
         L5DSSceiU31siop7lUD0UesDWf9MixNu8xzZ8B3XxWzPnbiwwGfRR7zO9ADHadwF+VpI
         JIYdFfr7cebx0QOqY4dIUIYjkeEqyUCgya6P99gtP/773DthyWBIB4qh9DTmJJ+Gdcl2
         4PUE1c4KvX5e1Zl5guuMrQBwA4hQBBCnxfSBitVwIlslH/y7c6nL3Fb0dduHTUqJiq1J
         DlABRi6aNJLRMnc7ICPIhiAYrw4G1tz9Zcm8fEB+Zrr17eYovRXVr3wlk0Qj5XUEZmD2
         Ar1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071594; x=1794676394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTMlOWbbnRfNiQisiEUTqHwz1SYjVGxkr36fm3glthQ=;
        b=1apdyOLGetqHESjxGrTV03klqn+u1LXZaUK9jr19/lYTqXlwofa8a9pp8SPzB5vdBd
         aw3o1CFwU7hgL3glVx62YBfKtvmzzZIygZ+xVonKLx3mkGviW4dJMfylQiAovuoo3Lyj
         Dc2oORoCzThqMJboPnS8jaVIIOUItqsftJLJGRTVwlrLwnPFjMDE2SGLVR4er2hUJ4oE
         DMsgBiXt6fN54Giy19OANyRrmBU89gZ+vRbCGkLlLl8Jimqq8GFRaYZo+pio7a4NqgDo
         ql/aSGW5siDuw7i5M7GPKJBpt1aw6tzg1S9/nld8HiA7vAu31hzg5l/N1LLSGqlOJDLy
         lNMg==
X-Forwarded-Encrypted: i=1; AL+hErG7AzufQjsQUpg84bD1bZGqKAvBeTRIin6M3IZqn4j2ZvyBJuZTJMHMpYpx5hXvZvOVwD5fU5W5bCHZM9NuusTbovc=@vger.kernel.org
X-Gm-Message-State: APuU4Z90LGbC71wX5cu1VXcuGVuHIomLrc4f6QCLPEkwWYQ+MdKZmvvd
	/heFBwmypHuheulY82deBzonvOJ2XLco4ikbvX/PCpd2sf+e+vN//9hI
X-Gm-Gg: AYBFou1sb0sYLyRPH+5yn8FaP9A5uQM8UzAIXkoAK+GyjlPVCFGdJAR6bVMtjkm3QBg
	PH5Y31CqIUMSSSOd3AJf0MPNbqDD7Wl2/0XR3DcrWf4Of4nb42IWPBdlraGOYC1P9+wg5Q0BLdR
	VTMnAPnFsWao60YMOxvXkfJCtEqfnZp/jSHL6t4uL17QBltXTeQtX8JZ+Ucel+heWFLhj0yHG9M
	pStKyg1M/9oqcOefdgLVwPpyLEcvrIO2RjqrZ+wBuEJbA/CJXGKAqCzzmKXk2p+Y8QeO+byL5M6
	hA9amFK+uSJffz9ReJ6x8WoIbz9Drbs78102g/XZGE4jQqCi7sIYeMZFvEN3+R5fmrgjMIv1T/i
	FwW20QOLn4IDnonvYqUANKjMXmeK/HAl+y27N5VmAE66EJtmmJl0Q7wmXiEHC4NG6oY/9BFh2eG
	CyF7vICfhzekev9TT3iYun119LLrBbD+ha+UVZll+fka0dSOz1ODv7qoU7X9ycF/LjgEf1nN2Ny
	n/FHlbVqt8CjFmaWd2GDkDIl8tNzQF5zUDOx2WOnw9VWiLU3N4sfqrzagf44kn7HQhMLD+53AlO
	ZOVRUGn/7jClhO1IJMXNYxskDtzw0bx0JyBGp+T5XNqQzT/qvFLvxZzUmowYZvYReHrjds3ySxL
	c7pr9UmaBKJR9kpHYfQYpTNPUFNlVmQpfjATy+guls/RaywKHDwZ4uTQDcmGIIWy+PuSbl/fHoo
	O8FsfeILjYCPCQlL77iBnqKAqbh8rPeCb/eEIoThzZiK8TcqXH1+Eu
X-Received: by 2002:a05:6000:2901:b0:48b:59f:db9c with SMTP id ffacd0b85a97d-492775f03ddmr11330970f8f.53.1794071593750;
        Sat, 07 Nov 2026 09:13:13 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:13 -0800 (PST)
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
Subject: [RFC PATCH v2 3/9] rv: Add a monitor for generic IRQ context transitions
Date: Sat,  7 Nov 2026 18:12:46 +0100
Message-Id: <20261107171252.25090-4-kmehltretter@gmail.com>
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

The generic IRQ boundary events expose state transitions, but do not
check their order or whether they agree with live kernel state.

Add an irq container and an irqstate hybrid-automaton monitor. It
checks generic hardirq and serving-softirq nesting against the kernel's
live state. On PREEMPT_RT, it suspends and resumes task-local softirq
state across sched_switch().

The monitor observes only the generic boundary events. It does not observe
NMI entry, architecture-specific intervals before generic IRQ entry or
after generic IRQ exit, or paths that bypass the generic IRQ entry and exit
helpers.

The generated model header is reproducible from the included DOT file
with the unmodified rvgen tool.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/rv/Kconfig                       |   4 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/irq/Kconfig          |  13 +
 kernel/trace/rv/monitors/irq/irq.c            |  35 +++
 kernel/trace/rv/monitors/irq/irq.h            |   3 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |  14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  | 240 ++++++++++++++++++
 kernel/trace/rv/monitors/irqstate/irqstate.h  | 139 ++++++++++
 .../rv/monitors/irqstate/irqstate_trace.h     |  15 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/irq/irqstate.dot    |  32 +++
 11 files changed, 498 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irq/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irq/irq.c
 create mode 100644 kernel/trace/rv/monitors/irq/irq.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
 create mode 100644 tools/verification/models/irq/irqstate.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 9bfd429ffdea2..a9238e41806a6 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -73,6 +73,10 @@ source "kernel/trace/rv/monitors/sssw/Kconfig"
 source "kernel/trace/rv/monitors/opid/Kconfig"
 # Add new sched monitors here
 
+source "kernel/trace/rv/monitors/irq/Kconfig"
+source "kernel/trace/rv/monitors/irqstate/Kconfig"
+# Add new irq monitors here
+
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index c895d81dfdad9..3c92202933207 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
+obj-$(CONFIG_RV_MON_IRQ) += monitors/irq/irq.o
+obj-$(CONFIG_RV_MON_IRQSTATE) += monitors/irqstate/irqstate.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/irq/Kconfig b/kernel/trace/rv/monitors/irq/Kconfig
new file mode 100644
index 0000000000000..598459c2982d6
--- /dev/null
+++ b/kernel/trace/rv/monitors/irq/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQ
+	depends on RV
+	bool "irq monitor"
+	help
+	  Enable the container for monitors which check IRQ execution
+	  context and ordering. Individual monitors can compare hardirq,
+	  softirq, and scheduler events with the kernel's recorded execution
+	  context.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irq.rst
diff --git a/kernel/trace/rv/monitors/irq/irq.c b/kernel/trace/rv/monitors/irq/irq.c
new file mode 100644
index 0000000000000..6542b99f9a7d7
--- /dev/null
+++ b/kernel/trace/rv/monitors/irq/irq.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "irq"
+
+#include "irq.h"
+
+struct rv_monitor rv_irq = {
+	.name = "irq",
+	.description = "IRQ context monitors.",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_irq(void)
+{
+	return rv_register_monitor(&rv_irq, NULL);
+}
+
+static void __exit unregister_irq(void)
+{
+	rv_unregister_monitor(&rv_irq);
+}
+
+module_init(register_irq);
+module_exit(unregister_irq);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irq: IRQ context monitors.");
diff --git a/kernel/trace/rv/monitors/irq/irq.h b/kernel/trace/rv/monitors/irq/irq.h
new file mode 100644
index 0000000000000..18dd4225b3be8
--- /dev/null
+++ b/kernel/trace/rv/monitors/irq/irq.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_irq;
diff --git a/kernel/trace/rv/monitors/irqstate/Kconfig b/kernel/trace/rv/monitors/irqstate/Kconfig
new file mode 100644
index 0000000000000..6accd907f14e4
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQSTATE
+	depends on RV
+	depends on RV_MON_IRQ
+	default y
+	select HA_MON_EVENTS_IMPLICIT
+	bool "irqstate monitor"
+	help
+	  Verify that generic hardirq and softirq context boundaries agree
+	  with the execution context recorded in preempt count.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irq.rst
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate.c b/kernel/trace/rv/monitors/irqstate/irqstate.c
new file mode 100644
index 0000000000000..bc7e9957bc750
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+#include <linux/rv.h>
+#include <linux/tracepoint.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "irqstate"
+
+#include <trace/events/irq.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/irq/irq.h>
+
+#define RV_MON_TYPE RV_MON_PER_CPU
+#include "irqstate.h"
+#include <rv/ha_monitor.h>
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_irqstate env,
+		      u64 time_ns)
+{
+	switch (env) {
+	case hardirq_irqstate:
+		return hardirq_count();
+	case serving_softirq_irqstate:
+		return !!in_serving_softirq();
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
+	if (curr_state == in_hardirq_irqstate && event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 0;
+	else if (curr_state == in_hardirq_irqstate &&
+		 event == softirq_entry_from_hardirq_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == idle_irqstate && event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 0;
+	else if (curr_state == idle_irqstate && event == softirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == idle_irqstate && event == softirq_resume_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0;
+	else if (curr_state == in_softirq_irqstate && event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == in_softirq_irqstate && event == softirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == in_softirq_irqstate && event == softirq_suspend_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0;
+	else if (curr_state == hardirq_from_softirq_irqstate &&
+		 event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == softirq_from_hardirq_irqstate &&
+		 event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == softirq_from_hardirq_irqstate &&
+		 event == softirq_exit_to_hardirq_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == hardirq_from_softirq_from_hardirq_irqstate &&
+		 event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+
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
+static void handle_hardirq_entry(void *data, unsigned int depth)
+{
+	if (!hardirq_count()) {
+		da_handle_start_run_event(hardirq_entry_irqstate);
+		return;
+	}
+
+	/* Nested hardirqs leave the outer context state unchanged. */
+	if (depth > 1)
+		return;
+
+	if (in_serving_softirq())
+		da_handle_event(hardirq_entry_irqstate);
+	else
+		da_handle_start_run_event(hardirq_entry_irqstate);
+}
+
+static void handle_hardirq_exit(void *data, unsigned int depth)
+{
+	if (!hardirq_count()) {
+		da_handle_start_run_event(hardirq_exit_irqstate);
+		return;
+	}
+
+	/* Nested hardirqs leave the outer context state unchanged. */
+	if (depth > 1)
+		return;
+
+	if (in_serving_softirq())
+		da_handle_event(hardirq_exit_irqstate);
+	else
+		da_handle_start_event(hardirq_exit_irqstate);
+}
+
+static void handle_softirq_entry(void *data, bool serving, bool from_hardirq)
+{
+	if (from_hardirq)
+		da_handle_event(softirq_entry_from_hardirq_irqstate);
+	else
+		da_handle_start_run_event(softirq_entry_irqstate);
+}
+
+static void handle_softirq_exit(void *data, bool serving, bool from_hardirq)
+{
+	if (from_hardirq) {
+		da_handle_event(softirq_exit_to_hardirq_irqstate);
+		return;
+	}
+
+	if (in_serving_softirq())
+		da_handle_start_event(softirq_exit_irqstate);
+	else
+		da_handle_start_run_event(softirq_exit_irqstate);
+}
+
+#ifdef CONFIG_PREEMPT_RT
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	/*
+	 * Serving-softirq state belongs to a task on RT. At this tracepoint
+	 * interrupts are disabled and current still names prev. Suspend its
+	 * context before representing the context of the incoming task.
+	 */
+	if (READ_ONCE(prev->softirq_disable_cnt) & SOFTIRQ_OFFSET)
+		da_handle_start_event(softirq_suspend_irqstate);
+	if (READ_ONCE(next->softirq_disable_cnt) & SOFTIRQ_OFFSET)
+		da_handle_start_run_event(softirq_resume_irqstate);
+}
+#endif
+
+static void attach_irqstate(void)
+{
+	rv_attach_trace_probe("irqstate", hardirq_context_entry_tp, handle_hardirq_entry);
+	rv_attach_trace_probe("irqstate", hardirq_context_exit_tp, handle_hardirq_exit);
+	rv_attach_trace_probe("irqstate", softirq_context_entry_tp, handle_softirq_entry);
+	rv_attach_trace_probe("irqstate", softirq_context_exit_tp, handle_softirq_exit);
+#ifdef CONFIG_PREEMPT_RT
+	rv_attach_trace_probe("irqstate", sched_switch, handle_sched_switch);
+	/*
+	 * Drain BH preparations which sampled the entry tracepoint disabled.
+	 * Their RCU read-side protection covers that sample and the serving
+	 * interval. Do not enable the monitor while one can still publish a
+	 * serving bit without its entry event after an IRQ synchronizes idle.
+	 */
+	synchronize_rcu();
+#endif
+}
+
+static void detach_irqstate(void)
+{
+	rv_detach_trace_probe("irqstate", hardirq_context_entry_tp, handle_hardirq_entry);
+	rv_detach_trace_probe("irqstate", hardirq_context_exit_tp, handle_hardirq_exit);
+	rv_detach_trace_probe("irqstate", softirq_context_entry_tp, handle_softirq_entry);
+	rv_detach_trace_probe("irqstate", softirq_context_exit_tp, handle_softirq_exit);
+#ifdef CONFIG_PREEMPT_RT
+	rv_detach_trace_probe("irqstate", sched_switch, handle_sched_switch);
+#endif
+}
+
+static int enable_irqstate(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	attach_irqstate();
+
+	return 0;
+}
+
+static void disable_irqstate(void)
+{
+	rv_this.enabled = 0;
+
+	detach_irqstate();
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "irqstate",
+	.description = "IRQ context boundaries agree with execution state.",
+	.enable = enable_irqstate,
+	.disable = disable_irqstate,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_irqstate(void)
+{
+	return rv_register_monitor(&rv_this, &rv_irq);
+}
+
+static void __exit unregister_irqstate(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_irqstate);
+module_exit(unregister_irqstate);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irqstate: verify IRQ event and execution context agreement");
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate.h b/kernel/trace/rv/monitors/irqstate/irqstate.h
new file mode 100644
index 0000000000000..2459f579c4696
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of irqstate automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME irqstate
+
+enum states_irqstate {
+	idle_irqstate,
+	hardirq_from_softirq_irqstate,
+	hardirq_from_softirq_from_hardirq_irqstate,
+	in_hardirq_irqstate,
+	in_softirq_irqstate,
+	softirq_from_hardirq_irqstate,
+	state_max_irqstate,
+};
+
+#define INVALID_STATE state_max_irqstate
+
+enum events_irqstate {
+	hardirq_entry_irqstate,
+	hardirq_exit_irqstate,
+	softirq_entry_irqstate,
+	softirq_entry_from_hardirq_irqstate,
+	softirq_exit_irqstate,
+	softirq_exit_to_hardirq_irqstate,
+	softirq_resume_irqstate,
+	softirq_suspend_irqstate,
+	event_max_irqstate,
+};
+
+enum envs_irqstate {
+	hardirq_irqstate,
+	serving_softirq_irqstate,
+	env_max_irqstate,
+	env_max_stored_irqstate = hardirq_irqstate,
+};
+
+_Static_assert(env_max_stored_irqstate <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_irqstate {
+	char *state_names[state_max_irqstate];
+	char *event_names[event_max_irqstate];
+	char *env_names[env_max_irqstate];
+	unsigned char function[state_max_irqstate][event_max_irqstate];
+	unsigned char initial_state;
+	bool final_states[state_max_irqstate];
+};
+
+static const struct automaton_irqstate automaton_irqstate = {
+	.state_names = {
+		"idle",
+		"hardirq_from_softirq",
+		"hardirq_from_softirq_from_hardirq",
+		"in_hardirq",
+		"in_softirq",
+		"softirq_from_hardirq",
+	},
+	.event_names = {
+		"hardirq_entry",
+		"hardirq_exit",
+		"softirq_entry",
+		"softirq_entry_from_hardirq",
+		"softirq_exit",
+		"softirq_exit_to_hardirq",
+		"softirq_resume",
+		"softirq_suspend",
+	},
+	.env_names = {
+		"hardirq",
+		"serving_softirq",
+	},
+	.function = {
+		{
+			in_hardirq_irqstate,
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			idle_irqstate,
+			INVALID_STATE,
+			softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			hardirq_from_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			idle_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			idle_irqstate,
+		},
+		{
+			hardirq_from_softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			in_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = idle_irqstate,
+	.final_states = { 1, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_trace.h b/kernel/trace/rv/monitors/irqstate/irqstate_trace.h
new file mode 100644
index 0000000000000..43de706dda7b6
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_RV_MON_IRQSTATE
+DEFINE_EVENT(event_da_monitor, event_irqstate,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_irqstate,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+
+DEFINE_EVENT(error_env_da_monitor, error_env_irqstate,
+	     TP_PROTO(char *state, char *event, char *env),
+	     TP_ARGS(state, event, env));
+#endif /* CONFIG_RV_MON_IRQSTATE */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 2f8a932432c95..040b3635ef289 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -91,6 +91,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 );
 
 #include <monitors/opid/opid_trace.h>
+#include <monitors/irqstate/irqstate_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_IMPLICIT here
 
 #endif
diff --git a/tools/verification/models/irq/irqstate.dot b/tools/verification/models/irq/irqstate.dot
new file mode 100644
index 0000000000000..90c41e8909e4e
--- /dev/null
+++ b/tools/verification/models/irq/irqstate.dot
@@ -0,0 +1,32 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = doublecircle] "idle"};
+	{node [shape = circle] "in_hardirq"};
+	{node [shape = circle] "in_softirq"};
+	{node [shape = circle] "hardirq_from_softirq"};
+	{node [shape = circle] "softirq_from_hardirq"};
+	{node [shape = circle] "hardirq_from_softirq_from_hardirq"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "in_hardirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 0" ];
+	"idle" -> "in_softirq" [ label = "softirq_entry;hardirq == 0 && serving_softirq == 1\nsoftirq_resume;hardirq == 0" ];
+	"in_hardirq" [label = "in_hardirq"];
+	"in_hardirq" -> "idle" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 0" ];
+	"in_hardirq" -> "softirq_from_hardirq" [ label = "softirq_entry_from_hardirq;hardirq == 0 && serving_softirq == 1" ];
+	"in_softirq" [label = "in_softirq"];
+	"in_softirq" -> "idle" [ label = "softirq_exit;hardirq == 0 && serving_softirq == 1\nsoftirq_suspend;hardirq == 0" ];
+	"in_softirq" -> "hardirq_from_softirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 1" ];
+	"hardirq_from_softirq" [label = "hardirq_from_softirq"];
+	"hardirq_from_softirq" -> "in_softirq" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 1" ];
+	"softirq_from_hardirq" [label = "softirq_from_hardirq"];
+	"softirq_from_hardirq" -> "in_hardirq" [ label = "softirq_exit_to_hardirq;hardirq == 0 && serving_softirq == 1" ];
+	"softirq_from_hardirq" -> "hardirq_from_softirq_from_hardirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 1" ];
+	"hardirq_from_softirq_from_hardirq" [label = "hardirq_from_softirq_from_hardirq"];
+	"hardirq_from_softirq_from_hardirq" -> "softirq_from_hardirq" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 1" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.39.5 (Apple Git-154)

