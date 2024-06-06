Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B34D9E9;
	Thu,  6 Jun 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699986; cv=none; b=lE1+yamJ0cEVnd+hD74IxzgWx2irJdWuUGiqO0r+OrbFchK9jexp/eqKfshlDm3rg+bp7RSZiuQv4FpQlFsxYGeP90JOcC6F6d77JWjDqdLNn0ZUsEGYz8S9JLx5kswoUG7qN5c7xt/ZTlCAjGmW2QKafKRuN5KH2RRwOfM/GFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699986; c=relaxed/simple;
	bh=74eQT7OqedDCr2Pj4HQL0YvRUtI2xPtyGDKxLig0xik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX+BA0to+uFzH1ZAxaccYehFXD6siYjG52gv08wDNyWwgCml4kZom6hEZANc/gnGH/RtrxGQBcHCfAEZ7F8AwK4fgk7RH211DJPOFm8nwTEZer52N7tlvnSz8bxAJceCWAYGYAyRHgup8LIbC0HgBq8tIkp/IGiAH+1IsXg5HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D729C2BD10;
	Thu,  6 Jun 2024 18:53:05 +0000 (UTC)
Date: Thu, 6 Jun 2024 14:53:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/5] ftrace: Remove "ftrace_hash" parameter from
 __ftrace_hash_rec_update()
Message-ID: <20240606145316.45ef14ab@rorschach.local.home>
In-Reply-To: <ZmH3iNgj_sLpQhTr@J2N7QTR9R3.cambridge.arm.com>
References: <20240605180334.090848865@goodmis.org>
	<20240605180408.691995506@goodmis.org>
	<ZmH3iNgj_sLpQhTr@J2N7QTR9R3.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 18:53:12 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Jun 05, 2024 at 02:03:36PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > While adding comments to the function __ftrace_hash_rec_update() and
> > trying to describe in detail what the parameter for "ftrace_hash" does, I
> > realized that it basically does exactly the same thing (but differently)
> > if it is set or not!  
> 
> Typo: "ftrace_hash" should be "filter_hash", and likewise in the commit
> title.

Let me go fix up linux-next :-p

> 
> > If it is set, the idea was the ops->filter_hash was being updated, and the
> > code should focus on the functions that are in the ops->filter_hash and
> > add them. But it still had to pay attention to the functions in the
> > ops->notrace_hash, to ignore them.
> > 
> > If it was cleared, it focused on the ops->notrace_hash, and would add
> > functions that were not in the ops->notrace_hash but would still keep
> > functions in the "ops->filter_hash". Basically doing the same thing.
> > 
> > In reality, the __ftrace_hash_rec_update() only needs to either remove the
> > functions associated to the give ops (if "inc" is set) or remove them (if
> > "inc" is cleared). It has to pay attention to both the filter_hash and
> > notrace_hash regardless.  
> 
> AFAICT, we actually remove a latent bug here, but that bug wasn't
> reachable because we never call __ftrace_hash_rec_update() with
> "filter_hash" clear.
> 
> Before this patch, if we did call __ftrace_hash_rec_update() with
> "filter_hash" clear, we'd setup:
> 
> 	all = false;
> 	...
> 	if (filter_hash) {
> 		...
> 	} else {
> 		hash = ops->func_hash->notrace_hash;
> 		other_hash = ops->func_hash->filter_hash;
> 	}
> 
> ... and then at the tail of the loop where we do:
> 
> 	count++;
> 
> 	[...] 
> 
> 	/* Shortcut, if we handled all records, we are done. */
> 	if (!all && count == hash->count) {
> 		pr_info("HARK: stopping after %d recs\n", count);
> 		return update;
> 	}
> 
> ... we'd be checking whether we've updated notrace_hash->count entries,
> when that could be smaller than the number of entries we actually need
> to update (e.g. if the notrace hash contains a single entry, but the
> filter_hash contained more).

I noticed this too as well as:

	if (filter_hash) {
		hash = ops->func_hash->filter_hash;
		other_hash = ops->func_hash->notrace_hash;
		if (ftrace_hash_empty(hash))
			all = true;
	} else {
		inc = !inc;
		hash = ops->func_hash->notrace_hash;
		other_hash = ops->func_hash->filter_hash;
		/*
		 * If the notrace hash has no items,
		 * then there's nothing to do.
		 */
		if (ftrace_hash_empty(hash))
			return false;
	}

