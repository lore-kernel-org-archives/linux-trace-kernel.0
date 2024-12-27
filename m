Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957291F63C8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310972; cv=none; b=VGQTpoAwHfcPivDf0Koj/PLSCCi0pqcmexsDwwSu8vcDsl0c9hsNqf9U9BDHk9/e8ExPrv/EwcO3vPKD/8IZ4l3weuWa226oLmT/pvSFIShDRCMNJR3wv2CK6SO9EyPvDfE+1wMaldTrAcSe4+v6QjBWhe8gimK27Hgio6oLSTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310972; c=relaxed/simple;
	bh=0kmeyOWmudtVPQ2OXLwAb9dtOPUiq4Qve8EIBvwIHMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT2xNi1KFQH9EgUZoaWt5ix+flOMDDi/CLLQDrbjFUwlVtWdQsHR9m3OzsOgaB6OBkOKgNzyG443c8jzTWZgR0l3HhcedjPH2jGGHDddwWJ8HhFNIdqP1ykqg9jfc8J7ys2NDgop8EfH4GXI4/QOfksYgdzhDcwxoqqj3ervRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ4aeiUV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ4aeiUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPoYnjkQ8AL7Lo1yZxJD9stCle93vsIwWy9gAacOuD4=;
	b=jQ4aeiUVuK7wQDDvT9UFm1F/CEv8u9rfb6cJQO30aQ5uZ3dPHchDxhXYYqs/Y6xOi0VkdJ
	0iSfQQxbnNjG4lzjmqe6XiGt5QZfKnT0OjzrKs6ZucMMUgXH5cpNSvzQhZxQx5gR8Q6aJ3
	ytGUhOLxExQuHnCOkMBgk9f6wtJdXKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-GsAhvQIyMGuSEhjF1voSkQ-1; Fri,
 27 Dec 2024 09:49:26 -0500
X-MC-Unique: GsAhvQIyMGuSEhjF1voSkQ-1
X-Mimecast-MFC-AGG-ID: GsAhvQIyMGuSEhjF1voSkQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 366C819560BD;
	Fri, 27 Dec 2024 14:49:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F405C3000197;
	Fri, 27 Dec 2024 14:49:20 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 6/8] verification/dot2k: Simplify manual steps in monitor creation
Date: Fri, 27 Dec 2024 15:47:50 +0100
Message-ID: <20241227144752.362911-7-gmonaco@redhat.com>
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

This patch reduces and simplifies the manual steps still needed in
creating a new RV monitor.

