Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B326FA6C;
	Wed, 24 Sep 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701461; cv=none; b=DcpkR/s+CUKCkexAbelnV3HCo+wVRLSBEIi5BZaGlvGyWEna3te3J8CnMXKkRKiGmFYZqBolcnh1tBoWa71OXCTgQ6tBVJ38udysQ/5hMS7Tx6b5lQIXI9HTU5gE+L2F8eNNFn9AiLvb1LKE/sIScTgoplMghGTEbxa0maf6zQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701461; c=relaxed/simple;
	bh=9Yx+MZchk7/8QcG+vzwjqY3qVz98jSv+VdQO8B2eL2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ve8egpOP3xR5CRRwteoiMpHsOkBqM1gU/GuPYlVScQY+KmkyXZULtyjfQBWRL/dkEye1/uUXE6Pyf6L+VYHaV4kSLVy7Y57uISqvM66gZ36MzGISwZkFAH84Yp3M6JZwj3JwnOWb1JKTNKqq2ZrcNh5q6iMHje/MWGhAwkzoQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBFZ/NBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBFZ/NBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC240C4CEE7;
	Wed, 24 Sep 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758701460;
	bh=9Yx+MZchk7/8QcG+vzwjqY3qVz98jSv+VdQO8B2eL2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBFZ/NBRjdxQy2EwsIewu0B8ph1KCcHYKDZ80cl3Jm7Y7WQusfucbA3b8n+AG8kSQ
	 qVUM8oQD4Antn6qGsPh00o/Att2cq/JEJ++iJOuuPXur97dIz6LTQYJtmBYJmEI9Uo
	 kcLfaEBhO3p5Bfi5WQaI7k9wSgniTg8i1iGE0YlRt8q75oON0GR9n0DSC/oCY6czMN
	 zwp0EK0c+8A6mQp98mLcFQMyok1SWce8ub9UDW0+hgiWGrFWi0pydZYae9Jxet+pXV
	 spnGjq9CotFxRh7rkU8iv5sqKjs2xTj7kh1GK4Ha2hUMV0iT/yjhU4Y1dBxTT/KMMx
	 wFtdavNQrN0nw==
Date: Wed, 24 Sep 2025 17:10:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: menglong.dong@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: Fix to remove recorded module
 addresses from filter
Message-Id: <20250924171058.15fe8364253fb8c42d5f0197@kernel.org>
In-Reply-To: <9510801.CDJkKcVGEf@7940hx>
References: <175867358989.600222.6175459620045800878.stgit@devnote2>
	<175867359903.600222.10400702167171128567.stgit@devnote2>
	<9510801.CDJkKcVGEf@7940hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 11:49:39 +0800
menglong.dong@linux.dev wrote:

> On 2025/9/24 08:26 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Even if there is a memory allocation failure in fprobe_addr_list_add(),
> > there is a partial list of module addresses. So remove the recorded
> > addresses from filter if exists.
> > This also removes the redundant ret local variable.
> > 
> > Fixes: a3dc2983ca7b ("tracing: fprobe: Cleanup fprobe hash when module unloading")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Hi, Masami. Should I send the V2 of the patch:
> 
>   tracing: fprobe: optimization for entry only case
> 
> after this series applied?

Yeah, I'll push this [2/2] to stable tonight. and
push [1/2] to probes/for-next too. I'll rebase probes/for-next
so that it will have both patch.

Thank you,

> 
> Thanks!
> Menglong Dong
> 
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 12ec194fdfed..95e43814b85b 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -434,8 +434,9 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
> >  {
> >  	unsigned long *addrs;
> >  
> > -	if (alist->index >= alist->size)
> > -		return -ENOMEM;
> > +	/* Previously we failed to expand the list. */
> > +	if (alist->index == alist->size)
> > +		return -ENOSPC;
> >  
> >  	alist->addrs[alist->index++] = addr;
> >  	if (alist->index < alist->size)
> > @@ -497,7 +498,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	} while (node == ERR_PTR(-EAGAIN));
> >  	rhashtable_walk_exit(&iter);
> >  
> > -	if (alist.index < alist.size && alist.index > 0)
> > +	if (alist.index > 0)
> >  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> >  				      alist.addrs, alist.index, 1, 0);
> >  	mutex_unlock(&fprobe_mutex);
> > 
> > 
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
