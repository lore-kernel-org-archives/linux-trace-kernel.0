Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B63D170E;
	Tue,  5 May 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964390; cv=none; b=jjpb3pRKv0UDFM8uW5xG2xeGECdCKCuCMNxYJRksjWV1OtImjbdQOf1BP4bVUvxzuDMUjs1UFsyP3+wRDnFDEvLH4pA8t/t/7Zog0hjzenFZ0DGn+iwr/QMQiqlGQ3UjtFjnN8Z5iGmOKqUXzALM/p+kfshGpJY9Sa4zi+dXcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964390; c=relaxed/simple;
	bh=IL1CJV37SnDlj7He/xBGqNLGEE6mSIvvEPCT1D3haac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idGbjdWLq59twMgHv0gA0aRtE7ZtHsdM5MRCoFQFoP5WmxWtWgv5eeGM2ymNNOCZQFqXPQh3ej3kgKBr2J7+PN573a5ODP3ZQkXArMsWXAK7RRqvI1I5/yrdJDux2+U1D2tR0QH9SE+mFhTLbta8yj1ps6nNd6S2JcOJgUdm/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuZgwdWh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9iEnQWt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuZgwdWh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9iEnQWt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5h1A1PZlfEvZC9waEvOsKerpl76J+NV3FZzV+7jV9I=;
	b=fuZgwdWh5AbMuaX7fqw+9PVe5Oa9Oru6dtyhruSLtJjv5IQ8QSVea0l11sqE6V5+bsYN7e
	B7GKjo2Satymau1Pacb3JPECyeLKXhurk2kkIy5cQF56nYj6O4mQbup2u0HQL91q7KO5Oj
	3CpkIbMmIx5k5/GvayIQXwcaqy9p6q9daXRgzwCWuL2zooENBJYsd8DCsSJEPMExiH3FzN
	RdAjgbe6GhSnZkU8x9RqIVwBEeZ5ZHFLsVVKD48JdpTiLR3gl12TEl2OrqmhCdyFw7guKf
	fogo/5Q2soguCL5wiRVJFDVhF0Zk7Rb+xYodeX0kcLwueExNCauMABFccdInYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5h1A1PZlfEvZC9waEvOsKerpl76J+NV3FZzV+7jV9I=;
	b=z9iEnQWt7CvYqo5QhYy8Fu423edjRg9xbFXvN63pGQnF67T0LCuawFsATHzI76iCBA6QBk
	mopY5hJWMylJOaCQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 06/13] verification/rvgen: Convert __fill_verify_guards_func() to Lark
Date: Tue,  5 May 2026 08:59:27 +0200
Message-ID: <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
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
 tools/verification/rvgen/rvgen/dot2k.py | 39 ++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 3a39ae29e41e..cf7e5ddc649c 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -221,6 +221,20 @@ class ha2k(dot2k):
     def __parse_single_constraint(self, rule: dict, value: str) -> str:
         return f"ha_get_env(ha_mon, {rule["env"]}{self.enum_suffix}, time_=
ns) {rule["op"]} {value}"
=20
+    def __parse_guard_rule(self, rule) -> str:
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
+        buff[-1] +=3D ';'
+        return buff
+
     def __get_constraint_env(self, constr: str) -> str:
         """Extract the second argument from an ha_ function"""
         env =3D constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
@@ -398,8 +412,9 @@ f"""static inline void ha_convert_inv_guard(struct ha_m=
onitor *ha_mon,
=20
     def __fill_verify_guards_func(self) -> list[str]:
         buff =3D []
-        if not self.guards:
-            return []
+
+        if not self.has_guard:
+            return
=20
         buff.append(
 f"""static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
@@ -410,14 +425,22 @@ f"""static inline bool ha_verify_guards(struct ha_mon=
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

