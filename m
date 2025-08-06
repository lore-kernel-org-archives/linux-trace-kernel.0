Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BA205AA1;
	Wed,  6 Aug 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467298; cv=none; b=ppiC40snzaYQoQn4TofAqRbkPFUecPBH3rYG+EJe10sVQsYYYlZc+1nEjy16hnFt14Ickhqbvb/HBCCHDof7veK8IHWPJODDKheXivH7btyQE+DB9/jZZPuxAQjiirx/9g4tMRRxk5CYClekcv30Yi229xWElWjJAL92kjSI8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467298; c=relaxed/simple;
	bh=Uesn38aob0MqcbKV3gio0rTGdqwKMtOR7nm2jvHxr4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vF1LEYy9EZKNFKhlxIRzYbUxCxABr0SVxzNMDj43HoJu+nFMZPFctjtQu89fxZus1NH9Tj5vrn/G8ZctkoAAJEHcblxhK1xrYqVtbMrknbk0bmcIRFaePivzlPM11KDA51aE5vHuODYO4hFjAaGm5j3+hvyvpH9CaqYQ5tmCnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03j0tmuS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fXsBEKlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03j0tmuS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXsBEKlV"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754467288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTX3RTvCUX/Mm46SCDPZbioQpsq3KjD49jPHt93BLXs=;
	b=03j0tmuSn4UpxWJJQj6z/P+9XuWbi6fltbN3mVixvyEyvvJbb/oIpQi/G4kOs6qE8Jxy7l
	BL0oYhAjsuSQw4ZxjwYqwHUcpJRKq+dLcmOdtDkaitEWurekLEaexbD4UeO9VF06AA0pvw
	mhIbhC43DP022AXK1tfKmSpDmHqQh/8MuK8pWvqanPw1fNk2TTHOxkaalBjxLQ4hKEj2Vn
	2MpJyA6tITd7X6DgULIO5QUoqOkZfRwOhkEy8M1aCHVO6Ds4+IbO53dOKKI02dJRTPr7nz
	Y38+Z0KXLUwdNhXD8cnL3JjfxfjmcnucdgmrNO3n1yCLsi2UXXsF46M2UU/O7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754467288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTX3RTvCUX/Mm46SCDPZbioQpsq3KjD49jPHt93BLXs=;
	b=fXsBEKlVmyayAWh/cFcO94BIAdjcmqHmFrkFc5OkhhVDvsP5XWBj/+2nVyappRpGXberad
	34zBKhvb+1DyfCBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/5] rv/ltl: Prepare for other monitor types
Date: Wed,  6 Aug 2025 10:01:17 +0200
Message-Id: <b55d857ea6cbecc380d69038886e351e361cf587.1754466623.git.namcao@linutronix.de>
In-Reply-To: <cover.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rv/ltl_monitor.h is the template file used by all LTL monitors. But only
per-task monitor is supported.

Prepare to support for other monitor types:

  - Change the monitored target type into an opaque type which will be
    defined differently depending on the monitor type. This type is only
    defined as struct task_struct * for now.

  - Separate out the per-task-specific printf format and arguments, so that
    rv_cond_react() can be shared with other monitor types.

No functional change intended.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: define the macros for DA usage as well
---
 include/linux/rv.h                            |  4 +
 include/rv/ltl_monitor.h                      | 85 +++++++++++--------
 .../trace/rv/monitors/pagefault/pagefault.h   |  2 +
 kernel/trace/rv/monitors/sleep/sleep.h        |  2 +
 4 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..10a8be730d89 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -13,6 +13,10 @@
 #define MAX_DA_NAME_LEN			32
 #define MAX_DA_RETRY_RACING_EVENTS	3
=20
+#define RV_MON_GLOBAL	0
+#define RV_MON_PER_CPU	1
+#define RV_MON_PER_TASK	2
+
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
 #include <linux/types.h>
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 67031a774e3d..9dabc5b133a3 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -16,49 +16,63 @@
 #error "Please include $(MODEL_NAME).h generated by rvgen"
 #endif
