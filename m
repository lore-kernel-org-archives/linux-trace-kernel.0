Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AB5101A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ADBC433C8;
	Mon, 11 Dec 2023 18:27:57 +0000 (UTC)
Date: Mon, 11 Dec 2023 13:28:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-ID: <20231211132837.24488ec1@gandalf.local.home>
In-Reply-To: <20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
References: <20231209175220.19867af4@gandalf.local.home>
	<20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 21:46:27 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > By increasing the trace_seq buffer to almost two pages, it can now print
> > out the first line.
> > 
> > This also subtracts the rest of the trace_seq fields from the buffer, so
> > that the entire trace_seq is now PAGE_SIZE aligned.  
> 
> Ok, but I just a bit concern about the memory consumption.
> Since this is very specific case, can we make it configurable later?

I was concerned about this too, but it looks like it's allocated and later
freed in every location except for a couple of instances.

One is "tracepoint_print_iter" which is used to pipe tracepoints to printk.
I think we can possibly make that allocated too.

The other is in ftrace_dump, which I don't think we can easily allocate
that. Although, we could have it allocated at boot up if
ftrace_dump_on_oops() is enabled.

Another KTODO?

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks!

-- Steve
