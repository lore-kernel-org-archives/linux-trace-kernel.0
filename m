Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4AD5661;
	Thu,  4 Sep 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949544; cv=none; b=OKjyzAeHxDXKWNAOpOo9lEC6EbOH9huM3eqY2PXXqTmUrf/j62x6vcixcf470AUVtMN0W8XDtTXZYoh14cE7SFYUbQr+/loxp5l4eJOMs4aCIxCCYbz8xP8LUZ/AM0YZ3JApVKRSf7El8Biiioey4jlJPRcQyouNzJSK/HJVg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949544; c=relaxed/simple;
	bh=l93qY3fTTLAE5J+kOYY/T0I+Q5vnv+2oWsWmEki3LBI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HNKHrgmmJLJJEtFTcKW/AuA3Q41QbIuKwFwasV/5rJW+/OT5SvuogE/rmpV4v+N4Sz0z/5ho3uM1HWdWDS3ueYJp2up1lDVCwKYtkeY+s91y7N94iB+tobaQhl+0zn5eV543dA1q7IKjpbxl6bOSM7xDHdBGL9kFkyT6iOxIcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueEyciu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueEyciu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB6C4CEE7;
	Thu,  4 Sep 2025 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756949543;
	bh=l93qY3fTTLAE5J+kOYY/T0I+Q5vnv+2oWsWmEki3LBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ueEyciu3rzy5Ig03+g4uj1mkJKGS4bCB/rWI4HoIFdnW4CMt5Pc9NbYnuuXrln4Jk
	 CUQUH35N6b5lgXoIhHANOVVdDkhyH9/G2JEZuuDsYDxtFt4q9RM4ce2avRzGieXBLp
	 jzv9NiktYEwuXRkLtMxqjZQFSBcAXqwkYjK0R0qXlieY9yM1JDTYT23haq1NAdPba8
	 vbUROs5pmhzRSC1pT715NKJoXTIZ1+JTVxMr8B0BJ6AqnQpOjZZ4iow7JH24N3lgel
	 aPMLOcydkS9vRQjx7MUZKUnJgNPk9UhgzUzhY0N+9O5jthZkP/JXChg7Yb0+bMCwOY
	 zjrlrRugN1/9w==
Date: Thu, 4 Sep 2025 10:32:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-Id: <20250904103219.f4937968362bfff1ecd3f004@kernel.org>
In-Reply-To: <aLiHQNBPOytj_85Q@gmail.com>
References: <20250829102050.232291-1-seokwoo.chung130@gmail.com>
	<20250902112147.165c8030837b6b21cf402fd3@kernel.org>
	<aLiHQNBPOytj_85Q@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 4 Sep 2025 03:21:52 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> On Tue, Sep 02, 2025 at 11:21:47AM +0900, Masami Hiramatsu wrote:
> Hi Masami,
> 
> Thank you for your comments.
> 
> > Hi Ryan,
> > 
> > Thanks for update.
> > 
> > On Fri, 29 Aug 2025 19:20:50 +0900
> > Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> > 
> > > This v2 addresses the TODO in trace_fprobe to handle comma-separated
> > > symbol lists and the '!' prefix. Tokens starting with '!' are collected
> > > as "nofilter", and the others as "filter", then passed to
> > > register_fprobe() accordingly. Empty tokens are rejected and errors are
> > > reported with trace_probe_log_err().
> > 
> > OK, can you describe how it changes the syntax. You may find more things
> > to write it down.
> > 
> 
> > For example, fprobe is not only a function entry, but also it supports
> > function return. How it is specified? Current "%return" suffix is introduced
> > for single symbol (function), like schedule%return. If we introduce a list
> > of symbols and filters, it looks more complicated.
> > 
> 
> I see your concern and where my confusion came from.
> 
> > For example, "!funcAB,funcC,funcA*%return" seems like the exit of funcA*,
> > the entry of funcC, but not covers funcAB. It is naturally misleading
> > users. We have to check "funcA*%return,!funcAB,funcC" pattern.
> > 
> > Thus, I think we should use another suffix, like ":exit" (I think the colon
> > does strongly separate than comma, what do you think?), or just
> > prohibit to use "%return" but user needs to specify "$retval" in fetcharg
> > to specify it is the fprobe on function exit. (this maybe more natural)
> > 
> 
> I agree with you here. Using another suffix will make it more clearer
> for the user. 
> 
> So in that sense, I am guessing you are suggesting:
> :exit (return)
> :entry (explicit entry)

