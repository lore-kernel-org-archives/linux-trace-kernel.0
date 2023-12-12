Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77D76DC6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E4EC433C8;
	Tue, 12 Dec 2023 15:45:07 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:45:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231212104549.58863438@gandalf.local.home>
In-Reply-To: <445ac00d-0f0c-4f6a-b85a-97209635c3f3@efficios.com>
References: <20231212090057.41b28efe@gandalf.local.home>
	<445ac00d-0f0c-4f6a-b85a-97209635c3f3@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 09:33:11 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-12 09:00, Steven Rostedt wrote:
> [...]
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7272,6 +7272,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	enum event_trigger_type tt = ETT_NONE;
> >   	struct trace_buffer *buffer;
> >   	struct print_entry *entry;
> > +	int meta_size;
> >   	ssize_t written;
> >   	int size;
> >   	int len;
> > @@ -7286,12 +7287,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
> >   		return -EINVAL;
> >   
> > -	if (cnt > TRACE_BUF_SIZE)
> > -		cnt = TRACE_BUF_SIZE;  
> 
> You're removing an early bound check for a size_t userspace input...
> 
> > -
> > -	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
> > -
> > -	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
> > +	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> > + again:
> > +	size = cnt + meta_size;  
> 
> ... and then implicitly casting it into a "int" size variable, which
> can therefore become a negative value.
> 
> Just for the sake of not having to rely on ring_buffer_lock_reserve
> catching (length > BUF_MAX_DATA_SIZE), I would recommend to add an
> early check for negative here.

size_t is not signed, so nothing should be negative. But you are right, I
need to have "size" be of size_t type too to prevent the overflow.

And I could make cnt of ssize_t type and check for negative and fail early
in such a case.

Thanks!

> 
> >   
> >   	/* If less than "<faulted>", then make sure we can still add
> > that */ if (cnt < FAULTED_SIZE)
> > @@ -7300,9 +7298,25 @@ tracing_mark_write(struct file *filp, const char
> > __user *ubuf, buffer = tr->array_buffer.buffer;
> >   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
> >   					    tracing_gen_ctx());
> > -	if (unlikely(!event))
> > +	if (unlikely(!event)) {
> > +		/*
> > +		 * If the size was greated than what was allowed, then
> >  
> 
> greater ?

Nah, the size is "greated" like "greated cheese" ;-)

Thanks for the review, I'll send out a v3.

-- Steve
