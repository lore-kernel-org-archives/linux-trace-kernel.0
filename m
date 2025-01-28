Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C41CEAD3;
	Tue, 28 Jan 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078640; cv=none; b=CWePe1Uz8t59IhuWQXVY/2Akqq0qWsr4ksbqwq8BhdjBHr9gDwcZnlbVKZfEw+EjxumIQaz3YTG8HXTt0dvxDNnJVYHc9ITD6H+2ZRuJUnkv+N+GHcXB63Iabo0mmhWvzgAh+ZhU52v3r7dk5GGvPjP9rJiyQSjrs5ectfXxdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078640; c=relaxed/simple;
	bh=HxL2+rxyJD0yjUQFxXAQiu1fzSMY1ftF2DKBxP+5nxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/yevKwyDvpbzTEyIUDERKYhbPVcWhaZAV8hw3IsjeS0TVKahbyHfhdp5HTiACv060pWsPyuhdbqt4pcnod5c0oAjEke3B8USZA9omsw9iuY/Jd5p4l2MidLHpQYaXsjO5KOYzGnsbbtkekN/G0i+dG7+mhpjoPsWhS6gqDJ0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OslkblKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OslkblKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47F6C4CED3;
	Tue, 28 Jan 2025 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078639;
	bh=HxL2+rxyJD0yjUQFxXAQiu1fzSMY1ftF2DKBxP+5nxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OslkblKGvalxeQXmDP2nhKDI/AaSG5uB6ZR7CC0kaZU5rrMnRZrZt2xmhdsG9pcIY
	 zEKE+Oz+DL8+eUkKFC8B52VEOWdVLzsN/dGxcHW5g66zwjaq0dpEwolt/67Zlf2iNb
	 14StPhcCm98r7YfVQXvAtXd6C7XXfUQx4Entb0NOPKPz0t5YuDcDD3YEedSGFitn+I
	 5f2Lp9hPS0vWTCp6n4bERTjxwGz0wBl/N/1XEVpEtthRw3O5NtJFt+ta7jqPh1LnDb
	 PP0kayQhhoekeLLu3akZAWDirnLfN9HpyH1oA334zWYIgajsrmekAAbUNndyQT7FzH
	 M1qykBfelP3UA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [RFC PATCH 2/3] tracing: Introduce "rel_stack" option
Date: Wed, 29 Jan 2025 00:37:15 +0900
Message-ID:  <173807863557.1525539.14465198884840039000.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
References:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
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

Since the relative offset stacktrace requires a special module loading
events to decode binary, it should be an optional for normal use case.
User can enable this feature via `options/relative-stacktrace`.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c         |   13 ++++++++-----
 kernel/trace/trace.h         |    2 ++
 kernel/trace/trace_entries.h |   22 ++++++++++++++++++++++
 kernel/trace/trace_output.c  |   37 ++++++++++++++++++++++++++++++++-----
 4 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e86a43b368c..b4da5e29957f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2926,6 +2926,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	int type;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -2937,6 +2938,7 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 #endif
 
 	preempt_disable_notrace();
+	type = (tr->trace_flags & TRACE_ITER_REL_STACK_BIT) ? TRACE_REL_STACK : TRACE_STACK;
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
@@ -2973,17 +2975,18 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 		for (int i = 0; i < nr_entries; i++) {
 			if (calls[i] >= tramp_start && calls[i] < tramp_end)
 				calls[i] = FTRACE_TRAMPOLINE_MARKER;
-			else
+			else if (type == TRACE_REL_STACK)
 				calls[i] -= (unsigned long)_stext;
 		}
 	}
 #else
-	/* Adjsut entries as the offset from _stext, instead of raw address. */
-	for (int i = 0; i < nr_entries; i++)
-		fstack->calls[i] -= (unsigned long)_stext;
+	if (type == TRACE_REL_STACK)
+		/* Adjsut entries as the offset from _stext, instead of raw address. */
+		for (int i = 0; i < nr_entries; i++)
+			fstack->calls[i] -= (unsigned long)_stext;
 #endif
 
-	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
+	event = __trace_buffer_lock_reserve(buffer, type,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
 	if (!event)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..602aea0ec69a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -55,6 +55,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_REL_STACK,
 
 	__TRACE_LAST_TYPE,
 };
@@ -1350,6 +1351,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(REL_STACK,	"relative-stacktrace"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fbfb396905a6..7769f95b70fe 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -229,6 +229,28 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
+FTRACE_ENTRY_DUP(kernel_rel_stack, stack_entry,
+
+	TRACE_REL_STACK,
+
+	F_STRUCT(
+		__field(	int,		size	)
+		__stack_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES, size)
+	),
+
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0] + (unsigned long)_stext,
+		 (void *)__entry->caller[1] + (unsigned long)_stext,
+		 (void *)__entry->caller[2] + (unsigned long)_stext,
+		 (void *)__entry->caller[3] + (unsigned long)_stext,
+		 (void *)__entry->caller[4] + (unsigned long)_stext,
+		 (void *)__entry->caller[5] + (unsigned long)_stext,
+		 (void *)__entry->caller[6] + (unsigned long)_stext,
+		 (void *)__entry->caller[7] + (unsigned long)_stext)
+);
+
 FTRACE_ENTRY(user_stack, userstack_entry,
 
 	TRACE_USER_STACK,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 497872df48f6..47e4ab549e81 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1239,16 +1239,17 @@ static struct trace_event trace_wake_event = {
 	.funcs		= &trace_wake_funcs,
 };
 
-/* TRACE_STACK */
-
-static enum print_line_t trace_stack_print(struct trace_iterator *iter,
-					   int flags, struct trace_event *event)
+static enum print_line_t trace_kernel_stack_print(struct trace_iterator *iter,
+					   int flags, struct trace_event *event, bool relative)
 {
 	struct stack_entry *field;
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = (unsigned long)_stext + iter->tr->text_delta;
+	long delta = iter->tr->text_delta;
+
+	if (relative)
+		delta += (unsigned long)_stext;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1272,6 +1273,14 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	return trace_handle_return(s);
 }
 
+/* TRACE_STACK */
+
+static enum print_line_t trace_stack_print(struct trace_iterator *iter,
+					   int flags, struct trace_event *event)
+{
+	return trace_kernel_stack_print(iter, flags, event, false);
+}
+
 static struct trace_event_functions trace_stack_funcs = {
 	.trace		= trace_stack_print,
 };
@@ -1281,6 +1290,23 @@ static struct trace_event trace_stack_event = {
 	.funcs		= &trace_stack_funcs,
 };
 
+/* TRACE_REL_STACK */
+
+static enum print_line_t trace_rel_stack_print(struct trace_iterator *iter,
+					   int flags, struct trace_event *event)
+{
+	return trace_kernel_stack_print(iter, flags, event, true);
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
@@ -1724,6 +1750,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_ctx_event,
 	&trace_wake_event,
 	&trace_stack_event,
+	&trace_rel_stack_event,
 	&trace_user_stack_event,
 	&trace_bputs_event,
 	&trace_bprint_event,

