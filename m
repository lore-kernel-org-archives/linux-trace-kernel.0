Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5D2DECBA;
	Mon,  1 Jun 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330900; cv=none; b=mhh78n+JnsPYX6F2MhiMi9n9/P4GsdaRns6gyemVmg7eLYCyxCwkuSilrDw0tC7lnvh5UtedCUsycjH+SlqIyl659MzEie+AfbyvROMmwO2wIMtHWdI4D20ohgzNkzpZ6xQmhas68mB9urKEXg9MVS95n/nfODHsoFF4Eles0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330900; c=relaxed/simple;
	bh=fXRz/kexCw7tl8j4OrPOM5N1HB9ieGSZmG1MhkBIDhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig8utwvxcvy+T8J+2zszXWVc20yb6K9iM+JVcV6yuoc6Ufk6RGaKcRMiptmPpz9TaJQI61oOIV/y/hhxEKkziPTpqoaikgYL016dmBhJr1wbIFzVHekRx1bxJ6iUdBSHWZ0Yd1CppKT8vpVxsqIgzfuchEuvbdyG1gUCSDtwgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 155F51A06B3;
	Mon,  1 Jun 2026 16:21:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id DD9041B;
	Mon,  1 Jun 2026 16:21:27 +0000 (UTC)
Date: Mon, 1 Jun 2026 12:21:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: PATCH v7] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260601122126.5ebbd7e7@fedora>
In-Reply-To: <20260531101458.c8ee22f6222a3fc224cc5328@kernel.org>
References: <20260529110442.0967a64c@fedora>
	<20260530231427.b079fefffc724a40082cd64b@kernel.org>
	<20260530110754.14870622@gandalf.local.home>
	<20260531101458.c8ee22f6222a3fc224cc5328@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9frj7xadi88jtum9gxfmnkzsso61z1hc
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DD9041B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/abiozyaR625A8L1Nkoj3BB1Q8X/gj5XU=
X-HE-Tag: 1780330887-144893
X-HE-Meta: U2FsdGVkX1/236rdKCmZwDqmDZ5yr5pKsCu4vyBw7M0LvAmAuW61bwjzRi8SLTb0vVr+l07gzDVIBl5i6klC+O9cdZ/sJ1cBq77yE7G8LRrMjgYX6jgaGbPO137qAiBOFYv5EDy4bT8SvY3Pri44M0Bw/f2zF2mDwIhADsBojnFaxizeGkVpKbUH42dZ7bjSr21Xq8d1psc7uuneQPbK4YTsFOKQdNrBrZJ+ZD4WRhJpVArkD+ZcsxGdlGRkwpY9stm9XVpEW0jc7Nn8MMNlC9ZVaAbrFR+CciikUQNQq7zIT/83ji6vp3t4w9BEk56PBu80MxXWItBdtXzoEcXt6+BiZ//sr71W

On Sun, 31 May 2026 10:14:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > Does this prematurely release the BTF struct reference?
> > > If TPARG_FL_TYPECAST is unset here and ctx->struct_btf is put, won't
> > > later steps in traceprobe_parse_probe_arg_body() (like
> > > find_fetch_type_from_btf_type()) fail to properly infer struct field sizes?
> > > When ctx_btf(ctx) is called later without TPARG_FL_TYPECAST set, it
> > > will evaluate to ctx->btf (which is NULL for eprobes).
> > > Could this potentially lead to silent defaults, such as 64-bit reads for
> > > smaller fields, or fail to inject pointer dereferences for string fields,
> > > while also leaving ctx->last_type pointing to a prematurely released BTF
> > > object?  
> > 
> > Does this mean we need to set ctx->last_type to NULL here too?  
> 
> No, since the member we refer can be different from unsigned long.
> When we don't have ":type" suffix, we use BTF type information to
> decide appropriate type.
> 
> > 
> > Because everything above is pretty much the expected behavior. The put is
> > *not* premature. The last_struct and struct_btf are both set to NULL. I
> > guess the only thing missing is to reset last_type as well.  
> 
> No, as I explained, the last_type is used to determine the member type
> when user does not specify the ":type" suffix.
> 
> So, what we need to do is deferring the btf_put(struct_btf) as below:
> (no build test yet.)

