Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94693B4E81;
	Mon,  8 Jun 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909052; cv=none; b=lTfE0JxwuFjDTfZO3C1s4jXTG7khHFoHM0h9y7DlB1ldLZpVuJZy6PFWt8RAQ4mKCQVvA1CX1Qs+t1kwTTj6PAwySdu5hOKSwUAQSxsqxqS1vyViKx3zjAnbtfqsQh5VZD7mN1H63s7PJIHNuIgrDmtAHXCPO5md3le9qT8BuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909052; c=relaxed/simple;
	bh=xB+mFvL/Gk3hD0symPhFYGjtdqFOIbUfP3scdyYgoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLBdsaj1xKFRWpVNPMTKcUMLcuBzOOEuDF67z1iT9/2o7fVpcF5Sgix23gJkp8OVLt02emxiwahCbey3m5AbsyE2MSuTIKCX3Wvv7mrDVWnPRjHsDxXXrNFYTowmBl01bz4LCgvh3RqN0gVkeuopOgqQLKbL6tzs/ZJAipfqdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZeE3bKyK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T97ZN7Kw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZeE3bKyK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T97ZN7Kw"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780909047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcYajoyp4TEVGAqefl9kQPnOV2nCEMbqQf4yFAPefF8=;
	b=ZeE3bKyKiG7FFvOJ5+pa0t0uXdbjfydew6WWUcmUX29sCnTwvA6v4KKJm2DQZHpBmx2HdW
	24qDYnboitTn+K/57BMRnNwZ4aZcxuDABz/jPTzws3rdgCT/Z1/mr25QE3t8ZN7B5B9aHN
	KRvLIYSNqDVPpEJz8Gii9xuOI0IGSsCi6t3xBuOmGXHqYbSekR6rOoFPljJKbWL3BqykCC
	Vb6mJVW8vL8IGUHQib6CV56wt4P/GYzs2IbQVCX5qLBk3JudSQOMeXd1M9RrLWu5rTvXoV
	2hR/cwncR8bmipyD0Nm3qsKiKOnVOE0g6kmwNf6LL8yescvCisKnMqQF9/B23w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780909047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcYajoyp4TEVGAqefl9kQPnOV2nCEMbqQf4yFAPefF8=;
	b=T97ZN7Kw2oLw395zWn+7/DfDMM4/xyFdQqe+sHcuvLfAS/+PuLlSmfslYv/25NPn5aDsUG
	Rn2uGKnteXbvf9Dw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 09/13] verification/rvgen: Delete __parse_constraint()
