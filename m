Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62320DD59;
	Mon,  7 Apr 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043857; cv=none; b=aDh5DTy4Zmw2ripdZzdqJAKmUxjfdD0WcHTLnmQ7DmfbV9woVqBytePA6HdJOpi53GzsdDCFQ/PvngK8wXgGj9LKuBoRFgds5rCkezRQMjU+mXDDp8LGDqqmmQFE9kWK+HfxEN396Hkxz3WV+g/Cfg/ivaVfPVLF+efB5bQfo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043857; c=relaxed/simple;
	bh=yAFU7V07a3Q+AzZVclL3WAZKHludpv3xo0NfhVK60nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YBr21XLgqvYqgoaiXcDTxKbj1Mnv17DeOHcFSiGbgZFkct1qQAZLveV8KF1trWJbSN5pieJCNxWGfdxPA4u7zz2OEO0m/iyn0zl1iFe6fhSK6Ji1mak4kIufP95rD2jNRswPB8vNDUIck61cToY93KzrHs2XkY1am053gvvN/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCD5C4CEDD;
	Mon,  7 Apr 2025 16:37:37 +0000 (UTC)
Date: Mon, 7 Apr 2025 12:38:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2] tracing: Move histogram trigger variables from stack to
 per CPU structure
Message-ID: <20250407123851.74ea8d58@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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

Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist tri=
ggers")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250404144008.0c47e4d7@gandalf.l=
ocal.home

- Fix compiler error.

  I upgraded my compiler and then this patch gave me this error:

   /work/git/test-linux.git/kernel/trace/trace_events_hist.c: In function =
=E2=80=98event_hist_trigger=E2=80=99:
   /work/git/test-linux.git/kernel/trace/trace_events_hist.c:5363:59: error=
: passing argument 1 of =E2=80=98stack_trace_save=E2=80=99 from pointer to =
non-enclosed address space
    5363 |                                 stack_trace_save(hist_pads->entr=
ies, HIST_STACKTRACE_DEPTH,
         |                                                  ~~~~~~~~~^~~~~~=
~~~
   /work/git/test-linux.git/include/linux/stacktrace.h:70:46: note: expecte=
d =E2=80=98long unsigned int *=E2=80=99 but argument is of type =E2=80=98__=
seg_gs long unsigned int *=E2=80=99
      70 | unsigned int stack_trace_save(unsigned long *store, unsigned int=
 size,
         |                               ~~~~~~~~~~~~~~~^~~~~
   make[5]: *** [/work/git/test-linux.git/scripts/Makefile.build:203: kerne=
l/trace/trace_events_hist.o] Error 1

  That was passing the per-cpu array directly into stack_trace_save().
  Instead, assign the array to unsigned long *entries, and pass that.

 kernel/trace/trace_events_hist.c | 120 +++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_h=
ist.c
index 1260c23cfa5f..0ec692f80aef 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5246,17 +5246,94 @@ hist_trigger_actions(struct hist_trigger_data *hist=
_data,
 	}
 }
=20
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
+	hist_pads =3D __alloc_percpu(sizeof(struct hist_pad) * MAX_HIST_CNT,
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
+	hist_pads =3D NULL;
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
+	hist_pad =3D per_cpu_ptr(hist_pads, smp_processor_id());
+
+	if (this_cpu_read(hist_pad_cnt) =3D=3D MAX_HIST_CNT) {
+		preempt_enable();
+		return NULL;
+	}
+
+	cnt =3D this_cpu_inc_return(hist_pad_cnt) - 1;
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
 	struct hist_trigger_data *hist_data =3D data->private_data;
 	bool use_compound_key =3D (hist_data->n_keys > 1);
-	unsigned long entries[HIST_STACKTRACE_DEPTH];
-	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
-	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt =3D NULL;
 	struct hist_field *key_field;
+	struct hist_pad *hist_pad;
 	u64 field_contents;
 	void *key =3D NULL;
 	unsigned int i;
@@ -5264,12 +5341,18 @@ static void event_hist_trigger(struct event_trigger=
_data *data,
 	if (unlikely(!rbe))
 		return;
=20
-	memset(compound_key, 0, hist_data->key_size);
+	hist_pad =3D get_hist_pad();
+	if (!hist_pad)
+		return;
+
+	memset(hist_pad->compound_key, 0, hist_data->key_size);
=20
 	for_each_hist_key_field(i, hist_data) {
 		key_field =3D hist_data->fields[i];
=20
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
+			unsigned long *entries =3D hist_pad->entries;
+
 			memset(entries, 0, HIST_STACKTRACE_SIZE);
 			if (key_field->field) {
 				unsigned long *stack, n_entries;
@@ -5293,26 +5376,31 @@ static void event_hist_trigger(struct event_trigger=
_data *data,
 		}
=20
 		if (use_compound_key)
-			add_to_key(compound_key, key, key_field, rec);
+			add_to_key(hist_pad->compound_key, key, key_field, rec);
 	}
=20
 	if (use_compound_key)
-		key =3D compound_key;
+		key =3D hist_pad->compound_key;
=20
 	if (hist_data->n_var_refs &&
-	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
-		return;
+	    !resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, false))
+		goto out;
=20
 	elt =3D tracing_map_insert(hist_data->map, key);
 	if (!elt)
-		return;
+		goto out;
=20
-	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, var_ref_vals);
+	hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, hist_pad->var_r=
ef_vals);
=20
-	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
-		hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals=
);
+	if (resolve_var_refs(hist_data, key, hist_pad->var_ref_vals, true)) {
+		hist_trigger_actions(hist_data, elt, buffer, rec, rbe,
+				     key, hist_pad->var_ref_vals);
+	}
=20
 	hist_poll_wakeup();
+
+ out:
+	put_hist_pad();
 }
=20
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -6157,6 +6245,9 @@ static int event_hist_trigger_init(struct event_trigg=
er_data *data)
 {
 	struct hist_trigger_data *hist_data =3D data->private_data;
=20
+	if (alloc_hist_pad() < 0)
+		return -ENOMEM;
+
 	if (!data->ref && hist_data->attrs->name)
 		save_named_trigger(hist_data->attrs->name, data);
=20
@@ -6201,6 +6292,7 @@ static void event_hist_trigger_free(struct event_trig=
ger_data *data)
=20
 		destroy_hist_data(hist_data);
 	}
+	free_hist_pad();
 }
=20
 static const struct event_trigger_ops event_hist_trigger_ops =3D {
@@ -6216,9 +6308,7 @@ static int event_hist_trigger_named_init(struct event=
_trigger_data *data)
=20
 	save_named_trigger(data->named_data->name, data);
=20
-	event_hist_trigger_init(data->named_data);
-
-	return 0;
+	return event_hist_trigger_init(data->named_data);
 }
=20
 static void event_hist_trigger_named_free(struct event_trigger_data *data)
--=20
2.47.2

