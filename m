Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866C2C374D;
	Tue, 29 Apr 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928100; cv=none; b=naGdNgdqlUHM7yXBFxO8wux8amU5FPQyD6CpLSossZG0OppE6cgZkjiBcVzF+X5uwgsUHluUvqC9x9+aAb6MqJn6PdUE2O9EfHRXy5VjlMddjXLdhkojBsSkj8MvnC19jc7y1mhsV7AOy9cAnjV7EbLP66yYpSjjgtrNrGJ7K0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928100; c=relaxed/simple;
	bh=BlA6PQqIv5pTwbg7B8FRT8nV5ZlN/yyEq5hrwhrDLLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRA2WxnRzS1U2nDtALjoU8c4HhoKTpdHG2oOmHCK4SaAyeeE6Qts9ChcJmz2ilgbyF08KcHXDN3n+GOTbvTEd7Oiix9bYtjD3mHf/Zxj6A7ehLsHyY0rCuhY/yuyWTloc5vUV+IBl6Us4JFK/tPPp+VFDYNtYvEQV+ABrovuNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6CTM7/d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6s2HTJa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6CTM7/d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6s2HTJa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+RNWYu1SgSahorf/z3esUDvCmO80tzytOTkrZJG51I=;
	b=N6CTM7/deEYwBkDgyTNqOA1e0R34sFR0pukXV5gIoNcT03bNDLzpTQAQPJWr4caGmqmHa7
	YAB+1dOly/hrWi93O75xr7/HwSo/CWclS2h9MKUhARdExllEoxlbKJr2+5bHnfnWM1RUp0
	YzfjlDTFmEm+531NZRwoIG582Guy49v4/gx/ShzjfG85x+qqJSHlP717ItNEjT/NfuOT/W
	Q6ATCQj2pSrFeAkLEpx7qnv7eNBmgURePQAwCNPvAjiWjR9SDelPSkqWhzjMjj18j3ILun
	58UvHihTLh8L20aO5h+OL5uBNK6Rt0L5qQ69A3zbRaPE/M4nQa2HnFGndOkI2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+RNWYu1SgSahorf/z3esUDvCmO80tzytOTkrZJG51I=;
	b=A6s2HTJa1Sy2QSyqg4J0BWcceZnkSoepqrOilVY9YFO2bGdm+x/kcxgmoAgnFSg9m0FJNp
	NfwQo5dRsY1AI4Dw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v5 12/23] verification/rvgen: Restructure the classes to prepare for LTL inclusion
Date: Tue, 29 Apr 2025 14:00:57 +0200
Message-Id: <aca4baa61a23c02a3a15b798b751252811b33030.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Both container generation and DA monitor generation is implemented in the
class dot2k. That requires some ugly "if is_container ... else ...". If
linear temporal logic support is added at the current state, the "if else"
chain is longer and uglier.

Furthermore, container generation is irrevelant to .dot files. It is
therefore illogical to be implemented in class "dot2k".

Clean it up, restructure the dot2k class into the following class
hierarchy:

         (RVGenerator)
              /\
             /  \
            /    \
           /      \
          /        \
    (Container)  (Monitor)
                    /\
                   /  \
                  /    \
                 /      \
              (dot2k)  [ltl2k] <- intended

This allows a simple and clean integration of LTL.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/Makefile           |   2 +
 tools/verification/rvgen/__main__.py        |   6 +-
 tools/verification/rvgen/rvgen/container.py |  22 ++
 tools/verification/rvgen/rvgen/dot2k.py     | 275 ++------------------
 tools/verification/rvgen/rvgen/generator.py | 264 +++++++++++++++++++
 5 files changed, 308 insertions(+), 261 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 create mode 100644 tools/verification/rvgen/rvgen/generator.py

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/M=
akefile
index 8d08825e7e54..cca8c9ba82e8 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -19,5 +19,7 @@ install:
 	$(INSTALL) rvgen/dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
+	$(INSTALL) rvgen/container.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/containe=
r.py
+	$(INSTALL) rvgen/generator.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/generato=
r.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
 	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvge=
