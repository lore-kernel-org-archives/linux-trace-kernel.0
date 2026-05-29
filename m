Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC85299A87;
	Fri, 29 May 2026 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780026007; cv=none; b=dYaJK43uzRID8KHLO/aTi7kVjJIfhP+dKC3eHsyfOPgMoNq4NAXIpP3kOyUXx6aEii/VZWh9YXWaq1UcCfF5Q0lHYb3BopBBMTGhUqZEx5tuVNIJw93wAZt6H2Zi7k/a2AdS0XQ1phl5ebwAnVo8/7O+K2APMcjfHICrrKnqLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780026007; c=relaxed/simple;
	bh=7S9QFropBerDCNyN9tpLvXAYOq/G2LyYyFxYTCbueT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amr6oAvMyWEGHPOrGIqZxmSBQbDHLH0HF/aAk9TRagbrpaCAvoEt728OyP5ADpCuTAq03tDZTCIjNWu85wsYDIqZ8kj5OQNlKkMLnS17AeiyZkRJK7XQm4A8F+07IKgoSvAhE4/oT+20u0b1z+PGe2MPrhLpNUfkieQjSM+Z3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gRTbw1TyPzYQtHk;
	Fri, 29 May 2026 11:38:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4F7514056B;
	Fri, 29 May 2026 11:39:51 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAXfPqFChlqQ87vDw--.13490S2;
	Fri, 29 May 2026 11:39:50 +0800 (CST)
Message-ID: <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
Date: Fri, 29 May 2026 11:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260526123719.482f07a3843e207e22d95378@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXfPqFChlqQ87vDw--.13490S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfGF15Jr1ftr4DWrWktFb_yoW8ury5pF
	Z7Ca4jkFsrArsFk3Z2qFs5urW5Cws3K3y3KFs3Aw1ftFs8Arn3KryIgr1q9F1v9rykCF4a
	vw42qa9FkrnrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Masami,

thanks for the review and feedback.

On 2026/5/26 11:37, Masami Hiramatsu wrote:
> On Mon, 25 May 2026 21:22:53 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> When a task calls schedule() to yield the CPU, its state remains
>> TASK_RUNNING, but its stack is frozen and safe to walk.
>>
>> Replace task_is_running(tsk) with tsk->on_cpu to avoid overly
>> conservative rejections.
> 
> Please see the Sashiko's comment.
> 
> https://sashiko.dev/#/patchset/20260525132253.1889726-1-wutengda%40huaweicloud.com
> 
> When calling Unwind on a task other than the current, IMHO, it is
> the responsibility of the caller of this function to ensure that the
> stack trace of that task is safe.

Agree.

> We also should not use tsk->on_cpu, but should use task_on_cpu(tsk).
> 
> BTW, should task_on_cpu() use READ_ONCE() etc?
> wait_task_inactive() seems a bit fragile.
> 
> Thanks,
> 

It seems that using task_on_cpu() is not necessary here because:

1. It requires an additional 'rq' parameter not available in the rethook context.
2. It just returns p->on_cpu, which is identical to our current use of tsk->on_cpu.

/* file: kernel/sched/sched.h */
static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
{
	return p->on_cpu;
}

Given these constraints, staying with tsk->on_cpu seems more straightforward
for the rethook context.

Thanks,
Tengda

>>
>> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  kernel/trace/rethook.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>> index 5a8bdf88999a..bd5e5f455e85 100644
>> --- a/kernel/trace/rethook.c
>> +++ b/kernel/trace/rethook.c
>> @@ -250,7 +250,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>  	if (WARN_ON_ONCE(!cur))
>>  		return 0;
>>  
>> -	if (tsk != current && task_is_running(tsk))
>> +	if (tsk != current && tsk->on_cpu)
>>  		return 0;
>>  
>>  	do {
>> -- 
>> 2.34.1
>>
>>
> 
> 

