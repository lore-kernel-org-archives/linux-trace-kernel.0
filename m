Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E53793BA;
	Thu, 28 May 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956895; cv=none; b=pOJsPZQS/uYi/jUcc0F72Q60dnV/8lx4Fao7evJwz53bAP/I4Cx+oBAOugPuMHQQKH7CONzEsXuN9/dDClIsutY+fmfxh8lsBivAN4FPHfVFcgOGX7td35vV8V6hMmX089FELPkiRvVh+IKonAwb2qYytXY6/gbt3NvkOJEAg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956895; c=relaxed/simple;
	bh=GgICHejSaCgbia1L+eRITR6BjR+aHeGi1DpftCmBGVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGhkLE6dhLQiAmhF7vOy7WDjiCcr1D3MaNI5iDd4f8kWlDDCeippObnlE3YQWiZGVDLrcPDag3k8XpfqeTuXXsN6qCuFINKkX0f4saSMNxCczKC0/yVs16Dy0hmJ5/vNQb9wY1hUDbq7aSPgKLwTi+Fn7mvJduaOOFGcwvF/SZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vMLuLz/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsab9iVI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vMLuLz/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsab9iVI"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzJsvUcVtDli60hQAurseNA0wOO48E4RfuNSOgFkTys=;
	b=4vMLuLz/+2aIRV7k0+o1UDlaGk0IKthdefshFa2tIPweThYvlo0iSY00kUMTYGEHIwQzyE
	QYHOIBaUUr7M/MEZrzQXGOUSHnUV5QSSy2zvYjGdXbS2Vacxss5euVkYFFZvRzEjJCRAex
	aj51uQNsisapZz2av9WAvXvHEKeQDMFwb8A5gZ5Jg5Ef1L8vNSEC9mznvjF1KWnqlfQZo/
	lJkmkK9i3802LyWNoPjGqAxTZpUbabsARXWSSgEHkjpbC7KZM68w5tmT9roWUz7Vy59Mq2
	2sPLLq5yvsmiIhNTH0Cg6x5m2TI/WgOjyiGKx0H/A6QOvrA85A0CFCBttLpnyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzJsvUcVtDli60hQAurseNA0wOO48E4RfuNSOgFkTys=;
	b=hsab9iVIjC9JenJYdja7ngVkhCu9cSDVcSwst2yfpI83pcas+1TZsr/uYe3jls6he0FlOF
	o7DfWLUD7EJFebAQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 04/13] verification/rvgen: Convert __fill_verify_invariants_func() to Lark
Date: Thu, 28 May 2026 10:27:52 +0200
Message-ID: <d1fbbafd8af64a9663b3982845ecb2c3c5a4eded.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert __fill_verify_invariants_func() to use the parsed states
information from Lark, prepare to remove the old raw text parsing code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: fix up __start_to_invariant_check()'s signature [Sashiko]
---
 tools/verification/rvgen/rvgen/dot2k.py | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index e6f476b903b0..a344cbbcb346 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -12,6 +12,7 @@ from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
 from .automata import _EventConstraintKey, _StateConstraintKey, AutomataEr=
ror
+from .automata import ConstraintRule, ConstraintCondition
=20
=20
 class dot2k(Monitor, Dot2c):
@@ -177,6 +178,14 @@ class ha2k(dot2k):
             raise AutomataError("Detected deterministic automaton, use the=
 'da' class")
         self.trace_h =3D self._read_template_file("trace_hybrid.h")
         self.__parse_constraints()
+        self.has_invariant =3D False
+        self.has_guard =3D False
+        for state in self._states:
+            if state.inv:
+                self.has_invariant =3D True
+        for transition in self.transitions:
+            if transition.rule or transition.reset:
+                self.has_guard =3D True
=20
     def fill_monitor_class_type(self) -> str:
         if self._is_id_monitor():
@@ -218,14 +227,13 @@ class ha2k(dot2k):
         assert env.rstrip(f"_{self.name}") in self.envs
         return env
=20
-    def __start_to_invariant_check(self, constr: str) -> str:
+    def __start_to_invariant_check(self, inv: ConstraintCondition) -> str:
         # by default assume the timer has ns expiration
-        env =3D self.__get_constraint_env(constr)
         clock_type =3D "ns"
-        if self.env_types.get(env.rstrip(f"_{self.name}")) =3D=3D "j":
+        if inv.unit =3D=3D "j":
             clock_type =3D "jiffy"
=20
-        return f"return ha_check_invariant_{clock_type}(ha_mon, {env}, tim=
e_ns)"
+        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns)"
=20
     def __start_to_conv(self, constr: str) -> str:
         """
@@ -320,20 +328,22 @@ class ha2k(dot2k):
                 self.invariants[key] =3D rules[0]
=20
     def __fill_verify_invariants_func(self) -> list[str]:
-        buff =3D []
-        if not self.invariants:
+        if not self.has_invariant:
             return []
=20
-        buff.append(
+        buff =3D [
 f"""static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
 \t\t\t\t\tenum {self.enum_states_def} curr_state, enum {self.enum_events_d=
ef} event,
 \t\t\t\t\tenum {self.enum_states_def} next_state, u64 time_ns)
-{{""")
+{{"""]
=20
         _else =3D ""
-        for state, constr in sorted(self.invariants.items()):
-            check_str =3D self.__start_to_invariant_check(constr)
-            buff.append(f"\t{_else}if (curr_state =3D=3D {self.states[stat=
e]}{self.enum_suffix})")
+        for state in self._states:
+            if not state.inv:
+                continue
+
+            check_str =3D self.__start_to_invariant_check(state.inv)
+            buff.append(f"\t{_else}if (curr_state =3D=3D {state.name}{self=
.enum_suffix})")
             buff.append(f"\t\t{check_str};")
             _else =3D "else "
=20
--=20
2.47.3

