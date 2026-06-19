Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFE348445;
	Fri, 19 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848357; cv=none; b=j5oqNa1SksthvNsofK5Bo63MmB8X3TE7kxyiGH6P4bGixPKMXRTDT5jPpTIxRfv+L0cZj13RL5IKjvdx4SeyU8wUiFsQxzIMb7JVOmmmag4YEWvI2p5JE/AgTHb9p6aRkURHzXMlqqR78NGAHdkXB05AiYgA144K2ma3NsxNSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848357; c=relaxed/simple;
	bh=BzdFvwO1OGfvgPqhIXiVI11xuvNS7lDC/RAO5tF8ad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEwrSH5CHouM2dGinzLhOd0A/EJfiFnXtvVVSzZL97lD+LRIBfH3+vfan8y7//s0gx8lG4DJIoYuThjoQqpTO2oUjk3GGsx33CLoEeBohLqdgmL3gjgFTyMDxdyC7Ll0N8r+A0RoqAAijlxp5KCff3e5eOSRYzUGVyawqZHOYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wWOsRJcO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhSoYRgh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wWOsRJcO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhSoYRgh"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9UCfs9PLSNkLNgiPRjXfqwxODwxnfunJjfemTNE/40=;
	b=wWOsRJcOoPG1M/T/6XDiUFJilCAiEjqk9y7rZ1JRNX7xr2ef2Q4yLdDFRXw9QX/fHI/gA8
	SkBfDO20cRG/rWZ0eoSbZwFuS8zUaQp5rMwMAXsL70TKmPTsIL83cptVIsU4CF3GKXRVtS
	MzPV+ez42gJ9MQOy8r50dRoekcMs8WAgR2AzLWSIIc8MnPGXHu/JLu6PhU5KyVUzqruvwE
	uHgLuG0FfLRXKNj78PCyxA7OaLRzm/EihK7pTNGEGBXtlA2hK95TscUUIJBAB6ZxfvRGbj
	CVe8tjtYbv2GhXUGi+rDmx1jTXlIFrC7H9RyUKkKk4bXkBIElU0xdCE7LoQ5Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9UCfs9PLSNkLNgiPRjXfqwxODwxnfunJjfemTNE/40=;
	b=IhSoYRghuQ5tZaGRAt6yDgoKl4viNpdtQr1D4KynBBTMJrnDIzC35TJGyYrzymOjh7cYbb
	oypx4fXFqQcHL9BA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 05/13] verification/rvgen: Convert __fill_setup_invariants_func() to Lark
Date: Fri, 19 Jun 2026 07:52:08 +0200
Message-ID: <1e6e95ae085b21155f9ba97359659fa231d1b803.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
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
v4:
  fix bug when the time value has a unit
---
 tools/verification/rvgen/rvgen/dot2k.py | 48 ++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 0595bfcd232e..93674505f07b 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -250,6 +250,30 @@ class ha2k(dot2k):
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
+        try:
+            val =3D int(inv.val)
+        except ValueError:
+            # it's a constant, a parameter or a function
+            val =3D inv.val.replace("()", "(ha_mon)")
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
@@ -463,15 +487,14 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
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
@@ -480,13 +503,20 @@ f"""static inline void ha_setup_invariants(struct ha_=
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

