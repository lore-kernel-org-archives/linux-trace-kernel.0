Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1381643B;
	Tue, 23 Jun 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179083; cv=none; b=bz9sl97ei8Pjoe8QsnPvuXv8koJvzq1pX0gamvCU2IhmPsyCbA1uRhnYGx7tNNFyprBkyFlMasxhn2B05HQvuVst3PWyMM+eTK0MSs6p+zyKutAh5d2w/mwWa7PWW6mVyiOkyWFL4mXg8Tocb0boOmJSjrqYnIrYDHSg9Ll/EQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179083; c=relaxed/simple;
	bh=tbR7cud76g27NO+9ObpVKHHoYA+n/x2FdHVn/M1DiNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9l14geLjIG83VYaMMfLS/RijWWjpyP9bjzWNkX4tYaathJ8F4hTM2h4wcLW1iLEP4gzTyx4hUqYsCLe675RjdoD0xfek0hmmibV5LiOHBMJn3OADLg9+JYWBnUytpeSAymtj5LBiFMAKrfSHkgDMehBeIqD1Y2oGW2CTSqnVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdunuH8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdunuH8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8311F000E9;
	Tue, 23 Jun 2026 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179082;
	bh=YohM4Nkk848xgxhCcqAx9WjRY5lEbmfBMauwNbLSKzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdunuH8bYDF0O5/e7FisRwR7Ker8YrqeZi4ji34oUOu7divHyLQlg1RfHf3a7nBod
	 qHIUTOuQslJand0uj7LQ9cK1z4a3TnHcVLIsKcbV3DWTrdOIC7iV0E4eq9vRGtHf9N
	 bylkfA/PspwLT2y3BSAVpOUZO3f6pxMjfYc+Pa6xwBgjwyEUcc2Y3kX9UB84UQhmU5
	 1UbuBaIr81k0+lsBTC8VmHo6H/nx+freR8myNPQBcwmKq+vmKRK5uLBH6CZ0aRKQxG
	 Ikv5wpB7Oei5O456uEL+3UcB/8mXBG6rUNW6IWwRCy3VQv3oq0g/tPDIEOef5CuZaE
	 ZNmPTVZnpasOg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 03/10] tracing/probes: Support dumping fetcharg program for debugging dynamic events
Date: Tue, 23 Jun 2026 10:44:38 +0900
Message-ID: <178217907822.643090.14693478306190628970.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178217904992.643090.15726197350652241270.stgit@devnote2>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
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

For debugging probe events, it is helpful to verify the compiled
fetch instructions for each probe argument. This introduces a new
kernel config CONFIG_PROBE_EVENTS_DUMP_FETCHARG to decode the
instruction sequence of each argument and display it under a
commented line starting with '#' immediately following the dynamic
event definition (such as in dynamic_events, kprobe_events,
uprobe_events, etc.).

For example:
 /sys/kernel/tracing # cat dynamic_events
 p:kprobes/p_vfs_read_0 vfs_read arg1=+0(file):ustring arg2=%ax:x16
 #  arg1: ARG(0) -> ST_USTRING(offset=0,size=4) -> END
 #  arg2: REG(80) -> ST_RAW(size=2) -> END

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
   - Show trace event field name for FETCH_OP_TP_ARG.
   - Show immediate string value for FETCH_OP_IMMSTR.
   - Fix style issues warned by checkpatch.pl.
 Changes in v6:
   - Newly added.
---
 kernel/trace/Kconfig        |   11 +++++
 kernel/trace/trace_eprobe.c |    2 +
 kernel/trace/trace_fprobe.c |    2 +
 kernel/trace/trace_kprobe.c |    2 +
 kernel/trace/trace_probe.c  |   96 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |   79 +++++++++++++++++++++--------------
 kernel/trace/trace_uprobe.c |    3 +
 7 files changed, 163 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e130da35808f..ed83fbfb4b7c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -779,6 +779,17 @@ config PROBE_EVENTS_BTF_ARGS
 	  kernel function entry or a tracepoint.
 	  This is available only if BTF (BPF Type Format) support is enabled.
 
+config PROBE_EVENTS_DUMP_FETCHARG
+	depends on PROBE_EVENTS
+	bool "Dump of dynamic probe event fetch-arguments"
+	default n
+	help
+	  This shows the dump of fetch-arguments of dynamic probe events
+	  alongside their event definitions in the dynamic_events file
+	  as comment lines. This is useful to debug the probe events.
+
+	  If unsure, say N.
+
 config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 50518b071414..462c31145733 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -87,6 +87,8 @@ static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev)
 		seq_printf(m, " %s=%s", ep->tp.args[i].name, ep->tp.args[i].comm);
 	seq_putc(m, '\n');
 
