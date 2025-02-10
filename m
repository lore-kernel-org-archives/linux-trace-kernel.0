Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131024BD0E;
	Mon, 10 Feb 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202242; cv=none; b=ocAXqwU4k9K+AdmvTc1yzG/i1bCAoGzOvR8z6iZ9hfJd42tH5A16ycI4S8Z1J3PSYRuo0Iin2XyuVEPNpOgQ4c4I/xmNxNUi1wz+esucRaSqCOUWg5s/76fIGTPrtDF23hYqKenntlyhx+9pLVV7gybZ4yMkzOrXikam0jytCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202242; c=relaxed/simple;
	bh=hbiwv4GKs3XrAlFoh81Tpdf/O96z8Cv9LlFCY3rJL3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf1dfANwJCviHiCwrtRpV9RkH0JdnNrIrsp08DAoiO3RsplWHAbEws/hLLJxtibm0HJGgo9D5V95o19q363H76fVQF6Gt00VH78LooiGFGtczM9cmUPN3RCc3Hc+8SyM8x+09d/wRaMi2Gr2RmVZtVCqw6TAwKDgqmxakKqDbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv+57KY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv+57KY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F374C4CED1;
	Mon, 10 Feb 2025 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739202242;
	bh=hbiwv4GKs3XrAlFoh81Tpdf/O96z8Cv9LlFCY3rJL3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kv+57KY7pdgRAIROgkIalU9215CzvZscODHgkazAd5eZ7Y69vDCY2Hs0yJWFvXZCj
	 adWGNe9JRmCXNGIPo53v/DzXxTCObhzWjFVaFsFQU3n6RCNGjZJJSVQjakB/xpW6UP
	 fxq5pa/4WonZJcjSPNQeKY6MoDuhbITx6+TeNq+IdKTgeSBUoAlz3Tmbz7Ybd7+0n4
	 58lMl0KBj12Fe6t6BmL6KXNXtalUBWsxmSW9OIVPOyIX5rJkJrzq/XUlDnw4OmKKb+
	 2TS6P/WaMVRzPA44HRTNUy3p0QPNOUOclq2r4EP5F2d3oGP7z9xv7s+UhIYx+OpKpk
	 9y4VlWgGTG8Bg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 1/3] tracing: Show last module text symbols in the stacktrace
Date: Tue, 11 Feb 2025 00:43:57 +0900
Message-ID: <173920223724.826592.12665655620615313089.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173920222697.826592.3726270716809214055.stgit@devnote2>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
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
 Changes in v2:
  - Add LRU based removed module information override.
  - Fix to move module_delta initialization after tr->scratch check.
  - Fix to make mod_delta on all loaded modules correctly.
  - (Note, I don't add uname check yet)
  - Fix mod_addr_comp() overflow issue.
  - Add pr_info() when failed to allocate module_delta.
---
 kernel/trace/trace.c        |  173 ++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_output.c |    3 -
 3 files changed, 167 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 443f2bc5b856..dde8000a5614 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -6001,12 +6002,73 @@ struct trace_mod_entry {
 
 struct trace_scratch {
 	unsigned long		kaslr_addr;
-	unsigned long		nr_entries;
+	unsigned int		nr_entries;
+	int			oldest_removed;
 	struct trace_mod_entry	entries[];
 };
 
 static DEFINE_MUTEX(scratch_mutex);
 
+/* Encode LRU list at the lowest 8bits and use 9th bit as removed flag. */
+#define MOD_INDEX_MASK		GENMASK(7, 0)
+#define MOD_REMOVED_MASK	BIT(8)
+#define MOD_INDEX_LAST		MOD_INDEX_MASK
+
+static int decode_next_removed(struct trace_mod_entry *entry)
+{
+	if (WARN_ON_ONCE(!(entry->mod_addr & MOD_REMOVED_MASK)))
+		return -1;
+
+	if ((entry->mod_addr & MOD_INDEX_MASK) == MOD_INDEX_MASK)
+		return -1;
+
+	return (int)(entry->mod_addr & MOD_INDEX_MASK);
+}
+
+static int encode_last_removed(struct trace_scratch *tscratch, int last)
+{
+	struct trace_mod_entry *entry;
+	int idx = tscratch->oldest_removed;
+
+	if (WARN_ON_ONCE(last < 0 || last >= tscratch->nr_entries))
+		return -1;
+
+	if (idx < 0) {
+		tscratch->oldest_removed = last;
+	} else {
+		do {
+			entry = &tscratch->entries[idx];
+			idx = entry->mod_addr & MOD_INDEX_MASK;
+		} while (idx != MOD_INDEX_LAST);
+		entry->mod_addr &= ~MOD_INDEX_MASK;
+		entry->mod_addr |= last;
+	}
+	entry = &tscratch->entries[last];
+	entry->mod_addr |= MOD_REMOVED_MASK | MOD_INDEX_LAST;
+	return 0;
+}
+
+unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
+{
+	struct trace_scratch *tscratch;
+	int i;
+
+	/* If we don't have last boot delta, return the address */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return addr;
+
+	tscratch = tr->scratch;
+	if (tscratch && tr->module_delta && tscratch->entries[0].mod_addr < addr) {
+		/* Note that entries are sorted */
+		for (i = 0; i < tr->nr_modules; i++)
+			if (addr < tscratch->entries[i].mod_addr)
+				break;
+		return addr + tr->module_delta[i - 1];
+	}
+
+	return addr + tr->text_delta;
+}
+
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6021,12 +6083,18 @@ static int save_mod(struct module *mod, void *data)
 		return -1;
 	size = tr->scratch_size;
 
-	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size)
-		return -1;
+	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size) {
+		int idx = tscratch->oldest_removed;
 
-	entry = &tscratch->entries[tscratch->nr_entries];
+		if (idx < 0)
+			return -1;
+		entry = &tscratch->entries[idx];
+		tscratch->oldest_removed = decode_next_removed(entry);
+	} else {
+		entry = &tscratch->entries[tscratch->nr_entries];
 
-	tscratch->nr_entries++;
+		tscratch->nr_entries++;
+	}
 
 	entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
 	strscpy(entry->mod_name, mod->name);
