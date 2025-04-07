Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFADC222560;
	Mon,  7 Apr 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055278; cv=none; b=HSr34fGq3oJXQBF/JNowZBchs7HVBlxEV0RO4YYXIIaCFzwso1kc6oeZ+yELbaXwxcqLwel0dWYg5CGfRtME3S3QQBh5uImEKpT7YJM55uCggIY++DBdxjk/wSwunOr6lmUD6byUHU1lPG2oBZsJ7bc6dNmg6V7Fd0gA739r1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055278; c=relaxed/simple;
	bh=aNmcLdwroFUwotUZ5Ycx/71l8quJaUOSBpHzjQqGqwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d/SJ8mpMxsqx+nvWNnRyXYJ+TnuWaGpvccXjmXa6CHx+NHa/e+HULdNJ7hN8zkirM/pPwUVmGscbxzMpu+7FGD3dyTXTCLa1VOxyiIytaGkIfF4vsq5LlcJHp7WohfIRJ/uXc/tcMP8KpR8/8OfeVE6wae7d9vZ0YnLFKwzEb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8793BC4CEDD;
	Mon,  7 Apr 2025 19:47:57 +0000 (UTC)
Date: Mon, 7 Apr 2025 15:49:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Add common_comm to histograms
Message-ID: <20250407154912.3c6c6246@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

If one wants to trace the name of the task that wakes up a process and
pass that to the synthetic events, there's nothing currently that lets the
synthetic events do that. Add a "common_comm" to the histogram logic that
allows histograms save the current->comm as a variable that can be passed
through and added to a synthetic event:

 # cd /sys/kernel/tracing
 # echo 's:wake_lat char[] waker; char[] wakee; u64 delta;' >> dynamic_events
 # echo 'hist:keys=pid:comm=common_comm:ts=common_timestamp.usecs if !(common_flags & 0x18)' > events/sched/sched_waking/trigger
 # echo 'hist:keys=next_pid:wake_comm=$comm:delta=common_timestamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,$wake_comm,next_comm,$delta)' > events/sched/sched_switch/trigger

The above will create a synthetic trace event that will save both the name
of the waker and the wakee but only if the wakeup did not happen in a hard
or soft interrupt context.

The "common_comm" is used to save the task->comm at the time of the
initial event and is passed via the "comm" variable to the second event,
and that is saved as the "waker" field in the "wake_lat" synthetic event.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 51 ++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e85bc59c0421..58c9535f61df 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -114,6 +114,7 @@ enum hist_field_fn {
 	HIST_FIELD_FN_BUCKET,
 	HIST_FIELD_FN_TIMESTAMP,
 	HIST_FIELD_FN_CPU,
+	HIST_FIELD_FN_COMM,
 	HIST_FIELD_FN_STRING,
 	HIST_FIELD_FN_DYNSTRING,
 	HIST_FIELD_FN_RELDYNSTRING,
@@ -506,6 +507,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_CONST		= 1 << 18,
 	HIST_FIELD_FL_PERCENT		= 1 << 19,
 	HIST_FIELD_FL_GRAPH		= 1 << 20,
+	HIST_FIELD_FL_COMM		= 1 << 21,
 };
 
 struct var_defs {
@@ -885,6 +887,15 @@ static u64 hist_field_cpu(struct hist_field *hist_field,
 	return cpu;
 }
 
+static u64 hist_field_comm(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct trace_buffer *buffer,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	return (u64)(unsigned long)current->comm;
+}
+
 /**
  * check_field_for_var_ref - Check if a VAR_REF field references a variable
  * @hist_field: The VAR_REF field to check
@@ -1338,6 +1349,8 @@ static const char *hist_field_name(struct hist_field *field,
 		field_name = hist_field_name(field->operands[0], ++level);
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "common_cpu";
+	else if (field->flags & HIST_FIELD_FL_COMM)
+		field_name = "common_comm";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
@@ -2015,6 +2028,13 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	if (flags & HIST_FIELD_FL_COMM) {
+		hist_field->fn_num = HIST_FIELD_FN_COMM;
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = "char[]";
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!field))
 		goto out;
 
@@ -2359,9 +2379,11 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			hist_data->attrs->ts_in_usecs = true;
 	} else if (strcmp(field_name, "common_stacktrace") == 0) {
 		*flags |= HIST_FIELD_FL_STACKTRACE;
-	} else if (strcmp(field_name, "common_cpu") == 0)
+	} else if (strcmp(field_name, "common_cpu") == 0) {
 		*flags |= HIST_FIELD_FL_CPU;
-	else if (strcmp(field_name, "hitcount") == 0)
+	} else if (strcmp(field_name, "common_comm") == 0) {
+		*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
+	} else if (strcmp(field_name, "hitcount") == 0)
 		*flags |= HIST_FIELD_FL_HITCOUNT;
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
@@ -2377,6 +2399,8 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+			} else if (field && field->filter_type == FILTER_COMM) {
+				*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
 			} else {
 				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
 					 errpos(field_name));
@@ -4327,6 +4351,8 @@ static u64 hist_fn_call(struct hist_field *hist_field,
 		return hist_field_timestamp(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_CPU:
 		return hist_field_cpu(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_COMM:
+		return hist_field_comm(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_STRING:
 		return hist_field_string(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_DYNSTRING:
@@ -5212,14 +5238,19 @@ static inline void add_to_key(char *compound_key, void *key,
 	size_t size = key_field->size;
 
 	if (key_field->flags & HIST_FIELD_FL_STRING) {
-		struct ftrace_event_field *field;
 
-		field = key_field->field;
-		if (field->filter_type == FILTER_DYN_STRING ||
-		    field->filter_type == FILTER_RDYN_STRING)
-			size = *(u32 *)(rec + field->offset) >> 16;
-		else if (field->filter_type == FILTER_STATIC_STRING)
-			size = field->size;
+		if (key_field->flags & HIST_FIELD_FL_COMM) {
+			size = strlen((char *)key);
+		} else {
+			struct ftrace_event_field *field;
+
+			field = key_field->field;
+			if (field->filter_type == FILTER_DYN_STRING ||
+			    field->filter_type == FILTER_RDYN_STRING)
+				size = *(u32 *)(rec + field->offset) >> 16;
+			else if (field->filter_type == FILTER_STATIC_STRING)
+				size = field->size;
+		}
 
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
@@ -6097,6 +6128,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "common_cpu");
+	if (hist_field->flags & HIST_FIELD_FL_COMM)
+		seq_puts(m, "common_comm");
 	else if (hist_field->flags & HIST_FIELD_FL_CONST)
 		seq_printf(m, "%llu", hist_field->constant);
 	else if (field_name) {
-- 
2.47.2

