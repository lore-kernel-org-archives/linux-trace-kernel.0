Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D617D372;
	Tue, 11 Jun 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115144; cv=none; b=Mf8eI2aXGRBJSG22oUym2j2p+0laRBWKwds4p3XRLN5P9WxA6X6I65jc/5/I1vt0BBn6U0uu7iQea303zM0wMownMDRfhJFS2rbWcrJbQbqgSdp2Gzo2oO5Ws1n4Ybcyjs01vGjRWwVvfdhg8iuMHPPwYraNe6HH1DW2aCU/9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115144; c=relaxed/simple;
	bh=YY724BGhiyIEaylXd+UnLjm1nNWqWKv7YVra5OWy9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXUkUe9FaZwQCHt0/WU0G6Ee6I80yuh9KRzcefGv9lu8Bh4GhDpY2s7tc3qIAZPo29lm8fmFO2Vtmf0MXW/CedsuBE1tEfj2p/WGB0o2CQQ/pGY+PEf88pAPvcXY6RF0Ab5oe/QddvuolH3tDiyJVSbrBnyuQqRqEMgnWndVUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305C9C2BD10;
	Tue, 11 Jun 2024 14:12:23 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:12:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney"
 <paulmck@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>, Thorsten Leemhuis
 <linux@leemhuis.info>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240611101238.6db5e4a7@gandalf.local.home>
In-Reply-To: <2024061143-transfer-jalapeno-afa0@gregkh>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
	<20240610112223.151faf65@rorschach.local.home>
	<b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
	<20240610163606.069d552a@gandalf.local.home>
	<70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
	<2024061143-transfer-jalapeno-afa0@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 08:23:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > Depends-on: c9929f0e344a ("mm/slob: remove CONFIG_SLOB")  
> 
> Ick, no, use the documented way of handling this as described in the
> stable kernel rules file.

You mentioned this before, I guess you mean this:

> To send additional instructions to the stable team, use a shell-style inline
> comment to pass arbitrary or predefined notes:
> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>     Cc: <stable@vger.kernel.org> # 3.3.x
>     Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>   The tag sequence has the meaning of::
> 
>     git cherry-pick a1f84a3
>     git cherry-pick 1b9508f
>     git cherry-pick fd21073
>     git cherry-pick <this commit>
> 
>   Note that for a patch series, you do not have to list as prerequisites the
>   patches present in the series itself. For example, if you have the following
>   patch series::
> 
>     patch1
>     patch2
> 
>   where patch2 depends on patch1, you do not have to list patch1 as
>   prerequisite of patch2 if you have already marked patch1 for stable
>   inclusion.

What's with the "3.3.x"? Isn't that obsolete? And honestly, I find the
above much more "ick" than "Depends-on:". That's because I like to read
human readable tags and not machine processing tags. I'm a human, not a machine.

-- Steve
