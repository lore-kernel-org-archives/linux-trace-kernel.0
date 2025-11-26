Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A83303A08;
	Wed, 26 Nov 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167928; cv=none; b=N8WWiQ7l8HYFf2nPBU35sa/cneFHiJG5lvITG/v7hpg3l+8ak2agFBzyz2rxo6dA3WCKM4JASEm7Dyxt2K3PKVP+0CvIb/O+6iJyNTFrx4i88GRnx8CTET4GjTZiloTLLaiHskqCj3SHbghcqhlR/wtG+Jkpl1TkOy/RdIyOF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167928; c=relaxed/simple;
	bh=zqDDxGTQytb5d+2QtpEhNrwnvj53cCDE00mQv7oBMwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiCFtr2VYsL34D4iD32R9xvOktxoFvnDPogo5qt/JKGRZcQYBqzjr2luUngDTVGiwY5ifQczVLCLKYZfbwx5XfHSVmmLNJp61SzBwS3s1pOG4ANlkaRQT5eyCfs76vQtdfCLub8LIXz/Z+Wf0XvIecphHz7y1PmBFlSEQH/Dwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id AC58959A70;
	Wed, 26 Nov 2025 14:38:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id DA1DF20029;
	Wed, 26 Nov 2025 14:38:39 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:39:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add system trigger file to enable triggers
 for all the system's events
Message-ID: <20251126093920.30763e89@gandalf.local.home>
In-Reply-To: <20251126150251.f3556dfc322a2563a75485e3@kernel.org>
References: <20251125200837.31aae207@gandalf.local.home>
	<20251126150251.f3556dfc322a2563a75485e3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DA1DF20029
X-Stat-Signature: 1i3etw4i6pbi9woewomuqrf9z9uh7dkz
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+o7FAoJoQmWLfI+Z4j+5iBg6FA41b5n94=
X-HE-Tag: 1764167919-145949
X-HE-Meta: U2FsdGVkX1/bzZhX95qoxKe63fi5YhOkwJFtuVwZX1R5MLq6Pv4jv8551qjwTbUtROsFs8LDzvzl6AQMwKS2BvK5hvBlwVmGuiTytwPJvbJp/6Vs5MAQZsWVrTQllV+9GooDg1n7UhUyBDXWVUTIVmHzwx871cHXx+mAs7csnsBMvun8wOML/t1h/xvmUC4pp1mg9jrVmYpErYwJKx6X053pk6u0HVaD+9yW8z1/KfCcNpcaC93CS3OQnnc/JB0ECTtGpyKenX/V5JbDv2lVbBs+ua+m/V10NUTA/o6ZLL3c73ilMvcY/6PhlTW0/6ZVEbMz03UfJHPqySP8meXVV8J2RnlqGR8M

