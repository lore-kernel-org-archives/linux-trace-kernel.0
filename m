Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097F2701A4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563749; cv=none; b=PuZZUxhAkvI+ar0lOvisekziU16GUDoNtkPxNEFz4UGgKVul2zvsjOajNq9aiCW48IOHLCiNIljvjL9d7qdT1qLoKQRMPwtZpiWJVCI09GvGbTGHz16QG1bsUKfAwSR2svTDhEZY7FuQRSHdjdPd6AxpNdbv8sRYbXpis6YcXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563749; c=relaxed/simple;
	bh=J2yEY9Nc8Fu2hSChIEPzOyAPv2+jUKzd7jotRyGXpm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnqGh8pyyaGrD80k15BKvD0NpXML2yVbDzjS4zbg+9mEXs6f+TgfEoAymx8SBhKIdsy/GmYFNxRBHOKGj63FhmHUFJwQWY7GLMMOjC2ABa+FQh00SurmbSdeIXqlvcyGnGhqQsBJ4Gkm6SRNw/EL/BrTXr58v0EdAwMo410X590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cwz0bh4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwz0bh4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ6+HKyJlDZw/hLSrbNr0osMJhJyvawRkvD8/BLpv+c=;
	b=Cwz0bh4uASnMUPfQRq4TQSf7CB/GHghvA7xDJy2caV0vV+1L0oI3SHU2E0Ld7trynKAoXE
	y55vzKg1u6MHSqUGZMZy9EFFiRNfSskljP0z6Gz/dUPho2HHUnMoAZKccxTmukYj2rS3RS
	wWMXzKJh594jY2ksvdbE7SctSIdy26o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-HZEyLyZsPo2Adgs2zFd68Q-1; Tue,
 15 Jul 2025 03:15:43 -0400
X-MC-Unique: HZEyLyZsPo2Adgs2zFd68Q-1
X-Mimecast-MFC-AGG-ID: HZEyLyZsPo2Adgs2zFd68Q_1752563742
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6064C195608C;
	Tue, 15 Jul 2025 07:15:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF19D180035E;
	Tue, 15 Jul 2025 07:15:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 08/17] verification/rvgen: Organise Kconfig entries for nested monitors
Date: Tue, 15 Jul 2025 09:14:25 +0200
Message-ID: <20250715071434.22508-9-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                     |  5 +++++
 tools/verification/rvgen/rvgen/container.py | 13 +++++++++++++
 tools/verification/rvgen/rvgen/generator.py | 13 ++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index c11bf7e61ebf0..26017378f79b8 100644
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
index 47d8ab2ad3ec4..fee493f89fde6 100644
--- a/tools/verification/rvgen/rvgen/container.py
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -20,3 +20,16 @@ class Container(generator.RVGenerator):
         main_h = self.main_h
         main_h = main_h.replace("%%MODEL_NAME%%", self.name)
         return main_h
+
+    def fill_kconfig_tooltip(self):
+        """Override to produce a marker for this container in the Kconfig"""
+        container_marker = f"# Add new {self.name} monitors here\n"
+        if self.auto_patch:
+            self._patch_file("Kconfig",
+                            "# Add new monitors here", "")
+        result = super().fill_kconfig_tooltip()
+        if self.auto_patch:
+            self._patch_file("Kconfig",
+                            "# Add new monitors here", container_marker)
+            return result
+        return result + container_marker
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 19d0078a38032..ac97c4505ff00 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -137,7 +137,8 @@ class RVGenerator:
         kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
-    def __patch_file(self, file, marker, line):
+    def _patch_file(self, file, marker, line):
+        assert(self.auto_patch)
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
@@ -158,8 +159,10 @@ Add this line where other tracepoints are included and %s is defined:
 
     def fill_kconfig_tooltip(self):
         if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
+            # monitors with a container should stay together in the Kconfig
+            self._patch_file("Kconfig",
+                            "# Add new %smonitors here" %
+                              (self.parent + " " if self.parent else ""),
                             "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
             return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
 
@@ -172,7 +175,7 @@ source \"kernel/trace/rv/monitors/%s/Kconfig\"
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

