Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63699846C;
	Sat, 19 Jul 2025 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899800; cv=none; b=C184XZMJNCzdE9c7L6l2D3GAY0yCPu4JVHqstjhaPN18YKbQiXFj0mb+vLHJ4RxigmgRMJo3JHjPnmOtvjflajpsKbCA9OocJuu1+cHlIvpiOEXoqW93FTFqCxYbDyOKamTNndKmO6KGUK+MSQEZTBaTDspJt/H/5a2Bb/RSWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899800; c=relaxed/simple;
	bh=ZWaiKcmdhVFNtI6FfH/pEyyxUfHDmIpPNCFdDbTmGmk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ixVfRWzhGIxeT3JqXJglX4V7utjtUFoM2kIMTxJdx+EmbBfYJAjphdBaxY5PqyJXN6bigae0ENEjKXZs2SRNG62ygCVh9GlW36f7y1YF8GgkEVztNHRLtTpaCoSUIHfQooYLJybfBkAX8jYEva31SC1YEiYoxRtXowmsaXZrFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIAkSlHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIAkSlHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D695C4CEE3;
	Sat, 19 Jul 2025 04:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752899799;
	bh=ZWaiKcmdhVFNtI6FfH/pEyyxUfHDmIpPNCFdDbTmGmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIAkSlHu90P9OkR8TbeMWIJafVzrASm6ixeuHgrEBSLLflppoYMr7mAP+KPiFl8nA
	 DHl9lIY57G3g+Dv3cBgZIXdiuwDUsjaC3LTuAIyRc8HXYRiM8B/wih6RlqmWUGGdgk
	 82iFp5U9/l7LtRlJjTRdUX5rq9Cg6oAqKUEm5CGpgGxOoXgMajTY40wsDInrHKbTwh
	 T2h7dwCtXoiG9vVIrojDogIPWicCSTZGj6Bm53GHp7LblflOtTG2muig6jUZfLJfQB
	 r2TUXfsD49MFt6323Pswdx2PekefBt6ammewLmgrY8QhvA4X8M0qxiHSJvGKosmt9l
	 i5VmeBv9TrC8Q==
Date: Sat, 19 Jul 2025 13:36:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 =?UTF-8?B?IkZ1c2hlbmcgSHVhbmcoIOm7hOWvjOeUnykgIg==?=
 <Fusheng.Huang@luxshare-ict.com>
Subject: Re: [PATCH v2] tracing: Add down_write(trace_event_sem) when adding
 trace event
Message-Id: <20250719133634.f424cba37241e73b0f774a7f@kernel.org>
In-Reply-To: <20250718223158.799bfc0c@batman.local.home>
References: <20250718223158.799bfc0c@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 22:31:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When a module is loaded, it adds trace events defined by the module. It
> may also need to modify the modules trace printk formats to replace enum
> names with their values.
> 
> If two modules are loaded at the same time, the adding of the event to the
> ftrace_events list can corrupt the walking of the list in the code that is
> modifying the printk format strings and crash the kernel.
> 
> The addition of the event should take the trace_event_sem for write while
> it adds the new event.
> 
> Also add a lockdep_assert_held() on that semaphore in
> __trace_add_event_dirs() as it iterates the list.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Cc: stable@vger.kernel.org
> Reported-by: Fusheng Huang(黄富生)  <Fusheng.Huang@luxshare-ict.com>
> Closes: https://lore.kernel.org/all/20250717105007.46ccd18f@batman.local.home/
> Fixes: 110bf2b764eb6 ("tracing: add protection around module events unload")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250717131204.74559b88@batman.local.home
> 
> - Replace lockdep_assert_held_read() with lockdep_assert_held() as it is
>   actually held with down_write() when it is called.
> 
>  kernel/trace/trace_events.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..d01e5c910ce1 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3136,7 +3136,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
>  	if (ret < 0)
>  		return ret;
>  
> +	down_write(&trace_event_sem);
>  	list_add(&call->list, &ftrace_events);
> +	up_write(&trace_event_sem);
> +
>  	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
>  		atomic_set(&call->refcnt, 0);
>  	else
> @@ -3750,6 +3753,8 @@ __trace_add_event_dirs(struct trace_array *tr)
>  	struct trace_event_call *call;
>  	int ret;
>  
> +	lockdep_assert_held(&trace_event_sem);
> +
>  	list_for_each_entry(call, &ftrace_events, list) {
>  		ret = __trace_add_new_event(call, tr);
>  		if (ret < 0)
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
