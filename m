Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800C3B47F6;
	Mon,  8 Jun 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909052; cv=none; b=CrCRnpvd9kMtp7KdPzUavPzcDmFTyIhcdgVTMvBW+JUUcJGNsdqSHWJ8vGK3Rzx81GHbpo91IK1iz6iscEYzBAXqVmFLSwXZn3GgE32zjhZRaYDhlfmsvgM+9AiE8QJiiBvvDeUmV+ofRZM3WuqZTURWmHaSJUEDUgWbwNMoCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909052; c=relaxed/simple;
	bh=1MhA2aRP60183cN4HBLv3Aj1A/11LGKf9X/a96VYV4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNHxAtbRKOQv+iO+3APLXtwwvmln1aUa6x2uwIhZNFHVtkJPV6qKAQD/y49jrxCtcjDObxiqzHGvPRxrKhrhmRMGr4DuAfngD2qvzGbkCU7PaIen4ZhfZdqRB31cMrVeduulUiaDGq/26mqzb1w1QLaBiO6Npc29fGnW8UNhG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzD4VZQc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gx4eqVxO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzD4VZQc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gx4eqVxO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUxzZb6WjvKyMCBcd/paWjOXRIvgAJq42QDVRrYlzeg=;
	b=kzD4VZQcOBlBJ7g62SxQ+ahKX7evRR/2LlOExgR1c0tqe/HgToT/4F8j1BJw3AaJipdTLs
	UTzftXzgf2ig1XqVIVcPt+7OssMSU59mnyKkla+nZLpsoDHUUQdnqKy+jXvRSbvCSPLoce
	bqt4LbcxiQAz2yVTWPHxBnjMnMe1uquCbgFK48F2pqTmyjMTL7wSa/0NGlKZOq/INvsHLM
	hE9XETm/dyvTAmv5h/4swqPqaWgHVhjTWo+SjDKNuq1bLtJIKiEg5JGQbhpqRMh6bNKfZz
	sfqBFRw2T0egRNVfklDj6lgQb4An1YvY5BaOXFbSqu8W1bkM/0mXagYOTaVW/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUxzZb6WjvKyMCBcd/paWjOXRIvgAJq42QDVRrYlzeg=;
	b=Gx4eqVxOdO3WQCAf7EikqZb5+61eyNPquCZvQMOToOyDyNKY8KHEjJ6au753H2X6rOAOlH
	WKTH6Gl9m8dAa8Cw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 10/13] verification/rvgen: Switch __get_event_variables() to Lark
Date: Mon,  8 Jun 2026 10:57:06 +0200
Message-ID: <50df4dd278779328cf2aa283c8353bac2281a337.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch __get_event_variables() to use the parsed results from Lark, instead
of raw text processing.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 78 ++++++----------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index b86275e7bf28..2e26bb863245 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -591,45 +591,22 @@ class Automata:
     def __get_event_variables(self) -> tuple[list[str], list[str]]:
         events: list[str] =3D []
         envs: list[str] =3D []
-        # here we are at the begin of transitions, take a note, we will re=
turn later.
-        cursor =3D self.__get_cursor_begin_events()
=20
-        for line in map(str.lstrip, islice(self.__dot_lines, cursor, None)=
):
-            if not line.startswith('"'):
-                break
+        for transition in self.transitions:
+            events.append(transition.event)
=20
-            # transitions have the format:
-            # "all_fired" -> "both_fired" [ label =3D "disable_irq" ];
-            #  ------------ event is here ------------^^^^^
-            split_line =3D line.split()
-            if len(split_line) > 1 and split_line[1] =3D=3D "->":
-                event =3D "".join(split_line[split_line.index("label") + 2=
:-1]).replace('"', '')
-
-                # when a transition has more than one label, they are like=
 this
-                # "local_irq_enable\nhw_local_irq_enable_n"
-                # so split them.
-
-                for i in event.split("\\n"):
-                    # if the event contains a constraint (hybrid automata),
-                    # it will be separated by a ";":
-                    # "sched_switch;x<1000;reset(x)"
-                    ev, *constr =3D i.split(";")
-                    if constr:
-                        if len(constr) > 2:
-                            raise AutomataError("Only 1 constraint and 1 r=
eset are supported")
-                        envs +=3D self.__extract_env_var(constr)
-                    events.append(ev)
-            else:
-                # state labels have the format:
-                # "enable_fired" [label =3D "enable_fired\ncondition"];
-                #  ----- label is here -----^^^^^
-                # label and node name must be the same, condition is optio=
nal
-                state =3D line.split("label")[1].split('"')[1]
-                _, *constr =3D state.split("\\n")
-                if constr:
-                    if len(constr) > 1:
-                        raise AutomataError("Only 1 constraint is supporte=
d in the state")
-                    envs +=3D self.__extract_env_var([constr[0].replace(" =
", "")])
+            if transition.reset:
+                envs.append(transition.reset.env)
+                self.env_stored.add(transition.reset.env)
+            if transition.rule:
+                for c, _ in transition.rule.rules:
+                    envs.append(c.env)
+                    self.__extract_env_var(c)
+
+        for state in self._states:
+            if state.inv:
+                envs.append(state.inv.env)
+                self.__extract_env_var(state.inv)
=20
         return sorted(set(events)), sorted(set(envs))
=20
@@ -653,28 +630,11 @@ class Automata:
             seps.append(None)
         return zip(exprs, seps)
=20
-    def __extract_env_var(self, constraint: list[str]) -> list[str]:
-        env =3D []
-        for c, _ in self._split_constraint_expr(constraint):
-            rule =3D self.constraint_rule.search(c)
-            reset =3D self.constraint_reset.search(c)
-            if rule:
-                env.append(rule["env"])
-                if rule.groupdict().get("unit"):
-                    self.env_types[rule["env"]] =3D rule["unit"]
-                if rule["val"][0].isalpha():
-                    self.constraint_vars.add(rule["val"])
-                # try to infer unit from constants or parameters
-                val_for_unit =3D rule["val"].lower().replace("()", "")
-                if val_for_unit.endswith("_ns"):
-                    self.env_types[rule["env"]] =3D "ns"
-                if val_for_unit.endswith("_jiffies"):
-                    self.env_types[rule["env"]] =3D "j"
-            if reset:
-                env.append(reset["env"])
-                # environment variables that are reset need a storage
-                self.env_stored.add(reset["env"])
-        return env
+    def __extract_env_var(self, constraint: ConstraintCondition):
+        if constraint.unit:
+            self.env_types[constraint.env] =3D constraint.unit
+        if constraint.val[0].isalpha():
+            self.constraint_vars.add(constraint.val)
=20
     def __create_matrix(self) -> tuple[list[list[str]], dict[_ConstraintKe=
y, list[str]]]:
         # transform the array into a dictionary
--=20
2.47.3

