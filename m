Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2F363C69;
	Fri, 29 May 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067091; cv=none; b=Uud32nyx4XfdIq4yTWyxPcMRpxm/eZBrWQUATNhPxIExXiJTrcRrh/ySLEjEn62WoIdqwesxqX01M6zuR9NpOHjSn0cT6hkqkGv2IrFpTez2hX2xZrTxvnleOO4pUm6WG/svIjDdYnyzivqehDmKTq4yahWzkH+QBfrscl0vlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067091; c=relaxed/simple;
	bh=fIxJ7qB5laAR/ZahnDUUnrosA+teNzLcrrrk2exluZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PqtJo8oOqbTAsoF+QFT6zJfsZ4vnEAkpwn0GVNtgcp35EdMflIWWV5OiDWq2yuR2waILNI8v96Qjdm9WNovyJ6UGUNlwhDASN1zFHUBcxAt/8dhnVFkJLIEVhIzgBnBQ09Dt/Tu0s6oqZyQTkmsxW2Y33aiFXDmbfUEP3IzkX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 3B361160DC7;
	Fri, 29 May 2026 15:04:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id D6A331C;
	Fri, 29 May 2026 15:04:43 +0000 (UTC)
Date: Fri, 29 May 2026 11:04:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: PATCH v7] tracing/eprobes: Allow use of BTF names to dereference
 pointers
Message-ID: <20260529110442.0967a64c@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bb3195wqjsdzhp5btigirbg78rgstmfx
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D6A331C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+i7yY1DZSK1H6xoPgehN8SsZTqnRxC6Rc=
X-HE-Tag: 1780067083-551989
X-HE-Meta: U2FsdGVkX19rEZ0FotIzzLHKp70+YJRYetk6tfya/LBHf2jhhz1L6IpDwUTrW4LoRiJKwDonFWbVBdqFKJgLvGobgQnazIZkodlKkLmN+lDnkG6tovHd4j6tkpXhzSrHw0HKFf59ggXjQ60S7/VUq46q20ANnfHtCm2Pg+ReQYN4m7FEjYz4/h5C+Em1Phbz7GQQeD2JApRxImxPrvUyHj7SjdZmfF2wDTEzifEOj9IIJ5bIYJIiP7ZJ4sVx75Taa+Yl4pwOa4s2R4Qzb9W03JwwWpbBsLTWncFk80z4RGnAqtj0a1nAYJR0ImDi1nzuLZV0ny7FpEzhbu8035FcBSnl/QPLS0PCPIR5Rb10Jnt5vzWxkm4r/RMD5o9i9dZzsGLt7JikMgMFBpALOcIh3O6Crm9D8T64sf6mbBLGNLeOtAiFLgKcrD9q05EzFqdsZclkZTt6QGlvyCrsi/0BmQ==

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
Changes since v6: https://patch.msgid.link/20260521225033.56458336@fedora

- Set ctx->struct_btf to NULL when finished with it in handle_typecast()
  (Sashiko)

- Remove extra unneeded "ret" declaration (Masami Hiramatsu)

- Add a WARN_ON_ONCE() in parse_btf_arg for TEVENT being called without
  TYPECAST being set. (Masami Hiramatsu)

 Documentation/trace/eprobetrace.rst |   4 +
 kernel/trace/trace_probe.c          | 168 +++++++++++++++++++++++-----
 kernel/trace/trace_probe.h          |   7 +-
 3 files changed, 149 insertions(+), 30 deletions(-)

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
index e0d3a0da26af..9246e9c3d066 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -332,6 +332,25 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
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
+	/* backward compatibility */
+	ctx->offset = 0;
+	return -EINVAL;
+}
+
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
 
 static u32 btf_type_int(const struct btf_type *t)
@@ -376,11 +395,17 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 		&& BTF_INT_BITS(intdata) == 8;
 }
 
