Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42A368942;
	Fri, 27 Feb 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207510; cv=none; b=CEyvFnXHL8nJaeCEibnXFNwROnMNYj56nqSrE3goauV+W3dC/FbSGKTlnMUl28U/w9uoWaZ9S4FvXhAKVTeS13vmOXwM8aJCAIPzGVQ/pbcRcENRTM1dPFjekUgvzgam3Xwq1oRUqAvkkKftWOF5C8mw0ky3btTwinv65/PeRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207510; c=relaxed/simple;
	bh=+aCMNr877FILRv3jDItxNrpluz5sjHtO+YLRsUy1UlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF3LHtaPEBsw6FXxhWY39foaQlUnE9AGuKNmKrXhgkaM2Is65GHxK5IRT69xXl2/lkorQ3raejhjGMqysyJnhtNrR5IWlRq/f6zlGbSl0IAjTea7qUQSLrzJ0kyJXXrN1v8LPeGvn6dLfjtwTwzfT+vs+DS6Wy/nQMq7daEBNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3B71BBB10F;
	Fri, 27 Feb 2026 15:51:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 178121C;
	Fri, 27 Feb 2026 15:51:43 +0000 (UTC)
Date: Fri, 27 Feb 2026 10:52:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
Message-ID: <20260227105207.01473471@gandalf.local.home>
In-Reply-To: <20260227150420.319528-1-tglozar@redhat.com>
References: <20260227150420.319528-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7pe5exjqxpy35ra7fs8twjouk413j6ey
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 178121C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/5ENNi5ofEpxLTvRAwu3nP1xnSPbDu5M=
X-HE-Tag: 1772207502-689402
X-HE-Meta: U2FsdGVkX18U4tBVOyunpHko/7QZwLU7431o5kcEwQrx9HjR4gladBeXCa6QfZC+KJoXERl3FSC6S+Q9whB0iqGNqVz32BYIjOUg3+k11RnrqExAtdPYoDtfCt2WjjF1zR7TzCYCA4hH+9o/j0x8vvMnsqSxtprS0XJy6AIGI9uIJ5MjrsQx0K3JXOczvtQ//RMhzLwWoAeaXseqTOdaq3gIIzJrhpav5+9aBkFFJwoSXobBhW1Chpmhymfw43UINftWMCTr3H4norDBoOsqgcZIbzBIqVxZ/X91GPEkikn0ZMdN+crm8voTGxAUevv2t+4YzhRAU/6yN9nBPMcXX37miz4yQcYV

On Fri, 27 Feb 2026 16:04:20 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
> corresponding setting osnoise/timerlat_align_us.
> 
> This option sets the alignment of wakeup times between different
> timerlat threads, similarly to cyclictest's -A/--aligned option. If
> TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> records its first wake-up time. Each following thread sets its first
> wake-up time to a fixed offset from the recorded time, and incremenets
> it by the same offset.
> 
> Example:
> 
> osnoise/timerlat_period is set to 1000, osnoise/timerlat_align_us is
> set to 50. There are four threads, on CPUs 1 to 4.

Is it set to 50 or 20?

> 
> - CPU 4 enters first cycle first. The current time is 20000us, so
> the wake-up of the first cycle is set to 21000us. This time is recorded.
> - CPU 2 enter first cycle next. It reads the recorded time, increments
> it to 21020us, and uses this value as its own wake-up time for the first
> cycle.
> - CPU 3 enters first cycle next. It reads the recorded time, increments
> it to 21040 us, and uses the value as its own wake-up time.

As the increments are off by 20 and not 50.

