Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10317262FDC;
	Fri, 27 Mar 2026 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571873; cv=none; b=ofzw2gNqkcQEzuPeYB4Rk9A1OOoGpjqPaEa1l2I93/56PzI4mmLx7qwGO0Mj/Ewxk8w9gqZ9JTqXqB40dBQNwtkOaaT5jW7QywqBLTo6EjXHcMAMOYVjcXVG1T6MK5hH35Hma++AIJnMjU49nccd0mdv0LT/f+jmGHjpCgjcC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571873; c=relaxed/simple;
	bh=G80oynxNc1JNWwRGgRQ8/+/4NvZfM6MAqWuXay4gzoE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o6tZ5H5YUObafW8hfZtWApj8q2hD4F4BqrfuA+2r9Cu9EJrLrhl6+Mzz/hEenx68kgkp5/ZOzBzPSICahQH8LG/Q3w77B/lmszB9bsY3w/uQa7xqaCMiXe/55V8lwX1vldLJGFJqHbWWeAOnJG0QTQT5IpKDBbS3WQDzgpJFLYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+boZ/XW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+boZ/XW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD27C116C6;
	Fri, 27 Mar 2026 00:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774571872;
	bh=G80oynxNc1JNWwRGgRQ8/+/4NvZfM6MAqWuXay4gzoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S+boZ/XWYYV7S2LAMc2LvmIr1i8eiUQ+ahTxL3v/CPwGsAgIzhWMjhHqDNzKEpVca
	 logEebmB3cabmvLQp7Zv1s4UUTLd5aEdKth6ZwkTgDMTx3tPEmC1yJTOCsA0SXTGoC
	 F/+6dAVp6FUDRPE3+2c0LjrV6ZXBpL0qEBfn5aHjrG747Ywx1SCHITCSpHy2HlLkhD
	 tHYQ/2wQi8xOWEn4WABFOj9cyMvSVDm8xbm15D9MJbEU9Ywl5V8c/5kGzV0DxkD969
	 dkWKpsl2xkJtXWw5P1agH48zYuYlrz4VaiQda79DdDOI07zAQTOKnEL4WqSzVQP9Kk
	 kOJ7asLs+7dPA==
Date: Fri, 27 Mar 2026 09:37:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: david.laight.linux@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Petr Mladek <pmladek@suse.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] tracing: Remove spurious default precision from
 show_event_trigger/filter formats
Message-Id: <20260327093747.7dac73febf4536fb147dd7ec@kernel.org>
In-Reply-To: <20260326201824.3919-1-david.laight.linux@gmail.com>
References: <20260326201824.3919-1-david.laight.linux@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 20:18:24 +0000
david.laight.linux@gmail.com wrote:

> From: David Laight <david.laight.linux@gmail.com>
> 
> Change 2d8b7f9bf8e6e ("tracing: Have show_event_trigger/filter format a bit more in columns")
> added space padding to align the output.
> However it used ("%*.s", len, "") which requests the default precision.
> It doesn't matter here whether the userspace default (0) or kernel
> default (no precision) is used, but the format should be "%*s".
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  kernel/trace/trace_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 249d1cba72c0..6b54c10f9ba4 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1718,7 +1718,7 @@ static int t_show_filters(struct seq_file *m, void *v)
>  
>  	len = get_call_len(call);
>  
> -	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
> +	seq_printf(m, "%s:%s%*s%s\n", call->class->system,
>  		   trace_event_name(call), len, "", filter->filter_string);
>  
>  	return 0;
> @@ -1750,7 +1750,7 @@ static int t_show_triggers(struct seq_file *m, void *v)
>  	len = get_call_len(call);
>  
>  	list_for_each_entry_rcu(data, &file->triggers, list) {
> -		seq_printf(m, "%s:%s%*.s", call->class->system,
> +		seq_printf(m, "%s:%s%*s", call->class->system,
>  			   trace_event_name(call), len, "");
>  
>  		data->cmd_ops->print(m, data);
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
