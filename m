Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEB30F92D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864139; cv=none; b=R/8skuxbTTTFTFlPXjZKTUB/5hiGegxrrUpdrVwpU49PuAL2IXgc2nE//8KP7UgIXFRe4xDsYRQc8srEVJOSqK5dk9kBMXebnQdgHPxexWBcyDvnrjo/gabtcrPC9SioalyDox7j8WJLAe6IuBo7em4RkXBvtdzE96jdizEU4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864139; c=relaxed/simple;
	bh=vEkF9WavzD5KqlmPKhm2df4adhITkvjyI+DumhCrwss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=krsCDuLaykGm8bnpb0bZHIIEho9eCWAJAzMAWB62EbNB7H6tS+uj4U4YNARcDgDn2KbUVguiGikCuIozBCzyl97acNNU3cvX/kfqsy/RfpN/BaVagRiDeUS64Qoae4lWgRhPoYdke3RCB/gVRssAqMWe5vkhxbb13qWpp6m7mPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEIO2pya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEIO2pya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+pkJNQaowjoHPGEYfVu6sri2iWmaCVQLnXkzvb9518=;
	b=XEIO2pyaGnoZMNc8V6hB35tQYVqU4zbw5LPVzPyYgnK5Jl950HpD9A5boXCzBzA1D32RN4
	r88Q+48ePYcvKZ7axOHYWueJJx/H4+ysOAobG/LhiA8d3StyjFSpLt9SWH559FnM17fbsu
	CY5Y3EPNFHSEZN2kwtYVA0yj5oDb6bc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-0uvrOOW0OEyzp89ypLiAlg-1; Mon,
 23 Feb 2026 11:28:51 -0500
X-MC-Unique: 0uvrOOW0OEyzp89ypLiAlg-1
X-Mimecast-MFC-AGG-ID: 0uvrOOW0OEyzp89ypLiAlg_1771864130
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31A221956067;
	Mon, 23 Feb 2026 16:28:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 062CE1800674;
	Mon, 23 Feb 2026 16:28:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 11/19] rv/rvgen: refactor automata.py to use iterator-based parsing
Date: Mon, 23 Feb 2026 13:17:54 -0300
Message-ID: <20260223162407.147003-12-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wZkv17q1Obn0kB5OYvbzr4kqJjv1IuN-ES11MvXH3mw_1771864130
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Refactor the DOT file parsing logic in automata.py to use Python's
iterator-based patterns instead of manual cursor indexing. The previous
implementation relied on while loops with explicit cursor management,
which made the code prone to off-by-one errors and would crash on
malformed input files containing empty lines.

The new implementation uses enumerate and itertools.islice to iterate
over lines, eliminating manual cursor tracking. Functions that search
for specific markers now use for loops with early returns and explicit
AutomataError exceptions for missing markers, rather than assuming the
markers exist. Additional bounds checking ensures that split line
arrays have sufficient elements before accessing specific indices,
preventing IndexError exceptions on malformed DOT files.

The matrix creation and event variable extraction methods now use
functional patterns with map combined with itertools.islice,
making the intent clearer while maintaining the same behavior. Minor
improvements include using extend instead of append in a loop, adding
empty file validation, and replacing enumerate with range where the
enumerated value was unused.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 116 +++++++++++++--------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index cdec78a4bbbae..6613a9d6159a9 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -11,6 +11,7 @@
 import ntpath
 import re
 from typing import Iterator
+from itertools import islice
 
 class _ConstraintKey:
     """Base class for constraint keys."""
@@ -89,37 +90,54 @@ class Automata:
         return model_name
 
     def __open_dot(self) -> list[str]:
-        cursor = 0
         dot_lines = []
         try:
             with open(self.__dot_path) as dot_file:
-                dot_lines = dot_file.read().splitlines()
+                dot_lines = dot_file.readlines()
         except OSError as exc:
             raise AutomataError(exc.strerror) from exc
 
+        if not dot_lines:
+            raise AutomataError(f"{self.__dot_path} is empty")
+
         # checking the first line:
-        line = dot_lines[cursor].split()
+        line = dot_lines[0].split()
 
-        if (line[0] != "digraph") or (line[1] != "state_automaton"):
+        if len(line) < 2 or line[0] != "digraph" or line[1] != "state_automaton":
             raise AutomataError(f"Not a valid .dot format: {self.__dot_path}")
-        else:
-            cursor += 1
+
         return dot_lines
 
     def __get_cursor_begin_states(self) -> int:
-        cursor = 0
-        while self.__dot_lines[cursor].split()[0] != "{node":
-            cursor += 1
-        return cursor
+        for cursor, line in enumerate(self.__dot_lines):
+            split_line = line.split()
+
+            if len(split_line) and split_line[0] == "{node":
+                return cursor
+
+        raise AutomataError("Could not find a beginning state")
 
     def __get_cursor_begin_events(self) -> int:
-        cursor = 0
-        while self.__dot_lines[cursor].split()[0] != "{node":
-            cursor += 1
-        while self.__dot_lines[cursor].split()[0] == "{node":
-            cursor += 1
-        # skip initial state transition
-        cursor += 1
+        state = 0
+        cursor = 0 # make pyright happy
+
+        for cursor, line in enumerate(self.__dot_lines):
+            line = line.split()
+            if not line:
+                continue
+
+            if state == 0:
+                if line[0] == "{node":
+                    state = 1
+            elif line[0] != "{node":
+                break
+        else:
+            raise AutomataError("Could not find beginning event")
+
+        cursor += 1 # skip initial state transition
+        if cursor == len(self.__dot_lines):
+            raise AutomataError("Dot file ended after event beginning")
+
         return cursor
 
     def __get_state_variables(self) -> tuple[list[str], str, list[str]]:
