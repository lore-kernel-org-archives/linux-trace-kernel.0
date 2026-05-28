Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7C379C5E;
	Thu, 28 May 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956897; cv=none; b=jNKPnqgqHv5PU1y+lj6T/vmSWOIfMXrxjl/odgTl25cNDlooJa5seU5Tlsygq1ivClUvkbcBRUUCK8WVcVFmkR3zK8EEFb7f8M3Z6yCYqJ7wCpLVxfQDk68KZQcf9f5+yZRxWqGZyr45KSqxM4fb7MkKHHTGGVT0gQmkI/vEgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956897; c=relaxed/simple;
	bh=+ACcNI4umuGPeXyl+kAJFeIoTbOgnWI7f9VK6dhZXME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLINANTATYCuIypZ4uzZQWbcJUsCmFKmfe2OOsBZvv6fmb10+qzRwsUEnWMRZz45ieFOpz6e6DdAAsYqQS2NpzlkS8DZRSe/dAH1mdM7l09Min+MRc9W7+nFEn7tejaiD/2mAU4eU6ul14dmHsvMTo61qjtLqnbSw/Hd7r0DIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aoccr8Lc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPsKaLaZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoccr8Lc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPsKaLaZ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3wk/oudCLpunKRbWUDb9KPkrIFOQfBgbbh4ZHb+baE=;
	b=aoccr8LcrXc/APh0Pw403QF+4mYgDdwzwpH6lFTmG6Fp7X+O2SR8bSlLEn1pajkIn3va/u
	uP2BgHtEB+UxR02JU5WrqB5fSDTHiSDZCIP17Xng/v1wdFiolw31D0LjEt8orh8fuKpOEH
	bVyxUbSifeOcMFqeqt2KPVXKSEnnNzXakoKbbrEuEKBffRHfnvFKT/S79LHaMaNiNMR8ES
	AL2T8VRk/qyoK6FAYUmhxIdelcKJbxNPKOEOHIHEUyqjifOu9AeTtqH0AqxEhttijmD0z1
	TbDlZgCmbWpyElmSsx8AzG5s0QubTFyy8+j2XL7Wl66dhn9+jZBF/e1kQVECvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3wk/oudCLpunKRbWUDb9KPkrIFOQfBgbbh4ZHb+baE=;
	b=mPsKaLaZuXuA7V8zmizidSXd32GC0u15QzJ+YfvnftJlWtqtYMqG53EEKcAMXE0rqL5xYH
	TYh/QbmfxdbzgrAQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 08/13] verification/rvgen: Simplify the generation for clock variables
Date: Thu, 28 May 2026 10:27:56 +0200
Message-ID: <c7ceb59b37e22d491d8eb527451cb085b890da23.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hybrid automata monitors's clock variables have been changed to have
only a single representation. Now there is no need to generate code to
convert between the two representations.

Delete __fill_convert_inv_guard_func() and its associates. Update
__start_to_invariant_check() to how invariants now work.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - add missing __adjust_value() in __start_to_invariant_check() [Sashiko]
  - remove obsolete comment about dual clock representation [Sashiko]
---
 tools/verification/rvgen/rvgen/dot2k.py | 96 +------------------------
 1 file changed, 3 insertions(+), 93 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index ebaa6c9135c2..3aee2e44ba7d 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -246,7 +246,9 @@ class ha2k(dot2k):
         if inv.unit =3D=3D "j":
             clock_type =3D "jiffy"
=20
-        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns)"
+        value =3D self.__adjust_value(inv.val, inv.unit)
+
+        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns, {value})"
=20
     def __start_to_conv(self, constr: str) -> str:
         """
@@ -383,40 +385,6 @@ f"""static inline bool ha_verify_invariants(struct ha_=
monitor *ha_mon,
         buff.append("\treturn true;\n}\n")
         return buff
=20
-    def __fill_convert_inv_guard_func(self) -> list[str]:
-        buff =3D []
-        if not self.invariants:
-            return []
-
-        conflict_guards, conflict_invs =3D self.__find_inv_conflicts()
-        if not conflict_guards and not conflict_invs:
-            return []
-
-        buff.append(
-f"""static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
-\t\t\t\t\tenum {self.enum_states_def} curr_state, enum {self.enum_events_d=
ef} event,
-\t\t\t\t\tenum {self.enum_states_def} next_state, u64 time_ns)
-{{""")
-        buff.append("\tif (curr_state =3D=3D next_state)\n\t\treturn;")
-
-        _else =3D ""
-        for state, constr in sorted(self.invariants.items()):
-            # a state with invariant can reach us without reset
-            # multiple conflicts must have the same invariant, otherwise w=
e cannot
-            # know how to reset the value
-            conf_i =3D [start for start, end in conflict_invs if end =3D=
=3D state]
-            # we can reach a guard without reset
-            conf_g =3D [e for s, e in conflict_guards if s =3D=3D state]
-            if not conf_i and not conf_g:
-                continue
-            buff.append(f"\t{_else}if (curr_state =3D=3D {self.states[stat=
e]}{self.enum_suffix})")
-
-            buff.append(f"\t\t{self.__start_to_conv(constr)};")
-            _else =3D "else "
-
-        buff.append("}\n")
-        return buff
-
     def __fill_verify_guards_func(self) -> list[str]:
         buff =3D []
