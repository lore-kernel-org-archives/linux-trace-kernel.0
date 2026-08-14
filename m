Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972119E839;
	Fri, 14 Aug 2026 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668134; cv=none; b=slthmeaBSodKYCPZCPPZlLuOxtd6QiBICR+U4G0y4ChpVEaXqWXRkdwUq3iUbJCkucp5XevJwuRR9tSG/vnUrEkJjoeVqp44YF11ck/OtGt4R4Ud9HF2ZFJy4hlNhBxhfjZhrZn9BbJCqukvA7l1rOopmbizSmLjKdaw2BHWR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668134; c=relaxed/simple;
	bh=Jt8pzgLgZHdKgBuxzBF+/+vqGd2tENbapL5Be2Me8lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oZE9SW5uQjaaDRn5bm1FxeY0V5fMBf/QHxbzuNIIpslAJcjnPPv4HwWlJods7Jd86nXlGYsy4d0/iETE5Yxw/jb5w7E7RT3H4KeLwYWnsN+duaN/10Ofl1SAkfH3tMBe74H5gNs+aJXFhjp+AM6eMBU0Xcm/hjBg8kg4AyOPvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=NUAYhTiz; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="NUAYhTiz"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EE1EC802F3;
	Fri, 14 Aug 2026 00:42:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5B1EA20026;
	Fri, 14 Aug 2026 00:42:09 +0000 (UTC)
Date: Thu, 13 Aug 2026 20:42:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Have trace_event_update_all() only handle module
 that is loading
Message-ID: <20260813204226.29563591@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5B1EA20026
X-Stat-Signature: z4bciic6wokgn19hbnjoo7ftdzie3mue
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+L/uTFqGYx307nE+fw2IelLWNkvQlNirk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4vgQkqt4Mbj/JVGDBZc8/RwHPM0tKfvKns6hdRlzyLQ=; b=NUAYhTizXOCbJF3J2EhrVaVRNC71SwY2C4JT3ncOh2m8CJVYLRPWqlwz3Qf6LEC+iHoKhz6gATZxdIS0uwZxZsBoQEftk5mJyUs8972cxmoHnrModt+ytstWhNlqVaMDbWnUK6cGDnt8g7qRjxbjVslN+Bq+iMvq5b3BEmGO1IY=
X-HE-Tag: 1786668129-240995
X-HE-Meta: U2FsdGVkX1+7Qd8t/V5t1lIgWHAXhhsSDYHXQa5POKwjKnUS+5KLaAIYXJLzXA6VLjQ7VxiJ30ojW5siwDrYQWvL5bxjJ67XSmYApWFxM9BDUp6UEAOyO6N34E0n1BYdKXbqUB32Du8bwQptOu/2zyecrzpJL6U1csTVHiJKvDlZWqFZEkKPpnLh9/GMPLiVK+2Gl3AOMr5dkK8B3OeC0dxsqasDr9dnppMOGxkeI5R8wOI3tz6XtftHS9kEHiS+USzmlkqOdlIUSwibybyTbzpll0osE2MM6LSee9VRWrqglKEHFjH4deum2RgChYX3V/H9ettFDh/Q4Q73/0qhFL3rZ2aMzX1Io+xj4UJVWBI+lVNdVZnFJQxFCXMXe+49

From: Steven Rostedt <rostedt@goodmis.org>

The function trace_event_update_all() does a scan of events looking to
replace enums with their values in the strings that get exported to the
event format files. It's run at boot up on all events and again when a
module loads.

The issue is that when a module loads, it still runs on *all* events.
There's no reason to process every event when a module loads as the
previous events have already been processed. Only execute on the events
that are loaded with the module.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 2 +-
 kernel/trace/trace.h        | 4 ++--
 kernel/trace/trace_events.c | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 01a5e87af299..575912e4c310 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4669,7 +4669,7 @@ trace_event_update_with_eval_map(struct module *mod,
 
 	map = start;
 
-	trace_event_update_all(map, len);
+	trace_event_update_all(map, len, mod);
 
 	if (len <= 0)
 		return;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bf77331f56a4..74a7a50d1e78 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2285,13 +2285,13 @@ static inline const char *get_syscall_name(int syscall)
 
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
-void trace_event_update_all(struct trace_eval_map **map, int len);
+void trace_event_update_all(struct trace_eval_map **map, int len, struct module *mod);
 /* Used from boot time tracer */
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }
-static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
+static inline void trace_event_update_all(struct trace_eval_map **map, int len, struct module *mod) { }
 #endif
 
 #ifdef CONFIG_TRACER_SNAPSHOT
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 956692856fa8..21fc68067805 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3557,7 +3557,7 @@ static void update_event_fields(struct trace_event_call *call,
 }
 
 /* Update all events for replacing eval and sanitizing */
-void trace_event_update_all(struct trace_eval_map **map, int len)
+void trace_event_update_all(struct trace_eval_map **map, int len, struct module *mod)
 {
 	struct trace_event_call *call, *p;
 	const char *last_system = NULL;
@@ -3568,6 +3568,10 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 
 	down_write(&trace_event_sem);
 	list_for_each_entry_safe(call, p, &ftrace_events, list) {
+
+		if (mod && call->module != mod)
+			continue;
+
 		/* events are usually grouped together with systems */
 		if (!last_system || call->class->system != last_system) {
 			first = true;
-- 
2.53.0

