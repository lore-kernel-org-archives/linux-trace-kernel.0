Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBF1ADC97;
	Wed,  3 Sep 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923718; cv=none; b=X/o8uiuTeAD8FSq+9JUJfTsasybU0zrd7I5L3A8gooJSKyKWNW51/1wZe6qqT5t9asAVxce6z3IDQV2NGpDzdZF1K+euTmDRv0zrgswHg5V7UiLuMOs+Fy/DsVagjkftL9oSHeFNdXGuOwPBjSk3ank8hir9lJsiX/TK9C82y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923718; c=relaxed/simple;
	bh=W0lC5R2+34xg5aYdHdN0hLDRbtgE256F3kX1lB/D8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/CdYiOI7qgjRFn6UzZRVvLBkJaHusywJ1j11DwboNMI5678AW4GXAgcJpMZ9CrV7krimyljBiR7Prqj+3fRFEwRTZ+4gnvoYvS5LXJdqOjgDEku36s5JAAmk/buLUjtQnMIbHBARAZEte596vyil4+BR2YUaGrlYXe1T31xHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP36bZag; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP36bZag"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70dfd18a27fso1479336d6.0;
        Wed, 03 Sep 2025 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923715; x=1757528515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LNP7ImyZ1MBjGXawCz04pirTs+Puchh4Cq6FlBkHlhE=;
        b=BP36bZagGU1Z6HMRcyl2vUksDjPzTjCNgtj48j5o4Ofc/r1GZGZ3Ql+3oZ+sq8Lyqq
         I1BIdqEP3zqyrOuw5xbnmgldW1SOPj6pd8PUJ29blOk3z0fGPqwtbvCgsG28L48E0Gri
         8GlWL1yItiM/8nZC1sn8veatDce3C4S22EamJrISAHP6U+9K5mLt/Io34EXhnOAOzYEs
         YWi2nXfgrxbrhyQm+FkCSHF6VBYd7ObaqwcyklFY6JMqwvrHsN37zD/8Y0hAkqpxSHXi
         4yufjOWt9e+HEHeSmAzenyHqP8YHxTMIpoYtYqqHV9Byxxzjuj8x9Q+65EykOlQKqjdk
         tX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923715; x=1757528515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNP7ImyZ1MBjGXawCz04pirTs+Puchh4Cq6FlBkHlhE=;
        b=ZG2ZfAn8E7SLeQLMJ1wnKZpK/LmjFklvmDfAcDwcoJBYkXRs+3v3PBe45BMK4/pK50
         joSHWLNnmviBM/b/cL++LXtkIxQdxdR650cNhD1tgCzTnNpzxEFiLzbAsAtbgnyvUBzO
         ercL8C2B1FXMZ18ckAxXcrqr+tbdFNlyBo+Naj0WmWScd5ouSyZY/2v5P6i1hB6lOR2b
         oZ6D6milsEtMF2VliN072l4g6fmGi3g3EQbdI1tCJx4Jq14gZHvd1YyaTnXfEHK3LV8/
         qYbicNE4uJ4o31AaKI9+MbsgMD6h2cbjhgGKhiblWcFylcue48AWbbbasNp7NsBD5Qvf
         HU1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1xHvQvMeTfAvPG+c+3+8DBenbDKBtqIfZfUqumoiWbtOh+F78glAh6Vfgp13FnF0g4vBb7OyZ+yhiW30=@vger.kernel.org, AJvYcCWuo//+loG10aJG+A/Wwgj0QOLd6KB9bLl5dgomHA553DbZaJuuCp0wT0M5Na+lRcDNfEWwPzmJv0fY5rrTJDG425iQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lRbSKsraGv6G2j452oqGNTAVaBP33pvSyz+q99Yxf5gDPkYO
	0lrTVA163MlTfefZUpVcT+ijjUhyROz4FO9e26ebW+zNlbkpGxMInRG+0hvXijXc1+tMNw==
X-Gm-Gg: ASbGncsvuzBMgp0+oVXDiG3Wdd8oWX7nNs4//I9+0sfe2ohGasRSWrgboQ21B2/Qpa2
	++yXPSMrk4fdsVpGdHWi8RBft62z+3Obu9QFkrz4cQYMfe3JCY0RrVvItNeBBOXCQTPKWMWOFVI
	055gvse1+DV9zKzFrsruyTQDZL1BCYwopY5CZWwaSHJEFQlzHvPDpIHMmmX9vdcmpFfsVdQ5XfS
	5lYCEaP5eseUuR+ELT9Izjnww7V5NKp8Jc+ObUeW0+W9AcZXH3zAF7GZkWMqFjHzPQsNn3WDzfm
	jGmXqEqtRTf46TEpdf88T7pyoFCY9DzmxgP/O+/Rxd2IhUpeHPyvGqlPHNlK7Kiv68UcrG9aaqN
	OpLwCo8fy6CSFnxTq2tC1wOPOLWQKozA2pRl8q613MA1ChzNP
