Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EE233952
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Aug 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051096; cv=none; b=M/+8JU3kA7/JBMw3q8C4XKj+j/gORGCWd3Sj/F2il9uvMND+HSVTbyWEcBZiN7jvVOfu8WPQpg7Jg0rUaMZksk03nb6cmdTD0wwPDfL26UNtBaZ0Fu0HOIyAmh1Jkp9Sf0vRJDFEmUunm4XpkzrjmqgsXiVhaDTXmJUmuoL2H+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051096; c=relaxed/simple;
	bh=zW6crNdoSe3nbWW5dWWo7jURAfz7zLhxzzJoPHkO0Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoTN8bZgcpb38VGjqsspRGbP7QBj6ml4e/1BjuSB1y2a5amMureAnCPnaZxZUa4M3FFOmOv5x0d47A3di8XZweDbgPfP7FZP7y37fJT6QAH5fyqY7jvr2bLtQKMBJVjRi/h8yAK52oVn4snk/4qytHj2X9DKIhRK89RIKYk0PEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=xeoNp/IN; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="xeoNp/IN"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7CC9D160209;
	Sun, 30 Aug 2026 00:51:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E2C3B2002E;
	Sun, 30 Aug 2026 00:51:31 +0000 (UTC)
Date: Sat, 29 Aug 2026 20:51:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Take trace_array reference before accessing
 its ftrace_ops
Message-ID: <20260829205129.21556287@robin>
In-Reply-To: <20260829025528.49A831F000E9@smtp.kernel.org>
References: <20260828223901.29e26edb@robin>
	<20260829025528.49A831F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E2C3B2002E
X-Stat-Signature: jfhosd4q6t39yd54i58nfqypxczdgjuc
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8OQ7RM4ZrJKJ5oasfvnOOD+fp9d3eKDk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=XfUPGPeY5Ofsz5f2snPBvKI87ji6KptMmOdpD1Q2RIk=; b=xeoNp/INE7uOvw9ssmwCDUBBj+uU4Gn0qcU6ErT4UOiVMKL2d5xJx8bRNk3/yf28P6jJL2WTNba+96PGOyp9eV556Mty28K6Txut1dTkA6Oyn29saC2lMWpA+IIR6i7F1PECfyDHr/cGV9fmDEf8Dm1onhoR3XLuOjLqv4zCGS8=
X-HE-Tag: 1788051091-310000
X-HE-Meta: U2FsdGVkX18hIkuW4gDuufvgW5TtUd4gnc6Wm8ZDz/AzzmfospIKTL2WwPiQJgLBWjcRoQeHP9f3ihsMqSBccb64VznSfefKMD89deXafzsOVzofhVIcD8idJlzKyyRoCP9ICNYxW5j2uzXhR1iRMj1NLW9wrH0EpNWLqYhDnRtG0u/tSXxTxi2ZgWToZRAgbi6zKTwPfkbahvDgzFW47jhRYFPm4kUie42FGneyUp1K15NH4WOda7kiG8/fEAAoljlB93QtOqUKXSnGMmq/Mf2kGTyR40l4/bV3oqON79vKZixMjqR+yQlOdsXw61gmuLAgsCaZXQssbeY7NWBUOa6bh9wVB+S+xZbhWmpHlngtDf8Z8B0YhU7RPaoX4KpktwbQAUR77WIgZMBlsFSLebf7D57q/XTReIhfj6Qt5P8=