n/__main__.py
index 994d320ad2d1..63ecf0c37034 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -10,6 +10,8 @@
=20
 if __name__ =3D=3D '__main__':
     from rvgen.dot2k import dot2k
+    from rvgen.generator import Monitor
+    from rvgen.container import Container
     import argparse
     import sys
=20
@@ -29,7 +31,7 @@ if __name__ =3D=3D '__main__':
                                 help=3D"Monitor class, either \"da\" or \"=
ltl\"")
     monitor_parser.add_argument('-s', "--spec", dest=3D"spec", help=3D"Mon=
itor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest=3D"monitor_ty=
pe",
-                                help=3Df"Available options: {', '.join(dot=
2k.monitor_types.keys())}")
+                                help=3Df"Available options: {', '.join(Mon=
itor.monitor_types.keys())}")
=20
     container_parser =3D subparsers.add_parser("container")
     container_parser.add_argument('-n', "--model_name", dest=3D"model_name=
", required=3DTrue)
@@ -47,7 +49,7 @@ if __name__ =3D=3D '__main__':
                 print("Unknown monitor class:", params.monitor_class)
                 sys.exit(1)
         else:
-            monitor =3D dot2k(None, None, vars(params))
+            monitor =3D Container(vars(params))
     except Exception as e:
         print('Error: '+ str(e))
         print("Sorry : :-(")
diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verificati=
on/rvgen/rvgen/container.py
new file mode 100644
index 000000000000..47d8ab2ad3ec
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -0,0 +1,22 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristo=
t@kernel.org>
+#
+# Generator for runtime verification monitor container
+
+from . import generator
+
+
+class Container(generator.RVGenerator):
+    template_dir =3D "container"
+
+    def __init__(self, extra_params=3D{}):
+        super().__init__(extra_params)
+        self.name =3D extra_params.get("model_name")
+        self.main_h =3D self._read_template_file("main.h")
+
+    def fill_model_h(self):
+        main_h =3D self.main_h
+        main_h =3D main_h.replace("%%MODEL_NAME%%", self.name)
+        return main_h
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index a9ed97d0b224..ed0a3c901106 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -9,108 +9,21 @@
 #   Documentation/trace/rv/da_monitor_synthesis.rst
=20
 from .dot2c import Dot2c
-import platform
-import os
+from .generator import Monitor
=20
-class dot2k(Dot2c):
-    monitor_types =3D { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    rv_dir =3D "kernel/trace/rv"
-    monitor_type =3D "per_cpu"
=20
-    def __init__(self, file_path, MonitorType, extra_params=3D{}):
-        self.container =3D extra_params.get("subcmd") =3D=3D "container"
-        self.parent =3D extra_params.get("parent")
-        if self.container:
-            self.abs_template_dir =3D os.path.join(os.path.dirname(__file_=
_), "templates/container")
-        else:
-            self.abs_template_dir =3D os.path.join(os.path.dirname(__file_=
_), "templates/dot2k")
-
-        if self.container:
-            if file_path:
-                raise ValueError("A container does not require a dot file")
-            if MonitorType:
-                raise ValueError("A container does not require a monitor t=
ype")
-            if self.parent:
-                raise ValueError("A container cannot have a parent")
-            self.name =3D extra_params.get("model_name")
-            self.events =3D []
-            self.states =3D []
-            self.main_h =3D self._read_template_file("main.h")
-        else:
-            super().__init__(file_path, extra_params.get("model_name"))
+class dot2k(Monitor, Dot2c):
+    template_dir =3D "dot2k"
=20
-            self.monitor_type =3D self.monitor_types.get(MonitorType)
-            if self.monitor_type is None:
-                raise ValueError("Unknown monitor type: %s" % MonitorType)
-            self.monitor_type =3D MonitorType
-            self.trace_h =3D self._read_template_file("trace.h")
-
-        self.main_c =3D self._read_template_file("main.c")
-        self.kconfig =3D self._read_template_file("Kconfig")
+    def __init__(self, file_path, MonitorType, extra_params=3D{}):
+        self.monitor_type =3D MonitorType
+        Monitor.__init__(self, extra_params)
+        Dot2c.__init__(self, file_path, extra_params.get("model_name"))
         self.enum_suffix =3D "_%s" % self.name
-        self.description =3D extra_params.get("description", self.name) or=
 "auto-generated"
-        self.auto_patch =3D extra_params.get("auto_patch")
-        if self.auto_patch:
-            self.__fill_rv_kernel_dir()
-
-    def __fill_rv_kernel_dir(self):
-
-        # first try if we are running in the kernel tree root
-        if os.path.exists(self.rv_dir):
-            return
-
-        # offset if we are running inside the kernel tree from verificatio=
n/dot2
-        kernel_path =3D os.path.join("../..", self.rv_dir)
-
-        if os.path.exists(kernel_path):
-            self.rv_dir =3D kernel_path
-            return
-
-        if platform.system() !=3D "Linux":
-            raise OSError("I can only run on Linux.")
-
-        kernel_path =3D os.path.join("/lib/modules/%s/build" % platform.re=
lease(), self.rv_dir)
-
-        # if the current kernel is from a distro this may not be a full ke=
rnel tree
-        # verify that one of the files we are going to modify is available
-        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
-            self.rv_dir =3D kernel_path
-            return
-
-        raise FileNotFoundError("Could not find the rv directory, do you h=
ave the kernel source installed?")
-
-    def __read_file(self, path):
-        try:
-            fd =3D open(path, 'r')
-        except OSError:
-            raise Exception("Cannot open the file: %s" % path)
-
-        content =3D fd.read()
-
-        fd.close()
-        return content
-
-    def _read_template_file(self, file):
-        try:
-            path =3D os.path.join(self.abs_template_dir, file)
-            return self.__read_file(path)
-        except Exception:
-            # Specific template file not found. Try the generic template f=
ile in the template/
-            # directory, which is one level up
-            path =3D os.path.join(self.abs_template_dir, "..", file)
-            return self.__read_file(path)
=20
     def fill_monitor_type(self):
         return self.monitor_type.upper()
=20
-    def fill_parent(self):
-        return "&rv_%s" % self.parent if self.parent else "NULL"
-
-    def fill_include_parent(self):
-        if self.parent:
-            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.pa=
rent)
-        return ""
-
     def fill_tracepoint_handlers_skel(self):
         buff =3D []
         for event in self.events:
@@ -144,30 +57,6 @@ class dot2k(Dot2c):
             buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoin=
t */, handle_%s);" % (self.name, event))
         return '\n'.join(buff)
=20
-    def fill_main_c(self):
-        main_c =3D self.main_c
-        monitor_type =3D self.fill_monitor_type()
-        min_type =3D self.get_minimun_type()
-        nr_events =3D len(self.events)
-        tracepoint_handlers =3D self.fill_tracepoint_handlers_skel()
-        tracepoint_attach =3D self.fill_tracepoint_attach_probe()
-        tracepoint_detach =3D self.fill_tracepoint_detach_helper()
-        parent =3D self.fill_parent()
-        parent_include =3D self.fill_include_parent()
-
-        main_c =3D main_c.replace("%%MONITOR_TYPE%%", monitor_type)
-        main_c =3D main_c.replace("%%MIN_TYPE%%", min_type)
-        main_c =3D main_c.replace("%%MODEL_NAME%%", self.name)
-        main_c =3D main_c.replace("%%NR_EVENTS%%", str(nr_events))
-        main_c =3D main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoi=
nt_handlers)
-        main_c =3D main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_atta=
ch)
-        main_c =3D main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_deta=
ch)
-        main_c =3D main_c.replace("%%DESCRIPTION%%", self.description)
-        main_c =3D main_c.replace("%%PARENT%%", parent)
-        main_c =3D main_c.replace("%%INCLUDE_PARENT%%", parent_include)
-
-        return main_c
-
     def fill_model_h_header(self):
         buff =3D []
         buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
