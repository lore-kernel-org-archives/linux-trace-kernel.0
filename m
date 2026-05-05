Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777363D1CA4;
	Tue,  5 May 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964391; cv=none; b=fqIrnUmdXV+JIOyI+iJDlz7uvJBgQcZ+WBErEgHQMINKMXpJlpWn/4VjPL7ORXHyJkrX7iuajwSh6Xdn9ZCi7bUTPIa0TickXoGd9j/suqMrvhHjme6A8yRu7Krq8ByhKm/EksV8CapkB28J0V2fDSSqNlNQQ06w27hGYie9U4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964391; c=relaxed/simple;
	bh=yTLgH36xEEmsymOpjtPNIIaA04EhIDtcCR6GSVjJPug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndCLrDmsuif8DubJj2laCZMo+ZmOO1tH+W8BLiafqafGUoaD8/B5W1VdBv4Xj3F+RRuQQfT2L/zKL4vrnsDdg7rrEElhiYkEyT0xoGzgdValYcmVeTRvR5AWIc+naT4O2VvFAsTNFXzNpm+X1TFI+cMMCE60lXMcBni+MXAYLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOwSuNbU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4J2uLaZy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOwSuNbU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4J2uLaZy"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVDUGSsyDe/fQYC75WnCgDJpQY9nDWTmvngJkI6bWUs=;
	b=UOwSuNbUEULSFCOo1gQpol/gsFmR7zGOC3NB0likL3N8H+qTQuyBdJSktrceEO1c+cJZLa
	DEl8Kg0GC6goKcnGG1Lrp9gS+CL55zL4IkRrsm1Q7XtNEfpla3KIP+V3bX2MMRhFRUfZQw
	aGGEIhWTByhosZOgFFRUyhKRk4ghVmjXwluFfF/e9CgirV7kxebLDDn8bm8sWUKLK+mzH2
	pEx4VFAp5SjP/galjBrJonsAa52BilkM995O33+r0+hKWy9xdwWakJ/TkuFJiIWY2rhXqe
	iKsaK+z6IF0EiY1ATFRfQgtsHWZj17MPJqaI6BOTLBEVV/Ujnw/rnLE1jZBUPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVDUGSsyDe/fQYC75WnCgDJpQY9nDWTmvngJkI6bWUs=;
	b=4J2uLaZyiWIbGYvvgKO+dJHLACHYLC+MyV69mlD4k3D2y+sIE0Cx2OG+yHvwWzQIIXTCp6
	Bjoh617uU/ODPJCw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 08/13] verification/rvgen: Simplify the generation for clock variables
Date: Tue,  5 May 2026 08:59:29 +0200
Message-ID: <ea337ecc9ca9d6864953170878e75bf2a1c91539.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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
 tools/verification/rvgen/rvgen/dot2k.py | 89 +------------------------
 1 file changed, 1 insertion(+), 88 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index cf7e5ddc649c..c662c888f991 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -247,7 +247,7 @@ class ha2k(dot2k):
         if inv.unit =3D=3D "j":
             clock_type =3D "jiffy"
=20
-        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns)"
+        return f"return ha_check_invariant_{clock_type}(ha_mon, {inv.env}_=
{self.name}, time_ns, {inv.val})"
=20
     def __start_to_conv(self, constr: str) -> str:
         """
@@ -376,40 +376,6 @@ f"""static inline bool ha_verify_invariants(struct ha_=
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
@@ -449,54 +415,6 @@ f"""static inline bool ha_verify_guards(struct ha_moni=
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
@@ -555,8 +473,6 @@ f"""static inline void ha_setup_invariants(struct ha_mo=
nitor *ha_mon,
  */""")
=20
         buff +=3D self.__fill_verify_invariants_func()
-        inv_conflicts =3D self.__fill_convert_inv_guard_func()
-        buff +=3D inv_conflicts
         buff +=3D self.__fill_verify_guards_func()
         buff +=3D self.__fill_setup_invariants_func()
=20
@@ -569,9 +485,6 @@ f"""static bool ha_verify_constraint(struct ha_monitor =
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

