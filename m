Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0003B3887;
	Mon,  8 Jun 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909048; cv=none; b=tEKjGU3+WvmQvb0hH0uIDm2eBfvr82tdhJKSFMFO5L5AhY24T2XsIZ4HnSKtzkSh1tszs9nDScIh31IHHPOqsirEBPU+xkz/hGMRvqJJLr1FWl+jB6F21UOIpt0zC7yzhxlaysh9Q+PYNCEjfFSzIFhhHqnlTw1DrKevWheO/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909048; c=relaxed/simple;
	bh=fWDOil+1nalo8bXMWCuGsQj/R1sipl6kSB3bKbJG1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQXi/fQ1Tewua7LQF8A8CXGwcdiq/CTauevPJMDKiTmEjevXmRfJU3qsOhqWnwfCh8PbbHv/1ZuvWiKb8+iJ0nyVmVhunO7X72VTxnB9464xvYGkJrDMfilK1Lb9HA67XQKnkLISAZNmK5CIaXrSQ2Ee4+5bNjwkS5pGmDFrmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=palc1tK8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nuUIbVlR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="palc1tK8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nuUIbVlR"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGdJn1kK1yjAiJ1GvD7KIXuOfVDkCf2rQ+rNK2oX5iE=;
	b=palc1tK8/tZYe4EtyvjtnVECPfUZzBXQ+XCa1FYYrdyDkxqCxTSLqlj2PydsO0MzZBpYvF
	bqo7Bu5PTT8YZHtn1bOCIeD50CK3/FM3qSHw/wL/sjboPrTOnq5EYlMv2p3QT8gJOknF91
	IHF79Y3gbVgXB73zdZJobDXsRrjFlDNkEvTFm0DoaQbkMRMkaOkEsBzY5Y46QjHCBVHY/G
	dnEE2PAuBoWhGF6kDlSOETMb4CVp9oHCWdAieSHULnq8eEEdo1UzkP0xz8avSH4SwLcuMu
	Wy8SvPPt0BXHDXHYjhteXQcCWKGKqa/UY98CS2NN5Ngi7XF/HlB1aRboCi5kvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGdJn1kK1yjAiJ1GvD7KIXuOfVDkCf2rQ+rNK2oX5iE=;
	b=nuUIbVlRpC6zV7LhxSgJiNc+5vHVn2Y47M2T3ECcaqo4UN+Q3cu2d9+8Zvun5MCC6fuT/J
	W5z+VMcsj+v9ckCA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 04/13] verification/rvgen: Convert __fill_verify_invariants_func() to Lark
Date: Mon,  8 Jun 2026 10:57:00 +0200
Message-ID: <f620a4f1aea617bb9a643d58832d1be134377195.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert __fill_verify_invariants_func() to use the parsed states
information from Lark, prepare to remove the old raw text parsing code.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v3:
  - remove unused import
---
 tools/verification/rvgen/rvgen/dot2k.py | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 110cfd69e53a..0595bfcd232e 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -12,6 +12,7 @@ from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
 from .automata import _EventConstraintKey, _StateConstraintKey, AutomataEr=
ror
+from .automata import ConstraintCondition
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
         assert env.removesuffix(f"_{self.name}") in self.envs
         return env
=20
-    def __start_to_invariant_check(self, constr: str) -> str:
+    def __start_to_invariant_check(self, inv: ConstraintCondition) -> str:
         # by default assume the timer has ns expiration
-        env =3D self.__get_constraint_env(constr)
         clock_type =3D "ns"
-        if self.env_types.get(env.removesuffix(f"_{self.name}")) =3D=3D "j=
":
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

