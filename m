Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41C3B4E84;
	Mon,  8 Jun 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909052; cv=none; b=X8QmX3vuYdpIG6F+0BD5c8MvRtMIHTVQTUwv0tcVlqVmc2WXW0MV+o5swIYRnGjWw+mRr7mQgrM0bcE0xwixUhAcfPOwRYnT44XG/amNWAWSXIgPf1CyL4jv8PxZF5W232J121dREA/wZ1nuo9nHSTiZlkyQ1jd5hExowHeLeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909052; c=relaxed/simple;
	bh=2WPjMY33orsToURjb7ZXHlVMYfa2lVeoNHh8wJLmook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD/nU/lNzDKdULOEIkwIxsddl7u7pnsADC4DqlA/k7pEWZQ5yyX7J9+mpkQf6dKnR8SlUXidlBq3EKCrAyOi9YcITGXJbTKPyr4AcW0EJgbNYUw+9LHaAfxVChchTl1/N6Bk/IeWWB2JnvKx8PIQJJgX/LvSmTfDJFMhPd0V/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ctis4pq1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLFPMF54; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ctis4pq1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLFPMF54"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv9On0UMEixskcuwDIk9hWUsnhiTMI2IAVc1WhiXmVY=;
	b=ctis4pq1bpb15NApuQ/+qCkOoG75DSBBc/96zlx17XtjvDMqgkFicx6iuSoauRNLfjvp7k
	gbZ883ePCbnDIzyxxDVB1Px0Q3ufEoyA/IoqMa7mS6W5E+QPIiHXOwm6xqZmuvFcOzZlfM
	p+5WWe6ziWTM1t6ySkuJvLoLqKq5ut+kMuNQ5cnybQbFnpcMSvpeAIrbTM1Sa9bfnU6NmW
	drCyJYfF482OA8gou02nO6MGgzMDXav4XrCfsnWglIwb3EWEDMRokViGI7xFAoSKHLTQc5
	OSMua71SjonaSjteTG4Sz4qBlzLnEcLvZ/W/CdTRXbk2YrQcREYjHk/Xi9e1YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv9On0UMEixskcuwDIk9hWUsnhiTMI2IAVc1WhiXmVY=;
	b=fLFPMF54oZH+A/0nh6+u1E3eQB4GVsAjCvekcY6LogFNMa826R85AEPyZRwe71BLTnk5b1
	hmLASAJ8Zh1uW5Aw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 11/13] verification/rvgen: Switch __create_matrix() to Lark
Date: Mon,  8 Jun 2026 10:57:07 +0200
Message-ID: <4e501de8e4e84a3de3370d82bf346f916aa97706.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch __create_matrix() to use the transitions parsed by Lark to avoid all
the raw text parsing.

Also stop parsing constraints in __create_matrix(), that is not used
anymore.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 47 ++++++----------------
 tools/verification/rvgen/rvgen/dot2k.py    |  2 +-
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index 2e26bb863245..4c302f5cba68 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -418,7 +418,7 @@ class Automata:
         self.constraint_vars =3D set()
         self.self_loop_reset_events =3D set()
         self.events, self.envs =3D self.__get_event_variables()
-        self.function, self.constraints =3D self.__create_matrix()
+        self.function =3D self.__create_matrix()
         self.events_start, self.events_start_run =3D self.__store_init_eve=
nts()
         self.env_stored =3D sorted(self.env_stored)
         self.constraint_vars =3D sorted(self.constraint_vars)
@@ -636,10 +636,10 @@ class Automata:
         if constraint.val[0].isalpha():
             self.constraint_vars.add(constraint.val)
=20
-    def __create_matrix(self) -> tuple[list[list[str]], dict[_ConstraintKe=
y, list[str]]]:
+    def __create_matrix(self) -> list[list[str]]:
         # transform the array into a dictionary
         events =3D self.events
-        states =3D self.states
+        states =3D [s.name for s in self._states]
         events_dict =3D {}
         states_dict =3D {}
         nr_event =3D 0
@@ -654,39 +654,16 @@ class Automata:
=20
         # declare the matrix....
         matrix =3D [[self.invalid_state_str for _ in range(nr_event)] for =
_ in range(nr_state)]
-        constraints: dict[_ConstraintKey, list[str]] =3D {}
=20
-        # and we are back! Let's fill the matrix
-        cursor =3D self.__get_cursor_begin_events()
-
-        for line in map(str.lstrip,
-                        islice(self.__dot_lines, cursor, None)):
-
-            if not line or line[0] !=3D '"':
-                break
-
-            split_line =3D line.split()
-
-            if len(split_line) > 2 and split_line[1] =3D=3D "->":
-                origin_state =3D split_line[0].replace('"', '').replace(',=
', '_')
-                dest_state =3D split_line[2].replace('"', '').replace(',',=
 '_')
-                possible_events =3D "".join(split_line[split_line.index("l=
abel") + 2:-1]).replace('"', '')
-                for event in possible_events.split("\\n"):
-                    event, *constr =3D event.split(";")
-                    if constr:
-                        key =3D _EventConstraintKey(states_dict[origin_sta=
te], events_dict[event])
-                        constraints[key] =3D constr
-                        # those events reset also on self loops
-                        if origin_state =3D=3D dest_state and "reset" in "=
".join(constr):
-                            self.self_loop_reset_events.add(event)
-                    matrix[states_dict[origin_state]][events_dict[event]] =
=3D dest_state
-            else:
-                state =3D line.split("label")[1].split('"')[1]
-                state, *constr =3D state.replace(" ", "").split("\\n")
-                if constr:
-                    constraints[_StateConstraintKey(states_dict[state])] =
=3D constr
-
-        return matrix, constraints
+        for transition in self.transitions:
+            src, dst =3D transition.src, transition.dst
+            event =3D transition.event
+            if src =3D=3D dst and transition.reset:
+                # those events reset also on self loops
+                self.self_loop_reset_events.add(event)
+            matrix[states_dict[src]][events_dict[event]] =3D dst
+
+        return matrix
=20
     def __store_init_events(self) -> tuple[list[bool], list[bool]]:
         events_start =3D [False] * len(self.events)
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index a38ef735a861..dc6d6f33729b 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -403,7 +403,7 @@ f"""static inline void ha_setup_invariants(struct ha_mo=
nitor *ha_mon,
=20
     def __fill_constr_func(self) -> list[str]:
         buff =3D []
-        if not self.constraints:
+        if not self.has_invariant and not self.has_guard:
             return []
=20
         buff.append(
--=20
2.47.3

