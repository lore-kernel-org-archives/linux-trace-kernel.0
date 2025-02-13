Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93420F094
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437768; cv=none; b=kk61RuOPk2Tt9wmaT7xIrsX/mls2rcgIThV1R2/EQU0BXnM0HNMfUDkjcoLu8jceMvKJo6uunOWSlVXKPlDLU0EbD3VtuqwSAEkC/N0hSDruo4QY0uacK6whU2AhJtedI1k9GWIerVI+5A+YUWkec3GpX6ZRqIedkrDaZs/oVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437768; c=relaxed/simple;
	bh=+L/G9ZYml07rE7xcoMc1XI178hR7JR3O+4eZS6nC3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzmyhLTCzPWdzGa7WGX9qMmpPeArSzg3U+xUD2r60tac4/1CtNKAPnM4cwFoAktkwYzcWMhWGnRvnlOmHkFmpe6EMNvgcKug73RdW7jYBvDo+Mxph76xE3qlLHnG+MNoSvPAcy4N87oJwgXwW+tO2y6iaqyoTiweOydh9U1g8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0Bkl1Br; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0Bkl1Br"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739437764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veJYqIZhZwJMarbagx/aKK/mQbHDV25wxXH1xL62AG8=;
	b=g0Bkl1BrSyiKJLd8R/UigyAlOs3uOiAlJBCTgUmPFwKxVcBdM5/whyVRfhEvJnHtG4NFR7
	EFNeryj8xnvHK5flpCaKrI/whzWeas2SI6VZaPzgp/8LEJrKy4ypEvCW19Z8aOFrSA51Zm
	X6hLwILmCEx9hBLKSOOl1MjkW6GSAtU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-VGBl6YyxMIm71eLJABmdGA-1; Thu,
 13 Feb 2025 04:09:20 -0500
X-MC-Unique: VGBl6YyxMIm71eLJABmdGA-1
X-Mimecast-MFC-AGG-ID: VGBl6YyxMIm71eLJABmdGA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4251800984;
	Thu, 13 Feb 2025 09:09:19 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB9CA1800570;
	Thu, 13 Feb 2025 09:09:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 09/11] verification/dot2k: Add support for nested monitors
Date: Thu, 13 Feb 2025 10:08:07 +0100
Message-ID: <20250213090819.419470-10-gmonaco@redhat.com>
In-Reply-To: <20250213090819.419470-1-gmonaco@redhat.com>
References: <20250213090819.419470-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

RV now supports nested monitors, this functionality requires a container
monitor, which has virtually no functionality besides holding other
monitors, and nested monitors, that have a container as parent.

Add the -p flag to pass a parent to a monitor, this sets it up while
registering the monitor and adds necessary includes and configurations.
Add the -c flag to create a container, since containers are empty, we
don't allow supplying a dot model or a monitor type, the template is
also different since functions to enable and disable the monitor are not
defined, nor any tracepoint. The generated header file only allows to
include the rv_monitor structure in children monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k                 | 27 ++++---
 tools/verification/dot2/dot2k.py              | 79 +++++++++++++++----
 .../verification/dot2/dot2k_templates/Kconfig |  1 +
 .../verification/dot2/dot2k_templates/main.c  |  4 +-
 .../dot2/dot2k_templates/main_container.c     | 38 +++++++++
 .../dot2/dot2k_templates/main_container.h     |  3 +
 6 files changed, 125 insertions(+), 27 deletions(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_container.h

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 559ba191a1f6d..767064f415e76 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -11,22 +11,30 @@
 if __name__ == '__main__':
     from dot2.dot2k import dot2k
     import argparse
-    import ntpath
-    import os
-    import platform
     import sys
 
+    def is_container():
+        """Should work even before parsing the arguments"""
+        return "-c" in sys.argv or "--container" in sys.argv
+
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
-    parser.add_argument('-d', "--dot", dest="dot_file", required=True)
-    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True)
-    parser.add_argument('-n', "--model_name", dest="model_name", required=False)
+    parser.add_argument('-d', "--dot", dest="dot_file", required=not is_container())
+    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=not is_container(),
+                        help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
+    parser.add_argument('-n', "--model_name", dest="model_name", required=is_container())
     parser.add_argument("-D", "--description", dest="description", required=False)
     parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
                         help="Patch the kernel in place")
