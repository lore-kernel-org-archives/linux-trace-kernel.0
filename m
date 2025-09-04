Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AA4437A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957079; cv=none; b=HGUz0mBk3ZdO5JYJt50eriRyfEQw3wTDVrP58QDyZd5mjMTHy2jTHV4CAwEJo/mqzvaaJdjTFoSeakJsg0ZinN2Sj2vB7ZRpEaUqrNm6CiEHc/IXFaOc8a9+D473zuqKL+Y2m6/sg3sYQ8jffT4uYp0qxW4yA0LkoEZkeDRR6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957079; c=relaxed/simple;
	bh=hBwYozockqqVFeG3isbfTlqiBxmmCOIrE2mdOE8PV+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxBmXbKga8knjs+afW3z6yv/e5iaF3ZoBEW3//UUmhy7bIA7HQJrqB68309SWMp/3lXpfDUuj50PTqws1F+dF6o5xCTZU+uPdyTRpxmbzhHrm7NFfDDnwAlY8GZCmjVSxRxeAd9+H/aPgI3yv3pnQxAy7538g5h86UW5IzUujYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EJ6S9uxb; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EJ6S9uxb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756957074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VYgcMypKQyiJTb5epJ2wT0CRJ6kGs1S6S5ooT5LxyA=;
	b=EJ6S9uxbhTajDlr+P1gRDzWhS7ofsW0bZeEW8xJ8x5H8gGw+Fv2THfS0GQB/5c7bqpzPv3
	3mkZohbfxsfvPCCNFFZEX788qTFsuVwFbhRucXhVubQAV3NoXC/569AjoF5F3zWIM94nC5
	U3J35RCwERWndBVxU8eYiFqQZr2pKG4=
From: Menglong Dong <menglong.dong@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Thu, 04 Sep 2025 11:37:35 +0800
Message-ID: <5038598.31r3eYUQgx@7940hx>
In-Reply-To: <aLfCa1FkLc3T4QI3@gondor.apana.org.au>
References:
 <aLa2D4It1Zxc7bs0@gondor.apana.org.au> <3005966.e9J7NaK4W3@7940hx>
 <aLfCa1FkLc3T4QI3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/3 12:22 Herbert Xu <herbert@gondor.apana.org.au> write:
> On Tue, Sep 02, 2025 at 05:50:32PM +0800, menglong.dong@linux.dev wrote:
> > On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> > > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > > >
> > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > index fb127fa95f21..fece0f849c1c 100644
> > > > --- a/kernel/trace/fprobe.c
> > > > +++ b/kernel/trace/fprobe.c
> > > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > > >        if (WARN_ON_ONCE(!fregs))
> > > >                return 0;
> > > > 
> > > > +       rcu_read_lock();
> > > >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > > +       rcu_read_unlock();
> > > >        reserved_words = 0;
> > > >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > > >                if (node->addr != func)
> > > 
> > > Actually this isn't quite right.  I know that it is a false-positive
> > > so that it's actually safe, but if you're going to mark it with
> > > rcu_read_lock, it should cover both the lookup as well as the
> > > dereference which happens in the loop rhl_for_each_entry_rcu.
> > 
> > Yeah, I understand. The rcu_read_lock() here is totally used to
> > suppress the suspicious rcu usage warning, not for the protection.
> > So I used it just for the rhltable_lookup() to reduce the impact.
> > Maybe I should add some comment for it.
> 
> My point is that after a lookup you will be doing some sort of a
> dereference on the RCU pointer.  That would cause exactly the same
> splat that rhltable_lookup itself generated.
> 
> For example, rhl_for_each_entry_rcu should have created the same
> warning, but it doesn't because for some reason it is using
> rcu_dereference_raw.  I'll need to dig up the history of this
> to see if there is a good reason for it to not warn.

Yeah, I understand what you mean. I noticed this, and that's why
I added the rcu_read_lock() for rhashtable_lookup() only.

Maybe it is to obtain better performance? Just guess ;)
And hlist_for_each_entry_rcu() also uses rcu_dereference_raw().

Thanks!
Menglong Dong
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 




