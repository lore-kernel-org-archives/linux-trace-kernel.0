Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316F37FF68;
	Tue,  8 Sep 2026 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848544; cv=none; b=I5ByP2HkUakZ2vG1YaTD86UORidEFnK+MA1jQouHIeTpfE7AwwuwyZ+i59tO4F5gZ7iAyZjrYm5N06T6bwyef5i2DVHEkQJ0b0E1uYQsMP7eqbVbzgVTOxdkuJ6ZXJ55j3kD7G/lNtzuGOaIzKAyNy0cdIGzVdpCrgFna6ZB8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848544; c=relaxed/simple;
	bh=5TVCsUrOMQYcESAbQ2G221/u2D2fA8NDkNdqUy0yaik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tsce8K/mYbF5cNWV0Tx7Mwhgk36/1bJaO2lgWiQgbPqKuznoYfY6esuvWSu+dUQQ6Z9Tbegq++RTtDWp4QQLQaMADoQJPU8md1sqFzoklqwDd0xL75AB7WSWnjUl/WTDk2EY3kcaVK0bHdDEHxALP0FNx4bKFz785bjhZsx3Z0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FIFX0nRK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lDHG4kqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FIFX0nRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDHG4kqU"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GssFXxtIHVdcg58tXsfZzX4oarFl2s1/f6rlQWfF6kw=;
	b=FIFX0nRKEOqyfGBvwZEnKZv/pSbmM4nnmEc+tk4d6FZcGE/DGZ73p+H71P8ztj9+YdThEX
	p2PEIO7FBNadsIy5+QWyKFldmk0fAnvcr0TEpCj5B7UfyRe2/K1iIskNtOjXULC4qvfDAX
	xTygW0X9FSKN84FfnEWwq9axoUcoJDP4nD/bmfAyU5vuuq7ARoxpFrel9AAUtL16ZRQhB0
	HJifPrexdb3ENncM2i0ZGOmpOpsymFMk6QcFsUx1ZH86Tq9xmNCZyUtdSKMw5qkeLjkVDn
	5P1P1W+VPLE1/ggzfWVtFKaY5eoQuus8zVGWj5bg0V2SQ+a9qnfVWC6rW6YRBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GssFXxtIHVdcg58tXsfZzX4oarFl2s1/f6rlQWfF6kw=;
	b=lDHG4kqUfaccOcS1bkxJ4aFh+2aMx6dHCCiKLP0o5q87aoTn2F9ZtwXyvoZoSF2v28zF4m
	sQKp8AgqlHT5KVAQ==
Date: Tue, 08 Sep 2026 08:22:19 +0200
Subject: [PATCH v2 5/7] tracing: Add a test for ftrace_parse_event_string()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-5-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=5394;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5TVCsUrOMQYcESAbQ2G221/u2D2fA8NDkNdqUy0yaik=;
 b=LHAy7qOyB8OR6mKqYLGIpugvedEnjZGGDFS3oaGfppyyeQatQnzZ6caa0Xiq38BnD8PJyIjYG
 l9m0aGM+KkrA1HFNj/cu+Of1Xp1lyfKweD24NomCm/ETF1sfNa5PO8h
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The parsing logic is a bit complicated and about to become more so.

Add a unit test to avoid regressions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/Kconfig             |   8 +++
 kernel/trace/Makefile            |   1 +
 kernel/trace/trace.h             |   4 ++
 kernel/trace/trace_events.c      |   5 +-
 kernel/trace/trace_events_test.c | 102 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0ab5916575a9..430a4152095e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -151,6 +151,14 @@ config EVENT_TRACING
 	select GLOB
 	bool
 
+config EVENT_TRACING_TEST
+	tristate "Test for event tracing" if !KUNIT_ALL_TESTS
+	depends on EVENT_TRACING
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit test for the event tracing implementation.
+
 config CONTEXT_SWITCH_TRACER
 	bool
 
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..7bef5a84ce47 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_EVENT_TRACING) += blktrace.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events.o
 obj-$(CONFIG_EVENT_TRACING) += trace_export.o