@@ -226,147 +115,15 @@ class dot2k(Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return '\n'.join(buff)
=20
-    def fill_monitor_deps(self):
-        buff =3D []
-        buff.append("	# XXX: add dependencies if there")
-        if self.parent:
-            buff.append("	depends on RV_MON_%s" % self.parent.upper())
-            buff.append("	default y")
-        return '\n'.join(buff)
-
-    def fill_trace_h(self):
-        trace_h =3D self.trace_h
-        monitor_class =3D self.fill_monitor_class()
-        monitor_class_type =3D self.fill_monitor_class_type()
-        tracepoint_args_skel_event =3D self.fill_tracepoint_args_skel("eve=
nt")
-        tracepoint_args_skel_error =3D self.fill_tracepoint_args_skel("err=
or")
-        trace_h =3D trace_h.replace("%%MODEL_NAME%%", self.name)
-        trace_h =3D trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
-        trace_h =3D trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
-        trace_h =3D trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_clas=
s_type)
-        trace_h =3D trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", trac=
epoint_args_skel_event)
-        trace_h =3D trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", trac=
epoint_args_skel_error)
-        return trace_h
-
-    def fill_kconfig(self):
-        kconfig =3D self.kconfig
-        monitor_class_type =3D self.fill_monitor_class_type()
-        monitor_deps =3D self.fill_monitor_deps()
-        kconfig =3D kconfig.replace("%%MODEL_NAME%%", self.name)
-        kconfig =3D kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
-        kconfig =3D kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_clas=
s_type)
-        kconfig =3D kconfig.replace("%%DESCRIPTION%%", self.description)
-        kconfig =3D kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
-        return kconfig
-
-    def fill_main_container_h(self):
-        main_h =3D self.main_h
-        main_h =3D main_h.replace("%%MODEL_NAME%%", self.name)
-        return main_h
-
-    def __patch_file(self, file, marker, line):
-        file_to_patch =3D os.path.join(self.rv_dir, file)
-        content =3D self.__read_file(file_to_patch)
-        content =3D content.replace(marker, line + "\n" + marker)
-        self.__write_file(file_to_patch, content)
-
-    def fill_tracepoint_tooltip(self):
-        monitor_class_type =3D self.fill_monitor_class_type()
-        if self.auto_patch:
-            self.__patch_file("rv_trace.h",
-                            "// Add new monitors based on CONFIG_%s here" =
% monitor_class_type,
-                            "#include <monitors/%s/%s_trace.h>" % (self.na=
me, self.name))
-            return "  - Patching %s/rv_trace.h, double check the result" %=
 self.rv_dir
