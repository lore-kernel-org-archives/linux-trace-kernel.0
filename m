Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33818229B18;
	Mon, 10 Mar 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614453; cv=none; b=cKnxrXVTwCpi7oX4XWVeZSlR91bZ5k3e10RnN+WGXDrAtZHLVruDw32mgXUzdngUjpcmHayv4CpDrYZGU5lnKImWyA1uvFMBsTW+w8QJVbYrPTi6/ngxPzxW20C1hsV3gtGRiVgigNAySy9wocsnDfqW+/ekGO6gESVrirEEMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614453; c=relaxed/simple;
	bh=oBY81sWp1crFquGirT/b5lCiol5ySLrz5qGNRv/ktUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHLOMH5mLZEut8VoZMP1tdIazwF2Y2JJKEHQjF9dE+P1KHb8zafdQ9oqve/M77IQJ4Zffko6FMa32GSel2hIhpzki1FxRE3OH6+QlFJsTRCMsXwfVJLv4EZBbYooYbZSxVrQChl7Y3nrEI6HxeHg31wn3FjJl6y86BXSTkybodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l30mavZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l30mavZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328BEC4CEE5;
	Mon, 10 Mar 2025 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741614451;
	bh=oBY81sWp1crFquGirT/b5lCiol5ySLrz5qGNRv/ktUo=;
	h=From:To:Cc:Subject:Date:From;
	b=l30mavZTUgq7WkAjRFnUfNy4xT/ItTyB3hR99DVt8x91a1teTMfZGuxAMHjsNgPv3
	 NrIum/LQUVc7xjVwt+O1rbT0YoLAG5rKX6GyReGODKuWWzqWVLO0pyblMEXAo3C4s0
	 ZYIbjmHZr+Szz+FFnApesmU5N5ZfxJMpIusGRdh8cyOjKGIi1ZU0HmpMULQDCAlK/S
	 /LdxQ2nTcV51G3PZ37NX46gXfPKGRYl+f0iuIJOpbxQntmoDsdiKKhD+w7IKpjEx5p
	 ChXiX0adGA6f81bWwqKN5WDZTxzlhfkxWwmJ4AkaCwN7TQk0rL0hAVSK3p8QlWrpZd
	 1hVGj4rCJeOkg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing: Show last module text symbols in the stacktrace
Date: Mon, 10 Mar 2025 22:47:27 +0900
Message-ID: <174161444691.1063601.16690699136628689205.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the previous boot trace buffer can include module text address in
the stacktrace. As same as the kernel text address, convert the module
text address using the module address information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Move module_delta to trace_scratch data structure.
  - Remove LRU based removed module information.
---
 kernel/trace/trace.c        |   99 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    2 +
 kernel/trace/trace_output.c |    4 +-
 3 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..0c1aa1750077 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -5996,11 +5997,41 @@ struct trace_mod_entry {
 struct trace_scratch {
 	unsigned long		kaslr_addr;
 	unsigned long		nr_entries;
+	long			*module_delta;
 	struct trace_mod_entry	entries[];
 };
 
 static DEFINE_MUTEX(scratch_mutex);
 
+/**
+ * trace_adjust_address() - Adjust prev boot address to current address.
+ * @tr: Persistent ring buffer's trace_array.
+ * @addr: Address in @tr which is adjusted.
+ */
+unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
+{
+	struct trace_scratch *tscratch;
+	long *module_delta;
+	int i;
+
+	/* If we don't have last boot delta, return the address */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return addr;
+
+	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tscratch->module_delta);
+	if (!tscratch || !tscratch->nr_entries || !module_delta ||
+	    tscratch->entries[0].mod_addr > addr)
+		return addr + tr->text_delta;
+
+	/* Note that entries must be sorted. */
+	for (i = 0; i < tscratch->nr_entries; i++)
+		if (addr < tscratch->entries[i].mod_addr)
+			break;
+
+	return addr + module_delta[i - 1];
+}
+
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6029,6 +6060,7 @@ static int save_mod(struct module *mod, void *data)
 static void update_last_data(struct trace_array *tr)
 {
 	struct trace_scratch *tscratch;
+	long *module_delta;
 
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
 		return;
@@ -6063,6 +6095,8 @@ static void update_last_data(struct trace_array *tr)
 		return;
 
 	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tscratch->module_delta);
