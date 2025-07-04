Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAD2FF497;
	Fri,  4 Jul 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635240; cv=none; b=C0awIcdpYxx1p57KxJ341DVENMDKzaOf2ag65et5LvdP6y3RwuJDlgBD3o8CbPof69bHgcpVPTJda8l4BbWOMSED7XXu27CoiDRicWATxJGhHvn/00V1sNZFhNrwcv6GVG5NeWAS8QmMAZ9XaqQx0TmBFuIm4P18jZD2JIFjhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635240; c=relaxed/simple;
	bh=ej4y0chUHV1X9BRd0j3lK7NyOoVBhIdQuzQiHYUH+3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmYbeGp8/x45XWeCm9y2y+utRvbsTTTt208WszhwOBCbEMPizApQ1YYyd0bosMzaW98+7KJ0M//6TtJfwBqhypSEdwpOYihcFVuoNyd184Qc3I8FhyrFw2jSQunqgDqtume2jKd6VI3CrC6e4c65wmKVhgVhE43ZYfg+k++Kb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fG1fjO6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JGCFPOoP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fG1fjO6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JGCFPOoP"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXMNC3VDuZEOrDVFsrDc68QHYikn2X7hWmfHQcqaREo=;
	b=fG1fjO6C9X9jv7e8Jci03rPUl7C4znaHKn/wzFEi5Mdo0vR3KBO8kC25B0MuOdyVTSUV+v
	gIqeqHDIb9xA4uCDaX9ZznBVr1oLqcKK6LD/TROyfPedfiFDpr5XSvEMXG78JaF1Cx+cRK
	F2o2cPQeL77SeA2nhuPiayEkWdIqHghmMH9UqGXz4rtZcvscHZ0S2vALizOHM99YBQyeff
	HQRg5dKuniXxnet+cH/t+58nDiJ0lGucjFMl+//Yu0Rr/oqiVHSOmLRfF+GAw5C1pwnETw
	Aot97DGv/Io2YA8kkbVqYcgQbsL2/Dk2VucuVZmHLC44R086WBt3dpvgVvR89w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXMNC3VDuZEOrDVFsrDc68QHYikn2X7hWmfHQcqaREo=;
	b=JGCFPOoPTTOmS8eIC2tGih1DzJsJJWSMEr+N5fHahyb+3Sx34XnNs9/+WkxUyKVGbuakG0
	ytmnzQjgNtgO6bCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 13/21] rv: Add support for LTL monitors
Date: Fri,  4 Jul 2025 15:20:05 +0200
Message-Id: <b25b8f29aedf09c76e8357ff280dfd747ea9b435.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While attempting to implement DA monitors for some complex specifications,
deterministic automaton is found to be inappropriate as the specification
language. The automaton is complicated, hard to understand, and
error-prone.

For these cases, linear temporal logic is more suitable as the
specification language.

Add support for linear temporal logic runtime verification monitor.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v11:
  - Keep comments within 80 colums
  - Add '&' to make memset() looks "natural"
  - Split this part out from the bigger patch
---
 include/linux/rv.h         |  63 ++++++++++++-
 include/rv/ltl_monitor.h   | 184 +++++++++++++++++++++++++++++++++++++
 kernel/fork.c              |   5 +-
 kernel/trace/rv/Kconfig    |   7 ++
 kernel/trace/rv/rv_trace.h |  47 ++++++++++
 5 files changed, 298 insertions(+), 8 deletions(-)
 create mode 100644 include/rv/ltl_monitor.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 9428e62eb8e9..1d5579f9b75a 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -10,6 +10,10 @@
 #define MAX_DA_NAME_LEN	32
=20
 #ifdef CONFIG_RV
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/array_size.h>
+
 /*
  * Deterministic automaton per-object variables.
  */
@@ -18,6 +22,59 @@ struct da_monitor {
 	unsigned int	curr_state;
 };
