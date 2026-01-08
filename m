Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC6500942;
	Thu,  8 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883478; cv=none; b=slc5Z2Ja2iOPZlJdP1+dtLNQVrqcxTZXG+FMZcsDVJBjZEjIsB+z4uqvMOW3slfM2aBdfzHvc/OqLMJLD5f2MrQIWJuT83Iz19T4BR9fgJ+KRNFp1/ewKfBG4ax5y1Iwid7hbNr2VHOrlvWT54TEaV6WZuCJhLULSigbGQxThp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883478; c=relaxed/simple;
	bh=h26F11PgNQuCwDzr9W+5zeXwLBX2W89RHkDerVNEuRA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HVviNAarsDTq2mj116LuqfeRPzSFylKL+dkUycmSaYSLR9h+vgsR/0/iKIG9oRLZslA9vnBJsuEU3skW6w/vrPHRMtZth59z2aYf1RQ1mJ/ZTC+rXz7REIWZsvqDLvlr11mdXlGzFZJqWnS2QNYWIVfOhkCEPgJahtuudvg8Wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvzYGCVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvzYGCVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A6C16AAE;
	Thu,  8 Jan 2026 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767883478;
	bh=h26F11PgNQuCwDzr9W+5zeXwLBX2W89RHkDerVNEuRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WvzYGCVL6qBZYieziNGmeADDEedq3FkdAvx+5nPjP4KVLdcLWtmrJVFtIXMT3F/zp
	 DZVdn9bzfP1PmSpWVkxu3YdSDPEvd7me3vsvL4z+1syOLcInJrA/DEjhSVqRFSLQwf
	 STWHMmn09QXIvE/Go5FZxNIOzrVzVwEPCeFg2WBcktPCfiC3iMRofAYdVOV5pB4p0F
	 K9gtntJB+pNVI9ASOuGFrOPJVDo25RJhUwuOnO5m9fFGEd3263KiZ25tis5WSELUgf
	 GpGePomcW0rpA2qrDPPJNyLralLDKKz4jqaxy7sTY3nI3NUlEimhXNIy5VcvXaJtIq
	 xxCFzdhOi6+lw==
Date: Thu, 8 Jan 2026 23:44:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Li Zhong <floridsleeves@gmail.com>
Subject: Re: [PATCH] tracing: Check the return value of
 tracing_update_buffers()
Message-Id: <20260108234435.c848eb17889b760f42c435aa@kernel.org>
In-Reply-To: <20260107161510.4dc98b15@gandalf.local.home>
References: <20260107161510.4dc98b15@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 16:15:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In the very unlikely event that tracing_update_buffers() fails in
> trace_printk_init_buffers(), report the failure so that it is known.
> 
> Link: https://lore.kernel.org/all/20220917020353.3836285-1-floridsleeves@gmail.com/

Good catch! Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Suggested-by: Li Zhong <floridsleeves@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2d387d56dcd4..1722e01e2238 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3418,9 +3418,10 @@ void trace_printk_init_buffers(void)
>  	pr_warn("**********************************************************\n");
>  
>  	/* Expand the buffers to set size */
> -	tracing_update_buffers(&global_trace);
> -
> -	buffers_allocated = 1;
> +	if (tracing_update_buffers(&global_trace) < 0)
> +		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
> +	else
> +		buffers_allocated = 1;
>  
>  	/*
>  	 * trace_printk_init_buffers() can be called by modules.
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
