Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248F3EBF0B;
	Thu, 19 Feb 2026 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771459290; cv=none; b=cfVAOHYqHOU8j1tRG3OaSvfTzc5rqO00JfBhSK+5sYZquQJa/UF1pU3FE77LXT73uDimz5VlYeiuGw51JlRaVwmfLh9vu/iQ12flqXpYOwKuW7xLAs/AchHYBMcpHOROneNl0WeXGRP+yDVLh6NGCYkc4v/es+l8RXS9rcS4yec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771459290; c=relaxed/simple;
	bh=D2On1+s9j5rpeapyAuVz23wXdjgYyjUQ0iLQaiIEpAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drhqao9jZbPTtPNrhG9wm+yU6af+3yJaLP15lmCqca+etbA7myCfjLV8jGonM76eK6b7om2FN9MewqcspSKRrpe41z1kx/5SQoTojyXf3xfFU1z2M532NKhl7Z5OVm07Iw0xug8Re1xaR2T/T8cIHUQrsKRdRQ2iYFrUCFQ0gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPIwJx5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPIwJx5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFC7C116D0;
	Thu, 19 Feb 2026 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771459290;
	bh=D2On1+s9j5rpeapyAuVz23wXdjgYyjUQ0iLQaiIEpAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KPIwJx5cRBkId7ntWT7zVE9T/rJFZemS/1BRPaJvMM1NA2d4QDiKZeEbkd4y0CZw4
	 6uYAki6XQyeBHr8WGD+JG2mcjaek74K3fl7LS2o2AGU9qNsu1s8/vNscBceaNkY/m7
	 tEGC45opS7MkElZXfuZIWUdTLV9d3/obYZT9FadMbsD+wivg6HUDqxbv9RM8Sgvqtj
	 Iikc+LV9hqeVvJYro6wcAfWK7LwnZkmKyDOSW+ca/TkRope/vVUA0D2qnvN/xCMHqy
	 /PtZA7/DdPNcJ9N5hhB6LEEzQbd91UyQg6v7HhTAQGNP/MLnssKIp6C92zO/uheD4b
	 EGPx0/93eBbtw==
Date: Wed, 18 Feb 2026 19:01:33 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tracing: Fix checking of freed trace_event_file
 for hist files
Message-ID: <20260218190133.7ec4846f@gandalf.local.home>
In-Reply-To: <20260217102957.7702081d@gandalf.local.home>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
	<20260216134247.1311631-2-petr.pavlu@suse.com>
	<20260217102957.7702081d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 10:29:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 16 Feb 2026 14:41:57 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 3690221ba3d8..f925034e402d 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -683,6 +683,11 @@ static inline void hist_poll_wakeup(void)
> >  
> >  #define hist_poll_wait(file, wait)	\
> >  	poll_wait(file, &hist_poll_wq, wait)
> > +
> > +#else
> > +static inline void hist_poll_wakeup(void)
> > +{
> > +}
> >  #endif
> >  
> >  #define __TRACE_EVENT_FLAGS(name, value)				\
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 137b4d9bb116..e8ed6ba155cf 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1295,6 +1295,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
> >  	free_event_filter(file->filter);
> >  	file->flags |= EVENT_FILE_FL_FREED;
> >  	event_file_put(file);
> > +
> > +	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
> > +	hist_poll_wakeup();
> >  }
> >  
> >  /*
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index c97bb2fda5c0..744c2aa3d668 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -5778,7 +5778,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
> >  
> >  	guard(mutex)(&event_mutex);
> >  
> > -	event_file = event_file_data(file);
> > +	event_file = event_file_file(file);
> >  	if (!event_file)
> >  		return EPOLLERR;
> >  
> > @@ -5816,7 +5816,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
> >  
> >  	guard(mutex)(&event_mutex);
> >  
> > -	event_file = event_file_data(file);
> > +	event_file = event_file_file(file);
> >  	if (!event_file) {
> >  		ret = -ENODEV;
> >  		goto err;
> > --   
> 
> This should be broken into two different patches. One for the
> hist_poll_wakeup() fix, the other to use event_file_file().
> 
> -- Steve

Replying with my kernel.org account in case this email ended up in your spam folder.

-- Steve
