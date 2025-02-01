Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02412B73;
	Sat,  1 Feb 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394606; cv=none; b=eX55ch9Qxee3+rDobwaY/x55WwR1Tn9VphxQbV9fJyv/vDSX6eKeOYUvnlqu68Z2ywBFHYfgvKpXV+a1R7ivN0Okl2UQB1/Diu0zTm1uxelVJhAa9YhaPuF6L8vwCad1gBfj9eKdb2F4lQypwyt7VMdjE9L7BaVt4PeCmsai3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394606; c=relaxed/simple;
	bh=XbYLYhL+p+a93lrvGvcF5wj9z6ODld0rstcGiOfbXM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnaY26XhjXxtd69xg6s/CRyWk121aY5nu841e5GLmUF0t9X7xeO8wUBlcOH+ogkh9EcMCfyys7SESvYZ+2bKd72MhYD0HHOZP0deBYDBtVC2qnNzOcP1s2Rf5AAtZ5pnulHx6Tq/xJdAE2JKBLY2BtFCCjOIu6gqXQSC2S++BNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLdlva7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLdlva7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C938C4CEE0;
	Sat,  1 Feb 2025 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738394605;
	bh=XbYLYhL+p+a93lrvGvcF5wj9z6ODld0rstcGiOfbXM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLdlva7YfycBM/PNWSdy7EvfZgjDPoCkPjTTh6C9nrTE/2GI+0EYiO+7HkOnq55RR
	 zTtXN/7MPEXMWsLyRPZAkZ0tiB8NCQHAJKFOjUg0NGJhRE0xVE8uuTgTCq4oTs4NbT
	 iLbQps3cOpBNbsxO8z9VEErBZsqGZqoBV6pbj8UTbO/AZ4J+SlKVzb9ajRssGBgoYV
	 iM+ggti8G/MV/RKTBdxTwIPavh53+gRhORccmx6gRPrmFqa10AbtCvQgj5LjoOyR+l
	 TPHukuYmN3o8+TaYzpnG4BA4g83/mztd71wSTQIEqUpqD6UMDEh0cV7QSf8wZHXVJX
	 BwV2FrBfZ9Z2Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v2 2/2] tracing: Add relative-stacktrace option
Date: Sat,  1 Feb 2025 16:23:20 +0900
Message-ID: <173839460073.2009498.15281500159677989414.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173839458022.2009498.14495253908367838065.stgit@devnote2>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
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

Add "relative-stacktrace" option to save the stacktrace entries
as offset from the _stext or module's text section. For the
module address, each entry also saves the first 4bytes of the
build_id of the module so that it can find the appropriate
symbol from the offset.

By using this build_id, we can also easily find the corresponding
modules off-line. Thus this stacktrace data is in the persistent
ring buffer, the kernel can find appropriate modules after reboot
without saving previous live information.

This feature also shows the module name after the symbol as below.

   event-sample-1622    [005] ...1.  2112.978105: <stack trace>
 => event_triggers_post_call
 => trace_event_raw_event_foo_bar [trace_events_sample]
 => do_simple_thread_func [trace_events_sample]
 => simple_thread [trace_events_sample]
 => kthread
 => ret_from_fork
 => ret_from_fork_asm

The downside is the cost of time and memory (on 32bit arch). This
needs to find the module if the address in the module, and save
both of 32bit offset and 32bit hash for each entry, this may consume
twice memory on 32bit arch. On 64bit arch, the amount of consuming
memory is the same.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace.h        |    5 +++
 kernel/trace/Kconfig         |    1 +
 kernel/trace/trace.c         |   50 ++++++++++++++++++++++++++++++----
 kernel/trace/trace.h         |    3 ++
 kernel/trace/trace_entries.h |   18 ++++++++++++
 kernel/trace/trace_output.c  |   62 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index fdcd76b7be83..4b4f008a2fa9 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -26,6 +26,11 @@ struct trace_export {
 	int flags;
 };
 
+struct ftrace_rel_caller {
+	int		offset;
+	unsigned int	build_id32;
+} __packed;
+
 struct trace_array;
 
 #ifdef CONFIG_TRACING
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d570b8b9c0a9..b4bd186732fe 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -169,6 +169,7 @@ config TRACING
 	bool
 	select RING_BUFFER
 	select STACKTRACE if STACKTRACE_SUPPORT
