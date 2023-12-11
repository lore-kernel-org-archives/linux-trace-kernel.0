Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1B2AF13
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp/BPQfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBA2C433C8;
	Mon, 11 Dec 2023 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702294839;
	bh=3gaOmYRIZfbiVmht0OPzyhJS1d5RxKW/OEhIAR90v1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hp/BPQfyYMdM+/l1B7ToTZogugssKh2805pDfssVpBiMrpztnBm3IxhG0xX6GS4Ne
	 3rnDUW6FCt13YNi6nHSWM2gqNtWEvmdB7+gU2OSZSHRXJKGwMCdCITXV5Cx4iyUfsM
	 MExdTDBqrNSzDjXhrF02RprgNGtivSRedj3mcsSI7ADcY8MbOZ2MxGUITILnohRvGr
	 ne9T+4+mP4tf8dtfJuBUmA0uq/RD2UQLZb29CYbBEMfix86hBRSQugXpkK9WJ/JqHJ
	 aKGRIgmco9nGhO71B8s0XHI1xIcIB/xSORD9NBAqGB37NTR4Y3kX6CacxY54nSiQpH
	 iFYgqWEmxsihQ==
Date: Mon, 11 Dec 2023 20:40:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kent Overstreet
 <kent.overstreet@linux.dev>
Subject: Re: [PATCH] ring-buffer: Fix buffer max_data_size with
 max_event_size
Message-Id: <20231211204033.a3658f5f497f0c7541dee025@kernel.org>
In-Reply-To: <20231209170925.71d4e02e@gandalf.local.home>
References: <20231209170139.33c1b452@gandalf.local.home>
	<20231209170925.71d4e02e@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Dec 2023 17:09:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 9 Dec 2023 17:01:39 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The maximum ring buffer data size is the maximum size of data that can be
> > recorded on the ring buffer. Events must be smaller than the sub buffer
> > data size minus any meta data. This size is checked before trying to
> > allocate from the ring buffer because the allocation assumes that the size
> > will fit on the sub buffer.
> > 
> > The maximum size was calculated as the size of a sub buffer page (which is
> > currently PAGE_SIZE minus the sub buffer header) minus the size of the
> > meta data of an individual event. But it missed the possible adding of a
> > time stamp for events that are added long enough apart that the event meta
> > data can't hold the time delta.
> > 
> > When an event is added that is greater than the current BUF_MAX_DATA_SIZE
> > minus the size of a time stamp, but still less than or equal to
> > BUF_MAX_DATA_SIZE, the ring buffer would go into an infinite loop, looking
> > for a page that can hold the event. Luckily, there's a check for this loop
> > and after 1000 iterations and a warning is emitted and the ring buffer is
> > disabled. But this should never happen.
> > 
> > This can happen when a large event is added first, or after a long period
> > where an absolute timestamp is prefixed to the event, increasing its size
> > by 8 bytes. This passes the check and then goes into the algorithm that
> > causes the infinite loop.
> > 
> > Fix this by creating a BUF_MAX_EVENT_SIZE to be used to determine if the
> > passed in event is too big for the buffer.
> > 
> 
> Forgot to add:
> 
> Cc: stable@vger.kernel.org
> Fixes: a4543a2fa9ef3 ("ring-buffer: Get timestamp after event is allocated")

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
> 
> -- Steve
> 
> 
> > Reported-by: Kent Overstreet <kent.overstreet@linux.dev> # (on IRC)
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/ring_buffer.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 8d2a4f00eca9..a38e5a3c6803 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -378,6 +378,9 @@ static inline bool test_time_stamp(u64 delta)
> >  /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
> >  #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
> >  
> > +/* Events may have a time stamp attached to them */
> > +#define BUF_MAX_EVENT_SIZE (BUF_MAX_DATA_SIZE - RB_LEN_TIME_EXTEND)
> > +
> >  int ring_buffer_print_page_header(struct trace_seq *s)
> >  {
> >  	struct buffer_data_page field;
> > @@ -3810,7 +3813,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
> >  	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
> >  		goto out;
> >  
> > -	if (unlikely(length > BUF_MAX_DATA_SIZE))
> > +	if (unlikely(length > BUF_MAX_EVENT_SIZE))
> >  		goto out;
> >  
> >  	if (unlikely(trace_recursive_lock(cpu_buffer)))
> > @@ -3960,7 +3963,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
> >  	if (atomic_read(&cpu_buffer->record_disabled))
> >  		goto out;
> >  
> > -	if (length > BUF_MAX_DATA_SIZE)
> > +	if (length > BUF_MAX_EVENT_SIZE)
> >  		goto out;
> >  
> >  	if (unlikely(trace_recursive_lock(cpu_buffer)))
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
