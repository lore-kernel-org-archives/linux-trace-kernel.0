Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195771D0E25;
	Mon, 21 Oct 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490295; cv=none; b=miLiEfSdW80ROjwZRUjkmdFKC6rDu4Y6jc2QnmBCqep1BQa1gdPgtJJClKJkCpley8Yv9wosobqAES4XuZl9iVQrldElOM5eJC4SusvqWwvFTI0s/7CXg8VTEHXbpXJW++/gz/lYnK5gLJwFKsYUAhkyzRATd0QOHOy3Ho1wUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490295; c=relaxed/simple;
	bh=cnBwHsIRodoa99w/eOo3riYqdUVnvEAMUk+C6Gflt00=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CqW3uOyyHewhs1dOkQmw7OEXmuSGFrTKpqMw12URyR4sVY/QuQdFln3B4cd01bM5EdGkapXUhYMZ1aYTipXdrwWxhfYL5OXMiWZQbnOEicrJWkp/zf7WVS27qOOn+LF4WUeQEKptbKepcleD5X/IzMPn6LfZ3MrPR3AdVI8Dw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHuxDmXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHuxDmXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA3EC4CEC3;
	Mon, 21 Oct 2024 05:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729490294;
	bh=cnBwHsIRodoa99w/eOo3riYqdUVnvEAMUk+C6Gflt00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHuxDmXcs+vj7gucd68wG1keUmoMLUQyOWZx615+4ggKx8eRhEtg6kf9637e/Fowv
	 /JWIuOe3me/yzxOjoODN0sYhRJa9VL5/5HcfTop5rS6JaPZvD+ORbUOA2BIO8obn19
	 7EciA70fnMNjCD7R6AVZgX0QKYZXHrCsRdWmNq9oGEKHyVGSfBT3kXpaZokWFpEIW5
	 oDtKvAzvVIhdsYF87O05IjyrnYISzcOM4h9uz1ncHjzvoFgyme3VLoxUhjvwtde353
	 hVVnnGPVDq97PeDPeczZYtqnWS/tnUnyZKr2Axx5oG5b79M7Mx3ZyRVu7Amc2CHh5s
	 Z9q7Qbu1Hg0og==
Date: Mon, 21 Oct 2024 14:58:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-Id: <20241021145810.9a9daec35cb83a04fe10208a@kernel.org>
In-Reply-To: <20241018214300.6df82178@rorschach>
References: <20241018214300.6df82178@rorschach>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 21:43:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The function graph infrastructure allocates a shadow stack for every task
> when enabled. This includes the idle tasks. The first time the function
> graph is invoked, the shadow stacks are created and never freed until the
> task exits. This includes the idle tasks.
> 
> Only the idle tasks that were for online CPUs had their shadow stacks
> created when function graph tracing started. If function graph tracing is
> enabled and a CPU comes online, the idle task representing that CPU will
> not have its shadow stack created, and all function graph tracing for that
> idle task will be silently dropped.
> 
> Instead, use the CPU hotplug mechanism to allocate the idle shadow stacks.
> This will include idle tasks for CPUs that come online during tracing.
> 
> This issue can be reproduced by:
> 
>  # cd /sys/kernel/tracing
>  # echo 0 > /sys/devices/system/cpu/cpu1/online
>  # echo 0 > set_ftrace_pid
>  # echo function_graph > current_tracer
>  # echo 1 > options/funcgraph-proc
>  # echo 1 > /sys/devices/system/cpu/cpu1
>  # grep '<idle>' per_cpu/cpu1/trace | head
> 
> Before, nothing would show up.
> 
> After:
>  1)    <idle>-0    |   0.811 us    |                        __enqueue_entity();
>  1)    <idle>-0    |   5.626 us    |                      } /* enqueue_entity */
>  1)    <idle>-0    |               |                      dl_server_update_idle_time() {
>  1)    <idle>-0    |               |                        dl_scaled_delta_exec() {
>  1)    <idle>-0    |   0.450 us    |                          arch_scale_cpu_capacity();
>  1)    <idle>-0    |   1.242 us    |                        }
>  1)    <idle>-0    |   1.908 us    |                      }
>  1)    <idle>-0    |               |                      dl_server_start() {
>  1)    <idle>-0    |               |                        enqueue_dl_entity() {
>  1)    <idle>-0    |               |                          task_contending() {
> 
> Note, if tracing stops and restarts, the old way would then initialize
> the onlined CPUs.
> 

Looks good to me, except one comment below;

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[...]
>  int register_ftrace_graph(struct fgraph_ops *gops)
>  {
> +	static bool fgraph_initialized;
>  	int command = 0;
>  	int ret = 0;
>  	int i = -1;
>  
>  	mutex_lock(&ftrace_lock);
>  
> +	if (!fgraph_initialized) {
> +		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",

Nit: Maybe it is better to call it as "tracing/fgraph:online" ?

Thank you,

> +					fgraph_cpu_init, NULL);
> +		if (ret < 0) {
> +			pr_warn("fgraph: Error to init cpu hotplug support\n");
> +			return ret;
> +		}
> +		fgraph_initialized = true;
> +		ret = 0;
> +	}
> +
>  	if (!fgraph_array[0]) {
>  		/* The array must always have real data on it */
>  		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