-
-        return """  - Edit %s/rv_trace.h:
-Add this line where other tracepoints are included and %s is defined:
-#include <monitors/%s/%s_trace.h>
-""" % (self.rv_dir, monitor_class_type, self.name, self.name)
-
-    def fill_kconfig_tooltip(self):
-        if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
-                            "source \"kernel/trace/rv/monitors/%s/Kconfig\=
"" % (self.name))
-            return "  - Patching %s/Kconfig, double check the result" % se=
lf.rv_dir
-
-        return """  - Edit %s/Kconfig:
-Add this line where other monitors are included:
-source \"kernel/trace/rv/monitors/%s/Kconfig\"
-""" % (self.rv_dir, self.name)
-
-    def fill_makefile_tooltip(self):
-        name =3D self.name
-        name_up =3D name.upper()
-        if self.auto_patch:
-            self.__patch_file("Makefile",
-                            "# Add new monitors here",
-                            "obj-$(CONFIG_RV_MON_%s) +=3D monitors/%s/%s.o=
" % (name_up, name, name))
-            return "  - Patching %s/Makefile, double check the result" % s=
elf.rv_dir
-
-        return """  - Edit %s/Makefile:
-Add this line where other monitors are included:
-obj-$(CONFIG_RV_MON_%s) +=3D monitors/%s/%s.o
-""" % (self.rv_dir, name_up, name, name)
-
-    def fill_monitor_tooltip(self):
-        if self.auto_patch:
-            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir,=
 self. name)
