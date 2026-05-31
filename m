Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16472D94BA;
	Sun, 31 May 2026 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780190105; cv=none; b=CHvo3E4JYAAeWN8H/RPHMqrOxblASRY6cldnOjQtP5DctFkbHPusnJRm374JGh3aB2HsCQjZawE8YUqkRshzN5zVI2CG2EzR5u7ZOJ1YUkKX3Q4MmaJaUZJqHD8XK6n9UdXH+MULv4ZwbsTSEAnNFwSooFghQLo+4XbGDjOi5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780190105; c=relaxed/simple;
	bh=nR61sCVhVO8GsWj1sL6a/1MGB1fir4TP3Nuep4uVWlA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sWEyKKRDrofniuZ9ecgutRA6NQt6kGWv4t7o5fxXTkjieiDZdLb8Xybt84sYWfT8nWEhzScP4cmZSeGRWa8tSf5sEEz98LodZ05nWr+/akhFQVOAwjMcEyyO4Qs7YvY54gPkU9vSLiRM4YtOtvP7RibwpgmD4ho/ZVaT2lEhn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1JQihF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1JQihF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FB71F00893;
	Sun, 31 May 2026 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780190103;
	bh=2u6gsL55fJO2e1VPOPKWnT2x/Q6WHQ+/DZKRUoeinJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X1JQihF9c4MOg/HkCcweSDCzmF9APr5oNzEgs4OqKsTl/FpgR4DnAPrqBrodiAxXC
	 3jTDbr0JFoKGybsNBDGfSghIyk7Gf2NO2Xnp+bpVqYoTZ8xoraTjdyhF3O7TF6msVG
	 sEtXsVCwJgBjNYJ4vb90hTApfMNNoKjeV+9P5qb7OYoZTAJwDBUU4+JM3OURMw8l3r
	 NPT4U2ZXot8BbJbkrMP6PwWEQGgkIkU35Hb+N0WM4sB1aDIyN2e7mzj6Lsi2MnAtLE
	 kzHA0ogJlMBTQz+W3KZmA4Sh5y0eHSK+K29t0sfhQI0dRHtc8W3RlfDRfbH2gD7y/Y
	 NavtYkETflfBg==
Date: Sun, 31 May 2026 10:14:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20260531101458.c8ee22f6222a3fc224cc5328@kernel.org>
In-Reply-To: <20260530110754.14870622@gandalf.local.home>
References: <20260529110442.0967a64c@fedora>
	<20260530231427.b079fefffc724a40082cd64b@kernel.org>
	<20260530110754.14870622@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 11:07:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 30 May 2026 23:14:27 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Thanks, and Sashiko reviewed this. 
> > 
> > https://sashiko.dev/#/patchset/20260529110442.0967a64c%40fedora
> > 
> > I think both comments are valid, especially, second one is important.
> 
> Hmm, comment below.
> 
> > 
> > BTW, I updated probes/fixes. Could you also update this and rebase
> > on probes/fixes branch?
> > 
> > I'm working on the nesting and container_of support patches which
> > are on top of this.
> 
> OK, I'll make sure to use your probes branch. Which one should I use? your
> probes/for-next or probes/urgent?

Ah, probes/fixes. (I think I need to update probes/for-next to rebase on it)