On Sat, 29 Aug 2026 02:55:27 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] ABA problem in trace_array lookup allows a file descriptor to attach to a newly created trace instance instead of failing.
> 
> Pre-existing issues:
> - [High] If `allocate_fgraph_ops` fails in `ftrace_create_function_files`, `tr->ops` is freed but not set to `NULL`. During instance removal, this dangling pointer causes a Use-After-Free and Double Free.
> - [High] Concurrent lockless calls to `ftrace_ops_init` can lead to double `mutex_init` and list corruption.
> --
> 
> commit f37f9bc71afd70bff68b27fdd3afcdd0c07c7ae7
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> ftrace: Take trace_array reference before accessing its ftrace_ops
> 
> The trace instance files set_ftrace_filter and set_ftrace_notrace was
> updated to work with specific trace instances (trace_arrays). This patch
> changes the files to pass the trace_array as the file private data,
> allowing the trace_array reference to be incremented before touching
> the ftrace_ops.
> 
> Fixes: 591dffdade9f0 ("ftrace: Allow for function tracing instance to filter functions")
> Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f9d80c7bd9f16..c7cf36f2dd7be 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c  
> [ ... ]
> > @@ -4691,26 +4692,45 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)  
> [ ... ]
> >  int
> > -ftrace_regex_open(struct ftrace_ops *ops, int flag,
> > +ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int flag,
> >  		  struct inode *inode, struct file *file)
> >  {  
> [ ... ]
> > +	if (!ops)
> > +		ops = tr->ops;
> > +
> > +	if (WARN_ON_ONCE(!ops))
> > +		goto out;
> > +
> > +	ftrace_ops_init(ops);  
> 
> [Severity: High]
> This is a pre-existing issue, but can concurrent lockless calls to
> ftrace_ops_init() lead to double mutex initialization?
> 
> In ftrace_regex_open(), this function is called locklessly in the VFS open
> path. Inside ftrace_ops_init(), it checks if the initialized flag is set:
> 
> kernel/trace/ftrace.c:ftrace_ops_init() {
>     if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
>         mutex_init(&ops->local_hash.regex_lock);
>         INIT_LIST_HEAD(&ops->subop_list);
>         ops->func_hash = &ops->local_hash;
>         ops->flags |= FTRACE_OPS_FL_INITIALIZED;
>     }
> }
> 
> If multiple threads concurrently open the filter file on a newly created
> trace instance, both could observe the flag as unset.
> 
> Could one thread lock the newly initialized mutex just as the second thread
> calls mutex_init() on it, potentially corrupting the mutex wait list?

Hmm, yeah this probably needs some locking to synchronize.

> 
> [ ... ]
> > @@ -4788,21 +4808,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
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
> 
> [Severity: High]
> Does this lockless trace_array pointer retrieval introduce an ABA problem?
> 
> If a thread pauses after reading tr from inode->i_private, a concurrent
> instance removal could free the original trace_array. If a subsequent mkdir
> allocates a new trace instance at the exact same memory address, the paused
> thread would resume with the old address.
> 
> When ftrace_regex_open() calls tracing_check_open_get_tr(tr), it ultimately
> validates the pointer in trace_array_get() by comparing the raw pointer
> against the global list:
> 
> kernel/trace/trace.c:trace_array_get() {
>     ...
>     list_for_each_entry(this_tr, &ftrace_trace_arrays, list) {
>         if (tr == this_tr) {
>             return __trace_array_get(tr);
>         }
>     }
> }
> 
> Because the new instance was allocated at the same address, this comparison
> would succeed, incorrectly attaching the file descriptor to the new trace
> instance. 
> 
> Could this lead to cross-instance state corruption?

The would at most open the wrong file in the new instance that was
meant for the old instance. It may confuse the administrator doing the
open, but if they are also deleting and creating instances (which are
very big operations that do a lot) and opening one of the files that
they are deleting, then we know they are likely already confused!

As long as it doesn't crash the kernel, this side effect is an issue
for the administrator to not do stupid things or they may get stupid
results.


> 
> >  }  
> [ ... ]
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index cd37f20137581..c879d43a5fbb2 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -101,7 +101,7 @@ int ftrace_create_function_files(struct trace_array *tr,
> >  		return ret;
> >  	}
> >  
> > -	ftrace_create_filter_files(tr->ops, parent);
> > +	ftrace_create_filter_files(tr, parent);
> >  
> >  	return 0;
> >  }  
> 
> [Severity: High]
> This is a pre-existing issue, but does a failure in allocate_fgraph_ops()
> leave a dangling tr->ops pointer?
> 
> Just above this hunk in ftrace_create_function_files(), if
> allocate_fgraph_ops() fails, it frees tr->ops but doesn't set it to NULL:
> 
> kernel/trace/trace_functions.c:ftrace_create_function_files() {
>     ret = allocate_fgraph_ops(tr, tr->ops);
>     if (ret) {
>         kfree(tr->ops);
>         return ret;
>     }
> }
> 
> Since tracefs setup ignores the error, the instance creation succeeds but
> leaves a dangling pointer inside the active trace_array.
> 
> Later, when the instance is removed, ftrace_destroy_function_files() will call
> ftrace_destroy_filter_files(tr->ops) and ftrace_free_ftrace_ops(tr), which might
> result in a use-after-free and a double free. 
> 
> Should tr->ops be set to NULL after kfree(tr->ops)?
> 

Probably, will investigate.

-- Steve

