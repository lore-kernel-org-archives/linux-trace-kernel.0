Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E91F612
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS+9lWp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A81C433C8;
	Mon, 11 Dec 2023 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296868;
	bh=ZmV8Ia6tQOoQryqALYfwSQzG28bMYMh8bIDdDdQzgtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eS+9lWp6lze+Q/NrEuIUBv6mTuFpDlg2/HlEsR7/VQH8qMKf2tk62BTK8CMp39bNj
	 EdkCvUbx9XSH/dHM57bDnUsd2dQoPWzGwM/Tv0y4SRGfGmt+l0kMr849Xup3wGyqkz
	 +eeELeRDTTP7wP8gaK2BRoBdBxftVieU7SHmCrdkgV+PGS0lXiYLvqvSO8/QjIg6JT
	 2ESpNondZeRvJy/CRblaNyTC/lfe3rgfbEZ00XoqsZNSh3bKwMsZelleR4PrADsuLX
	 YXXJ4NdWmi3Jmqy/bk5kH5KHaR9RmZBUGqvu8pMCJE9UpVc/ai4+iYEA9ZJTxpvKmT
	 i5RvFjI0drlBg==
Date: Mon, 11 Dec 2023 21:14:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Increase size of trace_marker_raw to max ring
 buffer entry
Message-Id: <20231211211424.e58f9b9abb9594f671d1d0ed@kernel.org>
In-Reply-To: <20231209175716.09ac455b@gandalf.local.home>
References: <20231209175716.09ac455b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Dec 2023 17:57:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There's no reason to give an arbitrary limit to the size of a raw trace
> marker. Just let it be as big as the size that is allowed by the ring
> buffer itself.
> 
> And there's also no reason to artificially break up the write to
> TRACE_BUF_SIZE, as that's not even used.

Looks good to me.

Reivewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> [
>   Depends on: https://lore.kernel.org/linux-trace-kernel/20231209175003.63db40ab@gandalf.local.home/
> ]
>  kernel/trace/trace.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index da837119a446..077b20e83e7c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7351,9 +7351,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	return written;
>  }
>  
> -/* Limit it for now to 3K (including tag) */
> -#define RAW_DATA_MAX_SIZE (1024*3)
> -
>  static ssize_t
>  tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
>  					size_t cnt, loff_t *fpos)
> @@ -7375,18 +7372,16 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
>  		return -EINVAL;
>  
>  	/* The marker must at least have a tag id */
> -	if (cnt < sizeof(unsigned int) || cnt > RAW_DATA_MAX_SIZE)
> +	if (cnt < sizeof(unsigned int))
>  		return -EINVAL;
>  
> -	if (cnt > TRACE_BUF_SIZE)
> -		cnt = TRACE_BUF_SIZE;
> -
> -	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
> -
>  	size = sizeof(*entry) + cnt;
>  	if (cnt < FAULT_SIZE_ID)
>  		size += FAULT_SIZE_ID - cnt;
>  
> +	if (size > ring_buffer_max_event_size(buffer))
> +		return -EINVAL;
> +
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
>  					    tracing_gen_ctx());
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