On Wed, 26 Nov 2025 15:02:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > This also allows to remove a trigger from all events in a subsystem (even
> > if it's not a subsystem trigger!).
> >   
> 
> I have some comments below.

BTW, it's more appropriate to simply trim the email ;-)


> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -2168,51 +2168,52 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
> >  
> >  static LIST_HEAD(event_subsystems);
> >  
> > -static int subsystem_open(struct inode *inode, struct file *filp)
> > +struct trace_subsystem_dir *trace_get_system_dir(struct inode *inode)
> >  {
> > -	struct trace_subsystem_dir *dir = NULL, *iter_dir;
> > -	struct trace_array *tr = NULL, *iter_tr;
> > -	struct event_subsystem *system = NULL;
> > -	int ret;
> > +	struct trace_subsystem_dir *dir;
> > +	struct trace_array *tr = NULL;  
> 
> nit: This also no need to be initialized.

Hmm, I guess this was needed in one of the versions I had before posting.

I'll fix in v3.

> 
> >  
> > -	if (tracing_is_disabled())
> > -		return -ENODEV;
> > +	guard(mutex)(&event_mutex);
> > +	guard(mutex)(&trace_types_lock);
> >  
> >  	/* Make sure the system still exists */
> > -	mutex_lock(&event_mutex);
> > -	mutex_lock(&trace_types_lock);
> > -	list_for_each_entry(iter_tr, &ftrace_trace_arrays, list) {
> > -		list_for_each_entry(iter_dir, &iter_tr->systems, list) {
> > -			if (iter_dir == inode->i_private) {
> > +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> > +		list_for_each_entry(dir, &tr->systems, list) {
> > +			if (dir == inode->i_private) {
> >  				/* Don't open systems with no events */
> > -				tr = iter_tr;
> > -				dir = iter_dir;
> > -				if (dir->nr_events) {
> > -					__get_system_dir(dir);
> > -					system = dir->subsystem;
> > -				}
> > -				goto exit_loop;
> > +				if (!dir->nr_events)
> > +					return NULL;
> > +				if (__trace_array_get(tr) < 0)
> > +					return NULL;
> > +				__get_system_dir(dir);
> > +				return dir;
> >  			}
> >  		}
> >  	}


> >  static ssize_t event_trigger_regex_write(struct file *file,
> >  					 const char __user *ubuf,
> >  					 size_t cnt, loff_t *ppos)
> >  {
> >  	struct trace_event_file *event_file;
> >  	ssize_t ret;
> > -	char *buf __free(kfree) = NULL;
> > +	char *buf __free(kfree) = get_user_buf(ubuf, cnt);
> >  
> > -	if (!cnt)
> > +	if (!buf)
> >  		return 0;
> >  
> > -	if (cnt >= PAGE_SIZE)
> > -		return -EINVAL;
> > -
> > -	buf = memdup_user_nul(ubuf, cnt);
> >  	if (IS_ERR(buf))
> >  		return PTR_ERR(buf);  
> 
> You can simply write:
> 
> 	if (IS_ERR_OR_NULL(buf))
> 		return PTR_ERR_OR_ZERO(buf);

Yes I can. But honestly, the above is much harder to understand what is
happening than the code I had written.

I mean:

	if (!buf)
		return 0;

	if (IS_ERR(buf))
		return PTR_ERR(buf);

is pretty obvious of what is happening.

	if (IS_ERR_OR_NULL(buf))
		return PTR_ERR_OR_ZERO(buf);

Is quite a bit more obfuscated. I mean, I needed to look up what
PTR_ERR_OR_ZERO() did to be sure I knew what was returned.

> > +	list_for_each_entry(file, &tr->events, list) {
> > +
> > +		if (strcmp(system->name, file->event_call->class->system) != 0)
> > +			continue;
> > +
> > +		ret = p->parse(p, file, buff, command, next);
> > +
> > +		/* Removals and existing events do not error */
> > +		if (ret < 0 && ret != -EEXIST && !remove) {
> > +			pr_warn("Failed adding trigger %s on %s\n",
> > +				command, trace_event_name(file->event_call));
> > +		}  
> 
> 
> Can I expect that this can recover the previous settings
> via event trigger?
> e.g. 
> 
> # echo "stacktrace" > events/sched/sched_wakeup/trigger
> # echo "stacktrace" > events/sched/trigger
> # echo "!stacktrace" > events/sched/trigger
> # cat events/sched/sched_wakeup/trigger
> stacktrace:unlimited
> 
> ?

No. In fact, this is one of the features of the system trigger. Writing
into the system/trigger file is the same as writing into each of the
system's event's trigger files one at a time. In fact, I updated the
documentation in this patch to show that this file can be used to clear
tiggers too!

+       echo snapshot > events/sched/sched_waking/trigger
+       cat events/sched/sched_waking/trigger
+       snapshot:unlimited
+       echo '!snapshot' > events/sched/trigger
+       cat events/sched/sched_waking/trigger
+       # Available triggers:
+       # traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist


> 
> 
> > +	}
> > +	return 0;
> > +}
> > +
> > +static ssize_t
> > +event_system_trigger_write(struct file *filp, const char __user *ubuf,
> > +		    size_t cnt, loff_t *ppos)
> > +{
> > +	struct trace_subsystem_dir *dir = filp->private_data;
> > +	struct event_command *p;
> > +	char *command, *next;
> > +	char *buf __free(kfree) = get_user_buf(ubuf, cnt);
> > +	bool remove = false;
> > +	bool found = false;
> > +	ssize_t ret;
> > +
> > +	if (!buf)
> > +		return 0;
> > +
> > +	if (IS_ERR(buf))
> > +		return PTR_ERR(buf);  
> 
> Ditto.

And ditto again with my reply ;-)

> 
> > +
> > +	/* system triggers are not allowed to have counters */
> > +	if (strchr(buf, ':'))
> > +		return -EINVAL;  
> 
> ':' is not always used for counters (e.g. hist) and it seems odd
> to check anything about parse here. Can we do this counter check
> after parse a command?
> 
> > +
> > +	/* If opened for read too, dir is in the seq_file descriptor */
> > +	if (filp->f_mode & FMODE_READ) {
> > +		struct seq_file *m = filp->private_data;
> > +		dir = m->private;
> > +	}
> > +
> > +	/* Skip added space at beginning of buf */
> > +	next = strim(buf);
> > +
> > +	command = strsep(&next, " \t");
> > +	if (next) {
> > +		next = skip_spaces(next);
> > +		if (!*next)
> > +			next = NULL;
> > +	}  
> 
> strim() removes both leading and trailing whitespace. So this check is
> not required.

But next here is not the one that had strim() attached to it.

	command = strsep(&next, " \t");

Updates the content of next.

Thanks for the review,

-- Steve
