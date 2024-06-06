Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC31990CC;
	Thu,  6 Jun 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696401; cv=none; b=nyawYTyxZZdlpROoVG30j6LrZ6qCsvQF3U1m6d/kD/y2VM/wmI0S52/v9vzu33wGxh86KJQ4JREgHoNjeswP3WFfFEtl15HYOLUFGBn2YvGgX+UJEIllG3OQzARvueTnzMseF03LYolS4FU+iGzyeZACFGwrfWBm5CbFjeIkKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696401; c=relaxed/simple;
	bh=ftz4Bm8vHSLMeffp8LaWdkXvqrUGzL8z2wEg8QsBdvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNL4bJeCq4PlRWAhv39JpkRoXtA0Js0+XsLrz3/WX8khFAQTduYrOtNZgTP1WHyPjycL8zWnC85J9wppDzMQkjarSQA1u4MDWwfu2NTBe1qeMhn8JQzO7WHMd+GrwOWmScuS2c9I/ppEUcB+Sk6WKEevJE72qA/fXnrNjcWzCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9958C2F4;
	Thu,  6 Jun 2024 10:53:42 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DEC43F64C;
	Thu,  6 Jun 2024 10:53:17 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:53:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/5] ftrace: Remove "ftrace_hash" parameter from
 __ftrace_hash_rec_update()
Message-ID: <ZmH3iNgj_sLpQhTr@J2N7QTR9R3.cambridge.arm.com>
References: <20240605180334.090848865@goodmis.org>
 <20240605180408.691995506@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605180408.691995506@goodmis.org>

On Wed, Jun 05, 2024 at 02:03:36PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> While adding comments to the function __ftrace_hash_rec_update() and
> trying to describe in detail what the parameter for "ftrace_hash" does, I
> realized that it basically does exactly the same thing (but differently)
> if it is set or not!

Typo: "ftrace_hash" should be "filter_hash", and likewise in the commit
title.

> If it is set, the idea was the ops->filter_hash was being updated, and the
> code should focus on the functions that are in the ops->filter_hash and
> add them. But it still had to pay attention to the functions in the
> ops->notrace_hash, to ignore them.
> 
> If it was cleared, it focused on the ops->notrace_hash, and would add
> functions that were not in the ops->notrace_hash but would still keep
> functions in the "ops->filter_hash". Basically doing the same thing.
> 
> In reality, the __ftrace_hash_rec_update() only needs to either remove the
> functions associated to the give ops (if "inc" is set) or remove them (if
> "inc" is cleared). It has to pay attention to both the filter_hash and
> notrace_hash regardless.

AFAICT, we actually remove a latent bug here, but that bug wasn't
reachable because we never call __ftrace_hash_rec_update() with
"filter_hash" clear.

Before this patch, if we did call __ftrace_hash_rec_update() with
"filter_hash" clear, we'd setup:

	all = false;
	...
	if (filter_hash) {
		...
	} else {
		hash = ops->func_hash->notrace_hash;
		other_hash = ops->func_hash->filter_hash;
	}

... and then at the tail of the loop where we do:

	count++;

	[...] 

	/* Shortcut, if we handled all records, we are done. */
	if (!all && count == hash->count) {
		pr_info("HARK: stopping after %d recs\n", count);
		return update;
	}

... we'd be checking whether we've updated notrace_hash->count entries,
when that could be smaller than the number of entries we actually need
to update (e.g. if the notrace hash contains a single entry, but the
filter_hash contained more).

As above, we never actually hit that because we never call with
"filter_hash" clear, so it might be good to explicitly say that before
this patch we never actually call __ftrace_hash_rec_update() with
"filter_hash" clear, and this is removing dead (and potentially broken)
code.

> Remove the "filter_hash" parameter from __filter_hash_rec_update() and
> comment the function for what it really is doing.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

FWIW, this looks good to me, and works in testing, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

I have one comment below, but the above stands regardless.

[...]

