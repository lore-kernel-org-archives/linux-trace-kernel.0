Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB196EEBB;
	Fri,  2 Jan 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378972; cv=none; b=FCR+Qz0IiLoxsx7R+aTjx9cVrtoBaVrkd880NVK4zJSTZssh8d0cvqmO9fCnqrr+5Q5zKxLPn6898ntIivVnuAcBE0oWgP526RPZhoTatWtlMAZcUCA6sfdCXrdHxIbDi1lXI7C990U9fsTl+x63x0b3126f4KlSmvoIsaydNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378972; c=relaxed/simple;
	bh=vgnhkFlc4vCqZPSBWVS5jziNFX20/nim0zAnafubpT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD35vrIBh523sjNM5C90wTuBX1miutzgKM57pjlFnaHBMwuu4crYW/QQoF+2lqmL2zLRZ3dfSwMwBJJjy3T9zmglapy+CMA7L7zVhWZHqZlWqsJRXBWvhrv3gIZf+gacXgZxzebgelnlfF5ZSXs8FAL19Y5OgPJxmWPW10z/2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C349AC3022;
	Fri,  2 Jan 2026 18:36:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8F43320023;
	Fri,  2 Jan 2026 18:36:04 +0000 (UTC)
Date: Fri, 2 Jan 2026 13:36:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, neelx@suse.com,
 sean@ashe.io, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add show_event_filters to expose active event
 filters
Message-ID: <20260102133619.39d3e323@gandalf.local.home>
In-Reply-To: <20260101233414.2476973-1-atomlin@atomlin.com>
References: <20260101233414.2476973-1-atomlin@atomlin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F43320023
X-Stat-Signature: o418836ypp6gezw69gh7kirkbr66asbt
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19v4XYSiUyjvgt0aWY4u1KCEtkBOvp/Ev4=
X-HE-Tag: 1767378964-769757
X-HE-Meta: U2FsdGVkX1/kGai+fjN109q12duAWHawt851RZkkrk3kl9d7XKfx9frqc8yCVB1tkrI75OndyVdwC1LqKI+R5eSfpfB+YHrpixK7PC/D66nx3oXBEj7EtK6LXo3sIX7eWjVD9GvTZzJdmgN/FhuGWhUQAFne8liR3TfC9kwJyCAuuNaQuYTfPV1qLZtlWF/yyQBy6aI7szqMbgIKcMZMcX2WbLzKu5o4bP0CipXsyqcOo/Hv8VvJvko4+YCFyQ4ORxls50EZBS+Cqc12QOaDhe7Mlvx/0tE1NpoqOGXylu2NmxwEYsR6BNyqjJShw3YLJumrbgmcWnlpjz3TqVWja1yy2HtVa8G4LlNqQCh2gAcuo8CUX10ZZkOPwJdAL/qU

On Thu,  1 Jan 2026 18:34:14 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> Currently, to audit active Ftrace event filters, userspace must
> recursively traverse the events/ directory and read each individual
> filter file. This is inefficient for monitoring tools and debugging.
> 
> Introduce "show_event_filters" at the trace root directory. This file
> displays all events that currently have a filter applied, alongside the
> actual filter string, in a consolidated system:event [tab] filter
> format.
> 
> The implementation reuses the existing trace_event_file iterators to
> ensure atomic traversal of the event list and utilises rcu_read_lock()
> to safely access volatile filter strings.

Nice. Perhaps we should do something similar for event triggers.

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  Documentation/trace/ftrace.rst |  6 ++++
>  kernel/trace/trace_events.c    | 62 ++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 639f4d95732f..27ea54bfbc52 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -684,6 +684,12 @@ of ftrace. Here is a list of some of the key files:
>  
>  	See events.rst for more information.
>  
> +  show_event_filters:
> +
> +	A list of events that are enabled and have a filter applied.

Enabled? Or just events with filters. I think this should just say:

	A list of events that have filters. This shows the system/event
	pair along with the filter that is attached to the event.


