Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539E126C03;
	Mon,  1 Jun 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275514; cv=none; b=mwQvQ7pKsYEee2bvCj1rWaTjLkwnibRDrMwMFpCiFKkuUhzE/N74YXE4YoegJuHmzzs7nudvsu6nWl+NTSJf7WnPkdaeBt0joj22WrpTKdaFRtp7LGPgIECfkeXjNQ4SG5ypkdXhQgKQV5AUUwg9GrDNV6TzeeuYuWHJWzOSIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275514; c=relaxed/simple;
	bh=v2xp4CwnDQJcU/9toSv/zsHcoIGbXl2GBg7qgphGSB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWBVB7fTNWJdtNFnjojsHETOQKA7M4JaVZAGsclTTooSe/befaUB4HEqA96y/9bIgVMn/1hx4BuVDmliD14oY2v4iHpcz3vY5PF3+f5GqcyPwzqQeZqz52z3WnpQVSf1oTvOLcIuJhobYO86dam1akCi2wNfWJSrzfj1w8aA2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gTFvH5L2QzYQtM9;
	Mon,  1 Jun 2026 08:58:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1C4A24056F;
	Mon,  1 Jun 2026 08:58:22 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAnnIEs2RxqWaK9AA--.30924S2;
	Mon, 01 Jun 2026 08:58:22 +0800 (CST)
Message-ID: <041c7307-adc0-4ddc-a418-fc79b717ae02@huaweicloud.com>
Date: Mon, 1 Jun 2026 08:58:20 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnnIEs2RxqWaK9AA--.30924S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykArWrCFyfJw13JrWkJFb_yoW5Aw1DpF
	WxGa1jkF47JF42yasFqrs5CF47K34fKay2gFnYyryFvFn8trn2gr1ftry29F18Cr1DCF4U
	trW7trZrur9rZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/1 7:40, Masami Hiramatsu wrote:
> On Fri, 29 May 2026 11:39:49 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>>> We also should not use tsk->on_cpu, but should use task_on_cpu(tsk).
>>>
>>> BTW, should task_on_cpu() use READ_ONCE() etc?
>>> wait_task_inactive() seems a bit fragile.
>>>
>>> Thanks,
>>>
>>
>> It seems that using task_on_cpu() is not necessary here because:
>>
>> 1. It requires an additional 'rq' parameter not available in the rethook context.
>> 2. It just returns p->on_cpu, which is identical to our current use of tsk->on_cpu.
> 
> OK. We may need to cleanup task_on_cpu() to remove unused rq, which
> was historically introduced by commit 029632fbb7b7 ("sched: Make
> separate sched*.c translation units") as a parameter for "task_running()"
> because it called task_current(), but was cleaned by commit 0b9d46fc5ef7
> ("sched: Rename task_running() to task_on_cpu()") and now it is not
> used.
> 
>>
>> /* file: kernel/sched/sched.h */
>> static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
>> {
>> 	return p->on_cpu;
>> }
>>
>> Given these constraints, staying with tsk->on_cpu seems more straightforward
>> for the rethook context.
> 
> The reason I asked you to use a wrapper function instead of directly
> accessing that on_cpu is to ensure that this part isn't overlooked when
> changing the scheduler's behavior in the future.
> 
> They may be equivalent at this point in time, but that doesn't necessarily
> mean they will remain so in the future.
> 
> IMHO, an API interface should represent the behavior and resources
> required for that operation, and when accessing it from outside the
> subsystem, we should use that API whenever possible. Otherwise, even
> if we want to update the internal implementation of one subsystem,
> we will have to make changes to other subsystems as well.
> 
> Peter, is it OK to drop @rq from task_on_cpu()? Then we can use
> it from rethook.
> 
> Thank you,
> 

Thank you for the detailed explanation -- that makes perfect sense.

I looked into task_on_cpu() and saw it has many callers.
Once it's confirmed that the parameter can be safely dropped, I'll
follow up with my patch to use the wrapper instead of directly
accessing on_cpu.

Best,
Tengda

>>>>
>>>> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
>>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>>> ---
>>>>  kernel/trace/rethook.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>>>> index 5a8bdf88999a..bd5e5f455e85 100644
>>>> --- a/kernel/trace/rethook.c
>>>> +++ b/kernel/trace/rethook.c
>>>> @@ -250,7 +250,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>>>  	if (WARN_ON_ONCE(!cur))
>>>>  		return 0;
>>>>  
>>>> -	if (tsk != current && task_is_running(tsk))
>>>> +	if (tsk != current && tsk->on_cpu)
>>>>  		return 0;
>>>>  
>>>>  	do {
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>>>
>>>
>>
> 
> 

