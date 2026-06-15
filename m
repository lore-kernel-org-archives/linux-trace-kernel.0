Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F62253B0;
	Mon, 15 Jun 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486080; cv=none; b=AE3V7Ku8fePm0Eq/sOWyilh9fem7J+Sdl7aR8F3lWotSXamMCELsC78LIRBHj0D4tMI7vHW0s6Y9rrLXM4FPj45l5g6Jw5olmy6Zrl2PpxukoMDKd/wtOQc3gXBsA5rrmU51tBc2QtR5D5w4milmOeqnB5g4ZTGGQj6gMYgaWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486080; c=relaxed/simple;
	bh=pcjOjNrVSJewCyXKfNiQtjCHWDQ1bP8wdFSr+hhw48U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVkd3hututNA1L3L3pE3bgbL3NYARgFV6wS93ZriLtNWnxsFDQtu5TibJ6r/N0dZ1smPxwvgnpnrQp0FToJjLNmahrpLj2/Umsmg2jKzCXbZk8jSrg7B40f0+HV3a50Q3q0JtFgghqdTXbkTj6wmpnG/AXGqxg7SPE84LD1TtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1UGHi0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1UGHi0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72321F000E9;
	Mon, 15 Jun 2026 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486078;
	bh=tAk2D4nKPILQ+RIg/Xo/s1vb1OpVX5YNt8NsLfRwwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1UGHi0LWxFa+Cqm3HtzbqHnDGGVUqo7Uwe00cXQQENJzhjtLi9V6hVfY1+faSA1u
	 uJGeEcXN8TIRARDkF6HQM8WiZMBmVA2EdedhLV1OlKlIZ+myY1U6ydJSjVkl+gAJcz
	 5PSFLl8jYrrrr7RXTyjrmtz7yRROV7t17FMPl+042kWSYNv7bLPW7YLtR8zMAOQogX
	 eR02WUcfQ37o8SNbIQBMyfs0rThtK3+JJACqgOtRDERKvurV9U6SY2NfIINLzPUl4W
	 VkmlmqY62Upeamh2fxsTyX2mDGseovyaRh9rM7KFRFUt9mYmVh3JVskf8Jhnj66nvB
	 NWF/i/RQiY38w==
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
Subject: [PATCH v4 4/7] tracing/probes: Support field specifier option for typecast
Date: Mon, 15 Jun 2026 10:14:34 +0900
Message-ID: <178148607479.185520.6433230045626074826.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178148603548.185520.3389196102475741865.stgit@devnote2>
References: <178148603548.185520.3389196102475741865.stgit@devnote2>
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

Add a field specifier option for the typecast. This works like
container_of() macro.

    (STRUCT[,FIELD[.FIELD2...]])VAR

This is equivalent to :

    container_of(VAR, struct STRUCT, FIELD[.FIELD2...])

For example:

 echo "f tick_nohz_handler next_tick=(tick_sched,sched_timer)timer->next_tick" >> dynamic_events

This will trace tick_nohz_handler() with its tick_sched::next_tick which
is converted from @timer by contianer_of(tick, struct tick_sched, sched_timer).
So, if you enabkle both fprobes:tick_nohz_handler__entry and
timer:hrtimer_expire_entry events, we will see something like:


          <idle>-0       [002] d.h1.  3778.087272: hrtimer_expire_entry: hrtimer=00000000d63db328 f
unction=tick_nohz_handler now=3777450051040
          <idle>-0       [002] d.h1.  3778.087281: tick_nohz_handler__entry: (tick_nohz_handler+0x4
/0x140) next_tick=3777450000000


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix error caret position.
 Changes in v2:
  - Use byteoffset for typecast field offset instead of bitoffset. This fixes negative modulo calculation.
  - Check whether a field is specified after typecast.
  - Reject if typecast field option  has arrow operator.
