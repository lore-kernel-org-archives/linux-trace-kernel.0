Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4263186E27
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460053; cv=none; b=MMZBa0FhzOAWGDPo0wc1AzObTBVD/A3lygu/Un023p67HrdLH1K7y0SuNXhLOPaRteb0e+kPOfbx75dxgtiLngleIxzSCsWMAdUuDPAksxvsS6vfH5M/hqr6pRyW4rwtNu9LCwFpfZV1LWK1+yS2JORZuLRV03h1cyS1yhG5hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460053; c=relaxed/simple;
	bh=m/rtI8kf5FmP40r0iRgrdofBk9aeY94p8d9AFSllcgo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=A4d0lObT5v9TF+SHYiTjEvbPaV+8q7nqH/KEZZKkGOM0bxPt8hybOlU9L8jkhyC82DctewKKBvUBF6NXXULYfRflflVVUvGeaSvKpGEtwIxPl5GO6R5j8410cRcmrQ/wB+PdXmKemjnXFyNeazrZm6lxAAmi67J7n1LvY6du5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XNlM03vBsz1j9Nq;
	Wed,  9 Oct 2024 15:46:20 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 728C81A016C;
	Wed,  9 Oct 2024 15:47:25 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 15:47:24 +0800
Message-ID: <c706d18d-934a-4bd3-816c-f512fcf6b71e@huawei.com>
Date: Wed, 9 Oct 2024 15:47:23 +0800
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
In-Reply-To: <20241003161907.52eda097@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)



On 2024/10/4 4:19, Steven Rostedt wrote:
> On Tue, 24 Sep 2024 17:45:15 +0800
> Wei Li <liwei391@huawei.com> wrote:
> 
>> Another "hung task" error was reported during the test, and i figured out
>> the deadlock scenario is as follows:
>>
>> T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
>> work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
>>   _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
>>     cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
>>     __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()
>>
>> It constitutes ABBA deadlock indirectly beAs it calls msleep_interruptible() and 'break' if signal pending below, i choosed 'break' here too.tween "cpu_hotplug_lock" and
>> "hwlat_data.lock", make the mutex obtaining in kthread_fn() interruptible
>> to fix this.
>>
>> Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  kernel/trace/trace_hwlat.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>> index 3bd6071441ad..4c228ccb8a38 100644
>> --- a/kernel/trace/trace_hwlat.c
>> +++ b/kernel/trace/trace_hwlat.c
>> @@ -370,7 +370,8 @@ static int kthread_fn(void *data)
>>  		get_sample();
>>  		local_irq_enable();
>>  
>> -		mutex_lock(&hwlat_data.lock);
>> +		if (mutex_lock_interruptible(&hwlat_data.lock))
>> +			break;
> 
> So basically this requires as signal to break it out of the loop?
> 
> But if it receives a signal for any other reason, it breaks out of the loop
> too. Which is not what we want. If anything, it should be:
> 
> 		if (mutex_lock_interruptible(&hwlat_data.lock))
> 			continue;

As it calls msleep_interruptible() below and 'break' if signal pending, i
choosed 'break' here too.

> But I still don't really like this solution, as it will still report a
> 	deadlock.
> 
> Is it possible to switch the cpu_read_lock() to be taken before the
> hwlat_data.lock?

It's a little hard to change the sequence of these two locks, we'll hold
"cpu_hotplug_lock" for longer unnecessarily if we do that.

But maybe we can remove the "hwlat_data.lock" in kthread_fn(), let me try
another modification.


Thanks,
Wei
