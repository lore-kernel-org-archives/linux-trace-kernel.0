Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09E2E92A2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856348; cv=none; b=oPvXZDZQf+SdfDM03cHozSd/AeT1ro3or+FVsIFXxc8XF37CF/nZHPcHDZ7M6BZ0pYZzieR13hRNHqOqhUcoGGYFsrdb3OFpwFpouxsYPWfzypfEDm0drk+FCZKJG1ws0Ip5x0XL6jgUiVaVC5u3Nsnnj/Xwg/ywHVOhhyG3mOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856348; c=relaxed/simple;
	bh=QGcDYSWhPw0OsaIiT/Y79JYcZvgnZ1aoQ9w1dCfTLhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPgKNPyhn/QKPkA+f8DijIzX5HgSkTX06ZUvoU8oLLoY58mgscVByqkpNOC62kfje2dEZJss+nqIltwws22pKZRFGCW1zJirVG2OP/y5sRJQHbGQCowDMytc6gYd/w/BSJEKs6duTibundkAIfsoeWB8lSeDetoxi/voe/i7TZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUPdMHkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUPdMHkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yha+RfJYjyXBlkSkTQNuex11nXIbAhRh6al57WlRycU=;
	b=ZUPdMHkmpu4nv9BcBe9pm+1OjXztl/KTH3G/qDDA2Uut6785OYxZiHIe41uRA9cP7G/DWV
	DA5hCiHfUpDYhTnpMBFWXlZdhSGV65oi3/7hodfHrnzs2QSZ8SNq93PuHq4Buf5wU4cMje
	54iTM0H9inLwo7GNEcGlQcoPfLSTSlM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-r816YAYpPQKmogDGZ0ExdA-1; Mon,
 19 Jan 2026 15:59:02 -0500
X-MC-Unique: r816YAYpPQKmogDGZ0ExdA-1
X-Mimecast-MFC-AGG-ID: r816YAYpPQKmogDGZ0ExdA_1768856341
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4522E1800378;
	Mon, 19 Jan 2026 20:59:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F17419560AB;
	Mon, 19 Jan 2026 20:58:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 01/26] rv/rvgen: introduce AutomataError exception class
Date: Mon, 19 Jan 2026 17:45:37 -0300
Message-ID: <20260119205601.105821-2-wander@redhat.com>
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

Replace generic Exception usage with a custom AutomataError class
that inherits from OSError throughout the rvgen tool. This change
provides more precise exception handling for automata parsing and
validation errors while avoiding overly broad exception catches that
could mask programming errors like SyntaxError or TypeError.

The AutomataError class inherits from OSError rather than Exception
because most error conditions involve file I/O operations such as
reading DOT files or handling file access issues. This semantic
alignment makes exception handling more specific and appropriate.
The exception is raised when DOT file processing fails due to invalid
format, I/O errors, or malformed automaton definitions.

Additionally, remove the broad try-except block from __main__.py that
was catching all exceptions. This allows Python's default exception
handling to provide complete stack traces, making debugging
significantly easier by showing exact error types and locations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/__main__.py        | 25 +++++++++------------
 tools/verification/rvgen/rvgen/automata.py  | 17 +++++++++-----
 tools/verification/rvgen/rvgen/dot2c.py     |  4 ++--
 tools/verification/rvgen/rvgen/generator.py |  7 ++----
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index fa6fc1f4de2f7..768b11a1e978b 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -39,22 +39,17 @@ if __name__ == '__main__':
 
     params = parser.parse_args()
 
-    try:
-        if params.subcmd == "monitor":
-            print("Opening and parsing the specification file %s" % params.spec)
-            if params.monitor_class == "da":
-                monitor = dot2k(params.spec, params.monitor_type, vars(params))
-            elif params.monitor_class == "ltl":
-                monitor = ltl2k(params.spec, params.monitor_type, vars(params))
-            else:
-                print("Unknown monitor class:", params.monitor_class)
-                sys.exit(1)
+    if params.subcmd == "monitor":
+        print("Opening and parsing the specification file %s" % params.spec)
+        if params.monitor_class == "da":
+            monitor = dot2k(params.spec, params.monitor_type, vars(params))
+        elif params.monitor_class == "ltl":
+            monitor = ltl2k(params.spec, params.monitor_type, vars(params))
         else:
-            monitor = Container(vars(params))
-    except Exception as e:
-        print('Error: '+ str(e))
-        print("Sorry : :-(")
-        sys.exit(1)
+            print("Unknown monitor class:", params.monitor_class)
+            sys.exit(1)
+    else:
+        monitor = Container(vars(params))
 
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index d9a3fe2b74bf2..8d88c3b65d00d 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -10,6 +10,13 @@
 
 import ntpath
 
+class AutomataError(OSError):
+    """Exception raised for errors in automata parsing and validation.
+
+    Raised when DOT file processing fails due to invalid format, I/O errors,
+    or malformed automaton definitions.
+    """
+
 class Automata:
     """Automata class: Reads a dot file and part it as an automata.
 
@@ -32,11 +39,11 @@ class Automata:
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
 
@@ -45,8 +52,8 @@ class Automata:
         dot_lines = []
         try:
             dot_file = open(self.__dot_path)
-        except:
-            raise Exception("Cannot open the file: %s" % self.__dot_path)
+        except OSError as exc:
+            raise AutomataError(f"Cannot open the file: {self.__dot_path}") from exc
 
         dot_lines = dot_file.read().splitlines()
         dot_file.close()
@@ -55,7 +62,7 @@ class Automata:
         line = dot_lines[cursor].split()
 
         if (line[0] != "digraph") and (line[1] != "state_automaton"):
-            raise Exception("Not a valid .dot format: %s" % self.__dot_path)
+            raise AutomataError("Not a valid .dot format: %s" % self.__dot_path)
         else:
             cursor += 1
         return dot_lines
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index b9b6f14cc536a..1a1770e7f20c0 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -13,7 +13,7 @@
 # For further information, see:
 #   Documentation/trace/rv/deterministic_automata.rst
 
-from .automata import Automata
+from .automata import Automata, AutomataError
 
 class Dot2c(Automata):
     enum_suffix = ""
@@ -93,7 +93,7 @@ class Dot2c(Automata):
             min_type = "unsigned int"
 
         if self.states.__len__() > 1000000:
-            raise Exception("Too many states: %d" % self.states.__len__())
+            raise AutomataError("Too many states: %d" % self.states.__len__())
 
         return min_type
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 3441385c11770..a7bee6b1ea70c 100644
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
-- 
2.52.0

