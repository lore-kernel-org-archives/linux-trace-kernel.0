Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CD1DB349
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201267; cv=none; b=YcAe1aFOa3LWXj/DP6ZZ9n4hs+a7vv4GviaaYhi0I5vsV9YCxTaiJRCxZXvK/CvEK4zyPtlkAU9BWMi9baRTsU/gVuL+MmkYMWeYZFLcjjdBgtGnAiR9gg43qKBs5CKAwTqQLrrZp+ITB4vfqauTQpY15HYo5x1lfcKfPaoNR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201267; c=relaxed/simple;
	bh=bCCoj9HpNs7DIrglTatp/QGtkbe2RnayL82gl5i+lwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2C9DPTqPxIs/0aMlqLPQe8j2RCBSeMESDPtaW9qpJc+A6OoBDSB6DaI5BiSzNmVxu0ATN8YburSM+ObcNETvPljB5VnCopHkBtcy+61bE2kEd3K9SK8W5WmDBZwWU/NUtoEs/cP8jhFA7SMsoE9NP5QsBw/wad0DOGfm71KSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2N2w5eQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2N2w5eQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LD4X0OQB8y8IQ9VbB0WvQsZxXCBPkNmPUv1WsVYigSE=;
	b=J2N2w5eQ4xRlnkzSVpPnAAmeoKB1iK5Mnl4VVGV7IPhsJo5Q9wkZG3qWzTBpP1xd+kfxhG
	DSvemyi1HZZgAayfQUJoMlTSsE4Ul+m52nKt3/+O73r0hG5py4P8ug8bag+Oc0pIjeLA6U
	HhWAdMuDpP4fHKghUYcNJ3/QWfTpxfM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-CLgKzTzdPo2UxEiCqExREQ-1; Thu,
 21 Nov 2024 10:01:00 -0500
X-MC-Unique: CLgKzTzdPo2UxEiCqExREQ-1
X-Mimecast-MFC-AGG-ID: CLgKzTzdPo2UxEiCqExREQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C968619560A2;
	Thu, 21 Nov 2024 15:00:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77FDD30000DF;
	Thu, 21 Nov 2024 15:00:57 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 2/4] verification/dot2k: Unify main.c templates
Date: Thu, 21 Nov 2024 15:59:55 +0100
Message-ID: <20241121145957.145700-3-gmonaco@redhat.com>
In-Reply-To: <20241121145957.145700-1-gmonaco@redhat.com>
References: <20241121145957.145700-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch removes the 3 dot2k templates and replaces them with a more
general one. The only difference among the 3 templates was the
`DECLARE_DA_MON_*` call, which can be adjusted by the python code.

This change eases changing the templates, which will be done in
following patches.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k.py              |  7 +-
 .../dot2k_templates/{main_global.c => main.c} |  2 +-
 .../dot2/dot2k_templates/main_per_cpu.c       | 91 -------------------
 .../dot2/dot2k_templates/main_per_task.c      | 91 -------------------
 4 files changed, 7 insertions(+), 184 deletions(-)
 rename tools/verification/dot2/dot2k_templates/{main_global.c => main.c} (97%)
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index f6d02e3406a3..15d6f7048f8d 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -26,7 +26,7 @@ class dot2k(Dot2c):
 
         self.monitor_type = MonitorType
         self.__fill_rv_templates_dir()
-        self.main_c = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".c")
+        self.main_c = self.__open_file(self.monitor_templates_dir + "main.c")
         self.enum_suffix = "_%s" % self.name
 
     def __fill_rv_templates_dir(self):
@@ -69,6 +69,9 @@ class dot2k(Dot2c):
         # cut off the last \n
         return string[:-1]
 
+    def fill_monitor_type(self):
+        return self.monitor_type.upper()
+
     def fill_tracepoint_handlers_skel(self):
         buff = []
         for event in self.events:
@@ -97,12 +100,14 @@ class dot2k(Dot2c):
 
     def fill_main_c(self):
         main_c = self.main_c
+        monitor_type = self.fill_monitor_type()
         min_type = self.get_minimun_type()
         nr_events = len(self.events)
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
 
+        main_c = main_c.replace("MONITOR_TYPE", monitor_type)
         main_c = main_c.replace("MIN_TYPE", min_type)
         main_c = main_c.replace("MODEL_NAME", self.name)
         main_c = main_c.replace("NR_EVENTS", str(nr_events))
diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main.c
similarity index 97%
rename from tools/verification/dot2/dot2k_templates/main_global.c
rename to tools/verification/dot2/dot2k_templates/main.c
index a5658bfb9044..2419a6f89cd8 100644
--- a/tools/verification/dot2/dot2k_templates/main_global.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -28,7 +28,7 @@
  * The rv monitor reference is needed for the monitor declaration.
  */
 static struct rv_monitor rv_MODEL_NAME;
-DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
+DECLARE_DA_MON_MONITOR_TYPE(MODEL_NAME, MIN_TYPE);
 
 /*
  * This is the instrumentation part of the monitor.
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
deleted file mode 100644
index 03539a97633f..000000000000
--- a/tools/verification/dot2/dot2k_templates/main_per_cpu.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ftrace.h>
-#include <linux/tracepoint.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/rv.h>
-#include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
-
-#define MODULE_NAME "MODEL_NAME"
-
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
-#include <trace/events/rv.h>
-
-/*
- * This is the self-generated part of the monitor. Generally, there is no need
- * to touch this section.
- */
-#include "MODEL_NAME.h"
-
-/*
- * Declare the deterministic automata monitor.
- *
- * The rv monitor reference is needed for the monitor declaration.
- */
-static struct rv_monitor rv_MODEL_NAME;
-DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
-
-/*
- * This is the instrumentation part of the monitor.
- *
- * This is the section where manual work is required. Here the kernel events
- * are translated into model's event.
- *
- */
-TRACEPOINT_HANDLERS_SKEL
-static int enable_MODEL_NAME(void)
-{
-	int retval;
-
-	retval = da_monitor_init_MODEL_NAME();
-	if (retval)
-		return retval;
-
-TRACEPOINT_ATTACH
-
-	return 0;
-}
-
-static void disable_MODEL_NAME(void)
-{
-	rv_MODEL_NAME.enabled = 0;
-
-TRACEPOINT_DETACH
-
-	da_monitor_destroy_MODEL_NAME();
-}
-
-/*
- * This is the monitor register section.
- */
-static struct rv_monitor rv_MODEL_NAME = {
-	.name = "MODEL_NAME",
-	.description = "auto-generated MODEL_NAME",
-	.enable = enable_MODEL_NAME,
-	.disable = disable_MODEL_NAME,
-	.reset = da_monitor_reset_all_MODEL_NAME,
-	.enabled = 0,
-};
-
-static int __init register_MODEL_NAME(void)
-{
-	rv_register_monitor(&rv_MODEL_NAME);
-	return 0;
-}
-
-static void __exit unregister_MODEL_NAME(void)
-{
-	rv_unregister_monitor(&rv_MODEL_NAME);
-}
-
-module_init(register_MODEL_NAME);
-module_exit(unregister_MODEL_NAME);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
deleted file mode 100644
index ffd92af87a86..000000000000
--- a/tools/verification/dot2/dot2k_templates/main_per_task.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ftrace.h>
-#include <linux/tracepoint.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/rv.h>
-#include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
-
-#define MODULE_NAME "MODEL_NAME"
-
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
-#include <trace/events/rv.h>
-
-/*
- * This is the self-generated part of the monitor. Generally, there is no need
- * to touch this section.
- */
-#include "MODEL_NAME.h"
-
-/*
- * Declare the deterministic automata monitor.
- *
- * The rv monitor reference is needed for the monitor declaration.
- */
-static struct rv_monitor rv_MODEL_NAME;
-DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
-
-/*
- * This is the instrumentation part of the monitor.
- *
- * This is the section where manual work is required. Here the kernel events
- * are translated into model's event.
- *
- */
-TRACEPOINT_HANDLERS_SKEL
-static int enable_MODEL_NAME(void)
-{
-	int retval;
-
-	retval = da_monitor_init_MODEL_NAME();
-	if (retval)
-		return retval;
-
-TRACEPOINT_ATTACH
-
-	return 0;
-}
-
-static void disable_MODEL_NAME(void)
-{
-	rv_MODEL_NAME.enabled = 0;
-
-TRACEPOINT_DETACH
-
-	da_monitor_destroy_MODEL_NAME();
-}
-
-/*
- * This is the monitor register section.
- */
-static struct rv_monitor rv_MODEL_NAME = {
-	.name = "MODEL_NAME",
-	.description = "auto-generated MODEL_NAME",
-	.enable = enable_MODEL_NAME,
-	.disable = disable_MODEL_NAME,
-	.reset = da_monitor_reset_all_MODEL_NAME,
-	.enabled = 0,
-};
-
-static int __init register_MODEL_NAME(void)
-{
-	rv_register_monitor(&rv_MODEL_NAME);
-	return 0;
-}
-
-static void __exit unregister_MODEL_NAME(void)
-{
-	rv_unregister_monitor(&rv_MODEL_NAME);
-}
-
-module_init(register_MODEL_NAME);
-module_exit(unregister_MODEL_NAME);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("MODEL_NAME");
-- 
2.47.0

