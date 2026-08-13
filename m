Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DB481ABB;
	Thu, 13 Aug 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630051; cv=none; b=FKPm7hXFpH/U6HRHaBCGAdVt+CbFq4/xVkBNjDlCWPzGlTpfp04RVfnfF15hFSle1ERmqtE6pY2Rs9jxwb6C3eAS1U5JLePNn8H7uk3VahRfj/TFt2ZFLRet2KMjpzEz5s0zD8ist3FOkK2h3PW/xT+cayuQkgXMIeHR9tAmnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630051; c=relaxed/simple;
	bh=rbW8w1n/9aEhBtK951U9QqR5KAHNtwNsTPHLF5qTGsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inB80HfUKVsT8rSYUk1oV0IA8RzoFq8s6FvekNk3Hw6iFyJzKhV+dfpK9IKbMk3ho2GOUO1ZWraGoIPmzuRoO15iOC/O7+XJV35nWkj0fe10Gyrox8AlxD+mnVbiY2NzxCPolwwEIepE4KAdjjCZwU41Lw/POljNDkkAzlubpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fClo/U/i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTB/fVOt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fClo/U/i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTB/fVOt"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fefSdkEdocoKGKpBduzl2pv9NZDc0Uh/2oLAQRIks8=;
	b=fClo/U/iBfQ5o3+zw4So4K+uDuKmdsMEsIyEI7Ikbj0QV6hXhMZThuaYs1nXGCV1w6UmlT
	Q+Gj8UgJrC405uRWvNK/NOdttPfmBBkkJol6oJcPIsIWfSxDHAfFVdzb4V3Q0H5hEHiCTM
	jGOOo8rD7l3eBzPj/o7qJoERFXZaCzrwDIkP30pFGnjoG2k4UOdUkHcrE3K9x0pDSODayy
	uRX4+Ds29XXCcJd547Z6aSVz/vFphaYFOnQN/d3+Fyk+lGj0zRWxNKNQlrJ07yv4DcGgtn
	gB6aDsHFfJoA0+nsMhmO/YP9pL+d1LHjClGWNlXPcY0KRWRAl2bd4NlquU589w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fefSdkEdocoKGKpBduzl2pv9NZDc0Uh/2oLAQRIks8=;
	b=sTB/fVOtO33axD44gV4KkPhnu4kTnhuy0NcsKLduk3J5As2sLEKDT2uL+xgEcVnwUzT0e0
	iFUtFnHj+/czVZDw==
Date: Thu, 13 Aug 2026 16:07:17 +0200
Subject: [PATCH RFC 4/7] tracing: Split the event string parsing logic into
 a dedicated function
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-4-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=2569;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rbW8w1n/9aEhBtK951U9QqR5KAHNtwNsTPHLF5qTGsA=;
 b=WxUc36gb35O0YVdUC0/KTbmO04ACZhkGqSpdbHVPnhlAEmGhvyTGx6Y6Uwm5v5Ve/zMyDhpwK
 90Xw/omnI9YBneH6jA2bPZtb+wZ1KcUxliAhyK3kj0BlpeiaYI5sTQI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

That new function can be tested with a KUnit test to prevent regressions
when adding new fields to the format.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events.c | 59 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c75a7f5b55de..4ff3f9214894 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1411,23 +1411,18 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
+static void
+ftrace_parse_event_string(char *buf, char **match, char **sub, char **event, char **mod)
 {
-	char *event = NULL, *sub = NULL, *match, *mod;
-
-	if (!tr)
-		return -ENOENT;
-
-	char *buf __free(kfree) = kstrdup(_buf, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
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
@@ -1442,21 +1437,35 @@ int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
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
+int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
+{
+	char *event, *sub, *match, *mod;
+
+	if (!tr)
+		return -ENOENT;
+
+	char *buf __free(kfree) = kstrdup(_buf, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ftrace_parse_event_string(buf, &match, &sub, &event, &mod);
 
 	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
 }

-- 
2.55.0

