Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FE25DCF1;
	Mon, 24 Mar 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826896; cv=none; b=rx8vD18n/3/R/dZoBqZdzkHX6XsBDc+ZlHuJL3BUSxOI8RyjxbAqsF9BcZ5u3LFYiB1B6P+1wfC1PpDg8sElBTMlnzqVJF8NuEXeSLVRQH7w3DpuqHM16yZmG7E7BNvZ+utdu+c79v7yxdAoiWW4by0mcotxNja0V2IFVwzNCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826896; c=relaxed/simple;
	bh=g0DMiciHGRTAgBPb/myWkaFmOFaVz7rSqmfjA3qYIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft9i/lcreyLsrxfgDh2hj1Pt7yb6N/vwFdTNV/DAJ5WV+usy58u6A0FPz13MLA/UZpSvA/JmFTGPFQHcdiHDUOziidHjHG2mkvQJP3VC1jabFvjjrzTWvl8mnbBycXFSzv/OfBLySgKCC4UeHStnK+dQ237klnsiysUysIcvKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj0fFPyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj0fFPyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF989C4CEDD;
	Mon, 24 Mar 2025 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826894;
	bh=g0DMiciHGRTAgBPb/myWkaFmOFaVz7rSqmfjA3qYIwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj0fFPyYATvb1AG8DK3pR6XuodKuJHeiK66PLMp2p4h2UH0BR2D7o5YTz5dMEmIRi
	 dqGl/m0s6Rpv3YgkOHGuoaQk5HblmPiqmaxVq0ZtiGrWtQxWbtF/YA3/+Tzb/GYQ6n
	 8NRkDynKYy7EScs6AUsCaXF75CFWn+MGVUIO/GWOpd582jWYajo7CnGTgDJ/DOFaKi
	 VGjnH5VWnTbDmwirjwknxDAbeeT8DjDsH89WMsQT7Otm02oePrX+ChWTJgXGU2WkWE
	 wFnEBeIlrgq+xgi8GwfSlLnebSuNb1gTcyB6nBQfeJZqkXqC9fT9SYQvkHL6pncO01
	 XwazAKzwwEADQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 1/1] tracing: Show last module text symbols in the stacktrace
Date: Mon, 24 Mar 2025 23:34:52 +0900
Message-ID:  <174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To:  <174282688292.356346.8368421078882769536.stgit@mhiramat.tok.corp.google.com>
References:  <174282688292.356346.8368421078882769536.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v6:
  - Protect module_delta by RCU.
  - Make nop make_mod_delta() for CONFIG_MODULES=n.
  - Rebased on linux-trace/for-next.
 Changes in v4:
  - Move module_delta to trace_array again.
  - Use bsearch for lookup module_delta.
  - Revert the boolean logic to avoid '!',
  - Fix !CONFIG_MODULES compile errors.
---
 kernel/trace/trace.c        |  133 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    8 +++
 kernel/trace/trace_output.c |    4 +
 3 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c920fbc538fb..f6ddcda010c3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -6019,6 +6020,59 @@ struct trace_scratch {
 
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
+	struct trace_module_delta *module_delta;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	int idx = 0, nr_entries;
+
+	/* If we don't have last boot delta, return the address */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return addr;
+
+	/* tr->module_delta must be protected by rcu. */
+	guard(rcu)();
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
+	return addr + module_delta->delta[idx];
+}
+
 #ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
@@ -6053,6 +6107,7 @@ static int save_mod(struct module *mod, void *data)
 
 static void update_last_data(struct trace_array *tr)
 {
+	struct trace_module_delta *module_delta;
 	struct trace_scratch *tscratch;
 
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
@@ -6091,6 +6146,9 @@ static void update_last_data(struct trace_array *tr)
 		return;
 
 	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
+	WRITE_ONCE(tr->module_delta, NULL);
+	kfree_rcu(module_delta, rcu);
 
 	/* Set the persistent ring buffer meta data to this address */
 #ifdef CONFIG_RANDOMIZE_BASE
@@ -9369,10 +9427,51 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+#ifdef CONFIG_MODULES
+static int make_mod_delta(struct module *mod, void *data)
+{
+	struct trace_module_delta *module_delta;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	struct trace_array *tr = data;
+	int i;
+
+	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
+	for (i = 0; i < tscratch->nr_entries; i++) {
+		entry = &tscratch->entries[i];
+		if (strcmp(mod->name, entry->mod_name))
+			continue;
+		if (mod->state == MODULE_STATE_GOING)
+			module_delta->delta[i] = 0;
+		else
+			module_delta->delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
+						 - entry->mod_addr;
+		break;
+	}
+	return 0;
+}
+#else
+static int make_mod_delta(struct module *mod, void *data)
+{
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
+	struct trace_module_delta *module_delta;
 	struct trace_mod_entry *entry;
+	int i, nr_entries;
 
 	if (!tscratch)
 		return;
@@ -9389,7 +9488,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9403,6 +9502,25 @@ static void setup_trace_scratch(struct trace_array *tr,
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
+		module_delta = kzalloc(struct_size(module_delta, delta, nr_entries), GFP_KERNEL);
+		if (!module_delta) {
+			pr_info("module_delta allocation failed. Not able to decode module address.");
+			goto reset;
+		}
+		init_rcu_head(&module_delta->rcu);
+	} else
+		module_delta = NULL;
+	WRITE_ONCE(tr->module_delta, module_delta);
+
+	/* Scan modules to make text delta for modules. */
+	module_for_each_mod(make_mod_delta, tr);
 	return;
  reset:
 	/* Invalid trace modules */
@@ -10119,16 +10237,20 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
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
 			guard(mutex)(&scratch_mutex);
 			save_mod(mod, tr);
+		} else if (flags & TRACE_ARRAY_FL_LAST_BOOT) {
+			/* Update delta if the module loaded in previous boot */
+			make_mod_delta(mod, tr);
 		}
 	}
 }
@@ -10141,10 +10263,11 @@ static int trace_module_notify(struct notifier_block *self,
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
index 89949a64e742..c20f6bcc200a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -313,6 +313,11 @@ struct trace_func_repeats {
 	u64		ts_last_call;
 };
 
+struct trace_module_delta {
+	struct rcu_head	rcu;
+	long		delta[];
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -351,6 +356,7 @@ struct trace_array {
 	unsigned long		range_addr_size;
 	char			*range_name;
 	long			text_delta;
+	struct trace_module_delta *module_delta;
 	void			*scratch; /* pointer in persistent memory */
 	int			scratch_size;
 
@@ -467,6 +473,8 @@ extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
+extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b51ee9373773..3c86eed662bb 100644
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
@@ -1345,7 +1346,6 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1362,7 +1362,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
 			continue;
 		}
-		seq_print_ip_sym(s, (*p) + delta, flags);
+		seq_print_ip_sym(s, trace_adjust_address(iter->tr, *p), flags);
 		trace_seq_putc(s, '\n');
 	}
 

