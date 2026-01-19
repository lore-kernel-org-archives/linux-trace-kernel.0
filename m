Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EB239E75
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856886; cv=none; b=Kf+SD2/mFaiZc7hChbbgSAjOcxsRmGlb6OE15HMYl6Q9UvZnfTK2QsUyOht9Ri/raSYc2mP/jncStrwYwzP7zDhgAfZwj4GOZoK7yiknO56xwdb3ZUdV16YqihDCKlahg/I1ET2X9B5ExiNcG06e1E5+Ff5TWQPyaqK63ZspAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856886; c=relaxed/simple;
	bh=CfZHGU9rAZCkxcJo6GF+wsIc1/L4cXtenRegcxb04NU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+iBovH2jAgeiAPCFHkJWOzgBR0CwTJ94TP55T77ehl3p+IfgJ6L7aiKdgpaAF664h/SOe749pQvvrGuwix6ncYeVspIvhcFmA8xoORo9Cn+pjsr7rOrmzBqmCxPWCyOcF1Wztmwg27qxaFoUD8lJKR7ZczXyDfN2r/s2+mca4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRK00jqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRK00jqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv86rSujb1th/HGt0eBVWDgWUHvu2gpQrKGVJxmc+Bc=;
	b=VRK00jqfPbtrIZDPctU5GFzttcnlLVshn/25t7iQI0/Pfp38pHy/3vdcUUrJUyzG49uXu7
	EEwX5vxbM06hHv8FGdqewhk2wPFTSBIGQ+5Ep6LyALSku++hoPgH5b5t+YkFdtlpifwRPH
	F0ogBjxNyyqgow0cUaHzNRBLs9jnwoM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-h6YaOZo7OQObv8GBVkXWNA-1; Mon,
 19 Jan 2026 16:08:00 -0500
X-MC-Unique: h6YaOZo7OQObv8GBVkXWNA-1
X-Mimecast-MFC-AGG-ID: h6YaOZo7OQObv8GBVkXWNA_1768856879
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 802961954B0C;
	Mon, 19 Jan 2026 21:07:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04B5819560AB;
	Mon, 19 Jan 2026 21:07:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 23/26] rv/rvgen: add type annotations to fix pyright errors
Date: Mon, 19 Jan 2026 17:45:59 -0300
Message-ID: <20260119205601.105821-24-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add return type annotations to RVGenerator base class methods and
LTL operator classes to resolve pyright reportIncompatibleMethodOverride
errors.

In generator.py, add string return type annotations to all template
filling methods and annotate the template_dir class attribute to enable
proper type checking during initialization.

In ltl2ba.py, introduce a LTLNode type alias as a Union of all AST node
types (BinaryOp, UnaryOp, Variable, Literal) to properly type operator
transformations. The operator base classes BinaryOp and UnaryOp receive
return type annotations using this type alias for their normalize and
negate methods, since these transformations can return different node
types depending on the expression. The Variable and Literal classes gain
return type annotations for their manipulation methods, and all temporal
checking methods are annotated to return bool.

The LTLNode type alias is necessary because operator transformations are
polymorphic: NotOp.negate() can return BinaryOp, UnaryOp, Variable, or
Literal depending on what expression is being negated.

In ltl2k.py, fix the _fill_states return type from str to list[str] to
match the actual implementation.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 35 +++++++++++----------
 tools/verification/rvgen/rvgen/ltl2ba.py    | 33 ++++++++++---------
 tools/verification/rvgen/rvgen/ltl2k.py     |  2 +-
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index d99a980850d64..c58a81a775681 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -12,6 +12,7 @@ from .utils import not_implemented
 
 class RVGenerator:
     rv_dir = "kernel/trace/rv"
+    template_dir: str
 
     def __init__(self, extra_params={}):
         self.name = extra_params.get("model_name")
@@ -66,24 +67,24 @@ class RVGenerator:
             path = os.path.join(self.abs_template_dir, "..", file)
             return self._read_file(path)
 
-    def fill_parent(self):
+    def fill_parent(self) -> str:
         return f"&rv_{self.parent}" if self.parent else "NULL"
 
-    def fill_include_parent(self):
+    def fill_include_parent(self) -> str:
         if self.parent:
             return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
         return ""
 
     @not_implemented
-    def fill_tracepoint_handlers_skel(self): ...
+    def fill_tracepoint_handlers_skel(self) -> str: ...
 
     @not_implemented
-    def fill_tracepoint_attach_probe(self): ...
+    def fill_tracepoint_attach_probe(self) -> str: ...
 
     @not_implemented
-    def fill_tracepoint_detach_helper(self): ...
+    def fill_tracepoint_detach_helper(self) -> str: ...
 
-    def fill_main_c(self):
+    def fill_main_c(self) -> str:
         main_c = self.main_c
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
@@ -102,18 +103,18 @@ class RVGenerator:
         return main_c
 
     @not_implemented
-    def fill_model_h(self): ...
+    def fill_model_h(self) -> str: ...
 
     @not_implemented
-    def fill_monitor_class_type(self): ...
+    def fill_monitor_class_type(self) -> str: ...
 
     @not_implemented
-    def fill_monitor_class(self): ...
+    def fill_monitor_class(self) -> str: ...
 
     @not_implemented
-    def fill_tracepoint_args_skel(self, tp_type): ...
+    def fill_tracepoint_args_skel(self, tp_type) -> str: ...
 
