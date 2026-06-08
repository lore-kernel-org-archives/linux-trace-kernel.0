Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327A3B42F9;
	Mon,  8 Jun 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909051; cv=none; b=puvRdrAqZ6W8oplWLqPVwtDR6d++u2Yb/oX9vUdad63cJs8rt25DxstloC0nnwZlMrqdvHq+q+tVU+72tqvYYE18tFmy4/UR1fsPQOTXz6LGPSO5468PpMK0nyqSL36DJ31dTJHTwysEWDP1rw4DELoOSRY7p0QnaV01+V+Ts0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909051; c=relaxed/simple;
	bh=nxXI/sbEg7sQYczA8k0dJsBSDlRQ7oSqvTggSL6UfOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R19rE5r/09SOcyw4nBQ331q3gfXyYcgEY+rbZLGh+cvfzT1hrqueB6Fc7yCj12OckDGem1YZFEGFgzAT84Brl2y9Dk513u64YHcXblibcrrZ38RIvJyH1Soyz4hyqn6+8A0GL5C9d3OasC6XqaDvhgd4mTUlF++r62mkeY+UiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieOiJA1f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7x+MF/Fs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieOiJA1f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7x+MF/Fs"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTq+GETCeldyfomjfzUFOZclOm/T6717ndV3i0vpoaI=;
	b=ieOiJA1fbN/ebbzDSM5c2vHGQXpVHcE6rGZRKawctdov7/zmdCGD/DGzKDJOQUHJOfV08P
	b7Pe1LLuJAbNpEiEhTic6NcCbcLlVqJhE2UlwJ5M5fbnXGTi+a6+wg5XxrQ714u5kOW6X5
	9ekSIhhLHL0xYWPC7P/AgSLMOzmRQuBdLCVnqWXn2L3Qs0ACskJN+0b1JRi+mndb/0SkM1
	lSjOuuzVKL/Bo62ug+OnN0T5Mo5xvWoQQ9KFzjbTO2rlliVTczamx5Gxvn3tOn+F9DWbU6
	r3ZW488pR6yuCbQmIiV3DDM0ogmD7Dxuwz18jv8GDnHo8HuShuBuyBxKnxMXeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTq+GETCeldyfomjfzUFOZclOm/T6717ndV3i0vpoaI=;
	b=7x+MF/Fs1HL2temJ9Lp2qRvKgS5Xk3W3sWAVYYa5aAP/RvpWkzI7O21mR48pN1X63JYOyp
	26xr6eTtbIJ+KIAQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 05/13] verification/rvgen: Convert __fill_setup_invariants_func() to Lark
Date: Mon,  8 Jun 2026 10:57:01 +0200
Message-ID: <e5f62eab0210df74ba5dea5c99e218b39d331274.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/dot2k.py | 44 ++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 0595bfcd232e..1b29792ed630 100644
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

