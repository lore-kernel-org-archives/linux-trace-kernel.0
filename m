Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7C1D6195;
	Tue, 11 Feb 2025 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238087; cv=none; b=D13IFI7Gw5U2amnVFMlniHIhBWVYLItH8lRyQbUfM37VESf/pawaPCni13Qfppry/7zmfmV4T6YoLHFLNG3J0ZQ0IMqjS3dg/AdV6rSXS1StambF8AyVmsQNvIxWneBWllEL0cMSztk77gGU27R3j6lnHns6YBql8cbopdMZveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238087; c=relaxed/simple;
	bh=pqoGaAJx1GqNGI4EQRoyPK7A6Uqa3T4oEOHRZVKX2fw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LpirjA7DRcVfJPHyugvURMYPhKxQ9STj701HCzJj7tIUYc7pNdDERqjkFBYqcf+w8ocI3c5IcCfBx4yqEl8Wcnrq4Munhsx1LfCpRLu8KmT5ACtXd+no7GhpSElmrgU5yT2iOji6NA9Uetzipx/8AKiPmaHr8/yUJ/BZZeFAvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKynmWI0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKynmWI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D1BC4CED1;
	Tue, 11 Feb 2025 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739238086;
	bh=pqoGaAJx1GqNGI4EQRoyPK7A6Uqa3T4oEOHRZVKX2fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKynmWI02rkQjaFqI1iWsapxgGFIeJG3FpbRvu9FZ2li80XWUntdohFe26jlsRZum
	 ybZ11kfTmtIHy/IJGxCuGTSqKHZiWIPmlDy/le73a89Y4Zzu8kxB84MSPjplHVvV5D
	 GTW2xfvGLJkBmdeU1vKTDQuZCsF4+Ol5zx7wPLmv7cdl0FwKglf77HOdCS+5CUW/g2
	 ZUQEjL41pQDTu00KXOA8T/ixRKxsu7O3kD/be/ovvNyubibPoa5aeFVzaorlqAXdgT
	 o87MCpi30VuCUyOKfGARLWFOMJtUKyo+ssC+pvPwAA53qU3csb/C+iZKD1mEDpPCMc
	 r9VcnOFjGmRmw==
Date: Tue, 11 Feb 2025 10:41:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] tracing: Freeable reserved ring buffer
Message-Id: <20250211104122.8ce39b7d4be222318d6c010b@kernel.org>
In-Reply-To: <20250210191350.79dfa2a2@gandalf.local.home>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920225773.826592.6428338529686044470.stgit@devnote2>
	<20250210191350.79dfa2a2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 19:13:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Feb 2025 00:44:17 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -9857,8 +9861,10 @@ static int __remove_instance(struct trace_array *tr)
> >  	int i;
> >  
> >  	/* Reference counter for a newly created trace array = 1. */
> > -	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
> > +	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref)) {
> > +		pr_info("Instance is busy: ref %d trace_ref %d\n", tr->ref, tr->trace_ref);
> 
> I don't think we need the print. The function will error with -EBUSY
> letting the user know that it is busy. This is a very common error, where I
> found that I had a program that didn't completely die, and still had a file
> descriptor open on an instance, and when I go to remove it, I get:
> 
>   # cd /sys/kernel/tracing/
>   # mkdir instances/foo
>   # bash 5< instances/foo/events/enable
>   # rmdir instances/foo
>   rmdir: failed to remove 'instances/foo': Device or resource busy
>   # exit
>   # rmdir instances/foo
>   #
> 
> If you only have it for debugging that is fine, but we should remove it
> before we accept it.

Oops, that is my debug code. I missed to remove that! Sorry for confusion.

Thank you!

> 
> -- Steve
> 
> >  		return -EBUSY;
> > +	}
> >  
> >  	list_del(&tr->list);
> >  
> > @@ -9881,6 +9887,11 @@ static int __remove_instance(struct trace_array *tr)
> >  	free_trace_buffers(tr);
> >  	clear_tracing_err_log(tr);
> >  
> > +	if (tr->range_name) {
> > +		reserved_mem_release_by_name(tr->range_name);
> > +		kfree(tr->range_name);
> > +	}
> > +
> >  	for (i = 0; i < tr->nr_topts; i++) {
> >  		kfree(tr->topts[i].topts);
> >  	}
> > @@ -10740,6 +10751,7 @@ __init static void enable_instances(void)
> >  		bool traceoff = false;
> >  		char *flag_delim;
> >  		char *addr_delim;
> > +		char *rname __free(kfree) = NULL;
> >  
> >  		tok = strsep(&curr_str, ",");
> >  
> > @@ -10796,6 +10808,7 @@ __init static void enable_instances(void)
> >  				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
> >  				continue;
> >  			}
> > +			rname = kstrdup(tok, GFP_KERNEL);
> >  		}
> >  
> >  		if (start) {
> > @@ -10832,7 +10845,7 @@ __init static void enable_instances(void)
> >  		 */
> >  		if (start) {
> >  			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
> > -			tr->ref++;
> > +			tr->range_name = no_free_ptr(rname);
> >  		}
> >  
> >  		while ((tok = strsep(&curr_str, ","))) {
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 47c0742fe9ec..ae8f7fac6592 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -348,6 +348,7 @@ struct trace_array {
> >  	unsigned int		mapped;
> >  	unsigned long		range_addr_start;
> >  	unsigned long		range_addr_size;
> > +	char			*range_name;
> >  	long			text_delta;
> >  	int			nr_modules;
> >  	long			*module_delta;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