It extends the dot2k script to create a tracepoint snippet and a
Kconfig file for the newly generated monitor. Those files can be kept
in the monitor's directory but shall be included in the main tracepoint
header and Kconfig.
Together with the checklist, dot2k now suggests the lines to add to
those files for inclusion and the Makefile line to compile the new
monitor:

 Writing the monitor into the directory monitor_name
 Almost done, checklist
   - Edit the monitor_name/monitor_name.c to add the instrumentation
   - Edit kernel/trace/rv/rv_trace.h:
 Add this line where other tracepoints are included and DA_MON_EVENTS_ID is defined:
 #include <monitors/monitor_name/monitor_name_trace.h>

   - Edit kernel/trace/rv/Makefile:
 Add this line where other monitors are included:
 obj-$(CONFIG_RV_MON_MONITOR_NAME) += monitors/monitor_name/monitor_name.o

   - Edit kernel/trace/rv/Kconfig:
 Add this line where other monitors are included:
 source "kernel/trace/rv/monitors/monitor_name/Kconfig"

   - Move monitor_name/ to the kernel's monitor directory (kernel/trace/rv/monitors)

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k                 |  8 +-
 tools/verification/dot2/dot2k.py              | 86 +++++++++++++++++++
 .../verification/dot2/dot2k_templates/Kconfig |  6 ++
 .../verification/dot2/dot2k_templates/main.c  |  2 +-
 .../verification/dot2/dot2k_templates/trace.h | 13 +++
 5 files changed, 110 insertions(+), 5 deletions(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/Kconfig
 create mode 100644 tools/verification/dot2/dot2k_templates/trace.h

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 827b62b8d5e16..190c974edd0a6 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -35,7 +35,7 @@ if __name__ == '__main__':
     monitor.print_files()
     print("Almost done, checklist")
     print("  - Edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
-    print("  - Edit include/trace/events/rv.h to add the tracepoint entry")
-    print("  - Move it to the kernel's monitor directory")
-    print("  - Edit kernel/trace/rv/Makefile")
-    print("  - Edit kernel/trace/rv/Kconfig")
+    print(monitor.fill_tracepoint_tooltip())
+    print(monitor.fill_makefile_tooltip())
+    print(monitor.fill_kconfig_tooltip())
+    print("  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (monitor.name, monitor.rv_dir))
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index d48ad86a035a7..dc56cd1fb0b41 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -15,6 +15,7 @@ import os
 class dot2k(Dot2c):
     monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
     monitor_templates_dir = "dot2/dot2k_templates/"
+    rv_dir = "kernel/trace/rv"
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType, extra_params={}):
@@ -27,6 +28,8 @@ class dot2k(Dot2c):
         self.monitor_type = MonitorType
         self.__fill_rv_templates_dir()
         self.main_c = self.__open_file(self.monitor_templates_dir + "main.c")
+        self.trace_h = self.__open_file(self.monitor_templates_dir + "trace.h")
+        self.kconfig = self.__open_file(self.monitor_templates_dir + "Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
 
@@ -144,6 +147,82 @@ class dot2k(Dot2c):
 
         return self.__buff_to_string(buff)
 
+    def fill_monitor_class_type(self):
+        if self.monitor_type == "per_task":
+            return "DA_MON_EVENTS_ID"
+        return "DA_MON_EVENTS_IMPLICIT"
+
+    def fill_monitor_class(self):
+        if self.monitor_type == "per_task":
+            return "da_monitor_id"
+        return "da_monitor"
+
+    def fill_tracepoint_args_skel(self, tp_type):
+        buff = []
+        tp_args_event = [
+                ("char *", "state"),
+                ("char *", "event"),
+                ("char *", "next_state"),
+                ("bool ",  "final_state"),
+                ]
+        tp_args_error = [
+                ("char *", "state"),
+                ("char *", "event"),
+                ]
+        tp_args_id = ("int ", "id")
+        tp_args = tp_args_event if tp_type == "event" else tp_args_error
+        if self.monitor_type == "per_task":
+            tp_args.insert(0, tp_args_id)
+        tp_proto_c = ", ".join([a+b for a,b in tp_args])
+        tp_args_c = ", ".join([b for a,b in tp_args])
+        buff.append("	     TP_PROTO(%s)," % tp_proto_c)
+        buff.append("	     TP_ARGS(%s)" % tp_args_c)
+        return self.__buff_to_string(buff)
+
+    def fill_trace_h(self):
+        trace_h = self.trace_h
+        monitor_class = self.fill_monitor_class()
+        monitor_class_type = self.fill_monitor_class_type()
+        tracepoint_args_skel_event = self.fill_tracepoint_args_skel("event")
+        tracepoint_args_skel_error = self.fill_tracepoint_args_skel("error")
+        trace_h = trace_h.replace("%%MODEL_NAME%%", self.name)
+        trace_h = trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        trace_h = trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
+        trace_h = trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
+        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", tracepoint_args_skel_event)
+        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", tracepoint_args_skel_error)
+        return trace_h
+
+    def fill_kconfig(self):
+        kconfig = self.kconfig
+        monitor_class_type = self.fill_monitor_class_type()
+        kconfig = kconfig.replace("%%MODEL_NAME%%", self.name)
+        kconfig = kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        kconfig = kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
+        kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
+        return kconfig
+
+    def fill_tracepoint_tooltip(self):
+        monitor_class_type = self.fill_monitor_class_type()
+        return """  - Edit %s/rv_trace.h:
+Add this line where other tracepoints are included and %s is defined:
+#include <monitors/%s/%s_trace.h>
+""" % (self.rv_dir, monitor_class_type, self.name, self.name)
+
+    def fill_kconfig_tooltip(self):
+        return """  - Edit %s/Kconfig:
+Add this line where other monitors are included:
+source \"kernel/trace/rv/monitors/%s/Kconfig\"
+""" % (self.rv_dir, self.name)
+
+    def fill_makefile_tooltip(self):
+        name = self.name
+        name_up = name.upper()
+        return """  - Edit %s/Makefile:
+Add this line where other monitors are included:
+obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
+""" % (self.rv_dir, name_up, name, name)
+
     def __create_directory(self):
         try:
             os.mkdir(self.name)
@@ -182,3 +261,10 @@ class dot2k(Dot2c):
 
         path = "%s.h" % self.name
         self.__create_file(path, model_h)
+
+        trace_h = self.fill_trace_h()
+        path = "%s_trace.h" % self.name
+        self.__create_file(path, trace_h)
+
+        kconfig = self.fill_kconfig()
+        self.__create_file("Kconfig", kconfig)
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/dot2/dot2k_templates/Kconfig
new file mode 100644
index 0000000000000..90cdc1e9379e1
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/Kconfig
@@ -0,0 +1,6 @@
+config RV_MON_%%MODEL_NAME_UP%%
+	depends on RV
+	select %%MONITOR_CLASS_TYPE%%
+	bool "%%MODEL_NAME%% monitor"
+	help
+	  %%DESCRIPTION%%
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 7046171685788..9605ca994416b 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -14,7 +14,7 @@
  * XXX: include required tracepoint headers, e.g.,
  * #include <trace/events/sched.h>
  */
-#include <trace/events/rv.h>
+#include <rv_trace.h>
 
 /*
  * This is the self-generated part of the monitor. Generally, there is no need
diff --git a/tools/verification/dot2/dot2k_templates/trace.h b/tools/verification/dot2/dot2k_templates/trace.h
new file mode 100644
index 0000000000000..87d3a1308926f
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/trace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
+DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
+%%TRACEPOINT_ARGS_SKEL_EVENT%%);
+
+DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
+%%TRACEPOINT_ARGS_SKEL_ERROR%%);
+#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
-- 
2.47.1

