Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D648164A;
	Thu, 13 Aug 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630049; cv=none; b=JioueP2PZLF5B+KywWUgibAnMDJ26hQlpAwLXfJJhgIrY6jlpCKJEzHLodtzjCdubKEqGfp1pWwwfIaj/nl7VCzYe5kyZR+f3Binkfwm/JA5vNW3IfDHxCAmdutWgIJRFaJRzziXsVO4xJXx0W88c2WYOripC05lS54bEnF/rQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630049; c=relaxed/simple;
	bh=uXB+u6Ra4h7qC+KVwAhXukZfPI/hERKowQT5GJBGtus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryAhwj/wCQoEEvJe2WrLP9Pbwyco3okXdwkFvqkZwWUvAs/HFw8rfClV+cpkJHSUSdz5psZHe4Hv35dVHZox1EQTFODPbu+oqnVeU66MozaKWXD9xzXZjScqsxM3jnJIN6FdtFnZImqcbaJzyhyUWYeskNUVn7qSe4TzMJSxjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKZRQ7Fe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIJ5UySd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKZRQ7Fe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIJ5UySd"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWBx/ls/TBxQ4uDqt98nJYBm/ZaABlStWuteh9J8+/A=;
	b=GKZRQ7Fe3BNap1XsJLke1T3tl01CE9WmllGts3MR/xcTD0LNobQe+Bfkyuwx8o2I7LWZV/
	eOFmJuVPub2lMOv9KRuJMd2N8OvgdMj4a1IKCuSdNolK2cUoUoTx11xVd859dDxfCTG/Jp
	aCwlML4H45s7FPLiU+9P1I6ON9uiyvKxEUsE53qXMIrAkzbyMUPDFw5OBmMKAdZ5ZUemVK
	n5KLAssaiv59yvC4DPZGVjagqZYYk+O99woJPMrpYdXyDste7c3k9jfcl9cMryBEjY3ymQ
	dSusPXHllsVX5vn+Ylm780czAnCH5XMNmp0BZsxIuD0nA/QCx1G/dbW4zB4/XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWBx/ls/TBxQ4uDqt98nJYBm/ZaABlStWuteh9J8+/A=;
	b=tIJ5UySdm/9mK1lrJl9h21ytjFAuO2I6X5Xqbrqfv4rhojDQYM/U9gWIB3w9A1Rkk1/Rdo
	p2vsUi9V0Zzg1KAw==
Date: Thu, 13 Aug 2026 16:07:16 +0200
Subject: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=2529;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uXB+u6Ra4h7qC+KVwAhXukZfPI/hERKowQT5GJBGtus=;
 b=mfbUNbUFvj87OWc1TgGUKcAypi8cdkYPiLnU07IQ5atB+PlKoPMaK+Nnh6utd2xi46Ev8QrH7
 izG5KviIK1sCArn7dur0YIQnWsupyAW0c2fZA4CZcIRzMerXhdTpTA9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

ftrace_set_clr_event() modifies its input buffer during parsing.
Before returning to the caller these modifications are undone.
This is restoration is error prone and was forgotten before.
Upcoming changes will also make it more complicated.

Copy the input argument and modify that copy and drop the
restoration logic.

Also mark the input argument as const.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/trace_events.h |  2 +-
 kernel/trace/trace_events.c  | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 308c76b57d13..460d820fe7a4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -873,7 +873,7 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+int ftrace_set_clr_event(struct trace_array *tr, const char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6aa32c492280..c75a7f5b55de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1411,14 +1411,17 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match, *mod;
-	int ret;
 
 	if (!tr)
 		return -ENOENT;
 
+	char *buf __free(kfree) = kstrdup(_buf, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	/* Modules events can be appended with :mod:<module> */
 	mod = strstr(buf, ":mod:");
 	if (mod) {
@@ -1455,15 +1458,7 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 			match = NULL;
 	}
 
-	ret = __ftrace_set_clr_event(tr, match, sub, event, set, mod);
-
-	/* Put back the colon to allow this to be called again */
-	if (buf)
-		*(buf - 1) = ':';
-	if (mod)
-		*(mod - 5) = ':';
-
-	return ret;
+	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
 }
 
 /**

-- 
2.55.0