+    parser.add_argument("-p", "--parent", dest="parent",
+                        required=False, help="Create a monitor nested to parent")
+    parser.add_argument("-c", "--container", dest="container",
+                        action="store_true", required=False,
+                        help="Create an empty monitor to be used as a container")
     params = parser.parse_args()
 
-    print("Opening and parsing the dot file %s" % params.dot_file)
+    if not is_container():
+        print("Opening and parsing the dot file %s" % params.dot_file)
     try:
         monitor=dot2k(params.dot_file, params.monitor_type, vars(params))
     except Exception as e:
@@ -37,8 +45,9 @@ if __name__ == '__main__':
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
     print("Almost done, checklist")
-    print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
-    print(monitor.fill_tracepoint_tooltip())
+    if not is_container():
+        print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+        print(monitor.fill_tracepoint_tooltip())
     print(monitor.fill_makefile_tooltip())
     print(monitor.fill_kconfig_tooltip())
     print(monitor.fill_monitor_tooltip())
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 153cc14bcca45..745d35a4a3791 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -19,16 +19,31 @@ class dot2k(Dot2c):
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType, extra_params={}):
-        super().__init__(file_path, extra_params.get("model_name"))
-
-        self.monitor_type = self.monitor_types.get(MonitorType)
-        if self.monitor_type is None:
-            raise ValueError("Unknown monitor type: %s" % MonitorType)
-
-        self.monitor_type = MonitorType
+        self.container = extra_params.get("container")
+        self.parent = extra_params.get("parent")
         self.__fill_rv_templates_dir()
-        self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
-        self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
+
+        if self.container:
+            if file_path:
+                raise ValueError("A container does not require a dot file")
+            if MonitorType:
+                raise ValueError("A container does not require a monitor type")
+            if self.parent:
+                raise ValueError("A container cannot have a parent")
+            self.name = extra_params.get("model_name")
+            self.events = []
+            self.states = []
+            self.main_c = self.__read_file(self.monitor_templates_dir + "main_container.c")
+            self.main_h = self.__read_file(self.monitor_templates_dir + "main_container.h")
+        else:
+            super().__init__(file_path, extra_params.get("model_name"))
+
+            self.monitor_type = self.monitor_types.get(MonitorType)
+            if self.monitor_type is None:
+                raise ValueError("Unknown monitor type: %s" % MonitorType)
+            self.monitor_type = MonitorType
+            self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
+            self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
         self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
@@ -105,6 +120,14 @@ class dot2k(Dot2c):
     def fill_monitor_type(self):
         return self.monitor_type.upper()
 
+    def fill_parent(self):
+        return "&rv_%s" % self.parent if self.parent else "NULL"
+
+    def fill_include_parent(self):
+        if self.parent:
+            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.parent)
+        return ""
+
     def fill_tracepoint_handlers_skel(self):
         buff = []
         for event in self.events:
@@ -146,6 +169,8 @@ class dot2k(Dot2c):
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
+        parent = self.fill_parent()
+        parent_include = self.fill_include_parent()
 
         main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
         main_c = main_c.replace("%%MIN_TYPE%%", min_type)
@@ -155,6 +180,8 @@ class dot2k(Dot2c):
         main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
         main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
         main_c = main_c.replace("%%DESCRIPTION%%", self.description)
+        main_c = main_c.replace("%%PARENT%%", parent)
+        main_c = main_c.replace("%%INCLUDE_PARENT%%", parent_include)
 
         return main_c
 
