Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520B314A60;
	Wed, 15 Apr 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247598; cv=none; b=BXKM+LbliAY/ZVN/7NBHYqH8dlr2QpRoUFTngFpXx02jG76bQFOrsX4UdjCXETChF8QyZbXpPnPi6IXaV9C0EmJYfyjhjlGHgjsu8ium6NZSh6kAidRGDka4wI74hHaSQsp3J18aIuvCiq87su6/dg+tgoFfsnVvfFQOOjLF6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247598; c=relaxed/simple;
	bh=Ej6f4nzpb11M/ETiPgKI3u4JDocpvX0cREtihus+aD8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j9NuQYIPymFriaomLcCCjj8b/az98ixhZYSrvxWWk7MTeJPqWLsX6IhIAQpwCtZ0O+52NJANOyXcMk3mnzYf93N4B/jYwnFvjwUPcLChb/0xWAMvGbF6EoxGw+QICKh7hyJh5azpsJQf7ogOqGIfiYWVy7Bv4oSyx5VpL79OLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MODKNgf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MODKNgf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D034C19424;
	Wed, 15 Apr 2026 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247598;
	bh=Ej6f4nzpb11M/ETiPgKI3u4JDocpvX0cREtihus+aD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MODKNgf6qgYNc3FaAl46++8aiBRrhmGeGw9ohJN9Fd5inn7JkANH9g2RVF8wwGHi+
	 D+m7Ekv5W4ZM0Hu/DkIvUqzOulUeB6dHXuRw60/rdzb4Ca7F41NnsDXqp3FwygBSz5
	 6P9pe8ceZzP/+0a8Uzpetbo3Uh5HyFvunvHoE4JkLrv40sQ8S2419wj6ViFJKqbYnp
	 eHU7Pg2JCT9iy3PkgMJCJhS4gsigyZYvzGnXVS2yYD48/2/xMqFQn6+Jqkyq7NlWUu
	 Fe3SYI9OTWyem0tgObPA/CPp6z0CxgfvO91xouO4Xite3TJNctuX2k3F5k2yx/wCK9
	 XfRKUPuO2ba9g==
Date: Wed, 15 Apr 2026 19:06:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] tracing/fprobe: Remove fprobe from hash in
 failure path
Message-Id: <20260415190635.2bdbcd3e40f2b9fb26d16489@kernel.org>
In-Reply-To: <2405872.ElGaqSPkdT@7940hx>
References: <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
	<177615809677.1165997.619922394559783590.stgit@mhiramat.tok.corp.google.com>
	<2405872.ElGaqSPkdT@7940hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 17:47:11 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2026/4/14 17:14 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > When register_fprobe_ips() fails, it tries to remove a list of
> > fprobe_hash_node from fprobe_ip_table, but it missed to remove
> > fprobe itself from fprobe_table. Moreover, when removing
> > the fprobe_hash_node which is added to rhltable once, it must
> > use kfree_rcu() after removing from rhltable.
> > 
> > To fix these issues, this reuses unregister_fprobe() internal
> > code to rollback the half-way registered fprobe.
> > 
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> [...]
> >  
> > +static int unregister_fprobe_nolock(struct fprobe *fp, bool force);
> > +
> >  /**
> >   * register_fprobe_ips() - Register fprobe to ftrace by address.
> >   * @fp: A fprobe data structure to be registered.
> > @@ -847,29 +855,26 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
> >  	if (ret)
> >  		return ret;
> 
> Hi, Masami. The logic of unregister_fprobe_nolock() looks a little
> messy. How about we make the logic here like this:
> 
> for (i = 0; i < hlist_array->size; i++) {
>     // The node->fp is NULL, so it's safe to add the node before
>     // fprobe_ftrace_add_ips(), right?
>     ret = insert_fprobe_node(&hlist_array->array[i], fp);
>     if (ret)
>         goto fallback_err;
> }
> 
> if (fprobe_is_ftrace(fp))
>     ret = fprobe_ftrace_add_ips(addrs, num);
> else
>     ret = fprobe_graph_add_ips(addrs, num);
> if (ret)
>     goto fallback_err;
> 
> add_fprobe_hash(fp);
> for (i = 0; i < hlist_array->size; i++)
>     WRITE_ONCE(hlist_array->array[i].fp, fp);
> 
> return 0;
> 
> fallback_err:
> for (i--; i >= 0; i--)
>     delete_fprobe_node(&hlist_array->array[i]);
> fprobe_fail_cleanup(fp);
> return ret;
> 
> Then, we don't need to change unregister_fprobe_nolock and
> insert_fprobe_node.

Thanks for the idea, but I don't like repeat it.
It is better to do the same thing(unregister) in the same code.
Above seems a bit optimized for fixing a problem.
(Maybe revisit it later for optimization)

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
