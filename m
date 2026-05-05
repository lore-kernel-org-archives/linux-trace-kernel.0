Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1F3D349D;
	Tue,  5 May 2026 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964392; cv=none; b=UtnLez/Q6I68yeIgG2fUaOvjQEy2Iw/sG+lrg36b2nAN2y6oWENU19aAaaf2dOAOQx47zM/3waV9X/T9d9OUuA0V4GAOdSfKTlAJp9jhqNuvBp9uxhhlTKBgJBmlIRVfYvrO1ZC7yPa813pBlzN1mbftZiC/bl204Vkdn3p27Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964392; c=relaxed/simple;
	bh=U8eo2ICz4lpIt8wpAs0vg9jNcPoWEgutttxGmPpTzXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqtexaKFBVodlRC7FpXUUYeSzeLSCesPlWYLfrcSSt8Ibkomzn3wSrITPhvFwsqOb8F+qqQQJ8Pupht/HdfBw2sTCvtOia2v3m6PzC9J4y2Wken1URIBhmyjI1f98VPYA34T5X9VcR3HdONvecL7nNdn/fJc5GostrvuvB1sMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAd19UAY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6aNtSQUp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAd19UAY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6aNtSQUp"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777964388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU+TvDDlCcsVI5W6j1TjtrcbzA0uGy58MDKdF8Z83eQ=;
	b=RAd19UAYGVPvbaUJMOEPa/TTOIg2PyHJ/SYeIAw1JRV0DxTd8+Z7wzkj136I+scCaHVaBA
	ppQtj7yRj0uCQ/3+KQduLofl4ClyWM1Oyn/dYEUQuQZbOHiIFv4v7f4XqSBgpjDu8vd5d/
	olSf7tSgT5sxWY+Er2q4cWNlgMy/1XXyv/vpmnHd0NIt0EQZfMEWM0OGSYNlqrLmSPKOpG
	QI4tefp3qcAOkmepURdwsVK364lmtmpdVJooYQscqa/UprWTQHr9ErbuF83Dmoi6tAP+Iy
	YcunSzl5Lthc2cWnoNoV9oyg/O3UarvCfggCHbPhVv+I2jiT+72fYrlPGi/GQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777964388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HU+TvDDlCcsVI5W6j1TjtrcbzA0uGy58MDKdF8Z83eQ=;
	b=6aNtSQUpSlu2wp/W7o09xvFWUjyp3ab6OCYR664CgiWu/W0gYjxbbfzx2vuclNWoSC3Ta5
	qHkD2ZVuOFaQvdAA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 10/13] verification/rvgen: Switch __get_event_variables() to Lark
Date: Tue,  5 May 2026 08:59:31 +0200
Message-ID: <a16e6cadb9a20d2f053124c380d1b8cfe15f5700.1777962130.git.namcao@linutronix.de>
In-Reply-To: <cover.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch __get_event_variables() to use the parsed results from Lark, instead
of raw text processing.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 78 ++++++----------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index 32c16736a41b..a29dcde1348c 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -578,45 +578,22 @@ class Automata:
     def __get_event_variables(self) -> tuple[list[str], list[str]]:
         events: list[str] =3D []
         envs: list[str] =3D []
-        # here we are at the begin of transitions, take a note, we will re=
turn later.
-        cursor =3D self.__get_cursor_begin_events()
=20
-        for line in map(str.lstrip, islice(self.__dot_lines, cursor, None)=
):
-            if not line.startswith('"'):
-                break
+        for transition in self.transitions:
+            events.append(transition.event)
=20
-            # transitions have the format:
-            # "all_fired" -> "both_fired" [ label =3D "disable_irq" ];
-            #  ------------ event is here ------------^^^^^
-            split_line =3D line.split()
-            if len(split_line) > 1 and split_line[1] =3D=3D "->":
-                event =3D "".join(split_line[split_line.index("label") + 2=
:-1]).replace('"', '')
-
-                # when a transition has more than one label, they are like=
 this
-                # "local_irq_enable\nhw_local_irq_enable_n"
-                # so split them.
-
-                for i in event.split("\\n"):
-                    # if the event contains a constraint (hybrid automata),
-                    # it will be separated by a ";":
-                    # "sched_switch;x<1000;reset(x)"
-                    ev, *constr =3D i.split(";")
-                    if constr:
-                        if len(constr) > 2:
-                            raise AutomataError("Only 1 constraint and 1 r=
eset are supported")
-                        envs +=3D self.__extract_env_var(constr)
-                    events.append(ev)
-            else:
-                # state labels have the format:
-                # "enable_fired" [label =3D "enable_fired\ncondition"];
-                #  ----- label is here -----^^^^^
-                # label and node name must be the same, condition is optio=
nal
-                state =3D line.split("label")[1].split('"')[1]
-                _, *constr =3D state.split("\\n")
-                if constr:
-                    if len(constr) > 1:
-                        raise AutomataError("Only 1 constraint is supporte=
d in the state")
-                    envs +=3D self.__extract_env_var([constr[0].replace(" =
", "")])
+            if transition.reset:
+                envs.append(transition.reset.env)
+                self.env_stored.add(transition.reset.env)
+            if transition.rule:
+                for c, _ in transition.rule.rules:
+                    envs.append(c.env)
+                    self.__extract_env_var(c)
+
+        for state in self._states:
+            if state.inv:
+                envs.append(state.inv.env)
+                self.__extract_env_var(state.inv)
=20
         return sorted(set(events)), sorted(set(envs))
=20
@@ -640,28 +617,11 @@ class Automata:
             seps.append(None)
         return zip(exprs, seps)
=20
-    def __extract_env_var(self, constraint: list[str]) -> list[str]:
-        env =3D []
-        for c, _ in self._split_constraint_expr(constraint):
-            rule =3D self.constraint_rule.search(c)
-            reset =3D self.constraint_reset.search(c)
-            if rule:
-                env.append(rule["env"])
-                if rule.groupdict().get("unit"):
-                    self.env_types[rule["env"]] =3D rule["unit"]
-                if rule["val"][0].isalpha():
-                    self.constraint_vars.add(rule["val"])
-                # try to infer unit from constants or parameters
-                val_for_unit =3D rule["val"].lower().replace("()", "")
-                if val_for_unit.endswith("_ns"):
-                    self.env_types[rule["env"]] =3D "ns"
-                if val_for_unit.endswith("_jiffies"):
-                    self.env_types[rule["env"]] =3D "j"
-            if reset:
-                env.append(reset["env"])
-                # environment variables that are reset need a storage
-                self.env_stored.add(reset["env"])
-        return env
+    def __extract_env_var(self, constraint: ConstraintCondition) -> list[s=
tr]:
+        if constraint.unit:
+            self.env_types[constraint.env] =3D constraint.unit
+        if constraint.val[0].isalpha():
+            self.constraint_vars.add(constraint.val)
=20
     def __create_matrix(self) -> tuple[list[list[str]], dict[_ConstraintKe=
y, list[str]]]:
         # transform the array into a dictionary
--=20
2.47.3

