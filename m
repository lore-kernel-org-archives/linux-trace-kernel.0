Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41B22259F;
	Sat, 30 May 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153646; cv=none; b=f65xxjLwtVhprarrs0ec23v8mOV3VRjzG0UcRgyhPiG7OMNN8/ukybzHTqLhSjcgr+MDJsV+a97LLZFGW7vb2hUQcHxdm16g8tZEBhgWSlZM9qv7DIsd+wLK5w2NUxV/XgvKdix3d6N8taYQ6ikUUbY/ajuLopY8bqxlwsuJowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153646; c=relaxed/simple;
	bh=St7TKUzfjXRMKVnYgQxWVktcU8qlm6KY3IIU/Q0Zd60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQqE72+pl9/Rp87Ab3ThX6mgHBkm2oP6QjUx88gYCxNd0hSHw4jZE6n5/2P1DKsfqsKGyIcNGF3i4Movep9yPSYBnZPGADPbVzUHHEcgE57SFX+oJ5RaAH/Zk4Frl+Vk8JJXqeO9R2ECBCoJBAnbNlE2rOEwzikJ88Y7DzFGriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E4ED7161AC9;
	Sat, 30 May 2026 15:07:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E829C8000F;
	Sat, 30 May 2026 15:07:13 +0000 (UTC)
Date: Sat, 30 May 2026 11:07:54 -0400
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
Message-ID: <20260530110754.14870622@gandalf.local.home>
In-Reply-To: <20260530231427.b079fefffc724a40082cd64b@kernel.org>
References: <20260529110442.0967a64c@fedora>
	<20260530231427.b079fefffc724a40082cd64b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m4eup5qr3ik58wizp8cf1p37siorgg5i
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E829C8000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+4AgsPK7oqH03v63S2oMicU5T2A+P7xoM=
X-HE-Tag: 1780153633-697350
X-HE-Meta: U2FsdGVkX18stzG5i/UpZsDs0zCakLQvD27gDk1fe5FmpjGv4Idup5ZUk1fkAp4fDdnxY8BKnPKFQcFrH7pbMydTYSFMXIjkFz3XjBtORaOP57+RZLriEOkN/Muf/c0R5+FPh7QZ6ND0VjW+Kxl+p9mhrNbu9+EAvhCggSUyS/m3CuKbpXpF7U8ORAbJ00nuNW+mLr6oLGokZ9RCUpojWW9vaLo+dvmzzPHfRrU7IJosqHWUpnzZR3xDXnyUiyMdtMB2LoFlWFSfRhcZAkP7a8/AFjldgxVUGBkEoLUQlECUK6upNyEu6aXR6ScqjdhOLBdczSJ1THW+Z4Xxk4EI9/lftszeZPXPV1tYo1pXz39omvewTGn7m3Hs3FfHO0svVhJtxJGEiOcZGWQyrMax5cduNsuCB/nuCO5nXe//s6/2duCr7OOv93/iy9cUY/NrqpLI7PpiVkfxlS34eDFEPw==

On Sat, 30 May 2026 23:14:27 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Thanks, and Sashiko reviewed this. 
> 
> https://sashiko.dev/#/patchset/20260529110442.0967a64c%40fedora
> 
> I think both comments are valid, especially, second one is important.

Hmm, comment below.

> 
> BTW, I updated probes/fixes. Could you also update this and rebase
> on probes/fixes branch?
> 
> I'm working on the nesting and container_of support patches which
> are on top of this.

OK, I'll make sure to use your probes branch. Which one should I use? your
probes/for-next or probes/urgent?

As for sashiko's comments:

