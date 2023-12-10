Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85E847B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4212C433C8;
	Sun, 10 Dec 2023 15:33:37 +0000 (UTC)
Date: Sun, 10 Dec 2023 10:34:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Message-ID: <20231210103415.5afd45ca@gandalf.local.home>
In-Reply-To: <18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
References: <20231209171058.78c1a026@gandalf.local.home>
	<18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 09:11:40 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-09 17:10, Steven Rostedt wrote:
> [...]
> >              <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
> >              <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234  
> 
> Failing to print an entire message because it does not fit in the
> buffer size is rather inconvenient.

Yes I agree, and luckily it hasn't been called out as an issue. Note, I hit
this because I extended the trace_marker buffer before increasing the
trace_seq size. Otherwise, the trace_marker just breaks it up. This can now
only be triggered by internal changes.

> 
> It would be better to print the partial line, and end the line with
> a <TRUNCATED LINE> tag.

Agreed, but I don't have time to do that (I already spent way too much time
on this than I had allocated). I decided to just do what the trace_pipe
currently does, and leave "print partial line" to another day when I can
allocate time on this.

Hmm, this could be added to the "TODO" list that was talked about in
ksummit-discuss.

-- Steve

