Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162233858F;
	Tue, 17 Feb 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342658; cv=none; b=NSkqSPVyaLdBNhjfQUNDaZt//lhY6/aWwFh3zLlFUPEa9LdAKXIQj5Kh9B/BHnIx3BwfuWJvvdXjso/3wjtQ0U6TGBI4+pCwldg+JU1b3f/NiGEi3dhnxA25Hsc7O8FKF9XvY/DV65cxVzy66rCczTro7p8xBixokPZZ34CzDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342658; c=relaxed/simple;
	bh=Xa+PVkV/1CwOqs1ygpbKzez/3wOg4Q6+Jvj/ZHOfEok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwRkL20XhHO1zbC3cvU8TgmlaRtegueddbOU8yypeFc556ThlkU9WHaZdpFy9623tA6OWeBnIebWEpOnJi/awZGxostdkBtpVTxvbB9eSHPPmJ9jb6o6OWF5pT/JDdJCr74Sw9ZItzA+rp36k8K9o5qCp8RRkIWolyq7jdJRTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E3259575BF;
	Tue, 17 Feb 2026 15:30:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 6F79B20033;
	Tue, 17 Feb 2026 15:29:56 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:29:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tracing: Fix checking of freed trace_event_file
 for hist files
Message-ID: <20260217102957.7702081d@gandalf.local.home>
In-Reply-To: <20260216134247.1311631-2-petr.pavlu@suse.com>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
	<20260216134247.1311631-2-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sw5swmy84iec15gazrzw7s3dk3n1k415
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6F79B20033
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gpscJ3Roo/IcjKWjmtSn/sFBTAIi7KPQ=
X-HE-Tag: 1771342196-480502
X-HE-Meta: U2FsdGVkX1+K/iRQRFiFPF2/hyjEWv64vCPtT3trUu/u29YT9pm3WH+GDycLu5qMhBP94QrOekqCncZDp22xU2cCU1pqA9LAq8INnR5UU6+He/IUTp1ZXm7gO8feWHTV1kcgTVmC6XjHwsePyPmybw5+n4CQMiU3s8wybAvbmeXdZB0tT2xjsyK1niIRdWM9nWejACxB4bVrMI3kXdg1wsFqjrlhfegg3u46VIZwxydljp/BcM8GuYBJwWq5q1GnkhpWmw3txrseMmzOsEF1lAMrzh59vJdeDIIyhEXnZGqB0HduI7piNkUwtENhQUz0ehDfICz/cSdi49StTs/sep3ACfxahnJw4CpaofzN6O+bW/vgMIUQ3hOEej10/hl/

On Mon, 16 Feb 2026 14:41:57 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 3690221ba3d8..f925034e402d 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -683,6 +683,11 @@ static inline void hist_poll_wakeup(void)
>  
>  #define hist_poll_wait(file, wait)	\
>  	poll_wait(file, &hist_poll_wq, wait)
> +
> +#else
> +static inline void hist_poll_wakeup(void)
> +{
> +}
>  #endif
>  
>  #define __TRACE_EVENT_FLAGS(name, value)				\
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

This should be broken into two different patches. One for the
hist_poll_wakeup() fix, the other to use event_file_file().

-- Steve

