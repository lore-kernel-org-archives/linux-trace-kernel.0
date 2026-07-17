Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111A36C588
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303234; cv=none; b=FHa5yA0/W9J8qFMUmVlky6H9CCHlazBLeSHU8E6vlPf0cl/Edwuhpme2DTUAF3IMBpAJXGK6iqehDC0h7q+Qf1hEKvXKiNnsaJjZWtJtWOMH0uF8LUoYIeJHReX8mv9/IbHCRAZ0i72oG6Hb/v74HQcAQ9GGzcAq9KW0WGXSPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303234; c=relaxed/simple;
	bh=juRSUQH49mutSlw9dHVHjZYx+yd8pmfuE+wPZU8INnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G/yUxdeyP0tjShAGZ6IdY+a+FWsh8C9OR4n0kmv9tIbL8fKHgUiEkq1vHZtI4OuuXqh6RTRYbyVWR4lQCNmrBqgZXlotJcEtajqonwQOewnSSFjVk28WNiiByuN1mPkf7Zt83butet9VfwnC9/H1XGHQaa1mSh+r3u+GFMK/o40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeUTN985; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeUTN985"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmUSuZjVzHE1hMQrcBQZVjUHguf58xO1cn06OsAaV8E=;
	b=NeUTN985U8L9rjmFssSGNsLcnuS1PYV0TpBFEZFEO4MPJKhOlqlOO0QGYwwUBdJEwd0HO/
	6zB9DOZcI28f7+a0qrji1tMTVKieGgzu9PNpaOHfG9c3Q2R5ZaDR5mM8KHilw3jVXLaKed
	39gXL4dIYxVFNjCvmwV7JiQd1A+V+D8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-yaWMW0U-Nx2nLi3faZL6qg-1; Fri,
 17 Jul 2026 11:47:07 -0400
X-MC-Unique: yaWMW0U-Nx2nLi3faZL6qg-1
X-Mimecast-MFC-AGG-ID: yaWMW0U-Nx2nLi3faZL6qg_1784303225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925D11800A40;
	Fri, 17 Jul 2026 15:47:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6641E30040BF;
	Fri, 17 Jul 2026 15:47:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 01/17] rv: Use generic rv_this for the rv_monitor variable in LTL
Date: Fri, 17 Jul 2026 17:46:22 +0200
Message-ID: <20260717154638.220789-2-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 51ibi3_u_ZqY8hCqng1REkWQB-JNajR-_YBPyWJR6p0_1784303225
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Align the rv_monitor variable name in LTL to the generic rv_this as it
is already done for DA/HA monitors. This improves consistency and eases
assumptions across model classes.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ltl_monitor.h                              | 5 ++---
 kernel/trace/rv/monitors/pagefault/pagefault.c        | 6 +++---
 kernel/trace/rv/monitors/sleep/sleep.c                | 6 +++---
 tools/verification/rvgen/rvgen/templates/ltl2k/main.c | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 38e792401f76..56e83edcf0c4 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -16,8 +16,7 @@
 #error "Please include $(MODEL_NAME).h generated by rvgen"
 #endif
 
-#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
-static struct rv_monitor RV_MONITOR_NAME;
+static struct rv_monitor rv_this;
 
 static int ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
 
@@ -85,7 +84,7 @@ static void ltl_monitor_destroy(void)
 static void ltl_illegal_state(struct task_struct *task, struct ltl_monitor *mon)
 {
 	CONCATENATE(trace_error_, MONITOR_NAME)(task);
-	rv_react(&RV_MONITOR_NAME, "rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
+	rv_react(&rv_this, "rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
 		 task->comm, task->pid);
 }
 
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
index 9fe6123b2200..5e1a2a606783 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -63,7 +63,7 @@ static void disable_pagefault(void)
 	ltl_monitor_destroy();
 }
 
-static struct rv_monitor rv_pagefault = {
+static struct rv_monitor rv_this = {
 	.name = "pagefault",
 	.description = "Monitor that RT tasks do not raise page faults",
 	.enable = enable_pagefault,
@@ -72,12 +72,12 @@ static struct rv_monitor rv_pagefault = {
 
 static int __init register_pagefault(void)
 {
-	return rv_register_monitor(&rv_pagefault, &rv_rtapp);
+	return rv_register_monitor(&rv_this, &rv_rtapp);
 }
 
 static void __exit unregister_pagefault(void)
 {
-	rv_unregister_monitor(&rv_pagefault);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_pagefault);
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index 8dfe5ec13e19..12328ce663f5 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -224,7 +224,7 @@ static void disable_sleep(void)
 	ltl_monitor_destroy();
 }
 
-static struct rv_monitor rv_sleep = {
+static struct rv_monitor rv_this = {
 	.name = "sleep",
 	.description = "Monitor that RT tasks do not undesirably sleep",
 	.enable = enable_sleep,
@@ -233,12 +233,12 @@ static struct rv_monitor rv_sleep = {
 
 static int __init register_sleep(void)
 {
-	return rv_register_monitor(&rv_sleep, &rv_rtapp);
+	return rv_register_monitor(&rv_this, &rv_rtapp);
 }
 
 static void __exit unregister_sleep(void)
 {
-	rv_unregister_monitor(&rv_sleep);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_sleep);
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
index f85d076fbf78..31258b9ea083 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -77,7 +77,7 @@ static void disable_%%MODEL_NAME%%(void)
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_%%MODEL_NAME%% = {
+static struct rv_monitor rv_this = {
 	.name = "%%MODEL_NAME%%",
 	.description = "%%DESCRIPTION%%",
 	.enable = enable_%%MODEL_NAME%%,
@@ -86,12 +86,12 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 
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
2.55.0