+static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
+{
+	return ctx->flags & TPARG_FL_TYPECAST ?
+		ctx->struct_btf : ctx->btf;
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
@@ -554,22 +579,29 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
 	u32 bitoffs, anon_offs;
+	bool is_struct = ctx->flags & TPARG_FL_TYPECAST;
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
@@ -580,7 +612,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				return is_ptr;
 
 			anon_offs = 0;
-			field = btf_find_struct_member(ctx->btf, type, fieldname,
+			field = btf_find_struct_member(btf, type, fieldname,
 						       &anon_offs);
 			if (IS_ERR(field)) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
@@ -602,7 +634,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(ctx->btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, &tid);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -627,6 +659,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	return 0;
 }
 
+
 static int __store_entry_arg(struct trace_probe *tp, int argnum);
 
 static int parse_btf_arg(char *varname,
@@ -640,7 +673,7 @@ static int parse_btf_arg(char *varname,
 	int i, is_ptr, ret;
 	u32 tid;
 
-	if (WARN_ON_ONCE(!ctx->funcname))
+	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
 		return -EINVAL;
 
 	is_ptr = split_next_field(varname, &field, ctx);
@@ -653,6 +686,16 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_TEVENT) {
+		ret = parse_trace_event(varname, code, ctx);
+		if (ret < 0)
+			return ret;
+		if (WARN_ON_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
+			return -EINVAL;
+		type = ctx->last_struct;
+		goto found_type;
+	}
+
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
 		code->op = FETCH_OP_RETVAL;
 		/* Check whether the function return type is not void */
@@ -709,6 +752,7 @@ static int parse_btf_arg(char *varname,
 
 found:
 	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -727,7 +771,7 @@ static int parse_btf_arg(char *varname,
 static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
-	struct btf *btf = ctx->btf;
+	struct btf *btf = ctx_btf(ctx);
 	const char *typestr = NULL;
 
 	if (btf && ctx->last_type)
@@ -758,7 +802,71 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return 0;
 }
 
-#else
+static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
+{
+	int id;
+
+	if (!ctx->struct_btf) {
+		struct btf *btf;
+
+		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+		if (id < 0)
+			return id;
+		ctx->struct_btf = btf;
+	} else {
+		id = btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);
+		if (id < 0)
+			return id;
+	}
+
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
+		ret = -EINVAL;
+		goto out_put;
+	}
+
+	ctx->flags |= TPARG_FL_TYPECAST;
+	tmp++;
+
+	ctx->offset += tmp - arg;
+	ret = parse_btf_arg(tmp, pcode, end, ctx);
+	ctx->flags &= ~TPARG_FL_TYPECAST;
+	ctx->last_struct = NULL;
+out_put:
+	btf_put(ctx->struct_btf);
+	ctx->struct_btf = NULL;
+	return ret;
+}
+
+#else /* !CONFIG_PROBE_EVENTS_BTF_ARGS */
+
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
 	ctx->btf = NULL;
@@ -794,7 +902,15 @@ static int check_prepare_btf_string_fetch(char *typename,
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
 
@@ -953,18 +1069,9 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
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
-		/* backward compatibility */
-		ctx->offset = 0;
-		goto inval;
+		if (parse_trace_event(arg, code, ctx) < 0)
+			goto inval;
+		return 0;
 	}
 
 	if (str_has_prefix(arg, "retval")) {
@@ -1231,6 +1338,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				code->op = FETCH_OP_IMM;
 		}
 		break;
+	case '(':
+		ret = handle_typecast(arg, pcode, end, ctx);
+		break;
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags) &&
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..952e3d7582b8 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -394,6 +394,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
  * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
  * TPARG_FL_FPROBE and TPARG_FL_TPOINT are optional but it should be with
  * TPARG_FL_KERNEL.
+ * TPARG_FL_TYPECAST is set if an argument was typecast to a structure.
  */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
@@ -402,6 +403,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_TYPECAST BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
@@ -422,7 +424,9 @@ struct traceprobe_parse_context {
 	const struct btf_param *params;	/* Parameter of the function */
 	s32 nr_params;			/* The number of the parameters */
 	struct btf *btf;		/* The BTF to be used */
+	struct btf *struct_btf;		/* The BTF to be used for structs */
 	const struct btf_type *last_type;	/* Saved type */
+	const struct btf_type *last_struct;	/* Saved structure */
 	u32 last_bitoffs;		/* Saved bitoffs */
 	u32 last_bitsize;		/* Saved bitsize */
 	struct trace_probe *tp;
@@ -563,7 +567,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
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

