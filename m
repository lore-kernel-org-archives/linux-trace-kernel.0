Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD637B3F2;
	Thu, 28 May 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956899; cv=none; b=fq8rBVHJLzUHNGoPr4w9LmVqyJTlrvVU6uEjpm5qkPpr3rjSeidY3Yu8XTvIl6c3Y5FZoK12HplZUku3nsNC1tRdMM9lJSmMsZMGSnYxEIPZsdvBJ1UsmEphq1SHogQn2luKOvoXsG6SLwrxSBT2wZS4IuxaGP7Tv1MASNXHbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956899; c=relaxed/simple;
	bh=WD8UkgpIzxOhbmnHWTXpgWqmukU6mPLth2IbYdVWEFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naV6LYXrwwyjN6em5dYK2PWatPEnikbRVL9pQav9HmqlWJlxoaKdpbwXcoWidEB2OhOFDCrl+vSmGCCA9nc9uf1qynRnFGfjjQwtOgqGNNmY6HFZZ0PWFjFb5puYno8OkJbeTd/n777xDQctKR/nF/JJx90RVGKIXSpfx62/lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXmiqWDF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byudeXV5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXmiqWDF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byudeXV5"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eA33C1vCAngK2GdSJijc3hLWCxvkKQ+Ktjn/5o1BBa8=;
	b=jXmiqWDFAx5aXlo2CgMABkLd3k6vWGX8iINTzVSLkSHIqKu59odcrebt2VLns0ySu4sFSp
	jEuMSWkq451mYd5T8KEgiqF3+qeuMb4G/ntyor1l2p8CITTLUrNycVYgqDradi5a7nAYzm
	sufdnIgzGl68qM/fZhye8HOT+7jgP9x8TQoW4Q8Tp+6WgVUkYCzfTnREU3vfkC45woFFG9
	6dSbsrz5nbk6upesnKM9iJPcuMch+/K5axb2RfPMY0PibR5i8CKFBe2NpLTz0R3t/QIAmj
	0I89gJ6RZTg8hwqokf92kEGiBeHEDxd004E5Dy3+R6ChXuWDdMIRXTD936/4yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eA33C1vCAngK2GdSJijc3hLWCxvkKQ+Ktjn/5o1BBa8=;
	b=byudeXV5qmvVqp42mXYDu7EAm3mSzDp/wSWLr37UuMmM2D4IvW50LiUTwh0ADp5QkqjF3a
	GLmMT5OhgTqEbGCg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 12/13] verification/rvgen: Remove the old state variables
Date: Thu, 28 May 2026 10:28:00 +0200
Message-ID: <eaa27c3288ca40af5db9a100842a3c4478a74847.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The state variables (states, initial_state, final_states) only capture the
states' names and have less information than their Lark-based counterparts.

Switch to use the new state variables and delete these old ones.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py |  9 ++++-----
 tools/verification/rvgen/rvgen/dot2c.py    | 10 +++++-----
 tools/verification/rvgen/rvgen/dot2k.py    |  8 ++++----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index 4c302f5cba68..a3be327c2a73 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -411,8 +411,7 @@ class Automata:
         self.__dot_lines =3D self.__open_dot()
         self.__parse_tree =3D ParseTree(file_path)
         self.transitions =3D self.__parse_transitions()
-        self._states, self._initial_state, self._final_states =3D self.__p=
arse_states()
-        self.states, self.initial_state, self.final_states =3D self.__get_=
state_variables()
+        self.states, self.initial_state, self.final_states =3D self.__pars=
e_states()
         self.env_types =3D {}
         self.env_stored =3D set()
         self.constraint_vars =3D set()
@@ -603,7 +602,7 @@ class Automata:
                     envs.append(c.env)
                     self.__extract_env_var(c)
=20
-        for state in self._states:
+        for state in self.states:
             if state.inv:
                 envs.append(state.inv.env)
                 self.__extract_env_var(state.inv)
