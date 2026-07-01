Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE923431E7C;
	Wed,  1 Jul 2026 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942518; cv=none; b=hjk2+2Kb+nr29n4VMrLnHqJC4+7DlnEkMO8y85xTS64p10ohfGsJ1ydEASgaoyyS+n8vALlGNWXmWvUXEZ03JvbdFN3UKwT7noDR3X8fyDzgFNxCdhFRW0uS5eCDpwu+CbinkDhnpY1psdFZKvvIT7bLZhL4cLPNz6tumO5xkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942518; c=relaxed/simple;
	bh=0tc6qik6Jl2K/L/rglEGGh4OCGcBhJr+0h8ZRAmrr50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jHOkOMN5TE0HYJdA7ihg33d8ogdK0UwClNUwVfpWBmBlfKN/uxySF83DmwbtjsQguENDclvS2veaOcGmxfbrAZSM5/CyLQzuWeQc3rEFFo/DiRkMRCojttex5P8G30fD3/oxwIE8ztaXiSx0i+y2iLwZu/Z6c2gVr4m3V+rUB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 97FF91A04EF;
	Wed,  1 Jul 2026 21:48:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id E5B4D20027;
	Wed,  1 Jul 2026 21:48:27 +0000 (UTC)
Date: Wed, 1 Jul 2026 17:48:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260701174829.67ab8a33@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E5B4D20027
X-Stat-Signature: nzwkrk5rzms7o1t8o97we3c5ndgdoffu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IzVQ0T+AGSOx40QNZaC498SWRq2N9csc=
X-HE-Tag: 1782942507-93147
X-HE-Meta: U2FsdGVkX1/wprPxJkUFHkvnsuL0DTsLCopIvxaRdcIcgYUR2pNjO8IiqGJWubT4lkeNP+lqiy8Cdd8p08nUTYGVsp2pvEaGwOtpYv6FmG2K30+TA18uzWcyGBwcwieIsXFo/OKoCovB4JvUTiKYWakKvsJBSP9e01In3XLzvTufATuLX7ir7l8YAs7dTYWpljFcc+5wd7C2UND014I8Uhhn8JsL8GeeZuYnCwZMwuZCe5xvYByLnL+rorxI5AVpLfJh3yYc8itPWer1GSxQ4lm85PtSuKRs0+tUVMV5xPvdADJtOHarFYKjCI9C2tEQrdNsI2fJsAlfqzmVD5fLgLOf5mEgMyIy8xmvoe/yWMkW1OANKg7f5kTZZzSvNK+/

From: Steven Rostedt <rostedt@goodmis.org>

The enable_data variable gets freed on most error paths in
event_enable_trigger_parse(). Use free() to free it and just before
returning normally, call no_free_ptr(enable_data) to keep it from being
freed.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..fe5ca6ac7c8d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
-	struct enable_trigger_data *enable_data;
+	struct enable_trigger_data *enable_data __free(kfree) = NULL;
 	struct event_trigger_data *trigger_data;
 	struct trace_array *tr = file->tr;
 	char *param, *filter;
@@ -1789,17 +1789,13 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->file = event_enable_file;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
-	if (!trigger_data) {
-		kfree(enable_data);
+	if (!trigger_data)
 		return ret;
-	}
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
-		kfree(enable_data);
-		ret = 0;
-		return ret;
+		return 0;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1829,6 +1825,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		goto out_disable;
 
 	event_trigger_free(trigger_data);
+	no_free_ptr(enable_data);
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1837,7 +1834,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
-	kfree(enable_data);
 
 	return ret;
 }
-- 
2.53.0

