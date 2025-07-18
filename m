Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558354503B;
	Fri, 18 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850700; cv=none; b=b6OvFA1EwQw0fEz8+8tDS5TDrUhMkzYBZhLfh9T4T1N1JxPUPPd86Oud0fdAxkRMMUg6enNBxD0eldDduWN69TUrRP/E8ykTL27guAPIaXRhKjtHS1ZPXXILuCON0BbVHUFKvhu9vcvnQdzFStPtwt4FDeV8zC5ziIz4pojsm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850700; c=relaxed/simple;
	bh=bHqd0pceGXeracf8rTym4kiKPxEE+vjc0WSbnSdUIYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sd4y5D6qNkFMfNxl8wBELBUOf6ekD0VbP4RC6puf/+5MA5HJzs33whCcSy50JAiracK1LrmJ4l7OKyteQtBWU630Lv6vm5VkHbriMljyGLLTs5tn2lTp2uFtU8nj9o7JSRlC6yiw0jEXAkgJey01YwX6YT7K7/hCZ3D/1qeqL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GsXYNlwh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jKSEV8bp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GsXYNlwh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKSEV8bp"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQIJao/BEOvnZ/LvbD4mo/zjJjh7HsWT/5/dONy0Yo8=;
	b=GsXYNlwhn86aYAp5ibZA4S4YEBDfsR7nTRzSajiECDUgVj2Z2nGsdDDM2GdEGBSHnpwxdi
	4BJvmz7lHCmfBxvFjCpUXI0a1bvJA7MCU5NqiJzZSKoYlJznbqKTp+QviUrtrj4st2qXVU
	CrrlRfwS/a/p6xLzLG+WeKLX9fRccGFqZSgB0/nHiElHM0G7bYFWbjlxFUhcq41tO/YWt4
	XYPI4e25eT3c3/RP5jXAKORcsULKXJx2nXfLyINtKiMkA08h+xzxwHgiz0q1fd5lI/D08B
	+4W7Wznoxn+CSadxbdWdJiYYAJtzRgZzzdcZIa5NaDjBDTgCBckiLVJNkNFXpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQIJao/BEOvnZ/LvbD4mo/zjJjh7HsWT/5/dONy0Yo8=;
	b=jKSEV8bpkNCM6SD0JZUQcUM1Xtz/TnRCR8gjwOt/9NEwtfs2MFu00uCxaAQFrdNmosOWQv
	7rlOng5RAEj4qYAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] verification/rvgen: Generate each variable definition only once
Date: Fri, 18 Jul 2025 16:58:10 +0200
Message-Id: <107dcf0d0aa8482d5fbe0314c3138f61cd284e91.1752850449.git.namcao@linutronix.de>
In-Reply-To: <cover.1752850449.git.namcao@linutronix.de>
References: <cover.1752850449.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a variable appears multiple times in the specification, ltl2k generates
multiple variable definitions. This fails the build.

Make sure each variable is only defined once.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/r=
vgen/rvgen/ltl2k.py
index 92e713861d86..59da351792ec 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -112,14 +112,16 @@ class ltl2k(generator.Monitor):
             if node.op.is_temporal():
                 continue
=20
-            if isinstance(node.op, ltl2ba.Variable):
-                buf.append("\tbool %s =3D test_bit(LTL_%s, mon->atoms);" %=
 (node, node.op.name))
-            elif isinstance(node.op, ltl2ba.AndOp):
+            if isinstance(node.op, ltl2ba.AndOp):
                 buf.append("\tbool %s =3D %s && %s;" % (node, node.op.left=
, node.op.right))
             elif isinstance(node.op, ltl2ba.OrOp):
                 buf.append("\tbool %s =3D %s || %s;" % (node, node.op.left=
, node.op.right))
             elif isinstance(node.op, ltl2ba.NotOp):
                 buf.append("\tbool %s =3D !%s;" % (node, node.op.child))
+
+        for atom in self.atoms:
+            buf.append("\tbool %s =3D test_bit(LTL_%s, mon->atoms);" % (at=
om.lower(), atom))
+
         buf.reverse()
=20
         buf2 =3D []
--=20
2.39.5

