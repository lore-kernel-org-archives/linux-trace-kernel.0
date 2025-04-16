Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FC22D4E6;
	Wed, 16 Apr 2025 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786325; cv=none; b=T0emXKgKXye843Q0EV1u69yGOuzIUgVM27q1cYAYDf7W5rn3++uK6p1eGg0X6UiUBIZOUdWXyv/BZAXjVJ67dbG0FdVRwLv6fBksh3Mf3U0kYgyf5pRN3hn8L+xm58cVNUDJbHpJdxWdHMc91/VA1VV9lWTD8mBiP++py6vUPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786325; c=relaxed/simple;
	bh=eenegdr4lJSL0yUQq2qJyCYn3/YSdBcRThcl+HprxGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUbmKrDAr/u6dckgcCeRbovSzZIgqXlNxIGTXP3yIR44oee8vDBQo+NVGk9/Xo7ZwEcwF3ltLJEGC9+GZjUphut5GVpMKl8btEC5YTyPT5r5owkoqMzqIcrwv44S1WIsYX+wlvQjtk17Q2TdS327WtDgKpCZ0YqIDSDUZuBi1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOiMp5AG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iiVl+Q/V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOiMp5AG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iiVl+Q/V"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7qp1cP58yQl3F7g0DY29H1iLOHUTNrE+EncFg9K470=;
	b=dOiMp5AGK2rRlLnJ9ZhTa21Q9/ZuSlc5518tDo1Ow27VFFhfTgV4UuWXzThRKNAjBbywdN
	ZxUo5xGIYpstXpbeNm+v8HH1+pRp2igLwTRn3+vzbDje1aLvLl7j6w5eMNZY4IKdhGMkCq
	Hb9TM8RgGHC9fffA9F95aftHKpGtT6gt/fHvY/+j8BeIWtRvrpGXQ8J1ChpVgAXcCNzjsr
	4Q0x4Tc9+zR2YD8itha4tpWKncePIv3wS8sEf9y3svm9legskklRetiasPGEqFXOm8CYq8
	fvpgM+249DNI8x8Qn4t1kQuKqa9KvXFj/F/FCjavUYXKcNmaRHy9hyTdSMeNeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7qp1cP58yQl3F7g0DY29H1iLOHUTNrE+EncFg9K470=;
	b=iiVl+Q/VfbQQTUSGztr+SmQHVxubdisvetMmX3yGExTDQGJvWIJIANnkNX8S5IAdsIet3S
	vaUP4u101hw93SAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 09/22] verification/dot2k: Prepare the frontend for LTL inclusion
Date: Wed, 16 Apr 2025 08:51:15 +0200
Message-Id: <af31461eae544f9aea6fb3e1c16a0bd24574ef56.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The dot2k tool has some code that can be reused for linear temporal logic
monitor. Prepare its frontend for LTL inclusion:

  1. Rename to be generic: rvgen

  2. Replace the parameter --dot with 2 parameters:
     --class: to specific the monitor class, can be 'da' or 'ltl'
     --spec: the monitor specification file, .dot file for DA, and .ltl
             file for LTL

The old command:

  python3 dot2/dot2k monitor -d wip.dot -t per_cpu

