Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01B481AA1;
	Thu, 13 Aug 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630055; cv=none; b=N+WInSJ/fJqf5AydfGMbAEnef1ZBADM9khFC2qEZTw4S2C1FWZrOZYg9O9MzVNWrUk/jzw36EfBT99SL0hgCM9+yjPoKDHeYszaogBQdLKCGr/ML4diFUCh7uioQW+ENrNqRvbm7U+nkyHTZruytBmuYGYnFn6qpSJtfRC49h6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630055; c=relaxed/simple;
	bh=5KG9ggG+sYH747V2TG/SWjV6KFhlj6kNDRk9COW7rC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MleN7+3oK7qHcf76B0ozObGppK9uOfeGnqEm99ZwIhIrlHR1I71zQfYwzbCF0s0WkRJLbZmaMkbRZAWCUj1hhQTAbRh4YQ3FXzZnMzyufGcUdv0aNWlwnCNSzhHXzMvGtk2T5PqptgLInqsNRNIdAJe5tZibSIr7NmwOupZx/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WO3cQm3H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4ygpNKO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WO3cQm3H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4ygpNKO"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KRVQFkVkY8fZPaA3svHgY48lpnccVnCvT09HtZ4RHI=;
	b=WO3cQm3HTwoMAUQdxst+HA+AgOQUBzhiIjBcfkqCN/pj0816LtVtfFdSL6xJP2S9bOkFzi
	0yBEuewHqRjOIi2W7egjCMJRyBUAhKjWo21wU2VWmLwQPuOu5Q0YDSvt8WxO1cRAC+7cAh
	rxebNJiaF0HXtM8Vf7PSzG1WmbbG8kLYdK6cI0YWvsesHY0AnQEMJrEMeEWQBZJA8Q3kBA
	0PhiH5ZrvlHFrDBJydLpWGja//CREijwYiIOiqYo7avle2KstxVFGgkl6x4rBTFyxHiBWj
	2zxo0AAnggjxilTNPm9Xpk6q+p55V2WCtxHVu6dOr7QRQTSi07Z0GAsnn/bKzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KRVQFkVkY8fZPaA3svHgY48lpnccVnCvT09HtZ4RHI=;
	b=o4ygpNKOebJ2MeA2lrYuosXxTuNCykcZjat0pnIG0/oMLt9t2ONL42kIbFyx5q8sU/VM/m
	ayaPGkSYBLOz/kCw==
Date: Thu, 13 Aug 2026 16:07:20 +0200
Subject: [PATCH RFC 7/7] tracing: Parse filter from event string
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-7-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=4633;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5KG9ggG+sYH747V2TG/SWjV6KFhlj6kNDRk9COW7rC0=;
 b=jC3xvgAwcx3f14HmFhF3FSLbFY6slRVpsxcQypzq0E5GRJSU59R779RB5tJExh1XDkO+KhF0P
 BHDfUGPT9ndB+5WiEbtO/4f2oyTyvJGurBjwRfSPS9uiKwuxT+Y63Gd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it possible to specify a trace event filter from the
kernel command line.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
For the non-RFC patch this should probably be limited to only apply to
the cmdline path.
---
 kernel/trace/trace.h             |  3 ++-
 kernel/trace/trace_events.c      | 13 +++++++++----
 kernel/trace/trace_events_test.c | 20 +++++++++++++++++---
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6bf4f031efa8..9102bf0a45a9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2507,5 +2507,6 @@ static inline int rv_init_interface(void)
 #endif /* _LINUX_KERNEL_TRACE_H */
 
 #if IS_ENABLED(CONFIG_KUNIT)
-void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod);
+void ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod,
+			       char **filter);
 #endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c24929d003dd..d4c46b24c382 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1426,10 +1426,12 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 }
 
 VISIBLE_IF_KUNIT void
-ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
+ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod,
+			  char **filter)
 {
 	*event = NULL;
 	*sub = NULL;
+	*filter = NULL;
 
 	/* Modules events can be appended with :mod:<module> */
 	*mod = strstr(buf, ":mod:");
@@ -1453,6 +1455,9 @@ ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, cha
 
 	*match = strsep(&buf, ":");
 	if (buf) {
+		*filter = buf;
+		strsep(filter, ":");
+
 		*sub = *match;
 		*event = buf;
 		*match = NULL;
@@ -1471,7 +1476,7 @@ EXPORT_SYMBOL_IF_KUNIT(ftrace_parse_event_string);
 
 int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
 {
-	char *event, *sub, *match, *mod;
+	char *event, *sub, *match, *mod, *filter;
 
 	if (!tr)
 		return -ENOENT;
@@ -1480,9 +1485,9 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
 	if (!buf)
 		return -ENOMEM;
 
-	ftrace_parse_event_string(buf, &match, &sub, &event, &mod);
+	ftrace_parse_event_string(buf, &match, &sub, &event, &mod, &filter);
 
-	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, NULL);
+	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, filter);
 }
 
 /**
diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events_test.c
index e090a699b8d5..fd54eb03b58f 100644
--- a/kernel/trace/trace_events_test.c
+++ b/kernel/trace/trace_events_test.c
@@ -8,7 +8,7 @@
 struct parse_event_test_case {
 	const char *input;
 
-	const char *match, *sub, *event, *mod;
+	const char *match, *sub, *event, *mod, *filter;
 };
 
 static const struct parse_event_test_case parse_event_test_cases[] = {
@@ -37,6 +37,12 @@ static const struct parse_event_test_case parse_event_test_cases[] = {
 		.sub	= "sub",
 		.event	= "event",
 	},
+	{
+		"sub:event:filter",
+		.sub	= "sub",
+		.event	= "event",
+		.filter	= "filter",
+	},
 	{
 		"match",
 		.match	= "match",
@@ -51,6 +57,13 @@ static const struct parse_event_test_case parse_event_test_cases[] = {
 		.event	= "event",
 		.mod	= "module",
 	},
+	{
+		"sub:event:filter:mod:module",
+		.sub	= "sub",
+		.event	= "event",
+		.mod	= "module",
+		.filter	= "filter",
+	},
 };
 
 static void parse_event_test_desc(const struct parse_event_test_case *params, char *desc)
@@ -71,18 +84,19 @@ KUNIT_ARRAY_PARAM(parse_event, parse_event_test_cases, parse_event_test_desc);
 static void parse_event(struct kunit *test)
 {
 	const struct parse_event_test_case *params = test->param_value;
-	char *input, *match, *sub, *event, *mod;
+	char *input, *match, *sub, *event, *mod, *filter;
 
 	input = kunit_kstrdup(test, params->input, GFP_KERNEL);
 	if (!input)
 		kunit_skip(test, "ENOMEM");
 
-	ftrace_parse_event_string(input, &match, &sub, &event, &mod);
+	ftrace_parse_event_string(input, &match, &sub, &event, &mod, &filter);
 
 	EXPECT_NULL_OR_STR_EQ(test, match, params->match);
 	EXPECT_NULL_OR_STR_EQ(test, sub, params->sub);
 	EXPECT_NULL_OR_STR_EQ(test, event, params->event);
 	EXPECT_NULL_OR_STR_EQ(test, mod, params->mod);
+	EXPECT_NULL_OR_STR_EQ(test, filter, params->filter);
 }
 
 static struct kunit_case trace_events_test_cases[] = {

-- 
2.55.0

