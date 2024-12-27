Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51531F6683;
	Fri, 27 Dec 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312278; cv=none; b=inceK26T3qvSADhtjgbgc4rPBsuWbbk2YjtTmvXq9WSkM5wqfnFIp7UyH5/Cmp79+gFAo37hvA6iCLdPA4jO2hUZIjh/zs1+4uui1ubeU03B2vMUAgALauRdYWIS0eZuZTuZXk/CHY2n3MEElQIQeNZR54SK5g+3Xivc7YkBzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312278; c=relaxed/simple;
	bh=kfOeBwnv0Ds0MeKw4CIrx5qvFwJZYHF15Vgt3M51MdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq++wsjJibzFojS2Re0QBKG2HHM7lVZFsIG6kd356VgqoVu8ShjQdIlWFNVoga3U4a+7B/qNt5X95mAKAXu8CkwR1PzmqfiEVqJFy6xb3FH1k5l0dxPfgCT0oCRtGTDvMrCKN5k3aqTDgUH0ZUD9gXcXjG4XTHCQMwvHSbdCeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33F8C4CED0;
	Fri, 27 Dec 2024 15:11:17 +0000 (UTC)
Date: Fri, 27 Dec 2024 10:12:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] tracing/dynevent: Adopt guard() and
 scoped_guard()
Message-ID: <20241227101218.5948129c@gandalf.local.home>
In-Reply-To: <173289891992.73724.9491350426847416169.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
	<173289891992.73724.9491350426847416169.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:48:40 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use guard() or scoped_guard() in dynamic events for critical sections
> rather than discrete lock/unlock pairs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Use scoped_guard() instead of guard() to avoid goto warnings.

I forgot you touched this file, and added a free guard to it which
conflicts. That said, I have some issues with this patch.

> ---
>  kernel/trace/trace_dynevent.c |   35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index 4376887e0d8a..eb8f669c15e1 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -63,9 +63,8 @@ int dyn_event_register(struct dyn_event_operations *ops)
>  		return -EINVAL;
>  
>  	INIT_LIST_HEAD(&ops->list);
> -	mutex_lock(&dyn_event_ops_mutex);
> +	guard(mutex)(&dyn_event_ops_mutex);
>  	list_add_tail(&ops->list, &dyn_event_ops_list);
> -	mutex_unlock(&dyn_event_ops_mutex);

I don't care for a scoped guards around simple paths. The great thing about
guard()s is that they help prevent bugs when you have complex code between
the lock and unlock that may need to exit.

But replacing:


	mutex_lock(&dyn_event_ops_mutex);
 	list_add_tail(&ops->list, &dyn_event_ops_list);
	mutex_unlock(&dyn_event_ops_mutex);
 }


With:

	guard(mutex)(&dyn_event_ops_mutex);
 	list_add_tail(&ops->list, &dyn_event_ops_list);
 }

is overkill to me. The first one is much easier to read. The second one
begs the question, "why did they use a guard here?"

>  	return 0;
>  }
>  
> @@ -106,20 +105,20 @@ int dyn_event_release(const char *raw_command,
> struct dyn_event_operations *type goto out;
>  	}
>  
> -	mutex_lock(&event_mutex);
> -	for_each_dyn_event_safe(pos, n) {
> -		if (type && type != pos->ops)
> -			continue;
> -		if (!pos->ops->match(system, event,
> -				argc - 1, (const char **)argv + 1, pos))
> -			continue;
> -
> -		ret = pos->ops->free(pos);
> -		if (ret)
> -			break;
> +	scoped_guard(mutex, &event_mutex) {
> +		for_each_dyn_event_safe(pos, n) {
> +			if (type && type != pos->ops)
> +				continue;
> +			if (!pos->ops->match(system, event,
> +					argc - 1, (const char **)argv +
> 1, pos))
> +				continue;
> +
> +			ret = pos->ops->free(pos);
> +			if (ret)
> +				break;
> +		}
> +		tracing_reset_all_online_cpus();
>  	}

This scoped_guard() doesn't give us anything. We still have the out label
below (which my patch removes).



> -	tracing_reset_all_online_cpus();
> -	mutex_unlock(&event_mutex);
>  out:
>  	argv_free(argv);
>  	return ret;
> @@ -133,13 +132,12 @@ static int create_dyn_event(const char *raw_command)
>  	if (raw_command[0] == '-' || raw_command[0] == '!')
>  		return dyn_event_release(raw_command, NULL);
>  
> -	mutex_lock(&dyn_event_ops_mutex);
> +	guard(mutex)(&dyn_event_ops_mutex);
>  	list_for_each_entry(ops, &dyn_event_ops_list, list) {
>  		ret = ops->create(raw_command);
>  		if (!ret || ret != -ECANCELED)
>  			break;
>  	}

I also don't think this helps much here.
> -	mutex_unlock(&dyn_event_ops_mutex);
>  	if (ret == -ECANCELED)
>  		ret = -EINVAL;
>  
> @@ -198,7 +196,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
>  	struct dyn_event *ev, *tmp;
>  	int ret = 0;
>  
> -	mutex_lock(&event_mutex);
> +	guard(mutex)(&event_mutex);
>  	for_each_dyn_event(ev) {
>  		if (type && ev->ops != type)
>  			continue;
> @@ -216,7 +214,6 @@ int dyn_events_release_all(struct dyn_event_operations *type)
>  	}
>  out:

And the same issue here too. Why the guard when you still need to do the
goto?


>  	tracing_reset_all_online_cpus();
> -	mutex_unlock(&event_mutex);
>  
>  	return ret;
>  }


There's a reason I looked at this file an didn't add any guards to it (when
I forgot that you touched it). They are all special cases, and I rather
avoid adding special case guards to handle it. I don't believe it makes it
any less error prone.

Are you OK with dropping this patch?

-- Steve
