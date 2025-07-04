Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA743303DCB;
	Fri,  4 Jul 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635243; cv=none; b=H4vD2tVxAERoJDE64+woQ2yhcWNuM+1XW45a+bIqo2KDnqVfYTW9xvI+jH9ENXog6+YHZBTwLUtGzfndYXIFvmHn69iqa4MmjeM08UKDLlwVB6SZWUKB9uybkpvn1mU9QuWYBws1G1qN5VWU3i9RHkylytuQs2b+TczjJD5e//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635243; c=relaxed/simple;
	bh=TBOO2AQSEASuyWnG4DlvlSfUwCeZ9UIJdlj7NIr/YgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCide+SCqrO7cpf0HCpd8EyBSrfhsqglWjoLW6C62+wD7dE9Fp4SWCJPrfemQvuVG6Op4NRKVKcucHva8pnGxvSN1DF/eBKXbkCKLK8EEVL3kImX4symXCYVKL1xZ0aACOz8HpjYUa1a7zsSxI8DF26FuwgTpW7azndbNXXbpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgdLzJak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7u+9oYe4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgdLzJak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7u+9oYe4"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sIiqASdnVahoU69Z+YarnWuWRAvV/Tk9WWJfBmMBXk=;
	b=mgdLzJakv5jot1BD/tTKNWGPWHb3mYXJWNKmfXyd4qvdmCRjHILrt4+M3Wa0bG5OcqupYo
	XWZT+pCC+HEoWbwX0OIBlCfUYyQB1jBWxODyywNGqnio8M7s5esgprfUTtZcZboKXR98Ml
	SrD3yWMMsaDXnniPLeXv+2aQrP7Yd8plu1K9wGAwYwVqJj5tXpchkjK9YLBO62/ihg4P3z
	rwgpwNlBOTW7c1oEDPp9vaQCUvjSqmUbOvgDh9IqkFHWz1xbDXfZJh2CE/nqc1aAy7sfbb
	pWAP9UnNHEAPdKkXJJ8+Dz6Aw1EePZxRnON3P8z5saJDhvn4PmKuOl3eZxMdYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sIiqASdnVahoU69Z+YarnWuWRAvV/Tk9WWJfBmMBXk=;
	b=7u+9oYe4V7jh5JbBNHG8Mzevoz9WHgDM6ZcIvRxy86lLgIr5wx6+rAABx+PvozeXyHZz7W
	ADcfVabh0gQKn/Bw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 15/21] Documentation/rv: Add documentation for linear temporal logic monitors
Date: Fri,  4 Jul 2025 15:20:07 +0200
Message-Id: <be13719e66fd8da147d7c69d5365aa23c52b743f.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add documents describing linear temporal logic runtime verification
monitors and how to generate them using rvgen.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v11:
  - Keep the doc within 80 columns
  - Split this out from the bigger patch
---
 Documentation/trace/rv/index.rst              |   1 +
 .../trace/rv/linear_temporal_logic.rst        | 133 +++++++++++++++
 Documentation/trace/rv/monitor_synthesis.rst  | 156 ++++++++++++++++--
 3 files changed, 274 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index 8e411b76ec82..2a27f6bc9429 100644
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
index 000000000000..57f107fcf6dd
--- /dev/null
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -0,0 +1,133 @@
+Linear temporal logic
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+Runtime verification monitor is a verification technique which checks that=
 the
+kernel follows a specification. It does so by using tracepoints to monitor=
 the
+kernel's execution trace, and verifying that the execution trace sastifies=
 the
+specification.
+
+Initially, the specification can only be written in the form of determinis=
tic
+automaton (DA).  However, while attempting to implement DA monitors for so=
me
+complex specifications, deterministic automaton is found to be inappropria=
te as
+the specification language. The automaton is complicated, hard to understa=
nd,
+and error-prone.
+
+Thus, RV monitors based on linear temporal logic (LTL) are introduced. Thi=
s type
+of monitor uses LTL as specification instead of DA. For some cases, writin=
g the
+specification as LTL is more concise and intuitive.
+
+Many materials explain LTL in details. One book is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, Th=
e MIT
+  Press, 2008.
+
+Grammar
+-------
+
+Unlike some existing syntax, kernel's implementation of LTL is more verbos=
e.
+This is motivated by considering that the people who read the LTL specific=
ations
+may not be well-versed in LTL.
+
+Grammar:
+    ltl ::=3D opd | ( ltl ) | ltl binop ltl | unop ltl
+
+Operands (opd):
+    true, false, user-defined names consisting of upper-case characters, d=
igits,
+    and underscore.
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
 must