---
 Documentation/trace/eprobetrace.rst |    5 +
 Documentation/trace/fprobetrace.rst |    8 +-
 Documentation/trace/kprobetrace.rst |    8 +-
 kernel/trace/trace.c                |    4 -
 kernel/trace/trace_probe.c          |  179 ++++++++++++++++++++++++-----------
 kernel/trace/trace_probe.h          |    5 +
 6 files changed, 142 insertions(+), 67 deletions(-)

diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
index cd0b4aa7f896..680e0af43d5d 100644
--- a/Documentation/trace/eprobetrace.rst
+++ b/Documentation/trace/eprobetrace.rst
@@ -49,7 +49,10 @@ Synopsis of eprobe_events
   (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
                   a pointer to STRUCT and then derference the pointer defined by
                   ->MEMBER. Note that when this is used, the FIELD name does not
-                  need to be prefixed with a '$'.
+                  need to be prefixed with a '$'. ASGN can be specified optionally.
+		  If ASGN is specified, FIELD will be cast to the same offset
+		  position as the ASGN member, rather than to the beginning of
+		  the STRUCT.
   (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
 		  also be used with another FETCHARG instead of FIELD.
 
diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 6b8bb27bb62d..290a9e6f7491 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -57,10 +57,12 @@ Synopsis of fprobe-events
                   (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
                   (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
-  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+  (STRUCT[,ASGN])FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
                   a pointer to STRUCT and then derference the pointer defined by
-                  ->MEMBER.
-  (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
+                  ->MEMBER. ASGN can be specified optionally. If ASGN is specified,
+		  FIELD will be cast to the same offset position as the ASGN member,
+		  rather than to the beginning of the STRUCT.
+  (STRUCT[,ASGN])(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
                  also be used with another FETCHARG instead of FIELD.
 
   (\*1) This is available only when BTF is enabled.
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c4382765d5b2..a62707e6a9f2 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -61,11 +61,13 @@ Synopsis of kprobe_events
 		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
                   "string", "ustring", "symbol", "symstr" and bitfield are
                   supported.
-  (STRUCT)FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
+  (STRUCT[,ASGN])FIELD->MEMBER[->MEMBER] : If BTF is supported, typecast FIELD to
                   a pointer to STRUCT and then derference the pointer defined by
                   ->MEMBER. Note that this is available only when the probe is
-		   on function entry.
-  (STRUCT)(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
+		   on function entry. ASGN can be specified optionally. If ASGN
+		   is specified, FIELD will be cast to the same offset position
+		   as the ASGN member, rather than to the beginning of the STRUCT.
+  (STRUCT[,ASGN])(FETCHARG)->MEMBER[->MEMBER] : typecast can nest, so the above can
                  also be used with another FETCHARG instead of FIELD.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4f70318918c2..0e36af853199 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4325,8 +4325,8 @@ static const char readme_msg[] =
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
-	"\t           [(structname)]<argname>[->field[->field|.field...]],\n"
-	"\t           [(structname)](fetcharg)->field[->field|.field...],\n"
+	"\t           [(structname[,field])]<argname>[->field[->field|.field...]],\n"
+	"\t           [(structname[,field])](fetcharg)->field[->field|.field...],\n"
 #endif
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index adcb5a19e72d..3ead93de2d93 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -574,6 +574,65 @@ static int split_next_field(char *varname, char **next_field,
 	return ret;
 }
 
+/* Inner loop for solving dot operator ('.'). Return bit-offset of the given field */
+static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **ptype,
+				  struct traceprobe_parse_context *ctx)
+{
+	const struct btf_type *type = *ptype;
+	const struct btf_member *field;
+	struct btf *btf = ctx_btf(ctx);
+	char *fieldname = *pfieldname;
+	int bitoffs = 0;
+	u32 anon_offs;
+	char *next;
+	int is_ptr;
+	s32 tid;
+
+	do {
+		next = NULL;
+		is_ptr = split_next_field(fieldname, &next, ctx);
+		if (is_ptr < 0)
+			return is_ptr;
+
+		anon_offs = 0;
+		field = btf_find_struct_member(btf, type, fieldname,
+						&anon_offs);
+		if (IS_ERR(field)) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return PTR_ERR(field);
+		}
+		if (!field) {
+			trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
+			return -ENOENT;
+		}
+		/* Add anonymous structure/union offset */
+		bitoffs += anon_offs;
+
+		/* Accumulate the bit-offsets of the dot-connected fields */
+		if (btf_type_kflag(type)) {
+			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
+			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
+		} else {
+			bitoffs += field->offset;
+			ctx->last_bitsize = 0;
+		}
+
+		type = btf_type_skip_modifiers(btf, field->type, &tid);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
+
+		if (next)
+			ctx->offset += next - fieldname;
+		fieldname = next;
+	} while (!is_ptr && fieldname);
+
+	*pfieldname = fieldname;
+	*ptype = type;
+
+	return bitoffs;
+}
 /*
  * Parse the field of data structure. The @type must be a pointer type
  * pointing the target data structure type.
@@ -583,16 +642,14 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			   struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
-	const struct btf_member *field;
-	u32 bitoffs, anon_offs;
-	bool is_struct = ctx->struct_btf != NULL;
 	struct btf *btf = ctx_btf(ctx);
-	char *next;
-	int is_ptr;
+	bool is_first_field = true;
+	int bitoffs;
 	s32 tid;
 
 	do {
-		if (!is_struct) {
+		/* For the first field of typecast, @type will be the target structure type. */
+		if (!(is_first_field && ctx->struct_btf)) {
 			/* Outer loop for solving arrow operator ('->') */
 			if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR) {
 				trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
@@ -606,60 +663,25 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				return -EINVAL;
 			}
 		}
-		/* Only the first type can skip being a pointer */
-		is_struct = false;
-
-		bitoffs = 0;
-		do {
-			/* Inner loop for solving dot operator ('.') */
-			next = NULL;
-			is_ptr = split_next_field(fieldname, &next, ctx);
-			if (is_ptr < 0)
-				return is_ptr;
-
-			anon_offs = 0;
-			field = btf_find_struct_member(btf, type, fieldname,
-						       &anon_offs);
-			if (IS_ERR(field)) {
-				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-				return PTR_ERR(field);
-			}
-			if (!field) {
-				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
-				return -ENOENT;
-			}
-			/* Add anonymous structure/union offset */
-			bitoffs += anon_offs;
-
-			/* Accumulate the bit-offsets of the dot-connected fields */
-			if (btf_type_kflag(type)) {
-				bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
-				ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
-			} else {
-				bitoffs += field->offset;
-				ctx->last_bitsize = 0;
-			}
-
-			type = btf_type_skip_modifiers(btf, field->type, &tid);
-			if (!type) {
-				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-				return -EINVAL;
-			}
-
-			ctx->offset += next - fieldname;
-			fieldname = next;
-		} while (!is_ptr && fieldname);
 
+		bitoffs = get_bitoffset_of_field(&fieldname, &type, ctx);
+		if (bitoffs < 0)
+			return bitoffs;
 		if (++code == end) {
 			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
 			return -EINVAL;
 		}
 		code->op = FETCH_OP_DEREF;	/* TODO: user deref support */
 		code->offset = bitoffs / 8;
+		if (is_first_field && ctx->struct_btf) {
+			/* The first field can be typecasted with field option. */
+			code->offset -= ctx->prefix_byteoffs;
+		}
 		*pcode = code;
 
 		ctx->last_bitoffs = bitoffs % 8;
 		ctx->last_type = type;
+		is_first_field = false;
 	} while (fieldname);
 
 	return 0;
@@ -690,6 +712,11 @@ static int parse_btf_arg(char *varname,
 				    NOSUP_DAT_ARG);
 		return -EOPNOTSUPP;
 	}
+	if (!field && ctx->struct_btf) {
+		/* Typecast without field option is not supported */
+		trace_probe_log_err(ctx->offset + strlen(varname), TYPECAST_REQ_FIELD);
+		return -EOPNOTSUPP;
+	}
 
 	if (ctx->flags & TPARG_FL_TEVENT) {
 		ret = parse_trace_event(varname, code, ctx);
@@ -700,8 +727,7 @@ static int parse_btf_arg(char *varname,
 		/* TEVENT is only here via a typecast */
 		if (WARN_ON_ONCE(ctx->struct_btf == NULL))
 			return -EINVAL;
-		type = ctx->last_struct;
-		goto found_type;
+		goto found;
 	}
 
 	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
@@ -763,7 +789,6 @@ static int parse_btf_arg(char *varname,
 		type = ctx->last_struct;
 	else
 		type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
-found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 		return -EINVAL;
@@ -832,6 +857,46 @@ static int query_btf_struct(const char *sname, struct traceprobe_parse_context *
 	return 0;
 }
 
+static int parse_btf_casttype(char *casttype, struct traceprobe_parse_context *ctx)
+{
+	char *field;
+	int ret;
+
+	/* Field option - evaluated later. */
+	field = strchr(casttype, ',');
+	if (field)
+		*field++ = '\0';
+
+	ret = query_btf_struct(casttype, ctx);
+	if (ret < 0) {
+		trace_probe_log_err(ctx->offset, NO_PTR_STRCT);
+		return -EINVAL;
+	}
+
+	if (field) {
+		struct btf_type *type = (struct btf_type *)ctx->last_struct;
+
+		ctx->offset += field - casttype;
+		ret = get_bitoffset_of_field(&field, &ctx->last_struct, ctx);
+		if (ret < 0)
+			return ret;
+		if (ret % 8) {
+			trace_probe_log_err(ctx->offset, TYPECAST_NOT_ALIGNED);
+			return -EINVAL;
+		}
+		if (field != NULL) {
+			/* this means @field skips an arrow operator ("->"). */
+			trace_probe_log_err(ctx->offset - 2, TYPECAST_BAD_ARROW);
+			return -EINVAL;
+		}
+		ctx->prefix_byteoffs = ret / 8;
+		/* Restore the original struct type (overwritten by get_bitoffset_of_field) */
+		ctx->last_struct = type;
+	}
+
+	return ret;
+}
+
 /* Find the matching closing parenthesis for a given opening parenthesis. */
 static char *find_matched_close_paren(char *s)
 {
@@ -915,11 +980,10 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 		nested = true;
 	}
 
-	ret = query_btf_struct(arg + 1, ctx);
-	if (ret < 0) {
-		trace_probe_log_err(orig_offset + 1, NO_PTR_STRCT);
-		return -EINVAL;
-	}
+	ctx->offset = orig_offset + 1;	/* for the '(' */
+	ret = parse_btf_casttype(arg + 1, ctx);
+	if (ret < 0)
+		return ret;
 
 	ctx->offset = orig_offset + tmp - arg;
 	/* If it is nested, tmp points to the field name. */
@@ -927,6 +991,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 		ret = parse_btf_field(tmp, ctx->last_struct, pcode, end, ctx);
 	else
 		ret = parse_btf_arg(tmp, pcode, end, ctx);
+	ctx->prefix_byteoffs = 0;
 	return ret;
 }
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 982d32a5df8b..44f113faae61 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -436,6 +436,7 @@ struct traceprobe_parse_context {
 	unsigned int flags;
 	int offset;
 	int nested_level;
+	int prefix_byteoffs;	/* The byte offset of the prefix field of typecast */
 };
 
 #define TRACEPROBE_MAX_NESTED_LEVEL 3
@@ -576,7 +577,9 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),  \
 	C(TYPECAST_NOT_EVENT,	"Typecasts are only for eprobe fields"), \
 	C(TYPECAST_REQ_FIELD,	"Typecast requires a field access"),	\
-	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"),
+	C(TOO_MANY_NESTED,	"Too many nested typecasts/dereferences"), \
+	C(TYPECAST_NOT_ALIGNED,	"Typecast field option is not byte-aligned"), \
+	C(TYPECAST_BAD_ARROW,	"Typecast field option does not support -> operator"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

