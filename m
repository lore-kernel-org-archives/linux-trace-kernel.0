Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D431DA21;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629685; cv=none; b=V4Ljq5+6vzVyMHMPZV0FLzkTszrvYjy7r00orqw7CwTUDWoPeEq/6MGd+oEaKw08lpH3d0eCkUL8mjcCd7Eaa6trZaVVJKcCG9W9hm7+K6KlD3rVpR8+u3VI0OEIyOxJmR/KkFreTqmBCyMk15zX4LPbMiqAsiHHtC3TA6h1Wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629685; c=relaxed/simple;
	bh=v3BqsBu76mZ9IjtnZSmxnnLPzK9Gfutz/C4dFMdez7Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iwZY4PGfVyIVKw/1sy3zG7m119MDZnUyRNhDV5jEpGN9STfCYVU7YXfKu7mS/LhI4CipSd2D+XpFcwBfaDxQJonJuBavE4Z+J0ztNXB/Bq6P4CswqX8E3FoDc3y3xUhkK+dq+/1liOTbWKJdPPsrfnpLch0fcDadCHMMZRRUxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8B4C4CEEB;
	Wed,  7 May 2025 14:54:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uCgAh-00000001q9y-3s4N;
	Wed, 07 May 2025 10:54:55 -0400
Message-ID: <20250507145455.776436410@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 07 May 2025 10:53:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/3] tracing: Rename event_trigger_alloc() to trigger_data_alloc()
References: <20250507145305.730136036@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function event_trigger_alloc() creates an event_trigger_data
descriptor and states that it needs to be freed via event_trigger_free().
This is incorrect, it needs to be freed by trigger_data_free() as
event_trigger_free() adds ref counting.

Rename event_trigger_alloc() to trigger_data_alloc() and state that it
needs to be freed via trigger_data_free(). This naming convention
was introducing bugs.

Fixes: 86599dbe2c527 ("tracing: Add helper functions to simplify event_command.parse() callback handling")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  8 +++-----
 kernel/trace/trace_events_hist.c    |  2 +-
 kernel/trace/trace_events_trigger.c | 16 ++++++++--------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a2639daea47b..053af6e4e7e0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1774,6 +1774,9 @@ extern int event_enable_register_trigger(char *glob,
 extern void event_enable_unregister_trigger(char *glob,
 					    struct event_trigger_data *test,
 					    struct trace_event_file *file);
+extern struct event_trigger_data *
+trigger_data_alloc(struct event_command *cmd_ops, char *cmd, char *param,
+		   void *private_data);
 extern void trigger_data_free(struct event_trigger_data *data);
 extern int event_trigger_init(struct event_trigger_data *data);
 extern int trace_event_trigger_enable_disable(struct trace_event_file *file,
@@ -1800,11 +1803,6 @@ extern bool event_trigger_check_remove(const char *glob);
 extern bool event_trigger_empty_param(const char *param);
 extern int event_trigger_separate_filter(char *param_and_filter, char **param,
 					 char **filter, bool param_required);
-extern struct event_trigger_data *
-event_trigger_alloc(struct event_command *cmd_ops,
-		    char *cmd,
-		    char *param,
-		    void *private_data);
 extern int event_trigger_parse_num(char *trigger,
 				   struct event_trigger_data *trigger_data);
 extern int event_trigger_set_filter(struct event_command *cmd_ops,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 58c9535f61df..1d536219b624 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6826,7 +6826,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		return PTR_ERR(hist_data);
 	}
 
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, hist_data);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
 	if (!trigger_data) {
 		ret = -ENOMEM;
 		goto out_free;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b66b6d235d91..dac3344ee345 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -804,7 +804,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 }
 
 /**
- * event_trigger_alloc - allocate and init event_trigger_data for a trigger
+ * trigger_data_alloc - allocate and init event_trigger_data for a trigger
  * @cmd_ops: The event_command operations for the trigger
  * @cmd: The cmd string
  * @param: The param string
@@ -815,14 +815,14 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
  * trigger_ops to assign to the event_trigger_data.  @private_data can
  * also be passed in and associated with the event_trigger_data.
  *
- * Use event_trigger_free() to free an event_trigger_data object.
+ * Use trigger_data_free() to free an event_trigger_data object.
  *
  * Return: The trigger_data object success, NULL otherwise
  */
-struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
-					       char *cmd,
-					       char *param,
-					       void *private_data)
+struct event_trigger_data *trigger_data_alloc(struct event_command *cmd_ops,
+					      char *cmd,
+					      char *param,
+					      void *private_data)
 {
 	struct event_trigger_data *trigger_data;
 	const struct event_trigger_ops *trigger_ops;
@@ -989,7 +989,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 		return ret;
 
 	ret = -ENOMEM;
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, file);
 	if (!trigger_data)
 		goto out;
 
@@ -1793,7 +1793,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
 
-	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, enable_data);
+	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data) {
 		kfree(enable_data);
 		goto out;
-- 
2.47.2


