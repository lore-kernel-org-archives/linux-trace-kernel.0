Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD9282F30
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Aug 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787970162; cv=none; b=RFz9rLGb+zvqTlaofLnTy+zieCXHf7yqIN1RSe9Fu29F16jp3r0JjdF4+rOAEwGvsf0Y/aKwOy+Td9q42lDsJasIAaVLc1YMCtaPid++Ofxvn1mAFW80qNX22w7tou1kauJmnBdvP7PBFQiYHxWUBPoBKG7aNg8hzhP4BYDPteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787970162; c=relaxed/simple;
	bh=s504lxEEUZRzNXYux2p22nJfD/fcE/FmGhlV4SPBzcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY32Ax0/Hs4pKgiA2PuXpM9V4te/fWntciQnwePIppv4F0+4YGylVJ8kat4nv1JhSThgHEj0uKvVJrrVMKENu5hzDezBiJ5eRrynp0E+oGAPU8kydtJZFPrnskyPMoZtwqEw7ZLvgEL5X47dx4fTEpI60nta2EJDUxqmD/UwCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Oa94HXbJ; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Oa94HXbJ"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C79BEA4057;
	Sat, 29 Aug 2026 02:22:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 263E620025;
	Sat, 29 Aug 2026 02:22:37 +0000 (UTC)
Date: Fri, 28 Aug 2026 22:22:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Take trace_array reference before accessing its
 ftrace_ops
Message-ID: <20260828222235.2e7fa4ea@robin>
In-Reply-To: <20260828201309.C18721F000E9@smtp.kernel.org>
References: <20260828155942.445f46e5@gandalf.local.home>
	<20260828201309.C18721F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 263E620025
X-Stat-Signature: cjm5f5s7f65wrseqodyzxxpn7mqj4q34
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18RucX7gAoP9UT78D9xjVfgrzgOVDGeH60=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=i70ZZQ9wNtXaGHZ/pPNurWclMZq3km52EkKnZqyvXZ0=; b=Oa94HXbJ/FtfOtmpilore1sM6q/qYmI/dGj/rmq8zUNR6OKNNOT6y76tvpFB43yApNuX2Hx7XuJYi1JeIHRXG7SX6HE3GZZTR2AJlH073mUtE6v5AEA6jpuP4vvtGjIJ+iNFT1cWBPdmydE1YiN6YJ/E6vwz9M8k26hbQN7GKAg=
X-HE-Tag: 1787970157-489918
X-HE-Meta: U2FsdGVkX18FrkBxVnytH8swnQ+Z+8PfzLqFKI4IMMvNl/ni2DdCAST7Mv9VCJnm6MoJDnUthMYAv7ffeeJfmOnqYNyCYY0tYfq57KzCfyKCCe+Q6ZUrYOPTDbrKWuz1hU6vVuwF0E4kvjA16cjGLXp4RAdP8L37gzMLFKB33u7Rn8hTNF1JDnAWYzmuBetyCzo9RyAN5OQJMv+YuJr99xkkfswEEELxD/iicu/6YgMVTnNxrS/yKpoR9L7oeGG0Bzqmy0S/mnPqyiiHP0g5jGufIIk+xMcY3oaYFSRNW5GKu7YGgVZNkjDY5VMHnkJloPd4V3T79u3/WNJWsbPIKcHUuP3YyLY/xHlI9RfmdBHqPbpbu6B+ITGSKJIqLU26xFEQdpwanUEifSBrijTNao+Q8icuFC9YAUQwSgU70Xc=

