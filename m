Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48B4C8F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986694; cv=none; b=WSiwmWwZqL2t6W30LxcoVUTLCzBYSSaymWo0dBuAWHIh4SPBVY5hOFqEKVKPzlgLGAFWZy8yI021begix/FEAJLOO/slr9my2QUOukrer0rUaG1RBYyx3w4MSqsDJg90QF7FPAvwulyboFfBJX83CmbhPVLBKW39i9ypDNdyK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986694; c=relaxed/simple;
	bh=m5bea/4j5TVSB+iecsEyojOZroaT7bU9dNuNava/SWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3hpT9y2O7oEi+YQL+BNBbMQRKVm1KcETqTvUo5XZDY9tKBMBNzha24m6H7TjYeXU8CyKUoFR0AbGzkvPBobfOv7NLlw/2OR+iB+fccJrb6TMYwHEVZptnTodMzkkADT9a29Sxjzj71kSmXw5KDfDjTEw474HynCw5tuGC1CP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB1DC4CEC5;
	Thu,  3 Oct 2024 20:18:13 +0000 (UTC)
Date: Thu, 3 Oct 2024 16:19:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Li <liwei391@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
 <xiexiuqi@huawei.com>
Subject: Re: [PATCH 5/5] tracing/hwlat: Fix deadlock in cpuhp processing
Message-ID: <20241003161907.52eda097@gandalf.local.home>
In-Reply-To: <20240924094515.3561410-6-liwei391@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
	<20240924094515.3561410-6-liwei391@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 17:45:15 +0800
Wei Li <liwei391@huawei.com> wrote:

> Another "hung task" error was reported during the test, and i figured out
> the deadlock scenario is as follows:
> 
> T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
> work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
>   _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
>     cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
>     __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()
> 
> It constitutes ABBA deadlock indirectly between "cpu_hotplug_lock" and
> "hwlat_data.lock", make the mutex obtaining in kthread_fn() interruptible
> to fix this.
> 
> Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  kernel/trace/trace_hwlat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 3bd6071441ad..4c228ccb8a38 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -370,7 +370,8 @@ static int kthread_fn(void *data)
>  		get_sample();
>  		local_irq_enable();
>  
> -		mutex_lock(&hwlat_data.lock);
> +		if (mutex_lock_interruptible(&hwlat_data.lock))
> +			break;

So basically this requires as signal to break it out of the loop?

But if it receives a signal for any other reason, it breaks out of the loop
too. Which is not what we want. If anything, it should be:

		if (mutex_lock_interruptible(&hwlat_data.lock))
			continue;

But I still don't really like this solution, as it will still report a
	deadlock.

Is it possible to switch the cpu_read_lock() to be taken before the
hwlat_data.lock?

-- Steve


>  		interval = hwlat_data.sample_window - hwlat_data.sample_width;
>  		mutex_unlock(&hwlat_data.lock);
>  