> - CPU 1 proceeds analogically.
> 
> In each next cycle, the wake-up time (called "absolute period" in
> timerlat code) is incremented by the (relative) period of 1000us. Thus,
> the wake-ups in the following cycles (provided the times are reached and
> not in the past) will be as follows:
> 
> CPU 1		CPU 2		CPU 3	 	CPU 4
> 21080us		21020us		21040us		21000us
> 22080us		22020us		22040us		22000us
> ...		...		...		...
> 
> Even if any cycle is skipped due to e.g. the first cycle calculation
> happening later, the alignment stays in place.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> 
> I tested this option using the following command:
> 
> $ bpftrace -e 'tracepoint:osnoise:timerlat_sample /!@time[cpu]/ {
>       if (!@begin) { @begin = nsecs; }
>       @time[cpu] = ((nsecs - @begin) / 1000) % 1000;
>   }
>  END { clear(@begin); }' -c 'rtla timerlat hist -d 1s -c 1-10'
> 
> This captures the alignment of first timerlat sample (which is +-
> equivalent to the wake-up time).
> 
> With timerlat_align_us = 20:
> 
> @time[1]: 2
> @time[2]: 18
> @time[3]: 38
> @time[4]: 57
> @time[5]: 83
> @time[6]: 103
> @time[7]: 123
> @time[8]: 143
> @time[9]: 162
> @time[10]: 182
> 
> With timerlat_align_us = 0
> 
> @time[1]: 1
> @time[5]: 4
> @time[7]: 4
> @time[6]: 4
> @time[8]: 4
> @time[9]: 4
> @time[10]: 4
> @time[4]: 5
> @time[3]: 5
> @time[2]: 5
> 
> Only thing I am not too sure about is the absense of barriers. I feel
> like I only touch that one atomic variable concurrently, so it should
> be fine (unlike e.g. a mutex protecting another variable, where you need
> acquire-release semantics) with relaxed variants of atomic functions;
> but I don't have any other experience with barriers so far.
> 
>  kernel/trace/trace_osnoise.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index dee610e465b9..df1d4529d226 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -58,6 +58,7 @@ enum osnoise_options_index {
>  	OSN_PANIC_ON_STOP,
>  	OSN_PREEMPT_DISABLE,
>  	OSN_IRQ_DISABLE,
> +	OSN_TIMERLAT_ALIGN,
>  	OSN_MAX
>  };
>  
> @@ -66,7 +67,8 @@ static const char * const osnoise_options_str[OSN_MAX] = {
>  							"OSNOISE_WORKLOAD",
>  							"PANIC_ON_STOP",
>  							"OSNOISE_PREEMPT_DISABLE",
> -							"OSNOISE_IRQ_DISABLE" };
> +							"OSNOISE_IRQ_DISABLE",
> +							"TIMERLAT_ALIGN" };
>  
>  #define OSN_DEFAULT_OPTIONS		0x2
>  static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
> @@ -326,6 +328,7 @@ static struct osnoise_data {
>  	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	u64	timerlat_period;	/* timerlat period */
> +	u64	timerlat_align_us;	/* timerlat alignment */
>  	u64	print_stack;		/* print IRQ stack if total > */
>  	int	timerlat_tracer;	/* timerlat tracer */
>  #endif
> @@ -338,6 +341,7 @@ static struct osnoise_data {
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	.print_stack			= 0,
>  	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
> +	.timerlat_align_us		= 0,
>  	.timerlat_tracer		= 0,
>  #endif
>  };
> @@ -1820,6 +1824,7 @@ static int wait_next_period(struct timerlat_variables *tlat)
>  {
>  	ktime_t next_abs_period, now;
>  	u64 rel_period = osnoise_data.timerlat_period * 1000;
> +	static atomic64_t align_next;
>  
>  	now = hrtimer_cb_get_time(&tlat->timer);
>  	next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
> @@ -1829,6 +1834,17 @@ static int wait_next_period(struct timerlat_variables *tlat)
>  	 */
>  	tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
>  
> +	if (test_bit(OSN_TIMERLAT_ALIGN, &osnoise_options) && !tlat->count
> +	    && atomic64_cmpxchg_relaxed(&align_next, 0, tlat->abs_period)) {

So the first one here sets 'align_next' and all others fall into this path.

As 'align_next' is a static variable for this function, what happens if you
run timerlat a second time with different values?

-- Steve

> +		/*
> +		 * Align thread in first cycle on each CPU to the set alignment.
> +		 */
> +		tlat->abs_period = atomic64_fetch_add_relaxed(osnoise_data.timerlat_align_us * 1000,
> +			&align_next);
> +		tlat->abs_period += osnoise_data.timerlat_align_us * 1000;
> +		next_abs_period = ns_to_ktime(tlat->abs_period);
> +	}
> +
>  	/*
>  	 * If the new abs_period is in the past, skip the activation.
>  	 */
> @@ -2650,6 +2666,17 @@ static struct trace_min_max_param timerlat_period = {
>  	.min	= &timerlat_min_period,
>  };
>  
> +/*
> + * osnoise/timerlat_align_us: align the first wakeup of all timerlat
> + * threads to a common boundary (in us). 0 means disabled.
> + */
> +static struct trace_min_max_param timerlat_align_us = {
> +	.lock	= &interface_lock,
> +	.val	= &osnoise_data.timerlat_align_us,
> +	.max	= NULL,
> +	.min	= NULL,
> +};
> +
>  static const struct file_operations timerlat_fd_fops = {
>  	.open		= timerlat_fd_open,
>  	.read		= timerlat_fd_read,
> @@ -2746,6 +2773,11 @@ static int init_timerlat_tracefs(struct dentry *top_dir)
>  	if (!tmp)
>  		return -ENOMEM;
>  
> +	tmp = tracefs_create_file("timerlat_align_us", TRACE_MODE_WRITE, top_dir,
> +				  &timerlat_align_us, &trace_min_max_fops);
> +	if (!tmp)
> +		return -ENOMEM;
> +
>  	retval = osnoise_create_cpu_timerlat_fd(top_dir);
>  	if (retval)
>  		return retval;