> +
> +	See events.rst for more information.
> +
>    available_events:
>  
>  	A list of events that can be enabled in tracing.
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index b16a5a158040..f578ee2e5c12 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1661,6 +1661,34 @@ static void t_stop(struct seq_file *m, void *p)
>  	mutex_unlock(&event_mutex);
>  }
>  
> +/**
> + * t_show_filters - seq_file callback to display active event filters
> + * @m: The seq_file instance
> + * @v: The current trace_event_file being iterated
> + *
> + * Traverses the trace_array event list and prints the system, name,
> + * and filter string for any event with an active filter.

This doesn't traverse the trace_array. The seq_file does the traversing.
Just state that this is part of the seq_file output and shows events with
filters.

> + * Uses RCU to safely dereference the volatile filter pointer.

This is internal to the function and should not be part of the kerneldoc.

> + */
> +static int t_show_filters(struct seq_file *m, void *v)
> +{
> +	struct trace_event_file *file = v;
> +	struct trace_event_call *call = file->event_call;
> +	struct event_filter *filter;
> +
> +	rcu_read_lock();

Use:

	guard(rcu)();

instead.

> +	filter = rcu_dereference(file->filter);
> +	if (filter && filter->filter_string) {
> +		seq_printf(m, "%s:%s\t%s\n",
> +			   call->class->system,
> +			   trace_event_name(call),
> +			   filter->filter_string);
> +	}
> +	rcu_read_unlock();

And remove the rcu_read_unlock().

Actually, the function may be better by just doing:

	guard(rcu)();
	filter = rcu_dereference(file->filter);
	if (!filter || !filter->filter_string)
		return 0;

	seq_printf(m, "%s:%s\t%s\n", call->class->system,
		   trace_event_name(call), filter->filter_string);

	return 0;



> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_MODULES
>  static int s_show(struct seq_file *m, void *v)
>  {
> @@ -2488,6 +2516,7 @@ ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
>  
>  static int ftrace_event_avail_open(struct inode *inode, struct file *file);
>  static int ftrace_event_set_open(struct inode *inode, struct file *file);
> +static int ftrace_event_show_filters_open(struct inode *inode, struct file *file);
>  static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
>  static int ftrace_event_set_npid_open(struct inode *inode, struct file *file);
>  static int ftrace_event_release(struct inode *inode, struct file *file);
> @@ -2506,6 +2535,13 @@ static const struct seq_operations show_set_event_seq_ops = {
>  	.stop = s_stop,
>  };
>  
> +static const struct seq_operations show_show_event_filters_seq_ops = {
> +	.start = t_start,
> +	.next = t_next,
> +	.show = t_show_filters,
> +	.stop = t_stop,
> +};
> +
>  static const struct seq_operations show_set_pid_seq_ops = {
>  	.start = p_start,
>  	.next = p_next,
> @@ -2535,6 +2571,13 @@ static const struct file_operations ftrace_set_event_fops = {
>  	.release = ftrace_event_release,
>  };
>  
> +static const struct file_operations ftrace_show_event_filters_fops = {
> +	.open = ftrace_event_show_filters_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = seq_release,
> +};
> +
>  static const struct file_operations ftrace_set_event_pid_fops = {
>  	.open = ftrace_event_set_pid_open,
>  	.read = seq_read,
> @@ -2679,6 +2722,22 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
>  	return ret;
>  }
>  
> +/**
> + * ftrace_event_show_filters_open - open interface for set_event_filters
> + * @inode: the inode of the file
> + * @file: the file being opened
> + *
> + * Connects the set_event_filters file to the sequence operations
> + * required to iterate over and display active event filters.
> + */
> +static int
> +ftrace_event_show_filters_open(struct inode *inode, struct file *file)
> +{
> +	const struct seq_operations *seq_ops = &show_show_event_filters_seq_ops;
> +
> +	return ftrace_event_open(inode, file, seq_ops);

Why not just:

	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);

?

> +}
> +
>  static int
>  ftrace_event_set_pid_open(struct inode *inode, struct file *file)
>  {
> @@ -4399,6 +4458,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  	if (!entry)
>  		return -ENOMEM;
>  
> +	trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
> +			  &ftrace_show_event_filters_fops);
> +
>  	nr_entries = ARRAY_SIZE(events_entries);
>  
>  	e_events = eventfs_create_events_dir("events", parent, events_entries,

Thanks,

-- Steve
