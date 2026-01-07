Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5B350D47;
	Wed,  7 Jan 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804083; cv=none; b=qfKPsdVQ4nXkFXp8mLjta3UWygDsErF4q8gwy+1wjl8lEEjnk40l5v0ZdJe/D/Gu3uquS042dMhEPULUPV4tf5DEY/t0aLuycmHzqQpu6jBRDinoMhjSDAhpBFNGg58uusoAhUQ6NtgHhQnxx11HTH6YDR9T+VJMdSEwsMrSzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804083; c=relaxed/simple;
	bh=631rQmD14PsFiLcLYmVUk2mt1AYrLAqIkXqnb4mT/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYRj4FS8riRyVz4sQHUTdQBuvFhFF7tOW82Pzen1V8ZJ9yviQeNb1ft9xLd2knCvKdvtdBfmsY/MdIrrtZ6DTwz+tzNCwhXhfHg+PZBdYiswWImqDRyllM3XG6bupXIKakSgphLZ7f6nqSKp0BVcdIlDqTiEgB95k/Mi9I6wlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E56BF58EE5;
	Wed,  7 Jan 2026 16:41:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3D5B32F;
	Wed,  7 Jan 2026 16:41:06 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:41:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Make the backup instance readonly
Message-ID: <20260107114133.7f14dac2@gandalf.local.home>
In-Reply-To: <176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
References: <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
	<176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7bu9wi7f3nbwq96k5k39bwx7azy3nxx8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3D5B32F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19BACx7bnSlk1elzuN6a9ELkiguqwHsPZU=
X-HE-Tag: 1767804066-827929
X-HE-Meta: U2FsdGVkX1+d9KRflcF4ib1jOYg5It9K1hTz1RtFmf0IDqge7Wu5gR/LdFCABEEbLBx3d9WAlOTM75Ol6j4dW2xgmUsq8FUFilf02qwflR49eJ6OUAR49Kgczy24Dq8tUFoiQMsMNdXpYJu+XMFPNUyW2yZ3sHqK5IF5c/TOoqJn18sAIwm28n1U4GY6M3f88c7abE2clSf9VsAofe5mJt1oJQ1OCIDJAvXIJPvu4C6su2xX19zI82WAOoYmWBjGEIeBhtmmNdRwK+2KKx3U7BNJdAUG+6SuVgpmnZcmvgooRWaIG/gRbcSaWe5Soe9fOFtZEe2rVaKPaE6ofly9hRiJeE/t6v77

On Wed,  7 Jan 2026 23:45:59 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since there is no reason to reuse the backup instance, make it
> readonly. Note that only backup instances are readonly, because
> other trace instances will be empty unless it is writable.
> Only backup instances have copy entries from the original.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace.c        |   91 ++++++++++++++++++++++++++++++++-----------
>  kernel/trace/trace.h        |    6 +++
>  kernel/trace/trace_events.c |   14 +++++--
>  3 files changed, 84 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 38f7a7a55c23..725930f5980e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4888,6 +4888,9 @@ static int tracing_open(struct inode *inode, struct file *file)
>  		int cpu = tracing_get_cpu(inode);
>  		struct array_buffer *trace_buf = &tr->array_buffer;
>  
> +		if (trace_array_is_readonly(tr))
> +			return -EPERM;

So this fails if someone opens a file in RDONLY mode?

Why?


> +
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  		if (tr->current_trace->print_max)
>  			trace_buf = &tr->max_buffer;
> @@ -6077,6 +6080,9 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
>  ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  				  unsigned long size, int cpu_id)
>  {
> +	if (trace_array_is_readonly(tr))
> +		return -EPERM;

In fact, I don't think we need any of these.

> +
>  	guard(mutex)(&trace_types_lock);
>  
>  	if (cpu_id != RING_BUFFER_ALL_CPUS) {



> @@ -9353,12 +9381,16 @@ static void
>  tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
>  {
>  	struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
> +	umode_t writable_mode = TRACE_MODE_WRITE;
>  	struct dentry *d_cpu;
>  	char cpu_dir[30]; /* 30 characters should be more than enough */
>  
>  	if (!d_percpu)
>  		return;
>  
> +	if (trace_array_is_readonly(tr))
> +		writable_mode = TRACE_MODE_READ;

This is more like what we should do with all the files in a read-only
instance. Just make all files not allow writes.

We may need to make sure they can't be changed to write as well. But that
will require a change to tracefs (and eventfs).

-- Steve


> +
>  	snprintf(cpu_dir, 30, "cpu%ld", cpu);
>  	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
>  	if (!d_cpu) {
> @@ -9371,7 +9403,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
>  				tr, cpu, &tracing_pipe_fops);
>  
>  	/* per cpu trace */
> -	trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
> +	trace_create_cpu_file("trace", writable_mode, d_cpu,
>  				tr, cpu, &tracing_fops);
>  
>  	trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,