> commit c8393ea9936934c16ba2881d9e7b3cce86c678ff
> Author: Steven Rostedt <rostedt@goodmis.org>
> [PATCH v7] tracing/eprobes: Allow use of BTF names to dereference pointers
> This commit introduces syntax to allow event probes to typecast pointer
> fields to a structure using BTF. This enables dereferencing structures
> using BTF names rather than having to manually calculate offsets.
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 39f040c863e85..0e87409a44033 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> [ ... ]
> > @@ -640,7 +673,7 @@ static int parse_btf_arg(char *varname,
> >  	int i, is_ptr, ret;
> >  	u32 tid;
> >  
> > -	if (WARN_ON_ONCE(!ctx->funcname))
> > +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
> >  		return -EINVAL;
> >  
> >  	is_ptr = split_next_field(varname, &field, ctx);
> > @@ -653,6 +686,16 @@ static int parse_btf_arg(char *varname,
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > +		ret = parse_trace_event(varname, code, ctx);
> > +		if (ret < 0)
> > +			return ret;

> Does this silently drop the error on parsing failure?
> If parse_trace_event() fails and returns -EINVAL, it appears this path
> returns the error without logging it.
> Unlike parse_probe_vars(), which explicitly logs the failure when
> parse_trace_event() fails, this path bypasses the log. Could this make
> it difficult to debug invalid typecast expressions since nothing is written
> to tracing/error_log?

Hmm, I guess I can put an error log here, as this is a unique path.

> > +		if (WARN_ON_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
> > +			return -EINVAL;
> > +		type = ctx->last_struct;
> > +		goto found_type;
> > +	}
> > +
> >  	if (ctx->flags & TPARG_FL_RETURN && !strcmp(varname, "$retval")) {
> >  		code->op = FETCH_OP_RETVAL;
> [ ... ]
> > @@ -758,7 +802,71 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
> >  	return 0;
> >  }
> >  
> > -#else
> > +static int query_btf_struct(const char *sname, struct traceprobe_parse_context *ctx)
> [ ... ]
> > +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> > +			   struct fetch_insn *end,
> > +			   struct traceprobe_parse_context *ctx)
> > +{
> > +	char *tmp;
> > +	int ret;
> > +
> > +	/* Currently this only works for eprobes */
> > +	if (!(ctx->flags & TPARG_FL_TEVENT)) {
> > +		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
> > +		return -EINVAL;
> > +	}
> > +
> > +	tmp = strchr(arg, ')');
> > +	if (!tmp) {
> > +		trace_probe_log_err(ctx->offset + strlen(arg),
> > +				    DEREF_OPEN_BRACE);
> > +		return -EINVAL;
> > +	}
> > +	*tmp = '\0';
> > +	ret = query_btf_struct(arg + 1, ctx);
> > +	*tmp = ')';
> > +
> > +	if (ret < 0) {
> > +		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> > +		ret = -EINVAL;
> > +		goto out_put;
> > +	}
> > +
> > +	ctx->flags |= TPARG_FL_TYPECAST;
> > +	tmp++;
> > +
> > +	ctx->offset += tmp - arg;
> > +	ret = parse_btf_arg(tmp, pcode, end, ctx);
> > +	ctx->flags &= ~TPARG_FL_TYPECAST;
> > +	ctx->last_struct = NULL;
> > +out_put:
> > +	btf_put(ctx->struct_btf);

> Does this prematurely release the BTF struct reference?
> If TPARG_FL_TYPECAST is unset here and ctx->struct_btf is put, won't
> later steps in traceprobe_parse_probe_arg_body() (like
> find_fetch_type_from_btf_type()) fail to properly infer struct field sizes?
> When ctx_btf(ctx) is called later without TPARG_FL_TYPECAST set, it
> will evaluate to ctx->btf (which is NULL for eprobes).
> Could this potentially lead to silent defaults, such as 64-bit reads for
> smaller fields, or fail to inject pointer dereferences for string fields,
> while also leaving ctx->last_type pointing to a prematurely released BTF
> object?

Does this mean we need to set ctx->last_type to NULL here too?

Because everything above is pretty much the expected behavior. The put is
*not* premature. The last_struct and struct_btf are both set to NULL. I
guess the only thing missing is to reset last_type as well.

-- Steve


> > +	ctx->struct_btf = NULL;
> > +	return ret;
> > +}
> > +
> > +#else /* !CONFIG_PROBE_EVENTS_BTF_ARGS */
