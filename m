Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CF68B62
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9D3C433C8;
	Tue,  5 Dec 2023 17:34:48 +0000 (UTC)
Date: Tue, 5 Dec 2023 12:35:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Always update snapshot buffer size
Message-ID: <20231205123514.03244a4e@gandalf.local.home>
In-Reply-To: <20231205115223.5256e1a1@gandalf.local.home>
References: <20231205115223.5256e1a1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 11:52:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> It use to be that only the top level instance had a snapshot buffer (for
> latency tracers like wakeup and irqsoff). The update of the ring buffer
> size would check if the instance was the top level and if so, it would
> also update the snapshot buffer as it needs to be the same as the main
> buffer.
> 
> Now that lower level instances also has a snapshot buffer, they too need
> to update their snapshot buffer sizes when the main buffer is changed,
> otherwise the following can be triggered:
> 
>  # cd /sys/kernel/tracing
>  # echo 1500 > buffer_size_kb
>  # mkdir instances/foo
>  # echo irqsoff > instances/foo/current_tracer
>  # echo 1000 > instances/foo/buffer_size_kb
> 

Bah, this is only a partial patch, in fact it doesn't even fix the issue.
It fixes another issue that this issue is dependent on.

I'll send out a v2 shortly.

-- Steve