On Fri, 28 Aug 2026 20:13:09 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Tracefs lockdown and tracing_disabled checks are bypassed for the global ftrace instance and stack tracer.
> - [High] Module and probe filters for the global ftrace instance cannot be cleared or read.
> --
> 
> commit 42c008f904dcd516dc1681a548fae6a4bba9a162
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> ftrace: Take trace_array reference before accessing its ftrace_ops
> 
> The trace instance files set_ftrace_filter and set_ftrace_notrace are
> updated to work with specific trace instances (trace_arrays). This
> patch passes the trace_array as the file private data to allow incrementing
> its reference before touching the ftrace_ops, preventing a use-after-free.
> 
> Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f9d80c7bd9f16..4babd86c7be00 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c  
> 
> [ ... ]
> 
> >  int
> > -ftrace_regex_open(struct ftrace_ops *ops, int flag,
> > +ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
> >  		  struct inode *inode, struct file *file)
> >  {
> > -	struct ftrace_iterator *iter;
> > +	struct ftrace_iterator *iter = NULL;
> >  	struct ftrace_hash *hash;
> >  	struct list_head *mod_head;
> > -	struct trace_array *tr = ops->private;
> > -	int ret = -ENOMEM;
> > -
> > -	ftrace_ops_init(ops);
> > +	int ret = -ENODEV;
> >  
> >  	if (unlikely(ftrace_disabled))
> >  		return -ENODEV;
> >  
> > -	if (tracing_check_open_get_tr(tr))
> > +	if (tr && tracing_check_open_get_tr(tr))
> >  		return -ENODEV;  
> 
> [Severity: Critical]
> By adding the `tr &&` short-circuit here, does this cause a regression
> where tracefs lockdown and tracing_disabled checks are bypassed for the
> global ftrace instance and the stack tracer?
> 
> Since `tr` is explicitly passed as `NULL` for these instances,
> `tracing_check_open_get_tr(NULL)` is never called.

Yeah, right after sending this I noticed that the if statement isn't needed.

> 
> [ ... ]
> 
> > @@ -4788,21 +4801,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
> >  static int
> >  ftrace_filter_open(struct inode *inode, struct file *file)
> >  {
> > -	struct ftrace_ops *ops = inode->i_private;
> > +	struct trace_array *tr = inode->i_private;
> >  
> > -	/* Checks for tracefs lockdown */
> > -	return ftrace_regex_open(ops,
> > -			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> > -			inode, file);
> > +	return ftrace_regex_open(tr, NULL,
> > +				 FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> > +				 inode, file);
> >  }  
> 
> [Severity: High]
> For the global ftrace instance, `tr` is `NULL`. Does passing `NULL` for `tr`
> break the module and probe filters?
> 
> In `ftrace_regex_open()`, the `mod_head` pointer is initialized like this:
> 
>     mod_head = tr ? &tr->mod_trace : NULL;
> 
> Because `tr` is `NULL`, `mod_head` will also be `NULL`. When opening the
> file with `O_TRUNC`, `clear_ftrace_mod_list(mod_head)` will do nothing,
> failing to clear the module filters.
> 
> Additionally, `iter->tr` is set to `NULL`. When reading the file,
> `t_mod_start()` relies on `iter->tr` and will return early:
> 
>     /* probes are only available if tr is set */
>     if (!iter->tr)
>         return NULL;
> 
> Could this skip the enumeration of active module and probe filters for the
> global instance entirely?

Hmm, yeah.

I guess I need to add a:

perhaps I need to add at the start:

	if (!tr && ops)
		tr = ops->private;

> 
> [ ... ]
> 
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 0aa2514a6593b..e7f4e523587d0 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -499,7 +499,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
> >  	struct ftrace_ops *ops = inode->i_private;
> >  
> >  	/* Checks for tracefs lockdown */
> > -	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
> > +	return ftrace_regex_open(NULL, ops, FTRACE_ITER_FILTER,
> >  				 inode, file);
> >  }  
> 
> [Severity: Critical]
> The stack tracer explicitly passes `NULL` for the trace array. Due to the
> short-circuit mentioned earlier, doesn't this also bypass the lockdown
> check documented in the comment right above this call?
> 

Yes, and I mentioned at the start I need to remove the if statement.

-- Steve

