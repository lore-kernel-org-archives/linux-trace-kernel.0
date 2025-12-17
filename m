Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C283358DE;
	Wed, 17 Dec 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989471; cv=none; b=oezZmPoqUu8IQLzcYRip+IRQWT/Jb1fe65cODk4CIZbr3BKOl3GngNxuXNXEmrHJ9xNWfOhkvdzmhkZFOYeZlKRWgeq9bEAhjLPUb/7w0jgbyF9TEfawkXh5kaIA5CSOuGsPjz8ashiDpXkVm/G501Xep2rZszPyjPmHSbLMPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989471; c=relaxed/simple;
	bh=NMZnqyZy1/Ec9VSOSCSL75tdHab4fNQnxN2xBOU2KAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eWHnKerXQ5t8N5iFOJEc0OcEI6Q9VQ4tmfIFSX28lCMyvA9F9gxSZWH9/q3YG3bCvIiHUYewGFf2bJqjSR+c2iBz2k4AjsTF6LTnp4xRflWZNKaaecb3BiB6R0AXOvrMDGlnw0dcTr3aClv48vu9VNkt7x5PPtJfO1CAnNaADZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4B7DD1370BA;
	Wed, 17 Dec 2025 16:37:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 4BF6A20027;
	Wed, 17 Dec 2025 16:37:44 +0000 (UTC)
Date: Wed, 17 Dec 2025 11:39:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ian Rogers <irogers@google.com>, Arnaldo
  Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung
  Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracing: Allow perf to read synthetic events
Message-ID: <20251217113920.50b56246@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BF6A20027
X-Stat-Signature: 8aetqh8zmqgmr67t39qiejgqn383c76g
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Xc5N5Ma+hwUdjht/mv7MucOyTa2R+LTc=
X-HE-Tag: 1765989464-234981
X-HE-Meta: U2FsdGVkX18BuGgTfFCpecoK8itU75LuieMvXk2C0KeeZ9dlQDZFEp7OskXe5CXAnd8oDG5gwrr95EjF3n5xqeFRXoEmsD4JKjD/vecGlhiTrx/hkJ1l1ugOXi9ENuv5Ibq4F5KOeh/EzVX+PGBtAsm1IGghflo07CP8rKdM9ECuQioKUnOwX3JcXp4YsCcscCm+UVil59iIXpjdvVqWgeBJheMMg6l52eqqvMOHvqa3dQM1Fy4XYVcO7uTxr6R8+1SdrF8XJODjpCK4aZUt8LUnYHv1cyjj0flPKInTKrwBktmLl3XwXO0faLuKryfiVxiSOt/V/Pmq5HFkihONctaBcKS33jmzfdLxz5EmdoMqSG7mvfLSIy1JZJh6d/cI7pFMoDH7ClvFmMlnTT1WkA==

From: Steven Rostedt <rostedt@goodmis.org>

Currently, perf can not enable synthetic events. When it does, it either
causes a warning in the kernel or errors with "no such device".

Add the necessary code to allow perf to also attach to synthetic events.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 121 +++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4554c458b78c..026e06f28958 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -493,28 +493,19 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	return len;
 }
 
-static notrace void trace_event_raw_event_synth(void *__data,
-						u64 *var_ref_vals,
-						unsigned int *var_ref_idx)
+static __always_inline int get_field_size(struct synth_event *event,
+					  u64 *var_ref_vals,
+					  unsigned int *var_ref_idx)
 {
-	unsigned int i, n_u64, val_idx, len, data_size = 0;
-	struct trace_event_file *trace_file = __data;
-	struct synth_trace_event *entry;
-	struct trace_event_buffer fbuffer;
-	struct trace_buffer *buffer;
-	struct synth_event *event;
-	int fields_size = 0;
-
-	event = trace_file->event_call->data;
-
-	if (trace_trigger_soft_disabled(trace_file))
-		return;
+	int fields_size;
 
 	fields_size = event->n_u64 * sizeof(u64);
 
-	for (i = 0; i < event->n_dynamic_fields; i++) {
+	for (int i = 0; i < event->n_dynamic_fields; i++) {
 		unsigned int field_pos = event->dynamic_fields[i]->field_pos;
 		char *str_val;
+		int val_idx;
+		int len;
 
 		val_idx = var_ref_idx[field_pos];
 		str_val = (char *)(long)var_ref_vals[val_idx];
@@ -529,18 +520,18 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 		fields_size += len;
 	}
+	return fields_size;
+}
 
-	/*
-	 * Avoid ring buffer recursion detection, as this event
-	 * is being performed within another event.
-	 */
-	buffer = trace_file->tr->array_buffer.buffer;
-	guard(ring_buffer_nest)(buffer);
-
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
-					   sizeof(*entry) + fields_size);
-	if (!entry)
-		return;
+static __always_inline void write_synth_entry(struct synth_event *event,
+					      struct synth_trace_event *entry,
+					      u64 *var_ref_vals,
+					      unsigned int *var_ref_idx)
+{
+	int data_size = 0;
+	int i, n_u64;
+	int val_idx;
+	int len;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		val_idx = var_ref_idx[i];
@@ -581,10 +572,83 @@ static notrace void trace_event_raw_event_synth(void *__data,
 			n_u64++;
 		}
 	}
+}
+
+static notrace void trace_event_raw_event_synth(void *__data,
+						u64 *var_ref_vals,
+						unsigned int *var_ref_idx)
+{
+	struct trace_event_file *trace_file = __data;
+	struct synth_trace_event *entry;
+	struct trace_event_buffer fbuffer;
+	struct trace_buffer *buffer;
+	struct synth_event *event;
+	int fields_size;
+
+	event = trace_file->event_call->data;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	fields_size = get_field_size(event, var_ref_vals, var_ref_idx);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	buffer = trace_file->tr->array_buffer.buffer;
+	guard(ring_buffer_nest)(buffer);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + fields_size);
+	if (!entry)
+		return;
+
+	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
+#ifdef CONFIG_PERF_EVENTS
+static notrace void perf_event_raw_event_synth(void *__data,
+					       u64 *var_ref_vals,
+					       unsigned int *var_ref_idx)
+{
+	struct trace_event_call *call = __data;
+	struct synth_trace_event *entry;
+	struct hlist_head *perf_head;
+	struct synth_event *event;
+	struct pt_regs *regs;
+	int fields_size;
+	size_t size;
+	int context;
+
+	event = call->data;
+
+	perf_head = this_cpu_ptr(call->perf_events);
+
+	if (!perf_head || hlist_empty(perf_head))
+		return;
+
+	fields_size = get_field_size(event, var_ref_vals, var_ref_idx);
+
+	size = ALIGN(sizeof(*entry) + fields_size, 8);
+
+	entry = perf_trace_buf_alloc(size, &regs, &context);
+
+	if (unlikely(!entry))
+		return;
+
+	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
+
+	perf_fetch_caller_regs(regs);
+
+	perf_trace_buf_submit(entry, size, context,
+			      call->event.type, 1, regs,
+			      perf_head, NULL);
+}
+#endif
+
 static void free_synth_event_print_fmt(struct trace_event_call *call)
 {
 	if (call) {
@@ -911,6 +975,9 @@ static int register_synth_event(struct synth_event *event)
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
 	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
+#ifdef CONFIG_PERF_EVENTS
+	call->class->perf_probe = perf_event_raw_event_synth;
+#endif
 	call->data = event;
 	call->tp = event->tp;
 
-- 
2.51.0

