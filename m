Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD87360ED1;
	Fri, 22 May 2026 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448994; cv=none; b=eMdhtZ9MlsJX2661m+t37vGqg5CzAKp5kTEVBGpivGr12WnhHl64puiaYnH9R37eN8dk6q0qhWDEdIxJOqtfJuKu6eHK2WWhqwXK5Gs9z1k+/2j+tqWAvg7WXGFbZCdm3PnzJXYKWWdvHq+0DuLz63PaksIaIpPvBa8iWJEhcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448994; c=relaxed/simple;
	bh=EynYeKcEeDcp6wkoF0BwTgjrnh7f9FWnussxgxK98yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKzQVhzGskRXTEJ+9QDBz29cJjYmkl8AdKWqKEIWhqxt2MXkVKLUcz9M5RRIK/rB/t0sLvLS0CsxOclfXnRsueK95nVzWLuQeaJ4Ro0PwJZECnnI8WjbsBmgI3JutmDcXvqxqb8CouMy0YrfsnzriZX/KPCcKDKKomMvnflpWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B847A1C1D6E;
	Fri, 22 May 2026 11:23:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 5DC3A20024;
	Fri, 22 May 2026 11:23:00 +0000 (UTC)
Date: Fri, 22 May 2026 07:23:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260522072322.18aa72dd@gandalf.local.home>
In-Reply-To: <20260521225033.56458336@fedora>
References: <20260521225033.56458336@fedora>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5DC3A20024
X-Rspamd-Server: rspamout06
X-Stat-Signature: afa4nbhk6ny8gj3cq78ujbpoi5ffmkhw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Zth/HUjUaEtmDfKhT8AscJIDFdcCIXes=
X-HE-Tag: 1779448980-770974
X-HE-Meta: U2FsdGVkX1/SLKYf4c/5fIJfBk9rp57TLhM+/XpkKKY1uc9NOrmruBiK+xaXAQ97upufwnAYIovdK2V+ZeCreHzHL+t8j6pN0lD9V/A6uu4G7dRDrQmR83e9AJyCvlqtQrf24JfLThMWzD6iC9hwrfSHsE9eB1QQ8XCr8zgzrqZwEb5Qi+bJefO0ojPxO0xJ/BlZ3ct1Vg6CknnuJ1j0/F3S1XXALzaepeYm0l1oTog0yU6PfXSXgUUtIfeWr1aN0emvVnzVlkcSNofRocvyyLgO5mT+Gm+DGIn8i7ZkeMNSXfXAGa3iyvBcNYLUrvn6YDdBUKL7cTOdjsxXc66gf2mWoTnXYTnery9AWcvt31zhTxvDr/VygbOFQzY/yuK4


[ Replying to Sashiko: https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260521225033.56458336%40fedora ]

> > @@ -653,6 +686,20 @@ static int parse_btf_arg(char *varname,
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > +		int ret;
> > +
> > +		ret = parse_trace_event(varname, code, ctx);
> > +		if (ret < 0)
> > +			return ret;

> When parse_trace_event() returns a negative error code (such as -EINVAL or
> -ENOENT) because a field name is invalid, the error is propagated back up
> the stack. Does this path miss calling trace_probe_log_err()? 
> If so, users might receive a generic failure without context or a caret
> pointing to the specific syntax error.

Hmm, there's a comment in the parse_trace_event() that sets ctx->offset for
backward compatibility. I'll investigate to see if we can fix that now.

> > +
> > +		if (ctx->flags & TPARG_FL_TYPECAST) {
> > +			type = ctx->last_struct;
> > +			goto found_type;
> > +		}
> > +		return 0;
> > +	}
> ...
> > @@ -758,7 +806,70 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
> >  	return 0;
> >  }
> >  
> > +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> > +			   struct fetch_insn *end,
> > +			   struct traceprobe_parse_context *ctx)
> > +{
> ...
> > +	ctx->flags |= TPARG_FL_TYPECAST;
> > +	tmp++;
> > +
> > +	ctx->offset += tmp - arg;
> > +	ret = parse_btf_arg(tmp, pcode, end, ctx);
> > +	ctx->flags &= ~TPARG_FL_TYPECAST;

> Since TPARG_FL_TYPECAST is cleared here, will it break automatic type
> inference later? 
> The traceprobe_parse_context is used for subsequent steps like
> find_fetch_type_from_btf_type() and check_prepare_btf_string_fetch(),
> which execute in traceprobe_parse_probe_arg() after this function returns.
> These functions rely on ctx_btf(), which needs TPARG_FL_TYPECAST to be
> set to return ctx->struct_btf.

> > +	ctx->last_struct = NULL;
> > +out_put:
> > +	btf_put(ctx->struct_btf);

> Because ctx->struct_btf is not set to NULL after calling btf_put(),
> can this cause a refcount underflow and use-after-free?
> If a user creates an eprobe with multiple typecasted arguments, the shared
> traceprobe_parse_context means the second argument will enter
> query_btf_struct() and see ctx->struct_btf is not NULL. It will skip
> acquiring a new reference but still use the pointer. At the end of parsing
> the second argument, btf_put(ctx->struct_btf) will be called again
> unconditionally.

Oops, I forgot to do:

	ctx->struct_buf = NULL;

here.

Will fix.

Thanks,

-- Steve


> > +	return ret;
> > +}
