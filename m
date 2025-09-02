Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE354414;
	Tue,  2 Sep 2025 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779711; cv=none; b=F/Rd+PP0TJuJwQXz/0wUTID1Q981RIU7K+zB8EZzSz+6NsG9s6d4U3R0/Y986utycifsD/INUzMcN3xWKSAJ/CsJexPVIyZMRNvqHmjjutE6iDkC97yKw4WZ3zOOo9SZ1NQv26V/fGZs3nnwnaYCpTVQbExXabAkgnLCCpMe5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779711; c=relaxed/simple;
	bh=QxyQmaWGUfjo1CyzoIwXOiE5z6bTP5jsQPqeFuE7b+k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bnPMVwbt6ViNaVaPB57HrrmEcLFXkSiXQPpQIRws/XhDp/MWoX+IPiAzdhNXGiQTuyMQzRvZ2uTIDb8asAHHaNVyQBa0ErZupeHEOJiBVSD0avZ53XMk5aKf4y+f/K3qGJTsfSqjB9QRS0k37nBCS1XFomPr2cwQOrlkKJsZHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPT/P+du; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPT/P+du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D9FC4CEF0;
	Tue,  2 Sep 2025 02:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756779710;
	bh=QxyQmaWGUfjo1CyzoIwXOiE5z6bTP5jsQPqeFuE7b+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPT/P+duW8tcFp+i7LVO2MJ6JAgZK7s5xGccAbSwin16/mMzRG2kZcaRNwrH+nB89
	 XWE5gL+2wqzMFI3FPOHR/EL8uzkkFvX7ZNiBeMbgzTESOjZIZFMmOTKIwyiFcH8SJm
	 glwMmdyqo2nO8hGh5L4xl4HTRZsggoNT7paQA1/B9fTlP2p9W65h3S2cIWND2Iw8yz
	 96X7zNlXdHqMZzw+M9dumiKGVRkZnxWjObb94psK9Y9dxVpZ3VX+I4qotLNT9xwUlZ
	 ijmOvQFg5jsZl2ne95aU0Nr4kgDNp9Tl5jt0PwsarcgQjQs+JlDlwfP+GSu0zR+OpC
	 FqMK/8uO7AWfw==
Date: Tue, 2 Sep 2025 11:21:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-Id: <20250902112147.165c8030837b6b21cf402fd3@kernel.org>
In-Reply-To: <20250829102050.232291-1-seokwoo.chung130@gmail.com>
References: <20250829102050.232291-1-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ryan,

Thanks for update.

On Fri, 29 Aug 2025 19:20:50 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> This v2 addresses the TODO in trace_fprobe to handle comma-separated
> symbol lists and the '!' prefix. Tokens starting with '!' are collected
> as "nofilter", and the others as "filter", then passed to
> register_fprobe() accordingly. Empty tokens are rejected and errors are
> reported with trace_probe_log_err().

OK, can you describe how it changes the syntax. You may find more things
to write it down.

For example, fprobe is not only a function entry, but also it supports
function return. How it is specified? Current "%return" suffix is introduced
for single symbol (function), like schedule%return. If we introduce a list
of symbols and filters, it looks more complicated.

For example, "!funcAB,funcC,funcA*%return" seems like the exit of funcA*,
the entry of funcC, but not covers funcAB. It is naturally misleading
users. We have to check "funcA*%return,!funcAB,funcC" pattern.

Thus, I think we should use another suffix, like ":exit" (I think the colon
does strongly separate than comma, what do you think?), or just
prohibit to use "%return" but user needs to specify "$retval" in fetcharg
to specify it is the fprobe on function exit. (this maybe more natural)

The reason why I talked about how to specify the exit point of a function
so far, is because the variables that can be accessed at the entrance
and exit are different.

Also, fprobe supports event-name autogeneration from the symbol name,
e.g. 'symbol__entry' or 'symbol__exit'. Recently I found the symbol
already supports wildcards, so sanitize it from the event name [1]

[1] https://lore.kernel.org/all/175535345114.282990.12294108192847938710.stgit@devnote2/

To use this list-style filters, we may need to reject if there is no
event name. Of cause we can generate event-name from the symbol list
but you need to sanitize non alphabet-number characters.