+	select MODULE_BUILD_ID if STACKTRACE_SUPPORT
 	select TRACEPOINTS
 	select NOP_TRACER
 	select BINARY_PRINTF
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..ca17d9db37e8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2916,16 +2916,41 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
+static void record_as_offset(struct ftrace_rel_caller *caller, unsigned long addr)
+{
+	if (likely(core_kernel_text(addr))) {
+		caller->build_id32 = 0;
+		caller->offset = addr - (unsigned long)_stext;
+	} else if (addr == FTRACE_TRAMPOLINE_MARKER) {
+		caller->build_id32 = 0;
+		caller->offset = (int)FTRACE_TRAMPOLINE_MARKER;
+	} else {
+		struct module *mod = __module_text_address(addr);
+
+		if (mod) {
+			unsigned long base = (unsigned long)mod->mem[MOD_TEXT].base;
+
+			caller->offset = addr - base;
+			caller->build_id32 = *(unsigned int *)mod->build_id;
+		} else {
+			caller->build_id32 = 0;
+			caller->offset = addr - (unsigned long)_stext;
+		}
+	}
+}
+
 static void __ftrace_trace_stack(struct trace_array *tr,
 				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
 {
+	struct rel_stack_entry *rel_entry;
 	struct ring_buffer_event *event;
 	unsigned int size, nr_entries;
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	int type;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -2937,6 +2962,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 #endif
 
 	preempt_disable_notrace();
+	type = (tr->trace_flags & TRACE_ITER_REL_STACK) ? TRACE_REL_STACK : TRACE_STACK;
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
@@ -2977,16 +3003,28 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	}
 #endif
 
-	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-				    struct_size(entry, caller, nr_entries),
+	if (type == TRACE_REL_STACK)
+		size = struct_size(rel_entry, caller, nr_entries);
+	else
+		size = struct_size(entry, caller, nr_entries);
+
+	event = __trace_buffer_lock_reserve(buffer, type, size,
 				    trace_ctx);
 	if (!event)
 		goto out;
-	entry = ring_buffer_event_data(event);
 
-	entry->size = nr_entries;
-	memcpy(&entry->caller, fstack->calls,
-	       flex_array_size(entry, caller, nr_entries));
+	if (type == TRACE_REL_STACK) {
+		rel_entry = ring_buffer_event_data(event);
+		rel_entry->size = nr_entries;
+		for (int i = 0; i < nr_entries; i++)
+			record_as_offset((struct ftrace_rel_caller *)&rel_entry->caller[i],
+					fstack->calls[i]);
+	} else {
+		entry = ring_buffer_event_data(event);
+		entry->size = nr_entries;
+		memcpy(&entry->caller, fstack->calls,
+		       flex_array_size(entry, caller, nr_entries));
+	}
 
 	__buffer_unlock_commit(buffer, event);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..b27533456865 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -55,6 +55,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_REL_STACK,
 
 	__TRACE_LAST_TYPE,
 };
@@ -511,6 +512,7 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct ftrace_entry, TRACE_FN);	\
 		IF_ASSIGN(var, ent, struct ctx_switch_entry, 0);	\
 		IF_ASSIGN(var, ent, struct stack_entry, TRACE_STACK);	\
+		IF_ASSIGN(var, ent, struct rel_stack_entry, TRACE_REL_STACK);\
 		IF_ASSIGN(var, ent, struct userstack_entry, TRACE_USER_STACK);\
 		IF_ASSIGN(var, ent, struct print_entry, TRACE_PRINT);	\
 		IF_ASSIGN(var, ent, struct bprint_entry, TRACE_BPRINT);	\
@@ -1350,6 +1352,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(REL_STACK,		"relative-stacktrace"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fbfb396905a6..46a770e57287 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -229,6 +229,24 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
+FTRACE_ENTRY(kernel_rel_stack, rel_stack_entry,
+
+	TRACE_REL_STACK,
+
+	F_STRUCT(
+		__field(	int,		size	)
+		__stack_array(	u64,	caller,	FTRACE_STACK_ENTRIES, size)
+	),
+
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0], (void *)__entry->caller[1],
+		 (void *)__entry->caller[2], (void *)__entry->caller[3],
+		 (void *)__entry->caller[4], (void *)__entry->caller[5],
+		 (void *)__entry->caller[6], (void *)__entry->caller[7])
+);
+
 FTRACE_ENTRY(user_stack, userstack_entry,
 
 	TRACE_USER_STACK,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..b3748a5f5843 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1281,6 +1281,67 @@ static struct trace_event trace_stack_event = {
 	.funcs		= &trace_stack_funcs,
 };
 
+/* TRACE_REL_STACK */
+
+static enum print_line_t trace_rel_stack_print(struct trace_iterator *iter,
+					   int flags, struct trace_event *event)
+{
+	struct ftrace_rel_caller *p;
+	struct rel_stack_entry *field;
+	struct trace_seq *s = &iter->seq;
+	unsigned long base;
+	struct module *mod;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_puts(s, "<stack trace>\n");
+
+	for (int i = 0; i < field->size; i++) {
+		p = (struct ftrace_rel_caller *)&field->caller[i];
+
+		if (trace_seq_has_overflowed(s))
+			break;
+
+		trace_seq_puts(s, " => ");
+		if (p->offset == FTRACE_TRAMPOLINE_MARKER) {
+			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
+			continue;
+		}
+		if (p->build_id32) {
+			unsigned char build_id32[4];
+
+			guard(rcu)();
+			*(unsigned int *)build_id32 = p->build_id32;
+			mod = __module_build_id(build_id32, 4);
+			if (!mod) {
+				trace_seq_printf(s, "%x [MODULE %02x%02x%02x%02x]\n",
+						p->offset, build_id32[0], build_id32[1],
+						build_id32[2], build_id32[3]);
+				continue;
+			}
+			base = (unsigned long)mod->mem[MOD_TEXT].base;
+		} else {
+			mod = NULL;
+			base = (unsigned long)_stext;
+		}
+		seq_print_ip_sym(s, base + p->offset, flags);
+		if (mod)
+			trace_seq_printf(s, " [%s]", mod->name);
+		trace_seq_putc(s, '\n');
+	}
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_rel_stack_funcs = {
+	.trace		= trace_rel_stack_print,
+};
+
+static struct trace_event trace_rel_stack_event = {
+	.type		= TRACE_REL_STACK,
+	.funcs		= &trace_rel_stack_funcs,
+};
+
 /* TRACE_USER_STACK */
 static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 						int flags, struct trace_event *event)
@@ -1724,6 +1785,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_ctx_event,
 	&trace_wake_event,
 	&trace_stack_event,
+	&trace_rel_stack_event,
 	&trace_user_stack_event,
 	&trace_bputs_event,
 	&trace_bprint_event,

