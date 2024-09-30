Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AC1917F2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708104; cv=none; b=VqKBcjgMBVP4JG2ExuKHLlWvzqJCK3HRscwQZSCpBUlMOhJnOZUl+IU7mLloT4NDEmDEaU3UT1K6bSippowU1SqDHnf6zhdS/5iK1zrqPzgp3/4fMKRK4VkYKcKqPvgz/UbfqZfNFog9MT9dwWUw+tFwJe1ez7+OBqj2z/12WqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708104; c=relaxed/simple;
	bh=a5vPzdsten2P2ffAMQmHIusfCCNiu1TFnIjnvY/TPH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0E8OzbyVn/OjTQ4Kie7IJUKyfsW10IMj18QzfHfakyv7LTDhpz/8prkGHb7NkpXkETGw4zuYM6uhvQ8m82pjWGCYUs2IeyZbkP8TSK3f+spLyMB3yHqwhzihL79Tn05TKdjyxw7XtaskOspyWZZKbLjCehxmzS04VvCtdmTYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A175C4CEC7;
	Mon, 30 Sep 2024 14:55:03 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:55:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] function_graph: Improve fgraph LRU data
 initialization
Message-ID: <20240930105550.564d5a67@gandalf.local.home>
In-Reply-To: <20240930071031.3694979-1-liaochang1@huawei.com>
References: <20240930071031.3694979-1-liaochang1@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 07:10:31 +0000
Liao Chang <liaochang1@huawei.com> wrote:

> This patch uses [first ... last] = value to initialize fgraph_array[].
> And use fgraph_lru_next and fgraph_lru_last as the indicator of
> initialization.

The only thing this patch does is to allow the use of [first...last]
annotation for initialization. What actual benefit does that give us?

In other words, why would I want to apply this? Just so that we can use
[first...last] annotation with the added cost of having to manage setting
fgraph_lru_next and fgraph_lru_last to -1 and then comparing them?

Personally, I find the original code easier to maintain, as it's simple and
doesn't add extra management.

-- Steve


> 
> v2->v1:
> Fixup the build error reported by kernel test robot <lkp@intel.com>.
> Since some architectures use ftrace_graph_entry_stub() for the static
> ftrace scenario, then restore the definition without static keyword in
> the original patch [1]. And rebasing patch to next-20240927.
> 
> [1] https://lore.kernel.org/all/20240912111550.1752115-1-liaochang1@huawei.com
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/trace/fgraph.c | 54 +++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f..eb2fbc0338c7 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -172,20 +172,41 @@ enum {
>  DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
>  int ftrace_graph_active;
>  
> -static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
> +int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> +			    struct fgraph_ops *gops)
> +{
> +	return 0;
> +}
> +
> +static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
> +				  struct fgraph_ops *gops)
> +{
> +}
> +
> +static struct fgraph_ops fgraph_stub = {
> +	.entryfunc = ftrace_graph_entry_stub,
> +	.retfunc = ftrace_graph_ret_stub,
> +};
> +
> +static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE] = {
> +	[0 ... FGRAPH_ARRAY_SIZE - 1] = &fgraph_stub,
> +};
>  static unsigned long fgraph_array_bitmask;
>  
>  /* LRU index table for fgraph_array */
>  static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
> -static int fgraph_lru_next;
> -static int fgraph_lru_last;
> +static int fgraph_lru_next = -1;
> +static int fgraph_lru_last = -1;
>  
>  /* Initialize fgraph_lru_table with unused index */
>  static void fgraph_lru_init(void)
>  {
> -	int i;
> +	if ((fgraph_lru_next >= 0) && (fgraph_lru_last >= 0))
> +		return;
>  
> -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
> +	fgraph_lru_next = fgraph_lru_last = 0;
> +
> +	for (int i = 0; i < FGRAPH_ARRAY_SIZE; i++)
>  		fgraph_lru_table[i] = i;
>  }
>  
> @@ -483,22 +504,6 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
>  }
>  #endif
>  
> -int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> -			    struct fgraph_ops *gops)
> -{
> -	return 0;
> -}
> -
> -static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
> -				  struct fgraph_ops *gops)
> -{
> -}
> -
> -static struct fgraph_ops fgraph_stub = {
> -	.entryfunc = ftrace_graph_entry_stub,
> -	.retfunc = ftrace_graph_ret_stub,
> -};
> -
>  static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
>  DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
>  DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
> @@ -1250,12 +1255,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  
>  	mutex_lock(&ftrace_lock);
>  
> -	if (!fgraph_array[0]) {
> -		/* The array must always have real data on it */
> -		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
> -			fgraph_array[i] = &fgraph_stub;
> -		fgraph_lru_init();
> -	}
> +	fgraph_lru_init();
>  
>  	i = fgraph_lru_alloc_index();
>  	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {

