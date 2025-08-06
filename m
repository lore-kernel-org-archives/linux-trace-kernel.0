Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031820A5EC;
	Wed,  6 Aug 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467298; cv=none; b=U3RhedeLoM0YA0GFlc8BuSmAuEGxF0ZWbrFwngijsa5ATnQ9d/fcdTCowFduKme3/ST9mcYk55FlPZhO/vnNxrzdi5xZJ8Nnws5rkIGkTw16/1VpyDqggvQcmrcb6UbHF27FmKxKWiej2woZ6t9fp12JEhdr7LGZT1F/fkFynVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467298; c=relaxed/simple;
	bh=8ZQpaVqGZMiSUnYX8EDOyClxHz2CZCaC9dSfVWom550=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGNErEVo3wcgk2p2hO0nfYxS4OZ/XG3FMIPc6h9hgtfaezCiRJKcHMrc2yHLn1jyKWuMVYoyHCAlptn1ZdH/zEZyqoDI2AfC0u+0TzZsyt8KosocEdvcT2ElzPndnaxFFtVzMx6bwRT0OVJfhVuW88gt+nKakrSmGXiFsi7WXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXNVaiXT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YSL8LZr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXNVaiXT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YSL8LZr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754467289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnRAFrkM/lmqxcfi1GIpiaGCyoxcPE5rzhs8o1bC4d8=;
	b=hXNVaiXTyCTfcKjLSo1DfSw+WTfcwYfbAoCYqsXcm0zQxOlp5Qch4yH/wM6I3ibGnJoUdj
	vDdbax0TkPrWcK4Ef5KjjbuCCkTkpsRry3JHguP2Ag8hPNmkzMh475aEK6csFfvlRQqO8G
	F3kkbYL3OVpLYjBWm1L6+Tyv87bg8TdipPJsYblEHk3U5LhjEBeuMl0iD2WAZlsjlh5+t+
	/VTGsOT4RjY1t51XD17nBINjzJc3b2W3r6BId84zUGyAcjynt0frPvK3KGf8RZwfcg1I44
	S5juJt6D0Ho+8bVtfflKSo89eR7vTuZ3yYv5t4OY1uGiRDw7Nh2x9sBX/2P12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754467289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnRAFrkM/lmqxcfi1GIpiaGCyoxcPE5rzhs8o1bC4d8=;
	b=3YSL8LZrXx49xc/4Wf9gd7WwOrspjctFTPD7mS2DTM+qO4E2mKFHNjdRs2EkmsLMCEmQ3y
	U9KNx7MxI2GczHDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 2/5] rv/ltl: Support per-cpu monitors
Date: Wed,  6 Aug 2025 10:01:18 +0200
Message-Id: <8e2b9d37f0543b1c0f78119d459d2294d99c8d4d.1754466623.git.namcao@linutronix.de>
In-Reply-To: <cover.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
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
v2: Rename "implicit" to "cpu"
---
 include/rv/ltl_monitor.h   | 32 ++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig    |  4 ++++
 kernel/trace/rv/rv_trace.h | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 9dabc5b133a3..4ad08b5b9f2d 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -23,12 +23,21 @@
=20
 typedef struct task_struct *monitor_target;
=20
+#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
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
+#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
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
+#elif LTL_MONITOR_TYPE =3D=3D RV_MON_PER_CPU
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
index 5b4be87ba59d..7ef89006ed50 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -16,6 +16,10 @@ config DA_MON_EVENTS_ID
 	select RV_MON_MAINTENANCE_EVENTS
 	bool
=20
+config LTL_MON_EVENTS_CPU
+	select RV_MON_EVENTS
+	bool
+
 config LTL_MON_EVENTS_ID
 	select RV_MON_EVENTS
 	bool
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 4a6faddac614..bf7cca6579ec 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -177,8 +177,54 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 #include <monitors/pagefault/pagefault_trace.h>
 #include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
+
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
=20
+#ifdef CONFIG_LTL_MON_EVENTS_CPU
+DECLARE_EVENT_CLASS(event_ltl_monitor_cpu,
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
+DECLARE_EVENT_CLASS(error_ltl_monitor_cpu,
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
+// Add new monitors based on CONFIG_LTL_MON_EVENTS_CPU here
+
+#endif /* CONFIG_LTL_MON_EVENTS_CPU */
+
 #ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
 /* Tracepoint useful for monitors development, currenly only used in DA */
 TRACE_EVENT(rv_retries_error,
--=20
2.39.5

