Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE33E023E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389754; cv=none; b=fmKrErgegGxS/RrXmHsUsvGXzUfIauaMewpXWdeEBGT4of2i6Apj3GJrZ8ULo1H599Vf5yi9y11silG8i0ClrBZ9w9V7dJYzowyTnK9J7bKa2foZJXNY2/JJKZz2kTGVvo/RPt4udN2CsPMagVyLa1WbkQy9ROmMAAt9lXxkgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389754; c=relaxed/simple;
	bh=9bWiVQAKH+tzbBU6c8KzYwX2+wMam86N/NDQEDgyrAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=llbL86PQ9VwYQTlv0oyffwQs8FXBjVuTizhoyMYa0fktU0vVBmsqAuywAOJWbyNEjJrCrhqU6JMNvSeEWHpGTdx6IkhqNkYEZqwImDYY4eku+HdX7JJT1z/tz8edD/Ll8hVuRbh1d59K2vO0v5ndu2voMweap95fxb5KsibiUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUwMfK9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUwMfK9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONbBWAAJjaoMR00igcidRmlEk4znmiS2R5FYNPiYwuo=;
	b=iUwMfK9rFd8ZZ8OoDnrXGx022U2ZMnUAUPujO+TnK4UVlz5VnqPqCXU0mMi0HQfBHSm9kT
	s+Hcy4js/3/9u5XLIz7jGn73tNV7Hfh6RQLwBNwqadoI56LRDOXCpPKeFMOKfNMPsaYiHL
	LtJaSMh8/wVbZ+8290IfgwlZZDX2tic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-TaPBO41MP9m5z8hYhDUiTQ-1; Thu,
 25 Jun 2026 08:15:46 -0400
X-MC-Unique: TaPBO41MP9m5z8hYhDUiTQ-1
X-Mimecast-MFC-AGG-ID: TaPBO41MP9m5z8hYhDUiTQ_1782389745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2138E187B9BA;
	Thu, 25 Jun 2026 12:15:45 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7503530002E0;
	Thu, 25 Jun 2026 12:15:42 +0000 (UTC)
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
Subject: [PATCH v3 11/17] rv: Prevent unintentional tracepoints during KUnit tests
Date: Thu, 25 Jun 2026 14:14:33 +0200
Message-ID: <20260625121440.116317-12-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: v9r1TYerVb7kZ9lZowY_8RosbsqrNEf2r9KhrsRLL5U_1782389745
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Monitor initialisation also called during KUnit tests may register some
tracepoints, this can lead to issues since we don't expect real monitor
events running during KUnit tests.

Prevent tracepoint registration if an RV KUnit test is running.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/instrumentation.h |  5 +++++
 include/rv/kunit.h           |  2 ++
 kernel/trace/rv/rv.c         | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/rv/instrumentation.h b/include/rv/instrumentation.h
index d4e7a02ede..761f8f147d 100644
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
index 5e8c604cf7..0c4c4bc933 100644
--- a/include/rv/kunit.h
+++ b/include/rv/kunit.h
@@ -19,6 +19,7 @@
 
 int rv_set_testing(struct kunit_suite *suite);
 void rv_clear_testing(struct kunit_suite *suite);
+bool rv_mon_test_is_running(void);
 struct task_struct *rv_get_current(void);
 
 struct rv_kunit_ctx {
@@ -59,6 +60,7 @@ void teardown_test(void *arg);
 #else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
 
 #define rv_get_current() current
+#define rv_mon_test_is_running() false
 
 #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
 #endif /* _RV_KUNIT_H */
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 61d4f13960..86ef5dee7f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -864,6 +864,14 @@ int __init rv_init_interface(void)
 #include <rv/kunit.h>
 #include <kunit/visibility.h>
 
+static bool rv_mon_test_running;
+
+bool rv_mon_test_is_running(void)
+{
+	return rv_mon_test_running;
+}
+EXPORT_SYMBOL_GPL(rv_mon_test_is_running);
+
 /*
  * rv_set_testing - ensure mutual exclusion between KUnit tests and real monitors
  *
@@ -886,6 +894,8 @@ int rv_set_testing(struct kunit_suite *suite)
 		}
 	}
 
+	rv_mon_test_running = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_IF_KUNIT(rv_set_testing);
@@ -895,6 +905,7 @@ EXPORT_SYMBOL_IF_KUNIT(rv_set_testing);
  */
 void rv_clear_testing(struct kunit_suite *suite)
 {
+	rv_mon_test_running = false;
 	mutex_unlock(&rv_interface_lock);
 }
 EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
-- 
2.54.0