@@ -216,6 +243,14 @@ class dot2k(Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return self.__buff_to_string(buff)
 
+    def fill_monitor_deps(self):
+        buff = []
+        buff.append("	# XXX: add dependencies if there")
+        if self.parent:
+            buff.append("	depends on RV_MON_%s" % self.parent.upper())
+            buff.append("	default y")
+        return self.__buff_to_string(buff)
+
     def fill_trace_h(self):
         trace_h = self.trace_h
         monitor_class = self.fill_monitor_class()
@@ -233,12 +268,19 @@ class dot2k(Dot2c):
     def fill_kconfig(self):
         kconfig = self.kconfig
         monitor_class_type = self.fill_monitor_class_type()
+        monitor_deps = self.fill_monitor_deps()
         kconfig = kconfig.replace("%%MODEL_NAME%%", self.name)
         kconfig = kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
         kconfig = kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
         kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
+        kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
+    def fill_main_container_h(self):
+        main_h = self.main_h
+        main_h = main_h.replace("%%MODEL_NAME%%", self.name)
+        return main_h
+
     def __patch_file(self, file, marker, line):
         file_to_patch = os.path.join(self.rv_dir, file)
         content = self.__read_file(file_to_patch)
@@ -324,19 +366,24 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 
     def print_files(self):
         main_c = self.fill_main_c()
-        model_h = self.fill_model_h()
 
         self.__create_directory()
 
         path = "%s.c" % self.name
         self.__create_file(path, main_c)
 
-        path = "%s.h" % self.name
-        self.__create_file(path, model_h)
-
-        trace_h = self.fill_trace_h()
-        path = "%s_trace.h" % self.name
-        self.__create_file(path, trace_h)
+        if self.container:
+            main_h = self.fill_main_container_h()
+            path = "%s.h" % self.name
+            self.__create_file(path, main_h)
+        else:
+            model_h = self.fill_model_h()
+            path = "%s.h" % self.name
+            self.__create_file(path, model_h)
+
+            trace_h = self.fill_trace_h()
+            path = "%s_trace.h" % self.name
+            self.__create_file(path, trace_h)
 
         kconfig = self.fill_kconfig()
         self.__create_file("Kconfig", kconfig)
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/dot2/dot2k_templates/Kconfig
index 03100eda17075..291b29ea28db3 100644
--- a/tools/verification/dot2/dot2k_templates/Kconfig
+++ b/tools/verification/dot2/dot2k_templates/Kconfig
@@ -2,6 +2,7 @@
 #
 config RV_MON_%%MODEL_NAME_UP%%
 	depends on RV
+%%MONITOR_DEPS%%
 	select %%MONITOR_CLASS_TYPE%%
 	bool "%%MODEL_NAME%% monitor"
 	help
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 9605ca994416b..83044a20c89aa 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -15,7 +15,7 @@
  * #include <trace/events/sched.h>
  */
 #include <rv_trace.h>
-
+%%INCLUDE_PARENT%%
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
  * to touch this section.
@@ -74,7 +74,7 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%);
+	rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
 	return 0;
 }
 
diff --git a/tools/verification/dot2/dot2k_templates/main_container.c b/tools/verification/dot2/dot2k_templates/main_container.c
new file mode 100644
index 0000000000000..89fc17cf8958e
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_container.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "%%MODEL_NAME%%"
+
+#include "%%MODEL_NAME%%.h"
+
+struct rv_monitor rv_%%MODEL_NAME%%;
+
+struct rv_monitor rv_%%MODEL_NAME%% = {
+	.name = "%%MODEL_NAME%%",
+	.description = "%%DESCRIPTION%%",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_%%MODEL_NAME%%(void)
+{
+	rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
+	return 0;
+}
+
+static void __exit unregister_%%MODEL_NAME%%(void)
+{
+	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
+}
+
+module_init(register_%%MODEL_NAME%%);
+module_exit(unregister_%%MODEL_NAME%%);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/dot2/dot2k_templates/main_container.h b/tools/verification/dot2/dot2k_templates/main_container.h
new file mode 100644
index 0000000000000..0f6883ab4bcc7
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/main_container.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_%%MODEL_NAME%%;
-- 
2.48.1

