Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF3342539;
	Tue, 10 Feb 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739159; cv=none; b=YNCTkFT4r71lQnr2/NwKl2a2lTUbQw6NY2GNptuiHlmM+noRMxZFKxYyYcEbcaur7O4VHCCex8D5c1wffJBIGBw4ri3hsiRHSxuR1FHJKxdyw0M7OBx4PBsVw32RnutE5bVDEEXqyA9ffzMsAPGeDtdLCRyUUuXxtySZCB6jYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739159; c=relaxed/simple;
	bh=E/gtZ/tnIQcdGR01WblVAYFutqScCOAO1Z5YgF+Yfy4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ADwVMmLIyGdzKcGlSd9czueVrWnc90lalFcYB9d15H59Uvn1l+kL0GzLrOigzfivVGWh42GTd/hijB9zMwiSGJo+UvRxp4aAj+YYYsls/JfWr+YdbrkCyWmVrD9SiB7P1684RrVhFwwsF8melmWHr3rkUc5SbeKdmtngl02jThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOIgfRC8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOIgfRC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD2C19424;
	Tue, 10 Feb 2026 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770739159;
	bh=E/gtZ/tnIQcdGR01WblVAYFutqScCOAO1Z5YgF+Yfy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mOIgfRC8K7pCLeI3P9mMtJKrMiaxWYiM8mQQJMTBOZATafR/pEfLQnelG3yASke6m
	 J1HsxNWQtpJjo+Bj2RsJsP6q2Wc6QKHg/i+7FdzoHyLzpfmjulJAYUVQ6FYdjP/Os9
	 PLqaYHBRGx0/i/scUnIkc5l1KBEAg2Y1qSohO7ayReQo1dMPaZFkSf/B42mtE0Qgcb
	 jNkZfrX62kQRESIz0dOK9OPn4QKPx7dg0DalsLTixGnrKvXzsRTX5wRhr+3UL4RWts
	 XQ4t9BHsM1Wx6ot+wKRfqvLP42vMPPk0Znm/2pPQnr/tWvEQQaGDwSh9l6WEvpVkUF
	 MEU/pVkYSQ6wA==
Date: Wed, 11 Feb 2026 00:59:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: Fix checking of freed trace_event_file for
 hist files
Message-Id: <20260211005915.1516a1695be366571fd7d2c9@kernel.org>
In-Reply-To: <20260210113427.1068932-2-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
	<20260210113427.1068932-2-petr.pavlu@suse.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 12:28:16 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The event_hist_open() and event_hist_poll() functions currently retrieve
> a trace_event_file pointer from a file struct by invoking
> event_file_data(), which simply returns file->f_inode->i_private. The
> functions then check if the pointer is NULL to determine whether the event
> is still valid. This approach is flawed because i_private is assigned when
> an eventfs inode is allocated and remains set throughout its lifetime.
> Instead, the code should call event_file_file(), which checks for
> EVENT_FILE_FL_FREED. Using the incorrect access function may result in the
> code potentially opening a hist file for an event that is being removed or
> becoming stuck while polling on this file.
> 
> A related issue is that although event_hist_poll() attempts to verify
> whether an event file is being removed, this check may not occur or could
> be unnecessarily delayed. This happens because hist_poll_wakeup() is
> currently invoked only from event_hist_trigger() when a hist command is
> triggered. If the event file is being removed, no associated hist command
> will be triggered and a waiter will be woken up only after an unrelated
> hist command is triggered.
> 
> Fix these issues by changing the access method to event_file_file() and
> adding a call to hist_poll_wakeup() in remove_event_file_dir() after
> setting the EVENT_FILE_FL_FREED flag. This ensures that a task polling on
> a hist file is woken up and receives EPOLLERR.
> 

Thanks for fixing!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/trace/trace_events.c      | 3 +++
>  kernel/trace/trace_events_hist.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 137b4d9bb116..e8ed6ba155cf 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1295,6 +1295,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
>  	free_event_filter(file->filter);
>  	file->flags |= EVENT_FILE_FL_FREED;
>  	event_file_put(file);
> +
> +	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
> +	hist_poll_wakeup();
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c97bb2fda5c0..744c2aa3d668 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5778,7 +5778,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
>  
>  	guard(mutex)(&event_mutex);
>  
> -	event_file = event_file_data(file);
> +	event_file = event_file_file(file);
>  	if (!event_file)
>  		return EPOLLERR;
>  
> @@ -5816,7 +5816,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
>  
>  	guard(mutex)(&event_mutex);
>  
> -	event_file = event_file_data(file);
> +	event_file = event_file_file(file);
>  	if (!event_file) {
>  		ret = -ENODEV;
>  		goto err;
> -- 
> 2.52.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
