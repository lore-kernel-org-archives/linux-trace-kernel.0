Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12FD3793DE;
	Thu, 28 May 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956896; cv=none; b=qbY3loHEIK7ipBwAgqmNcjii6BThFODMxUXW01OpeDQ/45loHFCFGytUzu2MQfWSlACkmcMfbohZeN54MeaMi2VzUDHaHUMVsslYTfiar2CAlaZpDuBY0toclSD7TQRHldmuymymmNRqvZUwilwmd3fQXnBDdN60SsxLTs4IdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956896; c=relaxed/simple;
	bh=QdsMQkekA1xOWQtjwhVjq/QjcJvm4QD4xcTebmKgsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm8hSjrbxiGjQWgo4dtWl8YHmAMLMJjt5WMlEvgeefX0racYubx+waCt3kkMM5oiELmaiGy6ld+TxVzeKzGPmS2BqBWslYcjeMucQNUmeWPbgBGiAvWtkVbMW3gREBtM0HpgH9uT5fCpLDamPhHvBwsqFcMqhaS9LNnSGTPtOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVdeF07/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sNXKcAl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVdeF07/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sNXKcAl"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SCEqGaXpDy5iQ9SddZqF6yn9bfsxhrj30i6jVH/uEQ=;
	b=HVdeF07/uVVnkZ2nqfQsE2Dw0SpagHB5UVu3wQ6R4/kENQhaX7wqx07jk6/Z5m84fd00NC
	U8egDaIdnZshiREf6+vjtoogfjUoOAXLZuXtXiSv4x7lDm6xxJSCCW6d47NSJmBs0TxYYw
	j/n0AT4Tg6Vdy0JZ0Ahb4NdWJt0Bj76bEtXZwNTEooghkjJlHdFw09PdXe+QmR0cPrwXhy
	hIPcpI3YW/erpX9xVGEzC/7Hy+JjTtE0pYavb3J2BxJzgsZqINr7kfH8fP7plA8QN5OHHT
	wIjWvnsHpj6fr6lwNoE+uX7g+LHlufwHoScbe5t5f8k27pyeaBT6QqLkucseIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SCEqGaXpDy5iQ9SddZqF6yn9bfsxhrj30i6jVH/uEQ=;
	b=3sNXKcAluMRltkKw/Lwlu8KGoc/sa0qF4sKa+QZLerb33eOmmN5YDD0WYXUqAF5kLZJ128
	PW9YsBdMh4cscICA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 05/13] verification/rvgen: Convert __fill_setup_invariants_func() to Lark
Date: Thu, 28 May 2026 10:27:53 +0200
Message-ID: <0b2cf5e1bb03d0e3a667b0fc2c7093123ef0a78c.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
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
v2: add missing time conversion [Sashiko]
---
 tools/verification/rvgen/rvgen/dot2k.py | 44 ++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index a344cbbcb346..d9f8e1c7737a 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -250,6 +250,26 @@ class ha2k(dot2k):
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
+        match inv.unit:
+            case "us":
+                val *=3D 10**3
+            case "ms":
+                val *=3D 10**6
+            case "s":
+                val *=3D 10**9
+
+        return (f"ha_start_timer_{clock_type}(ha_mon, {env},"
+                f" {val}, time_ns)")
+
     def __format_guard_rules(self, rules: list[str]) -> list[str]:
         """
         Merge guard constraints as a single C return statement.
@@ -463,15 +483,14 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
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
@@ -480,13 +499,20 @@ f"""static inline void ha_setup_invariants(struct ha_=
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