@@ -131,9 +149,12 @@ class Automata:
         cursor = self.__get_cursor_begin_states()
 
         # process nodes
-        while self.__dot_lines[cursor].split()[0] == "{node":
-            line = self.__dot_lines[cursor].split()
-            raw_state = line[-1]
+        for line in islice(self.__dot_lines, cursor, None):
+            split_line = line.split()
+            if not split_line or split_line[0] != "{node":
+                break
+
+            raw_state = split_line[-1]
 
             #  "enabled_fired"}; -> enabled_fired
             state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
@@ -141,16 +162,14 @@ class Automata:
                 initial_state = state[len(self.init_marker):]
             else:
                 states.append(state)
-                if "doublecircle" in self.__dot_lines[cursor]:
+                if "doublecircle" in line:
                     final_states.append(state)
                     has_final_states = True
 
-                if "ellipse" in self.__dot_lines[cursor]:
+                if "ellipse" in line:
                     final_states.append(state)
                     has_final_states = True
 
-            cursor += 1
-
         states = sorted(set(states))
         states.remove(initial_state)
 
@@ -163,18 +182,21 @@ class Automata:
         return states, initial_state, final_states
 
     def __get_event_variables(self) -> tuple[list[str], list[str]]:
+        events: list[str] = []
+        envs: list[str] = []
         # here we are at the begin of transitions, take a note, we will return later.
         cursor = self.__get_cursor_begin_events()
 
-        events = []
-        envs = []
-        while self.__dot_lines[cursor].lstrip()[0] == '"':
+        for line in map(str.lstrip, islice(self.__dot_lines, cursor, None)):
+            if not line.startswith('"'):
+                break
+
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
             #  ------------ event is here ------------^^^^^
-            if self.__dot_lines[cursor].split()[1] == "->":
-                line = self.__dot_lines[cursor].split()
-                event = "".join(line[line.index("label") + 2:-1]).replace('"', '')
+            split_line = line.split()
+            if len(split_line) > 1 and split_line[1] == "->":
+                event = "".join(split_line[split_line.index("label") + 2:-1]).replace('"', '')
 
                 # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
@@ -187,7 +209,7 @@ class Automata:
                     ev, *constr = i.split(";")
                     if constr:
                         if len(constr) > 2:
-                            raise ValueError("Only 1 constraint and 1 reset are supported")
+                            raise AutomataError("Only 1 constraint and 1 reset are supported")
                         envs += self.__extract_env_var(constr)
                     events.append(ev)
             else:
@@ -195,13 +217,12 @@ class Automata:
                 # "enable_fired" [label = "enable_fired\ncondition"];
                 #  ----- label is here -----^^^^^
                 # label and node name must be the same, condition is optional
-                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                state = line.split("label")[1].split('"')[1]
                 _, *constr = state.split("\\n")
                 if constr:
                     if len(constr) > 1:
-                        raise ValueError("Only 1 constraint is supported in the state")
+                        raise AutomataError("Only 1 constraint is supported in the state")
                     envs += self.__extract_env_var([constr[0].replace(" ", "")])
-            cursor += 1
 
         return sorted(set(events)), sorted(set(envs))
 
@@ -265,18 +286,24 @@ class Automata:
             nr_state += 1
 
         # declare the matrix....
-        matrix = [[self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        matrix = [[self.invalid_state_str for _ in range(nr_event)] for _ in range(nr_state)]
         constraints: dict[_ConstraintKey, list[str]] = {}
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
 
-        while self.__dot_lines[cursor].lstrip()[0] == '"':
-            if self.__dot_lines[cursor].split()[1] == "->":
-                line = self.__dot_lines[cursor].split()
-                origin_state = line[0].replace('"', '').replace(',', '_')
-                dest_state = line[2].replace('"', '').replace(',', '_')
-                possible_events = "".join(line[line.index("label") + 2:-1]).replace('"', '')
+        for line in map(str.lstrip,
+                        islice(self.__dot_lines, cursor, None)):
+
+            if not line or line[0] != '"':
+                break
+
+            split_line = line.split()
+
+            if len(split_line) > 2 and split_line[1] == "->":
+                origin_state = split_line[0].replace('"', '').replace(',', '_')
+                dest_state = split_line[2].replace('"', '').replace(',', '_')
+                possible_events = "".join(split_line[split_line.index("label") + 2:-1]).replace('"', '')
                 for event in possible_events.split("\\n"):
                     event, *constr = event.split(";")
                     if constr:
@@ -287,22 +314,21 @@ class Automata:
                             self.self_loop_reset_events.add(event)
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             else:
-                state = self.__dot_lines[cursor].split("label")[1].split('"')[1]
+                state = line.split("label")[1].split('"')[1]
                 state, *constr = state.replace(" ", "").split("\\n")
                 if constr:
                     constraints[_StateConstraintKey(states_dict[state])] = constr
-            cursor += 1
 
         return matrix, constraints
 
     def __store_init_events(self) -> tuple[list[bool], list[bool]]:
         events_start = [False] * len(self.events)
         events_start_run = [False] * len(self.events)
-        for i, _ in enumerate(self.events):
+        for i in range(len(self.events)):
             curr_event_will_init = 0
             curr_event_from_init = False
             curr_event_used = 0
-            for j, _ in enumerate(self.states):
+            for j in range(len(self.states)):
                 if self.function[j][i] != self.invalid_state_str:
                     curr_event_used += 1
                 if self.function[j][i] == self.initial_state:
-- 
2.53.0

