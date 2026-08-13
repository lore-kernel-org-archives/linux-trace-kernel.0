Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91493483BD3;
	Thu, 13 Aug 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630053; cv=none; b=LfILiuqOjqY6sUi7eWYVsPPru08GXOH1od11RuTUCsq7rLuvQf8C5Pam3c4qYa3seMSUX1dIGYAdFRFXE7ZZmsWtj6vvDafVUanBCzO7I76Ahg2Xaj9GkAUp+An85VMJtaR/dvmoi3nFWfIiuDubrkIGc+KEOw8hOOamhuxM1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630053; c=relaxed/simple;
	bh=4YSg6q5BnaYywr3fPl6vkuJOqPpAkW0f05ia6cMS4vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+3MSQc0aKDQe/YX2xjc4gjuSb/wONumRLiYTZyCHm84SoHbsy3OyrsEyAh3XwIqK9xKZzH8uTFTrffNeBG0HhC4FR3CyhhHuBSaG6UbI4JTRaDFKGGPzOqXY6v6ekgvnbYUKr7YUMEizCVARc4iouZZNjuB/YMmaorDSwVYORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpMFFvRC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o697awFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpMFFvRC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o697awFc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUBV4UfNe6DT8kodPBUPI5rVvc0/aAmNySrxh4n/hBY=;
	b=gpMFFvRCzk8omLjRJkoLMRqhqu1yNvU5qkDZRlosvjzLYNpgjJ6pucSio+K3mKIzTLF8GB
	D7jCB5FbXiHjCIIVele0IY+LYdcKlDbdlxO1S4rZN4sknrOGslq1ADScRjBTyUmar+e9Ko
	ULx/DG3Z3lylS76hagGUQDJ1zzn0H2odANn1mcZQN12P+mnHQSbXh2oTtmRAxB6fI/vLWl
	pW2+ptUcsWKr7hFrDt2WGZgQU02WQ4sCX/fjiqe31fPJ5EgFcSFQXp7Tke+1NeRwL/CaYN
	JSFLpUxqT4qMN4RX0Nho80KPjS26IAgMQ6eugd2wQ5/8z8X8cfOVIXKqTLrkjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUBV4UfNe6DT8kodPBUPI5rVvc0/aAmNySrxh4n/hBY=;
	b=o697awFcZf9eHmjFIdCNKE5rtAxBEmtUeG5i6VpKZzgD4pcQeG7C/qYjw9/7pVuNFFWBmG
	uAV4+WKu6nbTIyDg==
Date: Thu, 13 Aug 2026 16:07:18 +0200
Subject: [PATCH RFC 5/7] tracing: Add a test for
 ftrace_parse_event_string()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-5-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=5237;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4YSg6q5BnaYywr3fPl6vkuJOqPpAkW0f05ia6cMS4vs=;
 b=yrP9gshAK6xc5yLgyO/KDsWObN8FfwV4KsOOkIqs21aetqzaY7hT83jqOeuf654xCxxP6z2GX
 rnxOKhx9DNAD0+ev2nXlKjKkgqsWoQpKGPU13McDgAyoeVDAmns7Gxf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The parsing logic is a bit complicated and about to become more so.

Add a unit test to avoid regressions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/Kconfig             |   8 ++++
 kernel/trace/Makefile            |   1 +
 kernel/trace/trace.h             |   4 ++
 kernel/trace/trace_events.c      |   5 +-
 kernel/trace/trace_events_test.c | 101 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 084f34dc6c9f..e5eb26780abf 100644
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
index c00e4741f815..6bf4f031efa8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2505,3 +2505,7 @@ static inline int rv_init_interface(void)
 	})
 
 #endif /* _LINUX_KERNEL_TRACE_H */
+
+#if IS_ENABLED(CONFIG_KUNIT)
+void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod);
+#endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4ff3f9214894..098a5aee5ec7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -23,6 +23,8 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 
+#include <kunit/visibility.h>
+
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
 
@@ -1411,7 +1413,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static void
+VISIBLE_IF_KUNIT void
 ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
 {
 	*event = NULL;
@@ -1453,6 +1455,7 @@ ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, cha
 			*match = NULL;
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(ftrace_parse_event_string);
 
 int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
 {
diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events_test.c
new file mode 100644
index 000000000000..e090a699b8d5
--- /dev/null
+++ b/kernel/trace/trace_events_test.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+
+#include <kunit/test.h>
+
+#include "trace.h"
+
+struct parse_event_test_case {
+	const char *input;
+
+	const char *match, *sub, *event, *mod;
+};
+
+static const struct parse_event_test_case parse_event_test_cases[] = {
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
+static void parse_event_test_desc(const struct parse_event_test_case *params, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "'%s'", params->input);
+}
+
+KUNIT_ARRAY_PARAM(parse_event, parse_event_test_cases, parse_event_test_desc);
+
+#define EXPECT_NULL_OR_STR_EQ(test, left, right)		\
+({								\
+	if ((left) != NULL)					\
+		KUNIT_EXPECT_STREQ(test, (left), (right));	\
+	else							\
+		KUNIT_EXPECT_NULL(test, (right));		\
+})
+
+static void parse_event(struct kunit *test)
+{
+	const struct parse_event_test_case *params = test->param_value;
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
+	KUNIT_CASE_PARAM(parse_event, parse_event_gen_params),
+	{}
+};
+
+static struct kunit_suite trace_events_test_suite = {
+	.name = "trace-events",
+	.test_cases = trace_events_test_cases,
+};
+kunit_test_suite(trace_events_test_suite);
+
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.55.0

