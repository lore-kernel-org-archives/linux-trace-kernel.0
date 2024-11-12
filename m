Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637421830E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455442; cv=none; b=OlxOzZSi+LPJJ3VFOwhAAnEafud7NPv8iTELaLFC4d0RSjGP/VE8q2XdLjxTBZFIvtf8ioDDjbszvXRhh4sNF/i2WqquakUAlvJsLd07Ox4CispGq++9HeV0U/rNbbbNEkf2rypGcH/rSjb2UJ9JPQuux9krInZ/44kVY0qukP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455442; c=relaxed/simple;
	bh=AXoGCTYL84ZavPBy20Q+fM/Ugs97Y7hhVPFNihWvh5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCuZFSoBlI5zeu+NfUjhppMbYi6pZCmTqhoBBy0UCBLL/2z2U6R0mlKtja+e1y8ME/KH303BpUA7madOB6sSFiQobmW+qv8+vYf+uppCxts0WeNDf1O4DQcj/2imliH4A/ORNbKZp0AqBV4o9CI93guu+3VoLFRQ9i0oav/zo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C3C4CECD;
	Tue, 12 Nov 2024 23:50:41 +0000 (UTC)
Date: Tue, 12 Nov 2024 18:50:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "liwei (GF)" <liwei391@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
 <xiexiuqi@huawei.com>
Subject: Re: [PATCH 5/5] tracing/hwlat: Fix deadlock in cpuhp processing
Message-ID: <20241112185058.5bec6fca@gandalf.local.home>
In-Reply-To: <c706d18d-934a-4bd3-816c-f512fcf6b71e@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
	<20240924094515.3561410-6-liwei391@huawei.com>
	<20241003161907.52eda097@gandalf.local.home>
	<c706d18d-934a-4bd3-816c-f512fcf6b71e@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 15:47:23 +0800
"liwei (GF)" <liwei391@huawei.com> wrote:

> On 2024/10/4 4:19, Steven Rostedt wrote:
> > On Tue, 24 Sep 2024 17:45:15 +0800
> > Wei Li <liwei391@huawei.com> wrote:
> >   
> >> Another "hung task" error was reported during the test, and i figured out
> >> the deadlock scenario is as follows:
> >>
> >> T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
> >> work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
> >>   _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
> >>     cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
> >>     __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()

So, if we can make T3 not take the mutex_lock then that should be a
solution, right?

> >>
> >> It constitutes ABBA deadlock indirectly beAs it calls msleep_interruptible() and 'break' if signal pending below, i choosed 'break' here too.tween "cpu_hotplug_lock" and
> >> "hwlat_data.lock", make the mutex obtaining in kthread_fn() interruptible
> >> to fix this.
> >>
> >> Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
> >> Signed-off-by: Wei Li <liwei391@huawei.com>
> >> ---
> >>  kernel/trace/trace_hwlat.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> >> index 3bd6071441ad..4c228ccb8a38 100644
> >> --- a/kernel/trace/trace_hwlat.c
> >> +++ b/kernel/trace/trace_hwlat.c
> >> @@ -370,7 +370,8 @@ static int kthread_fn(void *data)
> >>  		get_sample();
> >>  		local_irq_enable();
> >>  
> >> -		mutex_lock(&hwlat_data.lock);
> >> +		if (mutex_lock_interruptible(&hwlat_data.lock))
> >> +			break;  
> > 
> > So basically this requires as signal to break it out of the loop?
> > 
> > But if it receives a signal for any other reason, it breaks out of the loop
> > too. Which is not what we want. If anything, it should be:
> > 
> > 		if (mutex_lock_interruptible(&hwlat_data.lock))
> > 			continue;  
> 
> As it calls msleep_interruptible() below and 'break' if signal pending, i
> choosed 'break' here too.
> 
> > But I still don't really like this solution, as it will still report a
> > 	deadlock.
> > 
> > Is it possible to switch the cpu_read_lock() to be taken before the
> > hwlat_data.lock?  
> 
> It's a little hard to change the sequence of these two locks, we'll hold
> "cpu_hotplug_lock" for longer unnecessarily if we do that.
> 
> But maybe we can remove the "hwlat_data.lock" in kthread_fn(), let me try
> another modification.

Have you found something yet? Looking at the code we have:

		mutex_lock(&hwlat_data.lock);
		interval = hwlat_data.sample_window - hwlat_data.sample_width;
		mutex_unlock(&hwlat_data.lock);

Where the lock is only there to synchronize the calculation of the
interval. We could add a counter for when sample_window and sample_width
are updated, and we could simply do:

 again:
		counter = atomic_read(&hwlat_data.counter);
		smp_rmb();
		if (!(counter & 1)) {
			new_interval = hwlat_data.sample_window - hwlat_data.sample_width;
			smp_rmb();
			if (counter == atomic_read(&hwlat_data.counter))
				interval = new_interval;
		}

Then we could do something like:

	atomic_inc(&hwlat_data.counter);
	smp_wmb();
	/* update sample_window or sample_width */
	smp_wmb();
	atomic_inc(&hwlat_data.counter);

And then the interval will only be updated if the values are not being
updated. Otherwise it just keeps the previous value.

-- Steve
