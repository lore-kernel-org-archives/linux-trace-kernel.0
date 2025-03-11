Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87D25F987;
	Tue, 11 Mar 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712731; cv=none; b=U0tYQV07COY/FLfCT2thkufTb2XlBZiF67hBMyrYx4WSDDTHQCh7Q1Dh9pXhHAi8tQQZnHVo5z2/w8j+A/Llk4FqtAtcAiRQB3uxcPop/jsGDiI0Oiz3ANpSwQO1cOBwQjvSAfNs2Sh0ksi0JHYY1ZyJg2hVbP2X1kIL4cjOt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712731; c=relaxed/simple;
	bh=qEs1t5R0JI3Zicr639mOVjunNA7Ttt4gfgOQTTGM12A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8gC3OCFciGhuvcm6E6s8Xo/H/NaNNYZHBchu1DeKMT1MJYs0pLhoFRbgxGiaghh7pWadu2ZXs6v5hY66ge/45a79RtgKy1LkItcXFO+b961MVBentYjEq1GqxR/5x1xk3ksizrMZKQ+M8tQ+70aA7YSV8CATDh+UH+xabf2xgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da8fil8o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUKitZUE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da8fil8o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUKitZUE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0F7VuAvpzjUk6D6p8AhxW1sYjgpGqNRcnrCfCY6X7c=;
	b=da8fil8oP1hKPTud3DMxJD/SvdxMQz8V9aioO/c4okZZ8W2xiFH22TtSgtkQqyBLi79yI8
	W5W3D8UOpejFLoa3d0E8lPhgiMSk9yMFqbxHf6pMX1Wvlo6F+dDPYA2pN4D/bRjm+Ld+MK
	HHmJLWQKNZZvBI3udOSd/rG6X3ghdJ5ZKo130WfuQy8G3HxMdv/v9mR8Vheu1SWn3bGsyq
	1yJEMY90ifoKgECpau2dzj/eAmK31tFm+ziFMt4lcEThaup4Df6MkR4efI3p8lVIdHGe1e
	2Ox90N2iiPnZeuR+fI+98fefi2NalmonsUwcCPtwzmr2+vxI8toD+qhjgzHJsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0F7VuAvpzjUk6D6p8AhxW1sYjgpGqNRcnrCfCY6X7c=;
	b=rUKitZUEo4g9rKjZsVjsbvxho/3dTYPSCou4TTg4j/1Eqy1sdiup5XM0z2RGZ4hgYXUbGG
	vZvIODNvZam1gMCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 03/10] rv: Add infrastructure for linear temporal logic monitor
Date: Tue, 11 Mar 2025 18:05:04 +0100
Message-Id: <0b03a7d779707c598068d6ec00f3e5a19de336d8.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare the infrastructure for linear temporal logic monitors:

  - add scripts for generating the monitors
  - implement data structures

For details, see:
Documentation/trace/rv/linear_temporal_logic.rst

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 .../trace/rv/linear_temporal_logic.rst        |  73 +++
 include/linux/rv.h                            |  26 +-
 kernel/fork.c                                 |   5 +-
 tools/verification/ltl2ba/.gitignore          |   3 +
 tools/verification/ltl2ba/generate.py         | 154 +++++
 tools/verification/ltl2ba/ltl.py              | 556 ++++++++++++++++++
 tools/verification/ltl2ba/template.c          | 131 +++++
 tools/verification/ltl2ba/template.h          | 157 +++++
 8 files changed, 1097 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst
 create mode 100644 tools/verification/ltl2ba/.gitignore
 create mode 100755 tools/verification/ltl2ba/generate.py
 create mode 100644 tools/verification/ltl2ba/ltl.py
 create mode 100644 tools/verification/ltl2ba/template.c
 create mode 100644 tools/verification/ltl2ba/template.h

diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentati=
on/trace/rv/linear_temporal_logic.rst
new file mode 100644
index 000000000000..9b0ce6a143ec
--- /dev/null
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -0,0 +1,73 @@
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Deterministic automaton runtime verification monitor is a verification tec=
hnique which checks that
+the kernel follows a specification in the form of deterministic automaton =
(DA). It does so by using
+tracepoints to monitor the kernel's execution trace, and verifying that th=
e execution trace
+sastifies the specification.
+
+However, while attempting to implement DA monitors for some complex specif=
ications, deterministic
+automaton is found to be inappropriate as the specification language. The =
automaton is complicated,
+hard to understand, and error-prone.
+
+Thus, RV monitors based on linear temporal logic (LTL for short) are intro=
duced. This type of
+monitor uses LTL as specification, instead of DA. For some cases, writing =
the specification as LTL
+is more concise and intuitive.
+
+Documents regarding LTL are widely available on the internet, this documen=
t will not go into
+details.
+
+Grammar
+=3D=3D=3D=3D=3D=3D=3D=3D
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
+Monitor synthesis
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To synthesize an LTL into a kernel monitor, conversion scripts are provide=
d:
+`tools/verification/ltl2ba`. The specification needs to be provided as a f=
ile, and it must have a
+"RULE =3D LTL" assignment, which specifies the LTL property to verify. For=
 example:
+
+   .. code-block::
+
+    RULE =3D always (ACQUIRE imply ((not KILLED and not CRASHED) until REL=
EASE))
+
+The LTL can be broken down if required using sub-expressions. For example,=
 the above is equivalent
+to:
+
+   .. code-block::
+
+    RULE =3D always (ACQUIRE imply (ALIVE until RELEASE))
+    ALIVE =3D not KILLED and not CRASHED
+
+The ltl file can be converted into C code:
+
+   .. code-block::
+
+    .tools/verification/ltl2ba/generate.py -l <ltl file> -n <model name> -=
o <output diretory>
+
+The above command generates `ba.c` and `ba.h`, the Buchi automaton that ve=
rifies the LTL property.
+The Buchi automaton needs to be manually glued to the kernel. Please see t=
he comments in `ba.h` for
+further details.
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 5482651ed020..6de4f93b390e 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -10,6 +10,8 @@
 #define MAX_DA_NAME_LEN	24
=20
 #ifdef CONFIG_RV
+#include <linux/types.h>
+
 /*
  * Deterministic automaton per-object variables.
  */
@@ -18,6 +20,24 @@ struct da_monitor {
 	unsigned int	curr_state;
 };
