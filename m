Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD3348C52;
	Fri, 19 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848359; cv=none; b=MiFaAJ1h/AA+AiIBf7N87lMx0JHMYR5sgdf/FBeGQiv5UmqjTOtdlqOkV9HsYj9tACDuCE+xeAJcV74Lrt2Id6O6dsDKXLdJLTuvQUSzXK2fWHRIrZmKi93zbyE4xuUeFBbs8G4jX4kp1rbYY2Eeys3EP46ppnd01J65DyY8qlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848359; c=relaxed/simple;
	bh=AgKczjzZ5VQ6/xQl8nNSBgb+Gj52Wze360PMaJLHjKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOZtxNE2wR5pHmLx+SCxFlKeUmGFOsj9OK+I3316kzZMPHIIOpY+AebinEiKNTtjZt81ybDe1Ttv1WL2/EpaOWJC4IJln4FuOqr6BYOXBivBnBCnIKjnPCCMrLmwO4knfMJW7H3x/B828U2JbDQ0hHrM0jOtUxVpVwjXiQQXcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2UW5mv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6j9oyPl3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2UW5mv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6j9oyPl3"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781848354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nPoyRhySyrOxX+5k4qEqycTCSX/Wj3yuuYmXawbrG4=;
	b=G2UW5mv/Omsf/T+685dGaUvdQmjADn8lQaqtE36k6K5W5DsGJAGjCEujOmRCyGvHSDxB4e
	mGnufy5vpRlkUZBRxWGa/6RZ+9Zq6JX6EJcFXvmgr4v7kRo33U2cH4QShPPRRmq33uUrAx
	dg5ggQT5bz5chkAL4zj15/QiFeiPFZKLb+EAwklJoGzF2zlpBZ3KtL+0nU/vUCzbsN80sO
	fyc/w3MG0GQ1F+jHBdf4bzywc2qYlLrkAYTtgYygjCNdCiQk37aEpOFmZo0/sH8VCzHvwk
	uV77Ivc/esHBlYv+y/f+vojnviBYvclc8jPKpTNOuoDS2pRmEvEVVG7EWX2+JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781848354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nPoyRhySyrOxX+5k4qEqycTCSX/Wj3yuuYmXawbrG4=;
	b=6j9oyPl37iWCWqNw0AOtAukwZIJw8SruUyMWtDac5OwFjiXq98GguYFqStFjEdF30gUCVZ
	04QmiK/Gco9lmQAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 10/13] verification/rvgen: Switch __get_event_variables() to Lark
Date: Fri, 19 Jun 2026 07:52:13 +0200
Message-ID: <03f6457b4fcaa64199ffe73edb2a9fc48e76a839.1781847583.git.namcao@linutronix.de>
In-Reply-To: <cover.1781847583.git.namcao@linutronix.de>
References: <cover.1781847583.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Switch __get_event_variables() to use the parsed results from Lark, instead
of raw text processing.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 78 ++++++----------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verificatio=
n/rvgen/rvgen/automata.py
index ea7eabd4c173..c34e916516ba 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -591,45 +591,22 @@ class Automata:
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
@@ -653,28 +630,11 @@ class Automata:
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
+    def __extract_env_var(self, constraint: ConstraintCondition):
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

