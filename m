Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C773CF043;
	Tue,  5 May 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964388; cv=none; b=IhK1m+nFiBJ0NeCODCOJFCPBzv0iLG1N4SL2Buogm7zeG0aLFbUSLXYdNrbu97FXs9keG99ZjuHfbDwof8h+HI12aah5n52x3KTO4VTZS3eLzJ73gUBrqMzrLTjrS0NR5o135C3/RoieEmS0tBaYzfGzB/MxWSukMYhprlR3cYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964388; c=relaxed/simple;
	bh=0CO/exRlfnI8S9HBp0VIqoVF0E3lIQNP1iYjsI79OYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etwfEXJF6ORXohQzZ228zqVR1Iq0E7qtHvWabdndKPhgBDGA5PAn0x7WRzBGnxYnlfKDXyeWfcTzAxUNzZKQW6fDA/6yGpbXQNzT3BgjeYDyV2kOpuydmsVjp2b0HfDfdelsvYWhX6LjCtfugEDTC/hOGT8YJoGnTtmxXjr6ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=amxSmtgl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7tK2fNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="amxSmtgl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7tK2fNu"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRg03oBC0tvBjzWX+19jO3Bw7cf7L48zSREJwFUyBvA=;
	b=amxSmtglXLCeOdiYXJnqK3NY1GW5ulppiMiSfiIsbrhb1pzRnJp8+eC7mSnlNxeF5IER8v
	S4rQ+RFevDPZ75dc+cmCRwWbGzpRKUXcjmq7pjUxVHNJCczqNnfYXCgA36gdgesk6WCEK2
	aquPXu/gVsclPnjjGvoI6ZcWPuLLgQddCaUk/1fzkMUoXBsKQ+aF9e9KPvY4j9qCbiOvO4
	iXeXhjV8DawTUJ6ZhITfL+v4aUgPdYS01hasFx2jdvxKNVgY83yrL8aOAk+8w6dQOgZUU0
	hmbNaQItZIkPMUfoJuw8zNfBckYRNZy5/JM82oIMCN9Y8n7BDHlZ7KH/w/OHBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRg03oBC0tvBjzWX+19jO3Bw7cf7L48zSREJwFUyBvA=;
	b=F7tK2fNuNkuwc0skMhNGrWJVk7BR3/ieYWil9Qq/O8plyddWdgI3f7WgPRAORE/QIeiI1E
	sWW6/PEis1rVOLDA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 01/13] verification/rvgen: Switch LTL parser to Lark
Date: Tue,  5 May 2026 08:59:22 +0200
Message-ID: <85aaa8cacb31cfc78619a07aeae9a86d059a4cc1.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/ltl2ba.py | 189 +++++++++--------------
 1 file changed, 70 insertions(+), 119 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/=
rvgen/rvgen/ltl2ba.py
index 7f538598a868..b2dee2dbe257 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -7,8 +7,7 @@
 # https://doi.org/10.1007/978-0-387-34892-6_1
 # With extra optimizations
=20
-from ply.lex import lex
-from ply.yacc import yacc
+import lark
 from .automata import AutomataError
=20
 # Grammar:
@@ -30,42 +29,38 @@ from .automata import AutomataError
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
+VARIABLE: /[A-Z_0-9]+/
+LITERAL: "true" | "false"
+
+COMMENT: "#" /.*/ "\n"
+%ignore COMMENT
+
+%import common.WS
+%ignore WS
+'''
=20
 class GraphNode:
     uid =3D 0
@@ -432,90 +427,46 @@ class Literal:
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
+        raise ValueError("Unknown operator %s" % node[1])
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
+        return ASTNode(Variable(args))
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
     spec =3D parser.parse(s)
+    spec =3D Transform().transform(spec)
=20
     rule =3D None
     subexpr =3D {}
--=20
2.47.3

