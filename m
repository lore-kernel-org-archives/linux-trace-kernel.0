Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA6382F23;
	Tue,  8 Sep 2026 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848544; cv=none; b=T2hKuzneAhcDwdlPfDvdtldOfrqkevUy70K5KAsVNhPeQuJCarmICYyUHwC9CIetOMUKhwvxZIitrhzcX1LkOutmrH+yHRkrY/CyP06JK/saIeSx+kFAMUuR98oc59tz49sYndXseqwSNyDsSiVKEU4a6N3OwmJA27Z0Qq2ffKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848544; c=relaxed/simple;
	bh=frgMevK5TVhiaL5RJpv209UOvEFNyDdYVbihdVW1tJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyko8ew2DUOK7wDmBJ7GWT1nsnubMDTo2IcVJNdd0WwDwpFIht14SHcxHvIiA1AhZh517w26AzfYBASqC7FA7cfjamdOEYNhOhYmybLnMBEWVNhVXfhta8Hmp+IybG6eMJTh+mBiAMCSzEaQaA1nkgPZfOhw7s0VCel4WDXN+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs5rvv9b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iEIntkcz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs5rvv9b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iEIntkcz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbKyjWw5mfZHH0FX6Zh5pd3WFdFK8W+TfufQoK8ZQGQ=;
	b=rs5rvv9b8g4M4Cfyl39TyfZ+IMCKWKkLj5j/HDCUHviGL7lAIp8OxSezqolC7B0SqRffdP
	1pRiYTRnqX8iVv4BumM0UJ1eHyxSbOk2IeHvARCgcLGTz7VKsMQ5rBPS2l6fGP1+VnPvNr
	E5tCpNh58uUmrkBh3ci0IbL60EEw0qr/JVOlNLU0zO0EMCm/p2lTVTOi9ih21EY59eVQ/W
	2Qlanv0CgGe0g07eoFd9ea4AEQ9NS+jEpKm9LLiiffbPZNEu97gCsiwKMMM4fXJJUSmHt4
	2+4BKmaTSmIAfMxI5kZdgLnsyUgvPfgPiUomh1OtitLEiqimmcw0I7rBfWsU1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbKyjWw5mfZHH0FX6Zh5pd3WFdFK8W+TfufQoK8ZQGQ=;
	b=iEIntkcz+LIDM0UmBJ829O1ZYbgdhIU6QNxGmOgH25r/+g54GewTuDl+7Pscgms5EmMjCT
	CTamRlOFNI+HttDQ==
Date: Tue, 08 Sep 2026 08:22:21 +0200
Subject: [PATCH v2 7/7] tracing: Parse filter from boot event string
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-7-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=8735;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=frgMevK5TVhiaL5RJpv209UOvEFNyDdYVbihdVW1tJ8=;
 b=qYDgbBKKc7G/UYGZrxg7iQhbfFk4xfG+6cwPAR+qYc1Wbrc39ACv/w5FcDdccSeVIqTM5dWXY
 wV6Ay+5QKPxB6xwWqRsShtu2MAlv3e+Hd83sN4wAbSb1fryhQxvh0MU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to specify a trace event filter from the
kernel command line.

Example:

	trace_event=syscalls:sys_enter_clock_nanosleep:filter:which_clock==0

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++--
 Documentation/trace/events.rst                  |  5 +++++
 include/linux/trace_events.h                    |  2 +-
 kernel/trace/trace.h                            |  3 ++-
 kernel/trace/trace_boot.c                       |  2 +-
 kernel/trace/trace_events.c                     | 27 +++++++++++++++++--------
 kernel/trace/trace_events_test.c                | 26 +++++++++++++++++++++---
 7 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..63347a986706 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7769,8 +7769,13 @@ Kernel parameters
 			trace_event=:mod:<module>
 
 			The value before :mod: will only enable specific events
-			that are part of the module. See the above mentioned
-			document for more information.
+			that are part of the module.
+
+			To apply a filter, use the :filter: keyword:
+
+			trace_event=...:filter:<filter>
+
+			See the above mentioned document for more information.
 
 	trace_instance=[instance-info]
 			[FTRACE] Create a ring buffer instance early in boot up.
diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 581f2260614b..6ce53372acbc 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -118,6 +118,11 @@ In order to facilitate early boot debugging, use boot option::
 event-list is a comma separated list of events. See section 2.1 for event
 format.
 
+The boot option also supports the ``:filter:`` keyword to apply a filter.
+The ``:filter:`` keyword needs to be at the end of the event specification::
+
+	<system>:<event>:mod:<module>:filter:<filter>
+
 3. Defining an event-enabled tracepoint
 =======================================
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index af46614bc75d..c1f6bb94f483 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -882,7 +882,7 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-int ftrace_set_clr_event(struct trace_array *tr, const char *buf, int set);
+int ftrace_set_clr_event(struct trace_array *tr, const char *buf, int set, bool handle_filter);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 35f619a1655e..2ec212d90192 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2508,5 +2508,6 @@ static inline int rv_init_interface(void)
 #endif /* _LINUX_KERNEL_TRACE_H */
 
 #if IS_ENABLED(CONFIG_KUNIT)
