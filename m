Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C41E7660;
	Mon, 28 Sep 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598175; cv=none; b=JdCAUwV91YKcGVvylEFpQdrgoc5F5CPAvH96A0QQA/1SyWGWYTWMzcLOseQwfhWBxGJt8ZiusWdVRnEov/yqebPNTIjR0oehyChc+ppkXajnxwI/mmxlF+hq6pQglCHgzN8uV17Tkibp1C6zGp5Pl7azeihjvcDLV/5ilhV3PIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598175; c=relaxed/simple;
	bh=oERatHrNyti65M0Q6PWz9JbXSiUntq66rbkX4KZmZTg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IdeDECooACXn0pVnWY9Tf6v6xbCOwkTdfEAMIkzvdGYhdTz0ZBF1BJAUn4G3+KMLY91O4lE9MYEm9NfVOruv2F78XUU2NZR84u4A810slU1GRzbY+ADtQllzODOBV1YkM3XYr/fAcgdY819uC1azE3UsozHijM36zR3tbntHaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbcyLi8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbcyLi8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641AB1F000FF;
	Mon, 28 Sep 2026 12:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598174;
	bh=ztLdZryxXo0UnEDHRAaJoKaaXxKgEfERrJosCd2p1Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nbcyLi8/vG/vKchA/PAhaI+POjW5sxfK5ooSAdb2FiyJ2WD3i2gqANIsSHwAbNokt
	 4xsOzQDc+rGLGmxK6hRXpxcce5tgEmh+yzNwVIvCDfAN5LDBpu+SgYJ8owNC+Voi1t
	 OpT15iIbbCB9KwBFNEz2wS5qdaV+Mx7WHbhl0DtigqL/FUWH0n9jycdVe7FFzbsNFo
	 F4LeG5Rih0HB7S8j8b3h7JomTPxdKiggCAtHaznP+jEKXvxRhdMhwNBrVC30L71Myh
	 uyLyuuaRVgPCROq00Vkd9jcC8yDnYtcmmkr9rN4Z5T2CbReQe09cqu2SPpfOzXVI1x
	 LK75c6UDKwTOQ==
Date: Mon, 28 Sep 2026 21:22:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Message-Id: <20260928212251.58fa1f68f33d4c967a8e8b1c@kernel.org>
In-Reply-To: <20260928005114.9C9FC1F000FF@smtp.kernel.org>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
	<179055575973.241711.6618845269004184577.stgit@devnote2>
	<20260928005114.9C9FC1F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 00:51:14 +0000
sashiko-bot@kernel.org wrote:

> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 1e9b00997ff27..e34c3f7667848 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -656,7 +656,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
> >  	size_words = SIZE_IN_LONG(size);
> >  	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
> >  
> > -	preempt_disable_notrace();
> > +	guard(rcu)();
> 
> [Severity: High]
> Since ftrace operations lacking the FTRACE_OPS_FL_RCU flag can execute in
> idle contexts where RCU is not watching, does adding guard(rcu)() here
> trigger an illegal RCU lock usage splat?

Hm, OK. Maybe we need to add something like checking rcu_watching, but
FTRACE_OPS_FL_RCU does not work correctly because fgraph_init_ops() only
configures subops (gops->ops). ftrace_startup_subops() does not propagete
that flag to graph_ops. (I guess that is yet another problem?)

To guarantee no illegal RCU usage or lockdep splats if an instrumented
function returns while RCU is offline, we can check 

 if (unlikely(!rcu_is_watching()))
	return;

before acquiring guard(rcu)().

> 
> Additionally, since RCU doesn't track read-side critical sections that
> start when RCU isn't watching, does this mean synchronize_rcu() during
> unregistration will fail to wait for these handlers, leaving the fprobe
> vulnerable to the same use-after-free this patch attempts to fix?

As I said above, if we add the rcu_is_watching() checks, we can avoid
this issue.


> 
> [ ... ]
> 
> 
> Looking at fprobe_fgraph_entry() in the same file:
> 
> kernel/trace/fprobe.c:fprobe_fgraph_entry() {
>     ...
> 	if (WARN_ON_ONCE(!fregs))
> 		return 0;
> 
> 	guard(rcu)();
> 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>     ...
> }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but fprobe_fgraph_entry() also
> uses guard(rcu)(). Could this pre-existing usage cause the same lockdep
> splats in idle contexts?

Yeah, so we also need !rcu_is_watching() check. BTW for x86-64, it seems
those call path are removed from ftrace by objtool.

> 
> 
> Looking at how fgraph operations are initialized:
> 
> kernel/trace/fgraph.c:fgraph_init_ops() {
> 	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
> 
> #ifdef CONFIG_DYNAMIC_FTRACE
>     ...
> }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the lack of
> FTRACE_OPS_FL_RCU in these global fgraph operations expose all fgraph
> users to execution when RCU is not watching? Should this flag be added
> here to prevent tracing callbacks from being invoked in contexts where
> RCU is offline?

Yeah, but the fgraph_ops in fprobe becomes a subops, whose flags
are ignored. So fprobe needs to check the rcu_is_watching() by
itself.

Let me update it.

However, I think this is fundamentally unneeded check if we replace
guard(rcu)() with preempt-disabled.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
