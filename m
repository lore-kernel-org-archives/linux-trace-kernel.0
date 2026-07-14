Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB123377A97;
	Tue, 14 Jul 2026 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066037; cv=none; b=joPZZ0jPMRl6IN2KB6ZQttYHObl+txs9In7KpidwMuGZX8GOgPY38lr85/mIgj/J84M3kgvjoy2SzHLIwjvmTQJ5/faQg7rn3NCrgd77a5wIyx/eqCrXQzTZdLJbtsivg677gXNUzASpmSb+eoTIlVcGt4+7vOUpxKoCVlIfn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066037; c=relaxed/simple;
	bh=x2Gh8QmklIM9C4aWufS1h0NEo7ZJy5Y4fu+SOBaQUzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AByN9mLMf9AwHAYmtElo9siopRPsxRvVB5R9RP+f2GutLATG7GBjahPHlnNCuCmMW70vvs+ZwKRQ55FmVb/C0DVQwinATqDwnDODfVdEtcIWLJonN5iEeppO+mvf+nsoAwCBb+FAAoVFztgKOT+xUWZww8oJVYSBRK47LBR0GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 22BA1C02B1;
	Tue, 14 Jul 2026 21:53:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 50B3B8000E;
	Tue, 14 Jul 2026 21:53:51 +0000 (UTC)
Date: Tue, 14 Jul 2026 17:53:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 lipengfei28@xiaomi.com, zhangbo56@xiaomi.com
Subject: Re: [RFC PATCH v4 2/3] trace: integrate stackmap into ftrace stack
 recording path
Message-ID: <20260714175355.1951b317@gandalf.local.home>
In-Reply-To: <20260616064119.438063-3-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
	<20260616064119.438063-3-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 50B3B8000E
X-Stat-Signature: bw3tchexy4hy9p6wtxur8cyu9p5w985i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5R3tem202lJ/8uS3/VH8+Yl0L4TJiYuY=
X-HE-Tag: 1784066031-212943
X-HE-Meta: U2FsdGVkX1+y8UQMoheRgHjVtTaIzkHJqlOnFcEhwu8Xdu6uo3Z4DRZg53S996Q1b1m5Kcv5eHW8XL3iP6BwL1ne96U4hB4CDGtA6JotS0eSqCRUyfe8z+7rBH/ObcuaVvj+nxx1IDHwqvT2TFQsv9qW1LhnGSY6LvpfCceNDVq2rtlICWB2opAc6Qsp3ZKU5KG543vtzECxuOMo9hGj5f25k9n6w2zl11jpu+o/DqIhCdLvQY1AgTdRHx5vgoXe6NMNWWVyZIxygHaR+ctL2/0qmsMRFPQKAfM9cNZRJWGrd7l6HnfTIcIngsL+l37DOBL7zqMQNW/ajVY3rpOLN3LRhLJ5Uj2m

On Tue, 16 Jun 2026 14:41:18 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

