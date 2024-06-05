Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14974E567;
	Wed,  5 Jun 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624223; cv=none; b=YdFZNHpEIHANEyvVtOEA6Ozv3KXREESey9z8seAvLTnn6G/ZLuWMQtILhzFvwcOZxytn9wSXN2jq9+zks5xHGP10pdlvwulu7KLzXZd4tt8ToR/roNsgdnT1HEQl9TUorF2bgpfX2Aq+xv4uck2i54Dun22Qkop7iamVJB+tOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624223; c=relaxed/simple;
	bh=Ymc9wcpaG97mbeNDzlGXrcwYGTgFta7AZuf3yen2Aio=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q6oxGfv8J8dvTkEv2k/M8uSz2D8/vLffhUx9T5MsaJBqtOc83xCiZv3HUx7QH/cf6GdOai6aD6LOE+cS8RoXOAy8VqCxq+5S8914d3yimq5BDqqLodi5tuoE+YGHgsNHD/gziQtmOQz5a4/9qyTjwykPUEDn4ILjonlc1CtLXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAykoGX1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAykoGX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B34C2BD11;
	Wed,  5 Jun 2024 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717624222;
	bh=Ymc9wcpaG97mbeNDzlGXrcwYGTgFta7AZuf3yen2Aio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAykoGX10RKgePgPfuf2G/JzeaU6Ebd2RnNuyIrLkKrilRieEQMr3dr2xosrlEfcT
	 XeC/hxNvXZX4be+hORGScwlXVnYbqwAM5Cewt/akt+mDmxWYu2x7V9qA1cK/QPpbBO
	 4GuKIQYJGRL7sxLhfGIhNeEM0rmGwJ/ZDqjBfZC05GU7fk8k1coZ93O25bdAQC/fvT
	 kow/IKgFiN51Z4rEXqtwgcYN6lc9PZ/DAqYpjNPDpD3RjJVDoOhuD/lNkNTdOqNp58
	 zZ6R3mQcUZ5u3mrvv6vlJbosOqlIQc3v8Pg8xfRCNQX1a+b19xDZPzlyCMs4NA237/
	 TULEy2zU0zAKw==
Date: Thu, 6 Jun 2024 06:50:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] ftrace: Remove "filter_hash" parameter from
 ftrace_hash_rec_disable/enable()
Message-Id: <20240606065018.0bf1d82a3bf9c526aee9a170@kernel.org>
In-Reply-To: <20240604212854.883675803@goodmis.org>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.883675803@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Jun 2024 17:28:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The functions ftrace_hash_rec_disable() and ftrace_hash_rec_enable()
> always has 1 passed to its "ftrace_hash" parameter. Remove the parameter
> and pass in true to __ftrace_hash_rec_update().
> 
> Also add some comments to both those functions explaining what they do.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
