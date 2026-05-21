Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93212D97B7;
	Thu, 21 May 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326977; cv=none; b=nmpQEYglVrlguLhs9y1uE7ZwgIiV3+D2CpoqtDPCJcM2u1H6jD6yUJCqQiRb0bRqVzyXgimKXlHHyhgwlJpocx9lMBPiz6OLfhyIFx+NLjKDOuOYzy5uez5Uy+TIgLjl0I2Ls2OQoIitEU4hvNbpFQUGfLuJweSmvjmgBFPkCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326977; c=relaxed/simple;
	bh=3IFaGN30KE43SMcbEg3up8/fIOMjau3mwGY7eXftmCM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TyjODWFAyk1XBwon/BsOwune/+yGo0Mt6sH887f/0Ex6PnE3NekfOTOZt1CSK0IzxQ0O73zUTaMlMWJ4py62h8k7DDwd7zCTxrZWZ55w1xCIAkDCFLBplioTui8rpzzlWbFvU6mBuL1GYZR774AriV0L1JuCB84IUucILWS9L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRGo8yck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRGo8yck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F02B1F000E9;
	Thu, 21 May 2026 01:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779326965;
	bh=8OETbXlMgDQXIJk/EaXlqQwcJwgZQw8XTOG8xLUenno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iRGo8yck7rePBQ3KIdHOR1LFvhuvYtk2Y/w0cEmYAOdFdHJpk0nQywfgWthzh92d3
	 cWJfQVMuBdjgUBLvcg+c03lVz5Aq2FiwTElym7B7frpn4mCIyk/JK5N+/PiyFCwxJ/
	 YgUHG0VqWCxp1XXUA6riVzvjdEa+FLCiE1y1vCayp0XFsU3ofDFWKnZy26LijSkofa
	 lJfzSzQFNP+HHKfO2A129LrWtI57Xmmheo7kJrii7aamJm+JXLUg/vPqlHnAtWQPWH
	 wje/+p6ZiF+h9l3F07RgQKTUPWCDxZ/vcjbntB70NxSRQxFBnmOUBRUsaC4dx0hBw/
	 tKAvTo2TdZRMg==
Date: Thu, 21 May 2026 10:29:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix reporting of missed events in iterator
Message-Id: <20260521102921.a1449dedfe0392a3bb4a91b9@kernel.org>
In-Reply-To: <20260520142817.4050abab@gandalf.local.home>
References: <20260520142817.4050abab@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:28:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When tracing is active while reading the trace file, if the iterator
> reading the buffer detects that the writer has passed the iterator head,
> it will reset and set a "missed events" flag. This flag is passed to the
> output processing to show the user that events were missed:
> 
>   CPU:4 [LOST EVENTS]
> 
> The problem is that the flag is reset after it is checked in
> ring_buffer_iter_dropped(). But the "trace" file iterates over all the CPU
> ring buffers and it will check if they are dropped when figuring out which
> buffer to print next. This prematurely clears the missed_events flag if
> the CPU buffer with the missed events is not the one that is printed next.
> 
> On the iteration where the CPU buffer with the missed events is printed,
> the check if it had missed events would return false and the output does
> not show that events were missed.
> 
> Do not reset the missed_events flag when checking if there were missed
> events, but instead clear it when moving the iterator head to the next
> event.
> 

As Sashiko pointed, this flag should be reset in rb_iter_reset() too.
(But that seems like another issue?)

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: c9b7a4a72ff64 ("ring-buffer/tracing: Have iterator acknowledge dropped events")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5326924615a4..47b0a7b43f0f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6086,10 +6086,7 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
>   */
>  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter)
>  {
> -	bool ret = iter->missed_events != 0;
> -
> -	iter->missed_events = 0;
> -	return ret;
> +	return iter->missed_events != 0;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_iter_dropped);
>  
> @@ -6251,7 +6248,7 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -
> +	iter->missed_events = 0;
>  	rb_advance_iter(iter);
>  
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> -- 
> 2.53.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
