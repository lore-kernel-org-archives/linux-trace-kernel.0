Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA521C19A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184137; cv=none; b=iqb+TA2RcBHZSe4LYhQVY+JgsMzbTxvbxlkSzOE4L9BnvxB+M/hcKIdFCVmKNpS6VDF057NxyMgNvv7Cbrw/pHCT5To6bgmk7TbpLJVR40RWxIrgZ1S2au2F/W6WbqIoYNLc7GafmjCTQnrCM0vgU+hSndA9EjDnjFrjTGmIQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184137; c=relaxed/simple;
	bh=BQuuF/m48mqxqBW4OTWlVJMPNfADUK+WR7ewpHKVei4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8KCS7pR9tf/VohNJZ8FI4MJySzgc5XRGm8oAzRYGyerstxUTo/+Zq1aOQzMIiGTRDQodOmgXl1mY303lRy4TOckD6d+DixJFnPXPP9mVdZB5RhtbZgbYDKj4wESwjecY8Gm9gq3e+kQ3TchjRBK7784a6TIe1+e0YtPkjdT2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5Dx6TgZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Dx6TgZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psBVSxqXLnc1DsK/Ni3tlWaJk27BOGfou6qbx9P9nYM=;
	b=A5Dx6TgZWgRGadDTPwxFdPzGpCJsWTi/WvzvgfqadKqgtZXv0SpwEGPqOD6MC203hrmw+U
	1GjzAY9lzrf6vP2SYNDc0N6HDoPMzGobNxvC00sgpoIYEJfLbtX5cBfq1Wryg5t9kgqcfh
	1KUmoNClpPABx5feWMdHrwProKQhICk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-t30n1DpHNlWpq7BDkBZwkw-1; Thu,
 14 Aug 2025 11:08:51 -0400
X-MC-Unique: t30n1DpHNlWpq7BDkBZwkw-1
X-Mimecast-MFC-AGG-ID: t30n1DpHNlWpq7BDkBZwkw_1755184129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A580C1954236;
	Thu, 14 Aug 2025 15:08:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D1071800295;
	Thu, 14 Aug 2025 15:08:45 +0000 (UTC)
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
Subject: [RFC PATCH 04/17] verification/rvgen: Adapt dot2k and templates after refactoring da_monitor.h
Date: Thu, 14 Aug 2025 17:07:56 +0200
Message-ID: <20250814150809.140739-5-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py         |  6 ++++--
 .../rvgen/rvgen/templates/dot2k/main.c          | 17 +++++------------
 2 files changed, 9 insertions(+), 14 deletions(-)

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
index e0fd1134bd85..f14a0e7ad56b 100644
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
 
@@ -57,7 +50,7 @@ static void disable_%%MODEL_NAME%%(void)
 
 %%TRACEPOINT_DETACH%%
 
-	da_monitor_destroy_%%MODEL_NAME%%();
+	da_monitor_destroy();
 }
 
 /*
@@ -68,7 +61,7 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 	.description = "%%DESCRIPTION%%",
 	.enable = enable_%%MODEL_NAME%%,
 	.disable = disable_%%MODEL_NAME%%,
-	.reset = da_monitor_reset_all_%%MODEL_NAME%%,
+	.reset = da_monitor_reset_all,
 	.enabled = 0,
 };
 
-- 
2.50.1

