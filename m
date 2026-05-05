Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B93A1A5D;
	Tue,  5 May 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964388; cv=none; b=E73E/H+tkeleL4BBmbs3D7aqJ9/tNYVUWwOGo7ZguVH7jsvlFwPY3rhz4f9ZXQ883rwthI+nsxxl7z4jomp5VGBwFmZH1zV70EPQixUobAYyx9kGUgQDxPc1cyrGlpWj3FOdlF5FhwU7TxwBuhgNXXtoBUtBaD0cvOI1Epc2gDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964388; c=relaxed/simple;
	bh=3Tc1VtSpaal8vA7z553+yAq6dlaFSiy8yVIdLyfgsXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThK0lHrffqJjcLmwm8hy/HKrG2yaxoKT96DPxDYanLOq5WE6BtliaNB3EprHSExw5W+fca1IWcndzx2W9cBH1D2PYG1mWK5P8IOepeA7ClivUFZxg/P05wQbQH9gHn6VdklEU98N0s2/HKfnQzuDVrdThUqYkrqrCO/mc+NDiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rkjqg7u2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdUZFZeW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rkjqg7u2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdUZFZeW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNM8CyygL7FGiRGRnj6bzhGY0NXr/eH5Oqh3Z3mRgv4=;
	b=Rkjqg7u2VNpkXkjPUT5d84DbioZE8x66otCUpOsE5ISjeqOy9xOprMZChRKoH8V7C5PkEz
	SIebUKVONXV0Y/pK2TWxJdkbZ/VqN7/5VWKeESo0utXnklPaT+rRxYtYyDMEhKcDaC9Wp1
	7msEeuAtZQbaaRIQWutIPvLZ3I0mFbNlXzTUVoJ7hScLYZ3wAwC3cD09xU1AEGYtOb8ZqH
	91mUFt2zIQHNrA981ztTKr6DVulq74apeJC5PJADVKc1WyLngfg62f7qxWXlvTP+jKoiks
	MkVeS4NCp4rEd37xk1xRBLb7tJqH1ot6MwCWGzSBORBcqC6Ry9jxh/GLPELkvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNM8CyygL7FGiRGRnj6bzhGY0NXr/eH5Oqh3Z3mRgv4=;
	b=cdUZFZeWBl9fI60HQ0DU7mpcOfUDqw0DOgUlO6llx9PC0o17pVvJX/XcoFcBoWfmPW3m4t
	N/nV0dbEUVnNopBg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 03/13] verification/rvgen: Implement state and transition parser based on Lark
Date: Tue,  5 May 2026 08:59:24 +0200
Message-ID: <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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
 tools/verification/rvgen/rvgen/automata.py | 207 +++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index 4e3d719a0952..32c16736a41b 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -194,6 +194,155 @@ class ParseTree:
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
+        self.rules.append((c, None))
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
+    def __init__(self, label: str):
+        parser =3D lark.Lark(self.grammar, parser=3D'lalr', start=3D"label=
")
+        tree =3D parser.parse(label)
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
+    event: name (";" guard)*
+
+    guard: reset
+         | rule
+         | rule reset
+         | reset rule
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
+        parser =3D lark.Lark(self.grammar, parser=3D'lalr', start=3D"event=
s")
+        tree =3D parser.parse(label)
+        self.events =3D self.GetEvents().transform(tree)
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
+    def __init__(self, name: str, inv: ConstraintRule):
+        self.name =3D name
+        self.inv =3D inv
+
 class _ConstraintKey:
     """Base class for constraint keys."""
=20
@@ -248,6 +397,8 @@ class Automata:
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
@@ -323,6 +474,62 @@ class Automata:
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
+            label =3D attr["label"]
+
+            if node.startswith(Automata.init_marker):
+                initial_state =3D node[len(Automata.init_marker):]
+
+            if not label:
+                continue
+
+            parser =3D StateLabelParser(attr["label"])
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