-        return "  - Move %s/ to the kernel's monitor directory (%s/monitor=
s)" % (self.name, self.rv_dir)
-
-    def __create_directory(self):
-        path =3D self.name
-        if self.auto_patch:
-            path =3D os.path.join(self.rv_dir, "monitors", path)
-        try:
-            os.mkdir(path)
-        except FileExistsError:
-            return
-        except:
-            print("Fail creating the output dir: %s" % self.name)
-
-    def __write_file(self, file_name, content):
-        try:
-            file =3D open(file_name, 'w')
-        except:
-            print("Fail writing to file: %s" % file_name)
-
-        file.write(content)
-
-        file.close()
-
-    def __create_file(self, file_name, content):
-        path =3D "%s/%s" % (self.name, file_name)
-        if self.auto_patch:
-            path =3D os.path.join(self.rv_dir, "monitors", path)
-        self.__write_file(path, content)
-
-    def __get_main_name(self):
-        path =3D "%s/%s" % (self.name, "main.c")
-        if not os.path.exists(path):
-            return "main.c"
-        return "__main.c"
-
-    def print_files(self):
-        main_c =3D self.fill_main_c()
-
-        self.__create_directory()
-
-        path =3D "%s.c" % self.name
-        self.__create_file(path, main_c)
+    def fill_main_c(self):
+        main_c =3D super().fill_main_c()
=20
-        if self.container:
-            main_h =3D self.fill_main_container_h()
-            path =3D "%s.h" % self.name
-            self.__create_file(path, main_h)
-        else:
-            model_h =3D self.fill_model_h()
-            path =3D "%s.h" % self.name
-            self.__create_file(path, model_h)
+        min_type =3D self.get_minimun_type()
+        nr_events =3D len(self.events)
+        monitor_type =3D self.fill_monitor_type()
=20
-            trace_h =3D self.fill_trace_h()
-            path =3D "%s_trace.h" % self.name
-            self.__create_file(path, trace_h)
+        main_c =3D main_c.replace("%%MIN_TYPE%%", min_type)
+        main_c =3D main_c.replace("%%NR_EVENTS%%", str(nr_events))
+        main_c =3D main_c.replace("%%MONITOR_TYPE%%", monitor_type)
=20
-        kconfig =3D self.fill_kconfig()
-        self.__create_file("Kconfig", kconfig)
+        return main_c
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verificati=
on/rvgen/rvgen/generator.py
new file mode 100644
index 000000000000..19d0078a3803
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -0,0 +1,264 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristo=
t@kernel.org>
+#
+# Abtract class for generating kernel runtime verification monitors from s=
pecification file
+
+import platform
+import os
+
+
+class RVGenerator:
+    rv_dir =3D "kernel/trace/rv"
+
+    def __init__(self, extra_params=3D{}):
+        self.name =3D extra_params.get("model_name")
+        self.parent =3D extra_params.get("parent")
+        self.abs_template_dir =3D \
+            os.path.join(os.path.dirname(__file__), "templates", self.temp=
late_dir)
+        self.main_c =3D self._read_template_file("main.c")
+        self.kconfig =3D self._read_template_file("Kconfig")
+        self.description =3D extra_params.get("description", self.name) or=
 "auto-generated"