is equivalent to the new commands:

  python3 dot2/dot2k monitor -c da -s wip.dot -t per_cpu

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/{dot2 =3D> rvgen}/Makefile    | 10 +++++-----
 .../{dot2/dot2k =3D> rvgen/__main__.py}          | 18 +++++++++++++-----
 tools/verification/{dot2 =3D> rvgen}/dot2c       |  2 +-
 .../{dot2 =3D> rvgen}/dot2k_templates/Kconfig    |  0
 .../dot2k_templates/Kconfig_container          |  0
 .../{dot2 =3D> rvgen}/dot2k_templates/main.c     |  0
 .../dot2k_templates/main_container.c           |  0
 .../dot2k_templates/main_container.h           |  0
 .../{dot2 =3D> rvgen}/dot2k_templates/trace.h    |  0
 .../{dot2 =3D> rvgen/rvgen}/automata.py          |  0
 .../{dot2 =3D> rvgen/rvgen}/dot2c.py             |  2 +-
 .../{dot2 =3D> rvgen/rvgen}/dot2k.py             | 10 +++++-----
 12 files changed, 25 insertions(+), 17 deletions(-)
 rename tools/verification/{dot2 =3D> rvgen}/Makefile (55%)
 rename tools/verification/{dot2/dot2k =3D> rvgen/__main__.py} (72%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2c (97%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/Kconfig (100%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/Kconfig_contai=
ner (100%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/main.c (100%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/main_container=
.c (100%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/main_container=
.h (100%)
 rename tools/verification/{dot2 =3D> rvgen}/dot2k_templates/trace.h (100%)
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/automata.py (100%)
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/dot2c.py (99%)
 rename tools/verification/{dot2 =3D> rvgen/rvgen}/dot2k.py (98%)

diff --git a/tools/verification/dot2/Makefile b/tools/verification/rvgen/Ma=
kefile
similarity index 55%
rename from tools/verification/dot2/Makefile
rename to tools/verification/rvgen/Makefile
index 021beb07a521..cea9c21c3bce 100644
--- a/tools/verification/dot2/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -3,7 +3,7 @@ INSTALL=3Dinstall
 prefix  ?=3D /usr
 bindir  ?=3D $(prefix)/bin
 mandir  ?=3D $(prefix)/share/man
-miscdir ?=3D $(prefix)/share/dot2
+miscdir ?=3D $(prefix)/share/rvgen
 srcdir  ?=3D $(prefix)/src
=20
 PYLIB  ?=3D $(shell python3 -c 'import sysconfig;  print (sysconfig.get_pa=
th("purelib"))')
@@ -16,11 +16,11 @@ clean:
=20
 .PHONY: install
 install:
-	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
-	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
+	$(INSTALL) rvgen/automata.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/automata.=
py
+	$(INSTALL) rvgen/dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
-	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
-	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
+	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
+	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
=20
 	mkdir -p ${miscdir}/
 	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
diff --git a/tools/verification/dot2/dot2k b/tools/verification/rvgen/__mai=
n__.py
similarity index 72%
rename from tools/verification/dot2/dot2k
rename to tools/verification/rvgen/__main__.py
index 133fb17d9d47..994d320ad2d1 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/rvgen/__main__.py
@@ -9,11 +9,11 @@
 #   Documentation/trace/rv/da_monitor_synthesis.rst
=20
 if __name__ =3D=3D '__main__':
-    from dot2.dot2k import dot2k
+    from rvgen.dot2k import dot2k
     import argparse
     import sys
=20
-    parser =3D argparse.ArgumentParser(description=3D'transform .dot file =
into kernel rv monitor')
+    parser =3D argparse.ArgumentParser(description=3D'Generate kernel rv m=
onitor')
     parser.add_argument("-D", "--description", dest=3D"description", requi=
red=3DFalse)
     parser.add_argument("-a", "--auto_patch", dest=3D"auto_patch",
                         action=3D"store_true", required=3DFalse,
@@ -25,7 +25,9 @@ if __name__ =3D=3D '__main__':
     monitor_parser.add_argument('-n', "--model_name", dest=3D"model_name")
     monitor_parser.add_argument("-p", "--parent", dest=3D"parent",
                                 required=3DFalse, help=3D"Create a monitor=
 nested to parent")
-    monitor_parser.add_argument('-d', "--dot", dest=3D"dot_file")
+    monitor_parser.add_argument('-c', "--class", dest=3D"monitor_class",
+                                help=3D"Monitor class, either \"da\" or \"=
ltl\"")
+    monitor_parser.add_argument('-s', "--spec", dest=3D"spec", help=3D"Mon=
itor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest=3D"monitor_ty=
pe",
                                 help=3Df"Available options: {', '.join(dot=
2k.monitor_types.keys())}")
=20
@@ -36,8 +38,14 @@ if __name__ =3D=3D '__main__':
=20
     try:
         if params.subcmd =3D=3D "monitor":
-            print("Opening and parsing the dot file %s" % params.dot_file)
-            monitor =3D dot2k(params.dot_file, params.monitor_type, vars(p=
arams))
+            print("Opening and parsing the specification file %s" % params=
.spec)
+            if params.monitor_class =3D=3D "da":
+                monitor =3D dot2k(params.spec, params.monitor_type, vars(p=
arams))
+            elif params.monitor_class =3D=3D "ltl":
+                raise NotImplementedError
+            else:
+                print("Unknown monitor class:", params.monitor_class)
+                sys.exit(1)
         else:
             monitor =3D dot2k(None, None, vars(params))
     except Exception as e:
diff --git a/tools/verification/dot2/dot2c b/tools/verification/rvgen/dot2c
similarity index 97%
rename from tools/verification/dot2/dot2c
rename to tools/verification/rvgen/dot2c
index 3fe89ab88b65..bf0c67c5b66c 100644
--- a/tools/verification/dot2/dot2c
+++ b/tools/verification/rvgen/dot2c
@@ -14,7 +14,7 @@
 #   Documentation/trace/rv/deterministic_automata.rst
=20
 if __name__ =3D=3D '__main__':
-    from dot2 import dot2c
+    from rvgen import dot2c
     import argparse
     import sys
=20
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verifi=
cation/rvgen/dot2k_templates/Kconfig
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/Kconfig
rename to tools/verification/rvgen/dot2k_templates/Kconfig
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig_container b/to=
ols/verification/rvgen/dot2k_templates/Kconfig_container
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/Kconfig_container
rename to tools/verification/rvgen/dot2k_templates/Kconfig_container
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verific=
ation/rvgen/dot2k_templates/main.c
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main.c
rename to tools/verification/rvgen/dot2k_templates/main.c
diff --git a/tools/verification/dot2/dot2k_templates/main_container.c b/too=
ls/verification/rvgen/dot2k_templates/main_container.c
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main_container.c
rename to tools/verification/rvgen/dot2k_templates/main_container.c
diff --git a/tools/verification/dot2/dot2k_templates/main_container.h b/too=
ls/verification/rvgen/dot2k_templates/main_container.h
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main_container.h
rename to tools/verification/rvgen/dot2k_templates/main_container.h
diff --git a/tools/verification/dot2/dot2k_templates/trace.h b/tools/verifi=
cation/rvgen/dot2k_templates/trace.h
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/trace.h
rename to tools/verification/rvgen/dot2k_templates/trace.h
diff --git a/tools/verification/dot2/automata.py b/tools/verification/rvgen=
/rvgen/automata.py
similarity index 100%
rename from tools/verification/dot2/automata.py
rename to tools/verification/rvgen/rvgen/automata.py
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/rvgen/rv=
gen/dot2c.py
similarity index 99%
rename from tools/verification/dot2/dot2c.py
rename to tools/verification/rvgen/rvgen/dot2c.py
index fa2816ac7b61..6009caf568d9 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -13,7 +13,7 @@
 # For further information, see:
 #   Documentation/trace/rv/deterministic_automata.rst
=20
-from dot2.automata import Automata
+from .automata import Automata
=20
 class Dot2c(Automata):
     enum_suffix =3D ""
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/rvgen/rv=
gen/dot2k.py
similarity index 98%
rename from tools/verification/dot2/dot2k.py
rename to tools/verification/rvgen/rvgen/dot2k.py
index 9ec99e297012..e29462413194 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -8,13 +8,13 @@
 # For further information, see:
 #   Documentation/trace/rv/da_monitor_synthesis.rst
=20
-from dot2.dot2c import Dot2c
+from .dot2c import Dot2c
 import platform
 import os
=20
 class dot2k(Dot2c):
     monitor_types =3D { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir =3D "dot2/dot2k_templates/"
+    monitor_templates_dir =3D "rvgen/dot2k_templates/"
     rv_dir =3D "kernel/trace/rv"
     monitor_type =3D "per_cpu"
=20
@@ -60,14 +60,14 @@ class dot2k(Dot2c):
         if platform.system() !=3D "Linux":
             raise OSError("I can only run on Linux.")
=20
-        kernel_path =3D "/lib/modules/%s/build/tools/verification/dot2/dot=
2k_templates/" % (platform.release())
+        kernel_path =3D "/lib/modules/%s/build/tools/verification/rvgen/do=
t2k_templates/" % (platform.release())
=20
         if os.path.exists(kernel_path):
             self.monitor_templates_dir =3D kernel_path
             return
=20
-        if os.path.exists("/usr/share/dot2/dot2k_templates/"):
-            self.monitor_templates_dir =3D "/usr/share/dot2/dot2k_template=
s/"
+        if os.path.exists("/usr/share/rvgen/dot2k_templates/"):
+            self.monitor_templates_dir =3D "/usr/share/rvgen/dot2k_templat=
es/"
             return
=20
         raise FileNotFoundError("Could not find the template directory, do=
 you have the kernel source installed?")
--=20
2.39.5

