Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F137BE93;
	Thu, 28 May 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956900; cv=none; b=B8YMKJg5KCIwGomz4etL9nDZdx7PAVgapYG9b6FE9ePGa+TjTRInI4T6VpDxpcWa9SOgH9dcEYmNIgSIsp4Z7VmaEIhjMxsMinLJ9qctPfSlUuBMsObh5wxQkF4P+N1eDuzk2Oqn9TIkyeF3M08i2BYt3BOXQpKe3tCxTp4Xrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956900; c=relaxed/simple;
	bh=YMnJ0bDTgxP05Ho/krWIEQlWaug9miNgKuxukAvKcbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmHjvZtdM7v86CUZVpufBAKefSC9Cf6a3hIjDpuo7eu+obN7FNokGmO9Aq6AzXAdjmdm4laCrhegS74jr99ag1EoFMqnhsznUya306O4tclUWShH+9o8WSpBUvCvrvFEUtRc5t0azbxVtLYWg0rl7dlP46T/v5489NZajH5QW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqW8+Kv2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYcUv2VN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqW8+Kv2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYcUv2VN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXs11Cl8SMxhlkwqsr5BWeZFDF6ettb7K0b3+Y32PCA=;
	b=rqW8+Kv2QpKNWh/U3JJ7eq6pATMbugLxewgXnttTsr38IVvewTnwwy6QxOUvQSyH7o8Z1c
	THsiqM7Lh6suGKz+RI3/pHhERfvSf4nYUnL/ZX/z0uOyCBMsJ3ldz5pXssCw291WgAdu8s
	/yree8XcM5VZkvuZbBJ3rlMMi0AZGTd8+kTc2u2mkZ+50hqKABvA6PSsSXBtG0GZVHnMV9
	1P8plhv4TYY088bD4vwKP+b/4FzlxtYZrK/UyX3+SHaiqszwIETgEOLuvzROeaH4wKmQIL
	D3SBUt+qw0aQIKPfBZs+omIV0vCdbdvMs1SQjq5pm71SlTIx7OAU0D69GESePA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXs11Cl8SMxhlkwqsr5BWeZFDF6ettb7K0b3+Y32PCA=;
	b=qYcUv2VNoGSd0BMLzYz+0HTMaRZ60ii53d/WsrTuoWqg5H/np+WKwWbrY4szqMmPMtWDXx
	zNXZ0EvoxZwyoXAg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 13/13] verification/rvgen: Remove dead code
Date: Thu, 28 May 2026 10:28:01 +0200
Message-ID: <9120d2a5987b79b646dde4001381581b703c0dd7.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The conversion to use Lark left some dead code behind. Remove them.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 154 ---------------------
 tools/verification/rvgen/rvgen/dot2k.py    |  28 +---
 2 files changed, 1 insertion(+), 181 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index a3be327c2a73..b6ff5fceb820 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -356,19 +356,6 @@ class State:
         self.name =3D name
         self.inv =3D inv
