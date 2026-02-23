Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F73307494
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863938; cv=none; b=Tk0e4l65k6yVyeXpc2bpXl6cVVhUz/o3NODG/s1Wfqp9i4rpArWF6Sd8oMqmfS+Zjo72+pPT8+V0gy91guKSWWNpG408mhgqHV9VOZyNZXEJpEIhHiinKe+mrOPUO9YiVBLh1XFybx20C/xtsONgZFdqmAY9PYCdf3kwLyxB6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863938; c=relaxed/simple;
	bh=Ju+HDZuzf2pq5QYcTVsR1EkKfnFFhNanEAoVUoMXt+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DXFqCVuv1F0tVbR0VfGvD4Asv/HcycOZIf8wsAsaZEbv1rJsXCba4GGfdaLyJAqFw4Rk0+sRb7FbCXfahXIm93RS+fAkzeYP9T4DMdJFf4Iu0TG4sSB4rrp2IJseJ8UwmS2qBKAF3ZX6KQIRc4NihGuwauqAhw4ybr9QjUOkXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hO8TX7W4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO8TX7W4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771863935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=857XS0LLSd69kHZwdL6IntKG+3a4rRKFrejXsWKnDLM=;
	b=hO8TX7W4tfQqR7RgkTHWKix2ovGwMM1dIGUM5W19v4Fvc9zrXwEcMaknyNMNbL9w2pXKTG
	r9Ro70iL7e8Ci0zgk/TJkuaaRvKBjJgeetjwugx5dmwsf4o6bIcmsCFIehAf9pdNRqg/+g
	azwhpmw4qCWWavjJDE01efscFlTYxmI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-SueilCcqPU2vZxWZNQgnBg-1; Mon,
 23 Feb 2026 11:25:31 -0500
X-MC-Unique: SueilCcqPU2vZxWZNQgnBg-1
X-Mimecast-MFC-AGG-ID: SueilCcqPU2vZxWZNQgnBg_1771863930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 626E218002C4;
	Mon, 23 Feb 2026 16:25:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E6641800370;
	Mon, 23 Feb 2026 16:25:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/19] rv/rvgen: introduce AutomataError exception class
Date: Mon, 23 Feb 2026 13:17:44 -0300
Message-ID: <20260223162407.147003-2-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MBTWv96jCbQxaflurcqGI0WJxAk0hGYY5nXujOc27Cw_1771863930
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Replace the generic except Exception block with a custom AutomataError
class that inherits from Exception. This provides more precise exception
handling for automata parsing and validation errors while avoiding
overly broad exception catches that could mask programming errors like
SyntaxError or TypeError.

The AutomataError class is raised when DOT file processing fails due to
invalid format, I/O errors, or malformed automaton definitions. The
main entry point catches this specific exception and provides a
user-friendly error message to stderr before exiting.

Also, replace generic exceptions raising in HA and LTL with
AutomataError.

Co-authored-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/__main__.py        |  6 ++---
 tools/verification/rvgen/rvgen/automata.py  | 17 ++++++++++----
 tools/verification/rvgen/rvgen/dot2c.py     |  4 ++--
 tools/verification/rvgen/rvgen/dot2k.py     | 26 ++++++++++-----------
 tools/verification/rvgen/rvgen/generator.py |  7 ++----
 tools/verification/rvgen/rvgen/ltl2ba.py    |  9 +++----
 tools/verification/rvgen/rvgen/ltl2k.py     |  8 +++++--
 7 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 9a5a9f08eae21..5a3f090ac3316 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -13,6 +13,7 @@ if __name__ == '__main__':
     from rvgen.generator import Monitor
     from rvgen.container import Container
     from rvgen.ltl2k import ltl2k
+    from rvgen.automata import AutomataError
     import argparse
     import sys
 
@@ -55,9 +56,8 @@ if __name__ == '__main__':
                 sys.exit(1)
         else:
             monitor = Container(vars(params))
-    except Exception as e:
-        print('Error: '+ str(e))
-        print("Sorry : :-(")
+    except AutomataError as e:
+        print(f"There was an error processing {params.spec}: {e}", file=sys.stderr)
         sys.exit(1)
 
     print("Writing the monitor into the directory %s" % monitor.name)
diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 5c1c5597d839f..9cc452305a2aa 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -25,6 +25,13 @@ class _EventConstraintKey(_ConstraintKey, tuple):
     def __new__(cls, state_id: int, event_id: int):
         return super().__new__(cls, (state_id, event_id))
 
+class AutomataError(Exception):
+    """Exception raised for errors in automata parsing and validation.
+
+    Raised when DOT file processing fails due to invalid format, I/O errors,
+    or malformed automaton definitions.
+    """
+
 class Automata:
     """Automata class: Reads a dot file and part it as an automata.
 
@@ -72,11 +79,11 @@ class Automata:
         basename = ntpath.basename(self.__dot_path)
         if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
-            raise Exception("not a dot file: %s" % self.__dot_path)
+            raise AutomataError("not a dot file: %s" % self.__dot_path)
 
         model_name = ntpath.splitext(basename)[0]
         if model_name.__len__() == 0:
-            raise Exception("not a dot file: %s" % self.__dot_path)
+            raise AutomataError("not a dot file: %s" % self.__dot_path)
 
         return model_name
 
@@ -85,8 +92,8 @@ class Automata:
         dot_lines = []
         try:
             dot_file = open(self.__dot_path)
-        except:
-            raise Exception("Cannot open the file: %s" % self.__dot_path)
+        except OSError as exc:
+            raise AutomataError(exc.strerror) from exc
 
         dot_lines = dot_file.read().splitlines()
         dot_file.close()
@@ -95,7 +102,7 @@ class Automata:
         line = dot_lines[cursor].split()
 
         if (line[0] != "digraph") and (line[1] != "state_automaton"):
-            raise Exception("Not a valid .dot format: %s" % self.__dot_path)
+            raise AutomataError("Not a valid .dot format: %s" % self.__dot_path)
         else:
             cursor += 1
         return dot_lines
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index f779d9528af3f..6878cc79e6f70 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -13,7 +13,7 @@
 # For further information, see:
 #   Documentation/trace/rv/deterministic_automata.rst
 
-from .automata import Automata
+from .automata import Automata, AutomataError
 
 class Dot2c(Automata):
     enum_suffix = ""
@@ -103,7 +103,7 @@ class Dot2c(Automata):
             min_type = "unsigned int"
 
         if self.states.__len__() > 1000000:
-            raise Exception("Too many states: %d" % self.states.__len__())
+            raise AutomataError("Too many states: %d" % self.states.__len__())
 
         return min_type
 
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e7ba68a54c1f8..55222e38323f5 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -11,7 +11,7 @@
 from collections import deque
 from .dot2c import Dot2c
 from .generator import Monitor
-from .automata import _EventConstraintKey, _StateConstraintKey
+from .automata import _EventConstraintKey, _StateConstraintKey, AutomataError
 
 
 class dot2k(Monitor, Dot2c):
@@ -166,14 +166,14 @@ class da2k(dot2k):
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         if self.is_hybrid_automata():
-            raise ValueError("Detected hybrid automata, use the 'ha' class")
+            raise AutomataError("Detected hybrid automata, use the 'ha' class")
 
 class ha2k(dot2k):
     """Hybrid automata only"""
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         if not self.is_hybrid_automata():
-            raise ValueError("Detected deterministic automata, use the 'da' class")
+            raise AutomataError("Detected deterministic automata, use the 'da' class")
         self.trace_h = self._read_template_file("trace_hybrid.h")
         self.__parse_constraints()
 
@@ -266,22 +266,22 @@ class ha2k(dot2k):
         # state constraints are only used for expirations (e.g. clk<N)
         if self.is_event_constraint(key):
             if not rule and not reset:
-                raise ValueError("Unrecognised event constraint "
-                                 f"({self.states[key[0]]}/{self.events[key[1]]}: {constr})")
+                raise AutomataError("Unrecognised event constraint "
+                                    f"({self.states[key[0]]}/{self.events[key[1]]}: {constr})")
             if rule and (rule["env"] in self.env_types and
                          rule["env"] not in self.env_stored):
-                raise ValueError("Clocks in hybrid automata always require a storage"
-                                 f" ({rule["env"]})")
+                raise AutomataError("Clocks in hybrid automata always require a storage"
+                                    f" ({rule["env"]})")
         else:
             if not rule:
-                raise ValueError("Unrecognised state constraint "
-                                 f"({self.states[key]}: {constr})")
+                raise AutomataError("Unrecognised state constraint "
+                                    f"({self.states[key]}: {constr})")
             if rule["env"] not in self.env_stored:
-                raise ValueError("State constraints always require a storage "
-                                 f"({rule["env"]})")
+                raise AutomataError("State constraints always require a storage "
+                                    f"({rule["env"]})")
             if rule["op"] not in ["<", "<="]:
-                raise ValueError("State constraints must be clock expirations like"
-                                 f" clk<N ({rule.string})")
+                raise AutomataError("State constraints must be clock expirations like"
+                                    f" clk<N ({rule.string})")
 
     def __parse_constraints(self) -> None:
         self.guards: dict[_EventConstraintKey, str] = {}
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 5eac12e110dce..571093a92bdc8 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -51,10 +51,7 @@ class RVGenerator:
         raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
 
     def _read_file(self, path):
-        try:
-            fd = open(path, 'r')
-        except OSError:
-            raise Exception("Cannot open the file: %s" % path)
+        fd = open(path, 'r')
 
         content = fd.read()
 
@@ -65,7 +62,7 @@ class RVGenerator:
         try:
             path = os.path.join(self.abs_template_dir, file)
             return self._read_file(path)
-        except Exception:
+        except OSError:
             # Specific template file not found. Try the generic template file in the template/
             # directory, which is one level up
             path = os.path.join(self.abs_template_dir, "..", file)
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index f14e6760ac3db..f9855dfa3bc1c 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -9,6 +9,7 @@
 
 from ply.lex import lex
 from ply.yacc import yacc
+from .automata import AutomataError
 
 # Grammar:
 # 	ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl
@@ -62,7 +63,7 @@ t_ignore_COMMENT = r'\#.*'
 t_ignore = ' \t\n'
 
 def t_error(t):
-    raise ValueError(f"Illegal character '{t.value[0]}'")
+    raise AutomataError(f"Illegal character '{t.value[0]}'")
 
 lexer = lex()
 
@@ -487,7 +488,7 @@ def p_unop(p):
     elif p[1] == "not":
         op = NotOp(p[2])
     else:
-        raise ValueError(f"Invalid unary operator {p[1]}")
+        raise AutomataError(f"Invalid unary operator {p[1]}")
 
     p[0] = ASTNode(op)
 
@@ -507,7 +508,7 @@ def p_binop(p):
     elif p[2] == "imply":
         op = ImplyOp(p[1], p[3])
     else:
-        raise ValueError(f"Invalid binary operator {p[2]}")
+        raise AutomataError(f"Invalid binary operator {p[2]}")
 
     p[0] = ASTNode(op)
 
@@ -526,7 +527,7 @@ def parse_ltl(s: str) -> ASTNode:
             subexpr[assign[0]] = assign[1]
 
     if rule is None:
-        raise ValueError("Please define your specification in the \"RULE = <LTL spec>\" format")
+        raise AutomataError("Please define your specification in the \"RULE = <LTL spec>\" format")
 
     for node in rule:
         if not isinstance(node.op, Variable):
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index b075f98d50c47..08ad245462e7d 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -4,6 +4,7 @@
 from pathlib import Path
 from . import generator
 from . import ltl2ba
+from .automata import AutomataError
 
 COLUMN_LIMIT = 100
 
@@ -60,8 +61,11 @@ class ltl2k(generator.Monitor):
         if MonitorType != "per_task":
             raise NotImplementedError("Only per_task monitor is supported for LTL")
         super().__init__(extra_params)
-        with open(file_path) as f:
-            self.atoms, self.ba, self.ltl = ltl2ba.create_graph(f.read())
+        try:
+            with open(file_path) as f:
+                self.atoms, self.ba, self.ltl = ltl2ba.create_graph(f.read())
+        except OSError as exc:
+            raise AutomataError(exc.strerror) from exc
         self.atoms_abbr = abbreviate_atoms(self.atoms)
         self.name = extra_params.get("model_name")
         if not self.name:
-- 
2.53.0

