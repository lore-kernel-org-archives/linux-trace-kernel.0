Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EC20D500;
	Tue, 18 Mar 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305164; cv=none; b=kAzqfW3LZxCU475JudHMGXT9HlpIhdhBNNYutbTd4cCd6FyewUqQuJIMORWjYSK6oNqCFkBAMIJbk3Mbq9TUVcyyC7X/Od9Vru0NAuGkBhCCJJL8EplapY6EKV62wD4riLnyih3IgqfEl997K5g8r2IgxxNjKyzaVfMMn+ZijLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305164; c=relaxed/simple;
	bh=aGEDXsXkSVDpfNUB07MO05XWgQqMVTqlJV42K3CAcJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDvd5ReYcLcVUUpelpg5iPzG3l7eLemKKK53+I+Qr/snkWGiRm+gxi8YkhTQuAbZh4yZGc2T0i8RAb2ETeRZdv6khxyg+IovA0mEVTRrnUcJs+7+4u4o5UCwRd6DJIXUv3XknPQAp0qDjvKScOBz+x5nrV8mhVAcA/915JfcGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnKQd1aV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnKQd1aV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F9CC4CEDD;
	Tue, 18 Mar 2025 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742305164;
	bh=aGEDXsXkSVDpfNUB07MO05XWgQqMVTqlJV42K3CAcJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnKQd1aVM8DM2yCcXJTaL+C85SJBtnC35AmHV4mTpeZgh/77J6W5r5+8lwVtzIerv
	 yHXY6yHVjXBPUdzyxl3uYzq/95NnFU02916cC45S9EMuJeO1O5Z7C6z4vbtviXRCwv
	 xIqTV4j5YBieYVCFPJ+yqJPPUcj4nVklmbJ+nKfQ0RlZ6rhUI2mMmG8wUe575LNdkL
	 3gnnkHIs1h4bvRKjXAUaS8y43RBLAHF+mqS9MnrRNOcoaIXFzEghtkbWdZWdvyh35k
	 f3Y9DQd59vsmYesKeeROcaRU0MD/GU9l3+yiRop681X/dOkAL46ezmAGYkB4tJRJm4
	 YMc8pubg2pwbA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] tracing: Show last module text symbols in the stacktrace
Date: Tue, 18 Mar 2025 22:39:21 +0900
Message-ID:  <174230516153.2909896.11459658533253319657.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To:  <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
References:  <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
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


Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503112303.D7g66VSd-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Move module_delta to trace_array again.
  - Use bsearch for lookup module_delta.
  - Revert the boolean logic to avoid '!',
  - Fix !CONFIG_MODULES compile errors.
---
 kernel/trace/trace.c        |  128 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    3 +
 kernel/trace/trace_output.c |    4 +
 3 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 68abea81e51a..94d89053c033 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -6001,6 +6002,57 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+static int cmp_mod_entry(const void *key, const void *pivot)
+{
+	unsigned long addr = (unsigned long)key;
+	const struct trace_mod_entry *ent = pivot;
+
+	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
+		return 0;
+	else
+		return addr - ent->mod_addr;
+}
+
+/**
+ * trace_adjust_address() - Adjust prev boot address to current address.
+ * @tr: Persistent ring buffer's trace_array.
+ * @addr: Address in @tr which is adjusted.
+ */
+unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
+{
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	long *module_delta;
+	int idx = 0, nr_entries;
+
+	/* If we don't have last boot delta, return the address */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return addr;
+
+	tscratch = tr->scratch;
+	/* if there is no tscrach, module_delta must be NULL. */
+	module_delta = READ_ONCE(tr->module_delta);
+	if (!module_delta || tscratch->entries[0].mod_addr > addr)
+		return addr + tr->text_delta;
+
+	/* Note that entries must be sorted. */
+	nr_entries = tscratch->nr_entries;
+	if (nr_entries == 1 ||
+	    tscratch->entries[nr_entries - 1].mod_addr < addr)
+		idx = nr_entries - 1;
+	else {
+		entry = __inline_bsearch((void *)addr,
+				tscratch->entries,
+				nr_entries - 1,
+				sizeof(tscratch->entries[0]),
+				cmp_mod_entry);
+		if (entry)
+			idx = entry - tscratch->entries;
+	}
+
+	return addr + module_delta[idx];
+}
+
 #ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
@@ -6036,6 +6088,7 @@ static int save_mod(struct module *mod, void *data)
 static void update_last_data(struct trace_array *tr)
 {
 	struct trace_scratch *tscratch;
+	long *module_delta;
 
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
 		return;
@@ -6070,6 +6123,8 @@ static void update_last_data(struct trace_array *tr)
 		return;
 
 	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
+	WRITE_ONCE(tr->module_delta, NULL);
 
 	/* Set the persistent ring buffer meta data to this address */
 #ifdef CONFIG_RANDOMIZE_BASE
@@ -6078,6 +6133,8 @@ static void update_last_data(struct trace_array *tr)
 	tscratch->kaslr_addr = 0;
 #endif
 	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
+
+	kfree(module_delta);
 }
 
 /**
@@ -9349,10 +9406,46 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+#ifdef CONFIG_MODULES
+static int make_mod_delta(struct module *mod, void *data)
+{
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	struct trace_array *tr = data;
+	long *module_delta;
+	int i;
+
+	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
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
+#endif
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
+	long *module_delta;
+	int i, nr_entries;
 
 	if (!tscratch)
 		return;
@@ -9369,7 +9462,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9383,6 +9476,26 @@ static void setup_trace_scratch(struct trace_array *tr,
 		if (n == MODULE_NAME_LEN)
 			goto reset;
 	}
+
+	/* Sort the entries so that we can find appropriate module from address. */
+	nr_entries = tscratch->nr_entries;
+	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
+	       mod_addr_comp, NULL, NULL);
+
+	if (IS_ENABLED(CONFIG_MODULES)) {
+		module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
+		if (!module_delta) {
+			pr_info("module_delta allocation failed. Not able to decode module address.");
+			goto reset;
+		}
+	} else
+		module_delta = NULL;
+	WRITE_ONCE(tr->module_delta, module_delta);
+
+#ifdef CONFIG_MODULES
+	/* Scan modules to make text delta for modules. */
+	module_for_each_mod(make_mod_delta, tr);
+#endif
 	return;
  reset:
 	/* Invalid trace modules */
@@ -10108,19 +10221,23 @@ static bool trace_array_active(struct trace_array *tr)
 	return trace_events_enabled(tr, NULL) > 1;
 }
 
-static void trace_module_record(struct module *mod)
+static void trace_module_record(struct module *mod, bool add)
 {
 	struct trace_array *tr;
+	unsigned long flags;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
-		    TRACE_ARRAY_FL_BOOT) {
+		if (flags == TRACE_ARRAY_FL_BOOT && add) {
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
@@ -10133,10 +10250,11 @@ static int trace_module_notify(struct notifier_block *self,
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_evals(mod);
-		trace_module_record(mod);
+		trace_module_record(mod, true);
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
+		trace_module_record(mod, false);
 		break;
 	}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0d6efb8a1179..b6a4d3032e5c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -350,6 +350,7 @@ struct trace_array {
 	unsigned long		range_addr_size;
 	char			*range_name;
 	long			text_delta;
+	long			*module_delta;
 	void			*scratch; /* pointer in persistent memory */
 	int			scratch_size;
 
@@ -466,6 +467,8 @@ extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
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
 