X-Google-Smtp-Source: AGHT+IED1sNvP+KLffopKUwQrmP7u+htZP1Exnpw6dAOY5RtZLV0gBKxjlmXyLlQc+326nA+U256Pg==
X-Received: by 2002:a05:6214:d01:b0:71e:bbb8:9dba with SMTP id 6a1803df08f44-71ebbb8a43fmr95585986d6.56.1756923715104;
        Wed, 03 Sep 2025 11:21:55 -0700 (PDT)
Received: from gmail.com (wlc3.cooper.edu. [199.98.16.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add668bdsm31981106d6.33.2025.09.03.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:21:54 -0700 (PDT)
Date: Thu, 4 Sep 2025 03:21:52 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-ID: <aLiHQNBPOytj_85Q@gmail.com>
References: <20250829102050.232291-1-seokwoo.chung130@gmail.com>
 <20250902112147.165c8030837b6b21cf402fd3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902112147.165c8030837b6b21cf402fd3@kernel.org>

On Tue, Sep 02, 2025 at 11:21:47AM +0900, Masami Hiramatsu wrote:
Hi Masami,

Thank you for your comments.

> Hi Ryan,
> 
> Thanks for update.
> 
> On Fri, 29 Aug 2025 19:20:50 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > This v2 addresses the TODO in trace_fprobe to handle comma-separated
> > symbol lists and the '!' prefix. Tokens starting with '!' are collected
> > as "nofilter", and the others as "filter", then passed to
> > register_fprobe() accordingly. Empty tokens are rejected and errors are
> > reported with trace_probe_log_err().
> 
> OK, can you describe how it changes the syntax. You may find more things
> to write it down.
> 

> For example, fprobe is not only a function entry, but also it supports
> function return. How it is specified? Current "%return" suffix is introduced
> for single symbol (function), like schedule%return. If we introduce a list
> of symbols and filters, it looks more complicated.
> 

I see your concern and where my confusion came from.

> For example, "!funcAB,funcC,funcA*%return" seems like the exit of funcA*,
> the entry of funcC, but not covers funcAB. It is naturally misleading
> users. We have to check "funcA*%return,!funcAB,funcC" pattern.
> 
> Thus, I think we should use another suffix, like ":exit" (I think the colon
> does strongly separate than comma, what do you think?), or just
> prohibit to use "%return" but user needs to specify "$retval" in fetcharg
> to specify it is the fprobe on function exit. (this maybe more natural)
> 

I agree with you here. Using another suffix will make it more clearer
for the user. 

So in that sense, I am guessing you are suggesting:
:exit (return)
:entry (explicit entry)

So this applies to the entire list. If a comma or wildcard is present
and %return appears, the parser will reject it with -EINVAL and a
precise trace_probe_log() index. For a single symbol, we use the legacy
foo%return.

Ex)
funcA*,!funcAB,funcC          # entry (default)
funcA*,!funcAB,funcC:exit     # exit (spec-level)
schedule%return               # single-symbol legacy

> The reason why I talked about how to specify the exit point of a function
> so far, is because the variables that can be accessed at the entrance
> and exit are different.
> 

Ah I see.

> Also, fprobe supports event-name autogeneration from the symbol name,
> e.g. 'symbol__entry' or 'symbol__exit'. Recently I found the symbol
> already supports wildcards, so sanitize it from the event name [1]
> 
> [1] https://lore.kernel.org/all/175535345114.282990.12294108192847938710.stgit@devnote2/
> 
> To use this list-style filters, we may need to reject if there is no
> event name. Of cause we can generate event-name from the symbol list
> but you need to sanitize non alphabet-number characters.
> 
> Ah, here is another one, symbol is used for ctx->funcname, and this is
> used for querying BTF. But obviously BTF context is unusable for this
> case. So we should set the ctx->funcname = NULL with listed filter.
> 

So it seems like this TODO is actually a bit larger scope than the
patch anticipated.

In that sense, maybe we could:
- for Single, literaly symbol, keep autogen symbol__entry/symbol__exit
  and sanitize wildcards.
- for List or wildcard, require an explicit [GROUP/]EVENT; reject if
  ommitted. No autogen.

I don't completely understand ctx->funcname you mentioned for the
usecase for querying BTF. I will research it more.

> > 
> > Questions for maintainers (to confirm my understanding):
> >   * Parsing location: Masami suggested doing the parsing in the parse
> >     stage (e.g., via parse_symbol_and_return()). v2 keeps the logic in
> >     __register_trace_fprobe(), but I can move the call into the parsing
> >     path in v3 if that is the preferred place. Is that correct?
> 
> Most of above processes have been done in parse_symbol_and_return(),
> thus the parsing it should be done around there.
> 

Thank you.

> >   * Documentation: I plan to update the user-facing docs for fprobe
> >     syntax. Is Documentation/trace/ the right place (e.g., 
> >     Documentation/trace/fprobetrace.rst)?
> 
> Yes, please explain it with examples.
> 
> Also, can you add a testcase (in a sparate patch) for this syntax?)
> 

