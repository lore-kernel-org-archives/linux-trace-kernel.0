Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07A378D86;
	Thu, 28 May 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956895; cv=none; b=IZ7HEJ8ovA6MMc+ir7sW9PlSSGafqx/UBepoPNwJ+X44etPz56JGOqJEoCb7h+OO06YUz7d7QeenPaBnLIyaAY4otYKZin7Mljy+jpwPhHmmhA4J7HS/XPL2noKfKsRE5EktmesHIK25HSf4yGCNqwDbuvIuGbbpGpOPz7vxLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956895; c=relaxed/simple;
	bh=Fv4TVPC1QQXiVJDLCPqfartIjb4SwsdTYlNIDEFSZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhKWDqg9RXhGJxK8WYjdNzR4FoeVfp61vVh0cNk05WcuIJXx9Q1jJ6efrV5ncIx5T3Xeg/QZguCg2ydgxAMyrepoaNYimgRCK3vtGXWIY/wHk8cRkmmQAUIAKUDuocmxdJqdzU1GeiP29BYME3pdleUlc6ijJ/QYKeBKk/yG6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUDF8nRL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlqH9qQI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUDF8nRL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlqH9qQI"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsoWyUh+iFiOgtu/fAtU2KwGjjQuIFRjIxwJ4HbkFvo=;
	b=DUDF8nRL8e5jppJgLWnbVPNn5VotGvEadCbGzrVLWK2SP9F2O/mXdfd+uUWSxAYci2A6V0
	zyV8wv3YqxNjQ6HTXmSE+iG2/c6d7vCA0xSswGutWi6cDwpNBKzLachtrVb32pYhFe3jJA
	0Q2WVyTP4QGkZBbVBrdGgctbYF4SCBo4SQwUOu9qVLBH1bmd4HOCjYvBzyc13EMDgZUBh/
	XTMw0LaMYtFpRzixduxhcBkppReJH3RLiS6lis9WEljXjCepOGDImRtzrNUC/Nvj+oOru2
	dzVg/iGtTA75R1YCQ/FVltVDOcYitsMvgGpZN6fFZISlx5gKgrH/L/OuT5Irng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsoWyUh+iFiOgtu/fAtU2KwGjjQuIFRjIxwJ4HbkFvo=;
	b=OlqH9qQIcm/yJk/zBHWy0zHrtZ34JUFXXyGlpfxZXcH3B7KykP5Bqfoa1xI1pR38LpohZX
	ozHRZq2Re9Nm8FCQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 03/13] verification/rvgen: Implement state and transition parser based on Lark
Date: Thu, 28 May 2026 10:27:51 +0200
Message-ID: <e84c39bab831f1623142e6b83a9513ba99a702f1.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DOT parsing scripts directly parse the raw text and they are quite
fragile. If the input dot files' formats are slightly changed (for
instance, by breaking long some lines which is allowed by the DOT
language), the scripts would fail.

Prepare to move away from the raw text processing, implement parsers based
on Lark which parse states, transitions and constraints.

The parse results are not used yet. The existing scripts will be converted
one by one to them, and the raw text processing will eventually be removed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - fixup guard grammar [Gabriele]
  - fixup inconsistent types in a list [Wander]
  - compiling the parsers only once to avoid overhead [Sashiko]
  - fix up the signature of State.__init__() [Sashiko]
  - gracefully handle node statement without label [Sashiko]
  - lark parse exception handling
---
 tools/verification/rvgen/rvgen/automata.py | 216 +++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index 8649d982383d..b86275e7bf28 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -198,6 +198,164 @@ class ParseTree:
         self.node_attrs =3D attributes_parser.node_attrs
         self.edge_attrs =3D attributes_parser.edge_attrs
