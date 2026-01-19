Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5B2D780A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856810; cv=none; b=AqbP26MmAA4AH/YqhQqQW8RWShePFmf5gxEWTy8WHZ7O8VZtvVtSjP4gFYSF02L+HyUa1aGVP3/9mj5cYFJDX4h3OsgP7Z0o+su+x7r9wC/ibTjNDpOcDf7a4s/IchOANawJdvsIZ7lDn2CRwdJzOyz4Y/rG0iGuj1X1sDEY3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856810; c=relaxed/simple;
	bh=Cv7xdVb8TPBh5SD/przOy40ZShHXp7REu15vrs83Fpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHBqADwEwDPntezRsRxGcY2kHzcmJq5lQNu2vsx6ZGVtv4lsJpvfTOQ0DLacXsx7p4JPKgZHzl7tMbh1TcOpGXXjvhfduGdKhZYx5jD2VHQksmZ6iPYLGCgSj2Yb4mDoO6xecvUWe2AAp4SQYHn5UnadUOVxiUfWv0xUP4hVGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izadLma7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izadLma7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAhJpBpuwY85AzW6pQHTpyADsq9b83OtuK/qOzl5+7M=;
	b=izadLma7pz6x0WiBOW17iQR9k6KQsKmDcKzNNK0Sz6Pqpzv3kzjrS2OphvSIKzGvcrrkey
	39jxH+kTbduY42oXgTRwsmjntUQJjt7j3z90T+h8KWxskEXGsjAIHOU/TubHEFVz20tgTr
	2lFRIr4QgIH7165e2n5hFEJYIEWSd8g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-BrduNxfKPBGLa-p8j_kXqA-1; Mon,
 19 Jan 2026 16:06:46 -0500
X-MC-Unique: BrduNxfKPBGLa-p8j_kXqA-1
X-Mimecast-MFC-AGG-ID: BrduNxfKPBGLa-p8j_kXqA_1768856805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8B01956048;
	Mon, 19 Jan 2026 21:06:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DC6319560AB;
	Mon, 19 Jan 2026 21:06:43 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 20/26] rv/rvgen: refactor automata.py to use iterator-based parsing
Date: Mon, 19 Jan 2026 17:45:56 -0300
Message-ID: <20260119205601.105821-21-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
---
 tools/verification/rvgen/rvgen/automata.py | 109 +++++++++++++--------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 083d0f5cfb773..a6889d0c26c3f 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -9,6 +9,7 @@
 #   Documentation/trace/rv/deterministic_automata.rst
 
 import ntpath
+from itertools import islice
 
 
 class AutomataError(OSError):
@@ -53,37 +54,54 @@ class Automata:
         return model_name
 
     def __open_dot(self):
-        cursor = 0
         dot_lines = []
         try:
             with open(self.__dot_path) as dot_file:
-                dot_lines = dot_file.read().splitlines()
+                dot_lines = dot_file.readlines()
         except OSError as exc:
             raise AutomataError(f"Cannot open the file: {self.__dot_path}") from exc
 
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
 
     def __get_cursor_begin_states(self):
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
 
     def __get_cursor_begin_events(self):
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
 
     def __get_state_variables(self):
@@ -96,9 +114,12 @@ class Automata:
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
             state = raw_state.replace('"', "").replace("};", "").replace(",", "_")
@@ -106,16 +127,14 @@ class Automata:
                 initial_state = state[len(self.init_marker) :]
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
         if initial_state is None:
             raise AutomataError("The automaton doesn't have a initial state")
 
@@ -130,26 +149,27 @@ class Automata:
         return states, initial_state, final_states
 
     def __get_event_variables(self):
+        events: list[str] = []
         # here we are at the begin of transitions, take a note, we will return later.
         cursor = self.__get_cursor_begin_events()
 
-        events = []
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
-                event = line[-2].replace('"', "")
+            split_line = line.split()
+            if len(split_line) > 1 and split_line[1] == "->":
+                event = split_line[-2].replace('"', "")
 
                 # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
                 event = event.replace("\\n", " ")
-                for i in event.split():
-                    events.append(i)
-            cursor += 1
+                events.extend(event.split())
 
         return sorted(set(events))
 
@@ -171,32 +191,37 @@ class Automata:
 
         # declare the matrix....
         matrix = [
-            [self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)
+            [self.invalid_state_str for _ in range(nr_event)] for _ in range(nr_state)
         ]
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
 
-        while self.__dot_lines[cursor].lstrip()[0] == '"':
-            if self.__dot_lines[cursor].split()[1] == "->":
-                line = self.__dot_lines[cursor].split()
-                origin_state = line[0].replace('"', "").replace(",", "_")
-                dest_state = line[2].replace('"', "").replace(",", "_")
-                possible_events = line[-2].replace('"', "").replace("\\n", " ")
+        for line in map(str.lstrip,
+                        islice(self.__dot_lines, cursor, None)):
+
+            if not line or line[0] != '"':
+                break
+
+            split_line = line.split()
+
+            if len(split_line) > 2 and split_line[1] == "->":
+                origin_state = split_line[0].replace('"', "").replace(",", "_")
+                dest_state = split_line[2].replace('"', "").replace(",", "_")
+                possible_events = split_line[-2].replace('"', "").replace("\\n", " ")
                 for event in possible_events.split():
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
-            cursor += 1
 
         return matrix
 
     def __store_init_events(self):
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
2.52.0

