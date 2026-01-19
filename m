Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728352D780A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856714; cv=none; b=p44NNBNKgsuw9qO2zpqyBIGOhj9DXdseV1HYVugdMfHGKdqQYDB2oidjiVAdUIo5vAbvFCMzy7wbbcejjiLMH7NpjhTXkBmqgwWMO25XBhQmKn062v9NEuJUN128fAOLJhhPAB4Hp7egCHP1QtdhHceyTh/62+xMHku0Vj50W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856714; c=relaxed/simple;
	bh=7DWaHBE+lufCXb7yGKuzsGpYm3Wlz4UGX3PpOWZN0lU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfTYphNoRtZi4j+CeM/xlFJ3IP3ykRN02eYhScmWvvGjNidmegLvq1zfwOceVboiPG136AHOvkLOHdIGq+GCmMHsZ6opF95qH/gedWf0DtvG6ghP+F0GfBjqyEcmByFvcr6D8QuqoxuXZ2s+aW3fT8dEJ1+xADem8xzfW+hKYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJM7/Vh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJM7/Vh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QayC2GyLW5anF6TqNfIzkKHxLfX0wSgqTgbD9DCUsY=;
	b=MJM7/Vh04svz4NMXEZF5uNtiBXKAglF/nUVPIj7rBayFEf97VYpAAkyUPG+39GWlGOHoT7
	ixfqd+8HJ9kxyIcK88ljsrWV7DMttaI/Iz1vH87+FBPXiyH47J7Osur51CY2weqvo7r8TC
	UdAMzVJNIwOTbYqfncJO9cPmfEQyScU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-WD23MUZSNP-0xeaoBzVnEQ-1; Mon,
 19 Jan 2026 16:05:09 -0500
X-MC-Unique: WD23MUZSNP-0xeaoBzVnEQ-1
X-Mimecast-MFC-AGG-ID: WD23MUZSNP-0xeaoBzVnEQ_1768856708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5287F1800350;
	Mon, 19 Jan 2026 21:05:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA5A71955F43;
	Mon, 19 Jan 2026 21:05:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 16/26] rv/rvgen: fix unbound initial_state variable
Date: Mon, 19 Jan 2026 17:45:52 -0300
Message-ID: <20260119205601.105821-17-wander@redhat.com>
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

Initialize initial_state to None and validate its assignment after
parsing DOT file state nodes. The previous implementation left
initial_state uninitialized if the DOT file contained no state with
the init_marker prefix, which would cause an UnboundLocalError when
the code attempted to use the variable at the end of the function.

This bug was identified by pyright static type checker, which correctly
flagged that initial_state could be referenced before assignment. The
fix adds proper initialization and validation, raising a AutomataError if
no initial state marker is found in the automaton definition. This
ensures that malformed DOT files missing an initial state are caught
early with a clear error message rather than causing cryptic runtime
exceptions.

The change also includes minor code formatting improvements to comply
with PEP 8 style guidelines, including consistent use of double quotes
for string literals and proper line length formatting for improved
readability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 26 +++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 8548265955570..083d0f5cfb773 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -10,6 +10,7 @@
 
 import ntpath
 
+
 class AutomataError(OSError):
     """Exception raised for errors in automata parsing and validation.
 
@@ -17,6 +18,7 @@ class AutomataError(OSError):
     or malformed automaton definitions.
     """
 
+
 class Automata:
     """Automata class: Reads a dot file and parses it as an automata.
 
@@ -31,7 +33,9 @@ class Automata:
         self.__dot_path = file_path
         self.name = model_name or self.__get_model_name()
         self.__dot_lines = self.__open_dot()
-        self.states, self.initial_state, self.final_states = self.__get_state_variables()
+        self.states, self.initial_state, self.final_states = (
+            self.__get_state_variables()
+        )
         self.events = self.__get_event_variables()
         self.function = self.__create_matrix()
         self.events_start, self.events_start_run = self.__store_init_events()
@@ -86,6 +90,7 @@ class Automata:
         # wait for node declaration
         states = []
         final_states = []
+        initial_state = None
 
         has_final_states = False
         cursor = self.__get_cursor_begin_states()
@@ -96,9 +101,9 @@ class Automata:
             raw_state = line[-1]
 
             #  "enabled_fired"}; -> enabled_fired
-            state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
+            state = raw_state.replace('"', "").replace("};", "").replace(",", "_")
             if state.startswith(self.init_marker):
-                initial_state = state[len(self.init_marker):]
+                initial_state = state[len(self.init_marker) :]
             else:
                 states.append(state)
                 if "doublecircle" in self.__dot_lines[cursor]:
@@ -111,6 +116,9 @@ class Automata:
 
             cursor += 1
 
+        if initial_state is None:
+            raise AutomataError("The automaton doesn't have a initial state")
+
         states = sorted(set(states))
 
         # Insert the initial state at the beginning of the states
@@ -132,7 +140,7 @@ class Automata:
             #  ------------ event is here ------------^^^^^
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                event = line[-2].replace('"', '')
+                event = line[-2].replace('"', "")
 
                 # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
@@ -162,7 +170,9 @@ class Automata:
             nr_state += 1
 
         # declare the matrix....
-        matrix = [[self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        matrix = [
+            [self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)
+        ]
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
@@ -170,9 +180,9 @@ class Automata:
         while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                origin_state = line[0].replace('"', '').replace(',', '_')
-                dest_state = line[2].replace('"', '').replace(',', '_')
-                possible_events = line[-2].replace('"', '').replace("\\n", " ")
+                origin_state = line[0].replace('"', "").replace(",", "_")
+                dest_state = line[2].replace('"', "").replace(",", "_")
+                possible_events = line[-2].replace('"', "").replace("\\n", " ")
                 for event in possible_events.split():
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             cursor += 1
-- 
2.52.0

