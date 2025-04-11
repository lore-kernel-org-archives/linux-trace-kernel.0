Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CC296140;
	Fri, 11 Apr 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357093; cv=none; b=BOyyB5u3QUZfl5iBBYJmYARyIwuc4B0txPdXfZOtQaU6dVBGQQHqapVqtN2+NjaNhrwwTb9HqrpjYIA9i64ViyCDoma9gP+mbTY84qXVX+nqXDq5XqwS4ZnU9eZ5CEN4Bc8ZCEivtCCrcHwT+OA4MD0aO7JKG2/Bm1gPk96Ijag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357093; c=relaxed/simple;
	bh=PUQ0zHRfJa8EqNsA/z/eC1enVG5l32c9sbX/IeTvkhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdRt8X3vZLoN7rX3d43AlLQtle/ZFqgQlw+rS7/eeJUCfhLoOcnwVGJd3Z2XQ63CdXBCiVI+aa9raX1ojGOMb2VexCFUBithBC+Etwf7d/r8Ed/zCyFjEvXRP7B9+I+vqwHR18tXNozuG4pGplndNKWMuDtrPx+Jw/Wamj+XII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCZ9GG00; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZiMaP0P+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCZ9GG00";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZiMaP0P+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INzN8Y6WNlcKvSQ69JFUt7STsA0/68xoUry5OkA5zUI=;
	b=oCZ9GG006m0A9hlN5HAh7vRgRnjn9DFWAPuWeZPibq9Deow5zI0Sghx/knuWWaLGKfBOcY
	eZN3nG6Ss/6swdcep71TNRS4MAeph/NOL+FfX5rNIxfW0AWYV8d2m/bi6TWYl1W0NqvXQM
	uV+Xg1ndwxXw2HDBAarpjPhEsdJdXzp/aoDj7WgNQepaa8MyyDK7gyYEGAUOFASJ6S1ikA
	07B+9ur5/bAcu1op5YqwFGQlVgr8JX3KS5K79J3n1MpKLHzSuLv1irvFMBXQTmdQmL89MY
	KUy8no5xTTubq38i3VXiSMrkS/UA3QlAgesWRi8UxiZgzDZ3peGQQZtOX2qrFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INzN8Y6WNlcKvSQ69JFUt7STsA0/68xoUry5OkA5zUI=;
	b=ZiMaP0P+bIzvGbkeT36pNk5vgysexb7LBWxijLhrffPPeBAVXMPOlHvMIDWHSaFlmyfs4b
	CmLc/moy7Q7gWwDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 11/22] verification/rvgen: Prepare the templates for LTL inclusion
Date: Fri, 11 Apr 2025 09:37:27 +0200
Message-Id: <af6d15edc1b48c94ec7bfedfa17feb5390fc05e4.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To prepare for the inclusion of linear temporal logic monitor, prepare the
generation template files:

  - Rename the directory dot2k_templates to templates
  - Move the dot2k-specific files to templates/dot2k
  - Move the container-specific files to templates/container

(Kconfig can be shared with LTL, therefore leave it at templates/)

This new structure allows sharing code for reading Kconfig and main.c
templates between DA monitor, container monitor and LTL monitor.

The intention is to add template files for LTL to templates/ltl.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/Makefile             |  2 +-
 tools/verification/rvgen/rvgen/dot2k.py       | 33 +++++++++++++------
 .../{dot2k_templates =3D> templates}/Kconfig    |  0
 .../container/Kconfig}                        |  0
 .../container/main.c}                         |  0
 .../container/main.h}                         |  0
 .../dot2k}/main.c                             |  0
 .../dot2k}/trace.h                            |  0
 8 files changed, 24 insertions(+), 11 deletions(-)
 rename tools/verification/rvgen/{dot2k_templates =3D> templates}/Kconfig (=
100%)
 rename tools/verification/rvgen/{dot2k_templates/Kconfig_container =3D> te=
mplates/container/Kconfig} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.c =3D> tem=
plates/container/main.c} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.h =3D> tem=
plates/container/main.h} (100%)
 rename tools/verification/rvgen/{dot2k_templates =3D> templates/dot2k}/mai=
n.c (100%)
 rename tools/verification/rvgen/{dot2k_templates =3D> templates/dot2k}/tra=
ce.h (100%)

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/M=
akefile
index cea9c21c3bce..c1a34fa49619 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -23,4 +23,4 @@ install:
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
=20
 	mkdir -p ${miscdir}/
