Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357063242D7;
	Fri, 30 Jan 2026 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786385; cv=none; b=pvhYwQfc5wgIlgxRUTtTdTfu82obgb3OE438wqjIbZwhpIQvGdksfOtubTEzCbBJSMbvk7kgTD1hlkrPliK4JAy3PUWf5SZjVY9qru56JWA5CveToeKQwzM/dMxjCp/UWsKbzs2iL+CazF+bvEMc/+ZBf5JKSEHkP8MZUEiy+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786385; c=relaxed/simple;
	bh=SUtvVeE0YfS2L3QEzmeKB1OW+RHeN2eYXUCYEaHJT5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGj1AOr49Jivi5acihccLH+xKwfMMzkJfz9K5uMf/+uOaktZ4btCUuALindMYkQAQW0yYIp02HWp94vY/JLnHsiPweeu8cUvFoBbjNdRt9QeDgBIIkLbr+kHaDguL1vw/8OnskyGQQdmlDO9PZ1GuwhGNcMz0QA/X7aJV7qcrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 05A3E1A051B;
	Fri, 30 Jan 2026 15:19:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 3AD3020014;
	Fri, 30 Jan 2026 15:19:41 +0000 (UTC)
Date: Fri, 30 Jan 2026 10:19:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Colin Lord <clord@mykolab.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace/hwlat: prevent false sharing in get_sample()
Message-ID: <20260130101949.619907bf@gandalf.local.home>
In-Reply-To: <20260130090906.24108-1-clord@mykolab.com>
References: <20260130090906.24108-1-clord@mykolab.com>
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
X-Rspamd-Queue-Id: 3AD3020014
X-Stat-Signature: p8k9m17mnqtsuquuuw9p3fhkwkbj1nf8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cBrubOYMUgRDCxP4JBB+wx/Q+iPEgy5I=
X-HE-Tag: 1769786381-388736
X-HE-Meta: U2FsdGVkX19O7C7sreOzk/DgPxv/TczKp3pQKDfZSVpy9eAhs5lZzJLZ89GR6FBShQZ56Eb/bvqSDFaBikbVH8zaipVuqD2fkjfKmQFlThezqNMvnk5MD+0R60E5vagZ6V8LXVmSS3NwDS1ZM7jitfp6GIT/F+6RqMutLYJmmsCTtgmwOqJZhD0jLV7zXOmPFx4wu93q3/ZpuGiidQGR3H/7qoAVaVK1pz1cXUnrRaF9KF3znil2fEsUQiYCoDjcrBsNCDOX/OTeOcI6uwwOgfU/bhOZa8qL6EBTYUC5+RYwy0RSAvMsadUBVOjbp9O/nGA9++oq0uZy6bscYddr161NGsxP15Ekanec8tjOiFulHoDZJT7snwZDPyYDgR782ZABI8YtKYndWIA/CX/Sda3W2GTt16oW
Message-ID: <20260130151956.AInlmreXL_tTGd83VUkUrs5fAa1GiyM4nOSnCDwR52Y@z>

On Fri, 30 Jan 2026 01:09:06 -0800
Colin Lord <clord@mykolab.com> wrote:

> The get_sample() function in the hwlat tracer assumes the caller holds
> hwlat_data.lock, but this is not actually happening. The result is
> unprotected data access to hwlat_data, and in per-cpu mode can result in
> false sharing. The false sharing can cause false positive latency
> events, since the sample_width member is involved and gets read as part
> of the main latency detection loop.
> 
> Lock before accessing hwlat_data members, and prevent false sharing by
> pulling sample_width into a local variable.
> 
> One system this was tested on was a dual socket server with 32 CPUs on
> each numa node. With settings of 1us threshold, 1000us width, and
> 2000us window, this change reduced the number of latency events from
> 500 per second down to approximately 1 event per minute. Some machines
> tested did not exhibit measurable latency from the false sharing.

Thanks for the report!

