Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472029D288
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856545; cv=none; b=fOs/CNSEfy8Y2sybmVE8g1ETiiZLti5DZFfli/OznPCWLi/SY5SN+u09wdxQAX05T2YI1qVLRUjd1U78LjcOXJv1T1/UvmA3g5HGzi3tZ4hBZjKKoCBQ7r5kwxQVeHy41freLiRbd4y6oDsdQ2EBgu7VC9msb97K2ya8sYZfrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856545; c=relaxed/simple;
	bh=3HxFQxxM6vktqQVICPtcfplyEe4QMmkt2BlQS319ws8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1dVPUOH7Z+wGcaVqATBENQSZyvI/1Y0kfxEgB8D9Pqb9V1uJ3IooOxX838pCz0lK54ktcm2qJJIRq8XT2+Yf0wpgZJrl4RlWWhAOEGMxUoS9ZIs5H9HNpQdswoGJ3wDkfwYxMi2Gu1RJgSIDGw9lmcSN3ZFdrF1kmFP5ukCFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBSwNL7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBSwNL7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QclBMzOHMQQ11XlfMLU94W1QkzKCUIDDZpVOzdcTRns=;
	b=SBSwNL7LuwhhkeBtDjou0NwAO/uWk+08dhbgCYh+H+pvd+c586uOHG6bxb+WNiPS9xehSU
	VIpy9cgsWNDZRfW2pLdiJQR6KHYCxmjAkP0V8YAU50l0Bu2Tf34mPOC/ts5gA/dYykICG6
	cndvrWJLpcJv7JjLGQF8rr3qE8IVpYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-1mJTTBGFPGqHDCraGtk9DQ-1; Mon,
 19 Jan 2026 16:02:19 -0500
X-MC-Unique: 1mJTTBGFPGqHDCraGtk9DQ-1
X-Mimecast-MFC-AGG-ID: 1mJTTBGFPGqHDCraGtk9DQ_1768856538
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BD18195609E;
	Mon, 19 Jan 2026 21:02:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E328619560AB;
	Mon, 19 Jan 2026 21:02:15 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 09/26] rv/rvgen: replace inline NotImplemented with decorator
Date: Mon, 19 Jan 2026 17:45:45 -0300
Message-ID: <20260119205601.105821-10-wander@redhat.com>
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

Replace inline NotImplementedError raises with a dedicated decorator in
the ltl2ba module. The previous implementation used explicit raise
statements inside abstract method bodies for BinaryOp and UnaryOp
classes, which required maintaining identical boilerplate across seven
different methods that need to be overridden by subclasses.

All stub methods in generator.py have been converted from returning
strings to using the decorator with ellipsis function bodies, which
is the recommended Python style for marking incomplete interface
methods. This ensures that any attempt to use unimplemented
functionality fails fast with a clear exception rather than silently
propagating string values through the code.

The new @not_implemented decorator consolidates this pattern into a
single reusable definition that clearly marks abstract methods while
reducing code duplication. The decorator creates a wrapper that raises
NotImplementedError with the function name, providing the same runtime
behavior with improved maintainability. Method bodies now use the
ellipsis literal instead of pass statements, which is the preferred
Python convention for stub methods according to PEP 8.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 29 +++++++++--------
 tools/verification/rvgen/rvgen/ltl2ba.py    | 25 ++++++++------
 tools/verification/rvgen/rvgen/utils.py     | 36 +++++++++++++++++++++
 3 files changed, 66 insertions(+), 24 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/utils.py

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index ee75e111feef1..fc9be5f6aaa1f 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -7,6 +7,7 @@
 
 import platform
 import os
+from .utils import not_implemented
 
 
 class RVGenerator:
@@ -73,14 +74,14 @@ class RVGenerator:
             return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
         return ""
 
-    def fill_tracepoint_handlers_skel(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_tracepoint_handlers_skel(self): ...
 
-    def fill_tracepoint_attach_probe(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_tracepoint_attach_probe(self): ...
 
-    def fill_tracepoint_detach_helper(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_tracepoint_detach_helper(self): ...
 
     def fill_main_c(self):
         main_c = self.main_c
@@ -100,17 +101,17 @@ class RVGenerator:
 
         return main_c
 
-    def fill_model_h(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_model_h(self): ...
 
-    def fill_monitor_class_type(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_monitor_class_type(self): ...
 
-    def fill_monitor_class(self):
-        return "NotImplemented"
+    @not_implemented
+    def fill_monitor_class(self): ...
 
-    def fill_tracepoint_args_skel(self, tp_type):
-        return "NotImplemented"
+    @not_implemented
+    def fill_tracepoint_args_skel(self, tp_type): ...
 
     def fill_monitor_deps(self):
         buff = []
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index f14e6760ac3db..9a3fb7c5f4f65 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -9,6 +9,7 @@
 
 from ply.lex import lex
 from ply.yacc import yacc
+from .utils import not_implemented
 
 # Grammar:
 # 	ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl
@@ -150,14 +151,14 @@ class BinaryOp:
         yield from self.left
         yield from self.right
 
-    def normalize(self):
-        raise NotImplementedError
+    @not_implemented
+    def normalize(self): ...
 
-    def negate(self):
-        raise NotImplementedError
+    @not_implemented
+    def negate(self): ...
 
-    def _is_temporal(self):
-        raise NotImplementedError
+    @not_implemented
+    def _is_temporal(self): ...
 
     def is_temporal(self):
         if self.left.op.is_temporal():
@@ -167,8 +168,9 @@ class BinaryOp:
         return self._is_temporal()
 
     @staticmethod
+    @not_implemented
     def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
-        raise NotImplementedError
+        ...
 
 class AndOp(BinaryOp):
     op_str = '&&'
@@ -288,19 +290,22 @@ class UnaryOp:
     def __hash__(self):
         return hash(self.child)
 
+    @not_implemented
     def normalize(self):
-        raise NotImplementedError
+        ...
 
+    @not_implemented
     def _is_temporal(self):
-        raise NotImplementedError
+        ...
 
     def is_temporal(self):
         if self.child.op.is_temporal():
             return True
         return self._is_temporal()
 
+    @not_implemented
     def negate(self):
-        raise NotImplementedError
+        ...
 
 class EventuallyOp(UnaryOp):
     def __str__(self):
diff --git a/tools/verification/rvgen/rvgen/utils.py b/tools/verification/rvgen/rvgen/utils.py
new file mode 100644
index 0000000000000..e09c943693edf
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/utils.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+
+def not_implemented(func):
+    """
+    Decorator to mark functions as not yet implemented.
+
+    This decorator wraps a function and raises a NotImplementedError when the
+    function is called, rather than executing the function body. This is useful
+    for defining interface methods or placeholder functions that need to be
+    implemented later.
+
+    Args:
+        func: The function to be wrapped.
+
+    Returns:
+        A wrapper function that raises NotImplementedError when called.
+
+    Raises:
+        NotImplementedError: Always raised when the decorated function is called.
+            The exception includes the function name and any arguments that were
+            passed to the function.
+
+    Example:
+        @not_implemented
+        def future_feature(arg1, arg2):
+            pass
+
+        # Calling future_feature will raise:
+        # NotImplementedError('future_feature', arg1_value, arg2_value)
+    """
+    def inner(*args, **kwargs):
+        raise NotImplementedError(func.__name__, *args, **kwargs)
+
+    return inner
-- 
2.52.0