Yes, that's right.

> 
> So this applies to the entire list. If a comma or wildcard is present
> and %return appears, the parser will reject it with -EINVAL and a
> precise trace_probe_log() index. For a single symbol, we use the legacy
> foo%return.
> 
> Ex)
> funcA*,!funcAB,funcC          # entry (default)
> funcA*,!funcAB,funcC:exit     # exit (spec-level)
> schedule%return               # single-symbol legacy

Right. this also should be shown in README so that test program can
identify the kernel supports new syntax.

> 
> > The reason why I talked about how to specify the exit point of a function
> > so far, is because the variables that can be accessed at the entrance
> > and exit are different.
> > 
> 
> Ah I see.
> 
> > Also, fprobe supports event-name autogeneration from the symbol name,
> > e.g. 'symbol__entry' or 'symbol__exit'. Recently I found the symbol
> > already supports wildcards, so sanitize it from the event name [1]
> > 
> > [1] https://lore.kernel.org/all/175535345114.282990.12294108192847938710.stgit@devnote2/
> > 
> > To use this list-style filters, we may need to reject if there is no
> > event name. Of cause we can generate event-name from the symbol list
> > but you need to sanitize non alphabet-number characters.
> > 
> > Ah, here is another one, symbol is used for ctx->funcname, and this is
> > used for querying BTF. But obviously BTF context is unusable for this
> > case. So we should set the ctx->funcname = NULL with listed filter.
> > 
> 
> So it seems like this TODO is actually a bit larger scope than the
> patch anticipated.

Yeah, sorry for confusion. It was too simple.

> 
> In that sense, maybe we could:
> - for Single, literaly symbol, keep autogen symbol__entry/symbol__exit
>   and sanitize wildcards.
> - for List or wildcard, require an explicit [GROUP/]EVENT; reject if
>   ommitted. No autogen.

Also, 
  - update <tracefs>/README so that we can write a new test case for
    this syntax.
  - update current existing test case's "requires:" lines.

> 
> I don't completely understand ctx->funcname you mentioned for the
> usecase for querying BTF. I will research it more.

It is only used for BTF (BPF type format, describes function prototype
which can be queried by function name), so you just need to set it NULL.

> > > 
> > > Questions for maintainers (to confirm my understanding):
> > >   * Parsing location: Masami suggested doing the parsing in the parse
> > >     stage (e.g., via parse_symbol_and_return()). v2 keeps the logic in
> > >     __register_trace_fprobe(), but I can move the call into the parsing
> > >     path in v3 if that is the preferred place. Is that correct?
> > 
> > Most of above processes have been done in parse_symbol_and_return(),
> > thus the parsing it should be done around there.
> > 
> 
> Thank you.
> 
> > >   * Documentation: I plan to update the user-facing docs for fprobe
> > >     syntax. Is Documentation/trace/ the right place (e.g., 
> > >     Documentation/trace/fprobetrace.rst)?
> > 
> > Yes, please explain it with examples.
> > 
> > Also, can you add a testcase (in a sparate patch) for this syntax?)
> > 
> 
> Yes. I will add selftests under tools/testing/selftests/ftrace/:
> Accept when list entry/exit; ! exclusions; whitespace variants.
> Reject when empty tokens, leading/trailing commas, %return with lists or
> wildcards, mixed forms.
> Naming: autogen only for single literal; list/wildcard requires explicit
> event name. 
> BTF: ctx->fullname == NULL when multi/wildcard.

Yes, that's what I meant.

> 
> I will add the following: 
> # entry across a list
> echo 'f:net/tx_entry tcp_sendmsg*,!tcp_sendmsg_locked,tcp_sendpage' \
>   > /sys/kernel/tracing/dynamic_events
> 
> # exit across the same list (spec-level)
> echo 'f:net/tx_exit tcp_sendmsg*,!tcp_sendmsg_locked,tcp_sendpage:exit' \
>   > /sys/kernel/tracing/dynamic_events
> 
> echo 1 > /sys/kernel/tracing/events/net/tx_entry/enable
> echo 1 > /sys/kernel/tracing/events/net/tx_exit/enable

OK, but carefully choose the symbols, some of them can be disappear
depending on Kconfig.