Ah, here is another one, symbol is used for ctx->funcname, and this is
used for querying BTF. But obviously BTF context is unusable for this
case. So we should set the ctx->funcname = NULL with listed filter.

> 
> Questions for maintainers (to confirm my understanding):
>   * Parsing location: Masami suggested doing the parsing in the parse
>     stage (e.g., via parse_symbol_and_return()). v2 keeps the logic in
>     __register_trace_fprobe(), but I can move the call into the parsing
>     path in v3 if that is the preferred place. Is that correct?

Most of above processes have been done in parse_symbol_and_return(),
thus the parsing it should be done around there.

>   * Documentation: I plan to update the user-facing docs for fprobe
>     syntax. Is Documentation/trace/ the right place (e.g., 
>     Documentation/trace/fprobetrace.rst)?

Yes, please explain it with examples.

Also, can you add a testcase (in a sparate patch) for this syntax?)

Thank you,

> 
> Link: https://lore.kernel.org/linux-trace-kernel/20250812162101.5981-1-seokwoo.chung130@gmail.com/
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>

> ---
> 
> Changes in v2:
>   * Classify '!' tokens as nofilter, others as filter; pass both to
>     register_fprobe().
>   * Reject empty tokens; log errors with trace_probe_log_*().
>   * Use __free(kfree) for temporary buffers.
>   * Keep subject and style per "Submitting patches" (tabs, wrapping).
>   * No manual dedup (leave to ftrace).
> 
>  kernel/trace/trace_fprobe.c | 48 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index b36ade43d4b3..d731d9754a39 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -815,6 +815,11 @@ static int trace_fprobe_verify_target(struct trace_fprobe *tf)
>  static int __register_trace_fprobe(struct trace_fprobe *tf)

This is not a good place to add anymore, because this change turned out
not to meet the expected prerequisites. (when I commented TODO here,
I didn't expected too.)

Anyway, this is a good opportunity to review this TODO deeper.

Thank you,

>  {
>  	int i, ret;
> +	const char *p, *q;
> +	size_t spec_len, flen = 0, nflen = 0, tlen;
> +	bool have_f = false, have_nf = false;
> +	char *filter __free(kfree) = NULL;
> +	char *nofilter __free(kfree) = NULL;
>  
>  	/* Should we need new LOCKDOWN flag for fprobe? */
>  	ret = security_locked_down(LOCKDOWN_KPROBES);
> @@ -835,8 +840,47 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  	if (trace_fprobe_is_tracepoint(tf))
>  		return __regsiter_tracepoint_fprobe(tf);
>  
> -	/* TODO: handle filter, nofilter or symbol list */
> -	return register_fprobe(&tf->fp, tf->symbol, NULL);
> +	spec_len = strlen(tf->symbol);
> +	filter = kzalloc(spec_len + 1, GFP_KERNEL);
> +	nofilter = kzalloc(spec_len + 1, GFP_KERNEL);
> +	if (!filter || !nofilter)
> +		return -ENOMEM;
> +
> +	p = tf->symbol;
> +	for (p = tf->symbol; p; p = q ? q + 1 : NULL) {
> +		q = strchr(p, ',');
> +		tlen = q ? (size_t)(q-p) : strlen(p);
> +
> +		/* reject empty token */
> +		if (!tlen) {
> +			trace_probe_log_set_index(1);
> +			trace_probe_log_err(0, BAD_TP_NAME);
> +			return -EINVAL;
> +		}
> +
> +		if (*p == '!') {
> +			if (tlen == 1) {
> +				trace_probe_log_set_index(1);
> +				trace_probe_log_err(0, BAD_TP_NAME);
> +				return -EINVAL;
> +			}
> +			if (have_nf)
> +				nofilter[nflen++] = ',';
> +			memcpy(nofilter + nflen, p + 1, tlen - 1);
> +			nflen += tlen - 1;
> +			have_nf = true;
> +		} else {
> +			if (have_f)
> +				filter[flen++] = ',';
> +			memcpy(filter + flen, p, tlen);
> +			flen += tlen;
> +			have_f = true;
> +		}
> +	}
> +
> +	return register_fprobe(&tf->fp,
> +			have_f ? filter : NULL,
> +			have_nf ? nofilter : NULL);
>  }
>  
>  /* Internal unregister function - just handle fprobe and flags */
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
