Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F0313D77
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291043; cv=none; b=cUz8t3EM+WhIJvRYV2DSHnHyAZbDQzRR1BxMhOxatL9qPLz8AreIXFFXSqtEWMub8x4B300f2uTWfItdsoDcyjkamRTU7tcrzaR0d3xGcYTCbOQrDYE595KzBx5fi27i8/ZY9Njv2dy6bmlXAgXnVTdA2E7yOa3hR8rATwLo9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291043; c=relaxed/simple;
	bh=2uSBSg0z7FhoX9dqTh8jGB8J5LqRgK//nnURVbzGQtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atqe2D7cIHxdgB94M4kRBQxt1SsRh7FRtLrmFkMqBM9hA84QJQB4+sPPNQ0xd1mHQwnCHvz63sdJmOsxaQARcPKU9TfefHNjntcG2t1Ut8Yudu170y9QoAJ2bqat+F7bgR24W4LgZTNHa1rGpx23IyUbOhSZ6U4FPL96v5yiXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TI+bJVUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI+bJVUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HMYLiAFpFotYVpVQjm+Gz4VQgdX+S8E9nRk/0uOuUs=;
	b=TI+bJVUUlEBQzkuLclgzDd08tkK7gUW9DWpgTiy4kZnXrIsxOSsE7DdXs0twVI0N7oLPgV
	KcYwQGJXOKy/qeszFDDJHB2Bc2Cnk0WbmNps7zfMay+/mOk3Mek+Q2v8XFKa6QNP9j76zq
	hHIMH8XHtgSW1D0SGHbygNw9Cka3k78=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-_5-Q0K7aNJKWS7K_isbbQA-1; Fri,
 19 Sep 2025 10:10:37 -0400
X-MC-Unique: _5-Q0K7aNJKWS7K_isbbQA-1
X-Mimecast-MFC-AGG-ID: _5-Q0K7aNJKWS7K_isbbQA_1758291035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69FD11955E70;
	Fri, 19 Sep 2025 14:10:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D2761955F6A;
	Fri, 19 Sep 2025 14:10:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 05/20] verification/rvgen: Adapt dot2k and templates after refactoring da_monitor.h
Date: Fri, 19 Sep 2025 16:09:39 +0200
Message-ID: <20250919140954.104920-6-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Previous changes refactored the da_monitor header file to avoid using
macros. This implies a few changes in how to import and use da_monitor
helpers:

 DECLARE_DA_MON_<TYPE>(name, type) is substituted by
 #define RV_MON_TYPE RV_MON_<TYPE>

Update the rvgen templates to reflect the changes.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py       |  6 +++--
 .../rvgen/rvgen/templates/dot2k/main.c        | 25 +++++++------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index ed0a3c901106..d618a842fc52 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -38,9 +38,9 @@ class dot2k(Monitor, Dot2c):
                 handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append("\tda_%s_%s(p, %s%s);" % (handle, self.name, event, self.enum_suffix));
+                buff.append("\tda_%s(p, %s%s);" % (handle, event, self.enum_suffix));
             else:
-                buff.append("\tda_%s_%s(%s%s);" % (handle, self.name, event, self.enum_suffix));
+                buff.append("\tda_%s(%s%s);" % (handle, event, self.enum_suffix));
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
@@ -66,6 +66,8 @@ class dot2k(Monitor, Dot2c):
         buff.append(" *   Documentation/trace/rv/deterministic_automata.rst")
         buff.append(" */")
         buff.append("")
+        buff.append("#define MONITOR_NAME %s" % (self.name))
+        buff.append("")
 
         return buff
 
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index e0fd1134bd85..a14e4f0883db 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 #include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
 
 #define MODULE_NAME "%%MODEL_NAME%%"
 
@@ -20,15 +19,9 @@
  * This is the self-generated part of the monitor. Generally, there is no need
  * to touch this section.
  */
+#define RV_MON_TYPE RV_MON_%%MONITOR_TYPE%%
 #include "%%MODEL_NAME%%.h"
-
-/*
- * Declare the deterministic automata monitor.
- *
- * The rv monitor reference is needed for the monitor declaration.
- */
-static struct rv_monitor rv_%%MODEL_NAME%%;
-DECLARE_DA_MON_%%MONITOR_TYPE%%(%%MODEL_NAME%%, %%MIN_TYPE%%);
+#include <rv/da_monitor.h>
 
 /*
  * This is the instrumentation part of the monitor.
@@ -42,7 +35,7 @@ static int enable_%%MODEL_NAME%%(void)
 {
 	int retval;
 
-	retval = da_monitor_init_%%MODEL_NAME%%();
+	retval = da_monitor_init();
 	if (retval)
 		return retval;
 
@@ -53,33 +46,33 @@ static int enable_%%MODEL_NAME%%(void)
 
 static void disable_%%MODEL_NAME%%(void)
 {
-	rv_%%MODEL_NAME%%.enabled = 0;
+	rv_this.enabled = 0;
 
 %%TRACEPOINT_DETACH%%
 
-	da_monitor_destroy_%%MODEL_NAME%%();
+	da_monitor_destroy();
 }
 
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_%%MODEL_NAME%% = {
+static struct rv_monitor rv_this = {
 	.name = "%%MODEL_NAME%%",
 	.description = "%%DESCRIPTION%%",
 	.enable = enable_%%MODEL_NAME%%,
 	.disable = disable_%%MODEL_NAME%%,
-	.reset = da_monitor_reset_all_%%MODEL_NAME%%,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	return rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
+	return rv_register_monitor(&rv_this, %%PARENT%%);
 }
 
 static void __exit unregister_%%MODEL_NAME%%(void)
 {
-	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_%%MODEL_NAME%%);
-- 
2.51.0