+obj-$(CONFIG_EVENT_TRACING_TEST) += trace_events_test.o
 obj-$(CONFIG_FTRACE_SYSCALLS) += trace_syscalls.o
 ifeq ($(CONFIG_PERF_EVENTS),y)
 obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8fffd10fad53..35f619a1655e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2506,3 +2506,7 @@ static inline int rv_init_interface(void)
 	})
 
 #endif /* _LINUX_KERNEL_TRACE_H */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod);
+#endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4104ccbebf4a..7a491dbe6e81 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -25,6 +25,8 @@
 #include <linux/delay.h>
 #include <linux/btf.h>
 
+#include <kunit/visibility.h>
+
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
 
@@ -1440,7 +1442,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static void
+VISIBLE_IF_KUNIT void
 ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
 {
 	*event = NULL;
@@ -1482,6 +1484,7 @@ ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, cha
 			*match = NULL;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(ftrace_parse_event_string);
 
 int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
 {
diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events_test.c
new file mode 100644
index 000000000000..515d2e668c31
--- /dev/null
+++ b/kernel/trace/trace_events_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+
+#include <kunit/test.h>
+
+#include "trace.h"
+
+struct parse_event_string_test_case {
+	const char *input;
+
+	const char *match, *sub, *event, *mod;
+};
+
+static const struct parse_event_string_test_case parse_event_string_test_cases[] = {
+	{
+		"",
+		.match	= "",
+	},
+	{
+		"*:event",
+		.event	= "event",
+	},
+	{
+		":event",
+		.event	= "event",
+	},
+	{
+		"sub:*",
+		.sub	= "sub",
+	},
+	{
+		"sub:",
+		.sub	= "sub",
+	},
+	{
+		"sub:event",
+		.sub	= "sub",
+		.event	= "event",
+	},
+	{
+		"match",
+		.match	= "match",
+	},
+	{
+		":mod:module",
+		.mod	= "module",
+	},
+	{
+		"sub:event:mod:module",
+		.sub	= "sub",
+		.event	= "event",
+		.mod	= "module",
+	},
+};
+
+static void
+parse_event_string_test_desc(const struct parse_event_string_test_case *params, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "'%s'", params->input);
+}
+
+KUNIT_ARRAY_PARAM(parse_event_string, parse_event_string_test_cases, parse_event_string_test_desc);
+
+#define EXPECT_NULL_OR_STR_EQ(test, left, right)		\
+({								\
+	if ((left) != NULL)					\
+		KUNIT_EXPECT_STREQ(test, (left), (right));	\
+	else							\
+		KUNIT_EXPECT_NULL(test, (right));		\
+})
+
+static void parse_event_string(struct kunit *test)
+{
+	const struct parse_event_string_test_case *params = test->param_value;
+	char *input, *match, *sub, *event, *mod;
+
+	input = kunit_kstrdup(test, params->input, GFP_KERNEL);
+	if (!input)
+		kunit_skip(test, "ENOMEM");
+
+	ftrace_parse_event_string(input, &match, &sub, &event, &mod);
+
+	EXPECT_NULL_OR_STR_EQ(test, match, params->match);
+	EXPECT_NULL_OR_STR_EQ(test, sub, params->sub);
+	EXPECT_NULL_OR_STR_EQ(test, event, params->event);
+	EXPECT_NULL_OR_STR_EQ(test, mod, params->mod);
+}
+
+static struct kunit_case trace_events_test_cases[] = {
+	KUNIT_CASE_PARAM(parse_event_string, parse_event_string_gen_params),
+	{}
+};
+
+static struct kunit_suite trace_events_test_suite = {
+	.name = "trace-events",
+	.test_cases = trace_events_test_cases,
+};
+kunit_test_suite(trace_events_test_suite);
+
+MODULE_DESCRIPTION("KUnit test for the event tracing implementation");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.55.0