Yes. I will add selftests under tools/testing/selftests/ftrace/:
Accept when list entry/exit; ! exclusions; whitespace variants.
Reject when empty tokens, leading/trailing commas, %return with lists or
wildcards, mixed forms.
Naming: autogen only for single literal; list/wildcard requires explicit
event name. 
BTF: ctx->fullname == NULL when multi/wildcard.

I will add the following: 
# entry across a list
echo 'f:net/tx_entry tcp_sendmsg*,!tcp_sendmsg_locked,tcp_sendpage' \
  > /sys/kernel/tracing/dynamic_events

# exit across the same list (spec-level)
echo 'f:net/tx_exit tcp_sendmsg*,!tcp_sendmsg_locked,tcp_sendpage:exit' \
  > /sys/kernel/tracing/dynamic_events

echo 1 > /sys/kernel/tracing/events/net/tx_entry/enable
echo 1 > /sys/kernel/tracing/events/net/tx_exit/enable

> Thank you,
> 
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20250812162101.5981-1-seokwoo.chung130@gmail.com/
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> 
> > ---
> > 
> > Changes in v2:
> >   * Classify '!' tokens as nofilter, others as filter; pass both to
> >     register_fprobe().
> >   * Reject empty tokens; log errors with trace_probe_log_*().
> >   * Use __free(kfree) for temporary buffers.
> >   * Keep subject and style per "Submitting patches" (tabs, wrapping).
> >   * No manual dedup (leave to ftrace).
> > 
> >  kernel/trace/trace_fprobe.c | 48 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index b36ade43d4b3..d731d9754a39 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -815,6 +815,11 @@ static int trace_fprobe_verify_target(struct trace_fprobe *tf)
> >  static int __register_trace_fprobe(struct trace_fprobe *tf)
> 
> This is not a good place to add anymore, because this change turned out
> not to meet the expected prerequisites. (when I commented TODO here,
> I didn't expected too.)
> 
> Anyway, this is a good opportunity to review this TODO deeper.
> 
> Thank you,
> 

I see. My question is whether or not all the symbol and filter should be
done in a separate location or possibly separate function (i.e.,
parse_symbol_and_return()).

Unless you prefer dropping %return entirely now, I’ll keep it for
single-symbol compatibility and mark it legacy in
Documentation/trace/fprobetrace.rst. I’ll send v3 with the parser
move, the spec-level suffix, explicit-name rule for list/wildcard,
BTF guard, docs, and selftests.

> >  {
> >  	int i, ret;
> > +	const char *p, *q;
> > +	size_t spec_len, flen = 0, nflen = 0, tlen;
> > +	bool have_f = false, have_nf = false;
> > +	char *filter __free(kfree) = NULL;
> > +	char *nofilter __free(kfree) = NULL;
> >  
> >  	/* Should we need new LOCKDOWN flag for fprobe? */
> >  	ret = security_locked_down(LOCKDOWN_KPROBES);
> > @@ -835,8 +840,47 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
> >  	if (trace_fprobe_is_tracepoint(tf))
> >  		return __regsiter_tracepoint_fprobe(tf);
> >  
> > -	/* TODO: handle filter, nofilter or symbol list */
> > -	return register_fprobe(&tf->fp, tf->symbol, NULL);
> > +	spec_len = strlen(tf->symbol);
> > +	filter = kzalloc(spec_len + 1, GFP_KERNEL);
> > +	nofilter = kzalloc(spec_len + 1, GFP_KERNEL);
> > +	if (!filter || !nofilter)
> > +		return -ENOMEM;
> > +
> > +	p = tf->symbol;
> > +	for (p = tf->symbol; p; p = q ? q + 1 : NULL) {
> > +		q = strchr(p, ',');
> > +		tlen = q ? (size_t)(q-p) : strlen(p);
> > +
> > +		/* reject empty token */
> > +		if (!tlen) {
> > +			trace_probe_log_set_index(1);
> > +			trace_probe_log_err(0, BAD_TP_NAME);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (*p == '!') {
> > +			if (tlen == 1) {
> > +				trace_probe_log_set_index(1);
> > +				trace_probe_log_err(0, BAD_TP_NAME);
> > +				return -EINVAL;
> > +			}
> > +			if (have_nf)
> > +				nofilter[nflen++] = ',';
> > +			memcpy(nofilter + nflen, p + 1, tlen - 1);
> > +			nflen += tlen - 1;
> > +			have_nf = true;
> > +		} else {
> > +			if (have_f)
> > +				filter[flen++] = ',';
> > +			memcpy(filter + flen, p, tlen);
> > +			flen += tlen;
> > +			have_f = true;
> > +		}
> > +	}
> > +
> > +	return register_fprobe(&tf->fp,
> > +			have_f ? filter : NULL,
> > +			have_nf ? nofilter : NULL);
> >  }
> >  
> >  /* Internal unregister function - just handle fprobe and flags */
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Best regards,
Ryan Chung