@@ -639,7 +638,7 @@ class Automata:
     def __create_matrix(self) -> list[list[str]]:
         # transform the array into a dictionary
         events =3D self.events
-        states =3D [s.name for s in self._states]
+        states =3D [s.name for s in self.states]
         events_dict =3D {}
         states_dict =3D {}
         nr_event =3D 0
@@ -675,7 +674,7 @@ class Automata:
             for j in range(len(self.states)):
                 if self.function[j][i] !=3D self.invalid_state_str:
                     curr_event_used +=3D 1
-                if self.function[j][i] =3D=3D self.initial_state:
+                if self.function[j][i] =3D=3D self.initial_state.name:
                     curr_event_will_init +=3D 1
             if self.function[0][i] !=3D self.invalid_state_str:
                 curr_event_from_init =3D True
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/r=
vgen/rvgen/dot2c.py
index fc85ba1f649e..22938ce1bf6c 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -29,10 +29,10 @@ class Dot2c(Automata):
=20
     def __get_enum_states_content(self) -> list[str]:
         buff =3D []
-        buff.append(f"\t{self.initial_state}{self.enum_suffix},")
+        buff.append(f"\t{self.initial_state.name}{self.enum_suffix},")
         for state in self.states:
             if state !=3D self.initial_state:
-                buff.append(f"\t{state}{self.enum_suffix},")
+                buff.append(f"\t{state.name}{self.enum_suffix},")
         buff.append(f"\tstate_max{self.enum_suffix},")
=20
         return buff
@@ -142,7 +142,7 @@ class Dot2c(Automata):
     def format_aut_init_states_string(self) -> list[str]:
         buff =3D []
         buff.append("\t.state_names =3D {")
-        buff.append(self.__get_string_vector_per_line_content(self.states))
+        buff.append(self.__get_string_vector_per_line_content([s.name for =
s in self.states]))
         buff.append("\t},")
=20
         return buff
@@ -159,7 +159,7 @@ class Dot2c(Automata):
         return buff
=20
     def __get_max_strlen_of_states(self) -> int:
-        max_state_name =3D len(max(self.states, key=3Dlen))
+        max_state_name =3D max((len(s.name) for s in self.states))
         return max(max_state_name, len(self.invalid_state_str))
=20
     def get_aut_init_function(self) -> str:
@@ -199,7 +199,7 @@ class Dot2c(Automata):
         return buff
=20
     def get_aut_init_initial_state(self) -> str:
-        return self.initial_state
+        return self.initial_state.name
=20
     def format_aut_init_initial_state(self) -> list[str]:
         buff =3D []
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 8fa7494846a3..49cb3e724a93 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -179,7 +179,7 @@ class ha2k(dot2k):
         self.trace_h =3D self._read_template_file("trace_hybrid.h")
         self.has_invariant =3D False
         self.has_guard =3D False
-        for state in self._states:
+        for state in self.states:
             if state.inv:
                 self.has_invariant =3D True
         for transition in self.transitions:
@@ -314,7 +314,7 @@ f"""static inline bool ha_verify_invariants(struct ha_m=
onitor *ha_mon,
 {{"""]
=20
         _else =3D ""
-        for state in self._states:
+        for state in self.states:
             if not state.inv:
                 continue
=20
@@ -382,7 +382,7 @@ f"""static inline void ha_setup_invariants(struct ha_mo=
nitor *ha_mon,
         buff.append(f"\tif ({condition_str})\n\t\treturn;")
=20
         _else =3D ""
-        for state in self._states:
+        for state in self.states:
             inv =3D state.inv
             if not inv:
                 continue
@@ -391,7 +391,7 @@ f"""static inline void ha_setup_invariants(struct ha_mo=
nitor *ha_mon,
             buff.append(f"\t\t{inv};")
             _else =3D "else "
=20
-        for state in self._states:
+        for state in self.states:
             inv =3D state.inv
             if not inv:
                 continue
--=20
2.47.3

