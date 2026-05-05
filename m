Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456C3C2779;
	Tue,  5 May 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964388; cv=none; b=FEhxHEhXXwtLCiW+wliSk8inRa98UAaLVvGHw/YuPgheWeW9dTDg+Dpc50srrjsMYpI05Exa7arIhXzdImVKembaaNI+nxdtNzkJGvEzBqDyxaOIT8CjfQTrmL1RZaLH1KxkfBuW8jC8LFnjMcm+6Jm+b5igFVf+MFcVEdCzjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964388; c=relaxed/simple;
	bh=vti/rte8oRMfSLDEsrf5xMN3UZt/x1fjzYRhpYKlvak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fro9SMpcAcQqFeVmhbncsRC89MNQc6CsNwQwzslKHsFyiWdGaCrYhMYmkoK6/DAzSePq1AyE2MX5GL+Wzzy2wPm/SXk0REl6wi1tdWJygO9MsLyn/AWYqFhUGdRhUP3UFdB6MmqdHFDAntIK3qyGVmxINM+coBvEKskICgdGj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gE+kTv7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=selyBx19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gE+kTv7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="selyBx19"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQXgIzbWeGU99kkevGp/pxf/2mcoG9yivLWfxbs3U3g=;
	b=gE+kTv7vJ+dYDs6ReVxUlxZYA6BV4TkxntoR+WGiidMq6sgwa8L+bnweU0FUE8BC499qEi
	ScVjUwXuhblVlCkk8j3m2x/SscPQpN+GK3tVXuz2w9mervbgW0hKA7wgl+12vnS1rKIvGr
	fPj5ycNubJ/6SbX9hsQRT/soVNyiOyMTekjLr2R2kNhi4R7dJiuqfV6+djFtSusB3OjfM4
	qkoDxNstRAltm62TuK6jFb3l4zp5W/LYowGSZny3X/BUD82FJFTqOhdQ+ZKSUWC22FGAed
	qgv7eces/Yot6hg19G60J2ekaYh6ovzhjY1b1dGq5RboAetkBBPnNe1d3SWFJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQXgIzbWeGU99kkevGp/pxf/2mcoG9yivLWfxbs3U3g=;
	b=selyBx19L14gfhqPmECuBjUl6AEKvEBNyx/v9HZRj1WAqXLZwui6Fsrr1KSmfsMhFg5LLE
	62ngR36+iD2oh/BQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 04/13] verification/rvgen: Convert __fill_verify_invariants_func() to Lark
Date: Tue,  5 May 2026 08:59:25 +0200
Message-ID: <f84cfc058ce2937840c84d309461042d5eed8c6c.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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
 tools/verification/rvgen/rvgen/dot2k.py | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index e6f476b903b0..3e7040398a20 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -12,6 +12,7 @@ from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
 from .automata import _EventConstraintKey, _StateConstraintKey, AutomataEr=
ror
+from .automata import ConstraintRule
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
+    def __start_to_invariant_check(self, inv: ConstraintRule) -> str:
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