+        self.auto_patch =3D extra_params.get("auto_patch")
+        if self.auto_patch:
+            self.__fill_rv_kernel_dir()
+
+    def __fill_rv_kernel_dir(self):
+
+        # first try if we are running in the kernel tree root
+        if os.path.exists(self.rv_dir):
+            return
+
+        # offset if we are running inside the kernel tree from verificatio=
n/dot2
+        kernel_path =3D os.path.join("../..", self.rv_dir)
+
+        if os.path.exists(kernel_path):
+            self.rv_dir =3D kernel_path
+            return
+
+        if platform.system() !=3D "Linux":
+            raise OSError("I can only run on Linux.")
+
+        kernel_path =3D os.path.join("/lib/modules/%s/build" % platform.re=
lease(), self.rv_dir)
+
+        # if the current kernel is from a distro this may not be a full ke=
rnel tree
+        # verify that one of the files we are going to modify is available
+        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
+            self.rv_dir =3D kernel_path
+            return
+
+        raise FileNotFoundError("Could not find the rv directory, do you h=
ave the kernel source installed?")
+
+    def _read_file(self, path):
+        try:
+            fd =3D open(path, 'r')
+        except OSError:
+            raise Exception("Cannot open the file: %s" % path)
+
+        content =3D fd.read()
+
+        fd.close()
+        return content
+
+    def _read_template_file(self, file):
+        try:
+            path =3D os.path.join(self.abs_template_dir, file)
+            return self._read_file(path)
+        except Exception:
+            # Specific template file not found. Try the generic template f=
ile in the template/
+            # directory, which is one level up
+            path =3D os.path.join(self.abs_template_dir, "..", file)
+            return self._read_file(path)
+
+    def fill_parent(self):
+        return "&rv_%s" % self.parent if self.parent else "NULL"
+
+    def fill_include_parent(self):
+        if self.parent:
+            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.pa=
rent)
+        return ""
+
+    def fill_tracepoint_handlers_skel(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_attach_probe(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_detach_helper(self):
+        return "NotImplemented"
+
+    def fill_main_c(self):
+        main_c =3D self.main_c
+        tracepoint_handlers =3D self.fill_tracepoint_handlers_skel()
+        tracepoint_attach =3D self.fill_tracepoint_attach_probe()
+        tracepoint_detach =3D self.fill_tracepoint_detach_helper()
+        parent =3D self.fill_parent()
+        parent_include =3D self.fill_include_parent()
+
+        main_c =3D main_c.replace("%%MODEL_NAME%%", self.name)
+        main_c =3D main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoi=
nt_handlers)
+        main_c =3D main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_atta=
ch)
+        main_c =3D main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_deta=
ch)
+        main_c =3D main_c.replace("%%DESCRIPTION%%", self.description)
+        main_c =3D main_c.replace("%%PARENT%%", parent)
+        main_c =3D main_c.replace("%%INCLUDE_PARENT%%", parent_include)
+
+        return main_c
+
+    def fill_model_h(self):
+        return "NotImplemented"
+
+    def fill_monitor_class_type(self):
+        return "NotImplemented"
+
+    def fill_monitor_class(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_args_skel(self, tp_type):
+        return "NotImplemented"
+
+    def fill_monitor_deps(self):
+        buff =3D []
+        buff.append("	# XXX: add dependencies if there")
+        if self.parent:
+            buff.append("	depends on RV_MON_%s" % self.parent.upper())
+            buff.append("	default y")
+        return '\n'.join(buff)
+
+    def fill_kconfig(self):
+        kconfig =3D self.kconfig
+        monitor_class_type =3D self.fill_monitor_class_type()
+        monitor_deps =3D self.fill_monitor_deps()
+        kconfig =3D kconfig.replace("%%MODEL_NAME%%", self.name)
+        kconfig =3D kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        kconfig =3D kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_clas=
s_type)
+        kconfig =3D kconfig.replace("%%DESCRIPTION%%", self.description)
+        kconfig =3D kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
+        return kconfig
+
+    def __patch_file(self, file, marker, line):
+        file_to_patch =3D os.path.join(self.rv_dir, file)
+        content =3D self._read_file(file_to_patch)
+        content =3D content.replace(marker, line + "\n" + marker)
+        self.__write_file(file_to_patch, content)
+
+    def fill_tracepoint_tooltip(self):
+        monitor_class_type =3D self.fill_monitor_class_type()
+        if self.auto_patch:
+            self.__patch_file("rv_trace.h",
+                            "// Add new monitors based on CONFIG_%s here" =
% monitor_class_type,
+                            "#include <monitors/%s/%s_trace.h>" % (self.na=
me, self.name))
+            return "  - Patching %s/rv_trace.h, double check the result" %=
 self.rv_dir