=20
@@ -456,54 +424,6 @@ f"""static inline bool ha_verify_guards(struct ha_moni=
tor *ha_mon,
         buff.append("\treturn res;\n}\n")
         return buff
=20
-    def __find_inv_conflicts(self) -> tuple[set[tuple[int, _EventConstrain=
tKey]],
-                                            set[tuple[int, _StateConstrain=
tKey]]]:
-        """
-        Run a breadth first search from all states with an invariant.
-        Find any conflicting constraints reachable from there, this can be
-        another state with an invariant or an edge with a non-reset guard.
-        Stop when we find a reset.
-
-        Return the set of conflicting guards and invariants as tuples of
-        conflicting state and constraint key.
-        """
-        conflict_guards: set[tuple[int, _EventConstraintKey]] =3D set()
-        conflict_invs: set[tuple[int, _StateConstraintKey]] =3D set()
-        for start_idx in self.invariants:
-            queue =3D deque([(start_idx, 0)])  # (state_idx, distance)
-            env =3D self.__get_constraint_env(self.invariants[start_idx])
-
-            while queue:
-                curr_idx, distance =3D queue.popleft()
-
-                # Check state condition
-                if curr_idx !=3D start_idx and curr_idx in self.invariants:
-                    conflict_invs.add((start_idx, _StateConstraintKey(curr=
_idx)))
-                    continue
-
-                # Check if we should stop
-                if distance > len(self.states):
-                    break
-                if curr_idx !=3D start_idx and distance > 1:
-                    continue
-
-                for event_idx, next_state_name in enumerate(self.function[=
curr_idx]):
-                    if next_state_name =3D=3D self.invalid_state_str:
-                        continue
-                    curr_guard =3D self.guards.get((curr_idx, event_idx), =
"")
-                    if "reset" in curr_guard and env in curr_guard:
-                        continue
-
-                    if env in curr_guard:
-                        conflict_guards.add((start_idx,
-                                             _EventConstraintKey(curr_idx,=
 event_idx)))
-                        continue
-
-                    next_idx =3D self.states.index(next_state_name)
-                    queue.append((next_idx, distance + 1))
-
-        return conflict_guards, conflict_invs
-
     def __fill_setup_invariants_func(self) -> list[str]:
         if not self.has_invariant:
             return []
@@ -554,16 +474,9 @@ f"""static inline void ha_setup_invariants(struct ha_m=
onitor *ha_mon,
  * the next state has a constraint, cancel it in any other case and to che=
ck
  * that it didn't expire before the callback run. Transitions to the same =
state
  * without a reset never affect timers.
- * Due to the different representations between invariants and guards, the=
re is
- * a function to convert it in case invariants or guards are reachable from
- * another invariant without reset. Those are not present if not required =
in
- * the model. This is all automatic but is worth checking because it may s=
how
- * errors in the model (e.g. missing resets).
  */""")
=20
         buff +=3D self.__fill_verify_invariants_func()
-        inv_conflicts =3D self.__fill_convert_inv_guard_func()
-        buff +=3D inv_conflicts
         buff +=3D self.__fill_verify_guards_func()
         buff +=3D self.__fill_setup_invariants_func()
=20
@@ -576,9 +489,6 @@ f"""static bool ha_verify_constraint(struct ha_monitor =
*ha_mon,
         if self.invariants:
             buff.append("\tif (!ha_verify_invariants(ha_mon, curr_state, "
                         "event, next_state, time_ns))\n\t\treturn false;\n=
")
-        if inv_conflicts:
-            buff.append("\tha_convert_inv_guard(ha_mon, curr_state, event,=
 "
-                        "next_state, time_ns);\n")
=20
         if self.guards:
             buff.append("\tif (!ha_verify_guards(ha_mon, curr_state, event=
, "
--=20
2.47.3

