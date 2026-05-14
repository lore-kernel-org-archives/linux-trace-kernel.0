Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD64279E6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772144; cv=none; b=H4T0F8pydRChogeHq3H/IKWMg2JgkH2oYApgYDLtiTjlQXuriZF2S7wPViibt0qiu0X0yCpxvuizfSD0DRw2JvShKvJEeERmTRcY9WBXEbMLc2L3tOyFSI5JUkKQiluTRFWU+KW4Ny3FV0mCJgAszaQJGx+mXRRBba8qWno7eJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772144; c=relaxed/simple;
	bh=a7E6bNQ7dz1N4RXdiqY6zukq4q8+j7ikFLUQ41WJkHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=J7rw2Wa+8zhmHntgABzNAem26S5eS4tNLEpyiGi4ELQZ5Y8bUM6JC5nJWKFhieBctdxlaiTjEa6mnJFBWxeqHzAjgOfDSe1ZSYrVBGauzBiOVJmxguPJpn2lrKWHNXp6GjZYzdYEIDbfkh/Z/qKREbyIuc4t19p/saeRLsi33OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+dgtOWe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+dgtOWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZGfHfNLg7GxzHHU+nQbUU/OieYElwK43G1qeeynGNQ=;
	b=M+dgtOWelaVdewEPDRLksQUTEiIg9L7NoHgreQZF94Tc9/LbD2+aFEWv9N913eBFubcNUh
	PsuzjmU9gYjmJAk8OHYuasGn2Faj2odf/YJwIPO+uVXOnWp2K/P5dL+LQrXQLrxkuk9gP2
	WZHbgiw12QzzUiqJFTTPTKirtoKq2yc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-F69KfIhKPYi-bXMtszLY4g-1; Thu,
 14 May 2026 11:22:20 -0400
X-MC-Unique: F69KfIhKPYi-bXMtszLY4g-1
X-Mimecast-MFC-AGG-ID: F69KfIhKPYi-bXMtszLY4g_1778772139
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D715C18005BB;
	Thu, 14 May 2026 15:22:18 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 515FE30001A2;
	Thu, 14 May 2026 15:22:15 +0000 (UTC)
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
Subject: [PATCH v2 13/14] rv: Prevent unintentional tracepoints during KUnit tests
Date: Thu, 14 May 2026 17:20:54 +0200
Message-ID: <20260514152055.229162-14-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: cWoFTR9iwBVu4V839dgVUBtF2ZF6IcYtJnaFzRhzwHI_1778772139
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Monitor initialisation also called during KUnit tests may register some
tracepoints, this can lead to issues since we don't expect real monitor
events running during KUnit tests.

Prevent tracepoint registration if an RV KUnit test is running.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/instrumentation.h       |  5 +++++
 include/rv/kunit.h                 |  2 ++
 kernel/trace/rv/rv_monitors_test.c | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/rv/instrumentation.h b/include/rv/instrumentation.h
index d4e7a02ede1a..761f8f147dac 100644
--- a/include/rv/instrumentation.h
+++ b/include/rv/instrumentation.h
@@ -9,12 +9,15 @@
  */
 
 #include <linux/ftrace.h>
+#include <rv/kunit.h>
 
 /*
  * rv_attach_trace_probe - check and attach a handler function to a tracepoint
  */
 #define rv_attach_trace_probe(monitor, tp, rv_handler)					\
 	do {										\
+		if (rv_mon_test_is_running())						\
+			break;								\
 		check_trace_callback_type_##tp(rv_handler);				\
 		WARN_ONCE(register_trace_##tp(rv_handler, NULL),			\
 				"fail attaching " #monitor " " #tp "handler");		\
@@ -25,5 +28,7 @@
  */
 #define rv_detach_trace_probe(monitor, tp, rv_handler)					\
 	do {										\
+		if (rv_mon_test_is_running())						\
+			break;								\
 		unregister_trace_##tp(rv_handler, NULL);				\
 	} while (0)
diff --git a/include/rv/kunit.h b/include/rv/kunit.h
index 3ef83d337880..9daaebacfc7e 100644
--- a/include/rv/kunit.h
+++ b/include/rv/kunit.h
@@ -19,6 +19,7 @@
 
 struct task_struct *rv_get_current(void);
 int rv_current_cpu(void);
+bool rv_mon_test_is_running(void);
 
 struct rv_kunit_ctx {
 	int reactions, expected;
@@ -52,6 +53,7 @@ struct rv_kunit_ctx {
 
 #define rv_get_current() current
 #define rv_current_cpu() smp_processor_id()
+#define rv_mon_test_is_running() false
 
 #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
 #endif /* _RV_KUNIT_H */
diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3dbe562f00c1..01cbee9ac6c0 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -14,6 +14,8 @@
 #include <linux/rv.h>
 #include "rv.h"
 
+static bool rv_mon_test_running;
+
 __printf(2, 3)
 static void stub_rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
@@ -55,6 +57,11 @@ static int stub_rv_current_cpu(void)
 	return ctx->cpu;
 }
 
+bool rv_mon_test_is_running(void)
+{
+	return rv_mon_test_running;
+}
+
 static int rv_mon_test_init(struct kunit *test)
 {
 	struct rv_kunit_ctx *ctx;
@@ -94,6 +101,8 @@ static int rv_set_testing(struct kunit_suite *suite)
 
 	mutex_lock(&rv_interface_lock);
 
+	rv_mon_test_running = true;
+
 	list_for_each_entry(mon, &rv_monitors_list, list) {
 		if (mon->enabled) {
 			mutex_unlock(&rv_interface_lock);
@@ -111,6 +120,7 @@ static int rv_set_testing(struct kunit_suite *suite)
  */
 static void rv_clear_testing(struct kunit_suite *suite)
 {
+	rv_mon_test_running = false;
 	mutex_unlock(&rv_interface_lock);
 }
 
-- 
2.54.0