-	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
+	cp -rp templates $(DESTDIR)$(miscdir)/
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index e29462413194..ed40a2071ddc 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -14,13 +14,16 @@ import os
=20
 class dot2k(Dot2c):
     monitor_types =3D { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir =3D "rvgen/dot2k_templates/"
     rv_dir =3D "kernel/trace/rv"
     monitor_type =3D "per_cpu"
=20
     def __init__(self, file_path, MonitorType, extra_params=3D{}):
         self.container =3D extra_params.get("subcmd") =3D=3D "container"
         self.parent =3D extra_params.get("parent")
+        if self.container:
+            self.monitor_templates_dir =3D "rvgen/templates/container"
+        else:
+            self.monitor_templates_dir =3D "rvgen/templates/dot2k"
         self.__fill_rv_templates_dir()
=20
         if self.container:
@@ -33,9 +36,7 @@ class dot2k(Dot2c):
             self.name =3D extra_params.get("model_name")
             self.events =3D []
             self.states =3D []
-            self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main_container.c")
-            self.main_h =3D self.__read_file(self.monitor_templates_dir + =
"main_container.h")
-            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig_container")
+            self.main_h =3D self._read_template_file("main.h")
         else:
             super().__init__(file_path, extra_params.get("model_name"))
=20
@@ -43,9 +44,10 @@ class dot2k(Dot2c):
             if self.monitor_type is None:
                 raise ValueError("Unknown monitor type: %s" % MonitorType)
             self.monitor_type =3D MonitorType
-            self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main.c")
-            self.trace_h =3D self.__read_file(self.monitor_templates_dir +=
 "trace.h")
-            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig")
+            self.trace_h =3D self._read_template_file("trace.h")
+
+        self.main_c =3D self._read_template_file("main.c")
+        self.kconfig =3D self._read_template_file("Kconfig")
         self.enum_suffix =3D "_%s" % self.name
         self.description =3D extra_params.get("description", self.name) or=
 "auto-generated"
         self.auto_patch =3D extra_params.get("auto_patch")
@@ -60,14 +62,15 @@ class dot2k(Dot2c):
         if platform.system() !=3D "Linux":
             raise OSError("I can only run on Linux.")
=20
-        kernel_path =3D "/lib/modules/%s/build/tools/verification/rvgen/do=
t2k_templates/" % (platform.release())
+        kernel_path =3D "/lib/modules/%s/build/tools/verification/%s/" \
+                      % (platform.release(), self.monitor_templates_dir)
=20
         if os.path.exists(kernel_path):
             self.monitor_templates_dir =3D kernel_path
             return
=20
-        if os.path.exists("/usr/share/rvgen/dot2k_templates/"):
-            self.monitor_templates_dir =3D "/usr/share/rvgen/dot2k_templat=
es/"
+        if os.path.exists("/usr/share/%s/" % self.monitor_templates_dir):
+            self.monitor_templates_dir =3D "/usr/share/%s/" % self.monitor=
_templates_dir
             return
=20
         raise FileNotFoundError("Could not find the template directory, do=
 you have the kernel source installed?")
@@ -109,6 +112,16 @@ class dot2k(Dot2c):
         fd.close()
         return content
=20
+    def _read_template_file(self, file):
+        try:
+            path =3D os.path.join(self.monitor_templates_dir, file)
+            return self.__read_file(path)
+        except Exception:
+            # Specific template file not found. Try the generic template f=
ile in the template/
+            # directory, which is one level up
+            path =3D os.path.join(self.monitor_templates_dir, "..", file)
+            return self.__read_file(path)
+
     def fill_monitor_type(self):
         return self.monitor_type.upper()
=20
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig b/tools/verif=
ication/rvgen/templates/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig
rename to tools/verification/rvgen/templates/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig_container b/t=
ools/verification/rvgen/templates/container/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig_container
rename to tools/verification/rvgen/templates/container/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.c b/to=
ols/verification/rvgen/templates/container/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.c
rename to tools/verification/rvgen/templates/container/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.h b/to=
ols/verification/rvgen/templates/container/main.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.h
rename to tools/verification/rvgen/templates/container/main.h
diff --git a/tools/verification/rvgen/dot2k_templates/main.c b/tools/verifi=
cation/rvgen/templates/dot2k/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main.c
rename to tools/verification/rvgen/templates/dot2k/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/trace.h b/tools/verif=
ication/rvgen/templates/dot2k/trace.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/trace.h
rename to tools/verification/rvgen/templates/dot2k/trace.h
--=20
2.39.5

