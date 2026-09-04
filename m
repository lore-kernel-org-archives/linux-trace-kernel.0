Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8DDF59;
	Fri,  4 Sep 2026 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482837; cv=none; b=JZ4Y4mzTbKe3NDtH2tlSqcG0WvHd2ZnscTTxOwKCta9Wq81WATotCjZMZZoxebUIDv3rOvxFxHedJ/thVfgzbLs4IksydcZvCK5nB0rVb0OVHgw0qPEi+wZ51ZQqiG8LWZWSgAfgHPsUl4SJ1pLl3RzcVCdxP80cuOAs4roVJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482837; c=relaxed/simple;
	bh=1Rj6DGdQT4blbVu2h7Vt4I+rc6NkpCrfGiFJ9H1m9qo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VhXsevPIP5au9MnQGsGxPQb69esotrB886mHDwnpWEX0yTnJZhEuybz/ZXEumqaUCDgiVTri8z7cplP+5xn29+O94cfyLs9pbATBXc4nNbaC9G6eoUMSWKGAWCDC57oJtUoxBw9gFYi33Orp7FFpyHZyH84CJF5DXsTeCdDGvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ied/Q2OQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ied/Q2OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC391F000E9;
	Fri,  4 Sep 2026 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482836;
	bh=5PoirAbTzXhUzGqr98L7qjL9f6MVl7KJM5VoZrFAO8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ied/Q2OQoPRqI2M3twPYYGpO3Dscab4q63GHlMtGRxY1NxGr9WkwKjvxolKXp6F1Q
	 m7HFDiT36r3HWjX3iQuzN8nvcBgLikLKpeZMcfvBj61RTyyUxkSoOaaOWn7g4EFuGD
	 haWRMHV4a6NZAyNjmcjHbTLMmtpBvT9hvZgzpMsUI1NY7TjqImNb+x/3lmSjPhol3Y
	 k8z/t19XyW9envohrINNxkyeMETfDOyqqN9LL0WXs0vak+0Uo3n2e4ANRFufB50GYi
	 6oo3UwJRMpXljyQFSayqYBp4vKcrfYt6X2J7Le7+IE3QqENCYKm5mv42INz2oDDMj8
	 ThlQFhBTXFytA==
Date: Fri, 4 Sep 2026 09:47:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ftrace: Synchronize the initialization of ftrace_ops
Message-Id: <20260904094712.495d57be3c22a6b00529e7b9@kernel.org>
In-Reply-To: <20260902095501.6b59af20@gandalf.local.home>
References: <20260902095501.6b59af20@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 09:55:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There's some internal state that ftrace_ops needs to have set, but since
> it can be declared outside of the ftrace.c code, it calls
> ftrace_ops_init() on the ops in every global function. The issue is that
> if two tasks call it on the same ops at the same time it is possible to
> have the initialization of one corrupt the initialization of the other
> call.
> 
> Create a ops_mutex to use to synchronize every initialization of the
> ftrace_ops. The mutex is taken within checking the ftrace_ops flag that
> states it was initializied but the flag is checked again after the mutex
> has been taken. Checking first outside the mutex allows it to shortcut
> having to take the mutex. But then the check needs to be done again after
> the mute is taken in case of races.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: f04f24fb7e48d ("ftrace, kprobes: Fix a deadlock on ftrace_regex_lock")
> Reported-by: sashiko-bot@kernel.org
> Close: https://lore.kernel.org/all/20260829025528.49A831F000E9@smtp.kernel.org/
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> Changes since v1: https://patch.msgid.link/20260901202020.09a1119a@robin
> 
> - Added smp_load_acquire() and smp_store_release() to make sure that
>   the flags value that is compared is really updated after the code has
>   been initialized. (Sashiko)
> 
>  kernel/trace/ftrace.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7cf36f2dd7b..53d5db60bfa5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -75,6 +75,8 @@
>  	.func_hash		= &opsname.local_hash,			\
>  	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock), \
>  	.subop_list		= LIST_HEAD_INIT(opsname.subop_list),
> +/* Used only to synchronize the initialization of ftrace_ops */
> +static DEFINE_MUTEX(ops_mutex);
>  #else
>  #define INIT_OPS_HASH(opsname)
>  #endif
> @@ -159,11 +161,18 @@ const struct ftrace_ops ftrace_nop_ops = {
>  static inline void ftrace_ops_init(struct ftrace_ops *ops)
>  {
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
> +	unsigned long flags = smp_load_acquire(&ops->flags);
> +
> +	if (!(flags & FTRACE_OPS_FL_INITIALIZED)) {
> +		guard(mutex)(&ops_mutex);
> +		/* Could have been initialized before lock taken */
> +		if (unlikely(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> +			return;
>  		mutex_init(&ops->local_hash.regex_lock);
>  		INIT_LIST_HEAD(&ops->subop_list);
>  		ops->func_hash = &ops->local_hash;
> -		ops->flags |= FTRACE_OPS_FL_INITIALIZED;
> +		flags = ops->flags | FTRACE_OPS_FL_INITIALIZED;
> +		smp_store_release(&ops->flags, flags);
>  	}
>  #endif
>  }
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
