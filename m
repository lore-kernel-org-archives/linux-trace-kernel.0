Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A343EA66;
	Tue,  2 Jun 2026 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359907; cv=none; b=Eh/OKngMn5gg6rEntRw0sY4e1/BP/ALCiTPrimfMwCDmbcJEo0A50c8QZ739k2K/netPVDUqD+4mn1SQyWFK8rNW52SomfDXOngc1P4p0m00EjMPgEjO8BH+T6KX0wh5ejhK/LxniD42jIJqs8WIC8QLga4qNMEnsbkh9HPckQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359907; c=relaxed/simple;
	bh=c+pRoOrhgcmHEGUQTg/su5WlxxB97Jvv9wf44QVA/pM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JHdQXgIWUMdODYjElNfPt3O6gCAXFRm0TDUq9X3o/pZ3b/NlSNHrUx9tBPU2VSKUo771bdZf6YYaEb3i4A6b+tHUsdy1tRQpZ4P/dB0OwlyAbkkwnUctyi2v8t4Jj7e+MaX17IGngmYEA7JovIQHdgnIaMxOQaC1Kb4G7wCu4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C583A162002;
	Tue,  2 Jun 2026 00:25:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id C90DC20010;
	Tue,  2 Jun 2026 00:24:59 +0000 (UTC)
Date: Mon, 1 Jun 2026 20:25:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard 
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
  <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian 
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: [RESEND][PATCH v8] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260601202546.564e867b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C90DC20010
X-Stat-Signature: gi6qskiyajx965ykr7kjthi9q9cowd5i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/9pJGTB/gF/yZ0zMEavLTkDV2LBxlxc0=
X-HE-Tag: 1780359899-524495
X-HE-Meta: U2FsdGVkX18D++fGNaf0l8LYuepG/G/5h6H2RBX0mLrf5XO673nu3RTeQDz+tghbpmCD5y9dEoTxQPKH6s/+tYCfflP5ZOvRxkMqyM7k3jl4twYZbh9ivhgpK27jBM66SGzdbz0IZkf9nQmCYiWQGoqX829r/Nh5PqKy3oPyyjS/4+eloWwjUBEi+KlEBfcwz+hnxvF01M188XC0JL1MPBQ5eOuH49SG2tQKbmyOaYX8SZpdPXt8bYt/m2dNunWf4BQx1DwjgtFICYXrjtcojn/fqWFbs0/WrfPRHcicO3HLqZaN32suc7gT91rT+RtVFagxkHbAEnQlBTGXMDVQ0Cp7I7Jbsludi02dVO20o6Tg+8xRjHlUU+OSQ5FmuAV0nC8POO10vM+QBBtFtHYTTVB5andmt/Br5SXqlm/ZH/hmmKaCMYHVkYrFfPjKrZDjHy65qNR2W0ZvAAVoq88mRw==

From: Steven Rostedt <rostedt@goodmis.org>

Add syntax to the parsing of eprobes to be able to typecast a trace event
field that is a pointer to a structure.

Currently, a dereference must be a number, where the user has to figure
out manually the offset of a member of a structure that they want to
dereference.

But for event probes that records a field that happens to be a pointer to
a structure, it cannot dereference these values with BTF naming, but
must use numerical offsets.

For example, to find out what device a sk_buff is pointing to in the
net_dev_xmit trace event, one must first use gdb to find the offsets of the
members of the structures:

 (gdb) p &((struct sk_buff *)0)->dev
 $1 = (struct net_device **) 0x10
 (gdb) p &((struct net_device *)0)->name
 $2 = (char (*)[16]) 0x118

And then use the raw numbers to dereference:

  # echo 'e:xmit net.net_dev_xmit +0x118(+0x10($skbaddr)):string' >> dynamic_events

If BTF is in the kernel, then instead, the skbaddr can be typecast to
sk_buff and use the normal dereference logic.

  # echo 'e:xmit net.net_dev_xmit (sk_buff)skbaddr->dev->name:string' >> dynamic_events
  # echo 1 > events/eprobes/xmit/enable
  # cat trace
[..]
    sshd-session-1022    [000] b..2.   860.249343: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.250061: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.250142: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.263553: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.283820: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.302716: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.322905: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.342828: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.362268: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.382335: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.400856: xmit: (net.net_dev_xmit) arg1="enp7s0"
    sshd-session-1022    [000] b..2.   860.419893: xmit: (net.net_dev_xmit) arg1="enp7s0"

