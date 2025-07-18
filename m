Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2651186284;
	Fri, 18 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850701; cv=none; b=KXugm9Li6kvy1Evmf9M0mS3TY438QsUO9GaZXu1LLBl7oDzAjcsBNOUYFfU2lCIlDhHQbxbKNlaMXcigE6MVgXKQ9xjFRyOnxBgBxWBBPdpPnqxQN/Da/Wioni2LJ1TysCBIZe1nEytDqz+GmDJwn5a1UcWrywXG/niyEVvd9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850701; c=relaxed/simple;
	bh=xVMfBgl1l3GHsKKQVU8yKnQCBPFluy2E1a7pDYpZ2ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQQ3GjsO23OzwcUudAPxwFer/mAxBdWXCSyEKovINXaeZtgudG1CrSdhpBc94//MtIJIQpa0oEhtaKnlpGTC6etPANFli8qU1MsphaM94XCdOiMeDq2fMwvg6AeNQE+FVZkAIWa4KwuOJcFes0Jn4+sLRA1Dp8aW3X+j3gDUkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P5M6zAxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7rfwEYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P5M6zAxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7rfwEYr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYKTQi7OGOSXX22a4In+1PmPa1DfLGyOjSg+4bTlG50=;
	b=P5M6zAxhLcfQMlUW3I05OZ+NvjToiLLyfeSlKCsY4Gr4KPOHr6zJzK0wktDKpVjJ67//ns
	+9MuFPOU/oZhpbNSaEHbQ4Yg/9jJYGmqWM9/KdA/avDNTInn6U2FAXjK5MWukksPA7q5gv
	gNBJDFp9L1LAO9MT4NtS87KfrrqPsnMMGetsdkYiAra6zTl6UOdrqn+kok/p88NZFWH4l5
	uptjOJcvbUqGM0mvMjU35ge+ry7CY83uOjzvLtwyInpk8kbjfoP0F8w82FbPP0pzkhvdRJ
	jc+/1i65b0ijqhgdnqv1oEFU7vkhFUHAxE5pvRxWtcMx2tkTMfmy3LgX/uy4tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYKTQi7OGOSXX22a4In+1PmPa1DfLGyOjSg+4bTlG50=;
	b=V7rfwEYreWuuiv1/eKSw45w4yn+UKBjxr36pto18piKULXM7ErzkFmZfHvUgxocW7MUEFZ
	e0BRu5heCfvyJyCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] verification/rvgen: Do not generate unused variables
Date: Fri, 18 Jul 2025 16:58:11 +0200
Message-Id: <636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de>
In-Reply-To: <cover.1752850449.git.namcao@linutronix.de>
References: <cover.1752850449.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ltl2k generates all variable definition in both ltl_start() and
ltl_possible_next_states(). However, these two functions may not use all
the variables, causing "unused variable" compiler warning.

Change the script to only generate used variables.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/r=
vgen/rvgen/ltl2k.py
index 59da351792ec..b075f98d50c4 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -106,20 +106,25 @@ class ltl2k(generator.Monitor):
         ])
         return buf
=20
-    def _fill_atom_values(self):
+    def _fill_atom_values(self, required_values):
         buf =3D []
         for node in self.ltl:
-            if node.op.is_temporal():
+            if str(node) not in required_values:
                 continue
=20
             if isinstance(node.op, ltl2ba.AndOp):
                 buf.append("\tbool %s =3D %s && %s;" % (node, node.op.left=
, node.op.right))
+                required_values |=3D {str(node.op.left), str(node.op.right=
)}
             elif isinstance(node.op, ltl2ba.OrOp):
                 buf.append("\tbool %s =3D %s || %s;" % (node, node.op.left=
, node.op.right))
+                required_values |=3D {str(node.op.left), str(node.op.right=
)}
             elif isinstance(node.op, ltl2ba.NotOp):
                 buf.append("\tbool %s =3D !%s;" % (node, node.op.child))
+                required_values.add(str(node.op.child))
=20
         for atom in self.atoms:
+            if atom.lower() not in required_values:
+                continue
             buf.append("\tbool %s =3D test_bit(LTL_%s, mon->atoms);" % (at=
om.lower(), atom))
=20
         buf.reverse()
@@ -135,7 +140,13 @@ class ltl2k(generator.Monitor):
             "ltl_possible_next_states(struct ltl_monitor *mon, unsigned in=
t state, unsigned long *next)",
             "{"
         ]
-        buf.extend(self._fill_atom_values())
+
+        required_values =3D set()
+        for node in self.ba:
+            for o in sorted(node.outgoing):
+                required_values |=3D o.labels
+
+        buf.extend(self._fill_atom_values(required_values))
         buf.extend([
             "",
             "\tswitch (state) {"
@@ -166,7 +177,13 @@ class ltl2k(generator.Monitor):
             "static void ltl_start(struct task_struct *task, struct ltl_mo=
nitor *mon)",
             "{"
         ]
-        buf.extend(self._fill_atom_values())
+
+        required_values =3D set()
+        for node in self.ba:
+            if node.init:
+                required_values |=3D node.labels
+
+        buf.extend(self._fill_atom_values(required_values))
         buf.append("")
=20
         for node in self.ba:
--=20
2.39.5