+be used.
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
rnel
+verification, the `always` operator is usually desirable, to specify that
+something is always true at the present and for all future. For example::
+
+    always (RAIN imply eventually not RAIN)
+
+means: *all* rain eventually stops.
+
+In the above examples, `RAIN`, `GO_OUTSIDE`, `HAVE_UMBRELLA` and `WET` are=
 the
+"atomic propositions".
+
+Monitor synthesis
+-----------------
+
+To synthesize an LTL into a kernel monitor, the `rvgen` tool can be used:
+`tools/verification/rvgen`. The specification needs to be provided as a fi=
le,
+and it must have a "RULE =3D LTL" assignment. For example::
+
+    RULE =3D always (ACQUIRE imply ((not KILLED and not CRASHED) until REL=
EASE))
+
+which says: if `ACQUIRE`, then `RELEASE` must happen before `KILLED` or
+`CRASHED`.
+
+The LTL can be broken down using sub-expressions. The above is equivalent =
to:
+
+   .. code-block::
+
+    RULE =3D always (ACQUIRE imply (ALIVE until RELEASE))
+    ALIVE =3D not KILLED and not CRASHED
+
+From this specification, `rvgen` generates the C implementation of a Buchi
+automaton - a non-deterministic state machine which checks the satisfiabil=
ity of
+the LTL. See Documentation/trace/rv/monitor_synthesis.rst for details on u=
sing
+`rvgen`.
+
+References
+----------
+
+One book covering model checking and linear temporal logic is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, Th=
e MIT
+  Press, 2008.
+
+For an example of using linear temporal logic in software testing, see::
+
+  Ruijie Meng, Zhen Dong, Jialin Li, Ivan Beschastnikh, and Abhik Roychoud=
hury.
+  2022. Linear-time temporal logic guided greybox fuzzing. In Proceedings =
of the
+  44th International Conference on Software Engineering (ICSE '22).  Assoc=
iation
+  for Computing Machinery, New York, NY, USA, 1343=E2=80=931355.
+  https://doi.org/10.1145/3510003.3510082
+
+The kernel's LTL monitor implementation is based on::
+
+  Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996). Simple On-the-fly
+  Automatic Verification of Linear Temporal Logic. In: Dembi=C5=84ski, P.,=
 =C5=9Aredniawa,
+  M. (eds) Protocol Specification, Testing and Verification XV. PSTV 1995.=
 IFIP
+  Advances in Information and Communication Technology. Springer, Boston, =
MA.
+  https://doi.org/10.1007/978-0-387-34892-6_1
diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/t=
race/rv/monitor_synthesis.rst
index 85624062073b..ac808a7554f5 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -39,16 +39,18 @@ below::
 RV monitor synthesis
 --------------------
=20
-The synthesis of automata-based models into the Linux *RV monitor* abstrac=
tion
-is automated by the rvgen tool and the rv/da_monitor.h header file that
-contains a set of macros that automatically generate the monitor's code.
+The synthesis of a specification into the Linux *RV monitor* abstraction is
+automated by the rvgen tool and the header file containing common code for
+creating monitors. The header files are:
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
ating
+the skeleton of a kernel monitor in C.
=20
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
@@ -63,18 +65,38 @@ This will create a directory named wip/ with the follow=
ing files:
 The wip.c file contains the monitor declaration and the starting point for
 the system instrumentation.
