Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1C1D540;
	Sun, 27 Oct 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037784; cv=none; b=uCZzzCOafdLfNdFC8DBIt3hdX/GEeyrtcXf1sFBW3dg9A4RYPm8ozazlLAiojpgX0g/VMtpNurd5nvmkzpEkA/bAJiYmt72KBjQziZ2HdyaYyKBSp9zbf2QuPbeQSDBXPcw58PJjY4emE1YyEdyESDU7qGVVy2lEDbJydJQ1rYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037784; c=relaxed/simple;
	bh=LhoYjWPnw5QWHt7GC9qloa0rQmmKlS9JcCkIHsCUrXI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=R2VoXWvLBkbLn+shfQdxguMYs2KynOyd+4HC7Z6996LveKcuDzigligSWiGsqcAvtToBlOkHDWjBeqA46h5WRu26eMSgmaacKVJzam+UOH8pzYU4/mzJ1b/YGsTH+azh0UnlXuwQgDc4SZUZKvrAY3CB7GmUMoEu2YYXqr3sn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIrAL571; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIrAL571"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA151C4CEC3;
	Sun, 27 Oct 2024 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730037783;
	bh=LhoYjWPnw5QWHt7GC9qloa0rQmmKlS9JcCkIHsCUrXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GIrAL57198rDy9Hctkx4eClyY3UHQPHYQz9cTB+qHBOzRkl9kmSFaAJqiZPxKAYlg
	 FKQhNaYEalQNtMb+ry+p84SaVhaQbZ70JOtvxAHUpBYbloCMpQ9aksHPojUmq0eZvX
	 qYqR+Bqzdsj9p5NTDjH1zgYsGpv+J9RgDtV3YhxyF1uG613b/ym83iwn604Cr6SxeI
	 16HYYSs/MKNtobg3fOI4Mvci5QanT16cBxWn0MULPP0t8pqPDPmkM8CeTOxqPgEz3b
	 m9NFYpBE7QvW4yBZkOKLip+Uu0kVwnCDSmUHEMSU7hq6KqyskJtof42F3n7NChulon
	 jz5Eqckc+L6gg==
Date: Sun, 27 Oct 2024 23:02:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ryan Roberts
 <ryan.roberts@arm.com>
Subject: Re: [PATCH v2] fgraph: Give ret_stack its own kmem cache
Message-Id: <20241027230259.d908b43b5d41833cebb9ff2c@kernel.org>
In-Reply-To: <20241026063210.7d4910a7@rorschach.local.home>
References: <20241026063210.7d4910a7@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 06:32:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ret_stack (shadow stack used by function graph infrastructure) is
> created for every task on the system when function graph is enabled. Give
> it its own kmem_cache. This will make it easier to see how much memory is
> being used specifically for function graph shadow stacks.
> 
> In the future, this size may change and may not be a power of two. Having
> its own cache can also keep it from fragmenting memory.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank youm

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20241019152719.321772eb@rorschach.local.home
> 
> - Rebased on top of urgent merged into for-next (uses guard(mutex) now)
> 
>  kernel/trace/fgraph.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 4ce87982966a..001abf376c0c 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -172,6 +172,8 @@ enum {
>  DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
>  int ftrace_graph_active;
>  
> +static struct kmem_cache *fgraph_stack_cachep;
> +
>  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
>  static unsigned long fgraph_array_bitmask;
>  
> @@ -1022,8 +1024,11 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
>  	struct task_struct *g, *t;
>  
> +	if (WARN_ON_ONCE(!fgraph_stack_cachep))
> +		return -ENOMEM;
> +
>  	for (i = 0; i < FTRACE_RETSTACK_ALLOC_SIZE; i++) {
> -		ret_stack_list[i] = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
> +		ret_stack_list[i] = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
>  		if (!ret_stack_list[i]) {
>  			start = 0;
>  			end = i;
> @@ -1054,7 +1059,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  	rcu_read_unlock();
>  free:
>  	for (i = start; i < end; i++)
> -		kfree(ret_stack_list[i]);
> +		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
>  	return ret;
>  }
>  
> @@ -1117,9 +1122,12 @@ void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
>  	if (ftrace_graph_active) {
>  		unsigned long *ret_stack;
>  
> +		if (WARN_ON_ONCE(!fgraph_stack_cachep))
> +			return;
> +
>  		ret_stack = per_cpu(idle_ret_stack, cpu);
>  		if (!ret_stack) {
> -			ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
> +			ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
>  			if (!ret_stack)
>  				return;
>  			per_cpu(idle_ret_stack, cpu) = ret_stack;
> @@ -1139,7 +1147,10 @@ void ftrace_graph_init_task(struct task_struct *t)
>  	if (ftrace_graph_active) {
>  		unsigned long *ret_stack;
>  
> -		ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
> +		if (WARN_ON_ONCE(!fgraph_stack_cachep))
> +			return;
> +
> +		ret_stack = kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);
>  		if (!ret_stack)
>  			return;
>  		graph_init_task(t, ret_stack);
> @@ -1154,7 +1165,11 @@ void ftrace_graph_exit_task(struct task_struct *t)
>  	/* NULL must become visible to IRQs before we free it: */
>  	barrier();
>  
> -	kfree(ret_stack);
> +	if (ret_stack) {
> +		if (WARN_ON_ONCE(!fgraph_stack_cachep))
> +			return;
> +		kmem_cache_free(fgraph_stack_cachep, ret_stack);
> +	}
>  }
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> @@ -1294,6 +1309,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  
>  	guard(mutex)(&ftrace_lock);
>  
> +	if (!fgraph_stack_cachep) {
> +		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
> +							SHADOW_STACK_SIZE,
> +							SHADOW_STACK_SIZE, 0, NULL);
> +		if (!fgraph_stack_cachep)
> +			return -ENOMEM;
> +	}
> +
>  	if (!fgraph_initialized) {
>  		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
>  					fgraph_cpu_init, NULL);
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
