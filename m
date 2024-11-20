Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01C1A9B5A;
	Wed, 20 Nov 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114311; cv=none; b=luwAY+ashwCwnKE1y8objz1CnclJWzmtGyYiqKHiI2g45meZLXspwYkl/jQWz6PPkeXK2Aim/UZTfH7w0CHowprcPOYcFplV9ioSPXc1+yY2/AU0bzCovkRdn4IN62qcBZPE4wVFdGfmilgwR096mibVCcW/uILIiNlrgX+HyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114311; c=relaxed/simple;
	bh=U+A6YOKxmhKh1xHUKOJMiURI3ezd9XaHKZIkgUass3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws+6HIXFDezmkuoskM6e+kdysBvaEfD3vEGan2B//dD2fZigi6bCuGNrAJrX9nF/lXf3+TI6Vei+lf3M/KhHh1jb1MSWbgoXX+l9X2YO0Ms/fsrjBKwc2z7kqbhZnSjpSYQ8ULf25i+pJJleo92TXZH5OqEJZaqrWPVWMfLFq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369ACC4CECD;
	Wed, 20 Nov 2024 14:51:50 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:52:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: guoweikang <guoweikang.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix regression with module command in
 stack_trace_filter
Message-ID: <20241120095225.37fe4655@gandalf.local.home>
In-Reply-To: <20241120052750.275463-1-guoweikang.kernel@gmail.com>
References: <20241120052750.275463-1-guoweikang.kernel@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 13:27:49 +0800
guoweikang <guoweikang.kernel@gmail.com> wrote:

> When executing the following command:
> 
>     # echo "write*:mod:ext3" > /sys/kernel/tracing/stack_trace_filter
> 
> The current mod command causes a null pointer dereference. While commit
> 0f17976568b3f ("ftrace: Fix regression with module command in stack_trace_filter")
> has addressed part of the issue, it left a corner case unhandled, which still
> results in a kernel crash.

Ouch!

Thanks, I'll also mark this as stable.

-- Steve

> 
> Signed-off-by: guoweikang <guoweikang.kernel@gmail.com>
> ---
>  kernel/trace/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 71e53eaba8bc..9b17efb1a87d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5093,6 +5093,9 @@ ftrace_mod_callback(struct trace_array *tr, struct ftrace_hash *hash,
>  	char *func;
>  	int ret;
>  
> +	if (!tr)
> +		return -ENODEV;
> +
>  	/* match_records() modifies func, and we need the original */
>  	func = kstrdup(func_orig, GFP_KERNEL);
>  	if (!func)