=20
+#if LTL_MONITOR_TYPE =3D=3D RV_MON_PER_TASK
+
+#define TARGET_PRINT_FORMAT "%s[%d]"
+#define TARGET_PRINT_ARGS(task) task->comm, task->pid
+
+typedef struct task_struct *monitor_target;
+
+#endif
+
 #ifdef CONFIG_RV_REACTORS
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
 static struct rv_monitor RV_MONITOR_NAME;
=20
-static void rv_cond_react(struct task_struct *task)
+static void rv_cond_react(monitor_target target)
 {
 	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
 		return;
-	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]: violation=
 detected\n",
-			      task->comm, task->pid);
+
+	RV_MONITOR_NAME.react(
+		"rv: "__stringify(MONITOR_NAME)": "TARGET_PRINT_FORMAT": violation detec=
ted\n",
+		TARGET_PRINT_ARGS(target));
 }
 #else
-static void rv_cond_react(struct task_struct *task)
+static void rv_cond_react(monitor_target target)
 {
 }
 #endif
=20
-static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
+static void ltl_atoms_fetch(monitor_target target, struct ltl_monitor *mon=
);
+static void ltl_atoms_init(monitor_target target, struct ltl_monitor *mon,=
 bool target_creation);
=20
-static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon);
-static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation);
+#if LTL_MONITOR_TYPE =3D=3D RV_MON_PER_TASK
+static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
=20
-static struct ltl_monitor *ltl_get_monitor(struct task_struct *task)
+static struct ltl_monitor *ltl_get_monitor(monitor_target target)
 {
-	return &task->rv[ltl_monitor_slot].ltl_mon;
+	return &target->rv[ltl_monitor_slot].ltl_mon;
 }
+#endif
=20
-static void ltl_task_init(struct task_struct *task, bool task_creation)
+static void ltl_target_init(monitor_target target, bool target_creation)
 {
-	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+	struct ltl_monitor *mon =3D ltl_get_monitor(target);
=20
 	memset(&mon->states, 0, sizeof(mon->states));
=20
 	for (int i =3D 0; i < LTL_NUM_ATOM; ++i)
 		__set_bit(i, mon->unknown_atoms);
=20
-	ltl_atoms_init(task, mon, task_creation);
-	ltl_atoms_fetch(task, mon);
+	ltl_atoms_init(target, mon, target_creation);
+	ltl_atoms_fetch(target, mon);
 }
=20
+#if LTL_MONITOR_TYPE =3D=3D RV_MON_PER_TASK
 static void handle_task_newtask(void *data, struct task_struct *task, unsi=
gned long flags)
 {
-	ltl_task_init(task, true);
+	ltl_target_init(task, true);
 }
=20
 static int ltl_monitor_init(void)
@@ -77,10 +91,10 @@ static int ltl_monitor_init(void)
 	read_lock(&tasklist_lock);
=20
 	for_each_process_thread(g, p)
-		ltl_task_init(p, false);
+		ltl_target_init(p, false);
=20
 	for_each_present_cpu(cpu)
-		ltl_task_init(idle_task(cpu), false);
+		ltl_target_init(idle_task(cpu), false);
=20
 	read_unlock(&tasklist_lock);
=20
@@ -94,17 +108,18 @@ static void ltl_monitor_destroy(void)
 	rv_put_task_monitor_slot(ltl_monitor_slot);
 	ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
 }
+#endif
=20
-static void ltl_illegal_state(struct task_struct *task, struct ltl_monitor=
 *mon)
+static void ltl_illegal_state(monitor_target target, struct ltl_monitor *m=
on)
 {
-	CONCATENATE(trace_error_, MONITOR_NAME)(task);
-	rv_cond_react(task);
+	CONCATENATE(trace_error_, MONITOR_NAME)(target);
+	rv_cond_react(target);
 }
=20
-static void ltl_attempt_start(struct task_struct *task, struct ltl_monitor=
 *mon)
+static void ltl_attempt_start(monitor_target target, struct ltl_monitor *m=
on)
 {
 	if (rv_ltl_all_atoms_known(mon))
-		ltl_start(task, mon);
+		ltl_start(target, mon);
 }
