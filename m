Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81F381B1C;
	Tue,  8 Sep 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848542; cv=none; b=Ey6rSM8RYQB9wtqMR6cLxKOdrr6Bg2JVgPjpjXL6Elg1ox4BiitUnVUzi6i6YPccWgYGvaRwt4sV0vBxE4HSDvQEjMaLeSff7s5ezetnjvjuy3luDxpCpFuWb081mfihWVxRezNXc22uvzrI5C+VRRSYjWGQVo91e2+SZ55NSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848542; c=relaxed/simple;
	bh=P9LZhluCeKIiFGbzqM6fDqg9P1GLsLImceM6YfjlBnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbjw1FLptqaQixl3oTte/ta4D3IaMECVH8lcfEFd3F7B1+hsmwg5S79mSqvtefjPHOXQ5CNJEmSmGVSkIibBGou04Boinbes5HhWopaVhZiSengUzQawu35b5adWjL4N6DvQq+HrfIvxfz8zFmJrykUM5xz2YqgPKi4gvTc6BfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NzhIBJSb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogFoxsqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzhIBJSb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogFoxsqT"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX47QCWixFRW8/1LS0ex98egxk9iLYoJ1TPMm4yBGpM=;
	b=NzhIBJSbZVdeGzlmN1b3vBCUHFalGC5LFS0HdJKbS7UVaJGwUMTSNAJL6uXHjEQ5V9qnt2
	nkhDvdOlZ/tfLSpWFRwO4y5DhkIcGNGYnRXOJnph7cgIBEDdXc8yjO9/ko2nO0auWlsEGI
	gLhZehcOg+7Fbz1dylrLz4sQ6VS5VK/RdLbNvokI4H7jwCU7xaJupRJ7lJkocrnGfOd4j7
	OytqmzT9G7g6FyNdpAFAC3ff8DUI+sIwXF2KvCZT8aDvrIBye5omDexErGOlpyvpVpsvd6
	upWUrB9f2vaJAy2jnuTuaRjhVGm2vtJ8uQQT1LjAqOE9hSpQYWjeCHHeDiB02g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX47QCWixFRW8/1LS0ex98egxk9iLYoJ1TPMm4yBGpM=;
	b=ogFoxsqT8ZGb068zJP+4TDh+jVIizXq1RnfhKW9cCCinm5jrvW1FUV5xgGLEAj8YkPNOH4
	qrsL8ebbIr8JBaBw==
Date: Tue, 08 Sep 2026 08:22:18 +0200
Subject: [PATCH v2 4/7] tracing: Split the event string parsing logic into
 a dedicated function
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-4-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=2654;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=P9LZhluCeKIiFGbzqM6fDqg9P1GLsLImceM6YfjlBnw=;
 b=tQsR2sk46GODRSRUQzEKLqp58NIGourYVB2yN50mx6J+VN7y7FVUNxY3UYS3km9CNEK1ulwOn
 GfthvLioSQgDxJw2ULhumhCr7Qr+fmJoR3RVVX8f5iL69qkmUVNQY5j
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This new function can be tested with a KUnit test to prevent regressions
when adding new fields to the format.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 88d0212ff2ca..4104ccbebf4a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1440,25 +1440,18 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
+static void
+ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
 {
-	char *event = NULL, *sub = NULL, *match, *mod;
-	char *buf;
-
-	if (!tr)
-		return -ENOENT;
-
-	char *dupped_buf __free(kfree) = kstrdup(arg_buf, GFP_KERNEL);
-	if (!dupped_buf)
-		return -ENOMEM;
-	buf = dupped_buf;
+	*event = NULL;
+	*sub = NULL;
 
 	/* Modules events can be appended with :mod:<module> */
-	mod = strstr(buf, ":mod:");
-	if (mod) {
-		*mod = '\0';
+	*mod = strstr(buf, ":mod:");
+	if (*mod) {
+		**mod = '\0';
 		/* move to the module name */
-		mod += 5;
+		*mod += 5;
 	}
 
 	/*
@@ -1473,21 +1466,35 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
 	 *  the name <name> or any event that matches <name>
 	 */
 
-	match = strsep(&buf, ":");
+	*match = strsep(&buf, ":");
 	if (buf) {
-		sub = match;
-		event = buf;
-		match = NULL;
-
-		if (!strlen(sub) || strcmp(sub, "*") == 0)
-			sub = NULL;
-		if (!strlen(event) || strcmp(event, "*") == 0)
-			event = NULL;
-	} else if (mod) {
+		*sub = *match;
+		*event = buf;
+		*match = NULL;
+
+		if (!strlen(*sub) || strcmp(*sub, "*") == 0)
+			*sub = NULL;
+		if (!strlen(*event) || strcmp(*event, "*") == 0)
+			*event = NULL;
+	} else if (*mod) {
 		/* Allow wildcard for no length or star */
-		if (!strlen(match) || strcmp(match, "*") == 0)
-			match = NULL;
+		if (!strlen(*match) || strcmp(*match, "*") == 0)
+			*match = NULL;
 	}
+}
+
+int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
+{
+	char *event, *sub, *match, *mod;
+
+	if (!tr)
+		return -ENOENT;
+
+	char *dupped_buf __free(kfree) = kstrdup(arg_buf, GFP_KERNEL);
+	if (!dupped_buf)
+		return -ENOMEM;
+
+	ftrace_parse_event_string(dupped_buf, &match, &sub, &event, &mod);
 
 	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
 }

-- 
2.55.0

