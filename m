Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB271F37A1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287207; cv=none; b=S6jU4+2FNp2cUlcCbkweFIE6FfiW/ApuNZ3tz3M4av3GYZGqjNy75o8fbnYvUHg1fppkeC3deuDaLR3sOh80HE5Dqh9Gx29Gp/RQG/M7+X3RUh/8lLwElKHWuOlgBmnPFj+NmyaKHEV4Hx9jVf+Zo5ZjSo+gbLma85wp8c82av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287207; c=relaxed/simple;
	bh=DYZmPuzb15xJEMPgrAmgf6GdY2yK3Kj27QdvencHLBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+eEGFJeguWK3/iBeu9vAafDDO+grefRBZq4CPWoZRuOTWVpZfDnZow22fMokEQFihzQEjpCSkPPgxgaK43yXxenjsVQgK0WQOKiExhbmYq3q6Kghquw81qJU6/3k3bhZsj1BJ4l6wrq4BkbYYku0D/ufIeN0d4BfBC/CWQ3Bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo5NMuwR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo5NMuwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753287202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKf0BXtvYlThA6N3H9zThoS+bmPeP3x7CvA45X4uE9M=;
	b=Fo5NMuwRzNaPQjHQJqnERUUjvLwAMcvWzUAVRMZLf0XxIvRm9jHiQSbUgEDRJsb08rvngY
	4Ch6fTsHwqcQWk4W2KxeTPzO/r9vFZy7G+BJFbRsZtz6NnENMY9PiVESCZ4lzhnHXonTCT
	X9BZLjSua6QTVKN12BBwx9NViMEcOg0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-UKWywS3fPK69OOnLLm49Jw-1; Wed,
 23 Jul 2025 12:13:19 -0400
X-MC-Unique: UKWywS3fPK69OOnLLm49Jw-1
X-Mimecast-MFC-AGG-ID: UKWywS3fPK69OOnLLm49Jw_1753287196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7FCB195608E;
	Wed, 23 Jul 2025 16:13:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42E4A1801712;
	Wed, 23 Jul 2025 16:13:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/5] verification/rvgen: Organise Kconfig entries for nested monitors
Date: Wed, 23 Jul 2025 18:12:39 +0200
Message-ID: <20250723161240.194860-5-gmonaco@redhat.com>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The current behaviour of rvgen when running with the -a option is to
append the necessary lines at the end of the configuration for Kconfig,
Makefile and tracepoints.
This is not always the desired behaviour in case of nested monitors:
while tracepoints are not affected by nesting and the Makefile's only
requirement is that the parent monitor is built before its children, in
the Kconfig it is better to have children defined right after their
parent, otherwise the result has wrong indentation:

[*]   foo_parent monitor
[*]     foo_child1 monitor
[*]     foo_child2 monitor
[*]   bar_parent monitor
[*]     bar_child1 monitor
[*]     bar_child2 monitor
[*]   foo_child3 monitor
[*]   foo_child4 monitor

Adapt rvgen to look for a different marker for nested monitors in the
Kconfig file and append the line right after the last sibling, instead
of the last monitor.
Also add the marker when creating a new parent monitor.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                     |  5 +++++
 tools/verification/rvgen/rvgen/container.py | 10 ++++++++++
 tools/verification/rvgen/rvgen/generator.py | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index c11bf7e61ebf..26017378f79b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -43,6 +43,7 @@ config RV_PER_TASK_MONITORS
 
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
+
 source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
@@ -50,9 +51,13 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
+# Add new sched monitors here
+
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
+# Add new rtapp monitors here
+
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verification/rvgen/rvgen/container.py
index 47d8ab2ad3ec..51f188530b4d 100644
--- a/tools/verification/rvgen/rvgen/container.py
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -20,3 +20,13 @@ class Container(generator.RVGenerator):
         main_h = self.main_h
         main_h = main_h.replace("%%MODEL_NAME%%", self.name)
         return main_h
+
+    def fill_kconfig_tooltip(self):
+        """Override to produce a marker for this container in the Kconfig"""
+        container_marker = self._kconfig_marker(self.name) + "\n"
+        result = super().fill_kconfig_tooltip()
+        if self.auto_patch:
+            self._patch_file("Kconfig",
+                             self._kconfig_marker(), container_marker)
+            return result
+        return result + container_marker
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 19d0078a3803..3441385c1177 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -137,7 +137,8 @@ class RVGenerator:
         kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
-    def __patch_file(self, file, marker, line):
+    def _patch_file(self, file, marker, line):
+        assert self.auto_patch
         file_to_patch = os.path.join(self.rv_dir, file)
         content = self._read_file(file_to_patch)
         content = content.replace(marker, line + "\n" + marker)
@@ -146,7 +147,7 @@ class RVGenerator:
     def fill_tracepoint_tooltip(self):
         monitor_class_type = self.fill_monitor_class_type()
         if self.auto_patch:
-            self.__patch_file("rv_trace.h",
+            self._patch_file("rv_trace.h",
                             "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
                             "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
             return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
@@ -156,10 +157,15 @@ Add this line where other tracepoints are included and %s is defined:
 #include <monitors/%s/%s_trace.h>
 """ % (self.rv_dir, monitor_class_type, self.name, self.name)
 
+    def _kconfig_marker(self, container=None) -> str:
+        return "# Add new %smonitors here" % (container + " "
+                                              if container else "")
+
     def fill_kconfig_tooltip(self):
         if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
+            # monitors with a container should stay together in the Kconfig
+            self._patch_file("Kconfig",
+                             self._kconfig_marker(self.parent),
                             "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
             return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
 
@@ -172,7 +178,7 @@ source \"kernel/trace/rv/monitors/%s/Kconfig\"
         name = self.name
         name_up = name.upper()
         if self.auto_patch:
-            self.__patch_file("Makefile",
+            self._patch_file("Makefile",
                             "# Add new monitors here",
                             "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
             return "  - Patching %s/Makefile, double check the result" % self.rv_dir
-- 
2.50.1

