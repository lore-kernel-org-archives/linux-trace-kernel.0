Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E69A20
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeSUIvLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CD9C433C7;
	Wed, 13 Dec 2023 00:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426777;
	bh=KwtZWAAG5PiyCTGlYkniFka6wa++0vZfqBICOqF8/x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BeSUIvLZ1NoM6V6v7A9nSVVBzoZDVZnOdHQ67v0+NdjoX8h5EgrQZOLC/ktkOdNf6
	 5fFGknlDEt7N6frDoH9SmBCVXcMQQjgsj7gmu91ebRKIf/nimlTTMXzFwB1uvEkGm0
	 A5ivyJOoYitgF9o6XCWGjnnaIh6XXdsnYdvh+yR9pRNJraUbuYx9w9f6gtmKLj4BnK
	 fBr0LhBUZYR+qeC1ooXJP7yF+AGcHlqdDfzdxqZ1Kvga9nUFfurrxWyCt14fBEtjzk
	 c7YAkNN0C0hSZp0eoUCB72pD8WrCcdcM1fAZnT0iOeN2yvknp1ikVxP42U88d2Tw1u
	 jZ8vCVXlT/4qg==
Date: Wed, 13 Dec 2023 09:19:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Have trace_marker break up by lines by size of
 trace_seq
Message-Id: <20231213091933.e3c78e210683b75b9dcbf59f@kernel.org>
In-Reply-To: <20231212190422.1eaf224f@gandalf.local.home>
References: <20231212190422.1eaf224f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 19:04:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If a trace_marker write is bigger than what trace_seq can hold, then it
> will print "LINE TOO BIG" message and not what was written.
> 
> Instead, if check if the write is bigger than the trace_seq and break it

Instead, check if ... ?

> up by that size.
> 
> Ideally, we could make the trace_seq dynamic that could hold this. But
> that's for another time.

I think this is OK, but if possible it is better to be merged with the
"LINE TOO BIG" patch (by updating the version).

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 893e749713d3..2a21bc840fe7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7298,6 +7298,11 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	if (cnt < FAULTED_SIZE)
>  		size += FAULTED_SIZE - cnt;
>  
> +	if (size > TRACE_SEQ_BUFFER_SIZE) {
> +		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
> +		goto again;
> +	}
> +
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    tracing_gen_ctx());
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