>  int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  {
>  	switch (mask) {
> @@ -3993,6 +4091,33 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  	if (!!(tr->trace_flags & mask) == !!enabled)
>  		return 0;
>  
> +#ifdef CONFIG_FTRACE_STACKMAP
> +	/*
> +	 * STACKMAP is intentionally global-instance-only: the dedup map,
> +	 * its tracefs files (stack_map / stack_map_stat / stack_map_bin)
> +	 * and the lifetime/reset semantics are tied to the global trace
> +	 * array. options/stackmap is hidden on secondary instances via
> +	 * TOP_LEVEL_TRACE_FLAGS, but writes still reach set_tracer_flag()
> +	 * through the aggregate trace_options file. Reject the enable on
> +	 * a secondary instance so it cannot be silently accepted and then
> +	 * become a no-op in the hot path (where tr->stackmap is NULL and
> +	 * the code falls back to a full stack trace).
> +	 *
> +	 * On the global instance, allow the enable while init is still
> +	 * pending (boot-time trace_options=stackmap is applied before the
> +	 * tracefs init work creates the map; the hot path falls back
> +	 * until the map is published). Only reject once init has
> +	 * permanently failed, so options/stackmap never reports an
> +	 * enabled no-op. READ_ONCE() suffices: this only inspects the
> +	 * init state, it does not dereference the map (the hot path uses
> +	 * smp_load_acquire(&tr->stackmap) for that).
> +	 */
> +	if (mask == TRACE_ITER(STACKMAP) && enabled &&
> +	    (tr != &global_trace ||
> +	     READ_ONCE(stackmap_init_state) == STACKMAP_INIT_FAILED))
> +		return -EINVAL;
> +#endif
> +
>  	/* Give the tracer a chance to approve the change */
>  	if (tr->current_trace->flag_changed)
>  		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
> @@ -9222,6 +9347,91 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  			NULL, &tracing_dyn_info_fops);
>  #endif
>  
> +#ifdef CONFIG_FTRACE_STACKMAP
> +	{
> +		struct ftrace_stackmap *smap;
> +		struct dentry *map_file;
> +
> +		smap = ftrace_stackmap_create(&global_trace);
> +		if (!IS_ERR(smap)) {
> +			/*
> +			 * Failure-atomic init: stack_map is the single
> +			 * required tracefs file (it doubles as the reset
> +			 * interface and the human-readable resolver). If
> +			 * we cannot create it, the hot path must not be
> +			 * able to emit <stack_id N> events that no one can
> +			 * resolve or clear, so refuse to publish the map
> +			 * and tear it down.
> +			 *
> +			 * Create stack_map BEFORE smp_store_release() so an
> +			 * observed non-NULL global_trace.stackmap implies
> +			 * its resolver/reset file exists.
> +			 */
> +			map_file = trace_create_file("stack_map",
> +						     TRACE_MODE_WRITE, NULL,
> +						     smap,
> +						     &ftrace_stackmap_fops);
> +			if (!map_file) {
> +				pr_warn("ftrace stackmap init: stack_map create failed, dedup disabled\n");
> +				ftrace_stackmap_destroy(smap);
> +				/*
> +				 * Permanent failure. Record it and clear a
> +				 * STACKMAP flag that a boot-time
> +				 * trace_options=stackmap may have set, so
> +				 * options/stackmap does not report an
> +				 * enabled no-op and later userspace enables
> +				 * return -EINVAL.
> +				 */
> +				WRITE_ONCE(stackmap_init_state,
> +					   STACKMAP_INIT_FAILED);
> +				global_trace.trace_flags &=
> +					~TRACE_ITER(STACKMAP);

80 columns is no longer a hard requirement. 100 is more the default, so the
above should be:

				WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_FAILED);
				global_trace.trace_flags &= ~TRACE_ITER(STACKMAP);



> +			} else {
> +				/*
> +				 * smp_store_release pairs with the
> +				 * smp_load_acquire() in
> +				 * __ftrace_trace_stack(). Publishing only
> +				 * after the required file exists keeps
> +				 * "smap visible" => "resolver/reset
> +				 * available".
> +				 */

> +				smp_store_release(&global_trace.stackmap,
> +						  smap);
> +				WRITE_ONCE(stackmap_init_state,
> +					   STACKMAP_INIT_DONE);

Same with the above two.

> +				/*
> +				 * stat and bin are auxiliary observability
> +				 * surfaces. If they fail to be created we
> +				 * keep dedup enabled (the kernel side still
> +				 * works, and stack_map alone is enough to
> +				 * resolve and reset); trace_create_file()
> +				 * already pr_warn()s on failure.
> +				 */
> +				trace_create_file("stack_map_stat",
> +						  TRACE_MODE_READ, NULL,
> +						  smap,
> +						  &ftrace_stackmap_stat_fops);
> +				trace_create_file("stack_map_bin",
> +						  TRACE_MODE_READ, NULL,
> +						  smap,
> +						  &ftrace_stackmap_bin_fops);
> +			}

-- Steve