-void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod);
+void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod,
+			       bool handle_filter, char **filter);
 #endif
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 5da0a8bbb110..6ba70dac1f06 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -94,7 +94,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 			continue;
 		}
 
-		if (ftrace_set_clr_event(tr, buf, 1) < 0)
+		if (ftrace_set_clr_event(tr, buf, 1, false) < 0)
 			pr_err("Failed to enable event: %s\n", p);
 	}
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f8881a9d3c7a..2e2815d95c56 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1455,10 +1455,21 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 }
 
 VISIBLE_IF_KUNIT void
-ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
+ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod,
+			  bool handle_filter, char **filter)
 {
 	*event = NULL;
 	*sub = NULL;
+	*filter = NULL;
+
+	/* event filters can be appended with :filter:<filter> */
+	if (handle_filter) {
+		*filter = strstr(buf, ":filter:");
+		if (*filter) {
+			**filter = '\0';
+			*filter += 8;
+		}
+	}
 
 	/* Modules events can be appended with :mod:<module> */
 	*mod = strstr(buf, ":mod:");
@@ -1498,9 +1509,9 @@ ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, cha
 }
 EXPORT_SYMBOL_IF_KUNIT(ftrace_parse_event_string);
 
-int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set, bool handle_filter)
 {
-	char *event, *sub, *match, *mod;
+	char *event, *sub, *match, *mod, *filter;
 
 	if (!tr)
 		return -ENOENT;
@@ -1509,9 +1520,9 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
 	if (!dupped_buf)
 		return -ENOMEM;
 
-	ftrace_parse_event_string(dupped_buf, &match, &sub, &event, &mod);
+	ftrace_parse_event_string(dupped_buf, &match, &sub, &event, &mod, handle_filter, &filter);
 
-	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, NULL);
+	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, filter);
 }
 
 /**
@@ -1593,7 +1604,7 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 		if (*parser.buffer == '!')
 			set = 0;
 
-		ret = ftrace_set_clr_event(tr, parser.buffer + !set, set);
+		ret = ftrace_set_clr_event(tr, parser.buffer + !set, set, false);
 		if (ret)
 			goto out_put;
 	}
@@ -4842,10 +4853,10 @@ static __init void __early_set_events(struct trace_array *tr, char *buf, bool en
 	while ((token = strsep(&buf, ","))) {
 		if (*token) {
 			if (enable) {
-				if (ftrace_set_clr_event(tr, token, 1))
+				if (ftrace_set_clr_event(tr, token, 1, true))
 					pr_warn("Failed to enable trace event: %s\n", token);
 			} else {
-				ftrace_set_clr_event(tr, token, 0);
+				ftrace_set_clr_event(tr, token, 0, true);
 			}
 		}
 
diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events_test.c
index 515d2e668c31..4a2d77fa0f58 100644
--- a/kernel/trace/trace_events_test.c
+++ b/kernel/trace/trace_events_test.c
@@ -8,7 +8,7 @@
 struct parse_event_string_test_case {
 	const char *input;
 
-	const char *match, *sub, *event, *mod;
+	const char *match, *sub, *event, *mod, *filter;
 };
 
 static const struct parse_event_string_test_case parse_event_string_test_cases[] = {
@@ -37,6 +37,12 @@ static const struct parse_event_string_test_case parse_event_string_test_cases[]
 		.sub	= "sub",
 		.event	= "event",
 	},
+	{
+		"sub:event:filter:filter",
+		.sub	= "sub",
+		.event	= "event",
+		.filter	= "filter",
+	},
 	{
 		"match",
 		.match	= "match",
@@ -51,6 +57,19 @@ static const struct parse_event_string_test_case parse_event_string_test_cases[]
 		.event	= "event",
 		.mod	= "module",
 	},
+	{
+		"sub:event:mod:module:filter:filter",
+		.sub	= "sub",
+		.event	= "event",
+		.mod	= "module",
+		.filter	= "filter",
+	},
+	{
+		"sub:event:mod:module:filter:unexpected-filter",
+		.sub	= "sub",
+		.event	= "event",
+		.mod	= "module:filter:unexpected-filter",
+	},
 };
 
 static void
@@ -72,18 +91,19 @@ KUNIT_ARRAY_PARAM(parse_event_string, parse_event_string_test_cases, parse_event
 static void parse_event_string(struct kunit *test)
 {
 	const struct parse_event_string_test_case *params = test->param_value;
-	char *input, *match, *sub, *event, *mod;
+	char *input, *match, *sub, *event, *mod, *filter;
 
 	input = kunit_kstrdup(test, params->input, GFP_KERNEL);
 	if (!input)
 		kunit_skip(test, "ENOMEM");
 
-	ftrace_parse_event_string(input, &match, &sub, &event, &mod);
+	ftrace_parse_event_string(input, &match, &sub, &event, &mod, params->filter, &filter);
 
 	EXPECT_NULL_OR_STR_EQ(test, match, params->match);
 	EXPECT_NULL_OR_STR_EQ(test, sub, params->sub);
 	EXPECT_NULL_OR_STR_EQ(test, event, params->event);
 	EXPECT_NULL_OR_STR_EQ(test, mod, params->mod);
+	EXPECT_NULL_OR_STR_EQ(test, filter, params->filter);
 }
 
 static struct kunit_case trace_events_test_cases[] = {

-- 
2.55.0

