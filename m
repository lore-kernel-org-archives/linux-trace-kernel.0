Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE43491D0;
	Fri, 19 Jun 2026 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848359; cv=none; b=LUteaX7+blVOeosIfmNeLKaRxIq3ZuR7+94p63FBLFISzUA4hG7rPZx/SuGcvUup9w8MGgnsTVY811qDMxRTwxH9hPETTefSOiKGK3HsXY6YgRkmzl/jFtUGexBerFTRZGnkVQC94Yk5vTd8DouF0iJXVeALMYuXIKuzlUbxWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848359; c=relaxed/simple;
	bh=h3of0wxgzSDDJXreuefzvdltkUpy+vFJourPkJTUkFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDXDnPgpiL9J2l1OkASrfSQBrykW934oV7qbm9f8g2DxPON3Np++GmqV8HvBz03Nijeh0OJqGSqh4AulpvKDaCXz9s1wUEXdkOIlrHZL+hwsVjHNoTAkocRxF3nValjKNWoD+CQjtHpE1/bG0OqUO5kaiIaEd72QqTJt06Xf70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jwdy1sPk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7sNJRd22; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwdy1sPk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7sNJRd22"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2re1CrwPeWA42+Pff8Mg41Ujjm+UUHmnktJ+QlHrnpU=;
	b=jwdy1sPkSerdrczW7/3Ozo82bIAaRsI4SGmMLyvIT255q+Sa1GYJmemV/0G0kExyOVHTad
	Um667qJFPGpDSTJKCEPJhNnoKd+v91lVy4DWHzdv17aczxL/bqB5FYuGOS+4XCsbxXAou9
	ROlY6dCk/UtN1sExWCfP+r8iK3sNZchup9Xm9Izk0p0RLclMIWu1e3i4RdyNpKX53NrGQV
	HwdxtfIBB6seTIWh5u76nfH7jG0acgKNj6YnxysHALnx1Ut5m+oS/w7SAy04IZsUgUVEOk
	jsqE5pFterw4QzyrTUkhCduhdBXnSv64r7M/OaN6l3iFJL4vSbu+/MEeb3vtDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2re1CrwPeWA42+Pff8Mg41Ujjm+UUHmnktJ+QlHrnpU=;
	b=7sNJRd22BffscXKG2U2+KXUdvQ9TPDgTqqJnalrMNW+ATJsqJRsZZ14+kKnyVGljYT22iL
	ljFk4ITU6SyHx8Cw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 11/13] verification/rvgen: Switch __create_matrix() to Lark
Date: Fri, 19 Jun 2026 07:52:14 +0200
Message-ID: <36e76b64049b7fef1cf5c2855fea310c0452ee38.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 47 ++++++----------------
 tools/verification/rvgen/rvgen/dot2k.py    |  2 +-
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index c34e916516ba..1726e82546a7 100644
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
index f1f5fa297adb..03141e9ef45d 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -407,7 +407,7 @@ f"""static inline void ha_setup_invariants(struct ha_mo=
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

