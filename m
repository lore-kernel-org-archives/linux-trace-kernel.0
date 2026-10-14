Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901F481AB3;
	Wed, 14 Oct 2026 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013314; cv=none; b=FApNQVRh2qkKGC6aAtapESWP4is5PPd63UlB+GdABe2A09aPe+8iCRLXgP9qc/hlcA07vD5wMLtyPqVveRUH/4dMTnAxegdTBFkWbcCpMomC4pFaGeRrGix8NIzjiWB8VoVhLqjXLJ1EfBht5Emq5SGN1JJEAfWMTsJh4sWkC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013314; c=relaxed/simple;
	bh=LpA+uJyhB8EEGLA/EzeAiOtgtEBsNeUt70KXBYbelLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjS2IXkBqGyDQePceEdiKYhChWjZEZ7aHPaAoTTImIIBnB8hG2kGURmuE7vGjTffGVzlHfDNqmsChHaYd5+NQ+HdBzIJBVLp6Y/VLfeXi3G5ZmXCWzR5oJ2TJBRQ3TiVjmII9cwKnHtpJBLGsjUZKAwyjF/1K8gB2HJsnXksKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2n5lE5gT; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2n5lE5gT"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 85626A04FC;
	Wed, 14 Oct 2026 21:28:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C985020027;
	Wed, 14 Oct 2026 21:28:22 +0000 (UTC)
Date: Wed, 14 Oct 2026 17:28:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: Fix lost recursion records in
 ftrace_record_recursion()
Message-ID: <20261014172821.2b1fde91@gandalf.local.home>
In-Reply-To: <20260917090217.6738-1-parri.andrea@gmail.com>
References: <20260917090217.6738-1-parri.andrea@gmail.com>
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
X-Rspamd-Queue-Id: C985020027
X-Stat-Signature: drctf8sc869jumqk859ukfc9mpq7zkrz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+eLNP5VhHoeWSdhwdUGvCEUjjZxRn7iwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=NbU69m8BL/3/ePbzU92HaN4diDbYa6HHrjwHCIZGzuw=; b=2n5lE5gTAHJLkU2QP6er9B1ou6S2Sg6YdJFMtaeKFARIjmoNFBR3hQh2uRld8CEqgwINUZE7P80r6UylCFShFFUHdc5NXubZznZnxIgeUXTeZZFR/8hxltsJsbPNqneg0s8ay+CQiCNdwIjR4O2fZyFUhos68Ddtagu/Hnh19bM=
X-HE-Tag: 1792013302-700209
X-HE-Meta: U2FsdGVkX1/VvuSB3H8ol/0Mycl3ICwPaj6Ch4qbMbD4JhBVitsMMDPeY5HGzhnuMM3hFhqzDa5u1ma7p5bFmHCNMhXKMCyhzKkP9uPyxtQkBxB73Yv8pePaQbnaucRYzfpThoxP3wTJa1t7JpDLoGKakcZods8V3q+QsCK4vvW7yXqpVENFqmGH6GPalcqeBPtr9ELnOfGFMW4w1HBNkXdQayzyAUXh+hDYT6yvnhqvMLgotuaJxir2gUyXydf/PcYQ/mvLu9/9IbCg8SDGgzuIeRk/sMiArUJ0pQk/h+aVYpusnwckPtFZRWTXls7nzFgS6+aHLJRY5mwWxeEBQVxpwTVA745V

On Thu, 17 Sep 2026 11:02:17 +0200
Andrea Parri <parri.andrea@gmail.com> wrote:

> cached_function is set to the current ip before the cmpxchg() that
> claims a slot in recursed_functions[]. When that cmpxchg() loses a
> race for the same slot, the code bumps index and retries via "goto
> again", but the retry immediately matches its own cached_function
> write and returns without ever reaching the bumped-index cmpxchg().
> 
> Concretely, for two writers racing on the same index:
> 
>   CPU 0 (ip = A)                    CPU 1 (ip = B)
>   --------------                    --------------
>                                      cmpxchg(&recursed_functions[index].ip,
>                                              0, B);      // succeeds
>   cached_function = A;
>   cmpxchg(&recursed_functions[index].ip,
>           0, A);
>     // fails, old == B
>   index++;
>   goto again;
>   if (A == cached_function)         // true: matches A's own store
>           return;                   // A is dropped, not retried
> 
> Once dropped this way, cached_function stays set to A, so every later
> recursion of A also hits the fast path and returns before reaching the
> retry, until some unrelated ip overwrites the cache.
> 
> Only set cached_function once the record is confirmed present, either
> because a concurrent writer already added it or because this writer
> just claimed the slot. The retry path leaves it untouched, so it no
> longer matches against a value it just wrote for itself.
> 

Good catch!

> Fixes: 773c16705058e ("ftrace: Add recording of functions that caused recursion")
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
> Can't claim to fully understand the logic behind ftrace_record_recursion().
> Notably, its smp_mb__after_atomic() calls and the lack of barrier comments
> both look suspicious to my LKMM-trained eyes.  ;)  Hence the RFC.

Well, the nr_records is updated via a cmpxchg() which itself is a full
memory barrier. The smp_mb__after_atomic() calls are to make sure the value
read is in sync with other CPUs before doing the compares. It also syncs
with the clearing function that is disabling and the writes, clears it, and
enables it (the -1 updates).

Otherwise, IIUC, the atomic_read() itself doesn't guarantee that what you
read is what is in memory without explicitly using the smp_mb__after_atomic().


> ---
>  kernel/trace/trace_recursion_record.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
> index bac4bc844ccd8..f42089c30f53c 100644
> --- a/kernel/trace/trace_recursion_record.c
> +++ b/kernel/trace/trace_recursion_record.c
> @@ -17,8 +17,8 @@ static struct recursed_functions recursed_functions[CONFIG_FTRACE_RECORD_RECURSI
>  static atomic_t nr_records;
>  
>  /*
> - * Cache the last found function. Yes, updates to this is racey, but
> - * so is memory cache ;-)
> + * Cache the last function confirmed present in recursed_functions[].
> + * Updates to this are racy, but this is only a best-effort cache.
>   */
>  static unsigned long cached_function;
>  
> @@ -67,24 +67,27 @@ void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip)
>  		}
>  	}
>  
> -	cached_function = ip;
> -
>  	/*
>  	 * We only want to add a function if it hasn't been added before.
> -	 * Add to the current location before incrementing the count.
> -	 * If it fails to add, then increment the index (save in i)
> -	 * and try again.
> +	 * Claim the current slot before incrementing the count. If the slot
> +	 * is occupied by another function, advance to the next slot and retry.
> +	 *
> +	 * Do not update cached_function until ip is known to be present;
> +	 * otherwise the retry would match its own cache update.
>  	 */
>  	old = cmpxchg(&recursed_functions[index].ip, 0, ip);
>  	if (old != 0) {
>  		/* Did something else already added this for us? */
> -		if (old == ip)
> +		if (old == ip) {
> +			cached_function = ip;
>  			return;
> +		}

I think we do not need the above. If old == ip, then whatever set it before
should have updated the cached_function.

-- Steve


>  		/* Try the next location (use i for the next index) */
>  		index++;
>  		goto again;
>  	}
>  
> +	cached_function = ip;
>  	recursed_functions[index].parent_ip = parent_ip;
>  
>  	/*

