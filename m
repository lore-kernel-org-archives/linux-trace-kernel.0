Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37444380FCA;
	Tue,  8 Sep 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848542; cv=none; b=iTwJgR/jLmDz0dMSsaFCVmpXBXCrcxiHiNrfWUq0uPCcQ1GlWgVPqmuCQ3Sf55PKhLgBwtyVzeyCr27Yq6fNaG/qwyO+OHmoI/lfoUjkS8mbsoMV6nAca8zuWZlLWH5YzF5KVDkdf9j2o6uephUj/AotlCv0a87IZpcIdZwZUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848542; c=relaxed/simple;
	bh=YY8c5L301iU3Aayfxj+VeR0xYVp0bNX5uug0M0tmkPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAWtVqrLx3QVRJHiyPp34gbLbOzyMgBam9lXyd+IV8uVu+Rm5sS4h2DsUyxX37nOXIppCSnTSQR69NxMmcB70qRZwyAW03SAWzijifWx/JtBwwVuwbS6/yvm4w6QOU0JJpSFW2uCTSLXeu+xB2MJeWSzF+ej4/UG0ZmjHbZFZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZA3hP+B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GPU4oEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZA3hP+B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GPU4oEK"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4sb6DZUE6ul1j4WR3dQwjkCoT7uBWyIVb1ZDOo3GtE=;
	b=PZA3hP+BoZEvlI/7rmXEzaghU6f63FSWBtHDFke4s1200ex9xzUzL5Tp2bj2/RE11WVDtO
	LU4SUQyudl1L1PxrS0PBcQk0MJwAzKDWV32M3VtXK1iDEgRlX37i/uqqMS7ukTiDMVQs6L
	ba6pv3N3aM8ia7maRfLJT4qwCJiXx+uIjevQ1FaV9oWSl5P68X8u4dKVPbnDnIqxzoH550
	AJ0absyOjpMmwvevKk0Fztms0UDVr5yWpYOU8kHqJyClSPPj/Q5bsF/vkswWzI1kntzptC
	0DSzXLj1QbvuAAXdHCguNKkgQAXUSGZq4uH3mw1XYv64WKxu+Hf9hm2nZfFPhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4sb6DZUE6ul1j4WR3dQwjkCoT7uBWyIVb1ZDOo3GtE=;
	b=8GPU4oEKmBfWzXi1YtETNeyXdIFJt6Z8XVNFKBFR8jNPht32y3QP3BZ+g6YVgkHlyADRci
	IQXuWkpktHBSOTAg==
Date: Tue, 08 Sep 2026 08:22:17 +0200
Subject: [PATCH v2 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-3-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=2586;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YY8c5L301iU3Aayfxj+VeR0xYVp0bNX5uug0M0tmkPA=;
 b=UDLTuP+8J3xIvaFAlm+a/H34vae8oA4XS/l+ZVgUG8PXR8eDaUXLvSnQ751ZdMAcNBeJBnx3/
 cUfPVBHzgEHAh2FzN7Sg5kW2o3JxT1TAto5PjvVwz9jZFDVSZ9s9Jmn
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
 kernel/trace/trace_events.c  | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5cbd09c8be8d..af46614bc75d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -882,7 +882,7 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+int ftrace_set_clr_event(struct trace_array *tr, const char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index eab653cb3540..88d0212ff2ca 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1440,14 +1440,19 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, const char *arg_buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match, *mod;
-	int ret;
+	char *buf;
 
 	if (!tr)
 		return -ENOENT;
 
+	char *dupped_buf __free(kfree) = kstrdup(arg_buf, GFP_KERNEL);
+	if (!dupped_buf)
+		return -ENOMEM;
+	buf = dupped_buf;
+
 	/* Modules events can be appended with :mod:<module> */
 	mod = strstr(buf, ":mod:");
 	if (mod) {
@@ -1484,15 +1489,7 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
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

