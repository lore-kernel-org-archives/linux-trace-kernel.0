Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187D28C5B7;
	Tue, 10 Jun 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548653; cv=none; b=AI4IVuJXWJMT2pNXM6ASjqqpKpEPFnEoLCYxVb4dDeL0w1HzqFPBq+kHJ4WcWUSWV0TLR7IHKsDM3D5WxLZMkZ3nsu+hrtlOUZwcmeEWRkeDkdaK1EFn5VBBn/OM/7ua+N7ohdY/U0UmVrb1v+AqRcPAEiRewzDsB+Ftf5RVf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548653; c=relaxed/simple;
	bh=cTg1xb18zgH9esrPCVvfiTYuWd593K8d70hNzbBTtLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p++hRWz4DxDcyNZqXToaFl+jb5wT6u9GIKMU5GCwAYs8EVkedmLDltmu5wDes4HL6cSM3zVBk5alolLHmNrvJV40sNp+cnpFmiszOkDZrzrBlFmAvnSQdB6kxu7BZ0Ry5QLHqWWcG9/uoqzHz9I9F7SEU/X0oLzxxt/ybTHFNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hts1rAyS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vU0Sm/OY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hts1rAyS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vU0Sm/OY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVwCLmEpXouiVk0eHeIAfNwYheUHCOYcywBYf9wPGSs=;
	b=hts1rAySLdmUVlrsO2VJ2R7wqNBE/vqk5jCPPmIwkRgrzTaPNhvln/G6EgbKQrJGrmQlEL
	AU6Q9usxYeMpZV7OrDNA00sGBM+AIpZ7v0ubu1ckXgMcJBghOUmBg/yhe3yekG+9xvbO8t
	b8zu0OvhPHAwlN+KeXO38AszlryAQhCAMqMrD+cEKaNgsJltqtpk8ilw40MveQ3sTQvm3i
	zP0xtMimw0/oFwzKy6wOx0EzjL8l/oi0zYP+yQJDTOr4Smm99h5OJ/aBRtLgkeD00rOUWZ
	atczqUazi9h8wsYfozrJiB5FpPl/WG25hZWkUUf4xU7tb7RH/XJLwzk0X7z1iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVwCLmEpXouiVk0eHeIAfNwYheUHCOYcywBYf9wPGSs=;
	b=vU0Sm/OYQn/erO+OOmR4zzzUf5/7OnG156ffVbi0PR79sJyuX+4Kt2olp1TLULODqHyoJA
	qUpCu7hVRrG0f3BQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 13/19] rv: Add support for LTL monitors
Date: Tue, 10 Jun 2025 11:43:38 +0200
Message-Id: <1750e36e7b445cbba283cd564b07e16dcd65aac5.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

While attempting to implement DA monitors for some complex specifications,
deterministic automaton is found to be inappropriate as the specification
language. The automaton is complicated, hard to understand, and
error-prone.

For these cases, linear temporal logic is more suitable as the
specification language.

Add support for linear temporal logic runtime verification monitor.

For all the details, see the documentations added by this commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/index.rst              |   1 +
 .../trace/rv/linear_temporal_logic.rst        | 122 ++++
 Documentation/trace/rv/monitor_synthesis.rst  | 141 ++++-
 include/linux/rv.h                            |  62 +-
 include/rv/ltl_monitor.h                      | 184 ++++++
 kernel/fork.c                                 |   5 +-
 kernel/trace/rv/Kconfig                       |   7 +
 kernel/trace/rv/rv_trace.h                    |  47 ++
 tools/verification/rvgen/.gitignore           |   3 +
 tools/verification/rvgen/Makefile             |   2 +
 tools/verification/rvgen/__main__.py          |   3 +-
 tools/verification/rvgen/rvgen/ltl2ba.py      | 540 ++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       | 245 ++++++++
 .../rvgen/rvgen/templates/ltl2k/main.c        | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  14 +
 15 files changed, 1453 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 include/rv/ltl_monitor.h
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index 8e411b76ec824..2a27f6bc94294 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,6 +8,7 @@ Runtime Verification
=20
    runtime-verification.rst
    deterministic_automata.rst
+   linear_temporal_logic.rst
    monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentati=
on/trace/rv/linear_temporal_logic.rst
new file mode 100644
index 0000000000000..9dc1de4ca9349
--- /dev/null
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -0,0 +1,122 @@
+Linear temporal logic
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+Runtime verification monitor is a verification technique which checks that=
 the kernel follows a
+specification. It does so by using tracepoints to monitor the kernel's exe=
cution trace, and
+verifying that the execution trace sastifies the specification.
+
+Initially, the specification can only be written in the form of determinis=
tic automaton (DA).
+However, while attempting to implement DA monitors for some complex specif=
ications, deterministic
+automaton is found to be inappropriate as the specification language. The =
automaton is complicated,
+hard to understand, and error-prone.
+
+Thus, RV monitors based on linear temporal logic (LTL) are introduced. Thi=
s type of monitor uses LTL
+as specification instead of DA. For some cases, writing the specification =
as LTL is more concise and
+intuitive.
+
+Many materials explain LTL in details. One book is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, Th=
e MIT Press, 2008.
+
+Grammar
+-------
+
+Unlike some existing syntax, kernel's implementation of LTL is more verbos=
e. This is motivated by
+considering that the people who read the LTL specifications may not be wel=
l-versed in LTL.
+
+Grammar:
+    ltl ::=3D opd | ( ltl ) | ltl binop ltl | unop ltl
+
+Operands (opd):
+    true, false, user-defined names consisting of upper-case characters, d=
igits, and underscore.
+
+Unary Operators (unop):
+    always
+    eventually
+    not
+
+Binary Operators (binop):
+    until
+    and
+    or
+    imply
+    equivalent
+
+This grammar is ambiguous: operator precedence is not defined. Parentheses=
 must be used.
