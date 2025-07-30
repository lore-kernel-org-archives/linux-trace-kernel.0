Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479ED7E110;
	Wed, 30 Jul 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879551; cv=none; b=S7HnG2sCAOn0jMmtV/3PfJ0V1fq5nxUUbdzoEU3lC5Breb5AMBfQjDwG91XUBOoZnm2q2J2RTIMMzaSqLlq5DeuaZTbYkpXjOv//qLHFntlQbUSYErr6COONdhcq+mJIIP9pv2nB+4e/UlsktSPY8uFrWP69YC16yDsRqFiVD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879551; c=relaxed/simple;
	bh=I1ppgLn+z/P1wOyVE+T6hdZ7XtSceHZO52uMuEwNRuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfe6Yxq54gV/ULPWU10N19GMor3tALPgGn7pd2MsObhrOLpt1RaV4w4yZXqhmEV/f+ShcsB25WoW6S1etRJCLYZeDoBWJVJHNvu/LVq6JMX+ksA3/hzDbJ2Qp1KKvDkW/OLlnwfHxi10b2tnBs4X89k0kwjdp1ptGGzDSt1tTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ys1be1nK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+/HvBf8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ys1be1nK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+/HvBf8"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+9ZvCAvr7r5DZXouvSSC23q/YVNnxkLHU1EznG+3zQ=;
	b=Ys1be1nKUb5NudMSRrjtttFD+KIJeZYZoIdkI1ndvJK5/BxW1N/55w87Ol4G/7fUWTyl79
	7MrqYWPBAvRSYqzzz0iVBN0Q964LOWYolO232+pe177YXo8BmD1kExTQkbsF5lGMaEh/r+
	dBJ3RlZsK+oDOMx43iS2YnFHM7wTtiOAWGPWW5QFxej554j7iwWsDks+Hxun3nZ5etNY8Z
	JacadZhFvb7zfCf+nqcUAXdUr0B+e/wvrd7O532W30Jmz63jhNzON+qY4nwnlE67bfYdb5
	qa1TkNvhVET6p86ihuh0aFhy116qSBTS+znGu+eUXZ1ihP5uoDVT8NgOX0loNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+9ZvCAvr7r5DZXouvSSC23q/YVNnxkLHU1EznG+3zQ=;
	b=i+/HvBf8zMqgNl6/NpwOboLU9S4i0pkiyWjl6VmAn0xcsAW5IqGUJ/x7/1F+i5yOxUnnXi
	L5Kk0dhe/cKdJWCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/5] rv/ltl: Support per-cpu monitors
Date: Wed, 30 Jul 2025 14:45:40 +0200
Message-Id: <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
In-Reply-To: <cover.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for per-cpu run-time verification linear temporal logic
monitors. This is analogous to deterministic automaton per-cpu monitors.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h         |  1 +
 include/rv/ltl_monitor.h   | 32 ++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig    |  4 ++++
 kernel/trace/rv/rv_trace.h | 47 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 175438a22641..a41ae5980099 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -29,6 +29,7 @@ struct da_monitor {
 #ifdef CONFIG_RV_LTL_MONITOR
=20
 #define LTL_TASK_MONITOR 0
+#define LTL_CPU_MONITOR 1
 /*
  * In the future, if the number of atomic propositions or the size of Buchi
  * automaton is larger, we can switch to dynamic allocation. For now, the =
code
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 466155fd53e6..29bbf86d1a52 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -23,12 +23,21 @@
=20
 typedef struct task_struct *monitor_target;
=20
+#elif LTL_MONITOR_TYPE =3D=3D LTL_CPU_MONITOR
+
+#define TARGET_PRINT_FORMAT "%u"
+#define TARGET_PRINT_ARGS(cpu) cpu
+
+typedef unsigned int monitor_target;
+
 #endif
=20
 #ifdef CONFIG_RV_REACTORS
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
 static struct rv_monitor RV_MONITOR_NAME;
=20
+static struct ltl_monitor *ltl_get_monitor(monitor_target target);
+
 static void rv_cond_react(monitor_target target)
 {
 	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
@@ -54,6 +63,13 @@ static struct ltl_monitor *ltl_get_monitor(monitor_targe=
t target)
 {
 	return &target->rv[ltl_monitor_slot].ltl_mon;
 }
+#elif LTL_MONITOR_TYPE =3D=3D LTL_CPU_MONITOR
+static struct ltl_monitor *ltl_get_monitor(unsigned int cpu)
+{
+	static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
+
+	return per_cpu_ptr(&ltl_monitor, cpu);
+}
 #endif
=20
 static void ltl_target_init(monitor_target target, bool target_creation)
@@ -108,6 +124,22 @@ static void ltl_monitor_destroy(void)
 	rv_put_task_monitor_slot(ltl_monitor_slot);
 	ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
 }
+
+#elif LTL_MONITOR_TYPE =3D=3D LTL_CPU_MONITOR
+
+static int ltl_monitor_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		ltl_target_init(cpu, false);
+	return 0;
+}
+
+static void ltl_monitor_destroy(void)
+{
+}
+
 #endif
=20
 static void ltl_illegal_state(monitor_target target, struct ltl_monitor *m=
on)
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 5b4be87ba59d..951c2e0cda25 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -16,6 +16,10 @@ config DA_MON_EVENTS_ID
 	select RV_MON_MAINTENANCE_EVENTS
 	bool
=20
+config LTL_MON_EVENTS_IMPLICIT
+	select RV_MON_EVENTS
+	bool
+
 config LTL_MON_EVENTS_ID
 	select RV_MON_EVENTS
 	bool
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 4a6faddac614..f9e5fd044c45 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -177,6 +177,53 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 #include <monitors/pagefault/pagefault_trace.h>
 #include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
+
+#ifdef CONFIG_LTL_MON_EVENTS_IMPLICIT
+DECLARE_EVENT_CLASS(event_ltl_monitor,
+
+	TP_PROTO(unsigned int cpu, char *states, char *atoms, char *next),
+
+	TP_ARGS(cpu, states, atoms, next),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+		__string(states, states)
+		__string(atoms, atoms)
+		__string(next, next)
+	),
+
+	TP_fast_assign(
+		__entry->cpu =3D cpu;
+		__assign_str(states);
+		__assign_str(atoms);
+		__assign_str(next);
+	),
+
+	TP_printk("cpu%u: (%s) x (%s) -> (%s)", __entry->cpu,
+		  __get_str(states), __get_str(atoms), __get_str(next))
+);
+
+DECLARE_EVENT_CLASS(error_ltl_monitor,
+
+	TP_PROTO(unsigned int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu =3D cpu;
+	),
+
+	TP_printk("cpu%u: violation detected", __entry->cpu)
+);
+#include <monitors/rts/rts_trace.h>
+// Add new monitors based on CONFIG_LTL_MON_EVENTS_IMPLICIT here
+
+#endif /* CONFIG_LTL_MON_EVENTS_IMPLICIT */
+
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
=20
 #ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
--=20
2.39.5

