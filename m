Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20214885D;
	Wed, 30 Jul 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879552; cv=none; b=pG80VGwI9XTIjcH62UMH8fDgbmHIMPDeAszhtdRar9Ksr07Ujy2FtXqeJp/6Opu9jEaTPHN/WLXAoSO2lK7p8bg/m6FSLx485/hEozIqt8GF6qWJpK4rAaCw6OvGsdiLbfdWB/+b+Jdbo8GBaDT9CoKz5LfocZJksjGoLRZD/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879552; c=relaxed/simple;
	bh=SG5hsGJtUVJ9pkqGhK5oyhoYPlbt7Y6ZFEaFWl7f/b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvuY81/+5bhua5tQxgwQRb97uQivwpDAk+1Zs+CYFiDu2fsrFurwbcFGpnV+ufFoZEks9uEgRQPXoRhDhE5B/pfVT/oiypk1/KhFAjZehMWHMft8DZIkvAbybW2YNOD9odeMy70yQdZzrfPa38IxSjoewHb19yc+kC6kEMfkkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BpaHdrm/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t80+L40R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BpaHdrm/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t80+L40R"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn7HO/aACdHhIlRnlBToKGaBd3DspogcnJie/zXFTts=;
	b=BpaHdrm/Os6CVyrQFuALeJhjZFLhW/i/PfWaHEIXi1iVkgxS0d7mRgMXeFHc5KYZDLvHXp
	KL3rSiL9eArUd4OzjONwVe/Ysi8BIUE2oOPTVn/AszxaI51keCZEAMD79LESYujA2IsnM8
	UIcqUH5lU6caJ65+YWquHm919+QN46md07hLgWhxueSiczV5NXEbV0gImwCO9GPcB4167i
	SwYnbrCY0phiSDrYoG1rA8TErLCdcJaVosQKCR+eNf9HSPlCjOsRwn09cCsjOuFRovoSjW
	gSdWDiWYE5WBCV5VBqf2YyFjE1QQ56pER/GNE3NGNx0X0Dv+MgnLBMKWVLjlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vn7HO/aACdHhIlRnlBToKGaBd3DspogcnJie/zXFTts=;
	b=t80+L40RAOcgyJUazdJAKICoKEBgVd1a9MTf/6td7j4O/tn1XBCs0W46iDtP2UnUb228lS
	efMDukPPQaD9qACg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 3/5] verification/rvgen/ltl: Support per-cpu monitor generation
Date: Wed, 30 Jul 2025 14:45:41 +0200
Message-Id: <3c7900721428d9091f70302ea9b6c4577c749f63.1753879295.git.namcao@linutronix.de>
In-Reply-To: <cover.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support to generate per-cpu LTL monitors. Similar to generating per-cpu
monitors from .dot files, the "-t per_cpu" parameter can be used to
generate per-cpu monitors from .ltl files.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/ltl2k.py       | 48 ++++++++++++++++---
 .../rvgen/rvgen/templates/ltl2k/main.c        |  9 ++--
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  7 ++-
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/r=
vgen/rvgen/ltl2k.py
index b075f98d50c4..0fd3f9963a87 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -57,9 +57,16 @@ class ltl2k(generator.Monitor):
     template_dir =3D "ltl2k"
=20
     def __init__(self, file_path, MonitorType, extra_params=3D{}):
