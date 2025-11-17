Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6E2BFC70;
	Mon, 17 Nov 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395423; cv=none; b=TzUlPcMU75wnBO0gHm1HG6xeIz8MMfGXijJ3LqGBhNysis5OSYQgA6qHLZfu5FAXh0K62OvAy1JdBzJ+clwfaZYM/7WFXaLggRt/G2tTxmjDK+UPnK5yzaFaHCaVKwE9OJJwArQ11/nnzRPW7QNjrIvi898+4JQn6dxa7JdQhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395423; c=relaxed/simple;
	bh=YWgNl5YH9yc+ues0acOIeCmqE6KjwxdoGSZUj6XT3MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW2UjrP/mLcTNei5FxSuv4x+pKQDaxrR7GwhBaeLSOqcRvgLhFMSGN5XGf16Jcl8qzeQsP+xrKrYgRWEeYS78Vx4K5MxhdNa/cKalzgu6B+E/wC/XWntt99d5jTI2sAzY3zGEb4kwX3YxreaL+DQA7kf6F9aAegZEA2SFczMDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdbvpxdB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdbvpxdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763395422; x=1794931422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWgNl5YH9yc+ues0acOIeCmqE6KjwxdoGSZUj6XT3MM=;
  b=QdbvpxdB6/0E9QqBunhKxZHQ6CutHYdCt8dw4ZluYvTcU/+B90gnmfEe
   QF28AKSVC8VSJ4iDgiLd0sjbvHGcXfKh+8q4nEABRanjYWWmCtbArKNdT
   BV9FUamCQG6DvTqh4di/TdqM8aOC4n4BGH5CdZ9oPDovmTrAOjaMqsIC8
   ZJtESavEJ7Cs+W3KL49csCSxqJ7zC6oR/OjBSkRAGljlsi0zQx8gjd7cJ
   Xum5Ye7YoGlRMJhpxnkpZQwstKZH0zH2J2yijiThqd/hmeMKcRRXz3nG6
   cBt+4B1QrmzhhKmHrs5f3DBaK29eYZaxSSsJKP3tx9KTyNZMzaAfuCBGo
   A==;
X-CSE-ConnectionGUID: CIKHO6uNSlqOc8KJBSKA1A==
X-CSE-MsgGUID: Wbb6P4uKRFC/BeIK04/syg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69266748"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69266748"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:03:41 -0800
X-CSE-ConnectionGUID: x/MswJ1vTuSg/dH25fN3JQ==
X-CSE-MsgGUID: tsjngiZuRXqykUAgrZA3GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190646548"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 17 Nov 2025 08:03:39 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DC1EB96; Mon, 17 Nov 2025 17:03:37 +0100 (CET)
Date: Mon, 17 Nov 2025 17:03:37 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] tracing: Have tracer option be instance specific
Message-ID: <aRtHWXzYa8ijUIDa@black.igk.intel.com>
References: <20251111232406.183056289@kernel.org>
 <20251111232429.305317942@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111232429.305317942@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 11, 2025 at 06:24:07PM -0500, Steven Rostedt wrote:

> Tracers can add specify options to modify them. This logic was added
> before instances were created and the tracer flags were global variables.
> After instances were created where a tracer may exist in more than one
> instance, the flags were not updated from being global into instance
> specific. This causes confusion with these options. For example, the
> function tracer has an option to enable function arguments:
> 
>   # cd /sys/kernel/tracing
>   # mkdir instances/foo
>   # echo function > instances/foo/current_tracer
>   # echo 1 > options/func-args
>   # echo function > current_tracer
>   # cat trace
> [..]
>   <idle>-0       [005] d..3.  1050.656187: rcu_needs_cpu() <-tick_nohz_next_event
>   <idle>-0       [005] d..3.  1050.656188: get_next_timer_interrupt(basej=0x10002dbad, basem=0xf45fd7d300) <-tick_nohz_next_event
>   <idle>-0       [005] d..3.  1050.656189: _raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
>   <idle>-0       [005] d..4.  1050.656190: do_raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
>   <idle>-0       [005] d..4.  1050.656191: _raw_spin_lock_nested(lock=0xffff8944bdf5f140, subclass=1) <-__get_next_timer_interrupt
>  # cat instances/foo/options/func-args
>  1
>  # cat instances/foo/trace
> [..]
>   kworker/4:1-88      [004] ...1.   298.127735: next_zone <-refresh_cpu_vm_stats
>   kworker/4:1-88      [004] ...1.   298.127736: first_online_pgdat <-refresh_cpu_vm_stats
>   kworker/4:1-88      [004] ...1.   298.127738: next_online_pgdat <-refresh_cpu_vm_stats
>   kworker/4:1-88      [004] ...1.   298.127739: fold_diff <-refresh_cpu_vm_stats
>   kworker/4:1-88      [004] ...1.   298.127741: round_jiffies_relative <-vmstat_update
> [..]
> 
> The above shows that setting "func-args" in the top level instance also
> set it in the instance "foo", but since the interface of the trace flags
> are per instance, the update didn't take affect in the "foo" instance.
> 
> Update the infrastructure to allow tracers to add a "default_flags" field
> in the tracer structure that can be set instead of "flags" which will make
> the flags per instance. If a tracer needs to keep the flags global (like
> blktrace), keeping the "flags" field set will keep the old behavior.
> 
> This does not update function or the function graph tracers. That will be
> handled later.

This broke clang build.


>  {
>  	struct tracer_opt *trace_opts;
>  	struct trace_array *tr = m->private;
> +	struct tracer_flags *flags;

>  	struct tracer *trace;

Now this is dangling variable. (Set but not used)

>  	u32 tracer_flags;
>  	int i;
> @@ -5152,12 +5180,14 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
>  			seq_printf(m, "no%s\n", trace_options[i]);
>  	}
>  
> -	trace = tr->current_trace;
> -	if (!trace->flags || !trace->flags->opts)
> +	flags = tr->current_trace_flags;
> +	if (!flags || !flags->opts)
>  		return 0;
>  
> -	tracer_flags = tr->current_trace->flags->val;
> -	trace_opts = tr->current_trace->flags->opts;

> +	trace = tr->current_trace;

Removing it and this line fixes, but I'm not sure that's correct one, so feel
free to fold the change or if it will be a fix,
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> +	tracer_flags = flags->val;
> +	trace_opts = flags->opts;

-- 
With Best Regards,
Andy Shevchenko


