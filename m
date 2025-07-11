Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B932D2389;
	Fri, 11 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239871; cv=none; b=IWk72vNjG9gUPyTwhqZs5i0CJAR9QU3yvlEeHj/k/CCjLGmJYIRky5Pwi49wgnWUF5sdqKoya61l2HlgrkhFGdGc9FC1IX8bfbmnmakCrp06fhGpmUNACpNFd+ZwrHe1owpGM2aMtlliMt48O5p6Imo0WcOdh6TuQw6zNIfnWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239871; c=relaxed/simple;
	bh=lw4OZfHfnI2cVyTNXtVLShhvrDH7ooKpfetSbu5fhRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2rpPtlqgQBlGswPGGU7aKfFR7ijWG9fhQKzyl23Cu9luZPflkYWC8h1H3fO9a02ij4peFyc3DA04OOp3+skkHMW1S6hJ5eSGO2A/Ty99cm48bB5zPlDWCQzBOheopCcrWt8kBzSRz/pJBwiVlMEm2L8DiMKrx8uMmIK/mXtyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyYHfoZk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgYXpM25; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyYHfoZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgYXpM25"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752239867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INu2KwXEZtpuyVFsgoK8s73FgdhQHIbE4KfHUbehgOU=;
	b=yyYHfoZkWZ1PibU39z748ytleE2WmXwUF+wUZcJYeVfHrm3e9/QhPDWqbzuVRyhpBCKaSL
	DSDQVs4k1koG26Lt49CEMNl8iD1iht08m5FJ/9GdHEfV8ehomMzLXblNNPvQ3pmsu3tgzk
	P+fcFSyCVLULw5DbeLTkx4v1AKXdrRFUvWoibaI0CHLIsoSbgc/A0tNAmn3bt63K5kwt2v
	zmEtv47RneL0JTdW7SQoEKRsml4Uyju0cdCvuBQ91MwUwo/lN2MIoGYSpR2fqtOXw8sWOV
	+SbUY4smsstnApo75pgSlapq/BjPHVGWevx2Desavq4R9mwb3ixYhFBxvHaItg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752239867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INu2KwXEZtpuyVFsgoK8s73FgdhQHIbE4KfHUbehgOU=;
	b=WgYXpM258leJ9ZiEYDxJgmBqOjOmgAKB1VfnnhQaJlSDMRFaHXwL79lvvJnnK0LQkcjqfa
	WpZv++/TzT8KWhDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] verification/rvgen: Support the 'next' operator
Date: Fri, 11 Jul 2025 15:17:38 +0200
Message-Id: <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
In-Reply-To: <cover.1752239482.git.namcao@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'next' operator is a unary operator. It is defined as: "next time, the
operand must be true".

Support this operator. For RV monitors, "next time" means the next
invocation of ltl_validate().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 .../trace/rv/linear_temporal_logic.rst        |  1 +
 tools/verification/rvgen/rvgen/ltl2ba.py      | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentati=
on/trace/rv/linear_temporal_logic.rst
index 57f107fcf6dd..9eee09d9cacf 100644
--- a/Documentation/trace/rv/linear_temporal_logic.rst
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -41,6 +41,7 @@ Operands (opd):
 Unary Operators (unop):
     always
     eventually
+    next
     not
=20
 Binary Operators (binop):
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/=
rvgen/rvgen/ltl2ba.py
index d11840af7f5f..f14e6760ac3d 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -19,6 +19,7 @@ from ply.yacc import yacc
 # Unary Operators (unop):
 #       always
 #       eventually
+#       next
 #       not
 #
 # Binary Operators (binop):
@@ -35,6 +36,7 @@ tokens =3D (
    'UNTIL',
    'ALWAYS',
    'EVENTUALLY',
+   'NEXT',
    'VARIABLE',
    'LITERAL',
    'NOT',
@@ -48,6 +50,7 @@ t_OR =3D r'or'
 t_IMPLY =3D r'imply'
 t_UNTIL =3D r'until'
 t_ALWAYS =3D r'always'
+t_NEXT =3D r'next'
 t_EVENTUALLY =3D r'eventually'
 t_VARIABLE =3D r'[A-Z_0-9]+'
 t_LITERAL =3D r'true|false'
@@ -327,6 +330,26 @@ class AlwaysOp(UnaryOp):
         # ![]F =3D=3D <>(!F)
         return EventuallyOp(self.child.negate()).normalize()
=20
+class NextOp(UnaryOp):
+    def normalize(self):
+        return self
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # not (next A) =3D=3D next (not A)
+        self.child =3D self.child.negate()
+        return self
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        tmp =3D GraphNode(node.incoming,
+                        node.new,
+                        node.old | {n},
+                        node.next | {n.op.child})
+        return tmp.expand(node_set)
+
 class NotOp(UnaryOp):
     def __str__(self):
         return "!" + str(self.child)
@@ -452,12 +475,15 @@ def p_unop(p):
     '''
     unop : ALWAYS ltl
          | EVENTUALLY ltl
+         | NEXT ltl
          | NOT ltl
     '''
     if p[1] =3D=3D "always":
         op =3D AlwaysOp(p[2])
     elif p[1] =3D=3D "eventually":
         op =3D EventuallyOp(p[2])
+    elif p[1] =3D=3D "next":
+        op =3D NextOp(p[2])
     elif p[1] =3D=3D "not":
         op =3D NotOp(p[2])
     else:
--=20
2.39.5

