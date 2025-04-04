Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9908BE4A;
	Fri,  4 Apr 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791944; cv=none; b=cXLlSiX6D/DACQd0k7bp7TNMB9WjBaMPMtqz8Q1pJTB/gjzzYGnfJuutO4zW75CrVjVQi5cTwoobIyrkYpwxdrOvl11mros1NOGQjz859aFCg/sbFJoPzgOpk45Don6ruwGk/mRKadnHmvY3ZBtcEOe1EMRmLATm4cb/8rtnYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791944; c=relaxed/simple;
	bh=WKSaCjgh1r7wRfZvSYlTabXa+wsTRJ3YNzbKz/4bPG0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=I/yaRW1GRvaqgfGWKQj1tVIli73dJKAURrQ/8dbvxXchtUM1DTrq/lUYPMSShMW8PUhayk6RdupVdCayzL01Adv2ga+WP3guFNq4fjAQZ0xoEmeW49ZiyayLB6LeVtWe1K9wxGLGyOHxL25Ei7hCdW12+ni6DvpuqroRxiho2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16D1C4CEDD;
	Fri,  4 Apr 2025 18:39:02 +0000 (UTC)
Date: Fri, 4 Apr 2025 14:40:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3] tracing: Move histogram trigger variables from stack to
 per CPU structure
Message-ID: <20250404144008.0c47e4d7@gandalf.local.home>
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

The histogram trigger has three somewhat large arrays on the kernel stack:

	unsigned long entries[HIST_STACKTRACE_DEPTH];
	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
	char compound_key[HIST_KEY_SIZE_MAX];

Checking the function event_hist_trigger() stack frame size, it currently
uses 816 bytes for its stack frame due to these variables!

Instead, allocate a per CPU structure that holds these arrays for each
context level (normal, softirq, irq and NMI). That is, each CPU will have
4 of these structures. This will be allocated when the first histogram
trigger is enabled and freed when the last is disabled. When the
histogram callback triggers, it will request this structure. The request
will disable preemption, get the per CPU structure at the index of the
per CPU variable, and increment that variable.

The callback will use the arrays in this structure to perform its work and
then release the structure. That in turn will simply decrement the per CPU
index and enable preemption.

Moving the variables from the kernel stack to the per CPU structure brings
the stack frame of event_hist_trigger() down to just 112 bytes.

Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist triggers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250404112720.34802192@gandalf.local.home

- Rebased on top of Linus's tree
  (Small conflicts with code around this code)

 kernel/trace/trace_events_hist.c | 126 ++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e139b58c3a43..3d94e5314a3e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5244,17 +5244,94 @@ hist_trigger_actions(struct hist_trigger_data *hist_data,
 	}
 }
 
