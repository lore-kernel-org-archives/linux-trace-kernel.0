Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8F2D8399;
	Fri, 21 Nov 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738543; cv=none; b=e28EuEbJ+FRTYiNOp/6/jGSrHr2/5CRjVuggittEJiUq1KiX85PZDagCpkPxNPmc9YwBomsMkIJlDQ8d8VgRRQbRlG0cu0LLwPwMGCeeGy7l6buyCse9843eCmBAfmJ5+MyDcy3BuSIQ4UKUR01S6s6+SoeZ8vx+unTQWL0RXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738543; c=relaxed/simple;
	bh=RIw6pp5WCPosptLJopqrrgG1TjpAvG0UJNi7hJYtDbs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ooXKBv7F+R8IAxNtt8XvmqekV83CUOu7QNH+A5iCiIVrUUD7qvTaL5f6aSDLyOfQSfeN0G7t7xjzlaK+52fEJkCpeCzBr7qJZ8d3WfEP1w7CUxD6F8JqyLsSYbjhU3YXZQoNY1EB3or9+S3hPa7t0zodH1KTW/9CIAc4Wm851pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEFCQl5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEFCQl5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF04C4CEF1;
	Fri, 21 Nov 2025 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763738543;
	bh=RIw6pp5WCPosptLJopqrrgG1TjpAvG0UJNi7hJYtDbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BEFCQl5vjeg8wS6LXGSVFJVaOO2mkuOI6u6qgGlMJqxz3JVK46dqqMLDXKAxpZcIv
	 eImfFQD38TmDSwLjV/1TA7NRjhGz++LFkNC+JHLwFBzN2H0Ck9ondKicvdyrNqKqUd
	 nm6FZJaZR+zaOVKYu8PlQANAxdgwEM1NRPbFdnb3am1hagP+jgkGGDY6TNxvbkQfkp
	 Oxt8gSc7Qe9IMfg3u2PDkCG2BQHor0gGZ2JK3mMEWsT0jRg7G66CrRKWId3kv/f5fp
	 JmBIxF84QMburgf4POs5Mdf8HntuwpyKU9zJOyFXPa17RvKJV+aYgYmggdf5Ylrr93
	 9OIEcFkS4YKCQ==
Date: Sat, 22 Nov 2025 00:22:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Use strim() in trigger_process_regex()
 instead of skip_spaces()
Message-Id: <20251122002218.538827c78b948a132ba11ee0@kernel.org>
In-Reply-To: <20251120205710.314839538@kernel.org>
References: <20251120205600.570673392@kernel.org>
	<20251120205710.314839538@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:56:03 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The function trigger_process_regex() is called by a few functions, where
> only one calls strim() on the buffer passed to it. That leaves the other
> functions not trimming the end of the buffer passed in and making it a
> little inconsistent.
> 
> Remove the strim() from event_trigger_regex_write() and have
> trigger_process_regex() use strim() instead of skip_spaces(). The buff
> variable is not passed in as const, so it can be modified.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 16e3449f3cfe..1dfe69146a81 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -309,7 +309,8 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
>  	char *command, *next;
>  	struct event_command *p;
>  
> -	next = buff = skip_spaces(buff);
> +	next = buff = strim(buff);
> +
>  	command = strsep(&next, ": \t");
>  	if (next) {
>  		next = skip_spaces(next);
> @@ -346,8 +347,6 @@ static ssize_t event_trigger_regex_write(struct file *file,
>  	if (IS_ERR(buf))
>  		return PTR_ERR(buf);
>  
> -	strim(buf);
> -
>  	guard(mutex)(&event_mutex);
>  
>  	event_file = event_file_file(file);
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