=20
+enum ltl_truth_value {
+	LTL_FALSE,
+	LTL_TRUE,
+	LTL_UNDETERMINED,
+};
+
+/*
+ * In the future, if the number of atomic propositions or the custom data =
size is larger, we can
+ * switch to dynamic allocation. For now, the code is simpler this way.
+ */
+#define RV_MAX_LTL_ATOM 10
+#define RV_MAX_DATA_SIZE 16
+struct ltl_monitor {
+	unsigned int		state;
+	enum ltl_truth_value	atoms[RV_MAX_LTL_ATOM];
+	u8			data[RV_MAX_DATA_SIZE];
+};
+
 /*
  * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
  * If we find justification for more monitors, we can think about
@@ -27,11 +47,9 @@ struct da_monitor {
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
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..5d6c1caca702 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2127,10 +2127,7 @@ static void copy_oom_score_adj(u64 clone_flags, stru=
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
diff --git a/tools/verification/ltl2ba/.gitignore b/tools/verification/ltl2=
ba/.gitignore
new file mode 100644
index 000000000000..9c47b9724860
--- /dev/null
+++ b/tools/verification/ltl2ba/.gitignore
@@ -0,0 +1,3 @@
+__pycache__/
+parsetab.py
+parser.out
diff --git a/tools/verification/ltl2ba/generate.py b/tools/verification/ltl=
2ba/generate.py
new file mode 100755
index 000000000000..52d5b3618e64
--- /dev/null
+++ b/tools/verification/ltl2ba/generate.py
@@ -0,0 +1,154 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+import argparse
+import ntpath
+import os
+import platform
+from pathlib import Path
+import sys
+import ltl
+
+parser =3D argparse.ArgumentParser(description=3D'transform ltl file into =
kernel rv monitor')
+parser.add_argument('-l', "--ltl", dest=3D"ltl", required=3DTrue)
+parser.add_argument('-n', "--model_name", dest=3D"model_name", required=3D=
True)
+parser.add_argument('-o', "--outdir", dest=3D"outdir", required=3DTrue)
+params =3D parser.parse_args()
+
+with open(params.ltl) as f:
+    atoms, graph =3D ltl.create_graph(f.read())
+states =3D []
+transitions =3D []
+init_conditions =3D []
+
+COLUMN_LIMIT =3D 100
+
+def build_condition_string(node: ltl.GraphNode):
+    if not node.labels:
+        return "(true)"
+
+    result =3D "("
+
+    first =3D True
+    for l in sorted(node.labels):
+        if not first:
+            result +=3D " && "
+        result +=3D '(' + l + ')'
+        first =3D False
+
+    result +=3D ")"
+
+    return result
+
+def build_states() -> str:
+    states =3D ''
+    for node in graph:
+        states +=3D "\t%s,\n" % node.name
+    return states
+
+def build_atoms() -> str:
+    global atoms
+    s =3D ''
+    for a in sorted(atoms):
+        s +=3D "\t%s,\n" % a
+    return s
+
+def build_transitions() -> list[str]:
+    transitions =3D []
+    for node in graph:
+        transitions.append("\tcase %s:\n" % node.name)
+
+        result =3D ""
+        first =3D True
+        for o in sorted(node.outgoing):
+            if first:
+                result +=3D "\t\tif "
+                cursor =3D 19
+            else:
+                result +=3D "\t\telse if "
+                cursor =3D 24
+
+            condition =3D build_condition_string(o)
+
+            while len(condition) + cursor > COLUMN_LIMIT:
+                i =3D condition[:COLUMN_LIMIT - cursor].rfind(' ')
+                result +=3D condition[:i]
+                if cursor =3D=3D 19:
+                    result +=3D '\n\t\t   '
+                elif cursor =3D=3D 24:
+                    result +=3D '\t\t\t\t'
+                else:
+                    raise ValueError()
+                condition =3D condition[i + 1:]
+
+            result +=3D condition
+
+            result +=3D '\n'
+            result +=3D ("\t\t\tmon->state =3D %s;\n" % o.name)
+            first =3D False
+        result +=3D "\t\telse\n\t\t\tillegal_state(task, mon);\n"
+        result +=3D "\t\tbreak;\n"
+        transitions.append(result)
+    return transitions
+
+def build_initial_conditions() -> str:
+    result =3D ""
+    first =3D True
+
+    for node in graph:
+        if not node.init:
+            continue
+
+        if not first:
+            result +=3D "\telse if "
+            cursor =3D 16
+        else:
+            result +=3D "\tif "
+            cursor =3D 11
+
+        condition =3D build_condition_string(node)
+        while len(condition) + cursor > COLUMN_LIMIT:
+            i =3D condition[:COLUMN_LIMIT - cursor].rfind(' ')
+            result +=3D condition[:i]
+            if cursor =3D=3D 16:
+                result +=3D '\n\t\t'
+            elif cursor =3D=3D 11:
+                result +=3D '\n\t   '
+            else:
+                raise ValueError()
+            condition =3D condition[i + 1:]
+
+        result +=3D condition
+        result +=3D '\n'
+        result +=3D ("\t\tmon->state =3D %s;\n" % node.name)
+        first =3D False
+    result +=3D "\telse\n\t\tillegal_state(task, mon);\n"
+    return result
+
+template =3D Path(__file__).with_name('template.h')
+out =3D os.path.join(params.outdir, "ba.h")
+with template.open() as template, open(out, "w") as file:
+    for line in template:
+        if line =3D=3D "%%ATOM_LIST%%\n":
+            file.write(build_atoms())
+        else:
+            line =3D line.replace("%%MODEL_NAME%%", params.model_name)
+            file.write(line)
+
+template =3D Path(__file__).with_name('template.c')
+out =3D os.path.join(params.outdir, "ba.c")
+with template.open() as template, open(out, "w") as file:
+    for line in template:
+        if line =3D=3D "%%STATE_LIST%%\n":
+            file.write(build_states())
+        elif line =3D=3D "%%BUCHI_START%%\n":
+            file.write(build_initial_conditions())
+        elif line =3D=3D "%%BUCHI_TRANSITIONS%%\n":
+            for t in build_transitions():
+                file.write(t)
+        elif line =3D=3D "%%ERROR_MESSAGE%%\n":
+            file.write(build_error_message())
+        else:
+            line =3D line.replace("%%MODEL_NAME%%", params.model_name)
+            line =3D line.replace("%%LTL%%", params.ltl)
+            file.write(line)
diff --git a/tools/verification/ltl2ba/ltl.py b/tools/verification/ltl2ba/l=
tl.py
new file mode 100644
index 000000000000..aa3a11d78a8e
--- /dev/null
+++ b/tools/verification/ltl2ba/ltl.py
@@ -0,0 +1,556 @@
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
+t_AND     =3D r'and'
+t_OR      =3D r'or'
+t_IMPLY   =3D r'imply'
+t_UNTIL   =3D r'until'
+t_ALWAYS =3D r'always'
+t_EVENTUALLY =3D r'eventually'
+t_VARIABLE =3D r'[A-Z_0-9]+'
+t_LITERAL =3D r'true|false'
+t_NOT =3D r'not'
+t_LPAREN =3D r'\('
+t_RPAREN =3D r'\)'
+t_ASSIGN =3D r'=3D'
+t_ignore_COMMENT =3D r'\#.*'
+t_ignore  =3D ' \t\n'
+
+def t_error(t):
+    raise ValueError("Illegal character '%s'" % t.value[0])
+
+lexer =3D lex()
+
+_new_name_counter =3D 0
+def new_name():
+    global _new_name_counter
+
+    _new_name_counter +=3D 1
+
+    return "S" + str(_new_name_counter)
+
+class GraphNode:
+    def __init__(self, name: str, incoming: set['GraphNode'], new, old, _n=
ext):
+        self.init =3D False
+        self.outgoing =3D set()
+        self.labels =3D set()
+        self.incoming =3D incoming
+        self.name =3D name
+        self.new =3D new.copy()
+        self.old =3D old.copy()
+        self.next =3D _next.copy()
+
+    def expand(self, node_set):
+        if not self.new:
+            for nd in node_set:
+                if nd.old =3D=3D self.old and nd.next =3D=3D self.next:
+                    nd.incoming |=3D self.incoming
+                    for i in self.incoming:
+                        i.outgoing.add(nd)
+                    return node_set
+
+            new_current_node =3D GraphNode(new_name(), {self}, self.next, =
set(), set())
+            return new_current_node.expand({self} | node_set)
+        n =3D self.new.pop()
+        return n.expand(self, node_set)
+
+    def __lt__(self, other):
+        return self.name < other.name
+
+class ASTNode:
+    def __init__(self,op):
+        self.op =3D op
+
+    def __hash__(self):
+        return hash(self.op)
+
+    def __str__(self):
+        return str(self.op)
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
+    def __str__(self):
+        return "(%s %s %s)" % (self.left, self.op_str, self.right)
+
+    def __hash__(self):
+        return hash((self.left, self.right))
+
+    def __iter__(self):
+        yield from self.left
+        yield from self.right
+
+    def normalize(self):
+        raise NotImplemented
+
+    def negate(self):
+        raise NotImplemented
+
+    def _is_temporal(self):
+        raise NotImplemented
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
+        raise NotImplemented
+
+class AndOp(BinaryOp):
+    op_str =3D '&&'
+
+    def __init__(self, left, right):
+        super().__init__(left, right)
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
+        tmp =3D GraphNode(node.name, node.incoming,
+                        node.new | ({n.op.left, n.op.right} - node.old),
+                        node.old | {n},
+                        node.next)
+        return tmp.expand(node_set)
+
+class OrOp(BinaryOp):
+    op_str =3D '||'
+
+    def __init__(self, left, right):
+        super().__init__(left, right)
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
+        node1 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next)
+        node2 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class UntilOp(BinaryOp):
+    def __init__(self, left, right):
+        super().__init__(left, right)
+
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
+        node1 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class VOp(BinaryOp):
+    def __init__(self, left, right):
+        super().__init__(left, right)
+
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
+        node1 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 =3D GraphNode(new_name(), node.incoming,
+                          node.new | ({n.op.left, n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class ImplyOp(BinaryOp):
+    def __init__(self, left, right):
+        super().__init__(left, right)
+
+    def normalize(self):
+        # P -> Q =3D=3D=3D !P | Q
+        return OrOp(self.left.negate(), self.right)
+
+    def _is_temporal(self):
+        return False
+
+    def negate():
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
+        raise NotImplemented
+
+    def _is_temporal(self):
+        raise NotImplemented
+
+    def is_temporal(self):
+        if self.child.op.is_temporal():
+            return True
+        return self._is_temporal()
+
+    def negate(self):
+        raise NotImplemented
+
+class EventuallyOp(UnaryOp):
+    def __init__(self, child):
+        super().__init__(child)
+
+    def __str__(self):
+        return "eventually " + str(self.child)
+
+    def normalize(self):
+        # <>F =3D=3D true U F
+        return UntilOp(Literal(True), self.right)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # !<>F =3D=3D [](!F)
+        return AlwaysOp(self.right.negate()).normalize()
+
+class AlwaysOp(UnaryOp):
+    def __init__(self, child):
+        super().__init__(child)
+
+    def normalize(self):
+        #[]F =3D=3D=3D !(true U !F) =3D=3D false V F
+        new =3D ASTNode(Literal(False))
+        return VOp(new, self.child)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # ![]F =3D=3D <>(!F)
+        return EventuallyOp(self.left, self.right.negate()).normalize()
+
+class NotOp(UnaryOp):
+    def __init__(self, child):
+        super().__init__(child)
+
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
+    def __str__(self):
+        return "mon->atoms[%s]" % self.name
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
+    if p[1] =3D=3D "eventually":
+        op =3D EventuallyOp(p[2])
+    if p[1] =3D=3D "not":
+        op =3D NotOp(p[2])
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
+        raise ValueError("Invalid binary operator: %s" % p[2])
+
+    p[0] =3D ASTNode(op)
+
+parser =3D yacc()
+
+def parse_ltl(s: str) -> ASTNode:
+    spec =3D parser.parse(s)
+
+    for assign in spec:
+        if assign[0] =3D=3D "RULE":
+            rule =3D assign[1]
+
+    for assign in spec:
+        if assign[0] =3D=3D "RULE":
+            continue
+
+        subexpr =3D assign[0]
+        for node in rule:
+            if isinstance(node.op, Variable) and node.op.name =3D=3D subex=
pr:
+                node.op =3D assign[1].op
+
+    return rule
+
+def create_graph(s: str):
+    atoms =3D set()
+
+    x =3D parse_ltl(s)
+    for c in x:
+        c.normalize()
+        if isinstance(c.op, Variable):
+            atoms.add(c.op.name)
+
+    init =3D GraphNode("init", set(), set(), set(), set())
+    head =3D GraphNode("first", {init}, {x}, set(), set())
+    graph =3D head.expand(set())
+
+    for node in graph:
+        for incoming in node.incoming:
+            if incoming.name =3D=3D "init":
+                node.init =3D True
+        for o in node.old:
+            if not o.op.is_temporal():
+                node.labels.add(str(o))
+
+    return atoms, sorted(graph)
diff --git a/tools/verification/ltl2ba/template.c b/tools/verification/ltl2=
ba/template.c
new file mode 100644
index 000000000000..31c5a209d71d
--- /dev/null
+++ b/tools/verification/ltl2ba/template.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is generated, do not edit.
+ */
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <trace/events/task.h>
+#include <trace/events/sched.h>
+
+#include "ba.h"
+
+static_assert(NUM_ATOM <=3D RV_MAX_LTL_ATOM);
+
+enum buchi_state {
+	INIT,
+%%STATE_LIST%%
+	DEAD,
+};
+
+int rv_%%MODEL_NAME%%_task_slot =3D RV_PER_TASK_MONITOR_INIT;
+
+static void init_monitor(struct task_struct *task)
+{
+	struct ltl_monitor *mon =3D rv_%%MODEL_NAME%%_get_monitor(task);
+
+	for (int i =3D 0; i < NUM_ATOM; ++i)
+		mon->atoms[i] =3D LTL_UNDETERMINED;
+	mon->state =3D INIT;
+}
+
+static void handle_task_newtask(void *data, struct task_struct *task, unsi=
gned long flags)
+{
+	struct ltl_monitor *mon =3D rv_%%MODEL_NAME%%_get_monitor(task);
+
+	init_monitor(task);
+
+	rv_%%MODEL_NAME%%_atoms_init(task, mon);
+	rv_%%MODEL_NAME%%_atoms_fetch(task, mon);
+}
+
+int rv_%%MODEL_NAME%%_init(size_t data_size)
+{
+	struct task_struct *g, *p;
+	int ret, cpu;
+
+	if (WARN_ON(data_size > RV_MAX_DATA_SIZE))
+		return -EINVAL;
+
+	ret =3D rv_get_task_monitor_slot();
+	if (ret < 0)
+		return ret;
+
+	rv_%%MODEL_NAME%%_task_slot =3D ret;
+
+	rv_attach_trace_probe("%%MODEL_NAME%%", task_newtask, handle_task_newtask=
);
+
+	read_lock(&tasklist_lock);
+
+	for_each_process_thread(g, p)
+		init_monitor(p);
+
+	for_each_present_cpu(cpu)
+		init_monitor(idle_task(cpu));
+
+	read_unlock(&tasklist_lock);
+
+	return 0;
+}
+
+void rv_%%MODEL_NAME%%_destroy(void)
+{
+	rv_put_task_monitor_slot(rv_%%MODEL_NAME%%_task_slot);
+	rv_%%MODEL_NAME%%_task_slot =3D RV_PER_TASK_MONITOR_INIT;
+
+	rv_detach_trace_probe("%%MODEL_NAME%%", task_newtask, handle_task_newtask=
);
+}
+
+static void illegal_state(struct task_struct *task, struct ltl_monitor *mo=
n)
+{
+	mon->state =3D INIT;
+	rv_%%MODEL_NAME%%_error(task, mon);
+}
+
+static void rv_%%MODEL_NAME%%_attempt_start(struct task_struct *task, stru=
ct ltl_monitor *mon)
+{
+	int i;
+
+	mon =3D rv_%%MODEL_NAME%%_get_monitor(task);
+
+	rv_%%MODEL_NAME%%_atoms_fetch(task, mon);
+
+	for (i =3D 0; i < NUM_ATOM; ++i) {
+		if (mon->atoms[i] =3D=3D LTL_UNDETERMINED)
+			return;
+	}
+
+%%BUCHI_START%%
+}
+
+static void rv_%%MODEL_NAME%%_step(struct task_struct *task, struct ltl_mo=
nitor *mon)
+{
+	switch (mon->state) {
+%%BUCHI_TRANSITIONS%%
+	case DEAD:
+	case INIT:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
+void rv_%%MODEL_NAME%%_atom_update(struct task_struct *task, unsigned int =
atom, bool value)
+{
+	struct ltl_monitor *mon =3D rv_%%MODEL_NAME%%_get_monitor(task);
+
+	rv_%%MODEL_NAME%%_atom_set(mon, atom, value);
+
+	if (mon->state =3D=3D DEAD)
+		return;
+
+	if (mon->state =3D=3D INIT)
+		rv_%%MODEL_NAME%%_attempt_start(task, mon);
+	if (mon->state =3D=3D INIT)
+		return;
+
+	mon->atoms[atom] =3D value;
+
+	rv_%%MODEL_NAME%%_atoms_fetch(task, mon);
+
+	rv_%%MODEL_NAME%%_step(task, mon);
+}
diff --git a/tools/verification/ltl2ba/template.h b/tools/verification/ltl2=
ba/template.h
new file mode 100644
index 000000000000..65d342891e70
--- /dev/null
+++ b/tools/verification/ltl2ba/template.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file is generated, do not edit.
+ *
+ * This file includes necessary functions to glue the Buchi automaton and =
the kernel together.
+ * Some of these functions must be manually implemented (look for "Must be=
 implemented", or just
+ * let the compiler tells you).
+ *
+ * Essentially, you need to manually define the meaning of the atomic prop=
ositions in the LTL
+ * property. The primary function for that is rv_%%MODEL_NAME%%_atom_updat=
e(), which can be called
+ * in tracepoints' handlers for example. In some specific cases where
+ * rv_%%MODEL_NAME%%_atom_update() is not convenient, rv_%%MODEL_NAME%%_at=
oms_fetch() can be used.
+ *
+ * rv_%%MODEL_NAME%%_init()/rv_%%MODEL_NAME%%_destroy() must be called whi=
le enabling/disabling
+ * the monitor.
+ *
+ * If the fields in struct ltl_monitor is not enough, extra custom data ca=
n be used. See
+ * rv_%%MODEL_NAME%%_get_data().
+ */
+
+#include <linux/sched.h>
+
+enum %%MODEL_NAME%%_atom {
+%%ATOM_LIST%%
+	NUM_ATOM
+};
+
+/**
+ * rv_%%MODEL_NAME%%_init
+ * @data_size:	required custom data size, can be zero
+ *
+ * Must be called while enabling the monitor
+ */
+int rv_%%MODEL_NAME%%_init(size_t data_size);
+
+/**
+ * rv_%%MODEL_NAME%%_destroy
+ *
+ * must be called while disabling the monitor
+ */
+void rv_%%MODEL_NAME%%_destroy(void);
+
+/**
+ * rv_%%MODEL_NAME%%_error - report violation of the LTL property
+ * @task:	the task violating the LTL property
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function should invoke the RV reactor and the=
 monitor's tracepoints.
+ */
+void rv_%%MODEL_NAME%%_error(struct task_struct *task, struct ltl_monitor =
*mon);
+
+extern int rv_%%MODEL_NAME%%_task_slot;
+
+/**
+ * rv_%%MODEL_NAME%%_get_monitor - get the struct ltl_monitor of a task
+ */
+static inline struct ltl_monitor *rv_%%MODEL_NAME%%_get_monitor(struct tas=
k_struct *task)
+{
+	return &task->rv[rv_%%MODEL_NAME%%_task_slot].ltl_mon;
+}
+
+/**
+ * rv_%%MODEL_NAME%%_atoms_init - initialize the atomic propositions
+ * @task:	the task
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function is called during task creation, and =
should initialize all
+ * atomic propositions. rv_%%MODEL_NAME%%_atom_set() should be used to imp=
lement this function.
+ *
+ * This function does not have to initialize atomic propositions that are =
updated by
+ * rv_%%MODEL_NAME%%_atoms_fetch(), because the two functions are called t=
ogether.
+ */
+void rv_%%MODEL_NAME%%_atoms_init(struct task_struct *task, struct ltl_mon=
itor *mon);
+
+/**
+ * rv_%%MODEL_NAME%%_atoms_fetch - fetch the atomic propositions
+ * @task:	the task
+ * @mon:	the LTL monitor
+ *
+ * Must be implemented. This function is called anytime the Buchi automato=
n is triggered. Its
+ * intended purpose is to update the atomic propositions which are expensi=
ve to trace and can be
+ * easily read from @task. rv_%%MODEL_NAME%%_atom_set() should be used to =
implement this function.
+ *
+ * Using this function may cause incorrect verification result if it is im=
portant for the LTL that
+ * the atomic propositions must be updated at the correct time. Therefore,=
 if it is possible,
+ * updating atomic propositions should be done with rv_%%MODEL_NAME%%_atom=
_update() instead.
+ *
+ * An example where this function is useful is with the LTL property:
+ *    always (RT imply not PAGEFAULT)
+ * (a realtime task does not raise page faults)
+ *
+ * In this example, adding tracepoints to track RT is complicated, because=
 it is changed in
+ * differrent places (mutex's priority boosting, sched_setscheduler). Furt=
hermore, for this LTL
+ * property, we don't care exactly when RT changes, as long as we have its=
 correct value when
+ * PAGEFAULT=3D=3Dtrue. Therefore, it is better to update RT in rv_%%MODEL=
_NAME%%_atoms_fetch(), as it
+ * can easily be retrieved from task_struct.
+ *
+ * This function can be empty.
+ */
+void rv_%%MODEL_NAME%%_atoms_fetch(struct task_struct *task, struct ltl_mo=
nitor *mon);
+
+/**
+ * rv_%%MODEL_NAME%%_atom_update - update an atomic proposition
+ * @task:	the task
+ * @atom:	the atomic proposition, one of enum %%MODEL_NAME%%_atom
+ * @value:	the new value for @atom
+ *
+ * Update an atomic proposition and trigger the Buchi atomaton to check fo=
r violation of the LTL
+ * property. This function can be called in tracepoints' handler, for exam=
ple.
+ */
+void rv_%%MODEL_NAME%%_atom_update(struct task_struct *task, unsigned int =
atom, bool value);
+
+/**
+ * rv_%%MODEL_NAME%%_atom_get - get an atomic proposition
+ * @mon:	the monitor
+ * @atom:	the atomic proposition, one of enum %%MODEL_NAME%%_atom
+ *
+ * Returns the value of an atomic proposition.
+ */
+static inline
+enum ltl_truth_value rv_%%MODEL_NAME%%_atom_get(struct ltl_monitor *mon, u=
nsigned int atom)
+{
+	return mon->atoms[atom];
+}
+
+/**
+ * rv_%%MODEL_NAME%%_atom_set - set an atomic proposition
+ * @mon:	the monitor
+ * @atom:	the atomic proposition, one of enum %%MODEL_NAME%%_atom
+ * @value:	the new value for @atom
+ *
+ * Update an atomic proposition without triggering the Buchi automaton. Th=
is can be useful to
+ * implement rv_%%MODEL_NAME%%_atoms_fetch() and rv_%%MODEL_NAME%%_atoms_i=
nit().
+ *
+ * Another use case for this function is when multiple atomic propositions=
 change at the same time,
+ * because calling rv_%%MODEL_NAME%%_atom_update() (and thus triggering th=
e Buchi automaton)
+ * multiple times may be incorrect. In that case, rv_%%MODEL_NAME%%_atom_s=
et() can be used to avoid
+ * triggering the Buchi automaton, and rv_%%MODEL_NAME%%_atom_update() is =
only used for the last
+ * atomic proposition.
+ */
+static inline
+void rv_%%MODEL_NAME%%_atom_set(struct ltl_monitor *mon, unsigned int atom=
, bool value)
+{
+	mon->atoms[atom] =3D value;
+}
+
+/**
+ * rv_%%MODEL_NAME%%_get_data - get the custom data of this monitor.
+ * @mon: the monitor
+ *
+ * If this function is used, rv_%%MODEL_NAME%%_init() must have been calle=
d with a positive
+ * data_size.
+ */
+static inline void *rv_%%MODEL_NAME%%_get_data(struct ltl_monitor *mon)
+{
+	return &mon->data;
+}
--=20
2.39.5