+	trace_probe_dump_args(m, &ep->tp);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 4d1abbf66229..536781cd4c47 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1449,6 +1449,8 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
 	seq_putc(m, '\n');
 
+	trace_probe_dump_args(m, &tf->tp);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a8420e6abb56..cfa807d8e760 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1320,6 +1320,8 @@ static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_printf(m, " %s=%s", tk->tp.args[i].name, tk->tp.args[i].comm);
 	seq_putc(m, '\n');
 
+	trace_probe_dump_args(m, &tk->tp);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d1c55596725b..5e6a680b2ce7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2394,3 +2394,99 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 	}
 	return 0;
 }
+
+#ifdef CONFIG_PROBE_EVENTS_DUMP_FETCHARG
+
+struct fetch_op_decode {
+	const char *name;
+	void (*decode)(struct seq_file *m, struct fetch_insn *insn);
+};
+
+static const struct fetch_op_decode fetch_op_decode[];
+
+static void fetcharg_decode_none(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_puts(m, fetch_op_decode[insn->op].name);
+}
+
+static void fetcharg_decode_param(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(%u)", fetch_op_decode[insn->op].name, insn->param);
+}
+
+static void fetcharg_decode_imm(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(0x%lx)", fetch_op_decode[insn->op].name, insn->immediate);
+}
+
+static void fetcharg_decode_string(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(%s)", fetch_op_decode[insn->op].name, (char *)insn->data);
+}
+
+static void fetcharg_decode_symbol(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(%s)", fetch_op_decode[insn->op].name, (char *)insn->data);
+}
+
+static void fetcharg_decode_offset(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(offset=%d)", fetch_op_decode[insn->op].name, insn->offset);
+}
+
+static void fetcharg_decode_store(struct seq_file *m, struct fetch_insn *insn)
+{
+	if (insn->op == FETCH_OP_ST_RAW)
+		seq_printf(m, "%s(size=%u)", fetch_op_decode[insn->op].name, insn->size);
+	else
+		seq_printf(m, "%s(offset=%d,size=%u)", fetch_op_decode[insn->op].name,
+			  insn->offset, insn->size);
+}
+
+static void fetcharg_decode_bf(struct seq_file *m, struct fetch_insn *insn)
+{
+	seq_printf(m, "%s(basesize=%u,lshift=%u,rshift=%u)",
+		   fetch_op_decode[insn->op].name, insn->basesize, insn->lshift, insn->rshift);
+}
+
+static void fetcharg_decode_tp_arg(struct seq_file *m, struct fetch_insn *insn)
+{
+	struct ftrace_event_field *field = insn->data;
+
+	seq_printf(m, "%s(%s)", fetch_op_decode[insn->op].name, field->name);
+}
+
+#define FETCH_OP(opname, decode_fn) \
+	[FETCH_OP_##opname] = { .name = #opname, .decode = fetcharg_decode_##decode_fn }
+
+static const struct fetch_op_decode fetch_op_decode[] = FETCH_OP_LIST;
+#undef FETCH_OP
+
+static void trace_probe_dump_arg(struct seq_file *m, struct probe_arg *parg)
+{
+	int i;
+
+	seq_printf(m, "#  %s: ", parg->name);
+	for (i = 0; i < FETCH_INSN_MAX; i++) {
+		struct fetch_insn *insn = parg->code + i;
+
+		if (insn->op >= ARRAY_SIZE(fetch_op_decode) || !fetch_op_decode[insn->op].decode)
+			seq_printf(m, "unknown(%d)", insn->op);
+		else
+			fetch_op_decode[insn->op].decode(m, insn);
+
+		if (insn->op == FETCH_OP_END)
+			break;
+		seq_puts(m, " -> ");
+	}
+	seq_putc(m, '\n');
+}
+
+void trace_probe_dump_args(struct seq_file *m, struct trace_probe *tp)
+{
+	int i;
+
+	for (i = 0; i < tp->nr_args; i++)
+		trace_probe_dump_arg(m, &tp->args[i]);
+}
+#endif /* CONFIG_PROBE_EVENTS_DUMP_FETCHARG */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index cd586e67b21a..a9a7e0fc04ca 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -83,38 +83,46 @@ static nokprobe_inline u32 update_data_loc(u32 loc, int consumed)
 /* Printing function type */
 typedef int (*print_type_func_t)(struct trace_seq *, void *, void *);
 
-enum fetch_op {
-	FETCH_OP_NOP = 0,
-	// Stage 1 (load) ops
-	FETCH_OP_REG,		/* Register : .param = offset */
-	FETCH_OP_STACK,		/* Stack : .param = index */
-	FETCH_OP_STACKP,	/* Stack pointer */
-	FETCH_OP_RETVAL,	/* Return value */
-	FETCH_OP_IMM,		/* Immediate : .immediate */
-	FETCH_OP_COMM,		/* Current comm */
-	FETCH_OP_ARG,		/* Function argument : .param */
-	FETCH_OP_FOFFS,		/* File offset: .immediate */
-	FETCH_OP_IMMSTR,	/* Allocated string: .data */
-	FETCH_OP_EDATA,		/* Entry data: .offset */
-	// Stage 2 (dereference) op
-	FETCH_OP_DEREF,		/* Dereference: .offset */
-	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
-	// Stage 3 (store) ops
-	FETCH_OP_ST_RAW,	/* Raw: .size */
-	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
-	FETCH_OP_ST_UMEM,	/* Mem: .offset, .size */
-	FETCH_OP_ST_STRING,	/* String: .offset, .size */
-	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
-	FETCH_OP_ST_SYMSTR,	/* Kernel Symbol String: .offset, .size */
-	FETCH_OP_ST_EDATA,	/* Store Entry Data: .offset */
-	// Stage 4 (modify) op
-	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
-	// Stage 5 (loop) op
-	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
-	FETCH_OP_TP_ARG,	/* Trace Point argument */
-	FETCH_OP_END,
-	FETCH_NOP_SYMBOL,	/* Unresolved Symbol holder */
-};
+#define FETCH_OP_LIST	{						\
+	/* Stage 1 (load) ops */					\
+	FETCH_OP(NOP, none),		/* NOP */			\
+	FETCH_OP(REG, param),		/* Register: .param = offset */	\
+	FETCH_OP(STACK, param),		/* Stack: .param = index */	\
+	FETCH_OP(STACKP, none),		/* Stack pointer */		\
+	FETCH_OP(RETVAL, none),		/* Return value */		\
+	FETCH_OP(IMM, imm),		/* Immediate: .immediate */	\
+	FETCH_OP(COMM, none),		/* Current comm */		\
+	FETCH_OP(ARG, param),		/* Argument: .param = index */	\
+	FETCH_OP(FOFFS, imm),		/* File offset: .immediate */	\
+	FETCH_OP(IMMSTR, string),	/* Allocated string: .data */	\
+	FETCH_OP(EDATA, offset),	/* Entry data: .offset */	\
+	FETCH_OP(TP_ARG, tp_arg),	/* Tracepoint argument: .data */\
+	/* Stage 2 (dereference) ops */					\
+	FETCH_OP(DEREF, offset),	/* Dereference: .offset */	\
+	FETCH_OP(UDEREF, offset),	/* User-space dereference: .offset */\
+	/* Stage 3 (store) ops */					\
+	FETCH_OP(ST_RAW, store),	/* Raw value: .size */		\
+	FETCH_OP(ST_MEM, store),	/* Memory: .offset, .size */	\
+	FETCH_OP(ST_UMEM, store),	/* User memory: .offset, .size */\
+	FETCH_OP(ST_STRING, store),	/* String: .offset, .size */	\
+	FETCH_OP(ST_USTRING, store),	/* User string: .offset, .size */\
+	FETCH_OP(ST_SYMSTR, store),	/* Symbol name: .offset, .size */\
+	FETCH_OP(ST_EDATA, offset),	/* Entry data: .offset */	\
+	/* Stage 4 (modify) op */					\
+	FETCH_OP(MOD_BF, bf),		/* Bitfield: .basesize, .lshift, .rshift*/\
+	/* Stage 5 (loop) op */						\
+	FETCH_OP(LP_ARRAY, param),	/* Loop array: .param = count */\
+	/* End */							\
+	FETCH_OP(END, none),						\
+	/* Unresolved Symbol holder */					\
+	FETCH_OP(NOP_SYMBOL, symbol),	/* Non loaded symbol: .data = symbol name */\
+}
+
+#define FETCH_OP(opname, decode_fn) FETCH_OP_##opname
+enum fetch_op FETCH_OP_LIST;
+#undef FETCH_OP
+
+#define FETCH_NOP_SYMBOL FETCH_OP_NOP_SYMBOL
 
 struct fetch_insn {
 	enum fetch_op op;
@@ -370,6 +378,13 @@ bool trace_probe_match_command_args(struct trace_probe *tp,
 int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
 int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_args,
 		 u8 *data, void *field);
+#ifdef CONFIG_PROBE_EVENTS_DUMP_FETCHARG
+void trace_probe_dump_args(struct seq_file *m, struct trace_probe *tp);
+#else
+static inline void trace_probe_dump_args(struct seq_file *m, struct trace_probe *tp)
+{
+}
+#endif
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 int traceprobe_get_entry_data_size(struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c274346853d1..b2e264a4b96c 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -765,6 +765,9 @@ static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
 
 	seq_putc(m, '\n');
+
+	trace_probe_dump_args(m, &tu->tp);
+
 	return 0;
 }
 