=20
+class ConstraintCondition:
+    def __init__(self, env: str, op: str, val: str, unit=3DNone):
+        self.env =3D env
+        self.op =3D op
+        self.val =3D val
+        self.unit =3D unit
+        if unit is None:
+            # try to infer unit from constants or parameters
+            val_for_unit =3D val.lower().replace("()", "")
+            if val_for_unit.endswith("_ns"):
+                self.unit =3D "ns"
+            if val_for_unit.endswith("_jiffies"):
+                self.unit =3D "j"
+
+class ConstraintRule:
+    grammar =3D r'''
+        rule: condition (OP condition)*
+
+        OP: "&&" | "||"
+
+        condition: ENV CMP_OP VAL UNIT?
+
+        ENV: CNAME
+
+        CMP_OP: "=3D=3D" | "<=3D" | "<" | ">=3D" | ">"
+
+        VAL: /[0-9]+/
+           | /[A-Z_]+\(\)/
+           | /[A-Z_]+/
+           | /[a-z_]+\(\)/
+           | /[a-z_]+/
+
+        UNIT: "ns" | "us" | "ms" | "s"
+    '''
+
+    def __init__(self, c: ConstraintCondition):
+        '''
+        A list of pairs of
+          - the condition (e.g. is_constr_dl =3D=3D 1)
+          - the logical operator ("||" or "&&") combining this
+            condition with the next one if it exists, otherwise None
+
+        TODO: Perhaps use an abstract syntax tree instead, because
+              this representation cannot capture precedence
+        '''
+        self.rules =3D [[c, None]]
+
+    def chain(self, op: str, c: ConstraintCondition):
+        self.rules[-1][1] =3D op
+        self.rules.append([c, None])
+
+class ConstraintReset:
+    def __init__(self, env):
+        self.env =3D env
+
+class StateLabelParser:
+    grammar =3D r'''
+    label: CNAME ("\\n" condition)?
+
+    %import common.CNAME
+    %import common.WS
+    %ignore WS
+    ''' + ConstraintRule.grammar
+
+    parser =3D lark.Lark(grammar, parser=3D'lalr', start=3D"label")
+
+    def __init__(self, label: str):
+        try:
+            tree =3D self.parser.parse(label)
+        except lark.exceptions.UnexpectedInput as exc:
+            raise(AutomataError(f"Unrecognised state \"{label}\"\n{exc}"))
+
+        self.state =3D tree.children[0]
+        self.constraint =3D None
+
+        if len(tree.children) =3D=3D 2:
+            self.constraint =3D ConstraintCondition(*tree.children[1].chil=
dren)
+            if self.constraint.op not in ("<", "<=3D"):
+                raise AutomataError("State constraints must be clock expir=
ations like"
+                                    f" clk<N ({label})")
+
+class EventLabelParser:
+    grammar =3D r'''
+    events: event ("\\n" event)*
+
+    event: name (";" guard)?
+
+    guard: reset
+         | rule
+         | rule ";" reset
+         | reset ";" rule
+
+    name: CNAME
+
+    reset: "reset" "(" ENV ")"
+
+    %import common.CNAME
+    %import common.WS
+    %ignore WS
+    ''' + ConstraintRule.grammar
+
+    parser =3D lark.Lark(grammar, parser=3D'lalr', start=3D"events")
+
+    class GetEvents(lark.visitors.Transformer):
+        def guard(self, args):
+            reset =3D None
+            rule =3D None
+            for arg in args:
+                if arg.data =3D=3D "reset":
+                    reset =3D ConstraintReset(arg.children[0])
+                elif arg.data =3D=3D "rule":
+                    conditions =3D arg.children
+                    rule =3D ConstraintRule(conditions[0])
+                    for i in range(1, len(conditions), 2):
+                        rule.chain(conditions[i], conditions[i + 1])
+            return reset, rule
+
+        def OP(self, args):
+            return args
+
+        def condition(self, args):
+            return ConstraintCondition(*args)
+
+        def event(self, args):
+            assert(len(args) <=3D 2)
+            name =3D args[0]
+            rule, reset =3D None, None
+            if len(args) =3D=3D 2:
+                reset, rule =3D args[1]
+            return name, reset, rule
+
+        def events(self, args):
+            return args
+
+        def name(self, args):
+            return args[0]
+
+    def __init__(self, label: str):
+        try:
+            tree =3D self.parser.parse(label)
+            self.events =3D self.GetEvents().transform(tree)
+        except lark.exceptions.UnexpectedInput as exc:
+            raise(AutomataError(f"Unrecognised event \"{label}\"\n{exc}"))
+
+class Transition:
+    def __init__(self, src: str, dst: str, event: str,
+                 reset: ConstraintReset, rule: ConstraintRule):
+        self.src =3D src
+        self.dst =3D dst
+        self.event =3D event
+        self.rule =3D rule
+        self.reset =3D reset
+
+class State:
+    def __init__(self, name: str, inv: ConstraintCondition):
+        self.name =3D name
+        self.inv =3D inv
+
 class _ConstraintKey:
     """Base class for constraint keys."""
=20
@@ -252,6 +410,8 @@ class Automata:
         self.name =3D model_name or self.__get_model_name()
         self.__dot_lines =3D self.__open_dot()
         self.__parse_tree =3D ParseTree(file_path)
+        self.transitions =3D self.__parse_transitions()
+        self._states, self._initial_state, self._final_states =3D self.__p=
arse_states()
         self.states, self.initial_state, self.final_states =3D self.__get_=
state_variables()
         self.env_types =3D {}
         self.env_stored =3D set()
@@ -327,6 +487,62 @@ class Automata:
=20
         return cursor
=20
+    def __parse_transitions(self):
+        transitions =3D []
+
+        for edge in self.__parse_tree.edges:
+            attr =3D self.__parse_tree.edge_attrs.get(edge)
+            if not attr:
+                continue
+
+            label =3D attr.get("label")
+
+            src, dst =3D edge
+
+            parser =3D EventLabelParser(label)
+            for event, reset, rule in parser.events:
+                transitions.append(Transition(src, dst, event, reset, rule=
))
+
+        transitions.sort(key=3Dlambda t : (t.src, t.event))
+        return transitions
+
+    def __parse_states(self):
+        initial_state =3D ""
+        states =3D []
+        final_states =3D []
+
+        for node in self.__parse_tree.nodes:
+            attr =3D self.__parse_tree.node_attrs[node]
+            label =3D attr.get("label")
+
+            if node.startswith(Automata.init_marker):
+                initial_state =3D node[len(Automata.init_marker):]
+
+            if not label:
+                continue
+
+            parser =3D StateLabelParser(label)
+            state =3D State(parser.state, parser.constraint)
+
+            states.append(state)
+
+            shape =3D attr.get("shape")
+            if shape in ("doublecircle", "ellipse"):
+                final_states.append(state)
+
+
+        initial_state =3D next((s for s in states if s.name =3D=3D initial=
_state), None)
+        if not initial_state:
+            raise AutomataError("The automaton doesn't have an initial sta=
te")
+
+        if not final_states:
+            final_states.append(initial_state)
+
+        states.remove(initial_state)
+        states.sort(key=3Dlambda s : s.name)
+        states.insert(0, initial_state)
+        return states, initial_state, final_states
+
     def __get_state_variables(self) -> tuple[list[str], str, list[str]]:
         # wait for node declaration
         states =3D []
--=20
2.47.3

