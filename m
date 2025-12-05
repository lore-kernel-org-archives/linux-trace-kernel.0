Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCD32F756
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940628; cv=none; b=Zoj6OUNkFejWteTjYW2f4KeVEXD/sa3LVDRgH05rHAzjJo/9LP7oDlhVUnGsa1+z7L6HyS0Xzdc2nO/oKvvvGSD9pc0ArnKiMpgxlBTV8WYeOnwm0T8ET5rd9aIF6NXO8VqvLzQUpUERCT6cVsMoqj1zybpjomR61oDb/qDJXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940628; c=relaxed/simple;
	bh=P7jRvn9M5gqanE12OJhNw9Zo9LYWcONhcYjh0YljXPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmmvLEeaMMfSFV6uzWSQQCO5HEYvsq2TPNger8mogebmMuRxNeX6hXNc4Ofye9GhshEOv97zz9rL4MsDW+qSIEb7b8UF3cpc8pF+mUwr52lWU4d/pICJkXa4gEuMV9KRtHyrD4ev/UVRqvq1X1DvhjbtnQHc0v1Xew3rp/cCCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMCMeLv/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMCMeLv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE9SUm+G0dnEBbgtLeKU+UqlHVL9kA8ig3SnM7DTyDk=;
	b=DMCMeLv/QwtgP13kN5adA/QmDNrZx8+0LXKIT1D/Uy7KwrAGdrS0DEHH4Zz70aERUtWi/W
	nCXMciQAYpZrV6AHsRquEGgXxzpUuNbc3+x0g5WBj5GqSTjC2jOBr2tIsImTgwqawbstWu
	Ulnm3YYnLzt8hc5g8aZETgEOkaQciDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-RS00ZabbMpOEtLe4qlPriw-1; Fri,
 05 Dec 2025 08:16:58 -0500
X-MC-Unique: RS00ZabbMpOEtLe4qlPriw-1
X-Mimecast-MFC-AGG-ID: RS00ZabbMpOEtLe4qlPriw_1764940616
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E17CB180065F;
	Fri,  5 Dec 2025 13:16:55 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 688E4180045B;
	Fri,  5 Dec 2025 13:16:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 04/13] verification/rvgen: Add support for Hybrid Automata
Date: Fri,  5 Dec 2025 14:16:12 +0100
Message-ID: <20251205131621.135513-5-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the possibility to parse dot files as hybrid automata and generate
the necessary code from rvgen.

Hybrid automata are very similar to deterministic ones and most
functionality is shared, the dot files include also constraints together
with event names (separated by ;) and state names (separated by \n).

The tool can now generate the appropriate code to validate constraints
at runtime according to the dot specification.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/__main__.py          |   8 +-
 tools/verification/rvgen/rvgen/automata.py    | 141 +++++-
 tools/verification/rvgen/rvgen/dot2c.py       |  49 ++
 tools/verification/rvgen/rvgen/dot2k.py       | 473 +++++++++++++++++-
 tools/verification/rvgen/rvgen/generator.py   |   2 +
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  16 +
 7 files changed, 677 insertions(+), 14 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index fa6fc1f4de2f..b8e07e463293 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -9,7 +9,7 @@
 #   Documentation/trace/rv/da_monitor_synthesis.rst
 
 if __name__ == '__main__':
-    from rvgen.dot2k import dot2k
+    from rvgen.dot2k import da2k, ha2k
     from rvgen.generator import Monitor
     from rvgen.container import Container
     from rvgen.ltl2k import ltl2k
