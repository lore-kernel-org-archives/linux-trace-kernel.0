Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F683E00AE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389695; cv=none; b=Fus9ZsgSW18HTkz+XXCN5gk6y6jd6Rr92we1hfXYkb753wGB4NHwJn1L8Sd6VxZkolmQncUZ7gSWhzYWkRG5SHZorqIH4cJxZp++OEJJmcaG9iND1lu2IjVakueMFp7m2KVStXpAJq9BCSenFCMeiHHyDXYmAr33r8oFNLA3KmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389695; c=relaxed/simple;
	bh=ZESqkHR3jY3iVqRjgIMuPoXgT4bfpdqS9wkoyldxL9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SqL0q6lN2RxlNPUDtORaRjZEeQBS+rnDe5fB3SudnFDbPkrdO7OwkWSzQImNA9olBUT/qV7M3I2Yg7IZXKLZkEf2mtfM8A7ObKyhl0GQ9ZS42Oo+/IF5VDYT0nPwFaBVpICW3toGa79bDbZvhxetFKQpI6FPtKp/6nX8/ovD/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTbZpyBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTbZpyBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IY3oHysqkwfEcSb37Q13nue4f4Qiaij97qq7R6usnnw=;
	b=VTbZpyBIEhIGZHL5NWtDqdaayOcM1KbuK1OJp4HfEiYGXXh9MezuklZ48eT3t+vB9Z+cl8
	uv1ObH6wrtS2jww2/A1zvRbtnS9iVIw/VMUWsZNHHiYfg3W/3JTepL+YOI3B1tQImAo5Rd
	q7UbBqgPOq+JmnjTdxyzUVmbpAfqUlI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-AMEEOhM2OrKA3jiCHAzydQ-1; Thu,
 25 Jun 2026 08:14:51 -0400
X-MC-Unique: AMEEOhM2OrKA3jiCHAzydQ-1
X-Mimecast-MFC-AGG-ID: AMEEOhM2OrKA3jiCHAzydQ_1782389690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4C51964CC9;
	Thu, 25 Jun 2026 12:14:49 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC66130002E0;
	Thu, 25 Jun 2026 12:14:46 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 01/17] rv: Use generic rv_this for the rv_monitor variable in LTL
Date: Thu, 25 Jun 2026 14:14:23 +0200
Message-ID: <20260625121440.116317-2-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: TRcGyNC-0QJMGKs_DR-5hGiqhoO4WgagFZDd8To5MDA_1782389690
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Align the rv_monitor variable name in LTL to the generic rv_this as it
is already done for DA/HA monitors. This improves consistency and eases
assumptions across model classes.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/ltl_monitor.h                              | 5 ++---
 kernel/trace/rv/monitors/pagefault/pagefault.c        | 6 +++---
 kernel/trace/rv/monitors/sleep/sleep.c                | 6 +++---
 tools/verification/rvgen/rvgen/templates/ltl2k/main.c | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 38e792401f..56e83edcf0 100644
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
index 9fe6123b22..5e1a2a6067 100644
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
index 8dfe5ec13e..12328ce663 100644
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
index f85d076fbf..31258b9ea0 100644
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
2.54.0

