Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD5188737;
	Mon, 28 Oct 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107025; cv=none; b=NANOw6ColmhbDgraBoKaqQugbfPNXDc/lvqLufqpJp1XgdUUJFGY9OvKT0Kg6QtgymV8aGl5Tv7l9TEODKPRHm2DXgbCQl1ki4fbsDKba2bmIBulSQyhhfeMFk81J8zSZXvoflw4Z+gZeTGljBFZx7U8sT1kJXiDNu2n1zctYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107025; c=relaxed/simple;
	bh=AzeS4iVVuORhDSNk0nnSwXiCr/f6FvTt1tpmW8lf78E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmRht1go5ndFqe9KH1BevNdS71KduDpd+H0FD79QXiAsGEqhuvuHPg4w2UGL+lThxX8eTzjhJUvHesc2UyCP9BvuG089JARg5XuzasfHfOiZIs0aYAIlsTSXfBWczKrif4/kyx5IC8MtLOUOxIvhH+GxoTIqZgiX+iy4SOE3kzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b2jLO2wc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b2jLO2wc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJLLZyCg0taEgd0tdxPqaA4YOwyn6ElZDCifLYaOT48=; b=b2jLO2wcaJO1QLM8tK/UqvlIlE
	+B327wFVqBs0XbUCRfDdYsmuXkVQXS7+QZsv0ZfJT6iPG7nrHuMPOILOd2/u2/6gq/0Zl8b+zq1OB
	r+bPy94A1+4TkyAX6WEKHjXMd06XdPrSRSqn66zOcDfE9LhYeEwhxY6IAdTNkLl6Crlh+zuppDJiL
	94vIojrhjd6VHzXeTRAwXLdUEfOryfpCMtBA7ty/2ZGX7r7Lf/1rA8mYG9wdFxE37K/u4+h2LDbud
	SaQ1Xg0XQ3TUzpjHK6Pi7/M0ltaZqpS/iFVN1CNTX/7LnCIkn5uMorEnyLsaygtLrzNvgYRJs2XKb
	HhkMa9AQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Lrs-00000009cFt-2Pdw;
	Mon, 28 Oct 2024 09:16:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4190930083E; Mon, 28 Oct 2024 10:16:56 +0100 (CET)
Date: Mon, 28 Oct 2024 10:16:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] ftrace: Use guard to take ftrace_lock in
 ftrace_graph_set_hash()
Message-ID: <20241028091656.GJ9767@noisy.programming.kicks-ass.net>
References: <20241028071228.575900713@goodmis.org>
 <20241028071308.406073025@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028071308.406073025@goodmis.org>

On Mon, Oct 28, 2024 at 03:12:33AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ftrace_lock is taken for most of the ftrace_graph_set_hash() function
> throughout the end. Use guard to take the ftrace_lock to simplify the exit
> paths.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c0fabd7da5b2..b4ef469f4fd2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6816,12 +6816,10 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
>  
>  	func_g.len = strlen(func_g.search);
>  
> -	mutex_lock(&ftrace_lock);
> +	guard(mutex)(&ftrace_lock);
>  
> -	if (unlikely(ftrace_disabled)) {
> -		mutex_unlock(&ftrace_lock);
> +	if (unlikely(ftrace_disabled))
>  		return -ENODEV;
> -	}
>  
>  	do_for_each_ftrace_rec(pg, rec) {
>  
> @@ -6837,7 +6835,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
>  				if (entry)
>  					continue;
>  				if (add_hash_entry(hash, rec->ip) == NULL)
> -					goto out;
> +					return 0;
>  			} else {
>  				if (entry) {
>  					free_hash_entry(hash, entry);
> @@ -6846,13 +6844,8 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
>  			}
>  		}
>  	} while_for_each_ftrace_rec();
> -out:
> -	mutex_unlock(&ftrace_lock);
>  
> -	if (fail)
> -		return -EINVAL;
> -
> -	return 0;
> +	return fail ? -EINVAL : 0;
>  }

Isn't the fail case more a case of -ESRCH / -ENOENT rather than -EINVAL?

Anyway, that's orthogonal, the patch preserves existing semantics and
looks okay (as do the others fwiw).
