Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAABD531;
	Tue, 27 May 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748387666; cv=none; b=Fin9G4+ftwZKg+wTTH2HDK0ZlgyjKejeBsZa8ML4p7w3DqsnZ7Dpw9XX/KWyN5QImz0OrphEyubHKfB1kAvILvhZ5iBTE5gmnXCt4U1nU1ClfEDa5zNwJXUjV5l2zBzbua8HF1C+4HI7bVZtCxB5vDgM5djHzJpuZqWVSLraZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748387666; c=relaxed/simple;
	bh=MsKGKfos+sWS/J61Jv507wPdYXiHp7tgmGBKaw82dqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAX34sGmU1BkjSxwRALmG2u28z1WVHQuqGR/Xp6W2lgcuo4HYzvO/pbMMvhsRxtE36pnp1s4QgzznbwobvauTs15wt2U/0PpmlxajajNIISgoa3LAD041bPWTcZ1Gg0XMf7V73c+NNt4i9KmoDmOCWA6as0p3Www9uyYf/UMh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37188C4CEE9;
	Tue, 27 May 2025 23:14:25 +0000 (UTC)
Date: Tue, 27 May 2025 19:15:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rafal Bilkowski <rafalbilkowski@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Protect trace_iter_expand_format against
 overflow and ZERO_SIZE_PTR
Message-ID: <20250527191523.15453dae@gandalf.local.home>
In-Reply-To: <20250519070240.256200-1-rafalbilkowski@gmail.com>
References: <20250519070240.256200-1-rafalbilkowski@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 09:02:40 +0200
Rafal Bilkowski <rafalbilkowski@gmail.com> wrote:

> Add a check in trace_iter_expand_format to prevent integer overflow when
> calculating the new format buffer size, and to handle the case where krealloc
> returns ZERO_SIZE_PTR. This improves robustness and prevents potential
> memory corruption or kernel crashes.

What exactly is this trying to protect?

> 
> Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
> ---
>  kernel/trace/trace.c        | 4 ++++
>  kernel/trace/trace_output.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5b8db27fb6ef..637bd1ff9325 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3596,6 +3596,10 @@ char *trace_iter_expand_format(struct trace_iterator *iter)
>  	if (!iter->tr || iter->fmt == static_fmt_buf)
>  		return NULL;
>  
> +	/* Protection against overflow and ZERO_SIZE_PTR returned from krealloc */
> +	if (check_add_overflow(iter->fmt_size, STATIC_FMT_BUF_SIZE, &iter->fmt_size))
> +		return NULL;

This will *NEVER* happen!

The fmt_size is initialized as STATIC_FMT_BUF_SIZE, and this is the only
function that increases it, and that happens *only* if the krealloc() succeeds.

For this to happen, then the krealloc must have allocated something that
would allow the format size to be INT_MAX, which krealloc would fail much
earlier than that.

Not to mention, the formats can't be more that the sub-buffer size, which
is by default 4K and can be at most 64K. Way smaller than INT_MAX.

> +
>  	tmp = krealloc(iter->fmt, iter->fmt_size + STATIC_FMT_BUF_SIZE,
>  		       GFP_KERNEL);
>  	if (tmp) {
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index b9ab06c99543..42560027001a 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -979,6 +979,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
>  							  iter->fmt_size);
>  			if (ret < 0)
>  				trace_seq_printf(&iter->seq, "(0x%px)", pos);
> +			else if (ret == 0)
> +				trace_seq_printf(&iter->seq, "(0x%px:<NULL>)", pos);

This part I'm OK with adding.

-- Steve

>  			else
>  				trace_seq_printf(&iter->seq, "(0x%px:%s)",
>  						 pos, iter->fmt);

