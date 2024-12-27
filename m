Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C01F63C9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310975; cv=none; b=RrDw+S/iOd405AaxYgnXz9Gabc63YgTv6PVamedVmJrzTZXSXiJM2cNn58bD7gJLY64Cbbg4XuSs4gmQ0xS4vDce2ORumIRZsMbX7d6IvkmiOdP2sjdwqdUm4zrEcrsAyaE5zmkym+idw+Amu3iYrSa+hP7GneoRNxl9UH2umG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310975; c=relaxed/simple;
	bh=PnOObsiaXYSi5DdcYWwHeskisfPGa+aaSBlrvTDBNoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGskQ0xlL2oS0vYZAi0+RwWfbYbAr/SmTeDXAndsCJl1VaskY4FxfJCAxJ4xC3smhs8VdWSq36ryhLVmsx81pz8dQ/m1UFrb8GIVJoQEl2buPiB6R9zb53jOHQ1xHL5LcZr+GoYylXmt4RD30DdI2Od5BgGVNpMDEAsXP/5xmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVsPxy2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVsPxy2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Mvivx0JU6mkPGU6ow2maK89XXungVetwbzNEa/Pr8=;
	b=PVsPxy2dxY4uoF55UGXCJKI52ch9wwFIi4TotuJj+0UT7SPz4Re6iJloGOnzngzjHic4Ge
	n0PD/4CXIGzaXfFkINj6UeqAvZoz6jAMi05BfUosyoBzxyJ+BJVrKKJrB2NrsfFTMakk3W
	PmXIY0biiNyfj1OsIXrfcmcbp4WSwco=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-j5VTLiXyNkSW5uEcejUvSQ-1; Fri,
 27 Dec 2024 09:49:29 -0500
X-MC-Unique: j5VTLiXyNkSW5uEcejUvSQ-1
X-Mimecast-MFC-AGG-ID: j5VTLiXyNkSW5uEcejUvSQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AAA1956048;
	Fri, 27 Dec 2024 14:49:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAC8A300F9B5;
	Fri, 27 Dec 2024 14:49:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 7/8] verification/dot2k: Auto patch current kernel source
Date: Fri, 27 Dec 2024 15:47:51 +0100
Message-ID: <20241227144752.362911-8-gmonaco@redhat.com>
In-Reply-To: <20241227144752.362911-1-gmonaco@redhat.com>
References: <20241227144752.362911-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

dot2k suggests a list of changes to the kernel tree while adding a
monitor: edit tracepoints header, Makefile, Kconfig and moving the
monitor folder. Those changes can be easily run automatically.

This patch adds a flag to dot2k to alter the kernel source.

The kernel source directory can be either assumed from the PWD, or from
the running kernel, if installed.
This feature works best if the kernel tree is a git repository, so that
its easier to make sure there are no unintended changes.

The main RV files (e.g. Makefile) have now a comment placeholder that
can be useful for manual editing (e.g. to know where to add new
monitors) and it is used by the script to append the required lines.

We also slightly adapt the file handling functions in dot2k: __open_file
is now called __read_file and also closes the file before returning the
content; __create_file is now a more general __write_file, we no longer
return on FileExistsError (not thrown while opening), a new
__create_file simply calls __write_file specifying the monitor folder in
the path.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig          |  2 +-
 kernel/trace/rv/Makefile         |  1 +
 kernel/trace/rv/rv_trace.h       |  2 +
 tools/verification/dot2/dot2k    |  5 +-
 tools/verification/dot2/dot2k.py | 92 +++++++++++++++++++++++++++-----
 5 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 1cca47531f006..8226352a00626 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -26,8 +26,8 @@ menuconfig RV
 	    Documentation/trace/rv/runtime-verification.rst
 
 source "kernel/trace/rv/monitors/wip/Kconfig"
-
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
+# Add new monitors here
 
 config RV_REACTORS
 	bool "Runtime verification reactors"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 645434146a88a..188b64668e1fa 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -5,6 +5,7 @@ ccflags-y += -I $(src)		# needed for trace events
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
+# Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 3442dc59490fe..5e65097423ba4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -58,6 +58,7 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 );
 
 #include <monitors/wip/wip_trace.h>
+// Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
 
@@ -117,6 +118,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 );
 
 #include <monitors/wwnr/wwnr_trace.h>
+// Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 190c974edd0a6..559ba191a1f6d 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -21,6 +21,9 @@ if __name__ == '__main__':
     parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True)
     parser.add_argument('-n', "--model_name", dest="model_name", required=False)
     parser.add_argument("-D", "--description", dest="description", required=False)
+    parser.add_argument("-a", "--auto_patch", dest="auto_patch",
+                        action="store_true", required=False,
+                        help="Patch the kernel in place")
     params = parser.parse_args()
 
     print("Opening and parsing the dot file %s" % params.dot_file)
@@ -38,4 +41,4 @@ if __name__ == '__main__':
     print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
     print(monitor.fill_kconfig_tooltip())
