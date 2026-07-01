Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70341226D;
	Wed,  1 Jul 2026 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945684; cv=none; b=Jswut0r8enxz2eJ2KO2NvGXN3qkaFF5iNh1SYSJkQP0BrQJj3b0dNP/1APulqXOMfa+zBxqvfGNx5GR/BtDGVXTHqZMdF/Fd/jItv+YUQpXt60VEUvSlX/+PViKo7We9CflpzstpEpLuS5s9K80qyTSFVZIEF3GVANnawWb1Wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945684; c=relaxed/simple;
	bh=uwH00bRWRCnA79IUVq1ssJACyITdmE2VrAJk/A30sYE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fQyk6ds8tg3liXhLF0BOYFFZOCw4oAF6jeYAaih3TsLN5RaHm/AgdCpEkyC+ZEzrNHQVYFe2hTE0aN+h8+gZdT6C1MvAJ31t+x9t8O3wlmakJyZJ2Ilv+eVuOfvjg+HOTHuQe3QxbkH3QY5TcWrRPI4ud3iFmA++uSr6X1g47CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqQwccoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqQwccoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB641F000E9;
	Wed,  1 Jul 2026 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782945683;
	bh=Pv+dx1QCv488RUWsR9Tg5lSeIp3qwvj6cFvBZ38tdTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DqQwccoKfGAqX8FVcg3Fzg4kJw2qWpu2liMObonlmWoSB+1j7O/ea1Umn5l6Lt+wl
	 E8FktUbw1+O/pr1EWuR7S3okFDkJ3FMnAXTo4EUNOz7SGYV0GBDuHoiYT3rtQKzOhj
	 i0i5hFbL679+6cK0RfnEmInV+2hu4mMSms1pbmmyoSoQsO2Jh4czVHN2+ZRYEKY/co
	 4gRxtP8OGs1c+KsJSA+B8wGbiu5SkwVJUviKbJUk9SQtzeJkOJ9f7eVslgCWAAN3Qp
	 eGxmJ41RYavpbizPRwP9Nf31sBLI3C+/XkAKClNA0dx4Ro3PIez3VSV8f7GI469UvJ
	 kzr0vAohV68eA==
Date: Thu, 2 Jul 2026 07:41:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-Id: <20260702074119.cc576d8423ed766fb407f7cb@kernel.org>
In-Reply-To: <20260701174829.67ab8a33@gandalf.local.home>
References: <20260701174829.67ab8a33@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 17:48:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The enable_data variable gets freed on most error paths in
> event_enable_trigger_parse(). Use free() to free it and just before
> returning normally, call no_free_ptr(enable_data) to keep it from being
> freed.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..fe5ca6ac7c8d 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>  			       char *glob, char *cmd, char *param_and_filter)
>  {
>  	struct trace_event_file *event_enable_file;
> -	struct enable_trigger_data *enable_data;
> +	struct enable_trigger_data *enable_data __free(kfree) = NULL;
>  	struct event_trigger_data *trigger_data;
>  	struct trace_array *tr = file->tr;
>  	char *param, *filter;
> @@ -1789,17 +1789,13 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>  	enable_data->file = event_enable_file;
>  
>  	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
> -	if (!trigger_data) {
> -		kfree(enable_data);
> +	if (!trigger_data)
>  		return ret;
> -	}
>  
>  	if (remove) {
>  		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>  		kfree(trigger_data);
> -		kfree(enable_data);
> -		ret = 0;
> -		return ret;
> +		return 0;
>  	}
>  
>  	/* Up the trigger_data count to make sure nothing frees it on failure */
> @@ -1829,6 +1825,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>  		goto out_disable;
>  
>  	event_trigger_free(trigger_data);
> +	no_free_ptr(enable_data);
>  	return ret;
>   out_disable:
>  	trace_event_enable_disable(event_enable_file, 0, 1);
> @@ -1837,7 +1834,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>   out_free:
>  	event_trigger_reset_filter(cmd_ops, trigger_data);
>  	event_trigger_free(trigger_data);
> -	kfree(enable_data);
>  
>  	return ret;
>  }
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
