Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA212E78;
	Fri, 26 Jul 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005535; cv=none; b=K7+9jOoGPAOQAoYW4g2KcOSVVTfsaXNjGY1f4mJZsnp3HSsK2XD+EOV/crA6e1x1JmmWNIX3NzzcL2IiPr6sYAkjAFdqriQooFnRKqbNpuMEMFHw9iliotWH2XhM0w0e7SJB2x3WPPGIPqf2goZGTLDpneYwuFg/utgxOGDvlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005535; c=relaxed/simple;
	bh=SbeWfRL6R1lWKmatWGy0wTbaWCZvYmvlyDRH+ijg2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDcXEpDxiQOal+fSC1VnXv1HueybZadZTFFZgYBefEk63Eo4I2NZV3Fdz7V+3IsoMxUMIQfpX/Wv4t8Xw3Utygpy+c/Px+Ul0NgQku0auWuUnCO2Of8xTMb4HBvFrTx8o3eR+v3QW4LQji/udJOpq/oKH5gysKhsp0x4lE44PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B51C32782;
	Fri, 26 Jul 2024 14:52:13 +0000 (UTC)
Date: Fri, 26 Jul 2024 10:52:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <20240726105212.120a74b2@rorschach.local.home>
In-Reply-To: <0b80cb48-6604-44ec-bfa9-f5ec1fc5d7d7@grsecurity.net>
References: <20240725201517.3c52e4b0@gandalf.local.home>
	<0b80cb48-6604-44ec-bfa9-f5ec1fc5d7d7@grsecurity.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 12:16:16 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> > 
> > With KASAN memory checking, it would trigger a use-after-free bug. This was  
> 
> The UAF bug is there even without KASAN. It's just that KASAN makes it
> much easier to detect and catch early.

Well the bug happens without KASAN but the "tigger" is shown by KASAN.
I was assuming people understood that.

> 
> > because the format file was not checking the file's meta data flag
> > "EVENT_FILE_FL_FREED", so it would access the event that the file meta data
> > pointed to after it was freed.
> > 
> > The second bug is that the dynamic "format" file also registered a callback
> > to decrement the meta data, but the "data" pointer passed to the callback
> > was the event itself. Not the meta data to free. This would either cause a
> > memory leak (the meta data never was freed) or a crash as it could have
> > incorrectly freed the event itself.

I need to remove the above, as I realized the release callback doesn't
get called for the "filter" but for only the "enable". That doesn't get
called until all files have no more references. So there's only one bug
here.

> > 
> > Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Mathias Krause <minipli@grsecurity.net>
> > Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")  
> 
> That fixes tag looks odd as it didn't introduce the bug. It's some late
> change to v6.9 but my bisect run showed, it's triggering as early as in
> v6.6 (commit 27152bceea1d ("eventfs: Move tracing/events to eventfs")).
> 
> git blame points to 5790b1fb3d67 ("eventfs: Remove eventfs_file and just
> use eventfs_inode"), which is still too young, as it's v6.7.

But if you look at the commit I posted. It has:

  Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")

And you need to add that to apply this patch as it has that as the
dependency. If you try to apply this to the change that had the
original bug, it will not apply. I basically say that this patch is a
fix to the previous fix.

> 
> IMHO, this needs at least the following additional fixes tags to ensure
> all stable kernels get covered:
> 
> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use
> eventfs_inode")
> Fixes: 27152bceea1d ("eventfs: Move tracing/events to eventfs")
> 
> Even if 27152bceea1d is not the real cause, just the commit making the
> bug reachable. But from looking at the history, this was always wrong?

All stable kernels should get covered as 27152bceea1d has both a Cc
stable tag and a Fixes tag for 5790b1fb3d67. And the stable kernels
look at what commits have been backported to determine what other
commits should be backported. By saying this fixes 27152bceea1d, it
should all work out correctly.

> 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace_events.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 6ef29eba90ce..852643d957de 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1540,7 +1540,8 @@ enum {
> >  
> >  static void *f_next(struct seq_file *m, void *v, loff_t *pos)
> >  {
> > -	struct trace_event_call *call = event_file_data(m->private);
> > +	struct trace_event_file *file = event_file_data(m->private);
> > +	struct trace_event_call *call = file->event_call;
> >  	struct list_head *common_head = &ftrace_common_fields;
> >  	struct list_head *head = trace_get_fields(call);
> >  	struct list_head *node = v;
> > @@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
> >  
> >  static int f_show(struct seq_file *m, void *v)
> >  {
> > -	struct trace_event_call *call = event_file_data(m->private);
> > +	struct trace_event_file *file = event_file_data(m->private);
> > +	struct trace_event_call *call = file->event_call;
> >  	struct ftrace_event_field *field;
> >  	const char *array_descriptor;
> >  
> > @@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
> >  
> >  static void *f_start(struct seq_file *m, loff_t *pos)
> >  {
> > +	struct trace_event_file *file;
> >  	void *p = (void *)FORMAT_HEADER;
> >  	loff_t l = 0;
> >  
> >  	/* ->stop() is called even if ->start() fails */
> >  	mutex_lock(&event_mutex);
> > -	if (!event_file_data(m->private))
> > +	file = event_file_data(m->private);
> > +	if (!file || (file->flags & EVENT_FILE_FL_FREED))
> >  		return ERR_PTR(-ENODEV);
> >  
> >  	while (l < *pos && p)
> > @@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
> >  	if (strcmp(name, "format") == 0) {
> >  		*mode = TRACE_MODE_READ;
> >  		*fops = &ftrace_event_format_fops;
> > -		*data = call;
> >  		return 1;
> >  	}
> >    
> 
> Tested-by: Mathias Krause <minipli@grsecurity.net>

Thanks!

-- Steve

