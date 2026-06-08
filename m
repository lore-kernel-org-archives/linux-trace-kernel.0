Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BA3B47C9;
	Mon,  8 Jun 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909052; cv=none; b=g7nQIzRWuOetkyGwThMcgDPdR1ZnKSFgfPXt7pihod9gb5tNum/fgLTKnlipLTCRgTX4vNXz/JR2znHUHqWcEbEAoP5TM1xIECBZ8YPnBs6PHT+WqFUGGvquIG2zqsx0kp6qMvOWxRpQV0LzErjjtzvYu6Qxf46Pbom0bHkhKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909052; c=relaxed/simple;
	bh=8zumhxn0uBbwstlGZfXS86mKSv2fQYnnyl7DAZnKNKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHBlZjYCsa2LIre8CV0A9qW6OWOmdVVZmCerkBnbWovhEeKTkoTRDOen4vJtImGDAm1KqBrHzcfOb/apOmVYZZct0TJLogUokyCyM0wKwbDuKEz95/lzEPUkzkFEPqmBat25y6P1N9CZh2Xw5S24U8NdMZqq2rFYHOQuOyZ3kcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Di5JtR7f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smKVrjtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Di5JtR7f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smKVrjtB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIYbDZpsVo2P3xrAA9JNP2SSQR+D2XJCTE0OZczvZUs=;
	b=Di5JtR7fH/8Rvs/LzpWG4qP++OK444mQIoFPaF93IzjMhwTWJ8t+Acr1hVkzjn9dgYjl6G
	jrTG7gMdXlOafdCB49Ugg2BiLWVOWZDswWpmWgWlk1A86PjETbwtbjTvw4zx5uwR+POMpv
	IoZBn2kGNOmGaekekdJYjzEnFF+SHxb8DP8Eo8bhTBUdxP4FmBmY99iQdHJvKGJcCJGQSW
	lN+Tsk16g8a1VNKY5Ve79U+8R96wm1yL1khOEEV5Ekjo+MXGcpezwBLp76UAWqQkjj7S2P
	4U0K2MmYv1PXwH/qMM5HCgWIuyUim9eh3jmwmkdUymfOdpDiWjITGZKvWEHeQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIYbDZpsVo2P3xrAA9JNP2SSQR+D2XJCTE0OZczvZUs=;
	b=smKVrjtBqZvftYl8NSC7kzT+lTh5yXKimd7Qf6AlhISx3UpMHOnxzmsfh+lR4bxfhjJp0l
	lDgxcevSotBB15DA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 06/13] verification/rvgen: Convert __fill_verify_guards_func() to Lark
Date: Mon,  8 Jun 2026 10:57:02 +0200
Message-ID: <8182bdf6a06a762799bd6edc2a5bdaca4b3ed916.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
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
index 1b29792ed630..e91717fde30d 100644
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

