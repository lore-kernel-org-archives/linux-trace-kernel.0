Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387334B1B0;
	Wed, 20 May 2026 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309663; cv=none; b=QHb2gXAxmx2u2qROn00Q/juoh4bkJGPqGdDmtZVmdbvcZ+toGHLPuLn8Gg1G/Z7x4njvDy29sM57HyyoN/EL+2rwKAQm6FE7+hXriEsdVLCXpG7/vlmRw2jEa4feD/YKmdMP5mC4+WZipH+oU3Wh5ToU3TuUJLyV+J8NHpBYWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309663; c=relaxed/simple;
	bh=e8hBwUdu6IUIkQnM53luWZUskzWpx2vPNF31m2ELzm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEkto/n/oWXpFnO4nwV3PqZBECV4Ceflr+eerjKa5XXNLPReFfSxg47zgaQ+B0Jxc2+UXKW7dD8ragpQvuL0P2MB1iGSxOfAioykp2idy6w6S4JanAyVbn/SMZ5xte57CQbg8FVmndbKKu3BR9OZfeUoHe5jebPe4BsziH4IeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1B1738B2A3;
	Wed, 20 May 2026 20:41:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 162152000E;
	Wed, 20 May 2026 20:40:58 +0000 (UTC)
Date: Wed, 20 May 2026 16:41:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rik van Riel <riel@surriel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260520164117.528d02fd@gandalf.local.home>
In-Reply-To: <20260513161916.04151502@fangorn>
References: <20260513161916.04151502@fangorn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 162152000E
X-Stat-Signature: cw1yu3hkzrqgrj5o9ugqcoyiq7oc4h3g
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+i+mG5U4QYO7VLONAOmDKyL25xgdLB6Ks=
X-HE-Tag: 1779309658-783929
X-HE-Meta: U2FsdGVkX193eHLBnNiiJKN3W1z0UcutCxScYbrJlhOQcJaAasmFkoI5jpMbdmgdxt84uj/wHoAQ/Dpn/HTdnGbWUrMhlqG/v7F0HOInZ8kA0dFQntexGZcNBEY/ZVEbzPo/O7gOg15BNFq8OMdmSfJoOOuPSbIy4oyKeEIQVe6bXKTA9lUFk19EKL2X1b2LuiVyfCa6+9y2GObNLPMxZpszuaXDiGdFLhRJC2tET+lDuJ2Eg9n9aSDgbhAwhfn/BdmeRT3QiB/ukuCCPPmm5muYW2pFQUR7u1oTjRJ1Df6HdC4jcPRa4y/JJ1SBEUY1jw2SwPzxjCJTOal6UZdLJtaGKlgX86yItoN0wdwBEF8822b/Z1LLmYVl6LsOv+X+zgaZYWhoOdMLuevNC7TUwG7DgXpgVORjcZ/pEBTX6sw0vh22uoN9pIBKnbdZuFgS3o0ul1GXKLvTGviu93f3oA==


Rik,

Can you reply to Sashiko here?

The below comes from Sashiko: https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260513161916.04151502%40fangorn

Thanks,

-- Steve


> commit f90ac36f39b79a19c015522bb1caf7ef903caf02
> Author: Rik van Riel <riel@surriel.com>
> perf/ftrace: Fix WARNING in __unregister_ftrace_function
> This commit attempts to fix a WARN_ON triggered during perf_event_alloc() error
> cleanup by checking FTRACE_OPS_FL_ENABLED before unregistering the ftrace
> function. The warning occurs because the ftrace_ops registration failed or was
> torn down by perf_try_init_event() earlier, but the event->destroy callback is
> executed again during the error path.
> > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > index 61e3a2620fa3c..8d64f17135e8f 100644
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -495,7 +495,11 @@ static int perf_ftrace_function_register(struct perf_event *event)
> >  static int perf_ftrace_function_unregister(struct perf_event *event)
> >  {
> >  	struct ftrace_ops *ops = &event->ftrace_ops;
> > -	int ret = unregister_ftrace_function(ops);
> > +	int ret = 0;
> > +
> > +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> > +		ret = unregister_ftrace_function(ops);
> > +
> >  	ftrace_free_filter(ops);

> Does calling ftrace_free_filter() unconditionally here mask a double-teardown
> regression while leaving the underlying double-free active?
> In perf_try_init_event(), if a PMU event_init() succeeds but a subsequent
> capability check fails, it explicitly calls event->destroy(event) to roll back:
> kernel/events/core.c:perf_try_init_event() {
>     ...
> 		if (ret && event->destroy)
> 			event->destroy(event);
>     ...
> }
> However, it does not set event->destroy to NULL.
> When the event is later freed in error paths, the stale event->destroy callback
> executes a second time.
> If ftrace_free_filter() is called twice, won't it result in a direct
> double-free of ops->func_hash->filter_hash, since ftrace_free_filter() frees
> the hash but does not nullify the pointers?
> Additionally, for regular tracepoint events, wouldn't the second teardown
> execute perf_trace_event_unreg() again?
> This could double-decrement total_ref_count, potentially freeing the shared
> perf_trace_buf while other events are active, and trigger an unbalanced
> module_put() leading to module refcount underflows.
> Should the root cause be addressed by setting event->destroy = NULL in
> perf_try_init_event() immediately after invoking it?

> >  	return ret;
> >  }