=20
-class _ConstraintKey:
-    """Base class for constraint keys."""
-
-class _StateConstraintKey(_ConstraintKey, int):
-    """Key for a state constraint. Under the hood just state_id."""
-    def __new__(cls, state_id: int):
-        return super().__new__(cls, state_id)
-
-class _EventConstraintKey(_ConstraintKey, tuple):
-    """Key for an event constraint. Under the hood just tuple(state_id,eve=
nt_id)."""
-    def __new__(cls, state_id: int, event_id: int):
-        return super().__new__(cls, (state_id, event_id))
-
 class AutomataError(Exception):
     """Exception raised for errors in automata parsing and validation.
=20
@@ -387,28 +374,10 @@ class Automata:
=20
     invalid_state_str =3D "INVALID_STATE"
     init_marker =3D "__init_"
-    node_marker =3D "{node"
-    # val can be numerical, uppercase (constant or macro), lowercase (para=
meter or function)
-    # only numerical values should have units
-    constraint_rule =3D re.compile(r"""
-        ^
-        (?P<env>[a-zA-Z_][a-zA-Z0-9_]+)  # C-like identifier for the env v=
ar
-        (?P<op>[!<=3D>]{1,2})              # operator
-        (?P<val>
-            [0-9]+ |                     # numerical value
-            [A-Z_]+\(\) |                # macro
-            [A-Z_]+ |                    # constant
-            [a-z_]+\(\) |                # function
-            [a-z_]+                      # parameter
-        )
-        (?P<unit>[a-z]{1,2})?            # optional unit for numerical val=
ues
-        """, re.VERBOSE)
-    constraint_reset =3D re.compile(r"^reset\((?P<env>[a-zA-Z_][a-zA-Z0-9_=
]+)\)")
=20
     def __init__(self, file_path, model_name=3DNone):
         self.__dot_path =3D file_path
         self.name =3D model_name or self.__get_model_name()
-        self.__dot_lines =3D self.__open_dot()
         self.__parse_tree =3D ParseTree(file_path)
         self.transitions =3D self.__parse_transitions()
         self.states, self.initial_state, self.final_states =3D self.__pars=
e_states()
@@ -435,57 +404,6 @@ class Automata:
=20
         return model_name
=20
-    def __open_dot(self) -> list[str]:
-        dot_lines =3D []
-        try:
-            with open(self.__dot_path) as dot_file:
-                dot_lines =3D dot_file.readlines()
-        except OSError as exc:
-            raise AutomataError(exc.strerror) from exc
-
-        if not dot_lines:
-            raise AutomataError(f"{self.__dot_path} is empty")
-
-        # checking the first line:
-        line =3D dot_lines[0].split()
-
-        if len(line) < 2 or line[0] !=3D "digraph" or line[1] !=3D "state_=
automaton":
-            raise AutomataError(f"Not a valid .dot format: {self.__dot_pat=
h}")
-
-        return dot_lines
-
-    def __get_cursor_begin_states(self) -> int:
-        for cursor, line in enumerate(self.__dot_lines):
-            split_line =3D line.split()
-
-            if len(split_line) and split_line[0] =3D=3D self.node_marker:
-                return cursor
-
-        raise AutomataError("Could not find a beginning state")
-
-    def __get_cursor_begin_events(self) -> int:
-        state =3D 0
-        cursor =3D 0 # make pyright happy
-
-        for cursor, line in enumerate(self.__dot_lines):
-            line =3D line.split()
-            if not line:
-                continue
-
-            if state =3D=3D 0:
-                if line[0] =3D=3D self.node_marker:
-                    state =3D 1
-            elif line[0] !=3D self.node_marker:
-                break
-        else:
-            raise AutomataError("Could not find beginning event")
-
-        cursor +=3D 1 # skip initial state transition
-        if cursor =3D=3D len(self.__dot_lines):
-            raise AutomataError("Dot file ended after event beginning")
-
-        return cursor
-
     def __parse_transitions(self):
         transitions =3D []
=20
@@ -542,51 +460,6 @@ class Automata:
         states.insert(0, initial_state)
         return states, initial_state, final_states
=20
-    def __get_state_variables(self) -> tuple[list[str], str, list[str]]:
-        # wait for node declaration
-        states =3D []
-        final_states =3D []
-        initial_state =3D ""
-
-        has_final_states =3D False
-        cursor =3D self.__get_cursor_begin_states()
-
-        # process nodes
-        for line in islice(self.__dot_lines, cursor, None):
-            split_line =3D line.split()
-            if not split_line or split_line[0] !=3D self.node_marker:
-                break
-
-            raw_state =3D split_line[-1]
-
-            #  "enabled_fired"}; -> enabled_fired
-            state =3D raw_state.replace('"', '').replace('};', '').replace=
(',', '_')
-            if state.startswith(self.init_marker):
-                initial_state =3D state[len(self.init_marker):]
-            else:
-                states.append(state)
-                if "doublecircle" in line:
-                    final_states.append(state)
-                    has_final_states =3D True
-
-                if "ellipse" in line:
-                    final_states.append(state)
-                    has_final_states =3D True
-
-        if not initial_state:
-            raise AutomataError("The automaton doesn't have an initial sta=
te")
-
-        states =3D sorted(set(states))
-        states.remove(initial_state)
-
-        # Insert the initial state at the beginning of the states
-        states.insert(0, initial_state)
-
-        if not has_final_states:
-            final_states.append(initial_state)
-
-        return states, initial_state, final_states
-
     def __get_event_variables(self) -> tuple[list[str], list[str]]:
         events: list[str] =3D []
         envs: list[str] =3D []
@@ -609,26 +482,6 @@ class Automata:
=20
         return sorted(set(events)), sorted(set(envs))
=20
-    def _split_constraint_expr(self, constr: list[str]) -> Iterator[tuple[=
str,
-                                                                          =
str | None]]:
-        """
-        Get a list of strings of the type constr1 && constr2 and returns a=
 list of
-        constraints and separators: [[constr1,"&&"],[constr2,None]]
-        """
-        exprs =3D []
-        seps =3D []
-        for c in constr:
-            while "&&" in c or "||" in c:
-                a =3D c.find("&&")
-                o =3D c.find("||")
-                pos =3D a if o < 0 or 0 < a < o else o
-                exprs.append(c[:pos].replace(" ", ""))
-                seps.append(c[pos:pos + 2].replace(" ", ""))
-                c =3D c[pos + 2:].replace(" ", "")
-            exprs.append(c)
-            seps.append(None)
-        return zip(exprs, seps)
-
     def __extract_env_var(self, constraint: ConstraintCondition):
         if constraint.unit:
             self.env_types[constraint.env] =3D constraint.unit
@@ -697,10 +550,3 @@ class Automata:
=20
     def is_hybrid_automata(self) -> bool:
         return bool(self.envs)
-
-    def is_event_constraint(self, key: _ConstraintKey) -> bool:
-        """
-        Given the key in self.constraints return true if it is an event
-        constraint, false if it is a state constraint
-        """
-        return isinstance(key, _EventConstraintKey)
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 49cb3e724a93..d6779ac6b7dd 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -11,9 +11,7 @@
 from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
-from .automata import _EventConstraintKey, _StateConstraintKey, AutomataEr=
ror
-from .automata import ConstraintRule, ConstraintCondition
-
+from .automata import ConstraintRule, ConstraintCondition, AutomataError
=20
 class dot2k(Monitor, Dot2c):
     template_dir =3D "dot2k"
@@ -217,9 +215,6 @@ class ha2k(dot2k):
                 value *=3D 10**9
         return str(value) + "ull"
=20
-    def __parse_single_constraint(self, rule: dict, value: str) -> str:
-        return f"ha_get_env(ha_mon, {rule["env"]}{self.enum_suffix}, time_=
ns) {rule["op"]} {value}"
-
     def __parse_guard_rule(self, rule) -> list[str]:
         buff =3D []
         for c, sep in rule.rules:
@@ -233,12 +228,6 @@ class ha2k(dot2k):
             buff.append(cond)
         return buff
=20
-    def __get_constraint_env(self, constr: str) -> str:
-        """Extract the second argument from an ha_ function"""
-        env =3D constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
-        assert env.rstrip(f"_{self.name}") in self.envs
-        return env
-
     def __start_to_invariant_check(self, inv: ConstraintCondition) -> str:
         # by default assume the timer has ns expiration
         clock_type =3D "ns"
@@ -249,21 +238,6 @@ class ha2k(dot2k):
=20
         return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns, {value})"
=20
-    def __start_to_conv(self, constr: str) -> str:
-        """
-        Undo the storage conversion done by ha_start_timer_
-        """
-        return "ha_inv_to_guard" + constr[constr.find("("):]
-
-    def __parse_timer_constraint(self, rule: dict, value: str) -> str:
-        # by default assume the timer has ns expiration
-        clock_type =3D "ns"
-        if self.env_types.get(rule["env"]) =3D=3D "j":
-            clock_type =3D "jiffy"
-
-        return (f"ha_start_timer_{clock_type}(ha_mon, {rule["env"]}{self.e=
num_suffix},"
-                f" {value}, time_ns)")
-
     def __parse_invariant(self, inv):
         # by default assume the timer has ns expiration
         clock_type =3D "ns"
--=20
2.47.3

