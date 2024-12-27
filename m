Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3B1F63FB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310964; cv=none; b=JPX6xy75COO7J6SJOgMR+HuMPNrTifE9b3TcbbVhvcrdOk2ngbR14/+yrpBkwJq1fFbg3Ds1xxgTmNztSA2D+zwMaSbmZZWkbkw4IX9RMYzrSF6vnqIy2dsw425kjbTUXZ6eydsNPpU0Uvdfwor8+/6Tf5pgy6o3aPm2Jj4H+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310964; c=relaxed/simple;
	bh=izmSzJZzd3CqENk/WWdffYg6nKXllgAawWCSO8C2aMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McUhtRxWO4L+yPF9xRtyNeVeBwY+g3vdYRXEcY1pEYYJzfG0xRyEL3xNmrNUPqAC4kysIywJhuuR5SXE993BPvtjb4f8yLzBq3RQLiUIiC+k3Hjh+tnsOr7lNSySMSyLhV8xuCEs9csXdvUZt869MZ7ldnGyc2eYZ61F/5RWppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mm1FOAWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm1FOAWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FU8Ngh8VR5vAwnJ5OPcLae/xFLqu3FeXfyM1lmwn70=;
	b=Mm1FOAWJ8TInNKpdFm3Yj1PHvnJ7UF+SXXIibH2ThcKJKEXf0PsH5PCreOLIuzkyCiIrxU
	tTwUJAAaC+bzbWqdjujWNMIRrbQqVaXg3pjKMCPAUrCuHOcGo/QLmvOZiF18yTVpWJkHNk
	lmiwW4fhWJ0So2sC8Y+DmKlslN4oWus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-J5Tunt0uOASzr9KrryPi4g-1; Fri,
 27 Dec 2024 09:49:15 -0500
X-MC-Unique: J5Tunt0uOASzr9KrryPi4g-1
X-Mimecast-MFC-AGG-ID: J5Tunt0uOASzr9KrryPi4g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F32719560BA;
	Fri, 27 Dec 2024 14:49:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 426F13000197;
	Fri, 27 Dec 2024 14:49:10 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 3/8] verification/dot2k: More robust template variables
Date: Fri, 27 Dec 2024 15:47:47 +0100
Message-ID: <20241227144752.362911-4-gmonaco@redhat.com>
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

The dot2k templates currently have variables that are automatically
filled by the script marked as an uppercase VARIABLE. This requires some
care while adding new variables to avoid using valid keywords and get
them unexpectedly substituted.

This patch switches the variables to the %%VARIABLE%% notation to make
the pattern substitution more robust.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k.py              | 14 +++---
 .../verification/dot2/dot2k_templates/main.c  | 50 +++++++++----------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 15d6f7048f8d4..c88b3c0117061 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -107,13 +107,13 @@ class dot2k(Dot2c):
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
 
-        main_c = main_c.replace("MONITOR_TYPE", monitor_type)
-        main_c = main_c.replace("MIN_TYPE", min_type)
-        main_c = main_c.replace("MODEL_NAME", self.name)
-        main_c = main_c.replace("NR_EVENTS", str(nr_events))
-        main_c = main_c.replace("TRACEPOINT_HANDLERS_SKEL", tracepoint_handlers)
-        main_c = main_c.replace("TRACEPOINT_ATTACH", tracepoint_attach)
-        main_c = main_c.replace("TRACEPOINT_DETACH", tracepoint_detach)
+        main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
+        main_c = main_c.replace("%%MIN_TYPE%%", min_type)
+        main_c = main_c.replace("%%MODEL_NAME%%", self.name)
+        main_c = main_c.replace("%%NR_EVENTS%%", str(nr_events))
+        main_c = main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoint_handlers)
+        main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
+        main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
 
         return main_c
 
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 2419a6f89cd89..4a05fef7f3c7f 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -8,7 +8,7 @@
 #include <rv/instrumentation.h>
 #include <rv/da_monitor.h>
 
-#define MODULE_NAME "MODEL_NAME"
+#define MODULE_NAME "%%MODEL_NAME%%"
 
 /*
  * XXX: include required tracepoint headers, e.g.,
@@ -20,15 +20,15 @@
  * This is the self-generated part of the monitor. Generally, there is no need
  * to touch this section.
  */
-#include "MODEL_NAME.h"
+#include "%%MODEL_NAME%%.h"
 
 /*
  * Declare the deterministic automata monitor.
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-static struct rv_monitor rv_MODEL_NAME;
-DECLARE_DA_MON_MONITOR_TYPE(MODEL_NAME, MIN_TYPE);
+static struct rv_monitor rv_%%MODEL_NAME%%;
+DECLARE_DA_MON_%%MONITOR_TYPE%%(%%MODEL_NAME%%, %%MIN_TYPE%%);
 
 /*
  * This is the instrumentation part of the monitor.
@@ -37,55 +37,55 @@ DECLARE_DA_MON_MONITOR_TYPE(MODEL_NAME, MIN_TYPE);
  * are translated into model's event.
  *
  */
-TRACEPOINT_HANDLERS_SKEL
-static int enable_MODEL_NAME(void)
+%%TRACEPOINT_HANDLERS_SKEL%%
+static int enable_%%MODEL_NAME%%(void)
 {
 	int retval;
 
-	retval = da_monitor_init_MODEL_NAME();
+	retval = da_monitor_init_%%MODEL_NAME%%();
 	if (retval)
 		return retval;
 
-TRACEPOINT_ATTACH
+%%TRACEPOINT_ATTACH%%
 
 	return 0;
 }
 
-static void disable_MODEL_NAME(void)
+static void disable_%%MODEL_NAME%%(void)
 {
-	rv_MODEL_NAME.enabled = 0;
+	rv_%%MODEL_NAME%%.enabled = 0;
 
-TRACEPOINT_DETACH
+%%TRACEPOINT_DETACH%%
 
-	da_monitor_destroy_MODEL_NAME();
+	da_monitor_destroy_%%MODEL_NAME%%();
 }
 
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_MODEL_NAME = {
-	.name = "MODEL_NAME",
-	.description = "auto-generated MODEL_NAME",
-	.enable = enable_MODEL_NAME,
-	.disable = disable_MODEL_NAME,
-	.reset = da_monitor_reset_all_MODEL_NAME,
+static struct rv_monitor rv_%%MODEL_NAME%% = {
+	.name = "%%MODEL_NAME%%",
+	.description = "auto-generated %%MODEL_NAME%%",
+	.enable = enable_%%MODEL_NAME%%,
+	.disable = disable_%%MODEL_NAME%%,
+	.reset = da_monitor_reset_all_%%MODEL_NAME%%,
 	.enabled = 0,
 };
 
-static int __init register_MODEL_NAME(void)
+static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_MODEL_NAME);
+	rv_register_monitor(&rv_%%MODEL_NAME%%);
 	return 0;
 }
 
-static void __exit unregister_MODEL_NAME(void)
+static void __exit unregister_%%MODEL_NAME%%(void)
 {
-	rv_unregister_monitor(&rv_MODEL_NAME);
+	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
 }
 
-module_init(register_MODEL_NAME);
-module_exit(unregister_MODEL_NAME);
+module_init(register_%%MODEL_NAME%%);
+module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("MODEL_NAME");
+MODULE_DESCRIPTION("%%MODEL_NAME%%");
-- 
2.47.1