OK, but I don't think we want the struct_btf to exist beyond a single
arg like the btf descriptor does. How about this (on top of this change),
where it clears the struct_btf at the end of traceprobe_parse_probe_arg_body()?

Also, I see the flag as being redundant and use the existence of
struct_btf to denote that it's parsing a typedef struct.

-- Steve

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9246e9c3d066..56b7dc406ca1 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -397,8 +397,7 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 
 static struct btf *ctx_btf(struct traceprobe_parse_context *ctx)
 {
-	return ctx->flags & TPARG_FL_TYPECAST ?
-		ctx->struct_btf : ctx->btf;
+	return ctx->struct_btf ? : ctx->btf;
 }
 
 static int check_prepare_btf_string_fetch(char *typename,
@@ -531,6 +530,15 @@ static int query_btf_context(struct traceprobe_parse_context *ctx)
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
@@ -579,7 +587,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct fetch_insn *code = *pcode;
 	const struct btf_member *field;
 	u32 bitoffs, anon_offs;
-	bool is_struct = ctx->flags & TPARG_FL_TYPECAST;
+	bool is_struct = ctx->struct_btf != NULL;
 	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
@@ -690,7 +698,7 @@ static int parse_btf_arg(char *varname,
 		ret = parse_trace_event(varname, code, ctx);
 		if (ret < 0)
 			return ret;
-		if (WARN_ON_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
+		if (WARN_ON_ONCE(ctx->struct_btf == NULL))
 			return -EINVAL;
 		type = ctx->last_struct;
 		goto found_type;
@@ -804,21 +812,19 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 
 static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
 {
+	struct btf *btf = NULL;
 	int id;
 
-	if (!ctx->struct_btf) {
-		struct btf *btf;
-
-		id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
-		if (id < 0)
-			return id;
-		ctx->struct_btf = btf;
-	} else {
-		id = btf_find_by_name_kind(ctx->struct_btf, sname, BTF_KIND_STRUCT);
-		if (id < 0)
-			return id;
+	/* Could be a for a structure in a different module */
+	if (ctx->struct_btf) {
+		btf_put(ctx->struct_btf);
+		ctx->struct_btf = NULL;
 	}
 
+	id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		return id;
+	ctx->struct_btf = btf;
 	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
 	return 0;
 }
@@ -848,25 +854,23 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 
 	if (ret < 0) {
 		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
-		ret = -EINVAL;
-		goto out_put;
+		return -EINVAL;
 	}
 
-	ctx->flags |= TPARG_FL_TYPECAST;
 	tmp++;
 
 	ctx->offset += tmp - arg;
 	ret = parse_btf_arg(tmp, pcode, end, ctx);
-	ctx->flags &= ~TPARG_FL_TYPECAST;
-	ctx->last_struct = NULL;
-out_put:
-	btf_put(ctx->struct_btf);
-	ctx->struct_btf = NULL;
 	return ret;
 }
 
 #else /* !CONFIG_PROBE_EVENTS_BTF_ARGS */
 
+static void clear_struct_btf(struct traceprobe_parse_context *ctx)
+{
+	ctx->struct_btf = NULL;
+}
+
 static void clear_btf_context(struct traceprobe_parse_context *ctx)
 {
 	ctx->btf = NULL;
@@ -1673,6 +1677,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	}
 	kfree(tmp);
 
+	/* struct_btf should not be passed to other arguments */
+	clear_struct_btf(ctx);
+
 	return ret;
 }
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 952e3d7582b8..83565f1634db 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -394,7 +394,6 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
  * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
  * TPARG_FL_FPROBE and TPARG_FL_TPOINT are optional but it should be with
  * TPARG_FL_KERNEL.
- * TPARG_FL_TYPECAST is set if an argument was typecast to a structure.
  */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
@@ -403,7 +402,6 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
-#define TPARG_FL_TYPECAST BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