-        if MonitorType !=3D "per_task":
-            raise NotImplementedError("Only per_task monitor is supported =
for LTL")
+        if MonitorType =3D=3D "per_task":
+            self._target_arg =3D "struct task_struct *task"
+            self._target =3D "task"
+        elif MonitorType =3D=3D "per_cpu":
+            self._target_arg =3D "unsigned int cpu"
+            self._target =3D "cpu"
+        else:
+            raise NotImplementedError(f"LTL does not support monitor type =
{MonitorType}")
         super().__init__(extra_params)
+        self.monitor_type =3D MonitorType
         with open(file_path) as f:
             self.atoms, self.ba, self.ltl =3D ltl2ba.create_graph(f.read())
         self.atoms_abbr =3D abbreviate_atoms(self.atoms)
@@ -67,6 +74,13 @@ class ltl2k(generator.Monitor):
         if not self.name:
             self.name =3D Path(file_path).stem
=20
+    def _fill_monitor_type(self) -> str:
+        if self.monitor_type =3D=3D "per_task":
+            return "#define LTL_MONITOR_TYPE LTL_TASK_MONITOR"
+        if self.monitor_type =3D=3D "per_cpu":
+            return "#define LTL_MONITOR_TYPE LTL_CPU_MONITOR"
+        assert False
+
     def _fill_states(self) -> str:
         buf =3D [
             "enum ltl_buchi_state {",
@@ -174,7 +188,7 @@ class ltl2k(generator.Monitor):
=20
     def _fill_start(self):
         buf =3D [
-            "static void ltl_start(struct task_struct *task, struct ltl_mo=
nitor *mon)",
+            "static void ltl_start(%s, struct ltl_monitor *mon)" % self._t=
arget_arg,
             "{"
         ]
=20
@@ -205,7 +219,7 @@ class ltl2k(generator.Monitor):
         buff =3D []
         buff.append("static void handle_example_event(void *data, /* XXX: =
fill header */)")
         buff.append("{")
-        buff.append("\tltl_atom_update(task, LTL_%s, true/false);" % self.=
atoms[0])
+        buff.append("\tltl_atom_update(%s, LTL_%s, true/false);" % (self._=
target, self.atoms[0]))
         buff.append("}")
         buff.append("")
         return '\n'.join(buff)
@@ -241,6 +255,9 @@ class ltl2k(generator.Monitor):
             ""
         ]
=20
+        buf.append(self._fill_monitor_type())
+        buf.append('')
+
         buf.extend(self._fill_atoms())
         buf.append('')
=20
@@ -259,13 +276,32 @@ class ltl2k(generator.Monitor):
         return '\n'.join(buf)
=20
     def fill_monitor_class_type(self):
-        return "LTL_MON_EVENTS_ID"
+        if self.monitor_type =3D=3D "per_task":
+            return "LTL_MON_EVENTS_ID"
+        if self.monitor_type =3D=3D "per_cpu":
+            return "LTL_MON_EVENTS_IMPLICIT"
+        assert False
=20
     def fill_monitor_class(self):
-        return "ltl_monitor_id"
+        if self.monitor_type =3D=3D "per_task":
+            return "ltl_monitor_id"
+        if self.monitor_type =3D=3D "per_cpu":
+            return "ltl_monitor"
+        assert False
+
+    def fill_tracepoint_args_skel(self, tp_type):
+        if tp_type =3D=3D "event":
+            return \
+                ("\tTP_PROTO(%s, char *states, char *atoms, char *next),\n=
" % self._target_arg) + \
+                ("\tTP_ARGS(%s, states, atoms, next)" % self._target)
+        if tp_type =3D=3D "error":
+            return \
+                ("\tTP_PROTO(%s),\n" % self._target_arg) + \
+                ("\tTP_ARGS(%s)" % self._target)
=20
     def fill_main_c(self):
         main_c =3D super().fill_main_c()
         main_c =3D main_c.replace("%%ATOMS_INIT%%", self.fill_atoms_init())
+        main_c =3D main_c.replace("%%TARGET_ARG%%", self._target_arg)
=20
         return main_c
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/=
verification/rvgen/rvgen/templates/ltl2k/main.c
index f85d076fbf78..09167efbfbf0 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -23,7 +23,7 @@
 #include "%%MODEL_NAME%%.h"
 #include <rv/ltl_monitor.h>
=20
-static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon)
+static void ltl_atoms_fetch(%%TARGET_ARG%%, struct ltl_monitor *mon)
 {
 	/*
 	 * This is called everytime the Buchi automaton is triggered.
@@ -36,13 +36,14 @@ static void ltl_atoms_fetch(struct task_struct *task, s=
truct ltl_monitor *mon)
 	 */
 }
=20
-static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
+static void ltl_atoms_init(%%TARGET_ARG%%, struct ltl_monitor *mon, bool t=
arget_creation)
 {
 	/*
 	 * This should initialize as many atomic propositions as possible.
 	 *
-	 * @task_creation indicates whether the task is being created. This is
-	 * false if the task is already running before the monitor is enabled.
+	 * @target_creation indicates whether the monitored target is being
+	 * created. This is false if the monitor target is already online before
+	 * the monitor is enabled.
 	 */
 %%ATOMS_INIT%%
 }
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h b/tools=
/verification/rvgen/rvgen/templates/ltl2k/trace.h
index 49394c4b0f1c..87d3a1308926 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
@@ -6,9 +6,8 @@
=20
 #ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
 DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *=
next),
-	     TP_ARGS(task, states, atoms, next));
+%%TRACEPOINT_ARGS_SKEL_EVENT%%);
+
 DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+%%TRACEPOINT_ARGS_SKEL_ERROR%%);
 #endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
--=20
2.39.5