> +/*
> + * This is the main engine to the ftrace updates to the dyn_ftrace records.
> + *
> + * It will iterate through all the available ftrace functions
> + * (the ones that ftrace can have callbacks to) and set the flags
> + * in the associated dyn_ftrace records.
> + *
> + * @inc: If true, the functions associated to @ops are added to
> + *       the dyn_ftrace records, otherwise they are removed.
> + */
>  static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> -				     int filter_hash,
>  				     bool inc)
>  {
>  	struct ftrace_hash *hash;
> -	struct ftrace_hash *other_hash;
> +	struct ftrace_hash *notrace_hash;
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  	bool update = false;
> @@ -1718,35 +1725,16 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  		return false;
>  
>  	/*
> -	 * In the filter_hash case:
>  	 *   If the count is zero, we update all records.
>  	 *   Otherwise we just update the items in the hash.
> -	 *
> -	 * In the notrace_hash case:
> -	 *   We enable the update in the hash.
> -	 *   As disabling notrace means enabling the tracing,
> -	 *   and enabling notrace means disabling, the inc variable
> -	 *   gets inversed.
>  	 */
> -	if (filter_hash) {
> -		hash = ops->func_hash->filter_hash;
> -		other_hash = ops->func_hash->notrace_hash;
> -		if (ftrace_hash_empty(hash))
> -			all = true;
> -	} else {
> -		inc = !inc;
> -		hash = ops->func_hash->notrace_hash;
> -		other_hash = ops->func_hash->filter_hash;
> -		/*
> -		 * If the notrace hash has no items,
> -		 * then there's nothing to do.
> -		 */
> -		if (ftrace_hash_empty(hash))
> -			return false;
> -	}
> +	hash = ops->func_hash->filter_hash;
> +	notrace_hash = ops->func_hash->notrace_hash;
> +	if (ftrace_hash_empty(hash))
> +		all = true;
>  
>  	do_for_each_ftrace_rec(pg, rec) {
> -		int in_other_hash = 0;
> +		int in_notrace_hash = 0;
>  		int in_hash = 0;
>  		int match = 0;
>  
> @@ -1758,26 +1746,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  			 * Only the filter_hash affects all records.
>  			 * Update if the record is not in the notrace hash.
>  			 */
> -			if (!other_hash || !ftrace_lookup_ip(other_hash, rec->ip))
> +			if (!notrace_hash || !ftrace_lookup_ip(notrace_hash, rec->ip))
>  				match = 1;
>  		} else {
>  			in_hash = !!ftrace_lookup_ip(hash, rec->ip);
> -			in_other_hash = !!ftrace_lookup_ip(other_hash, rec->ip);
> +			in_notrace_hash = !!ftrace_lookup_ip(notrace_hash, rec->ip);
>  
>  			/*
> -			 * If filter_hash is set, we want to match all functions
> -			 * that are in the hash but not in the other hash.
> -			 *
> -			 * If filter_hash is not set, then we are decrementing.
> -			 * That means we match anything that is in the hash
> -			 * and also in the other_hash. That is, we need to turn
> -			 * off functions in the other hash because they are disabled
> -			 * by this hash.
> +			 * We want to match all functions that are in the hash but
> +			 * not in the other hash.
>  			 */
> -			if (filter_hash && in_hash && !in_other_hash)
> -				match = 1;
> -			else if (!filter_hash && in_hash &&
> -				 (in_other_hash || ftrace_hash_empty(other_hash)))
> +			if (in_hash && !in_notrace_hash)
>  				match = 1;
>  		}
>  		if (!match)

I wonder how much the (subsequent) shortcut for count == hash->count
matters in practice, because if we were happy to get rid of that, we
could get rid of 'all', 'count', 'in_hash', 'in_notrace_hash', and
simplify the above down to:

	do_for_each_ftrace_rec(pg, rec) {
		if (skip_record(rec))
			continue;

		/*
		 * When the hash is empty we update all records.
		 * Otherwise we just update the items in the hash.
		 */
		if (!ftrace_hash_empty(hash) &&
		    !ftrace_lookup_ip(hash, rec->ip))
			continue;

		if (!ftrace_lookup_ip(notrace_hash, rec->ip))
			continue;

		[...]
			/* do the actual updates here */
		[...]

	} while_for_each_ftrace_rec();

... which'd be easier to follow.

FWIW, diff atop this patch below. It passes the selftests in my local
testing, but I understand if we'd rather keep the shortcut.

Mark.

---->8----
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f1aab82fa465..165e8dd4f894 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1714,49 +1714,27 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	bool update = false;
-	int count = 0;
-	int all = false;
 
 	/* Only update if the ops has been registered */
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return false;
 
-	/*
-	 *   If the count is zero, we update all records.
-	 *   Otherwise we just update the items in the hash.
-	 */
 	hash = ops->func_hash->filter_hash;
 	notrace_hash = ops->func_hash->notrace_hash;
-	if (ftrace_hash_empty(hash))
-		all = true;
 
 	do_for_each_ftrace_rec(pg, rec) {
-		int in_notrace_hash = 0;
-		int in_hash = 0;
-		int match = 0;
-
 		if (skip_record(rec))
 			continue;
 
-		if (all) {
-			/*
-			 * Only the filter_hash affects all records.
-			 * Update if the record is not in the notrace hash.
-			 */
-			if (!notrace_hash || !ftrace_lookup_ip(notrace_hash, rec->ip))
-				match = 1;
-		} else {
-			in_hash = !!ftrace_lookup_ip(hash, rec->ip);
-			in_notrace_hash = !!ftrace_lookup_ip(notrace_hash, rec->ip);
+		/*
+		 * If the hash is empty, we update all records.
+		 * Otherwise we just update the items in the hash.
+		 */
+		if (!ftrace_hash_empty(hash) &&
+		    !ftrace_lookup_ip(hash, rec->ip))
+			continue;
 
-			/*
-			 * We want to match all functions that are in the hash but
-			 * not in the other hash.
-			 */
-			if (in_hash && !in_notrace_hash)
-				match = 1;
-		}
-		if (!match)
+		if (ftrace_lookup_ip(notrace_hash, rec->ip))
 			continue;
 
 		if (inc) {
@@ -1846,14 +1824,9 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 		else
 			rec->flags &= ~FTRACE_FL_CALL_OPS;
 
-		count++;
-
 		/* Must match FTRACE_UPDATE_CALLS in ftrace_modify_all_code() */
 		update |= ftrace_test_record(rec, true) != FTRACE_UPDATE_IGNORE;
 
-		/* Shortcut, if we handled all records, we are done. */
-		if (!all && count == hash->count)
-			return update;
 	} while_for_each_ftrace_rec();
 
 	return update;


