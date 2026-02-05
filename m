Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222E41C2F6;
	Thu,  5 Feb 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302816; cv=none; b=bzuN0fYl0RZpJnv/E4O6ToKg1KNxLjru+ZhWtWDnQpXyGU7Iw3QFaVEHGNha1QiLOAYN5itlKjAYnitGkowwfxNkovegAQAXrtMXvhA+zQsN17Uo4JUNUomYfF5+2WSwQPeiKJQ3mx+0kws/9L6tbxfl6fP+wkcB9v7uZNYy428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302816; c=relaxed/simple;
	bh=SCPDeBfEWvPex5GKqDS194go51FZDmC721yiBsGwCs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sm6lsRS/K9/Rd/At4lE7yZNx9ZwvQ6JKd5dx9Ma3kgeQpp0zYWA6UJcYuB4I2WP/tHvkVzqEDgKmczI12/tZRs7pk78x9jiCtFDTMX7gdT+QhVFvfghtXEvUn/Ux17NCOqd6phOJZRae+ZRZpmU+bP+10fWlvgzCNaaG2xdmhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E9E33B9A07;
	Thu,  5 Feb 2026 14:46:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0AA8520029;
	Thu,  5 Feb 2026 14:46:52 +0000 (UTC)
Date: Thu, 5 Feb 2026 09:47:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Colin Lord <clord@mykolab.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] trace/hwlat: prevent false sharing in get_sample()
Message-ID: <20260205094722.6d21d8b0@gandalf.local.home>
In-Reply-To: <20260202025838.32057-1-clord@mykolab.com>
References: <20260202025838.32057-1-clord@mykolab.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0AA8520029
X-Stat-Signature: wghkmda3e9u7p7cwecs5hsfaxyton34r
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PsnGJgf7velFHC/2uVI1z8TnKuIPPT5c=
X-HE-Tag: 1770302812-15222
X-HE-Meta: U2FsdGVkX18+hyqu0Jr6vAtRjXwRK47I3WWKYpwSEVkzH2zYtcLYm1iaHoBCpc4pKx3rDioxa1ffEZrcNXoGT7Tu7a9KJlItdtHMzcY8leKAGcIx6K5eCYmqAnCRhEPLQst2le3YMKv4lXeFx1OhdvAj03+fSkKen8KfgrwXLfLDyBbXitJpXRq74luDKlHnLVn6tF898pyKfD6s6cgzfuNT3Ei9WFntPZ7v1TsjimyEKbNNxCZeFqHni8tZUcYfPDoh2e+6KAFg/TfQ5rD4NaTc3wXmOD1vb1vtRbqhzW8Ioh2MQa/pNKV9nlAook6PWaB2HlwDLhhs0MU0QMLtancyMgMlgM3SowvNxZd8VfVIlykD9U6YnvuJB38/EsmgULB6aL9ugv0EsFlYs1qmZfw63hZ5lrIl

On Sun,  1 Feb 2026 18:58:38 -0800
Colin Lord <clord@mykolab.com> wrote:

I was about to send this as part of my fixes, but taking a closer look at
it, I have more questions.

> The get_sample() function in the hwlat tracer assumes the caller holds
> hwlat_data.lock, but this is not actually happening. The result is
> unprotected data access to hwlat_data, and in per-cpu mode can result in
> false sharing. The false sharing can cause false positive latency

BTW, what exactly  do you mean by "false sharing"?

> events, since the sample_width member is involved and gets read as part
> of the main latency detection loop.

I'm trying to figure out why the change in sample_width would cause any
issue.

> 
> Convert hwlat_data.count to atomic64_t so it can be safely accessed
> without locking, and prevent false sharing by pulling sample_width into
> a local variable.

The above still makes sense, but this only effects the seqnum, which may
show either duplicate or skipped numbers. But shouldn't affect any of the
other data.

> 
> One system this was tested on was a dual socket server with 32 CPUs on
> each numa node. With settings of 1us threshold, 1000us width, and
> 2000us window, this change reduced the number of latency events from
> 500 per second down to approximately 1 event per minute. Some machines
> tested did not exhibit measurable latency from the false sharing.

Is this because the read of hwlat_data.sample_width is a global variable
and could possibly be causing a cache hit latency that shows up on large
machines?

Is that what you mean by "false sharing"?

Oh, and subjects for the tracing subsystem should start with a capital, and
should be something like:

  tracing: Fix get_sample() in hwlat from ...

-- Steve


> 
> Signed-off-by: Colin Lord <clord@mykolab.com>
> ---
> Changes in v2:
> - convert hwlat_data.count to atomic64_t
> - leave irqs_disabled block where it originally was, outside of
>   get_sample()
> 
> Thanks for the v1 review Steve, have updated and retested.
> 
> cheers,
> Colin
> 
>  kernel/trace/trace_hwlat.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 2f7b94e98317..3fe274b84f1c 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -102,9 +102,9 @@ struct hwlat_sample {
>  /* keep the global state somewhere. */
>  static struct hwlat_data {
>  
> -	struct mutex lock;		/* protect changes */
> +	struct mutex	lock;		/* protect changes */
>  
> -	u64	count;			/* total since reset */
> +	atomic64_t	count;		/* total since reset */
>  
>  	u64	sample_window;		/* total sampling window (on+off) */
>  	u64	sample_width;		/* active sampling portion of window */
> @@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
>   * get_sample - sample the CPU TSC and look for likely hardware latencies
>   *
>   * Used to repeatedly capture the CPU TSC (or similar), looking for potential
> - * hardware-induced latency. Called with interrupts disabled and with
> - * hwlat_data.lock held.
> + * hardware-induced latency. Called with interrupts disabled.
>   */
>  static int get_sample(void)
>  {
> @@ -204,6 +203,7 @@ static int get_sample(void)
>  	time_type start, t1, t2, last_t2;
>  	s64 diff, outer_diff, total, last_total = 0;
>  	u64 sample = 0;
> +	u64 sample_width = READ_ONCE(hwlat_data.sample_width);
>  	u64 thresh = tracing_thresh;
>  	u64 outer_sample = 0;
>  	int ret = -1;
> @@ -267,7 +267,7 @@ static int get_sample(void)
>  		if (diff > sample)
>  			sample = diff; /* only want highest value */
>  
> -	} while (total <= hwlat_data.sample_width);
> +	} while (total <= sample_width);
>  
>  	barrier(); /* finish the above in the view for NMIs */
>  	trace_hwlat_callback_enabled = false;
> @@ -285,8 +285,7 @@ static int get_sample(void)
>  		if (kdata->nmi_total_ts)
>  			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
>  
> -		hwlat_data.count++;
> -		s.seqnum = hwlat_data.count;
> +		s.seqnum = atomic64_inc_return(&hwlat_data.count);
>  		s.duration = sample;
>  		s.outer_duration = outer_sample;
>  		s.nmi_total_ts = kdata->nmi_total_ts;
> @@ -832,7 +831,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
>  
>  	hwlat_trace = tr;
>  
> -	hwlat_data.count = 0;
> +	atomic64_set(&hwlat_data.count, 0);
>  	tr->max_latency = 0;
>  	save_tracing_thresh = tracing_thresh;
>  
> 
> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7