+	WRITE_ONCE(tscratch->module_delta, NULL);
 
 	/* Set the persistent ring buffer meta data to this address */
 #ifdef CONFIG_RANDOMIZE_BASE
@@ -6071,6 +6105,8 @@ static void update_last_data(struct trace_array *tr)
 	tscratch->kaslr_addr = 0;
 #endif
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
+
+	kfree(module_delta);
 }
 
 /**
@@ -9342,10 +9378,43 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+static int make_mod_delta(struct module *mod, void *data)
+{
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	struct trace_array *tr = data;
+	long *module_delta;
+	int i;
+
+	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tscratch->module_delta);
+	for (i = 0; i < tscratch->nr_entries; i++) {
+		entry = &tscratch->entries[i];
+		if (!strcmp(mod->name, entry->mod_name)) {
+			if (mod->state == MODULE_STATE_GOING)
+				module_delta[i] = 0;
+			else
+				module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
+						 - entry->mod_addr;
+			break;
+		}
+	}
+	return 0;
+}
+
+static int mod_addr_comp(const void *a, const void *b, const void *data)
+{
+	const struct trace_mod_entry *e1 = a;
+	const struct trace_mod_entry *e2 = b;
+
+	return e1->mod_addr > e2->mod_addr ? 1 : -1;
+}
+
 static void setup_trace_scratch(struct trace_array *tr,
 				struct trace_scratch *tscratch, unsigned int size)
 {
 	struct trace_mod_entry *entry;
+	int i, nr_entries;
 
 	if (!tscratch)
 		return;
@@ -9362,7 +9431,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9376,6 +9445,21 @@ static void setup_trace_scratch(struct trace_array *tr,
 		if (n == MODULE_NAME_LEN)
 			goto reset;
 	}
+
+	nr_entries = i;
+	tscratch->module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
+	if (!tscratch->module_delta) {
+		pr_info("module_delta allocation failed. Not able to decode module address.");
+		goto reset;
+	}
+
+	/* Sort the entries so that we can find appropriate module from address. */
+	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
+	       mod_addr_comp, NULL, NULL);
+
+	/* Scan modules to make text delta for modules. */
+	module_for_each_mod(make_mod_delta, tr);
+
 	return;
  reset:
 	/* Invalid trace modules */
@@ -10101,19 +10185,23 @@ static bool trace_array_active(struct trace_array *tr)
 	return trace_events_enabled(tr, NULL) > 1;
 }
 
-static void trace_module_record(struct module *mod)
+static void trace_module_record(struct module *mod, bool remove)
 {
 	struct trace_array *tr;
+	unsigned long flags;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
-		    TRACE_ARRAY_FL_BOOT) {
+		if (flags == TRACE_ARRAY_FL_BOOT && !remove) {
 			/* Only update if the trace array is active */
 			if (trace_array_active(tr)) {
 				guard(mutex)(&scratch_mutex);
 				save_mod(mod, tr);
 			}
+		} else if (flags & TRACE_ARRAY_FL_LAST_BOOT) {
+			/* Update delta if the module loaded in previous boot */
+			make_mod_delta(mod, tr);
 		}
 	}
 }
@@ -10126,10 +10214,11 @@ static int trace_module_notify(struct notifier_block *self,
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_evals(mod);
-		trace_module_record(mod);
+		trace_module_record(mod, false);
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
+		trace_module_record(mod, true);
 		break;
 	}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0d6efb8a1179..3375f8301de3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -466,6 +466,8 @@ extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
+extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..1ad54fcf25cb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include "trace.h"
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
@@ -1248,7 +1249,6 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1265,7 +1265,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
 			continue;
 		}
-		seq_print_ip_sym(s, (*p) + delta, flags);
+		seq_print_ip_sym(s, trace_adjust_address(iter->tr, *p), flags);
 		trace_seq_putc(s, '\n');
 	}
 

