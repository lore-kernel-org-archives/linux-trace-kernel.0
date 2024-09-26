Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F446B8;
	Thu, 26 Sep 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355124; cv=none; b=ota1iIB1LPTukavWaXw7+K3itcqpwJgPFpY0H/IJngZlVbgPJj9dx3glUxdWdzxgHmGS0gxsRzB2MK8gK7hpLMxyghe/7ggBlE1jYYGdmSU63kVYuqGteBfdqMqTrhcLmnAGP3rPcqMk1wQaPcD20iKuKDUnD9UvvrWV2F4oBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355124; c=relaxed/simple;
	bh=KdrTlAxVPGzgCG2oBMur4u+A3dRAEZXCNNqql/A8E0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/EP4dIWPWhcAXUOjiCu9tf5XKd7DFvT1aPOJHviiJDoNVEkb/otvfKC0kbECqctoNXWiSIWMH9hTThuCwMhI9bASHBf6EeKDDvx2iYueoxFFfEi4zl2KHIuVxOpdnal/NFqmsc238zS6hFMjP1kesZlSYYUgbYff1zg+verIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA8CC4CEC5;
	Thu, 26 Sep 2024 12:51:48 +0000 (UTC)
Date: Thu, 26 Sep 2024 08:51:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 a.p.zijlstra@chello.nl, mingo@elte.hu, mark.rutland@arm.com,
 james.clark@linaro.org, nd@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Message-ID: <20240926085118.0a823138@rorschach.local.home>
In-Reply-To: <20240913021347.595330-1-yeoreum.yun@arm.com>
References: <20240913021347.595330-1-yeoreum.yun@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Can one of the perf folks give me an Ack, and I'll take this through my tree.

-- Steve


On Fri, 13 Sep 2024 03:13:47 +0100
Levi Yun <yeoreum.yun@arm.com> wrote:

> When a tracepoint event is created with attr.freq = 1,
> 'hwc->period_left' is not initialized correctly. As a result,
> in the perf_swevent_overflow() function, when the first time the event occurs,
> it calculates the event overflow and the perf_swevent_set_period() returns 3,
> this leads to the event are recorded for three duplicate times.
> 
> Step to reproduce:
>     1. Enable the tracepoint event & starting tracing
>          $ echo 1 > /sys/kernel/tracing/events/module/module_free
>          $ echo 1 > /sys/kernel/tracing/tracing_on
> 
>     2. Record with perf
>          $ perf record -a --strict-freq -F 1 -e "module:module_free"
> 
>     3. Trigger module_free event.
>          $ modprobe -i sunrpc
>          $ modprobe -r sunrpc
> 
> Result:
>      - Trace pipe result:
>          $ cat trace_pipe
>          modprobe-174509  [003] .....  6504.868896: module_free: sunrpc
> 
>      - perf sample:
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
>          modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
> 
> By setting period_left via perf_swevent_set_period() as other sw_event did,
> This problem could be solved.
> 
> After patch:
>      - Trace pipe result:
>          $ cat trace_pipe
>          modprobe 1153096 [068] 613468.867774: module:module_free: xfs
> 
>      - perf sample
>          modprobe 1153096 [068] 613468.867794: module:module_free: xfs
> 
> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
> Changes in v2:
>   - Fix build error.
> ---
>  kernel/trace/trace_event_perf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 05e791241812..3ff9caa4a71b 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -352,10 +352,16 @@ void perf_uprobe_destroy(struct perf_event *p_event)
>  int perf_trace_add(struct perf_event *p_event, int flags)
>  {
>  	struct trace_event_call *tp_event = p_event->tp_event;
> +	struct hw_perf_event *hwc = &p_event->hw;
> 
>  	if (!(flags & PERF_EF_START))
>  		p_event->hw.state = PERF_HES_STOPPED;
> 
> +	if (is_sampling_event(p_event)) {
> +		hwc->last_period = hwc->sample_period;
> +		perf_swevent_set_period(p_event);
> +	}
> +
>  	/*
>  	 * If TRACE_REG_PERF_ADD returns false; no custom action was performed
>  	 * and we need to take the default action of enqueueing our event on
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