> 
> > Thank you,
> > 
> > > 
> > > Link: https://lore.kernel.org/linux-trace-kernel/20250812162101.5981-1-seokwoo.chung130@gmail.com/
> > > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > 
> > > ---
> > > 
> > > Changes in v2:
> > >   * Classify '!' tokens as nofilter, others as filter; pass both to
> > >     register_fprobe().
> > >   * Reject empty tokens; log errors with trace_probe_log_*().
> > >   * Use __free(kfree) for temporary buffers.
> > >   * Keep subject and style per "Submitting patches" (tabs, wrapping).
> > >   * No manual dedup (leave to ftrace).
> > > 
> > >  kernel/trace/trace_fprobe.c | 48 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 46 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > > index b36ade43d4b3..d731d9754a39 100644
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -815,6 +815,11 @@ static int trace_fprobe_verify_target(struct trace_fprobe *tf)
> > >  static int __register_trace_fprobe(struct trace_fprobe *tf)
> > 
> > This is not a good place to add anymore, because this change turned out
> > not to meet the expected prerequisites. (when I commented TODO here,
> > I didn't expected too.)
> > 
> > Anyway, this is a good opportunity to review this TODO deeper.
> > 
> > Thank you,
> > 
> 
> I see. My question is whether or not all the symbol and filter should be
> done in a separate location or possibly separate function (i.e.,
> parse_symbol_and_return()).

That's a good question. I recommend you to have a separate function
because it needs a set of local variables, and independent logic.
It also needs to introduce .filter and .nofilter fields in trace_fprobe.

> 
> Unless you prefer dropping %return entirely now, I’ll keep it for
> single-symbol compatibility and mark it legacy in
> Documentation/trace/fprobetrace.rst.

Yeah, please keep it for backward compatibility.

> I’ll send v3 with the parser
> move, the spec-level suffix, explicit-name rule for list/wildcard,
> BTF guard, docs, and selftests.

Sounds good.

Thank you!

> 
> > >  {
> > >  	int i, ret;
> > > +	const char *p, *q;
> > > +	size_t spec_len, flen = 0, nflen = 0, tlen;
> > > +	bool have_f = false, have_nf = false;
> > > +	char *filter __free(kfree) = NULL;
> > > +	char *nofilter __free(kfree) = NULL;
> > >  
> > >  	/* Should we need new LOCKDOWN flag for fprobe? */
> > >  	ret = security_locked_down(LOCKDOWN_KPROBES);
> > > @@ -835,8 +840,47 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
> > >  	if (trace_fprobe_is_tracepoint(tf))
> > >  		return __regsiter_tracepoint_fprobe(tf);
> > >  
> > > -	/* TODO: handle filter, nofilter or symbol list */
> > > -	return register_fprobe(&tf->fp, tf->symbol, NULL);
> > > +	spec_len = strlen(tf->symbol);
> > > +	filter = kzalloc(spec_len + 1, GFP_KERNEL);
> > > +	nofilter = kzalloc(spec_len + 1, GFP_KERNEL);
> > > +	if (!filter || !nofilter)
> > > +		return -ENOMEM;
> > > +
> > > +	p = tf->symbol;
> > > +	for (p = tf->symbol; p; p = q ? q + 1 : NULL) {
> > > +		q = strchr(p, ',');
> > > +		tlen = q ? (size_t)(q-p) : strlen(p);
> > > +
> > > +		/* reject empty token */
> > > +		if (!tlen) {
> > > +			trace_probe_log_set_index(1);
> > > +			trace_probe_log_err(0, BAD_TP_NAME);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		if (*p == '!') {
> > > +			if (tlen == 1) {
> > > +				trace_probe_log_set_index(1);
> > > +				trace_probe_log_err(0, BAD_TP_NAME);
> > > +				return -EINVAL;
> > > +			}
> > > +			if (have_nf)
> > > +				nofilter[nflen++] = ',';
> > > +			memcpy(nofilter + nflen, p + 1, tlen - 1);
> > > +			nflen += tlen - 1;
> > > +			have_nf = true;
> > > +		} else {
> > > +			if (have_f)
> > > +				filter[flen++] = ',';
> > > +			memcpy(filter + flen, p, tlen);
> > > +			flen += tlen;
> > > +			have_f = true;
> > > +		}
> > > +	}
> > > +
> > > +	return register_fprobe(&tf->fp,
> > > +			have_f ? filter : NULL,
> > > +			have_nf ? nofilter : NULL);
> > >  }
> > >  
> > >  /* Internal unregister function - just handle fprobe and flags */
> > > -- 
> > > 2.43.0
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Best regards,
> Ryan Chung
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