=20
+#ifdef CONFIG_RV_LTL_MONITOR
+
+/*
+ * In the future, if the number of atomic propositions or the size of Buchi
+ * automaton is larger, we can switch to dynamic allocation. For now, the =
code
+ * is simpler this way.
+ */
+#define RV_MAX_LTL_ATOM 32
+#define RV_MAX_BA_STATES 32
+
+/**
+ * struct ltl_monitor - A linear temporal logic runtime verification monit=
or
+ * @states:	States in the Buchi automaton. As Buchi automaton is a
+ *		non-deterministic state machine, the monitor can be in multiple
+ *		states simultaneously. This is a bitmask of all possible states.
+ *		If this is zero, that means either:
+ *		    - The monitor has not started yet (e.g. because not all
+ *		      atomic propositions are known).
+ *		    - There is no possible state to be in. In other words, a
+ *		      violation of the LTL property is detected.
+ * @atoms:	The values of atomic propositions.
+ * @unknown_atoms: Atomic propositions which are still unknown.
+ */
+struct ltl_monitor {
+	DECLARE_BITMAP(states, RV_MAX_BA_STATES);
+	DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
+	DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
+};
+
+static inline bool rv_ltl_valid_state(struct ltl_monitor *mon)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(mon->states); ++i) {
+		if (mon->states[i])
+			return true;
+	}
+	return false;
+}
+
+static inline bool rv_ltl_all_atoms_known(struct ltl_monitor *mon)
+{
+	for (int i =3D 0; i < ARRAY_SIZE(mon->unknown_atoms); ++i) {
+		if (mon->unknown_atoms[i])
+			return false;
+	}
+	return true;
+}
+
+#else
+
+struct ltl_monitor {};
+
+#endif /* CONFIG_RV_LTL_MONITOR */
+
 /*
  * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
  * If we find justification for more monitors, we can think about
@@ -27,11 +84,9 @@ struct da_monitor {
 #define RV_PER_TASK_MONITORS		1
 #define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
=20
-/*
- * Futher monitor types are expected, so make this a union.
- */
 union rv_task_monitor {
-	struct da_monitor da_mon;
+	struct da_monitor	da_mon;
+	struct ltl_monitor	ltl_mon;
 };
=20
 #ifdef CONFIG_RV_REACTORS
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
new file mode 100644
index 000000000000..9a583125b566
--- /dev/null
+++ b/include/rv/ltl_monitor.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * This file must be combined with the $(MODEL_NAME).h file generated by
+ * tools/verification/rvgen.
+ */
+
+#include <linux/args.h>
+#include <linux/rv.h>
+#include <linux/stringify.h>
+#include <linux/seq_buf.h>
+#include <rv/instrumentation.h>
+#include <trace/events/task.h>
+#include <trace/events/sched.h>
+
+#ifndef MONITOR_NAME
+#error "Please include $(MODEL_NAME).h generated by rvgen"
+#endif
+
+#ifdef CONFIG_RV_REACTORS
+#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
+static struct rv_monitor RV_MONITOR_NAME;
+
+static void rv_cond_react(struct task_struct *task)
+{
+	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
+		return;
+	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]: violation=
 detected\n",
+			      task->comm, task->pid);
+}
+#else
+static void rv_cond_react(struct task_struct *task)
+{
+}
+#endif
+
+static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon);
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation);
+
+static struct ltl_monitor *ltl_get_monitor(struct task_struct *task)
+{
+	return &task->rv[ltl_monitor_slot].ltl_mon;
+}
+
+static void ltl_task_init(struct task_struct *task, bool task_creation)
+{
+	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+
+	memset(&mon->states, 0, sizeof(mon->states));
+
+	for (int i =3D 0; i < LTL_NUM_ATOM; ++i)
+		__set_bit(i, mon->unknown_atoms);
+
+	ltl_atoms_init(task, mon, task_creation);
+	ltl_atoms_fetch(task, mon);
+}
+
+static void handle_task_newtask(void *data, struct task_struct *task, unsi=
gned long flags)
+{
+	ltl_task_init(task, true);
+}
+
+static int ltl_monitor_init(void)
+{
+	struct task_struct *g, *p;
+	int ret, cpu;
+
+	ret =3D rv_get_task_monitor_slot();
+	if (ret < 0)
+		return ret;
+
+	ltl_monitor_slot =3D ret;
+
+	rv_attach_trace_probe(name, task_newtask, handle_task_newtask);
+
+	read_lock(&tasklist_lock);
+
+	for_each_process_thread(g, p)
+		ltl_task_init(p, false);
+
+	for_each_present_cpu(cpu)
+		ltl_task_init(idle_task(cpu), false);
+
+	read_unlock(&tasklist_lock);
+
+	return 0;
+}
+
+static void ltl_monitor_destroy(void)
+{
+	rv_detach_trace_probe(name, task_newtask, handle_task_newtask);
+
+	rv_put_task_monitor_slot(ltl_monitor_slot);
+	ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
+}
+
+static void ltl_illegal_state(struct task_struct *task, struct ltl_monitor=
 *mon)
+{
+	CONCATENATE(trace_error_, MONITOR_NAME)(task);
+	rv_cond_react(task);
+}
+
+static void ltl_attempt_start(struct task_struct *task, struct ltl_monitor=
 *mon)