The syntax is simply: (STRUCT)(FIELD)->MEMBER[->MEMBER..]

Also add comments around the #else and #endif of #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
to know what they are for.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

[ Resend with base-id below, maybe Sashiko will apply it to the correct tree! ]

base-id: 585abc02be3d3ab82fbcc4dbcbbf0ceb61a02129

Changes since v7: https://patch.msgid.link/20260529110442.0967a64c@fedora

- Add error message in parse_btf_args() for failed parsing of TEVENT.
  (Sashiko)

- Remove TPARG_FL_TYPECAST and just use ctx->struct_btf instead.
  The flag was redundant and added unnecessary complexity.

- Restructure to keep the lifetime of the TYPECAST to the end of
  traceprobe_parse_probe_arg_body(). This allows the last_type to stay
  around in case there's not a type parameter and then btf can still be
  used.
  (Sashiko and Masami Hiramatsu)

 Documentation/trace/eprobetrace.rst |   4 +
 kernel/trace/trace_probe.c          | 173 +++++++++++++++++++++++-----
 kernel/trace/trace_probe.h          |   5 +-
 3 files changed, 154 insertions(+), 28 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index 89b5157cfab8..fe3602540569 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -46,6 +46,10 @@ Synopsis of eprobe_events
 		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
                   "string", "ustring", "symbol", "symstr" and "bitfield" are
                   supported.
+  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+                  a pointer to STRUCT and then derference the pointer defined by
+                  ->MEMBER. Note that when this is used, the FIELD name does not
+                  need to be prefixed with a '$'.
 
 Types
 -----
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 695310571b08..fd1caa1f9723 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -332,6 +332,23 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
 	return -ENOENT;
 }
 
+static int parse_trace_event(char *arg, struct fetch_insn *code,
+			     struct traceprobe_parse_context *ctx)
+{
+	int ret;
+
+	if (code->data)
+		return -EFAULT;
+	ret = parse_trace_event_arg(arg, code, ctx);
+	if (!ret)
+		return 0;
+	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+		code->op = FETCH_OP_COMM;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 
 static u32 btf_type_int(const struct btf_type *t)
@@ -376,11 +393,16 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 		&& BTF_INT_BITS(intdata) == 8;
 }
 
+static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
+{
+	return ctx->struct_btf ? : ctx->btf;
+}
+
 static int check_prepare_btf_string_fetch(char *typename,
 				struct fetch_insn **pcode,
 				struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = ctx->btf;
+	struct btf *btf = ctx_btf(ctx);
 
 	if (!btf || !ctx->last_type)
 		return 0;
@@ -506,6 +528,15 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
 	return 0;
 }
 
+static void clear_struct_btf(struct traceprobe_parse_context *ctx)
+{
+	if (ctx->struct_btf) {
+		btf_put(ctx->struct_btf);
+		ctx->struct_btf = NULL;
+		ctx->last_struct = NULL;
+	}
+}
+
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
 	if (ctx->btf) {
@@ -554,22 +585,29 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
 	u32 bitoffs, anon_offs;
+	bool is_struct = ctx->struct_btf != NULL;
+	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
 	s32 tid;
 
 	do {
-		/* Outer loop for solving arrow operator ('->') */
-		if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
-			trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
-			return -EINVAL;
-		}
-		/* Convert a struct pointer type to a struct type */
-		type = btf_type_skip_modifiers(ctx->btf, type->type, &tid);
-		if (!type) {
-			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-			return -EINVAL;
+		if (!is_struct) {
+			/* Outer loop for solving arrow operator ('->') */
+			if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
+				trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
+				return -EINVAL;
+			}
+
+			/* Convert a struct pointer type to a struct type */
+			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			if (!type) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return -EINVAL;
+			}
 		}