-    def fill_monitor_deps(self):
+    def fill_monitor_deps(self) -> str:
         buff = []
         buff.append("	# XXX: add dependencies if there")
         if self.parent:
@@ -121,7 +122,7 @@ class RVGenerator:
             buff.append("	default y")
         return '\n'.join(buff)
 
-    def fill_kconfig(self):
+    def fill_kconfig(self) -> str:
         kconfig = self.kconfig
         monitor_class_type = self.fill_monitor_class_type()
         monitor_deps = self.fill_monitor_deps()
@@ -139,7 +140,7 @@ class RVGenerator:
         content = content.replace(marker, line + "\n" + marker)
         self.__write_file(file_to_patch, content)
 
-    def fill_tracepoint_tooltip(self):
+    def fill_tracepoint_tooltip(self) -> str:
         monitor_class_type = self.fill_monitor_class_type()
         if self.auto_patch:
             self._patch_file("rv_trace.h",
@@ -155,7 +156,7 @@ Add this line where other tracepoints are included and {monitor_class_type} is d
     def _kconfig_marker(self, container=None) -> str:
         return f"# Add new {container + ' ' if container else ''}monitors here"
 
-    def fill_kconfig_tooltip(self):
+    def fill_kconfig_tooltip(self) -> str:
         if self.auto_patch:
             # monitors with a container should stay together in the Kconfig
             self._patch_file("Kconfig",
@@ -168,7 +169,7 @@ Add this line where other monitors are included:
 source \"kernel/trace/rv/monitors/{self.name}/Kconfig\"
 """
 
-    def fill_makefile_tooltip(self):
+    def fill_makefile_tooltip(self) -> str:
         name = self.name
         name_up = name.upper()
         if self.auto_patch:
@@ -182,7 +183,7 @@ Add this line where other monitors are included:
 obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
 """
 
-    def fill_monitor_tooltip(self):
+    def fill_monitor_tooltip(self) -> str:
         if self.auto_patch:
             return f"  - Monitor created in {self.rv_dir}/monitors/{self.name}"
         return f"  - Move {self.name}/ to the kernel's monitor directory ({self.rv_dir}/monitors)"
@@ -229,7 +230,7 @@ class Monitor(RVGenerator):
         super().__init__(extra_params)
         self.trace_h = self._read_template_file("trace.h")
 
-    def fill_trace_h(self):
+    def fill_trace_h(self) -> str:
         trace_h = self.trace_h
         monitor_class = self.fill_monitor_class()
         monitor_class_type = self.fill_monitor_class_type()
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index 9a3fb7c5f4f65..49f6b9200ff0a 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -7,10 +7,15 @@
 # https://doi.org/10.1007/978-0-387-34892-6_1
 # With extra optimizations
 
+from __future__ import annotations
+from typing import Union
 from ply.lex import lex
 from ply.yacc import yacc
 from .utils import not_implemented
 
+# Type alias for all LTL node types in the AST
+LTLNode = Union['BinaryOp', 'UnaryOp', 'Variable', 'Literal']
+
 # Grammar:
 # 	ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl
 #
@@ -152,15 +157,15 @@ class BinaryOp:
         yield from self.right
 
     @not_implemented
-    def normalize(self): ...
+    def normalize(self) -> BinaryOp: ...
 
     @not_implemented
-    def negate(self): ...
+    def negate(self) -> BinaryOp: ...
 
     @not_implemented
-    def _is_temporal(self): ...
+    def _is_temporal(self) -> bool: ...
 
-    def is_temporal(self):
+    def is_temporal(self) -> bool:
         if self.left.op.is_temporal():
             return True
         if self.right.op.is_temporal():
@@ -291,20 +296,20 @@ class UnaryOp:
         return hash(self.child)
 
     @not_implemented
-    def normalize(self):
+    def normalize(self) -> LTLNode:
         ...
 
     @not_implemented
-    def _is_temporal(self):
+    def _is_temporal(self) -> bool:
         ...
 
-    def is_temporal(self):
+    def is_temporal(self) -> bool:
         if self.child.op.is_temporal():
             return True
         return self._is_temporal()
 
     @not_implemented
-    def negate(self):
+    def negate(self) -> LTLNode:
         ...
 
 class EventuallyOp(UnaryOp):
@@ -386,14 +391,14 @@ class Variable:
     def __iter__(self):
         yield from ()
 
-    def negate(self):
+    def negate(self) -> NotOp:
         new = ASTNode(self)
         return NotOp(new)
 
-    def normalize(self):
+    def normalize(self) -> Variable:
         return self
 
-    def is_temporal(self):
+    def is_temporal(self) -> bool:
         return False
 
     @staticmethod
@@ -419,14 +424,14 @@ class Literal:
             return "true"
         return "false"
 
-    def negate(self):
+    def negate(self) -> Literal:
         self.value = not self.value
         return self
 
-    def normalize(self):
+    def normalize(self) -> Literal:
         return self
 
-    def is_temporal(self):
+    def is_temporal(self) -> bool:
         return False
 
     @staticmethod
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index f1eafc16c754b..44231aadb257c 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -68,7 +68,7 @@ class ltl2k(generator.Monitor):
         if not self.name:
             self.name = Path(file_path).stem
 
-    def _fill_states(self) -> str:
+    def _fill_states(self) -> list[str]:
         buf = [
             "enum ltl_buchi_state {",
         ]
-- 
2.52.0

