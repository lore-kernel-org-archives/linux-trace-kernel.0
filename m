Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3ED1E493F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550027; cv=none; b=DRnrSGXiog25kiWtoFOIQvNgltj4lZcYDUVIwHv9I2IBlBH49LQUBTSXtMkUYiS7dG7q9/v91vU6jUnbLXGTYk6XVsbWNIcHv76QkLrpY22YdVi+LKQp8luBAq33rgIdoQstoc/Iu+5HC1RCKHDydpTJQEJK+9W2e1t4hCo9bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550027; c=relaxed/simple;
	bh=vF+HQAMwPmuHmsJG7SpTncBnzDvwWyuSwhhuNX7u8XY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DpqOBalFcH3OhJexO4X1gm0Ks/jxq9sWUCdpAJWZ/9yiaahejsuAtDk5+T+BQkqin6FEW3Toa1KoFNcXOBVqIkUb5VB8ZiQR/SMdbIADG93fbEdovgYWRsAhIGyCttqxrrTuK6jlueJT9nBF1TcE6fVe4h2Q7xscVdtRKmLjW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xpk5Q0gdVzQtV6;
	Thu, 14 Nov 2024 10:05:46 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 824E51800DE;
	Thu, 14 Nov 2024 10:07:01 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 10:07:00 +0800
Message-ID: <0a216696-9e93-49ce-9411-ee7e59b25c58@huawei.com>
Date: Thu, 14 Nov 2024 10:06:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH 5/5] tracing/hwlat: Fix deadlock in cpuhp processing
To: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
	<bristot@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
	<xiexiuqi@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
 <20240924094515.3561410-6-liwei391@huawei.com>
 <20241003161907.52eda097@gandalf.local.home>
 <c706d18d-934a-4bd3-816c-f512fcf6b71e@huawei.com>
 <20241112185058.5bec6fca@gandalf.local.home>
In-Reply-To: <20241112185058.5bec6fca@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Hi Steven,

On 2024/11/13 7:50, Steven Rostedt wrote:
>>>> Another "hung task" error was reported during the test, and i figured out
>>>> the deadlock scenario is as follows:
>>>>
>>>> T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
>>>> work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
>>>>   _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
>>>>     cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
>>>>     __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()
> 
> So, if we can make T3 not take the mutex_lock then that should be a
> solution, right?
> 
>>>>
>>>> It constitutes ABBA deadlock indirectly beAs it calls msleep_interruptible() and 'break' if signal pending below, i choosed 'break' here too.tween "cpu_hotplug_lock" and
>>>> "hwlat_data.lock", make the mutex obtaining in kthread_fn() interruptible
>>>> to fix this.
>>>>
>>>> Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
>>>> Signed-off-by: Wei Li <liwei391@huawei.com>
>>>> ---
>>>>  kernel/trace/trace_hwlat.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>>>> index 3bd6071441ad..4c228ccb8a38 100644
>>>> --- a/kernel/trace/trace_hwlat.c
>>>> +++ b/kernel/trace/trace_hwlat.c
>>>> @@ -370,7 +370,8 @@ static int kthread_fn(void *data)
>>>>  		get_sample();
>>>>  		local_irq_enable();
>>>>  
>>>> -		mutex_lock(&hwlat_data.lock);
>>>> +		if (mutex_lock_interruptible(&hwlat_data.lock))
>>>> +			break;  
>>>
>>> So basically this requires as signal to break it out of the loop?
>>>
>>> But if it receives a signal for any other reason, it breaks out of the loop
>>> too. Which is not what we want. If anything, it should be:
>>>
>>> 		if (mutex_lock_interruptible(&hwlat_data.lock))
>>> 			continue;  
>>
>> As it calls msleep_interruptible() below and 'break' if signal pending, i
>> choosed 'break' here too.
>>
>>> But I still don't really like this solution, as it will still report a
>>> 	deadlock.
>>>
>>> Is it possible to switch the cpu_read_lock() to be taken before the
>>> hwlat_data.lock?  
>>
>> It's a little hard to change the sequence of these two locks, we'll hold
>> "cpu_hotplug_lock" for longer unnecessarily if we do that.
>>
>> But maybe we can remove the "hwlat_data.lock" in kthread_fn(), let me try
>> another modification.
> 
> Have you found something yet? Looking at the code we have:
> 
> 		mutex_lock(&hwlat_data.lock);
> 		interval = hwlat_data.sample_window - hwlat_data.sample_width;
> 		mutex_unlock(&hwlat_data.lock);
> 
> Where the lock is only there to synchronize the calculation of the
> interval. We could add a counter for when sample_window and sample_width
> are updated, and we could simply do:
> 
>  again:
> 		counter = atomic_read(&hwlat_data.counter);
> 		smp_rmb();
> 		if (!(counter & 1)) {
> 			new_interval = hwlat_data.sample_window - hwlat_data.sample_width;
> 			smp_rmb();
> 			if (counter == atomic_read(&hwlat_data.counter))
> 				interval = new_interval;
> 		}
> 
> Then we could do something like:
> 
> 	atomic_inc(&hwlat_data.counter);
> 	smp_wmb();
> 	/* update sample_window or sample_width */
> 	smp_wmb();
> 	atomic_inc(&hwlat_data.counter);
> 
> And then the interval will only be updated if the values are not being
> updated. Otherwise it just keeps the previous value.
> 

Your seqlock-like solution seems to be able to solve this issue, but the difficulty is that
the current updates of sample_window and sample_width are implemented using the framework
of 'trace_min_max_fops'. We cannot add 'atomic_inc(&hwlat_data.counter)' into the update
processes for sample_window and sample_width directly. If we want to remove the mutex_lock
here, maybe we need to break the application of trace_min_max_write(). However, if we do
that, we can add a 'hwlat_data.sample_interval' and update it at the same time as updating
sample_window and sample_width. I didn't figure out an elegant solution yet.

Thanks,
Wei
