Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502F3D170D;
	Tue,  5 May 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964390; cv=none; b=FOYvfhZk8yAUXKNxK6hTHLfCsiDn1vPYa7NNPmg74TnseD3sRyjv4HzwhmFQjnPDu5qxxVlqPODbVDbYy8QXYIW4HSAl5dOTabFxPGHrzLWMkZZZD7ODy1GyAz1/5stnPlGb+CED0xx5EScIoPpwmCj7w9G/4GTP/ivhgcGC6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964390; c=relaxed/simple;
	bh=yOsBs3DkFMX0BsQrDiKY/RvPC/v+5k81reOajeGRoQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYB15u5TRNU4pCbgvl4G7Z5YeQpf6XsBtrW1XlV14IIfiHZ7cLNeUJnlZIVD0DVk8oDpCa8oliKTpPfyvUVt31/s7trfGDX+maYA5qpbwlXq/LQ+W0QVW0t1iPDkij/8AupO1cFhMG/0V2p/vjDnE9R0eo+wlWHrIuCpEc9E53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WUMtRlCo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6JIgCZ4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WUMtRlCo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6JIgCZ4P"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kag4q2URgPnqH3+6ewLWSFKjs+1QeBtay0Ac+Xb81Rw=;
	b=WUMtRlCouiV6WQdyv4ih4PSbaad2RLtZYAo1hDmA8SsUWbM1i30MDdeUTG+3OoCpTrcrVu
	1lOm1VD5VXm/xrjWfqCcPSxDJ/tZ0+UqMNS7yi+peAbeuacTfZJnU17WdIwGbNaZgXr11+
	V1S1RczD2RWtzqw60uXK8+aBPNWg7E8ONUGtMstFTyX+D9zbkTgU7HROjAgTCFyDTLFIg1
	fPW2l6JX1icRKguscHuo8L3u2h6X8F+tTbdhqXUOikKcOhMNb4IEF/4iiBqkKJPCck1wlo
	BUXC7MPRmNj7ZgELZEsmkO7AE2wq7tlCd39RU7wnY6CSQRrxyP5x6Pm9OlIMVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kag4q2URgPnqH3+6ewLWSFKjs+1QeBtay0Ac+Xb81Rw=;
	b=6JIgCZ4PVvmuw6tsdTIhDwhjAI6nHYJwV5/SYHtHgv+DqyARp05IvN9ypaZcuAqZ/9HIlS
	UTA8qOYClP0WFQAg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 05/13] verification/rvgen: Convert __fill_setup_invariants_func() to Lark
Date: Tue,  5 May 2026 08:59:26 +0200
Message-ID: <dcdfe3345529b2c0e2e12b4e58af235bf8fa6001.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for self.invariants and __parse_constraints() to be removed.
convert __fill_setup_invariants_func() to use the new parsed states from
Lark.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/dot2k.py | 36 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 3e7040398a20..3a39ae29e41e 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -250,6 +250,18 @@ class ha2k(dot2k):
         return (f"ha_start_timer_{clock_type}(ha_mon, {rule["env"]}{self.e=
num_suffix},"
                 f" {value}, time_ns)")
=20
+    def __parse_invariant(self, inv):
+        # by default assume the timer has ns expiration
+        clock_type =3D "ns"
+        if inv.unit =3D=3D "j":
+            clock_type =3D "jiffy"
+
+        env =3D inv.env + self.enum_suffix
+        val =3D inv.val.replace("()", "(ha_mon)")
+
+        return (f"ha_start_timer_{clock_type}(ha_mon, {env},"
+                f" {val}, time_ns)")
+
     def __format_guard_rules(self, rules: list[str]) -> list[str]:
         """
         Merge guard constraints as a single C return statement.
@@ -463,15 +475,14 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
itor *ha_mon,
         return conflict_guards, conflict_invs
=20
     def __fill_setup_invariants_func(self) -> list[str]:
-        buff =3D []
-        if not self.invariants:
+        if not self.has_invariant:
             return []
=20
-        buff.append(
+        buff =3D [
 f"""static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
 \t\t\t\t       enum {self.enum_states_def} curr_state, enum {self.enum_eve=
nts_def} event,
 \t\t\t\t       enum {self.enum_states_def} next_state, u64 time_ns)
-{{""")
+{{"""]
=20
         conditions =3D ["next_state =3D=3D curr_state"]
         conditions +=3D [f"event !=3D {e}{self.enum_suffix}"
@@ -480,13 +491,20 @@ f"""static inline void ha_setup_invariants(struct ha_=
monitor *ha_mon,
         buff.append(f"\tif ({condition_str})\n\t\treturn;")
=20
         _else =3D ""
-        for state, constr in sorted(self.invariants.items()):
-            buff.append(f"\t{_else}if (next_state =3D=3D {self.states[stat=
e]}{self.enum_suffix})")
-            buff.append(f"\t\t{constr};")
+        for state in self._states:
+            inv =3D state.inv
+            if not inv:
+                continue
+            inv =3D self.__parse_invariant(inv)
+            buff.append(f"\t{_else}if (next_state =3D=3D {state.name}{self=
.enum_suffix})")
+            buff.append(f"\t\t{inv};")
             _else =3D "else "
=20
-        for state in self.invariants:
-            buff.append(f"\telse if (curr_state =3D=3D {self.states[state]=
}{self.enum_suffix})")
+        for state in self._states:
+            inv =3D state.inv
+            if not inv:
+                continue
+            buff.append(f"\telse if (curr_state =3D=3D {state.name}{self.e=
num_suffix})")
             buff.append("\t\tha_cancel_timer(ha_mon);")
=20
         buff.append("}\n")
--=20
2.47.3

