Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB681CC88F;
	Thu, 10 Oct 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572630; cv=none; b=Lbr7U9lQEFmRVZArIp5PHsq8hwVnVasowjByyXmTW+1JwD77O/aJe3jPXxRDOR1cHfCOUjkqWShP588b7VqJPSy3xU8+o+Ugrvr40RuD3Af1N3cx6wSIKAJW/oDZxHdXNVZoALsC7U8lJmg4/QENnG7VAiL4EXvaOXZ/bbMFtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572630; c=relaxed/simple;
	bh=TWFU0C6rsLuYEF4R+l0rttKWu6E5GxvtM4XdY3cjoSE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YP8pGmsNL7lEbD3gh48z3FC+JrIZrf6zM/bpMS9XswWbLljdgEFYtk/RfqY8svEakigN3Olx4gGPJu7ea+FEXduiR/8Oe8wAIV2XTXIU95hhUyekcY1ss5pBlURI/AHII1k+t4NzMPx5uRtrYuutvJQJEfgw57ZKi9ZhYgjsnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlWs5Q0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlWs5Q0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5730C4CEC5;
	Thu, 10 Oct 2024 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728572630;
	bh=TWFU0C6rsLuYEF4R+l0rttKWu6E5GxvtM4XdY3cjoSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BlWs5Q0lOtbwvcdvdw0ADP4HpXG3a/cL9vIZ8+tFdscavbFcAo26kbAAV5iwtG8s7
	 X+jF/+q3YofiHlefSN+2FU+bxHZuH00pBUPwvzNnJP6FX5jpHMJn7cdmwRKlpmojM7
	 NoUO04Wk6Ypu41VIwEn9eE9HvfQMfOFKk2akaEHw9oSGWVwk6b7Lbg6BwyxHRTsQ6Y
	 8Sz4ma7Hc4/wuotYAL2RFWmewu+LCsYf32DKczRQdyo3IErAnSa34EqANYyLxJK0tb
	 2HEU8N7KU8BOo3qc/x3xR40dYjWJeb5TZeiRTJ6bX0kq2pQyUd3SPGn/wjKOXXWt46
	 bZ1Y5BJmw75CQ==
Date: Fri, 11 Oct 2024 00:03:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix function name for trampoline
Message-Id: <20241011000347.4b16dc96221873388475cb40@kernel.org>
In-Reply-To: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
References: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 22:02:59 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> The issue that unrelated function name is shown on stack trace like
> following even though it should be trampoline code address is caused by
> the creation of trampoline code in the area where .init.text section
> of module was freed after module is loaded.
> 
> bash-1344    [002] .....    43.644608: <stack trace>
>   => (MODULE INIT FUNCTION)
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> 
> To resolve this, when function address of stack trace entry is in
> trampoline, output without looking up symbol name.
> 
> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
> ---
>  kernel/trace/trace_output.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 868f2f912f28..32a0858373e2 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1246,6 +1246,11 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>  			break;
>  
>  		trace_seq_puts(s, " => ");
> +		if (is_ftrace_trampoline((*p) + delta)) {
> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);

If we know that address is the ftrace trampoline, we'd better show something
like "[FTRACE TRAMPOLINE]"

> +			trace_seq_putc(s, '\n');

And this is not needed. So for example,

			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");

is enough.

> +			continue;
> +		}
>  		seq_print_ip_sym(s, (*p) + delta, flags);
>  		trace_seq_putc(s, '\n');
>  	}

Thank you,

> -- 
> 2.46.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