@@ -6063,14 +6131,17 @@ static void update_last_data(struct trace_array *tr)
 	 */
 	tracing_reset_all_cpus(&tr->array_buffer);
 
-	/* Using current data now */
-	tr->text_delta = 0;
-
 	if (!tr->scratch)
 		return;
 
 	tscratch = tr->scratch;
 
+	/* Using current data now */
+	tr->text_delta = 0;
+	kfree(tr->module_delta);
+	tr->module_delta = NULL;
+	tr->nr_modules = 0;
+
 	/* Set the persistent ring buffer meta data to this address */
 #ifdef CONFIG_RANDOMIZE_BASE
 	tscratch->kaslr_addr = kaslr_offset();
@@ -9349,10 +9420,37 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+static int make_mod_delta(struct module *mod, void *data)
+{
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	struct trace_array *tr = data;
+	int i;
+
+	tscratch = tr->scratch;
+	for (i = 0; i < tr->nr_modules; i++) {
+		entry = &tscratch->entries[i];
+		if (!strcmp(mod->name, entry->mod_name)) {
+			tr->module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base - entry->mod_addr;
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
 static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned int size)
 {
 	struct trace_scratch *tscratch = scratch;
 	struct trace_mod_entry *entry;
+	int i, nr_entries;
 
 	if (!scratch)
 		return;
@@ -9369,7 +9467,7 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9383,6 +9481,22 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
 		if (n == MODULE_NAME_LEN)
 			goto reset;
 	}
+	nr_entries = i;
+	/* Allocate module delta array */
+	tr->module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
+	if (!tr->module_delta) {
+		pr_info("module_delta allocation failed. Not able to decode module address.");
+		goto reset;
+	}
+	tr->nr_modules = nr_entries;
+
+	/* Sort module table by base address. */
+	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
+		mod_addr_comp, NULL, NULL);
+
+	/* Scan modules */
+	module_for_each_mod(make_mod_delta, tr);
+
 	return;
  reset:
 	/* Invalid trace modules */
@@ -10100,14 +10214,50 @@ static bool trace_array_active(struct trace_array *tr)
 static void trace_module_record(struct module *mod)
 {
 	struct trace_array *tr;
+	unsigned long flags;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
-		    TRACE_ARRAY_FL_BOOT) {
+		if (flags == TRACE_ARRAY_FL_BOOT) {
 			/* Only update if the trace array is active */
 			if (trace_array_active(tr))
 				save_mod(mod, tr);
+		} else if (flags & TRACE_ARRAY_FL_LAST_BOOT) {
+			/* Update delta if the module loaded in previous boot */
+			make_mod_delta(mod, tr);
+		}
+	}
+}
+
+static void mark_mod_removed(struct trace_array *tr, struct module *mod)
+{
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	int i;
+
+	tscratch = tr->scratch;
+	for (i = 0; i < tscratch->nr_entries; i++) {
+		entry = &tscratch->entries[i];
+		if (!strcmp(entry->mod_name, mod->name)) {
+			encode_last_removed(tscratch, i);
+			break;
+		}
+	}
+}
+
+static void trace_module_mark_remove(struct module *mod)
+{
+	struct trace_array *tr;
+	unsigned long flags;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
+		/* Update any persistent trace array that has already been started */
+		if (flags == TRACE_ARRAY_FL_BOOT) {
+			/* Only update if the trace array is active */
+			if (trace_array_active(tr))
+				mark_mod_removed(tr, mod);
 		}
 	}
 }
@@ -10124,6 +10274,7 @@ static int trace_module_notify(struct notifier_block *self,
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
+		trace_module_mark_remove(mod);
 		break;
 	}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 90493220c362..47c0742fe9ec 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -349,6 +349,8 @@ struct trace_array {
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
 	long			text_delta;
+	int			nr_modules;
+	long			*module_delta;
 	void			*scratch; /* pointer in persistent memory */
 	int			scratch_size;
 
@@ -465,6 +467,8 @@ extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
+extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..a5336c4ece8e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1248,7 +1248,6 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1265,7 +1264,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
 			continue;
 		}
-		seq_print_ip_sym(s, (*p) + delta, flags);
+		seq_print_ip_sym(s, trace_adjust_address(iter->tr, *p), flags);
 		trace_seq_putc(s, '\n');
 	}
 

