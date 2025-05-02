Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5F15A848;
	Fri,  2 May 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193819; cv=none; b=lbE4+EkOdXbq7zjMxJo32OJIGWjatKVLlIYuXHjgP7guswtpvhm+N8V+sSLon595Wxwb9oXhfE9i199Mq6+dnqgvkmzhdW6mp0sMTomkTPEu6LkrFY1qX2UruIJJjSQd3OHUubYYrgSUqBo9TsSrMfw9v8Vo4aLlsHdfEQ2qImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193819; c=relaxed/simple;
	bh=Nb/eXk2fbpiaVSkfDB5EFnBMcgoaMSvuaoHQKAMHA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enWGe5afjDCiN6BZsBf1sxZHv2jNH0fEolJaJlDMZ+yEqdhYxZ30iMWr8UBAUJGgAGAdTRRMcmv4+jI2Sc0wf/mZaOZTkuvZNb23xDja+y/eh9WPiOwo5etP7jXXNVwHctLgbrwMoE53BED/1+WdPkipQBHnFWqzWjrH0i6Lux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2AAC4CEE4;
	Fri,  2 May 2025 13:50:18 +0000 (UTC)
Date: Fri, 2 May 2025 09:50:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Cc: paulcacheux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Namhyung Kim
 <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing: protect trace_probe_log with mutex
Message-ID: <20250502095025.1bc0426e@gandalf.local.home>
In-Reply-To: <20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
	<20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 15:15:53 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>
> 
> The shared trace_probe_log variable can be accessed and modified
> by multiple processes using tracefs at the same time, this new
> mutex will guarantee it's always in a coherent state.
> 
> There is no guarantee that multiple errors happening at the same
> time will each have the correct error message, but at least this
> won't crash.
> 
> Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
> 

No space needed between Fixes and SOB.

> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..14a7a0b59cd20a8bc43e3e7c653e986081f924c8 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -154,9 +154,11 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
>  }
>  
>  static struct trace_probe_log trace_probe_log;
> +static DEFINE_MUTEX(trace_probe_log_lock);

Probably should add a comment here saying something like:

/*
 * The trace_probe_log_lock only protects against the individual
 * modification of the trace_probe_log. It does not protect against
 * the log from producing garbage if two probes use it at the same
 * time. That would only happen if two admins were trying to add
 * probes simultaneously which they shouldn't be doing.
 */

-- Steve


>  
>  void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	trace_probe_log.subsystem = subsystem;
>  	trace_probe_log.argc = argc;
>  	trace_probe_log.argv = argv;
> @@ -165,11 +167,13 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
>  
>  void trace_probe_log_clear(void)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
>  }
>  
>  void trace_probe_log_set_index(int index)
>  {
> +	guard(mutex)(&trace_probe_log_lock);
>  	trace_probe_log.index = index;
>  }
>  
> @@ -178,6 +182,8 @@ void __trace_probe_log_err(int offset, int err_type)
>  	char *command, *p;
>  	int i, len = 0, pos = 0;
>  
> +	guard(mutex)(&trace_probe_log_lock);
> +
>  	if (!trace_probe_log.argv)
>  		return;
>  
> 

