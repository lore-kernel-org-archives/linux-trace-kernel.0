Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D2278E5D;
	Fri,  6 Feb 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390796; cv=none; b=nBbeY6UkQ0YE920TO1kLHBZeM8n/3pFQA4KbsYzmK9KtB2ytcIvorgl9tPVjcSzTuVzIxfX1WANXtu3/BblS8+Fe9T+3pLcWqIj1qv5DvRGrPySOqn1KhHpF5eXTepTHH9A0/5NT49jNueGT3+25JFw702s+JvG5Mz/vNv8+ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390796; c=relaxed/simple;
	bh=IEmyfAfum+l2fgo3tmNMTXIwB/AC8KXfpEYwZlJ1I4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OJ9uoSNDXM2UFYK9oHxHAYSNY/u+6BvaDEZ1DVRXEQGHWrTCeMsYx2mjPViXMLUGOriG0PLk2uQwKVPBOZMjnu7aQqroXKVqBk6KTAp6VrdZs8+K391pWwZY5eL2XXeJ3RfbZuUpcm0cpw+Eqc25obrcFf3j3lar51AO8rK28Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D39841B1E7D;
	Fri,  6 Feb 2026 15:13:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 1AB8330;
	Fri,  6 Feb 2026 15:13:13 +0000 (UTC)
Date: Fri, 6 Feb 2026 10:13:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Have all triggers expect a file parameter
Message-ID: <20260206101351.609d8906@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1AB8330
X-Stat-Signature: je3mtnrs5a4tm969fa43h54w7b5csqnf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uvTxWSBOEmUwiPtHu2qjMXOsA96ufkZw=
X-HE-Tag: 1770390793-681309
X-HE-Meta: U2FsdGVkX1/uCYyZ1t6qVH7Y2ZAS20tqMRobOZ5U1ChoU1wE9Bsg/RqQ7KERYCJf0OIdKLgyiVEKIUNVYMDo0jH8eP3UbMwQEFjFCAb32c/TwqSD1rSV0EysKBP3CVJkEmuTL23P2CNuxpjqgAWAg2yZzq9Hh4xX1U2Vxd7CIKWTt6ozb3cFQ76uTKR2sB1iQpbnz6kFhAAr8o3hd2H4cQPos/74heJAMeTNXd3Z0rEkUYQ9Ep5jzeY5+L6J0Tj6HGMa1e0UtFwfsfhbcZrXc0KFjdzlSWRswyZsuC8JLXQlBZZ/AlyrkF4IvukficY2KREOUHa4qZ20KR7uiJEWHInWCjN0QvtaCdBvrlEBryLDvGnnU30xeXu7I5wW3Er/

From: Steven Rostedt <rostedt@goodmis.org>

When the triggers were first created, they may not have had a file
parameter passed to them and things needed to be done generically.

But today, all triggers have a file parameter passed to them. Remove the
generic code and add a "if (WARN_ON_ONCE(!file))" to each trigger.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 62 +++++++++++------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 06b75bcfc7b8..7fa26327c9c7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1347,18 +1347,13 @@ traceon_trigger(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file) {
-		if (tracer_tracing_is_on(file->tr))
-			return;
-
-		tracer_tracing_on(file->tr);
+	if (WARN_ON_ONCE(!file))
 		return;
-	}
 
-	if (tracing_is_on())
+	if (tracer_tracing_is_on(file->tr))
 		return;
 
-	tracing_on();
+	tracer_tracing_on(file->tr);
 }
 
 static bool
@@ -1368,13 +1363,11 @@ traceon_count_func(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file) {
-		if (tracer_tracing_is_on(file->tr))
-			return false;
-	} else {
-		if (tracing_is_on())
-			return false;
-	}
+	if (WARN_ON_ONCE(!file))
+		return false;
+
+	if (tracer_tracing_is_on(file->tr))
+		return false;
 
 	if (!data->count)
 		return false;
@@ -1392,18 +1385,13 @@ traceoff_trigger(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file) {
-		if (!tracer_tracing_is_on(file->tr))
-			return;
-
-		tracer_tracing_off(file->tr);
+	if (WARN_ON_ONCE(!file))
 		return;
-	}
 
-	if (!tracing_is_on())
+	if (!tracer_tracing_is_on(file->tr))
 		return;
 
-	tracing_off();
+	tracer_tracing_off(file->tr);
 }
 
 static bool
@@ -1413,13 +1401,11 @@ traceoff_count_func(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file) {
-		if (!tracer_tracing_is_on(file->tr))
-			return false;
-	} else {
-		if (!tracing_is_on())
-			return false;
-	}
+	if (WARN_ON_ONCE(!file))
+		return false;
+
+	if (!tracer_tracing_is_on(file->tr))
+		return false;
 
 	if (!data->count)
 		return false;
@@ -1481,10 +1467,10 @@ snapshot_trigger(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file)
-		tracing_snapshot_instance(file->tr);
-	else
-		tracing_snapshot();
+	if (WARN_ON_ONCE(!file))
+		return;
+
+	tracing_snapshot_instance(file->tr);
 }
 
 static int
@@ -1570,10 +1556,10 @@ stacktrace_trigger(struct event_trigger_data *data,
 {
 	struct trace_event_file *file = data->private_data;
 
-	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
-	else
-		trace_dump_stack(STACK_SKIP);
+	if (WARN_ON_ONCE(!file))
+		return;
+
+	__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 }
 
 static int
-- 
2.51.0