=20
-Monitor macros
---------------
+Similarly, a linear temporal logic monitor can be generated with the follo=
wing
+command::
+
+  $ rvgen monitor -c ltl -s pagefault.ltl -t per_task
+
+This generates pagefault/ directory with:
+
+- pagefault.h: The Buchi automaton (the non-deterministic state machine to
+  verify the specification)
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
+include common macros and static functions for implementing *Monitor
+Instance(s)*.
=20
-The rv/da_monitor.h enables automatic code generation for the *Monitor
-Instance(s)* using C macros.
+The benefits of having all common functionalities in a single header file =
are
+3-fold:
=20
-The benefits of the usage of macro for monitor synthesis are 3-fold as it:
+  - Reduce the code duplication;
+  - Facilitate the bug fix/improvement;
+  - Avoid the case of developers changing the core of the monitor code to
+    manipulate the model in a (let's say) non-standard way.
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
@@ -130,10 +152,112 @@ While the event "preempt_enabled" will use::
 To notify the monitor that the system will be returning to the initial sta=
te,
 so the system and the monitor should be in sync.
=20
+rv/ltl_monitor.h
+++++++++++++++++
+This file must be combined with the $(MODEL_NAME).h file (generated by `rv=
gen`)
+to be complete. For example, for the `pagefault` monitor, the `pagefault.c`
+source file must include::
+
+  #include "pagefault.h"
+  #include <rv/ltl_monitor.h>
+
+(the skeleton monitor file generated by `rvgen` already does this).
+
+`$(MODEL_NAME).h` (`pagefault.h` in the above example) includes the
+implementation of the Buchi automaton - a non-deterministic state machine =
that
+verifies the LTL specification. While `rv/ltl_monitor.h` includes the comm=
on
+helper functions to interact with the Buchi automaton and to implement an =
RV
+monitor. An important definition in `$(MODEL_NAME).h` is::
+
+  enum ltl_atom {
+      LTL_$(FIRST_ATOMIC_PROPOSITION),
+      LTL_$(SECOND_ATOMIC_PROPOSITION),
+      ...
+      LTL_NUM_ATOM
+  };
+
+which is the list of atomic propositions present in the LTL specification
+(prefixed with "LTL\_" to avoid name collision). This `enum` is passed to =
the
+functions interacting with the Buchi automaton.
+
+While generating code, `rvgen` cannot understand the meaning of the atomic
+propositions. Thus, that task is left for manual work. The recommended pra=
tice
+is adding tracepoints to places where the atomic propositions change; and =
in the
+tracepoints' handlers: the Buchi automaton is executed using::
+
+  void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, bool =
value)
+
+which tells the Buchi automaton that the atomic proposition `atom` is now
+`value`. The Buchi automaton checks whether the LTL specification is still
+satisfied, and invokes the monitor's error tracepoint and the reactor if
+violation is detected.
+
+Tracepoints and `ltl_atom_update()` should be used whenever possible. Howe=
ver,
+it is sometimes not the most convenient. For some atomic propositions whic=
h are
+changed in multiple places in the kernel, it is cumbersome to trace all th=
ose
+places. Furthermore, it may not be important that the atomic propositions =
are
+updated at precise times. For example, considering the following linear te=
mporal
+logic::
+
+  RULE =3D always (RT imply not PAGEFAULT)
+
+This LTL states that a real-time task does not raise page faults. For this
+specification, it is not important when `RT` changes, as long as it has the
+correct value when `PAGEFAULT` is true.  Motivated by this case, another
+function is introduced::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+
+This function is called whenever the Buchi automaton is triggered. Therefo=
re, it
+can be manually implemented to "fetch" `RT`::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+  }
+
+Effectively, whenever `PAGEFAULT` is updated with a call to `ltl_atom_upda=
te()`,
+`RT` is also fetched. Thus, the LTL specification can be verified without
+tracing `RT` everywhere.
+
+For atomic propositions which act like events, they usually need to be set=
 (or
+cleared) and then immediately cleared (or set). A convenient function is
+provided::
+
+  void ltl_atom_pulse(struct task_struct *task, enum ltl_atom atom, bool v=
alue)
+
+which is equivalent to::
+
+  ltl_atom_update(task, atom, value);
+  ltl_atom_update(task, atom, !value);
+
+To initialize the atomic propositions, the following function must be
+implemented::
+
+  ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool t=
ask_creation)
+
+This function is called for all running tasks when the monitor is enabled.=
 It is
+also called for new tasks created after the enabling the monitor. It should
+initialize as many atomic propositions as possible, for example::
+
+  void ltl_atom_init(struct task_struct *task, struct ltl_monitor *mon, bo=
ol task_creation)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+      if (task_creation)
+          ltl_atom_set(mon, LTL_PAGEFAULT, false);
+  }
+
+Atomic propositions not initialized by `ltl_atom_init()` will stay in the
+unknown state until relevant tracepoints are hit, which can take some time=
. As
+monitoring for a task cannot be done until all atomic propositions is know=
n for
+the task, the monitor may need some time to start validating tasks which h=
ave
+been running before the monitor is enabled. Therefore, it is recommended to
+start the tasks of interest after enabling the monitor.
+
 Final remarks
 -------------
=20
-With the monitor synthesis in place using the rv/da_monitor.h and
+With the monitor synthesis in place using the header files and
 rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
=20
--=20
2.39.5

