Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457351BD9C9;
	Wed, 25 Mar 2026 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397857; cv=none; b=LAD+a+myrPn4Zu66RQcKPkni6ZcN2duWBUnxLd74CRbxFM4IgST7XOPAZFvr96lXNqbYQA9ZSin/Y3oLafsHStqpmtQQHLpFzkAjLWlVWlcOTriOyLkZySxasLIIHlB4mayTCiBdAk+UjM1HQLxWqO6O3jhmFciv2FUECc/OPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397857; c=relaxed/simple;
	bh=oDTovl9DbOW/Nj+6vldYb5qJYmAaw3JDozdSCELO6yU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KQgyQB0h2dg6GAHgXHc5Iblm4UwTzvLLg5MZ4bKGULlVajgjnj/h5Ge3TUybcLP6irLy3ODWc2b4tvktaOydHwgVU8zxbA+5mWyr2pXLkzwDhu51UfB1kqbPcxVr0d707xlNPcaeYk+20RdWKwxpeijv6fICxd0EAuAvTWweMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVQDQXUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVQDQXUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE3C19424;
	Wed, 25 Mar 2026 00:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774397856;
	bh=oDTovl9DbOW/Nj+6vldYb5qJYmAaw3JDozdSCELO6yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVQDQXUhyqq42r635kDpBr+ffGVMNDO5s7ivss79OZaMqOpap9f2IE4Woe85c5A7q
	 x8mhnhV6vB0m8cJKJb1gDKmn3HmQqkzkpqLDBslrRiYbcmDd99oCzqhRF5OTugEa+x
	 2zJblG02Qn1KnTBsLj2BfZp724935pERM/B4OF/vU0KNQ35Ga8BE7VzNDcTqIufMtV
	 tXMCnjB6aH/pQJOrmjsfnSTvGSRk3rGR3liVdSA4j8U5uFtro4jNiyyC2/CaWF94Zh
	 HNhUu9uFyXmtjIugrQHgKMMQrACNxAZdlc8Yxnbg+60GrC3vi18ucb0MhkFaEuFbK4
	 4OS9VamlcrM8A==
Date: Wed, 25 Mar 2026 09:17:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Show what clock function is used on
 timestamp errors
Message-Id: <20260325091734.c7b2d3769d614e413fc59597@kernel.org>
In-Reply-To: <20260323202212.479bb288@gandalf.local.home>
References: <20260323202212.479bb288@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 20:22:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The testing for tracing was triggering a timestamp count issue that was
> always off by one. This has been happening for some time but has never
> been reported by anyone else. It was finally discovered to be an issue
> with the "uptime" (jiffies) clock that happened to be traced and the
> internal recursion caused the discrepancy. This would have been much
> easier to solve if the clock function being used was displayed when the
> error was detected.
> 
> Add the clock function to the error output.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 170170bd83bd..a99d1c7d180b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4435,18 +4435,20 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
>  	ret = rb_read_data_buffer(bpage, tail, cpu_buffer->cpu, &ts, &delta);
>  	if (ret < 0) {
>  		if (delta < ts) {
> -			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
> -					   cpu_buffer->cpu, ts, delta);
> +			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld clock:%pS\n",
> +					   cpu_buffer->cpu, ts, delta,
> +					   cpu_buffer->buffer->clock);
>  			goto out;
>  		}
>  	}
>  	if ((full && ts > info->ts) ||
>  	    (!full && ts + info->delta != info->ts)) {
> -		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
> +		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\ntrace clock:%pS",
>  				   cpu_buffer->cpu,
>  				   ts + info->delta, info->ts, info->delta,
>  				   info->before, info->after,
> -				   full ? " (full)" : "", show_interrupt_level());
> +				   full ? " (full)" : "", show_interrupt_level(),
> +				   cpu_buffer->buffer->clock);
>  	}
>  out:
>  	atomic_dec(this_cpu_ptr(&checking));
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