That "return false" is actually a mistake as well. But I tried to hit
it, but found that I could not. I think I updated the code due to bugs
where I prevent that from happening, but the real fix would have been
this patch. :-p

> 
> As above, we never actually hit that because we never call with
> "filter_hash" clear, so it might be good to explicitly say that before
> this patch we never actually call __ftrace_hash_rec_update() with
> "filter_hash" clear, and this is removing dead (and potentially broken)
> code.

Right.

> 
> > Remove the "filter_hash" parameter from __filter_hash_rec_update() and
> > comment the function for what it really is doing.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> FWIW, this looks good to me, and works in testing, so:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> I have one comment below, but the above stands regardless.
> 
> [...]
> 
> > +/*
> > + * This is the main engine to the ftrace updates to the dyn_ftrace records.
> > + *
> > + * It will iterate through all the available ftrace functions
> > + * (the ones that ftrace can have callbacks to) and set the flags
> > + * in the associated dyn_ftrace records.
> > + *
> > + * @inc: If true, the functions associated to @ops are added to
> > + *       the dyn_ftrace records, otherwise they are removed.
> > + */
> >  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> > -				     int filter_hash,
> >  				     bool inc)
> >  {
> >  	struct ftrace_hash *hash;
> > -	struct ftrace_hash *other_hash;
> > +	struct ftrace_hash *notrace_hash;
> >  	struct ftrace_page *pg;
> >  	struct dyn_ftrace *rec;
> >  	bool update = false;
> > @@ -1718,35 +1725,16 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> >  		return false;
> >  
> >  	/*
> > -	 * In the filter_hash case:
> >  	 *   If the count is zero, we update all records.
> >  	 *   Otherwise we just update the items in the hash.
> > -	 *
> > -	 * In the notrace_hash case:
> > -	 *   We enable the update in the hash.
> > -	 *   As disabling notrace means enabling the tracing,
> > -	 *   and enabling notrace means disabling, the inc variable
> > -	 *   gets inversed.
> >  	 */
> > -	if (filter_hash) {
> > -		hash = ops->func_hash->filter_hash;
> > -		other_hash = ops->func_hash->notrace_hash;
> > -		if (ftrace_hash_empty(hash))
> > -			all = true;
> > -	} else {
> > -		inc = !inc;
> > -		hash = ops->func_hash->notrace_hash;
> > -		other_hash = ops->func_hash->filter_hash;
> > -		/*
> > -		 * If the notrace hash has no items,
> > -		 * then there's nothing to do.
> > -		 */
> > -		if (ftrace_hash_empty(hash))
> > -			return false;
> > -	}
> > +	hash = ops->func_hash->filter_hash;
> > +	notrace_hash = ops->func_hash->notrace_hash;
> > +	if (ftrace_hash_empty(hash))
> > +		all = true;
> >  
> >  	do_for_each_ftrace_rec(pg, rec) {
> > -		int in_other_hash = 0;
> > +		int in_notrace_hash = 0;
> >  		int in_hash = 0;
> >  		int match = 0;
> >  
> > @@ -1758,26 +1746,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> >  			 * Only the filter_hash affects all records.
> >  			 * Update if the record is not in the notrace hash.
> >  			 */
> > -			if (!other_hash || !ftrace_lookup_ip(other_hash, rec->ip))
> > +			if (!notrace_hash || !ftrace_lookup_ip(notrace_hash, rec->ip))
> >  				match = 1;
> >  		} else {
> >  			in_hash = !!ftrace_lookup_ip(hash, rec->ip);
> > -			in_other_hash = !!ftrace_lookup_ip(other_hash, rec->ip);
> > +			in_notrace_hash = !!ftrace_lookup_ip(notrace_hash, rec->ip);
> >  
> >  			/*
> > -			 * If filter_hash is set, we want to match all functions
> > -			 * that are in the hash but not in the other hash.
> > -			 *
> > -			 * If filter_hash is not set, then we are decrementing.
> > -			 * That means we match anything that is in the hash
> > -			 * and also in the other_hash. That is, we need to turn
> > -			 * off functions in the other hash because they are disabled
> > -			 * by this hash.
> > +			 * We want to match all functions that are in the hash but
> > +			 * not in the other hash.
> >  			 */
> > -			if (filter_hash && in_hash && !in_other_hash)
> > -				match = 1;
> > -			else if (!filter_hash && in_hash &&
> > -				 (in_other_hash || ftrace_hash_empty(other_hash)))
> > +			if (in_hash && !in_notrace_hash)
> >  				match = 1;
> >  		}
> >  		if (!match)  
> 
> I wonder how much the (subsequent) shortcut for count == hash->count
> matters in practice, because if we were happy to get rid of that, we
> could get rid of 'all', 'count', 'in_hash', 'in_notrace_hash', and
> simplify the above down to:
> 
> 	do_for_each_ftrace_rec(pg, rec) {
> 		if (skip_record(rec))
> 			continue;
> 
> 		/*
> 		 * When the hash is empty we update all records.
> 		 * Otherwise we just update the items in the hash.
> 		 */
> 		if (!ftrace_hash_empty(hash) &&
> 		    !ftrace_lookup_ip(hash, rec->ip))
> 			continue;
> 
> 		if (!ftrace_lookup_ip(notrace_hash, rec->ip))
> 			continue;
> 
> 		[...]
> 			/* do the actual updates here */
> 		[...]
> 
> 	} while_for_each_ftrace_rec();
> 
> ... which'd be easier to follow.
> 
> FWIW, diff atop this patch below. It passes the selftests in my local
> testing, but I understand if we'd rather keep the shortcut.

I'll have to do benchmarks. This loop is what takes up a lot of time
when you enable function tracing. It loops over 40,000 records (just do
a wc -l available_filter_functions to get the true count).

But if you want to send a formal patch, I could test it.

Thanks,

-- Steve


> 
> Mark.
> 
> ---->8----  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f1aab82fa465..165e8dd4f894 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1714,49 +1714,27 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  	bool update = false;
> -	int count = 0;
> -	int all = false;
>  
>  	/* Only update if the ops has been registered */
>  	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
>  		return false;
>  
> -	/*
> -	 *   If the count is zero, we update all records.
> -	 *   Otherwise we just update the items in the hash.
> -	 */
>  	hash = ops->func_hash->filter_hash;
>  	notrace_hash = ops->func_hash->notrace_hash;
> -	if (ftrace_hash_empty(hash))
> -		all = true;
>  
>  	do_for_each_ftrace_rec(pg, rec) {
> -		int in_notrace_hash = 0;
> -		int in_hash = 0;
> -		int match = 0;
> -
>  		if (skip_record(rec))
>  			continue;
>  
> -		if (all) {
> -			/*
> -			 * Only the filter_hash affects all records.
> -			 * Update if the record is not in the notrace hash.
> -			 */
> -			if (!notrace_hash || !ftrace_lookup_ip(notrace_hash, rec->ip))
> -				match = 1;
> -		} else {
> -			in_hash = !!ftrace_lookup_ip(hash, rec->ip);
> -			in_notrace_hash = !!ftrace_lookup_ip(notrace_hash, rec->ip);
> +		/*
> +		 * If the hash is empty, we update all records.
> +		 * Otherwise we just update the items in the hash.
> +		 */
> +		if (!ftrace_hash_empty(hash) &&
> +		    !ftrace_lookup_ip(hash, rec->ip))
> +			continue;
>  
> -			/*
> -			 * We want to match all functions that are in the hash but
> -			 * not in the other hash.
> -			 */
> -			if (in_hash && !in_notrace_hash)
> -				match = 1;
> -		}
> -		if (!match)
> +		if (ftrace_lookup_ip(notrace_hash, rec->ip))
>  			continue;
>  
>  		if (inc) {
> @@ -1846,14 +1824,9 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  		else
>  			rec->flags &= ~FTRACE_FL_CALL_OPS;
>  
> -		count++;
> -
>  		/* Must match FTRACE_UPDATE_CALLS in ftrace_modify_all_code() */
>  		update |= ftrace_test_record(rec, true) != FTRACE_UPDATE_IGNORE;
>  
> -		/* Shortcut, if we handled all records, we are done. */
> -		if (!all && count == hash->count)
> -			return update;
>  	} while_for_each_ftrace_rec();
>  
>  	return update;
> 

