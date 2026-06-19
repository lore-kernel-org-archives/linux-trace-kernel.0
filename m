Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07163321D4;
	Fri, 19 Jun 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848357; cv=none; b=ECzBpy4nrKp/mvE+MADXZc1gLUUQSwJRL1ssarBmxxrDQvEhC9I1cpp7Q6cZg8Osz0H/BqRFN49wnA6zZDiujYhwfc9+RV/uf0FXdtjkpQv9vuFVjlDRtEV7NmNeWvNl5+3pLim9WB6K+X+RK2mDzgQ7r9IblY9uRhT6aAmC9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848357; c=relaxed/simple;
	bh=I0RFHaJ0uyVjD8Y4yb61W3Sq9/JxOY6uGz6HtaofIoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqpOYcqsbapuqzaaopkTq86ecmVBR5DZNoRE1qAGfu2rCLzz0kLO2V7tdmpyyrhK5pVoS7RUKPHYXV1QVrYUr2WyWZS48EymhQaVgKiS0W0sycTZklrG2mXZ6SKZSoaMEMo8EyxdWTQruvLwlgF7r24PkzSd5ad/V6mPsmW6Z+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oe/BnC1c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VK70XB26; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oe/BnC1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VK70XB26"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmzKqFGh0o8uVtWZjNM4SQj84FV9pp6B5uCmDnjQf6k=;
	b=Oe/BnC1cnHPNqy5jxLmsrndldy0/3nGj0hqyi/wZF4GzG9Ypd/W/RP7TTDqL328Hg9imFZ
	QPYJI7WnMVCNkRTBww8ASFwC2w29GvnWBXB33+xsOzFiyY/IH5TdQF0l/Pn0G3BCUDe7qT
	TyQalCf/H7GNQl6haajVImFV3tik49fRnCawveuduwIGTeJGbZS/m6uBkpqSN2AwMn67lV
	8s4j8sY9+OkHL2vXeuczJCRgk2FD6zXNAhNbHB6fTI0XcvSf+eyXuDXnRyhHwdHb4pQoB7
	FyYNTOAIam0dwe9tEqHVGbfImHZEHvSYPsX+Gcb+e4mC1a8YacEMAeB+EZeWYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmzKqFGh0o8uVtWZjNM4SQj84FV9pp6B5uCmDnjQf6k=;
	b=VK70XB26iHzMlfzDUqoZCUlzAMHGM7pnM9vEWQfQ16caCVjI15OimYG6oEs55X3Niwyj51
	PiYWK/tbVmyazWAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 01/13] verification/rvgen: Switch LTL parser to Lark
Date: Fri, 19 Jun 2026 07:52:04 +0200
Message-ID: <73d149221d96090342c7de408d032573de9cb6c4.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The LTL parser is built using Ply. However, Ply is no longer
maintained [1].

Switch to use Lark instead. In addition to being actively maintained, Lark
also offers additional features (namely, automatically creating the
abstract syntax tree) which make the parser simpler.

Link: https://github.com/dabeaz/ply/commit/9d7c40099e23ff78f9d86ef69a26c1e8=
a83e706a [1]
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/__main__.py     |   5 +-
 tools/verification/rvgen/rvgen/ltl2ba.py | 202 +++++++++--------------
 2 files changed, 82 insertions(+), 125 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvge=
n/__main__.py
index 5c923dc10d0f..0915cf86e43b 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -14,6 +14,7 @@ if __name__ =3D=3D '__main__':
     from rvgen.container import Container
     from rvgen.ltl2k import ltl2k
     from rvgen.automata import AutomataError
+    from rvgen.ltl2ba import LTLError
     import argparse
     import sys
=20
@@ -57,8 +58,8 @@ if __name__ =3D=3D '__main__':
                 sys.exit(1)
         else:
             monitor =3D Container(vars(params))
