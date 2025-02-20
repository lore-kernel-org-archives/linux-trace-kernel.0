Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07F286291;
	Thu, 20 Feb 2025 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025731; cv=none; b=ErO0kAbNBrzN/0LS43jFZeMnVoJ7e19WQw3llt7iiwONKqxEv2ci7PMlJeAn168BV41m7IIwwQsUsi+BzFOPnkj/1CnbN6/9sdWLnKkgyBQkwHWj++gOiIqOA+K/3laG/NDoFymjFCqO498UUKYvrUVoivw9PTEx/M5b+8TPrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025731; c=relaxed/simple;
	bh=E72o+rqqTE8JfgJn/D0x7UAbb00J5LZDy4139aZCk9g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X05EJe5VWwCp3dP2+SO204FemViyNn9boCxU3WFqQD6Zapn3opYtIXVlevYZ0UkN7PlPR1sYjxHXdD+wlXUDZ9haCgErZL59SpJ1bfOl2vJe2yqg2Waxbms9Wv8eOaBeiZvv1yEbtjw+5DIS9h2RBEo8D0PajsADiMyO/lcjSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR5/eQTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR5/eQTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34135C4CED1;
	Thu, 20 Feb 2025 04:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740025731;
	bh=E72o+rqqTE8JfgJn/D0x7UAbb00J5LZDy4139aZCk9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uR5/eQThy9LLj50nIGethKOOBFCvC4sO0nImncmiEJuTkbW0boby6Jt3P8pFRC8Wi
	 bpAVBG0rpzc7LM/4ZPN6eT2xsN9lE5SEzlBiwc7svty7TxTQgjmaNAc3fKYwuxs87A
	 rt7h5SjvHwe2TYGGpKy1TJB2tqvCPwUXK+/+zYSsYyyilKak0V/4aMbjSyJdwIsgxg
	 wVUCY/5KoTytTrjS8YiV+NOvJiB0fu89fGUOyZHkzhLFQ+YHZvb/Tm0gpY4+WLNcBH
	 ufROED8Q5+gZK0WyBHFfifyj1TBD8C9radsWW9daPcTPVRpXAPkryRpe6QfZuIZOph
	 DOL8zebGkVssA==
Date: Thu, 20 Feb 2025 13:28:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] tracing: Fix memory leak when reading set_event
 file
Message-Id: <20250220132848.eafa42f94b25c6431d43a292@kernel.org>
In-Reply-To: <20250220031528.7373-1-ahuang12@lenovo.com>
References: <20250220031528.7373-1-ahuang12@lenovo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 11:15:28 +0800
Adrian Huang <adrianhuang0701@gmail.com> wrote:

> From: Adrian Huang <ahuang12@lenovo.com>
> 
> kmemleak reports the following memory leak after reading set_event file:
> 
>   # cat /sys/kernel/tracing/set_event
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xff110001234449e0 (size 16):
>   comm "cat", pid 13645, jiffies 4294981880
>   hex dump (first 16 bytes):
>     01 00 00 00 00 00 00 00 a8 71 e7 84 ff ff ff ff  .........q......
>   backtrace (crc c43abbc):
>     __kmalloc_cache_noprof+0x3ca/0x4b0
>     s_start+0x72/0x2d0
>     seq_read_iter+0x265/0x1080
>     seq_read+0x2c9/0x420
>     vfs_read+0x166/0xc30
>     ksys_read+0xf4/0x1d0
>     do_syscall_64+0x79/0x150
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The issue can be reproduced regardless of whether set_event is empty or
> not. Here is an example about the valid content of set_event.
> 
>   # cat /sys/kernel/tracing/set_event
>   sched:sched_process_fork
>   sched:sched_switch
>   sched:sched_wakeup
>   *:*:mod:trace_events_sample
> 
> The root cause is that s_next() returns NULL when nothing is found.
> This results in s_stop() attempting to free a NULL pointer because its
> parameter is NULL.
> 
> Fix the issue by freeing the memory appropriately when s_next() fails
> to find anything.
> 
> Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
> Changelog v2:
>  - Per Steven's suggestion: Add a comment to describe why to free memory
>    in s_next().
>  - Per Steven's suggestion: Change the variable 'p' to 'v' in s_stop()
> 
> ---
>  kernel/trace/trace_events.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 4cb275316e51..513de9ceb80e 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1591,6 +1591,13 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
>  		return iter;
>  #endif
>  
> +	/*
> +	 * The iter is allocated in s_start() and passed via the 'v'
> +	 * parameter. To stop the iterator, NULL must be returned. But
> +	 * the return value is what the 'v' parameter in s_stop() receives
> +	 * and frees. Free iter here as it will no longer be used.
> +	 */
> +	kfree(iter);
>  	return NULL;
>  }
>  
> @@ -1667,9 +1674,9 @@ static int s_show(struct seq_file *m, void *v)
>  }
>  #endif
>  
> -static void s_stop(struct seq_file *m, void *p)
> +static void s_stop(struct seq_file *m, void *v)
>  {
> -	kfree(p);
> +	kfree(v);
>  	t_stop(m, NULL);
>  }
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
