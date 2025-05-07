Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B828934A;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629685; cv=none; b=PwrnIpZDqHmIal3xUJN8VYBHQ7hKorbeWYvIb5hpocJShektSqKr4KNnCjjBtWnN45dEyo1mTbpxpMOVYagWKqfpHT6+nNZbNTdBSL347c0zIAbVWhhxkiFNXQmz7bcYJur6h8RLeiXWevxr3nIbkHlr+O6PC39sxfephoDAhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629685; c=relaxed/simple;
	bh=ax0RfAyfqlQKkQcvo78648dWff+TrIua/v5tQxEHJLU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QrchO7mFo+JyyUkz50Hf6Cg3VNrFDKISSOaWipEJddvG0MT10rJIW676ndHAW0AeQPW823+qpUbPeSC2HMpvC23l7m5nkTS+31cunevyC2M4PVqTbyrXKmvKtom8z4D6keMSvFkiBdFoa7oT9BqF6dcgSCEnl+G/e6l/G4ApGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA4C4CEF1;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uCgAi-00000001qAx-18GM;
	Wed, 07 May 2025 10:54:56 -0400
Message-ID: <20250507145456.121186494@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 07 May 2025 10:53:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/3] tracing: Remove unnecessary "goto out" that simply returns ret is
 trigger code
References: <20250507145305.730136036@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's several functions that have "goto out;" where the label out is just:

 out:
	return ret;

Simplify the code by just doing the return in the location and removing
all the out labels and jumps.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 44 +++++++++++------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index c316badc608b..fdd1112388e9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -552,16 +552,14 @@ static int register_trigger(char *glob,
 	lockdep_assert_held(&event_mutex);
 
 	list_for_each_entry(test, &file->triggers, list) {
-		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
-			ret = -EEXIST;
-			goto out;
-		}
+		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type)
+			return -EEXIST;
 	}
 
 	if (data->ops->init) {
 		ret = data->ops->init(data);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
@@ -572,7 +570,6 @@ static int register_trigger(char *glob,
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
 	}
-out:
 	return ret;
 }
 
@@ -770,7 +767,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 	if (!param_and_filter) {
 		if (param_required)
 			ret = -EINVAL;
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -781,7 +778,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 	 */
 	if (!param_required && param_and_filter && !isdigit(param_and_filter[0])) {
 		*filter = param_and_filter;
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -799,7 +796,6 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 		if (!**filter)
 			*filter = NULL;
 	}
-out:
 	return ret;
 }
 
@@ -991,13 +987,12 @@ event_trigger_parse(struct event_command *cmd_ops,
 	ret = -ENOMEM;
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, file);
 	if (!trigger_data)
-		goto out;
+		return ret;
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		trigger_data_free(trigger_data);
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	ret = event_trigger_parse_num(param, trigger_data);
@@ -1017,13 +1012,12 @@ event_trigger_parse(struct event_command *cmd_ops,
 
 	/* Down the counter of trigger_data or free it if not used anymore */
 	event_trigger_free(trigger_data);
- out:
 	return ret;
 
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	trigger_data_free(trigger_data);
-	goto out;
+	return ret;
 }
 
 /**
@@ -1057,10 +1051,10 @@ int set_trigger_filter(char *filter_str,
 	s = strsep(&filter_str, " \t");
 
 	if (!strlen(s) || strcmp(s, "if") != 0)
-		goto out;
+		return ret;
 
 	if (!filter_str)
-		goto out;
+		return ret;
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->tr, file->event_call,
@@ -1104,7 +1098,6 @@ int set_trigger_filter(char *filter_str,
 			ret = -ENOMEM;
 		}
 	}
- out:
 	return ret;
 }
 
@@ -1772,7 +1765,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	ret = -EINVAL;
 	event_enable_file = find_event_file(tr, system, event);
 	if (!event_enable_file)
-		goto out;
+		return ret;
 
 #ifdef CONFIG_HIST_TRIGGERS
 	hist = ((strcmp(cmd, ENABLE_HIST_STR) == 0) ||
@@ -1787,7 +1780,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 
 	enable_data = kzalloc(sizeof(*enable_data), GFP_KERNEL);
 	if (!enable_data)
-		goto out;
+		return ret;
 
 	enable_data->hist = hist;
 	enable_data->enable = enable;
@@ -1796,7 +1789,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data) {
 		kfree(enable_data);
-		goto out;
+		return ret;
 	}
 
 	if (remove) {
@@ -1804,7 +1797,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		kfree(trigger_data);
 		kfree(enable_data);
 		ret = 0;
-		goto out;
+		return ret;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1834,7 +1827,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		goto out_disable;
 
 	event_trigger_free(trigger_data);
- out:
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1845,7 +1837,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	event_trigger_free(trigger_data);
 	kfree(enable_data);
 
-	goto out;
+	return ret;
 }
 
 int event_enable_register_trigger(char *glob,
@@ -1865,15 +1857,14 @@ int event_enable_register_trigger(char *glob,
 		    (test->cmd_ops->trigger_type ==
 		     data->cmd_ops->trigger_type) &&
 		    (test_enable_data->file == enable_data->file)) {
-			ret = -EEXIST;
-			goto out;
+			return -EEXIST;
 		}
 	}
 
 	if (data->ops->init) {
 		ret = data->ops->init(data);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
@@ -1884,7 +1875,6 @@ int event_enable_register_trigger(char *glob,
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
 	}
-out:
 	return ret;
 }
 
-- 
2.47.2