+
+Example linear temporal logic
+-----------------------------
+.. code-block::
+
+   RAIN imply (GO_OUTSIDE imply HAVE_UMBRELLA)
+
+means: if it is raining, going outside means having an umbrella.
+
+.. code-block::
+
+   RAIN imply (WET until not RAIN)
+
+means: if it is raining, it is going to be wet until the rain stops.
+
+.. code-block::
+
+   RAIN imply eventually not RAIN
+
+means: if it is raining, rain will eventually stop.
+
+The above examples are referring to the current time instance only. For ke=
rnel verification, the
+`always` operator is usually desirable, to specify that something is alway=
s true at the present and
+for all future. For example::
+
+    always (RAIN imply eventually not RAIN)
+
+means: *all* rain eventually stops.
+
+In the above examples, `RAIN`, `GO_OUTSIDE`, `HAVE_UMBRELLA` and `WET` are=
 the "atomic
+propositions".
+
+Monitor synthesis
+-----------------
+
+To synthesize an LTL into a kernel monitor, the `rvgen` tool can be used:
+`tools/verification/rvgen`. The specification needs to be provided as a fi=
le, and it must have a
+"RULE =3D LTL" assignment. For example::
+
+    RULE =3D always (ACQUIRE imply ((not KILLED and not CRASHED) until REL=
EASE))
+
+which says: if `ACQUIRE`, then `RELEASE` must happen before `KILLED` or `C=
RASHED`.
+
+The LTL can be broken down using sub-expressions. The above is equivalent =
to:
+
+   .. code-block::
+
+    RULE =3D always (ACQUIRE imply (ALIVE until RELEASE))
+    ALIVE =3D not KILLED and not CRASHED
+
+From this specification, `rvgen` generates the C implementation of a Buchi=
 automaton - a
+non-deterministic state machine which checks the satisfiability of the LTL=
. See
+Documentation/trace/rv/monitor_synthesis.rst for details on using `rvgen`.
+
+References
+----------
+
+One book covering model checking and linear temporal logic is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, Th=
e MIT Press, 2008.
+
+For an example of using linear temporal logic in software testing, see::
+
+  Ruijie Meng, Zhen Dong, Jialin Li, Ivan Beschastnikh, and Abhik Roychoud=
hury. 2022. Linear-time
+  temporal logic guided greybox fuzzing. In Proceedings of the 44th Intern=
ational Conference on
+  Software Engineering (ICSE '22). Association for Computing Machinery, Ne=
w York, NY, USA,
+  1343=E2=80=931355. https://doi.org/10.1145/3510003.3510082
+
+The kernel's LTL monitor implementation is based on::
+
+  Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996). Simple On-the-fly =
Automatic Verification of
+  Linear Temporal Logic. In: Dembi=C5=84ski, P., =C5=9Aredniawa, M. (eds) =
Protocol Specification, Testing and
+  Verification XV. PSTV 1995. IFIP Advances in Information and Communicati=
on Technology. Springer,
+  Boston, MA. https://doi.org/10.1007/978-0-387-34892-6_1
diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/t=
race/rv/monitor_synthesis.rst
index 85624062073b0..aa532f10c2116 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -39,16 +39,17 @@ below::
 RV monitor synthesis
 --------------------
=20
-The synthesis of automata-based models into the Linux *RV monitor* abstrac=
tion
-is automated by the rvgen tool and the rv/da_monitor.h header file that
-contains a set of macros that automatically generate the monitor's code.
+The synthesis of a specification into the Linux *RV monitor* abstraction i=
s automated by the rvgen
+tool and the header file containing common code for creating monitors. The=
 header files are:
+
+  * rv/da_monitor.h for deterministic automaton monitor.
+  * rv/ltl_monitor.h for linear temporal logic monitor.
=20
 rvgen
 -----
=20
-The rvgen utility leverages dot2c by converting an automaton model in
-the DOT format into the C representation [1] and creating the skeleton of
-a kernel monitor in C.
+The rvgen utility converts a specification into the C presentation and cre=
ating the skeleton of a
+kernel monitor in C.
=20
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
@@ -63,18 +64,34 @@ This will create a directory named wip/ with the follow=
ing files:
 The wip.c file contains the monitor declaration and the starting point for
 the system instrumentation.
=20
-Monitor macros
---------------
+Similarly, a linear temporal logic monitor can be generated with the follo=
wing command::
+
+  $ rvgen monitor -c ltl -s pagefault.ltl -t per_task
+
+This generates pagefault/ directory with:
+
+- pagefault.h: The Buchi automaton (the non-deterministic state machine to=
 verify the specification)
