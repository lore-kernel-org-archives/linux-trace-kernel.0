Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0371946D5;
	Wed,  5 Jun 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582658; cv=none; b=P21PrgSqRcqe+ToaI9byHO7dO0iQsY/I9BRoqVkx+/7fdUHZYjqK21BCPLXe7NYZfPuqOJytrcoVReotrPn7pVvDkdIRxHucpc5rhh7eQ5dnlxd5BVaHmcYsj3RL5kUuL0xmRNYxGvfv3ILbM621iRlbLGkTFSCM02EVZybSUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582658; c=relaxed/simple;
	bh=vUJv8L+3IefnszZ1AcCTOOyf8R37J+f44bfYO2qfp7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ4M+OPv6SL9V1bR6UUB8atQbskuX9ObV7vay96uxIj/b7FFhkkMFpqCa5oTHElGWLHKlIQGKD4e1++XpGVn6sb1PkIWKhjvwES7itTwRkVi0Eeh6a0Cn+lVADo/QWl56YidnsozMnR1TfWdyvatza6g95CfyxnXxwYvVO5cD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA54A339;
	Wed,  5 Jun 2024 03:17:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2293F792;
	Wed,  5 Jun 2024 03:17:34 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:17:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] ftrace: Remove "filter_hash" parameter from
 ftrace_hash_rec_disable/enable()
Message-ID: <ZmA7OwmLw4QSt5uf@J2N7QTR9R3>
References: <20240604212817.384103202@goodmis.org>
 <20240604212854.883675803@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212854.883675803@goodmis.org>

On Tue, Jun 04, 2024 at 05:28:20PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The functions ftrace_hash_rec_disable() and ftrace_hash_rec_enable()
> always has 1 passed to its "ftrace_hash" parameter. Remove the parameter
> and pass in true to __ftrace_hash_rec_update().
> 
> Also add some comments to both those functions explaining what they do.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/trace/ftrace.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 93c7c5fd4249..de652201c86c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1895,16 +1895,24 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>  	return update;
>  }
>  
> -static bool ftrace_hash_rec_disable(struct ftrace_ops *ops,
> -				    int filter_hash)
> +/*
> + * This is called when an ops is removed from tracing. It will decrement
> + * the counters of the dyn_ftrace records for all the functions that
> + * the @ops attached to.
> + */
> +static bool ftrace_hash_rec_disable(struct ftrace_ops *ops)
>  {
> -	return __ftrace_hash_rec_update(ops, filter_hash, 0);
> +	return __ftrace_hash_rec_update(ops, true, 0);
>  }
>  
> -static bool ftrace_hash_rec_enable(struct ftrace_ops *ops,
> -				   int filter_hash)
> +/*
> + * This is called when an ops is added to tracing. It will increment
> + * the counters of the dyn_ftrace records for all the functions that
> + * the @ops attached to.
> + */
> +static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
>  {
> -	return __ftrace_hash_rec_update(ops, filter_hash, 1);
> +	return __ftrace_hash_rec_update(ops, true, 1);
>  }
>  
>  static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
> @@ -3062,7 +3070,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
>  		return ret;
>  	}
>  
> -	if (ftrace_hash_rec_enable(ops, 1))
> +	if (ftrace_hash_rec_enable(ops))
>  		command |= FTRACE_UPDATE_CALLS;
>  
>  	ftrace_startup_enable(command);
> @@ -3104,7 +3112,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  	/* Disabling ipmodify never fails */
>  	ftrace_hash_ipmodify_disable(ops);
>  
> -	if (ftrace_hash_rec_disable(ops, 1))
> +	if (ftrace_hash_rec_disable(ops))
>  		command |= FTRACE_UPDATE_CALLS;
>  
>  	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
> -- 
> 2.43.0
> 
> 
