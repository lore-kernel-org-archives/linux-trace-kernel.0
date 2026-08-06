Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5418248B;
	Thu,  6 Aug 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785975143; cv=none; b=bi0RQ2WeO1lTYdf6JZQC13Sa9nHpbutPuhWw4pdYMTnHnxxz37oj2GyaJk1AwlI1WNAfIJKtjKeGCe5u/zO7nsDYMCfHRXP9bFEEJYEV9cmh3blSyv4DbmKFbOf17Symwbu8NAhNmo6WFQSUIA5TuQgANLWtHNuaxKPKzv8woMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785975143; c=relaxed/simple;
	bh=YRjryu4I+ED+IpJT84vgCn+ldoDUwa4XJSQR6fYMcP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svbn8NWNGNRJzaAhebSVtNeXVelyec1uTnXeMPexBwNXQ5G4dx2CUJdtA9zTKLTlHGimL+X0onVutfMCHBhcpGU+5gri/ZEWSxnUUBjIFN7SXxbd7P8bCSKAD1pH5xOQSoffVWIkcP5CKJ2fbtM0AXnpbYToYu7DCyFrb6q0+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNX0lZuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNX0lZuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893E01F000E9;
	Thu,  6 Aug 2026 00:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785975142;
	bh=fdaDCWaOpYDudE/QaGVbePvjNGYP8RNAxxxSF/5EvyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YNX0lZuUxIl05HkFARrpvfnqBhw2JlU2ghSdtr1VDtMld6gVdM2mQl4sZGjdItOOx
	 F5Rq6QT+7zPBWDuq1p09xpAv2oAMBOpa1Hq5B0w1Yq6IdPblQEbyiuenZCvsWgCjIS
	 SZoLOSmDk3GeHXDUVJgkTQ/e9a9J4mZh/SeoJVpDmEwpMDuziermtFOro7BcSZgP0x
	 Gv/4Zy6lCKeu/U5P6xJDpS3E3XIBTYrR6sGdpbFFR2Nj4tsxjaI7th8YRU4ofneFti
	 0/qBCoZYypw5CK7A8tHXKUFfFbNdRsSYyob52nCz9ygKZwq5xHVHJ4+wzJV4PCYP3J
	 vXy60Q5QUTJVw==
Date: Wed, 5 Aug 2026 17:12:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix off-by-one fentry site disable in
 ftrace_free_mem()
Message-ID: <jhkedgexoznj7ycuypjdeznz57x77cj4fjnamnhram7lm4fdms@esmvzcfy5r3t>
References: <d0a6a1deda9836c614a11c458fef2c8cf321333a.1785726456.git.jpoimboe@kernel.org>
 <20260805153005.0bbc428a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805153005.0bbc428a@gandalf.local.home>

On Wed, Aug 05, 2026 at 03:30:05PM -0400, Steven Rostedt wrote:
> On Sun,  2 Aug 2026 20:08:35 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > When a module's init text is freed, do_init_module() calls
> > ftrace_free_mem() with a half-open [start, end) range.  However the
> > ftrace_cmp_recs() comparator treats the upper bound as inclusive, as all
> > its other users do, passing 'ip + size - 1'.  So ftrace_free_mem() can
> > delete a record sitting exactly at 'end', which is outside the freed
> > range.
> > 
> > For a kernel without CFI or IBT, the first record of a function is at
> > the function start, which for the first function in a module is also the
> > base of its text allocation.  As the module allocator packs its regions,
> > that address is often the 'end' passed by a neighboring module's
> > do_init_module(), causing the first function's ftrace location to get
> > disabled, preventing an attempt to livepatch it:
> > 
> >   livepatch: failed to find location for function 'pcspkr_probe'
> > 
> > Convert the exclusive end to the inclusive 'end - 1' the comparator
> > expects, and return early for an empty range to avoid the subtraction
> > from underflowing when the init text size is zero.
> 
> Nice catch.
> 
> 
> > 
> > Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  kernel/trace/ftrace.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f93e34dd2328..7d8b736f0d86 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -8293,8 +8293,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
> >  	struct ftrace_init_func *func, *func_next;
> >  	LIST_HEAD(clear_hash);
> >  
> > +	if (start >= end)
> > +		return;
> > +
> >  	key.ip = start;
> > -	key.flags = end;	/* overload flags, as it is unsigned long */
> > +	key.flags = end - 1;	/* overload flags, as it is unsigned long */
> 
> I'd like to keep this consistent with lookup_rec().
> 
> >  
> >  	mutex_lock(&ftrace_lock);
> >  
> 
> Can you do this instead?

Yeah, that would be better, let me go do that.

> 
> -- Steve
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 6c47a94f5924..dbb0fc2928d8 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8296,7 +8296,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
>  void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  {
>  	unsigned long start = (unsigned long)(start_ptr);
> -	unsigned long end = (unsigned long)(end_ptr);
> +	/* end is inclusive and end_ptr is exclusive */
> +	unsigned long end = (unsigned long)(end_ptr) - 1;
>  	struct ftrace_page **last_pg = &ftrace_pages_start;
>  	struct ftrace_page *tmp_page = NULL;
>  	struct ftrace_page *pg;

-- 
Josh
