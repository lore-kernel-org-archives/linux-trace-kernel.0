Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D902302CD3;
	Fri,  4 Jul 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635244; cv=none; b=Alqz3eOBgSpZLCVxPSngN9G3Dn6tdjYIEh4bd+8o9x/6iS+6r5xWAKzQQNa3uNZahRcsi9rRdgcNMKDsLVzFlKvcA5QdArGqMxJfmyArF10CtMP5Xr3LfL1neHyGUVOS7G7cM61DIxgrBFEYIYASwxGQl/oLydtStSWWqtr81qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635244; c=relaxed/simple;
	bh=4E0Oah8Vf9+0nw81guANuSlGCnnDikjBatsfcFqNIBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKmhQAxQY2lQTRuKFHZc4eio4hBPAauLcOKjw+E5XX8GpPJfi6AA267n7bAVL6aoUdtV1OaT/7pGpZrz9y8S9G9fnnGXVsAiMyEqC4tqreHWlTLEs9I4oduCWf4Uvr4Ec0yves7rsYVKB5IEfo8Q2vi8EgFePlgZb2dwE0fZayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27F5mGsN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dw8OvcQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27F5mGsN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dw8OvcQf"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KAvGyQ0xP8IO/zEYr99K1J42aOtJiiaTgBhx/7FTHk=;
	b=27F5mGsNcOtAq81zZ91b5dpynFe9wdQaftvmab/81vlWom9r+sZSKm3eJCyv2QTpkOgePF
	cHdcOSXYagcrs0iSchUpGxoLMSxRFgsV6roJuQhOyzQJ3iekHUUt/mnxJBpcs/EoXQh0Cy
	TZgHEwNcXWtiLF4xqSq/Izo51LCTL2HZ3B21cXd14XVB6YXrdxfRwZrqAcDEFrLFUtUpod
	zMexLEC1a74JNCngB0+REObgSMwiYOcTRobrs3vPSFxX0LXkIeiLDBfHyzM5ANKI+KgcIO
	U74K/gdXPt+sOImU85YzTJTayC/ZXzfshyuf5OOfefgytM8WxUDL7kncBdES9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KAvGyQ0xP8IO/zEYr99K1J42aOtJiiaTgBhx/7FTHk=;
	b=dw8OvcQf6v8TpmfaOjoRANqS2GO55LYz5u5odsXOKwN76bQqMRXSz+54oJmFilWb2hy5rV
	mAwx70uZSMyF9ADA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 14/21] verification/rvgen: Add support for linear temporal logic
Date: Fri,  4 Jul 2025 15:20:06 +0200
Message-Id: <f3c63b363ff9c5af3302ba2b5d92a26a98700eaf.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for generating RV monitors from linear temporal logic, similar
to the generation of deterministic automaton monitors.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v11:
  - Keep comments within 80 columns
  - Also generate a note that the monitor file is generated
  - Split this out from the bigger patch
---
 tools/verification/rvgen/.gitignore           |   3 +
 tools/verification/rvgen/Makefile             |   2 +
 tools/verification/rvgen/__main__.py          |   3 +-
 tools/verification/rvgen/rvgen/ltl2ba.py      | 540 ++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       | 252 ++++++++
 .../rvgen/rvgen/templates/ltl2k/main.c        | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  14 +
 7 files changed, 915 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

diff --git a/tools/verification/rvgen/.gitignore b/tools/verification/rvgen=
/.gitignore
new file mode 100644
index 000000000000..1e288a076560
--- /dev/null
+++ b/tools/verification/rvgen/.gitignore
@@ -0,0 +1,3 @@
+__pycache__/
+parser.out
+parsetab.py
diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/M=
akefile
index cca8c9ba82e8..cfc4056c1e87 100644
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
index 63ecf0c37034..fa6fc1f4de2f 100644
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
index 000000000000..d11840af7f5f
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
index 000000000000..92e713861d86
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -0,0 +1,252 @@
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
+            "/*",
+            " * C implementation of Buchi automaton, automatically generat=
ed by",
+            " * tools/verification/rvgen from the linear temporal logic sp=
ecification.",
+            " * For further information, see kernel documentation:",
+            " *   Documentation/trace/rv/linear_temporal_logic.rst",
+            " */",
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
index 000000000000..f85d076fbf78
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
+	 * This function could be used to fetch the atomic propositions which
+	 * are expensive to trace. It is possible only if the atomic proposition
+	 * does not need to be updated at precise time.
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
+	 * @task_creation indicates whether the task is being created. This is
+	 * false if the task is already running before the monitor is enabled.
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
index 000000000000..49394c4b0f1c
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

