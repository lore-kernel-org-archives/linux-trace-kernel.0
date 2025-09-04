Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D374437A;
	Thu,  4 Sep 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960175; cv=none; b=CJPCGlPRznehrxvHly6ApuQ6sTjkq4TG6Ta9uSj7e9pdM3NpXCDkYzJXsbkVQuPDMrfYIecyEYgLHcix2XAbtiaIGlbTtVs3zgKY4XVrycqsByzFXHx0UJ+D2k0FpsJZCtGxDUh8QqWzzXv28i1wAjkOv1JudItInecbLyiEOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960175; c=relaxed/simple;
	bh=wfmMCtQkYy7kMMCYDDyBRhhKXRcmqUlls5+MC/y169w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pkzW2EGfFMBPG4tVCp42hgAe9Nek3S0BItuiXB79O5x4JBJWXpWH1ecv2v187YVdUYkVEQ0omHzyc9tBneT8tZk7s6JUH564EBGbG7Vd+FZjdlowgNPMrleH8OGnIp6HwIw/sfAPEKWPNtwriwnv8NwV7w8I8vc9MPnoBwB+UJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcAdNLfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcAdNLfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2A0C4CEF0;
	Thu,  4 Sep 2025 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756960174;
	bh=wfmMCtQkYy7kMMCYDDyBRhhKXRcmqUlls5+MC/y169w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KcAdNLfgTd4f07sAiJkYgN2ebk8yr2J7uTlWiRj5VmxTz0qjCyhydrcrBArRkBxmE
	 y+f28hQRHx/WgMfptcxJh1Ro0ciDYZuiAyQMJfVPtMrJu75yvJbrXW+6lgkQvTKOMV
	 1mHcddZivLSq7I9olniDRXakZ8VAKQQKTZJpNY6mqJaweAfGqaNB3dyT269EBwZsbO
	 qVA9e2JYh0B9CqsPuM+yCnChWfuymGDl3ZIH96ycCXcL+WGI3a/7P+CVvsWSZEVCp2
	 pniuAxh6su+LeZ61+G0GnbxD1kOWC4wlct2BTvllQhhKc8FC8bcF1Vb5cIYi8T08v2
	 hqbfvsK3iip8A==
Date: Thu, 4 Sep 2025 13:29:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, mhiramat@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in
 fprobe_entry
Message-Id: <20250904132931.8c46a011b2fa1743fc87def4@kernel.org>
In-Reply-To: <5038598.31r3eYUQgx@7940hx>
References: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
	<3005966.e9J7NaK4W3@7940hx>
	<aLfCa1FkLc3T4QI3@gondor.apana.org.au>
	<5038598.31r3eYUQgx@7940hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Sep 2025 11:37:35 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2025/9/3 12:22 Herbert Xu <herbert@gondor.apana.org.au> write:
> > On Tue, Sep 02, 2025 at 05:50:32PM +0800, menglong.dong@linux.dev wrote:
> > > On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> > > > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > > > >
> > > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > > index fb127fa95f21..fece0f849c1c 100644
> > > > > --- a/kernel/trace/fprobe.c
> > > > > +++ b/kernel/trace/fprobe.c
> > > > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > > > >        if (WARN_ON_ONCE(!fregs))
> > > > >                return 0;
> > > > > 
> > > > > +       rcu_read_lock();
> > > > >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > > > +       rcu_read_unlock();
> > > > >        reserved_words = 0;
> > > > >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > > > >                if (node->addr != func)
> > > > 
> > > > Actually this isn't quite right.  I know that it is a false-positive
> > > > so that it's actually safe, but if you're going to mark it with
> > > > rcu_read_lock, it should cover both the lookup as well as the
> > > > dereference which happens in the loop rhl_for_each_entry_rcu.
> > > 
> > > Yeah, I understand. The rcu_read_lock() here is totally used to
> > > suppress the suspicious rcu usage warning, not for the protection.
> > > So I used it just for the rhltable_lookup() to reduce the impact.
> > > Maybe I should add some comment for it.
> > 
> > My point is that after a lookup you will be doing some sort of a
> > dereference on the RCU pointer.  That would cause exactly the same
> > splat that rhltable_lookup itself generated.
> > 
> > For example, rhl_for_each_entry_rcu should have created the same
> > warning, but it doesn't because for some reason it is using
> > rcu_dereference_raw.  I'll need to dig up the history of this
> > to see if there is a good reason for it to not warn.
> 
> Yeah, I understand what you mean. I noticed this, and that's why
> I added the rcu_read_lock() for rhashtable_lookup() only.
> 
> Maybe it is to obtain better performance? Just guess ;)
> And hlist_for_each_entry_rcu() also uses rcu_dereference_raw().

Hi Menglong, if you update the patch to use guard(rcu)() because
head is used repeatedly in fprobe_entry(), I can replace it.

Thank you,

> 
> Thanks!
> Menglong Dong
> > 
> > Cheers,
> > -- 
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
