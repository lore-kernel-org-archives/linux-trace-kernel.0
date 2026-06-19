Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C14348866;
	Fri, 19 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848357; cv=none; b=jdRwXuKm/bqKLq61BmRAeEjJfxptN6HsXKDHaBCz1taJt6BX+wzFUIJ8HmXMlpsURzYKjkXOrROeLI8wVHhbH9wbn51WD400+toZdDoD7yswD4vV+HX+wpYMndXqjCVAoMYsZfoJeYuUz7kyBySUC5SwPkLlM9Z2Jt3OSOmDVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848357; c=relaxed/simple;
	bh=J/ofVX/ZZ405Eucvmh0fYA2epdgpVfWN8hByac00wNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHLtd+e27ex/x6kUzJeO8X7mT+gKtOgp2wPwx0N278pQ4U7em0UDpAZs1qf2NvxWentguVQePfiWgRTSyg/Uxvj9uGM2YbMPQQuAy8GYarmydYr0YUDr1n8adzjJvyrpG4g9M07K30sweB8mINkW2SuW0O0Mn3cc1YeD5H1KV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mG2EHsFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yi9EUH8T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mG2EHsFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yi9EUH8T"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiwh70JgxsikzDg1LiLIFrWCTDNoi+RW5hKt9uDqw2g=;
	b=mG2EHsFV3nPxD83Z6ZPV1P2wzPLFYaUPnHivncYax9go5RSw+qIT2zOmkNelsRKViFyqzi
	+Tc+dpOJ1axNdo/e9KQqWqSgqdQhWCqgVtiN8OpipLKFVV5W+KdQT9uk4g4Q8vOSFzC74y
	eRUZccnULUAsgQk7tkAK4QZBCQ5cb6j7WkqOVBiPJGr6c+sprHbI5iMQu6Xz55IU/u96em
	ydtBe7tolv8lTSy0q1olHgVcT6xeF3UR7eEpFpFm/rLKzG3fllVGvwcuG44YwFcQrIcUic
	nOwdC7e9K6x3+zL3KFoEEEBQELiKYhpjSD+aDIxOSPgUHpQXHAX+Ha0MHI9AfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiwh70JgxsikzDg1LiLIFrWCTDNoi+RW5hKt9uDqw2g=;
	b=yi9EUH8T72mjpOaBkz0JBcLkphbKlg6Rzl7z54T8CAloy6BcYNgtamv+YcQx485xU9xqaG
	c5EpCnEX6F2xvrDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 06/13] verification/rvgen: Convert __fill_verify_guards_func() to Lark
Date: Fri, 19 Jun 2026 07:52:09 +0200
Message-ID: <4f18c30b60d7c7138c0016cd6985d14a898b1eec.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare to remove self.guards and self.__parse_constraints(), convert
__fill_verify_guards_func() to use the parsed transitions from Lark.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/dot2k.py | 38 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 93674505f07b..ced4e6288ff4 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -221,6 +221,19 @@ class ha2k(dot2k):
     def __parse_single_constraint(self, rule: dict, value: str) -> str:
         return f"ha_get_env(ha_mon, {rule["env"]}{self.enum_suffix}, time_=
ns) {rule["op"]} {value}"
=20
+    def __parse_guard_rule(self, rule) -> list[str]:
+        buff =3D []
+        for c, sep in rule.rules:
+            env =3D c.env + self.enum_suffix
+            op =3D c.op
+            val =3D self.__adjust_value(c.val, c.unit)
+
+            cond =3D f"ha_get_env(ha_mon, {env}, time_ns) {op} {val}"
+            if sep:
+                cond +=3D f" {sep}"
+            buff.append(cond)
+        return buff
+
     def __get_constraint_env(self, constr: str) -> str:
         """Extract the second argument from an ha_ function"""
         env =3D constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
@@ -291,7 +304,7 @@ class ha2k(dot2k):
         rules =3D invalid_checks + rules
=20
         separator =3D "\n\t\t      " if sum(len(r) for r in rules) > 80 el=
se " "
-        return ["res =3D " + separator.join(rules)]
+        return ["res =3D " + separator.join(rules) + ";"]
=20
     def __validate_constraint(self, key: tuple[int, int] | int, constr: st=
r,
                               rule, reset) -> None:
@@ -410,7 +423,8 @@ f"""static inline void ha_convert_inv_guard(struct ha_m=
onitor *ha_mon,
=20
     def __fill_verify_guards_func(self) -> list[str]:
         buff =3D []
-        if not self.guards:
+
+        if not self.has_guard:
             return []
=20
         buff.append(
@@ -422,14 +436,22 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
itor *ha_mon,
 """)
=20
         _else =3D ""
-        for edge, constr in sorted(self.guards.items()):
+        for transition in self.transitions:
+            if not transition.rule and not transition.reset:
+                continue
+
             buff.append(f"\t{_else}if (curr_state =3D=3D "
-                        f"{self.states[edge[0]]}{self.enum_suffix} && "
-                        f"event =3D=3D {self.events[edge[1]]}{self.enum_su=
ffix})")
-            if constr.count(";") > 0:
+                        f"{transition.src}{self.enum_suffix} && "
+                        f"event =3D=3D {transition.event}{self.enum_suffix=
})")
+            rule =3D transition.rule
+            reset =3D transition.reset
+            if rule and reset:
                 buff[-1] +=3D " {"
-            buff +=3D [f"\t\t{c};" for c in constr.split(";")]
-            if constr.count(";") > 0:
+            if rule:
+                buff.append("\t\t" + self.__format_guard_rules(self.__pars=
e_guard_rule(rule))[0])
+            if reset:
+                buff.append(f"\t\tha_reset_env(ha_mon, {reset.env}{self.en=
um_suffix}, time_ns);")
+            if rule and reset:
                 _else =3D "} else "
             else:
                 _else =3D "else "
--=20
2.47.3