> 
> Signed-off-by: Colin Lord <clord@mykolab.com>
> ---
> Hello, while debugging some poor hwlat results on a server I found this
> false sharing. I've tested the patch on multiple servers with many of
> the configs suggested by the patch submission checklist. A notable
> exception is I wasn't able to test with an SMP disabled build as
> multiple tags, including unmodified v6.18, were unable to finish booting
> with my config/hardware, however it did compile successfully. My
> understanding is that SMP is on its way to being required so I didn't
> spend more time on it, but I can do so if it's important. Thanks for
> your time and any feedback!

Don't worry about testing every flavor, that's my job ;-)

All I ask is basic tests, and see if it fixes the issue for you on your
machines.

> 
>  kernel/trace/trace_hwlat.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 2f7b94e98317..1a4b1409226b 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
>   * get_sample - sample the CPU TSC and look for likely hardware latencies
>   *
>   * Used to repeatedly capture the CPU TSC (or similar), looking for potential
> - * hardware-induced latency. Called with interrupts disabled and with
> - * hwlat_data.lock held.
> + * hardware-induced latency. Disables interrupts during measurement.

I would remove the comment about the hwlat_data.lock held but still call
this with interrupts disabled.

>   */
>  static int get_sample(void)
>  {
> @@ -204,6 +203,7 @@ static int get_sample(void)
>  	time_type start, t1, t2, last_t2;
>  	s64 diff, outer_diff, total, last_total = 0;
>  	u64 sample = 0;
> +	u64 sample_width;
>  	u64 thresh = tracing_thresh;
>  	u64 outer_sample = 0;
>  	int ret = -1;
> @@ -211,6 +211,12 @@ static int get_sample(void)
>  
>  	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
>  
> +	mutex_lock(&hwlat_data.lock);
> +	sample_width = hwlat_data.sample_width;
> +	mutex_unlock(&hwlat_data.lock);

We don't need to take the mutex here, a simple READ_ONCE() would do.
sample_width isn't a critical number, and as long as we get a consistent
number per sample (one that existed just before a user updated it or the
new number the user entered).

	sample_width = READ_ONCE(hwlat_data.sample_width);

Especially since it doesn't even look like the hwlat_data.lock is used to
protect the updates of sample_width :-p

> +
> +	local_irq_disable();

Then we don't need to move the disabling of interrupts here.

> +
>  	kdata->nmi_total_ts = 0;
>  	kdata->nmi_count = 0;
>  	/* Make sure NMIs see this first */
> @@ -267,12 +273,14 @@ static int get_sample(void)
>  		if (diff > sample)
>  			sample = diff; /* only want highest value */
>  
> -	} while (total <= hwlat_data.sample_width);
> +	} while (total <= sample_width);
>  
>  	barrier(); /* finish the above in the view for NMIs */
>  	trace_hwlat_callback_enabled = false;
>  	barrier(); /* Make sure nmi_total_ts is no longer updated */
>  
> +	local_irq_enable();
> +
>  	ret = 0;
>  
>  	/* If we exceed the threshold value, we have found a hardware latency */
> @@ -285,8 +293,11 @@ static int get_sample(void)
>  		if (kdata->nmi_total_ts)
>  			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
>  
> +		mutex_lock(&hwlat_data.lock);
>  		hwlat_data.count++;
>  		s.seqnum = hwlat_data.count;
> +		mutex_unlock(&hwlat_data.lock);

Let's make the counter an atomic_t and use:

		s.seqnum = atomic_inc_return(&hwlat_data.count);


-- Steve

> +
>  		s.duration = sample;
>  		s.outer_duration = outer_sample;
>  		s.nmi_total_ts = kdata->nmi_total_ts;
> @@ -303,7 +314,10 @@ static int get_sample(void)
>  		}
>  	}
>  
> +	return ret;
> +
>  out:
> +	local_irq_enable();
>  	return ret;
>  }
>  
> @@ -361,9 +375,7 @@ static int kthread_fn(void *data)
>  		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
>  			move_to_next_cpu();
>  
> -		local_irq_disable();
>  		get_sample();
> -		local_irq_enable();
>  
>  		mutex_lock(&hwlat_data.lock);
>  		interval = hwlat_data.sample_window - hwlat_data.sample_width;
> 
> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7