+
+        return """  - Edit %s/rv_trace.h:
+Add this line where other tracepoints are included and %s is defined:
+#include <monitors/%s/%s_trace.h>
+""" % (self.rv_dir, monitor_class_type, self.name, self.name)
+
+    def fill_kconfig_tooltip(self):
+        if self.auto_patch:
+            self.__patch_file("Kconfig",
+                            "# Add new monitors here",
+                            "source \"kernel/trace/rv/monitors/%s/Kconfig\=
"" % (self.name))
+            return "  - Patching %s/Kconfig, double check the result" % se=
lf.rv_dir
+
+        return """  - Edit %s/Kconfig:
+Add this line where other monitors are included:
+source \"kernel/trace/rv/monitors/%s/Kconfig\"
+""" % (self.rv_dir, self.name)
+
+    def fill_makefile_tooltip(self):
+        name =3D self.name
+        name_up =3D name.upper()
+        if self.auto_patch:
+            self.__patch_file("Makefile",
+                            "# Add new monitors here",
+                            "obj-$(CONFIG_RV_MON_%s) +=3D monitors/%s/%s.o=
" % (name_up, name, name))
+            return "  - Patching %s/Makefile, double check the result" % s=
elf.rv_dir
+
+        return """  - Edit %s/Makefile:
+Add this line where other monitors are included:
+obj-$(CONFIG_RV_MON_%s) +=3D monitors/%s/%s.o
+""" % (self.rv_dir, name_up, name, name)
+
+    def fill_monitor_tooltip(self):
+        if self.auto_patch:
+            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir,=
 self. name)
+        return "  - Move %s/ to the kernel's monitor directory (%s/monitor=
s)" % (self.name, self.rv_dir)
+
+    def __create_directory(self):
+        path =3D self.name
+        if self.auto_patch:
+            path =3D os.path.join(self.rv_dir, "monitors", path)
+        try:
+            os.mkdir(path)
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating the output dir: %s" % self.name)
+
+    def __write_file(self, file_name, content):
+        try:
+            file =3D open(file_name, 'w')
+        except:
+            print("Fail writing to file: %s" % file_name)
+
+        file.write(content)
+
+        file.close()
+
+    def _create_file(self, file_name, content):
+        path =3D "%s/%s" % (self.name, file_name)
+        if self.auto_patch:
+            path =3D os.path.join(self.rv_dir, "monitors", path)
+        self.__write_file(path, content)
+
+    def __get_main_name(self):
+        path =3D "%s/%s" % (self.name, "main.c")
+        if not os.path.exists(path):
+            return "main.c"
+        return "__main.c"
+
+    def print_files(self):
+        main_c =3D self.fill_main_c()
+
+        self.__create_directory()
+
+        path =3D "%s.c" % self.name
+        self._create_file(path, main_c)
+
+        model_h =3D self.fill_model_h()
+        path =3D "%s.h" % self.name
+        self._create_file(path, model_h)
+
+        kconfig =3D self.fill_kconfig()
+        self._create_file("Kconfig", kconfig)
+
+
+class Monitor(RVGenerator):
+    monitor_types =3D { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+
+    def __init__(self, extra_params=3D{}):
+        super().__init__(extra_params)
+        self.trace_h =3D self._read_template_file("trace.h")
+
+    def fill_trace_h(self):
+        trace_h =3D self.trace_h
+        monitor_class =3D self.fill_monitor_class()
+        monitor_class_type =3D self.fill_monitor_class_type()
+        tracepoint_args_skel_event =3D self.fill_tracepoint_args_skel("eve=
nt")
+        tracepoint_args_skel_error =3D self.fill_tracepoint_args_skel("err=
or")
+        trace_h =3D trace_h.replace("%%MODEL_NAME%%", self.name)
+        trace_h =3D trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        trace_h =3D trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
+        trace_h =3D trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_clas=
s_type)
+        trace_h =3D trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", trac=
epoint_args_skel_event)
+        trace_h =3D trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", trac=
epoint_args_skel_error)
+        return trace_h
+
+    def print_files(self):
+        super().print_files()
+        trace_h =3D self.fill_trace_h()
+        path =3D "%s_trace.h" % self.name
+        self._create_file(path, trace_h)
--=20
2.39.5