-    print("  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (monitor.name, monitor.rv_dir))
+    print(monitor.fill_monitor_tooltip())
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index dc56cd1fb0b41..83f4d49853a25 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -27,11 +27,14 @@ class dot2k(Dot2c):
 
         self.monitor_type = MonitorType
         self.__fill_rv_templates_dir()
-        self.main_c = self.__open_file(self.monitor_templates_dir + "main.c")
-        self.trace_h = self.__open_file(self.monitor_templates_dir + "trace.h")
-        self.kconfig = self.__open_file(self.monitor_templates_dir + "Kconfig")
+        self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
+        self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
+        self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
+        self.auto_patch = extra_params.get("auto_patch")
+        if self.auto_patch:
+            self.__fill_rv_kernel_dir()
 
     def __fill_rv_templates_dir(self):
 
@@ -39,7 +42,7 @@ class dot2k(Dot2c):
             return
 
         if platform.system() != "Linux":
-            raise Exception("I can only run on Linux.")
+            raise OSError("I can only run on Linux.")
 
         kernel_path = "/lib/modules/%s/build/tools/verification/dot2/dot2k_templates/" % (platform.release())
 
@@ -51,17 +54,43 @@ class dot2k(Dot2c):
             self.monitor_templates_dir = "/usr/share/dot2/dot2k_templates/"
             return
 
-        raise Exception("Could not find the template directory, do you have the kernel source installed?")
+        raise FileNotFoundError("Could not find the template directory, do you have the kernel source installed?")
 
+    def __fill_rv_kernel_dir(self):
 
-    def __open_file(self, path):
+        # first try if we are running in the kernel tree root
+        if os.path.exists(self.rv_dir):
+            return
+
+        # offset if we are running inside the kernel tree from verification/dot2
+        kernel_path = os.path.join("../..", self.rv_dir)
+
+        if os.path.exists(kernel_path):
+            self.rv_dir = kernel_path
+            return
+
+        if platform.system() != "Linux":
+            raise OSError("I can only run on Linux.")
+
+        kernel_path = os.path.join("/lib/modules/%s/build" % platform.release(), self.rv_dir)
+
+        # if the current kernel is from a distro this may not be a full kernel tree
+        # verify that one of the files we are going to modify is available
+        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
+            self.rv_dir = kernel_path
+            return
+
+        raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
+
+    def __read_file(self, path):
         try:
-            fd = open(path)
+            fd = open(path, 'r')
         except OSError:
             raise Exception("Cannot open the file: %s" % path)
 
         content = fd.read()
 
+        fd.close()
         return content
 
     def __buff_to_string(self, buff):
@@ -202,14 +231,32 @@ class dot2k(Dot2c):
         kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
         return kconfig
 
+    def __patch_file(self, file, marker, line):
+        file_to_patch = os.path.join(self.rv_dir, file)
+        content = self.__read_file(file_to_patch)
+        content = content.replace(marker, line + "\n" + marker)
+        self.__write_file(file_to_patch, content)
+
     def fill_tracepoint_tooltip(self):
         monitor_class_type = self.fill_monitor_class_type()
+        if self.auto_patch:
+            self.__patch_file("rv_trace.h",
+                            "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
+                            "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
+            return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
+
         return """  - Edit %s/rv_trace.h:
 Add this line where other tracepoints are included and %s is defined:
 #include <monitors/%s/%s_trace.h>
 """ % (self.rv_dir, monitor_class_type, self.name, self.name)
 
     def fill_kconfig_tooltip(self):
+        if self.auto_patch:
+            self.__patch_file("Kconfig",
+                            "# Add new monitors here",
+                            "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
+            return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
+
         return """  - Edit %s/Kconfig:
 Add this line where other monitors are included:
 source \"kernel/trace/rv/monitors/%s/Kconfig\"
@@ -218,32 +265,49 @@ source \"kernel/trace/rv/monitors/%s/Kconfig\"
     def fill_makefile_tooltip(self):
         name = self.name
         name_up = name.upper()
+        if self.auto_patch:
+            self.__patch_file("Makefile",
+                            "# Add new monitors here",
+                            "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
+            return "  - Patching %s/Makefile, double check the result" % self.rv_dir
+
         return """  - Edit %s/Makefile:
 Add this line where other monitors are included:
 obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 """ % (self.rv_dir, name_up, name, name)
 
+    def fill_monitor_tooltip(self):
+        if self.auto_patch:
+            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir, self. name)
+        return "  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (self.name, self.rv_dir)
+
     def __create_directory(self):
+        path = self.name
+        if self.auto_patch:
+            path = os.path.join(self.rv_dir, "monitors", path)
         try:
-            os.mkdir(self.name)
+            os.mkdir(path)
         except FileExistsError:
             return
         except:
             print("Fail creating the output dir: %s" % self.name)
 
-    def __create_file(self, file_name, content):
-        path = "%s/%s" % (self.name, file_name)
+    def __write_file(self, file_name, content):
         try:
-            file = open(path, 'w')
-        except FileExistsError:
-            return
+            file = open(file_name, 'w')
         except:
-            print("Fail creating file: %s" % path)
+            print("Fail writing to file: %s" % file_name)
 
         file.write(content)
 
         file.close()
 
+    def __create_file(self, file_name, content):
+        path = "%s/%s" % (self.name, file_name)
+        if self.auto_patch:
+            path = os.path.join(self.rv_dir, "monitors", path)
+        self.__write_file(path, content)
+
     def __get_main_name(self):
         path = "%s/%s" % (self.name, "main.c")
         if not os.path.exists(path):
-- 
2.47.1