+{
+	if (rv_ltl_all_atoms_known(mon))
+		ltl_start(task, mon);
+}
+
+static inline void ltl_atom_set(struct ltl_monitor *mon, enum ltl_atom ato=
m, bool value)
+{
+	__clear_bit(atom, mon->unknown_atoms);
+	if (value)
+		__set_bit(atom, mon->atoms);
+	else
+		__clear_bit(atom, mon->atoms);
+}
+
+static void
+ltl_trace_event(struct task_struct *task, struct ltl_monitor *mon, unsigne=
d long *next_state)
+{
+	const char *format_str =3D "%s";
+	DECLARE_SEQ_BUF(atoms, 64);
+	char states[32], next[32];
+	int i;
+
+	if (!CONCATENATE(CONCATENATE(trace_event_, MONITOR_NAME), _enabled)())
+		return;
+
+	snprintf(states, sizeof(states), "%*pbl", RV_MAX_BA_STATES, mon->states);
+	snprintf(next, sizeof(next), "%*pbl", RV_MAX_BA_STATES, next_state);
+
+	for (i =3D 0; i < LTL_NUM_ATOM; ++i) {
+		if (test_bit(i, mon->atoms)) {
+			seq_buf_printf(&atoms, format_str, ltl_atom_str(i));
+			format_str =3D ",%s";
+		}
+	}
+
+	CONCATENATE(trace_event_, MONITOR_NAME)(task, states, atoms.buffer, next);
+}
+
+static void ltl_validate(struct task_struct *task, struct ltl_monitor *mon)
+{
+	DECLARE_BITMAP(next_states, RV_MAX_BA_STATES) =3D {0};
+
+	if (!rv_ltl_valid_state(mon))
+		return;
+
+	for (unsigned int i =3D 0; i < RV_NUM_BA_STATES; ++i) {
+		if (test_bit(i, mon->states))
+			ltl_possible_next_states(mon, i, next_states);
+	}
+
+	ltl_trace_event(task, mon, next_states);
+
+	memcpy(mon->states, next_states, sizeof(next_states));
+
+	if (!rv_ltl_valid_state(mon))
+		ltl_illegal_state(task, mon);
+}
+
+static void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, =
bool value)
+{
+	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+
+	ltl_atom_set(mon, atom, value);
+	ltl_atoms_fetch(task, mon);
+
+	if (!rv_ltl_valid_state(mon))
+		ltl_attempt_start(task, mon);
+
+	ltl_validate(task, mon);
+}
+
+static void __maybe_unused ltl_atom_pulse(struct task_struct *task, enum l=
tl_atom atom, bool value)
+{
+	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+
+	ltl_atom_update(task, atom, value);
+
+	ltl_atom_set(mon, atom, !value);
+	ltl_validate(task, mon);
+}
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..1f06559d17bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1886,10 +1886,7 @@ static void copy_oom_score_adj(u64 clone_flags, stru=
ct task_struct *tsk)
 #ifdef CONFIG_RV
 static void rv_task_fork(struct task_struct *p)
 {
-	int i;
-
-	for (i =3D 0; i < RV_PER_TASK_MONITORS; i++)
-		p->rv[i].da_mon.monitoring =3D false;
+	memset(&p->rv, 0, sizeof(p->rv));
 }
 #else
 #define rv_task_fork(p) do {} while (0)
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6cdffc04b73c..6e157f964991 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -11,6 +11,13 @@ config DA_MON_EVENTS_ID
 	select RV_MON_EVENTS
 	bool
=20
+config LTL_MON_EVENTS_ID
+	select RV_MON_EVENTS
+	bool
+
+config RV_LTL_MONITOR
+	bool
+
 menuconfig RV
 	bool "Runtime Verification"
 	depends on TRACING
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 99c3801616d4..fd3111ad1d51 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -127,6 +127,53 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
=20
 #endif /* CONFIG_DA_MON_EVENTS_ID */
+#ifdef CONFIG_LTL_MON_EVENTS_ID
+DECLARE_EVENT_CLASS(event_ltl_monitor_id,
+
+	TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+
+	TP_ARGS(task, states, atoms, next),
+
+	TP_STRUCT__entry(
+		__string(comm, task->comm)
+		__field(pid_t, pid)
+		__string(states, states)
+		__string(atoms, atoms)
+		__string(next, next)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->pid =3D task->pid;
+		__assign_str(states);
+		__assign_str(atoms);
+		__assign_str(next);
+	),
+
+	TP_printk("%s[%d]: (%s) x (%s) -> (%s)", __get_str(comm), __entry->pid,
+		  __get_str(states), __get_str(atoms), __get_str(next))
+);
+
+DECLARE_EVENT_CLASS(error_ltl_monitor_id,
+
+	TP_PROTO(struct task_struct *task),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__string(comm, task->comm)
+		__field(pid_t, pid)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->pid =3D task->pid;
+	),
+
+	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
+);
+// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
+#endif /* CONFIG_LTL_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
=20
 /* This part must be outside protection */
--=20
2.39.5

