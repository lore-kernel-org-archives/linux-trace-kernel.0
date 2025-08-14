Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5F21FF2A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184171; cv=none; b=taNaHK1NJFC8RBmxJzB0H7yY9YCUg1kcMUJ2OObhxWZDbgKCGcyd0S+3nQWxNmtonpbfQUQrUl+MLqic2mFzhQ53l8A3vAenmFbs/k1UKoV+Kbk+G9863NqjO3VUoQx7dIZCu//Zf10MjE8dHGNclhGVP9tIlJ991Zfb6vaXDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184171; c=relaxed/simple;
	bh=AHaM+GbN7jA5MWydmwupUPhF964tCV/5zk0w+7BP88M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGOTviP2vlTUTnqpHwybD3LnskL5JcwucXGbtSaahTyfXY2gWanu7M3iAMCBjlD5Ft4yz5u54fkydoFsRWNry/ENhLdyUf2T4gemmKONs5BoRp+Ou7hcdde84BBDvkbzitjieVz8abrYsfU7RdCh0dh+Ek8B4Ba2tkVJprr1HG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kpr+MQEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kpr+MQEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvhs9L7pNYJYNGo454j7xHaZFOABn9WAkijZAU9p8cc=;
	b=Kpr+MQEWIR9vEBj/ogBFInq7K1rV9hE8KHGq0LBGRX6edqTUr7m6J6VTtwX/PO9Tx8sMII
	f7wBTIgLSgcxUuRomd1RgtJE52KTdACezDTX1FyxMLAPTkbcV9K+Z39egqrrEYTIj/27ZP
	VYtsIW/kZFGG5WUxwbVyPbLJ01eNwKA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-W_WtjSZbO3SKAOmZJhxDCQ-1; Thu,
 14 Aug 2025 11:09:24 -0400
X-MC-Unique: W_WtjSZbO3SKAOmZJhxDCQ-1
X-Mimecast-MFC-AGG-ID: W_WtjSZbO3SKAOmZJhxDCQ_1755184163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3B219775E2;
	Thu, 14 Aug 2025 15:09:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B935D1800280;
	Thu, 14 Aug 2025 15:09:18 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid Automata
Date: Thu, 14 Aug 2025 17:08:02 +0200
Message-ID: <20250814150809.140739-11-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
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
 tools/verification/rvgen/rvgen/automata.py    | 128 +++++++-
 tools/verification/rvgen/rvgen/dot2c.py       |  64 +++-
 tools/verification/rvgen/rvgen/dot2k.py       | 273 +++++++++++++++++-
 tools/verification/rvgen/rvgen/generator.py   |   2 +
 .../rvgen/rvgen/templates/dot2k/main.c        |   2 +-
 .../rvgen/templates/dot2k/trace_hybrid.h      |  16 +
 7 files changed, 475 insertions(+), 18 deletions(-)
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
index c637cf4ee749..c6525b95b15c 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -9,24 +9,50 @@
 #   Documentation/trace/rv/deterministic_automata.rst
 
 import ntpath
+import re
+from typing import Iterator
 
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
@@ -121,6 +147,7 @@ class Automata:
         cursor = self.__get_cursor_begin_events()
 
         events = []
+        envs = []
         while self.__dot_lines[cursor].lstrip()[0] == '"':
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
@@ -134,12 +161,77 @@ class Automata:
                 # so split them.
 
                 for i in event.split("\\n"):
+                    if ";" in i:
+                        # if the event contains a constraint (hybrid automata),
+                        # it will be separated by a ";":
+                        # "sched_switch;x<1000;reset(x)"
+                        line = i.split(";")
+                        i = line.pop(0)
+                        if len(line) > 2:
+                            raise ValueError("Only 1 constraint and 1 reset are supported")
+                        envs += self.__extract_env_var(line)
                     events.append(i)
+            else:
+                # state labels have the format:
+                # "enable_fired" [label = "enable_fired\ncondition"];
+                #  ----- label is here -----^^^^^
+                # label and node name must be the same, condition is optional
+                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                if "\\n" in state:
+                    line = state.split("\\n")
+                    line.pop(0)
+                    if len(line) > 1:
+                        raise ValueError("Only 1 constraint is supported in the state")
+                    envs += self.__extract_env_var([line[0].replace(" ", "")])
             cursor += 1
 