+- pagefault.c: The skeleton for the RV monitor
+
+Monitor header files
+--------------------
+
+The header files:
+
+- `rv/da_monitor.h` for deterministic automaton monitor
+- `rv/ltl_monitor` for linear temporal logic monitor
+
+include common macros and static functions for implementing *Monitor Insta=
nce(s)*.
=20
-The rv/da_monitor.h enables automatic code generation for the *Monitor
-Instance(s)* using C macros.
+The benefits of having all common functionalities in a single header file =
are 3-fold:
=20
-The benefits of the usage of macro for monitor synthesis are 3-fold as it:
+  - Reduce the code duplication;
+  - Facilitate the bug fix/improvement;
+  - Avoid the case of developers changing the core of the monitor code to =
manipulate the model in a
+    (let's say) non-standard way.
=20
-- Reduces the code duplication;
-- Facilitates the bug fix/improvement;
-- Avoids the case of developers changing the core of the monitor code
-  to manipulate the model in a (let's say) non-standard way.
+rv/da_monitor.h
++++++++++++++++
=20
 This initial implementation presents three different types of monitor inst=
ances:
=20
@@ -130,10 +147,102 @@ While the event "preempt_enabled" will use::
 To notify the monitor that the system will be returning to the initial sta=
te,
 so the system and the monitor should be in sync.
=20
+rv/ltl_monitor.h
+++++++++++++++++
+This file must be combined with the $(MODEL_NAME).h file (generated by `rv=
gen`) to be complete. For
+example, for the `pagefault` monitor, the `pagefault.c` source file must i=
nclude::
+
+  #include "pagefault.h"
+  #include <rv/ltl_monitor.h>
+
+(the skeleton monitor file generated by `rvgen` already does this).
+
+`$(MODEL_NAME).h` (`pagefault.h` in the above example) includes the implem=
entation of the Buchi
+automaton - a non-deterministic state machine that verifies the LTL specif=
ication. While
+`rv/ltl_monitor.h` includes the common helper functions to interact with t=
he Buchi automaton and to
+implement an RV monitor. An important definition in `$(MODEL_NAME).h` is::
+
+  enum ltl_atom {
+      LTL_$(FIRST_ATOMIC_PROPOSITION),
+      LTL_$(SECOND_ATOMIC_PROPOSITION),
+      ...
+      LTL_NUM_ATOM
+  };
+
+which is the list of atomic propositions present in the LTL specification =
(prefixed with "LTL\_" to
+avoid name collision). This `enum` is passed to the functions interacting =
with the Buchi automaton.
+
+While generating code, `rvgen` cannot understand the meaning of the atomic=
 propositions. Thus, that
+task is left for manual work. The recommended pratice is adding tracepoint=
s to places where the
+atomic propositions change; and in the tracepoints' handlers: the Buchi au=
tomaton is executed
+using::
+
+  void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, bool =
value)
+
+which tells the Buchi automaton that the atomic proposition `atom` is now =
`value`. The Buchi
+automaton checks whether the LTL specification is still satisfied, and inv=
okes the monitor's error
+tracepoint and the reactor if violation is detected.
+
+Tracepoints and `ltl_atom_update()` should be used whenever possible. Howe=
ver, it is sometimes not
+the most convenient. For some atomic propositions which are changed in mul=
tiple places in the
+kernel, it is cumbersome to trace all those places. Furthermore, it may no=
t be important that the
+atomic propositions are updated at precise times. For example, considering=
 the following linear
+temporal logic::
+
+  RULE =3D always (RT imply not PAGEFAULT)
+
+This LTL states that a real-time task does not raise page faults. For this=
 specification, it is not
+important when `RT` changes, as long as it has the correct value when `PAG=
EFAULT` is true.
+Motivated by this case, another function is introduced::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+
+This function is called whenever the Buchi automaton is triggered. Therefo=
re, it can be manually
+implemented to "fetch" `RT`::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+  }
+
+Effectively, whenever `PAGEFAULT` is updated with a call to `ltl_atom_upda=
te()`, `RT` is also
+fetched. Thus, the LTL specification can be verified without tracing `RT` =
everywhere.
+
+For atomic propositions which act like events, they usually need to be set=
 (or cleared) and then
+immediately cleared (or set). A convenient function is provided::
+
+  void ltl_atom_pulse(struct task_struct *task, enum ltl_atom atom, bool v=
alue)
+
+which is equivalent to::
+
+  ltl_atom_update(task, atom, value);
+  ltl_atom_update(task, atom, !value);
+
+To initialize the atomic propositions, the following function must be impl=
emented::
+
+  ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool t=
ask_creation)
+
+This function is called for all running tasks when the monitor is enabled.=
 It is also called for new
+tasks created after the enabling the monitor. It should initialize as many=
 atomic propositions as
+possible, for example::
+
+  void ltl_atom_init(struct task_struct *task, struct ltl_monitor *mon, bo=
ol task_creation)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+      if (task_creation)
+          ltl_atom_set(mon, LTL_PAGEFAULT, false);
+  }
+
+Atomic propositions not initialized by `ltl_atom_init()` will stay in the =
unknown state until
+relevant tracepoints are hit, which can take some time. As monitoring for =
a task cannot be done
+until all atomic propositions is known for the task, the monitor may need =
some time to start
+validating tasks which have been running before the monitor is enabled. Th=
erefore, it is recommended
+to start the tasks of interest after enabling the monitor.
+
 Final remarks
 -------------
