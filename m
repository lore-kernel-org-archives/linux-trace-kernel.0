Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D123CB;
	Wed, 28 May 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392279; cv=none; b=JZSLO+RHI3EETy27afEgN2cLaLYXT9kfwDx4nvRwFoZIyKkdeAQ7LZdTCiKF2k0P75xXaoGHs2Hp0G1culWZdhBa6mlM0qijUuzZbGNJcN6XB1gmugOFrwXda9pAbEk4QYOxOrpXQWyK/NZ2Rjith/oi//vx5h78Z1i1QfEELiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392279; c=relaxed/simple;
	bh=M6A45JnFOKhyL13s3EAIlzuklRV8jx57NggH6mzCtGg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=owuoTxa4OIlpyJYX3mxlsQUEOASinCqAK2xNdWXzIXZf3p6CuguzSmjBSVSjeGmmCAjSrjI9J5JucVchMXHD+SDn88qazlRpMwvyClxF3hsSKOkfgEPecyoM5z4bleWraiooetINsegg73IdkcBQPDjG5TLhrGuYLw1lELohk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhFa+PSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhFa+PSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34089C4CEE9;
	Wed, 28 May 2025 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392279;
	bh=M6A45JnFOKhyL13s3EAIlzuklRV8jx57NggH6mzCtGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhFa+PSf8KqoIrFCRUq2WFGiIZ+oYlFl1KbnEQyj414uHH7iG4MQDU2ecb9Cp/8f4
	 70WgrBeA8p9nwH6Huwcgvv+b/3d7Drmn74W1pDtH+FYkSQYRfpeJtA+0mDqCNHF2Go
	 6mdQYTzoODUKr6PB6/pROqQQBsNiFGyONgROqU5Ik4e5+NPk4bn/0K8vvzhAPBKLpn
	 +GlKjhcpKTvITvpI+y2ZedpmSKwM0ZXNhQpIPApTNjSiaf14Il2yfFkLjbZw4mxw8k
	 tiA+pUo2+t6VZpQ43BqE66d/jIfrUzfdPuCosENF084M3zNP/rjzjOZgudGauKodeV
	 vtQDhlJVL/aBQ==
Date: Wed, 28 May 2025 09:31:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify ring_buffer_read_page() with
 guard()
Message-Id: <20250528093116.2451fe1b1ebad2f457594c57@kernel.org>
In-Reply-To: <20250527145216.0187cf36@gandalf.local.home>
References: <20250527145216.0187cf36@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 14:52:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The function ring_buffer_read_page() had two gotos. One was simply
> returning "ret" and the other was unlocking the reader_lock.
> 
> There's no reason to use goto to simply return the "ret" variable. Instead
> just return the value.
> 
> The jump to the unlocking of the reader_lock can be replaced by
> guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock).
> 
> With these two changes the "ret" variable is no longer used and can be
> removed. The return value on non-error is what was read and is stored in
> the "read" variable.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 0b21d64e90c8..897ce51d3bbf 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6535,38 +6535,37 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	struct buffer_data_page *bpage;
>  	struct buffer_page *reader;
>  	unsigned long missed_events;
> -	unsigned long flags;
>  	unsigned int commit;
>  	unsigned int read;
>  	u64 save_timestamp;
> -	int ret = -1;
>  
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> -		goto out;
> +		return -1;
>  
>  	/*
>  	 * If len is not big enough to hold the page header, then
>  	 * we can not copy anything.
>  	 */
>  	if (len <= BUF_PAGE_HDR_SIZE)
> -		goto out;
> +		return -1;
>  
>  	len -= BUF_PAGE_HDR_SIZE;
>  
>  	if (!data_page || !data_page->data)
> -		goto out;
> +		return -1;
> +
>  	if (data_page->order != buffer->subbuf_order)
> -		goto out;
> +		return -1;
>  
>  	bpage = data_page->data;
>  	if (!bpage)
> -		goto out;
> +		return -1;
>  
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>  
>  	reader = rb_get_reader_page(cpu_buffer);
>  	if (!reader)
> -		goto out_unlock;
> +		return -1;
>  
>  	event = rb_reader_event(cpu_buffer);
>  
> @@ -6600,7 +6599,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		if (full &&
>  		    (!read || (len < (commit - read)) ||
>  		     cpu_buffer->reader_page == cpu_buffer->commit_page))
> -			goto out_unlock;
> +			return -1;
>  
>  		if (len > (commit - read))
>  			len = (commit - read);
> @@ -6609,7 +6608,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		size = rb_event_ts_length(event);
>  
>  		if (len < size)
> -			goto out_unlock;
> +			return -1;
>  
>  		/* save the current timestamp, since the user will need it */
>  		save_timestamp = cpu_buffer->read_stamp;
> @@ -6667,7 +6666,6 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		if (reader->real_end)
>  			local_set(&bpage->commit, reader->real_end);
>  	}
> -	ret = read;
>  
>  	cpu_buffer->lost_events = 0;
>  
> @@ -6694,11 +6692,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	if (commit < buffer->subbuf_size)
>  		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
>  
> - out_unlock:
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> -
> - out:
> -	return ret;
> +	return read;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_read_page);
>  
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
