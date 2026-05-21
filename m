Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4A30DD30;
	Thu, 21 May 2026 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335206; cv=none; b=PhEZsSMXj6IIR5g4q5VrLWTp4XQogoKzAtryEgHbzTABQBvRSkGJJh9EHbCvJfGuW2dppjZIM24u/m7vMzmlESECS4g3h5j1Ari/503jRIEtDOr4UkPnFVdMI2i2/ZWeEvq/jucBnXXSK1eaa/L25kBATRMAXPUnzBxSEnBmkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335206; c=relaxed/simple;
	bh=vfYSD69Q3rD4e9jkq8XgIX/wilniO7gBdcEfUt264EI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hAzR6bq7fqc1bdgrjLubazDb8HHVXESKJWM5WRadNfFua+6qGmJbFlr1f1DsCgIypMRrRpdlMITPl+VQma8lK450/4iRtfKkMw7U0IuCWcDJbfpDyGgsmI8/imdvXdvqxOB3KBTMl3KNN9fbYz9NDha04fHDhx7rGK2CZ5y7YxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eScHYmno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eScHYmno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A8D1F000E9;
	Thu, 21 May 2026 03:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335203;
	bh=qkhZOf3D5ilURBV43WvvgE2pB6mKClKLalFB6ckHHss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eScHYmnoGa2wpjOyQfh5394DjpLHb5MH+NIncZZSdConkGSYJir4feiGqjq01agEd
	 vmA396BBTL2OOio+Ol0qZie9oEuFQLZgRIRyNmhcblE3uRXEOwfONOrME8Lz+mfIDl
	 PSf29Jn7yz3NicmngjbX/biejlzm4O+j9s9/NJGscZcn6WiZ7kw1SNyu85HsFDNyEO
	 a4wi8GaVcUEwESP6zViGEpokmIKmnxDDeBpy6MN5HWmYRDDvS78hWG/I892flWq2+c
	 kh6vebo69h7Yh3AXEXVEohIbioiFmvQOfY738ZO2/ZW97MsH6F3rn8+MfWTuiHVV8g
	 SF0vWlopwObig==
Date: Thu, 21 May 2026 12:46:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Fix reporting of missed events in
 iterator
Message-Id: <20260521124640.daadbf2ecbe3c1e6b6560134@kernel.org>
In-Reply-To: <20260520220801.4fd09d13@fedora>
References: <20260520220801.4fd09d13@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 22:08:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From c3651ad3ac95b331c7aa010d163704a3702855da Mon Sep 17 00:00:00 2001
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Wed, 20 May 2026 14:28:17 -0400
> Subject: [PATCH] ring-buffer: Fix reporting of missed events in iterator
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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Cc: stable@vger.kernel.org
> Fixes: c9b7a4a72ff64 ("ring-buffer/tracing: Have iterator acknowledge dropped events")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> Changes since v1: https://patch.msgid.link/20260520142817.4050abab@gandalf.local.home
> 
> - Added clearing iter->missed_events in rb_iter_reset() (Sashiko)
> 
>  kernel/trace/ring_buffer.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7288383b1f27..7b07d2004cc6 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5429,6 +5429,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
>  	iter->head_page = cpu_buffer->reader_page;
>  	iter->head = cpu_buffer->reader_page->read;
>  	iter->next_event = iter->head;
> +	iter->missed_events = 0;
>  
>  	iter->cache_reader_page = iter->head_page;
>  	iter->cache_read = cpu_buffer->read;
> @@ -6108,10 +6109,7 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
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
> @@ -6273,7 +6271,7 @@ void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