=20
-With the monitor synthesis in place using the rv/da_monitor.h and
+With the monitor synthesis in place using the header files and
 rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
=20
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 9428e62eb8e90..2897aad168831 100644
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
@@ -18,6 +22,58 @@ struct da_monitor {
 	unsigned int	curr_state;
 };
=20
+#ifdef CONFIG_RV_LTL_MONITOR
+
+/*
+ * In the future, if the number of atomic propositions or the size of Buch=
i automaton is larger, we
+ * can switch to dynamic allocation. For now, the code is simpler this way.
+ */
+#define RV_MAX_LTL_ATOM 32
+#define RV_MAX_BA_STATES 32
+
+/**
+ * struct ltl_monitor - A linear temporal logic runtime verification monit=
or
+ * @states:	States in the Buchi automaton. As Buchi automaton is a
+ *		non-deterministic state machine, the monitor can be in multiple states
+ *		simultaneously. This is a bitmask of all possible states.
+ *		If this is zero, that means either:
+ *		    - The monitor has not started yet (e.g. because not all atomic pro=
positions are
+ *		      known).
+ *		    - there is no possible state to be in. In other words, a violation=
 of the
+ *		      LTL property is detected.
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
@@ -27,11 +83,9 @@ struct da_monitor {
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
index 0000000000000..78f5a11976659
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
+#error "MONITOR_NAME macro is not defined. Did you include $(MODEL_NAME).h=
 generated by rvgen?"
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
index 1ee8eb11f38ba..b258728792e09 100644
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
+	memset(p->rv, 0, sizeof(p->rv));
 }
 #else
 #define rv_task_fork(p) do {} while (0)
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6cdffc04b73c2..6e157f9649915 100644
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
index 99c3801616d40..27698c5791a04 100644
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
+	TP_printk("%s[%d]: (%s) x (%s) -> (%s)", __get_str(comm), __entry->pid, _=
_get_str(states),
+		  __get_str(atoms), __get_str(next))
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
diff --git a/tools/verification/rvgen/.gitignore b/tools/verification/rvgen=
/.gitignore
new file mode 100644
index 0000000000000..1e288a076560e
--- /dev/null
+++ b/tools/verification/rvgen/.gitignore
@@ -0,0 +1,3 @@
+__pycache__/
+parser.out
+parsetab.py
diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/M=
akefile
index cca8c9ba82e8b..cfc4056c1e87a 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -21,5 +21,7 @@ install:
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
 	$(INSTALL) rvgen/container.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/containe=
r.py
 	$(INSTALL) rvgen/generator.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/generato=
r.py
+	$(INSTALL) rvgen/ltl2ba.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2ba.py
+	$(INSTALL) rvgen/ltl2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2k.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
 	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvge=
n/__main__.py
index 63ecf0c370343..fa6fc1f4de2f7 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -12,6 +12,7 @@ if __name__ =3D=3D '__main__':
     from rvgen.dot2k import dot2k
     from rvgen.generator import Monitor
     from rvgen.container import Container
+    from rvgen.ltl2k import ltl2k
     import argparse
     import sys
=20
@@ -44,7 +45,7 @@ if __name__ =3D=3D '__main__':
             if params.monitor_class =3D=3D "da":
                 monitor =3D dot2k(params.spec, params.monitor_type, vars(p=
arams))
             elif params.monitor_class =3D=3D "ltl":
-                raise NotImplementedError
+                monitor =3D ltl2k(params.spec, params.monitor_type, vars(p=
arams))
             else:
                 print("Unknown monitor class:", params.monitor_class)
                 sys.exit(1)
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/=
rvgen/rvgen/ltl2ba.py
new file mode 100644
index 0000000000000..d11840af7f5fd
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -0,0 +1,540 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Implementation based on
+# Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996).
+# Simple On-the-fly Automatic Verification of Linear Temporal Logic.
+# https://doi.org/10.1007/978-0-387-34892-6_1
+# With extra optimizations
+
+from ply.lex import lex
+from ply.yacc import yacc
+
+# Grammar:
+# 	ltl ::=3D opd | ( ltl ) | ltl binop ltl | unop ltl
+#
+# Operands (opd):
+# 	true, false, user-defined names
+#
+# Unary Operators (unop):
+#       always
+#       eventually
+#       not
+#
+# Binary Operators (binop):
+#       until
+#       and
+#       or
+#       imply
+#       equivalent
+
+tokens =3D (
+   'AND',
+   'OR',
+   'IMPLY',
+   'UNTIL',
+   'ALWAYS',
+   'EVENTUALLY',
+   'VARIABLE',
+   'LITERAL',
+   'NOT',
+   'LPAREN',
+   'RPAREN',
+   'ASSIGN',
+)
+
+t_AND =3D r'and'
+t_OR =3D r'or'
+t_IMPLY =3D r'imply'
+t_UNTIL =3D r'until'
+t_ALWAYS =3D r'always'
+t_EVENTUALLY =3D r'eventually'
+t_VARIABLE =3D r'[A-Z_0-9]+'
+t_LITERAL =3D r'true|false'
+t_NOT =3D r'not'
+t_LPAREN =3D r'\('
+t_RPAREN =3D r'\)'
+t_ASSIGN =3D r'=3D'
+t_ignore_COMMENT =3D r'\#.*'
+t_ignore =3D ' \t\n'
+
+def t_error(t):
+    raise ValueError(f"Illegal character '{t.value[0]}'")
+
+lexer =3D lex()
+
+class GraphNode:
+    uid =3D 0
+
+    def __init__(self, incoming: set['GraphNode'], new, old, _next):
+        self.init =3D False
+        self.outgoing =3D set()
+        self.labels =3D set()
+        self.incoming =3D incoming.copy()
+        self.new =3D new.copy()
+        self.old =3D old.copy()
+        self.next =3D _next.copy()
+        self.id =3D GraphNode.uid
+        GraphNode.uid +=3D 1
+
+    def expand(self, node_set):
+        if not self.new:
+            for nd in node_set:
+                if nd.old =3D=3D self.old and nd.next =3D=3D self.next:
+                    nd.incoming |=3D self.incoming
+                    return node_set
+
+            new_current_node =3D GraphNode({self}, self.next, set(), set())
+            return new_current_node.expand({self} | node_set)
+        n =3D self.new.pop()
+        return n.expand(self, node_set)
+
+    def __lt__(self, other):
+        return self.id < other.id
+
+class ASTNode:
+    uid =3D 1
+
+    def __init__(self, op):
+        self.op =3D op
+        self.id =3D ASTNode.uid
+        ASTNode.uid +=3D 1
+
+    def __hash__(self):
+        return hash(self.op)
+
+    def __eq__(self, other):
+        return self is other
+
+    def __iter__(self):
+        yield self
+        yield from self.op
+
+    def negate(self):
+        self.op =3D self.op.negate()
+        return self
+
+    def expand(self, node, node_set):
+        return self.op.expand(self, node, node_set)
+
+    def __str__(self):
+        if isinstance(self.op, Literal):
+            return str(self.op.value)
+        if isinstance(self.op, Variable):
+            return self.op.name.lower()
+        return "val" + str(self.id)
+
+    def normalize(self):
+        # Get rid of:
+        #   - ALWAYS
+        #   - EVENTUALLY
+        #   - IMPLY
+        # And move all the NOT to be inside
+        self.op =3D self.op.normalize()
+        return self
+
+class BinaryOp:
+    op_str =3D "not_supported"
+
+    def __init__(self, left: ASTNode, right: ASTNode):
+        self.left =3D left
+        self.right =3D right
+
+    def __hash__(self):
+        return hash((self.left, self.right))
+
+    def __iter__(self):
+        yield from self.left
+        yield from self.right
+
+    def normalize(self):
+        raise NotImplementedError
+
+    def negate(self):
+        raise NotImplementedError
+
+    def _is_temporal(self):
+        raise NotImplementedError
+
+    def is_temporal(self):
+        if self.left.op.is_temporal():
+            return True
+        if self.right.op.is_temporal():
+            return True
+        return self._is_temporal()
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        raise NotImplementedError
+
+class AndOp(BinaryOp):
+    op_str =3D '&&'
+
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return OrOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.is_temporal():
+            node.old.add(n)
+            return node.expand(node_set)
+
+        tmp =3D GraphNode(node.incoming,
+                        node.new | ({n.op.left, n.op.right} - node.old),
+                        node.old | {n},
+                        node.next)
+        return tmp.expand(node_set)
+
+class OrOp(BinaryOp):
+    op_str =3D '||'
+
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return AndOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.is_temporal():
+            node.old |=3D {n}
+            return node.expand(node_set)
+
+        node1 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next)
+        node2 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class UntilOp(BinaryOp):
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return VOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return True
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        node1 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class VOp(BinaryOp):
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return UntilOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return True
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        node1 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 =3D GraphNode(node.incoming,
+                          node.new | ({n.op.left, n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class ImplyOp(BinaryOp):
+    def normalize(self):
+        # P -> Q =3D=3D=3D !P | Q
+        return OrOp(self.left.negate(), self.right)
+
+    def _is_temporal(self):
+        return False
+
+    def negate(self):
+        # !(P -> Q) =3D=3D=3D !(!P | Q) =3D=3D=3D P & !Q
+        return AndOp(self.left, self.right.negate())
+
+class UnaryOp:
+    def __init__(self, child: ASTNode):
+        self.child =3D child
+
+    def __iter__(self):
+        yield from self.child
+
+    def __hash__(self):
+        return hash(self.child)
+
+    def normalize(self):
+        raise NotImplementedError
+
+    def _is_temporal(self):
+        raise NotImplementedError
+
+    def is_temporal(self):
+        if self.child.op.is_temporal():
+            return True
+        return self._is_temporal()
+
+    def negate(self):
+        raise NotImplementedError
+
+class EventuallyOp(UnaryOp):
+    def __str__(self):
+        return "eventually " + str(self.child)
+
+    def normalize(self):
+        # <>F =3D=3D true U F
+        return UntilOp(ASTNode(Literal(True)), self.child)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # !<>F =3D=3D [](!F)
+        return AlwaysOp(self.child.negate()).normalize()
+
+class AlwaysOp(UnaryOp):
+    def normalize(self):
+        # []F =3D=3D=3D !(true U !F) =3D=3D false V F
+        new =3D ASTNode(Literal(False))
+        return VOp(new, self.child)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # ![]F =3D=3D <>(!F)
+        return EventuallyOp(self.child.negate()).normalize()
+
+class NotOp(UnaryOp):
+    def __str__(self):
+        return "!" + str(self.child)
+
+    def normalize(self):
+        return self.child.op.negate()
+
+    def negate(self):
+        return self.child.op
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        for f in node.old:
+            if n.op.child is f:
+                return node_set
+        node.old |=3D {n}
+        return node.expand(node_set)
+
+class Variable:
+    def __init__(self, name: str):
+        self.name =3D name
+
+    def __hash__(self):
+        return hash(self.name)
+
+    def __iter__(self):
+        yield from ()
+
+    def negate(self):
+        new =3D ASTNode(self)
+        return NotOp(new)
+
+    def normalize(self):
+        return self
+
+    def is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        for f in node.old:
+            if isinstance(f, NotOp) and f.op.child is n:
+                return node_set
+        node.old |=3D {n}
+        return node.expand(node_set)
+
+class Literal:
+    def __init__(self, value: bool):
+        self.value =3D value
+
+    def __iter__(self):
+        yield from ()
+
+    def __hash__(self):
+        return hash(self.value)
+
+    def __str__(self):
+        if self.value:
+            return "true"
+        return "false"
+
+    def negate(self):
+        self.value =3D not self.value
+        return self
+
+    def normalize(self):
+        return self
+
+    def is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.value:
+            return node_set
+        node.old |=3D {n}
+        return node.expand(node_set)
+
+def p_spec(p):
+    '''
+    spec : assign
+         | assign spec
+    '''
+    if len(p) =3D=3D 3:
+        p[2].append(p[1])
+        p[0] =3D p[2]
+    else:
+        p[0] =3D [p[1]]
+
+def p_assign(p):
+    '''
+    assign : VARIABLE ASSIGN ltl
+    '''
+    p[0] =3D (p[1], p[3])
+
+def p_ltl(p):
+    '''
+    ltl : opd
+        | binop
+        | unop
+    '''
+    p[0] =3D p[1]
+
+def p_opd(p):
+    '''
+    opd : VARIABLE
+        | LITERAL
+        | LPAREN ltl RPAREN
+    '''
+    if p[1] =3D=3D "true":
+        p[0] =3D ASTNode(Literal(True))
+    elif p[1] =3D=3D "false":
+        p[0] =3D ASTNode(Literal(False))
+    elif p[1] =3D=3D '(':
+        p[0] =3D p[2]
+    else:
+        p[0] =3D ASTNode(Variable(p[1]))
+
+def p_unop(p):
+    '''
+    unop : ALWAYS ltl
+         | EVENTUALLY ltl
+         | NOT ltl
+    '''
+    if p[1] =3D=3D "always":
+        op =3D AlwaysOp(p[2])
+    elif p[1] =3D=3D "eventually":
+        op =3D EventuallyOp(p[2])
+    elif p[1] =3D=3D "not":
+        op =3D NotOp(p[2])
+    else:
+        raise ValueError(f"Invalid unary operator {p[1]}")
+
+    p[0] =3D ASTNode(op)
+
+def p_binop(p):
+    '''
+    binop : opd UNTIL ltl
+          | opd AND ltl
+          | opd OR ltl
+          | opd IMPLY ltl
+    '''
+    if p[2] =3D=3D "and":
+        op =3D AndOp(p[1], p[3])
+    elif p[2] =3D=3D "until":
+        op =3D UntilOp(p[1], p[3])
+    elif p[2] =3D=3D "or":
+        op =3D OrOp(p[1], p[3])
+    elif p[2] =3D=3D "imply":
+        op =3D ImplyOp(p[1], p[3])
+    else:
+        raise ValueError(f"Invalid binary operator {p[2]}")
+
+    p[0] =3D ASTNode(op)
+
+parser =3D yacc()
+
+def parse_ltl(s: str) -> ASTNode:
+    spec =3D parser.parse(s)
+
+    rule =3D None
+    subexpr =3D {}
+
+    for assign in spec:
+        if assign[0] =3D=3D "RULE":
+            rule =3D assign[1]
+        else:
+            subexpr[assign[0]] =3D assign[1]
+
+    if rule is None:
+        raise ValueError("Please define your specification in the \"RULE =
=3D <LTL spec>\" format")
+
+    for node in rule:
+        if not isinstance(node.op, Variable):
+            continue
+        replace =3D subexpr.get(node.op.name)
+        if replace is not None:
+            node.op =3D replace.op
+
+    return rule
+
+def create_graph(s: str):
+    atoms =3D set()
+
+    ltl =3D parse_ltl(s)
+    for c in ltl:
+        c.normalize()
+        if isinstance(c.op, Variable):
+            atoms.add(c.op.name)
+
+    init =3D GraphNode(set(), set(), set(), set())
+    head =3D GraphNode({init}, {ltl}, set(), set())
+    graph =3D sorted(head.expand(set()))
+
+    for i, node in enumerate(graph):
+        # The id assignment during graph generation has gaps. Reassign them
+        node.id =3D i
+
+        for incoming in node.incoming:
+            if incoming is init:
+                node.init =3D True
+            else:
+                incoming.outgoing.add(node)
+        for o in node.old:
+            if not o.op.is_temporal():
+                node.labels.add(str(o))
+
+    return sorted(atoms), graph, ltl
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/r=
vgen/rvgen/ltl2k.py
new file mode 100644
index 0000000000000..b8da9094fb4ff
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+from pathlib import Path
+from . import generator
+from . import ltl2ba
+
+COLUMN_LIMIT =3D 100
+
+def line_len(line: str) -> int:
+    tabs =3D line.count('\t')
+    return tabs * 7 + len(line)
+
+def break_long_line(line: str, indent=3D'') -> list[str]:
+    result =3D []
+    while line_len(line) > COLUMN_LIMIT:
+        i =3D line[:COLUMN_LIMIT - line_len(line)].rfind(' ')
+        result.append(line[:i])
+        line =3D indent + line[i + 1:]
+    if line:
+        result.append(line)
+    return result
+
+def build_condition_string(node: ltl2ba.GraphNode):
+    if not node.labels:
+        return "(true)"
+
+    result =3D "("
+
+    first =3D True
+    for label in sorted(node.labels):
+        if not first:
+            result +=3D " && "
+        result +=3D label
+        first =3D False
+
+    result +=3D ")"
+
+    return result
+
+def abbreviate_atoms(atoms: list[str]) -> list[str]:
+    def shorten(s: str) -> str:
+        skip =3D ["is", "by", "or", "and"]
+        return '_'.join([x[:2] for x in s.lower().split('_') if x not in s=
kip])
+
+    abbrs =3D []
+    for atom in atoms:
+        for i in range(len(atom), -1, -1):
+            if sum(a.startswith(atom[:i]) for a in atoms) > 1:
+                break
+        share =3D atom[:i]
+        unique =3D atom[i:]
+        abbrs.append((shorten(share) + shorten(unique)))
+    return abbrs
+
+class ltl2k(generator.Monitor):
+    template_dir =3D "ltl2k"
+
+    def __init__(self, file_path, MonitorType, extra_params=3D{}):
+        if MonitorType !=3D "per_task":
+            raise NotImplementedError("Only per_task monitor is supported =
for LTL")
+        super().__init__(extra_params)
+        with open(file_path) as f:
+            self.atoms, self.ba, self.ltl =3D ltl2ba.create_graph(f.read())
+        self.atoms_abbr =3D abbreviate_atoms(self.atoms)
+        self.name =3D extra_params.get("model_name")
+        if not self.name:
+            self.name =3D Path(file_path).stem
+
+    def _fill_states(self) -> str:
+        buf =3D [
+            "enum ltl_buchi_state {",
+        ]
+
+        for node in self.ba:
+            buf.append("\tS%i," % node.id)
+        buf.append("\tRV_NUM_BA_STATES")
+        buf.append("};")
+        buf.append("static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);=
")
+        return buf
+
+    def _fill_atoms(self):
+        buf =3D ["enum ltl_atom {"]
+        for a in sorted(self.atoms):
+            buf.append("\tLTL_%s," % a)
+        buf.append("\tLTL_NUM_ATOM")
+        buf.append("};")
+        buf.append("static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);")
+        return buf
+
+    def _fill_atoms_to_string(self):
+        buf =3D [
+            "static const char *ltl_atom_str(enum ltl_atom atom)",
+            "{",
+            "\tstatic const char *const names[] =3D {"
+        ]
+
+        for name in self.atoms_abbr:
+            buf.append("\t\t\"%s\"," % name)
+
+        buf.extend([
+            "\t};",
+            "",
+            "\treturn names[atom];",
+            "}"
+        ])
+        return buf
+
+    def _fill_atom_values(self):
+        buf =3D []
+        for node in self.ltl:
+            if node.op.is_temporal():
+                continue
+
+            if isinstance(node.op, ltl2ba.Variable):
+                buf.append("\tbool %s =3D test_bit(LTL_%s, mon->atoms);" %=
 (node, node.op.name))
+            elif isinstance(node.op, ltl2ba.AndOp):
+                buf.append("\tbool %s =3D %s && %s;" % (node, node.op.left=
, node.op.right))
+            elif isinstance(node.op, ltl2ba.OrOp):
+                buf.append("\tbool %s =3D %s || %s;" % (node, node.op.left=
, node.op.right))
+            elif isinstance(node.op, ltl2ba.NotOp):
+                buf.append("\tbool %s =3D !%s;" % (node, node.op.child))
+        buf.reverse()
+
+        buf2 =3D []
+        for line in buf:
+            buf2.extend(break_long_line(line, "\t     "))
+        return buf2
+
+    def _fill_transitions(self):
+        buf =3D [
+            "static void",
+            "ltl_possible_next_states(struct ltl_monitor *mon, unsigned in=
t state, unsigned long *next)",
+            "{"
+        ]
+        buf.extend(self._fill_atom_values())
+        buf.extend([
+            "",
+            "\tswitch (state) {"
+        ])
+
+        for node in self.ba:
+            buf.append("\tcase S%i:" % node.id)
+
+            for o in sorted(node.outgoing):
+                line   =3D "\t\tif "
+                indent =3D "\t\t   "
+
+                line +=3D build_condition_string(o)
+                lines =3D break_long_line(line, indent)
+                buf.extend(lines)
+
+                buf.append("\t\t\t__set_bit(S%i, next);" % o.id)
+            buf.append("\t\tbreak;")
+        buf.extend([
+            "\t}",
+            "}"
+        ])
+
+        return buf
+
+    def _fill_start(self):
+        buf =3D [
+            "static void ltl_start(struct task_struct *task, struct ltl_mo=
nitor *mon)",
+            "{"
+        ]
+        buf.extend(self._fill_atom_values())
+        buf.append("")
+
+        for node in self.ba:
+            if not node.init:
+                continue
+
+            line   =3D "\tif "
+            indent =3D "\t   "
+
+            line +=3D build_condition_string(node)
+            lines =3D break_long_line(line, indent)
+            buf.extend(lines)
+
+            buf.append("\t\t__set_bit(S%i, mon->states);" % node.id)
+        buf.append("}")
+        return buf
+
+    def fill_tracepoint_handlers_skel(self):
+        buff =3D []
+        buff.append("static void handle_example_event(void *data, /* XXX: =
fill header */)")
+        buff.append("{")
+        buff.append("\tltl_atom_update(task, LTL_%s, true/false);" % self.=
atoms[0])
+        buff.append("}")
+        buff.append("")
+        return '\n'.join(buff)
+
+    def fill_tracepoint_attach_probe(self):
+        return "\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, han=
dle_example_event);" \
+                % self.name
+
+    def fill_tracepoint_detach_helper(self):
+        return "\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, han=
dle_sample_event);" \
+                % self.name
+
+    def fill_atoms_init(self):
+        buff =3D []
+        for a in self.atoms:
+            buff.append("\tltl_atom_set(mon, LTL_%s, true/false);" % a)
+        return '\n'.join(buff)
+
+    def fill_model_h(self):
+        buf =3D [
+            "/* SPDX-License-Identifier: GPL-2.0 */",
+            "",
+            "#include <linux/rv.h>",
+            "",
+            "#define MONITOR_NAME " + self.name,
+            ""
+        ]
+
+        buf.extend(self._fill_atoms())
+        buf.append('')
+
+        buf.extend(self._fill_atoms_to_string())
+        buf.append('')
+
+        buf.extend(self._fill_states())
+        buf.append('')
+
+        buf.extend(self._fill_start())
+        buf.append('')
+
+        buf.extend(self._fill_transitions())
+        buf.append('')
+
+        return '\n'.join(buf)
+
+    def fill_monitor_class_type(self):
+        return "LTL_MON_EVENTS_ID"
+
+    def fill_monitor_class(self):
+        return "ltl_monitor_id"
+
+    def fill_main_c(self):
+        main_c =3D super().fill_main_c()
+        main_c =3D main_c.replace("%%ATOMS_INIT%%", self.fill_atoms_init())
+
+        return main_c
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/=
verification/rvgen/rvgen/templates/ltl2k/main.c
new file mode 100644
index 0000000000000..2f3c4d6427468
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "%%MODEL_NAME%%"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <trace/events/sched.h>
+ */
+#include <rv_trace.h>
+%%INCLUDE_PARENT%%
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no =
need
+ * to touch this section.
+ */
+#include "%%MODEL_NAME%%.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *=
mon)
+{
+	/*
+	 * This is called everytime the Buchi automaton is triggered.
+	 *
+	 * This function could be used to fetch the atomic propositions which are=
 expensive to
+	 * trace. It is possible only if the atomic proposition does not need to =
be updated at
+	 * precise time.
+	 *
+	 * It is recommended to use tracepoints and ltl_atom_update() instead.
+	 */
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *m=
on, bool task_creation)
+{
+	/*
+	 * This should initialize as many atomic propositions as possible.
+	 *
+	 * @task_creation indicates whether the task is being created. This is fa=
lse if the task is
+	 * already running before the monitor is enabled.
+	 */
+%%ATOMS_INIT%%
+}
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel even=
ts
+ * are translated into model's event.
+ */
+%%TRACEPOINT_HANDLERS_SKEL%%
+static int enable_%%MODEL_NAME%%(void)
+{
+	int retval;
+
+	retval =3D ltl_monitor_init();
+	if (retval)
+		return retval;
+
+%%TRACEPOINT_ATTACH%%
+
+	return 0;
+}
+
+static void disable_%%MODEL_NAME%%(void)
+{
+%%TRACEPOINT_DETACH%%
+
+	ltl_monitor_destroy();
+}
+
+/*
+ * This is the monitor register section.
+ */
+static struct rv_monitor rv_%%MODEL_NAME%% =3D {
+	.name =3D "%%MODEL_NAME%%",
+	.description =3D "%%DESCRIPTION%%",
+	.enable =3D enable_%%MODEL_NAME%%,
+	.disable =3D disable_%%MODEL_NAME%%,
+};
+
+static int __init register_%%MODEL_NAME%%(void)
+{
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
+}
+
+static void __exit unregister_%%MODEL_NAME%%(void)
+{
+	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
+}
+
+module_init(register_%%MODEL_NAME%%);
+module_exit(unregister_%%MODEL_NAME%%);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(/* TODO */);
+MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h b/tools=
/verification/rvgen/rvgen/templates/ltl2k/trace.h
new file mode 100644
index 0000000000000..49394c4b0f1c5
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
+DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *=
next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
--=20
2.39.5

