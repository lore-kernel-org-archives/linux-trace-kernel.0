Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CA14D2BE;
	Sun, 27 Oct 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030396; cv=none; b=FIBWPewGPGcRulHWu4h+yeMo/AzvPRhJtmvYG7ZAHcfY6bF7G+HxIKfEop7eZhONhFqVGo8WwB6nztE5Sk5q4F1r/U71cLZNhUycKmvYqv46aGj5DpdQ7eiKEzPv2cKx1SO0nsC75QDDmhYbs0+oMNqCf0VNKj/iRXAODo4LtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030396; c=relaxed/simple;
	bh=no/+AbuoRzYxRFzGoq3ejOzhVao1LX1mcfFKJ9bkfXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lZQTSpMGsZzeZGN8+4fpWMA9tuE3loKiLsM5ie5IXSOJmh3nEUMel7IvS1DeLEMRiVgtVllvGZa5T/MegWCQiKvQ4Fr2ClTK804Lm3OZe9Y32bPTtbiyvlCfIwVDjeg+pKpc/k9pxA7sU3KC4Xa2Z16ip2dCxeboqZnCESnYcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQaknicl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQaknicl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9AAC4CEE8;
	Sun, 27 Oct 2024 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730030396;
	bh=no/+AbuoRzYxRFzGoq3ejOzhVao1LX1mcfFKJ9bkfXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQakniclNBUTG4LjfMqiEotg1kwXjpTW6UewlaZYZztiW56k7Hv/KAzkG8kD3WkuI
	 eOEBsIxpBEA2KQRhrmGHd9tGGTrjMX9G+GoRpv5yfiRo/InbkTdsfq9j0yL6BHs6hD
	 SSUMHdt/0ziNpw7Bn3vf4GgwAnCkYLx1tO3IjDHXoa6M/gHnMLpTPxU87dmMC3O0Ow
	 Y1ZU+AyokkNMySopDCxtgkg+EZEPkTznLqolcUBeR54eseZpi0JtOrEVDXzAwu/2u5
	 yP6+Vq+QkzmhmD8zV8fPaA39f4FXeF2eGE+WUMDtfOTOM61g8aFHgfcYkva5rHjuaB
	 L0dbhimjSYY0A==
Date: Sun, 27 Oct 2024 20:59:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Change the name of cpuhp state to
 "fgraph:online"
Message-Id: <20241027205952.e9c65a883362d8fdbdd2fe15@kernel.org>
In-Reply-To: <20241024222944.473d88c5@rorschach.local.home>
References: <20241024222944.473d88c5@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:29:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The cpuhp state name given to cpuhp_setup_state() is "fgraph_idle_init"
> which doesn't really conform to the names that are used for cpu hotplug
> setups. Instead rename it to "fgraph:online" to be in line with other
> states.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Fixes: 2c02f7375e658 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/fgraph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index cd1c2946018c..69e226a48daa 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1255,7 +1255,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	guard(mutex)(&ftrace_lock);
>  
>  	if (!fgraph_initialized) {
> -		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
> +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
>  					fgraph_cpu_init, NULL);
>  		if (ret < 0) {
>  			pr_warn("fgraph: Error to init cpu hotplug support\n");
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
