Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE623A783D;
	Wed, 13 May 2026 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698822; cv=none; b=QfV79o/3DoOUFoVW9bvR96GK2Un3g9nLgDIJP6Fz1aZp8ILxcqO0rMPoWgpk/eHvaXBXAZnQcGWeOKzq79lYp/0Ku05T3Rcn2f+aSviPcndOqWmX78AdbLLSv7P9S4Qqe3Myo6J9MPtwizJf7SGJ7RNkdpUq5oJPJGtAo8ax/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698822; c=relaxed/simple;
	bh=p9iJVpwidqE5mzaDvwm+CJT1EDavdcYjs9AHGsNwfh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L1q+cxjWgQ9vgqRpy5AX/8BcPNR93cxdFAsx8D4FNa60uOTsl03ExmyUGALReGU2kkUSOP+U07VUrfMh5004wibCi1V8lh1MWU20eQZ/xXWzbntzRzSlAbXtgB01OD32v29Rh12RQrj4tFmY1AGRGRF1plc2h3u3iN9QTTdXXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C5A311C030D;
	Wed, 13 May 2026 19:00:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id C5D392E;
	Wed, 13 May 2026 19:00:03 +0000 (UTC)
Date: Wed, 13 May 2026 15:00:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ian Rogers
 <irogers@google.com>
Subject: [PATCH v2] tracing: Allow perf to read synthetic events
Message-ID: <20260513150007.3b280e87@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C5D392E
X-Stat-Signature: in9hqoyh6jabk3jfhtq9nopqueq3e1as
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MCZlV3wFruJOpPUgUVntUzb69tTKUm5k=
X-HE-Tag: 1778698803-813443
X-HE-Meta: U2FsdGVkX1+Bd2NGkSUpBjFdiYZKvDZLuFitjXwDzLjRxXgzHuczzo8nWA3CVFEzN6jvRCyS2AfOcNoTMjNWvw+T8TjVT8SYaqlxG5e5MfGqkjClvTA4iDbdgWFpRFaR9G4JdwnefSG0Hf+ozpT5oYYG26gYHC11llgt4Ld5l4+aQ9eMAg8o8LqMOuneSTV6D34QU7oD+ptO94G+XWKVscHF/kUaQEOqhLrWaPpxH8J98SW0U364X6NhyjnGlQqMvTSUTgoN9x0squvnnA10vdjR/dkMqeDxAgFvKIHhbnDRojnbBjlMl1N6lMavho9L0/wG7A6Qn9TWxENoJvbexJajOstJesp0eWzrY+46tY/fasCmum1BkDyC8FOrN2Ghh2OB2Uijsv5HOwk97tn2FQc6aosIthgLM5Y/OYGRpXVc7ekEz+P4ySlcnsA7s1ZwZ+3ebtih7PBV0lIdbJRaawJZUJNOiheZ8eirIQFyArE=

From: Steven Rostedt <rostedt@goodmis.org>

Currently, perf can not enable synthetic events. When it does, it either
causes a warning in the kernel or errors with "no such device".

Add the necessary code to allow perf to also attach to synthetic events.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20251217113920.50b56246@gandalf.local.home

- Forward ported to v7.1-rc2

 kernel/trace/trace_events_synth.c | 121 +++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 39ac4eba0702..e6871230bde9 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -499,28 +499,19 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	return len;
 }
 
-static void trace_event_raw_event_synth(void *__data,
-					u64 *var_ref_vals,
-					unsigned int *var_ref_idx)
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
@@ -535,18 +526,18 @@ static void trace_event_raw_event_synth(void *__data,
 
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
@@ -587,10 +578,83 @@ static void trace_event_raw_event_synth(void *__data,
 			n_u64++;
 		}
 	}
+}
+
+static void trace_event_raw_event_synth(void *__data,
+					u64 *var_ref_vals,
+					unsigned int *var_ref_idx)
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
+static void perf_event_raw_event_synth(void *__data,
+				       u64 *var_ref_vals,
+				       unsigned int *var_ref_idx)
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
@@ -917,6 +981,9 @@ static int register_synth_event(struct synth_event *event)
 	call->flags = TRACE_EVENT_FL_TRACEPOINT;
 	call->class->reg = synth_event_reg;
 	call->class->probe = trace_event_raw_event_synth;
+#ifdef CONFIG_PERF_EVENTS
+	call->class->perf_probe = perf_event_raw_event_synth;
+#endif
 	call->data = event;
 	call->tp = event->tp;
 
-- 
2.53.0

