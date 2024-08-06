Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B49146D60;
	Tue,  6 Aug 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973161; cv=none; b=d8IDiwFjpPwhhrXAMOBcimnnZubJFKhxVt/7jt6V9t0Bk0pjHMt/vfihlPI7cm+lM0okveLacidYhNPphkhHBpmycYkDs2kzzktudSfrHG1a3ECwMu2cPUzSfXrTtj8O50/lhjB+KtfDJzB2c7JlkUBzygRsbdVLVQBvFt3w/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973161; c=relaxed/simple;
	bh=fobuBFVm7tP9vWvwnleJQ5ICaKqCFDIsuZQteHTKK5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9c3eUimBWgJjjtHVRlYDOq5FYRVtp2OQrwnhtzSfvoH0XXYCQYPHa7vloNX87Cd1mLuARdR6YOG9iOvcTfyl1kU6yQ7tPRgH/yVlM2civN3UxlHcs3t2WL23GGZcU0XhOuB/cyui3OK9r2IzNAi/Sk4qCCQbvKn49RxbfsBY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCDAC32786;
	Tue,  6 Aug 2024 19:39:19 +0000 (UTC)
Date: Tue, 6 Aug 2024 15:40:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
 <bobule.chang@mediatek.com>, <eric-yc.wu@mediatek.com>,
 <wsd_upstream@mediatek.com>, Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH RESEND] tracing: Fix overflow in get_free_elt()
Message-ID: <20240806154008.502b6c7d@gandalf.local.home>
In-Reply-To: <20240805055922.6277-1-Tze-nan.Wu@mediatek.com>
References: <20240805055922.6277-1-Tze-nan.Wu@mediatek.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 13:59:22 +0800
Tze-nan Wu <Tze-nan.Wu@mediatek.com> wrote:

> "tracing_map->next_elt" in get_free_elt() is at risk of overflowing.
> 
> Once it overflows, new elements can still be inserted into the tracing_map
> even though the maximum number of elements (`max_elts`) has been reached.
> Continuing to insert elements after the overflow could result in the
> tracing_map containing "tracing_map->max_size" elements, leaving no empty
> entries.
> If any attempt is made to insert an element into a full tracing_map using
> `__tracing_map_insert()`, it will cause an infinite loop with preemption
> disabled, leading to a CPU hang problem.
> 
> Fix this by preventing any further increments to "tracing_map->next_elt"
> once it reaches "tracing_map->max_elt".
> 
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
> We have encountered this issue internally after enabling the
> throttle_rss_stat feature provided by Perfetto in background for more than
> two days, during which `rss_stat` tracepoint was invoked over 2^32 times.
> After tracing_map->next_elt overflow, new elements can continue to be 
> inserted to the tracing_map belong to `rss_stat`.
> Then the CPU could hang inside the while dead loop in function
> `__tracing_map_insert()` by calling it after the tracing_map left no empty
> entry.
> 
> Call trace during hang:
>   __tracing_map_insert()
>   tracing_map_insert()
>   event_hist_trigger()
>   event_triggers_call()
>   __event_trigger_test_discard()
>   trace_event_buffer_commit()
>   trace_event_raw_event_rss_stat()
>   __traceiter_rss_stat()
>   trace_rss_stat()
>   mm_trace_rss_stat()
>   inc_mm_counter()
>   do_swap_page()
> 
> throttle_rss_stat is literally a synthetic event triggered by `rss_stat`
> with condition:
>  1. $echo "rss_stat_throttled unsigned int mm_id unsigned int curr int
>     member long size" >> /sys/kernel/tracing/synthetic_events
>  2. $echo
>     'hist:keys=mm_id,member:bucket=size/0x80000:onchange($bucket).rss_stat_
>     throttled(mm_id,curr,member,size)' >
>     /sys/kernel/tracing/events/kmem/rss_stat/trigger
> 
> The hang issue could also be reproduced easily by calling a customize
> trace event `myevent(u64 mycount)` for more than 2^32+(map_size-max_elts)
> times during its histogram enabled with the key set to variable "mycount".
> While we call `myevent` with different argument "mycount" everytime.
> 
> BTW, I added Cheng-jui to Co-developed because we have a lot of discussions
> during debugging this.
> ---
>  kernel/trace/tracing_map.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index a4dcf0f24352..3a56e7c8aa4f 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -454,7 +454,7 @@ static struct tracing_map_elt *get_free_elt(struct tracing_map *map)
>  	struct tracing_map_elt *elt = NULL;
>  	int idx;
>  
> -	idx = atomic_inc_return(&map->next_elt);
> +	idx = atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts);

I guess we need to add (with a comment):

	idx--;

>  	if (idx < map->max_elts) {

Otherwise the max elements will be off by one.

>  		elt = *(TRACING_MAP_ELT(map->elts, idx));

And the index will skip position zero.

-- Steve

>  		if (map->ops && map->ops->elt_init)
> @@ -699,7 +699,7 @@ void tracing_map_clear(struct tracing_map *map)
>  {
>  	unsigned int i;
>  
> -	atomic_set(&map->next_elt, -1);
> +	atomic_set(&map->next_elt, 0);
>  	atomic64_set(&map->hits, 0);
>  	atomic64_set(&map->drops, 0);
>  
> @@ -783,7 +783,7 @@ struct tracing_map *tracing_map_create(unsigned int map_bits,
>  
>  	map->map_bits = map_bits;
>  	map->max_elts = (1 << map_bits);
> -	atomic_set(&map->next_elt, -1);
> +	atomic_set(&map->next_elt, 0);
>  
>  	map->map_size = (1 << (map_bits + 1));
>  	map->ops = ops;