@@ -29,7 +29,7 @@ if __name__ == '__main__':
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
     monitor_parser.add_argument('-c', "--class", dest="monitor_class",
-                                help="Monitor class, either \"da\" or \"ltl\"")
+                                help="Monitor class, either \"da\", \"ha\" or \"ltl\"")
     monitor_parser.add_argument('-s', "--spec", dest="spec", help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
@@ -43,7 +43,9 @@ if __name__ == '__main__':
         if params.subcmd == "monitor":
             print("Opening and parsing the specification file %s" % params.spec)
             if params.monitor_class == "da":
-                monitor = dot2k(params.spec, params.monitor_type, vars(params))
+                monitor = da2k(params.spec, params.monitor_type, vars(params))
+            elif params.monitor_class == "ha":
+                monitor = ha2k(params.spec, params.monitor_type, vars(params))
             elif params.monitor_class == "ltl":
                 monitor = ltl2k(params.spec, params.monitor_type, vars(params))
             else:
diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 977ba859c34e..252c9960ee1c 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -9,24 +9,63 @@
 #   Documentation/trace/rv/deterministic_automata.rst
 
 import ntpath
+import re
+from typing import Iterator
+
+class _ConstraintKey:
+    """Base class for constraint keys."""
+
+class _StateConstraintKey(_ConstraintKey, int):
+    """Key for a state constraint. Under the hood just state_id."""
+    def __new__(cls, state_id: int):
+        return super().__new__(cls, state_id)
+
+class _EventConstraintKey(_ConstraintKey, tuple):
+    """Key for an event constraint. Under the hood just tuple(state_id,event_id)."""
+    def __new__(cls, state_id: int, event_id: int):
+        return super().__new__(cls, (state_id, event_id))
 
 class Automata:
     """Automata class: Reads a dot file and part it as an automata.
 
+    It supports both deterministic and hybrid automata.
+
     Attributes:
         dot_file: A dot file with an state_automaton definition.
     """
 
     invalid_state_str = "INVALID_STATE"
+    # val can be numerical, uppercase (constant or macro), lowercase (parameter or function)
+    # only numerical values should have units
+    constraint_rule = re.compile(r"""
+        ^
+        (?P<env>[a-zA-Z_][a-zA-Z0-9_]+)  # C-like identifier for the env var
+        (?P<op>[!<=>]{1,2})              # operator
+        (?P<val>
+            [0-9]+ |                     # numerical value
+            [A-Z_]+\(\) |                # macro
+            [A-Z_]+ |                    # constant
+            [a-z_]+\(\) |                # function
+            [a-z_]+                      # parameter
+        )
+        (?P<unit>[a-z]{1,2})?            # optional unit for numerical values
+        """, re.VERBOSE)
+    constraint_reset = re.compile(r"^reset\((?P<env>[a-zA-Z_][a-zA-Z0-9_]+)\)")
 
     def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
         self.name = model_name or self.__get_model_name()
         self.__dot_lines = self.__open_dot()
         self.states, self.initial_state, self.final_states = self.__get_state_variables()
-        self.events = self.__get_event_variables()
-        self.function = self.__create_matrix()
+        self.env_types = {}
+        self.env_stored = set()
+        self.constraint_vars = set()
+        self.self_loop_reset_events = set()
+        self.events, self.envs = self.__get_event_variables()
+        self.function, self.constraints = self.__create_matrix()
         self.events_start, self.events_start_run = self.__store_init_events()
+        self.env_stored = sorted(self.env_stored)
+        self.constraint_vars = sorted(self.constraint_vars)
 
     def __get_model_name(self) -> str:
         basename = ntpath.basename(self.__dot_path)
@@ -116,11 +155,12 @@ class Automata:
 
         return states, initial_state, final_states
 
-    def __get_event_variables(self) -> list[str]:
+    def __get_event_variables(self) -> tuple[list[str], list[str]]:
         # here we are at the begin of transitions, take a note, we will return later.
         cursor = self.__get_cursor_begin_events()
 
         events = []
+        envs = []
         while self.__dot_lines[cursor].lstrip()[0] == '"':
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
@@ -134,12 +174,74 @@ class Automata:
                 # so split them.
 
                 for i in event.split("\\n"):
-                    events.append(i)
+                    # if the event contains a constraint (hybrid automata),
+                    # it will be separated by a ";":
+                    # "sched_switch;x<1000;reset(x)"
+                    ev, *constr = i.split(";")
+                    if constr:
+                        if len(constr) > 2:
+                            raise ValueError("Only 1 constraint and 1 reset are supported")
+                        envs += self.__extract_env_var(constr)
+                    events.append(ev)
+            else:
+                # state labels have the format:
+                # "enable_fired" [label = "enable_fired\ncondition"];
+                #  ----- label is here -----^^^^^
+                # label and node name must be the same, condition is optional
+                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                _, *constr = state.split("\\n")
+                if constr:
+                    if len(constr) > 1:
+                        raise ValueError("Only 1 constraint is supported in the state")
+                    envs += self.__extract_env_var([constr[0].replace(" ", "")])
             cursor += 1
 
-        return sorted(set(events))
-
-    def __create_matrix(self) -> list[list[str]]:
+        return sorted(set(events)), sorted(set(envs))
+
+    def _split_constraint_expr(self, constr: list[str]) -> Iterator[tuple[str,
+                                                                          str | None]]:
+        """
+        Get a list of strings of the type constr1 && constr2 and returns a list of
+        constraints and separators: [[constr1,"&&"],[constr2,None]]
+        """
+        exprs = []
+        seps = []
+        for c in constr:
+            while "&&" in c or "||" in c:
+                a = c.find("&&")
+                o = c.find("||")
+                pos = a if o < 0 or 0 < a < o else o
+                exprs.append(c[:pos].replace(" ", ""))
+                seps.append(c[pos:pos+2].replace(" ", ""))
+                c = c[pos+2:].replace(" ", "")
+            exprs.append(c)
+            seps.append(None)
+        return zip(exprs, seps)
+
+    def __extract_env_var(self, constraint: list[str]) -> list[str]:
+        env = []
+        for c, _ in self._split_constraint_expr(constraint):
+            rule = self.constraint_rule.search(c)
+            reset = self.constraint_reset.search(c)
+            if rule:
+                env.append(rule["env"])
+                if rule.groupdict().get("unit"):
+                    self.env_types[rule["env"]] = rule["unit"]
+                if rule["val"][0].isalpha():
+                    self.constraint_vars.add(rule["val"])
+                # try to infer unit from constants or parameters
+                val_for_unit = rule["val"].lower().replace("()", "")
+                if val_for_unit.endswith("_ns"):
+                    self.env_types[rule["env"]] = "ns"
+                if val_for_unit.endswith("_jiffies"):
+                    self.env_types[rule["env"]] = "j"
+            if reset:
+                env.append(reset["env"])
+                # environment variables that are reset need a storage
+                self.env_stored.add(reset["env"])
+        return env
+
+    def __create_matrix(self) -> tuple[list[list[str]], dict[_ConstraintKey, list[str]]]:
         # transform the array into a dictionary
         events = self.events
         states = self.states
@@ -157,6 +259,7 @@ class Automata:
 
         # declare the matrix....
         matrix = [[ self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        constraints: dict[_ConstraintKey, list[str]] = {}
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
@@ -168,10 +271,22 @@ class Automata:
                 dest_state = line[2].replace('"','').replace(',','_')
                 possible_events = "".join(line[line.index("label")+2:-1]).replace('"','')
                 for event in possible_events.split("\\n"):
+                    event, *constr = event.split(";")
+                    if constr:
+                        key = _EventConstraintKey(states_dict[origin_state], events_dict[event])
+                        constraints[key] = constr
+                        # those events reset also on self loops
+                        if origin_state == dest_state and "reset" in "".join(constr):
+                            self.self_loop_reset_events.add(event)
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
+            else:
+                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                state, *constr = state.replace(" ", "").split("\\n")
+                if constr:
+                    constraints[_StateConstraintKey(states_dict[state])] = constr
             cursor += 1
 
-        return matrix
+        return matrix, constraints
 
     def __store_init_events(self) -> tuple[list[bool], list[bool]]:
         events_start = [False] * len(self.events)
@@ -203,3 +318,13 @@ class Automata:
         if any(self.events_start):
             return False
         return self.events_start_run[self.events.index(event)]
+
+    def is_hybrid_automata(self) -> bool:
+        return bool(self.envs)
+
+    def is_event_constraint(self, key: _ConstraintKey) -> bool:
+        """
+        Given the key in self.constraints return true if it is an event
+        constraint, false if it is a state constraint
+        """
+        return isinstance(key, _EventConstraintKey)
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 06a26bf15a7e..7f2efcfe3e52 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -19,6 +19,7 @@ class Dot2c(Automata):
     enum_suffix = ""
     enum_states_def = "states"
     enum_events_def = "events"
+    enum_envs_def = "envs"
     struct_automaton_def = "automaton"
     var_automaton_def = "aut"
 
@@ -61,6 +62,39 @@ class Dot2c(Automata):
 
         return buff
 
+    def __get_non_stored_envs(self) -> list[str]:
+        return [ e for e in self.envs if e not in self.env_stored ]
+
+    def __get_enum_envs_content(self) -> list[str]:
+        buff = []
+        # We first place env variables that have a u64 storage.
+        # Those are limited by MAX_HA_ENV_LEN, other variables
+        # are read only and don't require a storage.
+        unstored = self.__get_non_stored_envs()
+        for env in list(self.env_stored) + unstored:
+            buff.append("\t%s%s," % (env, self.enum_suffix))
+
+        buff.append("\tenv_max%s," % self.enum_suffix)
+        buff.append("\tenv_max_stored%s = %s%s," %
+                    (self.enum_suffix,
+                     unstored[0] if len(unstored) else "env_max",
+                     self.enum_suffix))
+
+        return buff
+
+    def format_envs_enum(self) -> list[str]:
+        buff = []
+        if self.is_hybrid_automata():
+            buff.append("enum %s {" % self.enum_envs_def)
+            buff += self.__get_enum_envs_content()
+            buff.append("};\n")
+            buff.append('_Static_assert(env_max_stored%s <= MAX_HA_ENV_LEN, "Not enough slots");' %
+                        (self.enum_suffix))
+            if {"ns", "us", "ms", "s"}.intersection(self.env_types.values()):
+                buff.append("#define HA_CLK_NS")
+            buff.append("")
+        return buff
+
     def get_minimun_type(self) -> str:
         min_type = "unsigned char"
 
@@ -81,6 +115,8 @@ class Dot2c(Automata):
         buff.append("struct %s {" % self.struct_automaton_def)
         buff.append("\tchar *state_names[state_max%s];" % (self.enum_suffix))
         buff.append("\tchar *event_names[event_max%s];" % (self.enum_suffix))
+        if self.is_hybrid_automata():
+            buff.append("\tchar *env_names[env_max%s];" % (self.enum_suffix))
         buff.append("\t%s function[state_max%s][event_max%s];" % (min_type, self.enum_suffix, self.enum_suffix))
         buff.append("\t%s initial_state;" % min_type)
         buff.append("\tbool final_states[state_max%s];" % (self.enum_suffix))
@@ -113,6 +149,17 @@ class Dot2c(Automata):
 
         return buff
 
+    def format_aut_init_envs_string(self) -> list[str]:
+        buff = []
+        if self.is_hybrid_automata():
+            buff.append("\t.env_names = {")
+            # maintain consistent order with the enum
+            ordered_envs = list(self.env_stored) + self.__get_non_stored_envs()
+            buff.append(self.__get_string_vector_per_line_content(ordered_envs))
+            buff.append("\t},")
+
+        return buff
+
     def __get_max_strlen_of_states(self) -> int:
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
@@ -205,10 +252,12 @@ class Dot2c(Automata):
         buff += self.format_states_enum()
         buff += self.format_invalid_state()
         buff += self.format_events_enum()
+        buff += self.format_envs_enum()
         buff += self.format_automaton_definition()
         buff += self.format_aut_init_header()
         buff += self.format_aut_init_states_string()
         buff += self.format_aut_init_events_string()
+        buff += self.format_aut_init_envs_string()
         buff += self.format_aut_init_function()
         buff += self.format_aut_init_initial_state()
         buff += self.format_aut_init_final_states()
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 6128fe238430..e72369ec1ad7 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -8,8 +8,10 @@
 # For further information, see:
 #   Documentation/trace/rv/da_monitor_synthesis.rst
 
+from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
+from .automata import _EventConstraintKey, _StateConstraintKey
 
 
 class dot2k(Monitor, Dot2c):
@@ -20,12 +22,16 @@ class dot2k(Monitor, Dot2c):
         Monitor.__init__(self, extra_params)
         Dot2c.__init__(self, file_path, extra_params.get("model_name"))
         self.enum_suffix = "_%s" % self.name
+        self.monitor_class = extra_params["monitor_class"]
 
     def fill_monitor_type(self) -> str:
-        return self.monitor_type.upper()
+        buff = [ self.monitor_type.upper() ]
+        buff += self._fill_timer_type()
+        return "\n".join(buff)
 
     def fill_tracepoint_handlers_skel(self) -> str:
         buff = []
+        buff += self._fill_hybrid_definitions()
         for event in self.events:
             buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
             buff.append("{")
@@ -77,6 +83,7 @@ class dot2k(Monitor, Dot2c):
         #
         self.enum_states_def = "states_%s" % self.name
         self.enum_events_def = "events_%s" % self.name
+        self.enum_envs_def = "envs_%s" % self.name
         self.struct_automaton_def = "automaton_%s" % self.name
         self.var_automaton_def = "automaton_%s" % self.name
 
@@ -107,8 +114,14 @@ class dot2k(Monitor, Dot2c):
                 ("char *", "state"),
                 ("char *", "event"),
                 ]
+        tp_args_error_env = tp_args_error + [("char *", "env")]
+        tp_args_dict = {
+                "event": tp_args_event,
+                "error": tp_args_error,
+                "error_env": tp_args_error_env
+                }
         tp_args_id = ("int ", "id")
-        tp_args = tp_args_event if tp_type == "event" else tp_args_error
+        tp_args = tp_args_dict[tp_type]
         if self.monitor_type == "per_task":
             tp_args.insert(0, tp_args_id)
         tp_proto_c = ", ".join([a+b for a,b in tp_args])
@@ -117,6 +130,14 @@ class dot2k(Monitor, Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return '\n'.join(buff)
 
+    def _fill_hybrid_definitions(self) -> list:
+        """Stub, not valid for deterministic automata"""
+        return []
+
+    def _fill_timer_type(self) -> list:
+        """Stub, not valid for deterministic automata"""
+        return []
+
     def fill_main_c(self) -> str:
         main_c = super().fill_main_c()
 
@@ -127,5 +148,453 @@ class dot2k(Monitor, Dot2c):
         main_c = main_c.replace("%%MIN_TYPE%%", min_type)
         main_c = main_c.replace("%%NR_EVENTS%%", str(nr_events))
         main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
+        main_c = main_c.replace("%%MONITOR_CLASS%%", self.monitor_class)
 
         return main_c
+
+class da2k(dot2k):
+    """Deterministic automata only"""
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+        if self.is_hybrid_automata():
+            raise ValueError("Detected hybrid automata, use the 'ha' class")
+
+class ha2k(dot2k):
+    """Hybrid automata only"""
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+        if not self.is_hybrid_automata():
+            raise ValueError("Detected deterministic automata, use the 'da' class")
+        self.trace_h = self._read_template_file("trace_hybrid.h")
+        self.__parse_constraints()
+
+    def fill_monitor_class_type(self) -> str:
+        if self.monitor_type == "per_task":
+            return "HA_MON_EVENTS_ID"
+        return "HA_MON_EVENTS_IMPLICIT"
+
+    def fill_monitor_class(self) -> str:
+        """
+        Used for tracepoint classes, since they are shared we keep da
+        instead of ha (also for the ha specific tracepoints).
+        The tracepoint class is not visible to the tools.
+        """
+        return super().fill_monitor_class()
+
+    def __adjust_value(self, value: str | int, unit: str | None) -> str:
+        """Adjust the value in ns"""
+        try:
+            value = int(value)
+        except ValueError:
+            # it's a constant, a parameter or a function
+            if value.endswith("()"):
+                return value.replace("()", "(ha_mon)")
+            return value
+        match unit:
+            case "us":
+                value *= 10**3
+            case "ms":
+                value *= 10**6
+            case "s":
+                value *= 10**9
+        return str(value) + "ull"
+
+    def __parse_single_constraint(self, rule: dict, value: str) -> str:
+        return "ha_get_env(ha_mon, %s%s, time_ns) %s %s" % (
+                rule["env"], self.enum_suffix, rule["op"], value)
+
+    def __get_constraint_env(self, constr: str) -> str:
+        """Extract the second argument from an ha_ function"""
+        env = constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
+        assert env.rstrip(f"_{self.name}") in self.envs
+        return env
+
+    def __start_to_invariant_check(self, constr:str) -> str:
+        # by default assume the timer has ns expiration
+        env = self.__get_constraint_env(constr)
+        clock_type = "ns"
+        if self.env_types.get(env.rstrip(f"_{self.name}")) == "j":
+            clock_type = "jiffy"
+
+        return "return ha_check_invariant_%s(ha_mon, %s, time_ns)" % (clock_type, env)
+
+    def __start_to_conv(self, constr: str) -> str:
+        """
+        Undo the storage conversion done by ha_start_timer_
+        """
+        return "ha_inv_to_guard" + constr[constr.find("("):]
+
+    def __parse_timer_constraint(self, rule: dict, value: str) -> str:
+        # by default assume the timer has ns expiration
+        clock_type = "ns"
+        if self.env_types.get(rule["env"]) == "j":
+            clock_type = "jiffy"
+
+        return "ha_start_timer_%s(ha_mon, %s%s, %s, time_ns)" % (clock_type, rule["env"],
+                                                                 self.enum_suffix, value)
+
+    def __format_guard_rules(self, rules: list[str]) -> list[str]:
+        """
+        Merge guard constraints as a single C return statement.
+        If the rules include a stored env, also check its validity.
+        Break lines in a best effort way that tries to keep readability.
+        """
+        if not rules:
+            return []
+
+        invalid_checks = [f"ha_monitor_env_invalid(ha_mon, {env}{self.enum_suffix}) ||"
+                         for env in self.env_stored if any(env in rule for rule in rules)]
+        if invalid_checks and len(rules) > 1:
+            rules[0] = "(" + rules[0]
+            rules[-1] = rules[-1] + ")"
+        rules = invalid_checks + rules
+
+        separator = "\n\t\t      " if sum(len(r) for r in rules) > 80 else " "
+        return ["res = " + separator.join(rules)]
+
+    def __validate_constraint(self, key: tuple[int, int] | int, constr: str,
+                              rule, reset) -> None:
+        # event constrains are tuples and allow both rules and reset
+        # state constraints are only used for expirations (e.g. clk<N)
+        if self.is_event_constraint(key):
+            if not rule and not reset:
+                raise ValueError("Unrecognised event constraint (%s/%s: %s)"
+                                 % (self.states[key[0]], self.events[key[1]], constr))
+            if rule and (rule["env"] in self.env_types and
+                         rule["env"] not in self.env_stored):
+                raise ValueError("Clocks in hybrid automata always require a storage (%s)"
+                                 % rule["env"])
+        else:
+            if not rule:
+                raise ValueError("Unrecognised state constraint (%s: %s)"
+                                 % (self.states[key], constr))
+            if rule["env"] not in self.env_stored:
+                raise ValueError("State constraints always require a storage (%s)"
+                                 % rule["env"])
+            if rule["op"] not in ["<", "<="]:
+                raise ValueError("State constraints must be clock expirations like clk<N (%s)"
+                                 % rule.string)
+
+    def __parse_constraints(self) -> None:
+        self.guards: dict[_EventConstraintKey, str] = {}
+        self.invariants: dict[_StateConstraintKey, str] = {}
+        for key, constraint in self.constraints.items():
+            rules = []
+            resets = []
+            for c, sep in self._split_constraint_expr(constraint):
+                rule = self.constraint_rule.search(c)
+                reset = self.constraint_reset.search(c)
+                self.__validate_constraint(key, c, rule, reset)
+                if rule:
+                    value = rule["val"]
+                    value_len = len(rule["val"])
+                    unit = None
+                    if rule.groupdict().get("unit"):
+                        value_len += len(rule["unit"])
+                        unit = rule["unit"]
+                    c = c[:-(value_len)]
+                    value = self.__adjust_value(value, unit)
+                    if self.is_event_constraint(key):
+                        c = self.__parse_single_constraint(rule, value)
+                        if sep:
+                            c += f" {sep}"
+                    else:
+                        c = self.__parse_timer_constraint(rule, value)
+                    rules.append(c)
+                if reset:
+                    c = "ha_reset_env(ha_mon, %s%s, time_ns)" % (reset["env"],
+                                                                 self.enum_suffix)
+                    resets.append(c)
+            if self.is_event_constraint(key):
+                res = self.__format_guard_rules(rules) + resets
+                self.guards[key] = ";".join(res)
+            else:
+                self.invariants[key] = rules[0]
+
+    def __fill_verify_invariants_func(self) -> list[str]:
+        buff = []
+        if not self.invariants:
+            return []
+
+        buff.append(
+"""static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
+\t\t\t\t\tenum %s curr_state, enum %s event,
+\t\t\t\t\tenum %s next_state, u64 time_ns)
+{""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+
+        _else = ""
+        for state, constr in self.invariants.items():
+            check_str = self.__start_to_invariant_check(constr)
+            buff.append("\t%sif (curr_state == %s%s)" %
+                        (_else, self.states[state], self.enum_suffix))
+            buff.append("\t\t%s;" % check_str)
+            _else = "else "
+
+        buff.append("\treturn true;\n}\n")
+        return buff
+
+    def __fill_convert_inv_guard_func(self) -> list[str]:
+        buff = []
+        if not self.invariants:
+            return []
+
+        conflict_guards, conflict_invs = self.__find_inv_conflicts()
+        if not conflict_guards and not conflict_invs:
+            return []
+
+        buff.append(
+"""static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
+\t\t\t\t\tenum %s curr_state, enum %s event,
+\t\t\t\t\tenum %s next_state, u64 time_ns)
+{""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+        buff.append("\tif (curr_state == next_state)\n\t\treturn;")
+
+        _else = ""
+        for state, constr in self.invariants.items():
+            # a state with invariant can reach us without reset
+            # multiple conflicts must have the same invariant, otherwise we cannot
+            # know how to reset the value
+            conf_i = [start for start, end in conflict_invs if end == state]
+            # we can reach a guard without reset
+            conf_g = [e for s, e in conflict_guards if s == state]
+            if not conf_i and not conf_g:
+                continue
+            buff.append("\t%sif (curr_state == %s%s)" %
+                        (_else, self.states[state], self.enum_suffix))
+            buff.append("\t\t%s;" % self.__start_to_conv(constr))
+            _else = "else "
+
+        buff.append("}\n")
+        return buff
+
+    def __fill_verify_guards_func(self) -> list[str]:
+        buff = []
+        if not self.guards:
+            return []
+
+        buff.append(
+"""static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+\t\t\t\t    enum %s curr_state, enum %s event,
+\t\t\t\t    enum %s next_state, u64 time_ns)
+{
+\tbool res = true;
+""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+
+        _else = ""
+        for edge, constr in self.guards.items():
+            buff.append("\t%sif (curr_state == %s%s && event == %s%s)" %
+                        (_else, self.states[edge[0]], self.enum_suffix,
+                         self.events[edge[1]], self.enum_suffix))
+            if constr.count(";") > 0:
+                buff[-1] += " {"
+            buff += [ "\t\t%s;" % c for c in constr.split(";") ]
+            if constr.count(";") > 0:
+                _else = "} else "
+            else:
+                _else = "else "
+        if _else[0] == "}":
+            buff.append("\t}")
+        buff.append("\treturn res;\n}\n")
+        return buff
+
+    def __find_inv_conflicts(self) -> tuple[set[tuple[int, _EventConstraintKey]],
+                                            set[tuple[int, _StateConstraintKey]]]:
+        """
+        Run a breadth first search from all states with an invariant.
+        Find any conflicting constraints reachable from there, this can be
+        another state with an invariant or an edge with a non-reset guard.
+        Stop when we find a reset.
+
+        Return the set of conflicting guards and invariants as tuples of
+        conflicting state and constraint key.
+        """
+        conflict_guards : set[tuple[int, _EventConstraintKey]] = set()
+        conflict_invs : set[tuple[int, _StateConstraintKey]] = set()
+        for start_idx in self.invariants:
+            queue = deque([(start_idx, 0)])  # (state_idx, distance)
+            env = self.__get_constraint_env(self.invariants[start_idx])
+
+            while queue:
+                curr_idx, distance = queue.popleft()
+
+                # Check state condition
+                if curr_idx != start_idx and curr_idx in self.invariants:
+                    conflict_invs.add((start_idx, _StateConstraintKey(curr_idx)))
+                    continue
+
+                # Check if we should stop
+                if distance > len(self.states):
+                    break
+                if curr_idx != start_idx and distance > 1:
+                    continue
+
+                for event_idx, next_state_name in enumerate(self.function[curr_idx]):
+                    if next_state_name == self.invalid_state_str:
+                        continue
+                    curr_guard = self.guards.get((curr_idx, event_idx), "")
+                    if "reset" in curr_guard and env in curr_guard:
+                        continue
+
+                    if env in curr_guard:
+                        conflict_guards.add((start_idx,
+                                             _EventConstraintKey(curr_idx, event_idx)))
+                        continue
+
+                    next_idx = self.states.index(next_state_name)
+                    queue.append((next_idx, distance + 1))
+
+        return conflict_guards, conflict_invs
+
+    def __fill_setup_invariants_func(self) -> list[str]:
+        buff = []
+        if not self.invariants:
+            return []
+
+        buff.append(
+"""static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
+\t\t\t\t       enum %s curr_state, enum %s event,
+\t\t\t\t       enum %s next_state, u64 time_ns)
+{""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+
+        conditions = ["next_state == curr_state"]
+        conditions += ["event != %s%s" % (e, self.enum_suffix)
+                       for e in self.self_loop_reset_events]
+        condition_str = " && ".join(conditions)
+        buff.append(f"\tif ({condition_str})\n\t\treturn;")
+
+        _else = ""
+        for state, constr in self.invariants.items():
+            buff.append("\t%sif (next_state == %s%s)" %
+                        (_else, self.states[state], self.enum_suffix))
+            buff.append("\t\t%s;" % constr)
+            _else = "else "
+
+        for state in self.invariants:
+            buff.append("\telse if (curr_state == %s%s)" %
+                        (self.states[state], self.enum_suffix))
+            buff.append("\t\tha_cancel_timer(ha_mon);")
+
+        buff.append("}\n")
+        return buff
+
+    def __fill_constr_func(self) -> list[str]:
+        buff = []
+        if not self.constraints:
+            return []
+
+        buff.append(
+"""/*
+ * These functions are used to validate state transitions.
+ *
+ * They are generated by parsing the model, there is usually no need to change them.
+ * If the monitor requires a timer, there are functions responsible to arm it when
+ * the next state has a constraint, cancel it in any other case and to check
+ * that it didn't expire before the callback run. Transitions to the same state
+ * without a reset never affect timers.
+ * Due to the different representations between invariants and guards, there is
+ * a function to convert it in case invariants or guards are reachable from
+ * another invariant without reset. Those are not present if not required in
+ * the model. This is all automatic but is worth checking because it may show
+ * errors in the model (e.g. missing resets).
+ */""")
+
+        buff += self.__fill_verify_invariants_func()
+        inv_conflicts = self.__fill_convert_inv_guard_func()
+        buff += inv_conflicts
+        buff += self.__fill_verify_guards_func()
+        buff += self.__fill_setup_invariants_func()
+
+        buff.append(
+"""static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+\t\t\t\t enum %s curr_state, enum %s event,
+\t\t\t\t enum %s next_state, u64 time_ns)
+{""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+
+        if self.invariants:
+            buff.append("\tif (!ha_verify_invariants(ha_mon, curr_state, event, next_state, time_ns))\n\t\treturn false;\n")
+        if inv_conflicts:
+            buff.append("\tha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);\n")
+
+        if self.guards:
+            buff.append("\tif (!ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns))\n\t\treturn false;\n")
+
+        if self.invariants:
+            buff.append("\tha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);\n")
+
+        buff.append("\treturn true;\n}\n")
+        return buff
+
+    def __fill_env_getter(self, env: str) -> str:
+        if env in self.env_types:
+            match self.env_types[env]:
+                case "ns" | "us" | "ms" | "s":
+                    return "ha_get_clk_ns(ha_mon, env, time_ns);"
+                case "j":
+                    return "ha_get_clk_jiffy(ha_mon, env);"
+        return "/* XXX: how do I read %s? */" % env
+
+    def __fill_env_resetter(self, env: str) -> str:
+        if env in self.env_types:
+            match self.env_types[env]:
+                case "ns" | "us" | "ms" | "s":
+                    return "ha_reset_clk_ns(ha_mon, env, time_ns);"
+                case "j":
+                    return "ha_reset_clk_jiffy(ha_mon, env);"
+        return "/* XXX: how do I reset %s? */" % env
+
+    def __fill_hybrid_get_reset_functions(self) -> list[str]:
+        buff = []
+        if self.is_hybrid_automata():
+            for var in self.constraint_vars:
+                if var.endswith("()"):
+                    func_name = var.replace("()", "")
+                    if func_name.isupper():
+                        buff.append("#define %s(ha_mon) /* XXX: what is %s(ha_mon)? */\n" % (func_name, func_name))
+                    else:
+                        buff.append("static inline u64 %s(struct ha_monitor *ha_mon)\n{" % func_name)
+                        buff.append("\treturn /* XXX: what is %s(ha_mon)? */;" % func_name)
+                        buff.append("}\n")
+                elif var.isupper():
+                    buff.append("#define %s /* XXX: what is %s? */\n" % (var, var))
+                else:
+                    buff.append("static u64 %s = /* XXX: default value */;" % var)
+                    buff.append("module_param(%s, ullong, 0644);\n" % var)
+            buff.append("""/*
+ * These functions define how to read and reset the environment variable.
+ *
+ * Common environment variables like ns-based and jiffy-based clocks have
+ * pre-define getters and resetters you can use. The parser can infer the type
+ * of the environment variable if you supply a measure unit in the constraint.
+ * If you define your own functions, make sure to add appropriate memory
+ * barriers if required.
+ * Some environment variables don't require a storage as they read a system
+ * state (e.g. preemption count). Those variables are never reset, so we don't
+ * define a reset function on monitors only relying on this type of variables.
+ */""")
+            buff.append("static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs%s env, u64 time_ns)\n{" % self.enum_suffix)
+            _else = ""
+            for env in self.envs:
+                buff.append("\t%sif (env == %s%s)\n\t\treturn %s" %
+                            (_else, env, self.enum_suffix, self.__fill_env_getter(env)))
+                _else = "else "
+            buff.append("\treturn ENV_INVALID_VALUE;\n}\n")
+            if len(self.env_stored):
+                buff.append("static void ha_reset_env(struct ha_monitor *ha_mon, enum envs%s env, u64 time_ns)\n{" % self.enum_suffix)
+                _else = ""
+                for env in self.env_stored:
+                    buff.append("\t%sif (env == %s%s)\n\t\t%s" %
+                                (_else, env, self.enum_suffix, self.__fill_env_resetter(env)))
+                    _else = "else "
+                buff.append("}\n")
+        return buff
+
+    def _fill_hybrid_definitions(self) -> list[str]:
+        return self.__fill_hybrid_get_reset_functions() + self.__fill_constr_func()
+
+    def _fill_timer_type(self) -> list:
+        if self.invariants:
+            return [
+                    "/* XXX: If the monitor has several instances, consider HA_TIMER_WHEEL */",
+                    "#define HA_TIMER_TYPE HA_TIMER_HRTIMER"
+                    ]
+        return []
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 3441385c1177..b80af3fd6701 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -255,12 +255,14 @@ class Monitor(RVGenerator):
         monitor_class_type = self.fill_monitor_class_type()
         tracepoint_args_skel_event = self.fill_tracepoint_args_skel("event")
         tracepoint_args_skel_error = self.fill_tracepoint_args_skel("error")
+        tracepoint_args_skel_error_env = self.fill_tracepoint_args_skel("error_env")
         trace_h = trace_h.replace("%%MODEL_NAME%%", self.name)
         trace_h = trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
         trace_h = trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
         trace_h = trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
         trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", tracepoint_args_skel_event)
         trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", tracepoint_args_skel_error)
+        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR_ENV%%", tracepoint_args_skel_error_env)
         return trace_h
 
     def print_files(self):
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index a14e4f0883db..bf0999f6657a 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -21,7 +21,7 @@
  */
 #define RV_MON_TYPE RV_MON_%%MONITOR_TYPE%%
 #include "%%MODEL_NAME%%.h"
-#include <rv/da_monitor.h>
+#include <rv/%%MONITOR_CLASS%%_monitor.h>
 
 /*
  * This is the instrumentation part of the monitor.
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h b/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h
new file mode 100644
index 000000000000..c8290e9ba2f4
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
+DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
+%%TRACEPOINT_ARGS_SKEL_EVENT%%);
+
+DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
+%%TRACEPOINT_ARGS_SKEL_ERROR%%);
+
+DEFINE_EVENT(error_env_%%MONITOR_CLASS%%, error_env_%%MODEL_NAME%%,
+%%TRACEPOINT_ARGS_SKEL_ERROR_ENV%%);
+#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
-- 
2.52.0

