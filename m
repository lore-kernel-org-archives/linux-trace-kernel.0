Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B72D3A7C;
	Sun, 31 May 2026 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271913; cv=none; b=a7EWXB9Upipz7NrfWcBXreW22dSDVIgrQpW5b9IfDr8PlcmvU8RejaatjtTCXtHR6z+OnNGkYebdjybc6WtgiFqRWkBGs61wC9si8iov4UIKG/MrwMKVfhbJwzmM4WzqYTtrRpyJ/rGQ1tMT4wZcKG5MX0SM/OT1LH3Jse3jLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271913; c=relaxed/simple;
	bh=uGWi4ENn5JtfTDzezeYOeQY2xipP3RfADyZ9hX7CcRE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WtRb65dgdmMRyqDPuBvpjLZS1140nc5U4PjRyyJ+SiLnXMyCh5qBgY4qpMn+s9tig8uagKAbhImzZhk8voDNc8cz667691qQ6rBLEBzT4IqqTrcIGMsGjTzFh20l21bu81ByE2K5iQ4Q1Kb1n+FhfYTbsBRTG7x27IJNahQYfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG0fnxea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG0fnxea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60FF1F00893;
	Sun, 31 May 2026 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780271912;
	bh=IF2vvANDYkVzBcUU/jJr89DSknrbPGIm+SIoTYlUjQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IG0fnxeaNRpFoMegSmON7ySA2AdTvP3H3eqG1Gg2SWPqNBbmkmNCGsfTsO6cqWSwv
	 d7g9uMGcxch7EAagf61jLAj7RUiUtKkzD3S7zkFGCsupglasfG1JT8aK0U0Caz8xMs
	 ZR0PGoX/uLfiir1X/zdcnegk7Tb3RH6tjvRt+9ocS73urLsHaQzvI5c/zyRx+n0OsU
	 hi81DHUvd8grMUyPusScUQzadhWhcsL60+gPUUbOz5bsar9axpLOkcErYuo2T5FeB3
	 90GqqrpoARabDJFrZjl0gLKIGazJLn7+W4cKZdCEN/oEx9LQAIFcWbG1QsYLibQhe1
	 w28tmhBdh4m0w==
Date: Mon, 1 Jun 2026 08:58:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Better comment the use of RB_MISSED_EVENTS
Message-Id: <20260601085828.23f9c5cb42fb6319be1b8753@kernel.org>
In-Reply-To: <20260528223738.41276c0e@fedora>
References: <20260528223738.41276c0e@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 22:37:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> If the persistent ring buffer is detected on boot up to have a corrupted
> sub-buffer, that sub-buffer is cleared to zero and its commit value has
> the RB_MISSED_EVENTS bit set. That bit is to allow the "trace",
> "trace_pipe" and "trace_pipe_raw" files know that events were dropped by
> outputting "[LOST EVENTS]".
> 
> Only in this case does that bit get set in the writeable portion of the
> ring buffer. When events are dropped in the normal ring buffer, that
> information is stored in the cpu_buffer descriptor and the
> RB_MISSED_EVENTS is set in the buffer page at the time the page is
> consumed. It is never set in the writeable portion of the buffer.
> 
> Add comments to describe this better as it can be confusing to know when
> the RB_MISSED_EVENTS are set in the commit portion of the buffer page.
> 
> Link: https://lore.kernel.org/all/20260529001500.14178455a046a5cbc6180861@kernel.org/
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, 

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 910f6b3adf74..06fb365bb86e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1929,6 +1929,12 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
>  	 */
>  	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
>  		local_set(&bpage->entries, 0);
> +		/*
> +		 * Note, the RB_MISSED_EVENTS is only set inside the main write
> +		 * buffer by this verification logic. The normal ring buffer
> +		 * has this bit set when the page is read and passed to the
> +		 * consumers.
> +		 */
>  		local_set(&dpage->commit, RB_MISSED_EVENTS);
>  		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
>  		ret = -1;
> @@ -7232,6 +7238,14 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  			local_add(RB_MISSED_STORED, &dpage->commit);
>  			size += sizeof(missed_events);
>  		}
> +		/*
> +		 * Note, for the persistent ring buffer, the RB_MISSED_EVENTS
> +		 * may have been set in the main buffer via the verification code.
> +		 * But here, dpage is a copy of that page and has not yet had
> +		 * the RB_MISSED_EVENTS set. As for the normal buffers,
> +		 * the main write buffer does not set these bits and it needs
> +		 * to be set here.
> +		 */
>  		local_add(RB_MISSED_EVENTS, &dpage->commit);
>  	}
>  
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
