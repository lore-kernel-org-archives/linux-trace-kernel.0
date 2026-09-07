Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0D39658D;
	Mon,  7 Sep 2026 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792369; cv=none; b=QnWn5SJmBjGGuBwzGq3fi62wsLTq71yLXehQMRW4dqeP6BmphjbW8pR3/6d4jr+dRuS1suT9XiD9HQpDvBnyLqj/ELTvcdYUIbvUb4h/BqZgYJvUJUrdS8gOqVcsqLybs1SjgRRF/irHQYXdDt6E89yyYCDY+ajDoxYMFzq5F0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792369; c=relaxed/simple;
	bh=8J6XlDIYM45w0hP7LqPqPaG0Z9bEmbVnLUdbOvMLDsg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k5UAJeSCrqcnbxJYws554wylYoOyy4V/657TcZNTWILxDS/5toegkS91gfAyXzg0vzUOBChtFZdwvdqNkK615JYzPXiozKcSsgZIHIyuytoAlaupUP5OQzuhOgAbl15BHNITahhA8VoknM78Wh8cGGivPkHMbCQTs+c4Os9UDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZszmMU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZszmMU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C61F00A3A;
	Mon,  7 Sep 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792367;
	bh=PpKyhZZuh92elO9qMdcxwvzxJ5xSQbUw+4KbMZWTxwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TZszmMU9cOh+kPDwrDer7BL4LApl9x27qJ7eRVwZAHYodEjXspe+IhMfZ8Z36TQ7t
	 eD+1m+zJimUQ9TyUkUdICvSERWzGahVjo6AHq9cp3rI3kIdJHixLgNMKFrDJYmwYu2
	 FIToT/mC1zPFuVK1fX+UyjQLhg/9OAU7T2Aah3setGw017+hxb7YFqZHmyfAMRyM4Q
	 iB0vMxAwfGSMiLuqxztrdNhYU0hn1fDtGYuCOS1M+i/O4UR/QMzVUgDGSSEziErxp9
	 02txE0kX5VubZ8T4yUFLfPhwq405kiiSSoMwpGNHgHS1lnB5+Nb8sv0qpQludTeYRZ
	 bcwg6L7hWxb/Q==
Date: Mon, 7 Sep 2026 23:46:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: hist: keep the entry count when the stats
 allocation fails
Message-Id: <20260907234604.f74c18e068255222b51ee0cf@kernel.org>
In-Reply-To: <20260907060323.480728-1-donggeunyoo.kernel@gmail.com>
References: <20260907060323.480728-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 15:03:23 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> print_entries() uses n_entries both as the number of sort entries and as
> its own return value, so the -ENOMEM it stores when the stats allocation
> fails overwrites the count that the cleanup still needs:
> 
> 	n_entries = tracing_map_sort_entries(map, ...);
> 	if (n_entries < 0)
> 		return n_entries;
> 	...
> 			if (!stats) {
> 				n_entries = -ENOMEM;
> 				goto out;
> 			}
> 	...
>  out:
> 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
> 
> tracing_map_destroy_sort_entries() takes an unsigned int and loops up to
> it, so -ENOMEM arrives as 4294967284. It walks an array of at most
> map->max_elts pointers and calls destroy_sort_entry(), which dereferences
> and frees, on whatever lies past the end.
> 
> Reading the hist file of a trigger with a .percent value, with that
> allocation forced to fail:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in tracing_map_destroy_sort_entries+0xa0/0xb0
>   Read of size 8 at addr ffffc90000045000 by task init/1
>    tracing_map_destroy_sort_entries+0xa0/0xb0
>    hist_show+0x6f7/0x1df0
>    seq_read_iter+0x2b8/0x1190
>    vfs_read+0x176/0xa40
>   The buggy address belongs to a 4-page vmalloc region starting at
>   ffffc90000041000 allocated at tracing_map_sort_entries+0x5c/0xd50
> 
> A few pages further the fault is fatal. The registers at the oops confirm
> the bound: the loop's end pointer less the array start, over the pointer
> size, is 4294967284.
> 
> Return the error in a separate variable and leave n_entries holding the
> count, the way tracing_map_sort_entries() does on its own error path.
> 
> The stats block is only entered for a value carrying .percent or .graph,
> which __create_val_field() has rejected since v6.3, so this cannot be
> reached in mainline as it stands. It becomes reachable again with
> "tracing: hist: let values keep the percent and graph modifiers", so it
> should be applied first.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
> Cc: stable@vger.kernel.org
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Reproduced under QEMU x86_64 on 1fc5a74b108f, with the percent/graph patch
> applied so the block is reachable and with the stats allocation forced to
> fail. Before this change the read of the hist file never returns: KASAN
> reports the vmalloc-out-of-bounds quoted above and the kernel then takes a
> fatal page fault. After it the read returns, the histogram prints its
> header with no rows, and KASAN is silent.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20260907052113.430818-1-donggeunyoo.kernel@gmail.com/
> 
>  kernel/trace/trace_events_hist.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 963e0d6b61fd..67f324d7dc78 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5690,7 +5690,7 @@ static int print_entries(struct seq_file *m,
>  {
>  	struct tracing_map_sort_entry **sort_entries = NULL;
>  	struct tracing_map *map = hist_data->map;
> -	int i, j, n_entries;
> +	int i, j, n_entries, ret;
>  	struct hist_val_stat *stats = NULL;
>  	u64 val;
>  
> @@ -5700,6 +5700,8 @@ static int print_entries(struct seq_file *m,
>  	if (n_entries < 0)
>  		return n_entries;
>  
> +	ret = n_entries;
> +
>  	/* Calculate the max and the total for each field if needed. */
>  	for (j = 0; j < hist_data->n_vals; j++) {
>  		if (!(hist_data->fields[j]->flags &
> @@ -5708,7 +5710,7 @@ static int print_entries(struct seq_file *m,
>  		if (!stats) {
>  			stats = kzalloc_objs(*stats, hist_data->n_vals);
>  			if (!stats) {
> -				n_entries = -ENOMEM;
> +				ret = -ENOMEM;
>  				goto out;
>  			}
>  		}
> @@ -5729,7 +5731,7 @@ static int print_entries(struct seq_file *m,
>  out:
>  	tracing_map_destroy_sort_entries(sort_entries, n_entries);
>  
> -	return n_entries;
> +	return ret;
>  }
>  
>  static void hist_trigger_show(struct seq_file *m,
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