+		/* Only the first type can skip being a pointer */
+		is_struct = false;
 
 		bitoffs = 0;
 		do {
@@ -580,7 +618,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				return is_ptr;
 
 			anon_offs = 0;
-			field = btf_find_struct_member(ctx->btf, type, fieldname,
+			field = btf_find_struct_member(btf, type, fieldname,
 						       &anon_offs);
 			if (IS_ERR(field)) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
@@ -602,7 +640,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(ctx->btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, &tid);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -640,7 +678,7 @@ static int parse_btf_arg(char *varname,
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (WARN_ON_ONCE(!ctx->funcname))
+	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);
@@ -653,6 +691,19 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_TEVENT) {
+		ret = parse_trace_event(varname, code, ctx);
+		if (ret < 0) {
+			trace_probe_log_err(ctx->offset, BAD_ATTACH_ARG);
+			return ret;
+		}
+		/* TEVENT is only here via a typecast */
+		if (WARN_ON_ONCE(ctx->struct_btf == NULL))
+			return -EINVAL;
+		type = ctx->last_struct;
+		goto found_type;
+	}
+
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void */
@@ -709,6 +760,7 @@ static int parse_btf_arg(char *varname,
 
 found:
 	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -727,7 +779,7 @@ static int parse_btf_arg(char *varname,
 static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = ctx->btf;
+	struct btf *btf = ctx_btf(ctx);
 	const char *typestr = NULL;
 
 	if (btf && ctx->last_type)
@@ -758,7 +810,67 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return 0;
 }
 
-#else
+static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = NULL;
+	int id;
+
+	/* A struct_btf should only be used by a single argument */
+	if (WARN_ON_ONCE(ctx->struct_btf)) {
+		btf_put(ctx->struct_btf);
+		ctx->struct_btf = NULL;
+	}
+
+	id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		return id;
+	ctx->struct_btf = btf;
+	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
+	return 0;
+}
+
+static int handle_typecast(char *arg, struct fetch_insn **pcode,
+			   struct fetch_insn *end,
+			   struct traceprobe_parse_context *ctx)
+{
+	char *tmp;
+	int ret;
+
+	/* Currently this only works for eprobes */
+	if (!(ctx->flags & TPARG_FL_TEVENT)) {
+		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
+		return -EINVAL;
+	}
+
+	tmp = strchr(arg, ')');
+	if (!tmp) {
+		trace_probe_log_err(ctx->offset + strlen(arg),
+				    DEREF_OPEN_BRACE);
+		return -EINVAL;
+	}
+	*tmp = '\0';
+	ret = query_btf_struct(arg + 1, ctx);
+	*tmp = ')';
+
+	if (ret < 0) {
+		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
+		return -EINVAL;
+	}
+
+	tmp++;
+
+	ctx->offset += tmp - arg;
+	ret = parse_btf_arg(tmp, pcode, end, ctx);
+	return ret;
+}
+
+#else /* !CONFIG_PROBE_EVENTS_BTF_ARGS */
+
+static void clear_struct_btf(struct traceprobe_parse_context *ctx)
+{
+	ctx->struct_btf = NULL;
+}
+
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
 	ctx->btf = NULL;
@@ -794,7 +906,15 @@ static int check_prepare_btf_string_fetch(char *typename,
 	return 0;
 }
 
-#endif
+static int handle_typecast(char *arg, struct fetch_insn **pcode,
+			   struct fetch_insn *end,
+			   struct traceprobe_parse_context *ctx)
+{
+	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_PROBE_EVENTS_BTF_ARGS */
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 
@@ -948,16 +1068,9 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 	int len;
 
 	if (ctx->flags & TPARG_FL_TEVENT) {
-		if (code->data)
-			return -EFAULT;
-		ret = parse_trace_event_arg(arg, code, ctx);
-		if (!ret)
-			return 0;
-		if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
-			code->op = FETCH_OP_COMM;
-			return 0;
-		}
-		goto inval;
+		if (parse_trace_event(arg, code, ctx) < 0)
+			goto inval;
+		return 0;
 	}
 
 	if (str_has_prefix(arg, "retval")) {
@@ -1224,6 +1337,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				code->op = FETCH_OP_IMM;
 		}
 		break;
+	case '(':
+		ret = handle_typecast(arg, pcode, end, ctx);
+		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags) &&
@@ -1556,6 +1672,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	}
 	kfree(tmp);
 
+	/* struct_btf should not be passed to other arguments */
+	clear_struct_btf(ctx);
+
 	return ret;
 }
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 1076f1df347b..15758cc11fc6 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -422,7 +422,9 @@ struct traceprobe_parse_context {
 	const struct btf_param *params;	/* Parameter of the function */
 	s32 nr_params;			/* The number of the parameters */
 	struct btf *btf;		/* The BTF to be used */
+	struct btf *struct_btf;		/* The BTF to be used for structs */
 	const struct btf_type *last_type;	/* Saved type */
+	const struct btf_type *last_struct;	/* Saved structure */
 	u32 last_bitoffs;		/* Saved bitoffs */
 	u32 last_bitsize;		/* Saved bitsize */
 	struct trace_probe *tp;
@@ -563,7 +565,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
 	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
-	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
+	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.53.0

