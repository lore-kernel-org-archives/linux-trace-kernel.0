Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC71E1026;
	Mon, 21 Oct 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497497; cv=none; b=orCz+lzEphH3tNz3qQtLp1Y33VZSTMpnoWW7IImLCjJuMXNUn+tHtq1oDuXS0T04X+A21yg43UkVRyev4Rh8wfzRRTg2ed2fe7CEld0/qNKtHaCJ5xwIuH4pyzuM8Wk3tNxARVXfU3YcOAlUGg7Jy7m6gxXuRWAYoKYw1WyawMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497497; c=relaxed/simple;
	bh=4rpysPQB20+ebB4iRt48r73mCvjGBhQyADVxUByaoN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlZTXudv1qMfS596uyOGSxwTtzG14Nubd2mxYL8eyTfykgmmpUixoIw8veL1yStjw0Uy4AwsTsomJ9oh0GD0jtLKfKcB0SZesByzmbY7JGo/izKozoHCcStTLTNOtbbkb27QRi9eFJEcb1bRMY4NyLCl57rWpQwuW9f/TxZg5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87C4DA7;
	Mon, 21 Oct 2024 00:58:43 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017B43F71E;
	Mon, 21 Oct 2024 00:58:12 -0700 (PDT)
Message-ID: <bf425884-b355-4da9-8e2b-6da693f2760b@arm.com>
Date: Mon, 21 Oct 2024 08:58:11 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fgraph: Give ret_stack its own kmem cache
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241019152719.321772eb@rorschach.local.home>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241019152719.321772eb@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2024 20:27, Steven Rostedt wrote:
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
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 51e81b299a0d..51849bc42d3a 100644
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
> @@ -1290,6 +1305,16 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  
>  	mutex_lock(&ftrace_lock);
>  
> +	if (!fgraph_stack_cachep) {
> +		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
> +							SHADOW_STACK_SIZE,
> +							SHADOW_STACK_SIZE, 0, NULL);

(I don't have any experience with this code, but...) is there any value/need to
destroy the cache in unregister_ftrace_graph()? I guess you would need to
refcount it, so its created on the first call to register and destroyed on the
last call to unregister?

Thanks,
Ryan

> +		if (!fgraph_stack_cachep) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
>  	if (!fgraph_array[0]) {
>  		/* The array must always have real data on it */
>  		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)

