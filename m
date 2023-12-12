Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7E745E1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12396C433C7;
	Tue, 12 Dec 2023 16:42:00 +0000 (UTC)
Date: Tue, 12 Dec 2023 11:42:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231212114242.53b02d11@gandalf.local.home>
In-Reply-To: <20231212110332.6fca52c4@gandalf.local.home>
References: <20231212110332.6fca52c4@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 11:03:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -7300,9 +7301,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>  	buffer = tr->array_buffer.buffer;
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>  					    tracing_gen_ctx());
> -	if (unlikely(!event))
> +	if (unlikely(!event)) {
> +		/*
> +		 * If the size was greated than what was allowed, then
> +		 * make it smaller and try again.
> +		 */

And I forgot to fix the comment. :-p

-- Steve