-    except AutomataError as e:
-        print(f"There was an error processing {params.spec}: {e}", file=3D=
sys.stderr)
+    except (AutomataError, LTLError) as e:
+        print(f"There was an error processing {params.spec}:\n{e}", file=
=3Dsys.stderr)
         sys.exit(1)
=20
     print(f"Writing the monitor into the directory {monitor.name}")
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/=
rvgen/rvgen/ltl2ba.py
index 016e7cf93bbb..7cebda61bce8 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -7,9 +7,7 @@
 # https://doi.org/10.1007/978-0-387-34892-6_1
 # With extra optimizations
=20
-from ply.lex import lex
-from ply.yacc import yacc
-from .automata import AutomataError
+import lark
=20
 # Grammar:
 # 	ltl ::=3D opd | ( ltl ) | ltl binop ltl | unop ltl
@@ -30,42 +28,41 @@ from .automata import AutomataError
 #       imply
 #       equivalent
=20
-tokens =3D (
-   'AND',
-   'OR',
-   'IMPLY',
-   'UNTIL',
-   'ALWAYS',
-   'EVENTUALLY',
-   'NEXT',
-   'VARIABLE',
-   'LITERAL',
-   'NOT',
-   'LPAREN',
-   'RPAREN',
-   'ASSIGN',
-)
-
-t_AND =3D r'and'
-t_OR =3D r'or'
-t_IMPLY =3D r'imply'
-t_UNTIL =3D r'until'
-t_ALWAYS =3D r'always'
-t_NEXT =3D r'next'
-t_EVENTUALLY =3D r'eventually'
-t_VARIABLE =3D r'[A-Z_0-9]+'
-t_LITERAL =3D r'true|false'
-t_NOT =3D r'not'
-t_LPAREN =3D r'\('
-t_RPAREN =3D r'\)'
-t_ASSIGN =3D r'=3D'
-t_ignore_COMMENT =3D r'\#.*'
-t_ignore =3D ' \t\n'
-
-def t_error(t):
-    raise AutomataError(f"Illegal character '{t.value[0]}'")
-
-lexer =3D lex()
+GRAMMAR =3D r'''
+start: assign+
+
+assign: VARIABLE "=3D" _ltl
+
+_ltl: _opd | binop | unop
+
+_opd : VARIABLE
+     | LITERAL
+     | "(" _ltl ")"
+
+unop: UNOP _ltl
+UNOP: "always"
+     | "eventually"
+     | "next"
+     | "not"
+
+binop: _opd BINOP _ltl
+BINOP: "until"
+      | "and"
+      | "or"
+      | "imply"
+
+VARIABLE: /[A-Z_][A-Z0-9_]*/
+LITERAL: "true" | "false"
+
+COMMENT: "#" /.*/ "\n"
+%ignore COMMENT
+
+%import common.WS
+%ignore WS
+'''
+
+class LTLError(Exception):
+    "Exception raised for malformed linear temporal logic"
=20
 class GraphNode:
     uid =3D 0
@@ -97,7 +94,7 @@ class GraphNode:
         return self.id < other.id
=20
 class ASTNode:
-    uid =3D 1
+    uid =3D 0
=20
     def __init__(self, op):
         self.op =3D op
@@ -433,90 +430,49 @@ class Literal:
         node.old |=3D {n}
         return node.expand(node_set)
