Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0A23536F;
	Thu,  6 Feb 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861150; cv=none; b=EZwy5QqNNDHOig0+8QGptbUwpp82WkX7Ye+OUADDE6XB1UjYLZFhHJgtdiTrjXB1ErlxvCMEpVEqt0IVvzDI5Ag6fU09xCMFpIUMHLkJ35XJ5bgElhhTqP+1Te9WBNOFr5H7WfVQDVp4MaddWv6XlKrZrGZMBhDcEECh3VWRnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861150; c=relaxed/simple;
	bh=Vv1rWvEG1vtQbRCMEzpnWZNcYiEwH9BO7hPBylfcnqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm43BaaJNOBEc/X7YKls8PHkmamsTz8/SOS+lsnAI1PVrD4wRHQVWDLdFLbe8cImxEgKapimPrBQd/Kz8WgCUehP7HT1t+RtuBjQGFcng0DLTWuwh+7gDrTtS2KMp0QGYhn6XowQtbNWpWAeKvXXqxa38KF9udNhOtazC19bXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmpXJDUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmpXJDUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5457C4CEDD;
	Thu,  6 Feb 2025 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738861149;
	bh=Vv1rWvEG1vtQbRCMEzpnWZNcYiEwH9BO7hPBylfcnqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmpXJDUUVGGMlWAJid+2FOK3lSM/p42aJx+CyAFOpXl3mFdZbsBJvGvAWyEPbiJB1
	 VIi+OZcHUBhhic2O4Ok9GUNl+y5TTNwxrcEPah4o5pmz/8sQRct4RQBbdRGEafWueD
	 dAefxlReSkYNnCftvvdbTMUZUUVe851/SPJsN9ls4/inZdBHA9/0/V8rtDjXJ72Shv
	 hmngHaSGc8qcbjw5bIG0uqkkQ/q8lxT8n57wOKo9byvjxtN99vBevjAuFfi6M+40cO
	 HmvRXJwww9w3g6rWYlYWeg529j4Q4p1OQiUJISSaghkJ8axqnsOrudgVZ2JQ8sMny9
	 JfJqcqP9nk+Qw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] tracing: Show last module text symbols in the stacktrace
Date: Fri,  7 Feb 2025 01:59:05 +0900
Message-ID: <173886114516.496116.8314066678313037503.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
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
 kernel/trace/trace.c        |   76 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    4 ++
 kernel/trace/trace_output.c |    3 +-
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5a064e712fd7..9d942b7c2651 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -6007,6 +6008,27 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
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
@@ -6068,6 +6090,9 @@ static void update_last_data(struct trace_array *tr)
 
 	/* Using current data now */
 	tr->text_delta = 0;
+	kfree(tr->module_delta);
+	tr->module_delta = NULL;
+	tr->nr_modules = 0;
 
 	if (!tr->scratch)
 		return;
@@ -9351,10 +9376,37 @@ static struct dentry *trace_instance_dir;
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
+			return 1;
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
+	return e1->mod_addr - e2->mod_addr;
+}
+
 static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned int size)
 {
 	struct trace_scratch *tscratch = scratch;
 	struct trace_mod_entry *entry;
+	int i, nr_entries;
 
 	if (!scratch)
 		return;
@@ -9371,7 +9423,7 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9385,6 +9437,20 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
 		if (n == MODULE_NAME_LEN)
 			goto reset;
 	}
+	nr_entries = i;
+	/* Allocate module delta array */
+	tr->module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
+	if (!tr->module_delta)
+		goto reset;
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
@@ -10093,12 +10159,16 @@ static inline void trace_module_remove_evals(struct module *mod) { }
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
 			save_mod(mod, tr);
+		} else if (flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) {
+			/* Update delta if the module loaded in previous boot */
+			make_mod_delta(mod, tr);
 		}
 	}
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
 

