Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F9395241;
	Thu, 21 May 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345262; cv=none; b=hH/5V7T9NfLBOax3NWkBTTV8SMrFfGuh1JIqQmn+ZBHT30ID6LpuHmclVt24pNEPzQshmPtqRwYUBv4ccz8940JkwiwrRrgotpq/jQXm5m9o3PhaTOkBJmLXfxkhY7K6ARTa8HeK2Vrz2uEWkR2HVo+By9bov6mSr+8oIjsc2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345262; c=relaxed/simple;
	bh=bSH5DR6DETIBxz7vRdGZzYpiMzj+04yhY0peXRWRTwA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RY0rgHSdGp+LeiZvN+TN3aXt3Uw/dFf5RatSsWk/2G8hY4g2kOiO2iM9pLeujt/3taqHQUgdPN5Wayo31AHSp3A7U3oq0z9YrdoZBvbW4kYUvs4QnQ7yF1NuXtL9EM0ouhEnrx9NVbnKOUu1VEZjaO43nfa0K/1AeTXkHEVikSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spag9ere; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spag9ere"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EEB1F00A3B;
	Thu, 21 May 2026 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779345260;
	bh=TCtyabHG7oFMqJCk/7FoLtKz/KpDHhIUvoORxGzrDuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Spag9ere6ymDFaZ8gDMpCmy9KwPFXwNVyKnpcsxc/xGm8l9Z7fH5NBLLhS6xKrG94
	 Pxkkl40qcqVFaim3iZ5HluG+bWYMPDUfVxHp1sG+X75JReU/uebuZhuIJ92+VNn6BN
	 I5bp4AY9FVPYMdAKPU0cMfSryrsYF+oTPO+XvnQCtnE8+kITjt26aK+7Fe9OAwN9n1
	 MkMFKLD5j5qbHxQvbCYEnxEeWNoXT16YrYvKyf29aUnFXm093tDQsZ/CmoCUdgSof5
	 u55Nhlc55yTlDqyyV/YP8gML+Zr03TSxwD9UJGhcQxAGN0k4x7Z3nkRnjGIK9GtFR/
	 zsOykMUquzvBQ==
Date: Thu, 21 May 2026 15:34:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 09/10] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-Id: <20260521153416.71be1cd6a42be89a12e0bc62@kernel.org>
In-Reply-To: <20260520185018.332045380@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.332045380@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:49:47 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the persistent ring buffer is validated on boot up, if a subbuffer is
> deemed invalid, it resets the buffer and continues. Currently, these lost
> events are not shown in the trace file output.
> 
> Have the trace iterator look for subbuffers that have the RB_MISSED_EVENTS
> set and set the iter->missed_events flag when it is detected. This will
> then have the trace file shows "LOST EVENTS" when it reads across a
> subbuffer that was corrupted and invalidated.

I think it is good to show the dropped events. BTW, is it better to
comment out the line, just for parser?
For example, add a '#' at the like.

# CPU:5 [LOST EVENTS]

Ah, but it is already done...

Thanks,

> 
> For example:
> 
>  <...>-1016    [005] ...1.  6230.660403: preempt_disable: caller=__mod_memcg_state+0x1c8/0x200 parent=__mod_memcg_state+0x1c8/0x200
> CPU:5 [LOST EVENTS]
>  <...>-1016    [005] .....  6230.660673: kmem_cache_alloc: call_site=__anon_vma_prepare+0x1ad/0x1e0 ptr=000000006e40294c name=anon_vma bytes_req=200 bytes_alloc=208 gfp_flags=GFP_KERNEL node=-1 accounted=true
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ae5c645b59c9..9cdbee171cdc 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3518,6 +3518,9 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
>  	else
>  		rb_inc_page(&iter->head_page);
>  
> +	if (rb_page_commit(iter->head_page) & RB_MISSED_EVENTS)
> +		iter->missed_events = -1;
> +
>  	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
>  	iter->head = 0;
>  	iter->next_event = 0;
> @@ -5579,6 +5582,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
>  	iter->head_page = cpu_buffer->reader_page;
>  	iter->head = cpu_buffer->reader_page->read;
>  	iter->next_event = iter->head;
> +	iter->missed_events = 0;
>  
>  	iter->cache_reader_page = iter->head_page;
>  	iter->cache_read = cpu_buffer->read;
> @@ -7053,7 +7057,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	struct ring_buffer_event *event;
>  	struct buffer_data_page *dpage;
>  	struct buffer_page *reader;
> -	unsigned long missed_events;
> +	long missed_events;
>  	unsigned int commit;
>  	unsigned int read;
>  	u64 save_timestamp;
> @@ -7179,6 +7183,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  		local_set(&reader->entries, 0);
>  		reader->read = 0;
>  		data_page->data = dpage;
> +		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
> +			missed_events = -1;
>  
>  		/*
>  		 * Use the real_end for the data size,
> @@ -7196,10 +7202,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Set a flag in the commit field if we lost events
>  	 */
>  	if (missed_events) {
> -		/* If there is room at the end of the page to save the
> +		/*
> +		 * If there is room at the end of the page to save the
>  		 * missed events, then record it there.
>  		 */
> -		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> +		if (missed_events > 0 &&
> +		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
>  			memcpy(&dpage->data[commit], &missed_events,
>  			       sizeof(missed_events));
>  			local_add(RB_MISSED_STORED, &dpage->commit);
> -- 
> 2.53.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
