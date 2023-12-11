Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839C38FA2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPAKLlpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F69C433C8;
	Mon, 11 Dec 2023 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296503;
	bh=H48TlKvi4BGnZcxJ7Nx9B60tEixMLubEf6s1qwzEUuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UPAKLlpAij5Mf2DLLVZoINgoQGRex/xDfJR7/eZsus5A8CNzh2phm2unAjVKrbZMu
	 jWAW4MT516TOaj6fzNPz8p6FZBXNid1u3zgSbE9hUs9SYC2EjuxdZeSdbhCXPmpOHP
	 LJliGFzHUgMBJueF8P6FfF9jwGW3LMNkFiy6Q3nQd+FicBqKF3u7Ioipkr9YbVfOLK
	 hDTtkhGRM6auhxiSP5rWLDU7eItiCnRRjIj5Rweo9FsF0SbcQFRX8EBpFOk8QX4RPU
	 56QzGuPISVuUEDZ5Y4tdRawpfjb3ev3Qxc3NRiO/c5beVLure3Kg1/0pW2z33lD1wX
	 M1eTpFKtH2i5w==
Date: Mon, 11 Dec 2023 21:08:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Message-Id: <20231211210819.cd4f7b3df09cf0eb584e51b9@kernel.org>
In-Reply-To: <20231210103415.5afd45ca@gandalf.local.home>
References: <20231209171058.78c1a026@gandalf.local.home>
	<18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
	<20231210103415.5afd45ca@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 10:34:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 10 Dec 2023 09:11:40 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > On 2023-12-09 17:10, Steven Rostedt wrote:
> > [...]
> > >              <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
> > >              <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234  
> > 
> > Failing to print an entire message because it does not fit in the
> > buffer size is rather inconvenient.
> 
> Yes I agree, and luckily it hasn't been called out as an issue. Note, I hit
> this because I extended the trace_marker buffer before increasing the
> trace_seq size. Otherwise, the trace_marker just breaks it up. This can now
> only be triggered by internal changes.

Rather than the broken output, I would perfer this output.

> 
> > 
> > It would be better to print the partial line, and end the line with
> > a <TRUNCATED LINE> tag.

But how long the partial line length is good enough? I think that big (and long)
user marker maybe not for human, so we don't need to care about readability.
I think current one is one of better solutions.

So I'll give my Reviewed-by. :)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Agreed, but I don't have time to do that (I already spent way too much time
> on this than I had allocated). I decided to just do what the trace_pipe
> currently does, and leave "print partial line" to another day when I can
> allocate time on this.
> 
> Hmm, this could be added to the "TODO" list that was talked about in
> ksummit-discuss.
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