=20
 static inline void ltl_atom_set(struct ltl_monitor *mon, enum ltl_atom ato=
m, bool value)
@@ -117,7 +132,7 @@ static inline void ltl_atom_set(struct ltl_monitor *mon=
, enum ltl_atom atom, boo
 }
=20
 static void
-ltl_trace_event(struct task_struct *task, struct ltl_monitor *mon, unsigne=
d long *next_state)
+ltl_trace_event(monitor_target target, struct ltl_monitor *mon, unsigned l=
ong *next_state)
 {
 	const char *format_str =3D "%s";
 	DECLARE_SEQ_BUF(atoms, 64);
@@ -137,10 +152,10 @@ ltl_trace_event(struct task_struct *task, struct ltl_=
monitor *mon, unsigned long
 		}
 	}
=20
-	CONCATENATE(trace_event_, MONITOR_NAME)(task, states, atoms.buffer, next);
+	CONCATENATE(trace_event_, MONITOR_NAME)(target, states, atoms.buffer, nex=
t);
 }
=20
-static void ltl_validate(struct task_struct *task, struct ltl_monitor *mon)
+static void ltl_validate(monitor_target target, struct ltl_monitor *mon)
 {
 	DECLARE_BITMAP(next_states, RV_MAX_BA_STATES) =3D {0};
=20
@@ -152,35 +167,35 @@ static void ltl_validate(struct task_struct *task, st=
ruct ltl_monitor *mon)
 			ltl_possible_next_states(mon, i, next_states);
 	}
=20
-	ltl_trace_event(task, mon, next_states);
+	ltl_trace_event(target, mon, next_states);
=20
 	memcpy(mon->states, next_states, sizeof(next_states));
=20
 	if (!rv_ltl_valid_state(mon))
-		ltl_illegal_state(task, mon);
+		ltl_illegal_state(target, mon);
 }
=20
-static void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, =
bool value)
+static void ltl_atom_update(monitor_target target, enum ltl_atom atom, boo=
l value)
 {
-	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+	struct ltl_monitor *mon =3D ltl_get_monitor(target);
=20
 	ltl_atom_set(mon, atom, value);
-	ltl_atoms_fetch(task, mon);
+	ltl_atoms_fetch(target, mon);
=20
 	if (!rv_ltl_valid_state(mon)) {
-		ltl_attempt_start(task, mon);
+		ltl_attempt_start(target, mon);
 		return;
 	}
=20
-	ltl_validate(task, mon);
+	ltl_validate(target, mon);
 }
=20
-static void __maybe_unused ltl_atom_pulse(struct task_struct *task, enum l=
tl_atom atom, bool value)
+static void __maybe_unused ltl_atom_pulse(monitor_target target, enum ltl_=
atom atom, bool value)
 {
-	struct ltl_monitor *mon =3D ltl_get_monitor(task);
+	struct ltl_monitor *mon =3D ltl_get_monitor(target);
=20
-	ltl_atom_update(task, atom, value);
+	ltl_atom_update(target, atom, value);
=20
 	ltl_atom_set(mon, atom, !value);
-	ltl_validate(task, mon);
+	ltl_validate(target, mon);
 }
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.h b/kernel/trace/=
rv/monitors/pagefault/pagefault.h
index c580ec194009..d449af84c24c 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.h
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.h
@@ -11,6 +11,8 @@
=20
 #define MONITOR_NAME pagefault
=20
+#define LTL_MONITOR_TYPE RV_MON_PER_TASK
+
 enum ltl_atom {
 	LTL_PAGEFAULT,
 	LTL_RT,
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monit=
ors/sleep/sleep.h
index 2ab46fd218d2..0c87875d9040 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.h
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -11,6 +11,8 @@
=20
 #define MONITOR_NAME sleep
=20
+#define LTL_MONITOR_TYPE RV_MON_PER_TASK
+
 enum ltl_atom {
 	LTL_ABORT_SLEEP,
 	LTL_BLOCK_ON_RT_MUTEX,
--=20
2.39.5