=20
-def p_spec(p):
-    '''
-    spec : assign
-         | assign spec
-    '''
-    if len(p) =3D=3D 3:
-        p[2].append(p[1])
-        p[0] =3D p[2]
-    else:
-        p[0] =3D [p[1]]
-
-def p_assign(p):
-    '''
-    assign : VARIABLE ASSIGN ltl
-    '''
-    p[0] =3D (p[1], p[3])
-
-def p_ltl(p):
-    '''
-    ltl : opd
-        | binop
-        | unop
-    '''
-    p[0] =3D p[1]
-
-def p_opd(p):
-    '''
-    opd : VARIABLE
-        | LITERAL
-        | LPAREN ltl RPAREN
-    '''
-    if p[1] =3D=3D "true":
-        p[0] =3D ASTNode(Literal(True))
-    elif p[1] =3D=3D "false":
-        p[0] =3D ASTNode(Literal(False))
-    elif p[1] =3D=3D '(':
-        p[0] =3D p[2]
-    else:
-        p[0] =3D ASTNode(Variable(p[1]))
-
-def p_unop(p):
-    '''
-    unop : ALWAYS ltl
-         | EVENTUALLY ltl
-         | NEXT ltl
-         | NOT ltl
-    '''
-    if p[1] =3D=3D "always":
-        op =3D AlwaysOp(p[2])
-    elif p[1] =3D=3D "eventually":
-        op =3D EventuallyOp(p[2])
-    elif p[1] =3D=3D "next":
-        op =3D NextOp(p[2])
-    elif p[1] =3D=3D "not":
-        op =3D NotOp(p[2])
-    else:
-        raise AutomataError(f"Invalid unary operator {p[1]}")
-
-    p[0] =3D ASTNode(op)
-
-def p_binop(p):
-    '''
-    binop : opd UNTIL ltl
-          | opd AND ltl
-          | opd OR ltl
-          | opd IMPLY ltl
-    '''
-    if p[2] =3D=3D "and":
-        op =3D AndOp(p[1], p[3])
-    elif p[2] =3D=3D "until":
-        op =3D UntilOp(p[1], p[3])
-    elif p[2] =3D=3D "or":
-        op =3D OrOp(p[1], p[3])
-    elif p[2] =3D=3D "imply":
-        op =3D ImplyOp(p[1], p[3])
-    else:
-        raise AutomataError(f"Invalid binary operator {p[2]}")
-
-    p[0] =3D ASTNode(op)
-
-parser =3D yacc()
+class Transform(lark.visitors.Transformer):
+    def unop(self, node):
+        if node[0] =3D=3D "always":
+            return ASTNode(AlwaysOp(node[1]))
+        if node[0] =3D=3D "eventually":
+            return ASTNode(EventuallyOp(node[1]))
+        if node[0] =3D=3D "next":
+            return ASTNode(NextOp(node[1]))
+        if node[0] =3D=3D "not":
+            return ASTNode(NotOp(node[1]))
+        raise ValueError("Unknown operator %s" % node[0])
+
+    def binop(self, node):
+        if node[1] =3D=3D "until":
+            return ASTNode(UntilOp(node[0], node[2]))
+        if node[1] =3D=3D "and":
+            return ASTNode(AndOp(node[0], node[2]))
+        if node[1] =3D=3D "or":
+            return ASTNode(OrOp(node[0], node[2]))
+        if node[1] =3D=3D "imply":
+            return ASTNode(ImplyOp(node[0], node[2]))
+        raise ValueError("Unknown operator %s" % node[1])
+
+    def VARIABLE(self, args):
+        return ASTNode(Variable(args))
+
+    def LITERAL(self, args):
+        return ASTNode(Literal(args =3D=3D "true"))
+
+    def start(self, node):
+        return node
+
+    def assign(self, node):
+        return node[0].op.name, node[1]
+
+parser =3D lark.Lark(GRAMMAR)
=20
 def parse_ltl(s: str) -> ASTNode:
-    spec =3D parser.parse(s)
+    try:
+        spec =3D parser.parse(s)
+    except lark.exceptions.UnexpectedInput as e:
+        raise LTLError(str(e))
+    spec =3D Transform().transform(spec)
=20
     rule =3D None
     subexpr =3D {}
@@ -528,7 +484,7 @@ def parse_ltl(s: str) -> ASTNode:
             subexpr[assign[0]] =3D assign[1]
=20
     if rule is None:
-        raise AutomataError("Please define your specification in the \"RUL=
E =3D <LTL spec>\" format")
+        raise LTLError("Please define your specification in the \"RULE =3D=
 <LTL spec>\" format")
=20
     for node in rule:
         if not isinstance(node.op, Variable):
--=20
2.47.3

