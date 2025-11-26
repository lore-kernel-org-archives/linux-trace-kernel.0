Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074F28B3E7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153795; cv=none; b=t44QrM5iwnPvjDiXBwSQjtjhrvyv+VVEP7NX0H/0fwQ7713FWvDHuvEcMFQxS+auhdsL7Y5gbzdCX6En6FenlpH6NJaNzooZmuEoobwP1MJY/AGHxVdnOWHfYqsP1tExbDWNwhHCQmsd7lJkYu3ygaeTzC7NgSORdRDhv5WTv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153795; c=relaxed/simple;
	bh=/UDn/5W83lvFD9h5OF95CDwRpH09gcN0aa8tdQ3XRJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqKjTQlsL66zuD07YDHt9mfAFVSfqI/3qmAXfyFmxMiVwY8hLdBsOBFMfm4Xs1Bw0dZs8g+XBu5X+c5AS38MF9JoQwKfFNMdcuvPuiNulb7dE6Hbpfb7GZKT0PaKtkb6sLu/Hmi0SvdZ+xItYPs1TLMImjYmhg62YAGwj5SH5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhHmgSnC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhHmgSnC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bTjsWcAgyFzINUHOD7EuUUEsT8+XkRCCX/wli3bZHI=;
	b=NhHmgSnC4AfqpdeTCgte2Ieabt25kpHAZhJjgtxuZZkgjvuqTyQ1M3yTRrHMpLWVmT3930
	/bux9/YLk7S/wJf13UOZMqaeGTIoYcionKhIBYSyP+RzyeLWbpCr6wIMN9p8vxIeTSPqpK
	juQE4KY9SCGcb/cOq8GhTPNKaW+IF5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-_i5J454BO4i0RBTs4RSNfg-1; Wed,
 26 Nov 2025 05:43:06 -0500
X-MC-Unique: _i5J454BO4i0RBTs4RSNfg-1
X-Mimecast-MFC-AGG-ID: _i5J454BO4i0RBTs4RSNfg_1764153785
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B81EE18002C5;
	Wed, 26 Nov 2025 10:43:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41BC51800298;
	Wed, 26 Nov 2025 10:43:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 4/8] verification/rvgen: Adapt dot2k and templates after refactoring da_monitor.h
Date: Wed, 26 Nov 2025 11:42:35 +0100
Message-ID: <20251126104241.291258-5-gmonaco@redhat.com>
In-Reply-To: <20251126104241.291258-1-gmonaco@redhat.com>
References: <20251126104241.291258-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Previous changes refactored the da_monitor header file to avoid using
macros. This implies a few changes in how to import and use da_monitor
helpers:

 DECLARE_DA_MON_<TYPE>(name, type) is substituted by
 #define RV_MON_TYPE RV_MON_<TYPE>

Update the rvgen templates to reflect the changes.

Reviewed-by: Nam Cao <namcao@linutronix.de>
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
2.51.1

