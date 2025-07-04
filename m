Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17A2FD58B;
	Fri,  4 Jul 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635239; cv=none; b=jb+1IIo9mi+D/PAiAhy0i7vOQabvoxkk+LQsX0l8pkRXUAds6AoObfAdP71GSp9Q8jquvjXJmF72E+tpC4k5orlJxttxp1dRPPIhHKzdCSospkD1H9zVLB/5+yc1er+wrFQsUHcYncQlC04Lypz/ncUleidfoU/4F3hLDAkm3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635239; c=relaxed/simple;
	bh=x17mpZ7sX8jAXa8NPlj8BPti3RdNXLLznHqcgpSPNLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nu9L6Vi0x3ug1X13OQLIGX0KEdmqgdzoNZkEcORQnSKwYrA05aCGySgUaQBjsmrMfBmRaJKgAd0bCvLnUIPPPIDwfL6ahapuiQZBywKwTcugDPszlRZBj2awD0ax59XVkcdep5z/Is10SGEGCQz80Uzy6zxfSdP294kIy9ko2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06q8BPFr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWI4I1Ez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06q8BPFr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWI4I1Ez"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqpK2ecQogzE/riTbJrIMj4alR3/q81koVHuN2ddxBw=;
	b=06q8BPFrHfzmSrunU0jHkXdzcd/OEM2gdigNj4+kvwCsDz1mM2/g3LK/BlJc/D71doVTzt
	TtvepcT5F+tjXbB8nkQzyDckrRPDpXy1Piv2m991lnYnvRcQIp8/r/L9pVP7ch7iNR8rHG
	Q9tNPbwvhDomIlmsUhztkTzLxaFzFIkTyReU7tbATEUOm/PXgGEVKYVvRqzi3McEUqTHXW
	9rw3Fw6clo4i/h4H9l6Vd/d0d47faT890MYJPAryaq3SqvyLVxtd7gd55emVcmf7az2kNH
	mUXUHl+hOOEDyJUZWMgiVT2nAbZJTp2hOi1bR2S76QNA720YMHfPZHk0kVdKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqpK2ecQogzE/riTbJrIMj4alR3/q81koVHuN2ddxBw=;
	b=DWI4I1Ezr4dRtYipBf6/AX1OXmXrdrzKFX53WszSF6+b3btp/btv5e7Y1Y6fMqp48DL5eh
	UrQLPDa5Oyx1HpDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 09/21] verification/dot2k: Prepare the frontend for LTL inclusion
Date: Fri,  4 Jul 2025 15:20:01 +0200
Message-Id: <dea18f7a44374e4db8df5c7e785604bc3062ffc9.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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

  python3 rvgen monitor -c da -s wip.dot -t per_cpu

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
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

