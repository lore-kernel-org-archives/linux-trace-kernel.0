Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AC3DA7ED;
	Mon, 10 Aug 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367651; cv=none; b=VjNKR8/uvF0tX/hcbxfl+L4fPDt68ZxwW2AgDZc4eXO4AQqJiXMThJAzRYuJ4BQpG4mJW7Ynx9IMlXBd2Eq2viwQ+kGHkB0VaAQva7MTnz55qdw3gnD/qJO5ITzFpQ4Ec8WnLW8hzCECnQbOdVGKg1YwTnfC+k49BdkqrRJCNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367651; c=relaxed/simple;
	bh=I0ExxeRt1leU0yjlEz/bq5fHSnHMSEL9zIdxoK6Cytw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehHdglOHK6c/Jv7N4UUr6uMmIjt+gogz6IViGzL8H2trzar5xXHaxKit+zqJKIMJDvSycmHsW0blbyWKZPdXBLm39HVQTiPlOcb0a9/7Pa0Gso6WdFx2m46N0hz6y2qze7CHNwqyVFLz4X0vE1nnI0AhgS1NwEhT2yv4C2zLzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hJZvh4ywPzYQvBm;
	Mon, 10 Aug 2026 21:13:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4DA624056B;
	Mon, 10 Aug 2026 21:13:54 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAHQs6Rznlqjbw8Bw--.2609S2;
	Mon, 10 Aug 2026 21:13:54 +0800 (CST)
Message-ID: <7e8c9706-86d6-42b5-b7ad-b24a7552d950@huaweicloud.com>
Date: Mon, 10 Aug 2026 21:13:52 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid -EBUSY
 during snapshot swap
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260803005640.2445666-1-wutengda@huaweicloud.com>
 <20260803005640.2445666-3-wutengda@huaweicloud.com>
 <20260808105855.09f8d794@robin>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808105855.09f8d794@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAHQs6Rznlqjbw8Bw--.2609S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1DWw1DKFyUGw4kZFyfXrb_yoW5Kr1DpF
	Waka4DGw4DZF40ya4Iqw1xCryrtrZ5G34xur13Ga1rZa90kFySqr48K3W3ua48CrnFk3y2
	vF4Y9FZ7GF1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 22:58, Steven Rostedt wrote:
> 
> Sashiko brings up a good point. This will break the recording of what
> task is being interrupted.
> 
>   https://sashiko.dev/#/patchset/20260803005640.2445666-2-wutengda%40huaweicloud.com
> 
> 
>> --- Patch [2]: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap ---
>> commit b61ca8359fdea427c80a410f6d4052c68af5eae3
>> Author: Tengda Wu <wutengda@huaweicloud.com>
>>
>> tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap
>>
>> This commit replaces smp_call_function_single() with work_on_cpu() in
>> the snapshot write path to avoid -EBUSY errors when a target CPU is
>> actively writing to the ring buffer.
>>
>>> diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
>>> --- a/kernel/trace/trace_snapshot.c
>>> +++ b/kernel/trace/trace_snapshot.c
>>
>> [ ... ]
>>
>>> -static void tracing_swap_cpu_buffer(void *tr)
>>> +static long tracing_swap_cpu_buffer(void *tr)
>>>  {
>>> +	local_irq_disable();
>>>  	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
>>
>> When calling update_max_tr_single() from a workqueue thread, does passing
>> current result in the trace snapshot recording the kworker task instead of
>> the interrupted task?
>>
>> In the previous smp_call_function_single() implementation, current would
>> represent the task executing on the target CPU, but now it will capture
>> the kworker thread.
> 
> And thinking of one usecase, what if you had a high priroity task you
> wanted to snashot? This wouldn't work to do that.
> 
> Now we can still keep the ipi and send data that holds the tr and
> state. It waits for the ipi to finish anyway. Then it can check if the
> swap happened or not, and could report a fail, or it could try again?
> 

Indeed, work_on_cpu() cannot handle these scenarios properly.

I just tried handling the return value and noticed that there is already
a log message inside update_max_tr_single() that reports the
ring_buffer_swap_cpu() error.
(I had previously overlooked this error handling and didn't notice it.)

So, it seems that no additional handling is necessary. I will keep the
current implementation unchanged.

Thank you for your accurate catch and thoughtful suggestions.

Best regards,
Tengda

>>
>>> +	local_irq_enable();
>>> +	return 0;
>>>  }
>>
>> [ ... ]
>>
>>> @@ -689,8 +692,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>>>  			update_max_tr(tr, current, smp_processor_id(), NULL);
>>>  			local_irq_enable();
>>>  		} else {
>>> -			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
>>> -						 (void *)tr, 1);
>>> +			work_on_cpu(iter->cpu_file, tracing_swap_cpu_buffer, (void *)tr);
>>
>> Can this result in swapping the wrong CPU's trace ring buffer if
>> iter->cpu_file is an offline CPU, or if the CPU goes offline concurrently?
>>
>> Because cpus_read_lock() is not held, if the target CPU is offline, the
>> workqueue subsystem may execute the work on a fallback online CPU.
>>
>> When tracing_swap_cpu_buffer() then calls smp_processor_id(), it will
>> evaluate to the fallback CPU's ID rather than the intended target CPU.
>>
>> This could potentially modify an unrelated online CPU's trace buffer while
>> leaving the requested offline CPU's buffer unchanged.
> 
> This too looks to be a valid concern.
> 
>>
>>>  		}
>>>  		tracing_disarm_snapshot(tr);
>>>  		break;
> 
> -- Steve