> 
> As for sashiko's comments:
> 
> > commit c8393ea9936934c16ba2881d9e7b3cce86c678ff
> > Author: Steven Rostedt <rostedt@goodmis.org>
> > [PATCH v7] tracing/eprobes: Allow use of BTF names to dereference pointers
> > This commit introduces syntax to allow event probes to typecast pointer
> > fields to a structure using BTF. This enables dereferencing structures
> > using BTF names rather than having to manually calculate offsets.
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index 39f040c863e85..0e87409a44033 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > [ ... ]
> > > @@ -640,7 +673,7 @@ static int parse_btf_arg(char *varname,
> > >  	int i, is_ptr, ret;
> > >  	u32 tid;
> > >  
> > > -	if (WARN_ON_ONCE(!ctx->funcname))
> > > +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
> > >  		return -EINVAL;
> > >  
> > >  	is_ptr = split_next_field(varname, &field, ctx);
> > > @@ -653,6 +686,16 @@ static int parse_btf_arg(char *varname,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >  
> > > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > > +		ret = parse_trace_event(varname, code, ctx);
> > > +		if (ret < 0)
> > > +			return ret;
> 
> > Does this silently drop the error on parsing failure?
> > If parse_trace_event() fails and returns -EINVAL, it appears this path
> > returns the error without logging it.
> > Unlike parse_probe_vars(), which explicitly logs the failure when
> > parse_trace_event() fails, this path bypasses the log. Could this make
> > it difficult to debug invalid typecast expressions since nothing is written
> > to tracing/error_log?
> 
> Hmm, I guess I can put an error log here, as this is a unique path.

Yeah, just adding trace_probe_log_err(ctx->offset, BAD_VAR) seems OK.

> 
> > > +		if (WARN_ON_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
> > > +			return -EINVAL;
> > > +		type = ctx->last_struct;
> > > +		goto found_type;
> > > +	}
> > > +
> > >  	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
> > >  		code->op = FETCH_OP_RETVAL;
> > [ ... ]
> > > @@ -758,7 +802,71 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
> > >  	return 0;
> > >  }
> > >  
> > > -#else
> > > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> > [ ... ]
> > > +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> > > +			   struct fetch_insn *end,
> > > +			   struct traceprobe_parse_context *ctx)
> > > +{
> > > +	char *tmp;
> > > +	int ret;
> > > +
> > > +	/* Currently this only works for eprobes */
> > > +	if (!(ctx->flags & TPARG_FL_TEVENT)) {
> > > +		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	tmp = strchr(arg, ')');
> > > +	if (!tmp) {
> > > +		trace_probe_log_err(ctx->offset + strlen(arg),
> > > +				    DEREF_OPEN_BRACE);
> > > +		return -EINVAL;
> > > +	}
> > > +	*tmp = '\0';
> > > +	ret = query_btf_struct(arg + 1, ctx);
> > > +	*tmp = ')';
> > > +
> > > +	if (ret < 0) {
> > > +		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> > > +		ret = -EINVAL;
> > > +		goto out_put;
> > > +	}
> > > +
> > > +	ctx->flags |= TPARG_FL_TYPECAST;
> > > +	tmp++;
> > > +
> > > +	ctx->offset += tmp - arg;
> > > +	ret = parse_btf_arg(tmp, pcode, end, ctx);
> > > +	ctx->flags &= ~TPARG_FL_TYPECAST;
> > > +	ctx->last_struct = NULL;
> > > +out_put:
> > > +	btf_put(ctx->struct_btf);
> 
> > Does this prematurely release the BTF struct reference?
> > If TPARG_FL_TYPECAST is unset here and ctx->struct_btf is put, won't
> > later steps in traceprobe_parse_probe_arg_body() (like
> > find_fetch_type_from_btf_type()) fail to properly infer struct field sizes?
> > When ctx_btf(ctx) is called later without TPARG_FL_TYPECAST set, it
> > will evaluate to ctx->btf (which is NULL for eprobes).
> > Could this potentially lead to silent defaults, such as 64-bit reads for
> > smaller fields, or fail to inject pointer dereferences for string fields,
> > while also leaving ctx->last_type pointing to a prematurely released BTF
> > object?
> 
> Does this mean we need to set ctx->last_type to NULL here too?

No, since the member we refer can be different from unsigned long.
When we don't have ":type" suffix, we use BTF type information to
decide appropriate type.

> 
> Because everything above is pretty much the expected behavior. The put is
> *not* premature. The last_struct and struct_btf are both set to NULL. I
> guess the only thing missing is to reset last_type as well.

No, as I explained, the last_type is used to determine the member type
when user does not specify the ":type" suffix.

So, what we need to do is deferring the btf_put(struct_btf) as below:
(no build test yet.)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index adaa1e4fbdd6..9a73c49e22df 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -538,6 +538,10 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 		ctx->params = NULL;
 		ctx->nr_params = 0;
 	}
+	if (ctx->struct_btf) {
+		btf_put(ctx->struct_btf);
+		ctx->struct_btf = NULL;
+	}
 }
 
 /* Return 1 if the field separator is arrow operator ('->') */
@@ -802,22 +806,18 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 
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
+	if (ctx->struct_btf) {
+		btf_put(ctx->struct_btf);
+		ctx->struct_btf = NULL;
 	}
 
-	ctx->last_struct = btf_type_by_id(ctx->struct_btf, id);
+	id = bpf_find_btf_id(sname, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		return id;
+	ctx->struct_btf = btf;
 	return 0;
 }
 
@@ -846,8 +846,7 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 
 	if (ret < 0) {
 		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
-		ret = -EINVAL;
-		goto out_put;
+		return ret;
 	}
 
 	ctx->flags |= TPARG_FL_TYPECAST;
@@ -857,9 +856,6 @@ static int handle_typecast(char *arg, struct fetch_insn **pcode,
 	ret = parse_btf_arg(tmp, pcode, end, ctx);
 	ctx->flags &= ~TPARG_FL_TYPECAST;
 	ctx->last_struct = NULL;
-out_put:
-	btf_put(ctx->struct_btf);
-	ctx->struct_btf = NULL;
 	return ret;
 }
 

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
