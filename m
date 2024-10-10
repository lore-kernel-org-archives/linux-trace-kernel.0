Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809461E3786;
	Thu, 10 Oct 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603379; cv=none; b=lPj8xeoUCTmjdokNJ9mxxowTnonjp7xfO+f/lcFS3Vhcx/JXLt4a6DboSeZpT7mBYV9Ngyl9wcguCs/Xi1ZACgZRjpK1ItDrCweePy2bh5dWypCw1HW/aDyW2QHjFot/mPmi2Qbqyyu0tsQ0vGT702lINtVJWXaWOXTDsJpQiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603379; c=relaxed/simple;
	bh=tKzeG/jfgL8J8LY9AyU3+IbFtdZr3+soVid8mGX2MDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcLOMLCE4iTbvwK8eWA2sz3lxLfgRjaHxLVbpNZuVUe0/V/FxO4e0WsMAdo+ijfd5fCPYK7dhjfV09jukEupOxuwomurj22IHBdtdXouIQY+NAoGBUQe6ShbJdAVy/nLvVwzThle/0hMe2IHzJ85DoXCsF3bmwOeIXXGYIxBq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20041C4CEC5;
	Thu, 10 Oct 2024 23:36:18 +0000 (UTC)
Date: Thu, 10 Oct 2024 19:36:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, zhengyejian@huaweicloud.com, sfr@canb.auug.org.au,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] function_graph: no need to invoke the function
 call_filter_check_discard
Message-ID: <20241010193626.76e7ff33@gandalf.local.home>
In-Reply-To: <20241010035826.567827-1-dolinux.peng@gmail.com>
References: <20241010035826.567827-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 11:58:26 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> The function call_filter_check_discard has been removed in the
> commit [1].
> 
> [1] https://lore.kernel.org/all/20240911010026.2302849-1-zhengyejian@huaweicloud.com/
> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  kernel/trace/trace_functions_graph.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 3b210e6bcd70..98f347c049d2 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -148,8 +148,7 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
>  	entry->graph_ent.func = trace->func;
>  	entry->graph_ent.depth = trace->depth;
>  	entry->graph_ent.retaddr = retaddr;
> -	if (!call_filter_check_discard(call, entry, buffer, event))
> -		trace_buffer_unlock_commit_nostack(buffer, event);
> +	trace_buffer_unlock_commit_nostack(buffer, event);
>  
>  	return 1;
>  }

This still fails:

kernel/trace/trace_functions_graph.c:140:27: error: unused variable 'call' [-Werror,-Wunused-variable]
  140 |         struct trace_event_call *call = &event_fgraph_retaddr_entry;
      |                                  ^~~~
1 error generated.

I'll just fix it up.

Thanks,

-- Steve
