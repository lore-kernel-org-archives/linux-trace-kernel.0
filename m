Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A4378D71;
	Thu, 28 May 2026 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956896; cv=none; b=Yk8+RJFTgvqQH+d3rK4hScnhQjDbVvD4yYVJkB4QijGagN1AqnKHt/PM56Otc2rFmjnnPQ3yxykf8jBpc5PLuNjm3zneIYWs3HcyeeCAy9nSlsK+8DKR6RuD6IoJPktdzDKfaXUSnHKwIDcZOSC5GToSoQMiUjOK+VtczQH6dCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956896; c=relaxed/simple;
	bh=vTFq3foTdNB6zeqaaZE7I9ZzLyhSfOY5UPD91dH1uH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlTreLD/QDVb+5YB7giRawuzerCrv+CT2Rzq/tYrJ4QkSAheD+Fkup3ihvRnPsd9Xe4KesMqWXr2UXZMIiNXeRYlO+AcKh69a7P+DyETG/QP0s4c1+ugvfYtm7dgEuvrJE1DK3qKcqwZwKr8gsCtIdQjDTVs1gJVj9R3hdNznGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlT465i0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SALIK9SN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlT465i0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SALIK9SN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3Mjdyvr7ihVKGai3Yxy6L8TVjmUfr9blfcOpHVW6Fo=;
	b=tlT465i0rSq7duiydyd6nlcxM+lx+dNx5//wIMsTxAe8Mru632rvTeKCoEVQMqwWRUkcwa
	+0owNMWtOK3kwITgjcj8A0mkHrlQz928q3i1CLHagn2X6LfaMHGnH5w9toKzSJt4Gfquys
	0BGuaF/xL5g9I+jkIGb5PDyKSSiM/bzwZnvt7ijO7sQW4Hg1iwtK1rUtbhHyDO7IRCW8fr
	N88W9AkPgA4/brQU3vk/QtRrlWoGJdFtrFyqIPXjj3QGcHI1uIoRt06vcqJsj5h5XheLkq
	FKBdW11sPxN+8WDDjXjECpx/QG6pBpTpBjjHTRbCbHT5EcLHXrsuENsgzeV07w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3Mjdyvr7ihVKGai3Yxy6L8TVjmUfr9blfcOpHVW6Fo=;
	b=SALIK9SNigRdB54CyXKKtQOYYRDm8K2YRt+OZzsZ3Q2j6PdJqTTOGG65U4UWdn3/dpuhBM
	6rg7Odf86+9zoGDw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 06/13] verification/rvgen: Convert __fill_verify_guards_func() to Lark
Date: Thu, 28 May 2026 10:27:54 +0200
Message-ID: <2157c2e5fe34251c403604f0d58a3a686a6f6a8b.1779956342.git.namcao@linutronix.de>
In-Reply-To: <cover.1779956342.git.namcao@linutronix.de>
References: <cover.1779956342.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare to remove self.guards and self.__parse_constraints(), convert
__fill_verify_guards_func() to use the parsed transitions from Lark.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2:
  - fix up the ';' separator [Gabriele]
  - make return type consistent with the function's signature [Wander]
  - fix up __parse_guard_rule()'s signature
---
 tools/verification/rvgen/rvgen/dot2k.py | 38 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index d9f8e1c7737a..ebaa6c9135c2 100644
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
@@ -287,7 +300,7 @@ class ha2k(dot2k):
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
@@ -406,7 +419,8 @@ f"""static inline void ha_convert_inv_guard(struct ha_m=
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
@@ -418,14 +432,22 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
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

