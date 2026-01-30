Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D6350A29;
	Fri, 30 Jan 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765054; cv=none; b=iYz1geE4AECVgrQp6y3iKWgpsuX1KtlVOy2urbHgLPOWlDEtq+XF06Wc7Bw3yQNg49KOe/1Ov60JM9uuApieIWQB8pknQuWC7Bg9olFzzXiRW9FQdqkDGN6wF02JJqPSEMh7naaj4V8DJ0wgjUgaSE929MkUG0WfOIVuWjTb9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765054; c=relaxed/simple;
	bh=CsYX1wJS8ckjJR4tQeUPSe/ArptesRksBD7x1GMaP5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V74Q0PejeLjcWMwW5RDlWqSCVhaBQOFpkC/5rP6AcEiZgEm6qCvo9g8oWvDJSpzCdh75I+UwHSVhAMLlSakVPI4bIlzSd8b51MbmDsdNxoiq+/hI6yqhlOV02cmiRnhY0tzHvAHaGN9Gs4/uNBIRHajDHm2Rq+EwFEBr2SzbF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASDVDTU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASDVDTU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C88FC4CEF7;
	Fri, 30 Jan 2026 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769765053;
	bh=CsYX1wJS8ckjJR4tQeUPSe/ArptesRksBD7x1GMaP5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ASDVDTU6mMXRUR7k41Q/Cg3dHziwgrb49ScF/fnGZJ9323Q0VS5lKqyZwOcOAegGv
	 y/mTzAT48vXQsuDA/0R8KJIwqrz9+mdbK871uWxrkGqteEDO8WrJ+i7gEuAy1DnY7+
	 8t4jm9/ReF/pqmQIk0gtA0Gj69UGM/v/rk9Ss7cHZDuX9wAzCml7+iWD1aPaoM7AVT
	 2SJjJIxeiUSQMFD3BUI4rt4Vz8SU8Hy5AY4I5VLFlfr+OBB82zsO0rJyyPK0HjUfVw
	 zrcf+aTKmkyQgfu8Ll5TBw5HKDHyEuMHAy18XIAaD+jMxDWxJdXYXYbeVlw1lDkpKJ
	 4LWRCi82l2t1A==
Date: Fri, 30 Jan 2026 18:24:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] tracing: Remove the backup instance
 automatically after read
Message-Id: <20260130182409.3e5b9f86dcfe7625b3b582cd@kernel.org>
In-Reply-To: <20260129151352.12e2be72@gandalf.local.home>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955900407.2786091.16663650848612163366.stgit@mhiramat.tok.corp.google.com>
	<20260129151352.12e2be72@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 15:13:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 Jan 2026 09:10:04 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the backup instance is readonly, after reading all data
> > via pipe, no data is left on the instance. Thus it can be
> > removed safely after closing all files.
> > This also removes it if user resets the ring buffer manually
> > via 'trace' file.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v4:
> >    - Update description.
> > ---
> >  kernel/trace/trace.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/trace/trace.h |    6 +++++
> >  2 files changed, 69 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index d39f6509c12a..7d615a74f915 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -590,6 +590,55 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
> >  	tr->ring_buffer_expanded = true;
> >  }
> >  
> > +static int __remove_instance(struct trace_array *tr);
> > +
> > +static void trace_array_autoremove(struct work_struct *work)
> > +{
> > +	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> > +
> > +	guard(mutex)(&event_mutex);
> > +	guard(mutex)(&trace_types_lock);
> > +
> > +	/*
> > +	 * This can be fail if someone gets @tr before starting this
> > +	 * function, but in that case, this will be kicked again when
> > +	 * putting it. So we don't care the result.
> 
> 			"So we don't care about the result."

OK.

> 
> > +	 */
> > +	__remove_instance(tr);
> > +}
> > +
> > +static struct workqueue_struct *autoremove_wq;
> > +
> > +static void trace_array_init_autoremove(struct trace_array *tr)
> > +{
> > +	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
> > +}
> > +
> > +static void trace_array_kick_autoremove(struct trace_array *tr)
> > +{
> > +	if (!work_pending(&tr->autoremove_work) && autoremove_wq)
> > +		queue_work(autoremove_wq, &tr->autoremove_work);
> > +}
> > +
> > +static void trace_array_cancel_autoremove(struct trace_array *tr)
> > +{
> > +	if (work_pending(&tr->autoremove_work))
> > +		cancel_work(&tr->autoremove_work);
> > +}
> > +
> > +__init static int trace_array_init_autoremove_wq(void)
> > +{
> 
> This isn't needed if there's no backup trace_array right?
> 
> Instead of creating a work queue when its not needed, just exit out if
> there's no backup trace_array.
> 
> Oh, and the above functions should always test autoremove_wq for NULL.

Ah, right. OK, let me fix it.

> 
> > +	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
> > +					WQ_UNBOUND | WQ_HIGHPRI, 0);
> > +	if (!autoremove_wq) {
> > +		pr_err("Unable to allocate tr_autoremove_wq\n");
> > +		return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> > +
> > +late_initcall_sync(trace_array_init_autoremove_wq);
> > +
> >  LIST_HEAD(ftrace_trace_arrays);
> >  
> >  int trace_array_get(struct trace_array *this_tr)
> > @@ -598,7 +647,7 @@ int trace_array_get(struct trace_array *this_tr)
> >  
> >  	guard(mutex)(&trace_types_lock);
> >  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > -		if (tr == this_tr) {
> > +		if (tr == this_tr && !tr->free_on_close) {
> >  			tr->ref++;
> >  			return 0;
> >  		}
> 
> Break the above into:
> 
> 		if (tr == this_tr) {
> 			if (tr->free_on_close)
> 				break;
> 			tr->ref++;
> 			return 0;
> 		}
> 
> Why continue the loop if we found the trace_array but it's in the process
> of closing?

Ah, indeed. OK, I'll fix it.

Thank you!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