-        return sorted(set(events))
-
-    def __create_matrix(self):
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
+    def __create_matrix(self) -> tuple[list[list[str]], dict[tuple[int, int] |
+                                                             int, list[str]]]:
         # transform the array into a dictionary
         events = self.events
         states = self.states
@@ -157,6 +249,7 @@ class Automata:
 
         # declare the matrix....
         matrix = [[ self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        constraints = {}
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
@@ -168,10 +261,23 @@ class Automata:
                 dest_state = line[2].replace('"','').replace(',','_')
                 possible_events = "".join(line[line.index("label")+2:-1]).replace('"','')
                 for event in possible_events.split("\\n"):
+                    if ";" in event:
+                        line = event.split(";")
+                        event = line.pop(0)
+                        constraints[states_dict[origin_state],events_dict[event]] = line
+                        # those events reset also on self loops
+                        if origin_state == dest_state and "reset" in "".join(line):
+                            self.self_loop_reset_events.add(event)
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
+            else:
+                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                if "\\n" in state:
+                    line = state.replace(" ", "").split("\\n")
+                    state = line.pop(0)
+                    constraints[states_dict[state]] = line
             cursor += 1
 
-        return matrix
+        return matrix, constraints
 
     def __store_init_events(self) -> tuple[list[bool], list[bool]]:
         events_start = [False] * len(self.events)
@@ -203,3 +309,13 @@ class Automata:
         if any(self.events_start):
             return False
         return self.events_start_run[self.events.index(event)]
+
+    def is_hybrid_automata(self) -> bool:
+        return bool(self.envs)
+
+    def is_event_constraint(self, key: tuple[int, int] | int) -> bool:
+        """
+        Given the key in self.constraints return true if it is an event
+        constraint, false if it is a state constraint
+        """
+        return isinstance(key, tuple)
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 1771a2c9f6b9..58b3ee70033a 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -19,6 +19,7 @@ class Dot2c(Automata):
     enum_suffix = ""
     enum_states_def = "states"
     enum_events_def = "events"
+    enum_envs_def = "envs"
     struct_automaton_def = "automaton"
     var_automaton_def = "aut"
 
@@ -26,7 +27,7 @@ class Dot2c(Automata):
         super().__init__(file_path, model_name)
         self.line_length = 100
 
-    def __get_enum_states_content(self):
+    def __get_enum_states_content(self) -> list[str]:
         buff = []
         buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
         for state in self.states:
@@ -36,7 +37,7 @@ class Dot2c(Automata):
 
         return buff
 
-    def format_states_enum(self):
+    def format_states_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_states_def)
         buff += self.__get_enum_states_content()
@@ -58,7 +59,7 @@ class Dot2c(Automata):
 
         return buff
 
-    def format_events_enum(self):
+    def format_events_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_events_def)
         buff += self.__get_enum_events_content()