+/*
+ * The hist_pad structure is used to save information to create
+ * a histogram from the histogram trigger. It's too big to store
+ * on the stack, so when the histogram trigger is initialized
+ * a percpu array of 4 hist_pad structures is allocated.
+ * This will cover every context from normal, softirq, irq and NMI
+ * in the very unlikely event that a tigger happens at each of
+ * these contexts and interrupts a currently active trigger.
+ */
+struct hist_pad {
+	unsigned long		entries[HIST_STACKTRACE_DEPTH];
+	u64			var_ref_vals[TRACING_MAP_VARS_MAX];
+	char			compound_key[HIST_KEY_SIZE_MAX];
+};
+
+static struct hist_pad __percpu *hist_pads;
+static DEFINE_PER_CPU(int, hist_pad_cnt);
+static refcount_t hist_pad_ref;
+
+/* One hist_pad for every context (normal, softirq, irq, NMI) */
+#define MAX_HIST_CNT 4
+
+static int alloc_hist_pad(void)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (refcount_read(&hist_pad_ref)) {
+		refcount_inc(&hist_pad_ref);
+		return 0;
+	}
+
+	hist_pads = __alloc_percpu(sizeof(struct hist_pad) * MAX_HIST_CNT,
+				   __alignof__(struct hist_pad));
+	if (!hist_pads)
+		return -ENOMEM;
+
+	refcount_set(&hist_pad_ref, 1);
+	return 0;
+}
+
+static void free_hist_pad(void)
+{
+	lockdep_assert_held(&event_mutex);
+
+	if (!refcount_dec_and_test(&hist_pad_ref))
+		return;
+
+	free_percpu(hist_pads);
+	hist_pads = NULL;
+}
+
+static struct hist_pad *get_hist_pad(void)
+{
+	struct hist_pad *hist_pad;
+	int cnt;
+
+	if (WARN_ON_ONCE(!hist_pads))
+		return NULL;
+
+	preempt_disable();
+
+	hist_pad = per_cpu_ptr(hist_pads, smp_processor_id());
+
+	if (this_cpu_read(hist_pad_cnt) == MAX_HIST_CNT) {
+		preempt_enable();
+		return NULL;
+	}
+
+	cnt = this_cpu_inc_return(hist_pad_cnt) - 1;
+
+	return &hist_pad[cnt];
+}
+
+static void put_hist_pad(void)
+{
+	this_cpu_dec(hist_pad_cnt);
+	preempt_enable();
+}
+
 static void event_hist_trigger(struct event_trigger_data *data,
 			       struct trace_buffer *buffer, void *rec,
 			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
-	unsigned long entries[HIST_STACKTRACE_DEPTH];
-	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
-	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt = NULL;
 	struct hist_field *key_field;
+	struct hist_pad *hist_pad;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -5262,25 +5339,29 @@ static void event_hist_trigger(struct event_trigger_data *data,
 	if (unlikely(!rbe))
 		return;
 
-	memset(compound_key, 0, hist_data->key_size);
+	hist_pad = get_hist_pad();
+	if (!hist_pad)
+		return;
+
+	memset(hist_pad->compound_key, 0, hist_data->key_size);
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			memset(entries, 0, HIST_STACKTRACE_SIZE);
+			memset(hist_pad->entries, 0, HIST_STACKTRACE_SIZE);
 			if (key_field->field) {
 				unsigned long *stack, n_entries;
 
 				field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
 				stack = (unsigned long *)(long)field_contents;
 				n_entries = *stack;
-				memcpy(entries, ++stack, n_entries * sizeof(unsigned long));
+				memcpy(hist_pad->entries, ++stack, n_entries * sizeof(unsigned long));
 			} else {
-				stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
+				stack_trace_save(hist_pads->entries, HIST_STACKTRACE_DEPTH,
 						 HIST_STACKTRACE_SKIP);
 			}
-			key = entries;
+			key = hist_pad->entries;
 		} else {
 			field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
@@ -5291,26 +5372,31 @@ static void event_hist_trigger(struct event_trigger_data *data,
 		}
 
 		if (use_compound_key)
-			add_to_key(compound_key, key, key_field, rec);
+			add_to_key(hist_pad->compound_key, key, key_field, rec);
 	}
 
 	if (use_compound_key)
-		key = compound_key;
+		key = hist_pad->compound_key;
 
 	if (hist_data->n_var_refs &&
-	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
-		return;
+	    !resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, false))
+		goto out;
 
 	elt = tracing_map_insert(hist_data->map, key);
 	if (!elt)
-		return;
+		goto out;
 
-	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, var_ref_vals);
+	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, hist_pad->var_ref_vals);
 
-	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
+	if (resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, true)) {
+		hist_trigger_actions(hist_data, elt, buffer, rec, rbe,
+				     key, hist_pad->var_ref_vals);
+	}
 
 	hist_poll_wakeup();
+
+ out:
+	put_hist_pad();
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -6155,6 +6241,9 @@ static int event_hist_trigger_init(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 
+	if (alloc_hist_pad() < 0)
+		return -ENOMEM;
+
 	if (!data->ref && hist_data->attrs->name)
 		save_named_trigger(hist_data->attrs->name, data);
 
@@ -6199,6 +6288,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		destroy_hist_data(hist_data);
 	}
+	free_hist_pad();
 }
 
 static const struct event_trigger_ops event_hist_trigger_ops = {
@@ -6214,9 +6304,7 @@ static int event_hist_trigger_named_init(struct event_trigger_data *data)
 
 	save_named_trigger(data->named_data->name, data);
 
-	event_hist_trigger_init(data->named_data);
-
-	return 0;
+	return event_hist_trigger_init(data->named_data);
 }
 
 static void event_hist_trigger_named_free(struct event_trigger_data *data)
-- 
2.47.2

