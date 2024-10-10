Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB851CBEA8;
	Thu, 10 Oct 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572547; cv=none; b=EfYIyfD5AVpX/7gRr3TtI7TBTjqXX1MsgpNIptwdvzLpuHv/fbP2P2MFF7JVt9x2C0F/fcNnWEVw0L8uOi5Bt06OYU/Jsgm2wPiCH00iJP9+F8PoXpqdDw2qiuVVkoFWjDN1H99VOpqvgYjcqYYXVCrgGvLXUPVoRZQ7Mig5NAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572547; c=relaxed/simple;
	bh=45YCwc//nGmPsU/f0Iqt9H9vI32dOjKX+gTMhd9p4wM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lji3tJNc1LR6WtXXQnu9DtjC99pTB50f24lQ+hmzlh4nwDwTa2VAbx972mqh5DvpPvV68W4zO+UwfsX4CRWrWW/W9k978eEZJ7DJmexGJQkOHLbhmVbgSnr8AAF1TOyiyuOI/loQ52jbSK3/EvCQLxP+NVIq6OHg6reTOkhZfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEACBC4CECE;
	Thu, 10 Oct 2024 15:02:25 +0000 (UTC)
Date: Thu, 10 Oct 2024 11:02:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix function name for trampoline
Message-ID: <20241010110233.4f9bdc34@gandalf.local.home>
In-Reply-To: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
References: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

This is not reliable. The output is called when the user reads the trace
file and the ops may no longer exist.

The only way to test this is if you call it during the trace. Yes it may
slow things down a little, but it will be accurate.

-- Steve


> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);
> +			trace_seq_putc(s, '\n');
> +			continue;
> +		}
>  		seq_print_ip_sym(s, (*p) + delta, flags);
>  		trace_seq_putc(s, '\n');
>  	}