@@ -66,7 +67,43 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_minimun_type(self):
+    def __get_non_stored_envs(self) -> list[str]:
+        return [ e for e in self.envs if e not in self.env_stored ]
+
+    def __get_enum_envs_content(self) -> list[str]:
+        buff = []
+        first = True
+        # We first place env variables that have a u64 storage.
+        # Those are limited by MAX_HA_ENV_LEN, other variables
+        # are read only and don't require a storage.
+        unstored = self.__get_non_stored_envs()
+        for env in list(self.env_stored) + unstored:
+            if first:
+                buff.append("\t%s%s = 0," % (env, self.enum_suffix))
+                first = False
+            else:
+                buff.append("\t%s%s," % (env, self.enum_suffix))
+
+        buff.append("\tenv_max%s," % self.enum_suffix)
+        buff.append("\tenv_max_stored%s = %s%s" %
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
+            buff.append('_Static_assert(env_max_stored%s <= MAX_HA_ENV_LEN, "Not enough slots");\n' %
+                        (self.enum_suffix))
+
+        return buff
+
+    def get_minimun_type(self) -> str:
         min_type = "unsigned char"
 
         if self.states.__len__() > 255:
@@ -86,6 +123,8 @@ class Dot2c(Automata):
         buff.append("struct %s {" % self.struct_automaton_def)
         buff.append("\tchar *state_names[state_max%s];" % (self.enum_suffix))
         buff.append("\tchar *event_names[event_max%s];" % (self.enum_suffix))
+        if self.is_hybrid_automata():
+            buff.append("\tchar *env_names[env_max%s];" % (self.enum_suffix))
         buff.append("\t%s function[state_max%s][event_max%s];" % (min_type, self.enum_suffix, self.enum_suffix))
         buff.append("\t%s initial_state;" % min_type)
         buff.append("\tbool final_states[state_max%s];" % (self.enum_suffix))
@@ -110,7 +149,7 @@ class Dot2c(Automata):
 
         return string
 
-    def format_aut_init_events_string(self):
+    def format_aut_init_events_string(self) -> list[str]:
         buff = []
         buff.append("\t.event_names = {")
         buff.append(self.__get_string_vector_per_line_content(self.events))
@@ -125,7 +164,18 @@ class Dot2c(Automata):
 
         return buff
 
-    def __get_max_strlen_of_states(self):
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
+    def __get_max_strlen_of_states(self) -> int:
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
 
@@ -217,10 +267,12 @@ class Dot2c(Automata):
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
index a48e32c4ca73..1f6ad11117ac 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -20,12 +20,14 @@ class dot2k(Monitor, Dot2c):
         Monitor.__init__(self, extra_params)
         Dot2c.__init__(self, file_path, extra_params.get("model_name"))
         self.enum_suffix = "_%s" % self.name
+        self.monitor_class = extra_params["monitor_class"]
 
     def fill_monitor_type(self) -> str:
         return self.monitor_type.upper()
 
     def fill_tracepoint_handlers_skel(self) -> str:
         buff = []
+        buff += self.fill_hybrid_definitions()
         for event in self.events:
             buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
             buff.append("{")
@@ -77,6 +79,7 @@ class dot2k(Monitor, Dot2c):
         #
         self.enum_states_def = "states_%s" % self.name
         self.enum_events_def = "events_%s" % self.name
+        self.enum_envs_def = "envs_%s" % self.name
         self.struct_automaton_def = "automaton_%s" % self.name
         self.var_automaton_def = "automaton_%s" % self.name
 
@@ -107,8 +110,14 @@ class dot2k(Monitor, Dot2c):
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
@@ -117,7 +126,11 @@ class dot2k(Monitor, Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return '\n'.join(buff)
 
-    def fill_main_c(self):
+    def fill_hybrid_definitions(self) -> list:
+        """Stub, not valid for deterministic automata"""
+        return []
+
+    def fill_main_c(self) -> str:
         main_c = super().fill_main_c()
 
         min_type = self.get_minimun_type()
@@ -127,5 +140,261 @@ class dot2k(Monitor, Dot2c):
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
+                value *= 1000
+            case "ms":
+                value *= 1000000
+            case "s":
+                value *= 1000000000
+        return str(value) + "ull"
+
+    def __parse_state_constraint(self, rule: dict, value: str) -> str:
+        # by default assume the timer has ns expiration
+        clock_type = "ns"
+        if self.env_types.get(rule["env"]) == "j":
+            clock_type = "jiffy"
+
+        return "ha_start_timer_%s(ha_mon, %s%s, %s)" % (clock_type, rule["env"],
+                                                        self.enum_suffix, value)
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
+                        c = "ha_get_env(ha_mon, %s%s) %s %s" % (
+                                rule["env"], self.enum_suffix, rule["op"], value)
+                    else:
+                        c = self.__parse_state_constraint(rule, value)
+                    if sep:
+                        c += f" {sep} "
+                    rules.append(c)
+                if reset:
+                    c = "ha_reset_env(ha_mon, %s%s)" % (reset["env"], self.enum_suffix)
+                    resets.append(c)
+            if self.is_event_constraint(key):
+                res = (["res = " + "".join(rules)] if rules else []) + resets
+                self.constraints[key] = ";".join(res)
+            else:
+                self.constraints[key] = rules[0]
+
+    def __get_constr_condition(self) -> list[str]:
+        buff = []
+        _else = ""
+        for edge, constr in self.constraints.items():
+            # skip state constraints
+            if not self.is_event_constraint(edge):
+                continue
+            buff.append("\t%sif (curr_state == %s%s && event == %s%s)" %
+                        (_else, self.states[edge[0]], self.enum_suffix,
+                         self.events[edge[1]], self.enum_suffix))
+            if constr.count(";") > 0:
+                buff[-1] += " {"
+            buff += [ "\t\t%s;" % c for c in constr.split(";") ]
+            if constr.count(";") > 0:
+                buff.append("\t}")
+            _else = "else "
+        return buff
+
+    def __get_state_constr_condition(self) -> list[str]:
+        buff = []
+        # do not even print this if no state constraint is present
+        if not [c for c in self.constraints.keys() if not self.is_event_constraint(c)]:
+            return buff
+
+        # normally leaving the state with a constraint doesn't touch the timer,
+        # but if that event does reset, we need to carry on with the checks
+        conditions = ["next_state == curr_state"]
+        conditions += ["event != %s%s" % (e, self.enum_suffix)
+                       for e in self.self_loop_reset_events]
+        condition_str = " && ".join(conditions)
+        if len(conditions) > 1:
+            condition_str = f"({condition_str})"
+        buff.append("\n\tif (%s || !res)\n\t\treturn res;" % condition_str)
+
+        _else = ""
+        constrained_states = set()
+        for state, constr in self.constraints.items():
+            # skip event constraints
+            if self.is_event_constraint(state):
+                continue
+            constrained_states.add(self.states[state])
+            buff.append("\t%sif (next_state == %s%s)" %
+                        (_else, self.states[state], self.enum_suffix))
+            buff.append("\t\t%s;" % constr)
+            _else = "else "
+        buff.append("\telse if (%s)\n\t\tres = !ha_cancel_timer(ha_mon);" %
+                    " ||".join(["curr_state == %s%s" % (s, self.enum_suffix)
+                                for s in constrained_states]))
+        return buff
+
+    def fill_constr_func(self) -> list[str]:
+        buff = []
+        if self.constraints:
+            buff.append(
+"""/*
+ * This function is used to validate state transitions.
+ *
+ * It is generated by parsing the model, there is usually no need to change it,
+ * unless conditions were incorrectly specified or too complex for the parser.
+ * If the monitor requires a timer, this function is responsible to arm it when
+ * the next state has a constraint and cancel it in any other case. Transitions
+ * to the same state never affect timers.
+ */
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+\t\t\t\t enum %s curr_state, enum %s event,
+\t\t\t\t enum %s next_state)
+{
+\tbool res = true;
+""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
+            buff += self.__get_constr_condition()
+            buff += self.__get_state_constr_condition()
+            buff.append("""\treturn res;
+}\n""")
+        return buff
+
+    def __fill_env_getter(self, env: str) -> str:
+        if env in self.env_types:
+            match self.env_types[env]:
+                case "ns" | "us" | "ms" | "s":
+                    return "ha_get_clk_ns(ha_mon, env);"
+                case "j":
+                    return "ha_get_clk_jiffy(ha_mon, env);"
+        return "/* XXX: how do I read %s? */" % env
+
+    def __fill_env_resetter(self, env: str) -> str:
+        if env in self.env_types:
+            match self.env_types[env]:
+                case "ns" | "us" | "ms" | "s":
+                    return "ha_reset_clk_ns(ha_mon, env);"
+                case "j":
+                    return "ha_reset_clk_jiffy(ha_mon, env);"
+        return "/* XXX: how do I reset %s? */" % env
+
+    def fill_hybrid_get_reset_functions(self) -> list[str]:
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
+            buff.append("static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs%s env)\n{" % self.enum_suffix)
+            _else = ""
+            for env in self.envs:
+                buff.append("\t%sif (env == %s%s)\n\t\treturn %s" %
+                            (_else, env, self.enum_suffix, self.__fill_env_getter(env)))
+                _else = "else "
+            buff.append("\treturn ENV_INVALID_VALUE;\n}\n")
+            if len(self.env_stored):
+                buff.append("static void ha_reset_env(struct ha_monitor *ha_mon, enum envs%s env)\n{" % self.enum_suffix)
+                _else = ""
+                for env in self.env_stored:
+                    buff.append("\t%sif (env == %s%s)\n\t\t%s" %
+                                (_else, env, self.enum_suffix, self.__fill_env_resetter(env)))
+                    _else = "else "
+                buff.append("}\n")
+        return buff
+
+    def fill_hybrid_definitions(self) -> list[str]:
+        return self.fill_hybrid_get_reset_functions() + self.fill_constr_func()
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
index f14a0e7ad56b..c9335cd32fc2 100644
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
2.50.1

