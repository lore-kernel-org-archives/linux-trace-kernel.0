Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158E381C2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080958; cv=none; b=f6Oy4E+eDGPe+w9sJS2R6qaAzPfv3TF7awR6uS6C2z7bNPiLL9hcOIM1SOZZ84J54OfZh9OjiqJeybilx2jfPZKQzGMAN1M5tIOx2Bggg1nCJAFrpV1mwcSpxcqtdpZGwCodPyfNvXyuaGgQBf2W/60LGKnCblpANkGdAFjX9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080958; c=relaxed/simple;
	bh=UDUMuejQybUaJH1a5uYtfSKi7sLSZysE1PEhP7+fMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0zd7ixI5otIUQ8Qgo0IkK5cQNtRmRFq6TBmqih6jCAEnoGiRVEOK6gS5fM32JaGF6zLEhIHMNKjNzxtTN8DOU0UzHfN8cL0xb8Iqs6iDJ15iDUIa4KFhZtbqPC/H8gW5oQnnGERfsF8swrN0nmE04bSMTvi6Siv06JivGg4nX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23373C4AF0F;
	Mon, 19 Aug 2024 15:22:37 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:23:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Chen <me@linux.beauty>
Cc: linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ftrace: Use this_cpu_ptr() instead of
 per_cpu_ptr(smp_processor_id())
Message-ID: <20240819112301.7c178eff@gandalf.local.home>
In-Reply-To: <87y14t6ofi.wl-me@linux.beauty>
References: <87y14t6ofi.wl-me@linux.beauty>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 14:01:53 +0800
Li Chen <me@linux.beauty> wrote:

> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Use this_cpu_ptr() instead of open coding the equivalent in various
> ftrace functions.

Thanks.

This code was written (2009) before this_cpu_ptr() was introduced (2010).

-- Steve

> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  kernel/trace/trace_functions.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index 3b0cea37e0297..65fed0bbc5c22 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -184,7 +184,6 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  	struct trace_array_cpu *data;
>  	unsigned int trace_ctx;
>  	int bit;
> -	int cpu;
>  
>  	if (unlikely(!tr->function_enabled))
>  		return;
> @@ -195,8 +194,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  
>  	trace_ctx = tracing_gen_ctx();
>  
> -	cpu = smp_processor_id();
> -	data = per_cpu_ptr(tr->array_buffer.data, cpu);
> +	data = this_cpu_ptr(tr->array_buffer.data);
>  	if (!atomic_read(&data->disabled))
>  		trace_function(tr, ip, parent_ip, trace_ctx);
>  
> @@ -300,7 +298,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	unsigned int trace_ctx;
>  	unsigned long flags;
>  	int bit;
> -	int cpu;
>  
>  	if (unlikely(!tr->function_enabled))
>  		return;
> @@ -309,8 +306,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		return;
>  
> -	cpu = smp_processor_id();
> -	data = per_cpu_ptr(tr->array_buffer.data, cpu);
> +	data = this_cpu_ptr(tr->array_buffer.data);
>  	if (atomic_read(&data->disabled))
>  		goto out;
>  
> @@ -321,7 +317,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	 * TODO: think about a solution that is better than just hoping to be
>  	 * lucky.
>  	 */
> -	last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
> +	last_info = this_cpu_ptr(tr->last_func_repeats);
>  	if (is_repeat_check(tr, last_info, ip, parent_ip))
>  		goto out;
>  

