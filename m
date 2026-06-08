Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA538E5CC;
	Mon,  8 Jun 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907480; cv=none; b=LW5Uc2nz/CHrn8ZE51/Jv/po0HTroXx/0bZempfQkMKixYnJNXtRMvbLwXvql0pPsfZFatLfCW0HmGo3O2c+9IDS9WnJfPTxXs55NYIi/Z4lneNlqCrJLUQIaD61PMhqVPD+SwU8iBBZ+eVrSS1PmADfXtJ3822AW3luBXW9fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907480; c=relaxed/simple;
	bh=v7xzP/IXbtPtwMUhNNCkJcDOWthXd/43wuw7CDcs6kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECu5Db9fAKW0z3OENzdQgIimUKyzk6Velv1Ecshe8ZRD+9JNG48VHF2gCrO0IkzLmFjha3imMIbLbo1b9szVUaOY7tAEVAYE8ojjcSVSaDOeOvFabQypwIOHstU3mQyNdN3aQGM/I1hDl8dp6FFt2jZ8NinruezXBrRGyM1fqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYlcK388ZzYQtlf;
	Mon,  8 Jun 2026 16:30:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49F4940562;
	Mon,  8 Jun 2026 16:31:12 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgA3jYHOfSZqTcozBA--.18071S2;
	Mon, 08 Jun 2026 16:31:12 +0800 (CST)
Message-ID: <02e87b57-b32c-4c12-9b8c-9a87afc0fcaa@huaweicloud.com>
Date: Mon, 8 Jun 2026 16:31:10 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
 <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
 <20260608115646.97d80d30aed182d468496449@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260608115646.97d80d30aed182d468496449@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3jYHOfSZqTcozBA--.18071S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw48JFW3JFy8Zr4xGw4rZrb_yoW5tw1Upr
	W3K3W5KF4kJF1xtrnFvrs5Jr4YyrZ3Jry7WwnrJryIyFn09ryxtrs7Kw4Y9a4DurZ8Cw42
	vrWjqrZrZrWIyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/8 10:56, Masami Hiramatsu wrote:
> On Mon, 8 Jun 2026 09:52:37 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>>
>>
>> On 2026/6/5 21:43, Masami Hiramatsu wrote:
>>> On Thu, 4 Jun 2026 11:34:45 +0200
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>> On Mon, Jun 01, 2026 at 08:40:01AM +0900, Masami Hiramatsu wrote:
>>>>
>>>>> Peter, is it OK to drop @rq from task_on_cpu()? 
>>>>
>>>> Sure.
>>>>
>>>>> Then we can use it from rethook.
>>>>
>>>> Well, it is in sched/sched.h, which is an internal header, and no you
>>>> cannot use that header in rethook.
>>>
>>> Ah, OK. Hmm, then we should not use it. Maybe ->on_cpu is also internal
>>> state?
>>>
>>>>
>>>> But lets step back first, what is the actual problem here, why are we
>>>> looking at ->on_cpu at all?
>>>
>>> Tengda, can you explain it?
>>> I think you want to take a stacktrace on !current process, and
>>> rethook_find_ret_addr() is rejected i the task is running state.
>>>
>>> But if you can share actual situation what you need, it is
>>> helpful for us to understand.
>>>
>>> Thank you,
>>>
>>>
>>
>>
>> Sure.
>>
>> Background: We are verifying the support of live patches for functions that
>> have a kretprobe. The specific verification method is as follows:
>>
>> We construct a function foo() that calls bar():
>>
>> void bar(void)
>> {
>>     for (;;) {
>>         schedule();
>>     }
>> }
>>
>> void foo(void)
>> {
>>     bar();
>> }
>>
>> A kretprobe is attached to bar():
>>
>> echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
>> echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable
>>
>> Then foo() is triggered. The expected behavior is that bar() will call
>> schedule() and yield the CPU.
>>
>> After that, the live patch is activated to attempt replacing the implementation
>> of foo(). The expectation is that this should succeed.
>>
>> However, in reality, because the task that called schedule() is still in the
>> RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
>> is not satisfied, causing the function to return early. This, in turn,
>> prevents stack_trace_save_tsk_reliable() from determining the stack as
>> reliable, leading to a failure in activating the live patch.
> 
> Hmm is the bar() doing infinite loop, or limited loop but take a long time
> so just yield a while? Anyway, it seems like a non-good design pattern.
> Is it possible to avoid busy loops and instead use Workers, or wait for
> something to complete or for input within a loop?
> 
>>
>> **Not sure if this is correct:**
>>
>> We believe that after a task voluntarily calls schedule(), when the stack
>> is expected to be reliable, it is a safe time to activate a live patch.
> 
> In this case, I don't know how to block the loop inside the bar.
> Even if !tsk->on_cpu, the tsk can restart running right after checking
> the flag.
> 

The infinite loop in bar() is indeed a poor design pattern. This test
case is only artificial, not from real-world code. It is merely
intended to verify live patch support for various cases.

However, the point you raised has indeed made me think. I realize that
checking only tsk->on_cpu is not sufficient -- there is also a race
condition where the task could be scheduled back onto a CPU right after
the check. I need to re-examine the validity of this test case and
whether it represents a safe live patch activation scenario.

Thank you again for your patience and for pointing out these
fundamental issues. Your guidance is much appreciated.

Best regards,
Tengda