Date: Mon,  8 Jun 2026 10:57:05 +0200
Message-ID: <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
In-Reply-To: <cover.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All previous users of self.invariants and self.guards have been converted
to the Lark parser, delete __parse_constraints() and its associates.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/dot2k.py | 67 ++-----------------------
 1 file changed, 4 insertions(+), 63 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index 6d346a718a39..a38ef735a861 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -177,7 +177,6 @@ class ha2k(dot2k):
         if not self.is_hybrid_automata():
             raise AutomataError("Detected deterministic automaton, use the=
 'da' class")
         self.trace_h =3D self._read_template_file("trace_hybrid.h")
-        self.__parse_constraints()
         self.has_invariant =3D False
         self.has_guard =3D False
         for state in self._states:
@@ -304,64 +303,6 @@ class ha2k(dot2k):
         separator =3D "\n\t\t      " if sum(len(r) for r in rules) > 80 el=
se " "
         return ["res =3D " + separator.join(rules) + ";"]
=20
-    def __validate_constraint(self, key: tuple[int, int] | int, constr: st=
r,
-                              rule, reset) -> None:
-        # event constrains are tuples and allow both rules and reset
-        # state constraints are only used for expirations (e.g. clk<N)
-        if self.is_event_constraint(key):
-            if not rule and not reset:
-                raise AutomataError("Unrecognised event constraint "
-                                    f"({self.states[key[0]]}/{self.events[=
key[1]]}: {constr})")
-            if rule and (rule["env"] in self.env_types and
-                         rule["env"] not in self.env_stored):
-                raise AutomataError("Clocks in hybrid automata always requ=
ire a storage"
-                                    f" ({rule["env"]})")
-        else:
-            if not rule:
-                raise AutomataError("Unrecognised state constraint "
-                                    f"({self.states[key]}: {constr})")
-            if rule["env"] not in self.env_stored:
-                raise AutomataError("State constraints always require a st=
orage "
-                                    f"({rule["env"]})")
-            if rule["op"] not in ["<", "<=3D"]:
-                raise AutomataError("State constraints must be clock expir=
ations like"
-                                    f" clk<N ({rule.string})")
-
-    def __parse_constraints(self) -> None:
-        self.guards: dict[_EventConstraintKey, str] =3D {}
-        self.invariants: dict[_StateConstraintKey, str] =3D {}
-        for key, constraint in self.constraints.items():
-            rules =3D []
-            resets =3D []
-            for c, sep in self._split_constraint_expr(constraint):
-                rule =3D self.constraint_rule.search(c)
-                reset =3D self.constraint_reset.search(c)
-                self.__validate_constraint(key, c, rule, reset)
-                if rule:
-                    value =3D rule["val"]
-                    value_len =3D len(rule["val"])
-                    unit =3D None
-                    if rule.groupdict().get("unit"):
-                        value_len +=3D len(rule["unit"])
-                        unit =3D rule["unit"]
-                    c =3D c[:-(value_len)]
-                    value =3D self.__adjust_value(value, unit)
-                    if self.is_event_constraint(key):
-                        c =3D self.__parse_single_constraint(rule, value)
-                        if sep:
-                            c +=3D f" {sep}"
-                    else:
-                        c =3D self.__parse_timer_constraint(rule, value)
-                    rules.append(c)
-                if reset:
-                    c =3D f"ha_reset_env(ha_mon, {reset["env"]}{self.enum_=
suffix}, time_ns)"
-                    resets.append(c)
-            if self.is_event_constraint(key):
-                res =3D self.__format_guard_rules(rules) + resets
-                self.guards[key] =3D ";".join(res)
-            else:
-                self.invariants[key] =3D rules[0]
-
     def __fill_verify_invariants_func(self) -> list[str]:
         if not self.has_invariant:
             return []
@@ -486,15 +427,15 @@ f"""static bool ha_verify_constraint(struct ha_monito=
r *ha_mon,
 \t\t\t\t enum {self.enum_states_def} next_state, u64 time_ns)
 {{""")
=20
-        if self.invariants:
+        if self.has_invariant:
             buff.append("\tif (!ha_verify_invariants(ha_mon, curr_state, "
                         "event, next_state, time_ns))\n\t\treturn false;\n=
")
=20
-        if self.guards:
+        if self.has_guard:
             buff.append("\tif (!ha_verify_guards(ha_mon, curr_state, event=
, "
                         "next_state, time_ns))\n\t\treturn false;\n")
=20
-        if self.invariants:
+        if self.has_invariant:
             buff.append("\tha_setup_invariants(ha_mon, curr_state, event, =
next_state, time_ns);\n")
=20
         buff.append("\treturn true;\n}\n")
@@ -571,7 +512,7 @@ f"""static bool ha_verify_constraint(struct ha_monitor =
*ha_mon,
         return self.__fill_hybrid_get_reset_functions() + self.__fill_cons=
tr_func()
=20
     def _fill_timer_type(self) -> list:
-        if self.invariants:
+        if self.has_invariant:
             return [
                     "/* XXX: If the monitor has several instances, conside=
r HA_TIMER_WHEEL */",
                     "#define HA_TIMER_TYPE HA_TIMER_HRTIMER"
--=20
2.47.3

